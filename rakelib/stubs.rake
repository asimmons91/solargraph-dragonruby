# frozen_string_literal: true

require "fileutils"
require "tmpdir"

UPSTREAM_REPO = "https://github.com/owenbutler/dragonruby-yard-doc.git"
UPSTREAM_DIR = File.expand_path("../stubs/upstream", __dir__)
EXTENSIONS_DIR = File.expand_path("../stubs/extensions", __dir__)

module StubSync
  module_function

  # @param dir [String]
  # @return [Array<Solargraph::Pin::Method>]
  def method_pins(dir)
    require "solargraph"
    Dir[File.join(dir, "*.rb")].sort
      .flat_map { |path| Solargraph::SourceMap.load(path).all_pins }
      .grep(Solargraph::Pin::Method)
  end

  # The doc comment and signature source of each upstream method that an
  # extension re-declares, keyed by path. Extensions win over upstream (see
  # `Solargraph::Dragonruby::Convention.pins`), so a change to one of these
  # never shows up in completions.
  #
  # @param overridden [Set<String>]
  # @return [Hash{String => String}]
  def overridden_upstream(overridden)
    lines = Hash.new { |cache, file| cache[file] = File.readlines(file) }
    method_pins(UPSTREAM_DIR)
      .select { |pin| overridden.include?(pin.path) }
      .group_by(&:path)
      .transform_values do |pins|
        pins.map do |pin|
          range = pin.location.range
          signature = lines[pin.location.filename][range.start.line..range.ending.line].join
          "#{pin.comments}\n#{signature}"
        end.join("\n")
      end
  end

  # @param before [Hash{String => String}]
  # @param after [Hash{String => String}]
  def report_overrides(before, after)
    groups = {
      "Changed upstream; check whether the extension override is still needed" =>
        (before.keys & after.keys).reject { |path| before[path] == after[path] },
      "New upstream; now shadowed by an extension" => after.keys - before.keys,
      "Removed upstream; the extension is now the only definition" => before.keys - after.keys
    }.reject { |_, paths| paths.empty? }

    if groups.empty?
      puts "No upstream changes to methods overridden in stubs/extensions"
      return
    end
    groups.each do |heading, paths|
      puts "#{heading}:"
      paths.sort.each { |path| puts "  #{path}" }
    end
  end
end

namespace :stubs do
  desc "Vendor the DragonRuby YARD stubs from #{UPSTREAM_REPO} (default ref: main)"
  task :sync, [:ref] do |_task, args|
    ref = args[:ref] || "main"
    overridden = StubSync.method_pins(EXTENSIONS_DIR).to_set(&:path)
    before = StubSync.overridden_upstream(overridden)

    Dir.mktmpdir("dragonruby-yard-doc") do |tmp|
      sh "git", "clone", "--quiet", "--depth", "1", "--branch", ref, UPSTREAM_REPO, tmp
      sha = `git -C #{tmp} rev-parse HEAD`.strip

      FileUtils.rm_rf(UPSTREAM_DIR)
      FileUtils.mkdir_p(UPSTREAM_DIR)
      FileUtils.cp(Dir[File.join(tmp, "*.rb")], UPSTREAM_DIR)
      FileUtils.cp(File.join(tmp, "LICENSE.txt"), UPSTREAM_DIR)
      File.write(File.join(UPSTREAM_DIR, "UPSTREAM"), "#{UPSTREAM_REPO.delete_suffix(".git")}\n#{sha}\n")

      puts "Vendored #{UPSTREAM_REPO} @ #{sha}"
    end

    # Unlike `git diff`, status also lists files upstream added.
    sh "git", "status", "--short", "--untracked-files=all", "--", UPSTREAM_DIR
    StubSync.report_overrides(before, StubSync.overridden_upstream(overridden))
  end
end

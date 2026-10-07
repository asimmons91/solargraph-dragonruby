# frozen_string_literal: true

require "fileutils"
require "tmpdir"

UPSTREAM_REPO = "https://github.com/owenbutler/dragonruby-yard-doc.git"
UPSTREAM_DIR = File.expand_path("../stubs/upstream", __dir__)

namespace :stubs do
  desc "Vendor the DragonRuby YARD stubs from #{UPSTREAM_REPO} (default ref: main)"
  task :sync, [:ref] do |_task, args|
    ref = args[:ref] || "main"

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

    sh "git", "diff", "--stat", "--", UPSTREAM_DIR
  end
end

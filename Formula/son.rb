class Son < Formula
  desc "One memory for every AI agent: one binary, one SQLite file"
  homepage "https://son-of-w.com"
  version "1.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/son-of-w/son/releases/download/v1.1.0/son-v1.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "f212707539d845480f53ba05191bd078e8d92f6076d00e0d88b544fd8608692b"
    end
    on_intel do
      url "https://github.com/son-of-w/son/releases/download/v1.1.0/son-v1.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "1a5f26671fdab65d459d11b66f8bcf5bbce2627e8d45220f265558fc193067b8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/son-of-w/son/releases/download/v1.1.0/son-v1.1.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "76e8e201930329a2aec23621a20c02d76345fbdfaf4153d2295d26afb107d799"
    end
    on_intel do
      url "https://github.com/son-of-w/son/releases/download/v1.1.0/son-v1.1.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "7ee9a48e89f3cff7e1d29c355d4efb24d08f3b347bb06b2cf6086b6e6888992c"
    end
  end

  def install
    bin.install "son"
    generate_completions_from_executable(bin/"son", "completions")
  end

  def caveats
    <<~EOS
      Run `son init` to set son up for your AI agents.
      After an upgrade, run `son init` again: it upgrades the database
      and brings the agent files up to date.
      Installing or removing son with brew does not change any agent's
      files and does not touch your memory (~/.son-of-w). To take son out
      of your agents' files, run `son uninstall` before `brew uninstall son`.
    EOS
  end

  test do
    assert_match "son #{version}", shell_output("#{bin}/son --version")
    ENV["SON_DB"] = testpath/"son.db"
    system bin/"son", "remember", "note", "brew test"
    assert_match "brew test", shell_output("#{bin}/son recall brew")
  end
end

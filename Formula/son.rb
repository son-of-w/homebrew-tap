class Son < Formula
  desc "One memory for every AI agent: one binary, one SQLite file"
  homepage "https://son-of-w.com"
  version "0.1.16"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/son-of-w/son/releases/download/v0.1.16/son-v0.1.16-aarch64-apple-darwin.tar.gz"
      sha256 "37e55888ac919210d04f7f81df987e59dbb9c5b143f448aeae386de349b4629b"
    end
    on_intel do
      url "https://github.com/son-of-w/son/releases/download/v0.1.16/son-v0.1.16-x86_64-apple-darwin.tar.gz"
      sha256 "02d22e89f49254cc935751722dd2759a8b80b93eedfbb17ba10aaa9c26c848b4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/son-of-w/son/releases/download/v0.1.16/son-v0.1.16-aarch64-unknown-linux-musl.tar.gz"
      sha256 "367ef858f5ed5221183f7f909e52bb561082070d11de4dc2ead9aa66f60a554e"
    end
    on_intel do
      url "https://github.com/son-of-w/son/releases/download/v0.1.16/son-v0.1.16-x86_64-unknown-linux-musl.tar.gz"
      sha256 "b2a90cd97f3f0887429df8c1a7626664c467534072cd66fda1283c8551891a88"
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

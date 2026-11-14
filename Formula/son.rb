class Son < Formula
  desc "One memory for every AI agent: one binary, one SQLite file"
  homepage "https://son-of-w.com"
  version "1.0.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/son-of-w/son/releases/download/v1.0.0/son-v1.0.0-aarch64-apple-darwin.tar.gz"
      sha256 "a147cecc40db1676d0026385d11d04605401e907c8d85ea5633d20a45bddcde1"
    end
    on_intel do
      url "https://github.com/son-of-w/son/releases/download/v1.0.0/son-v1.0.0-x86_64-apple-darwin.tar.gz"
      sha256 "f4b6f6a92e60835315afe342620936a1177df9ad759c3f4eb9ee98b72a580d9e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/son-of-w/son/releases/download/v1.0.0/son-v1.0.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "a4ca0f3ca9c75886298a46dae767aacd66559db14572a27243168f195449f44e"
    end
    on_intel do
      url "https://github.com/son-of-w/son/releases/download/v1.0.0/son-v1.0.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "34a09ee5466ab5b9a089012348dbf9dab121499e274bd1f6c4910e87f1fbbcb4"
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

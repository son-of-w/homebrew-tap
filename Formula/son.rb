class Son < Formula
  desc "One memory for every AI agent: one binary, one SQLite file"
  homepage "https://son-of-w.com"
  version "1.1.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/son-of-w/son/releases/download/v1.1.1/son-v1.1.1-aarch64-apple-darwin.tar.gz"
      sha256 "1c4e39ef7ba9f588759473c7989e18d024fd9acdbf937181b934ff2df8c3b0b2"
    end
    on_intel do
      url "https://github.com/son-of-w/son/releases/download/v1.1.1/son-v1.1.1-x86_64-apple-darwin.tar.gz"
      sha256 "62bf01611d00a1622f4eb3d984e9b0553f6b8a4a04118a70d9bb514bd0cfbcda"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/son-of-w/son/releases/download/v1.1.1/son-v1.1.1-aarch64-unknown-linux-musl.tar.gz"
      sha256 "aff381b32b006d854148615f62cd0ace6bfb8c1441a384582a41b3d8332b3dae"
    end
    on_intel do
      url "https://github.com/son-of-w/son/releases/download/v1.1.1/son-v1.1.1-x86_64-unknown-linux-musl.tar.gz"
      sha256 "6f1ed81824bd52dceff7e3820b6e380ef7913860b0418268185e1abae48b2426"
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

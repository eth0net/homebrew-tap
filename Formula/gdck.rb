class Gdck < Formula
  desc "A fast GDScript formatter and linter"
  homepage "https://github.com/eth0net/gdck"
  version "0.7.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/eth0net/gdck/releases/download/v0.7.0/gdck-aarch64-apple-darwin.tar.xz"
      sha256 "da17023db493acc58d3b951742b876e86c76a37dd49e53a2fb2e17cc1974d593"
    end
    if Hardware::CPU.intel?
      url "https://github.com/eth0net/gdck/releases/download/v0.7.0/gdck-x86_64-apple-darwin.tar.xz"
      sha256 "a032a494efe1f61c5fedf22ccc95d59c9b6fe4cda84e7217b34b4736f93a962f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/eth0net/gdck/releases/download/v0.7.0/gdck-aarch64-unknown-linux-musl.tar.xz"
      sha256 "c782ba1d6f91ca18bc896f1b34cf79af0c0e69f9d691bcd3b118dd217f997439"
    end
    if Hardware::CPU.intel?
      url "https://github.com/eth0net/gdck/releases/download/v0.7.0/gdck-x86_64-unknown-linux-musl.tar.xz"
      sha256 "49b27eb4cbf3b6bacd35e0ffaaf8327477141f37c62d61d51379af2b7f7f54d1"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
    "x86_64-apple-darwin":                {},
    "x86_64-pc-windows-gnu":              {},
    "x86_64-unknown-linux-gnu":           {},
    "x86_64-unknown-linux-musl-dynamic":  {},
    "x86_64-unknown-linux-musl-static":   {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "gdck"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "gdck"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "gdck"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "gdck"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end

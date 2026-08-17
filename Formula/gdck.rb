class Gdck < Formula
  desc "A fast GDScript formatter and linter"
  homepage "https://github.com/eth0net/gdck"
  version "0.6.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/eth0net/gdck/releases/download/v0.6.0/gdck-aarch64-apple-darwin.tar.xz"
      sha256 "983f6aebed431ba902934cc198b0cf0d0e2afd1955ab61078eab452445faeed7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/eth0net/gdck/releases/download/v0.6.0/gdck-x86_64-apple-darwin.tar.xz"
      sha256 "af64921aaaa62c8ef4b611dbee2af68db3d4ab119170ac4f9769d67acad58218"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/eth0net/gdck/releases/download/v0.6.0/gdck-aarch64-unknown-linux-musl.tar.xz"
      sha256 "8d971d431035e94a2d008c3a5cd0249f51c6f5856b222832b14d6cf846bd6e61"
    end
    if Hardware::CPU.intel?
      url "https://github.com/eth0net/gdck/releases/download/v0.6.0/gdck-x86_64-unknown-linux-musl.tar.xz"
      sha256 "f4c4ee06c092be3ad43d8ab5609e2aea5c8589f43a32891fafa1d5f7e06cb512"
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

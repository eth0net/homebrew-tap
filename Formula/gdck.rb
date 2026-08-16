class Gdck < Formula
  desc "A fast GDScript formatter and linter"
  homepage "https://github.com/eth0net/gdck"
  version "0.5.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/eth0net/gdck/releases/download/v0.5.1/gdck-aarch64-apple-darwin.tar.xz"
      sha256 "d6a44d259e99159e69f55489f7cf2821eb768e760f80bb3671d05f2d9a6d23cb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/eth0net/gdck/releases/download/v0.5.1/gdck-x86_64-apple-darwin.tar.xz"
      sha256 "2d5f240c76f2916dc690647825c1427ddde4cd106986588ff6e866320026f195"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/eth0net/gdck/releases/download/v0.5.1/gdck-aarch64-unknown-linux-musl.tar.xz"
      sha256 "fce6261d705868109b5da981d2ef5af0f753a981a165e38f5f087721d66ea845"
    end
    if Hardware::CPU.intel?
      url "https://github.com/eth0net/gdck/releases/download/v0.5.1/gdck-x86_64-unknown-linux-musl.tar.xz"
      sha256 "ac046b6b87604a21b72205e18a0e9abe994241fc3c4dfd2ea666b006276fca8d"
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

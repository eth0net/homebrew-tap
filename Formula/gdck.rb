class Gdck < Formula
  desc "A fast GDScript formatter and linter"
  homepage "https://github.com/eth0net/gdck"
  version "0.5.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/eth0net/gdck/releases/download/v0.5.2/gdck-aarch64-apple-darwin.tar.xz"
      sha256 "c988aea93d9a78f13257f6dc11334b13e610f26aa0e8f527854dc7b99ab3856e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/eth0net/gdck/releases/download/v0.5.2/gdck-x86_64-apple-darwin.tar.xz"
      sha256 "51eecf7df841052a7bf0172f6d433cce70f2c1489fa6791c8b42bd6e7f261adc"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/eth0net/gdck/releases/download/v0.5.2/gdck-aarch64-unknown-linux-musl.tar.xz"
      sha256 "a290d4a2450b1e40add208a1321c61b3a99be1190c16f65a4751414c431b5f1d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/eth0net/gdck/releases/download/v0.5.2/gdck-x86_64-unknown-linux-musl.tar.xz"
      sha256 "aa164958c3cee51d298fbfc7ec0ce9fc95982494ec62b59c10b803fcc003412f"
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

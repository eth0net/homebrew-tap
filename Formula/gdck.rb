class Gdck < Formula
  desc "A fast GDScript formatter and linter"
  homepage "https://github.com/eth0net/gdck"
  version "0.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/eth0net/gdck/releases/download/v0.5.0/gdck-aarch64-apple-darwin.tar.xz"
      sha256 "a5c77320e17d4441138f6622ec6059e93dd3d910102988b9f622f44bc01e32dc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/eth0net/gdck/releases/download/v0.5.0/gdck-x86_64-apple-darwin.tar.xz"
      sha256 "be213260dc7cc824d35f809a86675637887239e6261d22a2431af96c2bdc022f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/eth0net/gdck/releases/download/v0.5.0/gdck-aarch64-unknown-linux-musl.tar.xz"
      sha256 "0db49ef2a621257e66533cf48d119e4184997013f6231cab62bd13ce6631856a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/eth0net/gdck/releases/download/v0.5.0/gdck-x86_64-unknown-linux-musl.tar.xz"
      sha256 "41e50180a1b545495e5f00f9229cb5aaeff3d7f07013f65be67961c02d31cf1a"
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

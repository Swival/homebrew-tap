class Swival < Formula
  desc "Small, powerful CLI coding agent for open AI models"
  homepage "https://swival.dev/"
  url "https://github.com/Swival/swival/archive/refs/tags/1.9.2.tar.gz"
  sha256 "6dbb87c761a055481f9a6146287f62213bef5ba78f4e06f8be4388f9c636e68f"
  license "MIT"

  depends_on "go" => :build
  depends_on "rust" => :build
  depends_on "uv" => :build
  depends_on "python@3.14"

  preserve_rpath

  def install
    python = Formula["python@3.14"].opt_bin/"python3.14"
    system "uv", "venv", "--python", python.to_s, libexec.to_s
    system "uv", "pip", "install", "--python", (libexec/"bin/python").to_s, buildpath.to_s
    (bin/"swival").write_env_script libexec/"bin/swival", PATH: "#{libexec}/bin:${PATH}"
  end

  test do
    assert_match "swival", shell_output("#{bin}/swival --help")
  end
end

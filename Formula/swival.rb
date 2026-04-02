class Swival < Formula
  desc "Small, powerful CLI coding agent for open AI models"
  homepage "https://swival.dev/"
  url "https://github.com/Swival/swival/archive/refs/tags/0.10.8.tar.gz"
  sha256 "875525966f5f3e0ee328701737652302e4ce057b988fe4e39b96f6dbcd32a87a"
  license "MIT"

  depends_on "python@3.14"
  depends_on "uv"

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

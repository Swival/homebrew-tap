class Swival < Formula
  desc "Small, powerful CLI coding agent for open AI models"
  homepage "https://swival.dev/"
  url "https://github.com/Swival/swival/archive/refs/tags/0.10.4.tar.gz"
  sha256 "6016ee0c5177b30437c719b126f52a93f7fc0e3c3f846973cfee8f93a08574f2"
  license "MIT"

  depends_on "python@3.13"
  depends_on "uv"

  preserve_rpath

  def install
    python = Formula["python@3.13"].opt_bin/"python3.13"
    system "uv", "venv", "--python", python.to_s, libexec.to_s
    system "uv", "pip", "install", "--python", (libexec/"bin/python").to_s, buildpath.to_s
    (bin/"swival").write_env_script libexec/"bin/swival", PATH: "#{libexec}/bin:${PATH}"
  end

  test do
    assert_match "swival", shell_output("#{bin}/swival --help")
  end
end

class Swival < Formula
  desc "Small, powerful CLI coding agent for open AI models"
  homepage "https://swival.dev/"
  url "https://github.com/Swival/swival/archive/refs/tags/1.0.24.tar.gz"
  sha256 "a4e435af900a04c9dfe2e34a592b1505dd677a724a98af2adbe8b264013491ec"
  license "MIT"

  depends_on "python@3.14"
  depends_on "uv"
  depends_on "go" => :build
  depends_on "rust" => :build

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

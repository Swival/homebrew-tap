class Swival < Formula
  desc "Small, powerful CLI coding agent for open AI models"
  homepage "https://swival.dev/"
  url "https://github.com/Swival/swival/archive/refs/tags/1.0.15.tar.gz"
  sha256 "3e8dfa32d0e360c0f46220c8e2c5b8f1ef98f32368e6c90ea41e8491c04193a4"
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

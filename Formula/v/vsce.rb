class Vsce < Formula
  desc "Tool for packaging, publishing and managing VS Code extensions"
  homepage "https://code.visualstudio.com/api/working-with-extensions/publishing-extension#vsce"
  url "https://registry.npmjs.org/@vscode/vsce/-/vsce-3.3.0.tgz"
  sha256 "62872641b49fc7ee306a0cf482a5815230d7f61f333fde2d2c1e5bc5acde8295"
  license "MIT"
  head "https://github.com/microsoft/vscode-vsce.git", branch: "main"

  livecheck do
    url "https://registry.npmjs.org/@vscode/vsce/latest"
    regex(/["']version["']:\s*?["']([^"']+)["']/i)
  end

  bottle do
    sha256                               arm64_sequoia: "24261af6cc16b71e40e70a36bffd6ebe67fd8d720cd8cb02a95c60698bddf4e9"
    sha256                               arm64_sonoma:  "edd2a12bf1dc9000b6fb9c743c1babfa0c8b2d8befbfb08fae6d870560384f96"
    sha256                               arm64_ventura: "682eef5425c284bc6eb2a6d74b138a3713f83180c754ec9a9a2eae77a35b33f2"
    sha256                               sonoma:        "64d98d7c886d1418cb68f88a337661c0b5812fb627e46593b9caf5380c77688a"
    sha256                               ventura:       "4eb0b82505cb75f1100b484568613e4eae745517ce78e47d395b642504a0eab6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c72f49e1af7962731fcb0a8e3c7ee950d89cb4d886df290b561e4059bda06633"
  end

  depends_on "node"

  uses_from_macos "zlib"

  on_linux do
    depends_on "pkgconf" => :build
    depends_on "glib"
    depends_on "libsecret"
  end

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir[libexec/"bin/*"]
  end

  test do
    error = shell_output(bin/"vsce verify-pat 2>&1", 1)
    assert_match "Extension manifest not found:", error
  end
end

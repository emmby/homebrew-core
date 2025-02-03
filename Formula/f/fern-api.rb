class FernApi < Formula
  desc "Stripe-level SDKs and Docs for your API"
  homepage "https://buildwithfern.com/"
  url "https://registry.npmjs.org/fern-api/-/fern-api-0.51.20.tgz"
  sha256 "56b3f5b41b8a2b5fd4dcb3a4008beb910d06db7f2d049f0a9240276e01c6284d"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, all: "c757df29b6df0329a875319401a9d3bce11a57f929a9a20e2450f3e63796a6bf"
  end

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    system bin/"fern", "init", "--docs", "--org", "brewtest"
    assert_path_exists testpath/"fern/docs.yml"
    assert_match "\"organization\": \"brewtest\"", (testpath/"fern/fern.config.json").read

    system bin/"fern", "--version"
  end
end

#!/usr/bin/env ruby

require "digest"
require "fileutils"
require "json"
require "open3"
require "tmpdir"

def command(*args)
  stdout, stderr, status = Open3.capture3(*args)
  abort "#{args.join(" ")} failed: #{stderr.strip}" unless status.success?
  stdout
end

def github_json(endpoint)
  JSON.parse(command("gh", "api", endpoint))
end

def download_sha(url, directory, name)
  path = File.join(directory, name)
  command("curl", "--fail", "--location", "--silent", "--show-error", url, "--output", path)
  Digest::SHA256.file(path).hexdigest
end

def version_from_tag(tag)
  version = tag.delete_prefix("v")
  abort "unsupported upstream tag: #{tag}" unless version.match?(/\A\d+\.\d+\.\d+(?:[-+.]\w[\w.-]*)?\z/)
  version
end

Dir.mktmpdir("homebrew-tap-update") do |directory|
  proxytop_release = github_json("repos/cliecy/proxytop/releases/latest")
  proxytop_tag = proxytop_release.fetch("tag_name")
  proxytop_version = version_from_tag(proxytop_tag)
  assets = proxytop_release.fetch("assets").to_h { |asset| [asset.fetch("name"), asset.fetch("browser_download_url")] }

  arm_name = "proxytop-#{proxytop_version}-darwin-arm64"
  intel_name = "proxytop-#{proxytop_version}-darwin-x86_64"
  abort "missing #{arm_name} in latest proxytop release" unless assets.key?(arm_name)
  abort "missing #{intel_name} in latest proxytop release" unless assets.key?(intel_name)

  arm_sha = download_sha(assets.fetch(arm_name), directory, arm_name)
  intel_sha = download_sha(assets.fetch(intel_name), directory, intel_name)

  cc_tags = github_json("repos/cliecy/cc-switch-ui/tags?per_page=100")
  cc_tag = cc_tags.filter_map { |entry| entry["name"] }.find { |tag| tag.match?(/\Av\d+\.\d+\.\d+/) }
  abort "no semantic cc-switch-ui tag found" unless cc_tag
  cc_version = version_from_tag(cc_tag)
  cc_url = "https://github.com/cliecy/cc-switch-ui/archive/refs/tags/#{cc_tag}.tar.gz"
  cc_sha = download_sha(cc_url, directory, "cc-switch-ui-#{cc_version}.tar.gz")

  File.write("Formula/proxytop.rb", <<~RUBY)
    class Proxytop < Formula
      desc "macOS proxy, VPN, tunnel, and process traffic inspector"
      homepage "https://github.com/cliecy/proxytop"
      version "#{proxytop_version}"
      license "MIT"

      if Hardware::CPU.arm?
        url "#{assets.fetch(arm_name)}"
        sha256 "#{arm_sha}"
      else
        url "#{assets.fetch(intel_name)}"
        sha256 "#{intel_sha}"
      end

      def install
        artifact = Dir["proxytop-\#{version}-darwin-*"]
        odie "release asset was not found" if artifact.empty?
        bin.install artifact.first => "proxytop"
      end

      test do
        assert_match "proxytop", shell_output("\#{bin}/proxytop --help")
      end
    end
  RUBY

  File.write("Formula/cc-switch-ui.rb", <<~RUBY)
    class CcSwitchUi < Formula
      include Language::Python::Virtualenv

      desc "Local Web UI for managing Claude Code and Codex CLI connections"
      homepage "https://github.com/cliecy/cc-switch-ui"
      url "#{cc_url}"
      version "#{cc_version}"
      sha256 "#{cc_sha}"
      license "MIT"

      depends_on "python@3.12"

      resource "blinker" do
        url "https://files.pythonhosted.org/packages/21/28/9b3f50ce0e048515135495f198351908d99540d69bfdc8c1d15b73dc55ce/blinker-1.9.0.tar.gz"
        sha256 "b4ce2265a7abece45e7cc896e98dbebe6cead56bcf805a3d23136d145f5445bf"
      end

      resource "click" do
        url "https://files.pythonhosted.org/packages/9b/98/518d8e5081007684232226f475082b30087d0f585e8457db087298259f49/click-8.4.1.tar.gz"
        sha256 "918b5633eddf6b41c32d4f454bf0de810065c74e3f7dbf8ee5452f8be88d3e96"
      end

      resource "flask" do
        url "https://files.pythonhosted.org/packages/26/00/35d85dcce6c57fdc871f3867d465d780f302a175ea360f62533f12b27e2b/flask-3.1.3.tar.gz"
        sha256 "0ef0e52b8a9cd932855379197dd8f94047b359ca0a78695144304cb45f87c9eb"
      end

      resource "itsdangerous" do
        url "https://files.pythonhosted.org/packages/9c/cb/8ac0172223afbccb63986cc25049b154ecfb5e85932587206f42317be31d/itsdangerous-2.2.0.tar.gz"
        sha256 "e0050c0b7da1eea53ffaf149c0cfbb5c6e2e2b69c4bef22c81fa6eb73e5f6173"
      end

      resource "jinja2" do
        url "https://files.pythonhosted.org/packages/df/bf/f7da0350254c0ed7c72f3e33cef02e048281fec7ecec5f032d4aac52226b/jinja2-3.1.6.tar.gz"
        sha256 "0137fb05990d35f1275a587e9aee6d56da821fc83491a0fb838183be43f66d6d"
      end

      resource "markupsafe" do
        url "https://files.pythonhosted.org/packages/7e/99/7690b6d4034fffd95959cbe0c02de8deb3098cc577c67bb6a24fe5d7caa7/markupsafe-3.0.3.tar.gz"
        sha256 "722695808f4b6457b320fdc131280796bdceb04ab50fe1795cd540799ebe1698"
      end

      resource "werkzeug" do
        url "https://files.pythonhosted.org/packages/dd/b2/381be8cfdee792dd117872481b6e378f85c957dd7c5bca38897b08f765fd/werkzeug-3.1.8.tar.gz"
        sha256 "9bad61a4268dac112f1c5cd4630a56ede601b6ed420300677a869083d70a4c44"
      end

      def install
        virtualenv_install_with_resources
      end

      test do
        assert_match "usage", shell_output("\#{bin}/cc-switch-ui --help")
      end
    end
  RUBY

  puts "Updated proxytop #{proxytop_version} and cc-switch-ui #{cc_version}."
end

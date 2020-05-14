class Groovysdk25 < Formula
  desc "SDK for Groovy: a Java-based scripting language"
  homepage "https://www.groovy-lang.org/"
  url "https://dl.bintray.com/groovy/maven/apache-groovy-sdk-2.5.11.zip"
  sha256 "f8f566becc788efcd954d86296ef8ce522ebdd281cbd9167ad51e1ea44846d3d"

  bottle :unneeded

  # depends_on "openjdk"

  conflicts_with "groovy25", :because => "both install the same binaries"

  def install
    # We don't need Windows' files.
    rm_f Dir["bin/*.bat"]

    prefix.install_metafiles
    bin.install Dir["bin/*"]
    libexec.install "conf", "lib", "src", "doc"
    bin.env_script_all_files libexec/"bin",
                             :GROOVY_HOME => libexec,
                             :JAVA_HOME   => "${JAVA_HOME:-#{Formula["openjdk"].opt_prefix}}"
  end

  test do
    system "#{bin}/grape", "install", "org.activiti", "activiti-engine", "5.16.4"
  end
end

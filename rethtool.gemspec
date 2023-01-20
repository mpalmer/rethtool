Gem::Specification.new do |s|
	s.name = "rethtool"
	s.version = File.read(File.expand_path('../VERSION', __FILE__)).strip

	s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
	s.authors = ["Matt Palmer"]
	s.date = "2014-01-16"
	s.email = "theshed+rethtool@hezmatt.org"
	s.extra_rdoc_files = [
	  "COPYING",
	  "README.rdoc"
	]
	s.files = `git ls-files`.split("\n")
	s.homepage = "https://github.com/mpalmer/rethtool"
	s.licenses = ["GPLv3"]
	s.require_paths = ["lib"]
	s.summary = "Partial Ruby wrapper around the SIOCETHTOOL ioctl"

	s.add_runtime_dependency(%q<cstruct>, [">= 0"])
	s.add_development_dependency(%q<rake>, ["~> 10.0"])
	s.add_development_dependency(%q<bundler>, ["~> 1.0"])
	s.add_development_dependency(%q<rdoc>, ["~> 2.4"])
end


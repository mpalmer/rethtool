# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "rethtool"
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Matt Palmer"]
  s.date = "2011-12-17"
  s.email = "mpalmer@hezmatt.org"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    "COPYING",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "lib/rethtool.rb",
    "lib/rethtool/ethtool_cmd.rb",
    "lib/rethtool/ethtool_value.rb",
    "lib/rethtool/interface_settings.rb",
    "lib/rethtool/link_status.rb",
    "test/helper.rb",
    "test/test_rethtool.rb"
  ]
  s.homepage = "http://theshed.hezmatt.org/rethtool"
  s.licenses = ["GPLv3"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.10"
  s.summary = "Partial Ruby wrapper around the SIOCETHTOOL ioctl"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<cstruct>, [">= 0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.6.0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_development_dependency(%q<rdoc>, ["~> 2.4.2"])
    else
      s.add_dependency(%q<cstruct>, [">= 0"])
      s.add_dependency(%q<jeweler>, ["~> 1.6.0"])
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_dependency(%q<rdoc>, ["~> 2.4.2"])
    end
  else
    s.add_dependency(%q<cstruct>, [">= 0"])
    s.add_dependency(%q<jeweler>, ["~> 1.6.0"])
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    s.add_dependency(%q<rdoc>, ["~> 2.4.2"])
  end
end


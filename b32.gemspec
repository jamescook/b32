require_relative "./lib/b32/version"

Gem::Specification.new do |s|
  s.name    = "b32"
  s.version = B32::VERSION
  s.summary = "Base32 Ruby C Extension"
  s.author  = "James Cook"
  s.platform = Gem::Platform::RUBY
  s.homepage = "https://github.com/jamescook/b32"

  s.files = Dir.glob("ext/**/*.{c,h,rb}") +
            Dir.glob("lib/**/*.{rb}")

  s.extensions << "ext/b32/extconf.rb"
  s.licenses << "MIT"

  s.add_development_dependency "rake-compiler", "~> 1"
  s.add_development_dependency "minitest", "~> 5"
  s.required_ruby_version = '> 2.1'
end

Gem::Specification.new do |s|
  s.name     = "rad_cloth"
  s.version  = "0.1"
  s.date     = "2008-09-20"
  s.summary  = "Add convenience methods to textiled attributes"
  s.email    = "jordan@mckible.com"
  s.homepage = "http://github.com/jmckible/rad_cloth"
  s.description = "rad_cloth is a Ruby library for wrapping textile conversion methods using RedCloth."
  s.has_rdoc = false
  s.authors  = ["Jordan McKible", "Chris Wanstrath"]
  s.files    = [
    "init.rb", 
		"MIT-LICENSE", 
		"rad_cloth.gem_spec", 
		"README.rdoc", 
		"lib/textile.rb"
	]
  s.add_dependency("RedCloth", ["> 0.0.0"])
end

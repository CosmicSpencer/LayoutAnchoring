Pod::Spec.new do |s|
  s.name          = "LayoutAnchoring"
  s.version       = "0.0.2"
  s.summary       = "Layout Anchoring is a little framework aimed at facilitating programmatic auto layout."
  s.description   = <<-DESC
Setting up constraints on views can be a pain. The goal of this framework is to make it as simple as possible without sacrificing flexibility.
                   DESC

  s.homepage      = "https://github.com/CosmicSpencer/LayoutAnchoring"
  s.license       = "MIT"
  s.author        = { "Spencer" => "spencer.hall.31@gmail.com" }
  s.source        = { :git => "https://github.com/CosmicSpencer/LayoutAnchoring.git", :tag => "#{s.version}" }
  s.source_files  = "LayoutAnchoring/*.{h,swift}"
  s.swift_version = "5.0"
  s.ios.deployment_target = "10.3"

end

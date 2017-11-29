Pod::Spec.new do |s|
s.name = "AZPromptView"
s.version = "1.0.0"
s.ios.deployment_target = '8.0'
s.summary = "一个iOS提示框, pod 'AZPromptView/oc' | pod 'AZPromptView/swift'
s.homepage = "https://github.com/CoderAzreal/AZPromptView"
s.license = { :type => "MIT", :file => "LICENSE" }
s.author = { "AZReal" => "tianfengyu@foxmail.com" }
s.source = { :git => "https://github.com/CoderAzreal/AZPromptView.git", :tag = s.version }
s.requires_arc = true
s.subspec 'swift' do |t|
	t.source_files = "AZPromptView/AZPromptView/*.swift"
end
s.subspec 'oc' do |o|
	o.source_files = "AZPromptView/AZPromptView/*.{h,m}"
end
end



Pod::Spec.new do |spec|
spec.name = "HeadStart"
spec.version = "0.0.47"
spec.summary = "Framework for users who would like to head start their project with high level structure."
spec.homepage = "https://github.com/ashfuack/HeadStart"
spec.license = { type: 'MIT', file: 'LICENSE' }
spec.authors = { "Ashfauck Thaminsali" => 'ashfauck@gmail.com' }
spec.social_media_url = "https://github.com/ashfauck/HeadStart"

spec.platform = :ios, "11.0"
spec.requires_arc = true
spec.swift_version = "5.0"
spec.source = { git: "https://github.com/ashfauck/HeadStart.git", tag: "#{spec.version}", submodules: false }
spec.dependency "NVActivityIndicatorView"
spec.dependency "PINRemoteImage"


spec.source_files = "HeadStart/**/*.{h,swift}"


end

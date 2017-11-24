Pod::Spec.new do |s|
s.name         = 'JK_Empty'
s.version      = '1.0.0'
s.summary      = '轻巧、便捷的UITableView&UICollectionView的空白占位图，高度可自定一般'
s.homepage     = 'https://github.com/JsonRight/JK_Empty.git'
s.license      = 'MIT'
s.authors      = {'Jack' => '601539674@qq.com'}
s.platform     = :ios, '7.0'
s.source       = {:git => 'https://github.com/JsonRight/JK_Empty.git', :tag => s.version}
s.source_files = 'JK_EmptyDemo1/JK_EmptyDemo1/JK_Empty/**/*'
s.requires_arc = true
end

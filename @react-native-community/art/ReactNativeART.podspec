# coding: utf-8
# Copyright (c) Facebook, Inc. and its affiliates.
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.

require "json"

package = JSON.parse open('https://raw.githubusercontent.com/247-ai/tfs-react-native/master-0.61.5/package.json').read

Pod::Spec.new do |s|
  s.name                   = "ReactNativeART"
  s.version                = package['version']
  s.summary                = package['description']
  s.license                = package['license']
  s.authors                = package['author']
  s.homepage               = package['homepage']
  s.platforms              = { :ios => "9.0", :tvos => "9.2" }

  s.source                 = { :git => "https://github.com/react-native-community/art.git", :tag => "v#{s.version}" }
  s.source_files           = "ios/**/*.{h,m}"

  s.dependency "React"
end

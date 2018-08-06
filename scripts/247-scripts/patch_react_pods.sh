# usage  ./patch_react_pods.sh

echo "**** Patch for react native cocoapods using swift ****";
set -e

PROJECT_ROOT="`pwd`"
echo $PROJECT_ROOT

# https://github.com/facebook/yoga/issues/711#issuecomment-381098373
cd Pods/Target\ Support\ Files
yogaFilename="yoga/yoga-umbrella.h"
chmod +w $yogaFilename
sed -i '' '/#import "Yoga-internal.h"/d' $yogaFilename
sed -i '' '/#import "Utils.h"/d' $yogaFilename
sed -i '' '/#import "YGLayout.h"/d' $yogaFilename
sed -i '' '/#import "YGNodePrint.h"/d' $yogaFilename
sed -i '' '/#import "YGStyle.h"/d' $yogaFilename
sed -i '' '/#import "YGNode.h"/d' $yogaFilename
cd $PROJECT_ROOT

# https://github.com/facebook/react-native/issues/13198
cd Pods/React/Libraries/NativeAnimation
reactFileName="RCTNativeAnimatedNodesManager.h"
chmod +w $reactFileName
sed -i '' 's/#import <RCTAnimation\/RCTValueAnimatedNode.h>/#import "RCTValueAnimatedNode.h"/' $reactFileName
cd $PROJECT_ROOT

# https://github.com/facebook/react-native/issues/16039
cd Pods/React/Libraries/WebSocket
reactFileName="RCTReconnectingWebSocket.m"
chmod +w $reactFileName
sed -i '' 's/#import <fishhook\/fishhook.h>/#import "fishhook.h"/' $reactFileName


##### - patches that can be used in the podfile directly.
#change_lines_in_file('./Pods/Target Support Files/yoga/yoga-umbrella.h') do |lines|
#change_lines_in_file($yogaFilename) do |lines|
#lines.reject do | line |
#[
#'#import "Utils.h"',
#'#import "YGLayout.h"',
#'#import "YGNode.h"',
#'#import "YGNodePrint.h"',
#'#import "YGStyle.h"',
#'#import "Yoga-internal.h"',
#].include?(line.strip)
#end
#end
#
## https://github.com/facebook/react-native/issues/13198
#change_lines_in_file('./Pods/React/Libraries/NativeAnimation/RCTNativeAnimatedNodesManager.h') do |lines|
#lines.map { |line| line.include?("#import <RCTAnimation/RCTValueAnimatedNode.h>") ? '#import "RCTValueAnimatedNode.h"' : line }
#end
#
## https://github.com/facebook/react-native/issues/16039
#change_lines_in_file('./Pods/React/Libraries/WebSocket/RCTReconnectingWebSocket.m') do |lines|
#lines.map { |line| line.include?("#import <fishhook/fishhook.h>") ? '#import "fishhook.h"' : line }
#end


echo "**** Finished ****";

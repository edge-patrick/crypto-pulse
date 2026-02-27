#!/bin/bash

clear

displayCompilerInfo() {
	printf "\n"
	echo -n "### Current Compiler"
	printf "\n"
	eval xcrun swift -version
	eval xcode-select --print-path
}

removePlistFromMainTarget() {
    # Define variables
    PROJECT_PATH="HitHappens.xcodeproj"
    FILE_PATH="Application/Info.plist"
    TARGET_NAME="HitHappens Dev"
    PBXPROJ_PATH="$PROJECT_PATH/project.pbxproj"

    # Verify if the file exists
    if [ ! -f "$PBXPROJ_PATH" ]; then
        echo "Error: $PBXPROJ_PATH does not exist or is not a regular file."
        return 1
    fi

    # Locate the file reference ID
    FILE_REF_ID=$(grep -B 10 "$FILE_PATH" "$PBXPROJ_PATH" | grep -Eo '^[[:alnum:]]{24}' | head -n 1)

    # Locate the target build phase ID
    BUILD_PHASE_ID=$(grep -A 10 "$TARGET_NAME" "$PBXPROJ_PATH" | grep -Eo '^[[:alnum:]]{24}' | head -n 1)

    # Remove the file reference from the target's build phases
    if [ -n "$FILE_REF_ID" ]; then
        sed -i '' "/$FILE_REF_ID/d" "$PBXPROJ_PATH"
        echo "Removed file reference $FILE_PATH from target $TARGET_NAME"
    else
        echo "File reference for $FILE_PATH not found"
    fi

    # Optionally, remove build phase if empty
    if [ -n "$BUILD_PHASE_ID" ]; then
        sed -i '' "/$BUILD_PHASE_ID/d" "$PBXPROJ_PATH"
        echo "Removed build phase $BUILD_PHASE_ID if empty"
    fi
}

################################################################################

echo "### Brew"
echo " [1] : Install"
echo " [2] : Update"
echo " [3] : Skip (Default)"
echo -n "Option? "
read option
case $option in
    [1] ) /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" ;;
    [2] ) eval brew update ;;
   *) echo "Ignored...."
;;
esac

################################################################################

#printf "\n"

#echo "### CocoaPods"
#echo " [1] : Install"
#echo " [2] : Skip (Default)"
#echo -n "Option? "
#read option
#case $option in
#    [1] ) sudo gem install cocoapods ;;
#   *) echo "Ignored...."
#;;
#esac

################################################################################

printf "\n"

echo "### Swiftlint"
echo " [1] : Install"
echo " [2] : Skip (Default)"
echo -n "Option? "
read option
case $option in
    [1] ) brew install swiftlint ;;
   *) echo "Ignored...."
;;
esac

################################################################################

printf "\n"

echo "### Swiftformat"
echo " [1] : Install"
echo " [2] : Skip (Default)"
echo -n "Option? "
read option
case $option in
    [1] ) brew install swiftformat ;;
   *) echo "Ignored...."
;;
esac

################################################################################

printf "\n"

echo "### Xcodegen"
echo " [1] : Install"
echo " [2] : Upgrade"
echo " [3] : Skip (Default)"
echo -n "Option? "
read option
case $option in
    [1] ) brew install xcodegen ;;
    [2] ) brew upgrade xcodegen ;;
   *) echo "Ignored...."
;;
esac

################################################################################

displayCompilerInfo

printf "\n"

################################################################################

echo "### Kill Xcode?"
echo " [1] : No"
echo " [2] : Yes (Default)"
echo -n "Option? "
read option
case $option in
    [1] ) echo "Ignored...." ;;
   *) killall Xcode
;;
esac

################################################################################

printf "\n\n"

echo "### Clean DerivedData?"
echo " [1] : Yes"
echo " [2] : No (Default)"
echo -n "Option? "
read option
case $option in
    [1] ) rm -rf ~/Library/Developer/Xcode/DerivedData/* ;;
   *) echo "Ignored...."
;;
esac

################################################################################

printf "\n"

echo "### Run XcodeGen?"
echo " [1] : Yes (MultiConfig)"
echo " [2] : No"
echo -n "Option? "
read option
case $option in
    [1] ) xcodegen -s ./XcodeGen/Xcodegen.yml -p ./ ;;
    [2] ) echo "Ignored...." ;;
   *) xcodegen -s ./XcodeGen/Xcodegen.yml -p ./ 
;;
esac

################################################################################

printf "\n"


################################################################################

# Use plutil to remove the file from the target's build phases
echo ""
echo " ╔═══════════════════════╗"
echo " ║ Done! You're all set! ║"
echo " ╚═══════════════════════╝"


open CryptoPulse.xcodeproj
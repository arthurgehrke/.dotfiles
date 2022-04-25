eval "$(/opt/homebrew/bin/brew shellenv)"

nvm_use (){
  NODE_NEW=$1

  PREVIOUS_PACKAGES=$(npm ls -g --parseable --depth=0)

  nvm use ${NODE_NEW}

  ALL_PACKAGES=$(npm ls -g --depth=0)

  for PACKAGE in $(echo "$PREVIOUS_PACKAGES" | grep "/node_modules/[^npm]");
  do
    PACKAGE_NAME=${PACKAGE##*/}
    PACKAGE_IN_CURRENT_VERSION=$(echo "$ALL_PACKAGES" | grep $PACKAGE_NAME)
    if [ "$PACKAGE_IN_CURRENT_VERSION" = "" ]; then
      npm i -g $PACKAGE_NAME
    fi
  done
}

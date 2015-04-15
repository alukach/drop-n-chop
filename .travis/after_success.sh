if [ "$TRAVIS_BRANCH" != "$RELEASE_BRANCH" ]; then
    echo "In branch '$TRAVIS_BRANCH', not '$RELEASE_BRANCH'. Not deploying."
    exit 0;
fi

echo "Configuring git..."
git config --global user.email "travis@cugos.org"
git config --global user.name "Travis CI"
git config credential.helper "store --file=.git/credentials"
git remote set-url origin https://${GH_TOKEN}@github.com/alukach/drop-n-chop.git

echo "Running gh-pages..."
grunt gh-pages

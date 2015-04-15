# Post-build Deployment Script
# Upon a successful build in the 'release branch', this script will set up Git
# and the Grunt gh-pages command.
#
# This script requires that:
#   - grunt-gh-pages be installed and configured: https://github.com/tschaub/grunt-gh-pages
#   - a Github OAuth token with 'public_repo' permissions be added as a
#     (non-displayed) environment variable within Travis, with the key 'GH_TOKEN'
#   - the name of the branch to watch for commits and to deploy be added as an
#     environment variable within Travis, with the key 'RELEASE_BRANCH'
#

if [ "$TRAVIS_BRANCH" != "$RELEASE_BRANCH" ]; then
    echo "In branch '$TRAVIS_BRANCH', not '$RELEASE_BRANCH'. Not deploying."
    exit 0;
fi

echo "Configuring git..."
git config --global user.email "travis@cugos.org"
git config --global user.name "Travis CI"
git remote set-url origin https://${GH_TOKEN}@github.com/$TRAVIS_REPO_SLUG.git

echo "Running gh-pages..."
grunt gh-pages

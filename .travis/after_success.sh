if [ "$TRAVIS_BRANCH" != "master" ]; then
    exit 0;
fi

# export GIT_COMMITTER_EMAIL=...
# export GIT_COMMITTER_NAME=...

git checkout gh-pages || exit
git merge "$TRAVIS_COMMIT" || exit
git push ... # here need some authorization and url

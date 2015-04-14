if [ "$TRAVIS_BRANCH" != "$RELEASE_BRANCH" ]; then
    echo "In branch '$TRAVIS_BRANCH', not '$RELEASE_BRANCH'. Not deploying."
    exit 0;
fi

# export GIT_COMMITTER_EMAIL=...
# export GIT_COMMITTER_NAME=...

echo "Checking out $SERVED_BRANCH..."
git fetch
git checkout $SERVED_BRANCH || exit

echo "Merging $TRAVIS_COMMIT..."
git merge "$TRAVIS_COMMIT" || exit

echo "Building..."
grunt build || exit

echo "Adding & committing..."
git add -f ./dist || exit
git commit -m "$TRAVIS_COMMIT"

echo "Pushing..."
git push

echo "Success!"

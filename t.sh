
branch="test$1"
file="test$1.tf"
message="test$1"

git checkout master
git checkout -b $branch
touch $file
git add .
git commit -m "$message"
git log

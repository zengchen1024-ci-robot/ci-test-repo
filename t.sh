if [$# -eq 1]; then
  echo "input branch number"
  exit 0
fi

branch="test$1"
file="test$1.tf"
message="test$1"

git checkout master
git checkout -b $branch
touch $file
git add .
git commit -m "$message"
git log

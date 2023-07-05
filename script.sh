#!/bin/bash

# Extract the commit message
funcs[0]="lambda_func_1"
#funcs[1]="lambda_func_2"

commit_message=$(git diff-tree --name-only -r --no-commit-id HEAD)
echo $commit_message



for func in "${funcs[@]}"; do
  if [[ $commit_message =~ func ]]; then
          cd src/lambda_func_1
          docker build -t lambda-func-1 .
          $(aws ecr get-login --no-include-email --region eu-central-1)
          docker tag lambda-func-1 764717859735.dkr.ecr.eu-central-1.amazonaws.com/lambda-func-1:latest
          docker push 764717859735.dkr.ecr.eu-central-1.amazonaws.com/lambda-func-1:latest
          aws lambda update-function-code --function-name lambda-func-1 --image-uri 764717859735.dkr.ecr.eu-central-1.amazonaws.com/lambda-func-1:latest
    fi
done

#if [[ $commit_message =~ "folder1" ]]; then
#  echo "Deploying Lambda function for folder1"
#fi

#if [[ $commit_message =~ "folder2" ]]; then
#  echo "Deploying Lambda function for folder2"
#fi

# Add more conditionals for other folders as needed



#commands[0]="isort . --check-only"
#commands[1]="mypy --config-file setup.cfg"
#commands[2]="flake8 ./lambda_handler.py ./src/"
#
#errors=()
#set +e
#
#for cmd in "${commands[@]}"; do
#    res=$($cmd)
#    if [ $? -ne 0 ]; then
#        echo $res
#        errors+=("$res")
#    fi
#done
#
#
#if [ ${#errors[@]} -gt 0 ]; then
#    for err in "${errors[@]}"; do
#     echo "###############ERROR section starts################"
#     echo "$err"
#     echo "###############ERROR section ends################"
#    done
#exit 1
#fi
#

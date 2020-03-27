# runner_log
# runner_log_error (red)
# runner_log_warning (yellow)
# runner_log_success (green)
# runner_log_notice (gray)

AWS_REGION="sa-east-1"
lambda="aws --region=${AWS_REGION} --endpoint-url=http://localhost:4574 --output text lambda "
LAMBDA_NAME="test-file"

task_install_lambda_reqs(){
  runner_log_notice "installing lambda requirements"
  runner_run [ ! -d "lambdas/bin" ] && python3 -m venv lambdas
  runner_run cd lambdas
  runner_run source bin/activate
  runner_run [ -f "requirements.txt" ] && pip3 install -r requirements.txt -t ./ 
  runner_run deactivate
}

task_create_lambda(){
  runner_log_success "creating lambda"
  runner_run rm function.zip
  runner_run cd lambdas || exit
  runner_run zip -qr9 ../function.zip ./
  runner_run $lambda create-function --function-name ${LAMBDA_NAME} \
    --handler "lambda_function.handler" \
    --runtime nodejs12.x \
    --role arn:aws:${AWS_REGION}::123456:role/irrelevant \
    --zip-file "fileb://../function.zip"
}

task_update_lambda(){
  runner_log_success "updating lambda code"
  runner_run rm function.zip
  runner_run cd lambdas || exit
  runner_run zip -qr9 ../function.zip ./
  runner_run $lambda update-function-code --function-name ${LAMBDA_NAME} --zip-file "fileb://../function.zip"
}
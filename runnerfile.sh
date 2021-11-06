# runner_log
# runner_log_error (red)
# runner_log_warning (yellow)
# runner_log_success (green)
# runner_log_notice (gray)
FOLDER="lambda"
HANDLER="src/function.handler"
AWS_REGION="sa-east-1"
CMD="aws --region ${AWS_REGION} --endpoint-url http://localhost:4566 --output json lambda "
LAMBDA_NAME="test"

task_install_lambda_reqs() {
  runner_log_notice "installing lambda requirements"
  runner_run rm -r $FOLDER
  runner_run mkdir $FOLDER && 
  runner_run cp -r package.json $FOLDER
  runner_run cp -r src $FOLDER
  runner_run cd $FOLDER
  runner_run npm install
}

task_create_lambda() {
  runner_log_success "creating lambda"
  runner_run rm function.zip
  runner_run cd $FOLDER || exit
  runner_run zip -qr9 ../function.zip ./
  runner_run $CMD create-function --function-name ${LAMBDA_NAME} \
    --handler $HANDLER \
    --runtime nodejs12.x \
    --role arn:aws:${AWS_REGION}::123456:role/irrelevant \
    --zip-file "fileb://../function.zip"
}

task_update_lambda() {
  runner_log_success "updating lambda code"
  runner_run rm function.zip
  runner_sequence install_lambda_reqs || exit
  runner_run zip -qr9 ../function.zip ./
  runner_run $CMD update-function-code --function-name ${LAMBDA_NAME} --zip-file "fileb://../function.zip"
}
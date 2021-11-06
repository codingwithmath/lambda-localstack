const AWS = require('aws-sdk');

const getEndPoint = new AWS.Endpoint('http://localhost:4566');

AWS.config.update({ 
region: 'sa-east-1',
endpoint: getEndPoint,
credentials: {
  accessKeyId: 'matheus',
  secretAccessKey: 'matheus'
}});

const lambda = new AWS.Lambda();

const params = {
  FunctionName: "arn:aws:lambda:sa-east-1:000000000000:function:test", 
  InvocationType: "RequestResponse", 
  Payload: JSON.stringify({
    name: "testing",
  })
}

async function invokeLambda() {
  const resLambda = await lambda.invoke(params).promise()

  console.log(resLambda);
};

invokeLambda();

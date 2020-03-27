const AWS = require('aws-sdk');

const getEndPoint = new AWS.Endpoint('http://localhost:4574');

AWS.config.update({ 
region: 'sa-east-1',
endpoint: getEndPoint,
credentials: {
  accessKeyId: 'matheus',
  secretAccessKey: 'matheus'
}});

const lambda = new AWS.Lambda();

const params = {
  FunctionName: "arquivos-teste",
}
async function invokeLambda() {
let resLambda = await lambda.invoke({ FunctionName: "arn:aws:lambda:sa-east-1:000000000000:function:arquivos-teste", 
  InvocationType: "RequestResponse", 
  Payload: JSON.stringify({
    Hello: "Teste",
  })
})
  .promise()

  console.log(resLambda);
};

invokeLambda();

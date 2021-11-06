exports.handler = async (event, source) => {
  console.log(`This is the event ${event}`);

  console.log(`This is the source ${source}`);

  const greeting = {
    hello: `Hello ${event.name}`
  };

  return greeting;
}

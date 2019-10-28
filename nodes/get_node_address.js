https.get('https://waterservices.usgs.gov/nwis/iv/?format=json&sites=323915117055301,323808117060401,324055117064401&period=P1D&modifiedSince=PT60M&variable=72019', (resp) => {
  let data = '';

  // A chunk of data has been recieved.
  resp.on('data', (chunk) => {
    data += chunk;
  });

  // The whole response has been received. Print out the result.
  resp.on('end', () => {
    console.log(JSON.parse(data).value.timeSeries);
    //console.log(JSON.parse(data).value.timeSeries[0].values[0].value);
    console.log(Object.keys(JSON.parse(data).value.timeSeries[0].values[0].value).length);
  });

}).on("error", (err) => {
  console.log("Error: " + err.message);
});
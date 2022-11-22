console.log("Hello, World");
//print('hello world')

const express = require("express");
// import 'package:express/express.dart
const PORT = 3000;

const app = express();

//CREATING AN API WITH NODE.JS  USING EXPRESS
//http://<youripaddress>/hello-world
app.get("/hello-world", (req, res) => {
  res.json({ hi: "hello world" });
});
//GET, PUT, POST, DELETE, UPDATE -> CRUDb
app.listen(PORT, () => {
  console.log(`connected at port ${PORT}`);
});

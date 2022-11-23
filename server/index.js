// IMPORTS FROM PACKAGES
const express = require("express");
const mongoose = require("mongoose");
const authRouter = require("./routes/auth");

// INIT
const PORT = 3000;
const app = express();
const DB =
  "mongodb+srv://emin:Muhalada_1990@cluster0.hfnwi67.mongodb.net/?retryWrites=true&w=majority";

// middleware
app.use(express.json());
app.use(authRouter);

// Connections
mongoose
  .connect(DB)
  .then(() => {
    console.log("Connection Successful");
  })
  .catch((e) => {
    console.log(e);
  });

app.listen(PORT, "0.0.0.0", () => {
  console.log(`connected at port ${PORT}`);
});

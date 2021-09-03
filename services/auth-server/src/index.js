const express = require("express");
const logger = require("morgan");

const PORT = 80;

const app = express();
app.use(logger("tiny"));
app.use((req, res) => {
  res.set("X-User-ID", "00abc123");
  res.sendStatus(200);
});
app.listen(PORT);

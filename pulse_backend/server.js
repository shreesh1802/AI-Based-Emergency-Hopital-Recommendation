const recommendRoute = require("./routes/recommend");
const express = require("express");
const bodyParser = require("body-parser");
const cors = require("cors");

const app = express();
app.use(bodyParser.json());
app.use(cors());

app.get("/", (req, res) => {
  res.send("Recommend endpoint is alive");
});

app.post("/recommend", (req, res) => {
  res.json([
    {
      name: "City Hospital",
      eta: 8,
      beds_available: 4,
      lat: 28.7041,
      lng: 77.1025
    },
    {
      name: "Metro Care",
      eta: 12,
      beds_available: 6,
      lat: 28.7090,
      lng: 77.1000
    }
  ]);
});

const PORT = 8000;
app.use("/recommend", recommendRoute);
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
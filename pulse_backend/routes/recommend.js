const express = require("express");
const router = express.Router();

const { recommendHospitals } = require("../ai/engine");

router.post("/", (req, res) => {

  const { lat, lng, emergency, insurance } = req.body;

  const dummyHospitals = [
    { name: "City Hospital", eta: 8, beds_available: 4, insurance_supported: true },
    { name: "Metro Care", eta: 12, beds_available: 2, insurance_supported: false }
  ];

  const ranked = recommendHospitals(req.body, dummyHospitals);

  res.json(ranked);
});

module.exports = router;
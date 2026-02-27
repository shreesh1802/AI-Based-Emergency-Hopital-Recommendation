function recommendHospitals(userContext, hospitals) {

  const ranked = hospitals.map(h => {

    const distanceScore = 1 - h.eta / 30; // priority
    const availabilityScore = h.beds_available / 5;
    const financialScore = h.insurance_supported ? 1 : 0.3;

    const score =
      0.45 * distanceScore +
      0.30 * availabilityScore +
      0.25 * financialScore;

    return { ...h, score };
  });

  ranked.sort((a, b) => b.score - a.score);

  return ranked.slice(0, 3);
}

module.exports = { recommendHospitals };
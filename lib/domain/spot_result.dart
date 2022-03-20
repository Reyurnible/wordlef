
enum SpotResult {
  // Input word. Unknown result,
  unknown,
  // Green: In the word and in the correct spot.
  correctSpot,
  // Yellow: In the word bug wrong spot.
  wrongSpot,
  // Grey: Not in the word any spot.
  notInWord,
}
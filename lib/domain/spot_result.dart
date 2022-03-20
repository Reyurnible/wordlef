
enum SpotResult {
  // Input word. Unknown result,
  Unknown,
  // Green: In the word and in the correct spot.
  CorrectSpot,
  // Yellow: In the word bug wrong spot.
  WrongSpot,
  // Grey: Not in the word any spot.
  NotInWord,
}
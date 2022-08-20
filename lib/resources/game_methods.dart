class GameMethods {
  String checkWinner(List<String> displayElements) {
    String winner = '';

    // Checking rows
    if (displayElements[0] == displayElements[1] &&
        displayElements[0] == displayElements[2] &&
        displayElements[0] != '') {
      winner = displayElements[0];
    }
    if (displayElements[3] == displayElements[4] &&
        displayElements[3] == displayElements[5] &&
        displayElements[3] != '') {
      winner = displayElements[3];
    }
    if (displayElements[6] == displayElements[7] &&
        displayElements[6] == displayElements[8] &&
        displayElements[6] != '') {
      winner = displayElements[6];
    }

    // Checking Column
    if (displayElements[0] == displayElements[3] &&
        displayElements[0] == displayElements[6] &&
        displayElements[0] != '') {
      winner = displayElements[0];
    }
    if (displayElements[1] == displayElements[4] &&
        displayElements[1] == displayElements[7] &&
        displayElements[1] != '') {
      winner = displayElements[1];
    }
    if (displayElements[2] == displayElements[5] &&
        displayElements[2] == displayElements[8] &&
        displayElements[2] != '') {
      winner = displayElements[2];
    }

    // Checking Diagonal
    if (displayElements[0] == displayElements[4] &&
        displayElements[0] == displayElements[8] &&
        displayElements[0] != '') {
      winner = displayElements[0];
    }
    if (displayElements[2] == displayElements[4] &&
        displayElements[2] == displayElements[6] &&
        displayElements[2] != '') {
      winner = displayElements[2];
    }
    return winner;
  }
}

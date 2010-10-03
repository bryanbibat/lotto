$(document).ready(function () {
  displayNumbersBasedOnGame();
  $("#ticket_size").change(displayNumbersBasedOnGame);
});

function displayNumbersBasedOnGame() {
  size = parseInt($("#ticket_size").val());
  for (var idx = 42; idx <= size; idx++) {
    $("#cell" + idx).show();
  }

  for (var idx = size + 1; idx <= 56; idx++) {
    $("#cell" + idx).hide();
    $("#ticket_numbers_" + idx).attr("checked", false);
  }
}


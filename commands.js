var data = $.getJSON("commands.json", function() {
  const com = data['responseJSON'];
  var type = "";
  var coms = "<table id=\"blocks\"> <thead> <tr>    <th>Plugin</th>    <th>Command</th>    <th>Arguments</th>    <th>Aliases</th>    <th>Description</th>  </tr></thead><tbody>";

  for (var i = 0; i < com.length; i++) {
    coms += "<tr>";
    for (var k = 0; k < 5; k++) {
      if (k == 0) {
        type = "Plugin";
      } else if (k == 1) {
        type = "Command";
      } else if (k == 2) {
        type = "Arguments";
      } else if (k == 3) {
        type = "Aliases";
      } else if (k == 4) {
        type = "Description";
      }
      coms += "<td>" + com[i][type] + "</td>";
    }
    coms += "</tr>";
  }
  coms += "</tbody> </table>";

  var div = document.createElement('rows');
  div.innerHTML = coms;
  document.getElementById('commandList').appendChild(div);

});

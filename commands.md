# Chewbotcca Commands

For now I just wanted a simple list of commands to keep updated easier than restarting the bot every time. So, without further ado, here is that list!

<style>
#findblocks {
    background-image: url('https://www.w3schools.com/css/searchicon.png');
    background-position: 10px 12px;
    background-repeat: no-repeat;
    width: 100%;
    font-size: 16px;
    padding: 12px 20px 12px 40px;
    border: 1px solid #ddd;
    margin-bottom: 12px;
}
#blocks {
    border-collapse: collapse;
    width: 91.7%;
    border: 1px solid #ddd;
    font-size: 18px;
}
#blocks th, #blocks td {
    text-align: left;
    padding: 12px;
}
#block tr {
    border-bottom: 1px solid #ddd;
}
</style>

<script>
function lookWords() {
  // Declare variables
  var input, filter, table, tr, td, i;
  input = document.getElementById("findblocks");
  filter = input.value.toUpperCase();
  table = document.getElementById("blocks");
  tr = table.getElementsByTagName("tr");

  // Loop through all table rows, and hide those who don't match the search query
  for (i = 0; i < tr.length; i++) {
    td = tr[i].getElementsByTagName("td")[1];
    if (td) {
      if (td.innerHTML.toUpperCase().indexOf(filter) > -1) {
        tr[i].style.display = "";
      } else {
        tr[i].style.display = "none";
      }
    }
  }
}
</script>

<input type="text" id="findblocks" onkeyup="lookWords()" placeholder="Search for Commands..">

{:#blocks}
Command | Description
---|----
%^ping | Replies with "Pong!"
%^help | Shows a list of commands.
%^info | Type in a command (NO PREFIX) and it will give info on the command.
%^invite | Shows a link to invite Chewbotcca to your server and a discord invite link to the help server.
%^rate | Rate something /10.
%^namemc | Shows a link to search results for a response, or if there''s one result, will show detailed info.
%^memedb | It's the meme database, What more do you need??
%^stats | Shows basic stats for Chewbotcca.
%^rip | Makes someone or something rip. No spaces, letters and numbers only.
%^namecheap | Searches namecheap.com for a domain name. No spaces or special characters, just a normal domain search.
%^uinfo | Shows basic stats for the user.
%^sinfo | Shows basic stats for the server.
%^cat | Shows a random cat. meow.
%^catfact | Shows a catfact
%^trbmb | That really blanks my blank.
%^restart | Restarts the bot.

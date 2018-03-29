# Chewbotcca Commands

For now I just wanted a simple list of commands to keep updated easier than restarting the bot every time. So, without further ado, here is that list!

<link rel="stylesheet" href="assets/css/searchBoxes.css">
<script src="assets/js/searchtable.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>

<input type="text" id="findblocks" onkeyup="searchTable(0, 'findblocks')" placeholder="Search by Plugin">
<input type="text" id="findids" onkeyup="searchTable(1, 'findids')" placeholder="Command">
<input type="text" id="findprice" onkeyup="searchTable(2, 'findprice')" placeholder="Aliases">
<input type="text" id="findbuy" onkeyup="searchTable(3, 'findbuy')" placeholder="Description">

{:#blocks}
| Plugin      | Command                  | Arguments                 | Aliases              | Description                                                                                        |
| ----------- | ------------------------ | ------------------------- | -------------------- | -------------------------------------------------------------------------------------------------- |
| About       | %^help                   | None                      | %^commands           | Shows a link to a list of commands.                                                                |
| About       | %^ping                   | noedit if no edit         | None                 | Replies with "Pong!"                                                                               |
| About       | %^invite                 | None                      | None                 | Shows a link to invite Chewbotcca to your server and a discord invite link to the help server.     |
| About       | %^forceupdateservercount | None                      | None                 | Updates the server count on all the api's and the bot game.                                        |
| About       | %^stats                  | None                      | None                 | Shows basic stats for Chewbotcca.                                                                  |
| Cat         | %^cat                    | None                      | None                 | Shows a random cat. meow.                                                                          |
| Cat         | %^catfact                | None                      | None                 | Shows a catfact                                                                                    |
| English     | %^urban                  | Word to define            | None                 | Defines a word using urban dictionary                                                              |
| Eval        | %^eval                   | Expression to eval        | None                 | Evaluate expressions in ruby. **Requires Bot Owner**                                               |
| Google      | %^youtube                | Video to find             | None                 | Finds a video on youtube given a term.                                                             |
| Info        | %^info                   | Command                   | None                 | Type in a command (NO PREFIX) and it will give info on the command.                                |
| MemeDB      | %^memedb                 | Meme to find              | None                 | It's the meme database, What more do you need??                                                    |
| Minecraft   | %^namemc                 | Name to look up           | None                 | Shows a link to search results for a response, or if there''s one result, will show detailed info. |
| Minecraft   | %^mcavatar               | MC Username               | None                 | Shows a mcavatar for the specified user.                                                           |
| Minecraft   | %^mcstatus               | None                      | None                 | Shows Minecraft Statuses                                                                           |
| Minecraft   | %^mcserver               | Server IP                 | None                 | Shows minecraft server stats for a given server.                                                   |
| Misc        | %^isup                   | Website URL               | None                 | Shows website status, up or down?                                                                  |
| Misc        | %^8ball                  | Question to ask           | %^eball, %^eightball | Asks the 8ball a question.                                                                         |
| Misc        | %^qrcode                 | Text to make              | None                 | Create a QR code with given text.                                                                  |
| Misc        | %^flip                   | None                      | None                 | Flip a coin!                                                                                       |
| Misc        | %^choose                 | A comma separated list    | None                 | Picks a random choice from a list of comma separated values.                                       |
| Music       | %^lastfm                 | Last.fm username          | None                 | Finds lastfm stats for a user                                                                      |
| MusicPlayer | %^songs                  | None                      | None                 | Lists `%^play`able songs.                                                                          |
| MusicPlayer | %^play                   | Song to play              | None                 | Plays a song from the database.                                                                    |
| MusicPlayer | %^connect                | None                      | None                 | Makes the bot connect to your voice channel.                                                       |
| Namecheap   | %^namecheap              | URL to find.              | None                 | Returns a link with search results to namecheap.                                                   |
| Quotes      | %^trbmb                  | None                      | None                 | Generates a TRBMB quote. Based on [TRBMB Gen](http://trbmb.chew.pw)                                |
| Quotes      | %^acronym                | Acronym to solve          | None                 | Uses <http://acronym.chew.pro> to fill out an acronym.                                             |
| Rate        | %^rate                   | Your rating               | None                 | Rate something /10.                                                                                |
| Restart     | %^restart                | None                      | None                 | Restarts the bot. **Bot Owner Only**                                                               |
| Restart     | %^update                 | None                      | None                 | Updates the bot. **Bot Owner Only**                                                                |
| Restart     | %^updates                | None                      | None                 | Returns bot version and status. **Bot Owner Only.. Kinda**                                         |
| Restart     | %^shoo                   | None                      | None                 | Kills the bot. Bye! **Bot Owner Only**                                                             |
| Restart     | %^new                    | None                      | None                 | Finds 10 most recent commits                                                                       |
| Roles       | %^createrole             | Role name                 | None                 | Create a role with a given name.
| Rip         | %^rip                    | Person to rip             | None                 | Makes someone or something rip. No spaces, letters and numbers only.                               |
| ServerInfo  | %^sinfo                  | None                      | %^serverinfo         | Shows basic stats for the server.                                                                  |
| UserInfo    | %^uinfo                  | Mention a user (optional) | %^userinfo           | Shows basic stats for a user.                                                                      |

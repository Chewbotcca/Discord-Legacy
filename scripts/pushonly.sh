while true
do
  echo "Lets upload those local commits"
  git push

  echo "Booting up the bot..."
  ruby code.rb
done

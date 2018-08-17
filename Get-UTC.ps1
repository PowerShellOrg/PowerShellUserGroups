#get the current date and time in a UTC format with a long date time
#use this value when updating markdown documents

"$((get-date).touniversaltime().datetime) UTC"
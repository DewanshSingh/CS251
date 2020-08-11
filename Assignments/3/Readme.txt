Assignment #3 
Ayush Hitesh Soneria - 170192
Dewansh Kr Singh - 170241

Task 1

We are taking the file name as the first argument for the ./task1.sh command 
(script.sh is the script that we created)

We are using a while loop to iterate over the lines of the sample file by using done < "$s"
at the end of the loop

Then we created a nested if - elif loop in which we checked for the file extension 

We did the following next instructions for each of the four types of file extension 

And then suitable decided the preffered final directory for each (eg /include for ".h" )

We then created an array of the words in a line 

we created a file ( 1st element of array ) 

we made a directory (3rd element)

Now we checked for all the three permissions one by one and assigned and unassigned accordingly using chmod

now using mv we moved the files to their directories

Task 2

we used wget -q to first get the rss feeds to our machine ( -q to quite the wget output of terminal  )

we took the team name as the first argument 

We created an infinite while loop 

now we read the rss feeds that were downloaded and searched for the team name given as argument 1 

we created another variable "l2"  and stored the line containing the argument( basically stored the first instance of the score ) .
next we kept refreshing the feeds every 10s and checked if the line still matches with the varibale l2. if not we then send a notif using notif-send to the desktop 








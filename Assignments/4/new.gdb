file ./main1
break add
break sub
break mpy
break divide
set confirm off
set pagination off
#set logging file result.txt
#set logging overwrite on
#set logging on
run input
set $total = 5
set $i = 0
   while($i<$total)
     set $i = $i + 1
     info registers
     c 
   end
#set logging off
#set logging overwrite off
q

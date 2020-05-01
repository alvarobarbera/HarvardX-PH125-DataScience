B <- 10000
stick <- replicate(B, {
  doors <- as.character(1:3)
  prize <- sample(c("car","goat","goat"))   #random prizes
  prize_door <- doors[prize == "car"]    	# prize door with car
  my_pick  <- sample(doors, 1)    		#random pick
  show <- sample(doors[!doors %in% c(my_pick, prize_door)],1)   
  stick <- my_pick    
  stick == prize_door    
})
mean(stick) 


#Switching doors

B <- 10000
switch <- replicate(B, {
  doors <- as.character(1:3)
  prize <- sample(c("car","goat","goat"))   #random prizes
  prize_door <- doors[prize == "car"]    	# prize door with car
  my_pick  <- sample(doors, 1)    		#random pick
  show <- sample(doors[!doors %in% c(my_pick, prize_door)],1)   
  switch <- doors[!doors %in% c(my_pick,show)]    
  switch == prize_door    
})
mean(switch) 



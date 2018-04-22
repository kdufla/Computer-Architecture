.data 
space: .ascii " "
.text 
.globl main

.macro readint
	li 	$v0, 5			# load readint syscall code
	syscall				# read int into $v0
.end_macro


main:
	readint				# load int into $v0
	move	$t1, $v0		# store loaded int into $t1
	move	$a0, $t1		# set size of array
	move	$s1, $t1		# store size of array into $s1
	li	$v0, 9			# set syscall code to allocate memory
	syscall				# allocate memory
	move	$a1, $v0		# store allocated memory adddres into a1
	
	li	$t2, 2			# set first counter to 2
	li 	$t4, 2			#set counter for printing prime numbers
	li	$t6, 2
	j makeAllTrue

allTrue:	
	li	$t2, 2			#return first counter to 0
	j loop1
	
	
makeAllTrue:
	bgt 	$t2, $s1,allTrue		#if loop is finished and everything is true
	add 	$a3, $t2, $a1		#go to current address
	addi	$t7, $zero, 1
	sb	$t7, ($a3)
	addi	$t2, $t2, 1
	j makeAllTrue
	
loop1:	
	mul	$s5, $t2, $t2
	bgt 	$s5, $s1, printAll
	add	$a3, $t2, $a1
	lb 	$t5, ($a3)
	li	$t7, 1
	beq	$t5, $t7,loop2
	addi	$t2, $t2, 1
	j loop1
	
loop2:
	bgt	$t6, $s1, finishLoop2
	beq	$t6, $t2, continue
	rem	$t5, $t6, $t2	
	beqz	$t5, setToZeroAndContinue
	addi	$t6, $t6, 1
	j 	loop2

setToZeroAndContinue:
	add 	$a3, $t6, $a1
	sb	$s6, ($a3)
	addi 	$t6, $t6,1
	j 	loop2
	
continue:
	addi 	$t6, $t6,1
	j 	loop2
	
finishLoop2:
	addi, 	$t2,$t2,1
	move	$t6,$t2
	j 	loop1		
	
printAll:
	bgt 	$t4, $s1, end
	add 	$a3, $t4, $a1
	lb 	$t3, ($a3)
	bnez	$t3, printAndIncrement
	addi 	$t4, $t4, 1
	j 	printAll
	
printAndIncrement:
	move	$a0, $t4
	li	$v0, 1
	syscall
	li 	$v0, 4 
	la 	$a0, space		
	syscall
	addi	$t4, $t4, 1
	j 	printAll
	
end:
	li	$v0, 10
	syscall			# end program

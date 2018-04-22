.data 
.text 
.globl init


init:
	jal	readint			# load int into $v0
	move	$a2, $v0		# store loaded int into $a1
	li	$a1, 2			# set starting divisor to be 2
	j	loop			# start loop
	
	
loop:
	div	$a2, $a1		# divide number by divisor
	mfhi	$a3			# get reminder
	beq	$a3, 0, isdivisor	# if reminder is 0, program found one of the factors
	add	$a1, $a1, 1		# div++
	bgt	$a1, $a2, finish	# if divisor > number finish program
	j	loop			# start loop again
	
	

isdivisor:
	jal	printint		# print divisor
	jal	printspace		# print white space charcter
	mflo	$a2			# set divided value to number
	bgt	$a1, $a2, finish	# if divisor > number finish program
	j loop				# start loop again
	
	
finish:
	li	$v0, 10			# set exit syscall code
	syscall				# exit
	

printint:
	move	$a0, $a1		# load int to print
	li	$v0, 1			# set printint syscall code
	syscall				# print number at $a0
	jr	$ra			# return to address saved by jal
	
	
printspace:
	li	$a0, 32			# load ASCII space in $a0
	li	$v0, 11			# set printchar syscall code
	syscall				# print space
	jr	$ra			# return to address saved by jal
	

readint:
	li 	$v0, 5			# load readint syscall code
	syscall				# read int into $v0
	
	jr 	$ra			# return to address saved by jal

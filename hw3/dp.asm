.data 
n: .word 10
a: .word 6 1 5 3 7 5 3 6 8 4
b: .space 800
.text 
.globl init


init:
	la	$t0, a		# pointer to array a
	la	$t1, b		# pointer to array b
	lw	$t2, n		# number of elements
	li	$t3, 4		# sizeof int
	
	li	$t4, 1
	sw	$t4, ($t1)	# b[0] = 1
	
	li	$t4, 0		# max
	li	$t5, 0		# global max
	li	$t6, 1		# i
	li	$t7, 0		# j

loop:
	bge	$t6, $t2, end	# if i < n continue else end
	li	$t4, 0		# max = 0
	li	$t7, 0		# j = 0

loop2:
	bge	$t7, $t6, loopEnd
	
	mult	$t3, $t6
	mflo	$a3
	add	$a3, $a3, $t0
	lw	$a3, ($a3)	# a3 = a[i]
	
	mult	$t3, $t7
	mflo	$a2
	add	$a2, $a2, $t0
	lw	$a2, ($a2)	# a2 = a[j]
	
	bge	$a2, $a3, loopEnd2
	
	mult	$t3, $t7
	mflo	$a2
	add	$a2, $a2, $t1
	lw	$a2, ($a2)	# a2 = b[j]
	
	bge	$t4, $a2, loopEnd2
	
	move	$t4, $a2	# max = b[j]

loopEnd2:
	addi	$t7, $t7, 1
	j	loop2
	
loopEnd:
	mult	$t3, $t6
	mflo	$a3
	add	$a3, $a3, $t1	# ptr to b[i]
	
	addi	$t4, $t4, 1
	sw	$t4, ($a3)	# b[i] = max + 1
	
	addi	$t6, $t6, 1

	bgt	$t5, $t4, loop
	move	$t5, $t4	# global max = max +1
	j	loop
	
end:
	move	$a0, $t5
	li	$v0, 1			# set printint syscall code
	syscall				# print number at $a0

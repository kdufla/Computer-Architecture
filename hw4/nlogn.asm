.data 
n: .word 9
a: .word 2 5 3 7 11 8 10 13 6
b: .space 800
.text 
.globl init


init:
	la	$t0, a			# pointer to array a
	la	$t1, b			# pointer to array b
	lw	$t2, n			# n
	li	$t3, 4			# sizeof int
	li	$t4, 1			# l
	li	$t5, 1			# i
	li	$t6, 0			# ll
	li	$t7, 0			# r
	li	$t8, 0			# m
	
	lw	$a0, ($t0)
	sw	$a0, ($t1)
	
	
loop:
	bge	$t5, $t2, end		# if i < n continue else end
	
	mult	$t3, $t5
	mflo	$a0
	add	$a0, $a0, $t0
	lw	$a0, ($a0)		# a0 = a[i]
	
	lw	$a1, ($t1)		# a1 = b[0]
	
	blt	$a0, $a1, branchOne	# if (a[i] < b[0])
	
	addi	$a1, $t4, -1
	mult	$t3, $a1
	mflo	$a1
	add	$a1, $a1, $t1
	lw	$a1, ($a1)		# a1 = b[l - 1]
	
	blt	$a1, $a0, branchTwo	# if (b[l - 1] < a[i])
	
	li	$t6, -1			# ll = -1
	addi	$t7, $t4, -1		# r = l - 1
	
	
whileLoop:
	sub	$a0, $t7, $t6
	
	ble	$a0, 1, endWhile	# while (r - ll > 1)
	
	li	$a1, 2
	div	$a0, $a1
	mflo	$a1
	add	$t8, $t6, $a1		# m = ll + (r - ll) / 2
	
	mult	$t3, $t5
	mflo	$a0
	add	$a0, $a0, $t0
	lw	$a0, ($a0)		# a0 = a[i]
	
	mult	$t3, $t8
	mflo	$a1
	add	$a1, $a1, $t0
	lw	$a1, ($a1)		# a1 = a[m]
	
	bge	$a1, $a0, branchThree	# if (a[m] >= a[i])
	
	move	$t6, $t8		# ll = m
	
	j	whileLoop
	
	
branchOne:
	sw	$a0, ($t1)		# b[0] = a[i]
	addi	$t5, $t5, 1		# i++
	j	loop
	
	
branchTwo:
	mult	$t3, $t4
	mflo	$a1
	add	$a1, $a1, $t1
	sw	$a0, ($a1)		# b[l] = a[i]
	addi	$t4, $t4, 1		# l++
	addi	$t5, $t5, 1		# i++
	j	loop
	
	
endWhile:
	mult	$t3, $t5
	mflo	$a0
	add	$a0, $a0, $t0
	lw	$a0, ($a0)		# a0 = a[i]
	
	mult	$t3, $t7
	mflo	$a1
	add	$a1, $a1, $t1
	sw	$a0, ($a1)		# b[r] = a[i]
	addi	$t5, $t5, 1		# i++
	j	loop 
	
	
branchThree:
	move	$t7, $t8		# r = m
	j	whileLoop
	
	
end:
	move	$a0, $t4
	li	$v0, 1			# set printint syscall code
	syscall				# print number at $a0
	
	
	
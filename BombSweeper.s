.data
#Minefield declaration
##################################################################
  R_1: .word 0, 0, 0, 0, 0, 0
  R_2: .word 0, 0, 0, 0, 0, 0
  R_3: .word 0, 0, 0, 0, 0, 0
  R_4: .word 0, 0, 0, 0, 0, 0
  R_5: .word 0, 0, 0, 0, 0, 0
  R_6: .word 0, 0, 0, 0, 0, 0
  B_1: .word 0, 0, 0, 0, 0, 0
  B_2: .word 0, 0, 0, 0, 0, 0
  B_3: .word 0, 0, 0, 0, 0, 0
  B_4: .word 0, 0, 0, 0, 0, 0
  B_5: .word 0, 0, 0, 0, 0, 0
  B_6: .word 0, 0, 0, 0, 0, 0
#program variables
######################################################################
x_bound: .word 6
y_bound: .word 6
iterator: .word 0
max: .word 6
bombs: .word 0
total_bombs: .word 6
lives: .word 3

#strings
############################################################################
####
greeting: .asciiz "~~ *BombSweeper* ~~\n"
goodbye: .asciiz "~~ Thanks for playing!\n"
x_msg: .asciiz "~~ Input an x coordinate (1-6): "
y_msg: .asciiz "~~ Input a y coordinate (1-6): "
bomb_hit: .asciiz "You hit a bomb! Lose 1 life \n"
header: .asciiz "Lives: "
grid: .asciiz "GRID | 1 | | 2 | | 3 | | 4 | | 5 | | 6 |\n"
G_0: .asciiz "| 0 |"
G_1: .asciiz "| 1 |"
G_2: .asciiz "| 2 |"
G_3: .asciiz "| 3 |"
G_4: .asciiz "| 4 |"
G_5: .asciiz "| 5 |"
G_6: .asciiz "| 6 |"
G_B: .asciiz "| * |"
G_E: .asciiz "|{ }|"
G_C: .asciiz "| |"
space: .asciiz " "
newline: .asciiz "\n"
############################################################################
##############
.text
########
# Main #
########
############################################################################
##############
main:
li $s6, 3 # # of lives held in $s6
jal Generate_field
#print greeting
li $v0, 4
la $a0, greeting
syscall
#print newline
li $v0, 4
la $a0, newline
syscall
jal User
#############
# EXIT MAIN #
#############
exit_main:
li $v0, 4
la $a0, goodbye
syscall
li $v0, 10
syscall
############################################################################
##############
##################
# Generate Field # // places a bomb in a random index of each row
#R: $t0 - 4, $a0, $a1
##################
Generate_field:
#R1
la $t0, R_1
li $v0, 42 #randnum call
li $a1, 7 #randnum upper bound
syscall
move $t3, $a0 #move randnum to $t3
mul $t3, $t3, 4
add $t0, $t0, $t3
li $t4, 9
sw $t4, 0($t0)
#R2
la $t0, R_2
li $v0, 42 #randnum call
li $a1, 7 #randnum upper bound
syscall
move $t3, $a0 #move randnum to $t3
mul $t3, $t3, 4
add $t0, $t0, $t3
li $t4, 9
sw $t4, 0($t0)
#R3
la $t0, R_3
li $v0, 42 #randnum call
li $a1, 7 #randnum upper bound
syscall
move $t3, $a0 #move randnum to $t3
mul $t3, $t3, 4
add $t0, $t0, $t3
li $t4, 9
sw $t4, 0($t0)
#R4
la $t0, R_4
li $v0, 42 #randnum call
li $a1, 7 #randnum upper bound
syscall
move $t3, $a0 #move randnum to $t3
mul $t3, $t3, 4
add $t0, $t0, $t3
li $t4, 9
sw $t4, 0($t0)
#R5
la $t0, R_5
li $v0, 42 #randnum call
li $a1, 7 #randnum upper bound
syscall
move $t3, $a0 #move randnum to $t3
mul $t3, $t3, 4
add $t0, $t0, $t3
li $t4, 9
sw $t4, 0($t0)
#R6
la $t0, R_6
li $v0, 42 #randnum call
li $a1, 7 #randnum upper bound
syscall
move $t3, $a0 #move randnum to $t3
mul $t3, $t3, 4
add $t0, $t0, $t3
li $t4, 9
sw $t4, 0($t0)
jr $ra #end Generate_field
############################################################################
##############
##################
# Print function # // Prints the field with all mines showing
##################
Print_field:
li $v0, 4
la $a0, grid # displays coordinate grid
syscall
li $v0, 4
la $a0, G_1
syscall
li $v0, 4
la $a0, space
syscall
la $t0, R_1
lw $t1, iterator
lw $t2, max
# R_1
printR_1:
beq $t1, $t2, stopR_1 # loop breaks when t1 = t2
mul $t3, $t1, 4 # mul iterator by 4, store in $t3
add $t3, $t3, $t0 # add iterator to adress of R_1, store in $t3
lw $t4,0($t3) #loads value held in $t3 to $t4
beq $t4, 0, R_1printe #if array val is 0 print empty cell
beq $t4, 1, R_1printc #if array val is 1, cell has been checked, print empty
beq $t4, 9, R_1printb #if array val is 9 print bomb cell
R_1printe:
addi $sp, $sp, 4
sw $ra, ($sp)
li $v0, 4
la $a0, G_E
lw $ra, 0($sp)
addi $sp, $sp -4
syscall
j R_1_cont
R_1printc:
addi $sp, $sp, 4
sw $ra, ($sp)
li $v0, 4
la $a0, G_C
lw $ra, 0($sp)
addi $sp, $sp -4
syscall
j R_1_cont
R_1printb:
addi $sp, $sp, 4
sw $ra, ($sp)
li $v0, 4
la $a0, G_B
lw $ra, 0($sp)
addi $sp, $sp -4
syscall
j R_1_cont
R_1_cont:
li $v0, 4
la $a0, space
syscall
addi $t1, $t1, 1
j printR_1
stopR_1:
li $v0, 4
la $a0, newline
syscall
li $v0, 4
la $a0, G_2
syscall
li $v0, 4
la $a0, space
syscall
# R_2
la $t0, R_2
lw $t1, iterator
lw $t2, max
printR_2:
beq $t1, $t2, stopR_3 # loop breaks when t1 = t2
mul $t3, $t1, 4 # mul iterator by 4, store in $t3
add $t3, $t3, $t0 # add iterator to adress of R_1, store in $t3
lw $t4,0($t3) #loads value held in $t3 to $t4
beq $t4, 0, R_3printe #if array val is 0 print empty cell
beq $t4, 1, R_2printc #if array val is 1, cell has been checked, print empty
beq $t4, 9, R_2printb #if array val is 9 print bomb cell
R_2printe:
addi $sp, $sp, 4
sw $ra, ($sp)
li $v0, 4
la $a0, G_E
lw $ra, 0($sp)
addi $sp, $sp -4
syscall
j R_2_cont
R_2printc:
addi $sp, $sp, 4
sw $ra, ($sp)
li $v0, 4
la $a0, G_C
lw $ra, 0($sp)
addi $sp, $sp -4
syscall
j R_2_cont
R_2printb:
addi $sp, $sp, 4
sw $ra, ($sp)
li $v0, 4
la $a0, G_B
lw $ra, 0($sp)
addi $sp, $sp -4
syscall
j R_2_cont
R_2_cont:
li $v0, 4
la $a0, space
syscall
addi $t1, $t1, 1
j printR_2
stopR_2:
li $v0, 4
la $a0, newline
syscall
li $v0, 4
la $a0, G_3
syscall
li $v0, 4
la $a0, space
syscall
# R_3
la $t0, R_3
lw $t1, iterator
lw $t2, max
printR_3:
beq $t1, $t2, stopR_3 # loop breaks when t1 = t2
mul $t3, $t1, 4 # mul iterator by 4, store in $t3
add $t3, $t3, $t0 # add iterator to adress of R_1, store in $t3
lw $t4,0($t3) #loads value held in $t3 to $t4
beq $t4, 0, R_3printe #if array val is 0 print empty cell
beq $t4, 1, R_3printc #if array val is 1, cell has been checked, print empty
beq $t4, 9, R_3printb #if array val is 9 print bomb cell
R_3printe:
addi $sp, $sp, 4
sw $ra, ($sp)
li $v0, 4
la $a0, G_E
lw $ra, 0($sp)
addi $sp, $sp -4
syscall
j R_3_cont
R_3printc:
addi $sp, $sp, 4
sw $ra, ($sp)
li $v0, 4
la $a0, G_C
lw $ra, 0($sp)
addi $sp, $sp -4
syscall
j R_3_cont
R_3printb:
addi $sp, $sp, 4
sw $ra, ($sp)
li $v0, 4
la $a0, G_B
lw $ra, 0($sp)
addi $sp, $sp -4
syscall
j R_3_cont
R_3_cont:
li $v0, 4
la $a0, space
syscall
addi $t1, $t1, 1
j printR_3
stopR_3:
li $v0, 4
la $a0, newline
syscall
li $v0, 4
la $a0, G_4
syscall
li $v0, 4
la $a0, space
syscall
# R_4
la $t0, R_4
lw $t1, iterator
lw $t2, max
printR_4:
beq $t1, $t2, stopR_4 # loop breaks when t1 = t2
mul $t3, $t1, 4 # mul iterator by 4, store in $t3
add $t3, $t3, $t0 # add iterator to adress of R_1, store in $t3
lw $t4,0($t3) #loads value held in $t3 to $t4
beq $t4, 0, R_4printe #if array val is 0 print empty cell
beq $t4, 1, R_4printc #if array val is 1, cell has been checked, print empty
beq $t4, 9, R_4printb #if array val is 9 print bomb cell
R_4printe:
addi $sp, $sp, 4
sw $ra, ($sp)
li $v0, 4
la $a0, G_E
lw $ra, 0($sp)
addi $sp, $sp -4
syscall
j R_4_cont
R_4printc:
addi $sp, $sp, 4
sw $ra, ($sp)
li $v0, 4
la $a0, G_C
lw $ra, 0($sp)
addi $sp, $sp -4
syscall
j R_4_cont
R_4printb:
addi $sp, $sp, 4
sw $ra, ($sp)
li $v0, 4
la $a0, G_B
lw $ra, 0($sp)
addi $sp, $sp -4
syscall
j R_4_cont
R_4_cont:
li $v0, 4
la $a0, space
syscall
addi $t1, $t1, 1
j printR_4
stopR_4:
li $v0, 4
la $a0, newline
syscall
li $v0, 4
la $a0, G_5
syscall
li $v0, 4
la $a0, space
syscall
# R_5
la $t0, R_5
lw $t1, iterator
lw $t2, max
printR_5:
beq $t1, $t2, stopR_5 # loop breaks when t1 = t2
mul $t3, $t1, 4 # mul iterator by 4, store in $t3
add $t3, $t3, $t0 # add iterator to adress of R_1, store in $t3
lw $t4,0($t3) #loads value held in $t3 to $t4
beq $t4, 0, R_5printe #if array val is 0 print empty cell
beq $t4, 1, R_5printc #if array val is 1, cell has been checked, print empty
beq $t4, 9, R_5printb #if array val is 9 print bomb cell
R_5printe:
addi $sp, $sp, 4
sw $ra, ($sp)
li $v0, 4
la $a0, G_E
lw $ra, 0($sp)
addi $sp, $sp -4
syscall
j R_5_cont
R_5printc:
addi $sp, $sp, 4
sw $ra, ($sp)
li $v0, 4
la $a0, G_C
lw $ra, 0($sp)
addi $sp, $sp -4
syscall
j R_5_cont
R_5printb:
addi $sp, $sp, 4
sw $ra, ($sp)
li $v0, 4
la $a0, G_B
lw $ra, 0($sp)
addi $sp, $sp -4
syscall
j R_5_cont
R_5_cont:
li $v0, 4
la $a0, space
syscall
addi $t1, $t1, 1
j printR_5
stopR_5:
li $v0, 4
la $a0, newline
syscall
li $v0, 4
la $a0, G_6
syscall
li $v0, 4
la $a0, space
syscall
# R_6
la $t0, R_6
lw $t1, iterator
lw $t2, max
printR_6:
beq $t1, $t2, stopR_6 # loop breaks when t1 = t2
mul $t3, $t1, 4 # mul iterator by 4, store in $t3
add $t3, $t3, $t0 # add iterator to adress of R_1, store in $t3
lw $t4,0($t3) #loads value held in $t3 to $t4
beq $t4, 0, R_6printe #if array val is 0 print empty cell
beq $t4, 1, R_6printc #if array val is 1, cell has been checked, print checked cell
beq $t4, 9, R_6printb #if array val is 9 print bomb cell
R_6printe:
addi $sp, $sp, 4
sw $ra, ($sp)
li $v0, 4
la $a0, G_E
lw $ra, 0($sp)
addi $sp, $sp -4
syscall
j R_6_cont
R_6printc:
addi $sp, $sp, 4
sw $ra, ($sp)
li $v0, 4
la $a0, G_C
lw $ra, 0($sp)
addi $sp, $sp -4
syscall
j R_6_cont
R_6printb:
addi $sp, $sp, 4
sw $ra, ($sp)
li $v0, 4
la $a0, G_B
lw $ra, 0($sp)
addi $sp, $sp -4
syscall
j R_6_cont
R_6_cont:
li $v0, 4
la $a0, space
syscall
addi $t1, $t1, 1
j printR_6
stopR_6:
li $v0, 4
la $a0, newline
syscall
jr $ra #end Print_field
############################################################################
##############
#####################
# Print User Field # // Prints the current state of the field
#####################
Print_user_field:
li $v0, 4
la $a0, grid # displays coordinate grid
syscall
li $v0, 4
la $a0, G_1
syscall
li $v0, 4
la $a0, space
syscall
# B_1
la $t0, B_1
lw $t1, iterator
lw $t2, max
printB_1:
beq $t1, $t2, stopB_1 # loop breaks when t1 = t2
mul $t3, $t1, 4 # mul iterator by 4, store in $t3
add $t3, $t3, $t0 # add iterator to adress of R_1, store in $t3
lw $t4,0($t3) #loads value held in $t3 to $t4
beq $t4, 0, B_1printe #if array val is 0 print empty cell
beq $t4, 1, B_1printc #if array val is 1, cell has been checked, print empty
beq $t4, 9, B_1printm
B_1printe:
addi $sp, $sp, 4
sw $ra, ($sp)
li $v0, 4
la $a0, G_E
lw $ra, 0($sp)
addi $sp, $sp -4
syscall
j B_1_cont
B_1printc:
addi $sp, $sp, 4
sw $ra, ($sp)
li $v0, 4
la $a0, G_C
lw $ra, 0($sp)
addi $sp, $sp -4
syscall
j B_1_cont
B_1printm:
addi $sp, $sp, 4
sw $ra, ($sp)
li $v0, 4
la $a0, G_B
lw $ra, 0($sp)
addi $sp, $sp -4
syscall
j B_1_cont
B_1_cont:
li $v0, 4
la $a0, space
syscall
addi $t1, $t1, 1
j printB_1
stopB_1:
li $v0, 4
la $a0, newline
syscall
li $v0, 4
la $a0, G_2
syscall
li $v0, 4
la $a0, space
syscall
# B_2
la $t0, B_2
lw $t1, iterator
lw $t2, max
printB_2:
beq $t1, $t2, stopB_2 # loop breaks when t1 = t2
mul $t3, $t1, 4 # mul iterator by 4, store in $t3
add $t3, $t3, $t0 # add iterator to adress of R_1, store in $t3
lw $t4,0($t3) #loads value held in $t3 to $t4
beq $t4, 0, B_2printe #if array val is 0 print empty cell
beq $t4, 1, B_2printc #if array val is 1, cell has been checked, print empty
beq $t4, 9, B_2printm
B_2printe:
addi $sp, $sp, 4
sw $ra, ($sp)
li $v0, 4
la $a0, G_E
lw $ra, 0($sp)
addi $sp, $sp -4
syscall
j B_2_cont
B_2printc:
addi $sp, $sp, 4
sw $ra, ($sp)
li $v0, 4
la $a0, G_C
lw $ra, 0($sp)
addi $sp, $sp -4
syscall
j B_2_cont
B_2printm:
addi $sp, $sp, 4
sw $ra, ($sp)
li $v0, 4
la $a0, G_B
lw $ra, 0($sp)
addi $sp, $sp -4
syscall
j B_2_cont
B_2_cont:
li $v0, 4
la $a0, space
syscall
addi $t1, $t1, 1
j printB_2
stopB_2:
li $v0, 4
la $a0, newline
syscall
li $v0, 4
la $a0, G_3
syscall
li $v0, 4
la $a0, space
syscall
# B_3
la $t0, B_3
lw $t1, iterator
lw $t2, max
printB_3:
beq $t1, $t2, stopB_3 # loop breaks when t1 = t2
mul $t3, $t1, 4 # mul iterator by 4, store in $t3
add $t3, $t3, $t0 # add iterator to adress of R_1, store in $t3
lw $t4,0($t3) #loads value held in $t3 to $t4
beq $t4, 0, B_3printe #if array val is 0 print empty cell
beq $t4, 1, B_3printc #if array val is 1, cell has been checked, print empty
beq $t4, 9, B_3printm
B_3printe:
addi $sp, $sp, 4
sw $ra, ($sp)
li $v0, 4
la $a0, G_E
lw $ra, 0($sp)
addi $sp, $sp -4
syscall
j B_3_cont
B_3printc:
addi $sp, $sp, 4
sw $ra, ($sp)
li $v0, 4
la $a0, G_C
lw $ra, 0($sp)
addi $sp, $sp -4
syscall
j B_3_cont
B_3printm:
addi $sp, $sp, 4
sw $ra, ($sp)
li $v0, 4
la $a0, G_B
lw $ra, 0($sp)
addi $sp, $sp -4
syscall
j B_3_cont
B_3_cont:
li $v0, 4
la $a0, space
syscall
addi $t1, $t1, 1
j printB_3
stopB_3:
li $v0, 4
la $a0, newline
syscall
li $v0, 4
la $a0, G_4
syscall
li $v0, 4
la $a0, space
syscall
# B_4
la $t0, B_4
lw $t1, iterator
lw $t2, max
printB_4:
beq $t1, $t2, stopB_4 # loop breaks when t1 = t2
mul $t3, $t1, 4 # mul iterator by 4, store in $t3
add $t3, $t3, $t0 # add iterator to adress of R_1, store in $t3
lw $t4,0($t3) #loads value held in $t3 to $t4
beq $t4, 0, B_4printe #if array val is 0 print empty cell
beq $t4, 1, B_4printc #if array val is 1, cell has been checked, print empty
beq $t4, 9, B_4printm
B_4printe:
addi $sp, $sp, 4
sw $ra, ($sp)
li $v0, 4
la $a0, G_E
lw $ra, 0($sp)
addi $sp, $sp -4
syscall
j B_4_cont
B_4printc:
addi $sp, $sp, 4
sw $ra, ($sp)
li $v0, 4
la $a0, G_C
lw $ra, 0($sp)
addi $sp, $sp -4
syscall
j B_4_cont
B_4printm:
addi $sp, $sp, 4
sw $ra, ($sp)
li $v0, 4
la $a0, G_B
lw $ra, 0($sp)
addi $sp, $sp -4
syscall
j B_4_cont
B_4_cont:
li $v0, 4
la $a0, space
syscall
addi $t1, $t1, 1
j printB_4
stopB_4:
li $v0, 4
la $a0, newline
syscall
li $v0, 4
la $a0, G_5
syscall
li $v0, 4
la $a0, space
syscall
# B_5
la $t0, B_5
lw $t1, iterator
lw $t2, max
printB_5:
beq $t1, $t2, stopB_5 # loop breaks when t1 = t2
mul $t3, $t1, 4 # mul iterator by 4, store in $t3
add $t3, $t3, $t0 # add iterator to adress of R_1, store in $t3
lw $t4,0($t3) #loads value held in $t3 to $t4
beq $t4, 0, B_5printe #if array val is 0 print empty cell
beq $t4, 1, B_5printc #if array val is 1, cell has been checked, print empty
beq $t4, 9, B_5printm
B_5printe:
addi $sp, $sp, 4
sw $ra, ($sp)
li $v0, 4
la $a0, G_E
lw $ra, 0($sp)
addi $sp, $sp -4
syscall
j B_5_cont
B_5printc:
addi $sp, $sp, 4
sw $ra, ($sp)
li $v0, 4
la $a0, G_C
lw $ra, 0($sp)
addi $sp, $sp -4
syscall
j B_5_cont
B_5printm:
addi $sp, $sp, 4
sw $ra, ($sp)
li $v0, 4
la $a0, G_B
lw $ra, 0($sp)
addi $sp, $sp -4
syscall
j B_5_cont
B_5_cont:
li $v0, 4
la $a0, space
syscall
addi $t1, $t1, 1
j printB_5
stopB_5:
li $v0, 4
la $a0, newline
syscall
li $v0, 4
la $a0, G_6
syscall
li $v0, 4
la $a0, space
syscall
# B_6
la $t0, B_6
lw $t1, iterator
lw $t2, max
printB_6:
beq $t1, $t2, stopB_6 # loop breaks when t1 = t2
mul $t3, $t1, 4 # mul iterator by 4, store in $t3
add $t3, $t3, $t0 # add iterator to adress of R_1, store in $t3
lw $t4,0($t3) #loads value held in $t3 to $t4
beq $t4, 0, B_6printe #if array val is 0 print empty cell
beq $t4, 1, B_6printc #if array val is 1, cell has been checked, print empty
beq $t4, 9, B_6printm
B_6printe:
addi $sp, $sp, 4
sw $ra, ($sp)
li $v0, 4
la $a0, G_E
lw $ra, 0($sp)
addi $sp, $sp -4
syscall
j B_6_cont
B_6printc:
addi $sp, $sp, 4
sw $ra, ($sp)
li $v0, 4
la $a0, G_C
lw $ra, 0($sp)
addi $sp, $sp -4
syscall
j B_6_cont
B_6printm:
addi $sp, $sp, 4
sw $ra, ($sp)
li $v0, 4
la $a0, G_B
lw $ra, 0($sp)
addi $sp, $sp -4
syscall
j B_6_cont
B_6_cont:
li $v0, 4
la $a0, space
syscall
addi $t1, $t1, 1
j printB_6
stopB_6:
li $v0, 4
la $a0, newline
syscall
jr $ra #end Print_user_field
####################################################################
#############
# User Turn #
#############
User:
beq $s6, $zero, end_User
li $v0, 4
la $a0, header
syscall
li $v0, 1 #at start of every turn, users lives are displayed
move $a0, $s6
syscall
li $v0, 4
la $a0, newline
syscall
addi $sp, $sp, 4
sw $ra, ($sp)
jal Print_user_field
lw $ra, 0($sp)
addi $sp, $sp -4
li $v0, 4
la $a0, newline
syscall
li $v0, 4
la $a0, x_msg
syscall
li $v0, 5
syscall
move $t8, $v0 # x_coord stored in $t8
subi $t8, $t8, 1
li $v0, 4
la $a0, y_msg
syscall
li $v0, 5
syscall
move $t9, $v0 # y-coord stored in $t9
li $v0, 4
la $a0, newline
syscall
beq $t9, 1, checkB_1
beq $t9, 2, checkB_2
beq $t9, 3, checkB_3
beq $t9, 4, checkB_4
beq $t9, 5, checkB_5
beq $t9, 6, checkB_6
checkB_1:
la $t5, R_1 #stores adress of 1st index of R_1
mul $t8, $t8, 4 # $t8 = $t8 * 4
add $t5, $t5, $t8 # adds $t8 to adress of B_1[0]
lw $t7, 0($t5)
beq $t7, 0, emptyB_1
beq $t7, 9, bombB_1
emptyB_1:
la $t5, B_1 #stores adress of 1st index of B_1
add $t5, $t5, $t8 # adds $t8 to adress of B_1[0]
li $t0, 1
sw $t0, 0($t5)
j User
bombB_1:
subi $s6, $s6, 1
la $t5, B_1
add $t5, $t5, $t8 # adds $t8 to adress of B_1[0]
li $t1, 9
sw $t1, 0($t5)
j User
checkB_2:
la $t5, R_2 #stores adress of 1st index of R_1
mul $t8, $t8, 4 # $t8 = $t8 * 4
add $t5, $t5, $t8 # adds $t8 to adress of B_1[0]
lw $t7, 0($t5)
beq $t7, 0, emptyB_2
beq $t7, 9, bombB_2
emptyB_2:
la $t5, B_2 #stores adress of 1st index of B_1
add $t5, $t5, $t8 # adds $t8 to adress of B_1[0]
li $t0, 1
sw $t0, 0($t5)
j User
bombB_2:
subi $s6, $s6, 1
la $t5, B_2
add $t5, $t5, $t8 # adds $t8 to adress of B_1[0]
li $t1, 9
sw $t1, 0($t5)
j User
checkB_3:
la $t5, B_3 #stores adress of 1st index of B_1
mul $t8, $t8, 4 # $t8 = $t8 * 4
add $t5, $t5, $t8 # adds $t8 to adress of B_1[0]
sw $t7, 0($t5)
beq $t7, 0, emptyB_3
beq $t7, 9, bombB_3
emptyB_3:
la $t5, B_3 #stores adress of 1st index of B_1
add $t5, $t5, $t8 # adds $t8 to adress of B_1[0]
li $t0, 1
sw $t0, 0($t5)
j User
bombB_3:
subi $s6, $s6, 1
la $t5, B_3
add $t5, $t5, $t8 # adds $t8 to adress of B_1[0]
li $t1, 9
sw $t1, 0($t5)
j User
checkB_4:
la $t5, B_4 #stores adress of 1st index of B_1
mul $t8, $t8, 4 # $t8 = $t8 * 4
add $t5, $t5, $t8 # adds $t8 to adress of B_1[0]
sw $t7, 0($t5)
beq $t7, 0, emptyB_4
beq $t7, 9, bombB_4
emptyB_4:
la $t5, B_4 #stores adress of 1st index of B_1
add $t5, $t5, $t8 # adds $t8 to adress of B_1[0]
li $t0, 1
sw $t0, 0($t5)
j User
bombB_4:
subi $s6, $s6, 1
la $t5, B_4
add $t5, $t5, $t8 # adds $t8 to adress of B_1[0]
li $t1, 9
sw $t1, 0($t5)
j User
checkB_5:
la $t5, B_5 #stores adress of 1st index of B_1
mul $t8, $t8, 4 # $t8 = $t8 * 4
add $t5, $t5, $t8 # adds $t8 to adress of B_1[0]
sw $t7, 0($t5)
beq $t7, 0, emptyB_5
beq $t7, 9, bombB_5
emptyB_5:
la $t5, B_5 #stores adress of 1st index of B_1
add $t5, $t5, $t8 # adds $t8 to adress of B_1[0]
li $t0, 1
sw $t0, 0($t5)
j User
bombB_5:
subi $s6, $s6, 1
la $t5, B_5
add $t5, $t5, $t8 # adds $t8 to adress of B_1[0]
li $t1, 9
sw $t1, 0($t5)
j User
checkB_6:
la $t5, B_6 #stores adress of 1st index of B_1
mul $t8, $t8, 4 # $t8 = $t8 * 4
add $t5, $t5, $t8 # adds $t8 to adress of B_1[0]
sw $t7, 0($t5)
beq $t7, 0, emptyB_6
beq $t7, 9, bombB_6
emptyB_6:
la $t5, B_6 #stores adress of 1st index of B_1
add $t5, $t5, $t8 # adds $t8 to adress of B_1[0]
li $t0, 1
sw $t0, 0($t5)
j User
bombB_6:
subi $s6, $s6, 1
la $t5, B_6
add $t5, $t5, $t8 # adds $t8 to adress of B_1[0]
li $t1, 9
sw $t1, 0($t5)
j User
end_User:
jr $ra
############################################################################
##################

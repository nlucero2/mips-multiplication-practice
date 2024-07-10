#	
#	File: multiplication_practice.s
#	Author: Nathan Lucero
#	
#	Purpose: Defines an assembly program that allows people to practice simple 
#	multiplication problems. A multiplication problem is printed to stdout  
#	using syscall 41 to generate random numbers (from [1,10]) for the  
#	multiplier and multiplicand. Then an integer is read from stdin using  
#	syscall 5. The number that was read in is compared to the correct answer, 
#	and using another random number (from [1,4]) one of eight response 
#	messages is printed to stdout (four correct messages and four incorrect 
#	messages). Then the user is given the option to keep practicing or exit 
#	the program.
#	
#	Usage: To run the program, use the MARS MIPS simulator, Mars4.5la.jar.
#	



#	*************** An overview of the code in C ***************
#
#	int main() {
#		
#		
#		int firstInteger;
#		int secondInteger;
#		int intAnswer;
#		int randomResponseInteger;
#		char exitChar = 'y';
#		
#		// main while loop for program
#		while (exitChar == 'y') {
#			
#			// get random numbers between 1 and 10
#			firstInteger = ((random() % 9) + 1));
#			secondInteger = ((random() % 9) + 1));
#			
#			// print the multiplication question
#			printf("\nHow much is ");
#			printf("%d", firstInteger);
#			printf(" times ");
#			printf("%d", secondInteger);
#			printf("?\n\n");
#			
#			//get answer from user
#			scanf("%d", &intAnswer);
#			
#			//get a random number, between 1 and 4, for the response
#			randomResponseInteger{ rand() % 4 + 1 };
#			
#			
#			//test the students answer
#			if (intAnswer == firstInteger * secondInteger) {
#				
#				// correct answer response switch
#				switch (randomResponseInteger) {
#					
#					case 1:
#						printf("\n\t\tVery good!\n");
#						break;
#						
#					case 2:
#						printf("\n\t\tExcellent!\n");
#						break;
#						
#					case 3:
#						printf("\n\t\tNice work!\n");
#						break;
#						
#					case 4:
#						printf("\n\t\tKeep up the good work!\n");
#						break;
#						
#					default:
#						printf("\n\t\tVery good!\n");
#						break;
#						
#				}// end switch
#				
#			} else {
#				
#				// incorrect answer response switch
#				switch (randomResponseInteger) {
#					
#					case 1:
#						printf("\n\t\tSorry, that is incorrect.\n");
#						break;
#						
#					case 2:
#						printf("\n\t\tUnfortunately, that is the wrong answer.\n");
#						break;
#						
#					case 3:
#						printf("\n\t\tThat was close, don't give up!\n");
#						break;
#						
#					case 4:
#						printf("\n\t\tNope, keep trying.\n");
#						break;
#						
#					default:
#						printf("\n\t\tNo. Please try again.\n");
#						break;
#						
#				}// end switch
#				
#			}// end if
#			
#			
#			// ask if they want to keep practicing
#			printf("\nWould you like to keep practicing?\n");
#			printf("Press 'y' for yes, or any other letter for no:  ");
#			
#			// get input from user
#			scanf(" %c", &exitChar);
#			
#		}// end while
#		
#		
#		// print farewell message
#		printf("\n\nGreat job!!! Come back for more practice.\n");
#		
#		
#		// return 0
#		return 0;
#		
#	}// end main
#
#	Registers used:
#		$s0 - firstInteger			(the first  random number, multiplier)
#		$s1 - secondInteger 		(the second random number, multiplicand)
#		$s3 - intAnswer				(the user's answer, from stdin)
#		$s4 - randomResponseInteger	(the third  random number, for response message)
#		$s5 - exitChar				(the char input from stdin, to stay or exit loop)
#		$t0 - temp values			(various miscelaneous temp values for comparisons)
#		

.data
multQuest1:
	.asciiz "How much is "
multQuest2:
	.asciiz " times "
multQuest3:
	.asciiz "?"

corrMess1:
	.asciiz "Very good!"
corrMess2:
	.asciiz "Excellent!"
corrMess3:
	.asciiz "Nice work!"
corrMess4:
	.asciiz "Keep up the good work!"

inCorrMess1:
	.asciiz "Sorry, that is incorrect."
inCorrMess2:
	.asciiz "Unfortunately, that is the wrong answer."
inCorrMess3:
	.asciiz "That was close, don't give up."
inCorrMess4:
	.asciiz "Nope, keep trying."

endText1:
	.asciiz "\nWould you like to keep practicing?\n"
endText2:
	.asciiz "Press 'y' for yes, or any other letter for no:  "

farewellText:
	.asciiz "\n\nGreat job!!! Come back for more practice.\n"

.text
.globl main
main:

#	char exitChar = 'y';
	addi	$s5,	$zero,	'y'				# $s5 = exitChar = 'y'

# // main while loop for program
#	while (exitChar == 'y')
WHILE_LOOP:
	addi	$t0,	$zero,	'y'				# $t0 = 'y', to compare with exitChar
	bne		$s5,	$t0,	WHILE_LOOP_END	# if (exitChar != 'y'), then jump to end of loop


# // get random numbers between 1 and 10
#	firstInteger = ((random() % 9) + 1));
	addi	$a1,	$zero,	10				# set the range upper bound to 9
	addi	$v0,	$zero,	42				# random int range syscall
	syscall
	
	add		$s0,	$zero,	$a0				# $s0 = firstInteger = a random number [0, 10)
	addi	$s0,	$s0,	1				# $s0 = firstInteger = a random number [1, 10]

#	secondInteger = ((random() % 9) + 1));
	addi	$a1,	$zero,	10				# set the range upper bound to 9
	addi	$v0,	$zero,	42				# random int range syscall
	syscall
	
	add		$s1,	$zero,	$a0				# $s1 = secondInteger = a random number [0, 10)
	addi	$s1,	$s1,	1				# $s1 = secondInteger = a random number [1, 10]
	

# // print the multiplication question
#	print a newline
	addi	$v0,	$zero,	11				# print_char('\n')
	addi	$a0,	$zero,	0xa
	syscall

#	print a newline
	addi	$v0,	$zero,	11				# print_char('\n')
	addi	$a0,	$zero,	0xa
	syscall


#	printf("How much is ");
	addi	$v0,	$zero,	4				# print_str(multQuest1)
	la		$a0,	multQuest1
	syscall

#	printf("%d", firstInteger);
	add		$a0, 	$zero,	$s0				# $a0 = $s0 = firstInteger
	addi	$v0,	$zero,	1				# print_int(firstInteger)
	syscall


#	printf(" times ");
	addi	$v0,	$zero,	4				# print_str(multQuest2)
	la		$a0,	multQuest2
	syscall


#	printf("%d", secondInteger);
	add		$a0, 	$zero,	$s1				# $a0 = $s1 = secondInteger
	addi	$v0,	$zero,	1				# print_int(secondInteger)
	syscall


#	printf("?");
	addi	$v0,	$zero,	4				# print_str(multQuest3)
	la		$a0,	multQuest3
	syscall

#	print a newline
	addi	$v0,	$zero,	11				# print_char('\n')
	addi	$a0,	$zero,	0xa
	syscall

#	print a newline
	addi	$v0,	$zero,	11				# print_char('\n')
	addi	$a0,	$zero,	0xa
	syscall

# //get answer from user
#	scanf("%d", &intAnswer);
	addi	$v0,	$zero,	5				# read int from stdin
	syscall

#	save $v0 in $s3
	add		$s3, 	$zero,	$v0				# $s3 = the int read from stdin


# //get a random number, between 1 and 4, for the response
#	randomResponseInteger{ rand() % 4 + 1 };
	addi	$a1,	$zero,	4				# set the range upper bound to 3
	addi	$v0,	$zero,	42				# random int range syscall
	syscall
	
	add		$s4,	$zero,	$a0				# $s4 = randomResponseInteger = a random number [0, 4)
	addi	$s4,	$s4,	1				# $s4 = randomResponseInteger = a random number [1, 4]


# //test the students answer
#	multiply the two random numbers together to get the result
	mult	$s0,	$s1						# multiply $s0 by $s1
	mflo	$t0								# $t0 = $s0 * $s1


#	if (intAnswer == firstInteger * secondInteger)
	bne		$s3,	$t0,	THE_ELSE		# if (intAnswer != (firstInteger * secondInteger)), then jump to THE_ELSE


# // correct answer response switch
#	switch (randomResponseInteger)
	addi	$t0,	$zero,	1				# $t0 = 1, for case comparisons
	beq		$s4,	$t0,	corrCase1		# if (randomResponseInteger == 1), then jump to corrCase1

	addi	$t0,	$zero,	2				# $t0 = 2, for case comparisons
	beq		$s4,	$t0,	corrCase2		# if (randomResponseInteger == 2), then jump to corrCase2

	addi	$t0,	$zero,	3				# $t0 = 3, for case comparisons
	beq		$s4,	$t0,	corrCase3		# if (randomResponseInteger == 3), then jump to corrCase3

	addi	$t0,	$zero,	4				# $t0 = 4, for case comparisons
	beq		$s4,	$t0,	corrCase4		# if (randomResponseInteger == 4), then jump to corrCase4


#	case 1:
corrCase1:

#	printf("\n\t\tVery good!\n");

#	print a newline
	addi	$v0,	$zero,	11				# print_char('\n')
	addi	$a0,	$zero,	0xa
	syscall

#	print a tab
	addi	$v0,	$zero,	9				# print_char('\t')
	addi	$a0,	$zero,	0xa
	syscall

#	print a tab
	addi	$v0,	$zero,	9				# print_char('\t')
	addi	$a0,	$zero,	0xa
	syscall

#	print the string
	addi	$v0,	$zero,	4				# print_str(corrMess1)
	la		$a0,	corrMess1
	syscall

#	print a newline
	addi	$v0,	$zero,	11				# print_char('\n')
	addi	$a0,	$zero,	0xa
	syscall

#	break;
	j		corrBreak						# jump to after switch

#	case 2:
corrCase2:

#	printf("\n\t\tExcellent!\n");

#	print a newline
	addi	$v0,	$zero,	11				# print_char('\n')
	addi	$a0,	$zero,	0xa
	syscall

#	print a tab
	addi	$v0,	$zero,	9				# print_char('\t')
	addi	$a0,	$zero,	0xa
	syscall
	
#	print a tab
	addi	$v0,	$zero,	9				# print_char('\t')
	addi	$a0,	$zero,	0xa
	syscall

#	print the string
	addi	$v0,	$zero,	4				# print_str(corrMess2)
	la		$a0,	corrMess2
	syscall

#	print a newline
	addi	$v0,	$zero,	11				# print_char('\n')
	addi	$a0,	$zero,	0xa
	syscall

#	break;
	j		corrBreak						# jump to after switch

#	case 3:
corrCase3:

#	printf("\n\t\tNice work!\n");

#	print a newline
	addi	$v0,	$zero,	11				# print_char('\n')
	addi	$a0,	$zero,	0xa
	syscall

#	print a tab
	addi	$v0,	$zero,	9				# print_char('\t')
	addi	$a0,	$zero,	0xa
	syscall
	
#	print a tab
	addi	$v0,	$zero,	9				# print_char('\t')
	addi	$a0,	$zero,	0xa
	syscall

#	print the string
	addi	$v0,	$zero,	4				# print_str(corrMess3)
	la		$a0,	corrMess3
	syscall

#	print a newline
	addi	$v0,	$zero,	11				# print_char('\n')
	addi	$a0,	$zero,	0xa
	syscall

#	break;
	j		corrBreak						# jump to after switch

#	case 4:
corrCase4:

#	printf("\n\t\tKeep up the good work!\n");

#	print a newline
	addi	$v0,	$zero,	11				# print_char('\n')
	addi	$a0,	$zero,	0xa
	syscall

#	print a tab
	addi	$v0,	$zero,	9				# print_char('\t')
	addi	$a0,	$zero,	0xa
	syscall
	
#	print a tab
	addi	$v0,	$zero,	9				# print_char('\t')
	addi	$a0,	$zero,	0xa
	syscall

#	print the string
	addi	$v0,	$zero,	4				# print_str(corrMess4)
	la		$a0,	corrMess4
	syscall

#	print a newline
	addi	$v0,	$zero,	11				# print_char('\n')
	addi	$a0,	$zero,	0xa
	syscall

#	break;
	j		corrBreak						# jump to after switch


corrBreak:

	j		THE_IF_IS_OVER					# jump past the else code
	
THE_ELSE:


# // incorrect answer response switch
#	switch (randomResponseInteger)
	addi	$t0,	$zero,	1				# $t0 = 1, for case comparisons
	beq		$s4,	$t0,	inCorrCase1		# if (randomResponseInteger == 1), then jump to inCorrCase1

	addi	$t0,	$zero,	2				# $t0 = 2, for case comparisons
	beq		$s4,	$t0,	inCorrCase2		# if (randomResponseInteger == 2), then jump to inCorrCase2

	addi	$t0,	$zero,	3				# $t0 = 3, for case comparisons
	beq		$s4,	$t0,	inCorrCase3		# if (randomResponseInteger == 3), then jump to inCorrCase3

	addi	$t0,	$zero,	4				# $t0 = 4, for case comparisons
	beq		$s4,	$t0,	inCorrCase4		# if (randomResponseInteger == 4), then jump to inCorrCase4


#	case 1:
inCorrCase1:

#	printf("\n\t\tSorry, that is incorrect.\n");

#	print a newline
	addi	$v0,	$zero,	11				# print_char('\n')
	addi	$a0,	$zero,	0xa
	syscall

#	print a tab
	addi	$v0,	$zero,	9				# print_char('\t')
	addi	$a0,	$zero,	0xa
	syscall
	
#	print a tab
	addi	$v0,	$zero,	9				# print_char('\t')
	addi	$a0,	$zero,	0xa
	syscall

#	print the string
	addi	$v0,	$zero,	4				# print_str(inCorrMess1)
	la		$a0,	inCorrMess1
	syscall

#	print a newline
	addi	$v0,	$zero,	11				# print_char('\n')
	addi	$a0,	$zero,	0xa
	syscall

#	break;
	j		inCorrBreak						# jump to after switch

#	case 2:
inCorrCase2:

#	printf("\n\t\tUnfortunately, that is the wrong answer.\n");

#	print a newline
	addi	$v0,	$zero,	11				# print_char('\n')
	addi	$a0,	$zero,	0xa
	syscall

#	print a tab
	addi	$v0,	$zero,	9				# print_char('\t')
	addi	$a0,	$zero,	0xa
	syscall
	
#	print a tab
	addi	$v0,	$zero,	9				# print_char('\t')
	addi	$a0,	$zero,	0xa
	syscall

#	print the string
	addi	$v0,	$zero,	4				# print_str(inCorrMess2)
	la		$a0,	inCorrMess2
	syscall

#	print a newline
	addi	$v0,	$zero,	11				# print_char('\n')
	addi	$a0,	$zero,	0xa
	syscall

#	break;
	j		inCorrBreak						# jump to after switch

#	case 3:
inCorrCase3:

#	printf("\n\t\tThat was close, don't give up.\n");

#	print a newline
	addi	$v0,	$zero,	11				# print_char('\n')
	addi	$a0,	$zero,	0xa
	syscall

#	print a tab
	addi	$v0,	$zero,	9				# print_char('\t')
	addi	$a0,	$zero,	0xa
	syscall
	
#	print a tab
	addi	$v0,	$zero,	9				# print_char('\t')
	addi	$a0,	$zero,	0xa
	syscall

#	print the string
	addi	$v0,	$zero,	4				# print_str(inCorrMess3)
	la		$a0,	inCorrMess3
	syscall

#	print a newline
	addi	$v0,	$zero,	11				# print_char('\n')
	addi	$a0,	$zero,	0xa
	syscall

#	break;
	j		inCorrBreak						# jump to after switch

#	case 4:
inCorrCase4:

#	printf("\n\t\tNope, keep trying.\n");

#	print a newline
	addi	$v0,	$zero,	11				# print_char('\n')
	addi	$a0,	$zero,	0xa
	syscall

#	print a tab
	addi	$v0,	$zero,	9				# print_char('\t')
	addi	$a0,	$zero,	0xa
	syscall
	
#	print a tab
	addi	$v0,	$zero,	9				# print_char('\t')
	addi	$a0,	$zero,	0xa
	syscall

#	print the string
	addi	$v0,	$zero,	4				# print_str(inCorrMess4)
	la		$a0,	inCorrMess4
	syscall

#	print a newline
	addi	$v0,	$zero,	11				# print_char('\n')
	addi	$a0,	$zero,	0xa
	syscall

#	break;
	j		inCorrBreak						# jump to after switch


inCorrBreak:

THE_IF_IS_OVER:


# // ask if they want to keep practicing
#	printf("\nWould you like to keep practicing?\n");
	addi	$v0,	$zero,	4				# print_str(endText1)
	la		$a0,	endText1
	syscall

#	printf("Press 'y' for yes, or any other letter for no: ");
	addi	$v0,	$zero,	4				# print_str(endText2)
	la		$a0,	endText2
	syscall


# // get input from user
#	scanf(" %c", &exitChar);
	addi	$v0,	$zero,	12				# read char from stdin
	syscall

#	save $v0 in $s5
	add		$s5, 	$zero,	$v0				# $s5 = exitChar = the char read from stdin


#	jump back to top of the loop to get a new question
	j		WHILE_LOOP						# jump to top of loop

WHILE_LOOP_END:


# // print farewell message
#	printf("\n\nGreat job!!! Come back for more practice.\n");
	addi	$v0,	$zero,	4				# print_str(farewellText)
	la		$a0,	farewellText
	syscall


#	*************** Task 1: int main() End ***************


#	sys_exit()
	addi	$v0,	$zero,	10				# exit (terminate execution) syscall
	syscall


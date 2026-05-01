#include <stdio.h>
#include <string.h>

#define BUFSIZE 1024

extern int addstr(char *a, char *b);
extern int is_palindromeASM(char *s);
extern int factstr(char *s);
extern void palindrome_check();

int fact(int n);
int is_palindromeC(char *s);

int fact(int n){
	if(n <= 1)
		return 1;
	return n * fact(n - 1);
}

int is_palindromeC(char *s){
	int i = 0;
	int j = strlen(s) - 1;

	while(i < j){
		if (s[i] != s[j])
			return 0;
		i++;
		j--;
	}
	return 1;
}


int main(){
	char choice[BUFSIZE];
	char buf1[BUFSIZE];
	char buf2[BUFSIZE];
	int  result;

	while(1){
		printf("\n1) Add two numbers together\n");
		printf("2) Test if a string is a palindrome (C -> ASM)\n");
		printf("3) Print the factorial of a number\n");
		printf("4) Test if a string is a palindrome (ASM -> C)\n");
		printf("\nEnter choice: ");

		if(fgets(choice, BUFSIZE, stdin) == NULL)
			break;
		if(choice[0] == '\n')
			break;

		if(choice[0] == '1'){
			printf("Enter first number: ")
			fgets(buf1, BUFSIZE, stdin);
			printf("Enter secomd number: ");
			fgets(buf2, BUFSIZE, stdin);

			buf1[strcspn(buf1, "\n")] = '\0';
			buf2[strcspn(buf2, "\n")] = '\0';

			result = addstr(buf1, buf2);
			printf("Result: %d\n", result);
		}

		else if (choice[0] == '2') {
			printf("Enter a string: ");
			fgets(buf1, BUFSIZE, stdin);
			buf1[strcspn(buf1, "\n")] = '\0';

			result = is_palindromeASM(buf1);
			if (result == 1)
				printf("It is a palindrome\n");
			else
				printf("It is NOT a palindrome\n");
		}

		else if (choice[0] == '3') {
			printf("Enter a number: ");
			fgets(buf1, BUFSIZE, stdin);
			buf1[strcspn(buf1, "\n")] = '\0';

			result = factstr(buf1);
			printf("Factorial: %d\n", result);
		}

		else if (choice[0] == '4') {
			palindrome_check();
		}
	}

	return 0;
}
}

#include "expr.h"
#include "stdfuncs.h"

enum
{
	NOTYPE = 256,
	EQ = 0,
	NEQ,
	NUM,

	//unary operators
	UA_POS,
	UA_NEG,
	LESS,
	GREATER,
	LESSEQ,
	GREATEREQ,
	AND,
	OR,
	NOT,
	BIT_AND,
	BIT_OR,
	BIT_XOR
};

typedef struct token
{
	int type;
	int32_t value;
} Token;

Token tokens[32];
int nr_token;

static inline bool tok_is_digit(char* str)
{
	bool res = true;
	while (*str)
	{
		if (*str >= '0' && *str <= '9')
			str++;
		else
		{
			res = false;
			break;
		}
	}
	return res;
}

static bool make_token(char* e)
{
	nr_token = 0;

	char* token = strtok(e, " ");
	while (token)
	{
		if (strcmp(token, "==") == 0)
			tokens[nr_token++].type = EQ;
		else if (strcmp(token, "!=") == 0)
			tokens[nr_token++].type = NEQ;
		else if (tok_is_digit(token))
		{
			tokens[nr_token].type = NUM;
			tokens[nr_token++].value = atoi(token);
		}
		else if (strcmp(token, "+") == 0)
			tokens[nr_token++].type = '+';
		else if (strcmp(token, "-") == 0)
			tokens[nr_token++].type = '-';
		else if (strcmp(token, "*") == 0)
			tokens[nr_token++].type = '*';
		else if (strcmp(token, "/") == 0)
			tokens[nr_token++].type = '/';
		else if (strcmp(token, "(") == 0)
			tokens[nr_token++].type = '(';
		else if (strcmp(token, ")") == 0)
			tokens[nr_token++].type = ')';
		else if (strcmp(token, "<") == 0)
			tokens[nr_token++].type = LESS;
		else if (strcmp(token, ">") == 0)
			tokens[nr_token++].type = GREATER;
		else if (strcmp(token, "<=") == 0)
			tokens[nr_token++].type = LESSEQ;
		else if (strcmp(token, ">=") == 0)
			tokens[nr_token++].type = GREATEREQ;
		else if (strcmp(token, "&&") == 0)
			tokens[nr_token++].type = AND;
		else if (strcmp(token, "||") == 0)
			tokens[nr_token++].type = OR;
		else if (strcmp(token, "!") == 0)
			tokens[nr_token++].type = NOT;
		else if (strcmp(token, "&") == 0)
			tokens[nr_token++].type = BIT_AND;
		else if (strcmp(token, "|") == 0)
			tokens[nr_token++].type = BIT_OR;
		else if (strcmp(token, "^") == 0)
			tokens[nr_token++].type = BIT_XOR;
		else
			return false;
		token = strtok(NULL, " ");
	}

	return true;
}

inline static bool is_unary(int op)
{
	return tokens[op].type == UA_POS || tokens[op].type == UA_NEG || tokens[op].type == NOT;
}

static void pre_process()  //process unary operators
{
	//printf("PreProcess\n");
	bool is_unary = true;

	for (int i = 0; i < nr_token; ++i)
	{
		if (tokens[i].type == '+')
		{
			if (is_unary)
				tokens[i].type = UA_POS;
			else
				is_unary = true;
		}
		else if (tokens[i].type == '-')
		{
			if (is_unary)
				tokens[i].type = UA_NEG;
			else
				is_unary = true;
		}
		else if (tokens[i].type == '/' || tokens[i].type == '(' || tokens[i].type == EQ || tokens[i].type == NEQ)
			is_unary = true;
		else
			is_unary = false;
	}
}

static bool check_parentheses(int p, int q)
{
	if (tokens[p].type != '(' || tokens[q].type != ')')
		return false;
	int cnt = 0;
	for (int i = p; i <= q; ++i)
	{
		if (cnt < 0)
			return false;
		if (tokens[i].type == '(')
			++cnt;
		else if (tokens[i].type == ')')
			--cnt;
	}
	return cnt == 0;
}

static uint32_t priority(char op_type)
{
	switch (op_type)
	{
	case EQ:
	case NEQ:
	case LESS:
	case GREATER:
	case LESSEQ:
	case GREATEREQ:
	case AND:
	case OR:
	case BIT_AND:
	case BIT_OR:
	case BIT_XOR:
		return 10;
	case '+':
	case '-':
	case NOT:
		return 11;
	case '*':
	case '/':
		return 12;
	case UA_POS:
	case UA_NEG:
		return 14;
	default:
		return 100;
	}
}

int static find_match_parentheses(int p, int q)
{
	for (int i = p + 1; i <= q; ++i)
		if (check_parentheses(p, i))
			return i;
	return -1;
}

static bool is_operator(char type)
{
	return type == '+' || type == '-' || type == '/' || type == '*'\
		|| type == UA_NEG || type == UA_POS\
		|| type == EQ || type == NEQ || type == GREATER || type == LESS || type == GREATEREQ || type == LESSEQ
		|| type == AND || type == NOT || type == OR
		|| type == BIT_AND || type == BIT_OR || type == BIT_XOR;
}

static int dominant_operator(int p, int q)
{
	int domin_op = -1;

	for (int i = p; i <= q; ++i)
	{
		if (tokens[i].type == '(')
		{
			i = find_match_parentheses(i, q); //jump to right parentheses
		}
		if (is_operator(tokens[i].type))
		{
			if (domin_op == -1 ||
				(priority(tokens[domin_op].type) >= priority(tokens[i].type) \
					&& (!is_unary(domin_op) || !is_unary(i))))
				domin_op = i;
		}
	}

	return domin_op;
}

#define eval_case_helper(op_name, op) \
    case op_name: \
        res = val1 op val2; \
        break;
static int32_t eval(int p, int q, bool* success)
{
	int32_t res = -1;
	*success = true;

	if (p > q)
	{
		*success = false;
	}
	else if (p == q)
	{
		if (tokens[p].type == NUM)
			res = tokens[p].value;
		else
			*success = false;
	}
	else if (check_parentheses(p, q))
		return eval(p + 1, q - 1, success);
	else
	{
		int op = dominant_operator(p, q);
		if (op == -1)
			*success = false;
		else
		{
			if (op == p && is_unary(op))
			{
				int32_t val = eval(op + 1, q, success);
				if (*success)
					switch (tokens[op].type)
					{
					case UA_POS:
						res = val;
						break;
					case UA_NEG:
						res = -val;
						break;
					case NOT:
						res = !res;
						break;
					default:
						*success = false;
					}
			}
			else
			{
				bool success_aux;
				int32_t val1 = eval(p, op - 1, success);
				int32_t val2 = eval(op + 1, q, &success_aux);
				*success &= success_aux;

				if (*success)
					switch (tokens[op].type)
					{
						eval_case_helper('+', +);
						eval_case_helper('-', -);
						case '*':
							res = __mulsi3(val1, val2);
							break;
						case '/':
							res = __udivsi3(val1, val2);
							break;
						eval_case_helper(EQ, == );
						eval_case_helper(NEQ, != );
						eval_case_helper(GREATER, > );
						eval_case_helper(LESS, < );
						eval_case_helper(LESSEQ, <= );
						eval_case_helper(GREATEREQ, >= );
						eval_case_helper(AND, &&);
						eval_case_helper(OR, || );
						eval_case_helper(BIT_AND, &);
						eval_case_helper(BIT_OR, | );
						eval_case_helper(BIT_XOR, ^);
					default:
						*success = false;
					}
			}
		}

	}

	return res;
}

int32_t calc_expr(char* e, bool* success)
{
	if (!make_token(e))
	{
		*success = false;
		return 0;
	}

	pre_process();

	return eval(0, nr_token - 1, success);
}
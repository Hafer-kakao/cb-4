%expect 0

%define api.parser.struct {Parser}
%define api.value.type {Value}
%define api.parser.check_debug { self.debug }

%define parse.error custom
%define parse.trace

%code use {
    // all use goes here
    use crate::{Token, C1Lexer as Lexer, Loc, Value};
}

%code parser_fields {
    errors: Vec<String>,
    /// Enables debug printing
    pub debug: bool,
}

%token
    AND           "&&"
    OR            "||"
    EQ            "=="
    NEQ           "!="
    LEQ           "<="
    GEQ           ">="
    LSS           "<"
    GRT           ">"
    KW_BOOLEAN    "bool"
    KW_DO         "do"
    KW_ELSE       "else"
    KW_FLOAT      "float"
    KW_FOR        "for"
    KW_IF         "if"
    KW_INT        "int"
    KW_PRINTF     "printf"
    KW_RETURN     "return"
    KW_VOID       "void"
    KW_WHILE      "while"
    CONST_INT     "integer literal"
    CONST_FLOAT   "float literal"
    CONST_BOOLEAN "boolean literal"
    CONST_STRING  "string literal"
    ID            "identifier"

// definition of association and precedence of operators
%left '+' '-' OR
%left '*' '/' AND
%nonassoc UMINUS

// workaround for handling dangling else
// LOWER_THAN_ELSE stands for a not existing else
%nonassoc LOWER_THAN_ELSE
%nonassoc KW_ELSE
%%

program: programh 
        {
            $$ = Value::None;
        }

    programh: declassignment ';' programh
            {
                $$ = Value::Lol;
            }
        | functiondefinition programh
            {
                $$ = Value::Lol;
            }
        |
            {
                $$ = Value::Lol;
            }

    functiondefinition: type id '(' parameterlist ')' '{' statementlist '}'
            {
                $$ = Value::Lol;
            }
        | type id '(' ')' '{' statementlist '}'
            {
                $$ = Value::Lol;
            }
    
    parameterlist: type id ',' parameterlist
            {
                $$ = Value::Lol;
            }
        | type id
            {
                $$ = Value::Lol;
            }

    functioncall: id '(' assignmentlist ')'
            {
                $$ = Value::Lol;
            }
        | id '(' ')'
            {
                $$ = Value::Lol;
            }

    assignmentlist: assignment ',' assignmentlist
            {
                $$ = Value::Lol;
            }
        | assignment
            {
                $$ = Value::Lol;
            }

    statementlist: block statementlist
            {
                $$ = Value::Lol;
            }
        | 
            {
                $$ = Value::Lol;
            }
    
    block: '{' statementlist '}'
            {
                $$ = Value::Lol;
            }
        | statement 
            {
                $$ = Value::Lol;
            }

    statement: ifstatement
            {
                $$ = Value::Lol;
            }
        | forstatement 
            {
                $$ = Value::Lol;
            }
        | whilestatement 
            {
                $$ = Value::Lol;
            }
        | returnstatement ';'
            {
                $$ = Value::Lol;
            }
        | dowhilestatement ';'
            {
                $$ = Value::Lol;
            }
        | printf ';'
            {
                $$ = Value::Lol;
            }
        | declassignment ';'
            {
                $$ = Value::Lol;
            }
        | statassignment ';'
            {
                $$ = Value::Lol;
            }
        | functioncall ';'
            {
                $$ = Value::Lol;
            }   

    ifstatement: KW_IF '(' assignment ')' block
            {
                $$ = Value::Lol;
            }

    forstatement: KW_FOR '(' statassignment ';' expr ';' statassignment ')' block
            {
                $$ = Value::Lol;
            } 
        | KW_FOR '(' declassignment ';' expr ';' statassignment ')' block
            {
                $$ = Value::Lol;
            }

    dowhilestatement: KW_DO block KW_WHILE '(' assignment ')'
            {
                $$ = Value::Lol;
            }

    whilestatement: KW_WHILE '(' assignment ')' block
            {
                $$ = Value::Lol;
            }

    returnstatement: KW_RETURN assignment
            {
                $$ = Value::Lol;
            }
        | KW_RETURN 
            {
                $$ = Value::Lol;
            }

    printf: KW_PRINTF '(' assignment ')'
            {
                $$ = Value::Lol;
            }
        | KW_PRINTF '(' CONST_STRING ')'
            {
                $$ = Value::Lol;
            }

    declassignment: type id '=' assignment
            {
                $$ = Value::Lol;
            }
        | type id
            {
                $$ = Value::Lol;
            }
    
    statassignment: id '=' assignment
            {
                $$ = Value::Lol;
            }

    assignment: id '=' assignment
            {
                $$ = Value::Lol;
            } 
        | expr 
            {
                $$ = Value::Lol;
            }

    expr: simpexpr comp simpexpr
            {
                $$ = Value::Lol;
            }
        | simpexpr
            {
                $$ = Value::Lol;
            }

    comp: EQ
            {
                $$ = Value::Lol;
            } 
        | NEQ
            {
                $$ = Value::Lol;
            }
        | LEQ
            {
                $$ = Value::Lol;
            }
        | GEQ
            {
                $$ = Value::Lol;
            }
        | LSS
            {
                $$ = Value::Lol;
            }
        | GRT
            {
                $$ = Value::Lol;
            }

    simpexpr: nterm simpexprfn

    nterm: '-' term
            {
                $$ = Value::Lol;
            }
        | term
            {
                $$ = Value::Lol;
            }

    simpexprfn: op1 term simpexprfn
            {
                $$ = Value::Lol;
            }
        | 
            {
                $$ = Value::Lol;
            }

    op1: '+' 
            {
                $$ = Value::Lol;
            }
        | '-'
            {
                $$ = Value::Lol;
            }
        | OR
            {
                $$ = Value::Lol;
            }

    term: factor termfn
            {
                $$ = Value::Lol;
            }

    termfn: op2 factor
            {
                $$ = Value::Lol;
            }
        | 
            {
                $$ = Value::Lol;
            }

    op2: '*' 
            {
                $$ = Value::Lol;
            }
        | '/'
            {
                $$ = Value::Lol;
            }
        | AND
            {
                $$ = Value::Lol;
            }

    factor: CONST_INT
            {
                $$ = Value::Lol;
            }
        | CONST_FLOAT
            {
                $$ = Value::Lol;
            }
        | CONST_BOOLEAN
            {
                $$ = Value::Lol;
            }
        | functioncall
            {
                $$ = Value::Lol;
            }
        | id
            {
                $$ = Value::Lol;
            }
        | '(' assignment ')'
            {
                $$ = Value::Lol;
            }


    type: KW_BOOLEAN
            { 
                $$ = Value::Lol;
            }
        | KW_FLOAT
            {
                $$ = Value::Lol;
            }
        | KW_INT
            {
                $$ = Value::Lol;
            }

    id: ID 
            {
                $$ = Value::Lol;
            }

%%

impl Parser {
    /// "Sucess" status-code of the parser
    pub const ACCEPTED: i32 = -1;

    /// "Failure" status-code of the parser
    pub const ABORTED: i32 = -2;

    /// Constructor
    pub fn new(lexer: Lexer) -> Self {
        // This statement was added to manually remove a dead code warning for 'owned_value_at' which is auto-generated code
        Self::remove_dead_code_warning();
        Self {
            yy_error_verbose: true,
            yynerrs: 0,
            debug: false,
            yyerrstatus_: 0,
            yylexer: lexer,
            errors: Vec::new(),
        }
    }

    /// Wrapper around generated `parse` method that also
    /// extracts the `errors` field and returns it.
    pub fn do_parse(mut self) -> Vec<String> {
        self.parse();
        self.errors
    }

    /// Retrieve the next token from the lexer
    fn next_token(&mut self) -> Token {
        self.yylexer.yylex()
    }

    /// Print a syntax error and add it to the errors field
    fn report_syntax_error(&mut self, stack: &YYStack, yytoken: &SymbolKind, loc: YYLoc) {
        let token_name = yytoken.name();
        let error = format!("Unexpected token {} at {:?}", token_name, loc);
        eprintln!("Stack: {}\nError: {}", stack, error);
        self.errors.push(error);
    }

    /// Helper function that removes a dead code warning, which would otherwise interfere with the correction of a submitted
    /// solution
    fn remove_dead_code_warning() {
    	let mut stack = YYStack::new();
    	let yystate: i32 = 0;
    	let yylval: YYValue = YYValue::new_uninitialized();
    	let yylloc: YYLoc = YYLoc { begin: 0, end: 0 };
        stack.push(yystate, yylval.clone(), yylloc);
    	let _ = stack.owned_value_at(0);
    }
}


# A LaTeX class for Number Sense exams


## Introduction

This a `\LaTeX` class to typeset exams like those used in the UIL Number Sense
competition. The author is Guillermo Garza. 

The purpose of this class is to allow exam writers to write exams as quickly as
possible with less hassle.


## Main Usage

Questions are enclosed in a `questions` environment and specified using the `\q`
or `\aq` macros.  These are used like the `\item` macro in the `enumerate`
environment.  There must be a blank line between questions. The `\aq` macro
creates questions that are number with an "*".   You can specify an optional
answer to each question by using the `\q[]` or `\aq[]` macros.  
        
```
    \begin{question}
        \q the first question.
        
        \q[answer to second question] the second question.

        \aq a starred question

    \end{question}
```


## Useful Macros

The `\title` and `\subtitle` macros let you set the title and subtitle.

```
    \title{Edinburg North High School}
    \subtitle{Number Sense Practice Test}
```

The `\instructions` macro lets you give your own instructions.  Leave this 
unused to keep the default instructions.

```
    \instructions{Hurry up! Take your time!}
```

The `\answerkey` macro enables printing of an answer key. This macro does not
take any parameters. Without this macro, an answer key will not be printed.

```
    \answerkey
```

The `\columns` and `\keycolumns` macros let you specify the number of columns
used to typeset the exam and answer key, respectively. 

```
    \columns{4}
    \keycolumns{6}
```

The `\ans` macro is a synonym for `\hrulefill`.  This is intended to be used to
create answer blanks.

            
The `\problemspacing` macro lets you specify the spacing for questions in the
exam. The default value is 1.2.  You can set this to smaller value to cram in
more problems per page.

```
    \problemspacing{1}
```

Additionally you can change change  the length  `\columnsep` to use more space
per problem.

```
    \setlength\columnsep{10pt}
```

The `\raggedcolumns` and `\columnbreak` macros can be used to control where
columns break and how they look. Using these allows the column breaks in the
exam to match those in the answer key.


## Workflow Tip

To get the answer key columns to match the exam columns, do not insert any
`\columnbreak` commands in rough drafts.  When you're done creating problems,
take note of where the columns break.  Then, place a `\columnbreak` macro after
the questions where the columns break.
 

from random import choice, randint, sample
from fractions import gcd

top_template = """
\\documentclass{numbersense}

\\title{PSJA High School}
\\subtitle{Number Sense Worksheet}
\\instructions{Hurry up! Take your time!}
\\answerkey

\\columns{4}
\\keycolumns{7}
\\problemspacing{0.8}

\\setlength\columnsep{10pt}

\\begin{document}
\\begin{questions}
"""

bottom_template = """
\\end{questions}
\\end{document}
"""


def foil():
    # random problems to multiply using foil method
    num1 = randint(11, 99)
    num2 = randint(11, 99)
    ans = num1 * num2
    text = "\\q[%d] $%d \\times %d = $\\ans\n\n" % (ans, num1, num2)
    return text


def hundreds_under():
    # problems of type 94 * 97
    num1 = randint(90, 99)
    num2 = randint(90, 99)
    ans = num1 * num2
    text = "\\q[%d] $%d \\times %d = $\\ans\n\n" % (ans, num1, num2)
    return text


def hundreds_over():
    # problems of type 104 * 109
    num1 = randint(101, 110)
    num2 = randint(101, 110)
    ans = num1 * num2
    text = "\\q[%d] $%d \\times %d = $\\ans\n\n" % (ans, num1, num2)
    return text


def ones_ten():
    # problems of type 34 * 36
    ones1 = randint(1, 9)
    tens1 = randint(1, 14)

    ones2 = 10 - ones1
    tens2 = tens1

    num1 = 10 * tens1 + ones1
    num2 = 10 * tens2 + ones2

    ans = num1 * num2
    text = "\\q[%d] $%d \\times %d = $\\ans\n\n" % (ans, num1, num2)

    return text


def tens_ten():
    # problems of type 43 * 63
    tens1 = randint(1, 9)
    ones1 = randint(1, 9)

    ones2 = ones1
    tens2 = 10 - tens1

    num1 = 10 * tens1 + ones1
    num2 = 10 * tens2 + ones2

    ans = num1 * num2
    text = "\\q[%d] $%d \\times %d = $\\ans\n\n" % (ans, num1, num2)

    return text


def triangle():
    num = randint(5, 21)
    ans = num * (num + 1) * 0.5
    text = "\\q[%d] $1 + 2 + 3 + \\cdots  + %d =$ \\ans\n\n" % (ans, num)
    return text


def elevens2():
    # problems involving multiplying two-digit numbers by 11
    num1 = randint(11, 99)
    num2 = 11

    num1, num2 = sample((num1, num2), 2)  # this shuffles num1 and num2

    ans = num1 * num2
    text = "\\q[%d] $%d \\times %d = $\\ans\n\n" % (ans, num1, num2)
    return text


def double_half():
    # problems like 15 * 28 or 35 * 24
    num1 = randint(9, 49)
    tens2 = choice((1, 3, 4))

    num1 = num1 * 2  # this should be an even number
    num2 = tens2 * 10 + 5

    num1, num2 = sample((num1, num2), 2)  # this shuffles num1 and num2

    ans = num1 * num2
    text = "\\q[%d] $%d \\times %d = $\\ans\n\n" % (ans, num1, num2)
    return text


def twentyfive():
    # multiplication involving 25
    num1 = randint(5, 99)
    num2 = 25

    num1, num2 = sample((num1, num2), 2)  # this shuffles num1 and num2

    ans = num1 * num2
    text = "\\q[%d] $%d \\times %d = $\\ans\n\n" % (ans, num1, num2)
    return text


questions = ""

for i in range(1, 251):
    question_type = [hundreds_over, hundreds_under, tens_ten, ones_ten,
                     elevens2, double_half, twentyfive]
    #question_type = [twentyfive]
    questions = questions + choice(question_type)()

worksheet = top_template + questions + bottom_template

print worksheet

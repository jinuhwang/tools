#!/usr/bin/env python
# coding: utf-8

# In[1]:


import re
from subprocess import Popen, PIPE

template_file = {
    '2': './test02.c',
    '3': './test03.c'
}

template = {}
givens = {}
for key in template_file:
    with open(template_file[key]) as f:
        template[key] = f.read()

    givens[key] = {}

def run_make_test(index=None, given=None, num=None):
    # ans = dict(answer[2])
    ans = answer[num].copy()
    if index is not None:
        if index == 'All':
            ans = givens[num]
        else:
            ans[index] = given
            givens[num][index] = given
            print('given:', given)

    formatted = template[num].format(**ans)
    # return subprocess.check_output(['make', 'test'], input=formatted)
    p = Popen(['make', 'test'], shell=True, stdout=PIPE, stdin=PIPE)
    ret =  p.communicate(input=formatted.encode())[0]
    return ret.decode()

def _compare_answer(given, answer):
    given = given.lower()
    answer = answer.lower()
    if given == answer:
        return True
    elif "".join(given.split()) == "".join(answer.split()):
        return True
    else:
        return False


def compare_answer(number, index, given, answer, interactive=True, make = False):
    print('Sub Question', index)
    if make:
        answer = make_answer
        given =  run_make_test(index, given, num=number)

    if _compare_answer(given, answer):
        print('Correct')
        return True, False
    print('='*8)
    print('          answer:', answer)
    print('submitted answer:', given)
    while interactive:
        key = input('correct? (o/x/q):')
        if key == 'o':
            return True, False
        if key == 'x':
            return False, False
        if key == 'q':
            return True, True

    return False, False



delimiters = [('(', ')'), ('', '.'), ('', ')')]

def grade(number, debug=False, interactive=True, make=False):
    sub = str(submission[number])
    ans = answer[number]
    line_iter = iter(sub.split('\n'))
    line = next(line_iter, None)
    result = []
    found = False
    for index in ans.keys():
        while line is not None:
            for delimiter in delimiters:
                if delimiter[0]+index+delimiter[1] in line:
                    submitted_answer = line[line.find(delimiter[1])+1:].strip()
                    ret, quit = compare_answer(number, index, submitted_answer, ans[index], interactive, make)
                    if quit:
                        return []
                    result.append(ret)
                    found = True
                    if make and index == 'E':
                        # If it's the last index
                        ret, _ = compare_answer(number, 'All', submitted_answer, ans[index], interactive, make)
                        result.append(ret)
                    break

            if found:
                found = False
                break
            if debug:
                print(line)
            line = next(line_iter, None)
    return result

# submssion in { number(int): 'submitted_answer'(str) } format
# answer in { number(int): { subnumber(int): 'submitted_answer'(str) } } format
# from submissions import submission
from answers import answer
import argparse
import pandas as pd

df = pd.read_csv('./submissions.csv', index_col='name')

parser = argparse.ArgumentParser(description='script to grade midterm')
parser.add_argument('--name', metavar='NAME', type=str, default=None, nargs='?')
parser.add_argument('--num', metavar='NUM', type=str, default=None, nargs='*',
                    help='specify the number of questions to be graded')

args = parser.parse_args()

print('question:', args.num)

if args.name is None:
    target = df.index
else:
    target = [args.name]


for name in target:
    submission = df.loc[name, :]
    print('='*20)
    print('Student:', name)
    print('='*20)
    input('Press any key to start grading')

    if not args.num:
        args.num= submission.keys()

    for num in sorted(args.num):
        num = str(num)
        if num == 'name':
            continue

        if num not in answer:
            print(num, 'not in answer')
            continue

        if num == '1':
            result = grade(num, interactive=False)
        elif num in ['2', '3']:
            make_answer = run_make_test(num=num)
            result = grade(num, make=True, interactive=False)
        else:
            result = grade(num)
        print('='*20)
        print('Question', num, 'result')
        print('='*20)
        for a, b in enumerate(result):
            print(a+1, b)
        input('Press any key for next result:')



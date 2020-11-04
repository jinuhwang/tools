#!/usr/bin/env python
# coding: utf-8

# In[1]:


import re


# In[2]:


def _compare_answer(given, answer):
    given = given.lower()
    answer = answer.lower()
    if given == answer:
        return True
    if all(a == b for a, b in zip(given.split(), answer.split())):
        return True
    elif "".join(given.split()) == "".join(answer.split()):
        return True
    else:
        return False


def compare_answer(index, given, answer):
    print('Question', index)
    if _compare_answer(given, answer):
        print('Correct')
        return True
    print('='*8)
    print('answer:', answer)
    print('submitted answer:', given)
    if input('correct? (o/x):') == 'o':
        return True

    return False


# In[3]:


delimiters = [('(', ')')]

def grade(number, debug=False):
    sub = submission[number]
    ans = answer[number]
    line_iter = iter(sub.split('\n'))
    line = next(line_iter, None)
    result = []
    found = False
    for index in ans.keys():
        while line is not None:
            for delimiter in delimiters:
                if delimiter[0]+index+delimiter[1] in line:
                    submitted_answer = line[line.find(')')+1:].strip()
                    result.append(compare_answer(index, submitted_answer, ans[index]))
                    found = True
                    break

            if found:
                found = False
                break
            if debug:
                print(line)
            line = next(line_iter, None)
    return result


# In[5]:


# submssion in { number(int): 'submitted_answer'(str) } format
# answer in { number(int): { subnumber(int): 'submitted_answer'(str) } } format
from submissions import submission, answer


# In[ ]:


for num in submission.keys():
    result = grade(num)
    print('='*10)
    print('Question', num, 'result')
    print('='*10)
    for a, b in enumerate(result):
        print(a+1, b)
    input('Press any key for next result:')



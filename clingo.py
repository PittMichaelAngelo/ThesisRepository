import subprocess
from itertools import groupby
import sys
import random

# Run python clingo.py <num of answers>

# name of the ASP files to run.
filenames = " " #give the names of the files to run

ans = sys.argv[1] #NUM OF ANSWERS. IF NEGATIVE, GENERATE RANDOM ANSWERS

print("Running: " + filenames + '\n')

#RUN CLINGO COMMAND
if (int(ans) >= int(0)):
    p1 = subprocess.run('clingo -n '+ str(ans) + ' ' + filenames, shell=True, capture_output=True, text=True)
else:
    p1 = subprocess.run('clingo -n '+ str(ans[1:]) + ' --rand-freq=1 --seed=' + str(random.randint(0, 32767))+ ' ' + filenames, shell=True, capture_output=True, text=True)

#prints and removes from output everything that happend at time i
def printTime(output,i):
    j=0
    fir=''
    holds=[]
    others=[]
    while j < (len(output)):
        if output[j].endswith(','+str(i)+')' ):
            if output[j].startswith('fires'):
                fir=(output[j])
            elif output[j].startswith('holds'):
                holds.append(output[j])
            else:
                others.append(output[j])
            output.remove(output[j])
            continue
        j+=1

    printholdsbonds(holds)
    for i in others:   
        print('\t' + i)
    print('\t' + fir) #prints fires at the end

def printSolution(output):
    #print organised result
    output.sort(reverse = False)
    i=0
    time = 'time(' + str(i) + ')'
    while time in output:
        print('\n>> ' + time + ':')
        output.remove(time)

        printTime(output,i)

        i+=1
        time = 'time(' + str(i) + ')'

    #Print extra time
    print('\n>> ' + time + ':')
    printTime(output,i)   

def printholdsbonds(hb):
    #holdsbonds alphabetical based on tokens
    k=0
    while k < len(hb):
        if(hb[k].startswith('holdsbonds')):
            temp1 = hb[k]
            x = temp1.split(",")
            if (x[1] > x[2]):
                hb[k] = x[0]+','+x[2]+','+x[1]+','+x[3]
        k+=1
    #remove duplicates
    res = [] 
    for l in hb: 
        if l not in res: 
            res.append(l) 
    for l in res:
        print('\t' + l)


def printFires(output):
    j=0
    a=[]
    while j < (len(output)):
        if output[j].startswith('fires'):
            a.append(output[j][::-1])
        j+=1
    a.sort() #sorts the reversed string to get firings
    for i in a:
        print(i[::-1])


#Capture the output
op=p1.stdout.split()

errors=[e for e in op if "error" in e]

if (len(errors)==0):
    #prints if the PN SATISFIABLE/UNSATISFIABLE
    if 'SATISFIABLE' in op:
        print('SATISFIABLE')
    else:
        print('UNSATISFIABLE')

    #split list in Lists containing each answer
    numAnswers = op.count('Answer:')
    print('Number of Answers Found: ' +str(numAnswers))
    result = [list(res) for k,res in groupby(op,lambda x:x=='Answer:') if not k]


    x=1
    while (x <= numAnswers):
        print('\n-------ANSWER ' + str(x) +'-------\n')
        printFires(result[x])
        printSolution(result[x])
        x+=1

    print('----------------------\n') 
    print(result[x-1])
else:   
    for e in errors:
        print(e+"\n")
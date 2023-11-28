CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'

echo 'before if'
# 2. use if to check
if [[ -f student-submission/ListExamples.java ]] # -f check if thing is file and exits
# echo 'in the loop'
then
    # I want to show error or some message to show that it find something
    echo 'we found the student file'
else
    echo "we don't find the files, so you got 0% on the submission"
    exit
fi

# 3. move the file
cp student-submission/ListExamples.java grading-area
cp TestListExamples.java grading-area
cp -r lib grading-area
cd grading-area/

# 4. Test it
javac -cp ".;lib/hamcrest-core-1.3.jar;lib/junit-4.13.2.jar" *.java
# $? sucess = 0, if it fail = non-0
if [[ $? -ne 0 ]] # for arithmetic comparsion instead of != => -ne and == => -eq
then
    echo 'Your java file have a problem and cannot complie: You got 5% grade'
    exit
fi

java -cp ".;lib/junit-4.13.2.jar;lib/hamcrest-core-1.3.jar" org.junit.runner.JUnitCore TestListExamples > result.txt
call=$?
echo "Check java complie:" $call # 0 = pass and 1 = fail

if [[ $call -eq 0 ]] # if [[ space - space ]]
then 
    echo "Congraduation you got full point"
    exit
else
    echo "Your code have some error, we will check the parial credit you will get"
    result=`grep "Tests run: " result.txt`
    echo $result
    total=${result:11:1}
    wrong=${result:25:1}
    echo $total
    echo $wrong
fi
# Grading first two git-clone and provide feedback 1. grade 2. provide feed back
# using if

#result=`grep -r "OK (1 test)" result.txt`
# echo "This is result: " $result


# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests

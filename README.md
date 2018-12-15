# homework2-logiquepreuve
2nd homework for "Logique et Preuve" class at Enseirb-MATMECA engineering school, about **palindromes**.

Subject: [palindrome.etd.pdf](docs/palindrome.etd.pdf)  
Course: [poly-if107-etd.pdf](docs/poly-if107-etd.pdf)

## Compile
Just run *make* to compile the code:

    git clone https://github.com/geckoflume/homework2-logiquepreuve
    cd homework2-logiquepreuve
    make

## Run
The *run* rule makes the code run with the word *"radar"* which starts at pos *0* and has a length of *5* chars:

    make run

You can also run the code with your own word:

    ./homework2 <word> <lower pos in word> <upper pos in word>

## Adhoc
The *adhoc* rule runs the adhoc software to get *proof obligations* for invariants in algorithms:

    make adhoc

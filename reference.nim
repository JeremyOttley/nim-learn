type
    rob = ref ob
    ob = object
        key: int

var ob1 = ob(key:42)
var ob2 = ob1 # makes a copy of ob1
ob2.key = 2

echo ob1.key # prints 42
echo ob2.key # prints 2


var rob1 = rob(key:42)
var rob2 = rob1 # rob2 now points to rob1

rob2.key = 2

echo rob1.key # prints 2
echo rob2.key # prints 2

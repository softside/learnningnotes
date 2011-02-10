
List makeList()
{
List current = new List();
current.value = 1;
current.next = makeList();
return current;
}


# Pass By Reference

## Objectives

1. Get a refresher on method scope in Ruby.
2. Learn how Ruby variables can differ from the objects to which they point.
3. Understand the concept of mutability in Ruby.

> `str = "Hello"`
>
> ...variables in Ruby (with a few exceptions, most notably variables bound to integers) don’t hold **object values**. `str` doesn’t contain “Hello”. Rather, `str` contains a **reference** to a string object. It’s the string object that has the characteristic of containing the letters that make up “Hello”.  
> —David Black, [*The Well Grounded Rubyist*](http://www.amazon.com/The-Well-Grounded-Rubyist-David-Black/dp/1933988657)

## Method Scope in Ruby

Let's take a moment to refresh our memory about method scope. In Ruby, methods create their own scope. By default, any variable from outside a method will be unavailable inside that method. In addition, local variables created inside a method "fall out of scope" (become unavailable) once we're outside that method.

### Unavailable Variables

Let's make Douglas Adams proud and save the coveted answer to everything (`42`) in a variable at the top of a file. Now, let's try to print it in a method:

``` ruby
the_answer_to_the_ultimate_question_of_life_the_universe_and_everything = 42

def print_the_answer
  puts the_answer_to_the_ultimate_question_of_life_the_universe_and_everything
end

print_the_answer
NameError: undefined local variable or method 'the_answer_to_the_ultimate_question_of_life_the_universe_and_everything' for main:Object
```

Why can't the method not see the answer? It's right there! It's because methods drop an imaginary "gate" around their environment, closing out all other local variables.

Hm, well what about a variable declared inside a method body?

``` ruby
def what_are_you_thinking_about?
  want = "Chocolate"
  need = "A drink"
  hear = "Someone in the kitchen"
  "nothing"
end
what_are_you_thinking_about? #=> "nothing"
want
NameError: undefined local variable or method 'want' for main:Object
```

We encounter a similar problem when going in the opposite direction.

## Opening The Gates

Methods can take arguments, and here lies something very curious. What happens if we pass a variable in as an argument to a method? What happens when that reference is mutated (changed)?

``` ruby
names = []

def add_to_roster(list_of_names, name)
  list_of_names << name
end

add_to_roster(names, "Steven")
add_to_roster(names, "Avi")
add_to_roster(names, "Joe")
names #=> ["Steven", "Avi", "Joe"]
```

Arguments act as a gateway into a method body, allowing a variable to be passed into its local scope from the external scope that calls the method.

*When you pass in a variable, you're not passing in a value. You're passing in a reference to an object*. If we send a message to that variable, such as `<<` ("shovel"), it's able to respond with its programmed instructions!

The "exit gate" is the method's `return`, which can pass a reference out from its internal local scope back to the scope that called the method. Refer back to the `what_are_you_thinking_about?` method definition above. We *did* actually get something back: the return object, in this case a string of `"nothing"`.

## Pass by Reference vs. Pass by Value

In Ruby, objects are either passed by value or passed by reference. Primitive data like integers, floats, fixnums, and symbols require a fixed, small amount of memory. Consequently, when you pass around an integer, you are passing around the *actual value*. Objects that can grow and change, like arrays and strings, are never a fixed size. They are instead always accessed by a reference pointer in order to save memory use in a program. Passing around objects means passing around this reference pointer.

## Mutability

Because passing by references allows the object to be of any size, objects like strings and arrays can change; they are said to be "mutable". This means that if you pass such a variable into a method, the method can operate on the value of that variable and change its value while still keeping the reference intact. 

Let's take a look: 

```ruby
def change_the_array(array, string)
  array << string
end

some_words = ["hi", "there"]
change_the_array(some_words, "quizmaster")

puts.array.inspect
  #=> ["hi", "there", "quizmaster"]

```

Since all arrays in Ruby are mutable, when we pass the variable `some_words` (which as a *reference* to an array) into the method `change_the_array`, the method *actually changes the array!*


On the other hand, variables bound to objects that are passed by value, like integers, are **not** mutable. This means that if you pass such a variable into a method, the method *cannot* operate on the original variable's value to change it. 

Let's take a look:

``` ruby
def age_me_by(start_age, age_amount)
  start_age = start_age + age_amount
end

age = 31

age_me_by(age, 60) #=> 91
age #=> 31
```

Here, when we passed the variable, `age`, into the method, `age_me_by`, we passed in the actual *value* of `31`, not a reference to `age`. Since variables that point to integers are not mutable, our method's attempt to change the value of `age` did not work, so when we return to the original scope, `age` *still* has a value of `31`. 

Here's a handy reference regarding different datatypes and their mutability:

| Data Type | Pass by... |
|:---------:|:----------:|
| string    | reference  |
| array     | reference  |
| hash      | reference  |
| integer   | value      |
| fixnum    | value      |
| float     | value      |
| boolean   | value      |


## Resources

* [Pass By Value vs. Pass By Reference](http://ahimmelstoss.github.io/blog/2014/06/11/pass-by-value-vs-pass-by-reference-in-ruby/)

# Pass By Reference

## Objectives

1. Get a refresher on method scope in Ruby
2. Learn how Ruby variables can differ from the objects they point to
3. Understand the concept of mutability in Ruby

> `str = "Hello"`

> ...variables in Ruby (with a few exceptions, most notably variables bound to integers) don’t hold __object values__. str doesn’t contain “Hello”. Rather, str contains a __reference__ to a string object. It’s the string object that has the characteristic of containing the letters that make up “Hello”.
> ### -David Black - The Well Grounded Rubyist

## Method Scope in Ruby
Let's take a moment to refresh our membory about method scope. Methods in ruby create their own scope. Any local variable created outside of a method will be unavailable inside of a method. In addition, local variables created inside a method 'fall out of scope' once you're outside the method.

### Unavailable variable

``` ruby
the_answer_to_the_ultimate_question_of_life_the_universe_and_everything = 42

def print_the_answer
  puts the_answer_to_the_ultimate_question_of_life_the_universe_and_everything
end

print_the_answer
NameError: undefined local variable or method 'the_answer_to_the_ultimate_question_of_life_the_universe_and_everything' for main:Object

```

What!? How can you not see the answer?! It's there!
Methods drop an imaginary gate around their environment, closing out all other local variables.

### The other way

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

Same deal.

## Opening the gates

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

I know, I know. You just read about how there's this scope gate and stuff, but this makes total sense.

*When you pass in a variable, you're not passing in a value. You're passing in a reference to an object*. If you have that reference, and send a message to it, such as `#<<`, it's going to respond with its programmed instructions!

## Pass by Reference vs. Pass by Value

In previous lessons, we've learned that calling the `.each` iteration method on a collection, like an array, will return the original collection. Check it out: 

```ruby
array = [2, 4, 6]
array.each do |num|
	num * num 
end

  #=> [2, 4, 6]
```

But, there are exceptions to this rule. Watch this: 

```ruby
array = ["one", "two", "three"]
array.each do |word|
	word << "!"
end
  #=> ["one!", "two!", "three!"]
```

We just modified an array using `.each`! How is this possible? 

In Ruby, objects are either passed by value or passed by reference. Primitive data like integers, floats, fixnums, and symbols require a fixed, small amount of memory. Consequently, when you pass around an integer, you are passing and then operating on the *actual value*. Objects that can grow and change, like arrays and strings, are never a fixed size. They are instead always referenced by some pointer, in order to save memory use in a program.

**Thus, certain objects like strings and arrays are mutable within an `.each` method:**

On the other hand, **variables bound to integers are not mutable:**

``` ruby
age = 31
def age_me_by(start_age, age_amount)
  start_age = start_age + age_amount
end

age_me_by(age, 60) #=> 91
age #=> 31
```

## Resources

* [Pass By Value vs. Pass By Reference](http://ahimmelstoss.github.io/blog/2014/06/11/pass-by-value-vs-pass-by-reference-in-ruby/)

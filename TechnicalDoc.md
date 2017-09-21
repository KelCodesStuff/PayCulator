1. There are two big things going on in this single line of code, which declares and initializes maxLengths, a dictionary that stores the maximum lengths of text fields:
	▪	First, there’s the private declaration. In many programming languages, private means “accessible only inside the class”, but in Swift, private means “accessible only inside the source file where they’re defined”. Any code inside TextFieldMaxLengths.swift has access to maxLengths, and any code outside TextFieldMaxLengths.swift does not. By putting maxLengths in the same file as our UITextField extension, we get a place where we can store the maximum lengths of text fields (remember: extensions can only add methods, not properties), and by making it private, we keep other code from messing with it.
	▪	Then there’s the matter of what to use as the key for the maxLengths dictionary. Swift lets you use anything that conforms to the Hashable protocol as a dictionary key, and UITextField does just that. It makes sense to use the text fields themselves as the keys to the values for their maximum lengths.

2. Swift extensions let you add new functionality to existing classes, structs, enumerations, and protocols. We’re using an extension to UITextField to add two things:
	▪	maxLength, a property that lets the programmer set and get the maximum length of a text field, and
	▪	limitLength, a method called whenever the contents of a text field are changed, and limits the number of characters in that text field.

3. By marking the maxLength property with @IBInspectable, we make it available to Interface Builder, which then provides an editor for its value in the Attributes Inspector.

4. Get to know and love the guard statement and the “early return” style of programming; you’re going to see a lot of it in a lot of Swift coding. Here, we’re using guard to filter out cases where no maximum length has been defined for the text field, in which case, we simply return the theoretical maximum string size.

5. We use addTarget in maxLength‘s setter to ensure that if a text field is assigned a maximum length, the limitLength method is called whenever the text field’s contents change.

6. Another guard statement. Any case that gets past it is one where the text about to go into the text field is longer than the maximum length.

7. Cocoa sometimes likes to make things complicated. This line is the Cocoa way of saying “put the first maxLength characters of prospectiveText into text“. If you’re going to be playing with substrings, you need to get comfortable with Ranges and intervals.

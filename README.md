# textfieldtest

A flutter project to show uneven behavior( possible bug ) between `Material Texfied` and `CupertinoTexfield` . 
When appling a text maminpulation to its `TextEditingController` in `onChanged:` callback, and the workaround to make them behave the same.

## Problem:

When assign a modified text to `TextEditingController` to display it in the `Material Texfield` , in this case input text gets checked and modified to only accept time charcters adding `:`

 at proper position, `Material Textfield` cursor stays at first position, making the inputted text showing backwards. Not so in `CupertinoTexfield`.  



# textfieldtest

A flutter project to show uneven behavior( possible bug ) between Material Texfied and CupertinoTexfield, when appling a text maminpulation to its TextfieldController in `onChanged:` callback, and the workaround to make them beave the same.

## Problem:

When assign a modified text to Material Textfield controller to display it in the Texfield, in this case inputted text gets checked and modified to only accept time charcters adding `:`

 at proper position, cursor stays at first position, making the inputted text showing backwards. Not so in CupertinoTexfield.  



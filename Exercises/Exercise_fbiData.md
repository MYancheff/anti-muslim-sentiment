MDSR Exercise 1
================
Theodore Dounias
May 6, 2017

Data Manipulation
-----------------

If is quite often that, when dealing with data, you might find yourself faced with the daunting task of reading in a particularly disorganized or weirdly formatted dataset. Take for example the following, which is in a vector format containing strings:

This is a part of the FBI Uniform Report on hate crimes, in the year 2013. Each line represents either a reporting agency, or a hate crime incident. When a reporting agency reports a hate crime, it is listed under it. Each character, or subsets of the characters, are a specific variable. For example, characters 3-6 represent the state code and state abbreviation of either the agency or the incident. In this exercise, we will look at how we might set ourselves up in a favorable position to be able to tackle data such as this.

*Question 1*
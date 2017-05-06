MDSR Exercise 1
================
Theodore Dounias
May 6, 2017

Data Manipulation
-----------------

If is quite often that, when dealing with data, you might find yourself faced with the daunting task of reading in a particularly disorganized or weirdly formatted dataset. Take for example the following, which is in a vector format containing strings:

``` r
print(full_fbi[10:20])
```

    ##  [1] "BH01AL00107001991043019910101MIDFIELD                      AL6 631N         3070010NA        000005310037098000005392000000000      000000000000000000      000000000000000000      000000000000000000      0000000002013        MIDFIELD                      073"   
    ##  [2] "BH01AL00108001991043019910101BIRMINGHAM                    AL6 631N         3070010NA        000006323037098000006427000000000      000000000000000000      000000000000000000      000000000000000000      0000000002013ZZZZ    TARRANT                       073"   
    ##  [3] "BH01AL00109001991043019910101BIRMINGHAM                    AL4 631N         3070010NA        000034091037098000034181000000012059098000000014000000000      000000000000000000      000000000000000000      0000000002013        VESTAVIA HILLS                073117"
    ##  [4] "BH01AL00110001991043019910101BIRMINGHAM                    AL4 631N         3070010NA        000025299037098000025284000000000      000000000000000000      000000000000000000      000000000000000000      0000000002013        HOMEWOOD                      073"   
    ##  [5] "BH01AL00111001991043019910101FULTONDALE                    AL6 631N         3070010NA        000008633037098000008421000000000      000000000000000000      000000000000000000      000000000000000000      0000000002013        FULTONDALE                    073"   
    ##  [6] "BH01AL00112001991043019910101HOOVER                        AL3 631Y         3070010NA        000060284037098000058860000023855059098000023472000000000      000000000000000000      000000000000000000      0000000002013ZIZZ    HOOVER                        073117"
    ##  [7] "IR01AL00112002W100U7 S42820130423N200102M13C0012141I"                                                                                                                                                                                                                 
    ##  [8] "BH01AL00113001991043019910101IRONDALE                      AL5 631N         3070010NA        000012452037098000012407000000000      000000000000000000      000000000000000000      000000000000000000      0000000002013ZZZZ    IRONDALE                      073"   
    ##  [9] "BH01AL00114001991043019910101PLEASANT GROVE                AL5 631N         3070010NA        000010463037098000010158000000000      000000000000000000      000000000000000000      000000000000000000      0000000002013        PLEASANT GROVE                073"   
    ## [10] "BH01AL001150020001012        ROOSEVELT CITY                AL7 630NAL00100003070010N 20000101000000000037098000000000000000000      000000000000000000      000000000000000000      000000000000000000      0000000002013        ROOSEVELT CITY                073"   
    ## [11] "BH01AL00116001991043019910101GRAYSVILLE                    AL7 631N         3070010NA        000002143037098000002175000000000      000000000000000000      000000000000000000      000000000000000000      0000000002013        GRAYSVILLE                    073"

This is a part of the FBI Uniform Report on hate crimes, in the year 2013. Each line represents either a reporting agency, or a hate crime incident. When a reporting agency reports a hate crime, it is listed under it. Each character, or subsets of the characters, are a specific variable. For example, characters 3-6 represent the state code and state abbreviation of either the agency or the incident. In this exercise, we will look at how we might set ourselves up in a favorable position to be able to tackle data such as this. The data for this exercise is...somewhere.

#### Question 1

Create a function that discerns whether a line is a reporting agency, or an incident, and then divides the two into two other vectors. Some useful functions to remember here are: substr(), if().

#### Question 2

To create the final tidy dataset we need to have a way to extract a variable from each string in our vector. We need to create a function that does this, and returns a dataframe with a single column--the variable we want to add--which we would then bind to our whole dataframe. Write r script that reads 3-4 (State Code), and 5-13 (Agency ID) from the incidents vector you created into seperate dataframes, and then merge the, into a new df.

**BONUS:**Can you find a way to create the aforementioned function?

#### Question 3

Now you should have a dataframe with state code and the ID of the agency that reported. The data is already in a much more usable format--it should look like this:

    ##    Agency_ID State_code
    ## 1  AL0011100         AL
    ## 2  AL0011200         AL
    ## 3  AL0011200         AL
    ## 4  AL0011300         AL
    ## 5  AL0011300         AL
    ## 6  AL0011900         AL
    ## 7  AL0012200         AL
    ## 8  AL0012200         AL
    ## 9  AL0020500         AL
    ## 10 AL0020500         AL

We can already make some interesting observations! If you think about it, each line here represents an observation. Each observation is a hate crime incident. This means that we can figure out how many hate crimes hapened in each state! To do this, One way to do this is to use the mutate(), group\_by(), and summarize() functions available in the tidyverse. Which state had the highest amount of hate crimes? Can you make an educated guess as to why that is so?

**BONUS:**One of the necessary things we should do is figure out how many incidents each reporting agency reported; essentially we need to count how many lines begining with "IR" there are after each line beginning with "BH". To do this, one way is to implement a regressive function. Write a function that is able to return the exact number of incidents reported by each agency.

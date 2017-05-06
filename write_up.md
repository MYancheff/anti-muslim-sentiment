Media and Hate Crimes: Analyzing the Effect of Islamophobia in National Media on Anti-Muslim Hate Crimes  
================
Emily Clark, Theodore Dounias, Kristina Kutateli

Abstract
------------

Does anti-Muslim and Islamophobic rhetoric in mainstream media affect the incidence of religiously motivated anti-Muslim hate crimes? Using annual data from ReThink Media on the daily rate of Islamophobia in mainstream national news from 2011 to 2013, we analyze whether higher rates of anti-Muslim rhetoric correlate with more frequent incidences of anti-Muslim hate crimes as recorded by the FBI. While others have found statistical evidence of increased hate crime incidence following terrorist attacks, none have provided an empirical exploration of the effect of mainstream media rhetoric. If events are correlated with increased hate crime rates, how mainstream news sources cover those events may have serious implications for hate crime incidence. Controlling for county Muslim population, average level of education, median income, and base crime rate using Census data from TK year, we find that TK TK. Findings confirm TK. These results provide some of the first quantitative evidence that TK.   

Existing literature 
----------------------

The majority of the existing literature on specifically anti-Muslim hate crimes lacks empirical exploration of potential causes. King and Sutton (2013) provide one of the few studies of religiously motivated hate crimes that utilize statistical modelling. Hypothesizing that many hate crimes are retaliatory in nature and tend to increase dramatically in the aftermath of an event, they find that contentious trial verdicts and lethal terrorist attacks “precede spikes in racially or religiously motivated hate crimes.” Kaplan (2006) provided a clear-cut example of the effects of external threats on hate crime. Using FBI statistics, he showed a sharp spike in Islamophobic hate crime in the US immediately following the terrorist attacks in September 2001. Green et al. (1998) found correlations between demographic change (mainly rate of influx of ethnic minorities to predominantly white neighbourhoods) and hate crime incidents.   

Frost (2008) argues that British government policies affect the incidence of anti-Muslim hate crimes in the UK by cultivating a “climate of hostility” towards Muslim communities, yet provides a mostly theoretical basis for the argument and does not construct a statistical analysis for her claims. Poynting and Perry (2007) construct a comparative analysis of anti-Muslim hate crimes in Canada and Australia, contextualizing “the anti-Muslim vilification and victimisation within parallel - yet still distinct - political climates that bestow permission to hate.” Poynting and Perry argue that  “negative media portrayals, together with discriminatory rhetoric, policy and practices at the level of the state create an enabling environment that signals the legitimacy of public hostility toward the Muslim communities.” However, their paper lacks any kind of empirical or statistical analysis of data on anti-Muslim hate crimes.   


Our data  
--------

Our analysis uses three sets of data: Census data from TK year, NIBRS FBI hate crime data from 2011-2013, and ReThink Media’s 2011-2013 data on Islamophobia in mainstream national media.  

*Dependent variable: Hate crime incidence*  

State-level data on religiously-motivated anti-Muslim hate crimes is available from the Federal Bureau of Investigation’s Uniform Crime Reporting Program. On April 23, 1990, Congress passed the Hate Crime Statistics Act, 28 U.S.C. § 534, which required the Attorney General to collect data “about crimes that manifest evidence of prejudice based on race, religion, sexual orientation, or ethnicity.” Utilizing voluntary information from thousands of local and state law enforcement agencies, the UCR Program created a hate crime data collection to comply with the congressional mandate. Incident level data on hate crimes is available from the National Incident Based Reporting System (NIBRS).
The official reports filed with the FBI are regarded as the “best source of national hate crime data,” and they are used commonly by researchers analyzing hate crimes (Levy 2016). Hate crimes include murder, non-negligent manslaughter, rape, aggravated assault, simple assault, intimidation, robbery, burglary, larceny-theft, motor vehicle theft, arson, destruction, damage, vandalism, and crimes against society (Federal Bureau of Investigation 2012).
  
The data we received here was in a .txt format, and accompanied by a codebook explaining what each variable meant and where each one was. Each line in the .txt was either a reporting agency, or a hate crime incident; each character in that line was a different variable. Our job was to manage to transform it into a tidy .csv that could be one of the deliverables for our project.  We decided it was best to split the .txt into two .csv's, one for reporting agencies and the other for hate crime incidents, connected via the reporting agency ID Code. The resulting code is posted on our GitHub repo, and is openly available. What was essentially necessary was to write a nimber of functions to do each task necessary for the transform. These included: a function to count how many events were reported by every agency per year, a function to split each string into either active reporting agencies or incidents, and a function that inputs a character substring and then outputs a dataframe of a singular variable containing those values. After this process was finished, we joined the rows for each year for which we had data, and so had our finalized dataset ready.

*Independent variable: Rate of anti-Muslim rhetoric in mainstream media*  

To provide a measurement for the rate of anti-Muslim rhetoric in the media, we utilize ReThink Media's collected data on the level of Islamophobia in national, mainstream media (FOX news, New York Times, etc.). ReThink developed a search string that captures relevant news stories, pulling in news articles from a set list of national news outlets daily. Highlighting each quotation in each news article, ReThink then coded for the source (speaker), the message, and the sentiment of each quotation. Quotations coded as “Islamophobia” can range from problematic attitudes towards Muslims (e.g., Muslim communities must be partners to law enforcement in the war on terrorism) to outright bigotry (e.g., not all Muslims are terrorists but most terrorists are Muslim). We utilize media data from 2011 to 2013.  

*Controls*  
	
The population of Muslims in a given county might affect the incidence of hate crimes. In order to control for the population of Muslims in a county, we utilize Census data from 2010-2015 (see Appendix A for complete list of data source). While Census data provides this information for certain counties, the information is voluntarily reported and lacks data for some counties. We also use Census data to control for average level of education and median income. We include the average level of education and median income as a control for economic conditions because although the literature is mixed, some research finds a relationship between economic downturns and hate crimes (Beck and Tolnay 1990, Soule 1992).   
	
Crime incidence data is available from the FBI’s Uniform Crime Reporting Program and cover both violent crime and property crime, as well as reported hate crimes based on race/ethnicity, disability status, and sexuality. To the extent that reported hate crime fluctuations are due to general crime trends, the general crime measures should capture that. If, on the other hand, any relationships between anti-Muslim rhetoric and anti-Muslim hate crimes are spurious and capturing broad social trends in hate crimes, our other hate crime measures should capture that.  



Hypothesis and Methodology  
-------------------------

In order to bridge the gap between existing theoretical literature on anti-Muslim hate crimes (Poynting and Perry 2007; Frost 2008) and empirical observations, we test the following hypothesis:  

*H1. The incidence of religiously-motivated anti-Muslim hate crimes will increase with higher levels of anti-Muslim rhetoric in national mainstream media.*  

*Null H1: The incidence of religiously-motivated anti-Muslim hate crimes will not increase with higher levels of anti-Muslim rhetoric in national mainstream media.*  

To evaluate this hypothesis, we would use annual data from over three years (2011-2013) and rely on temporal correlation to identify the relationship between hate crime incidence and anti-Muslim sentiment. This is a common strategy to analyze the impact of events: Kaplan (2006) and King and Sutton (2013) utilize a similar method to test whether there is an increase in hate crime incidence following a terrorist attack. This type of hypothesis testing is, however, beyond the scope of this class. 
    
There are also some problems associated with the data that make this test unfeesible, or at least less possible to provide us with a true correlation. First, the data is not ranked by the severity of the rhetoric; thus it seems to be waited towards publictions like The Hill, or Politico, which rather than being the most intense in their anti-muslim rhetoric, just produce a large amount of stories that are more likely to contain some offhand mention that is perceived by the algorithm as damadging. Second, our hate crime data show a very small amount of anti-muslim hate crimes committed; most states report zero, and those that do not--such as New York, New Jersey, or California--are populous states with a large general amount of hatecrimes, making it hard to produce a definitive model. Lastly, even if we had better data for hate crimes, the anti-muslim rhetoric data is country-wide, which makes it significntly harder to test for how much regional factors come into play.
  
Instead of this model, we ran a set of different linear models trying to discern the relationship between anti-muslim hate crimes and factors such as median income, muslim population, education rates, and crime rates. The results from these models were inconclusive, probably due to the large amount of zeros in the hate crime data. Our results showed that only the general hate crime rate coefficient achieves statistical significance at any level, for any year, and that the general rate of hate crimes is closely correlated with the general population of the state, and the crime rates.

Our results here, of this very preliminary statistical analysis, by now means constitute a conclusive test of the data. However, through our project, we wish to offer the following results:

*Tidy hatecrime report data, and the code used to tidy the FBI datasets. This can be easily transformed to read in any uniform FBI reporting data, and represents a bulk of our work*

*Suggestions and observations on the data we had to work with. We have already offered parts of our analysis to ReThink Media, and believe that it presents several interesting points in which the data collection and analysis process might be streamlined*

*Tidyied census data, that can be easily reproduced and used in future projects*

*A github repository that reflects our work, and contains a large amount of handy visualizations and data transfigurations that might prove useful in the future*

Appendix   
  A. Census Data Source    
    1)	American Community Survey (ACS) 2011-2015 (5-Year Estimates)   
      a)	Population Data   
        i)	Total Population: SE_T002_001    
        ii)	Population Density: SE_T002_002   
      b)	Median Income   
        i)	Median Household Income (In 2015 Inflation  Adjusted Dollars): SE_T057_00    
    2)	UCR Crime Data 2010  
      a)	Violent Crime  
        i)	Number of Total Violent Crimes: SE_T004_001  
    3)	US Religion Data (RCMS) 2010  
      a)	Number of Muslim Adherents per State  
      b)	Number of Muslim Congregations per State  



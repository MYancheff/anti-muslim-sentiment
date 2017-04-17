Variables
================

### FBI data

*BATCHHEADER (Agency Information):*

3-4 NUMERIC STATE CODE  
This is a two-digit value assigned to the state and is used to place the records in order by this valeue for FBI purposes. Corresponds to state FIPS code.  

26-33 DATE ORI WAS ADDED  
This is the date that the Uniform Crime Reporting agency was added and/or had update activity performed on it by UCR staff.  

34-41 DATE ORI WENT NIBRS  
NIBRS (National Incident Based Reporting System) is also an incident-based reporting system also used by law enforcement agencies for collecting and reporting data on crimes to the FBI. While the UCR does not differentiate between completed and attempted crimes, NIBRS does. While UCR is a summary based reporting system, NIBRS reports criminal offenses at the incident level. The UCR collects data in a summary format also known as the aggregate or sum total methodology.  

42-71 CITY NAME   
The mailing address city for the agency.  

74-75 POPULATION GROUP  
This shows the population covered by the agency categorically. 1-7 are population groups for cities, 8-9 are for counties. 

76 COUNTRY DIVISION  
Geographic division in which the state is located (New England, Middle Atlantic, East North Central, West North Central, South Atlantic, East South Central, West South Central, West, Pacific).  

77 COUNTRY REGION  
Geographic region in which the country division is located. (North East, North Central, South, West).  

78 AGENCY INDICATOR
Distinguishes counties and colleges and universities from cities.  

79 CORE CITY  
Designates whether the agency is the core city of a Metropolitan Statistical Area  

93-96 JUDICIAL DISTRICT  
This is the code of the judicial district in which the agency is located.  

97 AGENCY NIBRS FLAG  
Whether the agency is an active NIBRS agency or not.

*(106-129 occurs 5 times, because some agencies are in as many as five different counties)*

106-114 CURRENT POPULATION  
Population for the agency, OR the population of the PORTION of the agency which is located in *this* county.

115-117 UCR COUNTY CODE 
UCR county code for the agency, or the county code for the portion of the agency which is located in the county.

268-270 FIPS COUNTY CODE  
Identical to UCR county code.  

118-120 MSA CODE  
Code of the metropolitan statistical area in which the agency is located.  

121-129 LAST POPULATION  
Last population of the agency according to the previous census.  

226-229 MASTER FILE YEAR  
The year of the data records.

230-233 STATE FIRST/SECOND/THIRD/FOUR QUARTER ACTIVITY

234-237 FEDERAL FIRST/SECOND/THIRD/FOURTH QUARTER ACTIVITY

268-282 FIPS COUNTY CODE (1-5)  
Repeats five times because agencies cover as many as five counties.  

*IR LEVEL:*

3-4 NUMERIC STATE CODE,  
FIPS code.

<<<<<<< HEAD
5-23 ORIGINATING AGENCY IDENTIFIER,  
Identifies agency under which the reported hate crime incident occured.  

23-33 INCIDENT DATE,
Date when incident occurred. Format: YYYYMMDD.

25 QUARTER OF THE YEAR,  
Quarter of the year in which the incident occurred (January-March, etc.)  
=======
5-13 ORIGINATING AGENCY IDENTIFIER,

26-33 INCIDENT DATE,

35 QUARTER OF THE YEAR,
>>>>>>> 3fc4b9b2b21b9a1ec157778e8aa11eb52c7f2f53

36-38 TOTAL NUMBER OF INDIVIDUAL VICTIMS,

39-40 TOTAL OFFENDERS,  
If 00, then nothing was known about the offenders involved.  

41 OFFENDERS RACE,  
(White, Black, American Indian/Alaskan Native, Asian/Pacific Islander, Multi-Racial Group, Unknown)  

42-221 TEN-OFFENSE GROUP INFORMATION (up to 10 offense codes)

this is for FIRST one:

42-44 UCR OFFENSE CODE 1,  
Type of crime (burglary, arson, etc.)

45-47 NUMBER OF VICTIMS 1,  
This is the total number of victims associated with the incident, and whether the victim was an individual or a business or an organization, etc.

48-49 LOCATION CODE 1,  
Where this offense occurred.

50-51 BIAS MOTIVATION 1,  
Bias motivation (anti-racial, anti-religious, anti-ethnicity, anti-sexual).  

52-59 TYPES OF VICTIMS 1,
Whether the victim was an individual or a business or an organization, etc.

(repeats 9 more times until 221)  

*Potential relationships/visualizations*:  


### Census data

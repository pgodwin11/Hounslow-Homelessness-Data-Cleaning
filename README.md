Project Overview

This project is somewhat personal as it delves into the issue of homelessness within my local borough, Hounslow. While London has long struggled with homelessness, this study focuses specifically on the homeless applications in the London Borough of Hounslow over the span of a decade. This analysis will explore the different ages categories, needs, reasons, and ethnic group demographics. With data spanning from 2005 to 2015, representing the up to date information made available from Hounslow's records, the aim is to extract insights and formulate potential reccomendations to address homelessness within the borough. Through comprehensive data cleaning using SQL and insightful data visualization techniques with Power BI, this project aims to uncover nuanced patterns and trends, facilitating a deeper understanding of the homelessness landscape in Hounslow.

 

Key Components

Data was collected from data.hounslow.gov.
Creation of schema and table and import of data into MySQL.
Data cleaning and preparation of data.
MySQL database connected to Power BI.
Built interactive dashboard in Power BI.
 

Data Cleaning Procedure

Dropped Columns: Unnecessary columns were removed from the dataset(Publisher Label, Publisher URL, DecisionCode) as they were deemed irrelevant for future analysis.

Cleaned Date Columns: Timestamps were removed from Registration Date and Decision Date columns to standardize the format and focus only on the date information.

Removed Nationality Column: This column was dropped as there was a significant amount of enteries labeled as "not rec", which wouldnt be great to use for our sample data.

Categorized Ethnicity Column: Rows with no information were removed, and spelling errors in some ethnic categories were corrected to maintain data consistency.

Categorized Reason Column: Reasons for homelessness were categorized and standardized in format, including capitalizing the first letter of each word for better readability and analysis.

Categorized Need Column: Enteries in this column were capitalized and standardized in format to ensure consistency and improve visual presentation.

Categorized Decision Column: Decisions related to homelessness were categorized and standardized in format to facillitate analysis and interpretation of the data.

Filtered Registration Date: Rows where the registration date before 2005 were filtered out to focus the anlysis for our specific time period.

Filtered Decision Time: Created a new column that would calculate decision time as the difference between Registration Date and Decision Date, after that I removed columns with negative or 0 days, to improve data accuracy.

Categorized Age: Age values were categorized into age groups and stored into a new column (age_category) to simplify analysis and interpretations of age-related patterns.
 

Key Insights and Recommedations(Coming Soon)

 

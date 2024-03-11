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
 


 

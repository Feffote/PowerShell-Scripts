This tool is used to manage the Report Server using Reporting Services Tools.
The main idea is to revoke the role of Content Manager (or the role you want) for all users and after that give them the role they should have.

So the Script will do the following:
  1. Read the main folder that you pass
  2. Search recursively all the folders that are inside the main folder until you reach each of the reports
  3. Create a list with all the folders / reports found
  4. Browse each folder / report and make a list with the users who are 'Content Manager'
  5. Go through each user, revoke all their roles and grant them the role of 'Browser', 'Publisher' and 'Report Builder'
  
  
Complete '[...]' with your data

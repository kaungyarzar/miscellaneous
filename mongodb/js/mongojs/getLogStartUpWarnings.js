// Desc: Mongo js script for checking log entries that may contain errors or warnings from MongoDB's log from when the current process started. 
// 	If mongod started without warnings, this filter may return an empty array.
// Depends Install: $ sudo apt install mongo-tools
// Usage Example: $ mongo mongodb://localhost:27017/mydb getLogStartUpWarnings.js

db.adminCommand( { getLog:'startupWarnings'} ).log.forEach(x => {print(x)})

// Desc: Mongo js script for all recent log entries.
// Depends Install: $ sudo apt install mongo-tools
// Usage Example: $ mongo mongodb://localhost:27017/mydb getLogGlobal.js

db.adminCommand( { getLog:'global'} ).log.forEach(x => {print(x)})

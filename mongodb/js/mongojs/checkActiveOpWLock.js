printjson(db.currentOp(
   {
     "waitingForLock" : true,
     $or: [
        { "op" : { "$in" : [ "insert", "update", "remove" ] } },
        { "query.findandmodify": { $exists: true } }
    ]
   }
))

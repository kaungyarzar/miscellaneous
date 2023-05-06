printjson(db.currentOp(
    {
      $or: [
        { op: "command", "query.createIndexes": { $exists: true } },
        { op: "none", ns: /\.system\.indexes\b/ }
      ]
    }
));

db.currentOp({"$all":true}).inprog.forEach(function(op){if(op.active === true){printjson(op)}})

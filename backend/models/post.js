var mongoose = require('mongoose')
var Schema = mongoose.Schema

var PostSchema = new Schema(
    {
        title : {
            type : String,
            require : true,
        },
        body : {
            type : String,
            require : true,
        },
        author : {
            type : String,
            require : true,
        },
        author_id : {
            type : String,
            require : true
        }
    },
    {
        timestamps : true
    }
)

module.exports = mongoose.model('Post',PostSchema)
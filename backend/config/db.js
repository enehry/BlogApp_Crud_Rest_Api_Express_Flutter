const mongoose = require('mongoose')
const dbConfig = require('./dbconfig')
require('dotenv').config()


const ConnectDB = async() => {
    try {
        const conn = await mongoose.connect(process.env.DB_URI, {
            useNewUrlParser : true,
            useFindAndModify: true,
            useUnifiedTopology : true,

        })
        console.log(`MongoDB Connected : ${conn.connection.host}`)
    } catch(e){
        console.log(e)
        process.exit(1)
    }
}

module.exports = ConnectDB
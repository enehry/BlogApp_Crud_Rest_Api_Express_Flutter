const express = require('express')
const morgan = require('morgan')
const cors = require('cors')
const connectDB = require('./config/db')
const passport = require('passport')
const routes = require('./routes/index')

connectDB()

const app = express()

if(process.env.NODE_ENV === 'development'){
    app.use(morgan('dev'))
}

app.use('*' ,cors())
app.use(express.urlencoded({ extend: false}))
app.use(express.json())
app.use(routes)
app.use(passport.initialize())
require('./config/passport')(passport)



const PORT = process.env.PORT || 5000

app.listen(PORT, 
    console.log(`Server running in ${process.env.NODE_ENV} mode on port ${PORT}`))
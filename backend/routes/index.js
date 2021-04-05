const express =  require('express')
const action = require('../methods/actions')
const router = express.Router()

router.get('/', (req, res) => {
    res.send('THIS iS HOME')
})

router.get('/dashboard', (req, res) => {
    res.send('THIS IS DASHBOARD')
})

//Adding new user
//route POST /adduser
router.post('/adduser', action.addNew)
//Authenticating user
//route POST /authenticate
router.post('/authenticate', action.authenticate)

router.get('/getinfo', action.getinfo)

router.post('/addpost', action.addPost)

router.get('/getallpost', action.getAllPost)

router.get('/getpostbyid/:id', action.getPostbyId)

router.get('/getpostbyauthorid/:id', action.getPostbyAuthorId)

router.get('/searchpost/:title', action.searchPost)

router.delete('/deletepost/:id', action.deletePost)

router.put('/updatepost/:id', action.updatePost)


module.exports = router;
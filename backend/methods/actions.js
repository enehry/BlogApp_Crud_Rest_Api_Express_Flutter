var User = require('../models/user')
var Post = require('../models/post')
var jwt = require('jwt-simple')
require('dotenv').config()

var functions = {
    addNew : function(req, res){
        User.findOne({
            name : req.body.name
        }, function (err, user){
            if(err){
                res.json({success : false, msg : 'There is a Problem finding the username'})
            } else {
                if(!user){
                    if((!req.body.name) || (!req.body.password)){
                        res.json({success : false, msg : 'Enter all fields'}) 
                    } else {
                        var newUser = User({
                            name : req.body.name,
                            password : req.body.password
                        })
                        newUser.save(function(err, newUser) {
                            if(err){
                                res.json({success: false, msg : 'Failed to save'})
                            } else {
                                res.json({success : true, msg : 'Successfully Save'})
                            }
                        })
                    }
                } else {
                    res.json({success : false, msg : 'Username already exist'})
                }
            }
        })

        
    },
    authenticate : function(req, res){
        User.findOne({
            name : req.body.name,  
        }, function(err, user){
            if(err) throw err
            if(!user){
                res.status(403).send({success : false, msg : 'User not found'})
            } else {
                user.comparePassword(req.body.password, function(err, isMatch){
                    if(isMatch && !err){
                        var token = jwt.encode(user, process.env.SECRET)
                        res.json({success : 'true', token : token})
                    } else {
                        return res.status(403).send({success : 'false', msg : 'Authenticating failed wrong password'})
                    }
                })
            }
        })
    },
    getinfo: function (req, res) {
        
        if (req.headers.authorization && req.headers.authorization.split(' ')[0] === 'Bearer') {
            var token = req.headers.authorization.split(' ')[1]
            var decodedToken = jwt.decode(token, process.env.SECRET)

            return res.json({success: true, 
                msg: 'Hello ' + decodedToken.name, 
                id : decodedToken._id, 
                name : decodedToken.name,
                password : decodedToken.password,
                createdAt : decodedToken.createdAt,
                updatedAt : decodedToken.updatedAt,
            })
        }
        else {
            return res.json({success: false, msg: 'No Headers'})
        }
    },
    addPost : function(req, res){
        if(!req.body.title || !req.body.body || !req.body.author || !req.body.author_id ){
            res.json({'success' : false , 'msg' : 'Please enter all fields'})
        } else {
            var newPost = Post({
                title : req.body.title,
                body : req.body.body,
                author : req.body.author,
                author_id : req.body.author_id
            })
            newPost.save(function(err){
                if(err){
                    res.json({'success' : false , 'msg' : `There is a problem saving your post ${err}`})
                } else {
                    res.json({'success' : true , 'msg' : 'Post save successfully'})
                }
            })
        }
    },

    getAllPost : function(req, res){
        Post.find({}, function(err, posts){
            if(err){
                return res.json({'success' : false, 'msg' : 'There was a problem retrieving a posts'})
            } else {
                return res.json(posts)
            }
        })
          //return res.send('TEST')
    },

    getPostbyId : function(req, res){
        Post.find({
            _id : req.params.id
        }, function(err, posts){
            if(err){
                return res.json({'success' : false, 'msg' : 'There was a problem retrieving a posts'})
            } else {
                return res.json(posts)
            }
        })
          //return res.send('TEST')
    },

    getPostbyAuthorId : function(req, res){
        Post.find({
            author_id : req.params.id
        }, function(err, posts){
            if(err){
                return res.json({'success' : false, 'msg' : 'There was a problem retrieving a posts'})
            } else {
                return res.json(posts)
            }
        })
          //return res.send('TEST')
    },
    
    searchPost : function(req, res){
        var title = req.params.title;
        console.log(title)
        Post.find(  { "title": { "$regex": `${title}`, "$options": "i" } } 
        , function(err, posts){
                if(err) return res.json({'success' : false, 'msg' : 'There was a problem retrieving a posts' + err})
                else return res.json(posts)
            }
        
        )
    },

    deletePost : function(req, res){
        Post.deleteOne({
            _id : req.params.id
        }, function(err){
            if(err){
                return res.json({'success' : false, 'msg' : 'There was an error delete your post'})
            } else {
                return res.json({'success' : true, 'msg' : 'Post Deleted'})
            }
        })
    },

    updatePost : function(req, res){
        Post.updateOne(
            {_id : req.params.id},
            {$set : {
                title : req.body.title,
                body : req.body.body,
                author : req.body.author,
                author_id : req.body.author_id
            }},
            function(err){
                if(err){
                    return res.json({'success' : false, 'msg' : 'There was an error updating your post'})
                } else {
                    return res.json({'success' : true, 'msg' : 'Post updated'})
                }
            }
        )
    }

    
}


module.exports = functions
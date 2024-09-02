const express=require('express')
const mongoose=require('mongoose')
//For using mongoose module, first need to install mongodb and mongoose through npm install name

//For Login system
mongodbServer='mongodb+srv://'
username='dbUser'
password='dbPassword123'
clustername='cluster0.noxusbn.mongodb.net'
databasename='RecipeApp'
mongoose.connect('mongodb+srv://dbUser:dbPassword123@cluster0.noxusbn.mongodb.net/RecipeApp?retryWrites=true&w=majority&appName=Cluster0')
.then(()=>console.log("Connected to database"))
.catch((error)=>console.log(error))
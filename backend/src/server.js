const express = require('express')
const app = express()

const mongoose = require('mongoose')
const Note = require('./models/notes_model')

const bodyParser = require('body-parser')
app.use(bodyParser.urlencoded({ extended: false }))
app.use(bodyParser.json())


const mongoDbPath = 'mongodb+srv://sdkysfzai:flutter_notes@cluster0.ncklhjc.mongodb.net/notesdb'
mongoose.connect(mongoDbPath).then(function () {

    app.get("/", function (req, res) {
        const response = { message: "API Works" }
        res.json(response)
    });
    const noteRouter = require('./routes/notes_routes')
    app.use("/notes", noteRouter)

})

const port = process.env.port || 5000
app.listen(port, function () {
    console.log("Server started at Port: " + port)
})
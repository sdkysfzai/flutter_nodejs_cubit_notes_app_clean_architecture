const express = require("express")
const router = express.Router()
const Note = require("./../models/notes_model")

router.post("/list/", async function (req, res) {
    const note = await Note.find({ userId: req.body.userId })
    res.json(note)
});

router.post("/add", async function (req, res) {

    await Note.deleteOne({ id: req.body.id })

    const newNote = new Note({
        id: req.body.id,
        userId: req.body.userId,
        title: req.body.title,
        content: req.body.content,
    })

    await newNote.save()
    const response = { message: "Note saved successfully!" + `id: ${req.body.id}` }
    res.json(response)
});

router.post("/delete", async function (req, res) {
    await Note.deleteOne({ id: req.body.id })
    const response = { message: "Note deleted successfully!" + `id: ${req.body.id}` }
    res.json(response)
})

module.exports = router
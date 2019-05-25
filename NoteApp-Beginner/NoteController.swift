import Foundation

class NoteController {
    private var notes = [Note]()
    
    func newNote() -> Note {
        return Note()
    }
    
    func pickNote(at index: Int) -> Note {
        return notes.remove(at: index)
    }
    
    func saveNote(with text: String) {
        notes.insert(Note(text: text), at: 0)
    }
    
    var lastNoteOrNew: Note {
        guard let lastNote = notes.last else { return newNote() }
        return lastNote
    }
    
    var numberOfNotes: Int {
        return notes.count
    }
    
    func title(at index: Int) -> String {
        return notes[index].text
    }
}

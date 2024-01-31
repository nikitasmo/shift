//
//  ListNotesPresenter.swift
//  Shift_trainee
//
//  Created by Никита on 28.01.2024.
//

import Foundation

protocol IListNotesPresenter: AnyObject {
    var lastNoteIndex: Int { get }
    var noteCount: Int { get }
    
    func createNewNote(text: String)
    func setTextNote(at index: Int, text: String, textSize: Float)
    func getNotePreview(index: Int) -> String
    func getSizeForTextNote(index: Int) -> Float
    func deleteNote(index: Int)
    
    func getNote(at index: Int) -> NoteModel
    
    func setSizetexNote(index: Int, textSize: Float) 
    
    func firstLoad()
}

final class ListNotesPresenter {
    
    private weak var view: IListNotesViewController?
    private let modelStorage = ModelStorage()
    
    init(view: IListNotesViewController) {
        self.view = view
    }
}

extension ListNotesPresenter: IListNotesPresenter {
    
    func firstLoad() {
        if modelStorage.model.count == 0 {
            createNewNote(text: "Hello world")
        }
    }
    
    var lastNoteIndex: Int {
        modelStorage.model.count - 1
    }
    
    var noteCount: Int {
        modelStorage.model.count
    }
    
    func createNewNote(text: String) {
        modelStorage.addNewModel(text: text)
    }
    
    func setTextNote(at index: Int, text: String, textSize: Float) {
        modelStorage.setText(number: index, text: text, textSize: textSize)
    }
    
    func getNotePreview(index: Int) -> String {
        modelStorage.getNotePreview(index: index)
    }
    
    func deleteNote(index: Int) {
        modelStorage.deleteNote(index: index)
        view?.displayNotes()
    }
    
    func getNote(at index: Int) -> NoteModel {
        modelStorage.getNote(index: index)
    }
    
    func getSizeForTextNote(index: Int) -> Float {
        modelStorage.getSizeForTextNote(number: index)
    }
    
    func setSizetexNote(index: Int, textSize: Float) {
        modelStorage.setTextSizeNote(number: index, textSize: textSize)
    }
    
}

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
    func setTextNote(at index: Int, text: String)
    func getNotePreview(index: Int) -> String
}

final class ListNotesPresenter {
    
    private weak var view: IListNotesViewController?
    private let modelStorage = ModelStorage()
    
    init(view: IListNotesViewController) {
        self.view = view
    }
}

extension ListNotesPresenter: IListNotesPresenter {
    
    var lastNoteIndex: Int {
        modelStorage.model.count - 1
    }
    
    var noteCount: Int {
        modelStorage.model.count
    }
    
    func createNewNote(text: String) {
        modelStorage.addNewModel(text: text)
    }
    
    func setTextNote(at index: Int, text: String) {
        modelStorage.setText(number: index, text: text)
    }
    
    func getNotePreview(index: Int) -> String {
        modelStorage.getNotePreview(index: index)
    }
    
}

//
//  ListNotesPresenter.swift
//  Shift_trainee
//
//  Created by Никита on 28.01.2024.
//

import Foundation

protocol IListNotesPresenter: AnyObject {
    var noteCount: Int { get }
    
    func createNewNote(text: String)
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
    
    var noteCount: Int {
        modelStorage.model.count
    }
    
    func createNewNote(text: String) {
        modelStorage.addNewModel(text: text)
    }
    
    func getNotePreview(index: Int) -> String {
        modelStorage.getNotePreview(index: index)
    }
    
}

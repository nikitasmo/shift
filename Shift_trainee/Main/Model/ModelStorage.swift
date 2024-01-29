//
//  ModelStorage.swift
//  Shift_trainee
//
//  Created by Никита on 28.01.2024.
//

import Foundation

final class ModelStorage {
    
    private(set) var model: [NoteModel]
    
    init() {
        self.model = []
    }
    
    func addNewModel(text: String) {
        let noteModel = NoteModel(text: text)
        model.append(noteModel)
    }
    
    func setText(number: Int, text: String) {
        model[number].text = text
    }
    
    func getNotePreview(index: Int) -> String {
        return model[index].text
    }
    
}

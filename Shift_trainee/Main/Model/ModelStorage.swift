//
//  ModelStorage.swift
//  Shift_trainee
//
//  Created by Никита on 28.01.2024.
//

import Foundation

final class ModelStorage {
    
    private let defaults = UserDefaults.standard
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    private(set) var model: [NoteModel]
    
    init() {
        if let data = defaults.data(forKey: "notes") {
            let notesModel = try? decoder.decode(Notes.self, from: data).models
            self.model = notesModel ?? []
        } else {
            self.model = []
        }
    }
    
    
    func addNewModel(text: String) {
        let noteModel = NoteModel(text: text, textSize: 30)
        model.append(noteModel)
        saveNew(note: noteModel)
    }
    
    func setText(number: Int, text: String, textSize: Float) {
        model[number].text = text
        model[number].textSize = textSize
        editNote(at: number, text: text, textSize: textSize)
    }
    
    func getNote(index: Int) -> NoteModel {
        model[index]
    }
    
    func getSizeForTextNote(number: Int) -> Float {
        return model[number].textSize
    }
    
    func setTextSizeNote(number: Int, textSize: Float) {
        model[number].textSize = textSize
        editNote(at: number, text: model[number].text, textSize: textSize)
    }
    
    func getNotePreview(index: Int) -> String {
        return model[index].text
    }
    
    func deleteNote(index: Int) {
        model.remove(at: index)
        deleteNote(at: index)
    }
    
}

extension ModelStorage {
    private func saveNew(note: NoteModel) {
        if let existData = defaults.data(forKey: "notes") {
            
            do {
                var notes = try decoder.decode(Notes.self, from: existData)
                
                notes.models.append(note)
                
                let newData = try encoder.encode(notes)
                
                defaults.set(newData, forKey: "notes")
                
            } catch let error {
                print(error.localizedDescription)
            }
        } else {
            do {
                let notes = Notes(models: [note])
                
                let data = try encoder.encode(notes)
                
                defaults.set(data, forKey: "notes")
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    private func editNote(at index: Int, text: String, textSize: Float) {
        guard let data = defaults.data(forKey: "notes") else {
            return
        }

        do {
            var notes = try decoder.decode(Notes.self, from: data)
            
            if !notes.models.isEmpty {
                notes.models[index].text = text
                notes.models[index].textSize = textSize
            }
            
            let newData = try encoder.encode(notes)
            
            defaults.set(newData, forKey: "notes")
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    private func deleteNote(at index: Int) {
        guard let data = defaults.data(forKey: "notes") else {
            return
        }

        do {
            var notes = try decoder.decode(Notes.self, from: data)
            

            notes.models.remove(at: index)
        
            
            let newData = try encoder.encode(notes)
            
            defaults.set(newData, forKey: "notes")
        } catch let error {
            print(error.localizedDescription)
        }
    }
}

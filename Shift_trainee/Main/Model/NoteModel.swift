//
//  NoteModel.swift
//  Shift_trainee
//
//  Created by Никита on 28.01.2024.
//

import Foundation

struct Notes: Codable {
    var models: [NoteModel]
}

struct NoteModel: Codable {
    var text: String
    var textSize: Float
}

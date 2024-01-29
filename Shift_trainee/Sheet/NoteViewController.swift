//
//  NoteViewController.swift
//  Shift_trainee
//
//  Created by Никита on 28.01.2024.
//

import UIKit

protocol INoteViewController: AnyObject {
    
}

protocol NoteViewControllerDelegate: AnyObject {
    func textViewDidChanged(at index: Int, text: String)
    func viewDidClose()
}

final class NoteViewController: UIViewController {
    // Properties
    weak var delegate: NoteViewControllerDelegate?
    
    private let noteView = NoteView()
    private let noteIndex: Int
    
    init(noteIndex: Int, text: String = "") {
        self.noteIndex = noteIndex
        self.noteView.textViewNote.text = text
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        noteView.delegate = self
        view = noteView
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        delegate?.viewDidClose()
    }
    
}

extension NoteViewController: INoteViewController {
    
}

extension NoteViewController: NoteViewDelegate {
    func textViewDidChanged(text: String) {
        delegate?.textViewDidChanged(at: noteIndex, text: text)
    }
}


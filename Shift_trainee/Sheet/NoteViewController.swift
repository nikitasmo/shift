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
    func textViewDidChanged(at index: Int, text: String, textSize: Float)
    func viewDidClose(noteIndex: Int, textSize: Float)
}

final class NoteViewController: UIViewController {
    // Properties
    weak var delegate: NoteViewControllerDelegate?
    
    private let noteView = NoteView()
    private let noteIndex: Int
    
    init(noteIndex: Int, text: String = "", textSize: Float) {
        self.noteIndex = noteIndex
        self.noteView.textViewNote.text = text
        noteView.sliderTextSize.setValue(textSize, animated: true)
        noteView.textViewNote.font = UIFont.systemFont(ofSize: CGFloat(textSize))
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
        delegate?.viewDidClose(noteIndex: noteIndex, textSize: noteView.sliderTextSize.value)
    }
    
}

extension NoteViewController: INoteViewController {
    
}

extension NoteViewController: NoteViewDelegate {
    func sliderChangeValue(sizeText: CGFloat) {
        noteView.textViewNote.font = UIFont.systemFont(ofSize: sizeText)
    }
    
    func textViewDidChanged(text: String) {
        var actualSize = noteView.textViewNote.sizeThatFits(CGSize(width: noteView.textViewNote.frame.size.width, height: CGFloat.greatestFiniteMagnitude))
        delegate?.textViewDidChanged(at: noteIndex, text: text, textSize: Float(actualSize.height))
    }
}


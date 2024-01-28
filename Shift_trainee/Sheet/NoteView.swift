//
//  NoteView.swift
//  Shift_trainee
//
//  Created by Никита on 28.01.2024.
//

import UIKit

final class NoteView: UIView {
    
    private(set) lazy var textViewNote: UITextView = {
        var textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    // MARK: - Life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
             
        self.addSubview(textViewNote)
        
        configureConstraint()
        
        textViewNote.becomeFirstResponder()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NoteView {
    private func configureConstraint() {
        textViewNote.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        textViewNote.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        textViewNote.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        textViewNote.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}


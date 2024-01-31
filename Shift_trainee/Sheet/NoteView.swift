//
//  NoteView.swift
//  Shift_trainee
//
//  Created by Никита on 28.01.2024.
//

import UIKit

protocol NoteViewDelegate: AnyObject {
    func textViewDidChanged(text: String)
    func sliderChangeValue(sizeText: CGFloat)
}

final class NoteView: UIView {
    
    private(set) lazy var textViewNote: UITextView = {
        var textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private(set) lazy var editTextView: UITextView = {
        var textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private(set) lazy var labelTextSize: UILabel = {
        var label = UILabel()
        label.text = "Размер текста"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var sliderTextSize: UISlider = {
        var slider = UISlider()
        slider.minimumValue = 10
        slider.maximumValue = 50
        slider.addTarget(self, action: #selector(ChangeSizeSlider), for: .valueChanged)
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    private var editTextViewBottomConstraint: NSLayoutConstraint?
    private var editTextViewBottomConstraintWithKeyboard: NSLayoutConstraint?
    
    weak var delegate: NoteViewDelegate?
    
    // MARK: - Life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        textViewNote.delegate = self
             
        self.addSubview(textViewNote)
        self.addSubview(editTextView)
        editTextView.addSubview(sliderTextSize)
        editTextView.addSubview(labelTextSize)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        configureConstraint()
        
        textViewNote.becomeFirstResponder()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NoteView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        delegate?.textViewDidChanged(text: textView.text)
    }
}

extension NoteView {
    private func configureConstraint() {
        textViewNote.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        textViewNote.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        textViewNote.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        textViewNote.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        editTextView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        editTextView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        editTextViewBottomConstraint = editTextView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        editTextView.heightAnchor.constraint(equalToConstant: 75).isActive = true
        
        editTextViewBottomConstraint?.isActive = true
        
        sliderTextSize.trailingAnchor.constraint(equalTo: editTextView.trailingAnchor, constant: -10).isActive = true
        sliderTextSize.leadingAnchor.constraint(equalTo: editTextView.leadingAnchor, constant: 10).isActive = true
        sliderTextSize.bottomAnchor.constraint(equalTo: editTextView.bottomAnchor, constant: 65).isActive = true
        sliderTextSize.centerXAnchor.constraint(equalTo: editTextView.centerXAnchor).isActive = true
        
        labelTextSize.trailingAnchor.constraint(equalTo: editTextView.trailingAnchor).isActive = true
        labelTextSize.leadingAnchor.constraint(equalTo: editTextView.leadingAnchor).isActive = true
        labelTextSize.centerXAnchor.constraint(equalTo: editTextView.centerXAnchor).isActive = true
        labelTextSize.bottomAnchor.constraint(equalTo: sliderTextSize.topAnchor, constant: -7).isActive = true
    }
}

extension NoteView {

    @objc func keyBoardWillShow(_ notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            editTextViewBottomConstraint?.isActive = false
            editTextViewBottomConstraintWithKeyboard = editTextView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -keyboardSize.height)
            editTextViewBottomConstraintWithKeyboard?.isActive = true
        }
        UIView.animate(withDuration: 0.1) {
            self.layoutIfNeeded()
        }
    }
    
    @objc func keyBoardWillHide(_ notification: Notification) {
        editTextViewBottomConstraintWithKeyboard?.isActive = false
        editTextViewBottomConstraint?.isActive = true
        UIView.animate(withDuration: 0.1) {
            self.layoutIfNeeded()
        }
        
    }
    
    @objc func ChangeSizeSlider() {
        
        delegate?.sliderChangeValue(sizeText: CGFloat(sliderTextSize.value))
        
    }
    
}


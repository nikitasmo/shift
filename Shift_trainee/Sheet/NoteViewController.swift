//
//  NoteViewController.swift
//  Shift_trainee
//
//  Created by Никита on 28.01.2024.
//

import UIKit

protocol NoteViewControllerDelegate: AnyObject {
    func viewDidClose()
}

final class NoteViewController: UIViewController {
    // Properties
    weak var delegate: NoteViewControllerDelegate?
    
    private let noteView = NoteView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = noteView
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        delegate?.viewDidClose()
    }
    
}


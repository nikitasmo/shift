//
//  ViewController.swift
//  Shift_trainee
//
//  Created by Никита on 28.01.2024.
//

import UIKit

protocol IListNotesViewController: AnyObject {
    
}

class ListNotesViewController: UIViewController {
    
    //Private
    private let listNotesView = ListNotesView()
    
    //MARK: - Dependecy
    
    private lazy var presenter: IListNotesPresenter = {
       return ListNotesPresenter(view: self)
    }()

    //MARK: - View life cycle
    
    override func loadView() {
        super.loadView()
        listNotesView.delegate = self
        view = listNotesView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Заметки"
        
        navigationItem.rightBarButtonItem = listNotesView.barButtonPlus
        
    }

}

extension ListNotesViewController: IListNotesViewController {
    
    func buttonAddPressed() {
        
        let noteViewController = NoteViewController()
        
        self.navigationController?.pushViewController(noteViewController, animated: true)
    }
}

extension ListNotesViewController: ListNotesViewDelegate {
    
    func getNotePreview(index: Int) -> String {
        presenter.getNotePreview(index: index)
    }
    
    func getNumberOfNote() -> Int {
        presenter.noteCount
    }
}


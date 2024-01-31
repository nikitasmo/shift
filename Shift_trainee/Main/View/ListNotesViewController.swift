//
//  ViewController.swift
//  Shift_trainee
//
//  Created by Никита on 28.01.2024.
//

import UIKit

protocol IListNotesViewController: AnyObject {
    func displayNotes()
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
        listNotesView.delegate = self
        view = listNotesView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Заметки"
        
        navigationItem.rightBarButtonItem = listNotesView.barButtonPlus
        
        presenter.firstLoad()
        
    }

}

// MARK: - IListNotesViewController
extension ListNotesViewController: IListNotesViewController {
    func displayNotes() {
        listNotesView.mainTableView.reloadData()
    }
}

// MARK: - ListNotesViewDelegate
extension ListNotesViewController: ListNotesViewDelegate {
    
    func getNotePreview(index: Int) -> String {
        presenter.getNotePreview(index: index)
    }
    
    func buttonDeletePressed(number: Int) {
        presenter.deleteNote(index: number)
    }
    
    func getNumberOfNote() -> Int {
        presenter.noteCount
    }
    
    func buttonAddPressed() {
        presenter.createNewNote(text: "")
        
        let noteViewController = NoteViewController(noteIndex: presenter.lastNoteIndex, textSize: 30)
        noteViewController.delegate = self
        
        self.navigationController?.pushViewController(noteViewController, animated: true)
    }
    
    func notePressed(row: Int) {
        let noteViewController = NoteViewController(noteIndex: row, text: presenter.getNote(at: row).text, textSize: presenter.getSizeForTextNote(index: row))
        noteViewController.delegate = self

        self.navigationController?.pushViewController(noteViewController, animated: true)
    }
}

extension ListNotesViewController: NoteViewControllerDelegate {
    
    func viewDidClose(noteIndex: Int, textSize: Float) {
        presenter.setSizetexNote(index: noteIndex, textSize: textSize)
        listNotesView.mainTableView.reloadData()
    }
    
    func textViewDidChanged(at index: Int, text: String, textSize: Float) {
        presenter.setTextNote(at: index, text: text, textSize: textSize)
    }
    
}

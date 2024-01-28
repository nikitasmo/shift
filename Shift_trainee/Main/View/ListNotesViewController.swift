//
//  ViewController.swift
//  Shift_trainee
//
//  Created by Никита on 28.01.2024.
//

import UIKit

class ListNotesViewController: UIViewController {
    
    //Private
    private let listNotesView = ListNotesView()

    
    //MARK: - View life cycle
    
    override func loadView() {
        super.loadView()
        view = listNotesView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Заметки"
        
    }


}


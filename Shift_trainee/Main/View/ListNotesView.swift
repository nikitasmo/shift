//
//  ListNotesView.swift
//  Shift_trainee
//
//  Created by Никита on 28.01.2024.
//

import Foundation
import UIKit

protocol ListNotesViewDelegate: AnyObject {
    
    
    func getNumberOfNote() -> Int
}


final class ListNotesView: UIView {
    
    // Subviews
    private(set) lazy var mainTableView: UITableView = {
        var tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.layer.backgroundColor = UIColor.clear.cgColor
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        return tableView
    }()
    
    //Properties
    weak var delegate: ListNotesViewDelegate?
    
    
    //MARK: - Life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ListNotesView: UITableViewDelegate {
    
}

extension ListNotesView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mainTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delegate?.getNumberOfNote() ?? 0
    }
    
}

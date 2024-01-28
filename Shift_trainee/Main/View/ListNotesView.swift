//
//  ListNotesView.swift
//  Shift_trainee
//
//  Created by Никита on 28.01.2024.
//

import Foundation
import UIKit


final class ListNotesView: UIView {
    
    // Subviews
    private(set) lazy var mianTableView: UITableView = {
        var tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.layer.backgroundColor = UIColor.clear.cgColor
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        return tableView
    }()
    
    
    //MARK: - Life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

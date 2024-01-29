//
//  ListNotesView.swift
//  Shift_trainee
//
//  Created by Никита on 28.01.2024.
//

import Foundation
import UIKit

protocol ListNotesViewDelegate: AnyObject {
    
    func buttonAddPressed()
    func buttonDeletePressed(number: Int)
    
    func getNumberOfNote() -> Int
    func getNotePreview(index: Int) -> String
}


final class ListNotesView: UIView {
    
    // Subviews
    private(set) lazy var barButtonPlus: UIBarButtonItem = {
        var button = UIBarButtonItem(title: "+", style: .plain, target: self, action: #selector(touchUpNoteAdd))
        button.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 30)], for: .normal)
        return button
    }()
    
    private(set) lazy var mainTableView: UITableView = {
        var tableView = UITableView()
        tableView.register(NoteTableViewCell.self, forCellReuseIdentifier: "cell")
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
        
        self.addSubview(mainTableView)
        
        configureConstraint()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ListNotesView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}

extension ListNotesView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NoteTableViewCell
        
        cell.layer.backgroundColor = UIColor.clear.cgColor
        cell.backgroundColor = .clear
        
        cell.configureCell(text: delegate?.getNotePreview(index: indexPath.row) ?? "fff")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delegate?.getNumberOfNote() ?? 0
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Удалить", handler: { [weak self] (_, _, _) in
            self?.delegate?.buttonDeletePressed(number: indexPath.row)
        })
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
}

// MARK: - Private

extension ListNotesView {
    private func configureConstraint() {
        //mainTableView
        mainTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        mainTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        mainTableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        mainTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}

// MARK: - Selectors
extension ListNotesView {
    @objc func touchUpNoteAdd() {
        delegate?.buttonAddPressed()
    }
}

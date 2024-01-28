//
//  NoteTableViewCell.swift
//  Shift_trainee
//
//  Created by Никита on 28.01.2024.
//

import UIKit

final class NoteTableViewCell: UITableViewCell {
    
    private var label = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setConstraints()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(text: String) {
        label.text = text
    }
}

private extension NoteTableViewCell {
    func addSubviews() {
        self.contentView.addSubview(label)
    }
    
    func setConstraints() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
    }
    
    func configure() {
        contentView.layer.borderWidth = 1
        contentView.layer.cornerRadius = 30
    }
}

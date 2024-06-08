//
//  MenuView.swift
//  ExpenceHit
//
//  Created by Roman Bigun on 05.06.2024.
//

import UIKit

protocol DropDownButtonDelegate: AnyObject {
    func didSelect(_ index: Int, tag: Int)
}

class MenuView: UIView {
    
    private let button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("none", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderWidth = 0.9
        button.layer.borderColor = R.Colors.active.cgColor
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        return button
    }()

    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = 4
        stack.axis = .vertical
        return stack
    }()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.isHidden = true
        table.layer.borderWidth = 0.9
        table.layer.borderColor = R.Colors.active.cgColor
        table.layer.cornerRadius = 5
        table.layer.masksToBounds = true
        table.backgroundColor = .white
        table.register(UINib(nibName: "MenuTableViewCell", bundle: nil),
                       forCellReuseIdentifier: "MenuTableViewCell")
        return table
    }()

    var dataSource: [String] = [] {
        didSet {
            updateTableDataSource()
        }
    }

    var title: String = "" {
        didSet {
            button.setTitle(title, for: .normal)
        }
    }

    var delegate: DropDownButtonDelegate?
   
    var tableViewHeight: NSLayoutConstraint?

    var buttonHeightConstraint: NSLayoutConstraint?
    
    var buttonHeight: CGFloat = 40 {
        didSet {
            buttonHeightConstraint?.constant = buttonHeight
            updateTableDataSource()
        }
    }

    var maxVisibleCellsAmount: Int = 4 {
        didSet {
            updateTableDataSource()
        }
    }

    var buttonBottomConstraint: NSLayoutYAxisAnchor {
        button.bottomAnchor
    }

    init() {
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    func setup() {
        addSubview(stackView)
        stackView.addArrangedSubview(button)
        stackView.addArrangedSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo:topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
        ])
        buttonHeightConstraint = button.heightAnchor.constraint(equalToConstant: buttonHeight)
        buttonHeightConstraint?.isActive = true
        tableViewHeight = tableView.heightAnchor.constraint(equalToConstant: 0)
        tableViewHeight?.isActive = true
        button.addTarget(self, action: #selector(buttonTapped), for: .primaryActionTriggered)
    }

    func updateTableDataSource() {
        if dataSource.count >= maxVisibleCellsAmount {
            tableViewHeight?.constant = CGFloat(maxVisibleCellsAmount * 2) * buttonHeight
        } else {
            tableViewHeight?.constant = CGFloat(dataSource.count) * buttonHeight
        }
        tableView.reloadData()
    }

    @objc private func buttonTapped() {
        tableView.isHidden.toggle()
    }

}

extension MenuView: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath) as! MenuTableViewCell
        cell.setLabel(categoryName: dataSource[indexPath.row])
        return cell
    }
}

extension MenuView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        button.setTitle(dataSource[indexPath.row], for: .normal)
        delegate?.didSelect(indexPath.row, tag: self.tag)
        tableView.isHidden = true
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return buttonHeight
    }
}

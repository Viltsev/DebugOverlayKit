//
//  LogViewController.swift
//  DebugOverlayKit
//
//  Created by viltsevdanila on 9/8/25.
//

import UIKit

@available(iOS 15, *)
public class LogViewController: UIViewController {
    
    private var logs: [LogEntry] = Logger.shared.logs {
        didSet {
            tableView.reloadData()
        }
    }
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .black
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        addSubviews()
        makeConstraints()
        addObserver()
    }
}

@available(iOS 15, *)
extension LogViewController {
    
    private func addObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleLogUpdate),
                                               name: .loggerDidUpdate,
                                               object: nil)
    }
    
    private func addSubviews() {
        view.backgroundColor = .black
        
        tableView.dataSource = self
        tableView.register(LogCell.self, forCellReuseIdentifier: LogCell.identifier)
        
        view.addSubview(tableView)
    }
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8),
        ])
    }
    
    @objc private func handleLogUpdate() {
        logs = Logger.shared.logs
    }
    
    func updateLogs(_ newLogs: [LogEntry]) {
        self.logs = newLogs
    }
}

@available(iOS 15, *)
extension LogViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        logs.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LogCell.identifier, for: indexPath) as? LogCell else {
            return UITableViewCell()
        }

        let log = logs[indexPath.row]
        
        cell.configure(with: log)
        return cell
    }
}

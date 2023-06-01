//
//  ViewController.swift
//  AssessmentLevel2
//
//  Created by Sankar on 01/06/23.
//

import UIKit

class DashboardController: UIViewController {
    // MARK: - OUTLETS
    @IBOutlet weak var dashboardTableView: UITableView!
    @IBOutlet weak var pageNumberButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    
    // MARK: - PROPERTIES
    var dashboardInfo: [DashboardInfo] = []
    var currentPage = 1
    var imageLimit = 20
    private lazy var dialogueView = Bundle.main.loadNibNamed("DialogueView", owner: self, options: nil)?.first as! DialogueView
    var selectedIndex: Int!
    
    // MARK: - LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configUI()
        self.fetchDashboardData()
    }
    
    // MARK: - CONFIG
    private func configUI() {
        self.dashboardTableView.delegate = self
        self.dashboardTableView.dataSource = self
        self.dashboardTableView.register(UINib(nibName: "DashboardTableViewCell", bundle: nil), forCellReuseIdentifier: "DashboardTableViewCell")
    }
    
    private func updatePaginationButton() {
        self.pageNumberButton.setTitle("\(self.currentPage)", for: .normal)
        self.leftButton.isEnabled = self.currentPage == 1 ? false : true
        self.rightButton.isEnabled = self.currentPage == 50 ? false : true
    }
    
    func configureDialogueView(){
        self.dialogueView.frame = CGRect(x: 0, y: 0, width: 283, height: 160)
        self.dialogueView.center = self.view.center
        self.dialogueView.delegate = self
    }
    
    // MARK: - HELPERS
    private func fetchDashboardData() {
        DashboardViewModel().fetchDashboardData(pageNumber: self.currentPage, imageLimit: self.imageLimit) { [weak self] dashboardData, errorMessage in
            guard let self else { return }
            if errorMessage == nil {
                guard let dashboardData else { return }
                self.dashboardInfo = dashboardData
                DispatchQueue.main.async {
                    self.dashboardTableView.reloadData()
                    self.updatePaginationButton()
                }
            } else {
                guard let errorMessage else { return }
                self.showAlert(message: errorMessage)
            }
        }
    }
    
    func showAlert(selectedRow: Int, author: String) {
        let alertController = UIAlertController(title: "Remove", message: "Do you want to deselect this author \(author)", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            var selectedData = self?.dashboardInfo[selectedRow]
            selectedData?.isSelected = false
            self?.dashboardInfo = (self?.dashboardInfo.map {
                var mutable = $0
                if mutable.id == selectedData!.id {
                    mutable = selectedData!
                }
                return mutable
            })!
            let cell = self?.dashboardTableView.cellForRow(at: IndexPath(row: selectedRow, section: 0)) as! DashboardTableViewCell
            cell.checkButton.isSelected = false
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive) { _ in
        }
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - ACTIONS
    @IBAction func leftButtonTapped(_ sender: UIButton) {
        self.currentPage -= 1
        if self.currentPage < 1 {
            self.currentPage = 1
        }
        self.fetchDashboardData()
    }
    
    @IBAction func rightButtonTapped(_ sender: UIButton) {
        self.currentPage += 1
        self.fetchDashboardData()
    }
}

// MARK: - TABLE VIEW DELEGATE
extension DashboardController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dashboardInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DashboardTableViewCell", for: indexPath) as! DashboardTableViewCell
        cell.setupCell(data: self.dashboardInfo[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
        var selectedRow = self.dashboardInfo[indexPath.row]
        if selectedRow.isSelected {
            self.showAlert(selectedRow: indexPath.row, author: selectedRow.author)
        } else {
            self.configureDialogueView()
            self.dialogueView.setupView(data: self.dashboardInfo[indexPath.row])
            self.view.addSubview(self.dialogueView)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

// MARK: - DIALOGUE VIEW DELEGATE
extension DashboardController: DialogueDelegate {
    
    func okayTapped() {
        self.dialogueView.removeFromSuperview()
        var selectedRow = dashboardInfo[self.selectedIndex]
        selectedRow.isSelected = true
        dashboardInfo = dashboardInfo.map {
            var mutable = $0
            if mutable.id == selectedRow.id {
                mutable = selectedRow
            }
            return mutable
        }
        if let cell = self.dashboardTableView.cellForRow(at: IndexPath(row: self.selectedIndex, section: 0)) as? DashboardTableViewCell {
            cell.checkButton.isSelected = true
        }
    }
}

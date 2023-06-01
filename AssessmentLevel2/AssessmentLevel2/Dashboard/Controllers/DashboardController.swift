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
        self.updatePaginationButton()
    }
    
    private func updatePaginationButton() {
        self.pageNumberButton.setTitle("\(self.currentPage)", for: .normal)
        self.leftButton.isEnabled = self.currentPage == 1 ? false : true
    }
    
    // MARK: - HELPERS
    private func fetchDashboardData() {
        DashboardViewModel().fetchDashboardData { [weak self] dashboardData, errorMessage in
            guard let self else { return }
            if errorMessage == nil {
                guard let dashboardData else { return }
                self.dashboardInfo = dashboardData
                DispatchQueue.main.async {
                    self.dashboardTableView.reloadData()
                }
            } else {
                guard let errorMessage else { return }
                self.showAlert(message: errorMessage)
            }
        }
    }
    
    // MARK: - ACTIONS
    @IBAction func leftButtonTapped(_ sender: UIButton) {
        self.currentPage -= 1
        if self.currentPage < 1 {
            self.currentPage = 1
        }
        self.updatePaginationButton()
    }
    
    @IBAction func rightButtonTapped(_ sender: UIButton) {
        self.currentPage += 1
        self.updatePaginationButton()
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

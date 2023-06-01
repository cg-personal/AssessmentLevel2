//
//  DialogueView.swift
//  AssessmentLevel2
//
//  Created by Sankar on 01/06/23.
//

import UIKit

protocol DialogueDelegate: AnyObject {
    func okayTapped()
}

class DialogueView: UIView {
    
    // MARK: - OUTLETS
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var imageUrlLabel: UILabel!
    @IBOutlet weak var okayButton: UIButton!
    
    // MARK: - PROPERTIES
    weak var delegate: DialogueDelegate?
    
    // MARK: - LIFECYCLE
    override func layoutSubviews() {
        super.layoutSubviews()
        self.okayButton.addCornerRadius(radius: 10)
        self.addCornerRadius(radius: 10)
        self.addSimpleBorder(width: 1.0, color: UIColor.black)
    }
    
    // MARK: - CONFIG
    func setupView(data: DashboardInfo) {
        self.authorLabel.text = data.author
        self.imageUrlLabel.text = data.url
    }
    
    // MARK: - ACTIONS
    @IBAction func okayTapped(_ sender: UIButton) {
        delegate?.okayTapped()
    }
}

//
//  TaskCell.swift
//  FinalProject_Jumana
//
//  Created by Jumana Rahman on 12/17/20.
//  Copyright © 2020 Jumana Rahman. All rights reserved.
//

import Foundation
import UIKit

class TaskCell: UITableViewCell {

    //file to customize each cell 
    var weightLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(task: String, weight: String) {
        //make text to the left
        self.textLabel!.text = "\(task)"
        self.textLabel!.numberOfLines = 0
        self.textLabel!.lineBreakMode = .byWordWrapping
        self.textLabel!.textAlignment = .center
        self.textLabel!.font = .systemFont(ofSize: 20)
        self.textLabel!.layer.shadowRadius = 2
        self.textLabel!.layer.shadowOpacity = 0.25
        self.textLabel!.layer.shadowOffset = CGSize(width: 4, height: 4)
        self.textLabel!.layer.masksToBounds = true
        self.textLabel?.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, paddingLeft: 16)
        //make weight to the right
        self.weightLabel.text =  "Weight: \(weight)"
        self.addSubview(weightLabel)
        weightLabel.anchor(top: self.topAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingRight: 16)
        
    }
}


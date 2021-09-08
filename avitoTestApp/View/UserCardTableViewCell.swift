//
//  UserCardTableViewCell.swift
//  avitoTestApp
//
//  Created by Ash on 07.09.2021.
//

import UIKit

class UserCardTableViewCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var phoneNumLabel: UILabel!
    @IBOutlet var skillsLabel: UILabel!
    
    static let identifire = "UserCardTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "UserCardTableViewCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
  
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func collectSkills(skills: [String]) -> String {
        var skillsList = ""
        for skill in skills {
            skillsList += skill + " "
        }
        return skillsList.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func configCell(with model: Employee){
        self.nameLabel.text = model.name
        self.phoneNumLabel.text = model.phoneNumber
        self.skillsLabel.text = collectSkills(skills: model.skills)
    }
    
}

//
//  SettingsVC.swift
//  Pomodoro
//
//  Created by Osaretin Uyigue on 8/2/22.
//

import UIKit
class SettingsVC: UITableViewController {
    
    //MARK: - View's LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
    }
    
    

    //MARK: - Properties
    fileprivate let moreSettingItems = [
        "How it works?",
        "Share App",
        "Write a Review",
        "Feature Request",
        "Report a Bug",
        "Developer's Twitter",
        "App Version"
        ]
    
    
    fileprivate let timeSettingsItems = [
        "Work",
        "Short Break",
        "Long Break"
    ]
    
    
    fileprivate let toggleSettingsData = [
    
        "Prevent Screen Lock",
        "Confirm Delete Task",
        "Play Sound on completion",
        "Noitification on completion"
    ]
    
    
    
    fileprivate lazy var settingsSection: [SettingsItem] = [
        .siriShortCuts,
        .timerSettings(timeSettingsItems),
        .toggleSettings(toggleSettingsData),
        .workSessions,
        .more(moreSettingItems) ]
    
    
    //MARK: - Methods
    fileprivate func setUpTableView() {
        
        tableView.register(SiriShortcutCell.self, forCellReuseIdentifier: SiriShortcutCell.cellReuseIdentifier)
        
        tableView.register(TimerSettingsCell.self, forCellReuseIdentifier: TimerSettingsCell.cellReuseIdentifier)
        
        tableView.register(ToggleSettingsCell.self, forCellReuseIdentifier: ToggleSettingsCell.cellReuseIdentifier)

        
        tableView.register(WorkSessionsRecordCell.self, forCellReuseIdentifier: WorkSessionsRecordCell.cellReuseIdentifier)
        
        tableView.register(MoreSettingsCell.self, forCellReuseIdentifier: MoreSettingsCell.cellIdentifier)
        

        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.contentInset = .init(top: 0, left: 0, bottom: 40, right: 0)
    }
    
    
   
    
}



//MARK: - TableView DataSource & Delegates
extension SettingsVC {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch settingsSection[indexPath.section] {
            
        case .siriShortCuts:
            let cell = tableView.dequeueReusableCell(withIdentifier: SiriShortcutCell.cellReuseIdentifier, for: indexPath) as! SiriShortcutCell
            return cell
            
        case .timerSettings(let timeSettingsItems):
            let cell = tableView.dequeueReusableCell(withIdentifier: TimerSettingsCell.cellReuseIdentifier, for: indexPath) as! TimerSettingsCell
            let title = timeSettingsItems[indexPath.row]
            cell.configureTitle(with: title)
            return cell
            

        case .toggleSettings(let toggleSettingsData):
            let cell = tableView.dequeueReusableCell(withIdentifier: ToggleSettingsCell.cellReuseIdentifier, for: indexPath) as! ToggleSettingsCell
            let title = toggleSettingsData[indexPath.row]
            cell.titleLabel.text = title
            return cell

        case .workSessions:
            let cell = tableView.dequeueReusableCell(withIdentifier: WorkSessionsRecordCell.cellReuseIdentifier, for: indexPath) as! WorkSessionsRecordCell
            return cell

        case .more(let moreSettingItems):
            let cell = tableView.dequeueReusableCell(withIdentifier: MoreSettingsCell.cellIdentifier, for: indexPath) as! MoreSettingsCell
            let title = moreSettingItems[indexPath.row]
            cell.configureTitle(with: title)
            return cell

        }
       
    }
    
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch settingsSection[indexPath.section] {
            
        case .siriShortCuts:
            return 95
            
        case .timerSettings:
            return 170

        case .toggleSettings:
            return 100

        case .workSessions:
            return 170

        case .more:
            return 70

        }
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch settingsSection[section] {
            
        case .siriShortCuts:
            return 1
            
        case .timerSettings(let timeSettingsItems):
            return timeSettingsItems.count

        case .toggleSettings(let toggleSettingsData):
            return toggleSettingsData.count

        case .workSessions:
            return 1

        case .more(let moreSettings):
            return moreSettings.count
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return settingsSection.count
    }
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let titleLabel = UILabel()
        let sectionTitle = settingsSection[section]
        
        titleLabel.text = "    \(sectionTitle.description)"
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .heavy)
        titleLabel.textColor = .appMainColor
        titleLabel.backgroundColor = .white
        return titleLabel
    }
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    
}



#if canImport(SwiftUI) && DEBUG
import SwiftUI

let deviceNames: [String] = [
    "iPhone SE (2nd generation)"
]

@available(iOS 13.0, *)
struct ViewController_Preview: PreviewProvider {
    static var previews: some View {
        ForEach(deviceNames, id: \.self) { deviceName in
            UIViewControllerPreview {
                SettingsVC()
            }.previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}
#endif

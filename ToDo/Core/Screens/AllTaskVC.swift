//
//  AllTaskVC.swift
//  ToDo
//
//  Created by Vishnu on 06/07/24.
//

import UIKit
import CoreLocation

class AllTaskVC: BaseViewController {
    
    private let locationManager = CLLocationManager()
    
    private let searchFieldView = SearchView()
    private var tableView: UITableView!
    private let filterView = FilterView()
    private let emptyView = EmptyView()
    
    var forecastIcon: UIImageView!
    var forecastLabel: Label!
    
    private let viewModel = AllTaskViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.theme.primaryColor
        
        locationSettings()
        addViews()
        setUpConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchTaskList()
    }
    
    // MARK: Location settings
    
    private func locationSettings() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        
        locationManager.startUpdatingLocation()
    }
    
    // MARK: Adding Sub Views
    
    private func addViews() {
        navConfiguration()
        addSearchFieldView()
        addFilterView()
        addTasksListView()
        addEmptyView()
    }
    
    private func navConfiguration() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        addAddButton()
        addForeCastViews()
    }
    
    private func addAddButton() {
        let rightButton = Button(frame: CGRect(x: 5, y: 5, width: 80, height: 40))
        rightButton.setTitle("Add", for: .normal)
        rightButton.setImage(UIImage(systemName: "plus"), for: .normal)
        rightButton.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButton)
    }
    
    private func addForeCastViews() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 120, height: 40))
        view.backgroundColor = .clear
        
        forecastIcon = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        forecastIcon.contentMode = .scaleAspectFit
        forecastIcon.tintColor = Colors.theme.textColor
        view.addSubview(forecastIcon)
        
        forecastLabel = Label(frame: CGRect(x: CGRectGetMaxX(forecastIcon.frame) + 7, y: 0, width: 80 - 7, height: 40))
        forecastLabel.textColor = Colors.theme.textColor
        forecastLabel.font = Fonts.boldBody
        view.addSubview(forecastLabel)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: view)
        
        viewModel.onForeCastUpdate = { [weak self] in
            self?.updateForeCastView()
        }
    }
    
    private func addSearchFieldView() {
        searchFieldView.delegate = self
        view.addSubview(searchFieldView)
    }
    
    private func addFilterView() {
        filterView.delegate = self
        view.addSubview(filterView)
    }
    
    private func addTasksListView() {
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "MyCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsVerticalScrollIndicator = false
        
        viewModel.onTaskListUpdate = { [weak self] in
            self?.tableView.reloadData()
            if self?.viewModel.taskList.count == 0 {
                self?.emptyView.setAsHidden(isHidden: false)
            } else {
                self?.emptyView.setAsHidden(isHidden: true)
            }
        }
        
        view.addSubview(tableView)
    }
    
    private func addEmptyView() {
        view.addSubview(emptyView)
        
        emptyView.setAsHidden(isHidden: true)
    }
    
    // MARK: Layout Contraints configuration
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            searchFieldView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            searchFieldView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            searchFieldView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            searchFieldView.heightAnchor.constraint(equalToConstant: 40),
            
            filterView.topAnchor.constraint(equalTo: searchFieldView.bottomAnchor, constant: 10),
            filterView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            filterView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            filterView.heightAnchor.constraint(equalToConstant: 40),
            
            tableView.topAnchor.constraint(equalTo: filterView.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            
            emptyView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            emptyView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            emptyView.widthAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.8)
        ])
    }
    
    private func updateForeCastView() {
        if let forecast = viewModel.forecast {
            forecastLabel.text = forecast.current.temperature2M.asDegreeCelcius()
            forecastIcon.image = CommonFunctions.covertWeatherCodeToImage(from: forecast.current.weatherCode)
        }
    }

}

// MARK: Location Delegate

extension AllTaskVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        viewModel.location = location.coordinate
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            print("Location access denied")
        case .authorizedWhenInUse, .authorizedAlways :
            locationManager.startUpdatingLocation()
        @unknown default:
            fatalError()
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get location: \(error.localizedDescription)")
    }
}

// MARK: Button Events

extension AllTaskVC {
    
    @objc private func addButtonPressed(sender: UIButton) {
        if let button = sender as? Button {
            button.animate()
        }
        
        let taskVC = TaskVC()
        navigationController?.pushViewController(taskVC, animated: true)
    }
    
}

// MARK: Handling Search Field

extension AllTaskVC: SearchViewDelegate {
    
    func search(searchText: String?) {
        if let text = searchText {
            viewModel.searchString = text.isEmpty ? nil : text
        } else {
            viewModel.searchString = nil
        }
    }
    
}

// MARK: TableView Delegates

extension AllTaskVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.taskList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath) as! TableViewCell
        let task = viewModel.taskList[indexPath.row]
        
        cell.title.text = task.title
        cell.note.text = task.taskDescription
        cell.date.text = "\(task.startDate.getStringFromDate(with: "dd MMM YY")) - \(task.endDate.getStringFromDate(with: "dd MMM YY"))"
        cell.setPriority(priority: task.priority)
        cell.setProgress(task.taskStatus)
        cell.setBoxNumber(number: indexPath.row + 1)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = viewModel.taskList[indexPath.row]
        print(task)
        let taskVC = TaskVC(with: task)
        navigationController?.pushViewController(taskVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            self.deleteTaskAtIndex(indexPath)
            completionHandler(true)
        }

        deleteAction.backgroundColor = Colors.theme.primaryColor
        deleteAction.image = nil
        deleteAction.title = nil
        deleteAction.image = createSwipeActionView(isDelete: true)
        
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteAction])
        swipeActions.performsFirstActionWithFullSwipe = false
        return swipeActions
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let task = viewModel.taskList[indexPath.row]
        if !task.taskStatus {
            let completeAction = UIContextualAction(style: .destructive, title: "Complete") { (action, view, completionHandler) in
                self.markTaskAsCompletedAtIndex(indexPath)
                completionHandler(true)
            }

            completeAction.backgroundColor = Colors.theme.primaryColor
            completeAction.image = nil
            completeAction.title = nil
            completeAction.image = createSwipeActionView(isDelete: false)
            
            let swipeActions = UISwipeActionsConfiguration(actions: [completeAction])
            swipeActions.performsFirstActionWithFullSwipe = false
            return swipeActions
        }
        return nil
    }
}

// MARK: FilterView Delegate

extension AllTaskVC: FilterViewDelegate {
    func sortOptionChanged(sortOption: SortOptions?) {
        viewModel.sortOption = sortOption
    }
}

// MARK: Utility functions

extension AllTaskVC {
    func createSwipeActionView(isDelete: Bool) -> UIImage? {
        
        let title = isDelete ? "Delete" : "Complete"
        let color = isDelete ? UIColor.systemRed : Colors.theme.textColor
        let icon = isDelete ? UIImage(systemName: "trash")  : UIImage(systemName: "checkmark.seal.fill")
        
        let font = Fonts.regularCaption!
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: color
        ]
        let attributedTitle = NSAttributedString(string: title, attributes: attributes)
        
        let customView = UIView(frame: CGRect(x: 0, y: 0, width: 75, height: 55))
        customView.backgroundColor = UIColor.clear
        customView.tintColor = color
        customView.layer.cornerRadius = 10
        customView.layer.masksToBounds = true
        
        let image = UIImageView(image: icon)
        image.frame = CGRect(x: Int((customView.frame.width - 35) / 2.0), y: 0, width: 35, height: 35)
        image.contentMode = .scaleAspectFit
        customView.addSubview(image)
        
        let titleLabel = UILabel()
        titleLabel.attributedText = attributedTitle
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.frame = CGRect(x: 0, y: CGRectGetMaxY(image.frame) + 5, width: customView.frame.width, height: 15)
        customView.addSubview(titleLabel)
        
        UIGraphicsBeginImageContextWithOptions(customView.bounds.size, false, UIScreen.main.scale)
        customView.layer.render(in: UIGraphicsGetCurrentContext()!)
        
        let buttonImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return buttonImage
    }
    
    func deleteTaskAtIndex(_ indexPath: IndexPath) {
        guard indexPath.row < viewModel.taskList.count else { return }
        let task = viewModel.taskList[indexPath.row]
        showActivityIndicator()
        viewModel.deleteTask(task: task) { [weak self] in
            self?.hideActivityIndicator()
        }
    }
    
    func markTaskAsCompletedAtIndex(_ indexPath: IndexPath) {
        guard indexPath.row < viewModel.taskList.count else { return }
        var task = viewModel.taskList[indexPath.row]
        task.taskStatus = true
        showActivityIndicator()
        viewModel.markTaskAsCompleted(task: task) { [weak self] in
            self?.hideActivityIndicator()
        }
    }
    
}

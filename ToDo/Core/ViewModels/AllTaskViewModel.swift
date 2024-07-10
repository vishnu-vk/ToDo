//
//  AllTaskViewModel.swift
//  ToDo
//
//  Created by Vishnu on 08/07/24.
//

import Foundation
import CoreLocation

class AllTaskViewModel {
    
    private let coreDataManager = CoreDataManager.instance
    private let weatherService = WeatherDataService.instance
    
    var originalTaskList: [Task] = []
    
    var onTaskListUpdate: (() -> Void)?
    var onForeCastUpdate: (() -> Void)?
    
    var taskList: [Task] = [] {
        didSet {
            DispatchQueue.main.async{ [weak self] in
                self?.onTaskListUpdate?()
            }
        }
    }
    
    var forecast: ForecastModel? = nil {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.onForeCastUpdate?()
            }
        }
    }
    
    var sortOption: SortOptions? = nil {
        didSet {
            filterAndSortTasks()
        }
    }
    
    var searchString: String? = nil {
        didSet {
            filterAndSortTasks()
        }
    }

    var location: CLLocationCoordinate2D? = nil {
        didSet {
            if let co = oldValue {
                if let lat = location?.latitude, let lon = location?.longitude {
                    if(abs(lat - co.latitude) > 0.1 || abs(lon - co.longitude) > 0.1) {
                        fetchWeatherData()
                    }
                }
            } else {
                fetchWeatherData()
            }
        }
    }
    
    init() {
        DispatchQueue.global(qos: .userInitiated).async {
            self.fetchTaskList()
        }
    }
    
    func fetchTaskList() {
        DispatchQueue.global(qos: .userInitiated).async {
            self.originalTaskList = self.coreDataManager.fetchAllTasks()
            self.filterAndSortTasks()
        }
    }
    
    func deleteTask(task: Task, completionHandler: @escaping () -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            self.coreDataManager.deleteTask(task: task)
            self.fetchTaskList()
            DispatchQueue.main.async {
                completionHandler()
            }
        }
    }
    
    func markTaskAsCompleted(task: Task, completionHandler: @escaping () -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            self.coreDataManager.updateTask(task: task)
            self.fetchTaskList()
            DispatchQueue.main.async {
                completionHandler()
            }
        }
    }
    
    private func filterAndSortTasks() {
        sortTasks(tasks: filterTasks())
    }
    
    private func filterTasks() -> [Task] {
        var filteredTasks: [Task] = originalTaskList
        if let text = searchString {
            filteredTasks = originalTaskList.filter({ task in
                return task.title.lowercased().contains(text.lowercased())
            })
        }
        return filteredTasks
    }
    
    private func sortTasks(tasks: [Task]) {
        var sortedTasksList: [Task]!
        
        switch(sortOption) {
            case .name:
                sortedTasksList = tasks.sorted { t1, t2 in
                    return t1.title.lowercased() < t2.title.lowercased()
                }
            case .startDate:
                sortedTasksList = tasks.sorted { t1, t2 in
                    return t1.startDate < t2.startDate
                }
            case .endDate:
                sortedTasksList = tasks.sorted { t1, t2 in
                    return t1.endDate < t2.endDate
                }
            case .priority:
                sortedTasksList = tasks.sorted { t1, t2 in
                    return t1.priority.priorityValue > t2.priority.priorityValue
                }
            default: sortedTasksList = tasks
        }
        
        taskList = sortedTasksList
    }
    
    private func fetchWeatherData() {
        guard let lattitude = location?.latitude, let longitude = location?.longitude else { return }
        weatherService.getWeatherData(for: lattitude, and: longitude) { forecastData in
            self.forecast = forecastData
        }
    }
    
}

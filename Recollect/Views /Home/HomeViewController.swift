//
//  HomeViewController.swift
//  Recollect
//
//  Created by student on 2022-07-22.
//
import UserNotifications
import UIKit
// Launch View Controller 
class HomeViewController: UIViewController {
    // Variables
    let notificationCenter = UNUserNotificationCenter.current()
    let myItems: String = "id_items"
    let user = UserDefaults()
    @IBOutlet var table: UITableView!
    // Model and to save reminders for UserDefaults
    var models = [myReminder]() {
        didSet {
            saveItems()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notificationCenter.requestAuthorization(options: [.sound, .badge, .alert]) { permissionGranted, error in
            if (!permissionGranted){
                print("Error")
            }
        }
        table.delegate = self
        table.dataSource = self
        getItems()

        // Do any additional setup after loading the view.
    }
    // Func to get previous reminders inputted in app
    // Decodes JSON data from saveItems function at bottom 
    func getItems () {
        guard
            let data = UserDefaults.standard.data(forKey: myItems),
            let savedItems = try? JSONDecoder().decode([myReminder].self, from: data)
        else {return}
        
        self.models = savedItems
        
    }
    
    
    @IBAction func refillBtn(_ sender: Any) {
        guard let cont = storyboard?.instantiateViewController(withIdentifier: "refill") as? RefillViewController else {
            return
        }
        cont.modalPresentationStyle = .fullScreen
        cont.modalTransitionStyle = .coverVertical
        present(cont, animated: true, completion: nil)    }
    

    
    
    // Add button
    @IBAction func didTapAdd() {

        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "add") as? AddViewController else {
            return
        }
        
        vc.title = "New Presciption"
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.completion = {title, body, date in
            DispatchQueue.main.async { [self] in
                self.navigationController?.popToRootViewController(animated: true)
                // To append new data
                let new = myReminder(title: title, body: body, date: date, identifer: "id_\(title)")
                self.models.append(new)
                self.table.reloadData()
                
                let content = UNMutableNotificationContent()
                content.title = title
                content.sound = .default
                content.body = body
                    
                // For notiftcaions for reminders
                let targetDate = date
                
                let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: targetDate),
                                                                repeats: false)
    
                
                    
                let request = UNNotificationRequest(identifier: "long id", content: content, trigger: trigger)
                
                UNUserNotificationCenter.current().add(request, withCompletionHandler: {error in
                    if error != nil {
                        print("Something went wrong")
                    }
                })

            }
        }
    
        
        navigationController?.pushViewController(vc, animated: true)
    
    }

//    @IBAction func sharePressed(_ sender: Any) {
//        let activityVC = UIActivityViewController(activityItems: [models], applicationActivities: nil)
//        activityVC.popoverPresentationController?.sourceView = self.view
//
//        self.present(activityVC, animated: true, completion: nil)
//    }
}


// Extension for UITableView
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        performSegue(withIdentifier: "trans", sender: nil)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    // Date Formatter
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = models[indexPath.row].title
        let date = models[indexPath.row].date
        let formatter = DateFormatter()
        let time = "HH:mm a"
        formatter.dateFormat = "MMMM dd, yyyy, \(time)"
        cell.detailTextLabel?.text = formatter.string(from: date)
        return cell
        
        
    }
    
    
    // Function to delete cells
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            models.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            tableView.endUpdates()
        }
    }
    
    // Save items function for User Defaults
    // Encode the data in JSON
    func saveItems() {
        if let encodedData = try? JSONEncoder().encode(models) {
            UserDefaults.standard.set(encodedData, forKey: myItems)
        }
    }
    
    
    
}


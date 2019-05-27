//
//  MyViewController.swift
//  HW 31-32 UITableView Editing
//
//  Created by Kirill Fedorov on 22/05/2019.
//  Copyright © 2019 Kirill Fedorov. All rights reserved.
//


//Задание.
//Ученик
//1. Создайте контроллер с таблицей в коде без сторибордов.
//2. Заполните таблицу данными на свое усмотрение
//3. Объедините данные в группы (секции)
//Студент.
//4. Реализуйте механизм перемещения данных между рядами и секциями
//5. Вы должны четко понимать что и как работает и в какой последовательности поэтому повторяйте задание пока вы полностью не освоите этот механизм
//Мастер.
//6. Реализуйте удаление рядов
//Супермен
//7. Реализуйте механзм добавления секций и рядов на ваше усмотрение

import UIKit

class MyViewController: UIViewController {
    
    var tableView = UITableView()
    var garageArray = [Garage]()
    
    override func loadView() {
        super.loadView()
        
        let frame = view.bounds
        let tableView = UITableView.init(frame: frame, style: UITableView.Style.grouped)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.delegate = self
        tableView.dataSource = self
        
        self.tableView = tableView
//        tableView.allowsSelectionDuringEditing = true
        
        view.addSubview(tableView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0...arc4random() % 10 {
            let garage = Garage()
            garage.name = "Garage #\(i)"
            garage.cars = [Car]()
            
            for _ in 0...arc4random() % 10 {
                garage.cars.append(Car.randomCar())
            }
            garageArray.append(garage)
        }
        tableView.reloadData()
        
        navigationItem.title = "AUTOPARK"
        let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(actionEdit))
        navigationItem.rightBarButtonItem = editButton
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(actionAdd))
        navigationItem.leftBarButtonItem = addButton
    }
    
    //MARK: - Actions
    @objc func actionEdit() {
        let isEditing = tableView.isEditing
        tableView.setEditing(!isEditing, animated: true)
        var barButtonItem = UIBarButtonItem.SystemItem.done
        
        if isEditing {
            barButtonItem = UIBarButtonItem.SystemItem.edit
        }
        
        let editButton = UIBarButtonItem(barButtonSystemItem: barButtonItem, target: self, action: #selector(actionEdit))
        navigationItem.rightBarButtonItem = editButton
    }
    
    @objc func actionAdd() {
        
        let garage = Garage()
        garage.name = "Garage #\(garageArray.count + 1)"
        garage.cars = [Car]()
        
        for _ in 0...arc4random() % 3 {
            garage.cars.append(Car.randomCar())
        }
        
        garageArray.insert(garage, at: 0)
        print(garageArray.count)
        
        tableView.beginUpdates()
        let inserSections = IndexSet(integer: 0)
        tableView.insertSections(inserSections, with: UITableView.RowAnimation.right)
        tableView.endUpdates()
        
        UIApplication.shared.beginIgnoringInteractionEvents()
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 0.3) {
            UIApplication.shared.endIgnoringInteractionEvents()
        }
    }
    
    //MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return garageArray.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return garageArray[section].name
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 + (garageArray[section].cars?.count ?? 0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        
        if indexPath.row == 0 {
            let addCarIdentifier = "AddCar"
            cell = tableView.dequeueReusableCell(withIdentifier: addCarIdentifier) ?? UITableViewCell(style: .default, reuseIdentifier: addCarIdentifier)
            cell.textLabel?.text = "Add new car"
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.textColor = .red
        } else {
            let carIdentifier = "CarCell"
            cell = tableView.dequeueReusableCell(withIdentifier: carIdentifier) ?? UITableViewCell(style: .value1, reuseIdentifier: carIdentifier)
            let car = garageArray[indexPath.section].cars[indexPath.row - 1]
            cell.textLabel?.text = "\(car.model) (Driver: \(car.driver))"
            cell.detailTextLabel?.text = "\(car.year)"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return indexPath.row != 0
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let sourceGrop = garageArray[sourceIndexPath.section]
        let car = sourceGrop.cars[sourceIndexPath.row - 1]
        
        if sourceIndexPath.section == destinationIndexPath.section {
            sourceGrop.cars.swapAt(sourceIndexPath.row - 1, destinationIndexPath.row - 1)
        } else {
            sourceGrop.cars.remove(at: sourceIndexPath.row - 1)
            let destinationGrop = garageArray[destinationIndexPath.section]
            destinationGrop.cars.insert(car, at: destinationIndexPath.row - 1)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            garageArray[indexPath.section].cars.remove(at: indexPath.row - 1)
            
            tableView.beginUpdates()
            let indexPathForDelete = IndexPath(item: indexPath.row, section: indexPath.section)
            tableView.deleteRows(at: [indexPathForDelete], with: UITableView.RowAnimation.left)
            tableView.endUpdates()
        }
    }
} //end of class

//MARK: - extension
extension MyViewController: UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return indexPath.row == 0 ? .none : .delete
    }
    
    func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        return proposedDestinationIndexPath.row == 0 ? sourceIndexPath : proposedDestinationIndexPath
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0 {
            garageArray[indexPath.section].cars.insert(Car.randomCar(), at: 0)
            
            tableView.beginUpdates()
            let newIndexPath = IndexPath(item: 1, section: indexPath.section)
            tableView.insertRows(at: [newIndexPath], with: UITableView.RowAnimation.left)
            tableView.endUpdates()
            
            UIApplication.shared.beginIgnoringInteractionEvents()
            DispatchQueue.main.asyncAfter(wallDeadline: .now() + 0.3) {
                UIApplication.shared.endIgnoringInteractionEvents()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "В УТИЛЬ"
    }
}


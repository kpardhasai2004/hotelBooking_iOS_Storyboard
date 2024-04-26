//
//  AddRegistrationTableViewController.swift
//  SRMHotel
//
//  Created by Avya Rathod on 24/01/24.
//

import UIKit

class AddRegistrationTableViewController: UITableViewController, SelectRoomTypeTableViewControllerDelegate {
    
    func SelectRoomTypeTableViewController(_ controller: SelectRoomTypeTableViewController, didselect roomType: RoomType) {
        self.roomType = roomType
        updateRoomType()
    }
    
    var registration:Registration?{
           guard let roomType = roomType else{
               return nil
           }
           let firstName = firstNameTF.text ?? ""
           let lastName = lastNameTF.text ?? ""
           let email = emailTF.text ?? ""
           let checkInDate = checkinDatePicker.date
           let checkOutDate = CheckoutDatePicker.date
           let numberOfAdults = Int(AdultStepper.value)
           let numberOfChildren = Int(ChildStepper.value)
           let hasWifi = wifiSwitch.isOn
           return Registration(firstName: firstName, lastName: lastName, emailAddress: email, checkInDate: checkInDate, checkOutDate: checkOutDate, numberOfAdults: numberOfAdults, numberOfChildren: numberOfChildren, wifi: hasWifi, roomType: roomType)
       }
    
    var roomType:RoomType?
    
    let checkinDPCellIndex = IndexPath(row: 1, section: 1)
    let checkoutDPCellIndex = IndexPath(row: 3, section: 1)
    var ischeckinDPVis:Bool = false{
        didSet{
            checkinDatePicker.isHidden = !ischeckinDPVis
        }
    }
    var ischeckoutDPVis:Bool = false{
        didSet{
            CheckoutDatePicker.isHidden = !ischeckoutDPVis
        }
    }
    
    let checkinLabelCellIndex = IndexPath(row: 0, section: 1)
    let checkoutLabelCellIndex = IndexPath(row: 2, section: 1)


    

    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var CheckinDateLabel: UILabel!
    @IBOutlet weak var checkinDatePicker: UIDatePicker!
    @IBOutlet weak var CheckoutDateLabel: UILabel!
    @IBOutlet weak var CheckoutDatePicker: UIDatePicker!
    
    
    @IBOutlet weak var adultCounter: UILabel!
    @IBOutlet weak var childCounter: UILabel!
    @IBOutlet weak var AdultStepper: UIStepper!
    @IBOutlet weak var ChildStepper: UIStepper!
    
    @IBOutlet weak var wifiSwitch: UISwitch!
    
    @IBOutlet weak var roomTypeLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let midnightToday = Calendar.current.startOfDay(for: Date())
        checkinDatePicker.minimumDate = midnightToday
        checkinDatePicker.date = midnightToday
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        updateDates()
        updateGuests()
        updateRoomType()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath{
            
        case
            checkinDPCellIndex where ischeckinDPVis == false:
            return 0
            
        case
            checkoutDPCellIndex where ischeckoutDPVis == false:
            return 0
        default:
            return UITableView.automaticDimension
            
        }
    }

    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath{
            
        case
            checkoutDPCellIndex:
            return 190
            
        case
            checkinDPCellIndex:
            return 190
        default:
            return UITableView.automaticDimension
            
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath == checkinLabelCellIndex && ischeckoutDPVis == false{
            ischeckinDPVis.toggle()
        }else if indexPath == checkoutLabelCellIndex && ischeckinDPVis == false{
            ischeckoutDPVis.toggle()
        }else if indexPath == checkinLabelCellIndex || indexPath == checkoutLabelCellIndex{
            ischeckinDPVis.toggle()
            ischeckoutDPVis.toggle()
        }else{
            return
        }
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    
    // MARK: - Table view data source

    

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func updateGuests(){
        adultCounter.text = "\(Int(AdultStepper.value))"
        childCounter.text = "\(Int(ChildStepper.value))"
    }

    func updateDates(){
        CheckoutDatePicker.minimumDate=Calendar.current.date(byAdding: .day, value: 1, to: checkinDatePicker.date)
        
        CheckinDateLabel.text = checkinDatePicker.date.formatted(date: .abbreviated,time:.omitted)
        CheckoutDateLabel.text = CheckoutDatePicker.date.formatted(date: .abbreviated,time:.omitted)
    }
    
//    @IBAction func doneBarButtonTapped(_ sender: UIBarButtonItem) {
//        let firstName = firstNameTF.text ?? ""
//        let lastName = lastNameTF.text ?? ""
//        let email = emailTF.text ?? ""
//        let checkinDate = checkinDatePicker.date
//        let checkoutDate = CheckoutDatePicker.date
//        
//        let childcount = childCounter.text
//        let adultcount = adultCounter.text
//        
//        let haswifi = wifiSwitch.isOn
//        let roomChoice = roomType?.name ?? "NOT SET"
//        
//        print("Done button tapped")
//        print("name: \(firstName) \(lastName), email: \(email)")
//        print("dates: \(checkinDate) - \(checkoutDate)")
//        
//        print("adults: \(String(describing: adultcount)) child: \(String(describing: childcount))")
//        print("wifi taken: \(haswifi)")
//        print("room selected: \(roomChoice)")
//    }
    
    func updateRoomType(){
        if let roomType = roomType{
            roomTypeLabel.text = roomType.name
        }else{
            roomTypeLabel.text = "NOT SET"
        }
    }
    
    
    @IBAction func datePickerValChange(_ sender: UIDatePicker){
        updateDates()
    }
    
    @IBAction func stepperValChange(_ sender: UIStepper){
        updateGuests()
    }
    
    @IBAction func wifiSwitchTapped(_ sender: UISwitch) {
    }
 
    @IBSegueAction func selectRoomType(_ coder: NSCoder, sender: Any?) -> SelectRoomTypeTableViewController? {
        let selectRoomTypeController = SRMHotel.SelectRoomTypeTableViewController(coder:coder)
        selectRoomTypeController?.delegate = self
        selectRoomTypeController?.roomType = roomType
        
        return selectRoomTypeController
    }
    
    
}

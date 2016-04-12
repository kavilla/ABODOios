//
//  mainViewController.swift
//  ABODOios
//  
//  Holds the tableView that contains all the apartments in the area.
//  The logic behind each cell is that if it doesn't have an image then it doesn't
//  show. I don't know if that is wanted but it seems logical.
//
//  Created by Kawika Avilla on 4/12/16.
//  Copyright © 2016 kawikaavilla. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage

class mainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var mainTable: UITableView!
    let mainTableCellIdentifer = "mainTableCell"
    var apartmentsArray = [apartment]()
    //end-point url
    let url = "https://www.abodo.com/search/get_property_results.json?lat=43.0752983&lng=-89.39389799999998&min_rent=&max_rent=&passed_search_area_text=Madison,%20WI%20Apartments"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTable.dataSource = self
        mainTable.delegate = self
        
        //for the delay
        let loadView = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
        loadView.center = self.view.center
        loadView.startAnimating()
        self.view.addSubview(loadView)
        mainTable.hidden = true
        
        // Do any additional setup after loading the view.
        Alamofire.request(.GET, url).responseJSON { (response) -> Void in
            if let value = response.result.value {
                let json = JSON(value)
                //print(json.array)
                if json != nil {
                    for jsonObject in json.array! {
                        var imageUrlString: String
                        var bedRange: String
                        var priceRange: String
                        var propertyName: String
                        bedRange = jsonObject["beds_range"].stringValue
                        priceRange = jsonObject["rent_range"].stringValue
                        propertyName = jsonObject["prop_display_name"].stringValue
                        imageUrlString = jsonObject["tile_url"].stringValue
                        //print("New apt object: $\(priceRange) BedRange: \(bedRange) PropName: \(propertyName) ImageUrl:\(imageUrlString)")
                        let newAptObject = apartment.init(propertyName: propertyName, bedRange: bedRange, priceRange: priceRange, imageUrlString: imageUrlString)
                        self.apartmentsArray.append(newAptObject)
                    }
                    loadView.stopAnimating()
                    loadView.removeFromSuperview()
                    self.mainTable.reloadData()
                    self.mainTable.hidden = false
                }
            }
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apartmentsArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(mainTableCellIdentifer) as! mainTableViewCell
        if(indexPath.row <= apartmentsArray.count){
            let apartmentObject = apartmentsArray[indexPath.row]
            let imageUrl = NSURL(string: apartmentObject.getImageUrlString())
            if let url = imageUrl {
                cell.propertyImageView.sd_setImageWithURL(url)
                cell.propertyNameLabel.text = apartmentObject.getPropertyName()
                cell.priceRangeLabel.text = apartmentObject.getPriceRange()
                cell.bedsRangeLabel.text = apartmentObject.getBedRange()
            }
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //segue here
        print(apartmentsArray[indexPath.row].getPropertyName())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

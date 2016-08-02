
import UIKit
import Alamofire

/**
 * Model that will create a hero object and store the
 * JSON data within that object. Then place that object into
 * an array of Heroes which will then be used to generate the
 * data to be displayed in each cell of the table for both the
 * CompHeroStats Controller & QuickHeroStats Controller.
 **/

@objc protocol HeroStatsModelDelegate{
    func heroStatsReady()
}

class HeroStatsModel: NSObject {
    
    var pickerData = [Hero]()
    
    var delegate:AnyObject?
    
    func getHeroes(platform:String, region:String, name:String, mode:String){
        
        /**
         * Since both Controllers will be getting data from this model
         * the delegate needs to assigned to the correct type.
         **/
        
        if(mode == "competitive-play"){
            delegate as? CompHeroStats
        }else{
            delegate as? QuickHeroStats
        }
        
        var URL:String = "https://api.lootbox.eu/"
        
        URL += platform + "/" + region + "/" + name + "/" + mode + "/heroes"
        
        Alamofire.request(.GET, URL)
            .responseJSON { response in
                print("Hero Response JSON: \(response.result.value)")
                
                if let JSON = response.result.value{
                    
                    var arrayOfObjects = [AnyObject]()
                    var arrayOfHeroes = [Hero]()
                    
                    arrayOfObjects = JSON as! NSArray as! [Hero]
                    
                    
                    
                    for(var i:Int = 0; i < arrayOfObjects.count; i += 1){
                        
                        let heroObject = Hero()
                        
                        if let imageData = arrayOfObjects[i].valueForKeyPath("image") as? String{
                            heroObject.heroImage = imageData
                        }else{
                            heroObject.heroImage = ""
                        }
                        
                        if let nameData = arrayOfObjects[i].valueForKeyPath("name") as? String{
                            heroObject.heroName = nameData
                        }else{
                            heroObject.heroName = ""
                        }
                        
                        if let playTimeData = arrayOfObjects[i].valueForKeyPath("playtime") as? String{
                            heroObject.heroPlayTime = playTimeData
                        }else{
                            heroObject.heroPlayTime = ""
                        }
                        
                        switch(heroObject.heroName){ //conform to API
                        case "Torbj&#xF6;rn":
                            heroObject.heroName = "Torbjörn"
                            break;
                        case "L&#xFA;cio":
                            heroObject.heroName = "Lúcio"
                            break;
                        case "Soldier76":
                            heroObject.heroName = "Soldier: 76"
                            break;
                        default:
                            break;
                        }
                        
                        arrayOfHeroes.append(heroObject)
                        
                    }
                    
                    if self.delegate != nil {
                        self.pickerData = arrayOfHeroes
                        self.delegate!.heroStatsReady()
                    }
                    
                }
        }
    }
}



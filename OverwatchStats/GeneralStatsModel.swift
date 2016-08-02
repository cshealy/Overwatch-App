
import UIKit
import Alamofire

/*
 * The Alamofire library grabs data asynchronously thus the
 * need to setup a protocol. The protocol is setup
 * so that the GeneralStats Controller
 * will be notified when the data is ready to be placed
 * on to the UI. Protocols make sure that our Controllers
 * conform.
 */
protocol GeneralStatsModelDelegate{
    func dataReady()
}

class GeneralStatsModel: NSObject {
    
    var player:Player? // Player info from last ViewController
    
    var delegate:ViewController?
    
    /**
     * Function sends uses the Alamofire library to access the JSON
     * for general statistics on the player.
     * After the information is received it is then sent to the
     * labels of the ViewController to confirm a valid player then sent to the
     * GeneralStats Controller.
     **/
    
    func getUserStats(platform:String, region:String, name:String){
        
        var URL:String = "https://api.lootbox.eu/"
        
        URL+=(platform + "/" + region + "/" + name + "/" + "profile")
        
        URL = URL.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        
        Alamofire.request(.GET, URL)
            .responseJSON { response in
                print("Response JSON: \(response.result.value)")
                
                
                if let JSON = response.result.value{
                    
                    let playerData:Player = Player()
                    
                    playerData.platform = platform
                    playerData.region = region
                    
                    if let name:String = JSON.valueForKeyPath("data.username") as? String{
                        playerData.name = name
                    }
                    
                    
                    if let level:Int = JSON.valueForKeyPath("data.level") as? Int{
                        playerData.level = String(level)
                    }
                    
                    /**
                     * Take the total quick-play wins & total quick-play games played.
                     * Then cast them for division/multiplication.
                     * Store result within quickWinPercentage.
                     * Display percentage by casting back to String.
                     **/
                    
                    var quickWins:String = ""
                    var totalQuickGames = ""
                    
                    if let qwins = JSON.valueForKeyPath("data.games.quick.wins") as? String{
                        quickWins = qwins
                    }
                    
                    if let totalQGames = JSON.valueForKeyPath("data.games.quick.played") as? String{
                        totalQuickGames = totalQGames
                    }
                    if(quickWins != "" && totalQuickGames != ""){
                        let quickWinPercentage:Int = Int((Double(quickWins)! / Double(totalQuickGames)!) * 100)
                        
                        let quickPercent = String(quickWinPercentage) + "%"
                        
                        
                        playerData.totalQWinPerc = quickPercent
                    }
                    
                    /**
                     * Take the total competitive-play wins & total competitive-play games played.
                     * Then cast them for division/multiplication.
                     * Store result within compWinPercentage.
                     * Display percentage by casting back to String.
                     **/
                    
                    var competitiveWins = ""
                    var totalCompGames = ""
                    
                    if let cWins:String = JSON.valueForKeyPath("data.games.competitive.wins") as? String{
                        competitiveWins = cWins
                    }
                    
                    if let totalCGames:String = JSON.valueForKeyPath("data.games.competitive.played") as? String{
                        totalCompGames = totalCGames
                    }
                    
                    if (competitiveWins != "" && totalCompGames != ""){
                        let compWinPercentage:Int = Int((Double(competitiveWins)! / Double(totalCompGames)!)*100)
                        
                        let compPercent:String = String(compWinPercentage) + "%"
                        playerData.totalCWinPerc = compPercent
                    }
                    
                    if let quickTime = JSON.valueForKeyPath("data.playtime.quick") as? String{
                        playerData.qTime = quickTime
                    }
                    
                    if let compTime = JSON.valueForKeyPath("data.playtime.competitive") as? String{
                        playerData.cTime = compTime
                    }
                    
                    if let avatarImageString:String = (JSON.valueForKeyPath("data.avatar") as? String){
                        
                        playerData.avatar = avatarImageString
                    }
                    
                    if let competitiveRank:String = JSON.valueForKeyPath("data.competitive.rank") as? String{
                        
                        playerData.compRank = competitiveRank
                    }
                    
                    
                    self.player = playerData
                    
                    if self.delegate != nil {
                        self.delegate!.dataReady()
                    }
                    
                }
        }
    }
}
import UIKit
import Alamofire


/**
 * Model will grab the JSON that is relevant to all
 * of the heroes. Hero specific stats will be implemented
 * at a later date.
 **/

protocol HeroDetailModelDelegate{
    func detailsReady()
}

class HeroDetailModel: NSObject{
    
    var heroData:Hero = Hero()
    
    var delegate:HeroDetailView?
    
    func getHeroDetails(URL:String, heroName:String){
        
        Alamofire.request(.GET, URL)
            .validate()
            .responseJSON { response in
                print("Hero Detail Response JSON: \(response.result.value)")
                
                if let JSON = response.result.value{
                    
                    if let winData = JSON.valueForKeyPath(heroName + ".WinPercentage") as? String{
                        self.heroData.winPercent = winData
                    }else{
                        self.heroData.winPercent = "0%"
                    }
                    
                    if let goldMedalData = JSON.valueForKeyPath(heroName + ".Medals-Gold") as? String{
                        self.heroData.goldMedalNum = goldMedalData
                    }else{
                        self.heroData.goldMedalNum = "0"
                    }
                    
                    if let silverMedalData = JSON.valueForKeyPath(heroName + ".Medals-Silver") as? String{
                        self.heroData.silverMedalNum = silverMedalData
                    }else{
                        self.heroData.silverMedalNum = "0"
                    }
                    
                    if let bronzeMedalData = JSON.valueForKeyPath(heroName + ".Medals-Bronze") as? String{
                        self.heroData.bronzeMedalNum = bronzeMedalData
                    }else{
                        self.heroData.bronzeMedalNum = "0"
                    }
                    
                    if let cards = JSON.valueForKeyPath(heroName + ".Cards") as? String{
                        self.heroData.cards = cards
                    }else{
                        self.heroData.cards = "0"
                    }
                    
                    if let dmgDone = JSON.valueForKeyPath(heroName + ".DamageDone") as? String{
                        self.heroData.dmgDone = dmgDone
                    }else{
                        self.heroData.dmgDone = "0"
                    }
                    
                    if let dmgDoneAvg = JSON.valueForKeyPath(heroName + ".DamageDone-Average") as? String{
                        self.heroData.dmgDoneAvg = dmgDoneAvg
                    }else{
                        self.heroData.dmgDoneAvg = "0"
                    }
                    
                    if let dmgMostGame = JSON.valueForKeyPath(heroName + ".DamageDone-MostinGame") as? String{
                        self.heroData.dmgDoneMostGame = dmgMostGame
                    }else{
                        self.heroData.dmgDoneMostGame = "0"
                    }
                    
                    if let dmgMostLife = JSON.valueForKeyPath(heroName + ".DamageDone-MostinLife") as? String{
                        self.heroData.dmgDoneMostLife = dmgMostLife
                    }else{
                        self.heroData.dmgDoneMostLife = "0"
                    }
                    
                    if let deaths = JSON.valueForKeyPath(heroName + ".Deaths") as? String{
                        self.heroData.deaths = deaths
                    }else{
                        self.heroData.deaths = "0"
                    }
                    
                    if let deathAvg = JSON.valueForKeyPath(heroName + ".Deaths-Average") as? String{
                        self.heroData.deathsAvg = deathAvg
                    }else{
                        self.heroData.deathsAvg = "0"
                    }
                    
                    if let eliminations = JSON.valueForKeyPath(heroName + ".Eliminations") as? String{
                        self.heroData.elim = eliminations
                    }else{
                        self.heroData.elim = "0"
                    }
                    
                    if let elimAvg = JSON.valueForKeyPath(heroName + ".Eliminations-Average") as? String{
                        self.heroData.elimAvg = elimAvg
                    }else{
                        self.heroData.elimAvg = "0"
                    }
                    
                    if let elimMostGame = JSON.valueForKeyPath(heroName + ".Eliminations-MostinGame") as? String{
                        self.heroData.elimMostGame = elimMostGame
                    }else{
                        self.heroData.elimMostGame = "0"
                    }
                    
                    if let elimMostLife = JSON.valueForKeyPath(heroName + ".Eliminations-MostinLife") as? String{
                        self.heroData.elimMostLife = elimMostLife
                    }else{
                        self.heroData.elimMostLife = "0"
                    }
                    
                    if let elimPerLife = JSON.valueForKeyPath(heroName + ".EliminationsperLife") as? String{
                        self.heroData.elimPerLife = elimPerLife
                    }else{
                        self.heroData.elimPerLife = "0"
                    }
                    
                    if let finalBlows = JSON.valueForKeyPath(heroName + ".FinalBlows") as? String{
                        self.heroData.finalBlows = finalBlows
                    }else{
                        self.heroData.finalBlows = "0"
                    }
                    
                    if let finalBlowsAvg = JSON.valueForKeyPath(heroName + ".FinalBlows-Average") as? String{
                        self.heroData.fBAvg = finalBlowsAvg
                    }else{
                        self.heroData.fBAvg = "0"
                    }
                    
                    if let finalBlowsMost = JSON.valueForKeyPath(heroName + ".FinalBlows-MostinGame") as? String{
                        self.heroData.fbMostGame = finalBlowsMost
                    }else{
                        self.heroData.fbMostGame = "0"
                    }
                    
                    if let gamesPlayed = JSON.valueForKeyPath(heroName + ".GamesPlayed") as? String{
                        self.heroData.gamesPlayed = gamesPlayed
                    }else{
                        self.heroData.gamesPlayed = "0"
                    }
                    
                    if let objKills = JSON.valueForKeyPath(heroName + ".ObjectiveKills") as? String{
                        self.heroData.objKills = objKills
                    }else{
                        self.heroData.objKills = "0"
                    }
                    
                    if let objKillsAvg = JSON.valueForKeyPath(heroName + ".ObjectiveKills-Average") as? String{
                        self.heroData.objKillsAvg = objKillsAvg
                    }else{
                        self.heroData.objKillsAvg = "0"
                    }
                    
                    if let objKillsMost = JSON.valueForKeyPath(heroName + ".ObjectiveKills-MostinGame") as? String{
                        self.heroData.objKillsMostGame = objKillsMost
                    }else{
                        self.heroData.objKillsMostGame = "0"
                    }
                    
                    if let objTime = JSON.valueForKeyPath(heroName + ".ObjectiveTime") as? String{
                        self.heroData.objTime = objTime
                    }else{
                        self.heroData.objTime = "0"
                    }
                    
                    if let objTimeAvg = JSON.valueForKeyPath(heroName + ".ObjectiveTime-Average") as? String{
                        self.heroData.objTimeAvg = objTimeAvg
                    }else{
                        self.heroData.objTimeAvg = "0"
                    }
                    
                    if let objTimeMost = JSON.valueForKeyPath(heroName + ".ObjectiveTime-MostinGame") as? String{
                        self.heroData.objTimeMostGame = objTimeMost
                    }else{
                        self.heroData.objTimeMostGame = "0"
                    }
                    
                    if let soloKills = JSON.valueForKeyPath(heroName + ".SoloKills") as? String{
                        self.heroData.soloKills = soloKills
                    }else{
                        self.heroData.soloKills = "0"
                    }
                    
                    if let soloKillsAvg = JSON.valueForKeyPath(heroName + ".SoloKills-Average") as? String{
                        self.heroData.soloKillsAvg = soloKillsAvg
                    }else{
                        self.heroData.soloKillsAvg = "0"
                    }
                    
                    if let soloKillsMost = JSON.valueForKeyPath(heroName + ".SoloKills-MostinGame") as? String{
                        self.heroData.soloKillsMostGame = soloKillsMost
                    }else{
                        self.heroData.soloKillsMostGame = "0"
                    }
                    
                    if let timeSpentOnFire = JSON.valueForKeyPath(heroName + ".TimeSpentonFire") as? String{
                        self.heroData.timeSpentOnFire = timeSpentOnFire
                    }else{
                        self.heroData.timeSpentOnFire = "0"
                    }
                }
                
                if self.delegate != nil {
                    self.delegate!.detailsReady()
                }
        }
    }
    
    
}
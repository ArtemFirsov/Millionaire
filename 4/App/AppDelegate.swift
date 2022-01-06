//
//  AppDelegate.swift
//  4
//
//  Created by Artem Firsov on 12/9/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let questionsKey = "questionKey"
        let questions: [Question] = [
                Question(questionText: "Сколько будет 2+2*2?", answersText: ["6", "12", "4", "84"], trueAnswer: 0),
                Question(questionText: "Сколько глаз  у пчелы?", answersText: ["2", "280", "5", "84"], trueAnswer: 2),
                Question(questionText: "Какая сейчас актуальная версия ОС Windows?", answersText: ["7", "10", "9", "11"], trueAnswer: 1)]
        do {
            let data = try? JSONEncoder().encode(questions)
            UserDefaults.standard.setValue(data, forKey: questionsKey)
        } catch {
            print(error)
        }
       
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}


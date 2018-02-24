//
//  DictionaryApiController.swift
//  Homework
//
//  Created by Stacy Chang on 2/23/18.
//  Copyright © 2018 Stacy Chang. All rights reserved.
//

import Foundation
import CoreData
import ObjectMapper

protocol ApiControllerProtocol {
    func didReceiveResults()
    func didReceiveError(statusCode: Int, error: String)
}

struct DirectoryUrl {
    static let directoryUrl = "mobile/interview/directory"
}

class DirectoryApiController {
    
    var baseApiUrl: String!
    var myDict: NSDictionary?
    var delegate: ApiControllerProtocol!
    
    init(delegate: ApiControllerProtocol) {
        self.delegate = delegate
        
        if let path = Bundle.main.path(forResource: "Info", ofType: "plist") {
            self.myDict = NSDictionary(contentsOfFile: path)
        }
        
    }
    
    func getDirectoryIndividuals(completionHandler: (() -> Void)?) {
        if let baseUrl = myDict?.value(forKey: "BaseApiUrl") {
            let path = "\(baseUrl)\(DirectoryUrl.directoryUrl)"
            getForObjectMapping(path: path, jsonResponseHandler: handleResponse(jsonAsString:completionHandler:), completionHandler: completionHandler)
        }
    }
    
    func getImageData(path: String, completionHandler: ((_ data: Data) -> Void)?) {
        let url = URL(string: path)
        let session =  URLSession.shared
        
        let task = session.dataTask(with: url!, completionHandler: {data, response, error -> Void in
            DispatchQueue.main.async(execute: {
                if data != nil {
                    if let handler = completionHandler {
                        handler(data!)
                    }
                }
            })
        })
        
        task.resume()
    }
    
    func fetchSentientBeingsFromLocalStore() -> [SentientBeing]? {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let request: NSFetchRequest<SentientBeing> = SentientBeing.fetchRequest()
            let firstNameSort = NSSortDescriptor(key: "firstName", ascending: true)
            request.sortDescriptors = [firstNameSort]
            let context = appDelegate.persistentContainer.viewContext
            do {
                let results = try context.fetch(request)
                return results
            } catch {
                print(error)
            }
        }
        return nil
    }
    
    fileprivate func getForObjectMapping(path: String, jsonResponseHandler: ((_ jsonAsString: String, _ completionHandler: (() -> Void)?) -> Void)?, completionHandler: (() -> Void)?) {
        let session =  URLSession.shared
        
        if let url = URL(string: path) {
            let task = session.dataTask(with: url, completionHandler: {data, response, error -> Void in
                DispatchQueue.main.async(execute: {
                    if let httpResponse = response {
                        let statusCode = (httpResponse as! HTTPURLResponse).statusCode
                        if (statusCode == 200) {
                            if let responseData = data {
                                let jsonAsString = NSString(data: responseData, encoding: String.Encoding.utf8.rawValue)! as String
                                if let handler = jsonResponseHandler {
                                    handler(jsonAsString, completionHandler)
                                }
                            } else {
                                self.delegate.didReceiveError(statusCode: statusCode, error: "No valid data response")
                            }
                        } else {
                            self.delegate.didReceiveError(statusCode: statusCode, error: "No server response found")
                        }
                    }
                    
                })
            })
            
            task.resume()
        }
        
    }
    
    fileprivate func handleResponse(jsonAsString: String,  completionHandler: (() -> Void)?) {
        if let directoryMap = Mapper<DirectoryMap>().map(JSONString: jsonAsString) {
            if let individuals = directoryMap.individuals {
                for individual in individuals {
                    insertOrUpdateIndividual(individual: individual)
                }
            }
        }
        delegate?.didReceiveResults()
        if let handler = completionHandler {
            handler()
        }
    }
    
    fileprivate func insertOrUpdateIndividual(individual: IndividualMap) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            var being = getIndividualForId(id: individual.id!)
            if being == nil {
                being = SentientBeing(context: appDelegate.persistentContainer.viewContext)
                being?.id = individual.id!
            }
            being?.firstName = individual.firstName
            being?.lastName = individual.lastName
            being?.birthdate = individual.birthdate
            being?.pictureUrl = individual.profileUrl
            being?.affiliation = individual.affiliation
            being?.forceSensitive = individual.forceSensitive ?? false
            appDelegate.saveContext()
        }
        
        
    }
    
    fileprivate func getIndividualForId(id: Int16) -> SentientBeing? {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let request: NSFetchRequest<SentientBeing> = SentientBeing.fetchRequest()
            request.predicate = NSPredicate(format: "id == %@", NSNumber(value: id))
            let context = appDelegate.persistentContainer.viewContext
            do {
                let results = try context.fetch(request)
                return results.first
            } catch {
                print(error)
            }
        }
        return nil
    }
}

//
//  PostController.swift
//  WhyIOS
//
//  Created by Kamil Wrobel on 9/5/18.
//  Copyright © 2018 Kamil Wrobel. All rights reserved.
//

import Foundation


class PostController {
    
    //MARK: - Singelton
    static let shared = PostController()
    
    private init() {}
    
    
    //MARK: - Source of Truth
    var posts: [Post] = []
    
    
    //MARK: - Base URL
    private let baseURL = URL(string:"https://whydidyouchooseios.firebaseio.com/reasons")
    
    
    //MARK: - Put Method
    
    func postReason(name: String, reason: String, cohort: String?, completion: @escaping (_ sucess: Bool) -> Void){
        
        guard let url = baseURL?.appendingPathExtension("json") else {
            fatalError("🍔 bad built url")
            
        }
        print("🍌\(url)")
        
        let post = Post(name: name, reason: reason, cohort: cohort)
        
        var urlRequest = URLRequest(url: url)
        
        do{
            let encodedPost = try JSONEncoder().encode(post)
            urlRequest.httpMethod = "PUT"
            urlRequest.httpBody = encodedPost
           
        }catch {
            print("There was an error Encoding Post on: \(#function): \(error) \(error.localizedDescription)")
            completion(false)
        }
        
        
        URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            if let error = error {
                print("🦑 Error during URLSession: \(error) \(error.localizedDescription)")
                completion(false)
                return
            }
            
            guard let data = data,
                let responseString = String(data: data, encoding: .utf8) else {
                
                completion(false)
                return
            }
            print(responseString)
            
            self.posts.append(post)
            
            completion(true)
            
        }.resume()
        
    }
    
    
    
    //MARK: - Fetch Method
    func fetchPosts(completion: @escaping(Post?) -> Void){
        
        guard let url = baseURL?.appendingPathExtension("json") else {
            fatalError("❌ bad built url")
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("📛 Error during URLSession: \(error) \(error.localizedDescription)")
                completion(nil)
                return
            }
            guard let data = data else {
                print("🔴 Error unwrapping Data: \(error), \(error?.localizedDescription)")
                completion(nil)
                return
            }
            do{
                let post = try JSONDecoder().decode(Post.self, from: data)
                self.posts.append(post)
                completion(post)
            } catch let error {
                print("☎️ There was an error decoding Data on \(#function): \(error) \(error.localizedDescription)")
            }
            
        }.resume()

    }

}

















//
//  JMUrlBuilder.swift
//  JustMyApp
//
//  Created by Viacheslav Obremsky on 7/26/18.
//  Copyright © 2018 Viacheslav Obremsky. All rights reserved.
//

//Flickr Creds
/* Key:
 292db38487874674cd0390d5b3849269
 
 Secret:
 61aa29fa9f093131
 */

import UIKit

class JMUrlBuilder: NSObject {
  
  let flickrUserId : String = "158502664@N06"
  let flickrKey : String = "292db38487874674cd0390d5b3849269"
  
  static let shared : JMUrlBuilder = JMUrlBuilder()
  
  func flickrUrl(with method : String) -> String{
    let url =  "https://api.flickr.com/services/rest/?method=\(method)&api_key=\(flickrKey)&user_id=\(flickrUserId)&format=json&nojsoncallback=?"
    return url
  }
  
  var  simpleFactsUrl : String{
    return "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts"
  }
  
}

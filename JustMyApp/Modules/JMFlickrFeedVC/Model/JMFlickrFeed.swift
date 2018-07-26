//
//  JMFlickrFeedItem.swift
//  JustMyApp
//
//  Created by Viacheslav Obremsky on 7/24/18.
//  Copyright © 2018 Viacheslav Obremsky. All rights reserved.
//

import UIKit

import Foundation

class JMFlickrFeed: Codable {
  let title, link, description, modified: String
  let generator: String
  let items: [Item]
  
  init(title: String, link: String, description: String, modified: String, generator: String, items: [Item]) {
    self.title = title
    self.link = link
    self.description = description
    self.modified = modified
    self.generator = generator
    self.items = items
  }
}

class Item: Codable {
  let title, link: String
  let media: Media
  let dateTaken, description, published, author: String
  let authorID, tags: String
  
  enum CodingKeys: String, CodingKey {
    case title, link, media
    case dateTaken = "date_taken"
    case description, published, author
    case authorID = "author_id"
    case tags
  }
  
  init(title: String, link: String, media: Media, dateTaken: String, description: String, published: String, author: String, authorID: String, tags: String) {
    self.title = title
    self.link = link
    self.media = media
    self.dateTaken = dateTaken
    self.description = description
    self.published = published
    self.author = author
    self.authorID = authorID
    self.tags = tags
  }
}

class Media: Codable {
  let m: String
  
  init(m: String) {
    self.m = m
  }
}

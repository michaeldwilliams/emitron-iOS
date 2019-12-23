/// Copyright (c) 2019 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import Foundation
import SwiftyJSON

enum PermissionOld: String, Codable {
  case streamBeginner = "stream-beginner-videos"
  case streamPro = "stream-professional-videos"
  case download = "download-videos"
  case none = ""
}

class PermissionsModel: Codable, Equatable {
  
  static func == (lhs: PermissionsModel, rhs: PermissionsModel) -> Bool {
    return lhs.id == rhs.id
      && lhs.name == rhs.name
      && lhs.tag == rhs.tag
      && lhs.createdAt == rhs.createdAt
      && lhs.updatedAt == rhs.updatedAt
  }
  
  // MARK: - Properties
  private(set) var id: Int = 0
  private(set) var name: String = ""
  private(set) var tag: PermissionOld = .none
  private(set) var createdAt: Date
  private(set) var updatedAt: Date
  
  // MARK: - Initializers
  // Default init—used for testing
  init(permission: PermissionOld = .none) {
    createdAt = Date()
    updatedAt = Date()
    tag = permission
  }
  
  init(_ jsonResource: JSONAPIResource,
       metadata: [String: Any]?) {
    
    self.id = jsonResource.id
    self.name = jsonResource["name"] as? String ?? ""
    if let tag = PermissionOld(rawValue: jsonResource["tag"] as? String ?? DomainLevel.none.rawValue) {
      self.tag = tag
    }
    
    if let createdAtStr = jsonResource["created_at"] as? String {
      self.createdAt = DateFormatter.apiDateFormatter.date(from: createdAtStr) ?? Date()
    } else {
      self.createdAt = Date()
    }
    
    if let updatedAtStr = jsonResource["updated_at"] as? String {
      self.updatedAt = DateFormatter.apiDateFormatter.date(from: updatedAtStr) ?? Date()
    } else {
      self.updatedAt = Date()
    }
  }
}

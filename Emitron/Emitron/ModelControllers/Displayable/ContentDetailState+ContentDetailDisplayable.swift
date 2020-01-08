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

extension ContentDetailState: ContentDetailDisplayable {
  // MARK:- Proxied from content
  var id: Int {
    content.id
  }
  
  var releasedAt: Date {
    content.releasedAt
  }
  
  var duration: Int {
    content.duration
  }
  
  var name: String {
    content.name
  }
  
  var descriptionPlainText: String {
    content.descriptionPlainText
  }
  
  var descriptionHtml: String {
    content.descriptionHtml
  }
  
  var professional: Bool {
    content.professional
  }
  
  var cardArtworkUrl: URL? {
    content.cardArtworkUrl
  }
  
  var contentType: ContentType {
    content.contentType
  }
  
  var ordinal: Int? {
    content.ordinal
  }
  
  var technologyTripleString: String {
    content.technologyTriple
  }
  
  var contentSummaryMetadataString: String {
    content.contentSummaryMetadataString
  }
  
  var contributorString: String {
    content.contributors
  }
  
  var groupId: Int? {
    content.groupId
  }
  
  var videoIdentifier: Int? {
    content.videoIdentifier
  }
  
  // MARK:- Proxied from Other Records
  var bookmarked: Bool {
    bookmark != nil
  }
  
  var parentName: String? {
    parentContent?.name
  }
  
  // MARK:- Evaluated
  var cardViewSubtitle: String {
    if domains.count == 1 {
      return domains.first!.name
    } else if domains.count > 1 {
      return "Multi-platform"
    }
    return ""
  }
  
  
  // MARK: - Converted to Display Properties
  var viewProgress: ContentViewProgressDisplayable {
    switch progression {
    case .none:
      return .notStarted
    case .some(let p) where p.finished:
      return .completed
    case .some(let p):
      return .inProgress(progress: p.progressProportion)
    }
  }
  
  var downloadProgress: DownloadProgressDisplayable {
    guard let download = download else { return .downloadable }

    switch download.state {
    case .cancelled, .error, .failed:
      return .notDownloadable
    case .enqueued, .pending, .urlRequested, .readyForDownload:
      return .enqueued
    case .inProgress:
      return .inProgress(progress: download.progress)
    case .complete:
      return .downloaded
    case .paused:
      return .downloadable
    }
  }
  
  
}

//
//  YoutubeSearchResponse.swift
//  Netflix
//
//  Created by Saadet Şimşek on 12/05/2024.
//

import Foundation

struct YoutubeSearchResponse: Codable {
    let items: [videoElement]
}

struct videoElement: Codable {
    let id: idvideoElement
}

struct idvideoElement: Codable {
    let kind: String
    let videoId: String
}

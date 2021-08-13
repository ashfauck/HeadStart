//
//  HSAttachmentsModel.swift
//  HeadStart
//
//  Created by ashfauck thaminsali on 13/08/21.
//  Copyright © 2021 Ashfauck. All rights reserved.
//

import Foundation

// MARK: - HSAttachmentsModel
@objcMembers class HSAttachmentsModel: NSObject, Codable
{
    var success: Bool?
    var attachments: [HSAttachment]?
    var message: String?

    enum CodingKeys: String, CodingKey {
        case success = "success"
        case attachments = "attachments"
        case message = "message"
    }
}


// MARK: - HSAttachment
@objcMembers public class HSAttachment: NSObject, Codable
{
    public var id: Int?
    public var name: String?
    public var type: String?
    public var url: String?
    public var path: String?
    public var document: String?
    public var success: Bool?

    enum CodingKeys: String, CodingKey
    {
        case id = "id"
        case name = "file_name"
        case type = "file_type"
        case url = "document"
        case path = "file_path"
        case document = "full_path"
        case success = "success"
    }
}

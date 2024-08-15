//
//  GSError.swift
//  GymShark
//
//  Created by hanif hussain on 15/08/2024.
//

import Foundation

enum GSError: String, Error {
    case invalidURL = "The URL is invalid. Please notify customer support."
    case unableToCompleteRequest = "Unable to complete request. Please try again later"
    case invalidResponseFromServer = "Invalid response from the server. Please try again."
    case parametersNil = "Parameters were nil"
    case encodingFailed = "Parameter Encoding failed"
    case decodingFailed = "Unable to Decode data"
    case missingURL = "The URL is nil"
    case couldNotParse = "Unable to parse the JSON response"
    case noData = "Data is nil"
    case fragmentResponse = "Response's body has fragments"
    case authenticationError = "Incorrect username or password"
    case badRequest = "Bad request. Please try again."
    case pageNotFound = "Page not found"
    case failed = "Request failed"
    case serverError = "Server error"
    case noResponse = "No response"
    case success = "Success"
}

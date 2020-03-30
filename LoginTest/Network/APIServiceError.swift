//
//  APIServiceError.swift
//  LoginTest
//
//  Created by Kevin Torres on 29-03-20.
//  Copyright © 2020 Kevin Torres. All rights reserved.
//

import Foundation

enum APIServiceError: Error {
    case responseError
    case parseError(Error)
}

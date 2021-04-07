//
//  HTTPRequestRetrier.swift
//  ZConcept
//
//  Created by Alexey Papin on 26/10/2019.
//  Copyright © 2019 Alexey Papin. All rights reserved.
//

import Alamofire

protocol HTTPRequestRetrier: Alamofire.RequestRetrier {
    typealias HTTPRequestRetrierCompletion = (_ shouldRetry: Bool, _ timeDelay: TimeInterval) -> Void
    
    func should(retry task: URLSessionTask?, completion: @escaping HTTPRequestRetrierCompletion)
}

extension HTTPRequestRetrier {
    func should(_ session: Session, retry request: Request, with error: Error, completion: @escaping HTTPRequestRetrierCompletion) {
        self.should(retry: request.task) {
            shouldRetry, timeDelay in
            
            completion(shouldRetry, timeDelay)
        }
    }
}

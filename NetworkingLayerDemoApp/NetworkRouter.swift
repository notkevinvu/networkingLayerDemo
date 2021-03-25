//
//  NetworkingLayer.swift
//  NetworkingLayerDemoApp
//
//  Created by Kevin Vu on 3/25/21.
//

import Foundation

/*
 we use an enum to build out the components of a URL request via the
 URLComponents structure. Here is an example of a URL and a breakdown of its
 components:
 
 https:// shopicruit.myshopify.com /admin/collects.json ? page=1&collection_id=68424466488
 
 https://                       scheme
 shopicruit.myshopify.com       host (name)
 /admin/collects.json           path
 page=1&collection_id=#####     parameters
 
 
 we will store each part as a variable within the enum
 */
 
enum Router {
     // pretty self-explanatory. We have three cases where each will represent
     // the request endpoint we want to send to the API
    case getSources,
         getProductIDs,
         getProductInfo
    
    // MARK: - Scheme
    var scheme: String {
        switch self {
        case .getSources, .getProductIDs, .getProductInfo:
            // we use https for all cases
            return "https"
        }
    }
    
    // MARK: - Host
    var host: String {
        switch self {
        case .getSources, .getProductIDs, .getProductInfo:
            /*
             all cases also use the same path
             
             a scenario where an endpoint might use a different host is if we
             request some data from one endpoint (some json) that also needs
             larger files/data like images or videos. The images or videos
             may not come as binary data in the initial response, but as links
             to a different server or host that contains the resources/assets
             */
            return "shopicruit.myshopify.com"
        }
    }
    
    // MARK: - Path
    var path: String {
        switch self {
        case .getSources:
            return "/admin/custom_collections.json"
        case .getProductIDs:
            return "/admin/collects.json"
        case .getProductInfo:
            return "/admin/products.json"
        }
    }
    
    // MARK: - Parameters
    var parameters: [URLQueryItem] {
        let accessToken = "c32313df0d0ef512ca64d5b336a0d7c6"
        
        // we keep a list of constants (maybe better to store as a dict?)
        // for easy access when building URLQueryItems
        let pageConstant = "page"
        let accessTokenConstant = "access_token"
        let collectionIDConstant = "collection_id"
        let productIDsConstant = "ids"
        
        // we return an array of URLQueryItems so that swift takes care of
        // putting it all together for us, since parameters are separated by "&"
        switch self {
        case .getSources:
            return [URLQueryItem(name: pageConstant, value: "1"),
                    URLQueryItem(name: accessTokenConstant, value: accessToken)]
        case .getProductIDs:
            return [URLQueryItem(name: pageConstant, value: "1"),
                    URLQueryItem(name: collectionIDConstant, value: "68424466488"),
                    URLQueryItem(name: accessTokenConstant, value: accessToken)]
        case .getProductInfo:
            return [URLQueryItem(name: productIDsConstant, value: "2759162243,2759143811"),
                    URLQueryItem(name: pageConstant, value: "1"),
                    URLQueryItem(name: accessTokenConstant, value: accessToken)]
        }
    }
    
    // MARK: - Method
    var method: String {
        switch self {
        // in this scenario, all we are doing is fetching data from the endpoint
        // so all cases will be of the "GET" method. However, the default method
        // for URL requests is GET anyway, so theoretically if you only had
        // GET requests, we wouldn't even need this method variable
        case .getSources, .getProductIDs, .getProductInfo:
            return "GET"
        }
    }
    
}

//
//  Provider.swift
//  Feathers
//
//  Created by Brendan Conron on 4/15/17.
//  Copyright © 2017 Swoopy Studios. All rights reserved.
//

import Foundation

public typealias FeathersCallback = (FeathersError?, Response?) -> ()

/// Abstract interface for a provider.
public protocol Provider: class {

    /// Provider's base url.
    var baseURL: URL { get }

    /// Used for any extra setup a provider needs. Called by the `Feathers` application.
    ///
    /// - Parameters:
    ///   - app: Feathers application object.
    func setup(app: Feathers)

    /// Send a request to the server.
    ///
    /// - Parameters:
    ///   - endpoint: Endpoint to hit.
    ///   - completion: Completion block.
    func request(endpoint: Endpoint, _ completion: @escaping FeathersCallback)

    /// Authenticate the provider.
    ///
    /// - Parameters:
    ///   - path: Authentication path.
    ///   - credentials: Credentials object for authentication.
    ///   - completion: Completion block.
    func authenticate(_ path: String, credentials: [String: Any], _ completion: @escaping FeathersCallback)

    /// Logout the provider.
    ///
    /// - Parameter path: Logout path.
    /// - Parameter completion: Completion block.
    func logout(path: String, _ completion: @escaping FeathersCallback)

}

/// A `Provider` that can supply a stream of real-time events.
public protocol RealTimeProvider: Provider {

    /// Register to listen for an event.
    ///
    /// - Parameters:
    ///   - event: Event name.
    ///   - callback: Event callback. Called every time an event sends.
    ///
    /// - warning: Events will continue to emit until `off` is called.
    func on(event: String, callback: @escaping ([String: Any]) -> ())

    /// Register for single-use handler for the event.
    ///
    /// - Parameters:
    ///   - event: Event name.
    ///   - callback: Event callback, only called once.
    func once(event: String, callback: @escaping ([String: Any]) -> ())

    /// Unregister for an event. Must be called to end the stream.
    ///
    /// - Parameter event: Event name.
    func off(event: String)

}

//
//  CreateSubscriptionViewModel.swift
//  moss
//
//  Created by Yufeng Guo on 15/12/2017.
//  Copyright © 2017 Yufeng Guo. All rights reserved.
//

import UIKit

extension CreateSubscriptionViewController {
    
    class ViewModel {
        private let subscription: Subscription
        
        var name: String? {
            get {
                if subscription.name != nil{
                    return subscription.name
                }
                else {
                    return ""
                }
                
            }
            set {
                subscription.name = newValue
            }
        }
        
        var price: NSDecimalNumber? {
            get {
                return subscription.price
            }
            set {
                subscription.price = newValue
            }
        }
        
        init(subscription: Subscription) {
            self.subscription = subscription
        }
        
        func delete() {
            NotificationCenter.default.post(name: .deleteSubscriptionNotification, object: nil, userInfo: [ Notification.Name.deleteSubscriptionNotification : subscription ])
        }
    }
}

extension Notification.Name {
    static let deleteSubscriptionNotification = Notification.Name("delete subscription")
}

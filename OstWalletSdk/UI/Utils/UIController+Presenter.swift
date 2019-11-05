/*
 Copyright © 2019 OST.com Inc
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 */

import Foundation

public extension UIViewController {
    
    func pushViewControllerOn(_ pusher: UIViewController, animated:Bool = true) {
        var navViewController:UINavigationController?;
        if ( pusher is UINavigationController ) {
            navViewController = (pusher as! UINavigationController);
        } else {
            navViewController = pusher.navigationController;
        }
        navViewController?.interactivePopGestureRecognizer?.isEnabled = false
        navViewController?.pushViewController(self, animated: animated);
    }
    
    func isLastViewController() -> Bool {
        if (nil == self.navigationController ) {
            return false;
        }
        let navController = self.navigationController!;
        return self == navController.viewControllers.last;
    }
}

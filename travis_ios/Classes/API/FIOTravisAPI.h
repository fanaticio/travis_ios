//
//  FIOTravisAPI.h
//  travis_ios
//
//  Created by Kevin Disneur on 8/8/13.
//  Copyright (c) 2013 FanaticIO. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^FIOTravisAPIOperationBlock)(id);

@interface FIOTravisAPI : NSObject

+ (id)sharedInstance;

- (void)findOrganizationsForMember:(NSString *)member withOperationBlock:(FIOTravisAPIOperationBlock)operationBlock;

@end

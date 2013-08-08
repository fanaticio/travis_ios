//
//  FIOTravisAPI.m
//  travis_ios
//
//  Created by Kevin Disneur on 8/8/13.
//  Copyright (c) 2013 FanaticIO. All rights reserved.
//

#import "FIOTravisAPI.h"
#import <AFJSONRequestOperation.h>

typedef void (^FIOTravisAPISuccessResponse)(NSURLRequest *, NSHTTPURLResponse *, id);
typedef void (^FIOTravisAPIErrorResponse)(NSURLRequest *, NSHTTPURLResponse *, NSError *, id);

@implementation FIOTravisAPI

static FIOTravisAPI *sharedInstance;

+ (id)sharedInstance
{
    if (!sharedInstance) {
        sharedInstance = [[FIOTravisAPI alloc] init];
    }

    return sharedInstance;
}

- (void)findOrganizationsForMember:(NSString *)member withOperationBlock:(FIOTravisAPIOperationBlock)operationBlock
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.travis-ci.org/repos?member=%@", member]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    FIOTravisAPISuccessResponse success = ^(NSURLRequest *request, NSHTTPURLResponse *response, id json)
    {
        operationBlock([self buildTravisOrganizationsFromJSON:json]);
    };

    FIOTravisAPIErrorResponse error = ^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id json)
    {
        operationBlock([self buildTravisOrganizationsFromJSON:json]);
    };

    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                        success:success
                                                                                        failure:error];

    [operation start];
}

# pragma findOrganizationsForMember private methods

- (void)addRepositoryFromTravisRepository:(NSDictionary *)travisRepository inOrganizations:(NSMutableArray *)organizations
{
    NSDictionary *organization = [self findOrAddTravisOrganizationFromTravisRepository:travisRepository in:organizations];

    NSArray *organizationAndRepository = [self organizationAndRepositoryFromSlug:[travisRepository objectForKey:@"slug"]];
    NSString *description = [travisRepository objectForKey:@"description"];

    NSMutableDictionary *repository = [[NSMutableDictionary alloc] init];
    [repository setObject:organizationAndRepository[1] forKey:@"repository"];
    [repository setObject:description forKey:@"description"];
    [[organization objectForKey:@"repositories"] addObject:repository];
}

- (NSDictionary *)buildOrganizationWithName:(NSString *)name AndTravisRepository:(NSDictionary *)travisRepository
{
    NSMutableDictionary *organization = [[NSMutableDictionary alloc] init];
    [organization setObject:name forKey:@"name"];
    [organization setObject:[[NSMutableArray alloc] init] forKey:@"repositories"];

    return organization;
}

- (NSArray *)buildTravisOrganizationsFromJSON:json
{
    NSMutableArray *organizations = [[NSMutableArray alloc] init];
    for (NSDictionary *travisRepository in json) {
        [self addRepositoryFromTravisRepository:travisRepository inOrganizations:organizations];
    }

    return organizations;
}

- (NSDictionary *)findOrAddTravisOrganizationFromTravisRepository:(NSDictionary *)travisRepository in:(NSMutableArray *)organizations
{
    NSArray *organizationAndRepository = [self organizationAndRepositoryFromSlug:[travisRepository objectForKey:@"slug"]];
    NSString *organizationName = organizationAndRepository[0];

    NSDictionary *organization = [self findOrganizationByName:organizationName in:organizations];
    if (!organization) {
        organization = [self buildOrganizationWithName:organizationName AndTravisRepository:travisRepository];
        [organizations addObject:organization];
    }

    return organization;
}

- (NSDictionary *)findOrganizationByName:(NSString *)name in:(NSArray *)organizations
{
    for (NSDictionary *organization in organizations) {
        if ([[organization objectForKey:@"name"] isEqualToString:name]) {
            return organization;
        }
    }

    return nil;
}

- (NSArray *)organizationAndRepositoryFromSlug:(NSString *)slug
{
    return [slug componentsSeparatedByString:@"/"];
}

@end

//
//  YYBRequestHelper.h
//  Mantu-iOS
//
//  Created by Aokura on 2018/7/31.
//  Copyright © 2018年 Mantu,Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

typedef void (^ YYBResponseSuccessHandler)(id responseObject, NSDictionary *params);
typedef void (^ YYBResponseErrorHandler)(NSError *error, NSDictionary *params);

@interface YYBRequestHelper : NSObject

+ (YYBRequestHelper *)sharedHelper;
@property (nonatomic,copy) void (^ handleManagerHandler)(AFHTTPSessionManager *manager);

- (void)GET:(NSString *)URLString params:(NSDictionary *)params configureHandler:(void(^)(AFHTTPSessionManager * manager))configureHandler successHandler:(YYBResponseSuccessHandler)successHandler errorHandler:(YYBResponseErrorHandler)errorHandler;

- (void)POST:(NSString *)URLString params:(NSDictionary *)params configureHandler:(void(^)(AFHTTPSessionManager * manager))configureHandler successHandler:(YYBResponseSuccessHandler)successHandler errorHandler:(YYBResponseErrorHandler)errorHandler;

- (void)POSTFormDataWithURLString:(NSString *)URLString params:(NSDictionary *)params images:(NSArray *)images successHandler:(YYBResponseSuccessHandler)successHandler errorHandler:(YYBResponseErrorHandler)errorHandler;

@end

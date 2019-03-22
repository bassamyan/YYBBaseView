//
//  YYBRequestHelper.m
//  Mantu-iOS
//
//  Created by Aokura on 2018/7/31.
//  Copyright © 2018年 Mantu,Inc. All rights reserved.
//

#import "YYBRequestHelper.h"
#import "NSDictionary+Sign.h"

@implementation YYBRequestHelper

static NSString * const kServerImagePath = @"file";

+ (YYBRequestHelper *)sharedHelper {
    static YYBRequestHelper *helper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[YYBRequestHelper alloc] init];
    });
    return helper;
}

- (void)GET:(NSString *)URLString params:(NSDictionary *)params configureHandler:(void (^)(AFHTTPSessionManager *))configureHandler successHandler:(YYBResponseSuccessHandler)successHandler errorHandler:(YYBResponseErrorHandler)errorHandler {
    AFHTTPSessionManager *manager = [self defaultSessionManager];
    
    if (configureHandler) {
        configureHandler(manager);
    }
    
    if (self.handleManagerHandler) {
        self.handleManagerHandler(manager);
    }
    
    NSError *error = nil;
    NSURLRequest *request = [[manager requestSerializer] requestWithMethod:@"GET" URLString:URLString parameters:params error:&error];
    
    if (error && errorHandler) {
        errorHandler(error,nil);
    } else {
        NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * response, id responseObject, NSError * error) {
            [manager invalidateSessionCancelingTasks:YES];
            NSLog(@"\n请求路径 == %@ \n请求参数 == %@ \nresponseObject = %@ \nerror = %@ \n",URLString,params,responseObject,error);
            
            [self serverHandleResponseWithReponseObject:responseObject error:error serverSuccessHandler:successHandler serverErrorHandler:errorHandler parameters:nil];
        }];
        [dataTask resume];
    }
}

- (void)POST:(NSString *)URLString params:(NSDictionary *)params configureHandler:(void (^)(AFHTTPSessionManager *))configureHandler successHandler:(YYBResponseSuccessHandler)successHandler errorHandler:(YYBResponseErrorHandler)errorHandler {
    NSAssert(URLString, @"请求URL路径不能为空");
    
    AFHTTPSessionManager *manager = [self defaultSessionManager];
    ((AFJSONResponseSerializer *)manager.responseSerializer).removesKeysWithNullValues = YES;
    
    if (self.handleManagerHandler) {
        self.handleManagerHandler(manager);
    }
    
    NSError *error = nil;
    NSURLRequest *request = [[manager requestSerializer] requestWithMethod:@"POST" URLString:URLString parameters:params error:&error];
    
    if (error && errorHandler) {
        errorHandler(error,params);
    } else {
        NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * response, id responseObject, NSError * error) {
            [manager invalidateSessionCancelingTasks:YES];
            NSLog(@"\n请求路径 == %@",URLString);
            NSLog(@"\n请求参数 == %@",params);
            NSLog(@"\nresponseObject = %@",responseObject);
            NSLog(@"\nerror = %@",error);
            
            [self serverHandleResponseWithReponseObject:responseObject error:error serverSuccessHandler:successHandler serverErrorHandler:errorHandler parameters:params];
        }];
        [dataTask resume];
    }
}

- (void)POSTFormDataWithURLString:(NSString *)URLString params:(NSDictionary *)params images:(NSArray *)images successHandler:(YYBResponseSuccessHandler)successHandler errorHandler:(YYBResponseErrorHandler)errorHandler {
    NSAssert(URLString, @"请求URL路径不能为空");
    
    AFHTTPSessionManager *manager = [self defaultSessionManager];
    
    if (self.handleManagerHandler) {
        self.handleManagerHandler(manager);
    }
    
    NSError *error = nil;
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:URLString parameters:[self handleMultipartParameters:params] constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        for (UIImage *image in images) {
            if ([image isKindOfClass:[UIImage class]]) {
                NSData *data = [self compressImage:image toMaxFileSize:1024];
                [formData appendPartWithFileData:data name:kServerImagePath fileName:@".png" mimeType:@"image/png"];
            }
        }
    } error:&error];
    
    if (error && errorHandler) {
        errorHandler(error,params);
    } else {
        NSURLSessionUploadTask *dataTask = [manager uploadTaskWithStreamedRequest:request progress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
            [manager invalidateSessionCancelingTasks:YES];
            
            NSLog(@"\n请求路径 == %@",URLString);
            NSLog(@"\n请求参数 == %@",params);
            NSLog(@"\nresponseObject = %@",responseObject);
            NSLog(@"\nerror = %@",error);
            
            [self serverHandleResponseWithReponseObject:responseObject error:error serverSuccessHandler:successHandler serverErrorHandler:errorHandler parameters:params];
        }];
        [dataTask resume];
    }
}

- (void)serverHandleResponseWithReponseObject:(id)responseObject error:(NSError *)error serverSuccessHandler:(YYBResponseSuccessHandler)serverSuccessHandler serverErrorHandler:(YYBResponseErrorHandler)serverErrorHandler parameters:(NSDictionary *)parameters {
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
        NSDictionary *responseDict = (NSDictionary *)responseObject;
        if ([[responseDict allKeys] containsObject:@"status"]) {
            NSInteger code = [[responseDict objectForKey:@"status"] integerValue];
            if (code != 200) {
                NSString *errorString = [responseDict objectForKey:@"message"];
                NSError *serverError = [NSError errorWithDomain:@"" code:code userInfo:@{@"message":errorString}];
                if (serverErrorHandler) {
                    serverErrorHandler(serverError,parameters);
                }
            } else {
                if (serverSuccessHandler && !error) {
                    serverSuccessHandler(responseObject,parameters);
                }
            }
        } else {
            if (serverSuccessHandler && !error) {
                serverSuccessHandler(responseObject,parameters);
            }
        }
    } else if (error) {
        if (serverErrorHandler) {
            serverErrorHandler(error,parameters);
        }
    } else {
        if (serverSuccessHandler && !error) {
            serverSuccessHandler(responseObject,parameters);
        }
    }
}

- (AFHTTPSessionManager *)defaultSessionManager {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = 30;
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/*"]];
    
    return manager;
}

- (NSData *)compressImage:(UIImage *)image toMaxFileSize:(NSInteger)maxFileSize {
    CGFloat compression = 0.9f;
    CGFloat maxCompression = 0.1f;
    NSData *imageData = UIImageJPEGRepresentation(image, compression);
    while ([imageData length] > maxFileSize && compression > maxCompression) {
        compression -= 0.1;
        imageData = UIImageJPEGRepresentation(image, compression);
    }
    
    return imageData;
}

- (NSDictionary *)handleMultipartParameters:(NSDictionary *)parameters {
    NSMutableDictionary *dict = [NSMutableDictionary new];
    for (NSString *key in parameters.allKeys) {
        id value = [parameters objectForKey:key];
        if ([value isKindOfClass:[NSDictionary class]]) {
            [dict setObject:[value dictTransformToJSONStringWithParameters:value] forKey:key];
        } else {
            [dict setObject:value forKey:key];
        }
    }
    return dict;
}

@end

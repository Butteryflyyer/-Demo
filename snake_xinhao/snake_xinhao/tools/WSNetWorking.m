//
//  WSNetWorking.m
//  YuLinZhengFeng
//
//  Created by 王帅 on 16/2/3.
//  Copyright © 2016年 shuai. All rights reserved.
//

#import "WSNetWorking.h"
//#import <AFNetworking.h>
#import "AFNetworkActivityIndicatorManager.h"
#import "AFHTTPSessionManager.h"
//968633519   1077650429
#define VersionOnitunUrl @"https://itunes.apple.com/cn/lookup?id=1077650429"
#ifdef DEBUG
#define WSAppLog(s, ... ) NSLog( @"[%@：in line: %d]-->%@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define WSAppLog(s, ... )
#endif

static NSString *sg_privateNetworkBaseUrl = @"https://app.qiandaowei.com/qdw/";
static BOOL sg_isEnableInterfaceDebug = NO;
static BOOL sg_shouldAutoEncode = NO;
static NSDictionary *sg_httpHeaders = nil;
static WSResponseType sg_responseType = kWSResponseTypeJSON;
static WSRequestType  sg_requestType  = kWSRequestTypeJSON;

@implementation WSNetWorking

+ (void)updateBaseUrl:(NSString *)baseUrl{

    sg_privateNetworkBaseUrl = baseUrl;
}

+ (NSString *)baseUrl{

    return sg_privateNetworkBaseUrl;
}

+ (void)enableInterfaceDebug:(BOOL)isDebug{

    sg_isEnableInterfaceDebug = isDebug;
}

+ (BOOL)isDebug{

    return sg_isEnableInterfaceDebug;
}

+ (void)configResponseType:(WSResponseType)responseType{

    sg_responseType = responseType;
}

+ (void)configRequestType:(WSRequestType)requestType{

    sg_requestType = requestType;
}
+ (void)shouldAutoEncodeUrl:(BOOL)shouldAutoEncode{

    sg_shouldAutoEncode = shouldAutoEncode;
}

+ (BOOL)shouldEncode{

    return sg_shouldAutoEncode;
}
+ (void)configCommonHttpHeaders:(NSDictionary *)httpHeaders{

    sg_httpHeaders = httpHeaders;

}

+ (WSURLSessionTask *)getWithUrl:(NSString *)url
                         success:(WSResponseSuccess)success
                            fail:(WSResponseFail)fail{

    return [self getWithUrl:url params:nil success:success fail:fail];
}

+ (WSURLSessionTask *)getWithUrl:(NSString *)url
                          params:(NSDictionary *)params
                         success:(WSResponseSuccess)success
                            fail:(WSResponseFail)fail{

    return [self getWithUrl:url
                     params:params
                   progress:nil
                    success:success
                       fail:fail];

}
+ (WSURLSessionTask *)getWithUrl:(NSString *)url
                          params:(NSDictionary *)params
                        progress:(WSGetProgress)progress
                         success:(WSResponseSuccess)success
                            fail:(WSResponseFail)fail{

    return [self _requestWithUrl:url
                       httpMedth:1
                          params:params
                        progress:progress
                         success:success
                            fail:fail];
}
+ (WSURLSessionTask *)postWithUrl:(NSString *)url
                            params:(NSDictionary *)params
                           success:(WSResponseSuccess)success
                              fail:(WSResponseFail)fail {
    
  
    
    return [self postWithUrl:url params:params progress:nil success:success fail:fail];
}

+ (WSURLSessionTask *)postWithUrl:(NSString *)url
                            params:(NSDictionary *)params
                          progress:(WSPostProgress)progress
                           success:(WSResponseSuccess)success
                              fail:(WSResponseFail)fail {
    return [self _requestWithUrl:url
                       httpMedth:2
                          params:params
                        progress:progress
                         success:success
                            fail:fail];
}


+ (WSURLSessionTask *)_requestWithUrl:(NSString *)url
                            httpMedth:(NSUInteger)httpMedth
                               params:(NSDictionary *)params
                             progress:(WSDownloadProgress)progress
                              success:(WSResponseSuccess)success
                                 fail:(WSResponseFail)fail{

    AFHTTPSessionManager * manager = [self manager];

    if ([self baseUrl] == nil) {
        if ([NSURL URLWithString:url] == nil ) {
            WSAppLog(@"URLString无效，无法生成URL。可能是URL中有中文，请尝试Encode URL");
            return nil;
        }
    }
        else{
            if ([NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[self baseUrl],url]] == nil) {
                WSAppLog(@"URLString无效，无法生成URL。可能是URL中有中文，请尝试Encode URL");
                return nil;
            }
        
        }
        if ([self shouldEncode]) {
            url = [self encodeUrl:url];
        }
    WSURLSessionTask * session = nil;
    if (httpMedth == 1) {
        session = [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            if (progress) {
                progress(downloadProgress.completedUnitCount,downloadProgress.totalUnitCount);
            }
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self successResponse:responseObject callback:success];
            if ([self isDebug]) {
                [self logWithSuccessResponse:responseObject
                                         url:task.response.URL.absoluteString
                                      params:params];
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (fail) {
                fail(error);
            }
            if ([self isDebug]) {
                [self logWithFailError:error url:task.response.URL.absoluteString params:params];
            }
        }];
    }  else if (httpMedth == 2){
    
        session = [manager POST:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            if (progress) {
                progress(downloadProgress.completedUnitCount, downloadProgress.totalUnitCount);
            }
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self successResponse:responseObject callback:success];
            
            if ([self isDebug]) {
                [self logWithSuccessResponse:responseObject
                                         url:task.response.URL.absoluteString
                                      params:params];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (fail) {
                fail(error);
            }
            
            if ([self isDebug]) {
                [self logWithFailError:error url:task.response.URL.absoluteString params:params];
            }
        }];

    
    }
    return  session;
}

+ (WSURLSessionTask *)uploadFileWithUrl:(NSString *)url
                          uploadingFile:(NSString *)uploadingFile
                               progress:(WSUploadProgress)progress
                                success:(WSResponseSuccess)success
                                   fail:(WSResponseFail)fail{
    
    if ([NSURL URLWithString:uploadingFile] == nil) {
        WSAppLog(@"uploadingFile无效，无法生成URL。请检查待上传文件是否存在");
        return nil;
    }
    
    NSURL *uploadURL = nil;
    if ([self baseUrl] == nil) {
        uploadURL = [NSURL URLWithString:url];
    } else {
        uploadURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [self baseUrl], url]];
    }
    
    if (uploadURL == nil) {
        WSAppLog(@"URLString无效，无法生成URL。可能是URL中有中文或特殊字符，请尝试Encode URL");
        return nil;
    }
    
    if ([self shouldEncode]) {
        url = [self encodeUrl:url];
    }
    
    AFHTTPSessionManager *manager = [self manager];
    NSURLRequest *request = [NSURLRequest requestWithURL:uploadURL];
    WSURLSessionTask *session = [manager uploadTaskWithRequest:request fromFile:[NSURL URLWithString:uploadingFile] progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);
        }
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        [self successResponse:responseObject callback:success];
        
        if (error) {
            if (fail) {
                fail(error);
            }
            
            if ([self isDebug]) {
                [self logWithFailError:error url:response.URL.absoluteString params:nil];
            }
        } else {
            if ([self isDebug]) {
                [self logWithSuccessResponse:responseObject
                                         url:response.URL.absoluteString
                                      params:nil];
            }
        }
    }];
    
    return session;

}
+ (WSURLSessionTask *)uploadWithImage:(UIImage *)image
                                  url:(NSString *)url
                             filename:(NSString *)filename
                                 name:(NSString *)name
                             mimiType:(NSString *)mimiType
                           parameters:(NSDictionary *)parameters
                             progress:(WSUploadProgress)progress
                              success:(WSResponseSuccess)success
                                 fail:(WSResponseFail)fail{
    
    if ([self baseUrl] == nil) {
        if ([NSURL URLWithString:url] == nil) {
            WSAppLog(@"URLString无效，无法生成URL。可能是URL中有中文，请尝试Encode URL");
            return nil;
        }
    } else {
        if ([NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [self baseUrl], url]] == nil) {
            WSAppLog(@"URLString无效，无法生成URL。可能是URL中有中文，请尝试Encode URL");
            return nil;
        }
    }
    
    if ([self shouldEncode]) {
        url = [self encodeUrl:url];
    }
    
    AFHTTPSessionManager *manager = [self manager];
    WSURLSessionTask *session = [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *imageData = UIImageJPEGRepresentation(image, 1);
//        LxDBAnyVar(image);
        NSString *imageFileName = filename;
        if (filename == nil || ![filename isKindOfClass:[NSString class]] || filename.length == 0) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            imageFileName = [NSString stringWithFormat:@"%@.jpg", str];
        }
        
        // 上传图片，以文件流的格式
        [formData appendPartWithFileData:imageData name:name fileName:imageFileName mimeType:mimiType];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self successResponse:responseObject callback:success];
        
        if ([self isDebug]) {
            [self logWithSuccessResponse:responseObject
                                     url:task.response.URL.absoluteString
                                  params:parameters];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (fail) {
            fail(error);
        }
        
        if ([self isDebug]) {
            [self logWithFailError:error url:task.response.URL.absoluteString params:nil];
        }
    }];
    
    return session;

}
+ (WSURLSessionTask *)downloadWithUrl:(NSString *)url
                           saveToPath:(NSString *)saveToPath
                             progress:(WSDownloadProgress)progressBlock
                              success:(WSResponseSuccess)success
                                 fail:(WSResponseFail)fail{
    
    if ([self baseUrl] == nil) {
        if ([NSURL URLWithString:url] == nil) {
            WSAppLog(@"URLString无效，无法生成URL。可能是URL中有中文，请尝试Encode URL");
            return nil;
        }
    } else {
        if ([NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [self baseUrl], url]] == nil) {
            WSAppLog(@"URLString无效，无法生成URL。可能是URL中有中文，请尝试Encode URL");
            return nil;
        }
    }
    
    NSURLRequest *downloadRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    AFHTTPSessionManager *manager = [self manager];
    
    
    WSURLSessionTask *session = [manager downloadTaskWithRequest:downloadRequest progress:^(NSProgress * _Nonnull downloadProgress) {
        if (progressBlock) {
            progressBlock(downloadProgress.completedUnitCount, downloadProgress.totalUnitCount);
        }
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        return [NSURL URLWithString:saveToPath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (success) {
            success(filePath.absoluteString);
        }
    }];
    
    return session;

}
#pragma mark - Private
+ (AFHTTPSessionManager *)manager {
    // 开启转圈圈
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    AFHTTPSessionManager *manager = nil;;
    if ([self baseUrl] != nil) {
        manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:[self baseUrl]]];
    } else {
        manager = [AFHTTPSessionManager manager];
    }
    
    switch (sg_requestType) {
        case kWSRequestTypeJSON: {
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
            [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            break;
        }
        case kWSRequestTypePlainText: {
            manager.requestSerializer = [AFHTTPRequestSerializer serializer];
            break;
        }
        default: {
            break;
        }
    }
    
    switch (sg_responseType) {
        case kWSResponseTypeJSON: {
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
            break;
        }
        case kWSResponseTypeData: {
            manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
            break;
        }
        case kWSResponseTypeXML: {
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            break;
        }
        default: {
            break;
        }
    }
    
    manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    for (NSString *key in sg_httpHeaders.allKeys) {
        if (sg_httpHeaders[key] != nil) {
            [manager.requestSerializer setValue:sg_httpHeaders[key] forHTTPHeaderField:key];
        }
    }
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
                                                                              @"text/html",
                                                                              @"text/json",
                                                                              @"text/plain",
                                                                              @"text/javascript",
                                                                              @"text/xml",
                                                                    @"image/*"]];
    
    // 设置允许同时最大并发数量，过大容易出问题
    manager.operationQueue.maxConcurrentOperationCount = 3;
    return manager;
}
+ (void)logWithSuccessResponse:(id)response url:(NSString *)url params:(NSDictionary *)params {
    WSAppLog(@"\nabsoluteUrl: %@\n params:%@\n response:%@\n\n",
              [self generateGETAbsoluteURL:url params:params],
              params,
              [self tryToParseData:response]);
}

+ (void)logWithFailError:(NSError *)error url:(NSString *)url params:(NSDictionary *)params {
    WSAppLog(@"\nabsoluteUrl: %@\n params:%@\n errorInfos:%@\n\n",
              [self generateGETAbsoluteURL:url params:params],
              params,
              [error localizedDescription]);
}
// 仅对一级字典结构起作用
+ (NSString *)generateGETAbsoluteURL:(NSString *)url params:(NSDictionary *)params {
    if (params.count == 0) {
        return url;
    }
    
    NSString *queries = @"";
    for (NSString *key in params) {
        id value = [params objectForKey:key];
        
        if ([value isKindOfClass:[NSDictionary class]]) {
            continue;
        } else if ([value isKindOfClass:[NSArray class]]) {
            continue;
        } else if ([value isKindOfClass:[NSSet class]]) {
            continue;
        } else {
            queries = [NSString stringWithFormat:@"%@%@=%@&",
                       (queries.length == 0 ? @"&" : queries),
                       key,
                       value];
        }
    }
    
    if (queries.length > 1) {
        queries = [queries substringToIndex:queries.length - 1];
    }
    
    if (([url rangeOfString:@"http://"].location != NSNotFound
         || [url rangeOfString:@"https://"].location != NSNotFound)
        && queries.length > 1) {
        if ([url rangeOfString:@"?"].location != NSNotFound
            || [url rangeOfString:@"#"].location != NSNotFound) {
            url = [NSString stringWithFormat:@"%@%@", url, queries];
        } else {
            queries = [queries substringFromIndex:1];
            url = [NSString stringWithFormat:@"%@?%@", url, queries];
        }
    }
    
    return url.length == 0 ? queries : url;
}

+ (NSString *)encodeUrl:(NSString *)url{
    return [self hyb_URLEncode:url];
    
}
+ (id)tryToParseData:(id)responseData {
    if ([responseData isKindOfClass:[NSData class]]) {
        // 尝试解析成JSON
        if (responseData == nil) {
            return responseData;
        } else {
            NSError *error = nil;
            NSDictionary *response = [NSJSONSerialization JSONObjectWithData:responseData
                                                                     options:NSJSONReadingMutableContainers
                                                                       error:&error];
            
            if (error != nil) {
                return responseData;
            } else {
                return response;
            }
        }
    } else {
        return responseData;
    }
}

+ (void)successResponse:(id)responseData callback:(WSResponseSuccess)success {
    if (success) {
        success([self tryToParseData:responseData]);
    }
}

+ (NSString *)hyb_URLEncode:(NSString *)url {
    NSString *newString =
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)url,
                                                              NULL,
                                                              CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)));
    if (newString) {
        return newString;
    }
    
    return url;
}

#pragma mark -- Above if the package has a problem to try the simple package below it

+ (AFHTTPSessionManager *)postWithPostURL:(NSString *)url
                           withParameters:(id)parameters
                                 progress:(void (^)(NSProgress *))progress
                                  success:(void (^)(NSURLSessionDataTask *, id))success
                                  failure:(void (^)(NSURLSessionDataTask *, NSError * ))failure
{
    AFHTTPSessionManager *requestManager = [AFHTTPSessionManager manager];
    
    requestManager.requestSerializer.timeoutInterval = TIMEOUTT_POST;
    requestManager.requestSerializer.HTTPShouldHandleCookies = YES;
    requestManager.responseSerializer = [AFJSONResponseSerializer serializer];
    requestManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSMutableSet *acceptContentTypes = [NSMutableSet setWithSet:requestManager.responseSerializer.acceptableContentTypes];
    [acceptContentTypes addObject:@"text/plain"];
    [acceptContentTypes addObject:@"text/html"];
    [acceptContentTypes addObject:@"application/json"];
    requestManager.responseSerializer.acceptableContentTypes = acceptContentTypes;
    
    [requestManager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        progress(uploadProgress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(task,responseObject);
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(task,error);
            
        }
        
    }];
    return requestManager;
}

+ (AFHTTPSessionManager *)getWithPostURL:(NSString *)url
                          withParameters:(id)parameters
                                progress:(void (^)(NSProgress *))progress
                                 success:(void (^)(NSURLSessionDataTask *, id))success
                                 failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    AFHTTPSessionManager *requestManager = [AFHTTPSessionManager manager];
    
    requestManager.requestSerializer.timeoutInterval = TIMEOUTT_GET;
    requestManager.requestSerializer.HTTPShouldHandleCookies = YES;
    requestManager.responseSerializer = [AFJSONResponseSerializer serializer];
    requestManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSMutableSet *acceptContentTypes = [NSMutableSet setWithSet:requestManager.responseSerializer.acceptableContentTypes];
    [acceptContentTypes addObject:@"text/plain"];
    [acceptContentTypes addObject:@"text/html"];
    [acceptContentTypes addObject:@"application/json"];
    requestManager.responseSerializer.acceptableContentTypes = acceptContentTypes;
    
    [requestManager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        progress (downloadProgress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(task,responseObject);
            
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(task,error);
            
        }
        
    }];
    
    return requestManager;
}

+ (AFHTTPSessionManager *)postDataWithUrl:(NSString *)url
                               parameters:(id)parameters
                constructingBodyWithBlock:(void (^)(id<AFMultipartFormData>))formDataBlock
                                 progress:(void (^)(NSProgress *))progress
                                  success:(void (^)(NSURLSessionDataTask *, id))success
                                  failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    
    AFHTTPSessionManager * requestManager = [AFHTTPSessionManager manager];
    
    requestManager.requestSerializer.timeoutInterval = TIMEOUTT_GET;
    requestManager.requestSerializer.HTTPShouldHandleCookies = YES;
    requestManager.responseSerializer = [AFJSONResponseSerializer serializer];
    requestManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableSet *acceptContentTypes = [NSMutableSet setWithSet:requestManager.responseSerializer.acceptableContentTypes];
    [acceptContentTypes addObject:@"text/plain"];
    [acceptContentTypes addObject:@"text/html"];
    [acceptContentTypes addObject:@"application/json"];
    requestManager.responseSerializer.acceptableContentTypes = acceptContentTypes;
    
    [requestManager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        if (formDataBlock) {
            formDataBlock(formData);
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        progress(uploadProgress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(task,responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(task,error);
        }
        
    }];
    
    return requestManager;
}
+(void)checkAppVersionFromAppstoreAndShowAlert:(void(^)(NSString * successStr))success{

    [self getAppVersionFromAppstoreBlock:^(id lastVersion,id trackViewUrl) {
        
        if (!lastVersion) {
            return ;
        }
        
        NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
        NSString *currentVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
        if (![lastVersion isEqualToString:currentVersion] ) {
            success((NSString *)trackViewUrl);
           
        }
        else
        {
         
        }
    }];


}

+(void)getAppVersionFromAppstoreBlock:(void(^)(id lastVersion,id trackViewUrl))block{
    
    [self getWithUrl:VersionOnitunUrl success:^(id response) {
        if ([[response objectForKey:@"resultCount"]intValue]==1) {
            NSDictionary *releaseInfo=[[response objectForKey:@"results"] firstObject];
            
            NSString *lastVersion = [releaseInfo objectForKey:@"version"];
            NSString *trackViewUrl = [releaseInfo objectForKey:@"trackViewUrl"];
            block(lastVersion,trackViewUrl);
        }else{
            block(nil,nil);
        }
        
    } fail:^(NSError *error) {
    
    }];
    
    
    
}

@end

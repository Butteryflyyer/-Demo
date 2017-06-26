//
//  XHNetWorking.h
//  YuLinZhengFeng
//
//  Created by 信昊 on 16/2/3.
//  Copyright © 2016年 昊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AFNetworking.h"
typedef enum{
    
    TIMEOUTT_GET = 20,
    TIMEOUTT_POST = 20,
    
}TIMEOUTT;
/**
 *  下载进度
 *
 *  @param bytesRead                已下载的大小
 *  @param totalBytesRead           文件总大小
 *
 *
 */
typedef void (^XHDownloadProgress)(int64_t bytesRead,
                                   int64_t totalBytesRead);
typedef XHDownloadProgress XHGetProgress;
typedef XHDownloadProgress XHPostProgress;

/**
 *  上传进度
 *
 *  @param bytesWritten      已上传的大小
 *  @param totalBytesWritten 文件总大小
 *
 *
 */
typedef void (^XHUploadProgress)(int64_t bytesWritten,
                                 int64_t totalBytesWritten);


typedef NS_ENUM(NSUInteger,XHResponseType){

    kXHResponseTypeJSON = 1, //默认
    kXHResponseTypeXML = 2,  //XML
    // 特殊情况下，一转换服务器就无法识别的，默认会尝试转换成JSON，若失败则需要自己去转换
    kXHResponseTypeData = 3

};

typedef  NS_ENUM(NSUInteger,XHRequestType){

    kXHRequestTypeJSON = 1,      //默认
    kXHRequestTypePlainText = 2  //普通 text/html

};

@class NSURLSessionDataTask;

// 请勿直接使用NSURLSessionDataTask,以减少对第三方的依赖
// 所有接口返回的类型都是基类NSURLSessionTask，若要接收返回值
// 且处理，请转换成对应的子类类型
typedef NSURLSessionDataTask XHURLSessionTask;

/**
 *  请求成功的回调
 *
 *  @param response 服务器返回的数据类型  通常是字典
 *
 *
 */
typedef void (^XHResponseSuccess)(id response);

/**
 *  网络响应失败的回调
 *
 *  @param error 错误信息
 *
 *
 */
typedef void (^XHResponseFail)(NSError * error);

/**
 *  基于AFNetworking 3.0 的网络层封装类.
 */
@interface XHNetWorking : NSObject

/**
 *  用于指定网络请求接口的基础url，如：
 *  http://ylzf.jtwu.net/index.php?s=Home/或者http://222.39.240.226:10002/ffp/MemberInterface?action=
 *  通常在AppDelegate中启动时就设置一次就可以了。如果接口有来源
 *  于多个服务器，可以调用更新
 *
 *  @param baseUrl 网络接口的基础url
 */
//+ (void)updateBaseUrl:(NSString *)baseUrl;

/**
 *  对外公开可获取当前所设置的网络接口基础url
 *
 *  @return 当前基础url
 */
+ (NSString *)baseUrl;

/**
 *  开启或关闭接口打印信息
 *
 *  @param isDebug 开发期，最好打开，默认是NO
 */
+ (void)enableInterfaceDebug:(BOOL)isDebug;

/**
 *  返回格式，默认为JSON。若为XML或者PLIST请在全局修改一下
 *
 *  @param responseType 响应格式
 */
+ (void)configResponseType:(XHResponseType)responseType;

/**
 *  请求格式，默认为JSON。如果要求传XML或者PLIST，请在全局配置一下
 *
 *  @param requestType 请求格式
 */
+ (void)configRequestType:(XHRequestType)requestType;

/**
 *  开启或关闭是否自动将URL使用UTF8编码，用于处理链接中有中文时无法请求的问题
 *
 *  @param shouldAutoEncode YES or NO,默认为NO
 */
+ (void)shouldAutoEncodeUrl:(BOOL)shouldAutoEncode;

/**
 *  配置公共的请求头，只调用一次即可，通常放在应用启动的时候配置就可以了
 *
 *  @param httpHeaders 只需要将与服务器商定的固定参数设置即可
 */
+ (void)configCommonHttpHeaders:(NSDictionary *)httpHeaders;

/**
 *  GET请求接口，若不指定baseurl，可传完整的url
 *
 *  @param url     接口路径，如/path/getArticleList?categoryid=1
 *  @param success 接口成功请求到数据的回调
 *  @param fail    接口请求数据失败的回调
 *
 *  @return 返回的对象中有可取消请求的API
 */
+ (XHURLSessionTask *)getWithUrl:(NSString *)url
                         success:(XHResponseSuccess)success
                            fail:(XHResponseFail)fail;

/**
 *  GET请求接口，若不指定baseurl，可传完整的url
 *
 *  @param url     接口路径，如/path/getArticleList
 *  @param params  接口中所需要的拼接参数，如@{"categoryid" : @(12)}
 *  @param success 接口成功请求到数据的回调
 *  @param fail    接口请求数据失败的回调
 *
 *  @return 返回的对象中有可取消请求的API
 */
+ (XHURLSessionTask *)getWithUrl:(NSString *)url
                         params:(NSDictionary *)params
                        success:(XHResponseSuccess)success
                           fail:(XHResponseFail)fail;

+ (XHURLSessionTask *)getWithUrl:(NSString *)url
                         params:(NSDictionary *)params
                       progress:(XHGetProgress)progress
                        success:(XHResponseSuccess)success
                           fail:(XHResponseFail)fail;

/**
 *  POST请求接口，若不指定baseurl，可传完整的url
 *
 *  @param url     接口路径，如/path/getArticleList
 *  @param params  接口中所需的参数，如@{"categoryid" : @(12)}
 *  @param success 接口成功请求到数据的回调
 *  @param fail    接口请求数据失败的回调
 *
 *  @return 返回的对象中有可取消请求的API
 */
+ (XHURLSessionTask *)postWithUrl:(NSString *)url
                           params:(NSDictionary *)params
                          success:(XHResponseSuccess)success
                             fail:(XHResponseFail)fail;

+ (XHURLSessionTask *)postWithUrl:(NSString *)url
                            params:(NSDictionary *)params
                          progress:(XHPostProgress)progress
                           success:(XHResponseSuccess)success
                              fail:(XHResponseFail)fail;

/**
 *  图片上传接口，若不指定baseurl，可传完整的url
 *
 *  @param image      图片对象
 *  @param url        上传图片的接口路径，如/path/images/
 *  @param filename   给图片起一个名字，默认为当前日期时间,格式为"yyyyMMddHHmmss"，后缀为`jpg`
 *  @param name       与指定的图片相关联的名称，这是由后端写接口的人指定的，如imagefiles
 *  @param mimiType   默认为image/jpeg
 *  @param parameters 参数
 *  @param progress   上传进度
 *  @param success    上传成功回调
 *  @param fail       上传失败回调
 *
 *
 */
+ (XHURLSessionTask *)uploadWithImage:(UIImage *)image
                                  url:(NSString *)url
                             filename:(NSString *)filename
                                 name:(NSString *)name
                             mimiType:(NSString *)mimiType
                           parameters:(NSDictionary *)parameters
                             progress:(XHUploadProgress)progress
                              success:(XHResponseSuccess)success
                                 fail:(XHResponseFail)fail;

/**
 *  上传文件操作
 *
 *  @param url           上传路径
 *  @param uploadingFile 待上传文件的路径
 *  @param progress      上传进度
 *  @param success       上传成功回调
 *  @param fail          上传失败回调
 *
 *
 */
+ (XHURLSessionTask *)uploadFileWithUrl:(NSString *)url
                          uploadingFile:(NSString *)uploadingFile
                               progress:(XHUploadProgress)progress
                                success:(XHResponseSuccess)success
                                   fail:(XHResponseFail)fail;

/**
 *  下载文件
 *
 *  @param url        下载URL
 *  @param saveToPath 下载到哪个路径下
 *  @param progress   下载进度
 *  @param success    下载成功后的回调
 *  @param fail       下载失败后的回调
 *
 *  
 */
+ (XHURLSessionTask *)downloadWithUrl:(NSString *)url
                           saveToPath:(NSString *)saveToPath
                             progress:(XHDownloadProgress)progress
                              success:(XHResponseSuccess)success
                                 fail:(XHResponseFail)fail;


#pragma mark -- Above if the package has a problem to try the simple package below it

/**
 *  post 请求
 *
 *  @param url        url
 *  @param parameters parameters 上传的数据
 *  @param progress   progress description //
 *  @param success    success
 *  @param failure    failure
 *
 *  @return return value description
 */
+ (AFHTTPSessionManager *)postWithPostURL:(NSString *)url
                           withParameters:(id)parameters
                                 progress:(void (^)(NSProgress *  uploadProgress))progress
                                  success:(void (^)(NSURLSessionDataTask *  task, id  responseObject))success
                                  failure:(void (^)(NSURLSessionDataTask *  task, NSError *  error))failure;
/**
 *  get 请求
 *
 *  @param url        url
 *  @param parameters parameters description
 *  @param progress   progress description
 *  @param success    success description
 *  @param failure    failure description
 *
 *  @return return value description
 */
+ (AFHTTPSessionManager *)getWithPostURL:(NSString *)url
                          withParameters:(id)parameters
                                progress:(void (^)(NSProgress *  uploadProgress))progress
                                 success:(void (^)(NSURLSessionDataTask *  task, id  responseObject))success
                                 failure:(void (^)(NSURLSessionDataTask *  task, NSError *  error))failure;

+ (AFHTTPSessionManager *)postDataWithUrl:(NSString *)url
                               parameters:(id)parameters
                constructingBodyWithBlock:(void(^)(id<AFMultipartFormData>  formData) )formDataBlock
                                 progress:(void (^)(NSProgress *  uploadProgress))progress
                                  success:(void (^)(NSURLSessionDataTask *  task, id  responseObject))success
                                  failure:(void (^)(NSURLSessionDataTask *  task, NSError *  error))failure;

/**
 *  encode编码字符串  主要针对中文
 *
 *  @param url
 *
 *  @return 
 */
+ (NSString *)hyb_URLEncode:(NSString *)url;

/**
 *  检测app更新
 *
 *  @param success 如果有更新 返回iTunesStore 的下载地址
 */
+(void)checkAppVersionFromAppstoreAndShowAlert:(void(^)(NSString * successStr))success;


@end

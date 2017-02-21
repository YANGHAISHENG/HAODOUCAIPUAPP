//
//  YHSNetworkingService.h
//  XinLiFMDemo
//
//  Created by YANGHAISHENG on 16/4/5.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// 项目打包上线都不会打印日志
#ifdef DEBUG
#define NetLog(s, ... ) NSLog( @"[%@ in line %d] ===============>%@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define NetLog(s, ... )
#endif

/*
 *  下载进度
 *
 *  @param bytesRead                 已下载的大小
 *  @param totalBytesRead            文件总大小
 */
typedef void (^NetDownloadProgress)(int64_t bytesRead, int64_t totalBytesRead);

typedef NetDownloadProgress NetGetProgress;
typedef NetDownloadProgress NetPostProgress;


/*
 *  上传进度
 *
 *  @param bytesWritten              已上传的大小
 *  @param totalBytesWritten         总上传大小
 */
typedef void (^NetUploadProgress)(int64_t bytesWritten, int64_t totalBytesWritten);

typedef NS_ENUM(NSUInteger, NetResponseType) {
    kNetResponseTypeJSON = 1, // 默认
    kNetResponseTypeXML  = 2, // XML
    // 特殊情况下，一转换服务器就无法识别的，默认会尝试转换成JSON，若失败则需要自己去转换
    kNetResponseTypeData = 3
};

typedef NS_ENUM(NSUInteger, NetRequestType) {
    kNetRequestTypeJSON = 1, // 默认
    kNetRequestTypePlainText  = 2 // 普通text/html
};

@class NSURLSessionTask;

// 请勿直接使用NSURLSessionDataTask，以减少对第三方的依赖
// 所有接口返回的类型都是基类NSURLSessionTask，若要接收返回值
// 且处理，请转换成对应的子类类型
typedef NSURLSessionTask NetURLSessionTask;

// SJBResponseSuccess是响应成功的回调，返回的是字典，外部再转换成模型就可以了。
typedef void(^NetResponseSuccess)(id response);

// SJBResponseFail是响应失败的回调，只有一个NSError对象，外部可接收处理。
typedef void(^NetResponseFail)(NSError *error);


/*
 *  基于AFNetworking的网络层封装类.
 */
@interface YHSNetworkingService : NSObject

/*
 *  用于指定网络请求接口的基础url
 *  通常在AppDelegate中启动时就设置一次就可以了。
 *  如果接口有来源于多个服务器，可以调用更新
 *
 *  @param baseUrl 网络接口的基础url
 */
+ (void)updateBaseUrl:(NSString *)baseUrl;


/*
 *  对外公开可获取当前所设置的网络接口基础url
 *
 *  @param baseUrl 当前基础url
 */
+ (NSString *)baseUrl;


/*
 *	默认只缓存GET请求的数据，对于POST请求是不缓存的。如果要缓存POST获取的数据，需要手动调用设置
 *  对JSON类型数据有效，对于PLIST、XML不确定
 *
 *	@param isCacheGet	    默认为YES
 *	@param shouldCachePost	默认为NO
 */
+ (void)cacheGetRequest:(BOOL)isCacheGet shoulCachePost:(BOOL)shouldCachePost;

/*
 *	获取缓存总大小/bytes
 *
 *	@return 缓存大小
 */
+ (unsigned long long)totalCacheSize;

/**
 *	清除缓存
 */
+ (void)clearCaches;

/*
 *  对于网络请求回来的结果，如果没有一个格式化好的日志打印出来查看，就要通过断点一步步跟踪，然后打开出来看，这太麻烦。
 *  因此，这里提供了打印日志的私有API。默认是不开启打印日志的。
 *
 *  通常在AppDelegate中应用启动的代理方法中调用设置为开启就可以了。
 *  不过是否设置为开启，当应用以发布证书打包时，都不会打印日志，因为这里做了处理，可放心使用。
 *
 *  开启或关闭接口打印信息
 *
 *  @param isDebug 开发期间，最好打开，默认是NO
 */
+ (void)enableInterfaceDebug:(BOOL)isDebug;

/*
 *  请求与响应格式设置
 *  配置请求格式，默认为JSON。如果要求传XML或者PLIST，请在全局配置一下
 *
 *  @param requestType 配置请求格式，默认为JSON。如果要求传XML或者PLIST，请在全局配置一下
 *  @param responseType 配置返回格式，默认为JSON。若为XML或者PLIST请在全局修改一下
 *  @param shouldAutoEncode 默认为NO，是否自动encode url
 *  @param shouldCallbackOnCancelRequest 当取消请求时，是否要回调，默认为YES
 */
+ (void)configRequestType:(NetRequestType)requestType
             responseType:(NetResponseType)responseType
      shouldAutoEncodeUrl:(BOOL)shouldAutoEncode
  callbackOnCancelRequest:(BOOL)shouldCallbackOnCancelRequest;

/*
 *  配置返回格式，默认为JSON。若为XML或者PLIST请在全局修改一下
 *
 *  @param responseType 响应格式
 */
+ (void)configResponseType:(NetResponseType)responseType;

/*
 *  配置请求格式，默认为JSON。如果要求传XML或者PLIST，请在全局配置一下
 *
 *  @param requestType 请求格式
 */
+ (void)configRequestType:(NetRequestType)requestType;

/*
 *  考虑到网络请求接口中，有时候会有中文参数，这时候就会请求失败，因此我们要对这种类型的URL进行编码，否则请求会失败。
 *  这里是开启或者关闭自动将URL编码的接口，默认为NO，表示不开启。
 *
 *  开启或关闭是否自动将URL使用UTF8编码，用于处理链接中有中文时无法请求的问题
 *
 *  @param shouldAutoEncode YES or NO, 默认为NO
 */
+ (void)setShouldAutoEncodeUrl:(BOOL)shouldAutoEncode;


/*
 *  配置公共的请求头，只调用一次即可，通常放在应用启动的时候配置就可以了
 *
 *  @param httpHeaders 只需要将与服务器商定的固定参数设置即可
 */
+ (void)configCommonHttpHeaders:(NSDictionary *)httpHeaders;

/**
 *	取消所有请求
 */
+ (void)cancelAllRequest;

/**
 *	取消某个请求。如果是要取消某个请求，最好是引用接口所返回来的NetURLSessionTask对象，
 *  然后调用对象的cancel方法。如果不想引用对象，这里额外提供了一种方法来实现取消某个请求
 *
 *	@param url   URL，可以是绝对URL，也可以是path（也就是不包括baseurl）
 */
+ (void)cancelRequestWithURL:(NSString *)url;

/*
 *  GET请求接口，若不指定baseurl，可传完整的url
 *
 *  @param url           接口路径，如/path/getArticleList?categoryid=1
 *  @param refreshCache  是否刷新缓存。由于请求成功也可能没有数据，对于业务失败，只能通过人为手动判断
 *  @param success       接口成功请求到数据的回调
 *  @param fail          接口请求数据失败的回调
 *
 *  @return 返回的对象中有可取消请求的API
 */
+ (NetURLSessionTask *)getWithUrl:(NSString *)url
                     refreshCache:(BOOL)refreshCache
                          success:(NetResponseSuccess)success
                             fail:(NetResponseFail)fail;

/*
 *  GET请求接口，若不指定baseurl，可传完整的url
 *
 *  @param url           接口路径，如/path/getArticleList?categoryid=1
 *  @param refreshCache  是否刷新缓存。由于请求成功也可能没有数据，对于业务失败，只能通过人为手动判断
 *  @param params        接口中所需要的拼接参数，如@{"categoryid" : @(12)}
 *  @param success       接口成功请求到数据的回调
 *  @param fail          接口请求数据失败的回调
 *
 *  @return 返回的对象中有可取消请求的API
 */
+ (NetURLSessionTask *)getWithUrl:(NSString *)url
                     refreshCache:(BOOL)refreshCache
                           params:(NSDictionary *)params
                          success:(NetResponseSuccess)success
                             fail:(NetResponseFail)fail;


/*
 *  GET请求接口，若不指定baseurl，可传完整的url
 *
 *  @param url           接口路径，如/path/getArticleList?categoryid=1
 *  @param refreshCache  是否刷新缓存。由于请求成功也可能没有数据，对于业务失败，只能通过人为手动判断
 *  @param params        接口中所需要的拼接参数，如@{"categoryid" : @(12)}
 *  @param progress      进度回调
 *  @param success       接口成功请求到数据的回调
 *  @param fail          接口请求数据失败的回调
 *
 *  @return 返回的对象中有可取消请求的API
 */
+ (NetURLSessionTask *)getWithUrl:(NSString *)url
                     refreshCache:(BOOL)refreshCache
                           params:(NSDictionary *)params
                         progress:(NetGetProgress)progress
                          success:(NetResponseSuccess)success
                             fail:(NetResponseFail)fail;


/*
 *  POST请求接口，若不指定baseurl，可传完整的url
 *
 *  @param url           接口路径，如/path/getArticleList
 *  @param refreshCache  是否刷新缓存
 *  @param params        接口中所需的参数，如@{"categoryid" : @(12)}
 *  @param success       接口成功请求到数据的回调
 *  @param fail          接口请求数据失败的回调
 *
 *  @return 返回的对象中有可取消请求的API
 */
+ (NetURLSessionTask *)postWithUrl:(NSString *)url
                      refreshCache:(BOOL)refreshCache
                            params:(NSDictionary *)params
                           success:(NetResponseSuccess)success
                              fail:(NetResponseFail)fail;

/*
 *  POST请求接口，若不指定baseurl，可传完整的url
 *
 *  @param url           接口路径，如/path/getArticleList
 *  @param refreshCache  是否刷新缓存
 *  @param params        接口中所需的参数，如@{"categoryid" : @(12)}
 *  @param progress      进度回调
 *  @param success       接口成功请求到数据的回调
 *  @param fail          接口请求数据失败的回调
 *
 *  @return 返回的对象中有可取消请求的API
 */
+ (NetURLSessionTask *)postWithUrl:(NSString *)url
                      refreshCache:(BOOL)refreshCache
                            params:(NSDictionary *)params
                          progress:(NetPostProgress)progress
                           success:(NetResponseSuccess)success
                              fail:(NetResponseFail)fail;


/*
 *	图片上传接口，若不指定baseurl，可传完整的url
 *  接口一次只能上传一张图片，通常也是这么处理的。这里是以文件流的形式来上传的哦。其中，mineType为image/jpeg
 *
 *	@param image		图片对象
 *	@param url			上传图片的接口路径，如/path/images/
 *	@param filename		给图片起一个名字，默认为当前日期时间,格式为"yyyyMMddHHmmss"，后缀为`jpg`
 *	@param name			与指定的图片相关联的名称，这是由后端写接口的人指定的，如imagefiles
 *	@param mimeType		默认为image/jpeg
 *	@param parameters	参数
 *	@param progress		上传进度
 *	@param success		上传成功回调
 *	@param fail			上传失败回调
 *
 *	@return 返回类型有取消请求的API
 */
+ (NetURLSessionTask *)uploadWithImage:(UIImage *)image
                                   url:(NSString *)url
                              filename:(NSString *)filename
                                  name:(NSString *)name
                              mimeType:(NSString *)mimeType
                            parameters:(NSDictionary *)parameters
                              progress:(NetUploadProgress)progress
                               success:(NetResponseSuccess)success
                                  fail:(NetResponseFail)fail;

/*
 *	上传文件操作
 *
 *	@param url				上传路径
 *	@param uploadingFile	待上传文件的路径
 *	@param progress			上传进度
 *	@param success			上传成功回调
 *	@param fail				上传失败回调
 *
 *	@return
 */
+ (NetURLSessionTask *)uploadFileWithUrl:(NSString *)url
                           uploadingFile:(NSString *)uploadingFile
                                progress:(NetUploadProgress)progress
                                 success:(NetResponseSuccess)success
                                    fail:(NetResponseFail)fail;


/*
 *  下载文件
 *
 *  @param url           下载URL
 *  @param saveToPath    下载到哪个路径下
 *  @param progressBlock 下载进度
 *  @param success       下载成功后的回调
 *  @param failure       下载失败后的回调
 */
+ (NetURLSessionTask *)downloadWithUrl:(NSString *)url
                            saveToPath:(NSString *)saveToPath
                              progress:(NetDownloadProgress)progressBlock
                               success:(NetResponseSuccess)success
                               failure:(NetResponseFail)failure;

@end

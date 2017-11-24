//
//  PdfShowViewController.m
//  OnlinepdfDemo
//
//  Created by hun on 2017/8/7.
//  Copyright © 2017年 hun. All rights reserved.
//

#import "PdfShowViewController.h"
#import "WXApiRequestHandler.h"
@interface PdfShowViewController ()<UIWebViewDelegate>

@property(nonatomic,strong)UIWebView *webView ;//主要用作浏览在线页面的

@property(nonatomic,strong)UIButton *rightBtn;

@property(nonatomic,copy)NSString *savePath ;//缓存路径
@property(nonatomic,copy)NSData *data ;     //数据!

@property(nonatomic,assign)BOOL isFilePrint ;//是否用于打印的数据

@property(nonatomic,strong)NSDictionary *fileDic ;//设置file的Dic

@end

@implementation PdfShowViewController


-(void)setUrlStr:(NSString *)urlStr FileDic:(NSDictionary *)fileDic
{
    _urlStr = urlStr;
    _fileDic = fileDic;
    _isFilePrint = YES;
}


#pragma mark - public
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navTitleLabel.text = @"pdf预览";
    
    [self setupUI];
    
    [self loadWebData];
    
}

-(void)setupUI
{
    if (self.isShare)
    {
        [self.navigationBar addSubview:self.rightBtn];
        WEAK_SELF;
        [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.navigationBar).offset(-10);
            make.height.equalTo(weakSelf.navTitleLabel).multipliedBy(0.8);
            make.centerY.equalTo(weakSelf.navTitleLabel);
        }];

    }
}

-(void)requestGetSuccess:(NSUInteger)requestKey andResponse:(id)response error:(NSError*)error;
{
    [self.waitView hideAnimated:YES];
    //下载成功,并分享出去
    if (requestKey == WSS_DOWNLOAD_FILE)
    {
        self.data = response;
        [self fileShareAction];
    }else if(requestKey == WSS_PRODUCTCHECK_PDFFILEFORORDER)
    {
        self.data = response;
        [self fileShareAction];
    }
}



//分享文件
-(void)fileShareAction
{
    UIImage *thumbImage = [UIImageManager imageNamed:@"common_icon_pdf"];
    NSData *fileData = self.data;
    
    [WXApiRequestHandler sendFileData:fileData
                        fileExtension:@"pdf"
                                Title:[NSString stringWithFormat:@"%@.pdf",self.model.fileName]
                          Description:kMessageExt
                           ThumbImage:thumbImage
                              InScene:WXSceneSession];
}

//微信分享
-(void)webChatShareWebAction
{
    if (self.model == nil)
    {
        [APP_KEYWINDOW makeToast:@"程序有误,没有pdf数据"];
        return;
    }
    if (_isFilePrint) {
        
        [self sendGetDownloadRequestWithKey:WSS_PRODUCTCHECK_PDFFILEFORORDER params:self.fileDic];
        
    }else
    {
        [self.waitView showAnimated:YES];
        //这个是正常的可以下载的图片:R3ce96d4289664ea7b70868b77a346823
        NSDictionary *bodyDic = @{@"readKey":HNotNull(self.model.fileId)};
        //衡杰写的下载方法!
        [self sendGetDownloadRequestWithKey:WSS_DOWNLOAD_FILE params:bodyDic];
    }
    
}

//分享按钮
-(void)rightBtnAction
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请选择要分享的渠道" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"微信" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        if (self.data == nil)
        {
            [self webChatShareWebAction];
        }else
        {
            [self fileShareAction];
        }
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:deleteAction];
    [alert addAction:cancelAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

//页面加载!
-(void)loadWebData
{
    if (_urlStr||_model)
    {
        NSURL *url = nil;
        if (self.urlStr)
        {
            url = [NSURL URLWithString:_urlStr];
        }else
            url = [NSURL URLWithString:[ConstantOrder imgUrlWithReadkey:self.model.fileId]];

        NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
        [self.webView loadRequest:request];
    }else
    {
        [APP_KEYWINDOW makeToast:@"程序有误,请从新加载"];
    }
    //进行加载
    [self.waitView showAnimated:YES];
}



-(UIWebView *)webView
{
    if (!_webView)
    {
         UIWebView *webView = [UIWebView new];
        webView.delegate = self;
        webView.scalesPageToFit = YES;//实现放大!
        [self.view addSubview:webView];
        [webView mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.top.equalTo(self.navigationBar.mas_bottom);
            make.left.right.bottom.equalTo(self.view);
        }];
        
        _webView = webView;
    }
    return _webView;
}

#pragma mark - getter

-(UIButton *)rightBtn
{
    if (!_rightBtn) {
        UIButton *rightBtn = [UIButton new];
        rightBtn.backgroundColor = [UIColor clearColor];
        [rightBtn setTitle:@"分享" forState:UIControlStateNormal];
        [rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
        
        _rightBtn = rightBtn;
    }
    return _rightBtn;
}
#pragma mark - delegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //进行加载
    [self.waitView hideAnimated:YES];
}

@end

//
//  ViewController.m
//  加密
//
//  Created by 李自杨 on 2017/4/26.
//  Copyright © 2017年 View. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>
#import <CommonCrypto/CommonDigest.h>

@interface ViewController ()

@property (nonatomic, strong) UITextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createUI];
    
}

-(void)createUI{

    //输入框
    _textField = [[UITextField alloc]init];
    [self.view addSubview:_textField];
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(50);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(100, 50));
    }];
    _textField.backgroundColor = [UIColor whiteColor];
    _textField.layer.masksToBounds = YES;
    _textField.layer.cornerRadius = 8;
    _textField.layer.borderWidth = 1;
    _textField.layer.borderColor = [UIColor blackColor].CGColor;
    _textField.placeholder = @"请输入密码...";
    
    //确定
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_textField.mas_bottom).offset(50);
        make.centerX.mas_equalTo(_textField);
        make.width.height.mas_equalTo(_textField);
    }];
    [btn setTitle:@"加密" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor orangeColor];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 8;
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = [UIColor blackColor].CGColor;
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];

}

//MD5加密
-(void)btnClick{

    NSLog(@"MD5加密前:%@",_textField.text);
    
    const char *cStr = [_textField.text UTF8String];
    
    unsigned char result[16];
    
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    
    NSString *md5Str = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",result[0],result[1],result[2],result[3],result[4],result[5],result[6],result[7],result[8],result[9],result[10],result[11],result[12],result[13],result[14],result[15]];
    
    NSLog(@"MD5加密后:%@",md5Str);
    
    /*
     其中%02x是格式控制符：‘x’表示以16进制输出，‘02’表示不足两位，前面补0；如‘f’输出为0f，‘1f3’则输出1f3;本来一般的都会介绍到这里就完了，我想多介绍一下代码中result是个字符数组，那为什么是[16]呢，这是因为MD5算法最后生成的是128位，而在计算机的最小存储单位为字节，1个字节是8位，对应一个char类型，计算可得需要16个char。所以result是[16]。那么为什么输出的格式一定是%02x呢，而不是其它呢。这也是有原因的：因为约定MD5一般是以16进制的格式输出，那么其实这个问题就转换为把128个0和1以16进制来表示，每4位二进制对应一个16进制的元素，则需要32个16进制的元素，如果元素全部为0，放到char的数组中，正常是不会输出，如00001111，以%x输出，则是f,那么就会丢失0；但如果以%02x表示则输出结果是0f，正好是转换的正确结果。
     
     所以以上就是char[16]和%02x的来历。
     
     至于人们说的16位MD5加密，其实是这样的：举例如果产生的MD5加密字符串是：01234567abcdefababcdefab76543210，则16位的MD加密字符是abcdefababcdefab，也就是只是截取了中间的16位。实际上这个操作已经不是MD5加密算法所包括的，而应当是对MD5加密算法结果的二次处理。其它的64位和大小写什么的，都属于对MD5算法结果的二次处理。因为MD5算法产生的结果就是128bit，128个二进制数字。
     
     */
    
}

@end

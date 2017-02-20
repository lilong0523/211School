//
//  person_basicInfoController.m
//  zph
//
//  Created by 李龙 on 2017/1/2.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "person_basicInfoController.h"
#import "basicInfoEdit.h"
#import "basicInfoTouch.h"
#import "BaseButton.h"
#import "BasePicker.h"
#import "baseDatePicker.h"

#import "educationalController.h"
#import "datePicker.h"
#import "YearMonthPick.h"
#import "NSData+NSData_ST.h"

@interface person_basicInfoController ()<UIPickerViewDelegate,UIPickerViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation person_basicInfoController
{
    UIScrollView *mainScroll;
    UIPickerView *sexPicker;//性别选择器
    NSMutableArray *sexArry;//性别数组
    NSMutableArray *eductionArry;//学历数组
    UIButton *userLogo;//用户头像
    BaseButton *nextBut;//下一步
    
    basicInfoEdit *nameText;//姓名
    basicInfoTouch *sexSelect;//性别选项
    basicInfoTouch *birthday;//生日选项
    basicInfoTouch *Household;//户籍选项
    NSString *HouseholdID;//户籍id
    basicInfoTouch *living;//现居选项
    NSString *livingID;//现居地id
    basicInfoTouch *Graduation;//毕业时间选项
    basicInfoTouch *Education;//学历选项
    NSString *educationId;//学历id
    basicInfoEdit *phoneNumber;//手机号
    
    
    datePicker *HouseholdPick;//户籍选择
    datePicker *livepick;//居住地选择器
    YearMonthPick *timeSelect;//毕业时间选择
    
    basicInfoEdit *QQ;//qq
    basicInfoEdit *email;//邮箱
    
    NSString *currentExt;//头像图片扩展名
    NSString *currentImageBase;//头像base64
    NSData *imageData;
    
    NSString *getHeadUrl;//传递过来的头像地址
    NSString *headImageUrl;//头像返回地址
}

- (void)viewDidLoad {
    [super viewDidLoad];
    sexArry = [[NSMutableArray alloc] initWithObjects:@{@"name":@"男",@"id":@"0"},@{@"name":@"女",@"id":@"1"}, nil];
    eductionArry= [[NSMutableArray alloc] initWithObjects:@{@"name":@"研究生",@"id":@"level_01"},@{@"name":@"本科",@"id":@"level_02"},@{@"name":@"大专",@"id":@"level_07"},@{@"name":@"高职",@"id":@"level_03"}, nil];
    
    [self.rightBut2 setTitle:@"保存" forState:UIControlStateNormal];
    
    [self.rightBut2 addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    [self.rightBut2 setTitleColor:BUTTON_COLOR forState:UIControlStateNormal];
    // Do any additional setup after loading the view.
    
    [self addMainView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 保存按钮
 */
- (void)rightClick{
    if (headImageUrl == nil) {
        [HUDProgress showHUD:@"请上传头像"];
    }
    else if ([nameText.text isEqualToString:@""]){
        [HUDProgress showHUD:@"请填写姓名"];
    }
    else if ([sexSelect.rightText isEqualToString:@""]){
        [HUDProgress showHUD:@"请选择性别"];
    }
    else if ([birthday.rightText isEqualToString:@""]){
        [HUDProgress showHUD:@"请选择生日"];
    }
    else if ([Household.rightText isEqualToString:@""]){
        [HUDProgress showHUD:@"请选择户籍"];
    }
    else if ([living.rightText isEqualToString:@""]){
        [HUDProgress showHUD:@"请选择现居地"];
    }
    else if ([Graduation.rightText isEqualToString:@""]){
        [HUDProgress showHUD:@"请选择毕业时间"];
    }
    else if ([Education.rightText isEqualToString:@""]){
        [HUDProgress showHUD:@"请选择学历"];
    }
    else if ([email.text isEqualToString:@""]){
        [HUDProgress showHUD:@"请输入邮箱"];
    }
    else if ([QQ.text isEqualToString:@""]){
        [HUDProgress showHUD:@"请输入QQ"];
    }
    else{
        [HUDProgress showHDWithString:@"请稍后..." coverView:self.view];
        if (currentImageBase == nil) {
            [self UpdateStudent];
        }
        else{
            [self upLoadHead];
        }
        
    }
}

/**
 添加主输入view
 */
- (void)addMainView{
    __block person_basicInfoController *block = self;
    
    mainScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topView.frame)+1, self.view.frame.size.width, self.view.frame.size.height-CGRectGetMaxY(self.topView.frame)-1)];
    mainScroll.bounces = NO;
    mainScroll.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:mainScroll];
    
    //头部
    userLogo = [[UIButton alloc] init];
    [userLogo setBackgroundColor:LINE_COLOR];
    userLogo.layer.masksToBounds = YES;
    [userLogo addTarget:self action:@selector(userImageSelect) forControlEvents:UIControlEventTouchUpInside];
    [userLogo.imageView setContentMode:UIViewContentModeScaleToFill];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HEADDOWNLOAD,[_model objectForKey:@"head_pic"]]];
    [userLogo sd_setImageWithURL:url forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"icon_userImage"]];
    [mainScroll addSubview:userLogo];
    UILabel *ps = [[UILabel alloc] init];
    [ps setText:@"点击修改"];
    [ps setTextColor:COMPANY_COLOR];
    [ps setFont:[UIFont systemFontOfSize:[myFont textFont:13.0]]];
    [mainScroll addSubview:ps];
    UIView *line = [[UIView alloc] init];
    [line setBackgroundColor:LINE_COLOR];
    [mainScroll addSubview:line];
    [userLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
        make.top.equalTo(mainScroll.mas_top).offset(10);
        make.centerX.equalTo(mainScroll.mas_centerX);
    }];
    [ps mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(userLogo.mas_bottom).offset(10);
        make.centerX.equalTo(userLogo.mas_centerX);
    }];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ps.mas_bottom).offset(15);
        make.width.mas_equalTo(mainScroll.mas_width);
        make.height.mas_equalTo(1);
    }];
    
    //主体输入模块
    nameText = [[basicInfoEdit alloc] init];
    nameText.leftImage = @"icon_edit";
    nameText.leftOverImage = @"icon_overEdit";
    nameText.leftText = @"姓名";
    nameText.PlaceHold = @"请输入真实姓名";
    nameText.text = [_model objectForKey:@"name"]?[_model objectForKey:@"name"]:@"";
    [mainScroll addSubview:nameText];
    //性别
    sexSelect = [[basicInfoTouch alloc] init];
    sexSelect.leftImage = @"icon_edit";
    sexSelect.leftText = @"性别";
    sexSelect.rightText = [_model objectForKey:@"sex"]?[_model objectForKey:@"sex"]:@"";
    sexSelect.selectBlock = ^(){
        //选择性别
        [block.view endEditing:YES];
        [block selectSex];
    };
    [mainScroll addSubview:sexSelect];
    //生日
    birthday = [[basicInfoTouch alloc] init];
    birthday.leftImage = @"icon_edit";
    birthday.leftText = @"生日";
    birthday.rightText = [_model objectForKey:@"birth"]?[_model objectForKey:@"birth"]:@"";
    birthday.selectBlock = ^(){
        //选择生日
        [block.view endEditing:YES];
        [block selectDate];
    };
    [mainScroll addSubview:birthday];
    
    //户籍
    Household = [[basicInfoTouch alloc] init];
    Household.leftImage = @"icon_edit";
    Household.leftText = @"户籍";
    Household.rightText = [NSString stringWithFormat:@"%@ %@",[_model objectForKey:@"home_province"],[_model objectForKey:@"home_city"]];
    Household.selectBlock = ^(){
        //选择户籍
        [block.view endEditing:YES];
        [block selectAddress];
    };
    [mainScroll addSubview:Household];
    //现居
    living = [[basicInfoTouch alloc] init];
    living.leftImage = @"icon_edit";
    living.leftText = @"现居";
    living.rightText = [NSString stringWithFormat:@"%@ %@",[_model objectForKey:@"area_province"],[_model objectForKey:@"area_city"]];
    living.selectBlock = ^(){
        //选择现居
        [block.view endEditing:YES];
        [block selectNowAddress];
    };
    [mainScroll addSubview:living];
    //毕业时间
    Graduation = [[basicInfoTouch alloc] init];
    Graduation.leftImage = @"icon_edit";
    Graduation.leftText = @"毕业时间";
    Graduation.rightText = [_model objectForKey:@"grad_year"]?[_model objectForKey:@"grad_year"]:@"";
    Graduation.selectBlock = ^(){
        //选择现居
        [block.view endEditing:YES];
        [block selectGraduation];
    };
    [mainScroll addSubview:Graduation];
    //最高学历
    Education = [[basicInfoTouch alloc] init];
    Education.leftImage = @"icon_edit";
    Education.leftText = @"最高学历";
    Education.rightText = [_model objectForKey:@"educations"]?[_model objectForKey:@"educations"]:@"";
    Education.selectBlock = ^(){
        //选择学历
        [block.view endEditing:YES];
        [block selectEducation];
    };
    [mainScroll addSubview:Education];
    
    //手机
    phoneNumber = [[basicInfoEdit alloc] init];
    phoneNumber.inputType = UIKeyboardTypeEmailAddress;
    phoneNumber.leftImage = @"icon_edit";
    phoneNumber.leftOverImage = @"icon_overEdit";
    phoneNumber.leftText = @"手机";
    phoneNumber.PlaceHold = @"请输入手机号";
    phoneNumber.text = [_model objectForKey:@"contact_tel"]?[_model objectForKey:@"contact_tel"]:@"";
    [mainScroll addSubview:phoneNumber];
    //邮箱
    email = [[basicInfoEdit alloc] init];
    email.inputType = UIKeyboardTypeEmailAddress;
    email.leftOverImage = @"icon_overEdit";
    email.leftImage = @"icon_edit";
    email.leftText = @"邮箱";
    email.PlaceHold = @"请输入常用邮箱";
    email.text = [_model objectForKey:@"contact_email"]?[_model objectForKey:@"contact_email"]:@"";
    [mainScroll addSubview:email];
    //QQ
    QQ = [[basicInfoEdit alloc] init];
    QQ.inputType = UIKeyboardTypePhonePad;
    QQ.leftOverImage = @"icon_overEdit";
    QQ.leftImage = @"icon_edit";
    QQ.leftText = @"QQ";
    QQ.PlaceHold = @"请输入您的QQ号";
    QQ.text = [_model objectForKey:@"bind_qq"]?[_model objectForKey:@"bind_qq"]:@"";
    [mainScroll addSubview:QQ];
    
    
    [nameText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom);
        make.width.mas_equalTo(line.mas_width);
        make.height.mas_equalTo(50);
    }];
    [sexSelect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameText.mas_bottom);
        make.width.mas_equalTo(nameText.mas_width);
        make.height.mas_equalTo(nameText.mas_height);
    }];
    [birthday mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sexSelect.mas_bottom);
        make.width.mas_equalTo(sexSelect.mas_width);
        make.height.mas_equalTo(sexSelect.mas_height);
    }];
    [Household mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(birthday.mas_bottom);
        make.width.mas_equalTo(birthday.mas_width);
        make.height.mas_equalTo(birthday.mas_height);
    }];
    [living mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(Household.mas_bottom);
        make.width.mas_equalTo(Household.mas_width);
        make.height.mas_equalTo(Household.mas_height);
    }];
    [Graduation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(living.mas_bottom);
        make.width.mas_equalTo(living.mas_width);
        make.height.mas_equalTo(living.mas_height);
    }];
    [Education mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(Graduation.mas_bottom);
        make.width.mas_equalTo(Graduation.mas_width);
        make.height.mas_equalTo(Graduation.mas_height);
    }];
    [phoneNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(Education.mas_bottom);
        make.width.mas_equalTo(Education.mas_width);
        make.height.mas_equalTo(Education.mas_height);
    }];
    
    [email mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneNumber.mas_bottom);
        make.width.mas_equalTo(phoneNumber.mas_width);
        make.height.mas_equalTo(phoneNumber.mas_height);
    }];
    [QQ mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(email.mas_bottom);
        make.width.mas_equalTo(email.mas_width);
        make.height.mas_equalTo(email.mas_height);
    }];
    
    
    
    
    
}




/**
 选择性别
 */
- (void)selectSex{
    
    BasePicker *sexPick = [[BasePicker alloc] initWithDic:sexArry copNum:1];
    [sexPick show];
    
    sexPick.selectBlock = ^(NSString *text){
        NSLog(@"%@",text);
        [sexSelect setRightText:text];
    };
    
}

/**
 选择日期
 */
- (void)selectDate{
    baseDatePicker *datePick = [[baseDatePicker alloc] init];
    [datePick show];
    datePick.selectBlock = ^(NSDate *date){
        NSLog(@"%@",date);
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        //设定时间格式,这里可以设置成自己需要的格式
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *DateStr = [dateFormatter stringFromDate:date];
        [birthday setRightText:DateStr];
    };
}



/**
 选择户籍
 */
- (void)selectAddress{
    __block person_basicInfoController *blockSelf = self;
    
    if (HouseholdPick == nil) {
        HouseholdPick = [[datePicker alloc] initWithNum:2];
    }
    HouseholdPick.FullIdBlock = ^(NSString *fullId){
        NSLog(@"%@",fullId);
        blockSelf->HouseholdID = fullId;
    };
    HouseholdPick.selectBlock = ^(NSString *text){
        blockSelf->Household.rightText = text;
    };
    [HouseholdPick show];
}

/**
 选择现居地
 */
- (void)selectNowAddress{
    __block person_basicInfoController *blockSelf = self;
    
    
    if (livepick == nil) {
        livepick = [[datePicker alloc] initWithNum:2];
    }
    livepick.FullIdBlock = ^(NSString *fullId){
        NSLog(@"%@",fullId);
        blockSelf->livingID = fullId;
        
    };
    livepick.selectBlock = ^(NSString *text){
        blockSelf->living.rightText = text;
    };
    [livepick show];
    
    
}

/**
 毕业时间选择
 */
- (void)selectGraduation{
    __block person_basicInfoController *blockSelf = self;
    if (timeSelect == nil) {
        timeSelect = [[YearMonthPick alloc] initWithFrame:self.view.frame];
    }
    
    timeSelect.selectBlock = ^(NSString *text){
        blockSelf->Graduation.rightText = text;
        [blockSelf->_model setObject:text forKey:@"grad_year"];
    };
    
    [timeSelect show];
    
}

/**
 最高学历选择
 */
- (void)selectEducation{
    if (eductionArry.count>0) {
        BasePicker *EducationPick = [[BasePicker alloc] initWithDic:eductionArry copNum:1];
        EducationPick.defaultNum = 1;
        [EducationPick show];
        
        EducationPick.selectBlock = ^(NSString *text){
            NSLog(@"%@",text);
            [_model setObject:text forKey:@"educations"];
            [Education setRightText:text];
        };
        EducationPick.FullIdBlock = ^(NSString *text){
            [_model setObject:text forKey:@"education"];
            educationId = text;
        };
    }
    
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 2;
}


- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view{
    
    
    UILabel *detail = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 32)];
    
    [detail setTextColor:[UIColor blackColor]];
    [detail setText:[sexArry objectAtIndex:row]];
    [detail setTextAlignment:NSTextAlignmentCenter];
    
    UIView *downLine = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(detail.frame), self.view.frame.size.width, 0.5)];
    [downLine setBackgroundColor:LINE_COLOR];
    [detail addSubview:downLine];
    return detail;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 32;
}


/**
 图片选择
 */
- (void)userImageSelect{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择照片" message:@"选择修改头像" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //处理点击拍照
        [self openCamera:UIImagePickerControllerSourceTypeCamera];
    }];
    UIAlertAction *archiveAction = [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //处理点击从相册选取
        [self openCamera:UIImagePickerControllerSourceTypePhotoLibrary];
    }];
    [alert addAction:cancelAction];
    [alert addAction:deleteAction];
    [alert addAction:archiveAction];
    [self presentViewController:alert animated:YES completion:nil];
}


- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    userLogo.layer.cornerRadius = userLogo.frame.size.width/2;
    mainScroll.contentSize = CGSizeMake(0, CGRectGetMaxY(QQ.frame)+10);
}


/**
 选择照片
 
 @param tap 拍照还是相册选择
 */
- (void)openCamera:(NSInteger)tap{
    
    if (tap == UIImagePickerControllerSourceTypeCamera) {
        if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            return;
        }
    }
    // 跳转到相机或相册页面
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    
    imagePickerController.delegate = self;
    
    imagePickerController.allowsEditing = YES;
    
    imagePickerController.sourceType = tap;
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"top_01.png"] forBarMetrics:UIBarMetricsDefault];
    
    
    [self presentViewController:imagePickerController animated:YES completion:^{
        
        NSLog(@"选择图片成功。。。");
    }];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    NSLog(@"imagePickerController:(UIImagePickerController *)picker 2222");
    
    
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    currentExt = [[info objectForKey:@"UIImagePickerControllerReferenceURL"] pathExtension];
    //压缩图片
    
    imageData = [self compressOriginalImage:[self compressOriginalImage:image toSize:CGSizeMake(100, 100)] toMaxDataSizeKBytes:100.0];
    //    NSData *imageData = [self reSizeImageData:image maxImageSize:500 maxFileSizeWithKB:100];
    float length = [imageData length]/1000.0;
    NSLog(@"%f",length);
    
    NSData *GzipData = [NSData compressData:imageData];
    
    currentImageBase = [GzipData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    [userLogo setImage:[UIImage imageWithData:imageData] forState:UIControlStateNormal];
    
    
}



/**
 *  压缩图片到指定文件大小
 *
 *  @param image 目标图片
 *  @param size  目标大小（最大值）
 *
 *  @return 返回的图片文件
 */
- (NSData *)compressOriginalImage:(UIImage *)image toMaxDataSizeKBytes:(CGFloat)size{
    NSData * data = UIImageJPEGRepresentation(image, 1.0);
    CGFloat dataKBytes = data.length/1000.0;
    CGFloat maxQuality = 0.9;
    while (dataKBytes > size && maxQuality > 0.1) {
        maxQuality = maxQuality - 0.1;
        data = UIImageJPEGRepresentation(image, maxQuality);
        dataKBytes = data.length / 1000.0;
        
        
    }
    return data;
}
/**
 *  压缩图片到指定尺寸大小
 *
 *  @param image 原始图片
 *  @param size  目标大小
 *
 *  @return 生成图片
 */
-(UIImage *)compressOriginalImage:(UIImage *)image toSize:(CGSize)size{
    UIImage * resultImage = image;
    UIGraphicsBeginImageContext(size);
    [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


- (void)setModel:(NSMutableDictionary *)model{
    if (_model == nil) {
        _model = [[NSMutableDictionary alloc] initWithDictionary:model];
    }
    [self loadDefaltInfo];
}


/**
 初始化数据
 */
- (void)loadDefaltInfo{
    HouseholdID = [_model objectForKey:@"home_area"];
    livingID = [_model objectForKey:@"area_id"];
    headImageUrl = [NSString stringWithFormat:@"%@",[_model objectForKey:@"head_pic"]];
    educationId = [_model objectForKey:@"education"];
}

/**
 上传头像
 */
- (void)upLoadHead{
    HttpRequestModel *request = [[HttpRequestModel alloc] init];
    request.httpSuccessBlock = ^(NSDictionary * dicData,NSInteger tag){
        
        if ([[dicData objectForKey:@"code"] integerValue] == 0) {
            
            headImageUrl = [[dicData objectForKey:@"data"] objectForKey:@"file_url"];
            [_model setObject:headImageUrl forKey:@"head_pic"];
            [self UpdateStudent];
            
        }
        else{
            [HUDProgress hideHUD];
            [HUDProgress showHUD:[NSString stringWithFormat:@"%@",[dicData objectForKey:@"message"]]];
            
        }
        
    };
    request.httpFieldBlock = ^(NSError *error){
        NSLog(@"%@",error.description);
        [HUDProgress hideHUD];
        
    };
    NSDictionary *dicBody = @{
                              @"filename":[NSString stringWithFormat:@"111.%@",currentExt],
                              @"base64code":currentImageBase,
                              };//json data
    
    
    [request postAsynRequestBody:dicBody interfaceName:UPLOADWITHGZIP interfaceTag:1 parType:0];
}


/**
 修改基本信息
 */
- (void)UpdateStudent{
    HttpRequestModel *request = [[HttpRequestModel alloc] init];
    request.httpSuccessBlock = ^(NSDictionary * dicData,NSInteger tag){
        [HUDProgress hideHUD];
        if ([[dicData objectForKey:@"code"] integerValue] == 0) {
            
            if (self.changeBlock) {
                self.changeBlock();
            }
            [HUDProgress showHUD:@"修改成功"];
            [self noticeInfo];
        }
        else{
            
            [HUDProgress showHUD:[NSString stringWithFormat:@"%@",[dicData objectForKey:@"message"]]];
            
        }
        
    };
    request.httpFieldBlock = ^(NSError *error){
        NSLog(@"%@",error.description);
        [HUDProgress hideHUD];
    };
    NSDictionary *dicBody = @{
                              
                              @"userName":nameText.text,
                              @"sex":sexSelect.rightText,
                              @"birthday":birthday.rightText,
                              @"homeArea":HouseholdID,
                              @"areaId":livingID,
                              @"gradYear":Graduation.rightText,
                              @"mobilePhone":phoneNumber.text,
                              @"education":educationId,
                              @"email":email.text,
                              @"qq":QQ.text,
                              @"headPic":headImageUrl,
                              };//json data
    
    
    
    [request postAsynRequestBody:dicBody interfaceName:UPDATESTU interfaceTag:2 parType:1];
}

/**
 通知个人信息页面刷新背景
 */
- (void)noticeInfo{
    //创建一个消息对象
    NSNotification * notice = [NSNotification notificationWithName:@"changeSelf" object:nil userInfo:nil];
    //发送消息
    [[NSNotificationCenter defaultCenter] postNotification:notice];
    [self.navigationController popViewControllerAnimated:YES];
}

@end

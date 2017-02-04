//
//  GPCaptureImageController.h
//  GPOnFire
//
//  Created by dandan on 16/3/16.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GPCaptureImageController;

@protocol GPCaptureImageViewDelagate <NSObject>

- (void)captureImageViewUserBtnCiclk:(GPCaptureImageController *)GPCaptureVc;

@end

@interface GPCaptureImageController : UIViewController

@property (nonatomic,weak) id <GPCaptureImageViewDelagate>delegate;

@property (nonatomic, strong) UIImage *selectImage;
@property (nonatomic, strong) UIImage *userImage;

+(instancetype)captureImage;
@end

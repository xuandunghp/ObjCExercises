//
//  ImageSkewer.m
//  ObjCExample
//
//  Created by Dzung Tran on 9/25/15.
//  Copyright © 2015 Dzung. All rights reserved.
//

#import "ImageSkewer.h"

typedef unsigned char byte;


@interface ImageSkewer ()

@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end


@implementation ImageSkewer
{
    CGImageRef _imageRef;

    NSUInteger _width;
    NSUInteger _height;
    CGColorSpaceRef _colorSpace;
    
    NSUInteger _bytesPerPixel;
    NSUInteger _bytesPerRow;
    NSUInteger _bitsPerComponent;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    _imageRef = [[UIImage imageNamed:@"steve.jpg"] CGImage];

    _width = CGImageGetWidth(_imageRef);
    _height = CGImageGetHeight(_imageRef);
    _colorSpace = CGColorSpaceCreateDeviceRGB();
    
    _bytesPerPixel = 4;
    _bytesPerRow = _bytesPerPixel * _width;
    _bitsPerComponent = 8;
    
    _slider.value = 0;
    
}

- (IBAction)skewImage:(id)sender {
    float angle = atanf((float)_height / 2 / _width) * _slider.value;

    byte *rawInput = (byte *)calloc(_height * _width * 4, sizeof(byte));;
    [self extractRawImageFrom:_imageRef To:rawInput];
    
    byte *rawOutput = (byte *)calloc(_height * _width * 4, sizeof(byte));
    [self skewRawImage:rawInput WidthAngle:angle To:rawOutput];

    UIImage *output = [self getImageFromRawImage:rawOutput];

    free(rawInput);
    free(rawOutput);
    
    [self.imageView setImage:output];
}

- (void) extractRawImageFrom:(CGImageRef)image To:(byte *)rawImage {
    CGContextRef context = CGBitmapContextCreate(rawImage, _width, _height, _bitsPerComponent, _bytesPerRow, _colorSpace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGContextDrawImage(context, CGRectMake(0, 0, _width, _height), image);
    CGContextRelease(context);
}

- (void) skewRawImage:(byte *)rawInput WidthAngle:(float)angle To:(byte *)rawOutput {
    memset(rawOutput, 0, _height * _width * 4 * sizeof(byte));
    
    float tanAlpha = tanf(angle);
    float tanBeta = tanf(angle);

    int x1, y1, x2, y2, byteIndex1, byteIndex2;
    
    for (x1 = 0; x1 < _width; x1++) {
        for (y1 = 0; y1 < _height; y1++) {
            x2 = x1;
            y2 = floor((y1 - (_width - x1) * tanAlpha) * _height / (_height - (_width - x1) * (tanAlpha + tanBeta)) + 0.5);

            if (y2 >= 0.0 && y2 <= _height - 1) {
                byteIndex1 = (x1 + y1 * _width) * 4;
                byteIndex2 = (x2 + y2 * _width) * 4;

                rawOutput[byteIndex1] = rawInput[byteIndex2];
                rawOutput[byteIndex1 + 1] = rawInput[byteIndex2 + 1];
                rawOutput[byteIndex1 + 2] = rawInput[byteIndex2 + 2];
                rawOutput[byteIndex1 + 3] = rawInput[byteIndex2 + 3];
            }
        }
    }
}

- (UIImage *) getImageFromRawImage:(byte *)rawImage {
    CGContextRef context = CGBitmapContextCreate(rawImage, _width, _height, _bitsPerComponent, _bytesPerRow, _colorSpace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    UIImage *image = [UIImage imageWithCGImage:CGBitmapContextCreateImage(context)];
    CGContextRelease(context);
    
    return image;
}


@end

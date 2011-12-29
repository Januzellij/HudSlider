@interface SBMediaController : NSObject {}
+ (id)sharedInstance;
- (void)setVolume:(float)vol;
- (float)volume;
@end

static UISlider *slider = nil;
%hook SBVolumeHUDView

- (id)initWithHUDViewLevel:(int)hudviewLevel {
	%orig;
	slider = [[UISlider alloc] initWithFrame:CGRectMake(10, 5, 140, 50)];
	[slider addTarget:self action:@selector(progressChanged:) forControlEvents:UIControlEventValueChanged];
	[slider setMinimumValue: 0.0];
	slider.value = [(SBMediaController *)[%c(SBMediaController) sharedInstance] volume];
	[self addSubview:slider];
	[slider release];
	return self;
}

- (void)layoutSubviews {
	%orig;
	[self setUserInteractionEnabled:YES];
}

- (void)setProgress:(float)progress {
	%orig;
	slider.value = progress;	
}
%new
- (void)progressChanged:(UISlider *)slide {
	[self setProgress:slide.value];
	[(SBMediaController *)[%c(SBMediaController) sharedInstance] setVolume:slide.value];
}
%end

%hook SBHUDWindow
- (BOOL)_ignoresHitTest {
	[self setUserInteractionEnabled:YES];
	return NO;
}
%end

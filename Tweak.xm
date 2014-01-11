@interface SBMediaController : NSObject {}
+ (id)sharedInstance;
- (void)setVolume:(float)vol;
- (float)volume;
@end

static UISlider *slider = nil;
%hook SBVolumeHUDView

- (id)initWithHUDViewLevel:(int)hudviewLevel {
	%orig;
	slider = [[UISlider alloc] initWithFrame:CGRectMake(10, 110, 140, 50)];
	UIImage *blankImage = [[[UIImage alloc] init] autorelease];
	[slider setThumbImage:blankImage forState:UIControlStateNormal];
	[slider setMinimumTrackImage:blankImage forState:UIControlStateNormal];
	[slider setMaximumTrackImage:blankImage forState:UIControlStateNormal];
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

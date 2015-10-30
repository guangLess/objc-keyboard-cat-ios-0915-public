# Keyboard Cat

*meow meow*

## Objectives 

1. Get familiar with the `NSNotificationCenter` API
2. Learn how to adjust your layout in response to the software keyboard's appearance

## Introduction

In this lab, you'll be responding to some of the system-provided Notification Center messages. There are quite a few of these, but we'll be focusing on the ones that are posted when the keyboard appears and disappears.

## Instructions

Open the `xcodeproj` file and check out the storyboard. The interface is a full-screen image, with a text field at the bottom. Go ahead and run the project to be greeted by Keyboard Cat. There's just one problem: when you tap in the text field, the keyboard covers it (and far too much of our cat!). Let's remedy that.

*Pro-tip:* if the software keyboard doesn't appear in the simulator when you tap the text field, hit `⌘` `K` to pop it up. By default the simulator uses the hardware keyboard attached to your computer, rather than the on-screen keyboard provided by iOS.

1. In the view controller's `-viewDidLoad`, subscribe to the relevant notification center messages. These are called `UIKeyboardWillShowNotification` and `UIKeyboardWillHideNotification`.

2. In the method that handles the keyboard appearing, you'll want to animate the text field to be above the keyboard. This will involve a few steps:
    - You'll need an outlet for the relevant constraints. They've already been made in the storyboard.
    - To retrieve the size of the keyboard, you'll need to grab a value from the `userInfo` property of the `NSNotification` argument to your method. Read the documentation on this. Don't just hard-code the keyboard height! Custom keyboards can be of any height, and even the emoji keyboard is different than the standard English one.
    - With the height of the keyboard in hand, you should be able to just animate a change in the constraint's constant. Woo!

3. In the method that handles the keyboard disappearing, you'll need to animate the text field back down to the bottom of the screen. This process will be about the same as the above, just without the need to pull out the frame of the keyboard from the notification.

4. Add a tap gesture recognizer to the image view that dismisses the keyboard, so you can make sure your code is working.

5. Now also move the bottom of the image view up with the keyboard. We want as much of the kitty visible as possible!


That's it! Make sure your code works with multiple sizes of keyboard by switching to the emoji keyboard, or hiding and showing the predictive text bar.


## Extra Credit

1. The documentation for the keyboard notifications notes that the notification's `userInfo` dictionary provides the duration and curve the system will use for animating the keyboard on and off screen. Use those values so that your animation perfectly matches the keyboard.
    - *Hint:* you can use `+[UIView setAnimationCurve:]` inside an animation block to use the curve value from the `userInfo` dictionary.

2. Can you think of a way to combine your two notification-handling methods into one? The only real difference is the location to which we are moving the textfield and image view.
    - *Hint:* you can check the name of the notification that triggered a method call via the `NSNotification`'s `name` property.

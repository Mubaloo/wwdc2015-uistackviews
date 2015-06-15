# UIStackView

## The Old Way

Often in many of our apps we usually have a screen somewhere consisting of a few to many text fields where the user enters in some information. A classic example of this is a registration page.

![Registration page](registration_uk.png)

If the page is pretty simple - all fields must be filled out to continue, the simplest way is often to have each field as a cell in a `UITableView`. If the UI is a bit more complex, you can have prototypes for the different styles. After you're finished you're most likely left with a rather large `tableView:cellForRowAtIndexPath:` method with a switch statement configuring each row/field.
Xcode 6 improved on this with the addition of a static option to a `UITableViewController`. This allowed you to create all the different cells you needed, and then hook up the fields as `IBOutlet`s. Interface Builder also supported sections, including their headers and footers.

### Making It More Complicated

As I've said using a table view is usually fine for simple cases, but typically there's dependencies for fields based on the input of other fields. In the above example, if you select United States as the country, another field appears to allow you to pick your state. 

![Dynamic content part of regstration](registration_us.png)

This now makes using a `UITableView` for screens like this a ball-ache. You have to check the value of the related field, then add or remove rows. Also you then have to make sure you keep your data source and delegate methods returning the correct values depending on if a row is there or not.

This registration page was actually constructed using constraints to keep things simpler and also static tables were not available when the app was created. The layout is based on `UIView`s as containers all placed in a `UIScrollView`. The visibility of the dependent fields was then controlled by changing the `constant` property of the various constraints and updating the `hidden` property of the view. While this solution worked, there just seemed a bit too much layout code for such a simple thing!

## WWDC 2015 and Stack Views

As usual at WWDC Apple introduced the new technologies for developers with their typical slide:

![WWDC 2015: New dev technologies](wwdc_2015_dev_anno.png)
<small>(Image from [Apple 2015 Live Event](http://www.apple.com/live/2015-june-event/))</small>

Not mentioning stack views during the keynote the easiest way to find out about them was to dive straight into the [pre-release docs](https://developer.apple.com/library/prerelease/ios/documentation/UIKit/Reference/UIStackView_Class_Reference/index.html) and see what they were!

Its nice to see that Apple have provided great docs here, and obviously are pushing developers to use them.
In fact the WWDC session [Implementing UI Designs in Interface Builder](https://developer.apple.com/videos/wwdc/2015/?id=407) recommends you use `UIStackView` everywhere and only fallback to using constraints if necessary.
The actual API interface for `UIStackView` is pretty small, with methods for changing the `arrangedSubviews` in the stack and properties for changing the way these views are displayed.
I'm not going to cover everything here as the docs give you more than you need to get started and provides a great overview.
It is worth reading however the section in the docs about _Maintaining Consistency Between the Arranged Views and Subviews_.

I'm going to cover some use cases and some cool stuff you can do when changing the layouts.

### Simplicity

Take the following layout:

![Screen shot of Interface Builder showing all the constraints](Constraints.png)

This has **31** constraints in Interface Builder to create this view (I couldn't fit them all on the screen)! Its also difficult to managed in Interface Builder, if you delete the centre row, you'd have to add in the constraints to space the top and bottom views back in. Additionally changing the spacing of the views consists of changing the constants of 2 constraints. This gets even more messy when adding lots more rows.

Once this layout is convert to use stack views, you can't visually tell the difference between the two implementations at runtime. In terms of managing the views however its a lot simpler. 
There are only **4** constraints to layout the stack view in its container and thats it. The stack view uses the intrinsic content size on its `arrangedSubviews` to size itself. The spacing attribute can be used to change the spacing between all the views at once, and by default the views are set to use the full width (or height for a horizontal stack view) of the stack view.

Also when dragging a view into the stack view Interface Builder places the view in the correct position and gives it the correct frame - no longer needing to constantly use the _Update Frames_ menu option.
This layout uses 4 stack views of different orientations. The top two rows are nested horizontal stack views, with the first row having another nested vertical stack view inside of that.

## Dynamic Layouts

Now lets go back to our original problem of having a views visibility being based on the input of other views.

![Screen shot of dynamic stack view layout](Dynamic.png)

Here we have a vertical stack view with some controls in it to change the state of the views.
(I think the stretched `UISwitch` might be a bug in Interface Builder as when the project is run, its fine.)

Now to hide and show the relevant controls we can literally hide and show the views.

	@IBAction func doImageSwitchChangedAction() {
	    imageRow.hidden = !imageSwitch.on
	}

Stack view updates it layout when the `hidden` property of any of its `arrangedSubviews` are changed. Normally hiding a view laid out with AutoLayout doesn't remove the view from layout pass calculations, so you're just left with an empty space where the view was.

![Animated GIF of dynamic screen in action](Dynamic.gif)

You can easily animate this layout change, by just placing the above code in an animation block.

Reconfiguring nested stack views in any animation block can give simple but effective animations of content changes.

![Animated GIF of changing stack view properties in an animation block](StackViewAnimation.gif)

## Size Classes

Another great features of stack view is that it allows its layout to be based on size class in Interface Builder.

Take this simple layout which consists of nested stack views.

![Screen shot of ](NestedHiearchy.png =x480) ![Screen shot of the layout in portrait](Portrait.png =x480)

Now if this layout is used in landscape it gets a bit squashed:

![Screen shot of the layout in landscape](Landscape.png)

So what we can do in Interface Builder, is give the stack view different `axis` values depending on the size class. So for a compact width we want a vertical layout, but for a compact height we'd lay the views out horizontally. This means we can alter the whole layout of the screen without writing one line of code!

![Attributes based on specific size classes](SizeClassAttributes.png)

The same thing can be applied to the _Alignment_, _Distribution_, _Spacing_, _Baseline Relative_ and _Layout Margins Relative_ attributes. The above example uses a spacing of 19 for the compact height size class.
This is exactly the same way constraints can be adjusted for different size classes.

Now when rotating the device, the layout changes to a horizontally stacked group.

![Animated GIF showing the transition from a vertical stack to a horizontal stack on rotation]()

This can be expanded on further, for example having a 4 rows of items when there is a compact width, 4 columns when there is a compact height and then any other layouts showing a 2x2 grid.

![Animated GIF showing the transition from 4 rows, to 2x2 to 4 columns]()

The above example was completely created in Interface Builder without any code.

![View hiearchy](4stack.png)

The _Root Stack View_ is given a default axis of horizontal and then a vertical axis for compact widths. The two inner stack views then both have horizontal axises for a compact height, falling back to vertical when needed.

## Other Resources

The demo code for the examples can be viewed on Mubaloo's GitHub account. // TODO: Link

As mentioned the [pre-release docs](https://developer.apple.com/library/prerelease/ios/documentation/UIKit/Reference/UIStackView_Class_Reference/index.html) are also a great place to start as well as the WWDC session [Implementing UI Designs in Interface Builder](https://developer.apple.com/videos/wwdc/2015/?id=407).

This post will be kept up to date in case any changes before iOS 9 is finally released.
## definitions

x `width` - the width of the container
x `padding` - space between the left and right ends of the container and the content (like with HTML). Example: 1
x `spacing` - space between children. Example: 1
x `usable width` - `width` - `padding` * 2
`content width` - the sum of the `adjusted children widths` plus `spacing` between them
x `spacing width` - `spacing` * (number of children -1)
`adjusted children widths` - the adjusted widths of children (hash mapping child to width)
x `preferred children widths` - the preferred widths of children (hash mapping child to width)
x `preferred content width` - the sum of the `preferred children widths` plus `spacing` between them
`left offset` - space between the leftmost `usable width` and the content (0 when left aligned)
`right offset` - space between the rightmost `usable width` and the content (0 when right aligned)

`minimum children widths` - the minimum widths of children (hash mapping child to width)
`maximum children widths` - the maximum widths of children (hash mapping child to width)


|padding|left offset|content|right offset|padding


# render

* return padding, the left offset, the rendered children, the right offset, padding

# render children

* reduce `adjusted children widths` to array of rendered children at the correct adjusted width
* join children with `spacing` between

# adjusted children widths

Grows or shrinks `preferred children widths` based on the `extra width` available

* clone `preferred children widths` as `adjusted widths`
* loop while `extra width` is not 0 and there are `adjustable children` (based on `extra width`)
		* find the the percent to change by dividing the `extra width` by the number of `adjustable children` (this may be negative)
	* iterate over the `adjustable children`
		* multiply their current adjusted width by the resizing percent to get the amount to add to their width
		* if the child's current adjusted width + the amount to add is less than their maximum width and greater than their minimum width, add it to the adjusted width
		* if the child's current adjusted width + the amount to add is greater than their maximum width, set their adjusted width to their maximum width
		* if the child's current adjusted width + the amount to add is less than their minimum width, set their adjusted width to their minimum width
* return the `adjustable children`

# extra width (based on map of children to widths)

* subtract sum of provided children's widths and `spacing width` from `usable width`

# adjustable children (based on extra width)

	* if `extra width` is negative: `shrinkable children`
	* if `extra width` is positive: `growable children`

# shrinkable children (based on map of children to widths)

* reduce children to those whose specified width is greater than their minimum width

# growable children (based on map of children to widths)

* reduce children to those whose specified width is less than their maximum width

# find the preferred widths of children

* map the children to their preferred width

# determine the right offset

* subtract `padding` * 2, `x offset`, and `content width` from `width`

# determine the left offset

* if left aligned, return 0
* if right aligned, return the `usable width` minus `content width` (IE: the adjusted children width)
* if center aligned, return the `usable width` minus `content width` divided by two



# find the minimum widths of children

* map the children to their minimum width

# find the maximum widths of children

* map the children to their maximum width

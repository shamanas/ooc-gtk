use gdk, gtk
import gtk/[Gtk, _GObject, Window, AccelGroup]
import gdk/Drawable

Adjustment: cover from GtkAdjustment* extends _GObject {
    new: static extern(gtk_adjustment_new) func(value, lower, upper, stepIncr, pageIncr, pageSize: Double) -> This

    getValue: extern(gtk_adjustment_get_value) func -> Double
    setValue: extern(gtk_adjustment_set_value) func(value: Double)
    value: Double {
        get {
            getValue()
        }
        set(value) {
            setValue(value)
        }
    }

    clampPage: extern(gtk_adjustment_clamp_page) func(lower, upper: Double)
    changed: extern(gtk_adjustment_changed) func
    valueChanged: extern(gtk_adjustment_value_changed) func

    configure: extern(gtk_adjustment_configure) func(value, lower, upper, stepIncr, pageIncr, pageSize: Double)

    getLower: extern(gtk_adjustment_get_lower) func -> Double
    setLower: extern(gtk_adjustment_set_lower) func(lower: Double)
    lower: Double {
        get {
            getLower()
        }
        set(lower) {
            setLower(lower)
        }
    }

    getPageIncrement: extern(gtk_adjustment_get_page_increment) func -> Double
    setPageIncrement: extern(gtk_adjustment_set_page_increment) func(pageIncr: Double)
    pageIncrement: Double {
        get {
            getPageIncrement()
        }
        set(pageIncr) {
            setPageIncrement(pageIncr)
        }
    }

    getPageSize: extern(gtk_adjustment_get_page_size) func -> Double
    setPageSize: extern(gtk_adjustment_set_page_size) func(pageSize: Double)
    pageSize: Double {
        get {
            getPageSize()
        }
        set(pageSize) {
            setPageSize(pageSize)
        }
    }

    getStepIncrement: extern(gtk_adjustment_get_step_increment) func -> Double
    setStepIncrement: extern(gtk_adjustment_set_step_increment) func(stepIncr: Double)
    stepIncrement: Double {
        get {
            getStepIncrement()
        }
        set(stepIncr) {
            setStepIncrement(stepIncr)
        }
    }

    getUpper: extern(gtk_adjustment_get_upper) func -> Double
    setUpper: extern(gtk_adjustment_set_upper) func(upper: Double)
    upper: Double {
        get {
            getUpper()
        }
        set(upper) {
            setUpper(upper)
        }
    }
}

WidgetStruct: cover from GtkWidget {
	window: extern GdkWindow*
	allocation: extern GtkAllocation
}


/**
 * A GTK widget, such as a Button, a Label, a Checkbox
 */
Widget: cover from WidgetStruct* extends _GObject {

	/**
	 * Set the sensitivity of this widget
	 * @param sensitive if true, the widget will react to the user
	 * input, and send/receive signals as usual. If false, thewidget
	 * will be "grayed out" and won't react to anything
	 */
	setSensitive: extern(gtk_widget_set_sensitive) func (sensitive: Bool)

	/**
	 * @see realize
	 */
	isRealized: extern(GTK_WIDGET_REALIZED) func -> Bool

	/**
	 * Realize this component on-screen, e.g. allocate resources, etc.
	 * It's often not needed to call it directly, use show() instead.
	 */
	realize: extern(gtk_widget_realize) func

	/**
	 * Sets whether the application intends to draw on the widget in
	 * an "expose-event" handler.
	 * This is a hint to the widget and does not affect the behavior of
	 * the GTK+ core; many widgets ignore this flag entirely. For widgets
	 * that do pay attention to the flag, such as GtkEventBox and
	 * GtkWindow, the effect is to suppress default themed drawing of
	 * the widget's background. (Children of the widget will still be drawn.)
	 * The application is then entirely responsible for drawing the
	 * widget background.
	 */
	setAppPaintable: extern(gtk_widget_set_app_paintable) func (Bool)


	getWindow: extern(gtk_widget_get_window) func -> Drawable

	/*
	 * Force the repaint of this widget
	 */
	/*
	forceRepaint: func (childrenToo: Bool) {

		while(Gtk eventsPending()) {
			Gtk mainIteration()
		}
		// ugly workaround
		gdk_window_invalidate_rect(this@ as WidgetStruct window, null, childrenToo)
		gdk_window_process_updates(this@ as WidgetStruct window, childrenToo)

	}
	*/

	/**
	 * Shows this widget on-screen.
	 */
	show: extern(gtk_widget_show) func

	/**
	 * Shows this widget on-screen and all its children.
	 */
	showAll: extern(gtk_widget_show_all) func

	/**
	 * Hides this widget
	 */
	hide: extern(gtk_widget_hide) func

	/**
	 * Destroys this widget
	 */
	destroy: extern(gtk_widget_destroy) func

	/**
	 * set the position of this wdiget
	 * @param x the x coordinate of the desired position for this widget, or
	 * -1 for default position
	 * @param y the y coordinate of the desired position for this widget, or
	 * -1 for default position
	 */
	setPosition: extern(gtk_widget_set_uposition) func (x, y : GInt)

	/**
	 * set the size of this widget
	 * @param width the desired width for this widget, or -1 for the default
	 * @param height the desired height for this widget, or -1 for the default
	 */
	setUSize: extern(gtk_widget_set_usize) func (width, height : GInt)

	/**
	 * The height of this window
	 */
	getWidth: func -> Int {
		// FIXME ugly workaround
		return this@ as WidgetStruct allocation width;
	}

	/**
	 * The height of this window
	 */
	getHeight: func -> Int {
		// FIXME ugly workaround
		return this@as WidgetStruct  allocation height;
	}

	/*
	getStyle: func -> Style {
		return gtk_widget_get_style(this) as Style;
	}
	*/

    addEvents: extern(gtk_widget_add_events) func (events: GdkEventMask)

    // TODO: add docs below
    destroyed: extern(gtk_widget_destroyed) func(widgetPointer: This*)
    set: extern(gtk_widget_set) func(firstProp: CString, ...)
    unparent: extern(gtk_widget_unparent) func
    showNow: extern(gtk_widget_show_now) func
    hideAll: extern(gtk_widget_hide_all) func
    map: extern(gtk_widget_map) func
    unmap: extern(gtk_widget_unmap) func
    unrealize: extern(gtk_widget_unrealize) func
    queueDraw: extern(gtk_widget_queue_draw) func
    queueResize: extern(gtk_widget_queue_resize) func
    queueResizeNoRedraw: extern(gtk_widget_queue_resize_no_redraw) func
    //draw: extern(gtk_widget_draw) func(area: GdkRectangle*) func
    //sizeRequest: extern(gtk_widget_size_request) func(requisition: Requisition)
    //getChildRequisition: extern(gtk_widget_get_child_requsition) func(requisition: Requisition)
    //sizeAllocate: extern(gtk_widget_size_allocate) func(allocation: Allocation)
    /*addAccelerator: func(signal: String, group: AccelGroup, key: UInt, mods: GdkModifierType, flags: AccelFlags) {
        gtk_widget_add_accelerator(this, signal, group, key, mods, flags)
    }*/
    //removeAccelerator: extern(gtk_widget_remove_accelerator) func(group: AccelGroup, key: UInt, mods: GdkModifierType)
    setAccelPath: func(path: String, group: AccelGroup) {
        gtk_widget_set_accel_path(this, path, group)
    }
    //listAccelClosures: extern(gtk_widget_list_accel_closures) func -> GList
    canActivateAccel?: extern(gtk_widget_can_activate_accel) func(signalId: UInt) -> Bool
    //event?: extern(gtk_widget_event) func(event: GdkEvent) -> Bool
    activate: extern(gtk_widget_activate) func -> Bool
    reparent: extern(gtk_widget_reparent) func(newParent: This)
    intersect: extern(gtk_widget_intersect) func~pointer(area,intersection: GdkRectangle*) -> Bool
    intersect: func~returnsTuple(area: GdkRectangle*) -> (GdkRectangle, Bool) {
        intersection: GdkRectangle
        ret := intersect~pointer(area, intersection&)
        (intersection, ret)
    }
    isFocus?: extern(gtk_widget_is_focus) func -> Bool
    grabFocus: extern(gtk_widget_grab_focus) func
    grabDefault: extern(gtk_widget_grab_default) func

    setName: func(name: String) {
        gtk_widget_set_name(name)
    }
    getName: extern(gtk_widget_get_name) func -> CString
    name: String {
        get {
            getName() toString()
        }
        set(name) {
            setName(name)
        }
    }

    //setState: extern(gtk_widget_set_state) func(state: StateType)
    setParent: extern(gtk_widget_set_parent) func(parent: This)

    setParentWindow: extern(gtk_widget_set_parent_window) func(parentWin: Window)
    getParentWindow: extern(gtk_widget_get_parent_window) func -> Window
    parentWindow: Window {
        get {
            getParentWindow()
        }
        set(parentWindow) {
            setParentWindow(parentWindow)
        }
    }

    setUPosition: extern(gtk_widget_set_uposition) func(x,y: Int)
    setUSize: extern(gtk_widget_set_usize) func(width,height: Int)

    setEvents: extern(gtk_widget_set_events) func(events: Int)
    getEvents: extern(gtk_widget_get_events) func -> Int
    events: Int {
        get {
            getEvents()
        }
        set(events) {
            setEvents(events)
        }
    }
    addEvents: extern(gtk_widget_add_events) func(events: Int)

    //setExtensionEvents: extern(gtk_widget_set_extension_events) func(mode: GdkExtensionMode)
    //getExtensionEvents: extern(gtk_widget_get_extension_events) func -> GdkExtensionMode
    /*extenstionEvents: GdkExtensionMode {
        get {
            getExtensionEvents()
        }
        set(mode) {
            setExtensionEvents(mode)
        }
    }*/

    getTopLevel: extern(gtk_widget_get_toplevel) func -> This
    //getAncestor: extern(gtk_widget_get_ancestor) func(type: GType) -> This

    //getColormap: extern(gtk_widget_get_colormap) func -> GdkColormap
    //setColormap: extern(gtk_widget_set_colormap) func(colormap: GdkColormap)
    /*colormap: GdkColormap {
        get {
            getColormap()
        }
        set(colormap) {
            setColormap(colormap)
        }
    }*/

    //getVisual: extern(gtk_widget_get_visual) -> GdkVisual
    getPointer: extern(gtk_widget_get_pointer) func~pointers(x,y: Int*)
    getPointer: func~returnsTuple -> (Int, Int) {
        x,y: Int
        getPointer~pointers(x&, y&)
        (x, y)
    }

    isAncestor?: extern(gtk_widget_is_ancestor) func(acenstor: This) -> Bool
    translateCoordinates: extern(gtk_widget_translate_coordinate) func~raw(dest: This, srcX,srcY: Int, destX,destY: Int*) -> Bool
    translateCoordinates: func~returnsTuple(dest: This, srcX,srcY: Int) -> (Int, Int, Bool) {
        destX, destY: Int
        ret := translateCoordinates~raw(dest, srcX, srcY, destX&, destY&)
        (destX, destY, ret)
    }
    hideOnDelete: extern(gtk_widget_hide_on_delete) func -> Bool

    //setStyle: extern(gtk_widget_set_style) func(style: Style)
    //getStyle: extern(gtk_widget_get_style) func -> Style
    /*style: Style {
        get {
            getStyle()
        }
        set(style) {
            setStyle(style)
        }
    }*/

    ensureStyle: extern(gtk_widget_ensure_style) func
    resetRcStyles: extern(gtk_widget_reset_rc_styles) func
    //pushColormap: static extern(gtk_widget_push_colormap) func(cmap: GdkColormap)
    popColormap: static extern(gtk_widget_pop_colormap) func

    //setDefaultColormap: static extern(gtk_widget_set_default_colormap) func(colormap: GdkColormap)
    //getDefaultColormap: static extern(gtk_widget_get_default_colormap) func -> GdkColormap
    /*defaultColormap: static GdkColormap {
        get {
            getDefaultColormap()
        }
        set(cmap) {
            setDefaultColormap(cmap)
        }
    }*/

    //getDefaultStyle: static extern(gtk_widget_get_default_style) func -> Style
    //getDefaultVisual: static extern(gtk_widget_get_default_visual) func -> GdkVisual

    setDirection: extern(gtk_widget_set_direction) func(dir: TextDirection)
    getDirection: extern(gtk_widget_get_direction) func -> TextDirection
    direction: TextDirection {
        get {
            getDirection()
        }
        set(dir) {
            setDirection(dir)
        }
    }

    setDefaultDirection: static extern(gtk_widget_set_default_direction) func(dir: TextDirection)
    getDefaultDirection: static extern(gtk_widget_get_default_direction) func -> TextDirection
    defaultDirection: static TextDirection {
        get {
            getDefaultDirection()
        }
        set(dir) {
            setDefaultDirection(dir)
        }
    }

    //shapeCombineMask: extern(gtk_widget_shape_combine_mask) func(shapeMask: GdkBitmap, offX,offY: Int)
    //inputShapeCombineMask: extern(gtk_widget_input_shape_combine_mask) func(shapeMask: GdkBitmap, offX,offY: Int)
    path: extern(gtk_widget_path) func~raw(length: UInt*, path: CString*, pathReversed: CString*)
    path: func~oocstring -> (String[], String[]) {
        length: UInt
        cPath, cPathReversed: CString*
        path~raw(length&, cPath, cPathReversed)
        path, pathReserved: String[length]
        for(i in 0 .. length) {
            path[i] = cPath[i] toString()
            pathReversed[i] = cPathReversed[i] toString()
        }
        (path, pathReserved)
    }
    classPath: extern(gtk_widget_class_path) func~raw(length: UInt*, path: CString*, pathReversed: CString*)
    classPath: func~oocstring -> (String[], String[]) {
        length: UInt
        cPath, cPathReversed: CString*
        path~raw(length&, cPath, cPathReversed)
        path, pathReserved: String[length]
        for(i in 0 .. length) {
            path[i] = cPath[i] toString()
            pathReversed[i] = cPathReversed[i] toString()
        }
        (path, pathReserved)
    }

    getCompositeName: extern(gtk_widget_get_composite_name) func -> CString
    //modifyStyle: extern(gtk_widget_modify_style) func(style: RcStyle)
    //getModifierStyle: extern(gtk_widget_get_modifier_style) func -> RcStyle
    //modifyFg: extern(gtk_widget_modify_fg) func(state: StateType, color: GdkColor)
    //modifyBg: extern(gtk_widget_modify_bg) func(state: StateType, color: GdkColor)
    //modifyText: extern(gtk_widget_modify_text) func(state: StateType, color: GdkColor)
    //modifyBase: extern(gtk_widget_modify_text) func(state: StateType, color: GdkColor)
    //modifyCursor: extern(gtk_widget_modify_cursor) func(primary, secondary: GdkColor)
        
    //modifyFont: extern(gtk_widget_modify_font) func(fontDesc: PangoFontDescription)
    //createPangoContext: extern(gtk_widget_create_pango_context) func -> PangoContext
    //getPangoContext: extern(gtk_widget_get_pango_context) func -> PangoContext
    /*createPangoLayout: func(text: String) -> PangoLayout {
        gtk_widget_create_pango_layout(this, text)
    }*/

    /*renderIcon: func(stockId: String, size: IconSize, detail: String) {
        gtk_widget_render_icon(this, stockId, size, detail)
    }*/

    pushCompositeChild: static extern(gtk_push_composite_child) func
    popCompositeChild: static extern(gtk_pop_composite_child) func
    queueClear: extern(gtk_widget_queue_clear) func
    queueClearArea: extern(gtk_widget_queue_clear_area) func(x,y,width,height: Int)
    queueDrawArea: extern(gtk_widget_queue_draw_area) func(x,y,width,height: Int)
    resetShapes: extern(gtk_widget_reset_shapes) func
    setDoubleBuffered: extern(gtk_widget_set_double_buffered) func(dbuff: Bool)
    setRedrawOnAllocate: extern(gtk_widget_set_redraw_on_allocate) func(redrawOnAllocate: Bool)
    setCompositeName: func(name: String) {
        gtk_widget_set_composite_name(this, name)
    }
    setScrollAdjustments: extern(gtk_widget_set_scroll_adjustments) func(hadj,vadj: Adjustment) -> Bool
    mnemonicActivate: extern(gtk_widget_mnemonic_activate) func(groupCycling: Bool) -> Bool
    //regionIntersect: extern(gtk_widget_region_intersect) func(region: GdkRegion) -> GdkRegion
    //sendExpose: extern(gtk_widget_send_expose) func(event: GdkEvent) -> Int
    //sendFocusChange: extern(gtk_widget_send_focus_change) func(event: GdkEvent) -> Bool
    styleGet: extern(gtk_widget_style_get) func(firstPropertyName: CString, ...)
    getProperty: extern(gtk_widget_style_get_property) func(propertyName: CString, value: Pointer)
    styleGetVaList: extern(gtk_widget_style_get_valist) func(firstPropertyName: CString, vaArgs: VaList)
    styleAttach: extern(gtk_widget_style_attach) func
    //getAccessible: extern(gtk_widget_get_accessible) func -> AtkObject
    //childFocus: extern(gtk_widget_child_focus) func(direction: DirectionType) -> Bool
    childNotify: func(prop: String) {
        gtk_widget_child_notify(oro)
    }
    getChildVisible?: extern(gtk_widget_get_child_visible) func -> Bool
    getParent: extern(gtk_widget_get_parent) func -> This
    //getSettings: extern(gtk_widget_get_settigs) func -> Settings
    //getClipboard: extern(gtk_widget_get_clipboard) func(selection: GdkAtom) -> Clipboard
}

//gtk_widget_add_accelerator: extern func(Widget, CString, AccelGroup, UInt, GdkModifierType, AccelFlags)
gtk_widget_set_accel_path: extern func(Widget, CString, AccelGroup)
gtk_widget_set_name: extern func(Widget, CString)
//gtk_widget_create_pango_layout: extern func(Widget, CString) -> PangoLayout
//gtk_widget_render_icon: extern func(Widget, CString, IconSize, CString) -> GdkPixbuf
gtk_widget_set_composite_name: extern func(Widget, CString)
gtk_widget_child_notify: extern func(Widget, CString)

GdkEventMask: enum {
  EXPOSURE_MASK           = 1 << 1,
  POINTER_MOTION_MASK = 1 << 2,
  POINTER_MOTION_HINT_MASK = 1 << 3,
  BUTTON_MOTION_MASK = 1 << 4,
  BUTTON1_MOTION_MASK = 1 << 5,
  BUTTON2_MOTION_MASK = 1 << 6,
  BUTTON3_MOTION_MASK = 1 << 7,
  BUTTON_PRESS_MASK         = 1 << 8,
  BUTTON_RELEASE_MASK = 1 << 9,
  KEY_PRESS_MASK            = 1 << 10,
  KEY_RELEASE_MASK          = 1 << 11,
  ENTER_NOTIFY_MASK         = 1 << 12,
  LEAVE_NOTIFY_MASK         = 1 << 13,
  FOCUS_CHANGE_MASK         = 1 << 14,
  STRUCTURE_MASK            = 1 << 15,
  PROPERTY_CHANGE_MASK = 1 << 16,
  VISIBILITY_NOTIFY_MASK = 1 << 17,
  PROXIMITY_IN_MASK         = 1 << 18,
  PROXIMITY_OUT_MASK = 1 << 19,
  SUBSTRUCTURE_MASK         = 1 << 20,
  SCROLL_MASK               = 1 << 21,
  ALL_EVENTS_MASK           = 0x3FFFFE 
}

TextDirection: extern(GtkTextDirection) enum {
    none: extern(GTK_TEXT_DIR_NONE),
    ltr: extern(GTK_TEXT_DIR_LTR),
    rtl: extern(GTK_TEXT_DIR_RTL)
}

GTK_WIDGET_REALIZED: extern func (Widget) -> Bool

GdkWindow: extern cover
GdkRectangle: extern cover

GtkAllocation: extern cover {
    width, height: extern Int
}

gdk_window_invalidate_rect: extern func (GdkWindow*, GdkRectangle, Bool)
gdk_window_process_updates: extern func (GdkWindow*, Bool)

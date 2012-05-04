use gtk, gdk
import gtk/[Container, Widget, TextIter, TextBuffer, TextTag]
import gdk/Event

TextWindowType: extern(GtkTextWindowType) enum {
    private: extern(GTK_TEXT_WINDOW_PRIVATE),
    widget: extern(GTK_TEXT_WINDOW_WIDGET),
    text: extern(GTK_TEXT_WINDOW_TEXT),
    left: extern(GTK_TEXT_WINDOW_LEFT),
    right: extern(GTK_TEXT_WINDOW_RIGHT),
    top: extern(GTK_TEXT_WINDOW_TOP),
    bottom: extern(GTK_TEXT_WINDOW_BOTTOM)
}

TextChildAnchor: cover from GtkTextChildAnchor* {
    new: static extern(gtk_text_child_anchow_new) func -> This
    //getWidgets: extern(gtk_text_child_get_widgets) func -> GList
    deleted?: extern(gtk_text_child_anchor_get_deleted) func -> Bool
}

// Need TextBuffer, TextMark, TextIter, GList, PangoTabArray, Adjustment, GSList, TextAttributes, TextTagTable, TextTag, ClipBoard, GdkAtom, GError, GtkTargetList for complete class

TextView: cover from GtkTextView* extends Container {

    /**
     * Create a new, empty TextView
     */
    new: static extern(gtk_text_view_new) func -> This

    /**
     * Create a new TextView from a TextBuffer
     */
    new: static extern(gtk_text_view_new_with_buffer) func ~withBuffer -> This

    /**
     * Set the TextView's buffer
     */
    setBuffer: extern(gtk_text_view_set_buffer) func(buffer: TextBuffer)

    /**
     * Get the TextView's buffer
     */
    getBuffer: extern(gtk_text_view_get_buffer) func -> TextBuffer

    buffer: TextBuffer {
        get {
            getBuffer()
        }
        set(buffer: TextBuffer) {
            setBuffer(buffer)
        }
    }

    /**
     * Scroll the TextView to mark
     */
    scrollToMark: extern(gtk_text_view_scroll_to_mark) func(mark: TextMark, margin: GDouble, align?: Bool, xalign,yalign: GDouble)

    /**
     * Scroll the TextView to iterator
     */
    scrollToIter: extern(gtk_text_view_scroll_to_iter) func(iter: TextIter, margin: GDouble, align?: Bool, xalign,yalign: GDouble) -> Bool

    /**
     * Scrolls TextView the minimum distance such that mark is contained within the visible area of the widget
     */
    scrollMarkOnScreen: extern(gtk_text_view_scroll_mark_onscreen) func(mark: TextMark)

    /**
     * Moves a mark within the buffer so that it's located within the currently-visible text area
     */
    //moveMarkOnScreen: extern(gtk_text_view_move_mark_onscreen) func(mark: TextMark) -> Bool

    /**
     * Moves the cursor to the currently visible region of the buffer, it it isn't there already
     */
    placeCursorOnScreen: extern(gtk_text_view_place_cursor_onscreen) func -> Bool

    /**
     * Fills visible_rect with the currently-visible region of the buffer, in buffer coordinates. Convert to window coordinates with TextView bufferToWindowCoords
     */
    getVisibleRect: extern(gtk_text_view_get_visible_rect) func ~pointer (rect: GdkRectangle*)
    getVisibleRect: func ~returns -> GdkRectangle {
        rect: GdkRectangle
        getVisibleRect(rect&)
        rect
    }

    /**
     * Gets a rectangle which roughly contains the character at iter. The rectangle position is in buffer coordinates
     */
    //getIterLocation: extern(gtk_text_view_get_iter_location) func ~pointer (iter: TextIter, location: GdkRectangle*)
    /*getIterLocation: func ~returns (iter: TextIter) -> GdkRectangle {
        location: GdkRectangle
        getIterLocation(iter,location&)
        location
    }*/

    /**
     * Gets the GtkTextIter at the start of the line containing the coordinate y. y is in buffer coordinates. If non-null, line_top will be filled with the coordinate of the top edge of the line.
     */
    //getLineAtY: extern(gtk_text_view_get_line_at_y) func ~pointer (target: TextIter, y: Int, line_top: Int*)
    /*getLineAtY: func ~returns (y: Int, line_top: Int* = null) -> TextIter {
        target: TextIter = null
        getLineAtY(target,y,line_top)
        target
    }*/

    /**
     * Gets the y coordinate of the top of the line containing iter, and the height of the line. The coordinate is a buffer coordinate
     */
    //getLineYRange: extern(gtk_text_view_get_line_yrange) func ~pointers (iter: TextIter, y,height: Int*)
    /*getLineYRange: func ~returnsTuple (iter: TextIter) -> (Int, Int) {
        y,height: Int
        getLineYRange(iter,y&,height&)
        (y,height)
    }*/

    /**
     * Retrieves the iterator at buffer coordinates x and y. Buffer coordinates are coordinates for the entire buffer, not just the currently-displayed portion.
     */
    //getIterAtLocation: extern(gtk_text_view_get_iter_at_location) func ~pointer (iter: TextIter, x,y: Int)
    /*getIterAtLocation: func ~returns (x,y: Int) -> TextIter {
        iter: TextIter
        getIterAtLocation(iter,x,y)
        iter
    }*/

    /**
     * Retrieves the iterator pointing to the character at buffer coordinates x and y. Buffer coordinates are coordinates for the entire buffer, not just the currently-displayed portion. Note that this is different from TextView getIterAtLocation, which returns cursor locations, i.e. positions between characters.
     * trailing: if non-NULL, location to store an integer indicating where in the grapheme the user clicked. It will either be zero, or the number of characters in the grapheme. 0 represents the trailing edge of the grapheme.
     */
    //getIterAtPosition: extern(gtk_view_get_iter_at_position) func ~pointer (iter: TextIter, trailing: Int*, x,y: Int)
    /*getIterAtPosition: func ~returns (x,y: Int, trailing: Int* = null) -> TextIter {
        iter: TextIter
        getIterAtPosition(iter,trailing,x,y)
        iter
    }*/

    /**
     * Converts coordinate (buffer_x, buffer_y) to coordinates for the window win, and stores the result in (window_x, window_y)
     */
    bufferToWindowCoords: extern(gtk_text_view_buffer_to_window_coords) func ~pointers (win: TextWindowType, buffer_x,buffer_y: Int, window_x,window_y: Int*)
    bufferToWindowCoords: func ~returnsTuple (win: TextWindowType, buffer_x,buffer_y: Int) -> (Int,Int) {
        window_x,window_y: Int
        bufferToWindowCoords(win, buffer_x, buffer_y, window_x&, window_y&)
        (window_x, window_y)
    }

    /**
     * Converts coordinates on the window identified by win to buffer coordinates, storing the result in (buffer_x,buffer_y)
     */
    windowToBufferCoords: extern(gtk_text_view_window_to_buffer_coords) func ~pointers (win: TextWindowType, window_x,window_y: Int, buffer_x,buffer_y: Int*)
    windowToBufferCoords: func ~returnsTuple (win: TextWindowType, window_x,window_y: Int) -> (Int, Int) {
        buffer_x,buffer_y: Int
        windowToBufferCoords(win, window_x, window_y, buffer_x&, buffer_y&)
        (buffer_x, buffer_y)
    }

    /**
     * Usually used to find out which window an event corresponds to. If you connect to an event signal on text_view, this function should be called on event->window to see which window it was.
     */
    getWindowType: extern(gtk_text_view_get_window_type) func(window: GdkWindow*) -> TextWindowType

    /**
     * Sets the width of GTK_TEXT_WINDOW_LEFT or GTK_TEXT_WINDOW_RIGHT, or the height of GTK_TEXT_WINDOW_TOP or GTK_TEXT_WINDOW_BOTTOM. Automatically destroys the corresponding window if the size is set to 0, and creates the window if the size is set to non-zero. This function can only be used for the "border windows"
     */
    setBorderWindowSize: extern(gtk_text_view_set_border_window_size) func(type: TextWindowType, size: Int)

    /**
     * Come on, really?!
     */
    getBorderWindowSize: extern(gtk_text_view_get_border_window_size) func(type: TextWindowType) -> Int

    /**
     * Moves the given iter forward by one display (wrapped) line. A display line is different from a paragraph. Paragraphs are separated by newlines or other paragraph separator characters. Display lines are created by line-wrapping a paragraph. If wrapping is turned off, display lines and paragraphs will be the same.
     */
    viewForwardDisplayLine: extern(gtk_text_view_forward_display_line) func(iter: TextIter) -> Bool

    /**
     * Same as above but backwards
     */
    viewBackwardDisplayLine: extern(gtk_text_view_backward_display_line) func(iter: TextIter) -> Bool

    /**
     * Moves the given iter forward to the next display line end.
     */
    viewForwardDisplayLineEnd: extern(gtk_text_view_forward_display_line_end) func(iter: TextIter) -> Bool

    /**
     * Same as above but backwards and at line start.
     */
    viewBackwardDisplayLineStart: extern(gtk_text_view_backward_display_line_start) func(iter: TextIter) -> Bool

    /**
     * Determines whether iter is at the start of a display line.
     */
    startsDisplayLine?: extern(gtk_text_view_starts_display_line) func(iter: TextIter) -> Bool

    /**
     * Move the iterator a given number of characters visually, treating it as the strong cursor position. If count is positive, then the new strong cursor position will be count positions to the right of the old cursor position. If count is negative then the new strong cursor position will be count positions to the left of the old cursor position.
     */
    moveVisually: extern(gtk_text_view_move_visually) func(iter: TextIter, count: Int) -> Bool

    /**
     * Adds a child widget in the text buffer, at the given anchor.
     */
    addChildAtAnchor: extern(gtk_text_view_add_child_at_anchor) func(child: Widget, anchor: TextChildAnchor)

    /**
     * Adds a child at fixed coordinates in one of the text widget's windows. . Note that the child coordinates are given relative to the GdkWindow in question, and that these coordinates have no sane relationship to scrolling. When placing a child in GTK_TEXT_WINDOW_WIDGET, scrolling is irrelevant, the child floats above all scrollable areas.
     */
     addChildInWindow: extern(gtk_text_view_add_child_in_window) func(child: Widget, win: TextWindowType, xpos,ypos: Int)

    /**
     * Updates the position of a child, as for TextView addChildInWindow
     */
    moveChild: extern(gtk_text_view_move_child) func(child: Widget, xpos,ypos: Int)

    getWrapMode: extern(gtk_text_view_get_wrap_mode) func -> WrapMode
    setWrapMode: extern(gtk_text_view_set_wrap_mode) func(mode: WrapMode)
    wrapMode: WrapMode {
        get {
            getWrapMode()
        }
        set(mode: WrapMode) {
            setWrapMode(mode)
        }
    }

    /**
     * The default editability of the GtkTextView. You can override this default setting with tags in the buffer, using the "editable" attribute of tags.
     */
     getEditable?: extern(gtk_text_view_get_editable) func -> Bool
     setEditable?: extern(gtk_text_view_set_editable) func(editable: Bool)
     editable?: Bool {
        get {
            getEditable?()
        }
        set(editable: Bool) {
            setEditable?(editable)
        }
     }

    /**
     * Whether the insertion point is displayed. A buffer with no editable text probably shouldn't have a visible cursor, so you may want to turn the cursor off.
     */
    getCursorVisible?: extern(gtk_text_view_get_cursor_visible) func -> Bool
    setCursorVisible?: extern(gtk_text_view_set_cursor_visible) func(cursorVisible: Bool)
    cursorVisible?: Bool {
        get {
            getCursorVisible?()
        }
        set(cursorVisible: Bool) {
            setCursorVisible?(cursorVisible)
        }
    }

    /**
     * Whether the TextView is in overwrite mode or not.
     */
    getOverwrite?: extern(gtk_text_view_get_overwrite) func -> Bool
    setOverwrite?: extern(gtk_text_view_set_overwrite) func(overwrite: Bool)
    overwrite?: Bool {
        get {
            getOverwrite?()
        }
        set(overwrite: Bool) {
            setOverwrite?(overwrite)
        }
    }

    /**
     * The default number of blank pixels above paragraphs in the text view. Tags in the buffer for the text view may override the defaults.
     */
    getPixelsAboveLines: extern(gtk_text_view_get_pixels_above_lines) func -> Int
    setPixelsAboveLines: extern(gtk_text_view_set_pixels_above_lines) func(pixels: Int)
    pixelsAboveLines: Int {
        get {
            getPixelsAboveLines()
        }
        set(pixels: Int) {
            setPixelsAboveLines(pixels)
        }
    }

    /**
     * The default number of blank pixels below paragraphs in the text view. Tags in the buffer for the text view may override the defaults.
     */
    getPixelsBelowLines: extern(gtk_text_view_get_pixels_below_lines) func -> Int
    setPixelsBelowLines: extern(gtk_text_view_set_pixels_below_lines) func(pixels: Int)
    pixelsBelowLines: Int {
        get {
            getPixelsBelowLines()
        }
        set(pixels: Int) {
            setPixelsBelowLines(pixels)
        }
    }

    /**
     * Sets the default number of pixels of blank space to leave between display/wrapped lines within a paragraph. May be overridden by tags in the text view's buffer.
     */
    getPixelsInsideWrap: extern(gtk_text_view_get_pixels_inside_wrap) func -> Int
    setPixelsInsideWrap: extern(gtk_text_view_set_pixels_inside_wrap) func(pixels: Int)
    pixelsInsideWrap: Int {
        get {
            getPixelsInsideWrap()
        }
        set(pixels: Int) {
            setPixelsInsideWrap(pixels)
        }
    }

    /**
     * The default justification of text in text_view. Tags in the view's buffer may override the default.
     */
    getJustification: extern(gtk_text_view_get_justification) -> Justification
    setJustification: extern(gtk_text_view_set_justification) func(just: Justification)
    justification: Justification {
        get {
            getJustification()
        }
        set(just: Justification) {
            setJustification(just)
        }
    }

    /**
     * The default left margin for text in text_view. Tags in the buffer may override the default.
     */
    getLeftMargin: extern(gtk_text_view_get_left_margin) func -> Int
    setLeftMargin: extern(gtk_text_view_set_left_margin) func(margin: Int)
    leftMargin: Int {
        get {
            getLeftMargin()
        }
        set(margin: Int) {
            setLeftMargin(margin)
        }
    }

    /**
     * The default right margin for text in the text view. Tags in the buffer may override the default.
     */
    getRightMargin: extern(gtk_text_view_get_right_margin) func -> Int
    setRightMargin: extern(gtk_text_view_set_right_margin) func(margin: Int)
    rightMargin: Int {
        get {
            getRightMargin()
        }
        set(margin: Int) {
            setRightMArgin(margin)
        }
    }

    /**
     * The default indentation for paragraphs in the text view. Tags in the buffer may override the default.
     */
    getIndent: extern(gtk_text_view_get_indent) func -> Int
    setIndent: extern(gtk_text_view_set_indent) func(indent: Int)
    indent: Int {
        get {
            getIndent()
        }
        set(indent: Int) {
            setIndent(indent)
        }
    }

    /**
     * The default tab stops for paragraphs in the text view. Tags in the buffer may override the default.
     */
    /*tabs: PangoTabArray {
        get: extern(gtk_text_view_get_tabs)
        set: extern(gtk_text_view_set_tabs)
    }*/

    /**
     * Sets the behavior of the text widget when the Tab key is pressed. If acceptsTab? is true, a tab character is inserted. If acceptsTab? is false the keyboard focus is moved to the next widget in the focus chain.
     */
    getAcceptsTab?: extern(gtk_text_view_get_accepts_tab) func -> Bool
    setAcceptsTab?: extern(gtk_text_view_set_accepts_tab) func(acceptsTab: Bool)
    acceptsTab?: Bool {
        get {
            getAcceptsTab?()
        }
        set(acceptsTab: Bool) {
            setAcceptsTab?(acceptsTab)
        }
    }

    /**
     * Obtains a copy of the default text attributes. These are the attributes used for text unless a tag overrides them.
     */
    getDefaultAttributes: extern(gtk_text_view_get_default_attributes) func -> TextAttributes*

    /**
     * Allow the TextView input method to internally handle key press and release events. If this function returns true, then no further processing should be done for this key event. See IMContext filterKeypress. Note that you are expected to call this function from your handler when overriding key event handling. This is needed in the case when you need to insert your own key handling between the input method and the default key event handling of the TextView.
    */
   IMContextFilterKeypress: extern(gtk_text_view_im_context_filter_keypress) func(event: EventKey*) -> Bool

    /**
     * Reset the input method context of the text view if needed. This can be necessary in the case where modifying the buffer would confuse on-going input method behavior.
     */
    resetIMContext: extern(gtk_text_view_reset_im_context) func

    /**
     * Gets the horizontal-scrolling Adjustment.
     */
    getHAdjustment: extern(gtk_text_view_get_hadjustment) func -> Adjustment

    /**
     * Gets the vertical-scrolling Adjustment.
     */
    getVAdjustment: extern(gtk_text_view_get_vadjustment) func -> Adjustment
}


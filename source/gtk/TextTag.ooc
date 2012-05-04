use gtk
import gtk/[Gtk, _GObject, Widget, TextIter]

//TODO: add docs

WrapMode: extern(GtkWrapMode) enum {
    none: extern(GTK_WRAP_NONE),
    char: extern(GTK_WRAP_CHAR),
    word: extern(GTK_WRAP_WORD),
    wordChar: extern(GTK_WRAP_WORD_CHAR)
}

TextAppearance: cover from GtkTextAppearance {
    //bgColor: extern(bg_color) Color
    //fgColor: extern(fg_color) Color
    //bgStipple: extern(bg_stipple) Bitmap
    //fgStipple: extern(fg_stipple) Bitmap
    rise: extern Int
    underline: extern UInt
    strikethrough: extern UInt
    drawBg: extern(draw_bg) UInt
    insideSelection: extern(inside_selection) UInt
    text?: extern(is_text) UInt
}

TextAttributes: cover from GtkTextAttributes {
    appearance: extern TextAppearance
    justification: extern Justification
    direction: extern TextDirection
    //font: extern PangoDontDescription
    fontScale: extern(font_scale) Double
    leftMargin: extern(left_margin) Int
    indent: extern Int
    rightMargin: extern(right_margin) Int
    pixelsAboveLines: extern(pixels_above_line) Int
    pixelsBelowLines: extern(pixels_below_lines) Int
    pixelsInsideWrap: extern(pixels_inside_wrap) Int
    //tabs: extern PangoTabArray
    wrapMode: extern(wrap_mode) WrapMode
    //language: extern PangoLanguage
    invisible: extern UInt
    bgFullHeight: extern(bg_full_height) UInt
    editable: extern UInt
    realized: extern UInt

    new: static extern(gtk_text_attributes_new) func -> This*
    copy: extern(gtk_text_attributes_copy) func@ -> This*
    copyValues: extern(gtk_text_attributes_copy_values) func@(dest: This*)
    unref: extern(gtk_text_attributes_unref)  func@
}

TextTag: cover from GtkTextTag* extends _GObject {
    new: static func(name: String) -> This {
        gtk_text_tag_new(name)
    }

    getPriority: extern(gtk_text_tag_get_priority) func -> Int
    setPriority: extern(gtk_text_tag_set_priority) func(priority: Int)
    priority: Int {
        get {
            getPriority()
        }
        set(priority) {
            setPriority(priority)
        }
    }

    //tagEvent: extern(gtk_text_tag_event) func(eventObject: _GObject, event: Event, iter: TextIter) -> Bool
}

TextTagTable: cover from GtkTextTagTable* extends _GObject {
    new: static extern(gtk_text_tag_table_new) func -> This
    add: extern(gtk_text_tag_table_add) func(tag: TextTag)
    remove: extern(gtk_text_tag_table_remove) func(tag: TextTag)
    lookup: func(name: String) -> TextTag {
        gtk_text_tag_table_lookup(this, name)
    }

    // Raw C function
    each: extern(gtk_text_tag_table_foreach) func~raw(f: Pointer, data: Pointer)
    // An ooc closure takes the context as a last argument so we can pass it as out data ;)
    each: func~closure(f: Func(TextTag)) {
        thunk := f as Closure thunk
        context := f as Closure context
        each~raw(thunk, context)
    }

    getSize: extern(gtk_text_tag_table_get_size) func -> Int
}

gtk_text_tag_table_lookup: extern func(TextTagTable, CString) -> TextTag
gtk_text_tag_new: extern func(CString) -> TextTag

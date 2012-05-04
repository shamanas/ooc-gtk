use gtk
import gtk/[Gtk, _GObject, TextIter]

TextBufferTargetInfo: extern(GtkTextBufferTargetInfo) enum {
    bufferContents: extern(GTK_TEXT_BUFFER_TARGET_INFO_BUFFER_CONTENTS),
    richText: extern(GTK_TEXT_BUFFER_TARGET_INFO_RICH_TEXT),
    text: extern(GTK_TEXT_BUFFER_TARGET_INFO_TEXT)
}

// TODO: add doc
TextBuffer: cover from GtkTextBuffer* extends _GObject {
    new: extern(gtk_text_buffer_new) func(table: TextTagTable) -> This
    getLineCount: extern(gtk_text_buffer_get_line_count) func -> Int
    getCharCount: extern(gtk_text_buffer_get_char_count) func -> Int
    getTagTable: extern(gtk_text_buffer_get_tag_table) func -> TextTagTable
    insert: func(iter: TextIter, text: String, len: Int) {
        gtk_text_buffer_insert(this, iter, text, len)
    }
    insertAtCursor: func(text: String, len: Int) {
        gtk_text_buffer_insert_at_cursor(this, text, len)
    }
    insertInteractive: func(iter: TextIter, text: String, len: Int, default_editable: Bool) -> Bool {
        gtk_text_buffer_insert_interactive(this, iter, text, len, default_editable)
    }
    insertInteractiveAtCursor: func(text: String, len: Int, default_editable: Bool) -> Bool {
        gtk_text_buffer_insert_interactive_at_cursor(this, text, len, default_editable)
    }
    insertRange: extern(gtk_text_buffer_insert_range) func(iter,start,end: TextIter)
    insertRangeInteractive: extern(gtk_text_buffer_insert_range_interactive) func(iter,start,end: TextIter, default_editable: Bool) -> Bool
    insertWithTags: func(iter: TextIter, text: String, len: Int, firstTag: TextTag, ...) {
        va: VaList
        va_start(va, firstTag)
        gtk_text_buffer_insert_with_tags(this, iter, text, len, firstTag, va)
        va_end(va)
    }
    insertWothTagsByName: func(iter: TextIter, text: String, len: Int, firstTagName: CString, ...) {
        va: VaList
        va_start(va, firstTagName)
        gtk_text_buffer_insert_with_tags_by_name(this, iter, text, len, firstTagName, va)
        va_end(va)
    }

    delete: extern(gtk_text_buffer_delete) func(start,end: TextIter)
    deleteInteractive: extern(gtk_text_buffer_delete_interactive) func(start,end: TextIter, defaultEditable: Bool) -> Bool
    bufferBackspace: extern(gtk_text_buffer_backspace) func(iter: TextIter, interactive,defaultEditable: Bool) -> Bool

    setText: func(text: String) {
        gtk_text_buffer_set_text(this, text, text length())
    }
    getText: extern(gtk_text_buffer_get_text) func(start,end: TextIter, includeHiddenChars: Bool) -> CString
    getSlice: extern(gtk_text_buffer_get_slice) func(start,end: TextIter, includeHiddenChars: Bool) -> CString

    //insertPixbuf: extern(gtk_text_buffer_insert_pixbuf) func(iter: TextIter, pixbuf: Pixbuf)
    insertChildAnchor: extern(gtk_text_buffer_insert_child_anchor) func(iter: TextIter, anchor: TextChildAnchor)
    createChildAnchor: extern(gtk_text_buffer_create_child_anchor) func(iter: TextIter) -> TextChildAnchor
    createMark: func(markName: String, where: TextIter, leftGravity: Bool) -> TextMark {
        gtk_text_buffer_create_mark(this, markName, where, leftGravity)
    }
    moveMark: extern(gtk_text_buffer_move_mark) func(mark: TextMark, where: TextIter)
    moveMarkByName: func(name: String, where: TextIter) {
        gtk_text_buffer_move_mark_by_name(this, name, where)
    }
    addMark: extern(gtk_text_buffer_add_mark) func(mark: TextMark, where: TextIter)
    deleteMark: extern(gtk_text_buffer_delete_mark) func(mark: TextMark)
    deleteMarkByName: func(name: String) {
        gtk_text_buffer_delete_mark_by_name(this, name)
    }
    getMark: func(name: String) -> TextMark {
        gtk_text_buffer_get_mark(this, name)
    }
    getInsert: extern(gtk_text_buffer_get_insert) func -> TextMark
    getSelectionBound: extern(gtk_text_buffer_get_selection_bound) func -> TextMark
    hasSelection?: extern(gtk_text_buffer_get_has_selection) func -> Bool
    placeCursor: extern(gtk_text_buffer_place_cursor) func(where: TextIter)
    selectRange: extern(gtk_text_buffer_select_range) func(ins,bound: TextIter)
    applyTag: extern(gtk_text_buffer_apply_tag) func(tag: TextTag, start,end: TextIter)
    removeTag: extern(gtk_text_buffer_remove_tag) func(tag: TextTag, start,end: TextIter)
    applyTagByName: func(name: String, start,end: TextIter) {
        gtk_text_buffer_apply_tag_by_name(this, name, start, end)
    }
    removeTagByName: func(name: String, start,end: TextIter) {
        gtk_text_buffer_remove_tag_by_name(this, name, start, end)
    }
    removeAllTags: extern(gtk_text_buffer_remove_all_tags) func(start,end: TextIter)
    createTag: extern(gtk_text_buffer_create_tag) func(tagName,firstPropertyName: CString, ...) -> TextTag

    getIterAtLineOffset: extern(gtk_text_buffer_get_iter_at_line_offset) func~pointer(iter: TextIter, lineNum,charOffset: Int)
    getIterAtLineOffset: func~returns(lineNum,charOffset: Int) -> TextIter {
        iter: TextIter
        getIterAtLineOffset~pointer(iter, lineNum, charOffset)
        iter
    }

    getIterAtOffset: extern(gtk_text_buffer_get_iter_at_offset) func~pointer(iter: TextIter, charOffset: Int)
    getIterAtOffset: func~returns(charOffset: Int) -> TextIter {
        iter: TextIter
        getIterAtOffset~pointer(iter, charOffset)
        iter
    }

    getIterAtLine: extern(gtk_text_buffer_get_iter_at_line) func~pointer(iter: TextIter, lineNum: Int)
    getIterAtLine: func~returns(lineNum: Int) -> TextIter {
        iter: TextIter
        getIterAtLine(iter, lineNum)
        iter
    }

    getIterAtLineIndex: extern(gtk_text_buffer_get_iter_at_line_index) func~pointer(iter: TextIter, lineNum,byteIndex: Int)
    getIterAtLineIndex: func~returns(lineNum,byteIndex: Int) -> TextIter {
        iter: TextIter
        getIterAtLineIndex~pointer(iter, lineNum, byteIndex)
        iter
    }

    getIterAtMark: extern(gtk_text_buffer_get_iter_at_mark) func~pointer(iter: TextIter, mark: TextMark)
    getIterAtMark: func~returns(mark: TextMark) -> TextIter {
        iter: TextIter
        getIterAtMark~pointer(iter, mark)
        iter
    }

    getIterAtChildAnchor: extern(gtk_text_buffer_get_iter_at_child_anchor) func~pointer(iter: TextIter, anchor: TextChildAnchor)
    getIterAtChildAnchor: func~returns(anchor: TextChildAnchor) -> TextIter {
        iter: TextIter
        getIterAtChildAnchor~pointer(iter, anchor)
        iter
    }

    getStartIter: extern(gtk_text_buffer_get_start_iter) func~pointer(iter: TextIter)
    getStartIter: func~returns -> TextIter {
        iter: TextIter
        getStartIter~pointer(iter)
        iter
    }

    getEndIter: extern(gtk_text_buffer_get_end_iter) func~pointer(iter: TextIter)
    getEndIter: func~returns -> TextIter {
        iter: TextIter
        getEndIter~pointer(iter)
        iter
    }

    getBounds: extern(gtk_text_buffer_get_bounds) func~pointers(start,end: TextIter)
    getBounds: func~returnsTuple -> (TextIter, TextIter) {
        start, end: TextIter
        getBounds~pointers(start, send)
        (start, end)
    }

    getModified?: extern(gtk_text_buffer_get_modified) func -> Bool
    setModified?: extern(gtk_text_buffer_set_modified) func(setting: Bool)
    modified?: Bool {
        get {
            getModified?()
        }
        set(setting: Bool) {
            setModified?(setting)
        }
    }

    deleteSelection: extern(gtk_text_buffer_delete_selection) func(interactive, defaultEditable: Bool) -> Bool
    //pasteClipboard: extern(gtk_text_buffer_paste_clipboard) func(clipboard: Clipboard, overrideLocation: TextIter, defaultEditable: Bool)
    //copyClipboard: extern(gtk_text_buffer_copy_clipboard) func(clipboard: Clipboard)
    //cutClipboard: extern(gtk_text_buffer_cut_clipboard) func(clipboard: Clipboard)

    getSelectionBounds: extern(gtk_text_buffer_get_selection_bounds) func~pointers(start,end) -> Bool
    getSelectionBounds: func~returnsTuple -> (TextIter, TextIter, Bool) {
        start, end: TextIter
        (start, end, getSelectionBounds~pointers(start, end))
    }

    beginUserAction: extern(gtk_text_buffer_begin_user_action) func
    endUserAction: extern(gtk_text_buffer_end_user_action) func

    //addSelectionClipboard: extern(gtk_text_buffer_add_selection_clipboard) func(clipboard: Clipboard)
    //removeSelectionClipboard: extern(gtk_text_buffer_remove_selection_clipboard) func(clipboard: Clipboard)

    //TODO: Add serialization funcs
    
}

gtk_text_buffer_insert: extern func(TextBuffer, TextIter, CString, Int)
gtk_text_buffer_insert_at_cursor: extern func(TextBuffer, CString, Int)
gtk_text_buffer_insert_interactive: extern func(TextBuffer, TextIter, CString, Int, Bool) -> Bool
gtk_text_buffer_insert_interactive_at_cursor: extern func(TextBuffer, CString, Int, Bool) -> Bool
gtk_text_buffer_insert_with_tags: extern func(TextBuffer, TextIter, CString, Int, TextTag, VaList)
gtk_text_buffer_insert_with_tags_by_name: extern func(TextBuffer, TextIter, CString, Int, CString, VaList)
gtk_text_buffer_set_text: extern func(TextBuffer, CString, Int)
gtk_text_buffer_create_mark: extern func(TextBuffer, CString, TextIter, Bool) -> TextMark
gtk_text_buffer_move_mark_by_name: extern func(TextBuffer, CString, TextIter)
gtk_text_buffer_delete_mark_by_name: extern func(TextBuffer, CString)
gtk_text_buffer_get_mark: extern func(TextBuffer, CString) -> TextMark
gtk_text_buffer_apply_tag_by_name: extern func(TextBuffer, CString, TextIter, TextIter)
gtk_text_buffer_remove_tag_by_name: extern func(TextBuffer, CString, TextIter, TextIter)

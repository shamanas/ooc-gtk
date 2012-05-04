use gtk
import gtk/[TextBuffer, Gtk, TextView, TextTag, _GObject]

TextMark: cover from GtkTextMark*  extends _GObject {
    new: static func(name: String, leftGravity: Bool) -> This {
        gtk_text_mark_new(name, leftGravity)
    }

    setVisible?: extern(gtk_text_mark_set_visible) func(setting: Bool)
    getVisible?: extern(gtk_text_mark_get_visible) func -> Bool

    visible?: Bool {
        get {
            getVisible?()
        }
        set(setting: Bool) {
            setVisible?(setting)
        }
    }

    deleted?: extern(gtk_text_mark_get_deleted) func -> Bool
    getName: extern(gtk_text_mark_get_name) func -> CString
    getBuffer: extern(gtk_text_mark_get_buffer) func -> TextBuffer
    getLeftGravity: extern(gtk_text_mark_get_left_gravity) func -> Bool
}

TextSearchFlags: extern(GtkTextSearchFlags) enum {
    visibleOnly: extern(GTK_TEXT_SEARCH_VISIBLE_ONLY),
    textOnly: extern(GTK_TEXT_SEARCH_ONY)
}

TextIter: cover from GtkTextIter* {
    getBuffer: extern(gtk_text_iter_get_buffer) func -> TextBuffer
    copy: extern(gtk_text_iter_copy) func -> This
    free: extern(gtk_text_iter_free) func

    /**
     * Returns the character offset of an iterator. Each character in a GtkTextBuffer has an offset, starting with 0 for the first character in the buffer.
     */
    getOffset: extern(gtk_text_iter_get_offset) func -> Int

    /**
     * Returns the line number containing the iterator. Lines in a TextBuffer are numbered beginning with 0 for the first line in the buffer. 
     */
    getLine: extern(gtk_text_iter_get_line) func -> Int   

    /**
     * Returns the character offset of the iterator, counting from the start of a newline-terminated line. The first character on the line has offset 0.
     */
    getLineOffset: extern(gtk_text_iter_get_line_offset) func -> Int

    /**
     * Returns the byte index of the iterator, counting from the start of a newline-terminated line. Remember that TextBuffer encodes text in UTF-8, and that characters can require a variable number of bytes to represent.
     */
    getLineIndex: extern(gtk_text_iter_get_line_index) func -> Int

    /**
     * Returns the number of bytes from the start of the line to the iter, not counting bytes that are invisible due to tags with the "invisible" flag toggled on.
     */
    getVisibleLineIndex: extern(gtk_text_iter_get_visible_line_index) func -> Int

    /**
     * Returns the offset in characters from the start of the line to the iter, not counting characters that are invisible due to tags with the "invisible" flag toggled on.
     */
    getVisibleLineOffset: extern(gtk_text_iter_get_visible_line_offset) func -> Int

    /**
     * Returns the Unicode character at this iterator. (Equivalent to operator* on a C++ iterator.) If the element at this iterator is a non-character element, such as an image embedded in the buffer, the Unicode "unknown" character 0xFFFC is returned. If invoked on the end iterator, zero is returned; zero is not a valid Unicode character.
     */
    getChar: extern(gtk_text_iter_get_char) func -> UInt32

    /**
     * Returns the text in the given range. A "slice" is an array of characters encoded in UTF-8 format, including the Unicode "unknown" character 0xFFFC for iterable non-character elements in the buffer, such as images. Because images are encoded in the slice, byte and character offsets in the returned array will correspond to byte offsets in the text buffer. Note that 0xFFFC can occur in normal text as well, so it is not a reliable indicator that a pixbuf or widget is in the buffer.
     */
    getSlice: func(end: TextIter) -> String {
        gtk_text_iter_get_slice(this,end) as CString toString()
    }

    /**
     * Returns text in the given range. If the range contains non-text elements such as images, the character and byte offsets in the returned string will not correspond to character and byte offsets in the buffer.
     */
    getText: func(end: TextIter) -> String {
        gtk_text_iter_get_slice(this,end) as CString toString()
    }

    /**
     * Like TextIter getSlice, but invisible text is not included. Invisible text is usually invisible because a TextTag with the "invisible" attribute turned on has been applied to it.
     */
    getVisibleSlice: func(end: TextIter) -> String {
        gtk_text_iter_get_visible_slice(this,end) as CString toString()
    }

    /**
     * You really want doc for this one? -.-
     */
    getVisibleText: func(end: TextIter) -> String {
        gtk_text_iter_get_visible_text(this,end) as CString toString()
    }

    /**
     * If the element at iter is a pixbuf, the pixbuf is returned (with no new reference count added). Otherwise, null is returned.
     */
    //getPixbuf: extern(gtk_text_iter_get_pixbuf) func -> GdkPixbuf

    /**
     * Returns a list of all TextMark at this location. Because marks are not iterable (they don't take up any "space" in the buffer, they are just marks in between iterable locations), multiple marks can exist in the same place. The returned list is not in any meaningful order.
     */
    //getMarks: extern(gtk_text_iter_get_marks) func -> GSList

    /**
     * Returns a list of TextTag that are toggled on or off at this point. (If toggled_on is true, the list contains tags that are toggled on.) If a tag is toggled on at iter, then some non-empty range of characters following iter has that tag applied to it. If a tag is toggled off, then some non-empty range following iter does not have the tag applied to it.
     */
    //getToggledTags: extern(gtk_text_iter_get_toggled_tags) func(toggled_on: Bool) -> GSList

    /**
     * If the location at iter contains a child anchor, the anchor is returned (with no new reference count added). Otherwise, null is returned.
     */
    getChildAnchor: extern(gtk_iter_get_child_anchor) func -> TextChildAnchor

    /**
     * Returns true if tag is toggled on at exactly this point. If tag is null, returns true if any tag is toggled on at this point. Note that the TextIter beginsTag? returns true if iter is the start of the tagged range; TextIter hasTag? tells you whether an iterator is within a tagged range.
     */
    beginsTag?: extern(gtk_iter_begins_tag) func(tag: TextTag) -> Bool

    /**
     * I don't think I need to explain that to you...
     */
    endsTag?: extern(gtk_iter_ends_tag) func(tag: TextTag) -> Bool

    /**
     * This is equivalent to (TextIter beginsTag? || TextIter endsTag?), i.e. it tells you whether a range with tag applied to it begins or ends at iter.
     */
    togglesTag?: extern(gtk_text_iter_toggles_tag) func(tag: TextTag) -> Bool

    /**
     * See description for TextIter beginsTag?
     */
    hasTag?: extern(gtk_text_iter_has_tag) func(tag: TextTag) -> Bool

    /**
     * Returns a list of tags that apply to iter, in ascending order of priority (highest-priority tags are last). The TextTag in the list don't have a reference added, but you have to free the list itself.
     */
    //getTags: extern(gtk_text_iter_get_tags) func -> GSList

    /**
     * Returns whether the character at iter is within an editable region of text. Non-editable text is "locked" and can't be changed by the user via TextView. This function is simply a convenience wrapper around TextIter getAttributes. If no tags applied to this text affect editability, default_setting will be returned. You don't want to use this function to decide whether text can be inserted at iter, because for insertion you don't want to know whether the char at iter is inside an editable range, you want to know whether a new character inserted at iter would be inside an editable range. Use TextIter canInsert? to handle this case.
     */
    editable?: extern(gtk_text_iter_editable) func(default_setting: Bool) -> Bool

    /**
     * See description for TextIter editable?
     */
    canInsert?: extern(gtk_text_iter_can_insert) func(default_editability: Bool) -> Bool

    /**
     * Determines whether iter begins a natural-language word. Word breaks are determined by Pango and should be correct for nearly any language (if not, the correct fix would be to the Pango word break algorithms).
     */
    startsWord?: extern(gtk_text_iter_starts_word) func -> Bool

    /**
     * Same as TextIter startsWord? but determines whether it ends a natural-language word.
     */
    endsWord?: extern(gtk_text_iter_ends_word) func -> Bool

    /**
     * Same as TextIter endsWord? but determines wether it is inside a natural-language word.
     */
    insideWord?: extern(gtk_text_iter_inside_word) func -> Bool

    /**
     * Returns true if iter begins a paragraph, i.e. if TextIter getLineOffset would return 0. However this function is potentially more efficient than TextIter getLineOffset because it doesn't have to compute the offset, it just has to see whether it's 0.
     */
    startsLine?: extern(gtk_text_iter_starts_line) func -> Bool

    /**
     * Same as TextIter startsLine? but for ending a line.
     */
    endsLine?: extern(gtk_text_iter_ends_line) func -> Bool

    /**
     * Determines whether iter begins a sentence. Sentence boundaries are determined by Pango and should be correct for nearly any language (if not, the correct fix would be to the Pango text boundary algorithms).
     */
    startsSentence?: extern(gtk_text_iter_starts_sentence) func -> Bool

    /**
     * Same as TextIter startsSentence? but for ending sentences.
     */
    endsSentence?: extern(gtk_text_iter_ends_sentence) func -> Bool

    /**
     * Determines whether iter is inside a sentence (as opposed to in between two sentences, e.g. after a period and before the first letter of the next sentence). Sentence boundaries are determined by Pango and should be correct for nearly any language (if not, the correct fix would be to the Pango text boundary algorithms).
     */
    insideSentence?: extern(gtk_text_iter_inside_sentence) func -> Bool

    /**
     * See TextIter forwardCursorPosition for details on what a cursor position is.
     */
    cursorPosition?: extern(gtk_text_iter_is_cursor_position) func -> Bool

    /**
     * Returns the number of characters in the line containing iter, including the paragraph delimiters.
     */
    getCharsInLine: extern(gtk_text_iter_get_chars_in_line) func -> Int    

    /**
     * Returns the number of bytes in the line containing iter, including the paragraph delimiters.
     */
    getBytesInLine: extern(gtk_text_iter_get_bytes_in_line) func -> Int

    /**
     * Computes the effect of any tags applied to this spot in the text. The values parameter should be initialized to the default settings you wish to use if no tags are in effect. You'd typically obtain the defaults from TextView getDefaultAttributes. TextIter getAttributes will modify values, applying the effects of any tags present at iter. If any tags affected values, the function returns true.
     */
    getAttributes: extern(gtk_text_iter_get_attributes) func~pointer(values: TextAttributes*) -> Bool
    getAttributes: func~returnsTuple -> (TextAttributes, Bool) {
        attr: TextAttributes
        ret := getAttributes~pointer(attr&)
        (attr, ret)
    }

    /**
     * A convenience wrapper around TextIter getAttributes, which returns the language in effect at iter. If no tags affecting language apply to iter, the return value is identical to that of Gtk getDefaultLanguage.
     */
    //getLanguage: extern(gtk_text_iter_get_language) func -> PangoLanguage

    /**
     * Returns true if iter is the end iterator, i.e. one past the last dereferenceable iterator in the buffer. TextIter end? is the most efficient way to check whether an iterator is the end iterator.
     */
    end?: extern(gtk_text_iter_is_end) func -> Bool

    /**
     * Returns true if iter is the first iterator in the buffer, that is if iter has a character offset of 0.
     */
    start?: extern(gtk_text_is_start) func -> Bool

    /**
     * Moves iter forward by one character offset. Note that images embedded in the buffer occupy 1 character slot, so TextIter forwardChar may actually move onto an image instead of a character, if you have images in your buffer. If iter is the end iterator or one character before it, iter will now point at the end iterator, and TextIter forwardChar returns false for convenience when writing loops.
     */
    forwardChar: extern(gtk_text_iter_forward_char) func -> Bool

    /**
     * Moves backward by one character offset. Returns true if movement was possible; if iter was the first in the buffer (character offset 0), TextIter backwardChar returns false for convenience when writing loops.
     */
    backwardChar: extern(gtk_text_iter_backward_char) func -> Bool

    /**
     * Moves count characters if possible (if count would move past the start or end of the buffer, moves to the start or end of the buffer). The return value indicates whether the new position of iter is different from its original position, and dereferenceable (the last iterator in the buffer is not dereferenceable). If count is 0, the function does nothing and returns false.
     */
    forwardChars: extern(gtk_text_iter_forward_chars) func(count: Int) -> Bool

    /**
     * Moves count characters backward, if possible (if count would move past the start or end of the buffer, moves to the start or end of the buffer). The return value indicates whether the iterator moved onto a dereferenceable position; if the iterator didn't move, or moved onto the end iterator, then false is returned. If count is 0, the function does nothing and returns false.
     */
    backwardChars: extern(gtk_text_iter_backward_chars) func(count: Int) -> Bool

    //TODO: Add doc from here and on
    forwardLine: extern(gtk_text_iter_forward_line) func -> Bool
    backwardLine: extern(gtk_text_iter_backward_line) func -> Bool
    forwardLines: extern(gtk_text_iter_forward_lines) func(count: Int) -> Bool
    backwardLines: extern(gtk_text_iter_backward_lines) func(count: Int) -> Bool
    forwardWordEnds: extern(gtk_text_iter_forward_word_ends) func(count: Int) -> Bool
    backwardWordStarts: extern(gtk_text_iter_backward_word_starts) func(count: Int) -> Bool
    forwardWordEnd: extern(gtk_text_iter_forward_word_end) func -> Bool
    backwardWordStart: extern(gtk_text_iter_backward_word_start) func -> Bool
    forwardCursorPosition: extern(gtk_text_iter_forward_cursor_position) func -> Bool
    backwardCursorPosition: extern(gtk_text_iter_backward_cursor_position) func -> Bool
    forwardCursorPositions: extern(gtk_text_iter_forward_cursor_positions) func(count: Int) -> Bool
    backwardCursorPositions: extern(gtk_text_iter_backward_cursor_positions) func(count: Int) -> Bool
    backwardSentenceStart: extern(gtk_text_iter_backward_sentence_start) func -> Bool
    backwardSentenceStarts: extern(gtk_text_iter_backward_sentence_starts) func(count: Int) -> Bool
    forwardSentenceEnd: extern(gtk_text_iter_forward_sentence_end) func -> Bool
    forwardSentenceEnds: extern(gtk_text_iter_forward_sentence_ends) func(count: Int) -> Bool
    forwardVisibleWordEnds: extern(gtk_text_iter_forward_visible_word_ends) func(count: Int) -> Bool
    backwardVisibleWordStarts: extern(gtk_text_iter_backward_visible_word_starts) func(count: Int) -> Bool
    forwardVisibleWordEnd: extern(gtk_text_iter_forward_visible_word_end) func -> Bool
    backwardVisibleWordStart: extern(gtk_text_iter_backward_visible_word_start) func -> Bool
    forwardVisibleCursorPosition: extern(gtk_text_iter_forward_visible_cursor_position) func -> Bool
    backwardVisibleCursorPosition: extern(gtk_text_iter_backward_visible_cursor_position) func -> Bool
    forwardVisibleCursorPositions: extern(gtk_text_iter_forward_visible_cursor_positions) func(count: Int) -> Bool
    backwardVisibleCursorPositions: extern(gtk_text_iter_backward_visible_cursor_positions) func(count: Int) -> Bool
    forwardVisibleLine: extern(gtk_text_iter_forward_visible_line) func -> Bool
    backwardVisibleLine: extern(gtk_text_iter_backward_visible_line) func -> Bool
    forwardVisibleLines: extern(gtk_text_iter_forward_visible_lines) func(count: Int) -> Bool
    backwardVisibleLines: extern(gtk_text_iter_backward_visible_lines) func(count: Int) -> Bool
    setOffset: extern(gtk_text_iter_set_offset) func(char_offset: Int)
    setLine: extern(gtk_text_iter_set_line) func(line_number: Int)
    setLineOffset: extern(gtk_text_iter_set_line_offset) func(char_on_line: Int)
    setLineIndex: extern(gtk_text_iter_set_line_index) func(byte_on_line: Int)
    setVisibleLineIndex: extern(gtk_text_iter_set_visible_line_index) func(byte_on_line: Int)
    setVisibleLineOffset: extern(gtk_text_iter_set_visible_line_offset) func(char_on_line: Int)
    forwardToEnd: extern(gtk_text_iter_forward_to_end) func
    forwardToLineEnd: extern(gtk_text_iter_forward_to_line_end) func -> Bool
    forwardToTagToggle: extern(gtk_text_iter_forward_to_tag_toggle) func(tag: TextTag) -> Bool
    backwardToTagToggle: extern(gtk_text_iter_backward_to_tag_toggle) func(tag: TextTag) -> Bool

    // Raw function methods
    forwardFindChar: extern(gtk_text_iter_forward_find_char) func~raw(pred: Func(UInt32, Pointer) -> Bool, user_data: Pointer, limit: const This) -> Bool
    backwardFindChar: extern(gtk_text_iter_backward_find_char) func~raw(pred: Func(UInt32, Pointer) -> Bool, user_data: Pointer, limit: const This) -> Bool
    // In an ooc closure, the context is passed as a last argument, so we can pass the context to user_data
    forwardFindChar: func~closure(pred: Func(UInt32) -> Bool, limit: const This) -> Bool {
        thunk := pred as Closure thunk as Func(UInt32, Pointer) -> Bool
        context := pred as Closure context
        forwardFindChar~raw(thunk, context, limit)
    }
    backwardFindChar: func~closure(pred: Func(UInt32) -> Bool, limit: const This) -> Bool {
        thunk := pred as Closure thunk as Func(UInt32, Pointer) -> Bool
        context := pred as Closure context
        backwardFindChar~raw(thunk, context, limit)
    }

    forwardSearch: extern(gtk_text_iter_forward_search) func(str: const GChar*, flags: TextSearchFlags, match_start,match_end: This, limit: const This) -> Bool
    backwardSearch: extern(gtk_text_iter_backward_search) func(str: const GChar*, flags: TextSearchFlags, match_start,match_end: This, limit: const This) -> Bool

    equals?: extern(gtk_text_iter_equal) func(other: const This) -> Bool
    compare: extern(gtk_text_iter_compare) func(other: const This) -> Int
    inRange?: extern(gtk_text_iter_in_range) func(start,end: const This) -> Bool
    order: extern(gtk_text_iter_order) func(second: This)
}

operator == (l,r: TextIter) -> Bool { l equals?(r) }
operator <=> (l,r: TextIter) -> Int { l compare(r) }

gtk_text_mark_new: extern func(CString, Bool) -> TextMark
gtk_text_iter_get_slice: extern func(start,end: TextIter) -> GChar*
gtk_text_iter_get_text: extern func(start,end: TextIter) -> GChar*
gtk_text_iter_get_visible_slice: extern func(start,end: TextIter) -> GChar*
gtk_text_iter_get_visible_text: extern func(start,end: TextIter) -> GChar*

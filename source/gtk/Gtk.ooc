use gtk
import gtk/_GObject

/* Module-load code */
Gtk init(null, null)

/**
 * Singleton GTK cover for initialization etc.
 */
Gtk: cover {

	/**
	 * Initialize Gtk, usually called from main, with Gtk.init(&argc, &argv)
	 * @param argc a pointer to the number of arguments passed to the program
	 * @param argv a pointer to the array of arguments as strings passed to the program
	 */
	init: extern(gtk_init) static func(Int*, String**)
	
	/**
	 * Start the Gtk main loop
	 */
	main: extern(gtk_main) static func
	
	/**
	 * @return true if the event queue is not empty
	 */
	eventsPending: extern(gtk_events_pending) static func -> Bool
	
	/**
	 * Iterate the gtk main loop
	 */
	mainIteration: extern(gtk_main_iteration) static func
	
	/**
	 * Quit the Gtk main loop
	 */
	mainQuit: extern(gtk_main_quit) static func
	
	/**
	 * Add an object to the list of objects to be destroyed at the end
	 * of the application
	 * @param object
	 */
	quitAddDestroy: static func (object: _GObject) {
		gtk_quit_add_destroy(1, GTK_OBJECT(object))
	}
	
	
	addTimeout: static func (interval: UInt, f: Func -> Bool) {
            c := f as Closure
            g_timeout_add(interval as GUInt, c thunk, c context)
        }

}

g_timeout_add: extern func (interval: GUInt, function: Pointer, data: Pointer)

gtk_quit_add_destroy: extern func (Int, _GObject)

gtk_get_current_event_time: extern func -> UInt

Justification: extern(GtkJustification) enum {
    left: extern(GTK_JUSTIFY_LEFT),
    right: extern(GTK_JUSTIFY_RIGHT),
    center: extern(GTK_JUSTIFY_CENTER),
    fill: extern(GTK_JUSTIFY_FILL)
}

Quark: cover from GQuark {
    fromString: static extern(g_quark_from_string) func(CString) -> This
    fromStaticString: static extern(g_quark_from_static_string) func(CString) -> This

    toString: extern(g_quark_to_string) func -> CString
    tryString: static extern(g_quark_try_string) func(CString) -> This
}

GError: cover from GError {
    domain: extern Quark
    code: extern Int
    message: extern CString

    new: static extern(g_error_new) func(domain: Quark, code: Int, fromat: CString, ...) -> This*
    new: static extern(g_error_new_literal) func~literal(domain: Quark, code: Int, message: CString) -> This*
    new: static extern(g_error_new_valist) func~vaList(domain: Quark, code: Int, format: CString, args: VaList) -> This*

    free: extern(g_error_free) func@
    copy: extern(g_error_copy) func@ -> This
    matches?: extern(g_error_matches) func@(domain: Quark, code: Int) -> Bool

    set: static extern(g_set_error) func(err: This**, domain: Quark, code: Int, format: CString, ...)
    set: static extern(g_set_error_literal) func~literal(err: This**, domain: Quark, code: Int, message: CString)
    propagate: static extern(g_propagate_error) func(dest: This**, src: This)
    clear: static extern(g_clear_error) func(err: This**)
    prefix: static extern(g_prefix_error) func(err: This**, format: CString, ...)
    propagatePrefixed: static extern(g_propagate_prefixed_error) func(dest: This**, src: This*, format: CString, ...)
}

GBool: cover from gboolean extends Bool
GInt: cover from gint extends SSizeT
GUInt: cover from guint extends SizeT
GLong: cover from glong extends Long
GULong: cover from gulong extends ULong
GPointer: cover from gpointer extends Pointer
GChar: cover from gchar extends Char
GString: cover from gchar* extends String
GUniChar: cover from gunichar extends UInt32

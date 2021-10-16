const std = @import("std");

const c = @import("c.zig").c;
const Window = @import("Window.zig");
const Error = @import("errors.zig").Error;
const getError = @import("errors.zig").getError;

/// Makes the context of the specified window current for the calling thread.
///
/// This function makes the OpenGL or OpenGL ES context of the specified window current on the
/// calling thread. A context must only be made current on a single thread at a time and each
/// thread can have only a single current context at a time.
///
/// When moving a context between threads, you must make it non-current on the old thread before
/// making it current on the new one.
///
/// By default, making a context non-current implicitly forces a pipeline flush. On machines that
/// support `GL_KHR_context_flush_control`, you can control whether a context performs this flush
/// by setting the glfw.context_release_behavior hint.
///
/// The specified window must have an OpenGL or OpenGL ES context. Specifying a window without a
/// context will generate Error.NoWindowContext.
///
/// @param[in] window The window whose context to make current, or null to
/// detach the current context.
///
/// Possible errors include glfw.Error.NotInitialized, glfw.Error.NoWindowContext and glfw.Error.PlatformError.
///
/// @thread_safety This function may be called from any thread.
///
/// see also: context_current, glfwGetCurrentContext
pub inline fn makeContextCurrent(window: ?Window) Error!void {
    if (window) |w| c.glfwMakeContextCurrent(w.handle) else c.glfwMakeContextCurrent(null);
}

// TODO(opengl):

// /// Client API function pointer type.
// ///
// /// Generic function pointer used for returning client API function pointers
// /// without forcing a cast from a regular pointer.
// ///
// /// see also: context_glext, glfwGetProcAddress
// ///
// ///
// /// @ingroup context
// typedef void (*GLFWglproc)(void);

// /// Returns the window whose context is current on the calling thread.
// ///
// /// This function returns the window whose OpenGL or OpenGL ES context is
// /// current on the calling thread.
// ///
// /// @return The window whose context is current, or null if no window's
// /// context is current.
// ///
// /// Possible errors include glfw.Error.NotInitialized.
// ///
// /// @thread_safety This function may be called from any thread.
// ///
// /// see also: context_current, glfwMakeContextCurrent
// ///
// ///
// /// @ingroup context
// GLFWAPI GLFWwindow* glfwGetCurrentContext(void);

// /// Sets the swap interval for the current context.
// ///
// /// This function sets the swap interval for the current OpenGL or OpenGL ES
// /// context, i.e. the number of screen updates to wait from the time @ref
// /// glfwSwapBuffers was called before swapping the buffers and returning. This
// /// is sometimes called _vertical synchronization_, _vertical retrace
// /// synchronization_ or just _vsync_.
// ///
// /// A context that supports either of the `WGL_EXT_swap_control_tear` and
// /// `GLX_EXT_swap_control_tear` extensions also accepts _negative_ swap
// /// intervals, which allows the driver to swap immediately even if a frame
// /// arrives a little bit late. You can check for these extensions with @ref
// /// glfwExtensionSupported.
// ///
// /// A context must be current on the calling thread. Calling this function
// /// without a current context will cause a @ref GLFW_NO_CURRENT_CONTEXT error.
// ///
// /// This function does not apply to Vulkan. If you are rendering with Vulkan,
// /// see the present mode of your swapchain instead.
// ///
// /// @param[in] interval The minimum number of screen updates to wait for
// /// until the buffers are swapped by @ref glfwSwapBuffers.
// ///
// /// Possible errors include glfw.Error.NotInitialized, glfw.Error.NoCurrentContext and glfw.Error.PlatformError.
// ///
// /// This function is not called during context creation, leaving the
// /// swap interval set to whatever is the default on that platform. This is done
// /// because some swap interval extensions used by GLFW do not allow the swap
// /// interval to be reset to zero once it has been set to a non-zero value.
// ///
// /// Some GPU drivers do not honor the requested swap interval, either
// /// because of a user setting that overrides the application's request or due to
// /// bugs in the driver.
// ///
// /// @thread_safety This function may be called from any thread.
// ///
// /// see also: buffer_swap, glfwSwapBuffers
// ///
// ///
// /// @ingroup context
// GLFWAPI void glfwSwapInterval(int interval);

// /// Returns whether the specified extension is available.
// ///
// /// This function returns whether the specified
// /// [API extension](@ref context_glext) is supported by the current OpenGL or
// /// OpenGL ES context. It searches both for client API extension and context
// /// creation API extensions.
// ///
// /// A context must be current on the calling thread. Calling this function
// /// without a current context will cause a @ref GLFW_NO_CURRENT_CONTEXT error.
// ///
// /// As this functions retrieves and searches one or more extension strings each
// /// call, it is recommended that you cache its results if it is going to be used
// /// frequently. The extension strings will not change during the lifetime of
// /// a context, so there is no danger in doing this.
// ///
// /// This function does not apply to Vulkan. If you are using Vulkan, see @ref
// /// glfw.getRequiredInstanceExtensions, `vkEnumerateInstanceExtensionProperties`
// /// and `vkEnumerateDeviceExtensionProperties` instead.
// ///
// /// @param[in] extension The ASCII encoded name of the extension.
// /// @return `GLFW_TRUE` if the extension is available, or `GLFW_FALSE`
// /// otherwise.
// ///
// /// Possible errors include glfw.Error.NotInitialized, glfw.Error.NoCurrentContext, glfw.Error.InvalidValue and glfw.Error.PlatformError.
// ///
// /// @thread_safety This function may be called from any thread.
// ///
// /// see also: context_glext, glfwGetProcAddress
// ///
// ///
// /// @ingroup context
// GLFWAPI int glfwExtensionSupported(const char* extension);

// /// Returns the address of the specified function for the current
// /// context.
// ///
// /// This function returns the address of the specified OpenGL or OpenGL ES
// /// [core or extension function](@ref context_glext), if it is supported
// /// by the current context.
// ///
// /// A context must be current on the calling thread. Calling this function
// /// without a current context will cause a @ref GLFW_NO_CURRENT_CONTEXT error.
// ///
// /// This function does not apply to Vulkan. If you are rendering with Vulkan,
// /// see @ref glfwGetInstanceProcAddress, `vkGetInstanceProcAddr` and
// /// `vkGetDeviceProcAddr` instead.
// ///
// /// @param[in] procname The ASCII encoded name of the function.
// /// @return The address of the function, or null if an
// /// error occurred.
// ///
// /// Possible errors include glfw.Error.NotInitialized, glfw.Error.NoCurrentContext and glfw.Error.PlatformError.
// ///
// /// The address of a given function is not guaranteed to be the same
// /// between contexts.
// ///
// /// This function may return a non-null address despite the
// /// associated version or extension not being available. Always check the
// /// context version or extension string first.
// ///
// /// @pointer_lifetime The returned function pointer is valid until the context
// /// is destroyed or the library is terminated.
// ///
// /// @thread_safety This function may be called from any thread.
// ///
// /// see also: context_glext, glfwExtensionSupported
// ///
// ///
// /// @ingroup context
// GLFWAPI GLFWglproc glfwGetProcAddress(const char* procname);

test "makeContextCurrent" {
    const glfw = @import("main.zig");
    try glfw.init();
    defer glfw.terminate();

    const window = glfw.Window.create(640, 480, "Hello, Zig!", null, null) catch |err| {
        // return without fail, because most of our CI environments are headless / we cannot open
        // windows on them.
        std.debug.print("note: failed to create window: {}\n", .{err});
        return;
    };
    defer window.destroy();

    glfw.makeContextCurrent(window) catch |err| std.debug.print("making context current, error={}\n", .{err});
}
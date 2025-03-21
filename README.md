# stb_image
This is [stb_image from stb](https://github.com/nothings/stb), packaged for [Zig](https://ziglang.org/). (Intended for C or C++ projects using Zig as a build tool.)

## Usage
First, update your `build.zig.zon`:
```sh
zig fetch --save git+https://github.com/jessechounard/stb_image
```

Next, in your `build.zig`, you can access the library as a dependency:
```zig
const stb_image_dep = b.dependency("stb_image", .{
    .target = target,
    .optimize = optimize,
});
const stb_image_lib = stb_image_dep.artifact("stb_image");

exe.root_module.linkLibrary(stb_image_lib);
```

Finally, in your C++ file, you can use the library:
```cpp
#include <stdio.h>
#include <stdint.h>
#include <stb_image.h>

int main() {
    int width, height, channels;
    uint8_t *data = stbi_load("image.png", &width, &height, &channels, 0);
    if (!data) {
        printf("Loading image failed!\n");
    } else {
        printf("image info:\n"
               "    file:     %s\n"
               "    width:    %d\n"
               "    height:   %d\n"
               "    channels: %d\n",
            "image.png",
            width,
            height,
            channels);
        stbi_image_free(data);
    }
    return 0;
}
```

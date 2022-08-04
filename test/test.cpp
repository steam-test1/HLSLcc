#include "hlslcc.h"

#include <fstream>
#include <string>
#include <iostream>

int main()
{
    unsigned int flags = HLSLCC_FLAG_UNIFORM_BUFFER_OBJECT;

    GlExtensions ext;
    ext.ARB_explicit_attrib_location = 1;
    ext.ARB_explicit_uniform_location = 1;
    ext.ARB_shading_language_420pack = 0;
    ext.OVR_multiview = 0;
    ext.EXT_shader_framebuffer_fetch = 0;

    HLSLccSamplerPrecisionInfo info;
    HLSLccReflection reflection;
    GLSLShader shader;

    // NOTE: Since we are using LANG_HLSL, a newly added variant, the output might look a bit strange.
    //   HLSLcc uses the language enum to determine which feature set is supported by the target (various versions of glsl)
    //   Since we use none of those, we hit the default case in a bunch of switch statements, and get some sort of ugly output.
    //   It basically thinks we are using ancient glsl.
    // NOTE: Just extracting DXBC isn't enough. We need to fix up RDEF sections of the binary. I re-purposed uTinyRipper for this.
    //   You can use the script found here: https://github.com/pema99/jank-extract-assetbundle-for-hlslcc/blob/main/FixShader/Program.cs
    int ok = TranslateHLSLFromFile("test/a.dxbc", 0, LANG_HLSL, &ext, nullptr, info, reflection, &shader);

    if (ok)
    {
        std::ofstream out("test/out1.hlsl");
        out << shader.sourceCode;
        out.close();
    }
    else
    {
        printf("HLSLcc failed with error code %i\n", ok);
    }

    return 0;
}

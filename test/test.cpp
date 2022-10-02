#include "hlslcc.h"

#include <fstream>
#include <string>
#include <iostream>

int main(int argc, const char* argv[])
{
    if (argc <= 1)
        return 1;

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

    // NOTE: Just extracting DXBC isn't enough. We need to fix up RDEF sections of the binary. I re-purposed uTinyRipper for this.
    //   You can use the script found here: https://github.com/pema99/jank-extract-assetbundle-for-hlslcc/blob/main/FixShader/Program.cs
    int ok = TranslateHLSLFromFile(argv[1], 0, LANG_HLSL, &ext, nullptr, info, reflection, &shader);

    if (ok)
    {
        std::cout << shader.sourceCode;
    }
    else
    {
        printf("HLSLcc failed with error code %i\n", ok);
    }

    return 0;
}

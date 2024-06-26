#ifndef TO_GLSL_OPERAND_H
#define TO_GLSL_OPERAND_H

#include <stdint.h>
#include "bstrlib.h"
#include "ShaderInfo.h"

class HLSLCrossCompilerContext;

//void TranslateOperand(HLSLCrossCompilerContext* psContext, const Operand* psOperand, uint32_t ui32TOFlag);
// Translate operand but add additional component mask
//void TranslateOperandWithMask(HLSLCrossCompilerContext* psContext, const Operand* psOperand, uint32_t ui32TOFlag, uint32_t ui32ComponentMask);

// TODO(pema): Refactor these into a namespace instead of global free functions

void TranslateOperandSwizzleHLSL(HLSLCrossCompilerContext* psContext, const Operand* psOperand, int iRebase);
void TranslateOperandSwizzleWithMaskHLSL(bstring glsl, HLSLCrossCompilerContext* psContext, const Operand* psOperand, uint32_t ui32ComponentMask, int iRebase);
void TranslateOperandSwizzleWithMaskHLSL(HLSLCrossCompilerContext* psContext, const Operand* psOperand, uint32_t ui32ComponentMask, int iRebase);

void ResourceNameHLSL(bstring targetStr, HLSLCrossCompilerContext* psContext, ResourceGroup group, const uint32_t ui32RegisterNumber);
std::string ResourceNameHLSL(HLSLCrossCompilerContext* psContext, ResourceGroup group, const uint32_t ui32RegisterNumber);

std::string TextureSamplerNameHLSL(ShaderInfo* psShaderInfo, const uint32_t ui32TextureRegisterNumber, const uint32_t ui32SamplerRegisterNumber);
void ConcatTextureSamplerNameHLSL(bstring str, ShaderInfo* psShaderInfo, const uint32_t ui32TextureRegisterNumber, const uint32_t ui32SamplerRegisterNumber);

std::string UniformBufferInstanceNameHLSL(HLSLCrossCompilerContext* psContext, const std::string& name);

#endif

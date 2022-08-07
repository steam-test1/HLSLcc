
uniform float4 _MainTex_ST;
struct VertexIn
{
    float4 in_POSITION0 : POSITION0;
    float3 in_NORMAL0 : NORMAL0;
    float2 in_TEXCOORD0 : TEXCOORD0;
}

struct VertexOut
{
    float4 gl_Position : SV_POSITION0;
    float2 vs_TEXCOORD1 : TEXCOORD1;
}

#define VERTEX_INPUT VertexIn
#define STAGE_VERTEX 1
#pragma vertex vert
VertexOut vert(VERTEX_INPUT vertexIn)
{
    VertexOut vertexOut = (VertexOut)0;
    //--- Start Early Main ---
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float u_xlat6;
    float u_xlat9;
    int u_xlati9;
    bool u_xlatb9;
    //--- End Early Main ---
    //DP3
    u_xlat0.x = dot(vertexIn.in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
    //DP3
    u_xlat0.y = dot(vertexIn.in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
    //DP3
    u_xlat0.z = dot(vertexIn.in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
    //DP3
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    //RSQ
    u_xlat9 = rsqrt(u_xlat9);
    //MUL
    u_xlat0.xyz = float3(u_xlat9) * u_xlat0.xyz;
    //MUL
    u_xlat1 = vertexIn.in_POSITION0.yyyy * unity_ObjectToWorld[1];
    //MAD
    u_xlat1 = unity_ObjectToWorld[0] * vertexIn.in_POSITION0.xxxx + u_xlat1;
    //MAD
    u_xlat1 = unity_ObjectToWorld[2] * vertexIn.in_POSITION0.zzzz + u_xlat1;
    //MAD
    u_xlat1 = unity_ObjectToWorld[3] * vertexIn.in_POSITION0.wwww + u_xlat1;
    //MAD
    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    //DP3
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    //RSQ
    u_xlat9 = rsqrt(u_xlat9);
    //MUL
    u_xlat2.xyz = float3(u_xlat9) * u_xlat2.xyz;
    //DP3
    u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
    //MAD
    u_xlat9 = (-u_xlat9) * u_xlat9 + 1.0;
    //SQRT
    u_xlat9 = sqrt(u_xlat9);
    //MUL
    u_xlat9 = u_xlat9 * unity_LightShadowBias.z;
    //MAD
    u_xlat0.xyz = (-u_xlat0.xyz) * float3(u_xlat9) + u_xlat1.xyz;
    //NE
    u_xlatb9 = unity_LightShadowBias.z!=0.0;
    //MOVC
    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat1.xyz;
    //ISHL
    u_xlati9 = unity_StereoEyeIndex << 2;
    //MUL
    u_xlat2 = u_xlat0.yyyy * unity_StereoMatrixVP[(u_xlati9 + 1) / 4][(u_xlati9 + 1) % 4];
    //MAD
    u_xlat2 = unity_StereoMatrixVP[u_xlati9 / 4][u_xlati9 % 4] * u_xlat0.xxxx + u_xlat2;
    //MAD
    u_xlat2 = unity_StereoMatrixVP[(u_xlati9 + 2) / 4][(u_xlati9 + 2) % 4] * u_xlat0.zzzz + u_xlat2;
    //MAD
    u_xlat0 = unity_StereoMatrixVP[(u_xlati9 + 3) / 4][(u_xlati9 + 3) % 4] * u_xlat1.wwww + u_xlat2;
    //DIV
    u_xlat1.x = unity_LightShadowBias.x / u_xlat0.w;
    //MIN
    u_xlat1.x = min(u_xlat1.x, 0.0);
    //MAX
    u_xlat1.x = max(u_xlat1.x, -1.0);
    //ADD
    u_xlat6 = u_xlat0.z + u_xlat1.x;
    //MIN
    u_xlat1.x = min(u_xlat0.w, u_xlat6);
    //MOV
    vertexOut.gl_Position.xyw = u_xlat0.xyw;
    //ADD
    u_xlat0.x = (-u_xlat6) + u_xlat1.x;
    //MAD
    vertexOut.gl_Position.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat6;
    //MAD
    vertexOut.vs_TEXCOORD1.xy = vertexIn.in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    //RET
    return vertexOut;
}

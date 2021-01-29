﻿Shader "Unlit/004"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Color("Color",Color)=(1,1,1,1)
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            //只有在CGPROGRAM内再次定义一个与属性块内名字与类型相同的变量，属性块对应的变量才能起作用
            fixed4 _Color;
            //appdata_base
            struct a2v//a application dao vert
            {
                //用模型顶点填充v变量
                float4 vertex:POSITION;
                //用模型的法线填充n变量
                float3 normal:NORMAL;//法线
                //用模型的第一套uv填充texcoord
                float4 texcood:TEXCOORD0;//UV
            };

            struct v2f//v vert dao frag
            {
                //SV_POSITION语义告诉unity： pos 为裁剪空间中的位置信息
                float4 pos:SV_POSITION;
                //COLOR0 语义可以储存颜色信息
                fixed3 color:COLOR0;
            };
            //POSITION SV_POSITION 语义
            v2f vert(appdata_full v)
            {
                v2f o;
                o.pos=UnityObjectToClipPos(v.vertex);
                //法线
                //将【-1，1】转变为【0，1】 x/2+0.5
                o.color=v.normal*0.5+fixed3(0.5,0.5,0.5);
                //切线
                o.color=v.tangent.xyz*0.5+fixed3(0.5,0.5,0.5);
                //UV
                o.color=fixed4(v.texcoord.xy,0,1);
                //顶点颜色
                o.color=v.color;
                return o;
            }
            fixed4 frag(v2f i):SV_TARGET
            {                                
                return fixed4(i.color,1); 
            }
            ENDCG
        }
    }
}

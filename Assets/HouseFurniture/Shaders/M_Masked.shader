// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "M_Masked"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		Material_Texture2D_1("Albedo", 2D) = "white" {}
		Material_Texture2D_3("Mask", 2D) = "white" {}
		Material_Texture2D_0("Normal", 2D) = "bump" {}
		Material_TextureD_2("Roughness", 2D) = "white" {}
		_Brightness("Brightness", Range( 0 , 5)) = 1
		_Roughness("Roughness", Range( 0 , 5)) = 1
		_Invert("Invert", Float) = 0
		[Toggle(_USEALBEDOALPHA_ON)] _UseAlbedoAlpha("UseAlbedoAlpha", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "Geometry+0" }
		Cull Off
		CGPROGRAM
		#pragma target 3.0
		#pragma shader_feature_local _USEALBEDOALPHA_ON
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D Material_Texture2D_0;
		uniform float4 Material_Texture2D_0_ST;
		uniform float _Invert;
		uniform sampler2D Material_Texture2D_1;
		uniform float4 Material_Texture2D_1_ST;
		uniform float _Brightness;
		uniform sampler2D Material_TextureD_2;
		uniform float4 Material_TextureD_2_ST;
		uniform float _Roughness;
		uniform sampler2D Material_Texture2D_3;
		uniform float4 Material_Texture2D_3_ST;
		uniform float _Cutoff = 0.5;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uvMaterial_Texture2D_0 = i.uv_texcoord * Material_Texture2D_0_ST.xy + Material_Texture2D_0_ST.zw;
			float3 break10 = UnpackNormal( tex2D( Material_Texture2D_0, uvMaterial_Texture2D_0 ) );
			float4 appendResult13 = (float4(break10.x , ( break10.y * _Invert ) , break10.z , 0.0));
			o.Normal = appendResult13.xyz;
			float2 uvMaterial_Texture2D_1 = i.uv_texcoord * Material_Texture2D_1_ST.xy + Material_Texture2D_1_ST.zw;
			float4 tex2DNode2 = tex2D( Material_Texture2D_1, uvMaterial_Texture2D_1 );
			o.Albedo = ( tex2DNode2 * _Brightness ).rgb;
			float2 uvMaterial_TextureD_2 = i.uv_texcoord * Material_TextureD_2_ST.xy + Material_TextureD_2_ST.zw;
			o.Smoothness = ( ( 1.0 - tex2D( Material_TextureD_2, uvMaterial_TextureD_2 ).r ) * _Roughness );
			o.Alpha = 1;
			float2 uvMaterial_Texture2D_3 = i.uv_texcoord * Material_Texture2D_3_ST.xy + Material_Texture2D_3_ST.zw;
			float4 temp_cast_2 = (tex2DNode2.a).xxxx;
			#ifdef _USEALBEDOALPHA_ON
				float4 staticSwitch14 = temp_cast_2;
			#else
				float4 staticSwitch14 = tex2D( Material_Texture2D_3, uvMaterial_Texture2D_3 );
			#endif
			clip( staticSwitch14.r - _Cutoff );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18930
2618;121;1820;797;1615.072;240.9109;1.374795;True;True
Node;AmplifyShaderEditor.SamplerNode;9;-1077.424,-30.60984;Inherit;True;Property;Material_Texture2D_0;Normal;3;0;Create;False;0;0;0;False;0;False;-1;abc00000000005546889098118452484;abc00000000005546889098118452484;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BreakToComponentsNode;10;-735.4246,35.81146;Inherit;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RangedFloatNode;11;-783.0624,-165.8431;Inherit;False;Property;_Invert;Invert;7;0;Create;True;0;0;0;False;0;False;0;-1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;8;-1222.854,593.8242;Inherit;True;Property;Material_TextureD_2;Roughness;4;0;Create;False;0;0;0;False;0;False;-1;abc00000000012000771315061351522;abc00000000012000771315061351522;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;3;-536.8902,-356.8895;Inherit;False;Property;_Brightness;Brightness;5;0;Create;True;0;0;0;False;0;False;1;1.57;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;12;-552.3325,-161.48;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;-1;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;5;-905.5154,611.374;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-883.8243,803.8151;Inherit;False;Property;_Roughness;Roughness;6;0;Create;True;0;0;0;False;0;False;1;1;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;2;-1626.082,-584.0287;Inherit;True;Property;Material_Texture2D_1;Albedo;1;0;Create;False;0;0;0;False;0;False;-1;abc00000000013474387870728954763;abc00000000013474387870728954763;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;4;-1476.732,289.3799;Inherit;True;Property;Material_Texture2D_3;Mask;2;0;Create;False;0;0;0;False;0;False;-1;abc00000000013474387870728954763;abc00000000013474387870728954763;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1;-120.19,-475.9895;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.DynamicAppendNode;13;-388.3253,16.31146;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;7;-554.9249,593.2153;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;14;-971.1859,290.8534;Inherit;False;Property;_UseAlbedoAlpha;UseAlbedoAlpha;8;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;153,-97;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;M_Masked;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;TransparentCutout;;Geometry;All;18;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;10;0;9;0
WireConnection;12;0;10;1
WireConnection;12;1;11;0
WireConnection;5;0;8;1
WireConnection;1;0;2;0
WireConnection;1;1;3;0
WireConnection;13;0;10;0
WireConnection;13;1;12;0
WireConnection;13;2;10;2
WireConnection;7;0;5;0
WireConnection;7;1;6;0
WireConnection;14;1;4;0
WireConnection;14;0;2;4
WireConnection;0;0;1;0
WireConnection;0;1;13;0
WireConnection;0;4;7;0
WireConnection;0;10;14;0
ASEEND*/
//CHKSM=8C5BE997239FDE33882DE68CB0E3A7E866BB9034
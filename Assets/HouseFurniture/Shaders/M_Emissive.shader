// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "M_Emissive"
{
	Properties
	{
		Material_Texture2D_0("Normal", 2D) = "bump" {}
		Material_Texture2D_1("Albedo", 2D) = "white" {}
		Material_TextureD_3("Emissive", 2D) = "white" {}
		_Brightness("Brightness", Range( 0 , 5)) = 1
		_Color1("Color 1", Color) = (1,0.4671207,0.03301889,0)
		_Color2("Color 2", Color) = (1,0.3148885,0,0)
		_Invert("Invert", Float) = 0
		_Power("Power", Range( 0 , 10)) = 1
		_Desaturation("Desaturation", Range( 0 , 1)) = 0
		[Toggle(_EMISSIVETEXTURE_ON)] _EmissiveTexture("EmissiveTexture", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Off
		CGPROGRAM
		#pragma target 3.0
		#pragma shader_feature_local _EMISSIVETEXTURE_ON
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
		uniform float4 _Color1;
		uniform float4 _Color2;
		uniform sampler2D Material_TextureD_3;
		uniform float4 Material_TextureD_3_ST;
		uniform float _Power;
		uniform float _Desaturation;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uvMaterial_Texture2D_0 = i.uv_texcoord * Material_Texture2D_0_ST.xy + Material_Texture2D_0_ST.zw;
			float3 break2 = UnpackNormal( tex2D( Material_Texture2D_0, uvMaterial_Texture2D_0 ) );
			float4 appendResult9 = (float4(break2.x , ( break2.y * _Invert ) , break2.z , 0.0));
			o.Normal = appendResult9.xyz;
			float2 uvMaterial_Texture2D_1 = i.uv_texcoord * Material_Texture2D_1_ST.xy + Material_Texture2D_1_ST.zw;
			o.Albedo = ( tex2D( Material_Texture2D_1, uvMaterial_Texture2D_1 ) * _Brightness ).rgb;
			float2 uvMaterial_TextureD_3 = i.uv_texcoord * Material_TextureD_3_ST.xy + Material_TextureD_3_ST.zw;
			float4 tex2DNode11 = tex2D( Material_TextureD_3, uvMaterial_TextureD_3 );
			float4 lerpResult14 = lerp( _Color1 , _Color2 , tex2DNode11.r);
			#ifdef _EMISSIVETEXTURE_ON
				float4 staticSwitch22 = tex2DNode11;
			#else
				float4 staticSwitch22 = lerpResult14;
			#endif
			float3 desaturateInitialColor8 = ( staticSwitch22 * _Power ).rgb;
			float desaturateDot8 = dot( desaturateInitialColor8, float3( 0.299, 0.587, 0.114 ));
			float3 desaturateVar8 = lerp( desaturateInitialColor8, desaturateDot8.xxx, _Desaturation );
			o.Emission = desaturateVar8;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18930
2653;137;1820;783;1095.232;-391.8943;1;True;True
Node;AmplifyShaderEditor.SamplerNode;11;-899.7441,914.2409;Inherit;True;Property;Material_TextureD_3;Emissive;2;0;Create;False;0;0;0;False;0;False;-1;abc00000000012000771315061351522;abc00000000000126704100571234953;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;15;-598.2767,509.902;Inherit;False;Property;_Color1;Color 1;4;0;Create;True;0;0;0;False;0;False;1,0.4671207,0.03301889,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;16;-828.6162,687.7076;Inherit;False;Property;_Color2;Color 2;5;0;Create;True;0;0;0;False;0;False;1,0.3148885,0,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;-1273.948,219.3247;Inherit;True;Property;Material_Texture2D_0;Normal;0;0;Create;False;0;0;0;False;0;False;-1;abc00000000005546889098118452484;abc00000000014120843247237600213;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;14;-322.69,667.3084;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;18;11.98759,921.0881;Inherit;False;Property;_Power;Power;7;0;Create;True;0;0;0;False;0;False;1;0.36;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;22;-118.4377,715.6572;Inherit;False;Property;_EmissiveTexture;EmissiveTexture;9;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.BreakToComponentsNode;2;-931.9487,284.099;Inherit;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RangedFloatNode;4;-979.5865,82.44442;Inherit;False;Property;_Invert;Invert;6;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;21;-1399.703,-362.969;Inherit;True;Property;Material_Texture2D_1;Albedo;1;0;Create;False;0;0;0;False;0;False;-1;abc00000000015719810112367684682;abc00000000000126704100571234953;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;3;-1242.469,-94.17523;Inherit;False;Property;_Brightness;Brightness;3;0;Create;True;0;0;0;False;0;False;1;0.45;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;7;-948.7675,468.824;Inherit;False;Property;_Desaturation;Desaturation;8;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;20;232.8531,679.8911;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;5;-748.8565,86.80753;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;-1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DesaturateOpNode;8;-75.25391,247.9458;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;6;-782.9471,-214.9223;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.DynamicAppendNode;9;-584.8494,264.599;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;570.1154,27.2582;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;M_Emissive;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;18;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;14;0;15;0
WireConnection;14;1;16;0
WireConnection;14;2;11;1
WireConnection;22;1;14;0
WireConnection;22;0;11;0
WireConnection;2;0;1;0
WireConnection;20;0;22;0
WireConnection;20;1;18;0
WireConnection;5;0;2;1
WireConnection;5;1;4;0
WireConnection;8;0;20;0
WireConnection;8;1;7;0
WireConnection;6;0;21;0
WireConnection;6;1;3;0
WireConnection;9;0;2;0
WireConnection;9;1;5;0
WireConnection;9;2;2;2
WireConnection;0;0;6;0
WireConnection;0;1;9;0
WireConnection;0;2;8;0
ASEEND*/
//CHKSM=A99F426C3346B2A12735383CBFE171C1726BAFCC
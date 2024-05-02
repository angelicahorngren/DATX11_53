// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "M_Master_Metallic"
{
	Properties
	{
		Material_Texture2D_1("Albedo", 2D) = "white" {}
		Material_Texture2D_0("Normal", 2D) = "bump" {}
		Material_Texture2D_3("Roughness", 2D) = "white" {}
		Material_Texture2D_4("Mask", 2D) = "white" {}
		Material_Texture2D_2("Metallic", 2D) = "white" {}
		_Brightness("Brightness", Range( 0 , 5)) = 1
		_Roughness("Roughness", Range( 0 , 5)) = 1
		_Normal_Invert("Normal_Invert", Float) = -1
		[Toggle(_COLORMASK_ON)] _ColorMask("ColorMask", Float) = 0
		[Toggle(_MASKINVERT_ON)] _MaskInvert("MaskInvert", Float) = 0
		_Color("Color", Color) = (0,0,0,0)
		_Desaturation("Desaturation", Range( 0 , 1)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma shader_feature_local _COLORMASK_ON
		#pragma shader_feature_local _MASKINVERT_ON
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D Material_Texture2D_0;
		uniform float4 Material_Texture2D_0_ST;
		uniform float _Normal_Invert;
		uniform sampler2D Material_Texture2D_1;
		uniform float4 Material_Texture2D_1_ST;
		uniform float4 _Color;
		uniform sampler2D Material_Texture2D_4;
		uniform float4 Material_Texture2D_4_ST;
		uniform float _Brightness;
		uniform float _Desaturation;
		uniform sampler2D Material_Texture2D_2;
		uniform float4 Material_Texture2D_2_ST;
		uniform sampler2D Material_Texture2D_3;
		uniform float4 Material_Texture2D_3_ST;
		uniform float _Roughness;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uvMaterial_Texture2D_0 = i.uv_texcoord * Material_Texture2D_0_ST.xy + Material_Texture2D_0_ST.zw;
			float3 break14 = UnpackNormal( tex2D( Material_Texture2D_0, uvMaterial_Texture2D_0 ) );
			float4 appendResult15 = (float4(break14.x , ( break14.y * _Normal_Invert ) , break14.z , 0.0));
			o.Normal = appendResult15.xyz;
			float2 uvMaterial_Texture2D_1 = i.uv_texcoord * Material_Texture2D_1_ST.xy + Material_Texture2D_1_ST.zw;
			float4 tex2DNode1 = tex2D( Material_Texture2D_1, uvMaterial_Texture2D_1 );
			float2 uvMaterial_Texture2D_4 = i.uv_texcoord * Material_Texture2D_4_ST.xy + Material_Texture2D_4_ST.zw;
			float4 tex2DNode25 = tex2D( Material_Texture2D_4, uvMaterial_Texture2D_4 );
			#ifdef _MASKINVERT_ON
				float staticSwitch30 = ( 1.0 - tex2DNode25.r );
			#else
				float staticSwitch30 = tex2DNode25.r;
			#endif
			float4 lerpResult26 = lerp( tex2DNode1 , ( tex2DNode1 * _Color ) , staticSwitch30);
			#ifdef _COLORMASK_ON
				float4 staticSwitch24 = lerpResult26;
			#else
				float4 staticSwitch24 = tex2DNode1;
			#endif
			float3 desaturateInitialColor31 = ( staticSwitch24 * _Brightness ).rgb;
			float desaturateDot31 = dot( desaturateInitialColor31, float3( 0.299, 0.587, 0.114 ));
			float3 desaturateVar31 = lerp( desaturateInitialColor31, desaturateDot31.xxx, _Desaturation );
			o.Albedo = desaturateVar31;
			float2 uvMaterial_Texture2D_2 = i.uv_texcoord * Material_Texture2D_2_ST.xy + Material_Texture2D_2_ST.zw;
			o.Metallic = tex2D( Material_Texture2D_2, uvMaterial_Texture2D_2 ).r;
			float2 uvMaterial_Texture2D_3 = i.uv_texcoord * Material_Texture2D_3_ST.xy + Material_Texture2D_3_ST.zw;
			o.Smoothness = ( ( 1.0 - tex2D( Material_Texture2D_3, uvMaterial_Texture2D_3 ).r ) * _Roughness );
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18930
2603;232;1820;797;1793.802;712.4451;1.350704;True;True
Node;AmplifyShaderEditor.SamplerNode;25;-2158.194,-328.9305;Inherit;True;Property;Material_Texture2D_4;Mask;3;0;Create;False;0;0;0;False;0;False;-1;abc00000000013474387870728954763;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;27;-1649.232,-548.1251;Inherit;False;Property;_Color;Color;10;0;Create;True;0;0;0;False;0;False;0,0,0,0;0.8,0.8,0.8,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;-1704.099,-882.0999;Inherit;True;Property;Material_Texture2D_1;Albedo;0;0;Create;False;0;0;0;False;0;False;-1;abc00000000013474387870728954763;abc00000000005211546218206248486;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;29;-1794.227,-103.7148;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;28;-1338.832,-488.925;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;30;-1720.101,-304.087;Inherit;False;Property;_MaskInvert;MaskInvert;9;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;2;-1606.801,-19.90009;Inherit;True;Property;Material_Texture2D_0;Normal;1;0;Create;False;0;0;0;False;0;False;-1;abc00000000005546889098118452484;abc00000000001707744076708742064;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;26;-1006.995,-282.1305;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.BreakToComponentsNode;14;-1233.74,29.60597;Inherit;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SamplerNode;3;-1240.404,824.3156;Inherit;True;Property;Material_Texture2D_3;Roughness;2;0;Create;False;0;0;0;False;0;False;-1;abc00000000012000771315061351522;abc00000000015130733455222063585;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;22;-1176.348,151.3147;Inherit;False;Property;_Normal_Invert;Normal_Invert;7;0;Create;True;0;0;0;False;0;False;-1;-1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-769.7741,-324.1851;Inherit;False;Property;_Brightness;Brightness;5;0;Create;True;0;0;0;False;0;False;1;1;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;24;-815.7561,-591.1318;Inherit;False;Property;_ColorMask;ColorMask;8;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;5;-476.6996,-447.9;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;18;-1041.247,25.51452;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;-1;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;7;-927.9332,856.6031;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;9;-984.6331,1083.904;Inherit;False;Property;_Roughness;Roughness;6;0;Create;True;0;0;0;False;0;False;1;1;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;32;-638.9491,-124.3077;Inherit;False;Property;_Desaturation;Desaturation;11;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;15;-886.6402,10.10597;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SamplerNode;10;-977.4857,290.4337;Inherit;True;Property;Material_Texture2D_2;Metallic;4;0;Create;False;0;0;0;False;0;False;-1;abc00000000012000771315061351522;abc00000000005651154134501610070;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;8;-479.4905,778.0797;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DesaturateOpNode;31;-336.9491,-195.3077;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;M_Master_Metallic;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;18;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;29;0;25;1
WireConnection;28;0;1;0
WireConnection;28;1;27;0
WireConnection;30;1;25;1
WireConnection;30;0;29;0
WireConnection;26;0;1;0
WireConnection;26;1;28;0
WireConnection;26;2;30;0
WireConnection;14;0;2;0
WireConnection;24;1;1;0
WireConnection;24;0;26;0
WireConnection;5;0;24;0
WireConnection;5;1;6;0
WireConnection;18;0;14;1
WireConnection;18;1;22;0
WireConnection;7;0;3;1
WireConnection;15;0;14;0
WireConnection;15;1;18;0
WireConnection;15;2;14;2
WireConnection;8;0;7;0
WireConnection;8;1;9;0
WireConnection;31;0;5;0
WireConnection;31;1;32;0
WireConnection;0;0;31;0
WireConnection;0;1;15;0
WireConnection;0;3;10;1
WireConnection;0;4;8;0
ASEEND*/
//CHKSM=C902290424BC53840FCEE634729E4615CA7C791C
// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "M_Master"
{
	Properties
	{
		Material_Texture2D_1("Albedo", 2D) = "white" {}
		Material_Texture2D_0("Normal", 2D) = "bump" {}
		Material_Texture2D_2("Roughness", 2D) = "white" {}
		Material_TextureD_3("Emissive", 2D) = "white" {}
		_Brightness("Brightness", Range( 0 , 5)) = 1
		Material_Texture2D_4("Mask", 2D) = "white" {}
		_Roughness("Roughness", Range( 0 , 5)) = 1
		_Invert("Invert", Float) = 0
		[Toggle(_COLORMASK_ON)] _ColorMask("ColorMask", Float) = 0
		[Toggle(_ROUGHNESS_ALPHA_ON)] _Roughness_Alpha("Roughness_Alpha", Float) = 0
		[Toggle(_EMISSIVE_ON)] _Emissive("Emissive", Float) = 0
		_UV("UV", Range( 0.1 , 10)) = 1
		[Toggle(_MASKINVERT_ON)] _MaskInvert("MaskInvert", Float) = 0
		_Color("Color", Color) = (0,0,0,0)
		_Desaturation("Desaturation", Range( 0 , 1)) = 0
		_UV_Offset("UV_Offset", Vector) = (0,0,0,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma shader_feature_local _COLORMASK_ON
		#pragma shader_feature_local _MASKINVERT_ON
		#pragma shader_feature_local _EMISSIVE_ON
		#pragma shader_feature_local _ROUGHNESS_ALPHA_ON
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D Material_Texture2D_0;
		uniform float _UV;
		uniform float2 _UV_Offset;
		uniform float _Invert;
		uniform sampler2D Material_Texture2D_1;
		uniform float4 _Color;
		uniform sampler2D Material_Texture2D_4;
		uniform float4 Material_Texture2D_4_ST;
		uniform float _Brightness;
		uniform float _Desaturation;
		uniform sampler2D Material_TextureD_3;
		uniform float4 Material_TextureD_3_ST;
		uniform sampler2D Material_Texture2D_2;
		uniform float _Roughness;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 temp_cast_0 = (_UV).xx;
			float2 uv_TexCoord22 = i.uv_texcoord * temp_cast_0 + _UV_Offset;
			float3 break10 = UnpackNormal( tex2D( Material_Texture2D_0, uv_TexCoord22 ) );
			float4 appendResult11 = (float4(break10.x , ( break10.y * _Invert ) , break10.z , 0.0));
			o.Normal = appendResult11.xyz;
			float4 tex2DNode1 = tex2D( Material_Texture2D_1, uv_TexCoord22 );
			float2 uvMaterial_Texture2D_4 = i.uv_texcoord * Material_Texture2D_4_ST.xy + Material_Texture2D_4_ST.zw;
			float4 tex2DNode17 = tex2D( Material_Texture2D_4, uvMaterial_Texture2D_4 );
			#ifdef _MASKINVERT_ON
				float staticSwitch20 = ( 1.0 - tex2DNode17.r );
			#else
				float staticSwitch20 = tex2DNode17.r;
			#endif
			float4 lerpResult18 = lerp( tex2DNode1 , ( tex2DNode1 * _Color ) , staticSwitch20);
			#ifdef _COLORMASK_ON
				float4 staticSwitch19 = lerpResult18;
			#else
				float4 staticSwitch19 = tex2DNode1;
			#endif
			float3 desaturateInitialColor27 = ( staticSwitch19 * _Brightness ).rgb;
			float desaturateDot27 = dot( desaturateInitialColor27, float3( 0.299, 0.587, 0.114 ));
			float3 desaturateVar27 = lerp( desaturateInitialColor27, desaturateDot27.xxx, _Desaturation );
			o.Albedo = desaturateVar27;
			float2 uvMaterial_TextureD_3 = i.uv_texcoord * Material_TextureD_3_ST.xy + Material_TextureD_3_ST.zw;
			#ifdef _EMISSIVE_ON
				float staticSwitch29 = tex2D( Material_TextureD_3, uvMaterial_TextureD_3 ).r;
			#else
				float staticSwitch29 = 0.0;
			#endif
			float3 temp_cast_3 = (staticSwitch29).xxx;
			o.Emission = temp_cast_3;
			#ifdef _ROUGHNESS_ALPHA_ON
				float staticSwitch25 = ( tex2DNode1.a * _Roughness );
			#else
				float staticSwitch25 = ( ( 1.0 - tex2D( Material_Texture2D_2, uv_TexCoord22 ).r ) * _Roughness );
			#endif
			o.Smoothness = staticSwitch25;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18930
2845;131;1820;789;3698.952;816.4749;1.3;True;True
Node;AmplifyShaderEditor.RangedFloatNode;23;-3296.259,-427.3929;Inherit;False;Property;_UV;UV;11;0;Create;True;0;0;0;False;0;False;1;0.5;0.1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;32;-3140.022,-217.5267;Inherit;False;Property;_UV_Offset;UV_Offset;15;0;Create;True;0;0;0;False;0;False;0,0;1,0.5;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;22;-2915.042,-435.377;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;17;-2504.367,-19.21308;Inherit;True;Property;Material_Texture2D_4;Mask;5;0;Create;False;0;0;0;False;0;False;-1;abc00000000013474387870728954763;abc00000000013474387870728954763;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;-2304.903,-878.1303;Inherit;True;Property;Material_Texture2D_1;Albedo;0;0;Create;False;0;0;0;False;0;False;-1;abc00000000013474387870728954763;4bbacf18e978d06479e809e84fe817d2;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;21;-2097.731,250.0792;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;15;-2193.004,-322.0078;Inherit;False;Property;_Color;Color;13;0;Create;True;0;0;0;False;0;False;0,0,0,0;0.8,0.8,0.8,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;20;-2023.605,49.70701;Inherit;False;Property;_MaskInvert;MaskInvert;12;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;16;-1882.605,-262.8076;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;18;-1550.768,-56.01306;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;2;-1166.801,184.8999;Inherit;True;Property;Material_Texture2D_0;Normal;1;0;Create;False;0;0;0;False;0;False;-1;abc00000000005546889098118452484;abc00000000008886504918599351223;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;3;-1567.269,630.0417;Inherit;True;Property;Material_Texture2D_2;Roughness;2;0;Create;False;0;0;0;False;0;False;-1;abc00000000012000771315061351522;abc00000000003107859184941060364;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;19;-1359.529,-365.0145;Inherit;False;Property;_ColorMask;ColorMask;8;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-1092.5,-128.6;Inherit;False;Property;_Brightness;Brightness;4;0;Create;True;0;0;0;False;0;False;1;1.28;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;7;-1249.93,647.5916;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;10;-824.8015,251.3212;Inherit;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RangedFloatNode;13;-872.4393,49.66666;Inherit;False;Property;_Invert;Invert;7;0;Create;True;0;0;0;False;0;False;0;-1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;9;-1228.24,840.0325;Inherit;False;Property;_Roughness;Roughness;6;0;Create;True;0;0;0;False;0;False;1;1;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;26;-908.4722,513.6764;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;5;-675.7999,-247.7001;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;28;-642.3318,-79.46907;Inherit;False;Property;_Desaturation;Desaturation;14;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;31;-512.8462,784.0377;Inherit;False;Constant;_Float0;Float 0;15;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;30;-792.5969,881.4632;Inherit;True;Property;Material_TextureD_3;Emissive;3;0;Create;False;0;0;0;False;0;False;-1;abc00000000012000771315061351522;abc00000000012000771315061351522;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;12;-641.7093,54.02977;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;-1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;8;-899.3399,629.4326;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DesaturateOpNode;27;-340.3318,-150.4691;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DynamicAppendNode;11;-477.7022,231.8212;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.StaticSwitch;25;-604.8002,620.5183;Inherit;False;Property;_Roughness_Alpha;Roughness_Alpha;9;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;29;-302.8734,736.4382;Inherit;False;Property;_Emissive;Emissive;10;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;313,-10;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;M_Master;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;18;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;22;0;23;0
WireConnection;22;1;32;0
WireConnection;1;1;22;0
WireConnection;21;0;17;1
WireConnection;20;1;17;1
WireConnection;20;0;21;0
WireConnection;16;0;1;0
WireConnection;16;1;15;0
WireConnection;18;0;1;0
WireConnection;18;1;16;0
WireConnection;18;2;20;0
WireConnection;2;1;22;0
WireConnection;3;1;22;0
WireConnection;19;1;1;0
WireConnection;19;0;18;0
WireConnection;7;0;3;1
WireConnection;10;0;2;0
WireConnection;26;0;1;4
WireConnection;26;1;9;0
WireConnection;5;0;19;0
WireConnection;5;1;6;0
WireConnection;12;0;10;1
WireConnection;12;1;13;0
WireConnection;8;0;7;0
WireConnection;8;1;9;0
WireConnection;27;0;5;0
WireConnection;27;1;28;0
WireConnection;11;0;10;0
WireConnection;11;1;12;0
WireConnection;11;2;10;2
WireConnection;25;1;8;0
WireConnection;25;0;26;0
WireConnection;29;1;31;0
WireConnection;29;0;30;1
WireConnection;0;0;27;0
WireConnection;0;1;11;0
WireConnection;0;2;29;0
WireConnection;0;4;25;0
ASEEND*/
//CHKSM=BCB457765DA798F9B0CF2198DAB3813ACF5CBFC2
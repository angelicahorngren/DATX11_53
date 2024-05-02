// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "M_MasterTwoSided"
{
	Properties
	{
		Material_Texture2D_1("Albedo", 2D) = "white" {}
		Material_Texture2D_0("Normal", 2D) = "bump" {}
		Material_Texture2D_2("Roughness", 2D) = "white" {}
		_Brightness("Brightness", Range( 0 , 5)) = 1
		Material_Texture2D_4("Mask", 2D) = "white" {}
		_Roughness("Roughness", Range( 0 , 5)) = 1
		_Invert("Invert", Float) = 0
		[Toggle(_COLORMASK_ON)] _ColorMask("ColorMask", Float) = 0
		_UV("UV", Range( 0.1 , 10)) = 1
		[Toggle(_MASKINVERT_ON)] _MaskInvert("MaskInvert", Float) = 0
		_Color("Color", Color) = (0,0,0,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Off
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
		uniform float _UV;
		uniform float _Invert;
		uniform sampler2D Material_Texture2D_1;
		uniform float4 _Color;
		uniform sampler2D Material_Texture2D_4;
		uniform float4 Material_Texture2D_4_ST;
		uniform float _Brightness;
		uniform sampler2D Material_Texture2D_2;
		uniform float _Roughness;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 temp_output_24_0 = ( i.uv_texcoord * _UV );
			float3 break10 = UnpackNormal( tex2D( Material_Texture2D_0, temp_output_24_0 ) );
			float4 appendResult11 = (float4(break10.x , ( break10.y * _Invert ) , break10.z , 0.0));
			o.Normal = appendResult11.xyz;
			float4 tex2DNode1 = tex2D( Material_Texture2D_1, temp_output_24_0 );
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
			o.Albedo = ( staticSwitch19 * _Brightness ).rgb;
			o.Smoothness = ( ( 1.0 - tex2D( Material_Texture2D_2, temp_output_24_0 ).r ) * _Roughness );
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18930
2597;92;1820;803;3772.124;744.5506;1.6;True;True
Node;AmplifyShaderEditor.TextureCoordinatesNode;22;-2915.042,-435.377;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;23;-2990.272,-188.5416;Inherit;False;Property;_UV;UV;8;0;Create;True;0;0;0;False;0;False;1;0.5;0.1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;24;-2679.272,-259.5416;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;17;-2504.367,-19.21308;Inherit;True;Property;Material_Texture2D_4;Mask;4;0;Create;False;0;0;0;False;0;False;-1;abc00000000013474387870728954763;abc00000000013474387870728954763;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;15;-2193.004,-322.0078;Inherit;False;Property;_Color;Color;10;0;Create;True;0;0;0;False;0;False;0,0,0,0;0.8,0.8,0.8,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;-2304.903,-878.1303;Inherit;True;Property;Material_Texture2D_1;Albedo;0;0;Create;False;0;0;0;False;0;False;-1;abc00000000013474387870728954763;abc00000000010070739072400082136;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;21;-2097.731,250.0792;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;20;-2023.605,49.70701;Inherit;False;Property;_MaskInvert;MaskInvert;9;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;16;-1882.605,-262.8076;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;2;-1166.801,184.8999;Inherit;True;Property;Material_Texture2D_0;Normal;1;0;Create;False;0;0;0;False;0;False;-1;abc00000000005546889098118452484;abc00000000011758110384990735058;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;3;-1174.8,511.5;Inherit;True;Property;Material_Texture2D_2;Roughness;2;0;Create;False;0;0;0;False;0;False;-1;abc00000000012000771315061351522;abc00000000012000771315061351522;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BreakToComponentsNode;10;-824.8015,251.3212;Inherit;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RangedFloatNode;13;-872.4393,49.66666;Inherit;False;Property;_Invert;Invert;6;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;18;-1550.768,-56.01306;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;19;-1359.529,-365.0145;Inherit;False;Property;_ColorMask;ColorMask;7;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-1092.5,-128.6;Inherit;False;Property;_Brightness;Brightness;3;0;Create;True;0;0;0;False;0;False;1;1;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;9;-835.77,721.4907;Inherit;False;Property;_Roughness;Roughness;5;0;Create;True;0;0;0;False;0;False;1;1;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;7;-857.4611,529.0498;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;12;-641.7093,54.02977;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;-1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;8;-506.8706,510.8909;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;11;-477.7022,231.8212;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;5;-675.7999,-247.7001;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;M_MasterTwoSided;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;18;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;24;0;22;0
WireConnection;24;1;23;0
WireConnection;1;1;24;0
WireConnection;21;0;17;1
WireConnection;20;1;17;1
WireConnection;20;0;21;0
WireConnection;16;0;1;0
WireConnection;16;1;15;0
WireConnection;2;1;24;0
WireConnection;3;1;24;0
WireConnection;10;0;2;0
WireConnection;18;0;1;0
WireConnection;18;1;16;0
WireConnection;18;2;20;0
WireConnection;19;1;1;0
WireConnection;19;0;18;0
WireConnection;7;0;3;1
WireConnection;12;0;10;1
WireConnection;12;1;13;0
WireConnection;8;0;7;0
WireConnection;8;1;9;0
WireConnection;11;0;10;0
WireConnection;11;1;12;0
WireConnection;11;2;10;2
WireConnection;5;0;19;0
WireConnection;5;1;6;0
WireConnection;0;0;5;0
WireConnection;0;1;11;0
WireConnection;0;4;8;0
ASEEND*/
//CHKSM=EA27645056602451988BC4B5257DF5D8715CCC46
// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "M_Fabric"
{
	Properties
	{
		Material_Texture2D_1("Albedo", 2D) = "white" {}
		Material_Texture2D_0("Normal", 2D) = "bump" {}
		Material_Texture2D_2("Roughness", 2D) = "white" {}
		_Brightness("Brightness", Range( 0 , 5)) = 1
		_Roughness("Roughness", Range( 0 , 5)) = 1
		_Invert("Invert", Float) = 0
		_Color("Color", Color) = (1,1,1,0)
		_UV("UV", Range( 1 , 10)) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
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
		uniform float _Brightness;
		uniform sampler2D Material_Texture2D_2;
		uniform float _Roughness;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 temp_output_23_0 = ( i.uv_texcoord * _UV );
			float3 break9 = UnpackNormal( tex2D( Material_Texture2D_0, temp_output_23_0 ) );
			float4 appendResult17 = (float4(break9.x , ( break9.y * _Invert ) , break9.z , 0.0));
			o.Normal = appendResult17.xyz;
			o.Albedo = ( ( tex2D( Material_Texture2D_1, temp_output_23_0 ) * _Color ) * _Brightness ).rgb;
			o.Smoothness = ( ( 1.0 - tex2D( Material_Texture2D_2, temp_output_23_0 ).r ) * _Roughness );
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18930
2597;92;1820;803;3955.013;613.5507;1.3;True;True
Node;AmplifyShaderEditor.TextureCoordinatesNode;21;-3082.444,-356.9304;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;22;-3157.674,-110.0949;Inherit;False;Property;_UV;UV;7;0;Create;True;0;0;0;False;0;False;1;1;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;23;-2846.674,-181.0949;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;7;-1275.685,267.7829;Inherit;True;Property;Material_Texture2D_0;Normal;1;0;Create;False;0;0;0;False;0;False;-1;abc00000000005546889098118452484;abc00000000005324788876782840406;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;2;-2413.787,-795.2474;Inherit;True;Property;Material_Texture2D_1;Albedo;0;0;Create;False;0;0;0;False;0;False;-1;abc00000000013474387870728954763;abc00000000004651139553646898344;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BreakToComponentsNode;9;-933.6859,334.2042;Inherit;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.ColorNode;3;-2301.888,-239.1248;Inherit;False;Property;_Color;Color;6;0;Create;True;0;0;0;False;0;False;1,1,1,0;0.4313725,0.6235294,0.4893682,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;10;-1283.684,594.3831;Inherit;True;Property;Material_Texture2D_2;Roughness;2;0;Create;False;0;0;0;False;0;False;-1;abc00000000012000771315061351522;abc00000000002124711222754993756;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;8;-981.3237,132.5497;Inherit;False;Property;_Invert;Invert;5;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;11;-750.5936,136.9128;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;-1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;12;-944.6544,804.3736;Inherit;False;Property;_Roughness;Roughness;4;0;Create;True;0;0;0;False;0;False;1;2.36;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;13;-1201.384,-45.71703;Inherit;False;Property;_Brightness;Brightness;3;0;Create;True;0;0;0;False;0;False;1;1.67;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;14;-966.3455,611.9328;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;6;-1812.451,-375.5741;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;16;-615.7549,593.7739;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;17;-586.5865,314.7042;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;18;-784.6843,-164.8171;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.FresnelNode;20;-1725.315,51.91706;Inherit;False;Standard;WorldNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;M_Fabric;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;18;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;23;0;21;0
WireConnection;23;1;22;0
WireConnection;7;1;23;0
WireConnection;2;1;23;0
WireConnection;9;0;7;0
WireConnection;10;1;23;0
WireConnection;11;0;9;1
WireConnection;11;1;8;0
WireConnection;14;0;10;1
WireConnection;6;0;2;0
WireConnection;6;1;3;0
WireConnection;16;0;14;0
WireConnection;16;1;12;0
WireConnection;17;0;9;0
WireConnection;17;1;11;0
WireConnection;17;2;9;2
WireConnection;18;0;6;0
WireConnection;18;1;13;0
WireConnection;0;0;18;0
WireConnection;0;1;17;0
WireConnection;0;4;16;0
ASEEND*/
//CHKSM=32B4FC5D9C45C54EED032DE7734ACDFB2438F36A
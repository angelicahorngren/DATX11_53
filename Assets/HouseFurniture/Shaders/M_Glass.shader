// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "M_Glass"
{
	Properties
	{
		Material_Texture2D_2("Roughness", 2D) = "white" {}
		_Brightness("Brightness", Range( 0 , 5)) = 1
		_Roughness("Roughness", Range( 0 , 5)) = 1
		[Toggle(_ROUGHNESS_VALUE_ON)] _Roughness_Value("Roughness_Value", Float) = 0
		_UV("UV", Range( 0.1 , 10)) = 1
		_Color("Color", Color) = (1,1,1,0)
		_Desaturation("Desaturation", Range( 0 , 1)) = 0
		_Opacity("Opacity", Range( 0 , 1)) = 0.5
		_Metallic("Metallic", Range( 0 , 1)) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Overlay+0" "IgnoreProjector" = "True" }
		Cull Back
		Blend OneMinusDstColor One
		
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		#pragma shader_feature_local _ROUGHNESS_VALUE_ON
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float4 _Color;
		uniform float _Brightness;
		uniform float _Desaturation;
		uniform float _Metallic;
		uniform sampler2D Material_Texture2D_2;
		uniform float _UV;
		uniform float _Roughness;
		uniform float _Opacity;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float3 desaturateInitialColor15 = ( _Color * _Brightness ).rgb;
			float desaturateDot15 = dot( desaturateInitialColor15, float3( 0.299, 0.587, 0.114 ));
			float3 desaturateVar15 = lerp( desaturateInitialColor15, desaturateDot15.xxx, _Desaturation );
			o.Albedo = desaturateVar15;
			o.Metallic = _Metallic;
			#ifdef _ROUGHNESS_VALUE_ON
				float staticSwitch22 = _Roughness;
			#else
				float staticSwitch22 = ( ( 1.0 - tex2D( Material_Texture2D_2, ( i.uv_texcoord * _UV ) ).r ) * _Roughness );
			#endif
			o.Smoothness = staticSwitch22;
			o.Alpha = _Opacity;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard keepalpha fullforwardshadows 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			sampler3D _DitherMaskLOD;
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float3 worldPos : TEXCOORD2;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				o.worldPos = worldPos;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.customPack1.xy;
				float3 worldPos = IN.worldPos;
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				SurfaceOutputStandard o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandard, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				half alphaRef = tex3D( _DitherMaskLOD, float3( vpos.xy * 0.25, o.Alpha * 0.9375 ) ).a;
				clip( alphaRef - 0.01 );
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18930
2634;245;1820;777;337.6895;239.7251;1;True;True
Node;AmplifyShaderEditor.TextureCoordinatesNode;29;-2079.533,-593.6653;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;27;-2154.763,-346.8297;Inherit;False;Property;_UV;UV;5;0;Create;True;0;0;0;False;0;False;1;0.25;0.1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;28;-1843.763,-417.8298;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;19;-751.2211,470.7919;Inherit;True;Property;Material_Texture2D_2;Roughness;0;0;Create;False;0;0;0;False;0;False;-1;abc00000000012000771315061351522;abc00000000014308900306582000776;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;8;-259.7211,-297.8081;Inherit;False;Property;_Brightness;Brightness;1;0;Create;True;0;0;0;False;0;False;1;1.83;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;23;-417.1511,478.3835;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;25;-1359.695,-480.2961;Inherit;False;Property;_Color;Color;6;0;Create;True;0;0;0;False;0;False;1,1,1,0;0.8584906,0.8584906,0.8584906,0.3333333;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;20;-429.2211,686.7919;Inherit;False;Property;_Roughness;Roughness;3;0;Create;True;0;0;0;False;0;False;1;1.17;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;21;-79.22107,470.7919;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;11;156.979,-416.9082;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;12;190.4471,-248.6771;Inherit;False;Property;_Desaturation;Desaturation;7;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;31;500.3804,11.25916;Inherit;False;Property;_Opacity;Opacity;8;0;Create;True;0;0;0;False;0;False;0.5;0.496;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.DesaturateOpNode;15;492.4471,-319.6772;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;32;403.6537,145.0332;Inherit;False;Property;_Metallic;Metallic;9;0;Create;True;0;0;0;False;0;False;1;0.895;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;22;224.7789,454.7919;Inherit;False;Property;_Roughness_Value;Roughness_Value;4;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1043.886,-42.12992;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;M_Glass;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;False;Transparent;;Overlay;All;18;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;5;4;False;-1;1;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;2;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;28;0;29;0
WireConnection;28;1;27;0
WireConnection;19;1;28;0
WireConnection;23;0;19;1
WireConnection;21;0;23;0
WireConnection;21;1;20;0
WireConnection;11;0;25;0
WireConnection;11;1;8;0
WireConnection;15;0;11;0
WireConnection;15;1;12;0
WireConnection;22;1;21;0
WireConnection;22;0;20;0
WireConnection;0;0;15;0
WireConnection;0;3;32;0
WireConnection;0;4;22;0
WireConnection;0;9;31;0
ASEEND*/
//CHKSM=E9ADCFD3A8FB215AFAC418B38482B72C3E59D8EB
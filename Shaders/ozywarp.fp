//redefined warp2 shader that allows us to control it somehow using also materials - Ozy81
const float pi = 3.14159265358979323846;

vec2 GetWarpOffset(vec2 texCoord)
{
	vec2 offset;

	offset.y = 0.5 + sin(pi * 2.0 * (texCoord.y + timer * 0.61 + 900.0/8192.0)) + sin(pi * 2.0 * (texCoord.x * 2.0 + timer * 0.36 + 300.0/8192.0));
	offset.x = 0.5 + sin(pi * 2.0 * (texCoord.y + timer * 0.49 + 700.0/8192.0)) + sin(pi * 2.0 * (texCoord.x * 2.0 + timer * 0.49 + 1200.0/8192.0));

	offset *= 0.05;

	return offset;
}

Material ProcessMaterial() //got this from waves.fp shader done by AFADoomer for BoA
{
	vec2 texCoord = vTexCoord.st;
	vec2 warpoffset = GetWarpOffset(texCoord);

	Material material;
	material.Base = getTexel(texCoord + warpoffset) * 0.85;
	material.Normal = ApplyNormalMap(texCoord + warpoffset);
#if defined(SPECULAR)
	material.Specular = texture(speculartexture, texCoord).rgb;
#endif
#if defined(BRIGHTMAP)
	material.Bright = texture(brighttexture, vTexCoord.st);
#endif
	return material;
}
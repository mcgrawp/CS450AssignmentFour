#ifndef __RAYTRACER_H__
#define __RAYTRACER_H__
#include <stdio.h>
#include <cstdio>
#include "Angel.h"

struct ray
{
	vec4 origin;
	vec4 direction;

};

vec4 some_ray(ray a_ray, GLfloat t)
{
	return a_ray.origin + a_ray.direction * t;
};

class RayTracer
{
public:
	RayTracer(void)
	{
		// a change
	}

	void trace(vec4 eye_position)
	{

	}

	void debug_print(std::string msg)
	{
		fprintf(stdout, "%s\n", msg.c_str());
	}
};
#endif //__RAYTRACER_H__
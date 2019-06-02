//[header]
// A simple program that uses ray-tracing to render a single triangle
//[/header]
//[compile]
// Download the raytri.cpp and geometry.h files to a folder.
// Open a shell/terminal, and run the following command where the files is saved:
//
// c++ -o raytri raytri.cpp -O3 -std=c++11 -DMOLLER_TRUMBORE
//
// Run with: ./raytri. Open the file ./out.png in Photoshop or any program
// reading PPM files.
//[/compile]
//[ignore]
// Copyright (C) 2012  www.scratchapixel.com
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.
//[/ignore]

#define _USE_MATH_DEFINES 1

#include <math.h>
#include <float.h>
#include <stdio.h>

#if WIN32
#include <emscripten.h>
#else
#define EMSCRIPTEN_KEEPALIVE
#endif

void memcpy(void*out, const void*in, int n) {
	const unsigned char*cin = (const unsigned char*)in;
	unsigned char*cout = (unsigned char*)out;
	for (int i = 0; i < n; i++) {
		cout[i] = cin[i];
	}
}

extern "C" void stuff(void*ptr);
extern "C" void printFloat(float v);
extern "C" void printString(const char*str);
extern "C" void printLabel(unsigned int n);

constexpr float kEpsilon = 1e-8;

struct Vec3f {
	float x, y, z;

	Vec3f(float x, float y, float z) {
		this->x = x;
		this->y = y;
		this->z = z;
	}

	Vec3f operator + (const Vec3f &v) const
	{
		return Vec3f(x + v.x, y + v.y, z + v.z);
	}
	Vec3f operator - (const Vec3f &v) const
	{
		return Vec3f(x - v.x, y - v.y, z - v.z);
	}
	Vec3f operator - () const
	{
		return Vec3f(-x, -y, -z);
	}
	Vec3f operator * (const float &r) const
	{
		return Vec3f(x * r, y * r, z * r);
	}
	Vec3f operator * (const Vec3f &v) const
	{
		return Vec3f(x * v.x, y * v.y, z * v.z);
	}
	float dotProduct(const Vec3f &v) const
	{
		return x * v.x + y * v.y + z * v.z;
	}
	Vec3f& operator /= (const float &r)
	{
		x /= r, y /= r, z /= r; return *this;
	}
	Vec3f& operator *= (const float &r)
	{
		x *= r, y *= r, z *= r; return *this;
	}
	Vec3f crossProduct(const Vec3f &v) const
	{
		return Vec3f(y * v.z - z * v.y, z * v.x - x * v.z, x * v.y - y * v.x);
	}
	float norm() const
	{
		return x * x + y * y + z * z;
	}
	float length() const
	{
		return sqrt(norm());
	}


};


bool rayTriangleIntersect(
    const Vec3f &orig, const Vec3f &dir,
    const Vec3f &v0, const Vec3f &v1, const Vec3f &v2,
    float &t, float &u, float &v)
{
    Vec3f v0v1 = v1 - v0;
    Vec3f v0v2 = v2 - v0;
    Vec3f pvec = dir.crossProduct(v0v2);
    float det = v0v1.dotProduct(pvec);
    // if the determinant is negative the triangle is backfacing
    // if the determinant is close to 0, the ray misses the triangle


    if (det < kEpsilon) return false;

    float invDet = 1 / det;

    Vec3f tvec = orig - v0;
    u = tvec.dotProduct(pvec) * invDet;
    if (u < 0 || u > 1) return false;

    Vec3f qvec = tvec.crossProduct(v0v1);
    v = dir.dotProduct(qvec) * invDet;
    if (v < 0 || u + v > 1) return false;
    
    t = v0v2.dotProduct(qvec) * invDet;
    
    return true;
}

#if 1

EMSCRIPTEN_KEEPALIVE extern "C" int test(int *v) {
int ox = v[0];
int oy = v[1];
int oz = v[2];
printf("test:%p %d %d %d\n", v, v[0], v[1], v[2]);
return 10 + ox + oy + oz;
}


#endif



EMSCRIPTEN_KEEPALIVE extern "C" int foo(int *v) {
	int ox = v[0];
	int oy = v[1];
	int oz = v[2];
	stuff(v);
	return ox+oy+oz;
}

struct IntersectResult {
	float t;
	float u;
	float v;
};

EMSCRIPTEN_KEEPALIVE extern "C" int intersectTriangles(float ox, float oy, float oz, float dx, float dy, float dz, float * triangles, int n, IntersectResult *result)
{
	Vec3f orig = Vec3f(ox, oy, oz);
	Vec3f direc = Vec3f(dx, dy, dz);
	result->t = FLT_MAX;
	result->u = 0.0f;
	result->v = 0.0f;


	int res = 0;
	for (int i = 0; i < n; i++) {
		Vec3f v0 = Vec3f(triangles[i * 3 + 0], triangles[i * 3 + 1], triangles[i * 3 + 2]);
		Vec3f v1 = Vec3f(triangles[i * 3 + 3], triangles[i * 3 + 4], triangles[i * 3 + 5]);
		Vec3f v2 = Vec3f(triangles[i * 3 + 6], triangles[i * 3 + 7], triangles[i * 3 + 8]);

		float tOut = FLT_MAX, u=0.0f, v=0.0f;
		if (rayTriangleIntersect(orig, direc, v0, v1, v2, tOut, u, v)) {
			res = 1;
			if (result->t > tOut) {
				result->t = tOut;
				result->u = u;
				result->v = v;
			}
		}
	}

	return res;
}




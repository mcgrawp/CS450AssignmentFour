// Simple 2D OpenGL Program

//Includes vec, mat, and other include files as well as macro defs
#define GL3_PROTOTYPES

// Include the vector and matrix utilities from the textbook, as well as some
// macro definitions.
#include "Angel.h"


#ifdef __APPLE__
#  include <OpenGL/gl3.h>
#endif

// My includes
#include <sstream>
#include <iostream>
#include <fstream>
#include <stdio.h>


#include "Obj.h"
#include "RayTracer.h"

using namespace std;


// globals
const string DATA_DIRECTORY_PATH = "./Data/";
RayTracer gRayTracer;

// OpenGL initialization
void
init()
{
	gRayTracer.debug_print("Hey!");
    glEnable(GL_DEPTH_TEST);
    glClearColor(1.0, 1.0, 1.0, 1.0);
}

void
display( void )
{
    glutSwapBuffers();
}

//----------------------------------------------------------------------------

void
keyboard( unsigned char key, int x, int y )
{
    switch( key ) {
	case 033:  // Escape key
	case 'q': case 'Q':
	    exit( EXIT_SUCCESS );
	    break;
    }
}

//----------------------------------------------------------------------------


int main(int argc, char** argv)
{
	string application_info = "Ray Tracer";
	string *window_title = new string;

	glutInit(&argc, argv);
#ifdef __APPLE__
    glutInitDisplayMode(GLUT_3_2_CORE_PROFILE | GLUT_RGBA | GLUT_DEPTH_TEST);
#else
    glutInitDisplayMode(GLUT_RGBA | GLUT_DOUBLE | GLUT_DEPTH);
    glutInitContextVersion (3, 2);
    glutInitContextFlags (GLUT_FORWARD_COMPATIBLE);
#endif

	window_title->append(application_info);
	glutInitWindowSize(1024, 1024);
	glutInitWindowPosition(500, 300);
    glutCreateWindow(window_title->c_str());
    printf("%s\n%s\n", glGetString(GL_RENDERER), glGetString(GL_VERSION));

#ifndef __APPLE__
    glewExperimental = GL_TRUE;
    glewInit();
#endif
	init();

    //NOTE:  callbacks must go after window is created!!!
	glutKeyboardFunc(keyboard);
	glutDisplayFunc(display);
    glutMainLoop();

    return(0);
}

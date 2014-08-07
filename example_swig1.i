%include "typemaps.i"

// Another example of the python swig wrapper.
// example2.i
%module example_swig1
%{
#include "example.h"
%}


//%newobject get_service
//
//// -------------------------- General --------------------------------
//
//%typemap(newfree) (MYService *)
//{
//   // Delete
//   fprintf(stderr, "Freeing service");
//   if ($1) free($1);
//}

// Adding the destructor for myservice. This is responsible for cleanup of MYService C struct.
%extend myservice
{
    ~myservice()
    {
        free($self->stringEntry);
        free($self);
    }
}

// -------------------------- fillup_service --------------------------------

// The next two methods are for fillup_service
%typemap(argout) MYService **servicePointer
{
    // Convert the value to integer again.
    long originalResult = PyInt_AS_LONG($result);

    if(originalResult == 0)
    {
        $result = SWIG_NewPointerObj(SWIG_as_voidptr(temp$argnum), SWIGTYPE_p_myservice, 0 | 0 );
    }
    else
    {
        $result = NULL;
        PyErr_SetString(PyExc_RuntimeError, "An exception has occured");
    }
}

// The purpose of this method is to wrap last argument of 
// fillup_service by pasing a null 'MYService *' for any method
// that ends with MYService **;
%typemap (in,numinputs=0) MYService ** (MYService *temp) {
    $1 = &temp;
}


// -------------------------- fillup_service_array --------------------------

// The next two methods are for fillup_service_array
%typemap(argout) MYService ***serviceArrayPointer
{
    // Convert the value to integer again.
    long originalResult = PyInt_AS_LONG($result);

    if(originalResult == 0)
    {
        PyObject *new_list = PyList_New(0);
        int index = 0;
        while(temp$argnum[index] != NULL)
        {
            MYService *service = temp$argnum[index++];
            // Convert the service to a swig object and pass to list.
            PyList_Append(new_list,
                          SWIG_NewPointerObj(SWIG_as_voidptr(service), SWIGTYPE_p_myservice, 0 | 0 ));
        }
        $result = new_list;
    }
    else
    {
        // Don't try freeing $result!! Leads to seg fault.
        // free($result);
        $result = NULL;
        // Clean up temp$argnum is not required here.
        PyErr_SetString(PyExc_RuntimeError, "An exception has occured");
    }
}

// The purpose of this method is to wrap last argument of 
// fillup_service_array by pasing a null 'MYService **' for any method
// that ends with MYService ***;
%typemap (in,numinputs=0) MYService *** (MYService **temp) {
  $1 = &temp;
}

// Most the the typemaps need to be completed before we add the required methods(by including the header file).
%include "example.h"

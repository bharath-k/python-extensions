%include "typemaps.i"

// example.i
%module example_swig2
%{
#include "example.h"
%}


// -------------------------- get_service ------------------------------------

// Define your typemaps before includeing the required methods.
// That way swig will know what to do with the methods when it actually encounters them.
%typemap(out) MYService *
{
    $result = Py_BuildValue("s", $1->stringEntry);
    free($1);
}


// -------------------------- get_service_array -----------------------------

%typemap(out) MYService **
{
    $result = PyList_New(0);
    int index = 0;
    while($1[index] != NULL)
    {
        MYService *service = $1[index++];
        PyList_Append($result, Py_BuildValue("s", service->stringEntry));
        free(service);
    }
    free($1);
}

// -------------------------- fillup_service --------------------------------

// The next two methods are for fillup_service
%typemap(argout) MYService **servicePointer
{
    // Convert the value to integer again.
    long originalResult = PyInt_AS_LONG($result);

    if(originalResult == 0)
    {
        $result = Py_BuildValue("s", temp$argnum->stringEntry);
        free(temp$argnum);
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
            PyList_Append(new_list, Py_BuildValue("s", service->stringEntry));

            // Free up service.
            free(service);
        }
        // Free up temp value
        free(temp$argnum);
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

// ----------------------------------------------------------------------------

// Most the the typemaps need to be completed before we add the required methods(by including the header file).
%include "example.h"

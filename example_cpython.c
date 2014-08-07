#include <Python.h>
#include "example.h"

// Docstrings
static char moduleDocstring[] =
    "Provides sample example c module apis.";

// Providing only one method as wrapper. The others can be handled similarly.
static char fillupDocstring[] =
    "fillup_service_array";

// Available functions
static PyObject *examplefillup_service_array(PyObject *self, PyObject *args);

// Module specification
static PyMethodDef moduleMethods[] = {
                                        {
                                            // Name of python method.
                                            "fillup_service_array",
                                            examplefillup_service_array,
                                            METH_VARARGS,
                                            fillupDocstring
                                        },
                                        {NULL, NULL, 0, NULL}
                                      };

// The SVC Exception object.
static PyObject *ServiceError;

// Initialize the module. The name of method is init<ModuleName>
PyMODINIT_FUNC
init_example_cpython(void)
{
    // The module name is _example_cpython
    PyObject *m = Py_InitModule3("_example_cpython", moduleMethods, moduleDocstring);
    if (m == NULL)
        return;

    // TODO: Change to desco.svcdirector.
    ServiceError = PyErr_NewException("_example_cpython.error", NULL, NULL);
    // Increment count for type.
    Py_INCREF(ServiceError);

    // Add this to module.
    PyModule_AddObject(m, "error", ServiceError);
}

/**
 * Lookup Service name for provided servicename.
 */
static PyObject *
examplefillup_service_array(PyObject *self, PyObject *args)
{
    int fail;

    // Validate if input fail parameter is provided.
    if (!PyArg_ParseTuple(args, "i", &fail))
        return NULL;

    MYService **servicesArray = NULL;
    int retVal;
    if ((retVal = fillup_service_array(fail, &servicesArray)) == 0)
    {
        if (servicesArray != NULL)
        {
            // Create a list to hold all the return values.
            // We do not know the size in advance. So creating a list and
            // appending items to it.
            PyObject *instances = PyList_New(0);
            MYService *service = NULL;
            int index = 0;
            while ((service = servicesArray[index++]) != NULL)
            {
                PyObject *stringValue = Py_BuildValue("s", service->stringEntry);

                // Add the stringValue to the list.
                PyList_Append(instances, stringValue);

                // NOTE: No Need to decrement 'stringValue' refcount since
                // appending to python list steal ownership of stringValue
                // Py_DECREF(stringValue);

                // Destroy the service entry. as all the required paramters have
                // been captured and converted into corresponding python
                // structures.
                free(service);
            }

            // Free the reference to servicesArray.
            free(servicesArray);

            // Return the list. Also we need not manage reference count since
            // as the list is returned and the caller becomes its owner.
            return instances;
        }
        else
        {
            // Need to return an empty list as not finding entries should not
            // raise exceptions or return null.
            PyObject *instances = PyList_New(0);
            return instances;
        }
    }
    else
    {
        // Set SVCError exception message.
        PyErr_SetString(ServiceError, "An exception has occured.");

        // Returning NULL indicates that there is an exception and python
        // knows how to handle this upstream.
        return NULL;
    }
}

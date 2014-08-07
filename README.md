python-extensions
=================

This project is a demostration of how to build python wrappers for a C program with structs and complicated arguments.
I have built the wrapper using both SWIG (in two mechanisms) and CPython. Partly it was to convince myself that I time I spent on SWIG was worth it!

To build and install all the python extensions:

> sudo make build-and-install-extensions

Testing C Code:

> make
> ./example

Testing extensions after installation:
> python test.py

Objectives::

What the C Program does:
* The C header file defines a simple struct 'MYService' with just a string value in it.
* Various methods are defined to create and return MYService * as well as MYService **.
* In the fill_* methods, an address pointer (to MYService ** or MYService *** ) is passed and this pointer is filled up.

What the Python wrappers need to do:
* For the get_* methods, since the MYService struct in C contains just a string, the python binding can simply return a string value or a list of strings in python.
* For the fill_* methods, Python code cannot pass pointers and hence the last argument for these methods need to be converted into the return value.
* For the fill_* methods, The actual integer return value can be used to indicate whether the operation succeeded or not i.e. throw a Python Runtime Exception is something goes wrong.

Description::

SWIG Wrapper 1:
* Using the traditional approach to wrap the fill_* methods i.e. using the proxy swig wrappers for MYService. Returns a list of proxy MYService objects.

SWIG Wrapper 2:
* To wrap the fill_* methods, converting the value of MYService stringEntry into a string and return a list of strings.
* Quite a bit of explanations on how the wrappers were written is in the example.i file. I have used typemaps extensively to do this.

CPython Wrappers:
* Firstly, one needs to be aware of Python C modules to write wrappers using CPython.
* The example_cpython.c file has extensive comments.
* Also note that I have not implemented all the methods using CPython and only fill_service_array method has been implemented. This is because I thought I'd demostrate the CPython wrapper with the most complex function of all.

Conclusion::
* Much misery was endured to figure all this out! Hope you, the reader, have an easier time...

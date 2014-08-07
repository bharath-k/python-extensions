#!/usr/bin/env python

"""
 * Author: Bharath Kumaran
 * Licensing: GNU General Public License (http://www.gnu.org/copyleft/gpl.html)
 * Description: setup.py file for SWIG example.
"""

from distutils.core import setup, Extension

# Build and install CPython Extension

example_cpython_module = Extension('_example_cpython',
                           sources=['example_cpython.c', 'example.c'],
                           )

setup (name = 'example_cpython',
       version = '0.1',
       author      = "Bharath Kumaran",
       description = """Simple CPython extension""",
       ext_modules = [example_cpython_module],
       )


# Build and install Swig extension for example.c - 1

example_swig1_module = Extension('_example_swig1',
                           sources=['example_swig1_wrap.c', 'example.c'],
                           )

setup (name = 'example_swig1',
       version = '0.1',
       author      = "Bharath Kumaran",
       description = """swig example 1 - Traditional SWIG Model""",
       ext_modules = [example_swig1_module],
       py_modules = ["example_swig1"],
       )

# Build and install Swig extension for example.c - 2

example_swig2_module = Extension('_example_swig2',
                           sources=['example_swig2_wrap.c', 'example.c'],
                           )

setup (name = 'example_swig2',
       version = '0.1',
       author      = "Bharath Kumaran",
       description = """Simple swig example 2 - A bit more complicated""",
       ext_modules = [example_swig2_module],
       py_modules = ["example_swig2"],
       )

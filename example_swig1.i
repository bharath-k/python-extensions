from __future__ import (print_function, division, absolute_import,
                        with_statement)

print("-------------------TESTING _example_cpython------------------------")

import _example_cpython

print("_example_cpython.fillup_service_array(0)")
print("Output:", _example_cpython.fillup_service_array(0))

try:
    print("_example_cpython.fillup_service_array(1111)")
    _example_cpython.fillup_service_array(1111)
except Exception as e:
    print("Exception:", e)


print("\n-------------------TESTING example_swig1------------------------")

import example_swig1

print("Calling: example_swig1.get_service()")
print("Output:", example_swig1.get_service())

print("Calling: example_swig1.get_service_array()")
print("Output:", example_swig1.get_service_array())

print("Calling: example_swig1.fillup_service(0)")
print("Output:", example_swig1.fillup_service(0))
print("Calling: example_swig1.fillup_service_array(0)")
print("Output:", example_swig1.fillup_service_array(0))

try:
    print("Calling: example_swig1.fillup_service(23)")
    example_swig1.fillup_service(23)
except Exception as r:
    print("Exception:", r)

try:
    print("Calling: example_swig1.fillup_service(23)")
    example_swig1.fillup_service(23)
except Exception as r:
    print("Exception:", r)


print("\n-------------------TESTING example_swig2------------------------")

import example_swig2

print("Calling: example_swig2.get_service()")
print("Output:", example_swig2.get_service())

print("Calling: example_swig2.get_service_array()")
print("Output:", example_swig2.get_service_array())

print("Calling: example_swig2.fillup_service(0)")
print("Output:", example_swig2.fillup_service(0))
print("Calling: example_swig2.fillup_service_array(0)")
print("Output:", example_swig2.fillup_service_array(0))

try:
    print("Calling: example_swig2.fillup_service(23)")
    example_swig2.fillup_service(23)
except RuntimeError as r:
    print("Exception:", r)

try:
    print("Calling: example_swig2.fillup_service(23)")
    example_swig2.fillup_service(23)
except RuntimeError as r:
    print("Exception:", r)


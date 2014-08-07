#
# Author: Bharath Kumaran
# Licensing: GNU General Public License (http://www.gnu.org/copyleft/gpl.html)
# Description: Makefile for Project
#

EXTRACFLAGS=
EXTRALDFLAGS=
SVCLIB=-lsvc
INCDIR=-I/usr/include -I.
LIBDIR=/usr/lib64
LIBS=-L$(LIBDIR) $(SVCLIB) $(EXTRALDFLAGS)
OPTFLAGS=-g
CFLAGS=$(OPTFLAGS) $(INCDIR) $(EXTRACFLAGS)
CC=gcc
all: example.o
	$(CC) --std=c99  -o example example.o $(LIBS)
example.o: example.c
	$(CC) $(INCDIR) -g -O -c example.c
clean:
	/bin/rm -Rf $(PROGS) *.o *.so *.out *.pyc example core example_swig1_wrap.c example_swig2_wrap.c example_swig1.py example_swig2.py build
dos2unix:
	/usr/bin/dos2unix *.c *.h Makefile
build-and-install-extensions:
	swig -I. -python example_swig1.i
	swig -I. -python example_swig2.i
	python setup.py build
	sudo python setup.py install

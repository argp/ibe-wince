# NTRG IBE WINCE -- Makefile
# Patroklos Argyroudis <argp at domain cs.tcd.ie>
#
# Makefile for compilation of the Stanford IBE library on WinCE.
#
# $Id: Makefile,v 1.3 2006/02/13 21:56:37 argp Exp $

CC = clarm
LD = link
EVC = "C:\Program Files\Microsoft eMbedded Tools\EVC"
WCEROOT = "C:\Windows CE Tools"
PLATFORM = "MS Pocket PC"
TARGETCPU = arm
OSVERSION = WCE300
CEVERSION = 300
CESUBSYS = WINDOWSCE
MACHINE = /machine:$(TARGETCPU)
CEPATH = $(EVC)\$(OSVERSION)\BIN
PATH = $(CEPATH);$(PATH)
LIB = $(WCEROOT)/$(OSVERSION)/$(PLATFORM)/lib/$(TARGETCPU)
INCLUDE = -I$(WCEROOT)/$(OSVERSION)/$(PLATFORM)/include -I"." \
    -I"C:\wceopenssl\include" -I"C:\wcegmp\include" -I"C:\wcecompat\include"
CFLAGS = -nologo -D_NTRG_WINCE_ -D_ARM_ -DARM \
	    -D_arm_ -DPOCKET_SIZE -DPALM_SIZE -D_WINCE \
	    -D_WIN32_WCE=$(CEVERSION) -DUNDER_CE=$(CEVERSION) \
	    -DBUILD_CELIB=1 -DFLOATING_POINT -DSTDC_HEADERS
LFLAGS = -libpath:$(WCEROOT)/$(OSVERSION)/$(PLATFORM)/lib/arm \
	    -libpath:"C:\wcegmp\lib" -libpath:"C:\wceopenssl\lib"
LIBS = commctrl.lib coredll.lib ibe.lib gmp.lib libeay32.lib
ENTRY = -entry:mainACRTStartup
LIBCMD = lib $(MACHINE) /nologo

SRCS =	byte_string.c \
	crypto.c \
	curve.c \
	format.c \
	fp2.c \
	ibe_lib.c
		
OBJS = $(SRCS:.c=.obj)

IBE_LIB = ibe.lib

.c.obj:
	$(CC) -c $(CFLAGS) $(INCLUDE) -Fo$@ $<

all:	$(IBE_LIB) ibetest

$(IBE_LIB):	$(OBJS)
		$(LIBCMD) /OUT:$(IBE_LIB) $(OBJS)

ibetest.obj:	ibetest.c
		$(CC) -c $(CFLAGS) $(INCLUDE) ibetest.c

ibetest:    ibetest.obj
	    $(LD) -subsystem:$(CESUBSYS) $(MACHINE) $(ENTRY) $(LFLAGS) \
	    -out:ibetest.exe ibetest.obj $(LIBS)

clean:
	del *.obj
	del ibetest.exe
	del $(IBE_LIB)

# EOF

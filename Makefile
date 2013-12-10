<<<<<<< HEAD
# handin info
TEAM=`whoami`
VERSION=`date +%Y%m%d%H%M%S`
PROJ=ext2cat

DELIVERY=ext2cat.c lib/ext2_access.c
ARCHIVE=${TEAM}-${VERSION}-${PROJ}.tar.gz
OS=$(shell uname -s)
ARCH=$(shell uname -m)
REFBLOB=reference-${OS}-${ARCH}.o

CC=gcc
CCOPTS=-g -std=c99 -Wall -Wextra -Werror -Wno-unused-parameter -Wno-unused-variable -I include
LIBDIR=lib
OBJDIR=obj


all: ext2cat

handin: clean
	tar -cvzf ${ARCHIVE} ${DELIVERY}

test-reg: handin
	HANDIN=`pwd`/${ARCHIVE}; cd testsuite; ./run_testcase.sh $${HANDIN}; rm -f $${HANDIN}

# Build the final binary against your code with the reference blob.
ext2cat: ext2_access mmapfs ext2cat.c
	${CC} ${CCOPTS} -o ext2cat ext2cat.c ${OBJDIR}/mmapfs.o ${OBJDIR}/ext2_access.o ${REFBLOB}

# Build the final binary against your code without the reference blob.
ext2cat_sans_ref: ext2_access mmapfs ext2cat.c
	${CC} ${CCOPTS} -o ext2cat ext2cat.c ${OBJDIR}/mmapfs.o ${OBJDIR}/ext2_access.o

# Build the final binary against the reference blob.
ext2cat_ref: ext2_access_ref mmapfs ext2cat.c
	${CC} ${CCOPTS} -o ext2cat_ref ext2cat.c ${OBJDIR}/mmapfs.o ${OBJDIR}/ext2_access_ref.o ${REFBLOB}



# Intermediate targets.
objdir:
	@mkdir ${OBJDIR} 2>/dev/null || true

# Build reusable .o files.
mmapfs: objdir ${LIBDIR}/mmapfs.c
	${CC} ${CCOPTS} -c -o ${OBJDIR}/mmapfs.o ${LIBDIR}/mmapfs.c

ext2_access: objdir ${LIBDIR}/ext2_access.c
	${CC} ${CCOPTS} -c -o ${OBJDIR}/ext2_access.o ${LIBDIR}/ext2_access.c

ext2_access_ref: objdir ${LIBDIR}/ext2_access_ref.c
	${CC} ${CCOPTS} -c -o ${OBJDIR}/ext2_access_ref.o ${LIBDIR}/ext2_access_ref.c

refblob: reflib/reference_implementation.c
	${CC} ${CCOPTS} -c -o ${REFBLOB} reflib/reference_implementation.c

clean:
	@rm -f ext2cat ext2cat_ref ${OBJDIR}/* *.gch */*.gch

=======
###############################################################################
#
# File:         Makefile
# RCS:          $Id: Makefile,v 1.1 2009/10/09 04:38:08 npb853 Exp $
# Description:  Guess
# Author:       Fabian E. Bustamante
#               Northwestern Systems Research Group
#               Department of Computer Science
#               Northwestern University
# Created:      Fri Sep 12, 2003 at 15:56:30
# Modified:     Wed Sep 24, 2003 at 18:31:43 fabianb@cs.northwestern.edu
# Language:     Makefile
# Package:      N/A
# Status:       Experimental (Do Not Distribute)
#
# (C) Copyright 2003, Northwestern University, all rights reserved.
#
###############################################################################

# handin info
TEAM = `whoami`
VERSION = `date +%Y%m%d%H%M%S`
PROJ = http_server

CC = gcc
MV = mv
CP = cp
RM = rm
MKDIR = mkdir
TAR = tar cvf
COMPRESS = gzip
#CFLAGS = -g -Wall -D HAVE_CONFIG_H
CFLAGS = -g -Wall -O2 -D HAVE_CONFIG_H

DELIVERY = Makefile *.h *.c
PROGS = http_server
SRCS = http_server.c thread_pool.c util.c seats.c
OBJS = ${SRCS:.c=.o}

all: ${PROGS}

#test-reg: handin
#	HANDIN=`pwd`/${TEAM}-${VERSION}-${PROJ}.tar.gz;\
#	cd testsuite;\
#	bash ./run_testcase.sh $${HANDIN};

handin: cleanAll
	${TAR} ${TEAM}-${VERSION}-${PROJ}.tar ${DELIVERY}
	${COMPRESS} ${TEAM}-${VERSION}-${PROJ}.tar

.o:
	${CC} *.c  *.h

http_server: ${OBJS}
	${CC} ${OBJS} -o $@  -lpthread

clean:
	${RM} -f *.o *~ *.h.gch

cleanAll: clean
	${RM} -f ${PROGS} ${TEAM}-${VERSION}-${PROJ}.tar.gz
>>>>>>> d1bb4a3b9c21ba92d59cd6a7a0c59846011a91da

KVER	:=$(shell uname -r)
KARCH	:=$(shell arch)
KNAME	:=$(shell echo "${KVER}.${KARCH}")

REL	=el5

URL	=http://oss.oracle.com/${REL}/debuginfo

all::	kernel-debuginfo-${KNAME}.rpm kernel-debuginfo-common-${KNAME}.rpm

clean::
	${RM} *.rpm

distclean clobber:: clean

kernel-debuginfo-${KNAME}.rpm::
	wget -c ${URL}/kernel-debuginfo-${KNAME}.rpm

kernel-debuginfo-common-${KNAME}.rpm::
	wget -c ${URL}/kernel-debuginfo-common-${KNAME}.rpm

install:: kernel-debuginfo-${KNAME}.rpm kernel-debuginfo-common-${KNAME}.rpm
	sudo rpm -Uvh kernel-debuginfo-${KNAME}.rpm kernel-debuginfo-common-${KNAME}.rpm

uninstall:: 
	sudo rpm -e kernel-debuginfo-${KNAME}.rpm kernel-debuginfo-common-${KNAME}.rpm

vars::
	echo "KVER=${KVER}"
	echo "KNAME=${KNAME}"

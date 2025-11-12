#!/bin/bash -x
########################################################################
#   $Name: ORG-TEST $, $Id: makeMe.bash,v 1.1 2002/09/16 18:36:38 leed Exp $
########################################################################
## Copyright (C) 2002 Affero, Inc.

## This file is part of The Affero Project.

## The Affero Project is free software# you can redistribute it and/or
## modify it under the terms of the Affero General Public License as
## published by Affero, Inc.# either version 1 of the License, or
## (at your option) any later version.

## The Affero Project is distributed in the hope that it will be
## useful,but WITHOUT ANY WARRANTY# without even the implied warranty
## of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## Affero General Public License for more details.

## You should have received a copy of the Affero General Public
## License in the COPYING file that comes with The Affero Project# if
## not, write to Affero, Inc., 510 Third Street, Suite 225, San
## Francisco, CA 94107 USA.
########################################################################

########################################################################
##  C A U T I O N    C A U T I O N    C A U T I O N    C A U T I O N  ##
########################################################################
#  this script is written only to run in the context of an RPM bulid. ##
#  it is  _not_ intended for general use!!							  ##
########################################################################
##			 build a tarball for the web services code                ##
#																	   #
	BUILDROOT=`pwd`
	echo "\$BUILDROOT is $BUILDROOT"
	echo "--------------------------------------------------------------"

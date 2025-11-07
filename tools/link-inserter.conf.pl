#   $Name: ORG-TEST $, $Id: link-inserter.conf.pl,v 1.6 2002/05/15 17:33:02 leed Exp $
##------------------+---------------------------------------------------
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
##----------------------------------------------------------------------
# You may want to edit the variables below :
{
    url                        => "http://svcs.affero.net/rm.php",
    message                    => "How valuable was this message? rate it at",

    #  these can be overridden on the command line
    urlEscapeCharSet           => "^A-Za-z0-9",
};


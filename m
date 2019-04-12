From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Fri, 12 Apr 2019 12:59:57 +0100
Subject: [cip-dev] isar error log
In-Reply-To: <20190412133736.5f3b257f@md1za8fc.ad001.siemens.net>
References: <OSAPR01MB3763A7998474AB7ABEB3DDF3D0560@OSAPR01MB3763.jpnprd01.prod.outlook.com>
	<0c1b977d-cd7e-34aa-8d7e-1569b313f75d@siemens.com>
	<OSAPR01MB37634FC9265275C1F909D27AD0570@OSAPR01MB3763.jpnprd01.prod.outlook.com>
	<043f0dda-7df0-36d1-c9ae-d9d08d3298d5@siemens.com>
	<OSAPR01MB37639D8B6560398B6DE5834ED02F0@OSAPR01MB3763.jpnprd01.prod.outlook.com>
	<2c3a7bd1-facf-87f2-ec20-2936c893584a@siemens.com>
	<OSAPR01MB3763518BD0621EA0A7BA5A0DD02F0@OSAPR01MB3763.jpnprd01.prod.outlook.com>
	<OSAPR01MB3763355E6AAF5A37347B24ACD02F0@OSAPR01MB3763.jpnprd01.prod.outlook.com>
	<74cc4dec-f603-4746-077d-4aae2e20a095@siemens.com>
	<20190412133736.5f3b257f@md1za8fc.ad001.siemens.net>
Message-ID: <1555070397.3557.19.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Fri, 2019-04-12 at 13:37 +0200, Henning Schild wrote:
[...]
> Just had a look at a ubuntu 16.04. It does support the fs but it is
> not mounted. So a pseudo-code patch for the docker entry could be:
> 
> if not mounted
> ?if grep binfmt_misc /proc/filesystems
> ? mount
> ?else
> ? echo "Get a real and recent distro"
> ?fi
> fi

Actual code should be something like:

if ! mountpoint -q /proc/sys/fs/binfmt_misc \
   && ! mount -t binfmt_misc binfmt_misc /proc/sys/fs/binfmt_misc; then
    echo >&2 "E: Unable to mount binfmt_misc"
    exit 1
fi

Ben.

-- 
Ben Hutchings, Software Developer                ?        Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom

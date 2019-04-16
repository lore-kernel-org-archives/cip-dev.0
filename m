From: daniel.sangorrin@toshiba.co.jp (daniel.sangorrin at toshiba.co.jp)
Date: Tue, 16 Apr 2019 02:47:03 +0000
Subject: [cip-dev] isar error log
In-Reply-To: <1555070397.3557.19.camel@codethink.co.uk>
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
	<1555070397.3557.19.camel@codethink.co.uk>
Message-ID: <OSAPR01MB37635280DF780D10C67B37EBD0240@OSAPR01MB3763.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Henning, Ben, Jan: thanks for your answers.

Actually, in my PC (Ubuntu 16.04.6) binfmt_misc is mounted, both outside and inside the container.
# Henning: not sure why yours wasn't but it could be because I have also qemu-user-static installed on the host OS or because of something I installed in the past.

I tried to dig a bit deeper.

- The error:
update-binfmts: warning: unable to close /proc/sys/fs/binfmt_misc/register: Invalid argument
- This error appears when /kas/docker-entrypoint calls "dpkg-configure qemu-user-static"
- I added a set -x to qemu-user-static's postinstall script (/var/lib/dpkg/info/qemu-user-static.postinst) and the error comes from this line:
update-binfmts --package qemu-user-static --install qemu-aarch64 ... --credential yes --fix-binary yes
- I tried to run update-binfmts (with the same arguments) and I could reproduce the problem
- If I remove the "--fix-binary yes" part and execute it twice, then the first time fails with the same error but the second time it succeeds
- I straced update-binfmts with --fix-binary yes
  - it opens /proc/sys/fs/binfmt_misc/register
  - writes :qemu-aarch64:M:0:x7fx45x4cx46x0"
  - returns EINVAL

And then I found the real reason of the problem:
- The qemu-user-static on the host side was conflicting with the one inside docker.
- If I remove qemu-user-static from the host then, it works.

Thanks,
Daniel

> -----Original Message-----
> From: cip-dev-bounces at lists.cip-project.org <cip-dev-bounces@lists.cip-
> project.org> On Behalf Of Ben Hutchings
> Sent: Friday, April 12, 2019 9:00 PM
> To: Henning Schild <henning.schild@siemens.com>; [ext] Jan Kiszka
> <jan.kiszka@siemens.com>
> Cc: kas-devel at googlegroups.com; isar-users at googlegroups.com; cip-
> dev at lists.cip-project.org
> Subject: Re: [cip-dev] isar error log
> 
> On Fri, 2019-04-12 at 13:37 +0200, Henning Schild wrote:
> [...]
> > Just had a look at a ubuntu 16.04. It does support the fs but it is
> > not mounted. So a pseudo-code patch for the docker entry could be:
> >
> > if not mounted
> > ?if grep binfmt_misc /proc/filesystems
> > ? mount
> > ?else
> > ? echo "Get a real and recent distro"
> > ?fi
> > fi
> 
> Actual code should be something like:
> 
> if ! mountpoint -q /proc/sys/fs/binfmt_misc \
>    && ! mount -t binfmt_misc binfmt_misc /proc/sys/fs/binfmt_misc; then
>     echo >&2 "E: Unable to mount binfmt_misc"
>     exit 1
> fi
> 
> Ben.
> 
> --
> Ben Hutchings, Software Developer                ?        Codethink Ltd
> https://www.codethink.co.uk/                 Dale House, 35 Dale Street
>                                      Manchester, M1 2HF, United Kingdom
> _______________________________________________
> cip-dev mailing list
> cip-dev at lists.cip-project.org
> https://lists.cip-project.org/mailman/listinfo/cip-dev

From: henning.schild@siemens.com (Henning Schild)
Date: Fri, 12 Apr 2019 13:37:36 +0200
Subject: [cip-dev] isar error log
In-Reply-To: <74cc4dec-f603-4746-077d-4aae2e20a095@siemens.com>
References: <OSAPR01MB3763A7998474AB7ABEB3DDF3D0560@OSAPR01MB3763.jpnprd01.prod.outlook.com>
	<0c1b977d-cd7e-34aa-8d7e-1569b313f75d@siemens.com>
	<OSAPR01MB37634FC9265275C1F909D27AD0570@OSAPR01MB3763.jpnprd01.prod.outlook.com>
	<043f0dda-7df0-36d1-c9ae-d9d08d3298d5@siemens.com>
	<OSAPR01MB37639D8B6560398B6DE5834ED02F0@OSAPR01MB3763.jpnprd01.prod.outlook.com>
	<2c3a7bd1-facf-87f2-ec20-2936c893584a@siemens.com>
	<OSAPR01MB3763518BD0621EA0A7BA5A0DD02F0@OSAPR01MB3763.jpnprd01.prod.outlook.com>
	<OSAPR01MB3763355E6AAF5A37347B24ACD02F0@OSAPR01MB3763.jpnprd01.prod.outlook.com>
	<74cc4dec-f603-4746-077d-4aae2e20a095@siemens.com>
Message-ID: <20190412133736.5f3b257f@md1za8fc.ad001.siemens.net>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Am Thu, 11 Apr 2019 14:42:03 +0200
schrieb "[ext] Jan Kiszka" <jan.kiszka@siemens.com>:

> On 11.04.19 12:13, daniel.sangorrin at toshiba.co.jp wrote:
> >> -----Original Message-----
> >> From: cip-dev-bounces at lists.cip-project.org
> >> <cip-dev-bounces@lists.cip-project.org> On Behalf Of
> >> daniel.sangorrin at toshiba.co.jp Sent: Thursday, April 11, 2019 7:06
> >> PM To: jan.kiszka at siemens.com
> >> Cc: kas-devel at googlegroups.com; isar-users at googlegroups.com;
> >> cip-dev at lists.cip-project.org Subject: Re: [cip-dev] isar error log
> >>  
> >>> -----Original Message-----
> >>> From: Jan Kiszka <jan.kiszka@siemens.com>
> >>> Sent: Thursday, April 11, 2019 6:16 PM
> >>> To: sangorrin daniel(????? ???? ????????)
> >>> <daniel.sangorrin@toshiba.co.jp> Cc:
> >>> cip-dev at lists.cip-project.org; isar-users at googlegroups.com;
> >>> kas-devel at googlegroups.com Subject: Re: isar error log
> >>>
> >>> On 11.04.19 11:08, daniel.sangorrin at toshiba.co.jp wrote:  
> >>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
> >>>>> On 03.04.19 02:56, daniel.sangorrin at toshiba.co.jp wrote:  
> >>>>>> Hi Jan,
> >>>>>>
> >>>>>> Yes I am following the Readme.
> >>>>>>
> >>>>>> The docker image id for kasproject/kas-isar is 9e9fe44e68d3 (I
> >>>>>> am using kas-docker script). And I am  
> >> using  
> >>>>>
> >>>>> That's the same version I have, and it works for me.
> >>>>>  
> >>>>>> kas-docker --isar build kas.yml:board-qemu-amd64.yml
> >>>>>>
> >>>>>> Yes, it seems there are multiple errors:
> >>>>>> /proc/sys/fs/binfmt_misc/register: Invalid argument
> >>>>>> /test-dev-null: Permission denied
> >>>>>>
> >>>>>> Probably this is a bug or misconfiguration in Ubuntu. I will
> >>>>>> try to figure it out. 
> >>>>>
> >>>>> Adding kas-devel: Would be interesting to understand this so
> >>>>> that we can fix it or at least document a workaround. Maybe you
> >>>>> need to be in some privileged group in order to use privileged
> >>>>> docker containers? That's how things work on SUSE.
> >>>>>
> >>>>> No one around is using Ubuntu, so that distro is likely a blind
> >>>>> spot for our testing.  
> >>>>
> >>>> OK, so I figured out that Ubuntu 16.04 was using the service
> >>>> "binfmt-support", not "systemd-binfmt". For that reason, the
> >>>> "systemd-binfmt" service was inactive. However, "binfmt-support"
> >>>> is working fine. I also checked that the post-install script of
> >>>> the qemu-user-static package had run correctly and there were
> >>>> binfmt configuration files at /var/lib/binfmts/  
> >>>
> >>> But what prevented the container to tune the host kernel
> >>> according to its needs? That is the intended resolution for the
> >>> host not having the same settings as the container (or any at
> >>> all).  
> >>
> >> To be honest I don't really know what binfmt is all about yet, so
> >> I can't even understand what you mean about "tuning the kernel".  
> 
> https://www.kernel.org/doc/html/latest/admin-guide/binfmt-misc.html
> 
> >>
> >> By the way, I managed to update to the latest Ubuntu 4.4 kernel
> >> (145) and the problem persists. I tried to reinstall
> >> qemu-user-static etc but still fails humm .
> >> Also i just tested on Ubuntu 18.04 and there I can build with ISAR
> >> without problems. So I might just leave it unsolved and update to
> >> 18.04...  
> > 
> > This might be a hint.
> > On Ubuntu 18.04 I can see "qemu-alpha" on /proc/sys/fs/binfmt_misc,
> > but on Ubuntu 16.04 it isn't there. When running kas-docker, the
> > first error is about not being able to
> > close /proc/sys/fs/binfmt_misc/register (invalid argument) and the
> > second is about qemu-alpha. 
> 
> Maybe /proc/sys/fs/binfmt_misc is not mounted into the container
> under Ubuntu 16.04, even if that is privileged.

Just had a look at a ubuntu 16.04. It does support the fs but it is
not mounted. So a pseudo-code patch for the docker entry could be:

if not mounted
 if grep binfmt_misc /proc/filesystems
  mount
 else
  echo "Get a real and recent distro"
 fi
fi

Henning

> Jan
> 

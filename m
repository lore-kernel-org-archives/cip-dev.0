From: daniel.sangorrin@toshiba.co.jp (daniel.sangorrin at toshiba.co.jp)
Date: Fri, 5 Apr 2019 07:44:23 +0000
Subject: [cip-dev] isar error log
In-Reply-To: <1554299591.3557.13.camel@codethink.co.uk>
References: <OSAPR01MB3763A7998474AB7ABEB3DDF3D0560@OSAPR01MB3763.jpnprd01.prod.outlook.com>
	<0c1b977d-cd7e-34aa-8d7e-1569b313f75d@siemens.com>
	<OSAPR01MB37634FC9265275C1F909D27AD0570@OSAPR01MB3763.jpnprd01.prod.outlook.com>
	<1554299591.3557.13.camel@codethink.co.uk>
Message-ID: <OSAPR01MB3763BA10966BA62B172B335ED0510@OSAPR01MB3763.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

> -----Original Message-----
> From: Ben Hutchings <ben.hutchings@codethink.co.uk>
> Sent: Wednesday, April 3, 2019 10:53 PM
> To: sangorrin daniel(????? ???? ????????)
> <daniel.sangorrin@toshiba.co.jp>; jan.kiszka at siemens.com
> Cc: isar-users at googlegroups.com; cip-dev at lists.cip-project.org
> Subject: Re: [cip-dev] isar error log
> 
> On Wed, 2019-04-03 at 00:56 +0000, daniel.sangorrin at toshiba.co.jp wrote:
> > Hi Jan,
> >
> > Yes I am following the Readme.
> >
> > The docker image id for kasproject/kas-isar is 9e9fe44e68d3 (I am
> > using kas-docker script). And I am using kas-docker --isar build
> > kas.yml:board-qemu-amd64.yml
> >
> > Yes, it seems there are multiple errors:
> > /proc/sys/fs/binfmt_misc/register: Invalid argument
> > /test-dev-null: Permission denied
> >
> > Probably this is a bug or misconfiguration in Ubuntu. I will try to figure it
> out.
> 
> Might this be restricted by an AppArmor profile?  aa-logprof should show
> you AppArmor denials and change the relevant profile(s) to allow the
> operations.

Thanks for the advice Ben.
I checked with aa-logprof but there was nothing related.
# interestingly, for some reason AppArmor was restricting some functionality in Evince

Then, I tried to update the kernel to a new version (i was using about 4.4.0-84 and the latest was around 4.4.0-145) to see if something improved but I found that the new kernel wouldn't boot properly because my disk is encrypted. So I have possibly found a regression on the 4.4 kernel, I will have to check when I get back to my desk. And there is a possibility that the reason for my problem is in the binfmt kernel module.

Thanks,
Daniel

> 
> Ben.
> 
> --
> Ben Hutchings, Software Developer                ?        Codethink Ltd
> https://www.codethink.co.uk/                 Dale House, 35 Dale Street
>                                      Manchester, M1 2HF, United Kingdom

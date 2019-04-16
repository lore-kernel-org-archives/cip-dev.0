From: kazuhiro3.hayashi@toshiba.co.jp (kazuhiro3.hayashi at toshiba.co.jp)
Date: Tue, 16 Apr 2019 09:20:25 +0000
Subject: [cip-dev] Supported kernel and Debian versions in Isar
In-Reply-To: <1555069176.3557.17.camel@codethink.co.uk>
References: <OSBPR01MB27743E33CB9ED2B9B5885577E12F0@OSBPR01MB2774.jpnprd01.prod.outlook.com>
	<1555069176.3557.17.camel@codethink.co.uk>
Message-ID: <OSBPR01MB2774C79EAAB5C34D2B392699E1240@OSBPR01MB2774.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Ben,

> -----Original Message-----
> From: Ben Hutchings [mailto:ben.hutchings at codethink.co.uk]
> Sent: Friday, April 12, 2019 8:40 PM
> To: hayashi kazuhiro(? ?? ????????) <kazuhiro3.hayashi@toshiba.co.jp>; jan.kiszka at siemens.com
> Cc: cip-dev at lists.cip-project.org
> Subject: Re: [cip-dev] Supported kernel and Debian versions in Isar
> 
> On Thu, 2019-04-11 at 08:33 +0000, kazuhiro3.hayashi at toshiba.co.jp wrote:
> [...]
> > Do you any plans to provide the kernel recipes for all CIP versions (4.4, 4.19, ...) in master branch
> > and validate them with all Debian versions?
> > I guess that the supported combinations would be limited to practical ones.
> > For examples:
> > 	4.4 + stretch => SUPPORTED
> > 	4.4 + buster => NOT SUPPORTED
> > 	4.4 + bullseye => NOT SUPPORTED
> 
> That makes sense to me.

Thank you for your opinion, I got it.

> 
> > 	4.19 + stretch => SUPPORTED
> > 	4.19 + buster => NOT SUPPORTED
> 
> That should be supported as Debian's official kernel packages for
> buster are based on 4.19.

Sorry, the above line (4.19 + buster => NOT SUPPORTED) is just my mistake
and It was originally intended: 4.19 + buster => SUPPORTED
https://lists.cip-project.org/pipermail/cip-dev/2019-April/002076.html

> 
> > 	4.19 + bullseye => SUPPORTED(?)
> [...]
> 
> That should be supportable - Debian generally tries to support partial
> upgrades including upgrading all of userland without the kernel, so
> bullseye userland should be compatible with 4.19.

Thank you for the information.
It would be better to consider providing this 'option' (4.19 + bullseye etc.) in CIP core as well
as long as the kernel version is supported in the previous Debian version.
(4.4 is not supported in Debian, so 4.4 + buster might not be supported)

I would like to summarize the list again:

	4.4 + stretch => SUPPORTED (necessary)
	4.4 + buster => NOT SUPPORTED
	4.4 + bullseye => NOT SUPPORTED
	4.19 + stretch => SUPPORTED (optional)
	4.19 + buster => SUPPORTED (necessary)
	4.19 + bullseye => SUPPORTED (optional: 4.19 should be compatible with bullseye userland)
	...

Kazu

> 
> Ben.
> 
> --
> Ben Hutchings, Software Developer                ?        Codethink Ltd
> https://www.codethink.co.uk/                 Dale House, 35 Dale Street
>                                      Manchester, M1 2HF, United Kingdom

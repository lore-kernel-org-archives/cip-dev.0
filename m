From: Dinesh.Kumar@TOSHIBA-TSIP.COM (Dinesh Kumar)
Date: Tue, 20 Aug 2019 09:48:46 +0000
Subject: [cip-dev] Testing CIP kernel with Debian gcc
In-Reply-To: <HK0PR01MB29797CA3964C6B930B4799F9E2AB0@HK0PR01MB2979.apcprd01.prod.exchangelabs.com>
References: <TYAPR01MB4286F48F657C60E5BBF5341DE1D70@TYAPR01MB4286.jpnprd01.prod.outlook.com>
	<TYAPR01MB228561299852241F36E8328BB7D70@TYAPR01MB2285.jpnprd01.prod.outlook.com>
	<5087d1355a38d5a1cb4c1e9e07bf64a0fddb625e.camel@codethink.co.uk>
	<CAFk6z8N0-9=LRfxVK5zgdsXC34om0W5-xzX4wbkDa59ZSK30yg@mail.gmail.com>
	<228e4b4a1f71bfa0e3b2869cc3b50d6b1c1c2fca.camel@codethink.co.uk>
	<HK0PR01MB29797CA3964C6B930B4799F9E2AB0@HK0PR01MB2979.apcprd01.prod.exchangelabs.com>
Message-ID: <80E94AEA6311AF498BB19C7192898B5D5B769CBB@TOSBLRMBX01.TOSHIBA-TSIP.COM>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi SZ,

>> We need some feedback from cip-security workgroup as well.

We will discuss this point in next security WG meeting (21/Aug) and will update here.

Thanks & Regards,
Dinesh Kumar

-----Original Message-----
From: cip-security-bounces@lists.cip-project.org [mailto:cip-security-bounces at lists.cip-project.org] On Behalf Of SZ Lin (???)
Sent: 20 August 2019 14:24
To: Ben Hutchings <ben.hutchings@codethink.co.uk>; cip-dev at lists.cip-project.org; cip-security at lists.cip-project.org
Cc: pavel at denx.de; Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Subject: Re: [Cip-security] [cip-dev] Testing CIP kernel with Debian gcc

Hi Ben,

> From: Ben Hutchings <ben.hutchings@codethink.co.uk> On Thu, 2019-08-15 
> at 10:50 +0800, SZ Lin (???) wrote:
> > Hi all,
> >
> > According to the discussion in IRC weekly meeting last week, do we 
> > want to add extra compiler options (e.g., security hardening) in CIP 
> > development? Or use origin setting from Debian package.
> >
> > I also attached Debian gcc 6.3 and 8.3 options below
> 
> So far as I could see, the only hardening option enabled there is PIE.
> That's good for user-space but can't be used in the kernel (currently).
> 
> > Any feedback is appreciated.
> 
> There is another source of default tool-chain options for *packages*, 
> which is dpkg-buildflags.  In buster that enables most hardening options by default.
> Most packages will set the tool-chain options using dpkg-buildflags 
> (dh does so automatically), but this would need to be checked for each 
> package.  And this doesn't help to harden unpackaged software that 
> members include in their systems.

AFAIK, the hardening options are not mandatory to packages [1][2]. That means we've to check each packages one by one...

[1] https://lintian.debian.org/tags/hardening-no-bindnow.html
[2] https://lintian.debian.org/reports/tags/hardening-no-relro.html

> 
> For the kernel, hardening options can require (arch-dependent) code to 
> support them because the kernel does not use the C library or even the 
> gcc runtime library.  So the kernel build system generally requires 
> them to be explicitly enabled in Kconfig, and will override them if 
> they're enabled in default compiler options but not Kconfig.

And the security options might make the impact to the scope of kernel maintenance.

> 
> So I think that changing the default tool-chain options may be worth 
> doing for user-space software, but the kernel will still need to be handled separately.

Thanks for your feedback.

We need some feedback from cip-security workgroup as well.

SZ

> 
> Ben.
> 
> --
> Ben Hutchings, Software Developer                         Codethink
> Ltd
> https://www.codethink.co.uk/                 Dale House, 35 Dale Street
>                                      Manchester, M1 2HF, United 
> Kingdom

_______________________________________________
Cip-security mailing list
Cip-security at lists.cip-project.org
https://lists.cip-project.org/mailman/listinfo/cip-security
The information contained in this e-mail message and in any
attachments/annexure/appendices is confidential to the 
recipient and may contain privileged information. 
If you are not the intended recipient, please notify the
sender and delete the message along with any 
attachments/annexure/appendices. You should not disclose,
copy or otherwise use the information contained in the
message or any annexure. Any views expressed in this e-mail 
are those of the individual sender except where the sender 
specifically states them to be the views of 
Toshiba Software India Pvt. Ltd. (TSIP),Bangalore.

Although this transmission and any attachments are believed to be
free of any virus or other defect that might affect any computer 
system into which it is received and opened, it is the responsibility
of the recipient to ensure that it is virus free and no responsibility 
is accepted by Toshiba Embedded Software India Pvt. Ltd, for any loss or
damage arising in any way from its use.

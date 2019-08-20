From: SZ.Lin@moxa.com (=?utf-8?B?U1ogTGluICjmnpfkuIrmmbop?=)
Date: Tue, 20 Aug 2019 08:53:53 +0000
Subject: [cip-dev] Testing CIP kernel with Debian gcc
In-Reply-To: <228e4b4a1f71bfa0e3b2869cc3b50d6b1c1c2fca.camel@codethink.co.uk>
References: <TYAPR01MB4286F48F657C60E5BBF5341DE1D70@TYAPR01MB4286.jpnprd01.prod.outlook.com>
	<TYAPR01MB228561299852241F36E8328BB7D70@TYAPR01MB2285.jpnprd01.prod.outlook.com>
	<5087d1355a38d5a1cb4c1e9e07bf64a0fddb625e.camel@codethink.co.uk>
	<CAFk6z8N0-9=LRfxVK5zgdsXC34om0W5-xzX4wbkDa59ZSK30yg@mail.gmail.com>
	<228e4b4a1f71bfa0e3b2869cc3b50d6b1c1c2fca.camel@codethink.co.uk>
Message-ID: <HK0PR01MB29797CA3964C6B930B4799F9E2AB0@HK0PR01MB2979.apcprd01.prod.exchangelabs.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Ben,

> From: Ben Hutchings <ben.hutchings@codethink.co.uk> 
> On Thu, 2019-08-15 at 10:50 +0800, SZ Lin (???) wrote:
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
> There is another source of default tool-chain options for *packages*, which is
> dpkg-buildflags.  In buster that enables most hardening options by default.
> Most packages will set the tool-chain options using dpkg-buildflags (dh does so
> automatically), but this would need to be checked for each package.  And this
> doesn't help to harden unpackaged software that members include in their
> systems.

AFAIK, the hardening options are not mandatory to packages [1][2]. That means we've to
check each packages one by one...

[1] https://lintian.debian.org/tags/hardening-no-bindnow.html
[2] https://lintian.debian.org/reports/tags/hardening-no-relro.html

> 
> For the kernel, hardening options can require (arch-dependent) code to support
> them because the kernel does not use the C library or even the gcc runtime
> library.  So the kernel build system generally requires them to be explicitly
> enabled in Kconfig, and will override them if they're enabled in default
> compiler options but not Kconfig.

And the security options might make the impact to the scope of kernel maintenance.

> 
> So I think that changing the default tool-chain options may be worth doing for
> user-space software, but the kernel will still need to be handled separately.

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

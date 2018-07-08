From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Sun, 08 Jul 2018 20:01:52 +0100
Subject: [cip-dev] [PATCH 62/86] ARM: dts: r8a7745: Add operating-points
 to cpu0
In-Reply-To: <TY1PR01MB177068FF298F3D3A8BF0BE69C0470@TY1PR01MB1770.jpnprd01.prod.outlook.com>
References: <1530283167-14050-1-git-send-email-fabrizio.castro@bp.renesas.com>
	<1530283167-14050-63-git-send-email-fabrizio.castro@bp.renesas.com>
	<1530827145.21552.2.camel@codethink.co.uk>
	<TY1PR01MB177068FF298F3D3A8BF0BE69C0470@TY1PR01MB1770.jpnprd01.prod.outlook.com>
Message-ID: <1531076512.21552.3.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Fri, 2018-07-06 at 10:00 +0000, Fabrizio Castro wrote:
> Hello Ben,
> 
> Thank you for your feedback.
> 
> > Subject: Re: [cip-dev][PATCH 62/86] ARM: dts: r8a7745: Add
> > operating-points to cpu0
> > 
> > On Fri, 2018-06-29 at 15:39 +0100, Fabrizio Castro wrote:
> > > shmobile_defconfig builds cpu freq into the kernel by default,
> > > therefore we get error and warning messages at boot, when
> > > hotplugging cpus, and when waking up from suspend to RAM.
> > > 
> > > Although the r8a7745 SoC does not support DVFS, defining one
> > > operating point makes cpu freq happy and therefore all of the
> > > nasty messages disappear.
> > 
> > Why was this not needed upstream?
> 
> Since there is a chance for the OPP to be registered dynamically the
> upstream kernel won't print error messages (only debug messages), as
> opposed to the CIP kernel which will print error messages. Have a
> look at 5b60697cd89cf5a438b2984e11859228e5ec1c6b.
[...]

Then I will cherry-pick that commit instead.

Ben.

-- 
Ben Hutchings, Software Developer                ?        Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom

From: Chris.Paterson2@renesas.com (Chris Paterson)
Date: Tue, 30 Jul 2019 14:41:16 +0000
Subject: [cip-dev] powerpc build with Kernel v4.4
In-Reply-To: <CAEss1EKhTYkeABwBCiapFipKg0ogGAArsLm=Edbunaq-8emiwg@mail.gmail.com>
References: <TYAPR01MB2285895BCD78ABB88C823A5DB7C30@TYAPR01MB2285.jpnprd01.prod.outlook.com>
	<20190728074044.GA19089@amd> <20190728084920.GA21045@amd>
	<TYAPR01MB2285D2A833FCC5D7E0DF8A3CB7DC0@TYAPR01MB2285.jpnprd01.prod.outlook.com>
	<CAEss1EKhTYkeABwBCiapFipKg0ogGAArsLm=Edbunaq-8emiwg@mail.gmail.com>
Message-ID: <OSBPR01MB22809B7C7686373537F62268B7DC0@OSBPR01MB2280.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

> From: Zoran S <zoran.stojsavljevic.de@gmail.com>
> Sent: 30 July 2019 15:30
> 
> > > Interesting line...WTH is wrong with the line 123
> > > (CONFIG_SPI_DEBUG=y)?
> >
> > Well spotted. This issue isn't with the actual config, rather
> > than with my script. It's not handling very well the fact that...
> 
> After I sent the email I have spotted the same: that actually it is
> line 123 in your script: /opt/build_kernel.sh: line 123
> 
> > there are two configs > called "toshiba_defconfig" for v4.4
> > in the cip-kernel-config repository. (One for x86 and one
> > for powerpc).
> 
> There should exist two different paths for the same names:
> [1] For x86: ~/git-repos/linux-cip/arch/x86
> [2] For powerpc: ~/git-repos/linux-cip/arch/powerpc
> 
> The both names are safely there (to 1 and 2 respectively), but the
> script should pick up the correct one toshiba_defconfig, my best guess
> is!

Yep. But only because powerpc is before x86 in alphabetical order.

I've logged [1] and fixed this now [2].

See [3] for a fully built powerpc config (with CONFIG_PPC_DISABLE_WERROR=y set).

[1] https://gitlab.com/cip-playground/linux-cip-ci/issues/1
[2] https://gitlab.com/cip-playground/linux-cip-ci/commit/edea7a9f5f575a0418312a66407f7d584d4946f6
[3] https://gitlab.com/cip-project/cip-kernel/linux-cip/-/jobs/262311713

> 
> > I'll update my script.
> 
> If not a secret, could you, please, also make available to us your
> entire script: /opt/build_kernel.sh @
> https://gitlab.com/cip-project/cip-kernel/linux-cip/ w h a t e v e r ?

The containers and scripts used for CIP CI are currently stored in the cip-playground project [4]. Hopefully they will move to the official cip-project repository soon.

[4] https://gitlab.com/cip-playground/linux-cip-ci/

Kind regards, Chris

> 
> Thank you,
> Zoran
> _______
> 
> On Tue, Jul 30, 2019 at 3:08 PM Chris Paterson
> <Chris.Paterson2@renesas.com> wrote:
> >
> > > From: Pavel Machek <pavel@denx.de>
> > > Sent: 28 July 2019 09:49
> > >
> > > *** gpg4o | The signature of this email could not be verified because the
> > > following public key is missing. Click here to search and import the key
> > > 30E7F06A95DBFAF2 ***
> > >
> > > Hi!
> > >
> > > > > I'm trying to build the toshiba_defconfig [1] for the powerpc
> architecture
> > > using the CIP v4.4 Kernel but I'm hitting some problems. The log from the
> > > build can be seen on GitLab [2].
> > > > >
> > > > > Has anyone tried building this configuration recently?
> > > > >
> > > > > I'm using gcc compiler v8.1.0. I mention this because I've see a half-
> > > related discussion [3] when Googling. From this mail thread I wonder if
> there
> > > are some patches we need to backport?
> > > > >
> > > >
> > > > Is there chance to use different gcc? Because this looks like gcc
> > > > bug... but workaround seems simple enough. Let me investigate some
> > > > more.
> > >
> > > Workaround seems simple, but won't easily apply on top of 4.4 kernel
> > That?s a shame.
> >
> > >
> > > Can you simply set
> > >
> > > CONFIG_PPC_DISABLE_WERROR=y
> > >
> > > to make the problem go away?
> >
> > I could, but even if it works it?s Toshiba?s config and perhaps they had a
> reason to enable this option.
> >
> > Daniel, Kobayashi-san, any comments?
> >
> > Kind regards, Chris
> >
> >
> > >
> > > Best regards,
> > >
> > >                                                               Pavel
> > > --
> > > DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> > > HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> >
> > _______________________________________________
> > cip-dev mailing list
> > cip-dev at lists.cip-project.org
> > https://lists.cip-project.org/mailman/listinfo/cip-dev

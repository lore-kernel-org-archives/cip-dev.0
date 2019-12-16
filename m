From: Chris.Paterson2@renesas.com (Chris Paterson)
Date: Mon, 16 Dec 2019 11:27:19 +0000
Subject: [cip-dev] gitlab mirroring broken was Re: [ANNOUNCE] Release
 v4.19.88-cip16 and v4.4.206-cip40
In-Reply-To: <20191216111437.GA14724@amd>
References: <OSAPR01MB323483390F138C52C363126492540@OSAPR01MB3234.jpnprd01.prod.outlook.com>
 <20191216111437.GA14724@amd>
Message-ID: <TYAPR01MB228551777781997812CD5618B7510@TYAPR01MB2285.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Pavel,

> From: Pavel Machek <pavel@denx.de>
> Sent: 16 December 2019 11:15
>
> Hi!
>
> > CIP kernel team has released Linux kernel v4.19.88-cip16 and v4.4.206-cip40.
> > The linux-4.19.y-cip tree has been updated base version from 4.19.85 to
> 4.19.88,
> > and The linux-4.4.y-cip tree has been updated base version from 4.4.199 to
> 4.4.206.
> > In addition, the following features have been backported and updated in the
> > linux-4.4.y-cip:
> >?? - Support Renesas RZ/G1N SoC (r8a7744)
> >?? - Support iWave G20D-Q7 board based on RZ/G1N
> >?? - Update mmc driver for RZ/G1C's eMMC
> >
> > You can get this release via the git tree at:
> >
> >?? v4.19.88-cip16:
> >???? repository:
> >?????? https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
>
> I attempted to check it in our gitlab, and seems that mirroring is
> broken:
>
> https://gitlab.com/cip-project/cip-kernel/linux-cip/commits/linux-4.4.y-cip

I've force-pushed the linux-4.4.y-cip branch to match upstream, which should hopefully solve this issue going forward.

Kind regards, Chris

>
> This project is mirrored from
> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git. Updated
> 23 minutes ago.? This branch has diverged from upstream.
> 04 Dec, 2019 1 commit
>
> gpiolib: Fix bad of_node pointer
> Fabrizio Castro authored 1 month ago
> 7b4a8ef7
>
> Best regards,
> ????? ??????? ??????? ??????? ??????? ??????? ??????? ??????? Pavel
>
> --
> DENX Software Engineering GmbH,????? Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

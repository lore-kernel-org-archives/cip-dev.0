From: Chris.Paterson2@renesas.com (Chris Paterson)
Date: Thu, 24 Oct 2019 12:58:18 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 0/6] Add HDMI AUDIO/CAN/CANFD
	support
In-Reply-To: <20191024124903.GA6546@amd>
References: <1571295479-39328-1-git-send-email-biju.das@bp.renesas.com>
	<20191018165754.GB25992@amd>
	<OSBPR01MB2103A670C18F3F754A319CDAB8690@OSBPR01MB2103.jpnprd01.prod.outlook.com>
	<20191024124903.GA6546@amd>
Message-ID: <TYAPR01MB2285B780FAA648DD83AE9EAAB76A0@TYAPR01MB2285.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Pavel,

> From: Pavel Machek <pavel@denx.de>
> Sent: 24 October 2019 13:49
>
> Hi!
>
> > > > This patch series add HDMI AUDIO/CAN/CANFD support for HiHope
> > > RZ/G2M platform.
> > > >
> > > > This patch series is based on linux-4.19.y-cip and all the patches in
> > > > this series are cherry-picked from linux rc tree.
> > >
> > > Series seems ok to me, if there are no objections I can apply it.
> > >
> > Thanks for the review
>
> I applied the patches. Tests are still running (
> https://gitlab.com/cip-project/cip-kernel/linux-cip/pipelines/91254170
> ) but I don't expect problems there.

Just to let you know, the arm64 boards are currently offline in the Renesas LAVA lab.
I'm working to get them online again, but the impact will be that your test jobs will eventually timeout and fail.

Sorry for the inconvenience.

Kind regards, Chris

>
> Best regards,
> ????? ??????? ??????? ??????? ??????? ??????? ??????? ??????? Pavel
> --
> DENX Software Engineering GmbH,????? Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

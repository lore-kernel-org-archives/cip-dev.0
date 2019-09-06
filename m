From: Chris.Paterson2@renesas.com (Chris Paterson)
Date: Fri, 6 Sep 2019 07:27:47 +0000
Subject: [cip-dev] [PATCH linux-4.19.y-cip] gitlab-ci: Start testing the
 r8a774a1-hihope-rzg2m-ex device
In-Reply-To: <OSAPR01MB3234ADA15FAB8C09BDF3468992BA0@OSAPR01MB3234.jpnprd01.prod.outlook.com>
References: <20190905162254.24424-1-chris.paterson2@renesas.com>
	<OSAPR01MB3234ADA15FAB8C09BDF3468992BA0@OSAPR01MB3234.jpnprd01.prod.outlook.com>
Message-ID: <TYAPR01MB22857869B4C7BA883FDE75A3B7BA0@TYAPR01MB2285.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Iwamatsu-san,

> From: nobuhiro1.iwamatsu at toshiba.co.jp
> <nobuhiro1.iwamatsu@toshiba.co.jp>
> Sent: 06 September 2019 04:35
> 
> Hi Chris,
> 
> > -----Original Message-----
> > From: Chris Paterson [mailto:chris.paterson2 at renesas.com]
> > Sent: Friday, September 6, 2019 1:23 AM
> > To: cip-dev at lists.cip-project.org
> > Cc: Chris Paterson <chris.paterson2@renesas.com>; iwamatsu nobuhiro(?
> > ? ?? ????????) <nobuhiro1.iwamatsu@toshiba.co.jp>
> > Subject: [PATCH linux-4.19.y-cip] gitlab-ci: Start testing the
> > r8a774a1-hihope-rzg2m-ex device
> >
> > Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
> > Cc: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> > ---
> >
> > Please apply this patch either with or before the "Add HopeRun RZ/G2[M]
> > main/sub boards" series:
> > https://patchwork.kernel.org/project/cip-dev/list/?series=167529
> >
> > This will mean that the RZ/G2M board is tested in the LAVA lab as the
> > code for it is added.
> >
> > It is safe to add this patch before the above series if that's easier.
> >
> 
> Applied, thanks.
> I pushed ci/linux-4.19.y-cip. If test was OK, I will push to linux-4.19.y-cip.

Looks good to me.

Pipeline: https://gitlab.com/cip-project/cip-kernel/linux-cip/pipelines/80609721
RZ/G2M boot test: https://lava.ciplatform.org/scheduler/job/3472
RZ/G2M SMC test: https://lava.ciplatform.org/scheduler/job/3473

Thanks, Chris

> 
> Best regards,
>   Nobuhiro

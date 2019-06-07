From: Chris.Paterson2@renesas.com (Chris Paterson)
Date: Fri, 7 Jun 2019 15:06:59 +0000
Subject: [cip-dev] [next] iwg20m: add support for this board
In-Reply-To: <1559918469.21054.3.camel@codethink.co.uk>
References: <20190606074829.8104-1-daniel.sangorrin@toshiba.co.jp>
	<20190606074829.8104-2-daniel.sangorrin@toshiba.co.jp>
	<1559918469.21054.3.camel@codethink.co.uk>
Message-ID: <TYAPR01MB2285605310C92322737DEB4FB7100@TYAPR01MB2285.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello,

> From: cip-dev-bounces at lists.cip-project.org <cip-dev-bounces@lists.cip-
> project.org> On Behalf Of Ben Hutchings
> Sent: 07 June 2019 15:41
> 
> On Thu, 2019-06-06 at 16:48 +0900, Daniel Sangorrin wrote:
> > This patch adds support for the iwg20m board to isar-cip-core.
> >
> > - Kernel version notes
> >
> > This board is only supported by the 4.4 kernel. For that
> > reason, the preferred version is set to 4.4 and the user
> > doesn't need to specify :opt-4.4.yml
> [...]
> 
> This really shouldn't be allowed to happen.  All the patches applied to
> 4.4-cip to support this board were already upstream, so this must be a
> regression.  If this board is used as a basis for real systems that
> need to run beyond EOL of the 4.4-cip branch (~2026), it needs to be
> possible to upgrade them to a new kernel version at that time.

Actually, the iwg20m board does work with the upstream Kernel as well as v4.19.y-cip, e.g. [1].

I think it's just that Renesas doesn't intend to support the board with anything other than v4.4.y-cip.

[1] https://lava.ciplatform.org/scheduler/job/1219

Kind regards, Chris

> 
> Ben.
> 
> --
> Ben Hutchings, Software Developer                ?        Codethink Ltd
> https://www.codethink.co.uk/                 Dale House, 35 Dale Street
>                                      Manchester, M1 2HF, United Kingdom
> _______________________________________________
> cip-dev mailing list
> cip-dev at lists.cip-project.org
> https://lists.cip-project.org/mailman/listinfo/cip-dev

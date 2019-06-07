From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Fri, 07 Jun 2019 16:16:10 +0100
Subject: [cip-dev] [next] iwg20m: add support for this board
In-Reply-To: <TYAPR01MB2285605310C92322737DEB4FB7100@TYAPR01MB2285.jpnprd01.prod.outlook.com>
References: <20190606074829.8104-1-daniel.sangorrin@toshiba.co.jp>
	<20190606074829.8104-2-daniel.sangorrin@toshiba.co.jp>
	<1559918469.21054.3.camel@codethink.co.uk>
	<TYAPR01MB2285605310C92322737DEB4FB7100@TYAPR01MB2285.jpnprd01.prod.outlook.com>
Message-ID: <1559920570.21054.7.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Fri, 2019-06-07 at 15:06 +0000, Chris Paterson wrote:
> Hello,
> 
> > From: cip-dev-bounces at lists.cip-project.org <cip-dev-bounces@lists.cip-
> > project.org> On Behalf Of Ben Hutchings
> > Sent: 07 June 2019 15:41
> > 
> > On Thu, 2019-06-06 at 16:48 +0900, Daniel Sangorrin wrote:
> > > This patch adds support for the iwg20m board to isar-cip-core.
> > > 
> > > - Kernel version notes
> > > 
> > > This board is only supported by the 4.4 kernel. For that
> > > reason, the preferred version is set to 4.4 and the user
> > > doesn't need to specify :opt-4.4.yml
> > 
> > [...]
> > 
> > This really shouldn't be allowed to happen.??All the patches applied to
> > 4.4-cip to support this board were already upstream, so this must be a
> > regression.??If this board is used as a basis for real systems that
> > need to run beyond EOL of the 4.4-cip branch (~2026), it needs to be
> > possible to upgrade them to a new kernel version at that time.
> 
> Actually, the iwg20m?board does work with the upstream Kernel as well
> as v4.19.y-cip, e.g. [1].

Oh, good.

> I think it's just that Renesas doesn't intend to support the board
> with anything other than v4.4.y-cip.

I understand the desire to limit the support burden.  But I hope that
there is a plan to support a newer kernel version eventually, if
necessary.

Ben.

> [1] https://lava.ciplatform.org/scheduler/job/1219
> 
> Kind regards, Chris

-- 
Ben Hutchings, Software Developer                ?        Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom

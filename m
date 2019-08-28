From: nobuhiro1.iwamatsu@toshiba.co.jp (nobuhiro1.iwamatsu at toshiba.co.jp)
Date: Wed, 28 Aug 2019 22:57:59 +0000
Subject: [cip-dev] [PATCH 1/3] Change templagte directory name
In-Reply-To: <TYAPR01MB2285770A2828D112504BF1FBB7A30@TYAPR01MB2285.jpnprd01.prod.outlook.com>
References: <20190828022619.3690-1-nobuhiro1.iwamatsu@toshiba.co.jp>
	<TYAPR01MB2285770A2828D112504BF1FBB7A30@TYAPR01MB2285.jpnprd01.prod.outlook.com>
Message-ID: <OSAPR01MB3234CE92510D6A0DF333047992A30@OSAPR01MB3234.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Chris,

> -----Original Message-----
> From: Chris Paterson [mailto:Chris.Paterson2 at renesas.com]
> Sent: Wednesday, August 28, 2019 7:05 PM
> To: iwamatsu nobuhiro(?? ?? ????????)
> <nobuhiro1.iwamatsu@toshiba.co.jp>
> Cc: cip-dev at lists.cip-project.org
> Subject: RE: [PATCH 1/3] Change templagte directory name
> 
> Hello Iwamatsu-san,
> 
> > From: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> > Sent: 28 August 2019 03:26
> >
> > Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> > ---
> >  .../r8a7743-iwg20d-q7.yaml                                    | 0
> >  .../r8a7745-iwg22d-sodimm.yaml                                | 0
> >  {healthcheck_templates => lava_templates}/r8a774c0-ek874.yaml | 0
> >  submit_tests.sh                                               | 2
> +-
> >  test.Dockerfile                                               | 4
> ++--
> >  5 files changed, 3 insertions(+), 3 deletions(-)  rename
> > {healthcheck_templates => lava_templates}/r8a7743-iwg20d- q7.yaml
> > (100%)  rename {healthcheck_templates =>
> > lava_templates}/r8a7745-iwg22d- sodimm.yaml (100%)  rename
> > {healthcheck_templates => lava_templates}/r8a774c0-ek874.yaml
> > (100%)
> 
> Thank you for this patch. Do you think you could create a merge request
> in gitlab[0] so we can do the review there?
> For this patch and the other two in the series.
> 
> [0]
> https://gitlab.com/cip-project/cip-testing/linux-cip-ci/merge_reques
> ts

Ok, I just sent MR via gitlab.

> 
> Kind regards, Chris
> 

Best regards,
  Nobuhiro

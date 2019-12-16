From: Chris.Paterson2@renesas.com (Chris Paterson)
Date: Mon, 16 Dec 2019 11:35:58 +0000
Subject: [cip-dev] [ANNOUNCE] Release v4.19.88-cip16 and v4.4.206-cip40
In-Reply-To: <TYAPR01MB2285954DF5F07BA6A3F4AD09B7510@TYAPR01MB2285.jpnprd01.prod.outlook.com>
References: <OSAPR01MB323483390F138C52C363126492540@OSAPR01MB3234.jpnprd01.prod.outlook.com>
 <20191216112246.GA17029@amd>
 <TYAPR01MB2285954DF5F07BA6A3F4AD09B7510@TYAPR01MB2285.jpnprd01.prod.outlook.com>
Message-ID: <TYAPR01MB228518B00BFF2797CCDE9EF5B7510@TYAPR01MB2285.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

> From: cip-dev <cip-dev-bounces@lists.cip-project.org> On Behalf Of Chris
> Paterson
> Sent: 16 December 2019 11:26
> 
> Hello Pavel,
> 
> > From: Pavel Machek <pavel@denx.de>
> > Sent: 16 December 2019 11:23
> >
> > Hi!
> >
> > > CIP kernel team has released Linux kernel v4.19.88-cip16 and v4.4.206-cip40.
> > > The linux-4.19.y-cip tree has been updated base version from 4.19.85 to
> > 4.19.88,
> > > and The linux-4.4.y-cip tree has been updated base version from 4.4.199 to
> > 4.4.206.
> >
> > >?? v4.4.206-cip40:
> > >???? repository:
> > >?????? https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
> > >???? branch:
> > >?????? linux-4.4.y-cip
> > >???? commit:
> > >?????? 0cddb349320426954582511b95e7d31873941aad
> >
> > I attempted to get this tested, but failed:
> >
> > https://gitlab.com/cip-project/cip-kernel/linux-cip/pipelines/103361420
> >
> > Found errors in your .gitlab-ci.yml:
> > Resolving config took longer than expected
> > You can also test your .gitlab-ci.yml in CI Lint
> 
> This error happens now and then. It's caused by GitLab taking too long to fetch
> the CI configs from a separate GitLab repo.

For those interested in such things, please see:
https://gitlab.com/gitlab-org/gitlab/issues/43710

Kind regards, Chris

> 
> Usually trying again a few minutes later works. I've started the pipeline you were
> trying to run:
> https://gitlab.com/cip-project/cip-kernel/linux-cip/pipelines/103362219
> 
> Kind regards, Chris
> 
> >
> > Best regards,
> > ????? ??????? ??????? ??????? ??????? ??????? ??????? ??????? Pavel
> > --
> > DENX Software Engineering GmbH,????? Managing Director: Wolfgang Denk
> > HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> _______________________________________________
> cip-dev mailing list
> cip-dev at lists.cip-project.org
> https://lists.cip-project.org/mailman/listinfo/cip-dev

From: pavel@denx.de (Pavel Machek)
Date: Wed, 2 Oct 2019 11:05:21 +0200
Subject: [cip-dev] Testing results for 4.19-cip-rt
In-Reply-To: <TYAPR01MB22856D44519AE15F3CD9D5C3B79C0@TYAPR01MB2285.jpnprd01.prod.outlook.com>
References: <20191002082238.GA9041@amd>
	<TYAPR01MB22856D44519AE15F3CD9D5C3B79C0@TYAPR01MB2285.jpnprd01.prod.outlook.com>
Message-ID: <20191002090521.GA8924@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> > From: Pavel Machek <pavel@denx.de>
> > Sent: 02 October 2019 09:23
> >
> > Hi!
> >
> > I pushed -cip-rt version to kernel.org, which got me automatic test on
> > gitlab:
> >
> > https://gitlab.com/cip-project/cip-kernel/linux-cip/-/jobs/309275693
> >
> > ...compile okay, but run_tests failed; unfortunately I don't quite
> > understand what went wrong with the test. Can someone help?
> 
> It looks like test join #4665[0] failed due to internet connectivity issues in the lab.
> 
> I've re-run the job and it passes[1], so you should be okay.
> I've also re-run the GitLab CI test job[2], so GitLab will show the pipeline as a success[3].

Thanks!

This time tests succeeded, but build is indicating problems, in case
you wanted to investigate:

https://gitlab.com/cip-project/cip-kernel/linux-cip/-/jobs/297715703

Anyway, it seems code is okay, so I'll proceed and create -cip-rt
release.

Best regards,
								Pavel
-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20191002/c799d60b/attachment.sig>

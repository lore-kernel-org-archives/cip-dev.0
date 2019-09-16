From: sz.lin@moxa.com (=?UTF-8?B?U1ogTGluICjmnpfkuIrmmbop?=)
Date: Mon, 16 Sep 2019 17:50:39 +0800
Subject: [cip-dev] gitlab: mirroring broken, tests failing
In-Reply-To: <OSAPR01MB3234387C361803EA604F3D7F92B00@OSAPR01MB3234.jpnprd01.prod.outlook.com>
References: <20190911221452.GA30802@amd>
	<OSAPR01MB3234387C361803EA604F3D7F92B00@OSAPR01MB3234.jpnprd01.prod.outlook.com>
Message-ID: <CAFk6z8OF4Bmviq3KWu2DsN1hDv-ozZs6Azw-ie=OJubrPOcReA@mail.gmail.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi,

<nobuhiro1.iwamatsu@toshiba.co.jp> ? 2019?9?13? ?? ??6:51???
>
> Hi all,
>
> > -----Original Message-----
> > From: cip-dev-bounces at lists.cip-project.org
> > [mailto:cip-dev-bounces at lists.cip-project.org] On Behalf Of Pavel
> > Machek
> > Sent: Thursday, September 12, 2019 7:15 AM
> > To: Chris.Paterson2 at renesas.com; cip-dev at lists.cip-project.org
> > Subject: [cip-dev] gitlab: mirroring broken, tests failing
> >
> > Hi!
> >
> > I pushed kernel to kernel.org, bug I don't see it on gilab. Does mirroring
> > need to be restarted?
> >
> > Plus, tests are failing, and it seems to me that problem is with tests,
> > not with kernel...
> > https://gitlab.com/cip-project/cip-kernel/linux-cip/-/jobs/292957614
> >
> > Job submitted successfully as #3620.
> > ------------------------------
> > Current job status:
> > Job #3605: Submitted
> > ...
> > Job #3620: Submitted
> > Timed out waiting for test jobs to complete Errors during testing
> >
> > I tried submiting known-good kernel, 3bc5ed22, and it failed, too...
>
> I think this is caused by LAVA.
> LAVA has many test queue, and is not being processed.

Yes, it's.

The gitlab mirror mechanism works fine.

SZ

>
>    https://lava.ciplatform.org/scheduler/
>
> Chris, could you check LAVA?
>
> Best regards,
>   Nobuhiro
> _______________________________________________
> cip-dev mailing list
> cip-dev at lists.cip-project.org
> https://lists.cip-project.org/mailman/listinfo/cip-dev

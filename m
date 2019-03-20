From: daniel.sangorrin@toshiba.co.jp (daniel.sangorrin at toshiba.co.jp)
Date: Wed, 20 Mar 2019 00:04:47 +0000
Subject: [cip-dev] Testing Dependencies
In-Reply-To: <OSBPR01MB205501D032B04773D51C3541E9400@OSBPR01MB2055.jpnprd01.prod.outlook.com>
References: <OSBPR01MB205553CE1E094E76BF4E681FE9470@OSBPR01MB2055.jpnprd01.prod.outlook.com>
	<OSAPR01MB37637BF6E9C90C5766CC048ED0400@OSAPR01MB3763.jpnprd01.prod.outlook.com>
	<OSBPR01MB205501D032B04773D51C3541E9400@OSBPR01MB2055.jpnprd01.prod.outlook.com>
Message-ID: <OSAPR01MB37638419F9EDED8EE26D2D1ED0410@OSAPR01MB3763.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

> -----Original Message-----
> From: Patryk Mungai Ndungu <patryk.mungai-ndungu.kx@renesas.com>
> > 5) We can just use or create our own shell scripts for testing the basic
> > behavior of most commands. There are a few test definitions in Fuego that
> > can be easily adapted.
> 
> I assume this is primarily for CIP-Core testing? In which case great! I think it would be nice to show CIP-Core tests
> in LAVA too.

Yes, that's right.

> So to summarise:
> - Images should have all tools dependencies installed during build
> - If not, it would be helpful if CIP-Core images have apt-get installed (use generic profile built with ISAR)
> - Any binaries for tests should be stored in the S3 bucket
> - As our focus is regression testing, these binaries should remain static
> - We can look into running Kernel 0-day bug tests and multi-node jobs later

Well summarized.

Thanks,
Daniel

> 
> Thanks,
> Patryk
> 
> >
> > Thanks,
> > Daniel

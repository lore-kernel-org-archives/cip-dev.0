From: pavel@denx.de (Pavel Machek)
Date: Sun, 2 Feb 2020 19:01:08 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 05/12] arm64: dts: renesas:
 r8a774b1: Add all MSIOF nodes
In-Reply-To: <OSBPR01MB5160106AB2B733ED6B690860AA040@OSBPR01MB5160.jpnprd01.prod.outlook.com>
References: <1580308205-20435-1-git-send-email-biju.das@bp.renesas.com>
 <1580308205-20435-6-git-send-email-biju.das@bp.renesas.com>
 <20200130192653.GA6721@duo.ucw.cz>
 <OSBPR01MB5160106AB2B733ED6B690860AA040@OSBPR01MB5160.jpnprd01.prod.outlook.com>
Message-ID: <20200202180108.GA30851@duo.ucw.cz>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> > > commit c88657c4a1ead900cf59d87511d7deee41ed92a5 upstream.
> > >
> > > Add the device nodes for all MSIOF SPI controllers on the RZ/G2N SoC
> > > (a.k.a. r8a774b1).
> >
> > I googled a bit, and MSIOF SPI seems to be "slave" controller on SPI. But I still
> > don't know what "MSIOF" stands for, if anything.
> >
> "MSIOF" stands for clock-synchronized serial interface with FIFO, this interface supports IIS and
> SPI serial formats (master and slave mode). ATM only SPI master mode is supported in mainline
> Kernel.

Ok, I can imagine that. But is "MSIOF" an acronym, and if so, what
does it stand for?

Best regards,
								Pavel
-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 195 bytes
Desc: not available
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20200202/2fe8a18d/attachment.sig>

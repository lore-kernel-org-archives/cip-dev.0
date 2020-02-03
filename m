From: Chris.Paterson2@renesas.com (Chris Paterson)
Date: Mon, 3 Feb 2020 08:27:49 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 05/12] arm64: dts: renesas:
 r8a774b1: Add all MSIOF nodes
In-Reply-To: <20200202180108.GA30851@duo.ucw.cz>
References: <1580308205-20435-1-git-send-email-biju.das@bp.renesas.com>
 <1580308205-20435-6-git-send-email-biju.das@bp.renesas.com>
 <20200130192653.GA6721@duo.ucw.cz>
 <OSBPR01MB5160106AB2B733ED6B690860AA040@OSBPR01MB5160.jpnprd01.prod.outlook.com>
 <20200202180108.GA30851@duo.ucw.cz>
Message-ID: <TYAPR01MB2285A317EF9D4BA9E721B5C4B7000@TYAPR01MB2285.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Pavel,

> From: cip-dev <cip-dev-bounces@lists.cip-project.org> On Behalf Of Pavel
> Machek
> Sent: 02 February 2020 18:01
>
> Hi!
>
> > > > commit c88657c4a1ead900cf59d87511d7deee41ed92a5 upstream.
> > > >
> > > > Add the device nodes for all MSIOF SPI controllers on the RZ/G2N SoC
> > > > (a.k.a. r8a774b1).
> > >
> > > I googled a bit, and MSIOF SPI seems to be "slave" controller on SPI. But I
> still
> > > don't know what "MSIOF" stands for, if anything.
> > >
> > "MSIOF" stands for clock-synchronized serial interface with FIFO, this
> interface supports IIS and
> > SPI serial formats (master and slave mode). ATM only SPI master mode is
> supported in mainline
> > Kernel.
>
> Ok, I can imagine that. But is "MSIOF" an acronym, and if so, what
> does it stand for?

To be honest, even I'm not sure what the acronym is meant to mean (or even if there is a direct meaning), but the 'long' name for the IP block is "Clock-Synchronized Serial Interface with FIFO".

Kind regards, Chris

>
> Best regards,
> ????? ??????? ??????? ??????? ??????? ??????? ??????? ??????? Pavel
> --
> DENX Software Engineering GmbH,????? Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

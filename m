From: prabhakar.mahadev-lad.rj@bp.renesas.com (Prabhakar Mahadev Lad)
Date: Thu, 30 Jan 2020 22:22:26 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 05/12] arm64: dts: renesas:
 r8a774b1: Add all MSIOF nodes
In-Reply-To: <20200130192653.GA6721@duo.ucw.cz>
References: <1580308205-20435-1-git-send-email-biju.das@bp.renesas.com>
 <1580308205-20435-6-git-send-email-biju.das@bp.renesas.com>
 <20200130192653.GA6721@duo.ucw.cz>
Message-ID: <OSBPR01MB5160106AB2B733ED6B690860AA040@OSBPR01MB5160.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Pavel,

> -----Original Message-----
> From: cip-dev <cip-dev-bounces@lists.cip-project.org> On Behalf Of Pavel
> Machek
> Sent: 30 January 2020 19:27
> To: Biju Das <biju.das@bp.renesas.com>
> Cc: cip-dev at lists.cip-project.org
> Subject: Re: [cip-dev] [PATCH 4.19.y-cip 05/12] arm64: dts: renesas:
> r8a774b1: Add all MSIOF nodes
>
> On Wed 2020-01-29 14:29:58, Biju Das wrote:
> > From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> >
> > commit c88657c4a1ead900cf59d87511d7deee41ed92a5 upstream.
> >
> > Add the device nodes for all MSIOF SPI controllers on the RZ/G2N SoC
> > (a.k.a. r8a774b1).
>
> I googled a bit, and MSIOF SPI seems to be "slave" controller on SPI. But I still
> don't know what "MSIOF" stands for, if anything.
>
"MSIOF" stands for clock-synchronized serial interface with FIFO, this interface supports IIS and
SPI serial formats (master and slave mode). ATM only SPI master mode is supported in mainline
Kernel.

Cheers,
--Prabhakar

> Best regards,
> Pavel
>
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany


Renesas Electronics Europe GmbH, Geschaeftsfuehrer/President: Carsten Jauch, Sitz der Gesellschaft/Registered office: Duesseldorf, Arcadiastrasse 10, 40472 Duesseldorf, Germany, Handelsregister/Commercial Register: Duesseldorf, HRB 3708 USt-IDNr./Tax identification no.: DE 119353406 WEEE-Reg.-Nr./WEEE reg. no.: DE 14978647

From: pavel@denx.de (Pavel Machek)
Date: Fri, 15 Nov 2019 22:17:46 +0100
Subject: [cip-dev] [PATCH 4.4.y-cip 05/21] clk: shmobile: Compile
 clk-rcar-gen2.c when using the r8a7744
In-Reply-To: <OSBPR01MB2103A89B8A8F7B23CBFC97FCB8700@OSBPR01MB2103.jpnprd01.prod.outlook.com>
References: <1573737877-11733-1-git-send-email-biju.das@bp.renesas.com>
 <1573737877-11733-6-git-send-email-biju.das@bp.renesas.com>
 <20191115080651.GA21006@amd>
 <OSBPR01MB21032CB3ACC0EC42F5945DEFB8700@OSBPR01MB2103.jpnprd01.prod.outlook.com>
 <20191115093713.GA25603@amd>
 <OSBPR01MB2103A89B8A8F7B23CBFC97FCB8700@OSBPR01MB2103.jpnprd01.prod.outlook.com>
Message-ID: <20191115211745.GC30273@duo.ucw.cz>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> > > > > +++ b/drivers/clk/shmobile/Makefile
> > > > > @@ -3,6 +3,7 @@ obj-$(CONFIG_ARCH_R7S72100)		+=
> > clk-rz.o
> > > > >  obj-$(CONFIG_ARCH_R8A73A4)		+= clk-r8a73a4.o
> > > > >  obj-$(CONFIG_ARCH_R8A7740)		+= clk-r8a7740.o
> > > > >  obj-$(CONFIG_ARCH_R8A7743)		+= clk-rcar-gen2.o
> > > > > +obj-$(CONFIG_ARCH_R8A7744)		+= clk-rcar-gen2.o
> > > > >  obj-$(CONFIG_ARCH_R8A7745)		+= clk-rcar-gen2.o
> > > > >  obj-$(CONFIG_ARCH_R8A77470)		+= clk-rcar-gen2.o
> > > > >  obj-$(CONFIG_ARCH_R8A7778)		+= clk-r8a7778.o
> > > >
> > > > This is kind-of interesting code. I'm okay with merging it as-is,
> > > > but would it be possible to select more suitable config option so
> > > > that same object file is not included 4 times?
> > >
> > > What about the others on the same file?
> > > 11 obj-$(CONFIG_ARCH_R8A7790)              += clk-rcar-gen2.o
> > >  12 obj-$(CONFIG_ARCH_R8A7791)              += clk-rcar-gen2.o
> > >  13 obj-$(CONFIG_ARCH_R8A7793)              += clk-rcar-gen2.o
> > >  14 obj-$(CONFIG_ARCH_R8A7794)              += clk-rcar-gen2.o
> > 
> > Could these all be replaced with
> > 
> > obj-$(CONFIG_ARCH_RCAR_GEN2)              += clk-rcar-gen2.o
> 
> On the mainline it is modified like this. Do you want me to backport the relevant changes or are you happy to do this? Please let me know.
> obj-$(CONFIG_CLK_RCAR_GEN2)             += clk-rcar-gen2.o

If it is easy, please backport relevant changes. If it is not, it can
stay this way.

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
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20191115/0bce16a0/attachment.sig>

From: pavel@denx.de (Pavel Machek)
Date: Thu, 29 Aug 2019 08:59:05 +0200
Subject: [cip-dev] [PATCH 4.4.y-cip 05/17] phy: phy-rcar-gen2: Add
 support for r8a77470
In-Reply-To: <OSBPR01MB21031A3D10375A9787BED6A0B8A30@OSBPR01MB2103.jpnprd01.prod.outlook.com>
References: <1566982115-11148-1-git-send-email-biju.das@bp.renesas.com>
	<1566982115-11148-6-git-send-email-biju.das@bp.renesas.com>
	<20190828111209.GB8052@amd>
	<OSBPR01MB21031A3D10375A9787BED6A0B8A30@OSBPR01MB2103.jpnprd01.prod.outlook.com>
Message-ID: <20190829065905.GA10041@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> > PHYS_PER_CHANNEL is 2.
> > 
> > > +	const u32 (*select_value)[PHYS_PER_CHANNEL];
> > 
> > This is ... quite "interesting" declaration. Does it actually match the arrays
> > below?
> > 
> > If I read it correctly:
> > 
> >    const u32 (...)[PHYS_PER_CHANNEL]
> > 
> > this is array of two items.
> > 
> > > +static const u32 pci_select_value[][PHYS_PER_CHANNEL] = {
> > > +	[0]	= { USBHS_UGCTRL2_USB0SEL_PCI,
> > USBHS_UGCTRL2_USB0SEL_HS_USB },
> > > +	[2]	= { USBHS_UGCTRL2_USB2SEL_PCI,
> > USBHS_UGCTRL2_USB2SEL_USB30 },
> > > +};
> > 
> > But here we have three items (0, 1 and 2), yet we are assigning that to same
> > pointer.
> > 
> > Correct me if I'm wrong.
> > 
> Please compile the below code and check the results for 2 dimensional arrays.

I'm sorry, I got confused. Sorry for the noise.

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
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190829/bba3d043/attachment.sig>

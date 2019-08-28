From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 28 Aug 2019 12:49:08 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 05/17] phy: phy-rcar-gen2: Add
 support for r8a77470
In-Reply-To: <20190828111209.GB8052@amd>
References: <1566982115-11148-1-git-send-email-biju.das@bp.renesas.com>
	<1566982115-11148-6-git-send-email-biju.das@bp.renesas.com>
	<20190828111209.GB8052@amd>
Message-ID: <OSBPR01MB21031A3D10375A9787BED6A0B8A30@OSBPR01MB2103.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Pavel,

Thanks for the feedback.

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Wednesday, August 28, 2019 12:12 PM
> To: Biju Das <biju.das@bp.renesas.com>
> Cc: cip-dev at lists.cip-project.org
> Subject: Re: [cip-dev] [PATCH 4.4.y-cip 05/17] phy: phy-rcar-gen2: Add
> support for r8a77470
> 
> Hi!
> 
> PHYS_PER_CHANNEL is 2.
> 
> > +	const u32 (*select_value)[PHYS_PER_CHANNEL];
> 
> This is ... quite "interesting" declaration. Does it actually match the arrays
> below?
> 
> If I read it correctly:
> 
>    const u32 (...)[PHYS_PER_CHANNEL]
> 
> this is array of two items.
> 
> > +static const u32 pci_select_value[][PHYS_PER_CHANNEL] = {
> > +	[0]	= { USBHS_UGCTRL2_USB0SEL_PCI,
> USBHS_UGCTRL2_USB0SEL_HS_USB },
> > +	[2]	= { USBHS_UGCTRL2_USB2SEL_PCI,
> USBHS_UGCTRL2_USB2SEL_USB30 },
> > +};
> 
> But here we have three items (0, 1 and 2), yet we are assigning that to same
> pointer.
> 
> Correct me if I'm wrong.
> 
Please compile the below code and check the results for 2 dimensional arrays.


#include <stdio.h>

static int test[][2] = {
        [0] = { 0, 1 },
        [2] = { 2, 3 },
};

main()
{
        int i;
        for (i=0;i<3;i++)
                printf("values %d0=%d,%d1=%d\n",i,test[i][0],i,test[i][1] );
}

Regards,
Biju

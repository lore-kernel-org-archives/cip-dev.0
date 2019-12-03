From: JohnsonCH.Chen@moxa.com (=?iso-2022-jp?B?Sm9obnNvbiBDSCBDaGVuICgbJEJERD48Ui4bKEIp?=)
Date: Tue, 3 Dec 2019 04:11:43 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip] gpiolib: Fix invalid access
	of	nullptr
In-Reply-To: <TY1PR01MB177064C0DFD2CCE7D43B3BE4C0430@TY1PR01MB1770.jpnprd01.prod.outlook.com>
References: <14717888-518c-3643-b98e-4a052c14c102@siemens.com>
 <TY1PR01MB177064C0DFD2CCE7D43B3BE4C0430@TY1PR01MB1770.jpnprd01.prod.outlook.com>
Message-ID: <HK0PR01MB35211F776B35B4A04047CEADFA420@HK0PR01MB3521.apcprd01.prod.exchangelabs.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Pavel and Iwamatsu-san,

> From: cip-dev <cip-dev-bounces@lists.cip-project.org> On Behalf Of 
> Fabrizio Castro
> Sent: Monday, December 2, 2019 11:43 PM
> To: Koch, Stefan <stefan-koch@siemens.com>; 
> cip-dev at lists.cip-project.org
> Cc: Biju Das <biju.das@bp.renesas.com>
> Subject: Re: [cip-dev] [PATCH 4.4.y-cip] gpiolib: Fix invalid access 
> of nullptr
>
> Hi Stefan,
>
> That's a known problem, please have a  look at:
> https://patchwork.kernel.org/patch/11235267/
>
> Pavel, Iwamatsu-san, could you please take patch:
> https://patchwork.kernel.org/patch/11235267/
>
> I think this is quite urgent as others will stumble across the problem and will try and fix it.
>

For "fix" a backport issue, should we follow upstream first in CIP?

> Thanks,
> Fab
>


Best regards,
Johnson

<span class="sew4j6gfd2s3o7x"><br></span>> > -----Original Message-----
> > From: Koch, Stefan <stefan-koch@siemens.com>
> > Sent: 02 December 2019 15:37
> > To: cip-dev at lists.cip-project.org
> > Cc: Fabrizio Castro <fabrizio.castro@bp.renesas.com>; pavel at denx.de; 
> > nobuhiro1.iwamatsu at toshiba.co.jp
> > Subject: [PATCH 4.4.y-cip] gpiolib: Fix invalid access of nullptr
> >
> > Hi
> >
> > There is a NULL pointer exception issue within the gpiolib of the 
> > CIP
> > 4.4 kernel.
> > The CIP kernel output and a patch that fix the invalid null pointer 
> > access are attached.
> >
> > The vanilla 4.4 kernel is not affected by this bug, because this 
> > regression affects only CIP 4.4.176-cip32 or newer kernels that 
> > contain back ported code for the gpiolib. The upstream vanilla 
> > kernel contains similar code beginning with version 4.17.
> >
> > The following commits introduce the new functionality for the CIP
> > 4.4.176-cip32 kernel:
> > gpiolib: Avoid calling chip->request() for unused gpios, 
> > ed4f40244354af7b19b3bae5c56cce2620877b7c
> > gpiolib: Support 'gpio-reserved-ranges' property,
> > baff4777cdb80256cd24dede2a3d0af761356307
> > gpiolib: Extract mask allocation into subroutine, 
> > 171aad2d8519db9940d84e337da96aac8b1eb36c
> >
> > Thank you.
> >
> > --
> > Best regards
> > Stefan Koch
> >
> > Siemens AG
> > Digital Industries
> > Process Automation
> > Software House Nbg
> > DI PA CI R&D 3
> > Gleiwitzer Str. 555
> > 90475 Nuernberg, Germany
> > stefan-koch at siemens.com <mailto:stefan-koch@siemens.com> 
> > www.siemens.com/ingenuityforlife 
> > <https://siemens.com/ingenuityforlife>
> > www.siemens.com/ingenuityforlife
> > Siemens Aktiengesellschaft: Chairman of the Supervisory Board: Jim 
> > Hagemann Snabe; Managing Board: Joe Kaeser, Chairman, President and Chief Executive Officer; Roland Busch, Lisa Davis, Klaus Helmrich, Janina Kugel, Cedrik Neike, Michael Sen, Ralf P.
> > Thomas; Registered offices: Berlin and Munich, Germany; Commercial
> > registries: Berlin Charlottenburg, HRB 12300, Munich, HRB 6684; 
> > WEEE-Reg.-No. DE 23691322
> >
> >
>
> _______________________________________________
> cip-dev mailing list
> cip-dev at lists.cip-project.org
> https://lists.cip-project.org/mailman/listinfo/cip-dev

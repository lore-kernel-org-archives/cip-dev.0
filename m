From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon, 2 Dec 2019 15:42:37 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip] gpiolib: Fix invalid access of
	nullptr
In-Reply-To: <14717888-518c-3643-b98e-4a052c14c102@siemens.com>
References: <14717888-518c-3643-b98e-4a052c14c102@siemens.com>
Message-ID: <TY1PR01MB177064C0DFD2CCE7D43B3BE4C0430@TY1PR01MB1770.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Stefan,

That's a known problem, please have a  look at:
https://patchwork.kernel.org/patch/11235267/

Pavel, Iwamatsu-san, could you please take patch:
https://patchwork.kernel.org/patch/11235267/

I think this is quite urgent as others will stumble across the problem and will try and fix it.

Thanks,
Fab

> -----Original Message-----
> From: Koch, Stefan <stefan-koch@siemens.com>
> Sent: 02 December 2019 15:37
> To: cip-dev at lists.cip-project.org
> Cc: Fabrizio Castro <fabrizio.castro@bp.renesas.com>; pavel at denx.de; nobuhiro1.iwamatsu at toshiba.co.jp
> Subject: [PATCH 4.4.y-cip] gpiolib: Fix invalid access of nullptr
> 
> Hi
> 
> There is a NULL pointer exception issue within the gpiolib of the CIP
> 4.4 kernel.
> The CIP kernel output and a patch that fix the invalid null pointer
> access are attached.
> 
> The vanilla 4.4 kernel is not affected by this bug, because this
> regression affects only CIP 4.4.176-cip32 or newer kernels that contain
> back ported code for the gpiolib. The upstream vanilla kernel contains
> similar code beginning with version 4.17.
> 
> The following commits introduce the new functionality for the CIP
> 4.4.176-cip32 kernel:
> gpiolib: Avoid calling chip->request() for unused gpios,
> ed4f40244354af7b19b3bae5c56cce2620877b7c
> gpiolib: Support 'gpio-reserved-ranges' property,
> baff4777cdb80256cd24dede2a3d0af761356307
> gpiolib: Extract mask allocation into subroutine,
> 171aad2d8519db9940d84e337da96aac8b1eb36c
> 
> Thank you.
> 
> --
> Best regards
> Stefan Koch
> 
> Siemens AG
> Digital Industries
> Process Automation
> Software House Nbg
> DI PA CI R&D 3
> Gleiwitzer Str. 555
> 90475 Nuernberg, Germany
> stefan-koch at siemens.com <mailto:stefan-koch@siemens.com>
> www.siemens.com/ingenuityforlife <https://siemens.com/ingenuityforlife>
> www.siemens.com/ingenuityforlife
> Siemens Aktiengesellschaft: Chairman of the Supervisory Board: Jim Hagemann Snabe; Managing Board: Joe Kaeser, Chairman,
> President and Chief Executive Officer; Roland Busch, Lisa Davis, Klaus Helmrich, Janina Kugel, Cedrik Neike, Michael Sen, Ralf P.
> Thomas; Registered offices: Berlin and Munich, Germany; Commercial registries: Berlin Charlottenburg, HRB 12300, Munich, HRB 6684;
> WEEE-Reg.-No. DE 23691322
> 
> 

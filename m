From: nobuhiro1.iwamatsu@toshiba.co.jp (nobuhiro1.iwamatsu at toshiba.co.jp)
Date: Wed, 4 Dec 2019 00:19:39 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip] gpiolib: Fix invalid access of
	nullptr
In-Reply-To: <TY1PR01MB177064C0DFD2CCE7D43B3BE4C0430@TY1PR01MB1770.jpnprd01.prod.outlook.com>
References: <14717888-518c-3643-b98e-4a052c14c102@siemens.com>
 <TY1PR01MB177064C0DFD2CCE7D43B3BE4C0430@TY1PR01MB1770.jpnprd01.prod.outlook.com>
Message-ID: <OSAPR01MB323449CF4631A8179A0EC6BE925D0@OSAPR01MB3234.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Fabrizio, Stefan,

> -----Original Message-----
> From: Fabrizio Castro [mailto:fabrizio.castro at bp.renesas.com]
> Sent: Tuesday, December 3, 2019 12:43 AM
> To: Koch, Stefan <stefan-koch@siemens.com>;
> cip-dev at lists.cip-project.org
> Cc: pavel at denx.de; iwamatsu nobuhiro(?? ?? ????????)
> <nobuhiro1.iwamatsu@toshiba.co.jp>; Chris Paterson
> <Chris.Paterson2@renesas.com>; Biju Das <biju.das@bp.renesas.com>
> Subject: RE: [PATCH 4.4.y-cip] gpiolib: Fix invalid access of nullptr
> 
> Hi Stefan,
> 
> That's a known problem, please have a  look at:
> https://patchwork.kernel.org/patch/11235267/
> 
> Pavel, Iwamatsu-san, could you please take patch:
> https://patchwork.kernel.org/patch/11235267/
> 
> I think this is quite urgent as others will stumble across the problem
> and will try and fix it.

OK, I will apply this with following comment if there is no other opinion.

NOTE: gpiochip_add_data()'s fixes is based on 6ff0497402ef7269ee6a72f62eb85adaa7a4768e.

Best regards,
  Nobuhiro

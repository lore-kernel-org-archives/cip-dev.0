From: nobuhiro1.iwamatsu@toshiba.co.jp (nobuhiro1.iwamatsu at toshiba.co.jp)
Date: Wed, 4 Dec 2019 23:21:24 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip] gpiolib: Fix invalid access of
	nullptr
In-Reply-To: <20191204123651.GA29179@duo.ucw.cz>
References: <14717888-518c-3643-b98e-4a052c14c102@siemens.com>
 <TY1PR01MB177064C0DFD2CCE7D43B3BE4C0430@TY1PR01MB1770.jpnprd01.prod.outlook.com>
 <OSAPR01MB323449CF4631A8179A0EC6BE925D0@OSAPR01MB3234.jpnprd01.prod.outlook.com>
 <20191204123651.GA29179@duo.ucw.cz>
Message-ID: <OSAPR01MB3234EEA22BD9140A30F7C375925D0@OSAPR01MB3234.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

> -----Original Message-----
> From: Pavel Machek [mailto:pavel at denx.de]
> Sent: Wednesday, December 4, 2019 9:37 PM
> To: iwamatsu nobuhiro(?? ?? ????????)
> <nobuhiro1.iwamatsu@toshiba.co.jp>
> Cc: fabrizio.castro at bp.renesas.com; stefan-koch at siemens.com;
> cip-dev at lists.cip-project.org; pavel at denx.de;
> Chris.Paterson2 at renesas.com; biju.das at bp.renesas.com
> Subject: Re: [PATCH 4.4.y-cip] gpiolib: Fix invalid access of nullptr
> 
> Hi!
> 
> > > That's a known problem, please have a  look at:
> > > https://patchwork.kernel.org/patch/11235267/
> > >
> > > Pavel, Iwamatsu-san, could you please take patch:
> > > https://patchwork.kernel.org/patch/11235267/
> > >
> > > I think this is quite urgent as others will stumble across the
> > > problem and will try and fix it.
> >
> > OK, I will apply this with following comment if there is no other opinion.
> >
> > NOTE: gpiochip_add_data()'s fixes is based on
> 6ff0497402ef7269ee6a72f62eb85adaa7a4768e.
> 
> Sounds good to me.

Applied.

Best regards,
  Nobuhiro

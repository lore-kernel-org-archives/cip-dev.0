From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 5 Dec 2019 10:04:09 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip] gpiolib: Fix invalid access of
	nullptr
In-Reply-To: <TYAPR01MB2285887DC9FCCC0BC1FAEB48B75C0@TYAPR01MB2285.jpnprd01.prod.outlook.com>
References: <14717888-518c-3643-b98e-4a052c14c102@siemens.com>
 <TY1PR01MB177064C0DFD2CCE7D43B3BE4C0430@TY1PR01MB1770.jpnprd01.prod.outlook.com>
 <OSAPR01MB323449CF4631A8179A0EC6BE925D0@OSAPR01MB3234.jpnprd01.prod.outlook.com>
 <20191204123651.GA29179@duo.ucw.cz>
 <OSAPR01MB3234EEA22BD9140A30F7C375925D0@OSAPR01MB3234.jpnprd01.prod.outlook.com>
 <TYAPR01MB2285887DC9FCCC0BC1FAEB48B75C0@TYAPR01MB2285.jpnprd01.prod.outlook.com>
Message-ID: <TY1PR01MB17708C10650375B7316F3199C05C0@TY1PR01MB1770.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Chris,

Thank you for your feedback!

> From: Chris Paterson <Chris.Paterson2@renesas.com>
> Sent: 05 December 2019 09:44
> To: nobuhiro1.iwamatsu at toshiba.co.jp; pavel at denx.de
> Cc: Fabrizio Castro <fabrizio.castro@bp.renesas.com>; stefan-koch at siemens.com; cip-dev at lists.cip-project.org; Biju Das
> <biju.das@bp.renesas.com>
> Subject: RE: [PATCH 4.4.y-cip] gpiolib: Fix invalid access of nullptr
> 
> Hello all,
> 
> > From: nobuhiro1.iwamatsu at toshiba.co.jp
> > <nobuhiro1.iwamatsu@toshiba.co.jp>
> > Sent: 04 December 2019 23:21
> >
> > > From: Pavel Machek [mailto:pavel at denx.de]
> > > Sent: Wednesday, December 4, 2019 9:37 PM
> > >
> > > Hi!
> > >
> > > > > That's a known problem, please have a  look at:
> > > > > https://patchwork.kernel.org/patch/11235267/
> > > > >
> > > > > Pavel, Iwamatsu-san, could you please take patch:
> > > > > https://patchwork.kernel.org/patch/11235267/
> > > > >
> > > > > I think this is quite urgent as others will stumble across the
> > > > > problem and will try and fix it.
> > > >
> > > > OK, I will apply this with following comment if there is no other opinion.
> > > >
> > > > NOTE: gpiochip_add_data()'s fixes is based on
> > > 6ff0497402ef7269ee6a72f62eb85adaa7a4768e.
> > >
> > > Sounds good to me.
> >
> > Applied.
> 
> This patch seems to have broken builds for 2/16 of our v4.4.y-cip configurations.
> Pipeline: https://gitlab.com/cip-project/cip-kernel/linux-cip/pipelines/100757773
> 
> 1) x86_plathome_obsvx1.config:  https://gitlab.com/cip-project/cip-kernel/linux-cip/-/jobs/369871332
> 
> Error log:
> 3274 drivers/gpio/gpiolib.c: In function 'gpiochip_add_data':
> 3275 drivers/gpio/gpiolib.c:363:12: error: 'struct gpio_chip' has no member named 'of_node'
> 3276   if ((!chip->of_node) && (chip->dev))
> 3277             ^~
> 3278 drivers/gpio/gpiolib.c:364:7: error: 'struct gpio_chip' has no member named 'of_node'
> 3279    chip->of_node = chip->dev->of_node;
> 3280        ^~
> 3281   CC      drivers/dma/ioat/prep.o
> 3282 scripts/Makefile.build:277: recipe for target 'drivers/gpio/gpiolib.o' failed
> 3283 make[2]: *** [drivers/gpio/gpiolib.o] Error 1
> 3284 scripts/Makefile.build:484: recipe for target 'drivers/gpio' failed
> 3285 make[1]: *** [drivers/gpio] Error 2
> 3286 make[1]: *** Waiting for unfinished jobs....
> 
> 
> 2) x86_siemens_iot2000.config: https://gitlab.com/cip-project/cip-kernel/linux-cip/-/jobs/369871333
> 
> Error log:
> 2729 drivers/gpio/gpiolib.c: In function 'gpiochip_add_data':
> 2730 drivers/gpio/gpiolib.c:363:12: error: 'struct gpio_chip' has no member named 'of_node'
> 2731   if ((!chip->of_node) && (chip->dev))
> 2732             ^~
> 2733 drivers/gpio/gpiolib.c:364:7: error: 'struct gpio_chip' has no member named 'of_node'
> 2734    chip->of_node = chip->dev->of_node;
> 2735        ^~
> 2736 scripts/Makefile.build:277: recipe for target 'drivers/gpio/gpiolib.o' failed
> 2737 make[2]: *** [drivers/gpio/gpiolib.o] Error 1
> 2738 make[1]: *** [drivers/gpio] Error 2
> 2739 make[1]: *** Waiting for unfinished jobs....
> 2740 scripts/Makefile.build:484: recipe for target 'drivers/gpio' failed

This makes a lot of sense, Intel would not have CONFIG_OF_GPIO set!
I'll send another version.

Thanks,
Fab

> 
> 
> Kind regards, Chris
> 
> >
> > Best regards,
> >   Nobuhiro

From: daniel.sangorrin@toshiba.co.jp (Daniel Sangorrin)
Date: Wed, 28 Jun 2017 17:57:55 +0900
Subject: [cip-dev] Renesas dev CIP repository announcement
In-Reply-To: <TY1PR06MB07026065C017B261EB74E3F8B7DD0@TY1PR06MB0702.apcprd06.prod.outlook.com>
References: <TY1PR06MB0702667AD2F56BEBDFFCF9A1B7C50@TY1PR06MB0702.apcprd06.prod.outlook.com>
	<001c01d2efbb$9603f410$c20bdc30$@toshiba.co.jp>
	<TY1PR06MB07026065C017B261EB74E3F8B7DD0@TY1PR06MB0702.apcprd06.prod.outlook.com>
Message-ID: <004201d2efec$a247cae0$e6d760a0$@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

> -----Original Message-----
> From: Chris Paterson [mailto:Chris.Paterson2 at renesas.com]
> Sent: Wednesday, June 28, 2017 2:47 PM
..
> >    - reboot doesn't seem to work (it works on the factory kernel 3.10).
> 
> This is a known issue that we currently have a workaround for. For development we could add this to [4], but it's a bit ugly.

OK. I think it's not so important, but it could help during CI testing to reboot the board in a soft manner.

> > By the way, do you have some test script to check that every module is
> > working fine?
> 
> Not at the moment, we are currently working on adding support for the CIP test framework, but this won't be ready for a while yet
> I'm afraid.

Maybe it would be nice to have them inside the kernel as kselftests.

Thanks,
Daniel

> 
> 
> [3] http://www.iwavesystems.com/downloads//products/cpu-modules/renesas/rz-g1m-q7-som/g20d-rz-g1m-som-block-diagram-
> R1.1.pdf
> [4] https://github.com/renesas-rz/renesas-cip
> 
> Kind regards, Chris
> 
> >
> > Thanks,
> > Daniel
> >

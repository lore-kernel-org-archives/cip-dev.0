From: daniel.sangorrin@toshiba.co.jp (Daniel Sangorrin)
Date: Thu, 29 Jun 2017 09:37:18 +0900
Subject: [cip-dev] Project-X (minimal root filesystem) for renesas board
In-Reply-To: <390B4EACA1A32748BA6BC7F859F7D7165D08C27D@GSJPOSKDCEMBX16.service.hitachi.net>
References: <001001d2efdc$d8312a30$88937e90$@toshiba.co.jp>
	<390B4EACA1A32748BA6BC7F859F7D7165D08C00F@GSJPOSKDCEMBX16.service.hitachi.net>
	<004101d2efeb$c53518b0$4f9f4a10$@toshiba.co.jp>
	<390B4EACA1A32748BA6BC7F859F7D7165D08C27D@GSJPOSKDCEMBX16.service.hitachi.net>
Message-ID: <003c01d2f06f$ddc420e0$994c62a0$@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Koguchi-san,

> -----Original Message-----
> From: ???? / KOGUCHI?TAKUO [mailto:takuo.koguchi.sw at hitachi.com]
> Sent: Wednesday, June 28, 2017 6:08 PM
> To: 'Daniel Sangorrin'; cip-dev at lists.cip-project.org
> Cc: 'Chris Paterson'
> Subject: RE: RE: Project-X (minimal root filesystem) for renesas board
> 
> Daniel-san,
> 
> > I think this is not a good approach. We would need to have a new linux-cip folder for each
> > release.
> Let make it clear. Will you please describe your recommendation?

Yes, please see below.
 
> > Patches for the cyclone board should be on its own CIP kernel repository (where you can
> > merge cip releases and add tags). Then, we can choose which version we want by
> > specifying the repository and tag/commit_id.
> Good point.  But  CIP kernel repository is curerntly used for release assuming it is tested. And CycloneV is not supported by CIP at this
> moment. So I put the patches in the yocto project way.

I didn't mean to put it on Ben's CIP repository rather on github. This way you can better maintain your "out-of-tree" cyclone V patches
and merge (do not rebase please) changes from Ben's CIP kernel regularly. In other words, do the same as Renesas is doing at [1].

[1] https://github.com/renesas-rz/renesas-cip

> > I don't think it is necessary since the CIP root filesystem only supports a few packages.
> > Do you mind if I rewrite this and other unnecessary definitions?
> I am happy if you go ahead and fix it!

OK, thanks. I will also separate Beaglebone from Cyclone V.

Thanks,
Daniel

> Best regards,
> Takuo Koguchi
> 
> 
> 
> > -----Original Message-----
> > From: Daniel Sangorrin [mailto:daniel.sangorrin at toshiba.co.jp]
> > Sent: Wednesday, June 28, 2017 5:52 PM
> > To: ???? / KOGUCHI?TAKUO; cip-dev at lists.cip-project.org
> > Cc: 'Chris Paterson'
> > Subject: [!]RE: Project-X (minimal root filesystem) for renesas board
> >
> > Ho Koguchi-san
> >
> > > -----Original Message-----
> > > From: ???? / KOGUCHI?TAKUO [mailto:takuo.koguchi.sw at hitachi.com]
> > > Sent: Wednesday, June 28, 2017 5:35 PM
> > > To: Daniel Sangorrin; cip-dev at lists.cip-project.org
> > > Cc: 'Chris Paterson'
> > > Subject: RE: Project-X (minimal root filesystem) for renesas board
> > >
> > > Hi Daniel-san,
> > >
> > > > I have a few questions:
> > > >   - Why do you have two directories "linux-cip" and "linux-cip2" that are almost
> > identical?
> > >
> > > linux-cip directory is for linux-4.4.55-cip3.
> > > linux-cip2 is for the previous release and it is not necessary if you update linux-cip.
> >
> > I think this is not a good approach. We would need to have a new linux-cip folder for each
> > release.
> >
> > Patches for the cyclone board should be on its own CIP kernel repository (where you can
> > merge cip releases and add tags). Then, we can choose which version we want by
> > specifying the repository and tag/commit_id.
> >
> > > >   - I can see some xserver-related definitions on the board's
> > > > configuration file. Are those necessary?
> > > beaglebone.conf is based on poky/meta-yocto-bsp/conf/machine.
> > > xserver-related definition was inculude in the original.  I am not sure if it is necessary.
> >
> > I don't think it is necessary since the CIP root filesystem only supports a few packages.
> > Do you mind if I rewrite this and other unnecessary definitions?
> >
> > Thanks,
> > Daniel
> >
> > >
> > >
> > > Takuo Koguchi
> > >
> > >
> > > > -----Original Message-----
> > > > From: Daniel Sangorrin [mailto:daniel.sangorrin at toshiba.co.jp]
> > > > Sent: Wednesday, June 28, 2017 4:05 PM
> > > > To: cip-dev at lists.cip-project.org; ???? / KOGUCHI?TAKUO
> > > > Cc: 'Chris Paterson'
> > > > Subject: [!]Project-X (minimal root filesystem) for renesas board
> > > >
> > > > Hi Koguchi-san,
> > > > Cc: Chris, cip-dev
> > > >
> > > > I'm going to add support to project-X for the Renesas iwg20m board
> > > > which is equipped with an armv7 chip.
> > > > I have noticed that you added support for beaglebone and cyclone on
> > > > the deby-armv7 folder [1].
> > > >
> > > > I have a few questions:
> > > >   - Why do you have two directories "linux-cip" and "linux-cip2" that are almost
> > identical?
> > > >   - I can see some xserver-related definitions on the board's
> > > > configuration file. Are those necessary?
> > > >
> > > > Thanks,
> > > > Daniel
> > > >
> > > > [1]
> > > > https://gitlab.com/cip-playground/project-x/tree/master/deby-armv7
> > > >
> >
> >

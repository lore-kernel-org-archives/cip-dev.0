From: nobuhiro1.iwamatsu@toshiba.co.jp (nobuhiro1.iwamatsu at toshiba.co.jp)
Date: Mon, 2 Sep 2019 01:46:06 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip v2 56/57] arm64: dts: Remove
 inconsistent use of 'arm, armv8' compatible string
In-Reply-To: <TYXPR01MB17754E8CA547CDCAC6559774C0BD0@TYXPR01MB1775.jpnprd01.prod.outlook.com>
References: <1566999164-27898-1-git-send-email-fabrizio.castro@bp.renesas.com>
	<1566999164-27898-57-git-send-email-fabrizio.castro@bp.renesas.com>
	<TY1PR01MB177044D5252F7954B4C9DF05C0BD0@TY1PR01MB1770.jpnprd01.prod.outlook.com>
	<20190830090958.GB18867@amd>
	<TYXPR01MB17754E8CA547CDCAC6559774C0BD0@TYXPR01MB1775.jpnprd01.prod.outlook.com>
Message-ID: <OSAPR01MB323422B4A92CC901B1550E1592BE0@OSAPR01MB3234.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Fabrizio,

> -----Original Message-----
> From: Fabrizio Castro [mailto:fabrizio.castro at bp.renesas.com]
> Sent: Friday, August 30, 2019 6:34 PM
> To: Pavel Machek <pavel@denx.de>
> Cc: iwamatsu nobuhiro(?? ?? ????????)
> <nobuhiro1.iwamatsu@toshiba.co.jp>; Chris Paterson
> <Chris.Paterson2@renesas.com>; Biju Das <biju.das@bp.renesas.com>;
> cip-dev at lists.cip-project.org
> Subject: RE: [cip-dev][PATCH 4.19.y-cip v2 56/57] arm64: dts: Remove
> inconsistent use of 'arm,armv8' compatible string
> 
> Hi Pavel,
> 
> > From: Pavel Machek <pavel@denx.de>
> > Sent: 30 August 2019 10:10
> > Subject: Re: [cip-dev][PATCH 4.19.y-cip v2 56/57] arm64: dts: Remove
> > inconsistent use of 'arm,armv8' compatible string
> >
> > Hi!
> >
> > > >It's not that important, but why is there a space between 'arm,'
> and 'armv8'
> > > >in subject?
> > > >Original subject does not have space.
> > >
> > > It is actually VERY, VERY, important, as the email I have sent out
> doesn't contain the space.
> > > I have even run hexdump on the patch file on my disk, it confirms
> there is no space.
> > > I am replying to my own email, and as you can see, there is no
> > >space.
> >
> > Can you take a look at the email, as received from the mailinglist?
> I
> > see a space in subject, between 'arm,' and 'armv8'.
> 
> Interesting...
> 
> >
> > Can you send the original email, as a binary attachment?
> 
> I use git send-email, therefore unfortunately I don't have the original
> email.
> I have attached the email msg as received from my email client, and the
> patch file.
> It doesn't look like there is a space there...
> 

Hmm, what do you use smtp server? There may be a problem with the SMTP server.

> In both cases:
> * "arm64: dts: Remove inconsistent use of 'arm,armv8' compatible string",
> and
> * "soc: renesas: rcar-sysc: Remove rcar_sysc_power_{down,up}() helpers"
> it seems like a space was added after the comma, like autocorrect programs
> would do...
> 
> Has anybody seen this before?
> 

I've easily checked.
The pinctrl patch sent last week seems to have the same problem.
e.g. https://lists.cip-project.org/pipermail/cip-dev/2019-August/002988.html

bd3eb391f0fc pinctrl: sh-pfc: r8a77995: Remove unused PINMUX_IPSR_{MSEL2, PHYS}()
f2be905d124b pinctrl: sh-pfc: rcar-gen3: Rename RTS{0, 1, 3, 4}# pin function definitions
db4bd73cbd2c pinctrl: sh-pfc: rcar-gen3: Rename SEL_ADG_{A, B, C} to SEL_ADG{A, B, C}
c50668864e27 pinctrl: sh-pfc: r8a7796: Add I2C{0, 3, 5} pins, groups and functions

> Thanks,
> Fab


Best regards,
  Nobuhiro

> 
> >
> > > >The following patch have similar problem.
> > > >soc: renesas: rcar-sysc: Remove rcar_sysc_power_{down, up}()
> > > >helpers
> > >
> > > Same thing here, there is no space in the email I have sent out,
> > > which means it's probably down to patchwork? Somehow a space gets
> > > automatically added, I wonder if this is happening with the code too?
> > >
> > > How do we find out if the problem is with patchwork?
> >
> > I don't think patchwork is responsible. It would have to be something
> > in the mailing list.
> >
> > Best regards,
> > 								Pavel
> >
> > --
> > DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> > HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

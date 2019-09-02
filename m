From: pavel@denx.de (Pavel Machek)
Date: Mon, 2 Sep 2019 10:32:06 +0200
Subject: [cip-dev] [PATCH 4.19.y-cip v2 56/57] arm64: dts: Remove
 inconsistent use of 'arm, armv8' compatible string
In-Reply-To: <TY1PR01MB1770994DB296627BFAE7C6D7C0BE0@TY1PR01MB1770.jpnprd01.prod.outlook.com>
References: <1566999164-27898-1-git-send-email-fabrizio.castro@bp.renesas.com>
	<1566999164-27898-57-git-send-email-fabrizio.castro@bp.renesas.com>
	<TY1PR01MB177044D5252F7954B4C9DF05C0BD0@TY1PR01MB1770.jpnprd01.prod.outlook.com>
	<20190830090958.GB18867@amd>
	<TYXPR01MB17754E8CA547CDCAC6559774C0BD0@TYXPR01MB1775.jpnprd01.prod.outlook.com>
	<OSAPR01MB323422B4A92CC901B1550E1592BE0@OSAPR01MB3234.jpnprd01.prod.outlook.com>
	<TY1PR01MB1770994DB296627BFAE7C6D7C0BE0@TY1PR01MB1770.jpnprd01.prod.outlook.com>
Message-ID: <20190902083206.GA19557@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!


> > Hmm, what do you use smtp server? There may be a problem with the SMTP server.
> 
> I am using Renesas' SMTP server, I have been using the same server for the past two
> years, and this is the first time I have seen this problem.
> 
> > 
> > > In both cases:
> > > * "arm64: dts: Remove inconsistent use of 'arm,armv8' compatible string",
> > > and
> > > * "soc: renesas: rcar-sysc: Remove rcar_sysc_power_{down,up}() helpers"
> > > it seems like a space was added after the comma, like autocorrect programs
> > > would do...
> > >
> > > Has anybody seen this before?
> > >
> > 
> > I've easily checked.
> > The pinctrl patch sent last week seems to have the same problem.
> > e.g. https://lists.cip-project.org/pipermail/cip-dev/2019-August/002988.html
> > 
> > bd3eb391f0fc pinctrl: sh-pfc: r8a77995: Remove unused PINMUX_IPSR_{MSEL2, PHYS}()
> > f2be905d124b pinctrl: sh-pfc: rcar-gen3: Rename RTS{0, 1, 3, 4}# pin function definitions
> > db4bd73cbd2c pinctrl: sh-pfc: rcar-gen3: Rename SEL_ADG_{A, B, C} to SEL_ADG{A, B, C}
> > c50668864e27 pinctrl: sh-pfc: r8a7796: Add I2C{0, 3, 5} pins, groups and functions
> 
> All those patches look ok in my inbox. I put myself in CC when sending out emails with
> git send-email, therefore whatever I send out with git send-email reaches my inbox
> before the mailing list daemon has the chance to forward the emails to my account, I
> wonder if the problem is with the mailing list?

That should be easy to test. Feel free to send a test patch to a
mailing list, ccing us directly....

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
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190902/50a42a41/attachment.sig>

From: pavel@denx.de (Pavel Machek)
Date: Thu, 29 Aug 2019 11:47:51 +0200
Subject: [cip-dev] [PATCH/RFC 4.19.y-cip 00/41] Fast forward sh-pfc
In-Reply-To: <TY1PR01MB1770129C698AAE461CFCE4FDC0A20@TY1PR01MB1770.jpnprd01.prod.outlook.com>
References: <1566991328-25476-1-git-send-email-fabrizio.castro@bp.renesas.com>
	<20190829081221.GD10041@amd>
	<TY1PR01MB1770129C698AAE461CFCE4FDC0A20@TY1PR01MB1770.jpnprd01.prod.outlook.com>
Message-ID: <20190829094751.GB20258@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> > > they have made good progress upstream with the development of sh-pfc,
> > > and although the functionality of the drivers hasn't changed much,
> > > the code looks fairly different. This means that backporting patches
> > > to SoC specific driver files will be increasingly hard and error
> > > prone, unless we fast-forward the code base for 4.19.y-cip, hence
> > > this series.
> > > What do you gus think? Comments welcome!
> > 
> > I reviewed the patches... and it is interesting how much magic can be
> > done with preprocessor.
> 
> I thought the same thing!

> > I do not see anything preventing the merge, but they were marked [rfc]
> > so I'm not doing that yet. Let me know if I should.
> 
> Since nothing nasty was spotted during code review and it works ok, I believe
> merging this series could really help us with future development, so yes
> please, go ahead and merge.

Ok, merged, and pushed out.

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
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190829/fec3b04c/attachment.sig>

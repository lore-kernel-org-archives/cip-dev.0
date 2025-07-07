Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAFF9C8303C
	for <webhook@archiver.kernel.org>; Mon,  7 Jul 2025 09:33:48 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.55936.1751880823319138261
 for <cip-dev@lists.cip-project.org>;
 Mon, 07 Jul 2025 02:33:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=X4dsmU3l;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 77B1B10380104;
	Mon,  7 Jul 2025 11:33:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1751880821; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=jdiHbC0WMdhNX5yfI50CWI0VoJ1aTWRECzYdSNGV93Q=;
	b=X4dsmU3lDH+eNDbZLA6xI39SrLoSAsLCanXpBQn9p6+mAl6t6fnAYVt2zgYQQekSRS9oxM
	n0YtwSCAOJj1cCK06/F3RsHS+a+JTBgqmi/ZvsI2KFTl2WRJvy1e6WhvnDDt3W126dTlDP
	yIs4lOGFhCAXwvD7uXT6hBx83nQBvd95PpMmayghsPniQ9UTPQ98EhndVBWk5JBXH4jDbh
	mpFsUVUSCxYe42vkVyvBTXPOYpHAvm8kePKNfkvolIiJhoAEna5mkaWwQhX993Z+u2gDfM
	V9tP5OVsZXu5M4plZ+UDkf/GX2Sov/ZZRfJheWd2d7iqAQVsHDaNn/KjSWDOXg==
Date: Mon, 7 Jul 2025 11:33:34 +0200
From: Pavel Machek <pavel@denx.de>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [PATCH 6.12.y-cip 00/18] Add Support for RZ/G3E ICU
Message-ID: <aGuUbnconUaEIATw@duo.ucw.cz>
References: <20250704090724.669848-1-tommaso.merciai.xr@bp.renesas.com>
 <aGgZqPAT9QADIQZr@duo.ucw.cz>
 <aGuKC8cWBN-B2SIa@tom-desktop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kWTh0KhIOAx9c0qs"
Content-Disposition: inline
In-Reply-To: <aGuKC8cWBN-B2SIa@tom-desktop>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 07 Jul 2025 09:33:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19379


--kWTh0KhIOAx9c0qs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2025-07-07 10:49:15, Tommaso Merciai wrote:
> Hi Pavel,
> Thanks for your work!
>=20
> On Fri, Jul 04, 2025 at 08:12:56PM +0200, Pavel Machek wrote:
> > Hi!
> >=20
> > > This series adds support for the RZ/G3E ICU driver into linux 6.12.y-=
cip.
> > >=20
> > > The ICU block on the RZ/G3E SoC is almost identical to the one found =
on
> > > the RZ/V2H SoC, with the following differences:
> > >  - The TINT register base offset is 0x800 instead of zero.
> > >  - The number of supported GPIO interrupts for TINT selection is 141
> > >    instead of 86.
> > >  - The pin index and TINT selection index are not in the 1:1 map
> > >  - The number of TSSR registers is 16 instead of 8
> > >  - Each TSSR register can program 2 TINTs instead of 4 TINTs
> > >=20
> > > This series applies on top of [1]
> > >=20
> > > [1] https://patchwork.kernel.org/project/cip-dev/list/?series=3D97815=
0&state=3D%2A&archive=3Dboth
> >=20
> > Series looks ok to me.
> >=20
> > I'll have some minor comments but nothing that should prevent
> > merge... so I can merge this if it passes testing and there are no
> > other comments.
> >=20
> > One thing: "Signed-off-by:" section should not have empty lines in
> > that. I guess we can fix that up doing merge.
>=20
> Sorry for that and thanks for taking care of this.
> Tbh I'm just using "git commit -s" to apply upstream patches.
> Any suggestion? Thanks in advance.
>=20
> Maybe I have somenthing wrong in my configuration :'(

I guess git rebase -i to manually edit the changelogs is easiest
option there.

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--kWTh0KhIOAx9c0qs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaGuUbgAKCRAw5/Bqldv6
8oQdAJ9h4Zu9Mn09KOkz5C/SilnvuzEKUwCgtXyE4XwC6PBk97PLlhM0HyW/v+8=
=lyeA
-----END PGP SIGNATURE-----

--kWTh0KhIOAx9c0qs--


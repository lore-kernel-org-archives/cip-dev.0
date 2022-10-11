Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B3EC433F5
	for <webhook@archiver.kernel.org>; Tue, 11 Oct 2022 11:24:00 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web08.5919.1665487436087500379
 for <cip-dev@lists.cip-project.org>;
 Tue, 11 Oct 2022 04:23:57 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 74B3D1C002C; Tue, 11 Oct 2022 13:23:52 +0200 (CEST)
Date: Tue, 11 Oct 2022 13:23:51 +0200
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: biju.das.jz@bp.renesas.com, cip-dev@lists.cip-project.org,
	pavel@denx.de, chris.paterson2@renesas.com, biju.das@bp.renesas.com
Subject: Re: [PATCH 5.10.y-cip] ASoC: sh: rz-ssi: Improve error handling in
 rz_ssi_probe() error path
Message-ID: <20221011112351.GA10593@duo.ucw.cz>
References: <20221010173833.1375381-1-biju.das.jz@bp.renesas.com>
 <TYWPR01MB94209F22CB57D9DD527D3FDE92239@TYWPR01MB9420.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
In-Reply-To: 
 <TYWPR01MB94209F22CB57D9DD527D3FDE92239@TYWPR01MB9420.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Oct 2022 11:24:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9712


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > We usually do cleanup in reverse order of init. Currently in case of er=
ror
> > rz_ssi_release_dma_channels() done in the reverse order. This patch imp=
roves
> > error handling in rz_ssi_probe() error path.
> >=20
> > While at it, use "goto cleanup" style to reduce code duplication.
> >=20
> > Reported-by: Pavel Machek <pavel@denx.de>
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > Link:
> > https://lore.kernel.org/r/20220728092612.38858-1-biju.das.jz@bp.renesas=
=2Eco
> > m
> > Signed-off-by: Mark Brown <broonie@kernel.org>
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > ---
> >  sound/soc/sh/rz-ssi.c | 26 +++++++++++++++-----------
> >  1 file changed, 15 insertions(+), 11 deletions(-)
>=20
> Looks good to me this patch.
> If there are no other comments, I can apply.
>=20
> Test:
> > https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/6635486=
93

Looks ok to me:

Reviewed-by: Pavel Machek <pavel@denx.de>

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY0VSRwAKCRAw5/Bqldv6
8iTeAJ9Jxn0GquCec8FLW7yA61R9llU39QCfePLVro2QfM5+1p+EmBaCI5H49Sw=
=0rJy
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--


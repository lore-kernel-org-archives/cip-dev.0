Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49FBDC77B75
	for <webhook@archiver.kernel.org>; Tue, 16 May 2023 11:49:52 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.19590.1684237784574400974
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 May 2023 04:49:45 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id F22921C0E50; Tue, 16 May 2023 13:49:41 +0200 (CEST)
Date: Tue, 16 May 2023 13:49:41 +0200
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: biju.das.jz@bp.renesas.com, cip-dev@lists.cip-project.org,
	pavel@denx.de, chris.paterson2@renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: Re: [PATCH 5.10.y-cip 0/4] Add RZ/G2L DMA Reset support
Message-ID: <ZGNt1dMIadgRLbmM@duo.ucw.cz>
References: <20230515085352.25794-1-biju.das.jz@bp.renesas.com>
 <TYWPR01MB94208EECEE9BAB87C9725F8692789@TYWPR01MB9420.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ft0JGk5KIHumdsQY"
Content-Disposition: inline
In-Reply-To: <TYWPR01MB94208EECEE9BAB87C9725F8692789@TYWPR01MB9420.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 May 2023 11:49:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11467


--ft0JGk5KIHumdsQY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > This patch series aims to add DMA reset support fot RZ/G2L alike SoCs
> >=20
> > Also added a patch to remove unused variable.
> >=20
> > All these patches are cherry-picked from the mainline.
> >=20
> > Biju Das (3):
> >   dt-bindings: dma: rz-dmac: Document clock-names and reset-names
> >   dmaengine: sh: rz-dmac: Add reset support
> >   arm64: dts: renesas: rzg2l: Add clock-names and reset-names to DMAC
> >     nodes
> >=20
> > Geert Uytterhoeven (1):
> >   dmaengine: sh: rz-dmac: Remove unused rz_dmac_chan.*_word_size
> >=20
> This series LGTM. I can apply this series.
>=20
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Patches passed my review, too, and they pass testing, so I added your
reviewed-by tag and applied the series.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--ft0JGk5KIHumdsQY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZGNt1QAKCRAw5/Bqldv6
8jCLAJ41i+A0VLoyy/xlPC8AZcXclOxOewCdHAc6LEIg8OJHl1UM5IQQ7QBob3E=
=Sxa8
-----END PGP SIGNATURE-----

--ft0JGk5KIHumdsQY--


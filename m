Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED1BC38145
	for <webhook@archiver.kernel.org>; Tue,  6 Sep 2022 08:37:04 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.1638.1662453418023337842
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Sep 2022 01:36:59 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id B14711C0004; Tue,  6 Sep 2022 10:36:54 +0200 (CEST)
Date: Tue, 6 Sep 2022 10:36:54 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Chris Paterson <chris.paterson2@renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 4.19.y-cip] drm: rcar-du: Fix Alpha blending issue on Gen3
Message-ID: <20220906083654.GD19021@duo.ucw.cz>
References: <20220830145938.1326295-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NtwzykIc2mflq5ck"
Content-Disposition: inline
In-Reply-To: <20220830145938.1326295-1-biju.das.jz@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Sep 2022 08:37:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9469


--NtwzykIc2mflq5ck
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: LUU HOAI <hoai.luu.ub@renesas.com>
>=20
> commit b7aaa61726cbc7b941007af14a9f991a828c67e4 upstream.
>=20
> As per R-Car-Gen3_Common_OPC_Customer_Notifications_V30.1.pdf,
> unexpected image output(such as incorrect colors or planes being
> invisible) can happen on the below conditions, as PnALPHAR register
> is not initialized by reset.

Thank you, applied.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--NtwzykIc2mflq5ck
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYxcGpgAKCRAw5/Bqldv6
8onIAJ9ahfBbc8k7IyuiCCx8HDtf2vqmhgCfckIji/bZfPmAlSsKZHofMZ0t0+8=
=GFWC
-----END PGP SIGNATURE-----

--NtwzykIc2mflq5ck--


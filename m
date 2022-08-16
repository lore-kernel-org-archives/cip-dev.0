Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 277EEC25B0E
	for <webhook@archiver.kernel.org>; Tue, 16 Aug 2022 11:44:28 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.14578.1660650262717638293
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Aug 2022 04:44:23 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 82C3F1C0001; Tue, 16 Aug 2022 13:44:19 +0200 (CEST)
Date: Tue, 16 Aug 2022 13:44:08 +0200
From: Pavel Machek <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 0/4] Renesas SDHI/DMA/thermal driver fixes and
 improvements
Message-ID: <20220816114408.GA27428@duo.ucw.cz>
References: <20220815163718.24056-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
In-Reply-To: <20220815163718.24056-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Aug 2022 11:44:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9217


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series backports SDHI/DMA/thermal driver fixes and
> improvements.
>=20
> Note: All the patches have been cherry picked from 6.0-rc1 kernel.

Series looks okay to me. I wonder if we have code using
rz_dmac_device_synchronize from 4/4 in the tree?

I can apply the patches if they pass testing and if there are no other
comments.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYvuDCAAKCRAw5/Bqldv6
8v9QAJ944yCqrpTCXo+mYTNO32njevyzsACfTqPOpHOV/gzvjtMfKaT25jcBWx0=
=RaIX
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--


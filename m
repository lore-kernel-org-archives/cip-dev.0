Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 745E0C433EF
	for <webhook@archiver.kernel.org>; Thu, 31 Mar 2022 10:16:10 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.5414.1648721766614328503
 for <cip-dev@lists.cip-project.org>;
 Thu, 31 Mar 2022 03:16:07 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 8D8CB1C0B96; Thu, 31 Mar 2022 12:16:04 +0200 (CEST)
Date: Thu, 31 Mar 2022 12:16:03 +0200
From: Pavel Machek <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 13/39] mmc: renesas_internal_dmac: add pre_req
 and post_req support
Message-ID: <20220331101603.GC21513@amd>
References: <20220330185454.10887-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220330185454.10887-14-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R+My9LyyhiUvIEro"
Content-Disposition: inline
In-Reply-To: <20220330185454.10887-14-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 31 Mar 2022 10:16:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7897


--R+My9LyyhiUvIEro
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> commit 69e7d76afdb54243df957351804c0f1afca46d0f upstream.
>=20
> Add pre_req and post_req support to improve performance.
>=20
> Inspired by a patch in the BSP by Masaharu Hayakawa.
>=20

> +/*
> + * renesas_sdhi_internal_dmac_map() will be called with two difference

"two different"?

> +	/* This DMAC cannot handle if buffer is not 128-bytes alignment */

"aligned"?

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--R+My9LyyhiUvIEro
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmJFf2MACgkQMOfwapXb+vL+mwCgw4FbozuOEZmYPjl2Gl87NKXl
/v8AmwajCTG6iqA9UBg/5ay1yt3/ZCrI
=xkBS
-----END PGP SIGNATURE-----

--R+My9LyyhiUvIEro--


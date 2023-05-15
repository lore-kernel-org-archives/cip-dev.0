Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C3AC77B75
	for <webhook@archiver.kernel.org>; Mon, 15 May 2023 20:26:44 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.1449.1684182397994798853
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 May 2023 13:26:38 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 60C5D1C0E4B; Mon, 15 May 2023 22:26:36 +0200 (CEST)
Date: Mon, 15 May 2023 22:26:35 +0200
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, Sai <Sai.Sathujoda@toshiba-tsip.com>,
	dinesh.kumar@toshiba-tsip.com
Subject: Re: [cip-dev] [cip-kernel-config] 5.10.y-cip/arm : Add support for
 access control lists.
Message-ID: <ZGKVe5ctFMEEnj/5@duo.ucw.cz>
References: <20230515121256.14413-1-Sai.Sathujoda@toshiba-tsip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fRKNY2e1zEsTsnoT"
Content-Disposition: inline
In-Reply-To: <20230515121256.14413-1-Sai.Sathujoda@toshiba-tsip.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 May 2023 20:26:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11457


--fRKNY2e1zEsTsnoT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Sai <Sai.Sathujoda@toshiba-tsip.com>
>=20
> These configs are required for acl package to work
> which is used for IEC-62443-4-2 evaluation.
>=20
> Signed-off-by: Sai <Sai.Sathujoda@toshiba-tsip.com>

Seems okay to me. We'll need to apply similar changes to 6.1.

If we have ext4, do we need ext2 and ext3? IIRC ext4 can serve as both
of those.

Best regards,
								Pavel
							=09
> +++ b/5.10.y-cip/arm/qemu_arm_defconfig
> @@ -149,6 +149,8 @@ CONFIG_EXT2_FS=3Dy
>  CONFIG_EXT2_FS_XATTR=3Dy
>  CONFIG_EXT2_FS_POSIX_ACL=3Dy
>  CONFIG_EXT3_FS=3Dy
> +CONFIG_EXT4_FS=3Dy
> +CONFIG_EXT4_FS_POSIX_ACL=3Dy
> +CONFIG_TMPFS_POSIX_ACL=3Dy
>  CONFIG_AUTOFS4_FS=3Dy
>  CONFIG_FUSE_FS=3Dm
>  CONFIG_OVERLAY_FS=3Dm


--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--fRKNY2e1zEsTsnoT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZGKVewAKCRAw5/Bqldv6
8jNxAJwNYnaz4xqMlvhkTPo1XFy84hYxyACeLWm0QZQCQc9qXiNGYolXVuQs8oA=
=LF7U
-----END PGP SIGNATURE-----

--fRKNY2e1zEsTsnoT--


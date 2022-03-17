Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A568FC433F5
	for <webhook@archiver.kernel.org>; Thu, 17 Mar 2022 09:58:09 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.8242.1647511088332109456
 for <cip-dev@lists.cip-project.org>;
 Thu, 17 Mar 2022 02:58:09 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 8C4A61C0B7F; Thu, 17 Mar 2022 10:58:04 +0100 (CET)
Date: Thu, 17 Mar 2022 10:58:03 +0100
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org, nobuhiro1.iwamatsu@toshiba.co.jp,
	masami.ichikawa@miraclelinux.com, Chris.Paterson2@renesas.com
Subject: Disabling XEN in our configs (used by QEMU and Renesas)
Message-ID: <20220317095803.GA2237@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 17 Mar 2022 09:58:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7775


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

There is bunch of XEN security fixes in the pipeline:

CVE-2022-23036, CVE-2022-23037, CVE-2022-23038, CVE-2022-23039,
CVE-2022-23040 : Xen: fix race conditions, resulting in potential data
leaks, data corruption, DoS by malicious backends

CVE-2022-23041: Xen: fix race conditions, resulting in potential data
leaks, data corruption, DoS by malicious backends

CVE-2022-23042: Xen: fix race conditions, resulting in potential data
leaks, data corruption, DoS by malicious backends

There's a bunch of patches fixing those, but backporting them to 4.4
would not be exactly easy. Our scripts show XEN as being used, but I
suspect that's a mistake.

Reneasas, can you confirm if you are using XEN in your arm64 products?
If not, it would be good to disable it in the configs.

Could we disable XEN in qemu configs? I don't believe it makes much
sense.

=2E/4.19.y-cip/arm64/qemu_arm64_defconfig:CONFIG_XEN=3Dy
=2E/4.19.y-cip/arm64/qemu_arm64_defconfig:CONFIG_XEN_GNTDEV=3Dy
=2E/4.19.y-cip/arm64/qemu_arm64_defconfig:CONFIG_XEN_GRANT_DEV_ALLOC=3Dy
=2E/4.19.y-cip/arm64/renesas_defconfig:CONFIG_XEN=3Dy
=2E/5.10.y-cip/arm64/qemu_arm64_defconfig:CONFIG_XEN=3Dy
=2E/5.10.y-cip/arm64/qemu_arm64_defconfig:CONFIG_XEN_GNTDEV=3Dy
=2E/5.10.y-cip/arm64/qemu_arm64_defconfig:CONFIG_XEN_GRANT_DEV_ALLOC=3Dy
=2E/5.10.y-cip/arm64/renesas_defconfig:CONFIG_XEN=3Dy
=2E/4.19.y-cip-rt/arm64/renesas-rt_defconfig:CONFIG_XEN=3Dy
=2E/5.10.y-cip-rt/arm64/renesas-rt_defconfig:CONFIG_XEN=3Dy

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmIzBisACgkQMOfwapXb+vJiVACgrrw0gV3mAe4/WXSdZJPmsprz
QlQAn0s/v5eiX/UaX0KhO3uov07IfAmA
=nMDj
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--


Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EFAFC25B67
	for <webhook@archiver.kernel.org>; Fri, 27 Oct 2023 11:51:46 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.4920.1698407504077973626
 for <cip-dev@lists.cip-project.org>;
 Fri, 27 Oct 2023 04:51:44 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 485DC1C0077; Fri, 27 Oct 2023 13:51:42 +0200 (CEST)
Date: Fri, 27 Oct 2023 13:51:41 +0200
From: Pavel Machek <pavel@denx.de>
To: Chris.Paterson2@renesas.com, cip-dev@lists.cip-project.org
Subject: Testing 4.4.302-cip80-rt46 fails at
 test:x86_cip_qemu_defconfig_release
Message-ID: <ZTukTXjiIS2M4t3c@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="B3gIxeDCwcU45+PE"
Content-Disposition: inline
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 27 Oct 2023 11:51:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13475


--B3gIxeDCwcU45+PE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I'm preparing 4.4-cip-rt release, and I'm getting test failure:

https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/1050438468

Has anything changed recently w.r.t. testing? I don't seem to remember
test:x86_cip_qemu_defconfig_release variant.

Could someone look at the tests and help me analyze the failure?

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--B3gIxeDCwcU45+PE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZTukTQAKCRAw5/Bqldv6
8tBTAJsEzRIezt/yb80zqMAqcFW+6uqsNQCfbdUP8MTTdkChrgIKsOPDPsV0l/Y=
=MODE
-----END PGP SIGNATURE-----

--B3gIxeDCwcU45+PE--


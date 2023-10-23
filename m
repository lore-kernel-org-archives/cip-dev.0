Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80647C001E0
	for <webhook@archiver.kernel.org>; Mon, 23 Oct 2023 06:21:19 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.114740.1698042073496738067
 for <cip-dev@lists.cip-project.org>;
 Sun, 22 Oct 2023 23:21:14 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id EF9301C0050; Mon, 23 Oct 2023 08:21:09 +0200 (CEST)
Date: Mon, 23 Oct 2023 08:21:09 +0200
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org, nobuhiro1.iwamatsu@toshiba.co.jp
Subject: 6.1.59
Message-ID: <ZTYQ1dStV2p0A8GB@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XfjqE+3yCWzqxU6I"
Content-Disposition: inline
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 Oct 2023 06:21:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13432


--XfjqE+3yCWzqxU6I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

There's 6.1.59 out, and it would be nice to have matching -cip
release, so that I could do -cip-rt.

Alternatively.. maybe I could try to do the regular -cip release just
to test out the process?

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--XfjqE+3yCWzqxU6I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZTYQ1QAKCRAw5/Bqldv6
8tdgAJ0WEGjaeC/jMG3+swYva8oBn7X5jgCfcJQzE60ay+ZKIcL+aUOF3TQmLWY=
=C2QU
-----END PGP SIGNATURE-----

--XfjqE+3yCWzqxU6I--


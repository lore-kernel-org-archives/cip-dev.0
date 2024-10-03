Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E98CF34A9
	for <webhook@archiver.kernel.org>; Thu,  3 Oct 2024 12:51:43 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.10505.1727959900224478265
 for <cip-dev@lists.cip-project.org>;
 Thu, 03 Oct 2024 05:51:40 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 06ABA1C00B3; Thu,  3 Oct 2024 14:51:37 +0200 (CEST)
Date: Thu, 3 Oct 2024 14:51:36 +0200
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org, Chris.Paterson2@renesas.com
Subject: -stable testing
Message-ID: <Zv6TWPUWmre9eyXh@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x4jjDlGesmR+cgA4"
Content-Disposition: inline
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 03 Oct 2024 12:51:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16993


--x4jjDlGesmR+cgA4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I'd like to test 6.6.54-rc2, but it does not seem to be mirrored in
gitlab, at the moment.

Plus, would it be possible to start testing 6.11 and 6.12?

Thanks and best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--x4jjDlGesmR+cgA4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZv6TWAAKCRAw5/Bqldv6
8vCVAJ497HQKM3QFt0L5P3VDuScLpea1lgCgsTaITH5CMpSZjSJR8ptDthN+KLc=
=4PIX
-----END PGP SIGNATURE-----

--x4jjDlGesmR+cgA4--


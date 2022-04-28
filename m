Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BECF1C433F5
	for <webhook@archiver.kernel.org>; Thu, 28 Apr 2022 17:14:16 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.359.1651166047136360971
 for <cip-dev@lists.cip-project.org>;
 Thu, 28 Apr 2022 10:14:07 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 528E31C0B8E; Thu, 28 Apr 2022 19:14:02 +0200 (CEST)
Date: Thu, 28 Apr 2022 19:14:01 +0200
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp, cip-dev@lists.cip-project.org
Subject: 4.19 oopses on socfpga
Message-ID: <20220428171401.GA30032@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 28 Apr 2022 17:14:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8227


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

There's oops during boot on socfpga:

4.19.240-cip72-00010-g0ffbb4b1066 -- https://lava.ciplatform.org/scheduler/=
job/669893
4.19.240-rc1-g5e5c9d690926 -- https://lava.ciplatform.org/scheduler/job/669=
259

This commit may be relevant:

commit e2423aa174e6c3e9805e96db778245ba73cdd88c
    net: ethernet: stmmac: fix altr_tse_pcs function when using a fixed-link
    [ Upstream commit a6aaa00324240967272b451bfa772547bd576ee6 ]

Let me investigate a bit more.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYmrLWQAKCRAw5/Bqldv6
8iwjAJ9HBmUt9jMcLYBtZ+UpXPMkYeS17ACgso/JdsuOm+9W549vbA2fs+Zgv6Y=
=drK7
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--


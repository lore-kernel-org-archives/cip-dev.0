Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98139CF9C5B
	for <webhook@archiver.kernel.org>; Mon, 23 Sep 2024 07:48:51 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.31411.1727077724721232027
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Sep 2024 00:48:45 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 5B5E61C009E; Mon, 23 Sep 2024 09:48:41 +0200 (CEST)
Date: Mon, 23 Sep 2024 09:48:40 +0200
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp, cip-dev@lists.cip-project.org
Subject: -cip version corresponding to 4.19.322-rt138
Message-ID: <ZvEdWAvSziP2CXqP@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5nXxPUdnFnTSocc4"
Content-Disposition: inline
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 Sep 2024 07:48:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16911


--5nXxPUdnFnTSocc4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Could I get 4.19.322-cip release? I'd like to do -rt
release. Alternatively, if it is not a problem, I can just do release
myself.

Thanks and best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--5nXxPUdnFnTSocc4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZvEdWAAKCRAw5/Bqldv6
8ts4AKCYzFefw59Z7bJpvz+L+ODGKK60YQCgi/UUaklpF0MZL0m4aAtkyldjp8E=
=byJr
-----END PGP SIGNATURE-----

--5nXxPUdnFnTSocc4--


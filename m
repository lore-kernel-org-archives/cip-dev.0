Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C94C7C43219
	for <webhook@archiver.kernel.org>; Tue,  8 Nov 2022 18:47:53 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.1019.1667933264469798730
 for <cip-dev@lists.cip-project.org>;
 Tue, 08 Nov 2022 10:47:45 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id B18941C09D7; Tue,  8 Nov 2022 19:47:40 +0100 (CET)
Date: Tue, 8 Nov 2022 19:47:40 +0100
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 0/3] SDHI Fixes/enhancements
Message-ID: <Y2qkTO5o6a05sDI4@duo.ucw.cz>
References: <20221108125630.3853219-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nao2myadeA60MRTY"
Content-Disposition: inline
In-Reply-To: <20221108125630.3853219-1-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 08 Nov 2022 18:47:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9948


--nao2myadeA60MRTY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series aims to add rounding error fixes for selecting
> 533MHz SDHI source clk and avoid glitches when resetting.

Series looks okay to me, and it looks like it will pass testing, too.

If there are no other comments, I can apply it. (But I guess I'll wait
for 5.10-cip kernel to be released, first, in order not to interfere
with the release).

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--nao2myadeA60MRTY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY2qkTAAKCRAw5/Bqldv6
8jzVAJ9QWOg/FhSUv2mxgP17MqueLmLIMgCgkPU0cuxk45sJN8wVAWd5/fphlE0=
=/oLf
-----END PGP SIGNATURE-----

--nao2myadeA60MRTY--


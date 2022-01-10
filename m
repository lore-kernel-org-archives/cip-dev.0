Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11928C433F5
	for <webhook@archiver.kernel.org>; Mon, 10 Jan 2022 17:55:26 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web09.35432.1641837323551813416
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Jan 2022 09:55:24 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id EE4661C0B76; Mon, 10 Jan 2022 18:55:19 +0100 (CET)
Date: Mon, 10 Jan 2022 18:55:19 +0100
From: Pavel Machek <pavel@denx.de>
To: Amy Fong <Amy_Fong@mentor.com>
Cc: cip-dev@lists.cip-project.org, nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 1/6] Backport netfilter: nf_tables:
 autoload modules from the abort path
Message-ID: <20220110175519.GA3396@duo.ucw.cz>
References: <16C8EE09FDEB733D.27414@lists.cip-project.org>
 <Ydw+c4lHNdN0zAE6@cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
In-Reply-To: <Ydw+c4lHNdN0zAE6@cat>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Jan 2022 17:55:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7435


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Ok, let me take a look at the series. But... could you provide some
kind of explanation of what these are and why you want them in -cip?

These are not usual "hardware enablement" patches...

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYdxzBwAKCRAw5/Bqldv6
8sYSAKC5+by4Vv1M5t3MyyXruocvWb75dwCdEQT68rHLpkr8CU2rE21V/YLiRnY=
=rxyU
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--


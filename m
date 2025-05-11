Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA6A9C3ABC5
	for <webhook@archiver.kernel.org>; Sun, 11 May 2025 19:47:57 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.35086.1746992868094918870
 for <cip-dev@lists.cip-project.org>;
 Sun, 11 May 2025 12:47:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=cn5ZL8qi;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 190001048C2EC;
	Sun, 11 May 2025 21:47:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1746992866; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=az2RLmmFXHAPKeL+tChlWORxp0uhvDsTrmiBKaHMye8=;
	b=cn5ZL8qiEeUwSLxKq2+kS30U0wPo0h2TFrf/G/7RwEqg0spN3y9EJj3xtCaB3/aefEHU8Z
	OPiQEi6OBnlCA+cG7gUIvcLiOvERs1CV9qOUbZ8wW3cUQKSYK4FbpyNHhUOdfuJmQIUXUd
	+jVkSdJCo2xxDpzJrZec8gwP1p4crSbliNDYSR5tknVsklruAoBghbElntEmCImf2GSM0c
	NIyOk+mtY1QtrnnUW24PWAMxHlRkbTpFYoxhfsuz9/eRnXA6DX3bqe+gOaW8131w2zPOjy
	Cer45z4ZCBylpKfZhw7CLO9cfwWH6A+zpsLAMbT8kNkjLqF2Vw01z6xCq48nkA==
Date: Sun, 11 May 2025 21:47:42 +0200
From: Pavel Machek <pavel@denx.de>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, cip-dev@lists.cip-project.org
Subject: Re: [PATCH 6.12.y-cip 00/29] RZ/G3S: Backport audio support
Message-ID: <aCD+3tPWlx5E5hTo@duo.ucw.cz>
References: <20250509093203.4014750-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tUj7PGbtAjRy/W9v"
Content-Disposition: inline
In-Reply-To: <20250509093203.4014750-1-claudiu.beznea.uj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 11 May 2025 19:47:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18890


--tUj7PGbtAjRy/W9v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Series backports the Renesas RZ/G3S audio support to v6.12.y CIP.

I went through 5.10 version, I still need to check this, but I assume
it will be ok. I can apply this if it passes testing and there are no
other comments.

Best regards,
                                                                Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--tUj7PGbtAjRy/W9v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaCD+3gAKCRAw5/Bqldv6
8uUPAJ9xlPmK8S17jCMjWX+GyY2CrHa9LACglDKFJYv7q6+bLyE7+vg6SgCq3Ro=
=LQ+H
-----END PGP SIGNATURE-----

--tUj7PGbtAjRy/W9v--


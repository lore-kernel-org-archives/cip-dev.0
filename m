Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30730C369D9
	for <webhook@archiver.kernel.org>; Wed, 30 Apr 2025 07:27:29 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.11572.1745998044269728809
 for <cip-dev@lists.cip-project.org>;
 Wed, 30 Apr 2025 00:27:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=XGE4oG64;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 706A71026CE8F;
	Wed, 30 Apr 2025 09:27:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1745998042; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=EZUdUf34r8K6mXpKrV0vAcs105PWgr9tEIJng5NoEUU=;
	b=XGE4oG64bXnGt7SW3Hs4z819aoCeqx3+EhouIHif2TiIsCHt01Cg3BwD4LSeWW11VNfUjK
	2sk+WVLDqFW2Prwc+OlzVZL+SecG5rArZw3q8xIdZcxRDv2q0zbQ+EZhBqGsj7cry6vSQQ
	Hgg3MclsOKr2NsdISt0ciPcs6PE8nch83D5lvVJ4oWcyveTAs4qGnyfg3wkl3sPGXmZLHA
	9SiXfTGXtwplUW/2ACEmYMFU6cyVxJh1sb+lHviGnHpT4Y5BF1kURs+bY7hWUHkm8Ay52n
	QxE88ScWW8CBSDMShl3rfxLo8QfzJXJxg3KxHs8aGM3hBxNG6o02nFBV7dML/g==
Date: Wed, 30 Apr 2025 09:27:16 +0200
From: Pavel Machek <pavel@denx.de>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, cip-dev@lists.cip-project.org
Subject: Re: [PATCH v6.1.y-cip 0/4] Backport I2C
Message-ID: <aBHQ1Fn5ibCrH94S@duo.ucw.cz>
References: <20250429134826.2429916-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zby69QSx6QkDlR/k"
Content-Disposition: inline
In-Reply-To: <20250429134826.2429916-1-claudiu.beznea.uj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 30 Apr 2025 07:27:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18741


--zby69QSx6QkDlR/k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Series backports the Renesas RZ/G3S I2C support to v6.1.y CIP.
>=20
> For v6.12 CIP none of these patches need to be backported. Everything is
> already integrated.

Thank you, series looks good and I can apply it if it passes testing
and there are no other comments.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--zby69QSx6QkDlR/k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaBHQ1AAKCRAw5/Bqldv6
8lUuAKCvo/7x7xmRYD8wrw2ynfu2GkquTACeJU9rLPO3E1A0f2fbdRL8A500K08=
=dGTE
-----END PGP SIGNATURE-----

--zby69QSx6QkDlR/k--


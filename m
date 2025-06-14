Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E11CEC71135
	for <webhook@archiver.kernel.org>; Sat, 14 Jun 2025 18:16:18 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.14978.1749924971282766945
 for <cip-dev@lists.cip-project.org>;
 Sat, 14 Jun 2025 11:16:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=bq1h/99s;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DD2B010272092;
	Sat, 14 Jun 2025 20:16:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1749924968; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=Bvxdkq299RPfnaRxTUsqcNMVCy5hEOFcdCkMMbhIeq8=;
	b=bq1h/99sF6zmCucINFdP4NBGvbMHOYR/mB0ecfwuO+Ckv35pOEDlM6aBmBzK1M8CHqYJph
	NhbTKN2TyKsCmmwsPRmm9bp9BHSjDkVmabyhr3YWZrTkSWrOxwC/zKPIlrMm7BznDWVLly
	YeuSaLzN/vzjcTnCI7dLDoZbmDb4L8WqpkzRyRsS0ShBcL4sz3QV02MYIMEc+QAb8j2yB5
	Gkj32HabLgpIH/0g0OHP4Daashq5EJtikV+cLpuzPDBdpRhWjxVogGRpIC7ZLlCBMW3jhy
	BY4nZ/l5tdSaLOFIqt+Q4tlYwtp1dj9ZkINhh2JrtJHJKqZVP3EsvXkfqARvaA==
Date: Sat, 14 Jun 2025 20:16:00 +0200
From: Pavel Machek <pavel@denx.de>
To: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc: cip-dev@lists.cip-project.org, prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: Re: [PATCH for 5.10.y-cip 0/1] Fix build on rzg2l-video.c
Message-ID: <aE28YGyJzn+6kGgW@duo.ucw.cz>
References: <1749730750-6914-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2/sVlXRduyNjk99k"
Content-Disposition: inline
In-Reply-To: <1749730750-6914-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 14 Jun 2025 18:16:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19086


--2/sVlXRduyNjk99k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This fixes a build error in rzg2l-video.c[0].
>=20
> ```
> drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c:532:8: error: unkn=
own type name 'irqreturn_t'
> ```
>=20
> The main cause of this error is that linux/interrupt.h is missing. And
> linux-5.10.y-cip needs the following commit.
>  =20
>   media: mc: Provide a helper for setting bus_info field
>=20
> Adding this commit will also fix linux/interrupt.h.

Thanks for doing this.

Reviewed-by: Pavel Machek <pavel@denx.de>

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--2/sVlXRduyNjk99k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaE28YAAKCRAw5/Bqldv6
8sjuAKCu6WSpnHoZVuaJjRk0eVkwlLUA1ACfeMVoJ/RbhHiPX0X16YvmhuGchPc=
=cICf
-----END PGP SIGNATURE-----

--2/sVlXRduyNjk99k--


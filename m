Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B41E9A742
	for <webhook@archiver.kernel.org>; Tue, 24 Mar 2026 09:14:40 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15524.1774343677163385032
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 Mar 2026 02:14:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=OLzz33ZM;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 787DF10BCC6;
	Tue, 24 Mar 2026 10:14:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1774343674;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=FE0yBDHO3bA/W71JZCQi/ufmd89T7gwGBVQdaatvxms=;
	b=OLzz33ZM5s3nx4yGk0XO+bdeyn3t8ATIuEk46jyOH54WJLpoqGLceTCNBbBnq3dM+zq2yB
	qwPxdQ/sGOSBpfREffZcYUBfKmRtmUJOoqDc48k+X9rh7uGZhZhbTFUbT6SeviUihPRmS6
	uEA11a2IJzMGAJ+P8euVDWylWlumvxvRu9+l4Go9wJYUf8Bx8L2BUFd8XLOmg2cDMByRSb
	X/gCaPZbXabvVu3/WnCQamlyjCXLl2R7Lfn2EfBNIJJCguri6Cm6jb/5UGhzMPqsDh1hGu
	ALi9pq1k+jI/JfySjgICOP/jnY11A77HmcJ9PoaQigRPR9iKf+vcGuXQ/Gdvpg==
Date: Tue, 24 Mar 2026 10:14:33 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 6.12.y-cip 09/35] phy: renesas: rcar-gen3-usb2: Add
 support for RZ/T2H SoC
Message-ID: <acJV-Xq-2uq_JFMn@duo.ucw.cz>
References: <20260316145915.8580-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260316145915.8580-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="m+kaN7wrJEmRHZhX"
Content-Disposition: inline
In-Reply-To: <20260316145915.8580-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 24 Mar 2026 09:14:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22537


--m+kaN7wrJEmRHZhX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> +++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
> @@ -283,6 +294,16 @@ static void rcar_gen3_init_from_a_peri_to_a_host(str=
uct rcar_gen3_chan *ch)
> =20
>  static bool rcar_gen3_check_id(struct rcar_gen3_chan *ch)
>  {
=2E..
>  	if (!ch->uses_otg_pins)
>  		return (ch->dr_mode =3D=3D USB_DR_MODE_HOST) ? false : true;
>

I see this is existing code, but I'd rather see "return ch->dr_mode !=3D
USB_DR_MODE_HOST" here.

Thanks and best regards,
								Pavel

--m+kaN7wrJEmRHZhX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCacJV+QAKCRAw5/Bqldv6
8j3CAJ4tlCPkNF0nJ3Q4+FK4hUNe2B5svACffM6RKPIXo5EukbXPebh5piy/JWk=
=mgTY
-----END PGP SIGNATURE-----

--m+kaN7wrJEmRHZhX--


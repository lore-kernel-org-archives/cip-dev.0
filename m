Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D328FC624D4
	for <webhook@archiver.kernel.org>; Wed,  2 Sep 2026 17:00:15 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.479.1788368410027703192
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Sep 2026 10:00:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=gi2Goq0Z;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E3D9A11C8D9;
	Wed, 02 Sep 2026 19:00:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1788368404;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=LvTkZvmUFpyttzy6d//BYwqQKglgD39rtolxt8nhjm4=;
	b=gi2Goq0ZXkrX3n3g7LfPih8+itbnFo8x6UUxuM0M7KZnhNWyFO/+sAuKWX/uus12b+wAtO
	LJPnYLug9qYrDeHPhkt1OeDXQgfVH6E35utl88gkhG28mugYfdyut7FUSFkb17ofeJQaJh
	qj9vBt6AXvdjMzDZgXJJ7ftPkz7uX0XgesfSDbXzLlvsC0lobYGmsIWNxfSbOTH2nUDVLX
	gGqm51rxLCHh0xPI44hS3HWYxKEJReoph2Y0GDNtubnXsXRIIF64APaKKkxjY7mDAop0/H
	1BsLGC5SStxQm5NlvuxLJLoOL2r1jO8Qok8pKwy5nF73b9nUPiDcfJBrrvCDFQ==
Date: Wed, 2 Sep 2026 19:00:02 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: cip-dev@lists.cip-project.org, pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: Re: [PATCH 6.1.y-cip 08/11] irqchip/renesas-rzv2h: Handle ICU error
 IRQ and add SWPE trigger
Message-ID: <aphWErnJi7t9RK-a@duo.ucw.cz>
References: <20260902092353.24648-1-ovidiu.panait.rb@renesas.com>
 <20260902092353.24648-9-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZnjwDGrreZXVbqXs"
Content-Disposition: inline
In-Reply-To: <20260902092353.24648-9-ovidiu.panait.rb@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Sep 2026 17:00:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24080


--ZnjwDGrreZXVbqXs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> commit 7585a27644f338b3e764ceeda4be10e7047331a7 upstream.
>=20
> Handle the RZ/V2H ICU error interrupt to help diagnose latched bus,
> ECC RAM, and CA55/IP error conditions.
>=20
> Support error injection via ICU_SWPE to allow testing the pseudo error
> error interrupts.
>=20
> Account for SoC differences in ECC RAM error register coverage so the
> handler only iterates over valid ECC status/clear banks, and route the
> RZ/V2N compatible to a probe path with the correct ECC range while
> keeping the existing RZ/V2H and RZ/G3E handling.
>=20

> +++ b/drivers/irqchip/irq-renesas-rzv2h.c
> +	fwspec.param_count =3D 2;
> +	fwspec.param[0] =3D ICU_ERR_INT_START;
> +	fwspec.param[1] =3D IRQ_TYPE_LEVEL_HIGH;
> +
> +	virq =3D irq_create_fwspec_mapping(&fwspec);
> +	if (!virq) {
> +		return dev_err_probe(dev, -EINVAL, "failed to create IRQ mapping for %=
s\n",
> +				     icu_err);
> +	}
> +
> +	ret =3D devm_request_irq(dev, virq, rzv2h_icu_error_irq, 0, dev_name(de=
v), rzv2h_icu_data);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to request %s IRQ\n", icu_err);
> +
>  	return 0;

It seems to me like the error path and possibly unload path need call
to irq_dispose_mapping()?

Best regards,
								Pavel
							=09

--ZnjwDGrreZXVbqXs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaphWEgAKCRAw5/Bqldv6
8ntYAJ484SeU3DpC1Cw7vJ9YiIdWarmo2ACguBBrVvzMd3yPcfyhoZ2fBP5swB8=
=76Su
-----END PGP SIGNATURE-----

--ZnjwDGrreZXVbqXs--


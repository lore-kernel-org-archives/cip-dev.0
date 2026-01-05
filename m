Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4CB4D5B160
	for <webhook@archiver.kernel.org>; Mon,  5 Jan 2026 11:40:00 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.62193.1767613190213841177
 for <cip-dev@lists.cip-project.org>;
 Mon, 05 Jan 2026 03:39:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=HEwvrXHs;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 491DA1057F3;
	Mon,  5 Jan 2026 12:39:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1767613188;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=cK5FGypAnq8N0vk8EE4pz8eJlPxbTCpdXQMuWBvFuRg=;
	b=HEwvrXHsT9+0k8r2ZgscBywTLyurgihkDIRjj4jiLyZ3GCJRF7Y0/Xelpu8aU4Maczne5H
	jKa6j84xfi8LgOWo8pz6QK2r1z14R2pvFWO+8akHj4xxiAZGxrTPZbltZAtA+y0qZ/19Fj
	Q18VIJdGFLyxKZp9amhyurfYu2IVuYHUgrDR4ZHVHZlrwgWgtgIgVgRap57FnQihZJr+TF
	u6am+hueEjPBDbAlTdQ29BYNrxITXe59SjeGkTPKXoDq8zOlyEJ7yxNv+WyhXPPqar7fIW
	02Qy5CYk6BFHq++qckGVLT3ETz0t/lc8xEhQ4g790t1JCyzIU5i0804/4NVL3Q==
Date: Mon, 5 Jan 2026 12:39:45 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 6.12.y-cip 04/17] clk: renesas: cpg-mssr: Add module
 reset support for RZ/T2H
Message-ID: <aVujAQJSDn6WyORK@duo.ucw.cz>
References: <20251229223911.8663-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20251229223911.8663-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZrkgL2HFQrXn7pKh"
Content-Disposition: inline
In-Reply-To: <20251229223911.8663-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Jan 2026 11:40:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21310


--ZrkgL2HFQrXn7pKh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

There's a cleanup possible, see below.

> commit 3b37979dcbef0dc3fc1aaba75b21ff9a21799055 upstream.
>=20
> Add support for module reset handling on the RZ/T2H SoC. Unlike earlier
> CPG/MSSR variants, RZ/T2H uses a unified set of Module Reset Control
> Registers (MRCR) where both reset and deassert actions are done via
> read-modify-write (RMW) to the same register.

> diff --git a/drivers/clk/renesas/renesas-cpg-mssr.c b/drivers/clk/renesas=
/renesas-cpg-mssr.c
> index 9ea544d00634b..4d2d945b3f5e2 100644
> --- a/drivers/clk/renesas/renesas-cpg-mssr.c
> +++ b/drivers/clk/renesas/renesas-cpg-mssr.c
> +	/*
> +	 * For secure processing after release from a module reset, one must
> +	 * perform multiple dummy reads of the same register.
> +	 */
> +	for (i =3D 0; !set && i < RZT2H_RESET_REG_READ_COUNT; i++)
> +		readl(reg_addr);
> +
> +	/* Verify the operation */
> +	val =3D readl(reg_addr);
> +	if (set =3D=3D !(bitmask & val)) {
> +		dev_err(priv->dev, "Reset register %u%02u operation failed\n", reg, bi=
t);
> +		spin_unlock_irqrestore(&priv->pub.rmw_lock, flags);
> +		return -EIO;
> +	}
> +
> +	spin_unlock_irqrestore(&priv->pub.rmw_lock, flags);

"(set =3D=3D !(bitmask & val))" is only using local variables, so does not
need spinlock protection AFAICT.

And dev_err really should not be run under spinlock.

So I believe spin_unlock...() can be simply moved before the if() for
tiny bit faster and cleaner code.

Thanks and best regards,
								Pavel
--=20
In cooperation with Nabla.

--ZrkgL2HFQrXn7pKh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaVujAQAKCRAw5/Bqldv6
8uUkAJ9+zUxW8fdqe5V0GOqw/k0Ev71haQCfSygwYbrtWYU05uVvY7iQSmO3/zg=
=5Bsj
-----END PGP SIGNATURE-----

--ZrkgL2HFQrXn7pKh--


Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B08105F796
	for <webhook@archiver.kernel.org>; Fri, 13 Mar 2026 10:39:41 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12934.1773398378516751997
 for <cip-dev@lists.cip-project.org>;
 Fri, 13 Mar 2026 03:39:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=baYqzFvI;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 98C8D10C17C;
	Fri, 13 Mar 2026 11:39:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1773398375;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=zj8LEsFvDbIfN7fmR42GR5G38acSmPulsJaDYZoYkig=;
	b=baYqzFvI8dbAjj+jJd8dNoxGNKr12b78hW8ICH5zu3DoBs24/6A3it9Z5moZY0rDP3D4u4
	TIQ8ngEd9TXa9ub7yFhcTSP37tcsGflSnG2GYz0G9BC909at+zqTfh1/YO/BcCxZmM/kFI
	dte5jdTbU39/ixo2DvavLC6XaFXj81Xaw5EHMYqipVgDgpbXpOQRB/8F71kSHkcyOsAgrb
	Y6UGEUuEIQEDF9RhBWuXTAOzJqCUxx/FkP/sJVDTzLxXklWOvJ+19jpelYwyudNEX/XJKD
	T/nXSDEIzMUcICiSROpyzdRN8FjQXM5SlERcIP5UZvzUL92AseMg7F1WlbTDsQ==
Date: Fri, 13 Mar 2026 11:39:33 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Biju <biju.das.au@gmail.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 6.12.y-cip v2 24/27] serial: sh-sci: Add support for
 RZ/G3E RSCI
Message-ID: <abPpZULsXhRmXTX9@duo.ucw.cz>
References: <20260311100458.162447-1-biju.das.jz@bp.renesas.com>
 <20260311100458.162447-25-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cK1Ay4w9U5wXnhYZ"
Content-Disposition: inline
In-Reply-To: <20260311100458.162447-25-biju.das.jz@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 13 Mar 2026 10:39:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22372


--cK1Ay4w9U5wXnhYZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> Add support for RZ/G3E RSCI. RSCI IP found on the RZ/G3E SoC is similar
> to RZ/T2H, but it has a 32-stage FIFO. It has 6 clocks(5 module clocks
> + 1 external clock) instead of 3 clocks(2 module clocks + 1 external
> clock) on T2H, has 6 irqs compared to 4 on RZ/T2H and has multiple resets.
> Add support for the hardware flow control.


> +	baud = uart_get_baud_rate(port, termios, old, 0, max_freq);
> +	if (!baud)
> +		goto done;
> +
> +	/* Divided Functional Clock using standard Bit Rate Register */
> +	err = sci_scbrr_calc(s, baud, &brr1, &srr1, &cks1);
> +	if (abs(err) < abs(min_err)) {
> +		best_clk = SCI_FCK;
> +		ccr0_val = 0;
> +		min_err = err;
> +		brr = brr1;
> +		cks = cks1;
> +	}
> +
> +done:
> +	if (best_clk >= 0)

I'm not sure if "done" is best label here, and probably avoiding the
goto would be best.

Best regards,
								Pavel

--cK1Ay4w9U5wXnhYZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCabPpZQAKCRAw5/Bqldv6
8guDAJ423RLPrVcPEg4UPZAmq/XSiZQ25gCeJdSOnBJntwczb3KY6LIX4qQ3bek=
=G8wV
-----END PGP SIGNATURE-----

--cK1Ay4w9U5wXnhYZ--


Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC8FC4450A
	for <webhook@archiver.kernel.org>; Thu, 16 Jul 2026 10:48:30 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10046.1784198899361268235
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Jul 2026 03:48:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=U4EnPEt0;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BC4BE11A003;
	Thu, 16 Jul 2026 12:48:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1784198897;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=UYRmjB4OVVJ1qdRjJKjduWak5M46R+BK40td8M0KREQ=;
	b=U4EnPEt0zqB5k4U+UtRGeUAtw0HYBccSNdf5iN95Mkiym4TVGbmAoYZD6MygGuHLcPFQs2
	uONtq3TOQxoqUO+e42QB7D+WdQCeQSvaakmuQieFIJn2EfSywgA108XgZFmVTX3Eh5EK1G
	Khqs5t01AMZqxf+M1mmAKVu1x+taZLjDwV/2P/wQuYam61kBoX/WuXNqTzPuiHoCakCRUC
	V1doHuj8D25TScg0RubfgVDjCOF9ZLFvtn1PAXc1ToAkXLGjzVBmbfQS5amYAd5vycNk2o
	7cQCdFgLAJJji7elN+VzejvJ6As7v9LJ76UybGePuw+LLmLLeClqvZ3yDJr8zg==
Date: Thu, 16 Jul 2026 12:48:15 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 6.12.y-cip 2/8] clk: renesas: r9a09g077: Add xSPI core
 and module clocks
Message-ID: <ali274E3aNG2-Rtx@duo.ucw.cz>
References: <20260706182328.5237-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260706182328.5237-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kosbf/jCzNedvL25"
Content-Disposition: inline
In-Reply-To: <20260706182328.5237-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Jul 2026 10:48:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23616


--kosbf/jCzNedvL25
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Minor details here:

> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> [PL: manually applied the changes]
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

> +++ b/drivers/clk/renesas/r9a09g077-cpg.c
> @@ -295,6 +334,151 @@ r9a09g077_cpg_mux_clk_register(struct device *dev,
>  	return clk_hw->clk;
>  }
> =20
> +static unsigned int r9a09g077_cpg_fselxspi_get_divider(struct clk_hw *hw=
, unsigned long rate,
> +						       unsigned int num_parents)
> +{
> +	struct clk_fixed_factor *ff;
> +	struct clk_hw *parent_hw;
> +	unsigned long best_rate;
> +	unsigned int i;
> +
> +	for (i =3D 0; i < num_parents; i++) {
> +		parent_hw =3D clk_hw_get_parent_by_index(hw, i);
> +		best_rate =3D clk_hw_round_rate(parent_hw, rate);
> +
> +		if (best_rate =3D=3D rate) {
> +			ff =3D to_clk_fixed_factor(parent_hw);
> +			return ff->div;
> +		}
> +	}
> +
> +	/* No parent could provide the exact rate - this should not happen */
> +	return 0;
> +}

If it can't happen, WARN() may be suitable?

> +
> +static struct clk * __init
> +r9a09g077_cpg_fselxspi_div_clk_register(struct device *dev,
> +					const struct cpg_core_clk *core,
> +					void __iomem *addr,
=2E..
> +	if (!xspi_div_ops) {
> +		xspi_div_ops =3D devm_kzalloc(dev, sizeof(*xspi_div_ops), GFP_KERNEL);
> +		if (!xspi_div_ops)
> +			return  ERR_PTR(-ENOMEM);

One space would be enough between return and ERR.

> +		memcpy(xspi_div_ops, &clk_divider_ops,
> +		       sizeof(const struct clk_ops));

And the memcpy does fit on single line.

(May not be worth cleaning up unless you are doing changes for that anyway).

Thanks and best regards,
										Pavel

--kosbf/jCzNedvL25
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCali27wAKCRAw5/Bqldv6
8pqLAKDBsXqSF7tgEPAYBDsAjn4nMF7ldgCeIwcUpIFZxRp5Si2h2FpjICXdnt8=
=h1jy
-----END PGP SIGNATURE-----

--kosbf/jCzNedvL25--


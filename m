Return-Path: <SRS0=TlPP=E5=lists.cip-project.org=bounce+64572+5829+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9AB9C2D0E4
	for <cip-dev@archiver.kernel.org>; Mon, 23 Nov 2020 19:43:54 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E10B420727
	for <cip-dev@archiver.kernel.org>; Mon, 23 Nov 2020 19:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="Cz5RwwbN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E10B420727
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5829+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id QRqmYY4521723xU8INgPX8pJ; Mon, 23 Nov 2020 11:43:53 -0800
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web08.40979.1606160632558314560
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Nov 2020 11:43:52 -0800
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 1BF491C0BA1; Mon, 23 Nov 2020 20:43:46 +0100 (CET)
Date: Mon, 23 Nov 2020 20:43:45 +0100
From: "Pavel Machek" <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 5/7] spi: spi-mem: Split spi_mem_exec_op() code
Message-ID: <20201123194345.GC5619@amd>
References: <20201123120354.26413-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201123120354.26413-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <20201123120354.26413-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: PitU8OOVUJ17aZvNDVkzyEsix4520388AA=
Content-Type: multipart/mixed; boundary="qTxXn1aAbOuM4UXQT1CC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606160633;
 bh=NyGH77hGrCnNHM6ESNnUH0TploIDP8dseS+/XtqsqPY=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=Cz5RwwbNEvgzaXojRbxuEq48wdsUMSNnOxocrU47ecG1RKGJgCf/8canN8qQPoURhAC
 akAluyCmmv8WUwl0oGT08MD11TDEMN3LItgfrbveNX0LYcjLrMnVyKJw99ZRTXQV7rOWB
 aQ1nTXLxHE7YHMU/AevAq0PORXRA7h7W5sY=

--qTxXn1aAbOuM4UXQT1CC
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="69pVuxX8awAiJ7fD"
Content-Disposition: inline

--69pVuxX8awAiJ7fD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Boris Brezillon <boris.brezillon@bootlin.com>
>=20
> commit f86c24f4795303e4024bc113196de32782f6ccb5 upstream.
>=20
> The logic surrounding the ->exec_op() call applies to direct mapping
> accessors. Move this code to separate functions to avoid duplicating
> code.
>=20

> +++ b/drivers/spi/spi-mem.c
> @@ -213,6 +213,44 @@ bool spi_mem_supports_op(struct spi_mem *mem, const =
struct spi_mem_op *op)
>  }
>  EXPORT_SYMBOL_GPL(spi_mem_supports_op);
> =20
> +static int spi_mem_access_start(struct spi_mem *mem)
> +{
> +	struct spi_controller *ctlr =3D mem->spi->controller;
=2E..
> +	if (ctlr->auto_runtime_pm) {
> +		int ret;
> +
> +		ret =3D pm_runtime_get_sync(ctlr->dev.parent);
> +		if (ret < 0) {
> +			dev_err(&ctlr->dev, "Failed to power device: %d\n",
> +				ret);
> +			return ret;
> +		}

This misses pm_runtime_put() in the error case.

> +	mutex_lock(&ctlr->bus_lock_mutex);
> +	mutex_lock(&ctlr->io_mutex);

Plus hiding locking into function like this ... is quite
"interesting".

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--69pVuxX8awAiJ7fD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl+8EPEACgkQMOfwapXb+vKTLgCbBTOfXg41bnZiDmbCkSJAPbQ8
5mQAnAk9ApmtA820dO44ojaRNCfmO8s0
=hJB1
-----END PGP SIGNATURE-----

--69pVuxX8awAiJ7fD--

--qTxXn1aAbOuM4UXQT1CC
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5829): https://lists.cip-project.org/g/cip-dev/message=
/5829
Mute This Topic: https://lists.cip-project.org/mt/78451545/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--qTxXn1aAbOuM4UXQT1CC--

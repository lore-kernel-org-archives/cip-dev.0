Return-Path: <SRS0=NkcY=E5=lists.cip-project.org=bounce+64572+5830+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA359C2D0E4
	for <cip-dev@archiver.kernel.org>; Mon, 23 Nov 2020 19:46:32 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D09120719
	for <cip-dev@archiver.kernel.org>; Mon, 23 Nov 2020 19:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="ot3h5EXv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D09120719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5830+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 0phFYY4521723xWhSkQVKnZg; Mon, 23 Nov 2020 11:46:31 -0800
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web09.41254.1606160790416693662
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Nov 2020 11:46:30 -0800
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id D614D1C0BA1; Mon, 23 Nov 2020 20:46:26 +0100 (CET)
Date: Mon, 23 Nov 2020 20:46:26 +0100
From: "Pavel Machek" <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 6/7] spi: spi-mem: Add a new API to support direct mapping
Message-ID: <20201123194626.GD5619@amd>
References: <20201123120354.26413-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201123120354.26413-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <20201123120354.26413-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: eCVdO0yCBHbaJDx4vb7YhSmvx4520388AA=
Content-Type: multipart/mixed; boundary="62CO3I1r7uQxas5nvfMf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606160791;
 bh=Mw33RJQ5Yld3JCO+cHcR4WDYqk3ZVhXPsYf4XH3vwco=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=ot3h5EXvMGLBsI2FlVkiIBGAqWCRDhWuRjDu7KEdFBCaIo4XH0jLJpbAgjrwmEUHKOJ
 42Aij5voaYlraxTC/ZGN/EWhIF97Q2Nh/IE4RYNojNjhKO2zUzTpBXUmCw6zqNV5vJKjl
 chpXxDpwInalINHWSU1FwTAwxIjQ0LC65TE=

--62CO3I1r7uQxas5nvfMf
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5gxpn/Q6ypwruk0T"
Content-Disposition: inline

--5gxpn/Q6ypwruk0T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> commit aa167f3fed0c37e0e4c707d4331d827661f46644 upstream.
>=20
> Most modern SPI controllers can directly map a SPI memory (or a portion
> of the SPI memory) in the CPU address space. Most of the time this
> brings significant performance improvements as it automates the whole
> process of sending SPI memory operations every time a new region is
> accessed.
>=20
> This new API allows SPI memory drivers to create direct mappings and
> then use them to access the memory instead of using
> spi_mem_exec_op().

> + * Return: the amount of data read from the memory device or a negative =
error
> + * code. Note that the returned size might be smaller than @len, and the=
 caller
> + * is responsible for calling spi_mem_dirmap_read() again when that happ=
ens.
> + */
> +ssize_t spi_mem_dirmap_read(struct spi_mem_dirmap_desc *desc,
> +			    u64 offs, size_t len, void *buf)
> +{
> +	struct spi_controller *ctlr =3D desc->mem->spi->controller;
> +	ssize_t ret;
> +
> +	if (desc->info.op_tmpl.data.dir !=3D SPI_MEM_DATA_IN)
> +		return -EINVAL;
> +
> +	if (!len)
> +		return 0;
> +
> +	if (desc->nodirmap) {
> +		ret =3D spi_mem_no_dirmap_read(desc, offs, len, buf);

I'd do return ... here.

> +	} else if (ctlr->mem_ops && ctlr->mem_ops->dirmap_read) {
> +		ret =3D spi_mem_access_start(desc->mem);
> +		if (ret)
> +			return ret;
> +
> +		ret =3D ctlr->mem_ops->dirmap_read(desc, offs, len, buf);
> +
> +		spi_mem_access_end(desc->mem);

and here.

> +	} else {
> +		ret =3D -ENOTSUPP;
> +	}

To help with if/else nesting. spi_mem_dirmap_write could use same
treatment.

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--5gxpn/Q6ypwruk0T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl+8EZEACgkQMOfwapXb+vK2+QCgw5ZShzRBVx68rqKdRzKkuqww
LZQAnjRnx56kYOAzHVr515bMZmBehm9G
=6ggO
-----END PGP SIGNATURE-----

--5gxpn/Q6ypwruk0T--

--62CO3I1r7uQxas5nvfMf
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5830): https://lists.cip-project.org/g/cip-dev/message=
/5830
Mute This Topic: https://lists.cip-project.org/mt/78451547/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--62CO3I1r7uQxas5nvfMf--

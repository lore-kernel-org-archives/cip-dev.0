Return-Path: <SRS0=wy8q=GI=lists.cip-project.org=bounce+64572+6034+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 510ACC433E0
	for <cip-dev@archiver.kernel.org>; Tue,  5 Jan 2021 16:57:40 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9ECA22CB9
	for <cip-dev@archiver.kernel.org>; Tue,  5 Jan 2021 16:57:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9ECA22CB9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6034+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id lS6CYY4521723xLzTZEGPxWe; Tue, 05 Jan 2021 08:57:39 -0800
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.55.1609865858566519730
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Jan 2021 08:57:38 -0800
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 4437E1C0B77; Tue,  5 Jan 2021 17:57:35 +0100 (CET)
Date: Tue, 5 Jan 2021 17:57:34 +0100
From: "Pavel Machek" <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH v3 4.19.y-cip 13/17] spi: spi-mem: Add a new API to support direct mapping
Message-ID: <20210105165734.GD361@amd>
References: <20210105135757.11069-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20210105135757.11069-14-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <20210105135757.11069-14-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: UszfqzjtPvEwBPgmlU9SJTTVx4520388AA=
Content-Type: multipart/mixed; boundary="gQGCZZsZ07fv7Bg9eiTu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1609865859;
 bh=NlMGOALm9s18jSz2x1nygN0lSfmgB2KjENKiGZZlx6k=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=jLE9olUBRIVMbDkgPHcs5dUZvruEkIp2KZNt75RYHTpFt4t3HafvfDs7r6+/UQ33IU0
 TsOppMzv6ubgIYTN3WSYfVEPgi3mMBP+nlom4WKmTMVD4wPc8+cr+Pdm4g4AuHky2O3jn
 Vbnhg2IA48fXptm/0ykzEFqi6XLpuW57i08=

--gQGCZZsZ07fv7Bg9eiTu
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SFyWQ0h3ruR435lw"
Content-Disposition: inline

--SFyWQ0h3ruR435lw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Boris Brezillon <boris.brezillon@bootlin.com>
>=20
> commit aa167f3fed0c37e0e4c707d4331d827661f46644 upstream.
>=20
> Most modern SPI controllers can directly map a SPI memory (or a portion
> of the SPI memory) in the CPU address space. Most of the time this
> brings significant performance improvements as it automates the whole
> process of sending SPI memory operations every time a new region is
> accessed.
>=20
> This new API allows SPI memory drivers to create direct mappings and
> then use them to access the memory instead of using spi_mem_exec_op().

This can be refactored to remove if/else nesting.

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
> +	} else if (ctlr->mem_ops && ctlr->mem_ops->dirmap_read) {
> +		ret =3D spi_mem_access_start(desc->mem);
> +		if (ret)
> +			return ret;
> +
> +		ret =3D ctlr->mem_ops->dirmap_read(desc, offs, len, buf);
> +
> +		spi_mem_access_end(desc->mem);
> +	} else {
> +		ret =3D -ENOTSUPP;
> +	}
> +
> +	return ret;
> +}

This can be

     if (desc->nodirmap)
     	return spi_mem_no_dirmap_read(desc, offs, len, buf);
     if (!(ctlr->mem_ops && ctlr->mem_ops->dirmap_read))
     	return -ENOTSUPP;

     ... normal case goes here...

Same refactoring can be done for dirmap_write.

Code works either way and is not too bad, so... up to you :-).

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--SFyWQ0h3ruR435lw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl/0mn4ACgkQMOfwapXb+vLKmACeO83Gj5MAqZ1vky8gCUi/Acu1
Yq8AniWnFtQ4UcoD73OeeSyi3xF1m31J
=7/Sk
-----END PGP SIGNATURE-----

--SFyWQ0h3ruR435lw--

--gQGCZZsZ07fv7Bg9eiTu
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6034): https://lists.cip-project.org/g/cip-dev/message=
/6034
Mute This Topic: https://lists.cip-project.org/mt/79450077/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--gQGCZZsZ07fv7Bg9eiTu--

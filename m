Return-Path: <SRS0=PNJj=GI=lists.cip-project.org=bounce+64572+6032+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F279EC433DB
	for <cip-dev@archiver.kernel.org>; Tue,  5 Jan 2021 16:51:52 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44A3D22CB9
	for <cip-dev@archiver.kernel.org>; Tue,  5 Jan 2021 16:51:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44A3D22CB9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6032+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id N1xqYY4521723x0J2l6GIwBa; Tue, 05 Jan 2021 08:51:51 -0800
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.8443.1609865510663189352
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Jan 2021 08:51:51 -0800
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 7601D1C0B77; Tue,  5 Jan 2021 17:51:47 +0100 (CET)
Date: Tue, 5 Jan 2021 17:51:46 +0100
From: "Pavel Machek" <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH v3 4.19.y-cip 08/17] spi: spi-mem: export spi_mem_default_supports_op()
Message-ID: <20210105165146.GB361@amd>
References: <20210105135757.11069-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20210105135757.11069-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <20210105135757.11069-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: v7DNomeoEWy6o4SByNFG1gnBx4520388AA=
Content-Type: multipart/mixed; boundary="g4H8LoyQUGaxplo9K4QA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1609865511;
 bh=49wjzfmHAKGFvJO/FFp0MIfuEY7MohNlGEwTqSB4n88=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=xF/SlcNezWta98yBqIjcAqCWEEOkRkDj+p5dJXY2eqdygRS7x8xko6585SeHMSWzvpw
 mXFkIaCzsNAMKCyLBuMc5HjRYNVmncnx3N0dQSoBJkDNox+HBi6G0WGZSL5KUPKMZwx5x
 yHpbukfKU006qq/XeVD4+hRWh04CaWSl4U8=

--g4H8LoyQUGaxplo9K4QA
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7iMSBzlTiPOCCT2k"
Content-Disposition: inline

--7iMSBzlTiPOCCT2k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
=20
> This patch also squashes upstream commit 72e6841608b9 ("spi: spi-mem: Fix
> build error without CONFIG_SPI_MEM")' in the current patch as commit
> 46109648052f ("spi: spi-mem: export spi_mem_default_supports_op()")'
> introduced below build error when built without CONFIG_SPI_MEM:

This puts function definition directly into header file; I don't think
that will work when multiple files include it.

Adding "static inline" is the usual solution for this.

Best regards,
								Pavel

> diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
> index 80db2de83402..253a8d451d4c 100644
> --- a/include/linux/spi/spi-mem.h
> +++ b/include/linux/spi/spi-mem.h
> @@ -239,6 +243,13 @@ spi_controller_dma_unmap_mem_op_data(struct spi_cont=
roller *ctlr,
>  				     struct sg_table *sg)
>  {
>  }
> +
> +bool spi_mem_default_supports_op(struct spi_mem *mem,
> +				 const struct spi_mem_op *op)
> +{
> +	return false;
> +}
> +
>  #endif /* CONFIG_SPI_MEM */
> =20
>  int spi_mem_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op);

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--7iMSBzlTiPOCCT2k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl/0mSIACgkQMOfwapXb+vIH+gCfRJJuhM2nQqle8UOxubFY+KI8
8dMAoLmkrybsOBA8/Sx7vp+JlAtdkA2k
=Egde
-----END PGP SIGNATURE-----

--7iMSBzlTiPOCCT2k--

--g4H8LoyQUGaxplo9K4QA
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6032): https://lists.cip-project.org/g/cip-dev/message=
/6032
Mute This Topic: https://lists.cip-project.org/mt/79450068/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--g4H8LoyQUGaxplo9K4QA--

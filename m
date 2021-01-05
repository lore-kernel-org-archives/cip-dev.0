Return-Path: <SRS0=ZApQ=GI=lists.cip-project.org=bounce+64572+6033+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F78FC43381
	for <cip-dev@archiver.kernel.org>; Tue,  5 Jan 2021 16:56:33 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FB8122CB9
	for <cip-dev@archiver.kernel.org>; Tue,  5 Jan 2021 16:56:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FB8122CB9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6033+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id eNBbYY4521723x9mEbQLo2kZ; Tue, 05 Jan 2021 08:56:30 -0800
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web09.6.1609865641582663919
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Jan 2021 08:54:01 -0800
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 16F411C0B77; Tue,  5 Jan 2021 17:53:59 +0100 (CET)
Date: Tue, 5 Jan 2021 17:53:58 +0100
From: "Pavel Machek" <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH v3 4.19.y-cip 12/17] spi: spi-mem: Compute length only when needed
Message-ID: <20210105165358.GC361@amd>
References: <20210105135757.11069-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20210105135757.11069-13-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <20210105135757.11069-13-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: Uz5RbqK22oL6gEs9WfoAWuEex4520388AA=
Content-Type: multipart/mixed; boundary="fODfEzvF2P85COCmR1G2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1609865790;
 bh=VvmlZ9GsDDYsJmUJe69DJ2I6kRk2wnxLOSEQiKJtWMw=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=pplKvIAOwR80EVRo70EFQNkN/JPKX2SA9RK0qZ/rHaf/PaewKuIQQHONI2BHDjd8Gco
 X5C+cQUrCJx+zU08EDan0li/16FQKvYQ7olCxBX3nxPEGdzIzxgu/pQ8ERpDghjmLX6UT
 KHETLOS27c2jOkK8gqmuzZ3Xh0QeqoXYuec=

--fODfEzvF2P85COCmR1G2
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TiqCXmo5T1hvSQQg"
Content-Disposition: inline

--TiqCXmo5T1hvSQQg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Tudor Ambarus <tudor.ambarus@microchip.com>
>=20
> commit c0e035ac56680e74b27fc218c07e70f4b9b8b7a5 upstream.
>=20
> When adjust_op_size is defined, len is never used. Move the len
> computation where it's actually used.

> index 59f7aa117a10..02cf8c3f7350 100644
> --- a/drivers/spi/spi-mem.c
> +++ b/drivers/spi/spi-mem.c
> @@ -412,12 +412,13 @@ int spi_mem_adjust_op_size(struct spi_mem *mem, str=
uct spi_mem_op *op)
>  	struct spi_controller *ctlr =3D mem->spi->controller;
>  	size_t len;
> =20
> -	len =3D sizeof(op->cmd.opcode) + op->addr.nbytes + op->dummy.nbytes;
> -
>  	if (ctlr->mem_ops && ctlr->mem_ops->adjust_op_size)
>  		return ctlr->mem_ops->adjust_op_size(mem, op);
> =20
>  	if (!ctlr->mem_ops || !ctlr->mem_ops->exec_op) {
> +		len =3D sizeof(op->cmd.opcode) + op->addr.nbytes +
> +		      op->dummy.nbytes;
> +
>  		if (len > spi_max_transfer_size(mem->spi))
>  			return -EINVAL;

If we are doing this kind of cleanups... I'd move "len" declaration
inside the if, too... Not that it matters much.

Best regards,

								Pavel

Signed-off-by: Pavel Machek (CIP) <pavel@denx.de>

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index c3a08afb6edf..bc64b4223913 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -410,13 +410,12 @@ EXPORT_SYMBOL_GPL(spi_mem_get_name);
 int spi_mem_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
 {
 	struct spi_controller *ctlr =3D mem->spi->controller;
-	size_t len;
=20
 	if (ctlr->mem_ops && ctlr->mem_ops->adjust_op_size)
 		return ctlr->mem_ops->adjust_op_size(mem, op);
=20
 	if (!ctlr->mem_ops || !ctlr->mem_ops->exec_op) {
-		len =3D sizeof(op->cmd.opcode) + op->addr.nbytes +
+		size_t len =3D sizeof(op->cmd.opcode) + op->addr.nbytes +
 		      op->dummy.nbytes;
=20
 		if (len > spi_max_transfer_size(mem->spi))

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--TiqCXmo5T1hvSQQg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl/0maYACgkQMOfwapXb+vKDpQCgj81BJ+GzcalEnxt3XNsxA8EL
BCwAnikG/mhEXc807ClYUk5DhCxufc3K
=KfGJ
-----END PGP SIGNATURE-----

--TiqCXmo5T1hvSQQg--

--fODfEzvF2P85COCmR1G2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6033): https://lists.cip-project.org/g/cip-dev/message=
/6033
Mute This Topic: https://lists.cip-project.org/mt/79450076/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--fODfEzvF2P85COCmR1G2--

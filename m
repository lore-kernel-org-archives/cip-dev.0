Return-Path: <SRS0=+1vv=E6=lists.cip-project.org=bounce+64572+5865+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF0B7C2D0E4
	for <cip-dev@archiver.kernel.org>; Tue, 24 Nov 2020 19:49:25 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC7802086A
	for <cip-dev@archiver.kernel.org>; Tue, 24 Nov 2020 19:49:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="ffRGgib5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC7802086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5865+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id igLJYY4521723x9esNcj1oCx; Tue, 24 Nov 2020 11:49:24 -0800
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.2372.1606247362675145656
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 Nov 2020 11:49:23 -0800
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 650D11C0B7D; Tue, 24 Nov 2020 20:49:19 +0100 (CET)
Date: Tue, 24 Nov 2020 20:49:18 +0100
From: "Pavel Machek" <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH v2 4.19.y-cip 0/7] Add RPC-IF driver for RZ/G2x SoC's
Message-ID: <20201124194918.GB4916@amd>
References: <20201124175918.12029-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <20201124175918.12029-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 5gGJiuDs613LASSn0LCQZjLSx4520388AA=
Content-Type: multipart/mixed; boundary="1Fzbfe4bizxOmzkLzxRj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606247364;
 bh=7iARl8DyGLpKgjrpGMLGNCZQUpoSZhOuHQek5uTCcP8=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=ffRGgib52RPspQGGFGv8lob61NX30Bk5RPG5gUdVsBVa/qA6cSvrd83HybQwzWpsqtM
 UgES8qsQR9bkl4ViyeWA8iB1bhphEYNAMr2bYi1wIlTIYaEjOijUgPLm34EQ/1aCwEEXd
 9edSokpAwbnmDKS19nhfliqWhJX6+hyMAx0=

--1Fzbfe4bizxOmzkLzxRj
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5I6of5zJg18YgZEa"
Content-Disposition: inline

--5I6of5zJg18YgZEa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series adds SPI driver for the Renesas RPC-IF.
> Alongside relevant changes for spi-mem have been also
> backported. This enables accessing SPI flash chip connected
> to RPC-IF on RZ/G2x boards.
>=20
> We currently only aim to backport just the driver hence there
> are no changes to dts/i files. The driver has been tested on
> RZ/G2{EM} with all the required dts/i changes [1].

Okay, that was quick.

What is your plan, merge dts changes soon? Or is the driver useful
even without the dts changes?

> Changes for v2:
> * Patches {1, 3, 4}/7 unchanged
> * Patch 2/7
>    * Fixed reference leak for OF node in rpcif_probe()
>    * Fixed overwriting return value in error path of rpcif_manual_xfer()
>    * Replaced C++ style comment with C style
>    * Replaced tab with a space between struct and struct name
>    * Fixed a typo in commit message (s/absract/abstract)
> * Patch 5/7
>    * Fixed reference leak in spi_mem_access_start for PM
> * Patch 6/7
>    * Return early in spi_mem_dirmap_dirmap_{read/write}
> * Patch 7/7
>    * Replaced C++ style comment with C style
>    * Used __maybe_unused for rpcif_spi_{suspend,resume} and dropped
>      CONFIG_PM_SLEEP ifdef checks
>    * Elaborated the description for SPI_RPCIF config
>    * Dropped the label err_put_ctlr from rpc_spi_probe()

Thanks for the changes; they are probably good (I have yet to take
close look), but I wonder if we should wait until they hit next or
mainline? If upstream maintainer disagrees, we would get divergence...

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--5I6of5zJg18YgZEa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl+9Y74ACgkQMOfwapXb+vJHfQCeIiXNIhQ+8Mqo9+GsdZrZFDyK
lNQAn0ANtveruXOPspy6aTUdW66QEK6X
=DUOU
-----END PGP SIGNATURE-----

--5I6of5zJg18YgZEa--

--1Fzbfe4bizxOmzkLzxRj
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5865): https://lists.cip-project.org/g/cip-dev/message=
/5865
Mute This Topic: https://lists.cip-project.org/mt/78482875/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--1Fzbfe4bizxOmzkLzxRj--

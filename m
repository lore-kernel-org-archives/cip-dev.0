Return-Path: <SRS0=ektH=GJ=lists.cip-project.org=bounce+64572+6043+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E496FC433E0
	for <cip-dev@archiver.kernel.org>; Wed,  6 Jan 2021 13:19:45 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34CF42311C
	for <cip-dev@archiver.kernel.org>; Wed,  6 Jan 2021 13:19:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34CF42311C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6043+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id pMbXYY4521723xOp85PxbweN; Wed, 06 Jan 2021 05:19:44 -0800
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.7742.1609939183487497408
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Jan 2021 05:19:44 -0800
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 1E23B1C0B92; Wed,  6 Jan 2021 14:19:30 +0100 (CET)
Date: Wed, 6 Jan 2021 14:19:29 +0100
From: "Pavel Machek" <pavel@denx.de>
To: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
Cc: cip-dev@lists.cip-project.org, Pavel Machek <pavel@denx.de>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH v3 4.19.y-cip 08/17] spi: spi-mem: export spi_mem_default_supports_op()
Message-ID: <20210106131929.GA13558@duo.ucw.cz>
References: <20210105135757.11069-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20210105135757.11069-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20210105165146.GB361@amd>
 <91eb8a79-a7e5-542a-b3d7-f54d17c29f47@codethink.co.uk>
MIME-Version: 1.0
In-Reply-To: <91eb8a79-a7e5-542a-b3d7-f54d17c29f47@codethink.co.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: U4sWLcz8sPAve4Hmq3iKq1sjx4520388AA=
Content-Type: multipart/mixed; boundary="uiZUXxmgNm9ZvAL2ryP1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1609939184;
 bh=J+gPFzAjj9wlS2zP7E/3XXnoyVAFX2vL57BpDjcVBck=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=ZEYzwf9p3ASKlAzg4QRp2iTzmYceIPo2iZunOIf7dmywVa5DdjWZj9YWgQTKPQDz/F9
 iMCBQ9BuFygNFZPTpIFpXr2YBEC2mWoBST66Hvrd/s8KynPmZq7G09/OiUI92BNinKBTW
 JfpsfzgNCCY0hJwYDeEP5MT/025KUEa6Ev8=

--uiZUXxmgNm9ZvAL2ryP1
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline

--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >> From: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
> > =20
> >> This patch also squashes upstream commit 72e6841608b9 ("spi: spi-mem: =
Fix
> >> build error without CONFIG_SPI_MEM")' in the current patch as commit
> >> 46109648052f ("spi: spi-mem: export spi_mem_default_supports_op()")'
> >> introduced below build error when built without CONFIG_SPI_MEM:
> >=20
> > This puts function definition directly into header file; I don't think
> > that will work when multiple files include it.
> >=20
> > Adding "static inline" is the usual solution for this.
>=20
> Has been done upstream by b5881b153bc8 ("spi: spi-mem: Make
> spi_mem_default_supports_op() static inline")
>=20
> I was once raising this concern internally that when commits are
> backported not all of them are backported but since I did not know
> enough about how CIP wants to do the backporting so never raised the
> issue. But this is an example what I was concerned about.

We can probably create a simple script that goes through commits,
collects their "upstream" commit ids, and searches linux-next for
Fixes: xxx... So we'd have simple way of checking if we are missing
any fixes.

If Renesas could submit b5881b153bc8 ("spi: spi-mem: Make=20
spi_mem_default_supports_op() static inline") for 4.19-cip, it would
be nice :-).

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX/W44QAKCRAw5/Bqldv6
8ojCAJ40UmIVzREuhvt/g3RUEO8zaaIQlQCgprOeRXshD1NLzIGbKLjJ5O2Aksk=
=Fbmf
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--

--uiZUXxmgNm9ZvAL2ryP1
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6043): https://lists.cip-project.org/g/cip-dev/message=
/6043
Mute This Topic: https://lists.cip-project.org/mt/79450068/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--uiZUXxmgNm9ZvAL2ryP1--

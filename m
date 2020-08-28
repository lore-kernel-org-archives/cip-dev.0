Return-Path: <SRS0=maBD=CG=lists.cip-project.org=bounce+64572+5324+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B002C433E6
	for <cip-dev@archiver.kernel.org>; Fri, 28 Aug 2020 18:15:56 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 676582074A
	for <cip-dev@archiver.kernel.org>; Fri, 28 Aug 2020 18:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="XYD0fN01"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 676582074A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5324+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id L2bcYY4521723xIPbzSgglKj; Fri, 28 Aug 2020 11:15:56 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.686.1598638554985956043
 for <cip-dev@lists.cip-project.org>;
 Fri, 28 Aug 2020 11:15:55 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 7BC751C0B76; Fri, 28 Aug 2020 20:15:53 +0200 (CEST)
Date: Fri, 28 Aug 2020 20:15:53 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Chris Paterson <chris.paterson2@renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 00/10] Add OPP/Thermal/Timer/CAN[FD] support
Message-ID: <20200828181553.GB10270@duo.ucw.cz>
References: <20200825132156.7839-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <20200825132156.7839-1-biju.das.jz@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: ZjYFElDT7yMtvou69oFBpctGx4520388AA=
Content-Type: multipart/mixed; boundary="cv5RIwmW6K2L0odnt0jY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598638556;
 bh=XfS+fV6gRl4GaHy2vUSeyvmvD3D2IhdSYl/ndVvCjUk=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=XYD0fN011ZmnBYTS+A2e1Q7V3RDrJJC6s6dN2ckBiryEAxQIl/kq+Jrc31uleRGN8Of
 EDLPxGvbdS4Cxun+ukreaS3RJV8j7jycoBnsgbRK1hgdT9AnTB2GVHJY0UCORNqaMjLF5
 uQhY6izow1DMy9TvJxMLl/BvAmY0ta1b8VY=

--cv5RIwmW6K2L0odnt0jY
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ADZbWkCsHQ7r3kzd"
Content-Disposition: inline

--ADZbWkCsHQ7r3kzd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series add RZ/G2H SoC support for OPP/Thermal/Timer/CAN[FD]
> to 4.19.y cip kernel.
>=20
> All the patches in this series are cherry-picked from ML.
>=20
> This patch series depend upon [1]
> [1]: https://patchwork.kernel.org/project/cip-dev/list/?series=3D336609

Thanks, applied and pushed out.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--ADZbWkCsHQ7r3kzd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX0lJ2QAKCRAw5/Bqldv6
8jBzAKCeNB3kAD6sbNDjENH3SC25q5ANrgCdHxFMFQbSOBnASK3lViZmim+OYdM=
=c9pS
-----END PGP SIGNATURE-----

--ADZbWkCsHQ7r3kzd--

--cv5RIwmW6K2L0odnt0jY
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5324): https://lists.cip-project.org/g/cip-dev/message=
/5324
Mute This Topic: https://lists.cip-project.org/mt/76406704/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--cv5RIwmW6K2L0odnt0jY--

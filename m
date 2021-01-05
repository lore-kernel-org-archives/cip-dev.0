Return-Path: <SRS0=28EZ=GI=lists.cip-project.org=bounce+64572+6036+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C54C8C433E0
	for <cip-dev@archiver.kernel.org>; Tue,  5 Jan 2021 17:04:58 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7518922CB9
	for <cip-dev@archiver.kernel.org>; Tue,  5 Jan 2021 17:04:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7518922CB9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6036+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id YcvzYY4521723xlRF4KcXZng; Tue, 05 Jan 2021 09:04:58 -0800
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.201.1609866296722197467
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Jan 2021 09:04:57 -0800
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 5862A1C0B77; Tue,  5 Jan 2021 18:04:52 +0100 (CET)
Date: Tue, 5 Jan 2021 18:04:51 +0100
From: "Pavel Machek" <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH v3 4.19.y-cip 00/17] Add Renesas RPC-IF driver
Message-ID: <20210105170451.GF361@amd>
References: <20210105135757.11069-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <20210105135757.11069-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 6nWUPJ5URx9YMzZctnBi07Ozx4520388AA=
Content-Type: multipart/mixed; boundary="jc2Y5MY3XniXZ3vDz0uo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1609866298;
 bh=WdSHerS9LUuqLu9Xb3xh2c00HV6dTELmisPWhTh7VuE=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=f/d/5HnOM/BPozByUG+pmES7LDgWYvt1puuXglbABne66d8evUEVuig0o1NJPHvO+9o
 ie4LC++pKP9XhPFJPskONawemMwxaWyH0aBlyjdSgXLVBP6oSXbV/V+MRch3LxxfbDCt4
 j5c4d/6WHVhn7JHyiXMPl0lNxsr6T+pcZ1E=

--jc2Y5MY3XniXZ3vDz0uo
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FoLtEtfbNGMjfgrs"
Content-Disposition: inline

--FoLtEtfbNGMjfgrs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series adds SPI driver for the Renesas RPC-IF.
> Alongside relevant changes for spi-mem have been also backported.
> This enables accessing SPI flash chip connected to RPC-IF.
>=20
> The series includes just the driver changes as the DTS/i changes are
> currently being upstreamed [1]. The driver has been tested on RZ/G2{EM}
> with all the required dts/i changes [2].
>=20
> All the patches have been cherry picked from Linux 5.11-rc2.

Thanks, series looks good. I commented on the individual patches, but
all but one are cleanup suggestions, not bugs spotted.

Tests do not show anything bad:

https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/237669839

(but we don't have the driver enabled in our configs..)

I believe this can go in. I can apply it if there are no other
comments.

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--FoLtEtfbNGMjfgrs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl/0nDMACgkQMOfwapXb+vK4cACffCyUZtaeQFjBcOdoaC5YNTAh
+7kAoJKsRA1QrISSthfyqkKwxdCPCSCr
=VzzP
-----END PGP SIGNATURE-----

--FoLtEtfbNGMjfgrs--

--jc2Y5MY3XniXZ3vDz0uo
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6036): https://lists.cip-project.org/g/cip-dev/message=
/6036
Mute This Topic: https://lists.cip-project.org/mt/79450058/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--jc2Y5MY3XniXZ3vDz0uo--

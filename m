Return-Path: <SRS0=8iWr=CE=lists.cip-project.org=bounce+64572+5272+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB2F7C433E1
	for <cip-dev@archiver.kernel.org>; Wed, 26 Aug 2020 21:46:32 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F86B207CD
	for <cip-dev@archiver.kernel.org>; Wed, 26 Aug 2020 21:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="NlSdROxT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F86B207CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5272+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id fhzZYY4521723xUrgn8Qo6UT; Wed, 26 Aug 2020 14:46:31 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.5585.1598478389692373715
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Aug 2020 14:46:30 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id E9F7B1C0BD8; Wed, 26 Aug 2020 23:46:24 +0200 (CEST)
Date: Wed, 26 Aug 2020 23:46:24 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Chris Paterson <chris.paterson2@renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 00/10] Add support for [H]SCIF/SDHI/I2C/RWDT/MSIOF
Message-ID: <20200826214624.GB15974@amd>
References: <20200826112132.4090-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <20200826112132.4090-1-biju.das.jz@bp.renesas.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: i7uToR5doyOHzDKCvxsiLpbhx4520388AA=
Content-Type: multipart/mixed; boundary="d9hpLotKbhK3bbSSc4UA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598478391;
 bh=5vBcqRfbDNcP3nwATn5R1BwFgwzx8tIl3y8QmDEMqtQ=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=NlSdROxTXme0oxT0Vof0qbFIingEOpoJvMV5qDF6cFDYfvzJvJwzDKrreoCCEmy+QDm
 I5o1Hp4XmSSAbpY8xBIVY1jZMAthwpwijGYzfuk94JbYY9t4+vMYrHNPmaOU9k4n2wdGm
 /tbYjK0X9l8Dadgx7wv06/UgvWNwS6LNMOU=

--d9hpLotKbhK3bbSSc4UA
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZoaI/ZTpAVc4A5k6"
Content-Disposition: inline

--ZoaI/ZTpAVc4A5k6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Add RZ/G2H SoC support for [H]SCIF/SDHI/I2C/RWDT/MSIOF on 4.19.y-cip kern=
el.
>=20
> All the patches in this series are cherry-piced from ML, except [1] which=
 is=20
> a new patch similar to the workdone for other similar SoC's

Series looks good to me. (But gitlab testing does not seem to work,
and it would be good to test it before applying).

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--ZoaI/ZTpAVc4A5k6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl9G2DAACgkQMOfwapXb+vIiEgCfWKz2pZfgKVLArM7YeRjWRonD
EmYAni5Tv6WuAstoe8q2nya1+sjxcFQp
=BPij
-----END PGP SIGNATURE-----

--ZoaI/ZTpAVc4A5k6--

--d9hpLotKbhK3bbSSc4UA
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5272): https://lists.cip-project.org/g/cip-dev/message=
/5272
Mute This Topic: https://lists.cip-project.org/mt/76426354/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--d9hpLotKbhK3bbSSc4UA--

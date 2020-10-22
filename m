Return-Path: <SRS0=8crX=D5=lists.cip-project.org=bounce+64572+5654+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE74AC388F2
	for <cip-dev@archiver.kernel.org>; Thu, 22 Oct 2020 12:23:59 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99863221FB
	for <cip-dev@archiver.kernel.org>; Thu, 22 Oct 2020 12:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="lEgk6aCM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99863221FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5654+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id X6rJYY4521723xkCWFN2JYiY; Thu, 22 Oct 2020 05:23:57 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.9469.1603369436127387658
 for <cip-dev@lists.cip-project.org>;
 Thu, 22 Oct 2020 05:23:56 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id DE7311C0B78; Thu, 22 Oct 2020 14:23:50 +0200 (CEST)
Date: Thu, 22 Oct 2020 14:23:50 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: cip-dev@lists.cip-project.org
Cc: Pavel Machek <pavel@denx.de>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 00/13] Enhancements to PCIe EPF
Message-ID: <20201022122350.GA32281@duo.ucw.cz>
References: <20201022101614.9298-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <20201022101614.9298-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: TnNj3rkPBMh4rlYNu730TDCIx4520388AA=
Content-Type: multipart/mixed; boundary="ZxGaLfW03eKSxTxguqyt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1603369437;
 bh=YacY3jUV4M2Bv8GlQOYUI+3sLoyPqNVJGBEnO9VLINs=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=lEgk6aCM0Bc1705xCh8NVPBg43Hy+xtQiYH/ZASS6LkbDNn95gP0rCVxzdAcanZT3RX
 djl6hi3kAsdbZihVy6LTeJfeuSrZmYr+eSb0ZrrRdnrUEfh6yPBHn+y8BDcmlhySNp8x/
 kIQfSOZB+3ZgKVIqPHft50Q1Fdh4Vc309G8=

--ZxGaLfW03eKSxTxguqyt
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline

--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series is part of RFC series [1] ("Add PCIe EP support for
> Renesas R-Car Gen3 and RZ/G2x"). For making it more cleaner and easier
> to review series [1] is split up as suggested by Pavel, patches 23-29,
> 31, 33-37 are included in this set from [1].

Thanks, applied and pushed out.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX5F51gAKCRAw5/Bqldv6
8hOBAJ9ACgsWvxf8vTKJHVmXiOBA9zBLUACgmDCYV05GxVrSlL2UHUAF9LVxnNg=
=wC4V
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--

--ZxGaLfW03eKSxTxguqyt
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5654): https://lists.cip-project.org/g/cip-dev/message=
/5654
Mute This Topic: https://lists.cip-project.org/mt/77727245/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--ZxGaLfW03eKSxTxguqyt--

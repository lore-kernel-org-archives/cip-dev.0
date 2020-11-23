Return-Path: <SRS0=3rS9=E5=lists.cip-project.org=bounce+64572+5825+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6DE0C2D0E4
	for <cip-dev@archiver.kernel.org>; Mon, 23 Nov 2020 18:53:03 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A2D520728
	for <cip-dev@archiver.kernel.org>; Mon, 23 Nov 2020 18:53:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="ZZwo9x0r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A2D520728
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5825+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id v87MYY4521723xiZK28k1sUL; Mon, 23 Nov 2020 10:53:00 -0800
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web08.40178.1606157569395578538
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Nov 2020 10:52:49 -0800
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 85C681C0BA1; Mon, 23 Nov 2020 19:52:44 +0100 (CET)
Date: Mon, 23 Nov 2020 19:52:44 +0100
From: "Pavel Machek" <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 0/2] Add sound support to R8A774E1 SoC
Message-ID: <20201123185244.GA13360@duo.ucw.cz>
References: <20201123105453.22074-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <20201123105453.22074-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: pAVeB7MUxiLGyo1lYz6HPPnYx4520388AA=
Content-Type: multipart/mixed; boundary="3rUt5ivNtXbUY2mLgsIj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606157580;
 bh=k/61kd+AdxssWKppCZFe87AHKqCyEKFrX5Fyq+CWkw8=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=ZZwo9x0rLxoEZD71LgbZe/55jbyTKcAmAf0uES2H4X02oZnNbheJo43BXHgk5U/7a1h
 NdUe/OLsWQQqu9CIuuHubF9HDzgfcKjQTKwO31QOik//pE1IsP607czQ0WGtaYQhyYrxT
 Bzx1bh5ivLGI8BDiyKs4Cf5fglJMvZ+1KJw=

--3rUt5ivNtXbUY2mLgsIj
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Content-Disposition: inline

--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series adds sound support to Renesas R8A774E1 SoC.
>=20
> All the patches have been cherry picked from Linux v5.10-rc5.

I don't see any problems here. If there are no other comments, I can
apply it.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX7wE/AAKCRAw5/Bqldv6
8jTpAJ45QNoPtH7QUu1z2z+VXTyjtz9mhwCgudMYyg/kX3OqPGWERq76NCQu5mU=
=Q25T
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--

--3rUt5ivNtXbUY2mLgsIj
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5825): https://lists.cip-project.org/g/cip-dev/message=
/5825
Mute This Topic: https://lists.cip-project.org/mt/78450804/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--3rUt5ivNtXbUY2mLgsIj--

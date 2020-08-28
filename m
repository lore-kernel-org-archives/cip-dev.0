Return-Path: <SRS0=p/L/=CG=lists.cip-project.org=bounce+64572+5323+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80D4C433E6
	for <cip-dev@archiver.kernel.org>; Fri, 28 Aug 2020 18:11:54 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45C8E2098B
	for <cip-dev@archiver.kernel.org>; Fri, 28 Aug 2020 18:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="s9CiwgDd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45C8E2098B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5323+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 5XaTYY4521723xpr6sy8wr4Y; Fri, 28 Aug 2020 11:11:53 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.599.1598638312145865908
 for <cip-dev@lists.cip-project.org>;
 Fri, 28 Aug 2020 11:11:53 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 0EC471C0B76; Fri, 28 Aug 2020 20:11:48 +0200 (CEST)
Date: Fri, 28 Aug 2020 20:11:47 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: cip-dev@lists.cip-project.org
Cc: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip] arm64: dts: renesas: Fix SD Card/eMMC interface device node names
Message-ID: <20200828181147.GA10270@duo.ucw.cz>
References: <20200827154032.28116-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <20200827154032.28116-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 46suMyfvILccVuOajU5YT9OFx4520388AA=
Content-Type: multipart/mixed; boundary="O3So2U1pPp4UDTsV4cyW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598638313;
 bh=QDKN9CRcC/eKiWi08uwKi8pwQYCAb9PKllCSJR1vN6A=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=s9CiwgDdCCOHRkWTxXsY5gQN1YC0L7FpJAXPfsszR+L1IW+oOSUZmWJyCc7RaPZZcYS
 vRl8X7uUCCqHnaCcn1defo/ERx5caJzc7fFuL7IYDuZm3QAjbuzlm1gbpt3XwV+W8d2xC
 MOg6zLw0QRTp2+RbregYuGT77dhrPM4kDdM=

--O3So2U1pPp4UDTsV4cyW
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline

--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>=20
> commit a6cb262af1e1adfa6287cb43f09021ee42beb21c upstream.
>=20
> Fix the device node names as "mmc@".

I believe this is only fix for some dtc warnings, so... it is not too
urgent.

Anyway, it is okay, and i'll apply it soon if there are no objections.

Best regards,
								Pavel
							=09

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX0lI4wAKCRAw5/Bqldv6
8oFjAJ9PL6nHXN309IOsRip1Mm2iZRbsqwCdGgIQUQzEhLWtrRK+ivt8LT5Sj8c=
=4XFA
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--

--O3So2U1pPp4UDTsV4cyW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5323): https://lists.cip-project.org/g/cip-dev/message=
/5323
Mute This Topic: https://lists.cip-project.org/mt/76454173/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--O3So2U1pPp4UDTsV4cyW--

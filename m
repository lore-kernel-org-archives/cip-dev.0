Return-Path: <SRS0=4lPG=EI=lists.cip-project.org=bounce+64572+5708+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 504A3C00A89
	for <cip-dev@archiver.kernel.org>; Mon,  2 Nov 2020 10:31:30 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A8D321D40
	for <cip-dev@archiver.kernel.org>; Mon,  2 Nov 2020 10:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="DFPbCCCZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A8D321D40
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5708+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id msIPYY4521723xClZ2G6LXoq; Mon, 02 Nov 2020 02:31:26 -0800
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.29381.1604313085304018414
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Nov 2020 02:31:25 -0800
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 48DC01C0B7F; Mon,  2 Nov 2020 11:31:20 +0100 (CET)
Date: Mon, 2 Nov 2020 11:31:19 +0100
From: "Pavel Machek" <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 0/6] Renesas RZ/G2H add PCIe{EP}/SATA support
Message-ID: <20201102103119.GA6161@duo.ucw.cz>
References: <20201102092443.4142-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <20201102092443.4142-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: nTp73l3jBkOkaDMERyTtzhwOx4520388AA=
Content-Type: multipart/mixed; boundary="NA5Cdc6QDCSDc4tZGh2Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1604313086;
 bh=1ryrAo/M2W8PMUwqIw9Kxbk78Nb55Bhrv+wUGj0Trzo=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=DFPbCCCZJzHuPks1mQCqq63uKcoNPQY4q3xmyyvrqls32NrebWhh7NkpSqB7x2IP3ne
 HIGW6h4qR/pa5TaToetfvWZ7mEYUxrIRMu4S03VQTkD3v1BuSz/DCJhsOTwo/p+FB0bX2
 psEkZXX1OhsU4f62rah6yhWJu7b6OAZIXTw=

--NA5Cdc6QDCSDc4tZGh2Q
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline

--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series adds PCIe{EP}/SATA support to Renesas RZ/G2H.
>=20
> All the patches have been cherry-picked from mainline kernel
> v5.10-rc2.

Looks good and passes our tests. I can apply it if there are no other
comments.

Best regards,
								Pavel
							=09
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX5/f9wAKCRAw5/Bqldv6
8oDgAKClvL/g3hYmJRgqVVQZZqvviuX05wCgqiF2sgbwZJiOcBDufaAAgLYNFmg=
=n1+4
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--

--NA5Cdc6QDCSDc4tZGh2Q
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5708): https://lists.cip-project.org/g/cip-dev/message=
/5708
Mute This Topic: https://lists.cip-project.org/mt/77977469/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--NA5Cdc6QDCSDc4tZGh2Q--

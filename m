Return-Path: <SRS0=xE4W=GJ=lists.cip-project.org=bounce+64572+6045+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E3BC433DB
	for <cip-dev@archiver.kernel.org>; Wed,  6 Jan 2021 17:08:25 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5282C22EBD
	for <cip-dev@archiver.kernel.org>; Wed,  6 Jan 2021 17:08:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5282C22EBD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6045+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id jYgyYY4521723x2enHGmdhdK; Wed, 06 Jan 2021 09:08:23 -0800
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web09.11067.1609952902293966802
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Jan 2021 09:08:22 -0800
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id C1C251C0B93; Wed,  6 Jan 2021 18:08:16 +0100 (CET)
Date: Wed, 6 Jan 2021 18:08:16 +0100
From: "Pavel Machek" <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip] spi: spi-mem: Make spi_mem_default_supports_op() static inline
Message-ID: <20210106170816.GA16394@duo.ucw.cz>
References: <20210106132221.17458-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <20210106132221.17458-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 8Y3sY6u4YeuRPiGAQNZitg3nx4520388AA=
Content-Type: multipart/mixed; boundary="DwjXsS19wGj5MesqvVKp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1609952903;
 bh=ytnWMo4lWVN1NJTI8OZeuEdPiqEh3tYjMPQCdfptEhc=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=JNaq5f8ndvBaXUc/doL3hf1VSmyvpcaB//hOZUwU3r8j8xd3GQFTRYYTMBWd0jdpwoH
 r1ik6Q38w9yiLdOhDCqxX1CDZ/8GPkYG9HHlAKhkw7b85wVYbpg2vKorsj2p+2jKFrNmn
 bsPyqO2Vt2JWWQJYyDENC+Z2sKFI42/eip4=

--DwjXsS19wGj5MesqvVKp
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline

--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is a incremental patch on top of series [1], as you pointed out in
> patch [2] the function should be static, this patch fixes this issue
> and is backported from upstream kernel.

Thank you! I pushed applied and pushed the three series leading to
this ("Add Renesas RPC-IF driver", "Add missing rpc-if clock on
RZ/G2{E,M,N} SoC'", "Optimize pinctrl and add QSPI[01] pins for
RZ/G2{H,M,N,E}".)

This looks okay to me, so I'll test it and push it in few minutes.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX/XugAAKCRAw5/Bqldv6
8rbgAKCACbaNuVwYDmzDu3Esug7xh+UQnACcDFIXlJL7IZ1QtTlrSfKzEA0WsSE=
=RSWj
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--

--DwjXsS19wGj5MesqvVKp
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6045): https://lists.cip-project.org/g/cip-dev/message=
/6045
Mute This Topic: https://lists.cip-project.org/mt/79474032/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--DwjXsS19wGj5MesqvVKp--

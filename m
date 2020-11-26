Return-Path: <SRS0=TRrI=FA=lists.cip-project.org=bounce+64572+5884+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE28C56202
	for <cip-dev@archiver.kernel.org>; Thu, 26 Nov 2020 17:12:03 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0CDD206B5
	for <cip-dev@archiver.kernel.org>; Thu, 26 Nov 2020 17:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="irZfvy1n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0CDD206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5884+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id d2AhYY4521723xHDOoksqSD5; Thu, 26 Nov 2020 09:12:01 -0800
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web09.8271.1606410719900290717
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2020 09:12:00 -0800
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id DBCA61C0B8D; Thu, 26 Nov 2020 18:11:53 +0100 (CET)
Date: Thu, 26 Nov 2020 18:11:53 +0100
From: "Pavel Machek" <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip] arm64: dts: renesas: r8a774c0: Fix MSIOF1 DMA channels
Message-ID: <20201126171153.GA27329@duo.ucw.cz>
References: <20201126113711.5176-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <20201126113711.5176-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: N14nnrxIqELOw6WblGZKk3AEx4520388AA=
Content-Type: multipart/mixed; boundary="sgAg2L7Grx8tOSuiY0GI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606410721;
 bh=XjwAceCWkhHuX2t2PivLMx8jP0wfA4kR/RHw0zXxjVA=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=irZfvy1nGACjUNBwuVuj9iwElIGIsV5IFxv3SOpNFi4fkQEC9mG8hlpHB5gOaWyUwRn
 Z0xJUjo/vhNXFdEXrxZ9XfG6EZVbOieau3tvFIsgUPtaEkzNTIoSOgOkvu3tKA6EFYgup
 fXO9QYs5d3rJ4nLB9HHNzz848vwYeKsqUwo=

--sgAg2L7Grx8tOSuiY0GI
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline

--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Geert Uytterhoeven <geert+renesas@glider.be>
>=20
> commit c91dfc9818df5f43c10c727f1cecaebdb5e2fa92 upstream.
>=20
> According to Technical Update TN-RCT-S0352A/E, MSIOF1 DMA can only be
> used with SYS-DMAC0 on R-Car E3.

Looks good to me, I can apply it if there are no other comments.

(I note you switched from dmac1 + dmac2 to dma_0_ only. I believe you
double checked that's okay, but I wonder how it worked before the
patch?)

Best regards,
								Pavel
							=09
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX7/h2QAKCRAw5/Bqldv6
8jWiAKCOhdEHdhdVNHMqHEXzvpqhG6rvrwCeJJB1z4AIrrOv/irJwjFOL+kvWo0=
=vOpc
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--

--sgAg2L7Grx8tOSuiY0GI
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5884): https://lists.cip-project.org/g/cip-dev/message=
/5884
Mute This Topic: https://lists.cip-project.org/mt/78527519/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--sgAg2L7Grx8tOSuiY0GI--

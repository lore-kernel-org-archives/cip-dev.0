Return-Path: <SRS0=4m+N=CK=lists.cip-project.org=bounce+64572+5360+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96231C433E2
	for <cip-dev@archiver.kernel.org>; Tue,  1 Sep 2020 20:12:08 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E152B207D3
	for <cip-dev@archiver.kernel.org>; Tue,  1 Sep 2020 20:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="k0f+uZu6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E152B207D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5360+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id aP7pYY4521723xSj2OqY8kxp; Tue, 01 Sep 2020 13:12:07 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.5195.1598991124965621158
 for <cip-dev@lists.cip-project.org>;
 Tue, 01 Sep 2020 13:12:05 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id BB0EC1C0B9C; Tue,  1 Sep 2020 22:12:00 +0200 (CEST)
Date: Tue, 1 Sep 2020 22:11:57 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Chris Paterson <chris.paterson2@renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.4.y-cip 00/10] Add IRQC/I2C/IIC/AVB/APMU support for RZ/G1H
Message-ID: <20200901201157.GA11492@duo.ucw.cz>
References: <20200901114114.3465-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <20200901114114.3465-1-biju.das.jz@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: ikL9nItrVe1sQXwrcGq4kDhWx4520388AA=
Content-Type: multipart/mixed; boundary="YTDoY7XAZJBH4KjM2idS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598991127;
 bh=y8856kVJk3FQxhqo3bMVThEUWfPOWeZehgvMZoS2D1g=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=k0f+uZu6cZRno/5840jVyjfyimbvouaG2rJmjev2Oa25F11QzoPhEU5F2iQJK8NpJEW
 dwwisZUXN3B0Mny97R6t+4AUR42RAK8uRSZTo/+Gttc8xY7hLR5ZHs3Rqh1o8Qyl+9iYn
 GSIovwfudQFG6wO5+QvdcrOZUO2cDVitwVg=

--YTDoY7XAZJBH4KjM2idS
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline

--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series add IRQC/I2C/IIC/AVB/APMU support for iWave RZ/G1H boar=
d based on
> r8a7742 SoC to 4.4.y-cip kernel. All patches in this series
> are cherry-picked from mainline.

Series looks good to me. I can apply it if there are no other comments
(and if it passes testing).

Best regards,
								Pavel
							=09
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX06rDQAKCRAw5/Bqldv6
8v4rAKDEV3eS4fbOiJktAzBsvvubNqEYywCfUJF4oPOP6FxXgg/xpDdydJg9UJI=
=1TzQ
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--

--YTDoY7XAZJBH4KjM2idS
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5360): https://lists.cip-project.org/g/cip-dev/message=
/5360
Mute This Topic: https://lists.cip-project.org/mt/76554005/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--YTDoY7XAZJBH4KjM2idS--

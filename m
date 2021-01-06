Return-Path: <SRS0=XB6b=GJ=lists.cip-project.org=bounce+64572+6047+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A1A8C433DB
	for <cip-dev@archiver.kernel.org>; Wed,  6 Jan 2021 17:39:51 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48A0720657
	for <cip-dev@archiver.kernel.org>; Wed,  6 Jan 2021 17:39:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48A0720657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6047+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id KuhWYY4521723xfOEKHizfXi; Wed, 06 Jan 2021 09:39:49 -0800
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.11887.1609954787949209662
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Jan 2021 09:39:48 -0800
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 941E61C0B79; Wed,  6 Jan 2021 18:39:41 +0100 (CET)
Date: Wed, 6 Jan 2021 18:39:41 +0100
From: "Pavel Machek" <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip] spi: spi-mem: Make spi_mem_default_supports_op() static inline
Message-ID: <20210106173941.GA18952@duo.ucw.cz>
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
X-Gm-Message-State: 498wkWpiKyNBrQtPUjnpfn4ux4520388AA=
Content-Type: multipart/mixed; boundary="STxSlrVtPhC1W5RbqyV8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1609954789;
 bh=18QRTTgKwQYxusXmZK40fRxSN7WqlaP6hyNJXUVop3o=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=MlZ3fSoE0uWWzD2UeI121yhlShsDzXp5b0iFroC8GPWwYK9OhJZepPWvtRSFgqz9uWo
 FFOuAyqBJ5DB3eRTC6HDjtPheKA2aaQ3Ir/Pm8dXREFrTPltdfb+VBRaZ4s1zVaaPQYUY
 gkoRcmGgXXpqMkZj4KyZ5R6rlT9qC9Cjps0=

--STxSlrVtPhC1W5RbqyV8
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline

--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> commit b5881b153bc81d63a5a7e82a35e8a4bdbe1f8c73 upstream.
>=20
> Stub helper spi_mem_default_supports_op() should
> be set to static inline
>=20
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> Hi Pavel,
>=20
> This is a incremental patch on top of series [1], as you pointed out in
> patch [2] the function should be static, this patch fixes this issue
> and is backported from upstream kernel.

Thanks, applied and pushed out.

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX/X13QAKCRAw5/Bqldv6
8qfpAJ0XCo3vQ5OYUtRIgbtqAxLG9FgsbwCfV7Q3Y917L59PJuBF6XDTe6+4e+k=
=gAzn
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--

--STxSlrVtPhC1W5RbqyV8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6047): https://lists.cip-project.org/g/cip-dev/message=
/6047
Mute This Topic: https://lists.cip-project.org/mt/79474032/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--STxSlrVtPhC1W5RbqyV8--

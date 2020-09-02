Return-Path: <SRS0=VQxc=CL=lists.cip-project.org=bounce+64572+5369+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E914C433E7
	for <cip-dev@archiver.kernel.org>; Wed,  2 Sep 2020 13:33:33 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BF4120767
	for <cip-dev@archiver.kernel.org>; Wed,  2 Sep 2020 13:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="uKNSX7nu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BF4120767
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5369+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id m3kzYY4521723xQjZiu5wXNn; Wed, 02 Sep 2020 06:33:31 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.7391.1599053610324422110
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Sep 2020 06:33:30 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id B81611C0B93; Wed,  2 Sep 2020 15:33:25 +0200 (CEST)
Date: Wed, 2 Sep 2020 15:33:24 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: biju.das.jz@bp.renesas.com, cip-dev@lists.cip-project.org,
	pavel@denx.de, chris.paterson2@renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: Re: [cip-dev] [PATCH 4.4.y-cip 0/5] Add RZ/G1H MMC/SDHI support
Message-ID: <20200902133324.GA10493@duo.ucw.cz>
References: <20200902075035.4445-1-biju.das.jz@bp.renesas.com>
 <OSBPR01MB29839D5D38C48CF0899AB729922F0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <OSBPR01MB29839D5D38C48CF0899AB729922F0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: FZMs6JbdCMYtPIu1BmoJeR84x4520388AA=
Content-Type: multipart/mixed; boundary="79CScOJ085i5AfS8Pv6X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1599053611;
 bh=Pme8Klr3LaaUm51Es+lDfdYqQUu9KqlqKYFqAX6e5HE=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=uKNSX7nu6rBe1rIBSw6NXqtt7JFvSEAoRGvcLos//WE5XSs1QBeJUm82UOIxSE1KE1M
 d7LGUI9CqWwg3m7fPxPKQ1oUXtBvzYwvoFLztVdA7gti+MB6HzYiuCPagiefdkbgwVd+A
 LYQW9suPWb48LdfCy++wpr7VciA5AyyHj50=

--79CScOJ085i5AfS8Pv6X
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline

--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >  .../devicetree/bindings/mmc/tmio_mmc.txt      |  1 +
> >  arch/arm/boot/dts/r8a7742-iwg21d-q7.dts       | 39 ++++++++++
> >  arch/arm/boot/dts/r8a7742.dtsi                | 71 +++++++++++++++++++
> >  arch/arm/boot/dts/r8a7743.dtsi                |  6 +-
> >  arch/arm/boot/dts/r8a7744.dtsi                |  6 +-
> >  arch/arm/boot/dts/r8a7745.dtsi                |  6 +-
> >  arch/arm/boot/dts/r8a77470.dtsi               |  6 +-
> >  7 files changed, 123 insertions(+), 12 deletions(-)
>=20
> This patch series looks good to me.
> If there are no other comments, I will apply this.

I reviewed the series and they look good to me.

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX0+fJAAKCRAw5/Bqldv6
8ix6AJ49g522w4xTvHxyosQ9Qkm8bUdfOQCfdhS3zhALSapwbQmyZZ2MqJ9JqcY=
=B39I
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--

--79CScOJ085i5AfS8Pv6X
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5369): https://lists.cip-project.org/g/cip-dev/message=
/5369
Mute This Topic: https://lists.cip-project.org/mt/76578438/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--79CScOJ085i5AfS8Pv6X--

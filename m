Return-Path: <SRS0=jo4w=CS=lists.cip-project.org=bounce+64572+5434+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6AA2C433E2
	for <cip-dev@archiver.kernel.org>; Wed,  9 Sep 2020 07:02:30 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C3F621532
	for <cip-dev@archiver.kernel.org>; Wed,  9 Sep 2020 07:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="wiVuY3qP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C3F621532
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5434+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id ouzwYY4521723x0qDv8z5fNZ; Wed, 09 Sep 2020 00:02:29 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.8067.1599634947855363300
 for <cip-dev@lists.cip-project.org>;
 Wed, 09 Sep 2020 00:02:28 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 9463C1C0B79; Wed,  9 Sep 2020 09:02:24 +0200 (CEST)
Date: Wed, 9 Sep 2020 09:02:24 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.4.y-cip] gpio: rcar: Avoid NULL pointer access in gpio_rcar_set_multiple()
Message-ID: <20200909070224.GD27139@duo.ucw.cz>
References: <20200904074057.27932-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <20200904074057.27932-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 58SJSP7a8ji8oQMIxLObK9Vkx4520388AA=
Content-Type: multipart/mixed; boundary="DNUwYumaxy0Stc8IxCZm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1599634949;
 bh=DMcPdLIYe/MQshVcIV2Bh6SK4j/fFBwLAs75dIdzWZM=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=wiVuY3qPVVvR0vzGrBVsssH3PbobDOhfPmRkB+db2wA3Pm5ViIrNyZL0WdFY3bGE5uy
 Fw2mBYe+y9mMSd19PHTFJBFfEpGgUQZ3BNqpdgj59SMD7/wT4lbyaNToS7b//2DrPvPuT
 QNMCdSHo92tg1V9Zv3ladKgb6Kg0VKqZnms=

--DNUwYumaxy0Stc8IxCZm
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iVCmgExH7+hIHJ1A"
Content-Disposition: inline

--iVCmgExH7+hIHJ1A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> gpiochip_get_data() expects the controller probe to call
> gpiochip_add_data() before using it, where as the rcar-gpio
> driver probe has gpiochip_add() call thus resulting in NULL
> pointer access.
>=20
> Avoid this case by using gpio_to_priv() call.
>=20
> Fixes: 6e52cced1aa58 ("gpio: rcar: Implement gpiochip.set_multiple()")
> Signed-off-by: Lad Prabhakar

Thanks, applied and pushed out.

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--iVCmgExH7+hIHJ1A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX1h+AAAKCRAw5/Bqldv6
8mJMAJ9kArZ/mg09WlOuk0o0PjFlixglUQCgkUm7BUBC3Pc8l+xfJQT6isg2Kok=
=D9/Y
-----END PGP SIGNATURE-----

--iVCmgExH7+hIHJ1A--

--DNUwYumaxy0Stc8IxCZm
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5434): https://lists.cip-project.org/g/cip-dev/message=
/5434
Mute This Topic: https://lists.cip-project.org/mt/76625137/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--DNUwYumaxy0Stc8IxCZm--

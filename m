Return-Path: <SRS0=qLGk=CM=lists.cip-project.org=bounce+64572+5410+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAEC4C2D0A6
	for <cip-dev@archiver.kernel.org>; Thu,  3 Sep 2020 20:51:45 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CE572067C
	for <cip-dev@archiver.kernel.org>; Thu,  3 Sep 2020 20:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="KZvbKKat"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CE572067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5410+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id zZdpYY4521723xJyZymbOgko; Thu, 03 Sep 2020 13:51:45 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.23819.1599166304363362083
 for <cip-dev@lists.cip-project.org>;
 Thu, 03 Sep 2020 13:51:44 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 148BD1C0B76; Thu,  3 Sep 2020 22:51:41 +0200 (CEST)
Date: Thu, 3 Sep 2020 22:51:34 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.4.y-cip 3/4] serial: sh-sci: Don't check for mctrl_gpio_init() returning -ENOSYS
Message-ID: <20200903205134.GC24361@duo.ucw.cz>
References: <20200903142719.13010-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200903142719.13010-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <20200903142719.13010-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: AXmHoiXKHfgobUbY4GG4AW7Xx4520388AA=
Content-Type: multipart/mixed; boundary="qPmcfHtm1irdqVtyqHGq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1599166305;
 bh=Rt+eKHXUeDfTTmyPM3e19SoPxMemCDIgsNs2RjHJJHU=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=KZvbKKatQMi8qVE2zKcDkSQy1iwtFkIvLgKPkKNGRUQq+4LVHBEraoqJUifUzX1Xstl
 g5WdYvWfpaU4yr3mX8AlOOD0k1hWAdnb3YZC2qlIvGo81cJnBwZiPQMq6VkLL/sNQ7Wri
 E7gJa4YjT/wNo0p6WrwVE0caId2xeH62DCQ=

--qPmcfHtm1irdqVtyqHGq
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+xNpyl7Qekk2NvDX"
Content-Disposition: inline

--+xNpyl7Qekk2NvDX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Now that the mctrl_gpio code returns NULL instead of ERR_PTR(-ENOSYS)
> if CONFIG_GPIOLIB is disabled, we can safely remove this check.

No, sorry, I don't think this is correct.

In 4.4, we still have

static inline struct gpio_desc *__must_check
devm_gpiod_get_index_optional(struct device *dev, const char *con_id,
                                unsigned int index, enum gpiod_flags flags)
{
        return ERR_PTR(-ENOSYS);
}

and that propagates through mctrl_gpio_init().

NAK.
								Pavel

> +++ b/drivers/tty/serial/sh-sci.c
> @@ -2778,7 +2778,7 @@ static int sci_probe_single(struct platform_device =
*dev,
>  		return ret;
> =20
>  	sciport->gpios =3D mctrl_gpio_init(&sciport->port, 0);
> -	if (IS_ERR(sciport->gpios) && PTR_ERR(sciport->gpios) !=3D -ENOSYS)
> +	if (IS_ERR(sciport->gpios))
>  		return PTR_ERR(sciport->gpios);
> =20
>  	if (p->capabilities & SCIx_HAVE_RTSCTS) {
> --=20
> 2.17.1
>=20

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--+xNpyl7Qekk2NvDX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX1FXVgAKCRAw5/Bqldv6
8kKOAKDC1jNDeU/XP+8W2C7chsjKU/O3WwCghTGylxqU8vuRskiO3aQ4NOVfGhY=
=3oFe
-----END PGP SIGNATURE-----

--+xNpyl7Qekk2NvDX--

--qPmcfHtm1irdqVtyqHGq
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5410): https://lists.cip-project.org/g/cip-dev/message=
/5410
Mute This Topic: https://lists.cip-project.org/mt/76607964/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--qPmcfHtm1irdqVtyqHGq--

Return-Path: <SRS0=RLdt=IH=lists.cip-project.org=bounce+64572+6257+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E6DEC433DB
	for <cip-dev@archiver.kernel.org>; Tue,  9 Mar 2021 18:55:33 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64D9264F25
	for <cip-dev@archiver.kernel.org>; Tue,  9 Mar 2021 18:55:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64D9264F25
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6257+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id tnsyYY4521723xlr1pmmODJD; Tue, 09 Mar 2021 10:55:32 -0800
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.14019.1615315951743812623
 for <cip-dev@lists.cip-project.org>;
 Tue, 09 Mar 2021 10:52:32 -0800
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 264321C0B78; Tue,  9 Mar 2021 19:52:27 +0100 (CET)
Date: Tue, 9 Mar 2021 19:52:26 +0100
From: "Pavel Machek" <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 12/40] media: dt-bindings: media: i2c: Add IMX219 CMOS sensor binding
Message-ID: <20210309185226.GA7023@duo.ucw.cz>
References: <20210309163656.20944-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20210309163656.20944-13-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <20210309163656.20944-13-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: MlOHaxmVCkeEC5LJJ0PXJTWux4520388AA=
Content-Type: multipart/mixed; boundary="F1SXNEQpZJYCVB1hoNTS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1615316132;
 bh=ZxZlNWXozJ0Gkeg9qHOIjq2Gr7HJ9Fa8+VqOR7cXZPc=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=k4oosQhzhwAixkKodOPHu2cius8Nm53shytBHYHWfwcGm/dlYXrFS32mCGYZtE93WhN
 hXNUuaCdZDuo0w2XXK3iM+8XH7khQblgUUG32Vop0Foo6MoV1X5GrZgkx8RUyNZmoiUQL
 hgBPjOxUOHmbQ42lv/IvAMEM6JoB9Y1jBzI=

--F1SXNEQpZJYCVB1hoNTS
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline

--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Andrey Konovalov <andrey.konovalov@linaro.org>
>=20
> commit 9d730f2cf4c0391785855dd231577d2de2594df9 upstream.
>=20
> Add YAML device tree binding for IMX219 CMOS image sensor, and
> the relevant MAINTAINERS entries.

> +title: Sony 1/4.0-Inch 8Mpixel CMOS Digital Image Sensor
> +
> +maintainers:
> +  - Dave Stevenson <dave.stevenson@raspberrypi.com>
> +
> +description: |-
> +  The Sony imx219 is a 1/4.0-inch CMOS active pixel digital image sensor

I assume it is 0.25 inch sensor? 1/4 inch or 0.25 inch would be
understandable, but 1/4.0 is kind of strange.


> +        imx219: sensor@10 {
> +            compatible =3D "sony,imx219";
> +            reg =3D <0x10>;
> +            clocks =3D <&imx219_clk>;
> +            VANA-supply =3D <&imx219_vana>;   /* 2.8v */
> +            VDIG-supply =3D <&imx219_vdig>;   /* 1.8v */
> +            VDDL-supply =3D <&imx219_vddl>;   /* 1.2v */

"V" should be uppercase in voltages.

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYEfD6gAKCRAw5/Bqldv6
8jSnAKCw5dqgA/UP3N7+++GxlQ2YI3ZnQgCgoAkX8E0PMlDLFexxgi8RLM0Futg=
=o/1h
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--

--F1SXNEQpZJYCVB1hoNTS
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6257): https://lists.cip-project.org/g/cip-dev/message=
/6257
Mute This Topic: https://lists.cip-project.org/mt/81205355/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--F1SXNEQpZJYCVB1hoNTS--

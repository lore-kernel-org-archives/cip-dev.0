Return-Path: <SRS0=4ODG=E6=lists.cip-project.org=bounce+64572+5852+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2EEAC2D0E4
	for <cip-dev@archiver.kernel.org>; Tue, 24 Nov 2020 17:58:15 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CFA720757
	for <cip-dev@archiver.kernel.org>; Tue, 24 Nov 2020 17:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="t1jkL0tg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CFA720757
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5852+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 34oYYY4521723x0t7eHpFO8z; Tue, 24 Nov 2020 09:58:13 -0800
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.780.1606240692472996678
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 Nov 2020 09:58:13 -0800
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 68DD21C0B9D; Tue, 24 Nov 2020 18:58:09 +0100 (CET)
Date: Tue, 24 Nov 2020 18:58:08 +0100
From: "Pavel Machek" <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Chris Paterson <chris.paterson2@renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH] dt-bindings: PCI: rcar: Add device tree support for r8a7742
Message-ID: <20201124175808.GA2713@duo.ucw.cz>
References: <20201124174036.14934-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <20201124174036.14934-1-biju.das.jz@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: Vb0l9Bg9vOQ5exHJZClo3hO2x4520388AA=
Content-Type: multipart/mixed; boundary="XwCh3QY9IQseAXcBqlIy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606240693;
 bh=YJtOqiwewgfnUwzDTlxL/xcJ5krMIplg3rD247+eSAo=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=t1jkL0tgwojEQT9djehdAfq8g/dL2ueN03LwOs5MPrwiEkbwSm18kg+yQ+oV7m0dG3F
 +eKtXn1QGG9XzlqLjnLAcZOYiPsWmsqdDHBJqnUDjeUSFUDLbHJpbACB6MvUo4bjo0dAV
 05uTCtXZ32Ao4suPmLwMWfkcZ7JA/rUKCJQ=

--XwCh3QY9IQseAXcBqlIy
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline

--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> commit d16d538ff49145b153976bd8e124116d369db266 upstream.
>=20
> Add support for r8a7742. The Renesas RZ/G1H (R8A7742) PCIe controller
> is identical to the R-Car Gen2 family.


Sure, we can apply this (I assume it is for 4.4)? But it will not
really add any support, it just documents the binding... so I assume
this should go into series with patches that actually change the dts
(and probably tweak the drivers)?

Best regards,
								Pavel

> diff --git a/Documentation/devicetree/bindings/pci/rcar-pci.txt b/Documen=
tation/devicetree/bindings/pci/rcar-pci.txt
> index bedfdc122543..8a3d8b5be515 100644
> --- a/Documentation/devicetree/bindings/pci/rcar-pci.txt
> +++ b/Documentation/devicetree/bindings/pci/rcar-pci.txt
> @@ -1,7 +1,8 @@
>  * Renesas R-Car PCIe interface
> =20
>  Required properties:
> -compatible: "renesas,pcie-r8a7743" for the R8A7743 SoC;
> +compatible: "renesas,pcie-r8a7742" for the R8A7742 SoC;
> +	    "renesas,pcie-r8a7743" for the R8A7743 SoC;
>  	    "renesas,pcie-r8a7779" for the R8A7779 SoC;
>  	    "renesas,pcie-r8a7790" for the R8A7790 SoC;
>  	    "renesas,pcie-r8a7791" for the R8A7791 SoC;
> --=20
> 2.17.1
>=20

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX71JsAAKCRAw5/Bqldv6
8mHlAJ9xvz8w9GuB7UWX4E+5b3wQdOoFEACgg3i30OSTg2RJ35HUsAYdbc9uOxA=
=KIPB
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--

--XwCh3QY9IQseAXcBqlIy
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5852): https://lists.cip-project.org/g/cip-dev/message=
/5852
Mute This Topic: https://lists.cip-project.org/mt/78482468/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--XwCh3QY9IQseAXcBqlIy--

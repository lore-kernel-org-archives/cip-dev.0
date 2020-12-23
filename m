Return-Path: <SRS0=yRKS=F3=lists.cip-project.org=bounce+64572+5973+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8628C433E0
	for <cip-dev@archiver.kernel.org>; Wed, 23 Dec 2020 00:13:19 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE3D82251E
	for <cip-dev@archiver.kernel.org>; Wed, 23 Dec 2020 00:13:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE3D82251E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5973+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id eGIIYY4521723xXdJdYu2dAC; Tue, 22 Dec 2020 16:13:18 -0800
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web09.2261.1608682397008529144
 for <cip-dev@lists.cip-project.org>;
 Tue, 22 Dec 2020 16:13:17 -0800
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 4F1A51C0B78; Wed, 23 Dec 2020 01:13:11 +0100 (CET)
Date: Wed, 23 Dec 2020 01:13:10 +0100
From: "Pavel Machek" <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.4.y-cip] ARM: dts: iwg22d-sodimm: Fix dt nodes sorting
Message-ID: <20201223001310.GA13078@amd>
References: <20201222112714.24595-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <20201222112714.24595-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 2xwFWqElXs37AbrCfSdRBW8Zx4520388AA=
Content-Type: multipart/mixed; boundary="7GWqklryMkeJzwBb3PHb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1608682398;
 bh=Bu4oTIwPdIXYe1J8yRO5KlgwCUYbE8g2eayHUtz0lZE=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=M3rlA9ppCIy4WDqIONztpF8aSz5rbyJI+Lv23t8iqghhrKiRuBTgau7NqWQt3/bxf6z
 YD5XCNFcXfDY2YpPHX+LlxMkMk42G10yo/i/SfbYcfNIiPW+kJzPtVpZ5r1mNZ6vv8KvT
 l2+Fbdwyyp+PFI5/un23gicAxCJA/DI0JI0=

--7GWqklryMkeJzwBb3PHb
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline

--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> commit 73aa5b7c941145b7a1a53f31b6a71dfe98007870 upstream.
>=20
> Some r8a7745-iwg22d-sodimm.dts device nodes are not sorted alphabetically.
> This patch fixes the sorting of nodes and also fixes a typo in the stmpe
> node.

I see why this is good idea for mainline, but do we need it in 4.4?

I guess it makes patch backporting easier, but maybe that can wait for
such backport?

>  		/* 3.25 MHz ADC clock speed */
>  		st,adc-freq =3D <1>;
> -		/* ADC converstion time: 80 clocks */
> +		/* ADC conversation time: 80 clocks */
>  		st,sample-time =3D <4>;

I believe this is wrong. Should be "conversion"?

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl/ii5YACgkQMOfwapXb+vIoDgCeO216hEbderCPB9+im82TEBFM
mkAAoJpeOinkLEMte6rLj13eNToCoud/
=MpX0
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--

--7GWqklryMkeJzwBb3PHb
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5973): https://lists.cip-project.org/g/cip-dev/message=
/5973
Mute This Topic: https://lists.cip-project.org/mt/79146851/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--7GWqklryMkeJzwBb3PHb--

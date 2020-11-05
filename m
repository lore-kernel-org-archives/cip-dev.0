Return-Path: <SRS0=njvh=EL=lists.cip-project.org=bounce+64572+5748+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12929C00A89
	for <cip-dev@archiver.kernel.org>; Thu,  5 Nov 2020 11:29:05 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8C6D2078E
	for <cip-dev@archiver.kernel.org>; Thu,  5 Nov 2020 11:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="Gw05BLsO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8C6D2078E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5748+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id Yr3IYY4521723xn5i78UZ1N7; Thu, 05 Nov 2020 03:29:01 -0800
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.6038.1604575739697598228
 for <cip-dev@lists.cip-project.org>;
 Thu, 05 Nov 2020 03:29:00 -0800
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 68DD31C0B82; Thu,  5 Nov 2020 12:28:55 +0100 (CET)
Date: Thu, 5 Nov 2020 12:28:54 +0100
From: "Pavel Machek" <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 4/6] arm64: dts: renesas: r8a774e1: Add USB2.0 phy and host (EHCI/OHCI) device nodes
Message-ID: <20201105112854.GA8073@duo.ucw.cz>
References: <20201105095039.4751-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201105095039.4751-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <20201105095039.4751-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: H3wWMjT9Qttywe8f8UF6wRqXx4520388AA=
Content-Type: multipart/mixed; boundary="LsfifrOHJ8ewEjWI3uug"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1604575741;
 bh=2l/2sXIe6d0tHwd8ZLyLwZA7jVS4vI3cdZydpOD1C3s=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=Gw05BLsOiXzzspzflJ9bYtSrTklZQg9fm0yJi0h/wEzOWyVUsInL4JvX4Y8KUhl3SHa
 asClD0lX641RzyDCyZW0g9eAsgw0KokYmXkaMAskYSa+MguQmEIgbLDOcBcjFLRLyFSQv
 bOqu8rCk6wCk4v4Qx6e5JUDwAcn2PXnXNeE=

--LsfifrOHJ8ewEjWI3uug
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline

--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> commit 92b2c276e15c7f93f1148329a1f713c51b26f652 upstream.
>=20
> Add USB2.0 phy and host (EHCI/OHCI) device nodes on RZ/G2H SoC dtsi.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renes=
as.com>
> Link: https://lore.kernel.org/r/1594919915-5225-7-git-send-email-prabhaka=
r.mahadev-lad.rj@bp.renesas.com
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  arch/arm64/boot/dts/renesas/r8a774e1.dtsi | 55 ++++++++++++++++++-----
>  1 file changed, 43 insertions(+), 12 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/renesas/r8a774e1.dtsi b/arch/arm64/boot/=
dts/renesas/r8a774e1.dtsi
> index 271045556aa0..106d64a8112a 100644
> --- a/arch/arm64/boot/dts/renesas/r8a774e1.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a774e1.dtsi
> @@ -1468,45 +1468,76 @@
>  		};
> =20
>  		ohci0: usb@ee080000 {
> +			compatible =3D "generic-ohci";

Should this have more complete compatible listed, too, for the
unlikely case hardware problem is discovered?

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX6Ph9gAKCRAw5/Bqldv6
8lmFAJ9V3xRVF3CJ5j5i+PV9q7eTd1oItACdHcatonZGVADgZ0Ui1YCX3XHNJIE=
=i8JQ
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--

--LsfifrOHJ8ewEjWI3uug
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5748): https://lists.cip-project.org/g/cip-dev/message=
/5748
Mute This Topic: https://lists.cip-project.org/mt/78047674/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--LsfifrOHJ8ewEjWI3uug--

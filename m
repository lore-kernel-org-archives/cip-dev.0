Return-Path: <SRS0=lhTs=FF=lists.cip-project.org=bounce+64572+5927+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1039C64E7A
	for <cip-dev@archiver.kernel.org>; Tue,  1 Dec 2020 09:49:01 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6886206C0
	for <cip-dev@archiver.kernel.org>; Tue,  1 Dec 2020 09:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="Nhrm1P2d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6886206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5927+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id UfsNYY4521723xJKr8aQe4dr; Tue, 01 Dec 2020 01:48:59 -0800
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.7953.1606816138158675509
 for <cip-dev@lists.cip-project.org>;
 Tue, 01 Dec 2020 01:48:59 -0800
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id B1CA61C0B8C; Tue,  1 Dec 2020 10:48:55 +0100 (CET)
Date: Tue, 1 Dec 2020 10:48:55 +0100
From: "Pavel Machek" <pavel@ucw.cz>
To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: Pavel Machek <pavel@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 4/6] arm64: dts: renesas: r8a774e1: Add USB2.0 phy and host (EHCI/OHCI) device nodes
Message-ID: <20201201094855.GA5579@duo.ucw.cz>
References: <20201105095039.4751-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201105095039.4751-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201105112854.GA8073@duo.ucw.cz>
 <OSBPR01MB50483903B8E5EF6CDB2B85F2AAEE0@OSBPR01MB5048.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <OSBPR01MB50483903B8E5EF6CDB2B85F2AAEE0@OSBPR01MB5048.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: YVG7CuFURsDYwLYgygjWvE1wx4520388AA=
Content-Type: multipart/mixed; boundary="ri1ldRoQy5rjQmFbeKZo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606816139;
 bh=tKM8UOwU3gHoW97FYHxYTwkABeIT6niQpQMsbt5j7Tg=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=Nhrm1P2dHlJDzeSTIvQGmlCyhifJUZxyKX4TimkrPrRZOJe4+og8YtMJP11XSMMkxnU
 Y3T0o+F1mOZ1kLDlbz3rXIyxSFfy5TdLS5azq3NvU67YESWDGpn0WhSIiTS/1fUjnrJGS
 yYcyhBF7x/D3kNV/3WYmeUPF8WFvqCny9os=

--ri1ldRoQy5rjQmFbeKZo
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Content-Disposition: inline

--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > --- a/arch/arm64/boot/dts/renesas/r8a774e1.dtsi
> > > +++ b/arch/arm64/boot/dts/renesas/r8a774e1.dtsi
> > > @@ -1468,45 +1468,76 @@
> > >  		};
> > >
> > >  		ohci0: usb@ee080000 {
> > > +			compatible =3D "generic-ohci";
> >=20
> > Should this have more complete compatible listed, too, for the
> > unlikely case hardware problem is discovered?
> >=20
> Controller is compatible with the generic OHCI driver as of now there are=
 no known hardware limitations. If in future if we come encounter any hardw=
are issue we will add SoC specific platform string with the fix.
>=20
> Hope this is OK with you.

Yes, OK with me, thanks.

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX8YRhwAKCRAw5/Bqldv6
8mCwAKCRBXpDJsUr9oTHVhkeMM5p26ScTQCbBf27FpBd+yxfoTBj2kCkyemCFIY=
=UTMY
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--

--ri1ldRoQy5rjQmFbeKZo
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5927): https://lists.cip-project.org/g/cip-dev/message=
/5927
Mute This Topic: https://lists.cip-project.org/mt/78047674/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--ri1ldRoQy5rjQmFbeKZo--

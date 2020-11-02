Return-Path: <SRS0=jxT3=EI=lists.cip-project.org=bounce+64572+5709+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65BB2C00A89
	for <cip-dev@archiver.kernel.org>; Mon,  2 Nov 2020 11:30:29 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C7FF22275
	for <cip-dev@archiver.kernel.org>; Mon,  2 Nov 2020 11:30:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="bvtk6peM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C7FF22275
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5709+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id ehNXYY4521723xPAibpKisEy; Mon, 02 Nov 2020 03:30:27 -0800
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web09.29694.1604316626089151581
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Nov 2020 03:30:26 -0800
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 547EC1C0B7D; Mon,  2 Nov 2020 12:30:22 +0100 (CET)
Date: Mon, 2 Nov 2020 12:30:21 +0100
From: "Pavel Machek" <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Cc: Pavel Machek <pavel@denx.de>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 0/5] Add PCIe EP nodes to RZ/G2{EMN}
Message-ID: <20201102113021.GA9840@duo.ucw.cz>
References: <20201027165622.28777-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201028152635.GA26388@duo.ucw.cz>
 <OSBPR01MB50480539DF66856499012B1EAA170@OSBPR01MB5048.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <OSBPR01MB50480539DF66856499012B1EAA170@OSBPR01MB5048.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: S82VfmyWp6rMep4UYG2gKRVNx4520388AA=
Content-Type: multipart/mixed; boundary="aGYwwJ0d1tSI66bvN806"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1604316627;
 bh=DwUsCY60qHkCboS0jKJ1sYi08yD/zQlWszUglljj8oo=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=bvtk6peMMNm1Zc4CvofcydqS632GpMv8yq3cDswRDenXFcMvXUxDk15kaJZu49amHBP
 9lMUZvASZiCjZp3RmliuOS0ueLGWWARROv1pW3uYcOJTAklabI18xzLj5UZgJ18gTUwlz
 x9hcXOnt/w2fLCaClcPqBKR+f6j3ys5m1EM=

--aGYwwJ0d1tSI66bvN806
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline

--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > These patches are part of RFC series [1] ({43-46,48}/50),
> > > these were dropped earlier as they weren't part of -rc release
> > > at the time of posting now that patches have landed in v5.10-rc1
> > > I am resending them with non-RFC tag.
> > >
> > > [1] https://patchwork.kernel.org/project/cip-dev/
> > >     list/?series=3D363279&state=3D%2A&archive=3Dboth
> >=20
> > Series looks good to me.
> >=20
> > >  arch/arm64/boot/dts/renesas/r8a774a1.dtsi     | 38 +++++++++++++++++=
++
> > >  arch/arm64/boot/dts/renesas/r8a774b1.dtsi     | 38 +++++++++++++++++=
++
> > >  arch/arm64/boot/dts/renesas/r8a774c0.dtsi     | 19 ++++++++++
> >=20
> > I see that the nodes are stil marked as "disabled"... I guess
> > devboards are not plugged into into PCIe hosts for the testing.
> >=20
> It's the same controller which works as a host and endpoint (PCIe EP). By=
 default on the boards  controller is enabled as host and not EP as a resul=
t status is set to disabled. So during testing host is disabled and EP is e=
nabled.
>=20
> > Anyway, it would be good to know if the merged -cip code was tested
> > and what was the result :-).
> >=20
> Attached are the results for G2M as PCIe host and G2N as PCIe EP tested o=
n CIP kernel.
>=20
> So on the host pcietest read/write/copy commands are tested (also
> lspci output)

Thank you!

Best regards,

								Pavel


--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX5/tzQAKCRAw5/Bqldv6
8nmiAJsFvA+8oj7jzVZd7sIgWgHTv71x5wCgtYw2Uu6YatoD90b7pJIgd9+BRTk=
=l1B3
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--

--aGYwwJ0d1tSI66bvN806
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5709): https://lists.cip-project.org/g/cip-dev/message=
/5709
Mute This Topic: https://lists.cip-project.org/mt/77842959/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--aGYwwJ0d1tSI66bvN806--

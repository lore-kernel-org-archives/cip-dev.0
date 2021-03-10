Return-Path: <SRS0=p7uf=II=lists.cip-project.org=bounce+64572+6268+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8D0C433E0
	for <cip-dev@archiver.kernel.org>; Wed, 10 Mar 2021 09:38:47 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4062664F6F
	for <cip-dev@archiver.kernel.org>; Wed, 10 Mar 2021 09:38:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4062664F6F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6268+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id HBC8YY4521723xfaYnU4FJ8H; Wed, 10 Mar 2021 01:38:45 -0800
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.6480.1615369123891734124
 for <cip-dev@lists.cip-project.org>;
 Wed, 10 Mar 2021 01:38:44 -0800
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 789FF1C0B80; Wed, 10 Mar 2021 10:38:30 +0100 (CET)
Date: Wed, 10 Mar 2021 10:38:30 +0100
From: "Pavel Machek" <pavel@denx.de>
To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: Pavel Machek <pavel@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 12/40] media: dt-bindings: media: i2c: Add IMX219 CMOS sensor binding
Message-ID: <20210310093830.GA24989@duo.ucw.cz>
References: <20210309163656.20944-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20210309163656.20944-13-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20210309185226.GA7023@duo.ucw.cz>
 <OSAPR01MB486786ED928CA022458782FBAA919@OSAPR01MB4867.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <OSAPR01MB486786ED928CA022458782FBAA919@OSAPR01MB4867.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 2itZKbyLKxddX1PJbZ2Bg8Vex4520388AA=
Content-Type: multipart/mixed; boundary="x4fWRleFxBSuwL1wjB6Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1615369125;
 bh=Mvuv8gG9Oii7UQV2BCdbvSlkNCXNItXk8g6nFVSxT+g=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=RUVecGu5IatP6msh05fXX2yIPeAcTYaeXP7tBiHf2t6SArZzeaXqI0dMaz0irDzVc7y
 YxuTFFJfqRnabAmjJ2ModoSSLpO6vr5M30oJS4ml56jZSA4jL3HjJ/9lzl2WyeI2efHQS
 9+FxHES+CQMDJdYl4dCi47MAViqwm5LRBPA=

--x4fWRleFxBSuwL1wjB6Q
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline

--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > +description: |-
> > > +  The Sony imx219 is a 1/4.0-inch CMOS active pixel digital image se=
nsor
> >=20
> > I assume it is 0.25 inch sensor? 1/4 inch or 0.25 inch would be
> > understandable, but 1/4.0 is kind of strange.
> >=20
> Agree with you here, but looking at the document [1] its referred the sam=
e way "1/4.0".
>=20
> [1] http://www.opensourceinstruments.com/Electronics/Data/IMX219PQ.pdf

It is refered as "Type 1/4.0" and I'm not really sure what it means.

1/4 inch is 6.35mm, but document states it is 4.6mm.

https://www.photoreview.com.au/tips/buying/unravelling-sensor-sizes/
explains this system, but they use 1/4", not 1/4.0, and it translates
that to 4.5mm.

I guess easiest way is to say it is "4.8mm CMOS active pixel digital
image sensor" and forget about confusing inch values.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYEiTlgAKCRAw5/Bqldv6
8qXDAJoDsLBhbOAalrRGaV0Sj+V8KdPxlwCfT3gYbNZMA1xmFhh1QdISnPpUa+A=
=8JxN
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--

--x4fWRleFxBSuwL1wjB6Q
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6268): https://lists.cip-project.org/g/cip-dev/message=
/6268
Mute This Topic: https://lists.cip-project.org/mt/81205355/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--x4fWRleFxBSuwL1wjB6Q--

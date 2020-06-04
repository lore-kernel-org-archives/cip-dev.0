Return-Path: <SRS0=LdaT=7R=lists.cip-project.org=bounce+64572+4696+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 000C5C433E0
	for <cip-dev@archiver.kernel.org>; Thu,  4 Jun 2020 08:42:27 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 305B92074B
	for <cip-dev@archiver.kernel.org>; Thu,  4 Jun 2020 08:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="rl1+Okos"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 305B92074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4696+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id maxbYY4521723xNUWOV13UdY; Thu, 04 Jun 2020 01:42:25 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.9899.1591260144022097087
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Jun 2020 01:42:24 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 8E9591C0BD2; Thu,  4 Jun 2020 10:42:20 +0200 (CEST)
Date: Thu, 4 Jun 2020 10:42:20 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: cip-dev@lists.cip-project.org
Cc: chris.paterson2@renesas.com, fabrizio.castro.jz@renesas.com
Subject: Re: [cip-dev] [PATCH v2 v4.4.y-cip] ARM: dts: iwg20d-q7-common: Add LCD support
Message-ID: <20200604084220.GA18398@duo.ucw.cz>
References: <1591087404-7118-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
 <OSBPR01MB298388B7BE773E7DD4284E4A928B0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <OSBPR01MB298388B7BE773E7DD4284E4A928B0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: YDsgfPlKFclrnfN922LIOLhUx4520388AA=
Content-Type: multipart/mixed; boundary="ZDHRLl0ElXtUJngVqUk5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1591260145;
 bh=XCKv0wcfrwuxfh7PtrjyFSuc/65Bp5hbvfpoWwAlT4w=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=rl1+Okos8yUDU46q+/te1cD8opBuYszbXTpITvGpuuC2a+zW4+TFIy+QR+w4J3bohb4
 eNOMe7wfPWzsIJ6KLCqyr/5YUXVMtONrbd6/+mAWRTe8uRGW+ztt06BlJp8/6SFRxkmgF
 sjK3i/OL6SZIByt3Xp4sDCR24VFsibBETgs=

--ZDHRLl0ElXtUJngVqUk5
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Content-Disposition: inline

--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > The iwg20d comes with a 7" capacitive touch screen, therefore
> > add support for it.
>=20
> Looks good to me this patch.
> BTW, when you confirmed this patch, did you update the kernel config?
> If we need to add drivers, please tell us what kernel config you
> used.

I don't see anything wrong, either.

SIMPLE_PANEL is not enabled in
4.4.y-cip/arm/renesas_shmobile_defconfig , and it seems to be driver
relevant to this panel.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXtiz7AAKCRAw5/Bqldv6
8k3DAJ42paC0/8A+sFNsw+pzACHJ4uG0ZQCfalKumdv5vREP7clsdZkbU0l4zQ8=
=A0J6
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--

--ZDHRLl0ElXtUJngVqUk5
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4696): https://lists.cip-project.org/g/cip-dev/message=
/4696
Mute This Topic: https://lists.cip-project.org/mt/74623758/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--ZDHRLl0ElXtUJngVqUk5--

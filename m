Return-Path: <SRS0=LNls=7W=lists.cip-project.org=bounce+64572+4789+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D325C433DF
	for <cip-dev@archiver.kernel.org>; Tue,  9 Jun 2020 10:45:41 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A67020814
	for <cip-dev@archiver.kernel.org>; Tue,  9 Jun 2020 10:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="nyjP/UmR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A67020814
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4789+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 9pQ4YY4521723xvS4kZLKfzK; Tue, 09 Jun 2020 03:45:40 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.4454.1591699538179019969
 for <cip-dev@lists.cip-project.org>;
 Tue, 09 Jun 2020 03:45:39 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id CEAA41C0C0C; Tue,  9 Jun 2020 12:45:34 +0200 (CEST)
Date: Tue, 9 Jun 2020 12:45:34 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: Johnson CH Chen =?utf-8?B?KOmZs+aYreWLsyk=?= <JohnsonCH.Chen@moxa.com>
Cc: Pavel Machek <pavel@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: [cip-dev] [PATCH 4.4.y-cip 0/3] ARM: dts: am335x: Replace numeric pinmux address with macro defines
Message-ID: <20200609104534.GA27637@amd>
References: <HK2PR01MB3281084A8DA1542518F65818FA850@HK2PR01MB3281.apcprd01.prod.exchangelabs.com>
 <HK2PR01MB32818C637F6FB1F0AE969A95FA850@HK2PR01MB3281.apcprd01.prod.exchangelabs.com>
 <20200608213019.GA2851@amd>
 <HK2PR01MB32819F56BCF1EA97DF34F5E8FA820@HK2PR01MB3281.apcprd01.prod.exchangelabs.com>
MIME-Version: 1.0
In-Reply-To: <HK2PR01MB32819F56BCF1EA97DF34F5E8FA820@HK2PR01MB3281.apcprd01.prod.exchangelabs.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: MCunembn9rZnyPM35C9bXFBXx4520388AA=
Content-Type: multipart/mixed; boundary="AMuTXytggGma2XeMYChN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1591699540;
 bh=kQY92kBrn5kevEgC5uhrY7+YezayYzfl6KYjsosHDqk=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=nyjP/UmRPj0GqLQOgDiCx/V/fpCrKDatBvYvNWi8D6VcLGmvXhMpRihbZG2ErmkkTXr
 rACQLXlxQ5OoULsvqs4CqT9wZLTFIz8jBVIjLwezjMFiQApw0S19IdlO4f7E9LC8QhTqG
 I7sI53f9O0sqgGvSQTDsxWILwMFu62nFIso=

--AMuTXytggGma2XeMYChN
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline

--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > On the other hand, I don't see any obvious benefit. Whether we use hex
> > constants or symbolic constants affects readability, but has no effect =
on
> > functionality.
> >=20
> > Do you have any patches on top of these that rely on symbolic constants=
 in the
> > dts? Are there any changes in the generated .dtb?
> > What is the benefit of this series (besides cleanup)?
>=20
> Thanks for your response!
>=20
> If macros of numeric pinmux addresses is used, we don't need to see AM335=
X's Technical Reference Manual again and again to find out the meaning of e=
ach pinmux address, just check "am33xx.h". Besides, it helps us to configur=
e module pin's for different device trees easily. For example of mii, If we=
 want to configure module of mii pin, we check module in "am33xx.h" can pic=
k register names we want to modify. It's hard to remember pin address numbe=
r for the specific module to us.
>=20
> If AM33XX_PADCONF is taken, we can make sure both of pin's direction and =
mux mode are actually set, and it helps us to debug.
>=20
> We have many boards based on AM335x SoC. Some dts rely on symbolic consta=
nts and some dts are not. I think this patch series can let us develop boar=
ds with AM335x SoC easiler.
>

Aha, ok, having more boards like this certainly explains the
benefits. Thanks for an explanation.

I have applied patches, I'll run some basic tests and push the
results.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl7faE4ACgkQMOfwapXb+vL7IgCghJoNIx0VkhzU8JUG5KQWUszn
Za0AoKJDxP8exxFgSdyjnKMLrC57iByv
=aW/A
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--

--AMuTXytggGma2XeMYChN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4789): https://lists.cip-project.org/g/cip-dev/message=
/4789
Mute This Topic: https://lists.cip-project.org/mt/74749053/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--AMuTXytggGma2XeMYChN--

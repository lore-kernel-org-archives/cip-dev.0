Return-Path: <SRS0=ANta=6S=lists.cip-project.org=bounce+64572+4613+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E65CC47258
	for <cip-dev@archiver.kernel.org>; Mon,  4 May 2020 22:42:00 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CCC820707
	for <cip-dev@archiver.kernel.org>; Mon,  4 May 2020 22:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="c5zYvKXy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CCC820707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4613+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id DoQEYY4521723xdqzAKFLPJV; Mon, 04 May 2020 15:41:58 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.6892.1588325777451241651
 for <cip-dev@lists.cip-project.org>;
 Fri, 01 May 2020 02:36:18 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id E7E451C020C; Fri,  1 May 2020 11:36:15 +0200 (CEST)
Date: Fri, 1 May 2020 11:36:15 +0200
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: JohnsonCH.Chen@moxa.com, cip-dev@lists.cip-project.org, pavel@denx.de
Subject: Re: [cip-dev] [PATCH 4.4.y-cip 0/3] Add TI CPUFreq/OPP hw-supported driver
Message-ID: <20200501093615.GC11782@amd>
References: <HK2PR01MB32811FA86BAC56B8CDA4B1B7FAAA0@HK2PR01MB3281.apcprd01.prod.exchangelabs.com>
 <OSAPR01MB3667E8AE3A76EB13D1C03BF292AA0@OSAPR01MB3667.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <OSAPR01MB3667E8AE3A76EB13D1C03BF292AA0@OSAPR01MB3667.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: wMixXzDo0b2BBy3yKYDyfmsXx4520388AA=
Content-Type: multipart/mixed; boundary="tThfqbmKBAZoKjY3SdMm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1588632118;
 bh=IUIXGmL0yLELtOcr9n1LrwCJcJH9YvboC4Zl1HgBmjw=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=c5zYvKXy0wvFWIKdko4lN/DB7eWQT2RoaBarQ3rKafQB6lTtoFUzah1iSas6yqlkyLz
 KP+bgo5ykQUnJK/mvuNgfXoauV0/Vl3Lgyfzbsku5iC/U/JdW/Sn8L7MGW6Q4pp2S3Ek5
 HQnxrlRPx8x1ZN+D9m9uyP6kGGli4p+GxSo=

--tThfqbmKBAZoKjY3SdMm
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6zdv2QT/q3FMhpsV"
Content-Disposition: inline

--6zdv2QT/q3FMhpsV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Tested on MOXA UC-8100A-ME that uses AM335x's SoC we have in house.
> >=20
> > Dave Gerlach (1):
> >   cpufreq: ti: Add cpufreq driver to determine available OPPs at runtime
> >=20
> > Viresh Kumar (2):
> >   PM / OPP: Add "opp-supported-hw" binding
> >   PM / OPP: Parse 'opp-supported-hw' binding
>=20
> Looks good to me.
> If there is no opinion, I will apply this series.

I have made some comments. 3/3 has double-free in error path, that one
may be worth fixing before the merge.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--6zdv2QT/q3FMhpsV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl6r7Y8ACgkQMOfwapXb+vKPEQCfU0bWiZ8Wla6OcP/e6itAVmXW
DK4AoJUu/5remiat0uKw1BBxFO2AeQlf
=aH5W
-----END PGP SIGNATURE-----

--6zdv2QT/q3FMhpsV--

--tThfqbmKBAZoKjY3SdMm
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4613): https://lists.cip-project.org/g/cip-dev/message=
/4613
Mute This Topic: https://lists.cip-project.org/mt/73369238/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--tThfqbmKBAZoKjY3SdMm--

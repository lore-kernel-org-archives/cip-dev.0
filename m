Return-Path: <SRS0=G6gQ=MD=lists.cip-project.org=bounce+64572+6618+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F510C07E96
	for <cip-dev@archiver.kernel.org>; Sun, 11 Jul 2021 08:32:47 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DA5361249
	for <cip-dev@archiver.kernel.org>; Sun, 11 Jul 2021 08:32:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DA5361249
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6618+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id it0IYY4521723xdBeRfotEPU; Sun, 11 Jul 2021 01:32:44 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.4967.1625992363324514122
 for <cip-dev@lists.cip-project.org>;
 Sun, 11 Jul 2021 01:32:44 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id DA5F61C0B77; Sun, 11 Jul 2021 10:32:30 +0200 (CEST)
Date: Sun, 11 Jul 2021 10:32:30 +0200
From: "Pavel Machek" <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] New CVE entries this week
Message-ID: <20210711083230.GC14434@duo.ucw.cz>
References: <CAODzB9o6L1L7z=HBNDQUc8yxHy9ZehgCjWhUmke3uuMJ6qpp9A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAODzB9o6L1L7z=HBNDQUc8yxHy9ZehgCjWhUmke3uuMJ6qpp9A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: N26pAkTaG8QyWxvGovDFk8Box4520388AA=
Content-Type: multipart/mixed; boundary="USxaKohaOtNzy8MSw4Ui"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1625992364;
 bh=Tfh5OyKsy9e62PQyMWUPZuUBMhwqWQSiW1LVWtSfTbY=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=blx+w+/5preRu3fKfO0hvxehU5C1e5R58fhnCpXdCqR9vgbgePiDSK+rc1DwZvb6/+g
 O4fI+Co5T3JYKPiW2sbdFybG5nNbymxusRVMnfrfhS/BWzr5gPZoUD3o/irrTNTGSAciq
 QjL8QfCiSu6002bmpWu87UEOcdGNbx0O1o0=

--USxaKohaOtNzy8MSw4Ui
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dkEUBIird37B8yKS"
Content-Disposition: inline

--dkEUBIird37B8yKS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> These are the new issues this week:
>=20
> * 2021/06/30
>=20
> CVE-2020-28097 -- vgacon_scrolldelta out-of-bounds read

This is sad situation but we don't need to do anything here.

> CVE-2021-29256.yml -- Mali GPU Kernel Driver elevates CPU RO pages
>  to writable

Too early to do anything here, we don't have enough information.

> CVE-2021-31615 -- InjectaBLE: Injecting malicious traffic into
> established Bluetooth Low Energy connections

Too early to do anything here, we don't have enough information.

> * 2021/07/08
>=20
> CVE-2021-35039 -- Without CONFIG_MODULE_SIG, verification that a
> kernel module is signed, for loading via init_module, does not occur
> for a module.sig_enforce=3D1 command-line argument.
>=20
> This CVE affects v4.15 to v5.12, so v4.4 kernel doesn't affect.

Stable did the work, we don't need to do anything. Good :-).

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--dkEUBIird37B8yKS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYOqsngAKCRAw5/Bqldv6
8lGZAJ9Md56C6T2fkK6r/2tBuSw6HhRy9QCfYBzJOHSrhaw8owznzlMZCZ3jnzY=
=cKjw
-----END PGP SIGNATURE-----

--dkEUBIird37B8yKS--

--USxaKohaOtNzy8MSw4Ui
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6618): https://lists.cip-project.org/g/cip-dev/message=
/6618
Mute This Topic: https://lists.cip-project.org/mt/84058381/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--USxaKohaOtNzy8MSw4Ui--

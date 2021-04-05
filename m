Return-Path: <SRS0=nyHh=JC=lists.cip-project.org=bounce+64572+6341+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3DB3C433B4
	for <cip-dev@archiver.kernel.org>; Mon,  5 Apr 2021 14:41:32 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03537613A3
	for <cip-dev@archiver.kernel.org>; Mon,  5 Apr 2021 14:41:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03537613A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6341+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id KbOlYY4521723xw2RdiZCjlb; Mon, 05 Apr 2021 07:41:31 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web09.5653.1617633690437198327
 for <cip-dev@lists.cip-project.org>;
 Mon, 05 Apr 2021 07:41:30 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 085871C0B7D; Mon,  5 Apr 2021 16:41:12 +0200 (CEST)
Date: Mon, 5 Apr 2021 16:41:10 +0200
From: "Pavel Machek" <pavel@denx.de>
To: cip-dev@lists.cip-project.org, chris.paterson2@renesas.com
Subject: [cip-dev] -stable-rc tests failing
Message-ID: <20210405144110.GA29465@amd>
MIME-Version: 1.0
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: HFAZLvjqvC7LjdR76AKchxVlx4520388AA=
Content-Type: multipart/mixed; boundary="otYSzr8tK7ZwburKKVV4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1617633691;
 bh=Vw6svauXPKhk7JZORbRZnB8XOCARkUeyS7ooT9nknS0=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=njuaxntncsYh2vwJciAZ3NsFgirlBnIdZsbByMElUDqPP0jwMARNdXpS3MJHi+cd0X+
 Y2INKtk8TeV5MoJOC7dONmjwV+ZdGOLxl781jKuYf+b77K4xUMB2luO87RRUXCM1E30Aw
 b7XY48qJjFJGNj3UWWjAljDNQUB/vLHLMME=

--otYSzr8tK7ZwburKKVV4
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline

--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi!

Every single test in -stable-rc series fails:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
4.4.y
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
4.19.y
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
5.10.y

I attempted to re-run a few, but I don't think it will fix
anything. IIRC LAVA labs should be up now, so it would be cool if
someone could investigate.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmBrIYYACgkQMOfwapXb+vK4SQCbBCYuUDegjglfkqtf0E3nfeM8
6FMAnRytVkoHdT11si2B7ojO/5zks9Eh
=rXuF
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--

--otYSzr8tK7ZwburKKVV4
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6341): https://lists.cip-project.org/g/cip-dev/message=
/6341
Mute This Topic: https://lists.cip-project.org/mt/81865407/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--otYSzr8tK7ZwburKKVV4--

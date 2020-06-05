Return-Path: <SRS0=6rF9=7S=lists.cip-project.org=bounce+64572+4724+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F21C433E0
	for <cip-dev@archiver.kernel.org>; Fri,  5 Jun 2020 10:41:04 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57F3B2075B
	for <cip-dev@archiver.kernel.org>; Fri,  5 Jun 2020 10:41:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="Hw5OIpkz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57F3B2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4724+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id qOjIYY4521723x2t3MtdJ7nQ; Fri, 05 Jun 2020 03:41:03 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.8138.1591353661068874557
 for <cip-dev@lists.cip-project.org>;
 Fri, 05 Jun 2020 03:41:01 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 977561C0BD2; Fri,  5 Jun 2020 12:40:57 +0200 (CEST)
Date: Fri, 5 Jun 2020 12:40:57 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: Johnson CH Chen =?utf-8?B?KOmZs+aYreWLsyk=?= <JohnsonCH.Chen@moxa.com>
Cc: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"pavel@denx.de" <pavel@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev][PATCH 4.4.y-cip 0/2] Add dts for Moxa UC-8100-ME-T platform
Message-ID: <20200605104057.GA26010@duo.ucw.cz>
References: <HK2PR01MB32816DED0D73E7481744817CFA860@HK2PR01MB3281.apcprd01.prod.exchangelabs.com>
MIME-Version: 1.0
In-Reply-To: <HK2PR01MB32816DED0D73E7481744817CFA860@HK2PR01MB3281.apcprd01.prod.exchangelabs.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 81i12UXSqhurlZbujZF7Pg8Sx4520388AA=
Content-Type: multipart/mixed; boundary="K9t7AENtXavCn5B15GRf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1591353663;
 bh=o7NoPNXoQpgTeIPYA8FRLQjVJcXc8y00lO8JXz5yj98=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=Hw5OIpkzuuh/P09C96FD3+MLCcGAzdwQb8Ri+diQWk/Zu7m8v61t6gsdSByvtkBVZfY
 wmr+EVxu+Klryb3AuIP/OvgUN1RWoFsZrud+RUXLcWat4SoOZ9hb0FK0SCyMAiWFqHKyb
 jQsLN1xyMMHmWD0hDEQsu4Oz4RVotKh+f/k=

--K9t7AENtXavCn5B15GRf
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline

--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> MOXA UC-8100-ME-T is built around a Cortex-A8 processor for TI AM335x,=20
> and it's designed for embedded data acquisition application. Here we add
> the device tree am335x-moxa-uc-8100-me-t.dts. Besides, also add new DT=20
> binding for the eDMA3 because function of edma crossbar is used in=20
> UC-8100-ME-T, and memory is safe for with the new binding.
>=20
> 1. Use the new binding for eDMA3 of am33xx.
> 2. Add dts for MOXA UC-8100-ME-T =20
>=20
> It's tested with a MOXA UC-8100-ME-T platform.

So this is relatively simple, as it only affects Moxa code. And I see
nothing wrong there.

I'll apply it if there are no other comments.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXtohOQAKCRAw5/Bqldv6
8r4gAKCW7jIoKz30Vn/sP+Afv+qSTJiH2ACgw59jQAWFKeOI2R16c7SiHj4aYE0=
=9Kqx
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--

--K9t7AENtXavCn5B15GRf
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4724): https://lists.cip-project.org/g/cip-dev/message=
/4724
Mute This Topic: https://lists.cip-project.org/mt/74689396/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--K9t7AENtXavCn5B15GRf--

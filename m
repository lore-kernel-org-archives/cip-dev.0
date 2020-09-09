Return-Path: <SRS0=KaFR=CS=lists.cip-project.org=bounce+64572+5436+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B87E6C43461
	for <cip-dev@archiver.kernel.org>; Wed,  9 Sep 2020 07:03:47 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D17F21741
	for <cip-dev@archiver.kernel.org>; Wed,  9 Sep 2020 07:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="UNAyrCvA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D17F21741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5436+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 0zR8YY4521723xEAE1jyugQA; Wed, 09 Sep 2020 00:03:46 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.8104.1599635026175528599
 for <cip-dev@lists.cip-project.org>;
 Wed, 09 Sep 2020 00:03:46 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id A88001C0B79; Wed,  9 Sep 2020 09:03:43 +0200 (CEST)
Date: Wed, 9 Sep 2020 09:03:43 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, pavel@denx.de,
	cip-dev@lists.cip-project.org, JohnsonCH.Chen@moxa.com,
	victor.yu@moxa.com
Subject: Re: [cip-dev] [PATCH 4.4.y-cip 00/11] ti-cpufreq backport
Message-ID: <20200909070343.GF27139@duo.ucw.cz>
References: <20200909044233.4115-1-wens@csie.org>
MIME-Version: 1.0
In-Reply-To: <20200909044233.4115-1-wens@csie.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 0PZvhzalQnI015YyS3438M8Kx4520388AA=
Content-Type: multipart/mixed; boundary="Jo5niUi8gkBWh3Z3nHye"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1599635026;
 bh=2HPm+W5rklgFEstEsqtvR+quNNPbHO1hOTLKjN+Ewhs=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=UNAyrCvAyfCxJkyh2iwvdH9xg3+4UZxnzb7Rd21nxt76nSKFRBjrHilPqiiGNEa3sSs
 /0zO9BO45XTXmor4vN63FQ37iKQuK/XmCbACZ/jyTIPmMwg5hzbtXz/cUMGohYd8qnq4e
 /qA4xhWYyVzgr3icz1hp66+csNP9gMI8P98=

--Jo5niUi8gkBWh3Z3nHye
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="V4b9U9vrdWczvw78"
Content-Disposition: inline

--V4b9U9vrdWczvw78
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the final part of MOXA's PM / OPP / ti-cpufreq backport series.
> Part 2, which consisted of OPP / cpufreq-dt cleanups, is abandoned in
> favor of directly backporting the ti-cpufreq driver.
>=20
> This part includes a couple of patches to the PM / OPP subsystem to
> expose required APIs, and deal with the v1/v2 mixed OPP table used
> by am33xx. The rest are the backport of the ti-cpufreq driver, and
> fixes for this driver. The fixes were requested by CIP kernel
> maintainers as part of MOXA's previous attempt to backport ti-cpufreq.
> They are included as separate patches, as there are quite a few of them
> spread over multiple kernel releases.
>=20
> The result is that my BeagleBone Black can run at higher speeds than
> without the ti-cpufreq driver due to having a better silicon
> revision.

The series looks good to me. I can apply it if it passes testing and
there are no other comments.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--V4b9U9vrdWczvw78
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX1h+TwAKCRAw5/Bqldv6
8me8AJ0TT1HLQHbARgJ+7W/DEz1mZHfZOwCgoHrMfqsYdQrPNzlp7/xlzndqkIk=
=FGrm
-----END PGP SIGNATURE-----

--V4b9U9vrdWczvw78--

--Jo5niUi8gkBWh3Z3nHye
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5436): https://lists.cip-project.org/g/cip-dev/message=
/5436
Mute This Topic: https://lists.cip-project.org/mt/76726426/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--Jo5niUi8gkBWh3Z3nHye--

Return-Path: <SRS0=5LbH=GX=lists.cip-project.org=bounce+64572+6119+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB182C433E0
	for <cip-dev@archiver.kernel.org>; Wed, 20 Jan 2021 19:24:42 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5883233EB
	for <cip-dev@archiver.kernel.org>; Wed, 20 Jan 2021 19:24:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5883233EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6119+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id rPkXYY4521723xGj0wRU4FJU; Wed, 20 Jan 2021 11:24:40 -0800
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web08.32863.1611170677700850376
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Jan 2021 11:24:38 -0800
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 9200B1C0B8A; Wed, 20 Jan 2021 20:24:33 +0100 (CET)
Date: Wed, 20 Jan 2021 20:24:33 +0100
From: "Pavel Machek" <pavel@denx.de>
To: masashi.kudo@cybertrust.co.jp, chris.paterson2@renesas.com
Cc: pavel@denx.de, nobuhiro1.iwamatsu@toshiba.co.jp,
	cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] Starting 5.10.y branch?
Message-ID: <20210120192433.GA24348@duo.ucw.cz>
References: <20210119182125.GA17515@duo.ucw.cz>
 <TY2PR01MB497256384FF6FC1115BC3F34A0A30@TY2PR01MB4972.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <TY2PR01MB497256384FF6FC1115BC3F34A0A30@TY2PR01MB4972.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: QGYCQDhkJQy9stxzAaFYI00Nx4520388AA=
Content-Type: multipart/mixed; boundary="G6lxw0EnviGHMrnj0TrD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1611170680;
 bh=is69DrokFd8cUW95IYf2Oah4IEIuixqNEXTQ+FFayXc=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=Ld/UamN6Z4iMY8s923KGhZKvrn30D6/odOD6WCNZNTba3BHoWS9NAMPPVnEOBnZ1rI1
 86UQVIEPZBHV3TANJUDscYNKcPMvLlIB0oq+bBtvpPHjZzYUtal0SAVntoqcXre0i4Sxt
 zFI/cHiwaxGKQj7+CfWaDw4HT1DCgBTWnKA=

--G6lxw0EnviGHMrnj0TrD
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline

--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Thanks for your offer. Yes, please do so!

Done.

I put .gitlab-ci.yml in the repository, which points to

https://gitlab.com/cip-project/cip-testing/linux-cip-pipelines/raw/master/t=
rees/linux-5.10.y-cip.yml

AFAICT it can be provided by simply copying linux-5.10.y.yml, but I
guess I should let Chris do that.

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYAiDcQAKCRAw5/Bqldv6
8i3nAKCFnb+68/yDwCJRQ9Ifoi6HD0wsbgCgutrcQKz2fM2qiHjbNE2MwkK/OKw=
=32pv
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--

--G6lxw0EnviGHMrnj0TrD
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6119): https://lists.cip-project.org/g/cip-dev/message=
/6119
Mute This Topic: https://lists.cip-project.org/mt/79958721/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--G6lxw0EnviGHMrnj0TrD--

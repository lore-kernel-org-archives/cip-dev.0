Return-Path: <SRS0=DfcJ=OF=lists.cip-project.org=bounce+64572+6738+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA53C433EF
	for <cip-dev@archiver.kernel.org>; Wed, 15 Sep 2021 19:35:32 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16C60611C1
	for <cip-dev@archiver.kernel.org>; Wed, 15 Sep 2021 19:35:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 16C60611C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id pkEaYY4521723xbavyn2WxoF; Wed, 15 Sep 2021 12:35:31 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.1205.1631734530024205192
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Sep 2021 12:35:30 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id EBF0C1C0B7C; Wed, 15 Sep 2021 21:35:24 +0200 (CEST)
Date: Wed, 15 Sep 2021 21:35:24 +0200
From: "Pavel Machek" <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: [cip-dev] Travels & IRC meeting tommorow
Message-ID: <20210915193523.GA5832@amd>
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
X-Gm-Message-State: VzLeoSwswg35KvwUl252NN6px4520388AA=
Content-Type: multipart/mixed; boundary="G4rjOPTDXm7LCeKfd639"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1631734531;
 bh=pjyCRwvakCYdcHQmtzMKHeKQUlfQJqCbLq4HtCPXn0c=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=VeeY7pbT+oRLpD4ViRGryOT4zA8Uo02sm/S8ZhOD024y9Og5Y3n8Vy6iuXUkmYR5WGP
 RsTb5lgjLJZc162MxPbaCchJb6r9qkV3wYv6n1BxPCi120gF0pTfvchvRwXGohB1IdlVA
 M91DWI5IIt8ZMO3zHzL9mCbnXAeyJIoefWw=

--G4rjOPTDXm7LCeKfd639
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline

--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I'm travelling tommorow and day after that, so I may not make it to
the irc meeting. I have reviewed patches for 5.10.64, 65 and 66.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmFCSvsACgkQMOfwapXb+vIaLACgg6pKf8uMoq73aQ//nynQZYQe
p5QAn371+wRxPx+nmoSlm3PCmaWZ/k3Y
=0Eow
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--

--G4rjOPTDXm7LCeKfd639
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6738): https://lists.cip-project.org/g/cip-dev/message/=
6738
Mute This Topic: https://lists.cip-project.org/mt/85636472/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--G4rjOPTDXm7LCeKfd639--

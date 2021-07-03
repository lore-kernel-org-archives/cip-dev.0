Return-Path: <SRS0=Qtkn=L3=lists.cip-project.org=bounce+64572+6592+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E0EDC07E97
	for <cip-dev@archiver.kernel.org>; Sat,  3 Jul 2021 12:30:02 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AF9361939
	for <cip-dev@archiver.kernel.org>; Sat,  3 Jul 2021 12:30:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AF9361939
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6592+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id x6KdYY4521723xurdOeFH4Ox; Sat, 03 Jul 2021 05:30:00 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.21804.1625315399406456066
 for <cip-dev@lists.cip-project.org>;
 Sat, 03 Jul 2021 05:30:00 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 23A221C0B79; Sat,  3 Jul 2021 14:29:47 +0200 (CEST)
Date: Sat, 3 Jul 2021 14:29:44 +0200
From: "Pavel Machek" <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: [cip-dev] 4.4-rt situation
Message-ID: <20210703122944.GA5933@amd>
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
X-Gm-Message-State: nuUAjGUIAWiL8Xfl8bUAVdb7x4520388AA=
Content-Type: multipart/mixed; boundary="rqUGqpeEg0lwTuBRlIaI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1625315400;
 bh=xGTGj2WpAk5NmtvihkSvMLP6QzbMMu/W2XF1rrAv7SA=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=q+EbyTJFbgutX1xxOnDtB2SomcEUMWmxHbZI7B1EBLa31S/Fa9CkabAodvNOamkZx93
 uQoGp58Ja6Q4t1ahH9lo5u/o8GCUHsuR07RNl6IcxBdAzozSzQP09q5pLCYC41M9ur2Va
 +2OnfFemtykP6gijoliYpEbNlBF9v8s3cxs=

--rqUGqpeEg0lwTuBRlIaI
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline

--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I tried to release 4.4-cip-rt at the end of May, but suitable versions
were not available, and I got nasty-looking rejects when trying to
sort things out.

We decided to (try to) coordinate -cip releases with -rt releases, so
we should get 4.4-cip-rt soon after 4.4-rt is released.

Best regards and sorry for the delay,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmDgWDcACgkQMOfwapXb+vJGwQCgwe5yQgqSXzeNEjXK5dYcES1l
QREAnAhg3vjmB0rNnnnev+0o2ZUkETtg
=YsCV
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--

--rqUGqpeEg0lwTuBRlIaI
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6592): https://lists.cip-project.org/g/cip-dev/message=
/6592
Mute This Topic: https://lists.cip-project.org/mt/83959297/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--rqUGqpeEg0lwTuBRlIaI--

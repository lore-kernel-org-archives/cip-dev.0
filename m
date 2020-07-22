Return-Path: <SRS0=suNs=BB=lists.cip-project.org=bounce+64572+4979+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D740C433E3
	for <cip-dev@archiver.kernel.org>; Wed, 22 Jul 2020 21:49:39 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E99452071A
	for <cip-dev@archiver.kernel.org>; Wed, 22 Jul 2020 21:49:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="VZWhgbfi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E99452071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4979+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id EwDgYY4521723xFOogpcLuI9; Wed, 22 Jul 2020 14:49:38 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.29962.1595454576915181392
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Jul 2020 14:49:37 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id DC6E81C0BD8; Wed, 22 Jul 2020 23:49:33 +0200 (CEST)
Date: Wed, 22 Jul 2020 23:49:33 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Chris Paterson <chris.paterson2@renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 00/17] Add RZ/G2E Dual LVDS display
Message-ID: <20200722214933.GB16146@amd>
References: <20200722163449.3513-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <20200722163449.3513-1-biju.das.jz@bp.renesas.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: L4QTNTIY6u1Nfg0zSnKYwbXRx4520388AA=
Content-Type: multipart/mixed; boundary="D1TLFbvBsYijYb6YNwuJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595454578;
 bh=oGjSnbADJzBG5HmcXsCdQjOiyRhz0b8+c0/UQTYSZBE=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=VZWhgbfiuVCiMBpx2hsevb2aEtbo8tKPfK1WH4Te7BWC3atNysIRhjEWWcCcqF21EJg
 cK6jfmqlZJtq7m0K0kOyArNleskZ/CoLtBYw38165h5GkVQEegx3Wv7YfSeMOqp2A3JQE
 WPohq9vcfp91bDOLbZStGDEu8asIwB/Kp/I=

--D1TLFbvBsYijYb6YNwuJ
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hHWLQfXTYDoKhP50"
Content-Disposition: inline

--hHWLQfXTYDoKhP50
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Add RZ/G2E Dual LVDS display support. All patches in this series are=20
> cherry-picked from upstream kernel.

I could not find any issues besides double of_node_put in 11/.

It is currently being tested:

https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/169687006

If noone objects (and tests pass), I can apply/push the series.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--hHWLQfXTYDoKhP50
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl8YtG0ACgkQMOfwapXb+vKexQCdHuK0ehr4JigamcnR2hQv7yQ8
NDAAoKWwdYV4XcZDrzxO5Hi5FoH8DR5k
=paL+
-----END PGP SIGNATURE-----

--hHWLQfXTYDoKhP50--

--D1TLFbvBsYijYb6YNwuJ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4979): https://lists.cip-project.org/g/cip-dev/message=
/4979
Mute This Topic: https://lists.cip-project.org/mt/75730020/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--D1TLFbvBsYijYb6YNwuJ--

Return-Path: <SRS0=2mJN=7P=lists.cip-project.org=bounce+64572+4663+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EFF1C433E1
	for <cip-dev@archiver.kernel.org>; Tue,  2 Jun 2020 17:24:14 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F8622068D
	for <cip-dev@archiver.kernel.org>; Tue,  2 Jun 2020 17:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="tAfQeLko"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F8622068D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4663+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id rrRlYY4521723xZjBLtPGGIh; Tue, 02 Jun 2020 10:24:12 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.1100.1591118650494918431
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 Jun 2020 10:24:11 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 28AD71C0BD2; Tue,  2 Jun 2020 19:24:07 +0200 (CEST)
Date: Tue, 2 Jun 2020 19:24:06 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org, SZ.Lin@moxa.com,
	ben.hutchings@codethink.co.uk, Chris.Paterson2@renesas.com
Subject: [cip-dev] [ANNOUNCE] v4.4.225-cip45-rt29 release
Message-ID: <20200602172406.GA26198@duo.ucw.cz>
MIME-Version: 1.0
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: c5YsMBrozpdBZWqShfU4wiOlx4520388AA=
Content-Type: multipart/mixed; boundary="wHvmAwJxxjt8JV968JAf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1591118652;
 bh=QtsDIO35l3wY4Q+Gwa/8vq+2+3MQtjuywlnVCShthdg=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=tAfQeLkofjEHdH14kyVwRWkjElRbZli+MzE8wHe67xLkJVIFAPDX/hzdZ7oqGf8JQFC
 99jhviZH9ubJSiqyzNxZu+H0EZNFsX/ulFf/KrfrdDVqUeMhT76zMUHdXq0oudSwYVQfz
 ggY9ODvDWiDaxuSsHzBtyYcbfePQRM6eLQg=

--wHvmAwJxxjt8JV968JAf
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline

--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

v4.4.225-cip45-rt29 should be available at kernel.org.

Trees are available at

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-4.4.y-cip-rt

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-4.4.y-cip-rt-rebase

And their content should be identical.

There is known issue in upstream -rt release, and we are likely
affected by this, too:

  sigwaittest with hackbench as workload is able to trigger a crash on x86_=
64,
  the same as reported for the v4.4.220-rt196 release.

  BUG: unable to handle kernel paging request at 00000000ffffffff
  IP: [<ffffffff81190003>] kmem_cache_alloc_node+0xc3/0x1e0


Best regards,
								Pavel



--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXtaLNgAKCRAw5/Bqldv6
8ttLAJ4gdqw8kTqwOnhYkjSNPxxRdCbYXQCeIXTeEoGoFHApi23IX7t0yt5/SMQ=
=wGNc
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--

--wHvmAwJxxjt8JV968JAf
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4663): https://lists.cip-project.org/g/cip-dev/message=
/4663
Mute This Topic: https://lists.cip-project.org/mt/74632627/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--wHvmAwJxxjt8JV968JAf--

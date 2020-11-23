Return-Path: <SRS0=wJmf=E5=lists.cip-project.org=bounce+64572+5826+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A16FC2D0E4
	for <cip-dev@archiver.kernel.org>; Mon, 23 Nov 2020 19:09:46 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05E9922257
	for <cip-dev@archiver.kernel.org>; Mon, 23 Nov 2020 19:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="eNbg57Is"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05E9922257
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5826+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id n5W4YY4521723xKej3jda4jl; Mon, 23 Nov 2020 11:09:44 -0800
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web09.40667.1606158583277545983
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Nov 2020 11:09:43 -0800
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 1BB3F1C0BA6; Mon, 23 Nov 2020 20:09:41 +0100 (CET)
Date: Mon, 23 Nov 2020 20:09:40 +0100
From: "Pavel Machek" <pavel@denx.de>
To: chris.paterson2@renesas.com, cip-dev@lists.cip-project.org
Subject: [cip-dev] A lot of compiles failing
Message-ID: <20201123190940.GA13627@duo.ucw.cz>
MIME-Version: 1.0
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: Nhfq4nZwTf96IkAqeFSWtINbx4520388AA=
Content-Type: multipart/mixed; boundary="4B3Z79J4t7QPCuNSvGwu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606158584;
 bh=WLU779r9XhdZrw0+YTtRPZWSyENYe0IpPIJcQ51FBv8=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=eNbg57IsmNxYl9o7Lzici8FDFpKnfG6nyKDG5jIwv/uC3r8bS7HiYM2fP4HCcuLjkJd
 MdNq8dSw4Jqw2Se/kxzp/OkTwLsiDAG4452FDFl1/ScA0xVhtQf6KzeKDlvwGz/LKW36W
 LEDFVfUhkAZle8L1p+pSfdO/e6EMJAaboCU=

--4B3Z79J4t7QPCuNSvGwu
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline

--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

This is going on for a few days now, but today it seems worse than
usual:

https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/220169843

builds are failing, 'HTTP 500 curl 22' error, so not a real build
problem. I can probably just click restart... 6 times. But something
is not there, and it is getting worse.

Best regards,
								Pavel


g for pod gitlab/runner-bcrayztp-project-2678032-concurrent-7hmhsr to be ru=
nning, status is Pending
74Running on runner-bcrayztp-project-2678032-concurrent-7hmhsr via cip-proj=
ect-v3-gitlab-runner-6dbd79945f-wdqqw...
76
Fetching changes with git depth set to 10...
00:18
77Initialized empty Git repository in /builds/cip-project/cip-kernel/linux-=
cip/.git/
78Created fresh repository.
79error: RPC failed; HTTP 500 curl 22 The requested URL returned error: 500=
=20
80fatal: the remote end hung up unexpectedly
82
Uploading artifacts...
00:00
83WARNING: output: no matching files                =20
84ERROR: No files to upload                         =20
86ERROR: Job failed: command terminated with exit code 1
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX7wI9AAKCRAw5/Bqldv6
8jY/AKC7diNUolMcpyIVf3WipWg/CmJsJACdE1VrAu6c2sjjWNs9KVynUEatlHw=
=5+9u
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--

--4B3Z79J4t7QPCuNSvGwu
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5826): https://lists.cip-project.org/g/cip-dev/message=
/5826
Mute This Topic: https://lists.cip-project.org/mt/78460850/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--4B3Z79J4t7QPCuNSvGwu--

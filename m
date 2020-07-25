Return-Path: <SRS0=8P/J=BE=lists.cip-project.org=bounce+64572+5013+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D53C433DF
	for <cip-dev@archiver.kernel.org>; Sat, 25 Jul 2020 18:31:03 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9147A206D7
	for <cip-dev@archiver.kernel.org>; Sat, 25 Jul 2020 18:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="WfWYzsY2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9147A206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5013+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id MG4uYY4521723xYYLlzUjrsf; Sat, 25 Jul 2020 11:31:02 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.15118.1595701854518018014
 for <cip-dev@lists.cip-project.org>;
 Sat, 25 Jul 2020 11:31:00 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 884131C0BDD; Sat, 25 Jul 2020 20:30:48 +0200 (CEST)
Date: Sat, 25 Jul 2020 20:30:48 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org, SZ.Lin@moxa.com,
	ben.hutchings@codethink.co.uk, Chris.Paterson2@renesas.com
Subject: [cip-dev] [ANNOUNCE] v4.4.231-cip47-rt30
Message-ID: <20200725183048.GA10375@duo.ucw.cz>
MIME-Version: 1.0
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: uhWFTcEdhJhy8wYS3m0i0iVFx4520388AA=
Content-Type: multipart/mixed; boundary="uDEOFl0TrNsvD14nocKF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595701862;
 bh=bFo4a4DTaPqgA2UT5JqAQmCkq89GphZoxAvGJ8t5DlY=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=WfWYzsY26bh5SuC9aHm01JPw1TDqbRfoTuoMvJLiytGVXl6vWm9Wg4MoEqgChnyJrgV
 B3xhmHKLZaRpn0IlLFjz5aR9Yze2H45LYWOhXGjVxqXNCNetWkZfgkxJiJk3baO5ORyC9
 9mg+gnFKHkEK0iwLv8ICci+GyNNef68QyGw=

--uDEOFl0TrNsvD14nocKF
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline

--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

v4.4.231-cip47-rt30 should be available at kernel.org.

Trees are available at

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.4.y-cip-rt

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.4.y-cip-rt-rebase

And their content should be identical.

There is known issue in upsream -rt:

   sigwaittest with hackbench as workload is able to trigger a crash on x86_64,
   the same as reported for the v4.4.220-rt196 release. As it turns
   out it was not triggered by BPF.
   https://paste.opensuse.org/view/raw/58939248

Best regards,
								Pavel

--
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXxx6WAAKCRAw5/Bqldv6
8oLiAJ9a51xrQWDnAVydDj2AlHLUYixfkgCgrwJV+9ywaMxwzHw3bd8UxZS2dyo=
=c6lF
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--

--uDEOFl0TrNsvD14nocKF
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5013): https://lists.cip-project.org/g/cip-dev/message=
/5013
Mute This Topic: https://lists.cip-project.org/mt/75790131/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--uDEOFl0TrNsvD14nocKF--

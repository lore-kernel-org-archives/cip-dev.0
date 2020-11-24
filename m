Return-Path: <SRS0=Q2as=E6=lists.cip-project.org=bounce+64572+5861+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA02C2D0E4
	for <cip-dev@archiver.kernel.org>; Tue, 24 Nov 2020 18:45:06 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8DE6206E5
	for <cip-dev@archiver.kernel.org>; Tue, 24 Nov 2020 18:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="kOPbKUkd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8DE6206E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5861+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 40yFYY4521723xELb1RJoKDL; Tue, 24 Nov 2020 10:45:04 -0800
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web09.1479.1606243502390170509
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 Nov 2020 10:45:03 -0800
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id D5AF21C0B7D; Tue, 24 Nov 2020 19:44:58 +0100 (CET)
Date: Tue, 24 Nov 2020 19:44:58 +0100
From: "Pavel Machek" <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Cc: chris.paterson2@renesas.com
Subject: Re: [cip-dev] A lot of compiles failing
Message-ID: <20201124184458.GA7488@duo.ucw.cz>
References: <164A38B8F4B8DF4E.30699@lists.cip-project.org>
MIME-Version: 1.0
In-Reply-To: <164A38B8F4B8DF4E.30699@lists.cip-project.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: kwgeLgSDEwnrZ2ab8L26Ip3Cx4520388AA=
Content-Type: multipart/mixed; boundary="gt0E9vuZG0zkZpKv08Cg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606243504;
 bh=8gY7hkwizbfr7Ie0NJqO1utmSJIRwYHzCBYO7tLngu0=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=kOPbKUkdRpVYi4Yk345eK9WxKq5aWBFoBVQTn7FrWwLi0nyCsf9rZDCRVrJdp2M0e7F
 N/j23dQc4MzJwFqdixbMKQF1XdgZCiuHfcyr9+TcD1nMYzY1OXsnawqDj/3ZLlGPgmZMV
 3MPFGhKyYlJJ+t2U1v3sZcwc/AcF0QhXk/Y=

--gt0E9vuZG0zkZpKv08Cg
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline

--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is going on for a few days now, but today it seems worse than
> usual:
>=20
> https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/220169843
>=20
> builds are failing, 'HTTP 500 curl 22' error, so not a real build
> problem. I can probably just click restart... 6 times. But something
> is not there, and it is getting worse.

Today I got new one....

Waiting for pod gitlab/runner-bcrayztp-project-2678032-concurrent-392fb6 to=
 be running, status is Pending
217Running on runner-bcrayztp-project-2678032-concurrent-392fb6 via cip-pro=
ject-v3-gitlab-runner-6dbd79945f-wdqqw...
219
Fetching changes with git depth set to 10...
00:35
220Initialized empty Git repository in /builds/cip-project/cip-kernel/linux=
-cip/.git/
221Created fresh repository.
222error: RPC failed; curl 92 HTTP/2 stream 0 was not closed cleanly: INTER=
NAL_ERROR (err 2)
223fatal: the remote end hung up unexpectedly
224fatal: early EOF
225fatal: index-pack failed
227
Uploading artifacts.

I wonder... Is each of our workers pulling full copy of kernel from
gitlab?

If so, I understand that gitlab might be a bit unhappy. We probably
should populate the initial version from our servers (or from
kernel.org), or maybe include copy of recent linux directly into
machine images... to reduce load on gitlab.

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX71UqgAKCRAw5/Bqldv6
8h+7AJ9U3hD3chhLPjLEqkB2cIO+3ohXOQCeKAyrf9gF+eNzSwXFrhaBgPpHxoo=
=DUNq
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--

--gt0E9vuZG0zkZpKv08Cg
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5861): https://lists.cip-project.org/g/cip-dev/message=
/5861
Mute This Topic: https://lists.cip-project.org/mt/78460850/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--gt0E9vuZG0zkZpKv08Cg--

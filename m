Return-Path: <SRS0=5jGY=JU=lists.cip-project.org=bounce+64572+6386+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 486BCC433ED
	for <cip-dev@archiver.kernel.org>; Fri, 23 Apr 2021 10:58:04 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E1D261461
	for <cip-dev@archiver.kernel.org>; Fri, 23 Apr 2021 10:58:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E1D261461
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6386+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id bkMjYY4521723xKzF5Sfg591; Fri, 23 Apr 2021 03:58:02 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web08.7998.1619175481108576627
 for <cip-dev@lists.cip-project.org>;
 Fri, 23 Apr 2021 03:58:02 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id DD64C1C0B76; Fri, 23 Apr 2021 12:57:56 +0200 (CEST)
Date: Fri, 23 Apr 2021 12:57:56 +0200
From: "Pavel Machek" <pavel@denx.de>
To: pavel@denx.de, nobuhiro1.iwamatsu@toshiba.co.jp, wens@csie.org,
	cip-dev@lists.cip-project.org
Subject: [cip-dev] umn.edu situation and its effects on stable/cip
Message-ID: <20210423105756.GA22991@duo.ucw.cz>
MIME-Version: 1.0
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: TUzNrRumola08FrClzx3K1uBx4520388AA=
Content-Type: multipart/mixed; boundary="DdYXd13s01MAbLpDL0QV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1619175482;
 bh=5QXwlBSBksDs0B/jxGTgIbJ9q9TCr0IkPgKRlDFU0NY=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=AC0WuylRxVXtmz6NeKG4g0GGkksnQAf3TjMeZHssyGtaf1yQZ4re3wNOimRtCyXiXcc
 Fy9MrdG2qtvUYgNUH7Y80IjBK64Mj0nj3WQ/9glAPqVufNXsNCWT3zJrEM5Y98xAkik20
 3m7bZmLnLTuE4CCg0s8oYVHEqG45VL/AMR8=

--DdYXd13s01MAbLpDL0QV
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline

--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

You may have noticed in the news something funny is going on with
umn.edu commits.

Researchers at umn.edu did 3 bad-faith patches to kernel, sent them
=66rom gmail.com addresses, and tried to get them reviewed (but
prevented them from being merged):

https://github.com/QiushiWu/QiushiWu.github.io/blob/main/papers/OpenSourceI=
nsecurity.pdf

That somehow led to Greg trying to revert all patches from umn.edu:

https://github.com/QiushiWu/QiushiWu.github.io/blob/main/papers/OpenSourceI=
nsecurity.pdf

And indeed there are some patches that do not fix any problem in
mainline (I identified one during stable review), but I don't see
evidence they were done in bad faith.

This is developing news, discussed on linux-kernel and ksummit-discuss
mailing lists (at least), but it should not affect us till middle of
May, and in my view it is likely that impact will be minor in the end.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYIKoNAAKCRAw5/Bqldv6
8scrAJ476XIFrmFj7B1cwBtL1o12ctrcyACfXNhQzNFGVkNpGtfUA6pXizaW+Fg=
=qCzh
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--

--DdYXd13s01MAbLpDL0QV
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6386): https://lists.cip-project.org/g/cip-dev/message=
/6386
Mute This Topic: https://lists.cip-project.org/mt/82307678/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--DdYXd13s01MAbLpDL0QV--

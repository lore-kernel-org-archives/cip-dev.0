Return-Path: <SRS0=jcmF=M2=lists.cip-project.org=bounce+64572+6654+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A128C4338F
	for <cip-dev@archiver.kernel.org>; Tue,  3 Aug 2021 19:53:54 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77D0E6103C
	for <cip-dev@archiver.kernel.org>; Tue,  3 Aug 2021 19:53:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 77D0E6103C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id PL0eYY4521723xRCKHVBb35n; Tue, 03 Aug 2021 12:53:53 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.4050.1628020431493802173
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Aug 2021 12:53:52 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 926C11C0B76; Tue,  3 Aug 2021 21:53:47 +0200 (CEST)
Date: Tue, 3 Aug 2021 21:53:47 +0200
From: "Pavel Machek" <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: cip-dev@lists.cip-project.org, pavel@denx.de,
	Chris.Paterson2@renesas.com, masashi.kudo@cybertrust.co.jp,
	masami.ichikawa@cybertrust.co.jp
Subject: Re: [cip-dev] [ANNOUNCE] Release v4.4.277-cip60
Message-ID: <20210803195347.GB16178@duo.ucw.cz>
References: <TYAPR01MB62521F8D2A41BC0B6DEEDE3F92F09@TYAPR01MB6252.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <TYAPR01MB62521F8D2A41BC0B6DEEDE3F92F09@TYAPR01MB6252.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: L3NRPifAqfXatzS0f4L7S0bbx4520388AA=
Content-Type: multipart/mixed; boundary="SDJX4nJNK4RUxwrWFLqO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1628020433;
 bh=YmblNJMDZ1bgXR8yKHT6w7D1YssJcM+0Ty4zEpdxlec=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=FCZyUyT7Grb7694SKdKTfwPYv56yGGAHP8W5U/o23fFmM+W4WLrrEPTy+o7mTlsgE/F
 HXf06WbNGO1IK1ztyxlTlSU5Ij2yjsqKghsTasKmp0hAB6AlfvWRSGRi2ZopnRuxZtnTV
 O9EjdebF0WTu4M4H8TIsq7fQDs3i64JzSjc=

--SDJX4nJNK4RUxwrWFLqO
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FkmkrVfFsRoUs1wW"
Content-Disposition: inline

--FkmkrVfFsRoUs1wW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> CIP kernel team has released Linux kernel v4.4.277-cip60.
> The 4.4.y tree was scheduled to be released next week, but we have
> rescheduled it for the release of the CIP-RT tree.
>=20
> The linux-4.4.y-cip tree has been updated base version from v4.4.274
> to v4.4.277. No CIP-specific patches have been added to this version.

Thank you, it was very useful for getting 4.4-rt released.

I noticed that linux-4.4.y-cip-rebase was not updated, but as there
were no changes between -cip59 and -cip60, it did not pose a problem.
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-4.4.y-cip-rebase

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--FkmkrVfFsRoUs1wW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYQmeywAKCRAw5/Bqldv6
8jxKAJ9TVtcajmjfhcjtnSezSfvM5VtFUACcCu5k23CB18PQlrhU9q3hOrDqE9o=
=2L1K
-----END PGP SIGNATURE-----

--FkmkrVfFsRoUs1wW--

--SDJX4nJNK4RUxwrWFLqO
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6654): https://lists.cip-project.org/g/cip-dev/message=
/6654
Mute This Topic: https://lists.cip-project.org/mt/84632315/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/452038=
8/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--SDJX4nJNK4RUxwrWFLqO--

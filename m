Return-Path: <SRS0=B9oZ=CM=lists.cip-project.org=bounce+64572+5408+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C199C43461
	for <cip-dev@archiver.kernel.org>; Thu,  3 Sep 2020 20:43:19 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2EE52083B
	for <cip-dev@archiver.kernel.org>; Thu,  3 Sep 2020 20:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="xT7wNuEX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2EE52083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5408+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id EippYY4521723xc5bFjtVZSP; Thu, 03 Sep 2020 13:43:18 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.23683.1599165796251018112
 for <cip-dev@lists.cip-project.org>;
 Thu, 03 Sep 2020 13:43:17 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id B64021C0B76; Thu,  3 Sep 2020 22:43:12 +0200 (CEST)
Date: Thu, 3 Sep 2020 22:43:11 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.4.y-cip 1/4] serial: mctrl_gpio: Check if GPIO property exisits before requesting it
Message-ID: <20200903204311.GA24361@duo.ucw.cz>
References: <20200903142719.13010-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200903142719.13010-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <20200903142719.13010-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: mPHF70zZXclcPn4cIgk6ON3vx4520388AA=
Content-Type: multipart/mixed; boundary="bKv9rmCB8LlQIaUKRPD8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1599165798;
 bh=FZPuuipMpEbLxILXV8GbqMPTEbCcFd0dx6WVFeyY7Q8=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=xT7wNuEXqy0aE0Rd1kYp/lS1OBs//LI0z6VlRCc0L9MRbWSIA7jtwWEx7yu1DLNaWqg
 bUsLIoow3oW0bqKMIFWme9NZzCoC0GBKi0Ro5USBC1XaaQiBwjGIt2MIq3sIwEtqX7fE5
 Y5KPeqfbeU58phafS+sGjnLo1GaN1bCR0F8=

--bKv9rmCB8LlQIaUKRPD8
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline

--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch adds a check for the GPIOs property existence, before the
> GPIO is requested. This fixes an issue seen when the 8250 mctrl_gpio
> support is added (2nd patch in this patch series) on x86 platforms using
> ACPI.

Ok, so this fixes serial_mctrl_gpio on some ACPI systems. It should be
a NOP on Renesas hardware, right?

Do you need this one in 4.4? Was it tested on problematic ACPI system?

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX1FVXwAKCRAw5/Bqldv6
8ne6AJ939v2p6Urob7ZHsNu8CnkW+4QD2QCgvEccyUL9SkipvJqR+b6UVbMKzjc=
=PJQC
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--

--bKv9rmCB8LlQIaUKRPD8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5408): https://lists.cip-project.org/g/cip-dev/message=
/5408
Mute This Topic: https://lists.cip-project.org/mt/76607963/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--bKv9rmCB8LlQIaUKRPD8--

Return-Path: <SRS0=P9FF=B4=lists.cip-project.org=bounce+64572+5129+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958ABC433DF
	for <cip-dev@archiver.kernel.org>; Tue, 18 Aug 2020 07:57:14 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E9BC206B5
	for <cip-dev@archiver.kernel.org>; Tue, 18 Aug 2020 07:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="i6UcNjq8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E9BC206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toshiba-tsip.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5129+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 5H2jYY4521723xaLHYHJTH3o; Tue, 18 Aug 2020 00:57:13 -0700
Subject: Re: [cip-dev] [isar-cip-core] security-customizations: Recipe to apply security configurations
To: cip-dev@lists.cip-project.org
From: "Venkata Pyla" <venkata.pyla@toshiba-tsip.com>
X-Originating-Location: Hyderabad, Telangana, IN (157.44.118.144)
X-Originating-Platform: Windows Chrome 84
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Tue, 18 Aug 2020 00:57:13 -0700
References: <20ae8e8c-fded-c2ee-517a-d1f077f3224b@siemens.com>
In-Reply-To: <20ae8e8c-fded-c2ee-517a-d1f077f3224b@siemens.com>
Message-ID: <12712.1597737433226203230@lists.cip-project.org>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: voOPJyosL6aTjDZDI4w0YV4yx4520388AA=
Content-Type: multipart/mixed; boundary="cSA2MKvzks8IwJKBntvc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1597737433;
 bh=cfwpWzlBC1Cg7DmK3s0aUIoKBAKQMdaCp8KNypu3FeY=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=i6UcNjq8Yl6LTFsI0tYI37AWO0WUr+ce55F5KufdoMw3SnjMt0mV6Ga2hmEt/I6uayg
 lNiPjyydyeS12Qp8qWq06sc6R4Y0S1fpwnMn8i0+4YWWdKKaVhzrU62zpwV84RIGY4YZ/
 dHppuco5hjJCmVnSN13OlXpHddqRQcX4MVA=

--cSA2MKvzks8IwJKBntvc
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2020 at 08:49 PM, Jan Kiszka wrote:

>
> >=20
> >=20
> >> +++ b/recipes-core/security-customizations/security-customizations.bb
> >> @@ -0,0 +1,18 @@
> >> +#
> >> +# CIP Security, generic profile
> >> +#
> >> +# Copyright (c) Toshiba Corporation, 2020
> >> +#
> >> +# Authors:
> >> +# Venkata Pyla <venkata.pyla@...>#
> >> +#
> >> +# SPDX-License-Identifier: MIT
> >> +#
> >> +
> >> +inherit dpkg-raw
> >> +
> >> +DESCRIPTION =3D "CIP Security image for IEC62443-4-2 evaluation"
> >> +
> >> +SRC_URI =3D " file://postinst"
> >> +
> >=20
> >=20
>=20
> Was missing
>=20
> DEPENDS =3D "sshd-regen-keys"
>=20
> Added this, CI should be passing now. I suspect you tested over a
> non-clean build with leftovers that papered over it.
>=20

sorry, i have not verified on clean build,
Thanks for fixing it.

> Jan
>=20
> >=20
> >=20
> >> +DEBIAN_DEPENDS =3D "sshd-regen-keys"
> >>=20
> >=20
> > Thanks, applied to next.
> >=20
> > Jan
>

--cSA2MKvzks8IwJKBntvc
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5129): https://lists.cip-project.org/g/cip-dev/message=
/5129
Mute This Topic: https://lists.cip-project.org/mt/76006733/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--cSA2MKvzks8IwJKBntvc--

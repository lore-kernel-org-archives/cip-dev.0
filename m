Return-Path: <SRS0=sYqr=BJ=lists.cip-project.org=bounce+64572+5069+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5820C433E0
	for <cip-dev@archiver.kernel.org>; Thu, 30 Jul 2020 09:34:10 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DC0D2082E
	for <cip-dev@archiver.kernel.org>; Thu, 30 Jul 2020 09:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="LGjKj6+a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DC0D2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toshiba-tsip.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5069+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id av27YY4521723xw1SJJWoY7S; Thu, 30 Jul 2020 02:34:10 -0700
Subject: Re: [cip-dev] [isar-cip-core 1/2] opt: Add kas option file for security image
To: cip-dev@lists.cip-project.org
From: "Venkata Pyla" <venkata.pyla@toshiba-tsip.com>
X-Originating-Location: Bengaluru, Karnataka, IN (202.56.254.194)
X-Originating-Platform: Windows Chrome 84
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Thu, 30 Jul 2020 02:34:09 -0700
References: <51ec0d91-7eae-0c2d-5711-ab20f4b7ad26@siemens.com>
In-Reply-To: <51ec0d91-7eae-0c2d-5711-ab20f4b7ad26@siemens.com>
Message-ID: <19585.1596101649462525400@lists.cip-project.org>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: I01A4x1snrr76aWt3uEbamMox4520388AA=
Content-Type: multipart/mixed; boundary="0zbvowA3JZrgOwkzJlgT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1596101650;
 bh=3/aqO6OQD1yTi30xbzlJPfGo9wAGUxZCY9wwcWqYDC0=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=LGjKj6+avwQoLt9IX28PtoliZHMhWGvpAmf3IZp/XGj9KpvqdbEFx/svLDFoErc0uis
 LfTRvvv+KH1OG96voAW/OJ04ETwZ0wk0e4lsE7R4kjpAdUMltt/c50DiM6YUvENRefnW7
 v395SPPdx8vA9DMnRf2zEyHYvYOPhgRuj7k=

--0zbvowA3JZrgOwkzJlgT
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2020 at 02:51 PM, Jan Kiszka wrote:

>
> On 30.07.20 11:10, venkata.pyla@toshiba-tsip.com wrote:
> > From: venkata pyla <venkata.pyla@toshiba-tsip.com>
> >=20
> > Signed-off-by: Venkata Pyla <venkata.pyla@toshiba-tsip.com>
>=20
> Different capitalization of your name. Only reporting that as my tooling=
=
=20
> detected this mismatch. It checks if signed-off and authorship match.=20

I will correct this problem thank you.

>
> Both patches applied to next - let's get CI started.

Thank you for applying the patches.

>=20
> Thanks,
> Jan
>=20
> > ---
> >   README.md            |  2 +-
> >   kas/opt/security.yml | 14 ++++++++++++++
> >   2 files changed, 15 insertions(+), 1 deletion(-)
> >   create mode 100644 kas/opt/security.yml
> >=20
> > diff --git a/README.md b/README.md
> > index 26fbbef..250dbad 100644
> > --- a/README.md
> > +++ b/README.md
> > @@ -39,7 +39,7 @@ card, run
> >   ## Building Security target images
> >   Building images for QEMU x86-64bit machine
> >  =20
> > -    ./kas-docker --isar build --target cip-core-image-security
> kas.yml:board-qemu-amd64.yml
> > +    ./kas-docker --isar build
> kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/security.yml
> >  =20
> >   Run the generated securiy images on QEMU (x86-64bit)
> >  =20
> > diff --git a/kas/opt/security.yml b/kas/opt/security.yml
> > new file mode 100644
> > index 0000000..237cbeb
> > --- /dev/null
> > +++ b/kas/opt/security.yml
> > @@ -0,0 +1,14 @@
> > +#
> > +# CIP Core, generic profile
> > +#
> > +# Copyright (c) Toshiba Corporation, 2020
> > +#
> > +# Authors:
> > +#  Venkata Pyla <venkata.pyla@toshiba-tsip.com>
> > +#
> > +# SPDX-License-Identifier: MIT
> > +#
> > +header:
> > +  version: 8
> > +
> > +target: cip-core-image-security
> >=20
>=20
> --=20
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux
>

--0zbvowA3JZrgOwkzJlgT
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5069): https://lists.cip-project.org/g/cip-dev/message=
/5069
Mute This Topic: https://lists.cip-project.org/mt/75882938/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--0zbvowA3JZrgOwkzJlgT--

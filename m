Return-Path: <SRS0=pVbZ=BD=lists.cip-project.org=bounce+64572+4992+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F24AC433E1
	for <cip-dev@archiver.kernel.org>; Fri, 24 Jul 2020 06:58:29 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16A7620714
	for <cip-dev@archiver.kernel.org>; Fri, 24 Jul 2020 06:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="bQ5QF94S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16A7620714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toshiba-tsip.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4992+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id SoqNYY4521723xdph2MpSNNC; Thu, 23 Jul 2020 23:58:28 -0700
Subject: Re: [cip-dev] [PATCH 3/3] README: Add steps to build cip-security image
To: cip-dev@lists.cip-project.org
From: "Venkata Pyla" <venkata.pyla@toshiba-tsip.com>
X-Originating-Location: Bengaluru, Karnataka, IN (202.56.254.194)
X-Originating-Platform: Windows Chrome 83
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Thu, 23 Jul 2020 23:58:28 -0700
References: <544b0f34-c55b-2be1-d672-6a5eb796403e@siemens.com>
In-Reply-To: <544b0f34-c55b-2be1-d672-6a5eb796403e@siemens.com>
Message-ID: <30764.1595573908018751968@lists.cip-project.org>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: kPcujFBzhLScSfQRKgc4l5cGx4520388AA=
Content-Type: multipart/mixed; boundary="j7cBy43xGsK2kr2MbU84"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595573908;
 bh=J8cgZaBtYvUI/FO10g1SrMUTVx6QMsNgtTqqPgb9fTo=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=bQ5QF94SSO24EzZQfGxjcgiqheErD6rtvFa0pqQp4E7cRje5ul6hJc32rMBHxVrii9l
 +R9rVcrZREYnSEXO3zEAgcgy7ZQVhHqb0/RuML2DR1tczcXpfsBetfX/Qo+TuMwZrrW/l
 J4NQkszUDzOQnVG/FjFnnhnm4PVinJ6cx7g=

--j7cBy43xGsK2kr2MbU84
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Jan,

On Thu, Jul 23, 2020 at 04:10 PM, Jan Kiszka wrote:

>
> On 21.07.20 10:16, Venkata Pyla wrote:
> > From: venkata <venkata.pyla@toshiba-tsip.com>
> >=20
> > Signed-off-by: venkata <venkata.pyla@toshiba-tsip.com>
> > ---
> >   README.md | 10 ++++++++++
> >   1 file changed, 10 insertions(+)
> >=20
> > diff --git a/README.md b/README.md
> > index bbad1a0..b2c4166 100644
> > --- a/README.md
> > +++ b/README.md
> > @@ -36,6 +36,16 @@ card, run
> >       dd
> if=3Dbuild/tmp/deploy/images/bbb/cip-core-image-cip-core-buster-bbb.wic.=
img \
> >          of=3D/dev/<medium-device> bs=3D1M status=3Dprogress
> >  =20
> > +## Building Security target images
> > +Building images for QEMU x86-64bit machine
> > +
> > +    ./kas-docker --isar build --target cip-core-image-security
> kas.yml:board-qemu-amd64.yml
> > +
> > +Run the generated securiy images on QEMU (x86-64bit)
> > +
> > +    TARGET_IMAGE=3Dcip-core-image-security ./start-qemu.sh amd64
> > +
> > +
> >   ## Community Resources
> >  =20
> >   TBD
> >=20
>=20
> This patch is fine, but I'm missing 4/4: Add this image to CI (same=20
> comment as I had on the MR on gitlab).
>=20

Adding cip security image to CI,=20
i need some suggestions to use the current format present in .gitlab-ci.ym=
l

Currently i have the below problem for using script deploy-cip-core.sh:
1. image name formation in the script should have another variable
         .../$IMG_PREFIX-cip-core-$RELEASE-$TARGET
         where $IMG_PREFIX is default to "cip-core-image"  if not specifie=
d
          for security image it will be passed as 4th argument "cip-core-i=
mage-security"
2. currently scrit is expecting the image format in *.wic.img so,
       for qemu i think we should have wks file to generate image with for=
mat .wic.img

or for this security image do we need to deploy it seperatley?
please guide me

Thanks

> Jan
>=20
> --=20
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux
>

--j7cBy43xGsK2kr2MbU84
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4992): https://lists.cip-project.org/g/cip-dev/message=
/4992
Mute This Topic: https://lists.cip-project.org/mt/75699595/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--j7cBy43xGsK2kr2MbU84--

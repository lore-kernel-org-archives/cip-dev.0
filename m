Return-Path: <SRS0=o27i=BI=lists.cip-project.org=bounce+64572+5046+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21CC2C433DF
	for <cip-dev@archiver.kernel.org>; Wed, 29 Jul 2020 12:39:22 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A407A20829
	for <cip-dev@archiver.kernel.org>; Wed, 29 Jul 2020 12:39:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="tUSDQFBR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A407A20829
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toshiba-tsip.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5046+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id pI2GYY4521723xA4XP513o65; Wed, 29 Jul 2020 05:39:21 -0700
Subject: Re: [cip-dev] [isar-cip-core 1/3] cip-security: Add packages for IEC-62443-4-2 evaluation
To: cip-dev@lists.cip-project.org
From: "Venkata Pyla" <venkata.pyla@toshiba-tsip.com>
X-Originating-Location: Bengaluru, Karnataka, IN (49.207.193.3)
X-Originating-Platform: Linux Firefox 68
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Wed, 29 Jul 2020 05:39:20 -0700
References: <79d0ae51-9d84-ce85-d6fc-95bb22bdc2cb@siemens.com>
In-Reply-To: <79d0ae51-9d84-ce85-d6fc-95bb22bdc2cb@siemens.com>
Message-ID: <7345.1596026360263349677@lists.cip-project.org>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: rvUkfcBf6rXAubTvAaitlJfwx4520388AA=
Content-Type: multipart/mixed; boundary="kJ7Wyor8hejikqS6EXW7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1596026361;
 bh=m7N63jg+q9RMHsFR074v+NT2jM3zwHrI1zF8z5U+APs=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=tUSDQFBRTPWZyR2TFxVdSepz6Ur+AXYMygX7+liBZ1xJqOSc+4Fl6/T7OYQacUospGP
 Eohiz1DTVClbur6WECFoSVOnq6DbrxQ2wanKSMWAIoRY8omwFJ9nscDTRhCNmDavvD4SW
 qVqa6jWttIWD0kWM3u12IV69rCNPGqJ3Ntk=

--kJ7Wyor8hejikqS6EXW7
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2020 at 08:04 PM, Jan Kiszka wrote:

>
> On 27.07.20 13:41, venkata.pyla@toshiba-tsip.com wrote:
> > From: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
> >=20
> > Identified security packages are added to the target image
> > and that will be used for IEC-62443-4-2 evaluation
> >=20
> > Signed-off-by: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
> > Signed-off-by: Venkata Pyla <venkata.pyla@toshiba-tsip.com>
> > ---
> >   .../images/cip-core-image-security.bb         | 36 +++++++++++++++++=
++
> >   1 file changed, 36 insertions(+)
> >   create mode 100644 recipes-core/images/cip-core-image-security.bb
> >=20
> > diff --git a/recipes-core/images/cip-core-image-security.bb
> b/recipes-core/images/cip-core-image-security.bb
> > new file mode 100644
> > index 0000000..a17c522
> > --- /dev/null
> > +++ b/recipes-core/images/cip-core-image-security.bb
> > @@ -0,0 +1,36 @@
> > +#
> > +# A reference image which includes security packages
> > +#
> > +# Copyright (c) Toshiba Corporation, 2020
> > +#
> > +# Authors:
> > +#  Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
> > +#
> > +# SPDX-License-Identifier: MIT
> > +#
> > +
> > +inherit image
> > +
> > +DESCRIPTION =3D "CIP Core image including security packages"
> > +
> > +IMAGE_INSTALL +=3D "customizations"
> > +
> > +# Debian packages that provide security features
> > +IMAGE_PREINSTALL +=3D " \
> > +	openssl libssl1.1 \
> > +	fail2ban \
> > +	openssh-server openssh-sftp-server openssh-client \
> > +	syslog-ng-core syslog-ng-mod-journal \
> > +	aide aide-common \
> > +	libnftables0 nftables \
> > +	libpam-pkcs11 \
> > +	chrony \
> > +	tpm2-tools \
> > +	tpm2-abrmd \
> > +	libtss2-esys0 libtss2-udev \
> > +	libpam-cracklib \
> > +	acl \
> > +	libauparse0 audispd-plugins auditd \
> > +	uuid-runtime \
> > +	sudo \
> > +"
> >=20
>=20
> Still no CI for this. You can send that separately on top, the series=20
> looks fine otherwise.
>

To add security image in gitlab-ci.yml i need some suggestions...
in deploy-cip-core script that is used in gitlab-ci is expecting *.wic ima=
ge for copying the files,=20
but because there is no wks file yet for QEMU it is not generating the ima=
ge.

i think we should add wks file for the qemu target, can you guide me how t=
o do that?

> Jan
>=20
> --=20
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux
>

--kJ7Wyor8hejikqS6EXW7
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5046): https://lists.cip-project.org/g/cip-dev/message=
/5046
Mute This Topic: https://lists.cip-project.org/mt/75820361/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--kJ7Wyor8hejikqS6EXW7--

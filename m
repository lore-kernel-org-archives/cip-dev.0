Return-Path: <SRS0=J2aw=BC=lists.cip-project.org=bounce+64572+4988+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF734C433DF
	for <cip-dev@archiver.kernel.org>; Thu, 23 Jul 2020 12:53:12 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E14820768
	for <cip-dev@archiver.kernel.org>; Thu, 23 Jul 2020 12:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="BvIXVWD8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E14820768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toshiba-tsip.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4988+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id dbEkYY4521723xUeFXEvsCO0; Thu, 23 Jul 2020 05:53:11 -0700
Subject: Re: [cip-dev] [PATCH 1/3] cip-security: Add packages for IEC-62443-4-2 Evaluation.
To: cip-dev@lists.cip-project.org
From: "Venkata Pyla" <venkata.pyla@toshiba-tsip.com>
X-Originating-Location: Bengaluru, Karnataka, IN (202.56.254.194)
X-Originating-Platform: Windows Chrome 83
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Thu, 23 Jul 2020 05:53:11 -0700
References: <ab8b6d0d-aff4-cdfe-e926-385f62aae02d@siemens.com>
In-Reply-To: <ab8b6d0d-aff4-cdfe-e926-385f62aae02d@siemens.com>
Message-ID: <3944.1595508791111156485@lists.cip-project.org>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: bkLY8tUqhGnW4IuvOt7qejwMx4520388AA=
Content-Type: multipart/mixed; boundary="MzZanM1Ex5FdChkO7TeI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595508791;
 bh=ROAiYf3jksHrnfHg9OWhWSsv4UbAGzdOSo3httAQlJ0=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=BvIXVWD872USBdcohLKDxMFz8aZmMzEO0oW+p6Xz61QkM/Ob3byUCVRSRTuWotMoPRk
 HWugpI45eSusGdqahxfDAtdER2yIr95HJQHbUsLe964b6SeW34PoXuf8U2DwVKzjR+d32
 GWxdKmi/0U10UbzqCtTx+tP72MgLc2guj7U=

--MzZanM1Ex5FdChkO7TeI
Content-Type: multipart/alternative; boundary="gYjlHV7IaogFtgpoXfYZ"

--gYjlHV7IaogFtgpoXfYZ
Content-Type: text/plain; charset="utf-8"; markup=markdown
Content-Transfer-Encoding: quoted-printable

Hi Jan,

On Thu, Jul 23, 2020 at 04:07 PM, Jan Kiszka wrote:

>
> On 21.07.20 10:16, Venkata Pyla wrote:
> > From: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
> >=20
> > Identified security packages are added to the target image
> > and that will be used for IEC-62443-4-2 evaluation
> >=20
> > Signed-off-by: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
> > Signed-off-by: pvenkata2 <venkata.pyla@toshiba-tsip.com>
>                   ^^^^^^^^^
> Can you configure your git to add you written name here as well? It's in=
=
=20
> the email, yes, but it would be nicer to have it displayed as well.
>=20
sure, i didn't notice, it was missed in my git config

> > ---
> >   .../images/cip-core-image-security.bb         | 37 +++++++++++++++++=
++
> >   1 file changed, 37 insertions(+)
> >   create mode 100644 recipes-core/images/cip-core-image-security.bb
> >=20
> > diff --git a/recipes-core/images/cip-core-image-security.bb
> b/recipes-core/images/cip-core-image-security.bb
> > new file mode 100644
> > index 0000000..8253952
> > --- /dev/null
> > +++ b/recipes-core/images/cip-core-image-security.bb
> > @@ -0,0 +1,37 @@
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
> > +# Use the same customizations as cip-core-image
>=20
> That comment is not needed. It just creates the risk of becoming=20
> outdated if cip-core-image decides to do something else.
>=20
Understood, i will modify and resend this patch series.

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
> Can you close=20
> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/merge_requests/8=
=
=20
> if this series obsoletes it?
I have rebased the branch and sent the patches over mail,
I think i should close this MR in gitlab, i will do that.

> BTW, a cover letter would help structuring the patches together. And=20
> please add a tag like "[isar-cip-core]" in order to clarify the series=
=20
> target. That is all configurable in git format-patch/send-email.
>=20
> Jan
>=20
> --=20
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux
>

--gYjlHV7IaogFtgpoXfYZ
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<p>Hi Jan,</p>

<p>On Thu, Jul 23, 2020 at 04:07 PM, Jan Kiszka wrote:</p>

<blockquote>
<p>On 21.07.20 10:16, Venkata Pyla wrote:
&gt; From: Kazuhiro Hayashi <a href=3D"mailto:kazuhiro3.hayashi@toshiba.co=
.jp" target=3D"_blank">kazuhiro3.hayashi@toshiba.co.jp</a>
&gt;
&gt; Identified security packages are added to the target image
&gt; and that will be used for IEC-62443-4-2 evaluation
&gt;
&gt; Signed-off-by: Kazuhiro Hayashi <a href=3D"mailto:kazuhiro3.hayashi@t=
oshiba.co.jp" target=3D"_blank">kazuhiro3.hayashi@toshiba.co.jp</a>
&gt; Signed-off-by: pvenkata2 <a href=3D"mailto:venkata.pyla@toshiba-tsip.=
com" target=3D"_blank">venkata.pyla@toshiba-tsip.com</a>
                  ^^^^^^^^^
Can you configure your git to add you written name here as well? It's in
the email, yes, but it would be nicer to have it displayed as well.</p>

<p>sure, i didn't notice, it was missed in my git config</p>

<blockquote>
<hr>

<p>.../images/cip-core-image-security.bb         | 37 +++++++++++++++++++
  1 file changed, 37 insertions(+)
  create mode 100644 recipes-core/images/cip-core-image-security.bb</p>

<p>diff --git a/recipes-core/images/cip-core-image-security.bb
b/recipes-core/images/cip-core-image-security.bb
new file mode 100644
index 0000000..8253952
--- /dev/null
+++ b/recipes-core/images/cip-core-image-security.bb
@@ -0,0 +1,37 @@
+#
+# A reference image which includes security packages
+#
+# Copyright (c) Toshiba Corporation, 2020
+#
+# Authors:
+#  Kazuhiro Hayashi <a href=3D"mailto:kazuhiro3.hayashi@toshiba.co.jp" ta=
rget=3D"_blank">kazuhiro3.hayashi@toshiba.co.jp</a>
+#
+# SPDX-License-Identifier: MIT
+#
+
+inherit image
+
+DESCRIPTION =3D &quot;CIP Core image including security packages&quot;
+
+# Use the same customizations as cip-core-image</p>
</blockquote>

<p>That comment is not needed. It just creates the risk of becoming
outdated if cip-core-image decides to do something else.</p>

<p>Understood, i will modify and resend this patch series.</p>

<blockquote>
<p>+IMAGE_INSTALL +=3D &quot;customizations&quot;
+
+# Debian packages that provide security features
+IMAGE_PREINSTALL +=3D &quot; \
+   openssl libssl1.1 \
+   fail2ban \
+   openssh-server openssh-sftp-server openssh-client \
+   syslog-ng-core syslog-ng-mod-journal \
+   aide aide-common \
+   libnftables0 nftables \
+   libpam-pkcs11 \
+   chrony \
+   tpm2-tools \
+   tpm2-abrmd \
+   libtss2-esys0 libtss2-udev \
+   libpam-cracklib \
+   acl \
+   libauparse0 audispd-plugins auditd \
+   uuid-runtime \
+   sudo \
+&quot;</p>
</blockquote>

<p>Can you close
<a href=3D"https://gitlab.com/cip-project/cip-core/isar-cip-core/-/merge_r=
equests/8" target=3D"_blank">https://gitlab.com/cip-project/cip-core/isar-c=
ip-core/-/merge_requests/8</a>
if this series obsoletes it?
I have rebased the branch and sent the patches over mail,
I think i should close this MR in gitlab, i will do that.</p>

<p>BTW, a cover letter would help structuring the patches together. And
please add a tag like &quot;[isar-cip-core]&quot; in order to clarify the =
series
target. That is all configurable in git format-patch/send-email.</p>

<p>Jan</p>

<p>--
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux</p>
</blockquote>

--gYjlHV7IaogFtgpoXfYZ--

--MzZanM1Ex5FdChkO7TeI
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4988): https://lists.cip-project.org/g/cip-dev/message=
/4988
Mute This Topic: https://lists.cip-project.org/mt/75699592/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--MzZanM1Ex5FdChkO7TeI--

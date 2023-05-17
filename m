Return-Path: <srinuvasan_a@mentor.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456D2C77B7A
	for <webhook@archiver.kernel.org>; Wed, 17 May 2023 10:30:39 +0000 (UTC)
Subject: Re: [isar-cip-core][PATCH] kas/opt/6.1-mainline: use KERNEL_DEFCONFIG from cip-kernel-config
To: cip-dev@lists.cip-project.org
From: "Srinuvasan A" <srinuvasan_a@mentor.com>
X-Originating-Location: US (139.181.36.34)
X-Originating-Platform: Windows Chrome 113
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Wed, 17 May 2023 03:30:38 -0700
References: <c2e2ac19-99a0-9012-7806-e7f656ff5a95@siemens.com>
In-Reply-To: <c2e2ac19-99a0-9012-7806-e7f656ff5a95@siemens.com>
Message-ID: <22447.1684319438306897517@lists.cip-project.org>
Content-Type: multipart/alternative; boundary="bOYTzdSGudehieYtXOl7"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 May 2023 10:30:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11489

--bOYTzdSGudehieYtXOl7
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 17, 2023 at 03:57 PM, Jan Kiszka wrote:

>=20
> On 17.05.23 12:22, Srinuvasan Arjunan wrote:
>=20
>> From: Srinuvasan A <srinuvasan.a@siemens.com>
>>=20
>> Presently 6.1 mainline kernel uses it's internal configuration, now cip
>> provides the defconfig for 6.1 LTS, hence use that one, this config
>> already conatins the CONFIG_SQUASHFS, so remove this one from recipe.
>>=20
>> Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
>> ---
>> kas/opt/6.1-mainline.yml | 1 -
>> recipes-kernel/linux/files/squashfs.cfg | 1 -
>> recipes-kernel/linux/linux-mainline_6.1.15.bb | 3 +--
>> 3 files changed, 1 insertion(+), 4 deletions(-)
>> delete mode 100644 recipes-kernel/linux/files/squashfs.cfg
>>=20
>> diff --git a/kas/opt/6.1-mainline.yml b/kas/opt/6.1-mainline.yml
>> index 84d12b0..0dcf336 100644
>> --- a/kas/opt/6.1-mainline.yml
>> +++ b/kas/opt/6.1-mainline.yml
>> @@ -14,5 +14,4 @@ header:
>>=20
>> local_conf_header:
>> kernel-version: |
>> - KERNEL_DEFCONFIG =3D ""
>=20
> That was actually missing from my patch to finally use the
> cip-kernel-config - good point.
>=20
>=20
>> KERNEL_NAME =3D "mainline"
>> diff --git a/recipes-kernel/linux/files/squashfs.cfg
>> b/recipes-kernel/linux/files/squashfs.cfg
>> deleted file mode 100644
>> index 7a89d00..0000000
>> --- a/recipes-kernel/linux/files/squashfs.cfg
>> +++ /dev/null
>> @@ -1 +0,0 @@
>> -CONFIG_SQUASHFS=3Dy
>> diff --git a/recipes-kernel/linux/linux-mainline_6.1.15.bb
>> b/recipes-kernel/linux/linux-mainline_6.1.15.bb
>> index 690f6dd..9b45f28 100644
>> --- a/recipes-kernel/linux/linux-mainline_6.1.15.bb
>> +++ b/recipes-kernel/linux/linux-mainline_6.1.15.bb
>> @@ -12,8 +12,7 @@ ARCHIVE_VERSION =3D "${@ d.getVar('PV')[:-2] if
>> d.getVar('PV').endswith('.0') else
>> KERNEL_DEFCONFIG_VERSION ?=3D "6.1.y-cip"
>>=20
>> SRC_URI +=3D " \
>> - https://cdn.kernel.org/pub/linux/kernel/v6.x/linux- ${ARCHIVE_VERSION}=
.tar.xz
>> \
>> - file://squashfs.cfg"
>> + https://cdn.kernel.org/pub/linux/kernel/v6.x/linux- ${ARCHIVE_VERSION}=
.tar.xz"
>>=20
>>=20
>> SRC_URI[sha256sum] =3D
>> "2c16dfe2168a2e64ac0d55a12d625ebfb963818bb48b60c1868c7c460644c4fd"
>=20
> If you don't mind, I'll fold that into [1] and send it as v2.

Sure jan, Please send v2.

>=20
>=20
> Jan
>=20
> [1]
> https://lore.kernel.org/cip-dev/f1be8d8c-d58d-715f-b6c0-39d76826450e@siem=
ens.com/T/#u
>=20
>=20
> --
> Siemens AG, Technology
> Competence Center Embedded Linux

--bOYTzdSGudehieYtXOl7
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 17, 2023 at 03:57 PM, Jan Kiszka wrote:<br />
<blockquote>On 17.05.23 12:22, Srinuvasan Arjunan wrote:<br />
<blockquote>From: Srinuvasan A &lt;srinuvasan.a@siemens.com&gt;<br /><br />=
Presently 6.1 mainline kernel uses it's internal configuration, now cip<br =
/>provides the defconfig for 6.1 LTS, hence use that one, this config<br />=
already conatins the CONFIG_SQUASHFS, so remove this one from recipe.<br />=
<br />Signed-off-by: Srinuvasan A &lt;srinuvasan.a@siemens.com&gt;<br />---=
<br />kas/opt/6.1-mainline.yml | 1 -<br />recipes-kernel/linux/files/squash=
fs.cfg | 1 -<br />recipes-kernel/linux/linux-mainline_6.1.15.bb | 3 +--<br =
/>3 files changed, 1 insertion(+), 4 deletions(-)<br />delete mode 100644 r=
ecipes-kernel/linux/files/squashfs.cfg<br /><br />diff --git a/kas/opt/6.1-=
mainline.yml b/kas/opt/6.1-mainline.yml<br />index 84d12b0..0dcf336 100644<=
br />--- a/kas/opt/6.1-mainline.yml<br />+++ b/kas/opt/6.1-mainline.yml<br =
/>@@ -14,5 +14,4 @@ header:<br /><br />local_conf_header:<br />kernel-versi=
on: |<br />- KERNEL_DEFCONFIG =3D ""</blockquote>
That was actually missing from my patch to finally use the<br />cip-kernel-=
config - good point.<br /><br />
<blockquote>KERNEL_NAME =3D "mainline"<br />diff --git a/recipes-kernel/lin=
ux/files/squashfs.cfg b/recipes-kernel/linux/files/squashfs.cfg<br />delete=
d file mode 100644<br />index 7a89d00..0000000<br />--- a/recipes-kernel/li=
nux/files/squashfs.cfg<br />+++ /dev/null<br />@@ -1 +0,0 @@<br />-CONFIG_S=
QUASHFS=3Dy<br />diff --git a/recipes-kernel/linux/linux-mainline_6.1.15.bb=
 b/recipes-kernel/linux/linux-mainline_6.1.15.bb<br />index 690f6dd..9b45f2=
8 100644<br />--- a/recipes-kernel/linux/linux-mainline_6.1.15.bb<br />+++ =
b/recipes-kernel/linux/linux-mainline_6.1.15.bb<br />@@ -12,8 +12,7 @@ ARCH=
IVE_VERSION =3D "${@ d.getVar('PV')[:-2] if d.getVar('PV').endswith('.0') e=
lse<br />KERNEL_DEFCONFIG_VERSION ?=3D "6.1.y-cip"<br /><br />SRC_URI +=3D =
" \<br />- <a href=3D"https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-" =
target=3D"_blank" rel=3D"noopener">https://cdn.kernel.org/pub/linux/kernel/=
v6.x/linux-</a>${ARCHIVE_VERSION}.tar.xz \<br />- file://squashfs.cfg"<br /=
>+ <a href=3D"https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-" target=
=3D"_blank" rel=3D"noopener">https://cdn.kernel.org/pub/linux/kernel/v6.x/l=
inux-</a>${ARCHIVE_VERSION}.tar.xz"<br /><br />SRC_URI[sha256sum] =3D "2c16=
dfe2168a2e64ac0d55a12d625ebfb963818bb48b60c1868c7c460644c4fd"</blockquote>
If you don't mind, I'll fold that into [1] and send it as v2.</blockquote>
&nbsp; &nbsp; &nbsp;Sure jan, Please send v2.<br />
<blockquote><br />Jan<br /><br />[1]<br /><a href=3D"https://lore.kernel.or=
g/cip-dev/f1be8d8c-d58d-715f-b6c0-39d76826450e@siemens.com/T/#u" target=3D"=
_blank" rel=3D"noopener">https://lore.kernel.org/cip-dev/f1be8d8c-d58d-715f=
-b6c0-39d76826450e@siemens.com/T/#u</a><br /><br />-- <br />Siemens AG, Tec=
hnology<br />Competence Center Embedded Linux</blockquote>

--bOYTzdSGudehieYtXOl7--


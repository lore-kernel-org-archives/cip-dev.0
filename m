Return-Path: <srinuvasan_a@mentor.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D88C77B7A
	for <webhook@archiver.kernel.org>; Wed, 17 May 2023 14:00:20 +0000 (UTC)
Subject: Re: [isar-cip-core][PATCH] recipes-kernel/linux: Update cip-kernels to latest one
To: cip-dev@lists.cip-project.org
From: "Srinuvasan A" <srinuvasan_a@mentor.com>
X-Originating-Location: US (139.181.36.34)
X-Originating-Platform: Windows Chrome 113
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Wed, 17 May 2023 07:00:12 -0700
References: <20230517134206.1517172-1-srinuvasan_a@mentor.com>
In-Reply-To: <20230517134206.1517172-1-srinuvasan_a@mentor.com>
Message-ID: <22447.1684332012438821010@lists.cip-project.org>
Content-Type: multipart/alternative; boundary="odOFaJIU4WuV8C17ZyrN"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 May 2023 14:00:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11496

--odOFaJIU4WuV8C17ZyrN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 17, 2023 at 07:12 PM, Srinuvasan A wrote:

>=20
> From: Srinuvasan A <srinuvasan.a@siemens.com>
>=20
> Update cip-kernels to latest one.
>=20
> Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
> ---
> ...{linux-cip_4.19.280-cip96.bb =3D> linux-cip_4.19.282-cip97.bb} | 2 +-
> .../{linux-cip_4.4.302-cip74.bb =3D> linux-cip_4.4.302-cip75.bb} | 2 +-
> ...{linux-cip_5.10.177-cip31.bb =3D> linux-cip_5.10.179-cip32.bb} | 2 +-
> 3 files changed, 3 insertions(+), 3 deletions(-)
> rename recipes-kernel/linux/{linux-cip_4.19.280-cip96.bb =3D>
> linux-cip_4.19.282-cip97.bb} (72%)
> rename recipes-kernel/linux/{linux-cip_4.4.302-cip74.bb =3D>
> linux-cip_4.4.302-cip75.bb} (72%)
> rename recipes-kernel/linux/{linux-cip_5.10.177-cip31.bb =3D>
> linux-cip_5.10.179-cip32.bb} (72%)
>=20
> diff --git a/recipes-kernel/linux/linux-cip_4.19.280-cip96.bb
> b/recipes-kernel/linux/linux-cip_4.19.282-cip97.bb
> similarity index 72%
> rename from recipes-kernel/linux/linux-cip_4.19.280-cip96.bb
> rename to recipes-kernel/linux/linux-cip_4.19.282-cip97.bb
> index 0a1af14..5fbe92d 100644
> --- a/recipes-kernel/linux/linux-cip_4.19.280-cip96.bb
> +++ b/recipes-kernel/linux/linux-cip_4.19.282-cip97.bb
> @@ -13,4 +13,4 @@ require linux-cip-common.inc
>=20
> KERNEL_DEFCONFIG_VERSION ?=3D "4.19.y-cip"
>=20
> -SRC_URI[sha256sum] =3D
> "30f092e20799b9797376ee40d14995fd31a68773dff0b4913d4bbe5848cab5f6"
> +SRC_URI[sha256sum] =3D
> "aeefefeea208364ee091950b1bc7d088d3769bce3bd5dc4397423641993cd2a0"
> diff --git a/recipes-kernel/linux/linux-cip_4.4.302-cip74.bb
> b/recipes-kernel/linux/linux-cip_4.4.302-cip75.bb
> similarity index 72%
> rename from recipes-kernel/linux/linux-cip_4.4.302-cip74.bb
> rename to recipes-kernel/linux/linux-cip_4.4.302-cip75.bb
> index 4b6a548..4be6e36 100644
> --- a/recipes-kernel/linux/linux-cip_4.4.302-cip74.bb
> +++ b/recipes-kernel/linux/linux-cip_4.4.302-cip75.bb
> @@ -13,4 +13,4 @@ require linux-cip-common.inc
>=20
> KERNEL_DEFCONFIG_VERSION ?=3D "4.4.y-cip"
>=20
> -SRC_URI[sha256sum] =3D
> "0758c47f454d51fa80e3c63aac919d04ab4e6dc1a6ef8c34807e1e180d44d9d4"
> +SRC_URI[sha256sum] =3D
> "1a606abebcf83aade421f0600c088cd94c3844fe6866d312d86b3fb1591b82bd"
> diff --git a/recipes-kernel/linux/linux-cip_5.10.177-cip31.bb
> b/recipes-kernel/linux/linux-cip_5.10.179-cip32.bb
> similarity index 72%
> rename from recipes-kernel/linux/linux-cip_5.10.177-cip31.bb
> rename to recipes-kernel/linux/linux-cip_5.10.179-cip32.bb
> index 08bc8ad..ff55f9e 100644
> --- a/recipes-kernel/linux/linux-cip_5.10.177-cip31.bb
> +++ b/recipes-kernel/linux/linux-cip_5.10.179-cip32.bb
> @@ -13,4 +13,4 @@ require linux-cip-common.inc
>=20
> KERNEL_DEFCONFIG_VERSION ?=3D "5.10.y-cip"
>=20
> -SRC_URI[sha256sum] =3D
> "7a53197c1bd26c3c2dbcea0d93d287900dc3e0d92199ef13702e5bf78ae97f56"
> +SRC_URI[sha256sum] =3D
> "0688c26a0d8c1d425844ada9f42bbb5e8efb18b93b8cb6a823c587e12381fb8e"
> --
> 2.34.1

Sorry, CI getting failed, will check and send v2.

--odOFaJIU4WuV8C17ZyrN
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 17, 2023 at 07:12 PM, Srinuvasan A wrote:<br />
<blockquote>From: Srinuvasan A &lt;srinuvasan.a@siemens.com&gt;<br /><br />=
Update cip-kernels to latest one.<br /><br />Signed-off-by: Srinuvasan A &l=
t;srinuvasan.a@siemens.com&gt;<br />---<br />...{linux-cip_4.19.280-cip96.b=
b =3D&gt; linux-cip_4.19.282-cip97.bb} | 2 +-<br />.../{linux-cip_4.4.302-c=
ip74.bb =3D&gt; linux-cip_4.4.302-cip75.bb} | 2 +-<br />...{linux-cip_5.10.=
177-cip31.bb =3D&gt; linux-cip_5.10.179-cip32.bb} | 2 +-<br />3 files chang=
ed, 3 insertions(+), 3 deletions(-)<br />rename recipes-kernel/linux/{linux=
-cip_4.19.280-cip96.bb =3D&gt; linux-cip_4.19.282-cip97.bb} (72%)<br />rena=
me recipes-kernel/linux/{linux-cip_4.4.302-cip74.bb =3D&gt; linux-cip_4.4.3=
02-cip75.bb} (72%)<br />rename recipes-kernel/linux/{linux-cip_5.10.177-cip=
31.bb =3D&gt; linux-cip_5.10.179-cip32.bb} (72%)<br /><br />diff --git a/re=
cipes-kernel/linux/linux-cip_4.19.280-cip96.bb b/recipes-kernel/linux/linux=
-cip_4.19.282-cip97.bb<br />similarity index 72%<br />rename from recipes-k=
ernel/linux/linux-cip_4.19.280-cip96.bb<br />rename to recipes-kernel/linux=
/linux-cip_4.19.282-cip97.bb<br />index 0a1af14..5fbe92d 100644<br />--- a/=
recipes-kernel/linux/linux-cip_4.19.280-cip96.bb<br />+++ b/recipes-kernel/=
linux/linux-cip_4.19.282-cip97.bb<br />@@ -13,4 +13,4 @@ require linux-cip-=
common.inc<br /><br />KERNEL_DEFCONFIG_VERSION ?=3D "4.19.y-cip"<br /><br /=
>-SRC_URI[sha256sum] =3D "30f092e20799b9797376ee40d14995fd31a68773dff0b4913=
d4bbe5848cab5f6"<br />+SRC_URI[sha256sum] =3D "aeefefeea208364ee091950b1bc7=
d088d3769bce3bd5dc4397423641993cd2a0"<br />diff --git a/recipes-kernel/linu=
x/linux-cip_4.4.302-cip74.bb b/recipes-kernel/linux/linux-cip_4.4.302-cip75=
.bb<br />similarity index 72%<br />rename from recipes-kernel/linux/linux-c=
ip_4.4.302-cip74.bb<br />rename to recipes-kernel/linux/linux-cip_4.4.302-c=
ip75.bb<br />index 4b6a548..4be6e36 100644<br />--- a/recipes-kernel/linux/=
linux-cip_4.4.302-cip74.bb<br />+++ b/recipes-kernel/linux/linux-cip_4.4.30=
2-cip75.bb<br />@@ -13,4 +13,4 @@ require linux-cip-common.inc<br /><br />K=
ERNEL_DEFCONFIG_VERSION ?=3D "4.4.y-cip"<br /><br />-SRC_URI[sha256sum] =3D=
 "0758c47f454d51fa80e3c63aac919d04ab4e6dc1a6ef8c34807e1e180d44d9d4"<br />+S=
RC_URI[sha256sum] =3D "1a606abebcf83aade421f0600c088cd94c3844fe6866d312d86b=
3fb1591b82bd"<br />diff --git a/recipes-kernel/linux/linux-cip_5.10.177-cip=
31.bb b/recipes-kernel/linux/linux-cip_5.10.179-cip32.bb<br />similarity in=
dex 72%<br />rename from recipes-kernel/linux/linux-cip_5.10.177-cip31.bb<b=
r />rename to recipes-kernel/linux/linux-cip_5.10.179-cip32.bb<br />index 0=
8bc8ad..ff55f9e 100644<br />--- a/recipes-kernel/linux/linux-cip_5.10.177-c=
ip31.bb<br />+++ b/recipes-kernel/linux/linux-cip_5.10.179-cip32.bb<br />@@=
 -13,4 +13,4 @@ require linux-cip-common.inc<br /><br />KERNEL_DEFCONFIG_VE=
RSION ?=3D "5.10.y-cip"<br /><br />-SRC_URI[sha256sum] =3D "7a53197c1bd26c3=
c2dbcea0d93d287900dc3e0d92199ef13702e5bf78ae97f56"<br />+SRC_URI[sha256sum]=
 =3D "0688c26a0d8c1d425844ada9f42bbb5e8efb18b93b8cb6a823c587e12381fb8e"<br =
/>-- <br />2.34.1</blockquote>
Sorry, CI getting failed, will check and send v2.

--odOFaJIU4WuV8C17ZyrN--


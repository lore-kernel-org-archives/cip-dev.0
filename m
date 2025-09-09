Return-Path: <david.kauschke.ext@zeiss.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 380A1CA0FED
	for <webhook@archiver.kernel.org>; Tue,  9 Sep 2025 07:45:02 +0000 (UTC)
Subject: =?UTF-8?B?W2lzYXItY2lwLWNvcmVdW1BBVENIXSBpbml0cmFtZnMtY3J5cHQtaG9vazogYWRkIHRwbV90aXNfc3BpIG1vZHVsZSDCoHN1cHBvcnQ=?=
To: cip-dev@lists.cip-project.org
From: david.kauschke.ext@zeiss.com
X-Originating-Location: North Rhine-Westphalia, DE (145.253.133.129)
X-Originating-Platform: Linux Firefox 142
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Tue, 09 Sep 2025 00:44:55 -0700
Message-ID: <UQTq.1757403895402017236.iyck@lists.cip-project.org>
Content-Type: multipart/alternative; boundary="0TisgWuvksIuaoD0kyED"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 09 Sep 2025 07:45:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20023

--0TisgWuvksIuaoD0kyED
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello Jan, hello Quirin,

this patch provides TPM SPI support in the initramfs.

Best regards,
David

From ae2d177c83ad9384b287e7cd9b6de3fa5c637ef3 Mon Sep 17 00:00:00 2001
From: David Kauschke <david.kauschke.ext@zeiss.com>
Date: Tue, 9 Sep 2025 07:07:43 +0000
Subject: [isar-cip-core][PATCH] initramfs-crypt-hook: add tpm_tis_spi modul=
e
support
The initramfs crypt hook currently loads tpm_tis and tpm_crb but not
tpm_tis_spi. On systems where TPM is connected over SPI, such as with
the Infineon OPTIGA TPM SLB 9672, the absence of this module prevents
TPM initialization during early boot.
Signed-off-by: David Kauschke <david.kauschke.ext@zeiss.com>
---
recipes-initramfs/initramfs-crypt-hook/files/local-top-complete | 1 +
.../initramfs-crypt-hook/initramfs-crypt-hook_0.9.bb =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0| 2 +-
2 files changed, 2 insertions(+), 1 deletion(-)
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complet=
e b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
index 0d42bd4..664124d 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
+++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
@@ -42,6 +42,7 @@ esac

# load necessary kernel modules:
modprobe tpm_tis
+modprobe tpm_tis_spi
modprobe tpm_crb

modprobe ecb
diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.=
9.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.9.bb
index e2d55f9..e107575 100644
--- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.9.bb
+++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.9.bb
@@ -39,7 +39,7 @@ DEBIAN_DEPENDS:append:systemd:trixie =3D ", systemd-crypt=
setup"
DEBIAN_DEPENDS:append:systemd =3D ", systemd (>=3D 251)"

HOOK_ADD_MODULES =3D " \
- =C2=A0 =C2=A0tpm tpm_tis_core tpm_tis tpm_crb dm_mod dm_crypt \
+ =C2=A0 =C2=A0tpm tpm_tis_core tpm_tis tpm_tis_spi tpm_crb dm_mod dm_crypt=
 \
ecb aes_generic xts"

HOOK_COPY_EXECS =3D " \
--
2.43.0

--0TisgWuvksIuaoD0kyED
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>
<div>
<div>Hello Jan, hello Quirin,</div>
<div>&nbsp;</div>
<div>this patch provides TPM SPI support in the initramfs.</div>
<div>&nbsp;</div>
<div>Best regards,</div>
<div>David</div>
<div>&nbsp;</div>
</div>
<div>&nbsp;</div>
<div>From ae2d177c83ad9384b287e7cd9b6de3fa5c637ef3 Mon Sep 17 00:00:00 2001=
<br />From: David Kauschke &lt;david.kauschke.ext@zeiss.com&gt;<br />Date: =
Tue, 9 Sep 2025 07:07:43 +0000<br />Subject: [isar-cip-core][PATCH] initram=
fs-crypt-hook: add tpm_tis_spi module<br />&nbsp;support</div>
<div>The initramfs crypt hook currently loads tpm_tis and tpm_crb but not<b=
r />tpm_tis_spi. On systems where TPM is connected over SPI, such as with<b=
r />the Infineon OPTIGA TPM SLB 9672, the absence of this module prevents<b=
r />TPM initialization during early boot.</div>
<div>Signed-off-by: David Kauschke &lt;david.kauschke.ext@zeiss.com&gt;<br =
/>---<br />&nbsp;recipes-initramfs/initramfs-crypt-hook/files/local-top-com=
plete | 1 +<br />&nbsp;.../initramfs-crypt-hook/initramfs-crypt-hook_0.9.bb=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;| 2 +-<br />&nbsp;2 files changed=
, 2 insertions(+), 1 deletion(-)</div>
<div>diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-co=
mplete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete<br=
 />index 0d42bd4..664124d 100644<br />--- a/recipes-initramfs/initramfs-cry=
pt-hook/files/local-top-complete<br />+++ b/recipes-initramfs/initramfs-cry=
pt-hook/files/local-top-complete<br />@@ -42,6 +42,7 @@ esac<br />&nbsp;<br=
 />&nbsp;# load necessary kernel modules:<br />&nbsp;modprobe tpm_tis<br />=
+modprobe tpm_tis_spi<br />&nbsp;modprobe tpm_crb<br />&nbsp;<br />&nbsp;mo=
dprobe ecb<br />diff --git a/recipes-initramfs/initramfs-crypt-hook/initram=
fs-crypt-hook_0.9.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-cry=
pt-hook_0.9.bb<br />index e2d55f9..e107575 100644<br />--- a/recipes-initra=
mfs/initramfs-crypt-hook/initramfs-crypt-hook_0.9.bb<br />+++ b/recipes-ini=
tramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.9.bb<br />@@ -39,7 +39,7=
 @@ DEBIAN_DEPENDS:append:systemd:trixie =3D ", systemd-cryptsetup"<br />&n=
bsp;DEBIAN_DEPENDS:append:systemd =3D ", systemd (&gt;=3D 251)"<br />&nbsp;=
<br />&nbsp;HOOK_ADD_MODULES =3D " \<br />- &nbsp; &nbsp;tpm tpm_tis_core t=
pm_tis tpm_crb dm_mod dm_crypt \<br />+ &nbsp; &nbsp;tpm tpm_tis_core tpm_t=
is tpm_tis_spi tpm_crb dm_mod dm_crypt \<br />&nbsp; &nbsp; &nbsp;ecb aes_g=
eneric xts"<br />&nbsp;<br />&nbsp;HOOK_COPY_EXECS =3D " \<br />--&nbsp;<br=
 />2.43.0</div>
<div>&nbsp;</div>
</div>

--0TisgWuvksIuaoD0kyED--


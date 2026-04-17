Return-Path: <sari.sercan@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6876F8E4BB
	for <webhook@archiver.kernel.org>; Fri, 17 Apr 2026 07:49:44 +0000 (UTC)
Subject: Re: [isar-cip-core][PATCH] encrypt_partition: evict stale systemd SRK handle before enrollment
To: cip-dev@lists.cip-project.org
From: sari.sercan@siemens.com
X-Originating-Location: Vienna, AT (165.225.200.167)
X-Originating-Platform: Windows Edge 100
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Fri, 17 Apr 2026 00:49:37 -0700
References: <DB9PR10MB6643CE84D750B5014B3606DCF05DA@DB9PR10MB6643.EURPRD10.PROD.OUTLOOK.COM> <9171aea6-f54d-401f-8fcd-92a902b3ec16@siemens.com>
In-Reply-To: <9171aea6-f54d-401f-8fcd-92a902b3ec16@siemens.com>
Message-ID: <1451444.1776412177481084098@lists.cip-project.org>
Content-Type: multipart/alternative; boundary="I0JlqmXeCWSH7WfkfK6E"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Apr 2026 07:49:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22759

--I0JlqmXeCWSH7WfkfK6E
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16, 2026 at 05:30 PM, Jan Kiszka wrote:

>=20
> On 06.04.26 15:39, Sari, Sercan wrote:
>=20
>> systemd-cryptenroll persists its TPM2 SRK at handle 0x81000001
>=20
> Is that handle number officially documented? Or was it retrieved from
> the code?

Yes, officially documented in man page.

>=20
>=20
>> evict any stale handle before enrollment to avoid
>> "Failed to seal to TPM2: State not recoverable".
>>=20
>> Signed-off-by: Sercan Sari <sari.sercan@...>
>> ---
>> .../files/encrypt_partition.systemd.script | 5 +++++
>> 1 file changed, 5 insertions(+)
>>=20
>> diff --git
>> a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd=
.script
>> b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd=
.script
>>=20
>> index 1b7c83b..841219c 100644
>> ---
>> a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd=
.script
>>=20
>> +++
>> b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd=
.script
>>=20
>> @@ -26,6 +26,11 @@ enroll_tpm2_token() {
>> #tpm_key_algorithm=3D"$4"
>> #pcr_bank_hash_type=3D"$5"
>>=20
>> + # systemd-cryptenroll persists its TPM2 SRK at handle 0x81000001
>> + # evict any stale handle before enrollment to avoid
>> + # "Failed to seal to TPM2: State not recoverable".
>> + tpm2_evictcontrol -C o -c 0x81000001 2>/dev/null || true
>=20
> "|| true" is always a bit fragile and bad for debugging. Can't we test
> for the handle first and actually fail if eviction is then not successful=
?

Agreed, better to look at with tpm2_getcap first, then evict.

--I0JlqmXeCWSH7WfkfK6E
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>On Thu, Apr 16, 2026 at 05:30 PM, Jan Kiszka wrote:</div>
<div>
<blockquote>On 06.04.26 15:39, Sari, Sercan wrote:<br />
<blockquote>systemd-cryptenroll persists its TPM2 SRK at handle 0x81000001<=
/blockquote>
Is that handle number officially documented? Or was it retrieved from<br />=
the code?</blockquote>
Yes, officially documented in man page.<br />
<blockquote>
<blockquote>evict any stale handle before enrollment to avoid<br />"Failed =
to seal to TPM2: State not recoverable".<br /><br />Signed-off-by: Sercan S=
ari &lt;sari.sercan@...&gt;<br />---<br />.../files/encrypt_partition.syste=
md.script | 5 +++++<br />1 file changed, 5 insertions(+)<br /><br />diff --=
git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.system=
d.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.s=
ystemd.script<br />index 1b7c83b..841219c 100644<br />--- a/recipes-initram=
fs/initramfs-crypt-hook/files/encrypt_partition.systemd.script<br />+++ b/r=
ecipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.scrip=
t<br />@@ -26,6 +26,11 @@ enroll_tpm2_token() {<br />#tpm_key_algorithm=3D"=
$4"<br />#pcr_bank_hash_type=3D"$5"<br /><br />+ # systemd-cryptenroll pers=
ists its TPM2 SRK at handle 0x81000001<br />+ # evict any stale handle befo=
re enrollment to avoid<br />+ # "Failed to seal to TPM2: State not recovera=
ble".<br />+ tpm2_evictcontrol -C o -c 0x81000001 2&gt;/dev/null || true</b=
lockquote>
"|| true" is always a bit fragile and bad for debugging. Can't we test<br /=
>for the handle first and actually fail if eviction is then not successful?=
</blockquote>
Agreed, better to look at with tpm2_getcap first, then evict.&nbsp;</div>

--I0JlqmXeCWSH7WfkfK6E--


Return-Path: <sari.sercan@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6521BF94CD3
	for <webhook@archiver.kernel.org>; Wed, 22 Apr 2026 06:45:30 +0000 (UTC)
Subject: Re: [isar-cip-core][PATCH] tpm2_functions: verify PCR bank output instead of relying on quiet mode
To: cip-dev@lists.cip-project.org
From: "Sercan Sari" <sari.sercan@siemens.com>
X-Originating-Location: Vienna, AT (165.225.200.182)
X-Originating-Platform: Windows Edge 147
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Tue, 21 Apr 2026 23:45:28 -0700
References: <20260421121344.3747040-1-sari.sercan@siemens.com> <a610ab8a-dfb5-471f-b7e6-57638fff52e0@siemens.com>
In-Reply-To: <a610ab8a-dfb5-471f-b7e6-57638fff52e0@siemens.com>
Message-ID: <1534696.1776840328665594382@lists.cip-project.org>
Content-Type: multipart/alternative; boundary="ZiL9cbFzx5oIhpPox72C"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Apr 2026 06:45:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22781

--ZiL9cbFzx5oIhpPox72C
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 04:27 PM, Jan Kiszka wrote:

>=20
> On 21.04.26 14:13, Sercan Sari wrote:
>=20
>> tpm2_pcrread --quiet can return 0 when the configured PCR bank
>> is not usable on the device. This causes tpm2_check_device()
>> to incorrectly select the TPM device, encryption failures
>> when encryption is optional.
>>=20
>> remove --quiet and verify actual PCR data is present in the output
>> via grep. If the bank is not available, the device is correctly
>> skipped and optional encryption exits gracefully.
>>=20
>> Signed-off-by: Sercan Sari <sari.sercan@siemens.com>
>> ---
>> recipes-initramfs/initramfs-crypt-hook/files/tpm2_functions | 3 ++-
>> 1 file changed, 2 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/tpm2_functions
>> b/recipes-initramfs/initramfs-crypt-hook/files/tpm2_functions
>> index 54d43f3..1c6bbff 100644
>> --- a/recipes-initramfs/initramfs-crypt-hook/files/tpm2_functions
>> +++ b/recipes-initramfs/initramfs-crypt-hook/files/tpm2_functions
>> @@ -11,7 +11,8 @@
>> # SPDX-License-Identifier: MIT
>>=20
>> tpm2_check_device() {
>> - tpm2_pcrread -T device:"$1" "$pcr_bank_hash_type":7 --quiet 2>/dev/nul=
l
>> &&
>> + tpm2_pcrread -T device:"$1" "$pcr_bank_hash_type":7 2>/dev/null \
>> + | grep -qv "$pcr_bank_hash_type" &&
>> tpm2_testparms -T device:"$1" "$tpm_key_algorithm" --quiet 2>/dev/null
>> }
>=20
> Hmm, nasty. Is this unexpected behaviour of the tpm-tools limited to
> specific versions of it? Did you report an issue upstream about this?
>=20
> Jan

This seems like a design choice. tpm2_pcrread reads and returns the TPM's r=
esponse.
It does not consider the functionality of the bank depending on its digest.=
 It'd be more of a feature request but seems worth to give a shot.

--ZiL9cbFzx5oIhpPox72C
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>On Tue, Apr 21, 2026 at 04:27 PM, Jan Kiszka wrote:</div>
<div>
<blockquote>On 21.04.26 14:13, Sercan Sari wrote:<br />
<blockquote>tpm2_pcrread --quiet can return 0 when the configured PCR bank<=
br />is not usable on the device. This causes tpm2_check_device() <br />to =
incorrectly select the TPM device, encryption failures <br />when encryptio=
n is optional.<br /><br />remove --quiet and verify actual PCR data is pres=
ent in the output<br />via grep. If the bank is not available, the device i=
s correctly<br />skipped and optional encryption exits gracefully.<br /><br=
 />Signed-off-by: Sercan Sari &lt;sari.sercan@siemens.com&gt;<br />---<br /=
>recipes-initramfs/initramfs-crypt-hook/files/tpm2_functions | 3 ++-<br />1=
 file changed, 2 insertions(+), 1 deletion(-)<br /><br />diff --git a/recip=
es-initramfs/initramfs-crypt-hook/files/tpm2_functions b/recipes-initramfs/=
initramfs-crypt-hook/files/tpm2_functions<br />index 54d43f3..1c6bbff 10064=
4<br />--- a/recipes-initramfs/initramfs-crypt-hook/files/tpm2_functions<br=
 />+++ b/recipes-initramfs/initramfs-crypt-hook/files/tpm2_functions<br />@=
@ -11,7 +11,8 @@<br /># SPDX-License-Identifier: MIT<br /><br />tpm2_check_=
device() {<br />- tpm2_pcrread -T device:"$1" "$pcr_bank_hash_type":7 --qui=
et 2&gt;/dev/null &amp;&amp;<br />+ tpm2_pcrread -T device:"$1" "$pcr_bank_=
hash_type":7 2&gt;/dev/null \<br />+ | grep -qv "$pcr_bank_hash_type" &amp;=
&amp;<br />tpm2_testparms -T device:"$1" "$tpm_key_algorithm" --quiet 2&gt;=
/dev/null<br />}</blockquote>
Hmm, nasty. Is this unexpected behaviour of the tpm-tools limited to<br />s=
pecific versions of it? Did you report an issue upstream about this?<br /><=
br />Jan</blockquote>
This seems like a design choice. tpm2_pcrread reads and returns the TPM's r=
esponse.</div>
<div>It does not consider the functionality of the bank depending on its di=
gest. It'd be more of a feature request but seems worth to give a shot.</di=
v>

--ZiL9cbFzx5oIhpPox72C--


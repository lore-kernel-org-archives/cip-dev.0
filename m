Return-Path: <sari.sercan@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 949BACA5FFC
	for <webhook@archiver.kernel.org>; Wed,  7 Oct 2026 12:01:35 +0000 (UTC)
Subject: Re: [PATCH] initramfs-crypt-hook: emit TPM DA lockout metric
To: cip-dev@lists.cip-project.org
From: "Sercan Sari" <sari.sercan@siemens.com>
X-Originating-Location: Vienna, AT (165.225.200.167)
X-Originating-Platform: Windows Edge 154
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Wed, 07 Oct 2026 05:01:29 -0700
References: <20260928133951.3500729-1-sari.sercan@siemens.com> <62c6208d-da8b-4069-b8ba-c272c9604b93@siemens.com>
In-Reply-To: <62c6208d-da8b-4069-b8ba-c272c9604b93@siemens.com>
Message-ID: <1485199.1791373977131958423@lists.cip-project.org>
X-Old-Date: Wed, 07 Oct 2026 04:52:57 -0700
Content-Type: multipart/alternative; boundary="cDMciMQWLXDHaMK769lc"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Oct 2026 12:01:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24435
Message-ID: <20261007120129.Yv9HhVFB9UhVdvxgs8Y4ptKTKotAGBbNjlhj7yCHYaY@z>

--cDMciMQWLXDHaMK769lc
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026 at 10:39 AM, Jan Kiszka wrote:

>=20
> On 28.09.26 15:39, Sercan Sari wrote:
>=20
>> The TPM dictionary-attack (DA) lockout counter increments on unclean
>> shutdowns and failed unlock attempts, and eventually locks the TPM.
>> Its trajectory cannot be observed from the running system without
>> querying the TPM again.
>>=20
>> Emit the DA counters (lockoutCounter, maxAuthFail, lockoutInterval,
>> inLockout) as a single 'tpm-da:' key=3Dvalue line to /dev/kmsg after eac=
h
>> unlock attempt, so a rootfs service can track them via journald without
>> touching the TPM. The metric is emitted on both the success and the
>> failure path, so a lockout is still reported before the hook panics. A
>> multi-partition device emits the line once per unlocked partition; the
>> values are identical, as the DA state is global.
>=20
> Do we really need the output, including redundant ones, in all success
> paths? Why not limit it to the less common case the lockout counter is
> non-zero? And please de-duplicate outputs for the same TPM device.
>=20
>=20
>> Signed-off-by: Sercan Sari <sari.sercan@siemens.com>
>> ---
>> .../files/encrypt_partition.clevis.script | 2 ++
>> .../files/encrypt_partition.systemd.script | 2 ++
>> .../initramfs-crypt-hook/files/tpm2_functions | 23 +++++++++++++++++++
>> .../files/tpm2_functions.buster | 5 ++++
>> 4 files changed, 32 insertions(+)
>>=20
>> diff --git
>> a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.=
script
>> b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.=
script
>>=20
>> index ceeacd1..e473dfb 100644
>> ---
>> a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.=
script
>>=20
>> +++
>> b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.=
script
>>=20
>> @@ -16,8 +16,10 @@ open_tpm2_partition() {
>> tpm_device=3D"$3"
>> if ! TPM2TOOLS_TCTI=3D"device:$tpm_device" usr/bin/clevis luks unlock -n
>> "$crypt_mount_name" \
>> -d "$partition_device"; then
>> + tpm2_report_da_metric
>> panic "Can't decrypt '$partition_device' !"
>> fi
>> + tpm2_report_da_metric
>> }
>>=20
>> enroll_tpm2_token() {
>> diff --git
>> a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd=
.script
>> b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd=
.script
>>=20
>> index 94346a8..40eeb4d 100644
>> ---
>> a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd=
.script
>>=20
>> +++
>> b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd=
.script
>>=20
>> @@ -15,8 +15,10 @@ open_tpm2_partition() {
>> tpm_device=3D"$3"
>> if ! /usr/lib/systemd/systemd-cryptsetup attach "$crypt_mount_name" \
>> "$partition_device" - tpm2-device=3D"$tpm_device"; then
>> + tpm2_report_da_metric
>> panic "Can't decrypt '$partition_device' !"
>> fi
>> + tpm2_report_da_metric
>> }
>>=20
>> enroll_tpm2_token() {
>> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/tpm2_functions
>> b/recipes-initramfs/initramfs-crypt-hook/files/tpm2_functions
>> index 1c6bbff..20ece43 100644
>> --- a/recipes-initramfs/initramfs-crypt-hook/files/tpm2_functions
>> +++ b/recipes-initramfs/initramfs-crypt-hook/files/tpm2_functions
>> @@ -65,3 +65,26 @@ tpm2_key_get() {
>> tpm2_key_del() {
>> tpm2_evictcontrol -C o -c "$TPM2_HANDLE"
>> }
>> +
>> +# Extract a TPM2_PT_<name> property value from "$da"
>=20
> Please make $da a parameter, not a global variable.
>=20
>=20
>> +tpm2_da_prop() {
>> + echo "$da" | awk -v k=3D"TPM2_PT_$1:" '
>> + $1 =3D=3D k { if (NF > 1) { print $NF; exit } f =3D 1; next }
>> + f && /0x/ { print $NF; exit }'
>> +}
>> +
>> +# Read the dictionary-attack counters into globals.
>> +tpm2_read_da() {
>> + da=3D"$(tpm2_getcap -T "device:${tpm_device}" properties-variable
>> 2>/dev/null)"
>> + da_counter=3D"$(tpm2_da_prop LOCKOUT_COUNTER)"
>> + da_maxfail=3D"$(tpm2_da_prop MAX_AUTH_FAIL)"
>> + da_interval=3D"$(tpm2_da_prop LOCKOUT_INTERVAL)"
>> + da_inlockout=3D"$(echo "$da" | sed -n
>> 's/.*inLockout:[[:space:]]*\([0-9]\).*/\1/p')"
>> +}
>=20
> This can be folded into the caller.
>=20
>=20

Thanks, v2 has been sent to address the comments.

--cDMciMQWLXDHaMK769lc
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div>
<div>On Tue, Sep 29, 2026 at 10:39 AM, Jan Kiszka wrote:</div>
<div>
<blockquote>On 28.09.26 15:39, Sercan Sari wrote:<br />
<blockquote>The TPM dictionary-attack (DA) lockout counter increments on un=
clean<br />shutdowns and failed unlock attempts, and eventually locks the T=
PM.<br />Its trajectory cannot be observed from the running system without<=
br />querying the TPM again.<br /><br />Emit the DA counters (lockoutCounte=
r, maxAuthFail, lockoutInterval,<br />inLockout) as a single 'tpm-da:' key=
=3Dvalue line to /dev/kmsg after each<br />unlock attempt, so a rootfs serv=
ice can track them via journald without<br />touching the TPM. The metric i=
s emitted on both the success and the<br />failure path, so a lockout is st=
ill reported before the hook panics. A<br />multi-partition device emits th=
e line once per unlocked partition; the<br />values are identical, as the D=
A state is global.</blockquote>
Do we really need the output, including redundant ones, in all success<br /=
>paths? Why not limit it to the less common case the lockout counter is<br =
/>non-zero? And please de-duplicate outputs for the same TPM device.<br /><=
br />
<blockquote>Signed-off-by: Sercan Sari &lt;sari.sercan@siemens.com&gt;<br /=
>---<br />.../files/encrypt_partition.clevis.script | 2 ++<br />.../files/e=
ncrypt_partition.systemd.script | 2 ++<br />.../initramfs-crypt-hook/files/=
tpm2_functions | 23 +++++++++++++++++++<br />.../files/tpm2_functions.buste=
r | 5 ++++<br />4 files changed, 32 insertions(+)<br /><br />diff --git a/r=
ecipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script=
 b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.sc=
ript<br />index ceeacd1..e473dfb 100644<br />--- a/recipes-initramfs/initra=
mfs-crypt-hook/files/encrypt_partition.clevis.script<br />+++ b/recipes-ini=
tramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script<br />@@ -=
16,8 +16,10 @@ open_tpm2_partition() {<br />tpm_device=3D"$3"<br />if ! TPM=
2TOOLS_TCTI=3D"device:$tpm_device" usr/bin/clevis luks unlock -n "$crypt_mo=
unt_name" \<br />-d "$partition_device"; then<br />+ tpm2_report_da_metric<=
br />panic "Can't decrypt '$partition_device' !"<br />fi<br />+ tpm2_report=
_da_metric<br />}<br /><br />enroll_tpm2_token() {<br />diff --git a/recipe=
s-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script b/r=
ecipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.scrip=
t<br />index 94346a8..40eeb4d 100644<br />--- a/recipes-initramfs/initramfs=
-crypt-hook/files/encrypt_partition.systemd.script<br />+++ b/recipes-initr=
amfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script<br />@@ -1=
5,8 +15,10 @@ open_tpm2_partition() {<br />tpm_device=3D"$3"<br />if ! /usr=
/lib/systemd/systemd-cryptsetup attach "$crypt_mount_name" \<br />"$partiti=
on_device" - tpm2-device=3D"$tpm_device"; then<br />+ tpm2_report_da_metric=
<br />panic "Can't decrypt '$partition_device' !"<br />fi<br />+ tpm2_repor=
t_da_metric<br />}<br /><br />enroll_tpm2_token() {<br />diff --git a/recip=
es-initramfs/initramfs-crypt-hook/files/tpm2_functions b/recipes-initramfs/=
initramfs-crypt-hook/files/tpm2_functions<br />index 1c6bbff..20ece43 10064=
4<br />--- a/recipes-initramfs/initramfs-crypt-hook/files/tpm2_functions<br=
 />+++ b/recipes-initramfs/initramfs-crypt-hook/files/tpm2_functions<br />@=
@ -65,3 +65,26 @@ tpm2_key_get() {<br />tpm2_key_del() {<br />tpm2_evictcon=
trol -C o -c "$TPM2_HANDLE"<br />}<br />+<br />+# Extract a TPM2_PT_&lt;nam=
e&gt; property value from "$da"</blockquote>
Please make $da a parameter, not a global variable.<br /><br />
<blockquote>+tpm2_da_prop() {<br />+ echo "$da" | awk -v k=3D"TPM2_PT_$1:" =
'<br />+ $1 =3D=3D k { if (NF &gt; 1) { print $NF; exit } f =3D 1; next }<b=
r />+ f &amp;&amp; /0x/ { print $NF; exit }'<br />+}<br />+<br />+# Read th=
e dictionary-attack counters into globals.<br />+tpm2_read_da() {<br />+ da=
=3D"$(tpm2_getcap -T "device:${tpm_device}" properties-variable 2&gt;/dev/n=
ull)"<br />+ da_counter=3D"$(tpm2_da_prop LOCKOUT_COUNTER)"<br />+ da_maxfa=
il=3D"$(tpm2_da_prop MAX_AUTH_FAIL)"<br />+ da_interval=3D"$(tpm2_da_prop L=
OCKOUT_INTERVAL)"<br />+ da_inlockout=3D"$(echo "$da" | sed -n 's/.*inLocko=
ut:[[:space:]]*\([0-9]\).*/\1/p')"<br />+}</blockquote>
This can be folded into the caller.<br /><br /></blockquote>
</div>
</div>
<div>Thanks, v2 has been sent to address the comments.</div>

--cDMciMQWLXDHaMK769lc--


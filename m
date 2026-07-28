Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0DAC53219
	for <webhook@archiver.kernel.org>; Tue, 28 Jul 2026 04:54:58 +0000 (UTC)
Subject: Re: [isar-cip-core][PATCH v1 1/2] Enable the support of Debian forky based builds
To: cip-dev@lists.cip-project.org
From: "Kunijadar Shivanand" <Shivanand.Kunijadar@toshiba-tsip.com>
X-Originating-Location: Hyderabad, Telangana, IN (151.186.148.44)
X-Originating-Platform: Windows Chrome 150
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Mon, 27 Jul 2026 21:54:50 -0700
References: <20260727141136.1773671-1-Shivanand.Kunijadar@toshiba-tsip.com> <20260727141136.1773671-2-Shivanand.Kunijadar@toshiba-tsip.com> <e7db87cb-3908-4b4e-804f-a6cfd8c2e246@siemens.com>
In-Reply-To: <e7db87cb-3908-4b4e-804f-a6cfd8c2e246@siemens.com>
Message-ID: <1092128.1785214490802252393@lists.cip-project.org>
Content-Type: multipart/alternative; boundary="R8NFs6z3ozuEu5J89ruz"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 Jul 2026 04:54:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23787

--R8NFs6z3ozuEu5J89ruz
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 10:05 AM, Jan Kiszka wrote:

>=20
> On 27.07.26 16:11, Shivanand.Kunijadar@toshiba-tsip.com wrote:
>=20
>> From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
>>=20
>> The .key & .pem files are addded using below .deb package,
>> https://snapshot.debian.org/file/d32d11a5aacbf5685b81e8176a27a6918e9b55f=
b/ovmf-generic_2025.11-5_all.deb
>>=20
>>=20
>> Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com=
>
>> ---
>> Kconfig | 4 +++
>> conf/distro/cip-core-forky.conf | 13 ++++++++
>> kas/opt/forky.yml | 15 ++++++++++
>> .../files/forky/PkKek-1-snakeoil.key | 30 +++++++++++++++++++
>> .../files/forky/PkKek-1-snakeoil.pem | 23 ++++++++++++++
>=20
> So, current sid uses different keys that forky? Is that always the case?

The ovmf package version in both forky & sid are same now[1], so the keys s=
hould be same.
I'll send a separate patch to create symlink to forky for sid keys. please =
note the sid keys were added long back and pointing to trixie.

[1] https://packages.debian.org/sid/ovmf-generic

>=20
>=20
>> .../swupdate-certificates/files/forky | 1 +
>> start-qemu.sh | 2 ++
>> 7 files changed, 88 insertions(+)
>> create mode 100644 conf/distro/cip-core-forky.conf
>> create mode 100644 kas/opt/forky.yml
>> create mode 100644
>> recipes-devtools/secure-boot-secrets/files/forky/PkKek-1-snakeoil.key
>> create mode 100644
>> recipes-devtools/secure-boot-secrets/files/forky/PkKek-1-snakeoil.pem
>> create mode 120000 recipes-devtools/swupdate-certificates/files/forky
>>=20
>> diff --git a/Kconfig b/Kconfig
>> index 438234c..14cd677 100644
>> --- a/Kconfig
>> +++ b/Kconfig
>> @@ -241,6 +241,9 @@ config DEBIAN_TRIXIE
>> config DEBIAN_SID
>> bool "Sid (Unstable)"
>>=20
>> +config DEBIAN_FORKY
>> + bool "forky (14)"
>> +
>=20
> Let's sort forky before sid.

Ok, sure.

>=20
>=20
>> endchoice
>>=20
>> config KAS_INCLUDE_DEBIAN
>> @@ -250,6 +253,7 @@ config KAS_INCLUDE_DEBIAN
>> default "kas/opt/bookworm.yml" if DEBIAN_BOOKWORM
>> default "kas/opt/trixie.yml" if DEBIAN_TRIXIE
>> default "kas/opt/sid.yml" if DEBIAN_SID
>> + default "kas/opt/forky.yml" if DEBIAN_FORKY
>=20
> Here as well.

Ok.

>=20
>=20
>> comment "Image features"
>>=20
>> diff --git a/conf/distro/cip-core-forky.conf
>> b/conf/distro/cip-core-forky.conf
>> new file mode 100644
>> index 0000000..7a868ce
>> --- /dev/null
>> +++ b/conf/distro/cip-core-forky.conf
>> @@ -0,0 +1,13 @@
>> +#
>> +# CIP Core, generic profile
>> +#
>> +# Copyright (c) Toshiba Corporation, 2026
>> +#
>> +# Authors:
>> +# Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +require conf/distro/debian-forky.conf
>> +require cip-core-common.inc
>> diff --git a/kas/opt/forky.yml b/kas/opt/forky.yml
>> new file mode 100644
>> index 0000000..6c4fcdc
>> --- /dev/null
>> +++ b/kas/opt/forky.yml
>> @@ -0,0 +1,15 @@
>> +#
>> +# CIP Core, generic profile
>> +#
>> +# Copyright (c) Toshiba Corporation, 2026
>> +#
>> +# Authors:
>> +# Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +header:
>> + version: 14
>> +
>> +distro: cip-core-forky
>> diff --git
>> a/recipes-devtools/secure-boot-secrets/files/forky/PkKek-1-snakeoil.key
>> b/recipes-devtools/secure-boot-secrets/files/forky/PkKek-1-snakeoil.key
>> new file mode 100644
>> index 0000000..dd7f492
>> --- /dev/null
>> +++
>> b/recipes-devtools/secure-boot-secrets/files/forky/PkKek-1-snakeoil.key
>> @@ -0,0 +1,30 @@
>> +-----BEGIN ENCRYPTED PRIVATE KEY-----
>> +MIIFHDBOBgkqhkiG9w0BBQ0wQTApBgkqhkiG9w0BBQwwHAQIs4RXCLmGLJgCAggA
>> +MAwGCCqGSIb3DQIJBQAwFAYIKoZIhvcNAwcECHer6014IEhGBIIEyO8O2zL8CJwV
>> +auQpWLJsMMWxu2aSh1WadX9+rg+O61mukuS4rQSH5shMQ2krZZKzyXx0q8+2AySD
>> +EtDXwhLvep60gUxOoNqK1+l3AxSFfIGOY8NC6yW67VX+G09ajWpgHj3ox63VRW8v
>> +6mA8TFWYbOIwB8J7ScF4NszVwyiUnW13oKi7svoBM3LYYG2IMvre+gOvyMGfM8uv
>> +X3txcYqAjhRV6n7vGo9LRLIIRSPKzaJbm/W7nT38LRUJP8JMSQUOPKgeEwQvOTVZ
>> ++1kd7WeaGZrjagTDM4yhBjpOmB3D8aeT6xkjBlUwuddPzbdi0N7GrU520RcJMjxt
>> +JMyOgabHKUKmPTX4m0ZCKi2jSILi7/6fBF+TZDxpakLwAwpTzm6kXArXb6AYtTEX
>> +GPihB4O69ZgEc90jp3EnZt7HtKZn1HTbPNQAlWgvESgJ7hWHnTlM5Obqnyb78tj5
>> +VdcOfTSQRYmw4Rh/lSUX0vQLhdmYSVLiMFFvT4IepXZgQ6McIdcvqoVrPgr0HoVz
>> +5YILZdmbs80VcgYL853lMfQ84kRwUcw8jNyz7mBK7V7rE5QhaF5lunZ/R41ZRXRy
>> +1ys1rNvLPvtOq/K51+A9U+h5lLM9LjeoOR+IUk2Vg4aIap+Z+lxbImH0gcJTrpem
>> +ctA/2sBjLN7w811EjB/Tlu2awzbsKLpIDFVGHiGBI2zb41gtPd2RkijmiZab6nuM
>> +ETg4ad3GscMoa++01oX/lrnVe386ECSjurmThb7I01eTNZrBlNsLyBeFzlEIEoBR
>> +TqUXHLiDACxzL6U4vWzdnvVrCOW9fwvJJqChj7Wy822w2LXxVhOryNujBmZCmOht
>> +mgDaJ15QiF+DACcX6VoBbm/462z+9Skxa0DqGwGzMOD5HldwvQSyZSykk/BzGFWP
>> +rXfLYoMjN+dgA/yNfem64ayGsmoPUAjnsE4YasD58UVO0XwwtdMGJSOVmkdyWMcM
>> +t+lN74kX/gmIvciK06N6prBfowgBEIJ6ev2dzlydSN8rGORmQ+OFzjP14rT0O+1Q
>> +O48yR2ZZ9jl4YPUKSFJ3EUc/Qt9vO+chNiNYSy6TABGXur0WWiDvGURG9K5fWTqq
>> +U2KydSRoYD5iF0caOgMZecNhZV+4CX927j3XuuKKx49qTAt3WMtmJ/UQFHMtQ833
>> +XDFWHpEKDImfHfyiB1f8bOmqYmPuE6Shup0UMJsMFel4QVJM0Jn9+wHw/0qqPiS3
>> +a769S/u9U2dfyZY5PfymY8UjFRMDtLaUoJSRaGp6RNc6LynuMMKdzho0GwvL3+m9
>> +xKLDbbks8hVdmtcxxDKiio+F0hp3yc/2PyA/VGAlARiGp7876WTCZox9Bwnf6lkS
>> +k9eYLSabe/r3Ag1SbWEGpFk3VO37qCyfp2xTfrHXK1ZJlvFwj3FFSprUaMrV+81K
>> +FCEcSozXpVsQ7e7d11A7S8rTbtp09Q/J2oxyR0A9lk/ia5Qd/xwbPl4QJcWK2Jar
>> +K3yFK8VrUNib7CjI1kdB479KIllD8oK6druBkzwGzFxDtcl47RlfkqW96XSQT7x/
>> +h/YKSLcpMx9x9TJd2GDKj2t4oE9eGTBC0YbdH+HJNSrjEsWkjgY6Uw++S6VzKvQZ
>> +DDsMJfxwcChc2zKRou+BFA=3D=3D
>> +-----END ENCRYPTED PRIVATE KEY-----
>> diff --git
>> a/recipes-devtools/secure-boot-secrets/files/forky/PkKek-1-snakeoil.pem
>> b/recipes-devtools/secure-boot-secrets/files/forky/PkKek-1-snakeoil.pem
>> new file mode 100644
>> index 0000000..7cd2487
>> --- /dev/null
>> +++
>> b/recipes-devtools/secure-boot-secrets/files/forky/PkKek-1-snakeoil.pem
>> @@ -0,0 +1,23 @@
>> +-----BEGIN CERTIFICATE-----
>> +MIID1zCCAr+gAwIBAgIUDMG7xGGEPj+ABvbflim0PNb/loowDQYJKoZIhvcNAQEL
>> +BQAwejELMAkGA1UEBhMCVVMxETAPBgNVBAgMCENvbG9yYWRvMRUwEwYDVQQHDAxG
>> +b3J0IENvbGxpbnMxETAPBgNVBAoMCFNuYWtlT2lsMS4wLAYDVQQDDCVTbmFrZU9p
>> +bCBUZXN0IEtleSBmb3IgRUZJIFNlY3VyZSBCb290MCAXDTIzMDUxOTIzMTE0NVoY
>> +DzIwNTMwNTE3MjMxMTQ1WjB6MQswCQYDVQQGEwJVUzERMA8GA1UECAwIQ29sb3Jh
>> +ZG8xFTATBgNVBAcMDEZvcnQgQ29sbGluczERMA8GA1UECgwIU25ha2VPaWwxLjAs
>> +BgNVBAMMJVNuYWtlT2lsIFRlc3QgS2V5IGZvciBFRkkgU2VjdXJlIEJvb3QwggEi
>> +MA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDIi65d6LmojD5S9q8vE/LI2HHQ
>> +boiO5/1KrFVc6kpxD6XdkJwpBoItYIfSls9CPnzvNWOAxR3hIeBd1U/prAPPxvQ1
>> +wuDLMXfWkcGaYHfPnme/YluAjnpuLH1MQcumgOzj5xYBvZZk+RbytX/phH7FW4Tx
>> ++L1oBYnsfh3BSE/NTtEEHV1nXAXpa/dvyefWMlrlbwjfM5362lZzM6yrJGcOcWEy
>> +I66UYCIVO2Yhe/ZVF5B/tPGtd2oACz11xLeqLPM1WBjlekAG2Zi7UCPIvDCpdn5u
>> +Vna2ZRQmJyDDdh0Ja2VMC19dkMd/5nOAI21O+FvYPOkBWYX8f4DzDyVQlmIFAgMB
>> +AAGjUzBRMB0GA1UdDgQWBBRjuNXuXfh7mi8I3eTboeYGyFTa2zAfBgNVHSMEGDAW
>> +gBRjuNXuXfh7mi8I3eTboeYGyFTa2zAPBgNVHRMBAf8EBTADAQH/MA0GCSqGSIb3
>> +DQEBCwUAA4IBAQBBxlfo6MxBN44mXBIhE/QUbJZ+bo/Vrqv2DIZqOlV5+Sk6KnK8
>> +X9Rz2IJwoqLjB6cW9yInk5P/QS45880K1fDT/lu5/2U64i3l1ZFK75qLDCn4/khF
>> +birV2U6LBZpxLe3UvXk3xZMoUPzvT2rhrsf78G0pSmAnP8li8Co8F6hTjQzB8IgC
>> +DpYVATCoWBH6GhudtjUp+CJSyGApdL+HKX6i6oD7vutvWYBf0Hx5r1NrqIv31Y4V
>> +bhwvK5zajFamj/VYeVy7/roqD06hNF1ImhsuBOqoJlKu+cHMGN9DOJqjGup1T9aI
>> +2dpEOK5vbKXFrox/yCLgXmUkdwZ3BK4lcxCq
>> +-----END CERTIFICATE-----
>> diff --git a/recipes-devtools/swupdate-certificates/files/forky
>> b/recipes-devtools/swupdate-certificates/files/forky
>> new file mode 120000
>> index 0000000..2719d00
>> --- /dev/null
>> +++ b/recipes-devtools/swupdate-certificates/files/forky
>> @@ -0,0 +1 @@
>> +../../secure-boot-secrets/files/forky
>> \ No newline at end of file
>> diff --git a/start-qemu.sh b/start-qemu.sh
>> index d12fa23..0b783d6 100755
>> --- a/start-qemu.sh
>> +++ b/start-qemu.sh
>> @@ -47,6 +47,8 @@ if [ -z "${DISTRO_RELEASE}" ]; then
>> DISTRO_RELEASE=3D"trixie"
>> elif grep -s -q "DEBIAN_SID: true" .config.yaml; then
>> DISTRO_RELEASE=3D"sid"
>> + elif grep -s -q "DEBIAN_FORKY: true" .config.yaml; then
>> + DISTRO_RELEASE=3D"forky"
>=20
> ..and here.

Ok.

Thanks & Regards
Shivanand K

--R8NFs6z3ozuEu5J89ruz
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>On Mon, Jul 27, 2026 at 10:05 AM, Jan Kiszka wrote:</div>
<div>
<blockquote>On 27.07.26 16:11, Shivanand.Kunijadar@toshiba-tsip.com wrote:<=
br />
<blockquote>From: Shivanand Kunijadar &lt;Shivanand.Kunijadar@toshiba-tsip.=
com&gt;<br /><br />The .key &amp; .pem files are addded using below .deb pa=
ckage,<br /><a href=3D"https://snapshot.debian.org/file/d32d11a5aacbf5685b8=
1e8176a27a6918e9b55fb/ovmf-generic_2025.11-5_all.deb" target=3D"_blank" rel=
=3D"noopener">https://snapshot.debian.org/file/d32d11a5aacbf5685b81e8176a27=
a6918e9b55fb/ovmf-generic_2025.11-5_all.deb</a><br /><br />Signed-off-by: S=
hivanand Kunijadar &lt;Shivanand.Kunijadar@toshiba-tsip.com&gt;<br />---<br=
 />Kconfig | 4 +++<br />conf/distro/cip-core-forky.conf | 13 ++++++++<br />=
kas/opt/forky.yml | 15 ++++++++++<br />.../files/forky/PkKek-1-snakeoil.key=
 | 30 +++++++++++++++++++<br />.../files/forky/PkKek-1-snakeoil.pem | 23 ++=
++++++++++++</blockquote>
So, current sid uses different keys that forky? Is that always the case?</b=
lockquote>
</div>
<div>&nbsp;</div>
<div>The ovmf package version in both forky &amp; sid are same now[1], so t=
he keys should be same.&nbsp;</div>
<div>I'll send a separate patch to create symlink to forky for sid keys. pl=
ease note the sid keys were added long back and pointing to trixie.&nbsp; &=
nbsp;</div>
<div>&nbsp;</div>
<div>[1] https://packages.debian.org/sid/ovmf-generic</div>
<div><br />
<blockquote>
<blockquote>.../swupdate-certificates/files/forky | 1 +<br />start-qemu.sh =
| 2 ++<br />7 files changed, 88 insertions(+)<br />create mode 100644 conf/=
distro/cip-core-forky.conf<br />create mode 100644 kas/opt/forky.yml<br />c=
reate mode 100644 recipes-devtools/secure-boot-secrets/files/forky/PkKek-1-=
snakeoil.key<br />create mode 100644 recipes-devtools/secure-boot-secrets/f=
iles/forky/PkKek-1-snakeoil.pem<br />create mode 120000 recipes-devtools/sw=
update-certificates/files/forky<br /><br />diff --git a/Kconfig b/Kconfig<b=
r />index 438234c..14cd677 100644<br />--- a/Kconfig<br />+++ b/Kconfig<br =
/>@@ -241,6 +241,9 @@ config DEBIAN_TRIXIE<br />config DEBIAN_SID<br />bool=
 "Sid (Unstable)"<br /><br />+config DEBIAN_FORKY<br />+ bool "forky (14)"<=
br />+</blockquote>
Let's sort forky before sid.</blockquote>
</div>
<div>Ok, sure.<br />
<blockquote>
<blockquote>endchoice<br /><br />config KAS_INCLUDE_DEBIAN<br />@@ -250,6 +=
253,7 @@ config KAS_INCLUDE_DEBIAN<br />default "kas/opt/bookworm.yml" if D=
EBIAN_BOOKWORM<br />default "kas/opt/trixie.yml" if DEBIAN_TRIXIE<br />defa=
ult "kas/opt/sid.yml" if DEBIAN_SID<br />+ default "kas/opt/forky.yml" if D=
EBIAN_FORKY</blockquote>
Here as well.</blockquote>
Ok.<br />
<blockquote>
<blockquote>comment "Image features"<br /><br />diff --git a/conf/distro/ci=
p-core-forky.conf b/conf/distro/cip-core-forky.conf<br />new file mode 1006=
44<br />index 0000000..7a868ce<br />--- /dev/null<br />+++ b/conf/distro/ci=
p-core-forky.conf<br />@@ -0,0 +1,13 @@<br />+#<br />+# CIP Core, generic p=
rofile<br />+#<br />+# Copyright (c) Toshiba Corporation, 2026<br />+#<br /=
>+# Authors:<br />+# Shivanand Kunijadar &lt;Shivanand.Kunijadar@toshiba-ts=
ip.com&gt;<br />+#<br />+# SPDX-License-Identifier: MIT<br />+#<br />+<br /=
>+require conf/distro/debian-forky.conf<br />+require cip-core-common.inc<b=
r />diff --git a/kas/opt/forky.yml b/kas/opt/forky.yml<br />new file mode 1=
00644<br />index 0000000..6c4fcdc<br />--- /dev/null<br />+++ b/kas/opt/for=
ky.yml<br />@@ -0,0 +1,15 @@<br />+#<br />+# CIP Core, generic profile<br /=
>+#<br />+# Copyright (c) Toshiba Corporation, 2026<br />+#<br />+# Authors=
:<br />+# Shivanand Kunijadar &lt;Shivanand.Kunijadar@toshiba-tsip.com&gt;<=
br />+#<br />+# SPDX-License-Identifier: MIT<br />+#<br />+<br />+header:<b=
r />+ version: 14<br />+<br />+distro: cip-core-forky<br />diff --git a/rec=
ipes-devtools/secure-boot-secrets/files/forky/PkKek-1-snakeoil.key b/recipe=
s-devtools/secure-boot-secrets/files/forky/PkKek-1-snakeoil.key<br />new fi=
le mode 100644<br />index 0000000..dd7f492<br />--- /dev/null<br />+++ b/re=
cipes-devtools/secure-boot-secrets/files/forky/PkKek-1-snakeoil.key<br />@@=
 -0,0 +1,30 @@<br />+-----BEGIN ENCRYPTED PRIVATE KEY-----<br />+MIIFHDBOBg=
kqhkiG9w0BBQ0wQTApBgkqhkiG9w0BBQwwHAQIs4RXCLmGLJgCAggA<br />+MAwGCCqGSIb3DQ=
IJBQAwFAYIKoZIhvcNAwcECHer6014IEhGBIIEyO8O2zL8CJwV<br />+auQpWLJsMMWxu2aSh1=
WadX9+rg+O61mukuS4rQSH5shMQ2krZZKzyXx0q8+2AySD<br />+EtDXwhLvep60gUxOoNqK1+=
l3AxSFfIGOY8NC6yW67VX+G09ajWpgHj3ox63VRW8v<br />+6mA8TFWYbOIwB8J7ScF4NszVwy=
iUnW13oKi7svoBM3LYYG2IMvre+gOvyMGfM8uv<br />+X3txcYqAjhRV6n7vGo9LRLIIRSPKza=
Jbm/W7nT38LRUJP8JMSQUOPKgeEwQvOTVZ<br />++1kd7WeaGZrjagTDM4yhBjpOmB3D8aeT6x=
kjBlUwuddPzbdi0N7GrU520RcJMjxt<br />+JMyOgabHKUKmPTX4m0ZCKi2jSILi7/6fBF+TZD=
xpakLwAwpTzm6kXArXb6AYtTEX<br />+GPihB4O69ZgEc90jp3EnZt7HtKZn1HTbPNQAlWgvES=
gJ7hWHnTlM5Obqnyb78tj5<br />+VdcOfTSQRYmw4Rh/lSUX0vQLhdmYSVLiMFFvT4IepXZgQ6=
McIdcvqoVrPgr0HoVz<br />+5YILZdmbs80VcgYL853lMfQ84kRwUcw8jNyz7mBK7V7rE5QhaF=
5lunZ/R41ZRXRy<br />+1ys1rNvLPvtOq/K51+A9U+h5lLM9LjeoOR+IUk2Vg4aIap+Z+lxbIm=
H0gcJTrpem<br />+ctA/2sBjLN7w811EjB/Tlu2awzbsKLpIDFVGHiGBI2zb41gtPd2RkijmiZ=
ab6nuM<br />+ETg4ad3GscMoa++01oX/lrnVe386ECSjurmThb7I01eTNZrBlNsLyBeFzlEIEo=
BR<br />+TqUXHLiDACxzL6U4vWzdnvVrCOW9fwvJJqChj7Wy822w2LXxVhOryNujBmZCmOht<b=
r />+mgDaJ15QiF+DACcX6VoBbm/462z+9Skxa0DqGwGzMOD5HldwvQSyZSykk/BzGFWP<br />=
+rXfLYoMjN+dgA/yNfem64ayGsmoPUAjnsE4YasD58UVO0XwwtdMGJSOVmkdyWMcM<br />+t+l=
N74kX/gmIvciK06N6prBfowgBEIJ6ev2dzlydSN8rGORmQ+OFzjP14rT0O+1Q<br />+O48yR2Z=
Z9jl4YPUKSFJ3EUc/Qt9vO+chNiNYSy6TABGXur0WWiDvGURG9K5fWTqq<br />+U2KydSRoYD5=
iF0caOgMZecNhZV+4CX927j3XuuKKx49qTAt3WMtmJ/UQFHMtQ833<br />+XDFWHpEKDImfHfy=
iB1f8bOmqYmPuE6Shup0UMJsMFel4QVJM0Jn9+wHw/0qqPiS3<br />+a769S/u9U2dfyZY5Pfy=
mY8UjFRMDtLaUoJSRaGp6RNc6LynuMMKdzho0GwvL3+m9<br />+xKLDbbks8hVdmtcxxDKiio+=
F0hp3yc/2PyA/VGAlARiGp7876WTCZox9Bwnf6lkS<br />+k9eYLSabe/r3Ag1SbWEGpFk3VO3=
7qCyfp2xTfrHXK1ZJlvFwj3FFSprUaMrV+81K<br />+FCEcSozXpVsQ7e7d11A7S8rTbtp09Q/=
J2oxyR0A9lk/ia5Qd/xwbPl4QJcWK2Jar<br />+K3yFK8VrUNib7CjI1kdB479KIllD8oK6dru=
BkzwGzFxDtcl47RlfkqW96XSQT7x/<br />+h/YKSLcpMx9x9TJd2GDKj2t4oE9eGTBC0YbdH+H=
JNSrjEsWkjgY6Uw++S6VzKvQZ<br />+DDsMJfxwcChc2zKRou+BFA=3D=3D<br />+-----END=
 ENCRYPTED PRIVATE KEY-----<br />diff --git a/recipes-devtools/secure-boot-=
secrets/files/forky/PkKek-1-snakeoil.pem b/recipes-devtools/secure-boot-sec=
rets/files/forky/PkKek-1-snakeoil.pem<br />new file mode 100644<br />index =
0000000..7cd2487<br />--- /dev/null<br />+++ b/recipes-devtools/secure-boot=
-secrets/files/forky/PkKek-1-snakeoil.pem<br />@@ -0,0 +1,23 @@<br />+-----=
BEGIN CERTIFICATE-----<br />+MIID1zCCAr+gAwIBAgIUDMG7xGGEPj+ABvbflim0PNb/lo=
owDQYJKoZIhvcNAQEL<br />+BQAwejELMAkGA1UEBhMCVVMxETAPBgNVBAgMCENvbG9yYWRvMR=
UwEwYDVQQHDAxG<br />+b3J0IENvbGxpbnMxETAPBgNVBAoMCFNuYWtlT2lsMS4wLAYDVQQDDC=
VTbmFrZU9p<br />+bCBUZXN0IEtleSBmb3IgRUZJIFNlY3VyZSBCb290MCAXDTIzMDUxOTIzMT=
E0NVoY<br />+DzIwNTMwNTE3MjMxMTQ1WjB6MQswCQYDVQQGEwJVUzERMA8GA1UECAwIQ29sb3=
Jh<br />+ZG8xFTATBgNVBAcMDEZvcnQgQ29sbGluczERMA8GA1UECgwIU25ha2VPaWwxLjAs<b=
r />+BgNVBAMMJVNuYWtlT2lsIFRlc3QgS2V5IGZvciBFRkkgU2VjdXJlIEJvb3QwggEi<br />=
+MA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDIi65d6LmojD5S9q8vE/LI2HHQ<br />+boi=
O5/1KrFVc6kpxD6XdkJwpBoItYIfSls9CPnzvNWOAxR3hIeBd1U/prAPPxvQ1<br />+wuDLMXf=
WkcGaYHfPnme/YluAjnpuLH1MQcumgOzj5xYBvZZk+RbytX/phH7FW4Tx<br />++L1oBYnsfh3=
BSE/NTtEEHV1nXAXpa/dvyefWMlrlbwjfM5362lZzM6yrJGcOcWEy<br />+I66UYCIVO2Yhe/Z=
VF5B/tPGtd2oACz11xLeqLPM1WBjlekAG2Zi7UCPIvDCpdn5u<br />+Vna2ZRQmJyDDdh0Ja2V=
MC19dkMd/5nOAI21O+FvYPOkBWYX8f4DzDyVQlmIFAgMB<br />+AAGjUzBRMB0GA1UdDgQWBBR=
juNXuXfh7mi8I3eTboeYGyFTa2zAfBgNVHSMEGDAW<br />+gBRjuNXuXfh7mi8I3eTboeYGyFT=
a2zAPBgNVHRMBAf8EBTADAQH/MA0GCSqGSIb3<br />+DQEBCwUAA4IBAQBBxlfo6MxBN44mXBI=
hE/QUbJZ+bo/Vrqv2DIZqOlV5+Sk6KnK8<br />+X9Rz2IJwoqLjB6cW9yInk5P/QS45880K1fD=
T/lu5/2U64i3l1ZFK75qLDCn4/khF<br />+birV2U6LBZpxLe3UvXk3xZMoUPzvT2rhrsf78G0=
pSmAnP8li8Co8F6hTjQzB8IgC<br />+DpYVATCoWBH6GhudtjUp+CJSyGApdL+HKX6i6oD7vut=
vWYBf0Hx5r1NrqIv31Y4V<br />+bhwvK5zajFamj/VYeVy7/roqD06hNF1ImhsuBOqoJlKu+cH=
MGN9DOJqjGup1T9aI<br />+2dpEOK5vbKXFrox/yCLgXmUkdwZ3BK4lcxCq<br />+-----END=
 CERTIFICATE-----<br />diff --git a/recipes-devtools/swupdate-certificates/=
files/forky b/recipes-devtools/swupdate-certificates/files/forky<br />new f=
ile mode 120000<br />index 0000000..2719d00<br />--- /dev/null<br />+++ b/r=
ecipes-devtools/swupdate-certificates/files/forky<br />@@ -0,0 +1 @@<br />+=
../../secure-boot-secrets/files/forky<br />\ No newline at end of file<br /=
>diff --git a/start-qemu.sh b/start-qemu.sh<br />index d12fa23..0b783d6 100=
755<br />--- a/start-qemu.sh<br />+++ b/start-qemu.sh<br />@@ -47,6 +47,8 @=
@ if [ -z "${DISTRO_RELEASE}" ]; then<br />DISTRO_RELEASE=3D"trixie"<br />e=
lif grep -s -q "DEBIAN_SID: true" .config.yaml; then<br />DISTRO_RELEASE=3D=
"sid"<br />+ elif grep -s -q "DEBIAN_FORKY: true" .config.yaml; then<br />+=
 DISTRO_RELEASE=3D"forky"</blockquote>
..and here.</blockquote>
</div>
<div>Ok.</div>
<div>&nbsp;</div>
<div>Thanks &amp; Regards</div>
<div>Shivanand K</div>

--R8NFs6z3ozuEu5J89ruz--


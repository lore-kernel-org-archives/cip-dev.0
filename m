Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDDBC433EF
	for <webhook@archiver.kernel.org>; Tue, 23 Nov 2021 06:29:03 +0000 (UTC)
Received: from goliath.siemens.de (goliath.siemens.de [192.35.17.28])
 by mx.groups.io with SMTP id smtpd.web10.8030.1637648941709635383
 for <cip-dev@lists.cip-project.org>;
 Mon, 22 Nov 2021 22:29:02 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 192.35.17.28, mailfrom: jan.kiszka@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 1AN6SrZx002882
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Nov 2021 07:28:53 +0100
Received: from [167.87.0.79] ([167.87.0.79])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 1AN6SoGZ023552;
	Tue, 23 Nov 2021 07:28:51 +0100
Subject: Re: [cip-dev][isar-cip-core][RFC PATCH] customizations: Add FW and
 tools required for wifi testing
To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Pavel Machek <pavel@denx.de>
References: <20211122111940.12250-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <eb289805-9e98-7d2d-8e6d-1786087d0ac3@siemens.com>
 <OSZPR01MB7019EA632E0BDCC0F4251C9FAA9F9@OSZPR01MB7019.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <676467b7-74fd-c95f-08e5-aa1794073e17@siemens.com>
Date: Tue, 23 Nov 2021 07:28:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: 
 <OSZPR01MB7019EA632E0BDCC0F4251C9FAA9F9@OSZPR01MB7019.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by goliath.siemens.de id
 1AN6SrZx002882
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 Nov 2021 06:29:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6965

On 22.11.21 18:37, Prabhakar Mahadev Lad wrote:
> Hi Jan,
>=20
> Thank you for the quick response.
>=20
>> -----Original Message-----
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>> Sent: 22 November 2021 11:28
>> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>; c=
ip-dev@lists.cip-project.org;
>> Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek <pa=
vel@denx.de>
>> Subject: Re: [cip-dev][isar-cip-core][RFC PATCH] customizations: Add F=
W and tools required for wifi
>> testing
>>
>> On 22.11.21 12:19, Lad Prabhakar wrote:
>>> Add firmware and tools required for testing wifin on hihope-rzg2m.
>>>
>>> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com=
>
>>> ---
>>> Hi All,
>>>
>>> Sending an RFC as I am not sure if this is the right place to add
>>> this. I wanted to add the debian package depends in machine.conf file
>>> but didnt find any variables.
>>
>> IMAGE_INSTALL_append would work there, see eg.
>> https://github.com/siemens/jailhouse-
>> images%2Fblob%2Fmaster%2Fconf%2Fmachine%2Frpi4.conf&amp;data=3D04%7C01=
%7Cprabhakar.mahadev-
>> lad.rj%40bp.renesas.com%7Cae2601f49f5b4725b1ab08d9adab1943%7C53d82571d=
a1947e49cb4625a166a4a2a%7C0%7C0%
>> 7C637731772644808211%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQI=
joiV2luMzIiLCJBTiI6Ik1haWwiLCJXV
>> CI6Mn0%3D%7C3000&amp;sdata=3Dmqp0wknGyxKyY82YvgHJXl72aTu4DWSuUOHcaZPo8=
xA%3D&amp;reserved=3D0.
>>
> Adding IMAGE_INSTALL/IMAGE_PREINSTALL machine.conf didn=E2=80=99t help =
for me, I was seeing below issues:
>=20
> | ERROR: Nothing PROVIDES 'wireless-regdb' (but /repo/recipes-core/imag=
es/cip-core-image.bb DEPENDS on or otherwise requires it)
> | ERROR: Required build target 'cip-core-image' has no buildable provid=
ers.
> | Missing or unbuildable dependency chain was: ['cip-core-image', 'wire=
less-regdb']
>=20
> | ERROR: Nothing PROVIDES 'wireless-tools' (but /repo/recipes-core/imag=
es/cip-core-image.bb DEPENDS on or otherwise requires it)
> | ERROR: Required build target 'cip-core-image' has no buildable provid=
ers.
> | Missing or unbuildable dependency chain was: ['cip-core-image', 'wire=
less-tools']
>=20
> | ERROR: Nothing PROVIDES 'firmware-ti-connectivity' (but /repo/recipes=
-core/images/cip-core-image.bb DEPENDS on or otherwise requires it)
> | ERROR: Required build target 'cip-core-image' has no buildable provid=
ers.
> | Missing or unbuildable dependency chain was: ['cip-core-image', 'firm=
ware-ti-connectivity']
>=20
> | ERROR: Nothing PROVIDES 'iw' (but /repo/recipes-core/images/cip-core-=
image.bb DEPENDS on or otherwise requires it)
> | ERROR: Required build target 'cip-core-image' has no buildable provid=
ers.
> | Missing or unbuildable dependency chain was: ['cip-core-image', 'iw']
>=20
> As above didn=E2=80=99t work and customizations.bb is the only place we=
re I was able to grep for DEBIAN_DEPENDS variable I went this approach =F0=
=9F=98=89.
> (Note also adding DEBIAN_DEPENDS in machine.conf didn=E2=80=99t work.)
>=20
> Is there something which I am missing that would make it work with IMAG=
E_INSTALL_append variable?=20
>=20

DEBIAN_DEPENDS is the wrong variable to touch at global configuration
level. As in the references example, you need to extend the
IMAGE_PREINSTALL (for Debian packages; IMAGE_INSTALL would be for
self-built ones):

diff --git a/conf/machine/hihope-rzg2m.conf b/conf/machine/hihope-rzg2m.c=
onf
index a2ae03d..4c611ae 100644
--- a/conf/machine/hihope-rzg2m.conf
+++ b/conf/machine/hihope-rzg2m.conf
@@ -17,3 +17,5 @@ KERNEL_DEFCONFIG =3D "cip-kernel-config/4.19.y-cip/arm6=
4/renesas_defconfig"
 USE_CIP_KERNEL_CONFIG =3D "1"
 DTB_FILES =3D "r8a774a1-hihope-rzg2m-ex.dtb"
 IMAGE_BOOT_FILES =3D "${KERNEL_IMAGE} ${DTB_FILES}"
+
+IMAGE_PREINSTALL_append =3D " firmware-ti-connectivity"

>=20
>> Whether we want to "hard-code" the installation wireless firmware in t=
he machine conf here is a
>> different question. Maybe customizations is not that a bad place.
>>
> If adding IMAGE_INSTALL_append works in machine.conf, will go with this=
 approach, as that would not disturb other platform builds.
>=20

You would still have to add/request the generic wireless tools
somewhere. For that, you either need to touch the customization package
(DEBIAN_DEPENDS) or directly expand the IMAGE_PREINSTALL list in
cip-core-image.bb. How about this pattern?

diff --git a/conf/machine/hihope-rzg2m.conf b/conf/machine/hihope-rzg2m.c=
onf
index a2ae03d..4f4ee81 100644
--- a/conf/machine/hihope-rzg2m.conf
+++ b/conf/machine/hihope-rzg2m.conf
@@ -17,3 +17,6 @@ KERNEL_DEFCONFIG =3D "cip-kernel-config/4.19.y-cip/arm6=
4/renesas_defconfig"
 USE_CIP_KERNEL_CONFIG =3D "1"
 DTB_FILES =3D "r8a774a1-hihope-rzg2m-ex.dtb"
 IMAGE_BOOT_FILES =3D "${KERNEL_IMAGE} ${DTB_FILES}"
+
+WIRELESS_FIRMWARE_PACKAGE =3D "firmware-ti-connectivity"
+INSTALL_WIRELESS_TOOLS ?=3D "1"
diff --git a/recipes-core/customizations/customizations.bb b/recipes-core=
/customizations/customizations.bb
index 932b11c..1c2a125 100644
--- a/recipes-core/customizations/customizations.bb
+++ b/recipes-core/customizations/customizations.bb
@@ -18,10 +18,15 @@ SRC_URI =3D " \
     file://ethernet \
     file://99-silent-printk.conf"
=20
+WIRELESS_FIRMWARE_PACKAGE ?=3D ""
+INSTALL_WIRELESS_TOOLS ??=3D "0"
+
 DEPENDS +=3D "sshd-regen-keys"
=20
 DEBIAN_DEPENDS =3D " \
-    ifupdown, isc-dhcp-client, net-tools, iputils-ping, ssh, sshd-regen-=
keys"
+    ifupdown, isc-dhcp-client, net-tools, iputils-ping, ssh, sshd-regen-=
keys, \
+    ${@('iw, wireless-regdb, wireless-tools, ' + d.getVar('WIRELESS_FIRM=
WARE_PACKAGE')) \
+        if d.getVar('INSTALL_WIRELESS_TOOLS') =3D=3D '1' else ''}"
=20
 do_install() {
 	install -v -d ${D}/etc/network/interfaces.d

Avoids enforcing wireless installation when using the machine conf, only=20
when using our customization package, something that downstream layers=20
usually don't do.

Jan

--=20
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux


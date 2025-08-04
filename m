Return-Path: <david.kauschke.ext@zeiss.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D0BC87FDA
	for <webhook@archiver.kernel.org>; Mon,  4 Aug 2025 06:02:42 +0000 (UTC)
Subject: =?UTF-8?B?U2VjdXJlIEJvb3QgJiBJbml0cmFtZnMg4oCUIEdQTHYzIENvbXBhdGliaWxpdHkgQ29uY2VybnM=?=
To: cip-dev@lists.cip-project.org
From: david.kauschke.ext@zeiss.com
X-Originating-Location: Munich, Bavaria, DE (188.195.217.206)
X-Originating-Platform: Linux Chrome 138
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Sun, 03 Aug 2025 23:02:41 -0700
Message-ID: <izPt.1754287361385416033.LPEa@lists.cip-project.org>
Content-Type: multipart/alternative; boundary="vTdiUQhxaeHUplMHcwZQ"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 04 Aug 2025 06:02:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19657

--vTdiUQhxaeHUplMHcwZQ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello CIP-members ,

I'm currently evaluating the use of an initramfs (as part of the unified ke=
rnel image, loaded by Efibootguard)
within a Secure Boot chain on a Linux-based system,
and I have some questions regarding potential GPLv3 licensing implications.

Specifically, I've noticed that certain initramfs components, such as coreu=
tils or awk are licensed under GPLv3.

Since Secure Boot typically restricts the ability to modify or replace sign=
ed binaries,
this raises potential concerns with GPLv3's "Installation Information" requ=
irement.

I would appreciate your insights on the following:
1)) Has this issue been previously discussed or addressed in the context of=
 CIP-based Linux systems?
2)) Are there recommended approaches for avoiding GPLv3 components in initr=
amfs, or for maintaining compliance with Secure Boot policies?
For example, substituting GPLv3 tools with alternatives like BusyBox?

Any guidance or references would be greatly appreciated.

Best regards,
David

--vTdiUQhxaeHUplMHcwZQ
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>
<div>Hello <span style=3D"color: #333333; font-family: system-ui, 'Segoe UI=
', Roboto, 'Helvetica Neue', 'Noto Sans', 'Liberation Sans', Arial, sans-se=
rif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color =
Emoji'; font-size: 16px; font-style: normal; font-variant-ligatures: normal=
; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orph=
ans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: =
2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; =
background-color: #ffffff; text-decoration-thickness: initial; text-decorat=
ion-style: initial; text-decoration-color: initial; display: inline !import=
ant; float: none;">CIP-members</span>,</div>
<div>&nbsp;</div>
<div>I'm currently evaluating the use of an initramfs (as part of the unifi=
ed kernel image, loaded by Efibootguard)<br />within a Secure Boot chain on=
 a Linux-based system,<br />and I have some questions regarding potential G=
PLv3 licensing implications.</div>
<div>&nbsp;</div>
<div>Specifically, I've noticed that certain initramfs components, such as =
coreutils or awk are licensed under GPLv3.</div>
<div>&nbsp;</div>
<div>Since Secure Boot typically restricts the ability to modify or replace=
 signed binaries,<br />this raises potential concerns with GPLv3's "Install=
ation Information" requirement.</div>
<div>&nbsp;</div>
<div>I would appreciate your insights on the following:</div>
<div>1)) Has this issue been previously discussed or addressed in the conte=
xt of CIP-based Linux systems?</div>
<div>2)) Are there recommended approaches for avoiding GPLv3 components in =
initramfs, or for maintaining compliance with Secure Boot policies?</div>
<div>For example, substituting GPLv3 tools with alternatives like BusyBox?<=
/div>
<div>&nbsp;</div>
<div>Any guidance or references would be greatly appreciated.</div>
<div>&nbsp;</div>
<div>Best regards,<br />David</div>
</div>

--vTdiUQhxaeHUplMHcwZQ--


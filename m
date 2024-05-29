Return-Path: <johnxw@amazon.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB34C25B75
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 16:51:50 +0000 (UTC)
Subject: Adding swap space to the encrypted partition
To: cip-dev@lists.cip-project.org
From: "JohnW" <johnxw@amazon.com>
X-Originating-Location: Puyallup, Washington, US (174.21.53.213)
X-Originating-Platform: Mac Firefox 126
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Wed, 29 May 2024 09:51:44 -0700
Message-ID: <lc89.1717001504639248244.RWYi@lists.cip-project.org>
Content-Type: multipart/alternative; boundary="rK7f82hBqIdV9fUfFPiQ"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 16:51:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16066

--rK7f82hBqIdV9fUfFPiQ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Cip-Dev community,

Is there a way to add a swap space to the encrypted partition? Something th=
at will look like

nvme0n1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 259:0=C2=A0=C2=A0=C2=A0=C2=A00 238.5G=C2=A0=C2=A00 disk
=E2=94=9C=E2=94=80nvme0n1p1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 259:1=C2=A0=C2=A0=C2=A0=C2=A00=C2=A0=C2=A0 512M=C2=A0=C2=A00 p=
art=C2=A0=C2=A0/boot/efi
=E2=94=9C=E2=94=80nvme0n1p2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 259:2=C2=A0=C2=A0=C2=A0=C2=A00=C2=A0=C2=A0 1.4G=C2=A0=C2=A00 p=
art=C2=A0=C2=A0/boot
=E2=94=94=E2=94=80nvme0n1p3=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 259:3=C2=A0=C2=A0=C2=A0=C2=A00 236.6G=C2=A0=C2=A00 part
=E2=94=94=E2=94=80nvme0n1p3_crypt=C2=A0=C2=A0 253:0=C2=A0=C2=A0=C2=A0=C2=A0=
0 236.5G=C2=A0=C2=A00 crypt
=E2=94=9C=E2=94=80my-root=C2=A0=C2=A0 253:1=C2=A0=C2=A0=C2=A0=C2=A00 235.6G=
=C2=A0=C2=A00 lvm=C2=A0=C2=A0 /
=E2=94=94=E2=94=80my-swap_1 253:2=C2=A0=C2=A0=C2=A0=C2=A00=C2=A0=C2=A0 980M=
=C2=A0=C2=A00 lvm=C2=A0=C2=A0 [SWAP]

Regards,
John

--rK7f82hBqIdV9fUfFPiQ
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Cip-Dev community,<br /><br />Is there a way to add a swap space to the =
encrypted partition? Something that will look like<br /><br />
<div style=3D"caret-color: #000000; color: #000000; font-family: Aptos; fon=
t-style: normal; font-variant-caps: normal; font-weight: 400; letter-spacin=
g: normal; orphans: auto; text-align: start; text-indent: 0px; text-transfo=
rm: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-tex=
t-stroke-width: 0px; text-decoration: none;">nvme0n1&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 259:0&nbsp;&n=
bsp;&nbsp;&nbsp;0 238.5G&nbsp;&nbsp;0 disk</div>
<div style=3D"caret-color: #000000; color: #000000; font-family: Aptos; fon=
t-style: normal; font-variant-caps: normal; font-weight: 400; letter-spacin=
g: normal; orphans: auto; text-align: start; text-indent: 0px; text-transfo=
rm: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-tex=
t-stroke-width: 0px; text-decoration: none;">=E2=94=9C=E2=94=80nvme0n1p1&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 259:1&nbsp;&nbsp;=
&nbsp;&nbsp;0&nbsp;&nbsp; 512M&nbsp;&nbsp;0 part&nbsp;&nbsp;/boot/efi</div>
<div style=3D"caret-color: #000000; color: #000000; font-family: Aptos; fon=
t-style: normal; font-variant-caps: normal; font-weight: 400; letter-spacin=
g: normal; orphans: auto; text-align: start; text-indent: 0px; text-transfo=
rm: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-tex=
t-stroke-width: 0px; text-decoration: none;">=E2=94=9C=E2=94=80nvme0n1p2&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 259:2&nbsp;&nbsp;=
&nbsp;&nbsp;0&nbsp;&nbsp; 1.4G&nbsp;&nbsp;0 part&nbsp;&nbsp;/boot</div>
<div style=3D"caret-color: #000000; color: #000000; font-family: Aptos; fon=
t-style: normal; font-variant-caps: normal; font-weight: 400; letter-spacin=
g: normal; orphans: auto; text-align: start; text-indent: 0px; text-transfo=
rm: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-tex=
t-stroke-width: 0px; text-decoration: none;">=E2=94=94=E2=94=80nvme0n1p3&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 259:3&nbsp;&nbsp;=
&nbsp;&nbsp;0 236.6G&nbsp;&nbsp;0 part</div>
<div style=3D"caret-color: #000000; color: #000000; font-family: Aptos; fon=
t-style: normal; font-variant-caps: normal; font-weight: 400; letter-spacin=
g: normal; orphans: auto; text-align: start; text-indent: 0px; text-transfo=
rm: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-tex=
t-stroke-width: 0px; text-decoration: none;">&nbsp;&nbsp;=E2=94=94=E2=94=80=
nvme0n1p3_crypt&nbsp;&nbsp; 253:0&nbsp;&nbsp;&nbsp;&nbsp;0 236.5G&nbsp;&nbs=
p;0 crypt</div>
<div style=3D"caret-color: #000000; color: #000000; font-family: Aptos; fon=
t-style: normal; font-variant-caps: normal; font-weight: 400; letter-spacin=
g: normal; orphans: auto; text-align: start; text-indent: 0px; text-transfo=
rm: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-tex=
t-stroke-width: 0px; text-decoration: none;">&nbsp;&nbsp;&nbsp;&nbsp;=E2=94=
=9C=E2=94=80my-root&nbsp;&nbsp; 253:1&nbsp;&nbsp;&nbsp;&nbsp;0 235.6G&nbsp;=
&nbsp;0 lvm&nbsp;&nbsp; /</div>
<div style=3D"caret-color: #000000; color: #000000; font-family: Aptos; fon=
t-style: normal; font-variant-caps: normal; font-weight: 400; letter-spacin=
g: normal; orphans: auto; text-align: start; text-indent: 0px; text-transfo=
rm: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-tex=
t-stroke-width: 0px; text-decoration: none;">&nbsp;&nbsp;&nbsp;&nbsp;=E2=94=
=94=E2=94=80my-swap_1 253:2&nbsp;&nbsp;&nbsp;&nbsp;0&nbsp;&nbsp; 980M&nbsp;=
&nbsp;0 lvm&nbsp;&nbsp; [SWAP]<br /><br />Regards,<br />John</div>

--rK7f82hBqIdV9fUfFPiQ--


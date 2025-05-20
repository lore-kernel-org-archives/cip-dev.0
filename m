Return-Path: <d.kauschke154@googlemail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93CA1C3ABDD
	for <webhook@archiver.kernel.org>; Tue, 20 May 2025 05:53:19 +0000 (UTC)
Subject: [isar-cip-core][QUESTION] initramfs-overlay-hook: tmpFS for overlay storage
To: cip-dev@lists.cip-project.org
From: d.kauschke154@googlemail.com
X-Originating-Location: Munich, Bavaria, DE (188.195.217.206)
X-Originating-Platform: Linux Firefox 138
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Mon, 19 May 2025 22:53:14 -0700
Message-ID: <unkY.1747720394864813878.o3iY@lists.cip-project.org>
Content-Type: multipart/alternative; boundary="FQIhswi6hyRSknvdV4bj"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 20 May 2025 05:53:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18924

--FQIhswi6hyRSknvdV4bj
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello all,

I have some questions regarding the use of the initramfs-overlay-hook featu=
re in CIP Core:
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob/master/recipes=
-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.3.bb

Currently, I=E2=80=99m using the default behavior where the overlay=E2=80=
=99s upper directory is located on a separate, persistent /var partition.
An wic example setup can be found here:
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob/master/wic/bbb=
-efibootguard.wks.in

At runtime, /etc/fstab includes an entry:

overlay on /etc type overlay (rw,relatime,lowerdir=3D/root/etc,upperdir=3D/=
root/var/local/etc,workdir=3D/root/var/local/.etc-atomic,uuid=3Don)

In this setup, the root filesystem is mounted read-only, and directories li=
ke /etc are made writable via an overlay.

This works well from a functional perspective, but due to the use of persis=
tent storage for the upper and work directories (on /var),
all runtime modifications are retained across reboots.
For example:
/etc/machine-id can be modified as expected,
but also a file like /etc/systemd/system/attacker.service could be dropped =
during runtime by someone with physical access to the flash of the device.
These files would then persist across reboots, undermining runtime integrit=
y.

Questions:
1) Is there an existing way to configure initramfs-overlay-hook to use a vo=
latile overlay backed by tmpFS for the upper directories?
2) If not, would it be feasible or acceptable to extend the recipe to optio=
nally support such a mode?
3) Are there known reasons why a tmpFS for overlay storage was not implemen=
ted yet?

The goal is to ensure that the system always boots into a clean and control=
led state,
without retaining any changes made during runtime =E2=80=94 for improved se=
curity and integrity.

Thank you for your time and expertise.

Best regards,
David

--FQIhswi6hyRSknvdV4bj
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>
<div>Hello all,</div>
<div>&nbsp;</div>
<div>I have some questions regarding the use of the initramfs-overlay-hook =
feature in CIP Core:<br /><a href=3D"https://gitlab.com/cip-project/cip-cor=
e/isar-cip-core/-/blob/master/recipes-initramfs/initramfs-overlay-hook/init=
ramfs-overlay-hook_0.3.bb" target=3D"_blank" rel=3D"noopener">https://gitla=
b.com/cip-project/cip-core/isar-cip-core/-/blob/master/recipes-initramfs/in=
itramfs-overlay-hook/initramfs-overlay-hook_0.3.bb</a></div>
<div>&nbsp;</div>
<div>Currently, I&rsquo;m using the default behavior where the overlay&rsqu=
o;s upper directory is located on a separate, persistent /var partition.<br=
 />An wic example setup can be found here:<br /><a href=3D"https://gitlab.c=
om/cip-project/cip-core/isar-cip-core/-/blob/master/wic/bbb-efibootguard.wk=
s.in" target=3D"_blank" rel=3D"noopener">https://gitlab.com/cip-project/cip=
-core/isar-cip-core/-/blob/master/wic/bbb-efibootguard.wks.in</a></div>
<div>&nbsp;</div>
<div>At runtime, /etc/fstab includes an entry:</div>
<div>&nbsp;</div>
<div>overlay on /etc type overlay (rw,relatime,lowerdir=3D/root/etc,upperdi=
r=3D/root/var/local/etc,workdir=3D/root/var/local/.etc-atomic,uuid=3Don)</d=
iv>
<div>&nbsp;</div>
<div>In this setup, the root filesystem is mounted read-only, and directori=
es like /etc are made writable via an overlay.</div>
<div>&nbsp;</div>
<div>This works well from a functional perspective, but due to the use of p=
ersistent storage for the upper and work directories (on /var),<br />all ru=
ntime modifications are retained across reboots.</div>
<div>For example:</div>
<div>/etc/machine-id can be modified as expected,<br />but also a file like=
 /etc/systemd/system/attacker.service could be dropped during runtime by so=
meone with physical access to the flash of the device.</div>
<div>These files would then persist across reboots, undermining runtime int=
egrity.</div>
<div>&nbsp;</div>
<div>Questions:</div>
<div>1) Is there an existing way to configure initramfs-overlay-hook to use=
 a volatile overlay backed by tmpFS for the upper directories?<br />2) If n=
ot, would it be feasible or acceptable to extend the recipe to optionally s=
upport such a mode?<br />3) Are there known reasons why a tmpFS for overlay=
 storage was not implemented yet?</div>
<div>&nbsp;</div>
<div>The goal is to ensure that the system always boots into a clean and co=
ntrolled state,<br />without retaining any changes made during runtime &mda=
sh; for improved security and integrity.</div>
<div>&nbsp;</div>
<div>Thank you for your time and expertise.</div>
<div>&nbsp;</div>
<div>Best regards,<br />David</div>
</div>

--FQIhswi6hyRSknvdV4bj--


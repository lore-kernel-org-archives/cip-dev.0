Return-Path: <johnxw@amazon.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 089A1C54E58
	for <webhook@archiver.kernel.org>; Mon, 25 Mar 2024 17:48:20 +0000 (UTC)
Subject: Re: [isar-cip-core][RFC 8/8] Add example to encrypt the rootfs
To: cip-dev@lists.cip-project.org
From: "JohnW" <johnxw@amazon.com>
X-Originating-Location: Puyallup, Washington, US (174.21.53.213)
X-Originating-Platform: Mac Firefox 123
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Mon, 25 Mar 2024 10:48:16 -0700
References: <d7cc79e4-ef20-4d31-befe-229ca3274fb7@siemens.com>
In-Reply-To: <d7cc79e4-ef20-4d31-befe-229ca3274fb7@siemens.com>
Message-ID: <1141.1711388896493643788@lists.cip-project.org>
Content-Type: multipart/alternative; boundary="XlEP9T0HulEPQ83jhhKT"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 25 Mar 2024 17:48:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15413

--XlEP9T0HulEPQ83jhhKT
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

>=20
> This should build an rootfs without efibootguard and with systemd-boot:
>=20
> ```
> kas-container build
> kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/encrypt_rootfs.yml
> ```

I tried this build and tried to boot this image from USB with secure boot d=
isabled in BIOS. The boot stuck at
>=20
>=20
> EFI stub: Loaded initrd from LINUX_EFI_INITRD_MEDIA_GUID device path
> EFI stub: Measured initrd data into PCR9

I currently have a image build based on ISAR with grub boot loader that has=
 secure boot working properly with all of my test devices. Is it possible i=
f I can add the /opt/encrypt_rootfs.yml into that build?

--XlEP9T0HulEPQ83jhhKT
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<blockquote>This should build an rootfs without efibootguard and with syste=
md-boot:<br /><br />```<br />kas-container build kas-cip.yml:kas/board/qemu=
-amd64.yml:kas/opt/encrypt_rootfs.yml<br />```</blockquote>
I tried this build and tried to boot this image from USB with secure boot d=
isabled in BIOS. The boot stuck at
<blockquote>EFI stub: Loaded initrd from LINUX_EFI_INITRD_MEDIA_GUID device=
 path<br />EFI stub: Measured initrd data into PCR9</blockquote>
I currently have a image build based on ISAR with grub boot loader that has=
 secure boot working properly with all of my test devices. Is it possible i=
f I can add the /opt/encrypt_rootfs.yml into that build?

--XlEP9T0HulEPQ83jhhKT--


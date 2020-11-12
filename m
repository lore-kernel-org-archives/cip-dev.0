Return-Path: <SRS0=Snss=ES=lists.cip-project.org=bounce+64572+5795+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C83DC2D0A3
	for <cip-dev@archiver.kernel.org>; Thu, 12 Nov 2020 12:12:44 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A936207BB
	for <cip-dev@archiver.kernel.org>; Thu, 12 Nov 2020 12:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="H5pRKWhm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A936207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=sanmina.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5795+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id CCBNYY4521723xoH1mAjiRz6; Thu, 12 Nov 2020 04:12:40 -0800
X-Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
 by mx.groups.io with SMTP id smtpd.web10.2781.1605179906235053820
 for <cip-dev@lists.cip-project.org>;
 Thu, 12 Nov 2020 03:18:26 -0800
X-Received: by mail-qt1-f175.google.com with SMTP id n63so3639629qte.4
        for <cip-dev@lists.cip-project.org>; Thu, 12 Nov 2020 03:18:26 -0800 (PST)
X-Gm-Message-State: Xt4GrejeHDkKB3xPRK0h8Vxfx4520388AA=
X-Google-Smtp-Source: ABdhPJzILm312cThuD3yR5b3b4dnATd9GCOXp2CpamRtAiYHr2BbDnlybpS003YTbjBkfc6USjeUyB+g45uAXSerqOM=
X-Received: by 2002:aed:3b7b:: with SMTP id q56mr29349577qte.377.1605179904444;
 Thu, 12 Nov 2020 03:18:24 -0800 (PST)
MIME-Version: 1.0
From: Rajashree Sankar <rajashree.sankar@sanmina.com>
Date: Thu, 12 Nov 2020 16:47:47 +0530
Message-ID: <CA+UxhRraif5mPKm5Ux3wzxvzr=weNPN-xKE50htgkS0wGX1pMA@mail.gmail.com>
Subject: [cip-dev] Issue in mounting Boot Partition on rootfs
To: cip-dev@lists.cip-project.org
Cc: Lakshmi Natarajan <lakshmi.natarajan@sanmina.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="lGD5e6kJa97KqHxX9ZXs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1605183160;
 bh=nz6nknF18CnCFF/zLw94o29oWhjwgt7w1gnflwZxmuY=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=H5pRKWhmo2FywqXZPL38yxhbDNBwT3lRFeK/lgbgnhWEzDQ2nmfnxXc3hx5MvHK3Kqu
 gxF8/9XEk32Qac+4kgqFNCblyczuHG4SHpDuBHIpM/USxArXVKoKNnNgy9A4QNZpUWrp4
 S7EkayojvsjZWP5o7R6aaoqF5O6RBktB5Uc=

--lGD5e6kJa97KqHxX9ZXs
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000008223805b3e7120a"

--00000000000008223805b3e7120a
Content-Type: multipart/alternative; boundary="000000000000019e2805b3e712a9"

--000000000000019e2805b3e712a9
Content-Type: text/plain; charset="UTF-8"

Hello All,
We need the boot partition to be mounted in rootfs For its access.
We have made a fstab entry */dev/mmcblk0p1  /boot   auto auto,sync,rw 0 0
to /etc/fstab .*On changing the contents of the mounted boot partition ,the
system does not boot on reboot/power cycle. Thi problem occurs 2/3 times.

Could you please share how this could be solved.
Thanks and Regards,
Rajashree Sankar

-- 
CONFIDENTIALITY
This e-mail message and any attachments thereto, is 
intended only for use by the addressee(s) named herein and may contain 
legally privileged and/or confidential information. If you are not the 
intended recipient of this e-mail message, you are hereby notified that any 
dissemination, distribution or copying of this e-mail message, and any 
attachments thereto, is strictly prohibited.  If you have received this 
e-mail message in error, please immediately notify the sender and 
permanently delete the original and any copies of this email and any prints 
thereof.
ABSENT AN EXPRESS STATEMENT TO THE CONTRARY HEREINABOVE, THIS 
E-MAIL IS NOT INTENDED AS A SUBSTITUTE FOR A WRITING.  Notwithstanding the 
Uniform Electronic Transactions Act or the applicability of any other law 
of similar substance and effect, absent an express statement to the 
contrary hereinabove, this e-mail message its contents, and any attachments 
hereto are not intended to represent an offer or acceptance to enter into a 
contract and are not otherwise intended to bind the sender, Sanmina 
Corporation (or any of its subsidiaries), or any other person or entity.

--000000000000019e2805b3e712a9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello All,<div>We need the boot partition to be mounted in=
 rootfs For its access.</div><div>We have made a fstab entry <b>/dev/mmcblk=
0p1=C2=A0 /boot=C2=A0 =C2=A0auto auto,sync,rw 0 0 to /etc/fstab .</b>On cha=
nging the contents of the mounted boot partition ,the system does not boot =
on reboot/power cycle. Thi problem occurs 2/3 times.</div><div><br></div><d=
iv>Could you please share how this could be solved.<br clear=3D"all"><div><=
div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_signature=
"><div dir=3D"ltr">Thanks and Regards,<div>Rajashree Sankar</div></div></di=
v></div></div></div>

<br>
CONFIDENTIALITY<br>This e-mail message and any attachments thereto, is inte=
nded only for use by the addressee(s) named herein and may contain legally =
privileged and/or confidential information. If you are not the intended rec=
ipient of this e-mail message, you are hereby notified that any disseminati=
on, distribution or copying of this e-mail message, and any attachments the=
reto, is strictly prohibited.  If you have received this e-mail message in =
error, please immediately notify the sender and permanently delete the orig=
inal and any copies of this email and any prints thereof.<br>ABSENT AN EXPR=
ESS STATEMENT TO THE CONTRARY HEREINABOVE, THIS E-MAIL IS NOT INTENDED AS A=
 SUBSTITUTE FOR A WRITING.  Notwithstanding the Uniform Electronic Transact=
ions Act or the applicability of any other law of similar substance and eff=
ect, absent an express statement to the contrary hereinabove, this e-mail m=
essage its contents, and any attachments hereto are not intended to represe=
nt an offer or acceptance to enter into a contract and are not otherwise in=
tended to bind the sender, Sanmina Corporation (or any of its subsidiaries)=
, or any other person or entity.<br>

--000000000000019e2805b3e712a9--

--00000000000008223805b3e7120a
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
H5QsTzlq4h/m1U9TUrkwRlHZAREpyXKowiIQoyGdnpWejVRw5Domsyxz9dACCtE7wFWb9f7gZPa9
yTHFUbiNo++Yfznto1zDKwGNRCHPwpSNWdv8uiLS5hs81uShzQIDAQABo4IB0zCCAc8wDgYDVR0P
AQH/BAQDAgWgMIGeBggrBgEFBQcBAQSBkTCBjjBNBggrBgEFBQcwAoZBaHR0cDovL3NlY3VyZS5n
bG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NwZXJzb25hbHNpZ24yc2hhMmczb2NzcC5jcnQwPQYIKwYB
BQUHMAGGMWh0dHA6Ly9vY3NwMi5nbG9iYWxzaWduLmNvbS9nc3BlcnNvbmFsc2lnbjJzaGEyZzMw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwRAYDVR0fBD0wOzA5oDegNYYzaHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc3BlcnNvbmFsc2lnbjJzaGEyZzMuY3JsMCcGA1UdEQQgMB6B
HHJhamFzaHJlZS5zYW5rYXJAc2FubWluYS5jb20wEwYDVR0lBAwwCgYIKwYBBQUHAwQwHwYDVR0j
BBgwFoAUaXKCYjFnlUSFd5GAxAQ2SZ17C2EwHQYDVR0OBBYEFBPMobgcDoNm3SbIojgMqG55lVDF
MA0GCSqGSIb3DQEBCwUAA4IBAQCxnjMGwiTsBWackGriNSClcLWSCJeszISzIymhTXxU2rWb/F/9
ZO2mcJVcQG/qJm6/NElgY5CfiXbyhTM9ZMRCvh2KVFHw8cX+w3fztRYsO+39fyuLP/6psQm3RyOz
czkuKDkRm2JftTBjT7g41XdaY5z1aFhFTpQHyIv1TxXksSJsM1YX3kR8dHBKxKwdRX+P8l0BiQ+v
yGnARB8rAsDJM5asocelVp2bJUDlW865vAoNfVUnngm7xtkYK+ErZfVqslPEhnv2g1NVG07IDeiC
E+PUXrkr2xG4LEyH4Gr+ckFtt/vtGAQGxyWfrenz4b1uocfPqSxE0KMcLmnM7oB+MYICbzCCAmsC
AQEwbTBdMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEzMDEGA1UEAxMq
R2xvYmFsU2lnbiBQZXJzb25hbFNpZ24gMiBDQSAtIFNIQTI1NiAtIEczAgw0A1bVryXuYEwTeCUw
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIPiONP9o3cSh2ffjidjGVhiS8ctVaBhx
vwN3wGrAXOfoMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIwMTEx
MjExMTgyNFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQBKnMeC/QKLiUaq/1gghMNjTtqvx15wIsBsqjtYvOx1JwCg6Hpd
mJN3Vo4+uLAp2JPSxyj66Xk4/OZiPHhHFKwDMB/d+XNkT7inyznqfEYUmn7ZV8ITpip4mc0twlcg
aysMC5hz71EEL0x83c6FwJbTRxgPt3J7ZeFT+J7RMI9T8xGrv1n1L2fH0RWc8QSR1i6B7EE/y2aM
pRjoSGd+F4MCO1J46jfytNo/btzchja0UWrXJQsUHegwGTotjGGKBNzouHWhaOSYr3eFH94J/oxn
9ijSoePGJ34gHi09fQMw/H9VeG0EiiAQP9z6vwe9Qn9rBB+jExh+JAIJ6dttVKCG

--00000000000008223805b3e7120a--

--lGD5e6kJa97KqHxX9ZXs
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5795): https://lists.cip-project.org/g/cip-dev/message=
/5795
Mute This Topic: https://lists.cip-project.org/mt/78204876/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--lGD5e6kJa97KqHxX9ZXs--

Return-Path: <SRS0=WRrn=DX=lists.cip-project.org=bounce+64572+5588+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E96BC433DF
	for <cip-dev@archiver.kernel.org>; Fri, 16 Oct 2020 10:41:14 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 646AE207F7
	for <cip-dev@archiver.kernel.org>; Fri, 16 Oct 2020 10:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="TfIWSbnx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 646AE207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=sanmina.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5588+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id Atp8YY4521723xa1s0R1u629; Fri, 16 Oct 2020 03:41:12 -0700
X-Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
 by mx.groups.io with SMTP id smtpd.web12.12621.1602843972451372577
 for <cip-dev@lists.cip-project.org>;
 Fri, 16 Oct 2020 03:26:12 -0700
X-Received: by mail-qk1-f179.google.com with SMTP id h140so1513633qke.7
        for <cip-dev@lists.cip-project.org>; Fri, 16 Oct 2020 03:26:12 -0700 (PDT)
X-Gm-Message-State: m13oMWYPElfOUjfSwEDyCAU7x4520388AA=
X-Google-Smtp-Source: ABdhPJzNDUv51xpfpO+w2n0bIPu94JsnfUg7pAIGnKv6v0GhfPxmrbYELvaG8VN8sToWhxYZlc4jMIJt+aj7N+vR3ME=
X-Received: by 2002:ae9:e711:: with SMTP id m17mr3015670qka.255.1602843970126;
 Fri, 16 Oct 2020 03:26:10 -0700 (PDT)
MIME-Version: 1.0
From: Rajashree Sankar <rajashree.sankar@sanmina.com>
Date: Fri, 16 Oct 2020 15:55:31 +0530
Message-ID: <CA+UxhRrWr_1VNmcrujPKjPWxoZw47XCSpGY2sqbkein2vHtYug@mail.gmail.com>
Subject: [cip-dev] Camera CSI support for IMX
To: cip-dev@lists.cip-project.org
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="TXdHOIxiIwPGCLkDCtba"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1602844872;
 bh=B+r7Bo/zGhVK53oZU6ApqxGOB/QvgAsXAOUMHK6zLsE=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=TfIWSbnxw891RBmUax3U1iNGwDwg4D7n4hRcrbVx1OvPjwJto5JxXtuRlz0RrMvmZlf
 ydSkuLDKNnX+0UDZ6juhKjPRrd1znQpfEhebb0Hbgdmj7GJbu7IRkyRnpBhjt+o4P31a+
 1MIhF7mdwaxh/LiCdYVzUl9c3IZZpk4ZtXk=

--TXdHOIxiIwPGCLkDCtba
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000008e480f05b1c731a5"

--0000000000008e480f05b1c731a5
Content-Type: multipart/alternative; boundary="0000000000007896a505b1c7315f"

--0000000000007896a505b1c7315f
Content-Type: text/plain; charset="UTF-8"

 Hello,
We are using Linux-CIP Kernel Version 4.19.140-cip33. We do not find IMX
files  in the Kernel supporting Camera Capture through CSI.Could you get
us  how the support can be added?
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

--0000000000007896a505b1c7315f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><span style=3D"color:rgb(80,0,80)">=C2=A0Hello,</span><div=
><span style=3D"color:rgb(80,0,80)">We are using Linux-CIP Kernel Version 4=
.19.140-cip33. We do not find IMX</span><br style=3D"color:rgb(80,0,80)"><s=
pan style=3D"color:rgb(80,0,80)">files=C2=A0 in the Kernel supporting Camer=
a Capture through CSI.Could you get</span><br style=3D"color:rgb(80,0,80)">=
<span style=3D"color:rgb(80,0,80)">us=C2=A0 how the support can be added?</=
span><br clear=3D"all"><div><div dir=3D"ltr" class=3D"gmail_signature" data=
-smartmail=3D"gmail_signature"><div dir=3D"ltr">Thanks and Regards,<div>Raj=
ashree Sankar</div></div></div></div></div></div>

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

--0000000000007896a505b1c7315f--

--0000000000008e480f05b1c731a5
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIHxiLsemf3h+rbcyerfyaQu0JiCcFAPc
tGB0sRxkj0i8MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIwMTAx
NjEwMjYxMVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQBdc+k2jZl9FGSqxzoQihvE7jXXuyR+zqydW6FONfLnWa3Culux
QR8qTYXei+xfIUeHRPClCjZMiEMO5cF8IOmcO1sJERofXaZo6/fB3RwiYpTJGsAYLyC3Cjmg7lKW
YxLVseKHGdj8i0mm9Nlq3AiFhxtX522xE+FZtsu5kV9WoW2Dg8spiUVyDQBirBs6EbFDUrD67rL4
A/AUwUXNZ3lYu9Az55TAJVhf8AKeLDRfETUcHbw5aD05IXxfQQhW0jXfqdH3phZnB0s3eB8s3kR4
MfHgI9v46by92X23+9ntWANgfG+tlKinXOahrvLcqUna4AQbyxCVvURV8jVdHvvK

--0000000000008e480f05b1c731a5--

--TXdHOIxiIwPGCLkDCtba
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5588): https://lists.cip-project.org/g/cip-dev/message=
/5588
Mute This Topic: https://lists.cip-project.org/mt/77547893/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--TXdHOIxiIwPGCLkDCtba--

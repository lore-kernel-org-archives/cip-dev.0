Return-Path: <SRS0=i2+r=LL=lists.cip-project.org=bounce+64572+6529+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C54C2B9F4
	for <cip-dev@archiver.kernel.org>; Thu, 17 Jun 2021 10:55:48 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CC12613C1
	for <cip-dev@archiver.kernel.org>; Thu, 17 Jun 2021 10:55:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CC12613C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=sanmina.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6529+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id LaKoYY4521723x2IrWNbm77P; Thu, 17 Jun 2021 03:55:48 -0700
X-Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
 by mx.groups.io with SMTP id smtpd.web08.4183.1623911453325566722
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Jun 2021 23:30:53 -0700
X-Received: by mail-pg1-f178.google.com with SMTP id v7so4126061pgl.2
        for <cip-dev@lists.cip-project.org>; Wed, 16 Jun 2021 23:30:53 -0700 (PDT)
X-Gm-Message-State: ws6jfxfMSh5CLQpgeANxrX7xx4520388AA=
X-Google-Smtp-Source: ABdhPJxX1WaIlZyxcbGclLFL7Jh0bJrbzNWTEMIcAUJ95DzVUKLWvqOqQ3kD12d4GnqPHnyAxD2LzZqh1kBxE8WXs3o=
X-Received: by 2002:a63:e343:: with SMTP id o3mr3486470pgj.416.1623911452346;
 Wed, 16 Jun 2021 23:30:52 -0700 (PDT)
MIME-Version: 1.0
From: Lakshmi Natarajan <lakshmi.natarajan@sanmina.com>
Date: Thu, 17 Jun 2021 12:00:41 +0530
Message-ID: <CAMbjpb_3E0-528zAOnKQRTBQTf+xf4vptPOtQLmBWKptgbvkQw@mail.gmail.com>
Subject: [cip-dev] Request support to switch the CIP version
To: cip-dev@lists.cip-project.org
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="UUmwUot52Xe4fbOdouf5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1623927348;
 bh=vIXjXzu807A7TTIysV4EtewZle6J0exwGYMIIb/GoO0=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=hirrMdWFibYjOwR4YRFfcrB4BwUbXR2lcK58+wgUT1EhSu5wu2AEpDsQ8ZU9H1jGi/p
 XB74ovmwC7WAhm61BsjHPlB6FporkVOQR3B3id+4CwNyUqR7B8O71tUDjgWijHxZqkmZc
 CB80J09hDb3AGI/eapXDmxi2jmI5BDghRDU=

--UUmwUot52Xe4fbOdouf5
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000004b3ba505c4f059b5"

--0000000000004b3ba505c4f059b5
Content-Type: multipart/alternative; boundary="00000000000043cc2305c4f0591d"

--00000000000043cc2305c4f0591d
Content-Type: text/plain; charset="UTF-8"

Hello,

We are currently using CIP Linux Kernel version 4.19. 140-cip33 in our
Linux open source platform (ISAR).
We have to switch to revision * 4.19.186.*
Can you point us to the link to use in the .bb file and the SHA value for
the same?
We are getting SHA failure when we try to download from this link
<https://gitlab.com/cip-project/cip-kernel/linux-cip/-/archive/v4.19.186-cip47/linux-cip-v4.19.186-cip47.tar.gz>
.

Regards,
Lakshmi

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

--00000000000043cc2305c4f0591d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,<div><br></div><div>We are currently using CIP Linux=
 Kernel version 4.19. 140-cip33 in our Linux open source platform (ISAR).</=
div><div>We have to switch to revision=C2=A0<b><u>

<span style=3D"color:rgb(32,33,36);font-family:Roboto,sans-serif;font-size:=
14px;white-space:pre-wrap;background-color:rgb(248,249,250)">4.19.186.</spa=
n></u></b><br></div><div><span style=3D"color:rgb(32,33,36);font-family:Rob=
oto,sans-serif;font-size:14px;white-space:pre-wrap;background-color:rgb(248=
,249,250)">Can you point us to the link to use in the .bb file and the SHA =
value for the same?</span></div><div><span style=3D"color:rgb(32,33,36);fon=
t-family:Roboto,sans-serif;font-size:14px;white-space:pre-wrap;background-c=
olor:rgb(248,249,250)">We are getting SHA failure when we try to download f=
rom this <a href=3D"https://gitlab.com/cip-project/cip-kernel/linux-cip/-/a=
rchive/v4.19.186-cip47/linux-cip-v4.19.186-cip47.tar.gz">link</a>.</span></=
div><div><font color=3D"#202124" face=3D"Roboto, sans-serif"><span style=3D=
"font-size:14px;white-space:pre-wrap"><b><u><br clear=3D"all"></u></b></spa=
n></font><div><div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"=
gmail_signature"><div dir=3D"ltr">Regards,<div>Lakshmi</div></div></div></d=
iv></div></div>

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

--00000000000043cc2305c4f0591d--

--0000000000004b3ba505c4f059b5
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBXowggRioAMCAQICDBnCDFOqLVrDUzBGfzANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMDEyMTIwNzM1MzdaFw0yMjA2MjkwMjAyNTJaMIG4
MQswCQYDVQQGEwJVUzETMBEGA1UECBMKQ2FsaWZvcm5pYTERMA8GA1UEBxMIU2FuIEpvc2UxHDAa
BgNVBAoTE1Nhbm1pbmEgQ29ycG9yYXRpb24xDTALBgNVBAsTBEkuVC4xJjAkBgNVBAMMHWxha3No
bWkubmF0YXJhamFuQHNhbm1pbmEuY29tMSwwKgYJKoZIhvcNAQkBFh1sYWtzaG1pLm5hdGFyYWph
bkBzYW5taW5hLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAM8VYNDjkttYWVnE
hHQtypjagA0RDa+/zAnT8qrSemjBZgWraVzgothgofebXt7fGTfnjBAFV/rsFQ3pX5nCZS3zFFA2
SK+DUpJ6HIjxWCcS2jkD7sOQEYeQAOYSPaDRMI7cH5BH3lkdkuGTPm2z17GnUa1tEBW4+bWms0tQ
VPcZCG74qHEacp9nTtfnfAWTeFRuRhAfTHSZjCD+/sUfH7UIs7QZj1Iux6PG5zRnd4AXo/66RIf6
cK7+OcWwNQvNmhLrBB4vYzifMpYQv64Ddxcj1S7bKRlvrgY2u2ilDxjXzL1X5iaz8WB76pMwaxzJ
TFcbW2vOCwsCTXqJsp7iYjcCAwEAAaOCAd4wggHaMA4GA1UdDwEB/wQEAwIFoDCBowYIKwYBBQUH
AQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5jb20vY2FjZXJ0
L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcwAYY1aHR0cDovL29jc3Au
Z2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAwTQYDVR0gBEYwRDBCBgor
BgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9z
aXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDovL2NybC5nbG9iYWxzaWdu
LmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwKAYDVR0RBCEwH4EdbGFrc2htaS5u
YXRhcmFqYW5Ac2FubWluYS5jb20wEwYDVR0lBAwwCgYIKwYBBQUHAwQwHwYDVR0jBBgwFoAUljPR
5lgXWzR1ioFWZNW+SN6hj88wHQYDVR0OBBYEFNh77DsxaQ3xMU0Jn33NzdmblDvrMA0GCSqGSIb3
DQEBCwUAA4IBAQBtyiYk0PkvqJSOybmGDQwGrL6AhqiV3YGIGtPjL7/iBtEjRw0RWbi5LjKw0gff
SQkDaB7vwcqIKjgNpoml/UwrZvQdgQISH/climjYnz/PdjqyTT9PoYOTN0dGNX/NFMrpeVL7ro2d
q6AzdtlJD09xH28sV5gcW/gP9KDsa1+U7nWJkEyapYjZA2d5XkvwRet0qbMUhYiwlamAD5jhP0qr
viFxOg9XcUnWm5sDxo2Qk0jDrb74Wr8sZGy9k1HJ9sVC2ijKajAlkkXFCGsyVZD3kGchabTtNok3
9jkkXCJJSA2wZeBXtqiaREk8xoolBgosgKXW0BsEeXY2ZEeCPoVcMYICbTCCAmkCAQEwazBbMQsw
CQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2ln
biBHQ0MgUjMgUGVyc29uYWxTaWduIDIgQ0EgMjAyMAIMGcIMU6otWsNTMEZ/MA0GCWCGSAFlAwQC
AQUAoIHUMC8GCSqGSIb3DQEJBDEiBCD1dptZEmDGbiFWcdMIkmHs4Ed9bNJ1utXSCGFSGOxqpDAY
BgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMTA2MTcwNjMwNTJaMGkG
CSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYI
KoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEAutwa24fYOYpT2ladUngowWZ9YKog8g60CBd5zo/1SQVvO6Y20k1j4pYPgVBODf6e
89s2XKQU5tuyDGCs4qsdBirKVkQXPU4Ys8+2C4cg2jGv/V6YRasXSOhNMmc23heFg56sico5jHLy
EQV0yPUyFNEdt+NS88Kr1iyPP4uM16IQP1T0dCFhIXrBKCtL5aj6/NMcjiX72CG7NcJRcfguLKJt
ek1DCAm2pRVxtODZvPW438/IHN9acuxEx/2KDt179XimGO/FbQmFl7dbwrkwys4Dx2Pzmt9ARXOo
tJK9fQZhkS+R5F0HOSEm/vn4cG7lGS2cP+XKNhjcq5r1JgxnfQ==

--0000000000004b3ba505c4f059b5--

--UUmwUot52Xe4fbOdouf5
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6529): https://lists.cip-project.org/g/cip-dev/message=
/6529
Mute This Topic: https://lists.cip-project.org/mt/83601368/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--UUmwUot52Xe4fbOdouf5--

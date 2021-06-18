Return-Path: <SRS0=Sc8O=LN=lists.cip-project.org=bounce+64572+6542+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 952B5C48BDF
	for <cip-dev@archiver.kernel.org>; Sat, 19 Jun 2021 02:06:14 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D0426113E
	for <cip-dev@archiver.kernel.org>; Sat, 19 Jun 2021 02:06:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D0426113E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=sanmina.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6542+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id GW8oYY4521723xb0Ebj2PWkj; Fri, 18 Jun 2021 19:06:12 -0700
X-Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
 by mx.groups.io with SMTP id smtpd.web12.5269.1624005346871096272
 for <cip-dev@lists.cip-project.org>;
 Fri, 18 Jun 2021 01:35:47 -0700
X-Received: by mail-pj1-f48.google.com with SMTP id bb20so1144789pjb.3
        for <cip-dev@lists.cip-project.org>; Fri, 18 Jun 2021 01:35:46 -0700 (PDT)
X-Gm-Message-State: 0ImCY6ikU2WSTxy3wZOEcpNQx4520388AA=
X-Google-Smtp-Source: ABdhPJy9Zgb88Mt6IcgshNKcrrWw95WzC9Huod18nXMALudb9evXPCvTM4kzmcSckaWJSS7mR7pwwSUtXTf+YJ++3pQ=
X-Received: by 2002:a17:902:f2c1:b029:121:ffc0:91d0 with SMTP id
 h1-20020a170902f2c1b0290121ffc091d0mr201800plc.31.1624005345868; Fri, 18 Jun
 2021 01:35:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAMbjpb_3E0-528zAOnKQRTBQTf+xf4vptPOtQLmBWKptgbvkQw@mail.gmail.com>
In-Reply-To: <CAMbjpb_3E0-528zAOnKQRTBQTf+xf4vptPOtQLmBWKptgbvkQw@mail.gmail.com>
From: Lakshmi Natarajan <lakshmi.natarajan@sanmina.com>
Date: Fri, 18 Jun 2021 14:05:34 +0530
Message-ID: <CAMbjpb81VNbH31anZiaBH2B9wV_1Qaegwp8+JehLfTGKbMzb+g@mail.gmail.com>
Subject: Re: [cip-dev] Request support to switch the CIP version
To: cip-dev@lists.cip-project.org
Cc: Rajashree Sankar <rajashree.sankar@sanmina.com>
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="22SArgku1GfOgktT89oz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1624068372;
 bh=tDU/q6/f9j8btclMm19zNxV3KW92xe6JFrz5cHFIB68=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=uxGQ4YffVBRziMy7WQ4R8s6hdD/mM9gAxXJLmMqorR8OSwRTkFPUyZNzg2cDySVI148
 jexv9ZzVFU4R1U13H3Yp/+GX7x/kSsePkoXUemqtzGT1nYbSOG1UQyTN+vBloLCvByPvT
 B3dCzfqipaJz77YoedPNl67/xNmR1Dfkmi8=

--22SArgku1GfOgktT89oz
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000c71bc705c5063568"

--000000000000c71bc705c5063568
Content-Type: multipart/alternative; boundary="000000000000c1a73e05c50635b5"

--000000000000c1a73e05c50635b5
Content-Type: text/plain; charset="UTF-8"

Hello,

Can you please support with the below query where we are looking to switch
to a different CIP kernel revision.

Regards,
Lakshmi


On Thu, Jun 17, 2021 at 12:00 PM Lakshmi Natarajan <
lakshmi.natarajan@sanmina.com> wrote:

> Hello,
>
> We are currently using CIP Linux Kernel version 4.19. 140-cip33 in our
> Linux open source platform (ISAR).
> We have to switch to revision * 4.19.186.*
> Can you point us to the link to use in the .bb file and the SHA value for
> the same?
> We are getting SHA failure when we try to download from this link
> <https://gitlab.com/cip-project/cip-kernel/linux-cip/-/archive/v4.19.186-cip47/linux-cip-v4.19.186-cip47.tar.gz>
> .
>
> Regards,
> Lakshmi
>

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

--000000000000c1a73e05c50635b5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,<div><br></div><div>Can you please support with the =
below query where we are looking to switch to a different CIP kernel revisi=
on.</div><div><br clear=3D"all"><div><div dir=3D"ltr" class=3D"gmail_signat=
ure" data-smartmail=3D"gmail_signature"><div dir=3D"ltr">Regards,<div>Laksh=
mi</div></div></div></div><br></div></div><br><div class=3D"gmail_quote"><d=
iv dir=3D"ltr" class=3D"gmail_attr">On Thu, Jun 17, 2021 at 12:00 PM Lakshm=
i Natarajan &lt;<a href=3D"mailto:lakshmi.natarajan@sanmina.com">lakshmi.na=
tarajan@sanmina.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex"><div dir=3D"ltr">Hello,<div><br></div><div>We are curren=
tly using CIP Linux Kernel version 4.19. 140-cip33 in our Linux open source=
 platform (ISAR).</div><div>We have to switch to revision=C2=A0<b><u>

<span style=3D"color:rgb(32,33,36);font-family:Roboto,sans-serif;font-size:=
14px;white-space:pre-wrap;background-color:rgb(248,249,250)">4.19.186.</spa=
n></u></b><br></div><div><span style=3D"color:rgb(32,33,36);font-family:Rob=
oto,sans-serif;font-size:14px;white-space:pre-wrap;background-color:rgb(248=
,249,250)">Can you point us to the link to use in the .bb file and the SHA =
value for the same?</span></div><div><span style=3D"color:rgb(32,33,36);fon=
t-family:Roboto,sans-serif;font-size:14px;white-space:pre-wrap;background-c=
olor:rgb(248,249,250)">We are getting SHA failure when we try to download f=
rom this <a href=3D"https://gitlab.com/cip-project/cip-kernel/linux-cip/-/a=
rchive/v4.19.186-cip47/linux-cip-v4.19.186-cip47.tar.gz" target=3D"_blank">=
link</a>.</span></div><div><font color=3D"#202124" face=3D"Roboto, sans-ser=
if"><span style=3D"font-size:14px;white-space:pre-wrap"><b><u><br clear=3D"=
all"></u></b></span></font><div><div dir=3D"ltr"><div dir=3D"ltr">Regards,<=
div>Lakshmi</div></div></div></div></div></div>
</blockquote></div>

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

--000000000000c1a73e05c50635b5--

--000000000000c71bc705c5063568
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
AQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDmQcyUEbTyG9vfBaEh1Eum06iPuqgebD5FV4sA2DzujjAY
BgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMTA2MTgwODM1NDZaMGkG
CSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYI
KoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEAoQy9tKsGNU6N//4xtYorm3lG7Uxt4IDiBnQ0Ywr/7Eic/UCd7Bpi70s7y2iwQ9MH
1utJQfQC4vT+g8lU69CEanw4TQ8QhJS7mNK3MzJiMnbiquSZjAa86BoZdslzox/wzdk86isjiu6H
xRSGe259uLGVl6ZIzJBnuqLKOgEK+6Iw1QjvXz+Lm7eMDTZJ8BQuJmCpnD/wmIZw7MoWdfKLa0m9
F8aM+wRyi7jWFkmWKsbMVnHX/0xDdNGEs19Z9cTPe7rHYjuaieB+eLWf7Y4oD1QV+fIQmVYTDhs+
qiizJVjxK8w7pMZoC/I9XFSz2dz1ErwHNkxdZZyQdfmLyFDXvQ==

--000000000000c71bc705c5063568--

--22SArgku1GfOgktT89oz
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6542): https://lists.cip-project.org/g/cip-dev/message=
/6542
Mute This Topic: https://lists.cip-project.org/mt/83601368/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--22SArgku1GfOgktT89oz--

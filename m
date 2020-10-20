Return-Path: <SRS0=ncx9=D3=lists.cip-project.org=bounce+64572+5595+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A80FC433E7
	for <cip-dev@archiver.kernel.org>; Tue, 20 Oct 2020 12:19:59 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A78D822253
	for <cip-dev@archiver.kernel.org>; Tue, 20 Oct 2020 12:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="rWzCiov9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A78D822253
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=sanmina.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5595+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 0OFXYY4521723xQbC8emjqVm; Tue, 20 Oct 2020 05:19:58 -0700
X-Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
 by mx.groups.io with SMTP id smtpd.web09.5094.1603196282863730422
 for <cip-dev@lists.cip-project.org>;
 Tue, 20 Oct 2020 05:18:03 -0700
X-Received: by mail-qv1-f42.google.com with SMTP id de3so744468qvb.5
        for <cip-dev@lists.cip-project.org>; Tue, 20 Oct 2020 05:18:02 -0700 (PDT)
X-Gm-Message-State: 6s2VWhelpKt44gLFp49h9i71x4520388AA=
X-Google-Smtp-Source: ABdhPJxqJORGKsQl39xmynKD2DrJ4lqWlXEg9guCMrYHjblLqYrzMd09VEdBzp8WlBcXbC7J7svW2M2V3G6G6xo4pZ0=
X-Received: by 2002:a0c:b741:: with SMTP id q1mr3004001qve.37.1603196281326;
 Tue, 20 Oct 2020 05:18:01 -0700 (PDT)
MIME-Version: 1.0
References: <CA+UxhRrWr_1VNmcrujPKjPWxoZw47XCSpGY2sqbkein2vHtYug@mail.gmail.com>
 <8ba7cf9c-7f55-7f06-4e34-6f4d92cce821@siemens.com>
In-Reply-To: <8ba7cf9c-7f55-7f06-4e34-6f4d92cce821@siemens.com>
From: Rajashree Sankar <rajashree.sankar@sanmina.com>
Date: Tue, 20 Oct 2020 17:47:14 +0530
Message-ID: <CA+UxhRqONS33a6da-nhRMApuyMeGzHpYstwH3AB83FH5ELALAw@mail.gmail.com>
Subject: Re: [cip-dev] Camera CSI support for IMX
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: cip-dev@lists.cip-project.org, 
	Lakshmi Natarajan <lakshmi.natarajan@sanmina.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="sZnb1qFyP9tlKrs4JwR0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1603196398;
 bh=gJCMOLM4QUzk5jnrYM/1RDzS/RDG1pKADcaRR47HJ04=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=rWzCiov98ChrYbxVF1spiKGK5xwGeQrLXckeLkOhpVtJwSY7hokxY3RJdTAlHGwvPqf
 3kt5z6G0VB7jmjyOTIgMDYRtMfHEHe1WnVOU+jHSvl7o+j5P4Pt1VErF0TK0D1ydBBvUk
 kVqhWziGAT/rkVz5gcKHwiJ3nEo5iWOKi/o=

--sZnb1qFyP9tlKrs4JwR0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000e7a44b05b2193876"

--000000000000e7a44b05b2193876
Content-Type: multipart/mixed; boundary="000000000000db76e905b219382f"

--000000000000db76e905b219382f
Content-Type: multipart/alternative; boundary="000000000000db76e505b219382d"

--000000000000db76e505b219382d
Content-Type: text/plain; charset="UTF-8"

Hello Jan,
We have used Yocto Framework provided by NXP from the following link
<https://www.nxp.com/design/development-boards/i-mx-evaluation-and-development-boards/evaluation-kit-for-the-i-mx-6ull-and-6ulz-applications-processor:MCIMX6ULL-EVK?fpsp=1#documentsandsoftware>.Refer
to the Document L4.19.35_1.1.0_LINUX_DOCS
<https://www.nxp.com/webapp/Download?colCode=L4.19.35_1.1.0_LINUX_DOCS>  in
the above mentioned link.
The DT-bindings and the IMX Camera capture information will be available by
following the steps mentioned in the document
i.MX_Yocto_Project_User's_Guide from the above link.
The Kernel which we are using is fetched from the bitbake files attached
below( linux-yocto_4.19.bb and its append).Could you please let us know
whether CSI  Camera capture supported in this kernel be included in the
Linux CIP?

Thanks and Regards,
Rajashree Sankar

>
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

--000000000000db76e505b219382d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello Jan,<div>We have used Yocto Framework provided by NX=
P from the following=C2=A0<a href=3D"https://www.nxp.com/design/development=
-boards/i-mx-evaluation-and-development-boards/evaluation-kit-for-the-i-mx-=
6ull-and-6ulz-applications-processor:MCIMX6ULL-EVK?fpsp=3D1#documentsandsof=
tware" target=3D"_blank">link</a>.Refer to the Document=C2=A0<h3 style=3D"b=
ox-sizing:border-box;font-family:Arial,sans-serif;line-height:1.1;color:rgb=
(32,39,45);margin-top:0px;margin-bottom:11px;font-size:16px;font-weight:400=
"><a href=3D"https://www.nxp.com/webapp/Download?colCode=3DL4.19.35_1.1.0_L=
INUX_DOCS" id=3D"m_6906828438111408434gmail-m_3608227123783273889gmail-docs=
AndSoftware_documentResultTitle3_7" style=3D"color:rgb(33,91,214);box-sizin=
g:border-box;background-color:transparent;outline:0px" target=3D"_blank">L4=
.19.35_1.1.0_LINUX_DOCS</a>=C2=A0 in the above mentioned link.</h3><div>The=
 DT-bindings and the IMX Camera capture information will be available by fo=
llowing the steps mentioned in the document i.MX_Yocto_Project_User&#39;s_G=
uide from the above link.</div><div>The Kernel which we are using is fetche=
d from the bitbake files attached below( <a href=3D"http://linux-yocto_4.19=
.bb" target=3D"_blank">linux-yocto_4.19.bb</a> and its append).Could you pl=
ease let us know whether CSI=C2=A0 Camera capture supported in this kernel =
be included in the Linux CIP?</div><div><br></div></div><div><div dir=3D"lt=
r" data-smartmail=3D"gmail_signature"><div dir=3D"ltr">Thanks and Regards,<=
div>Rajashree Sankar</div></div></div></div><div class=3D"gmail_quote"><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex"><br>
</blockquote></div></div>

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

--000000000000db76e505b219382d--

--000000000000db76e905b219382f
Content-Type: application/octet-stream; name="linux-yocto_4.19.bb"
Content-Disposition: attachment; filename="linux-yocto_4.19.bb"
Content-Transfer-Encoding: base64
Content-ID: <f_kghxf30m0>
X-Attachment-Id: f_kghxf30m0

S0JSQU5DSCA/PSAidjQuMTkvc3RhbmRhcmQvYmFzZSIKCnJlcXVpcmUgcmVjaXBlcy1rZXJuZWwv
bGludXgvbGludXgteW9jdG8uaW5jCgojIGJvYXJkIHNwZWNpZmljIGJyYW5jaGVzCktCUkFOQ0hf
cWVtdWFybSAgPz0gInY0LjE5L3N0YW5kYXJkL2FybS12ZXJzYXRpbGUtOTI2ZWpzIgpLQlJBTkNI
X3FlbXVhcm02NCA/PSAidjQuMTkvc3RhbmRhcmQvcWVtdWFybTY0IgpLQlJBTkNIX3FlbXVtaXBz
ID89ICJ2NC4xOS9zdGFuZGFyZC9tdGktbWFsdGEzMiIKS0JSQU5DSF9xZW11cHBjICA/PSAidjQu
MTkvc3RhbmRhcmQvcWVtdXBwYyIKS0JSQU5DSF9xZW11eDg2ICA/PSAidjQuMTkvc3RhbmRhcmQv
YmFzZSIKS0JSQU5DSF9xZW11eDg2LTY0ID89ICJ2NC4xOS9zdGFuZGFyZC9iYXNlIgpLQlJBTkNI
X3FlbXVtaXBzNjQgPz0gInY0LjE5L3N0YW5kYXJkL210aS1tYWx0YTY0IgoKU1JDUkVWX21hY2hp
bmVfcWVtdWFybSA/PSAiYzEyYmMxYTA5OGJlMDA5YzQ0NTgyZTc1YWY2MzBmZjU3MzE1NTQ3MyIK
U1JDUkVWX21hY2hpbmVfcWVtdWFybTY0ID89ICJmMGM2Yzg1ZTE1NTYzMjU4MGJkNDRhNWRiMDFj
YmIxOWRjYzE1NTljIgpTUkNSRVZfbWFjaGluZV9xZW11bWlwcyA/PSAiMThiYTcxNjBhYzdhMDk0
YmY5NjU5NjQ5YzUzNzMwMzIwMWViMDIyZSIKU1JDUkVWX21hY2hpbmVfcWVtdXBwYyA/PSAiZjBj
NmM4NWUxNTU2MzI1ODBiZDQ0YTVkYjAxY2JiMTlkY2MxNTU5YyIKU1JDUkVWX21hY2hpbmVfcWVt
dXg4NiA/PSAiZjBjNmM4NWUxNTU2MzI1ODBiZDQ0YTVkYjAxY2JiMTlkY2MxNTU5YyIKU1JDUkVW
X21hY2hpbmVfcWVtdXg4Ni02NCA/PSAiZjBjNmM4NWUxNTU2MzI1ODBiZDQ0YTVkYjAxY2JiMTlk
Y2MxNTU5YyIKU1JDUkVWX21hY2hpbmVfcWVtdW1pcHM2NCA/PSAiZDljNzdmZTJhNjAzODg0OGZi
YWRkNjYwODgyYjc4ZTU5MGMzMjUyZSIKU1JDUkVWX21hY2hpbmUgPz0gImYwYzZjODVlMTU1NjMy
NTgwYmQ0NGE1ZGIwMWNiYjE5ZGNjMTU1OWMiClNSQ1JFVl9tZXRhID89ICJhZDIzNWRiNDYxYmY0
NTk1YzY2ODcwMGNhOGE5MDljMzIyMDA5Y2MxIgoKU1JDX1VSSSA9ICJnaXQ6Ly9naXQueW9jdG9w
cm9qZWN0Lm9yZy9saW51eC15b2N0by5naXQ7bmFtZT1tYWNoaW5lO2JyYW5jaD0ke0tCUkFOQ0h9
OyBcCiAgICAgICAgICAgZ2l0Oi8vZ2l0LnlvY3RvcHJvamVjdC5vcmcveW9jdG8ta2VybmVsLWNh
Y2hlO3R5cGU9a21ldGE7bmFtZT1tZXRhO2JyYW5jaD15b2N0by00LjE5O2Rlc3RzdWZmaXg9JHtL
TUVUQX0gXAogICAgICAgICAgIgoKTElDX0ZJTEVTX0NIS1NVTSA9ICJmaWxlOi8vQ09QWUlORztt
ZDU9YmJlYTgxNWVlMjc5NWIyZjQyMzA4MjZjMGM2Yjg4MTQiCkxJTlVYX1ZFUlNJT04gPz0gIjQu
MTkuNDQiCgpERVBFTkRTICs9ICIke0BiYi51dGlscy5jb250YWlucygnQVJDSCcsICd4ODYnLCAn
ZWxmdXRpbHMtbmF0aXZlJywgJycsIGQpfSIKREVQRU5EUyArPSAib3BlbnNzbC1uYXRpdmUgdXRp
bC1saW51eC1uYXRpdmUiCgpQViA9ICIke0xJTlVYX1ZFUlNJT059K2dpdCR7U1JDUFZ9IgoKS01F
VEEgPSAia2VybmVsLW1ldGEiCktDT05GX0JTUF9BVURJVF9MRVZFTCA9ICIyIgoKS0VSTkVMX0RF
VklDRVRSRUVfcWVtdWFybSA9ICJ2ZXJzYXRpbGUtcGIuZHRiIgoKQ09NUEFUSUJMRV9NQUNISU5F
ID0gInFlbXVhcm18cWVtdWFybXY1fHFlbXVhcm02NHxxZW11eDg2fHFlbXVwcGN8cWVtdW1pcHN8
cWVtdW1pcHM2NHxxZW11eDg2LTY0IgoKIyBGdW5jdGlvbmFsaXR5IGZsYWdzCktFUk5FTF9FWFRS
QV9GRUFUVVJFUyA/PSAiZmVhdHVyZXMvbmV0ZmlsdGVyL25ldGZpbHRlci5zY2MiCktFUk5FTF9G
RUFUVVJFU19hcHBlbmQgPSAiICR7S0VSTkVMX0VYVFJBX0ZFQVRVUkVTfSIKS0VSTkVMX0ZFQVRV
UkVTX2FwcGVuZF9xZW11YWxsPSIgY2ZnL3ZpcnRpby5zY2MiCktFUk5FTF9GRUFUVVJFU19hcHBl
bmRfcWVtdXg4Nj0iIGNmZy9zb3VuZC5zY2MgY2ZnL3BhcmF2aXJ0X2t2bS5zY2MiCktFUk5FTF9G
RUFUVVJFU19hcHBlbmRfcWVtdXg4Ni02ND0iIGNmZy9zb3VuZC5zY2MgY2ZnL3BhcmF2aXJ0X2t2
bS5zY2MiCktFUk5FTF9GRUFUVVJFU19hcHBlbmQgPSAiICR7QGJiLnV0aWxzLmNvbnRhaW5zKCJU
VU5FX0ZFQVRVUkVTIiwgIm14MzIiLCAiIGNmZy94MzIuc2NjIiwgIiIgLGQpfSIK

--000000000000db76e905b219382f
Content-Type: application/octet-stream; name="linux-yocto_4.19.bbappend"
Content-Disposition: attachment; filename="linux-yocto_4.19.bbappend"
Content-Transfer-Encoding: base64
Content-ID: <f_kghxffgh1>
X-Attachment-Id: f_kghxffgh1

S0JSQU5DSF9nZW5lcmljeDg2ICA9ICJ2NC4xOS9zdGFuZGFyZC9iYXNlIgpLQlJBTkNIX2dlbmVy
aWN4ODYtNjQgID0gInY0LjE5L3N0YW5kYXJkL2Jhc2UiCktCUkFOQ0hfZWRnZXJvdXRlciA9ICJ2
NC4xOS9zdGFuZGFyZC9lZGdlcm91dGVyIgpLQlJBTkNIX2JlYWdsZWJvbmUteW9jdG8gPSAidjQu
MTkvc3RhbmRhcmQvYmVhZ2xlYm9uZSIKS0JSQU5DSF9tcGM4MzE1ZS1yZGIgPSAidjQuMTkvc3Rh
bmRhcmQvZnNsLW1wYzgzMTVlLXJkYiIKCktNQUNISU5FX2dlbmVyaWN4ODYgPz0gImNvbW1vbi1w
YyIKS01BQ0hJTkVfZ2VuZXJpY3g4Ni02NCA/PSAiY29tbW9uLXBjLTY0IgpLTUFDSElORV9iZWFn
bGVib25lLXlvY3RvID89ICJiZWFnbGVib25lIgoKU1JDUkVWX21hY2hpbmVfZ2VuZXJpY3g4NiAg
ICA/PSAiMTFlMGU2MTZlZDA5NWJiODAxMmUxYjRhMjMxMjU0Yzk2NTZhMDE5MyIKU1JDUkVWX21h
Y2hpbmVfZ2VuZXJpY3g4Ni02NCA/PSAiMTFlMGU2MTZlZDA5NWJiODAxMmUxYjRhMjMxMjU0Yzk2
NTZhMDE5MyIKU1JDUkVWX21hY2hpbmVfZWRnZXJvdXRlciA/PSAiZWViYjUxMzAwYTA3ODA0YTAy
MGVjNDY4YjVmOGM1YmY3MjAxOThkOSIKU1JDUkVWX21hY2hpbmVfYmVhZ2xlYm9uZS15b2N0byA/
PSAiZWViYjUxMzAwYTA3ODA0YTAyMGVjNDY4YjVmOGM1YmY3MjAxOThkOSIKU1JDUkVWX21hY2hp
bmVfbXBjODMxNWUtcmRiID89ICI4YjYwZjk2ODgyMzI1NmY1ZDI4ODljNDUyMGQ3MDI5OWNhMjE0
MTFiIgoKQ09NUEFUSUJMRV9NQUNISU5FX2dlbmVyaWN4ODYgPSAiZ2VuZXJpY3g4NiIKQ09NUEFU
SUJMRV9NQUNISU5FX2dlbmVyaWN4ODYtNjQgPSAiZ2VuZXJpY3g4Ni02NCIKQ09NUEFUSUJMRV9N
QUNISU5FX2VkZ2Vyb3V0ZXIgPSAiZWRnZXJvdXRlciIKQ09NUEFUSUJMRV9NQUNISU5FX2JlYWds
ZWJvbmUteW9jdG8gPSAiYmVhZ2xlYm9uZS15b2N0byIKQ09NUEFUSUJMRV9NQUNISU5FX21wYzgz
MTVlLXJkYiA9ICJtcGM4MzE1ZS1yZGIiCgpMSU5VWF9WRVJTSU9OX2dlbmVyaWN4ODYgPSAiNC4x
OS4xOSIKTElOVVhfVkVSU0lPTl9nZW5lcmljeDg2LTY0ID0gIjQuMTkuMTkiCkxJTlVYX1ZFUlNJ
T05fZWRnZXJvdXRlciA9ICI0LjE5LjE0IgpMSU5VWF9WRVJTSU9OX2JlYWdsZWJvbmUteW9jdG8g
PSAiNC4xOS4xNCIKTElOVVhfVkVSU0lPTl9tcGM4MzE1ZS1yZGIgPSAiNC4xOS4xNCIK

--000000000000db76e905b219382f--

--000000000000e7a44b05b2193876
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIQbQYJKoZIhvcNAQcCoIIQXjCCEFoCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg3CMIIE6DCCA9CgAwIBAgIOSBtqCRO9gCTKXSLwFPMwDQYJKoZIhvcNAQELBQAwTDEgMB4GA1UE
CxMXR2xvYmFsU2lnbiBSb290IENBIC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMT
Ckdsb2JhbFNpZ24wHhcNMTYwNjE1MDAwMDAwWhcNMjQwNjE1MDAwMDAwWjBdMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEzMDEGA1UEAxMqR2xvYmFsU2lnbiBQZXJzb25h
bFNpZ24gMiBDQSAtIFNIQTI1NiAtIEczMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
tpZok2X9LAHsYqMNVL+Ly6RDkaKar7GD8rVtb9nw6tzPFnvXGeOEA4X5xh9wjx9sScVpGR5wkTg1
fgJIXTlrGESmaqXIdPRd9YQ+Yx9xRIIIPu3Jp/bpbiZBKYDJSbr/2Xago7sb9nnfSyjTSnucUcIP
ZVChn6hKneVGBI2DT9yyyD3PmCEJmEzA8Y96qT83JmVH2GaPSSbCw0C+Zj1s/zqtKUbwE5zh8uuZ
p4vC019QbaIOb8cGlzgvTqGORwK0gwDYpOO6QQdg5d03WvIHwTunnJdoLrfvqUg2vOlpqJmqR+nH
9lHS+bEstsVJtZieU1Pa+3LzfA/4cT7XA/pnwwIDAQABo4IBtTCCAbEwDgYDVR0PAQH/BAQDAgEG
MGoGA1UdJQRjMGEGCCsGAQUFBwMCBggrBgEFBQcDBAYIKwYBBQUHAwkGCisGAQQBgjcUAgIGCisG
AQQBgjcKAwQGCSsGAQQBgjcVBgYKKwYBBAGCNwoDDAYIKwYBBQUHAwcGCCsGAQUFBwMRMBIGA1Ud
EwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFGlygmIxZ5VEhXeRgMQENkmdewthMB8GA1UdIwQYMBaA
FI/wS3+oLkUkrk1Q+mOai97i3Ru8MD4GCCsGAQUFBwEBBDIwMDAuBggrBgEFBQcwAYYiaHR0cDov
L29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3RyMzA2BgNVHR8ELzAtMCugKaAnhiVodHRwOi8vY3Js
Lmdsb2JhbHNpZ24uY29tL3Jvb3QtcjMuY3JsMGcGA1UdIARgMF4wCwYJKwYBBAGgMgEoMAwGCisG
AQQBoDIBKAowQQYJKwYBBAGgMgFfMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNp
Z24uY29tL3JlcG9zaXRvcnkvMA0GCSqGSIb3DQEBCwUAA4IBAQConc0yzHxn4gtQ16VccKNm4iXv
6rS2UzBuhxI3XDPiwihW45O9RZXzWNgVcUzz5IKJFL7+pcxHvesGVII+5r++9eqI9XnEKCILjHr2
DgvjKq5Jmg6bwifybLYbVUoBthnhaFB0WLwSRRhPrt5eGxMw51UmNICi/hSKBKsHhGFSEaJQALZy
4HL0EWduE6ILYAjX6BSXRDtHFeUPddb46f5Hf5rzITGLsn9BIpoOVrgS878O4JnfUWQi29yBfn75
HajifFvPC+uqn+rcVnvrpLgsLOYG/64kWX/FRH8+mhVe+mcSX3xsUpcxK9q9vLTVtroU/yJUmEC4
OcH5dQsbHBqjMIIDXzCCAkegAwIBAgILBAAAAAABIVhTCKIwDQYJKoZIhvcNAQELBQAwTDEgMB4G
A1UECxMXR2xvYmFsU2lnbiBSb290IENBIC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNV
BAMTCkdsb2JhbFNpZ24wHhcNMDkwMzE4MTAwMDAwWhcNMjkwMzE4MTAwMDAwWjBMMSAwHgYDVQQL
ExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UEAxMK
R2xvYmFsU2lnbjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMwldpB5BngiFvXAg7aE
yiie/QV2EcWtiHL8RgJDx7KKnQRfJMsuS+FggkbhUqsMgUdwbN1k0ev1LKMPgj0MK66X17YUhhB5
uzsTgHeMCOFJ0mpiLx9e+pZo34knlTifBtc+ycsmWQ1z3rDI6SYOgxXG71uL0gRgykmmKPZpO/bL
yCiR5Z2KYVc3rHQU3HTgOu5yLy6c+9C7v/U9AOEGM+iCK65TpjoWc4zdQQ4gOsC0p6Hpsk+QLjJg
6VfLuQSSaGjlOCZgdbKfd/+RFO+uIEn8rUAVSNECMWEZXriX7613t2Saer9fwRPvm2L7DWzgVGkW
qQPabumDk3F2xmmFghcCAwEAAaNCMEAwDgYDVR0PAQH/BAQDAgEGMA8GA1UdEwEB/wQFMAMBAf8w
HQYDVR0OBBYEFI/wS3+oLkUkrk1Q+mOai97i3Ru8MA0GCSqGSIb3DQEBCwUAA4IBAQBLQNvAUKr+
yAzv95ZURUm7lgAJQayzE4aGKAczymvmdLm6AC2upArT9fHxD4q/c2dKg8dEe3jgr25sbwMpjjM5
RcOO5LlXbKr8EpbsU8Yt5CRsuZRj+9xTaGdWPoO4zzUhw8lo/s7awlOqzJCK6fBdRoyV3XpYKBov
Hd7NADdBj+1EbddTKJd+82cEHhXXipa0095MJ6RMG3NzdvQXmcIfeg7jLQitChws/zyrVQ4PkX42
68NXSb7hLi18YIvDQVETI53O9zJrlAGomecsMx86OyXShkDOOyyGeMlhLxS67ttVb9+E7gUJTb0o
2HLO02JQZR7rkpeDMdmztcpHWD9fMIIFbzCCBFegAwIBAgIMNANW1a8l7mBME3glMA0GCSqGSIb3
DQEBCwUAMF0xCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTMwMQYDVQQD
EypHbG9iYWxTaWduIFBlcnNvbmFsU2lnbiAyIENBIC0gU0hBMjU2IC0gRzMwHhcNMTkwNjMwMTI0
OTI1WhcNMjIwNjMwMTI0OTI1WjCBtjELMAkGA1UEBhMCVVMxEzARBgNVBAgTCkNhbGlmb3JuaWEx
ETAPBgNVBAcTCFNhbiBKb3NlMRwwGgYDVQQKExNTYW5taW5hIENvcnBvcmF0aW9uMQ0wCwYDVQQL
EwRJLlQuMSUwIwYDVQQDDBxyYWphc2hyZWUuc2Fua2FyQHNhbm1pbmEuY29tMSswKQYJKoZIhvcN
AQkBFhxyYWphc2hyZWUuc2Fua2FyQHNhbm1pbmEuY29tMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8A
MIIBCgKCAQEA2tgQ0f4wml1CXfTpRQCfJbZvXn2E9jSPLVg/bW9DSYohYon4hm+idx+TCiyIf8AW
I+SJ8iaq83dOPppjcJV/26gi8yOv1ey6WqgVkIHs3/SJsHOalTlt9Hik13qPk1WTNnyVad4WsAJw
BF6zTK9mGNEp/NQcoaH0QAynclYjNdRWxj/Xu9a7ha85rLOKw9R2vD43UkyvMp5erSfkd9+O3WH2
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIEH/HDm1l63mpICa3ng8O8Bp2GMkw+8l
ONt4aUNwz9iaMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIwMTAy
MDEyMTgwMlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQCKkrTSfy/VXlqfn7GGBoLcBlMN80ZkAuXRvgJ9IkSvx/UysbDt
lZy0xxGqKuole3pXtqVaeU3awXq0+pAmq7mXkbfcg52HUg2DtENpV+Pg2piMvvvuNgozT3/2Cxum
IEyS1VMIa60SLh6KeUKS5lF22CtRDetyUEW1TudY/b8ACsvnApTcR3/N+sggJXX8lXlKBDTvYWPf
pqkE1UUn76zzl6zn8O93mw9ErPtjwGVqKx5MYzm+I5LgpPevezqWTUWPf4HO3Y4Dc11nWMLvzl7K
zvUHtrOv6zTwIBzPB61xpTl5WQ2Ch63Cy6LUHecxuQFI7BE6bLBSBP7xNCieL0Sf

--000000000000e7a44b05b2193876--

--sZnb1qFyP9tlKrs4JwR0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5595): https://lists.cip-project.org/g/cip-dev/message=
/5595
Mute This Topic: https://lists.cip-project.org/mt/77547893/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--sZnb1qFyP9tlKrs4JwR0--

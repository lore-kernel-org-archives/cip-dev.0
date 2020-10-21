Return-Path: <SRS0=l/xm=D4=lists.cip-project.org=bounce+64572+5632+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B42F8C388F9
	for <cip-dev@archiver.kernel.org>; Wed, 21 Oct 2020 11:21:57 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9F3D21741
	for <cip-dev@archiver.kernel.org>; Wed, 21 Oct 2020 11:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="pYuC/b+Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9F3D21741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=sanmina.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5632+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id JsnvYY4521723xZo8GshgkeA; Wed, 21 Oct 2020 04:21:55 -0700
X-Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
 by mx.groups.io with SMTP id smtpd.web09.10156.1603278716672568717
 for <cip-dev@lists.cip-project.org>;
 Wed, 21 Oct 2020 04:11:56 -0700
X-Received: by mail-pf1-f180.google.com with SMTP id b26so1291291pff.3
        for <cip-dev@lists.cip-project.org>; Wed, 21 Oct 2020 04:11:56 -0700 (PDT)
X-Gm-Message-State: y6TcnWiohtQgFkI73Q6Nb2BPx4520388AA=
X-Google-Smtp-Source: ABdhPJyGuliLq4VcR2mOQiknegTrCrp5OdInYh8vQAFSVEnw+3fcqF/gRiRCXDbIf/cR4q1d0fyawnlxCyGYb++pPCA=
X-Received: by 2002:aa7:988c:0:b029:155:c0e4:fb35 with SMTP id
 r12-20020aa7988c0000b0290155c0e4fb35mr3105999pfl.47.1603278716017; Wed, 21
 Oct 2020 04:11:56 -0700 (PDT)
MIME-Version: 1.0
References: <CA+UxhRrWr_1VNmcrujPKjPWxoZw47XCSpGY2sqbkein2vHtYug@mail.gmail.com>
 <8ba7cf9c-7f55-7f06-4e34-6f4d92cce821@siemens.com> <CA+UxhRqONS33a6da-nhRMApuyMeGzHpYstwH3AB83FH5ELALAw@mail.gmail.com>
 <CAMbjpb-YqOOFvRc50aw-1uqpmnTgbAi9VGzs4k2t21ScsUG-bw@mail.gmail.com> <8dccd65c-1539-0ef6-3a3f-3978874c14de@siemens.com>
In-Reply-To: <8dccd65c-1539-0ef6-3a3f-3978874c14de@siemens.com>
From: Lakshmi Natarajan <lakshmi.natarajan@sanmina.com>
Date: Wed, 21 Oct 2020 16:41:44 +0530
Message-ID: <CAMbjpb_Y71ybMOOX-XFLzNEjTPfPFJoUaRDEDn99YH4uZSVmJg@mail.gmail.com>
Subject: Re: [cip-dev] Request for Camera CSI support for IMX
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Rajashree Sankar <rajashree.sankar@sanmina.com>, cip-dev@lists.cip-project.org
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="qBscsipIjopeXpNNXofJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1603279315;
 bh=q+PsNgd8paonSp7b6stE0I9hKWvii8h4gZLx6NIV9JA=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=pYuC/b+YbtzUoFB2IJzXaWtqPiiYCNr6fthVYCGdX3W30R384Y3uuy2qzZvOfYf5D1O
 9xcu4mdF+PUzCE4fG1SSAW0HW9LrlBYmthX+VwrESM4DrfwWpMFQqwvKpAZbNTVBAlMLx
 EjPHp62whF/vFBDbYnx8HZpV/wbhNAPKe94=

--qBscsipIjopeXpNNXofJ
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000005e5a0405b22c6a50"

--0000000000005e5a0405b22c6a50
Content-Type: multipart/alternative; boundary="00000000000058846705b22c6a50"

--00000000000058846705b22c6a50
Content-Type: text/plain; charset="UTF-8"

Hello Jan,

Thanks for the details. This gives us an idea on what we could do next.
Thanks for your immediate support. We will get in touch with NXP for this.

Regards,
Lakshmi


On Wed, Oct 21, 2020 at 4:27 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:

> Hi Lakshmi,
>
> On 21.10.20 11:50, Lakshmi Natarajan wrote:
> > Hello Jan,
> >
> > This is regarding requests for CSI support in the IMX processor.
> > We were using Yocto + NXP provided kernel to use the CSI peripheral of
> > the IMX6 processor. We have complete support from NXP for their kernel
> > along with the Yocto framework.
> > We want to move to CIP 4.19 + ISAR framework.
> > When we checked CIP kernel 4.19 - there was no support for CSI interface
> > as well as there were some differences in the arch support too.
> > After study of the NXP provided framework, we found that they use the
> > kernel from https://source.codeaurora.org/external/imx/linux-imxand
> > commit ID 0f9917c56d5995e1dc3bde5658e2d7bc865464de.
> > Even linux kernel 5.9 doesn't have the imx specific support.
>
> That's unfortunate.
>
> > Can you guide us on how we should proceed with the same - will it be
> > possible for CIP to add IMX support (or) should we request NXP to add
> > the patch for CIP kernel 4.19
>
> Yes, please reach out to NXP and ask what their answer for upstream is,
> today or at least for the future. It's their issue in the first place.
> Also for that, you should prepare with naming the kernel interfaces or
> drivers you need in more details.
>
> If NXP cannot or do not want to answer this appropriately, plan B) will
> be identifying the patches they provide on top of the upstream kernel,
> optimally 4.19. Those patches then needs to be applied on top of the CIP
> kernel but, as they are unfortunately downstream only, you will then
> have to maintain them for your product and can't propose them for the
> CIP kernel.
>
> Best regards,
> Jan
>
> >
> > Regards,
> > Lakshmi
> >
> >
> > On Tue, Oct 20, 2020 at 5:48 PM Rajashree Sankar
> > <rajashree.sankar@sanmina.com <mailto:rajashree.sankar@sanmina.com>>
> wrote:
> >
> >     Hello Jan,
> >     We have used Yocto Framework provided by NXP from the following link
> >     <
> https://www.nxp.com/design/development-boards/i-mx-evaluation-and-development-boards/evaluation-kit-for-the-i-mx-6ull-and-6ulz-applications-processor:MCIMX6ULL-EVK?fpsp=1#documentsandsoftware
> >.Refer
> >     to the Document
> >
> >
> >           L4.19.35_1.1.0_LINUX_DOCS
> >           <
> https://www.nxp.com/webapp/Download?colCode=L4.19.35_1.1.0_LINUX_DOCS>
> >           in the above mentioned link.
> >
> >     The DT-bindings and the IMX Camera capture information will be
> >     available by following the steps mentioned in the document
> >     i.MX_Yocto_Project_User's_Guide from the above link.
> >     The Kernel which we are using is fetched from the bitbake files
> >     attached below( linux-yocto_4.19.bb <http://linux-yocto_4.19.bb> and
> >     its append).Could you please let us know whether CSI  Camera capture
> >     supported in this kernel be included in the Linux CIP?
> >
> >     Thanks and Regards,
> >     Rajashree Sankar
> >
> >
> >
> > CONFIDENTIALITY
> > This e-mail message and any attachments thereto, is intended only for
> > use by the addressee(s) named herein and may contain legally privileged
> > and/or confidential information. If you are not the intended recipient
> > of this e-mail message, you are hereby notified that any dissemination,
> > distribution or copying of this e-mail message, and any attachments
> > thereto, is strictly prohibited. If you have received this e-mail
> > message in error, please immediately notify the sender and permanently
> > delete the original and any copies of this email and any prints thereof.
> > ABSENT AN EXPRESS STATEMENT TO THE CONTRARY HEREINABOVE, THIS E-MAIL IS
> > NOT INTENDED AS A SUBSTITUTE FOR A WRITING. Notwithstanding the Uniform
> > Electronic Transactions Act or the applicability of any other law of
> > similar substance and effect, absent an express statement to the
> > contrary hereinabove, this e-mail message its contents, and any
> > attachments hereto are not intended to represent an offer or acceptance
> > to enter into a contract and are not otherwise intended to bind the
> > sender, Sanmina Corporation (or any of its subsidiaries), or any other
> > person or entity.
>
> --
> Siemens AG, T RDA IOT
> Corporate Competence Center Embedded Linux
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

--00000000000058846705b22c6a50
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello Jan,<div><br></div><div>Thanks for the details. This=
 gives us an idea on what we could do next.</div><div>Thanks for your immed=
iate support. We will get in touch with NXP for this.</div><div><br clear=
=3D"all"><div><div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"=
gmail_signature"><div dir=3D"ltr">Regards,<div>Lakshmi</div></div></div></d=
iv><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D=
"gmail_attr">On Wed, Oct 21, 2020 at 4:27 PM Jan Kiszka &lt;<a href=3D"mail=
to:jan.kiszka@siemens.com">jan.kiszka@siemens.com</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">Hi Lakshmi,<br>
<br>
On 21.10.20 11:50, Lakshmi Natarajan wrote:<br>
&gt; Hello Jan,<br>
&gt; <br>
&gt; This is regarding requests=C2=A0for CSI support in the IMX processor.<=
br>
&gt; We were using Yocto=C2=A0+ NXP provided kernel to use the CSI peripher=
al of <br>
&gt; the IMX6 processor. We have complete support from NXP for their kernel=
 <br>
&gt; along with the Yocto framework.<br>
&gt; We want to move to CIP 4.19 + ISAR framework.<br>
&gt; When we checked CIP kernel 4.19 - there was no support for CSI interfa=
ce <br>
&gt; as well as there were some differences in the arch support too.<br>
&gt; After study of the NXP provided framework, we found that they use the =
<br>
&gt; kernel from <a href=3D"https://source.codeaurora.org/external/imx/linu=
x-imxand" rel=3D"noreferrer" target=3D"_blank">https://source.codeaurora.or=
g/external/imx/linux-imxand</a> <br>
&gt; commit ID 0f9917c56d5995e1dc3bde5658e2d7bc865464de.<br>
&gt; Even linux kernel 5.9 doesn&#39;t have the imx specific support.<br>
<br>
That&#39;s unfortunate.<br>
<br>
&gt; Can you guide us on how we should proceed with the same - will it be <=
br>
&gt; possible for CIP to add IMX support (or) should we request NXP to add =
<br>
&gt; the patch for CIP kernel 4.19<br>
<br>
Yes, please reach out to NXP and ask what their answer for upstream is, <br=
>
today or at least for the future. It&#39;s their issue in the first place. =
<br>
Also for that, you should prepare with naming the kernel interfaces or <br>
drivers you need in more details.<br>
<br>
If NXP cannot or do not want to answer this appropriately, plan B) will <br=
>
be identifying the patches they provide on top of the upstream kernel, <br>
optimally 4.19. Those patches then needs to be applied on top of the CIP <b=
r>
kernel but, as they are unfortunately downstream only, you will then <br>
have to maintain them for your product and can&#39;t propose them for the <=
br>
CIP kernel.<br>
<br>
Best regards,<br>
Jan<br>
<br>
&gt; <br>
&gt; Regards,<br>
&gt; Lakshmi<br>
&gt; <br>
&gt; <br>
&gt; On Tue, Oct 20, 2020 at 5:48 PM Rajashree Sankar <br>
&gt; &lt;<a href=3D"mailto:rajashree.sankar@sanmina.com" target=3D"_blank">=
rajashree.sankar@sanmina.com</a> &lt;mailto:<a href=3D"mailto:rajashree.san=
kar@sanmina.com" target=3D"_blank">rajashree.sankar@sanmina.com</a>&gt;&gt;=
 wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Hello Jan,<br>
&gt;=C2=A0 =C2=A0 =C2=A0We have used Yocto Framework provided by NXP from t=
he following link<br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https://www.nxp.com/design/developme=
nt-boards/i-mx-evaluation-and-development-boards/evaluation-kit-for-the-i-m=
x-6ull-and-6ulz-applications-processor:MCIMX6ULL-EVK?fpsp=3D1#documentsands=
oftware" rel=3D"noreferrer" target=3D"_blank">https://www.nxp.com/design/de=
velopment-boards/i-mx-evaluation-and-development-boards/evaluation-kit-for-=
the-i-mx-6ull-and-6ulz-applications-processor:MCIMX6ULL-EVK?fpsp=3D1#docume=
ntsandsoftware</a>&gt;.Refer<br>
&gt;=C2=A0 =C2=A0 =C2=A0to the Document<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0L4.19.35_1.1.0_LINUX_DOCS<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https://www.nxp=
.com/webapp/Download?colCode=3DL4.19.35_1.1.0_LINUX_DOCS" rel=3D"noreferrer=
" target=3D"_blank">https://www.nxp.com/webapp/Download?colCode=3DL4.19.35_=
1.1.0_LINUX_DOCS</a>&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0in the above mentioned link.<b=
r>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0The DT-bindings and the IMX Camera capture informat=
ion will be<br>
&gt;=C2=A0 =C2=A0 =C2=A0available by following the steps mentioned in the d=
ocument<br>
&gt;=C2=A0 =C2=A0 =C2=A0i.MX_Yocto_Project_User&#39;s_Guide from the above =
link.<br>
&gt;=C2=A0 =C2=A0 =C2=A0The Kernel which we are using is fetched from the b=
itbake files<br>
&gt;=C2=A0 =C2=A0 =C2=A0attached below( <a href=3D"http://linux-yocto_4.19.=
bb" rel=3D"noreferrer" target=3D"_blank">linux-yocto_4.19.bb</a> &lt;<a hre=
f=3D"http://linux-yocto_4.19.bb" rel=3D"noreferrer" target=3D"_blank">http:=
//linux-yocto_4.19.bb</a>&gt; and<br>
&gt;=C2=A0 =C2=A0 =C2=A0its append).Could you please let us know whether CS=
I=C2=A0 Camera capture<br>
&gt;=C2=A0 =C2=A0 =C2=A0supported in this kernel be included in the Linux C=
IP?<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Thanks and Regards,<br>
&gt;=C2=A0 =C2=A0 =C2=A0Rajashree Sankar<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; CONFIDENTIALITY<br>
&gt; This e-mail message and any attachments thereto, is intended only for =
<br>
&gt; use by the addressee(s) named herein and may contain legally privilege=
d <br>
&gt; and/or confidential information. If you are not the intended recipient=
 <br>
&gt; of this e-mail message, you are hereby notified that any dissemination=
, <br>
&gt; distribution or copying of this e-mail message, and any attachments <b=
r>
&gt; thereto, is strictly prohibited. If you have received this e-mail <br>
&gt; message in error, please immediately notify the sender and permanently=
 <br>
&gt; delete the original and any copies of this email and any prints thereo=
f.<br>
&gt; ABSENT AN EXPRESS STATEMENT TO THE CONTRARY HEREINABOVE, THIS E-MAIL I=
S <br>
&gt; NOT INTENDED AS A SUBSTITUTE FOR A WRITING. Notwithstanding the Unifor=
m <br>
&gt; Electronic Transactions Act or the applicability of any other law of <=
br>
&gt; similar substance and effect, absent an express statement to the <br>
&gt; contrary hereinabove, this e-mail message its contents, and any <br>
&gt; attachments hereto are not intended to represent an offer or acceptanc=
e <br>
&gt; to enter into a contract and are not otherwise intended to bind the <b=
r>
&gt; sender, Sanmina Corporation (or any of its subsidiaries), or any other=
 <br>
&gt; person or entity.<br>
<br>
-- <br>
Siemens AG, T RDA IOT<br>
Corporate Competence Center Embedded Linux<br>
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

--00000000000058846705b22c6a50--

--0000000000005e5a0405b22c6a50
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
AgErkOL2mGgGGDT32pcweiOQc9dlTHrpb3vfEIRlQDf1gRc5cy/7WTbnn4jFgZnOwCJFZMOABvKl
9M2yzfr775TVszqbWoOMtCfnYOJi/lOr6GYMp7/vzCaQQUbm2jCFAgMBAAGjggHUMIIB0DAOBgNV
HQ8BAf8EBAMCBaAwgZ4GCCsGAQUFBwEBBIGRMIGOME0GCCsGAQUFBzAChkFodHRwOi8vc2VjdXJl
Lmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc3BlcnNvbmFsc2lnbjJzaGEyZzNvY3NwLmNydDA9Bggr
BgEFBQcwAYYxaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL2dzcGVyc29uYWxzaWduMnNoYTJn
MzBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xv
YmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBEBgNVHR8EPTA7MDmgN6A1hjNodHRw
Oi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzcGVyc29uYWxzaWduMnNoYTJnMy5jcmwwKAYDVR0RBCEw
H4EdbGFrc2htaS5uYXRhcmFqYW5Ac2FubWluYS5jb20wEwYDVR0lBAwwCgYIKwYBBQUHAwQwHwYD
VR0jBBgwFoAUaXKCYjFnlUSFd5GAxAQ2SZ17C2EwHQYDVR0OBBYEFBe//nau24DcU02B8ilCFDd7
vqJaMA0GCSqGSIb3DQEBCwUAA4IBAQBIU8BQpASMkQxA7ARW/S+p4PI9U33OqTYwDanRN3AlU0O3
IHYzprKEsSYVYrcIvSdmnLBKBB4f/Vuh2oZDUt/l5aIg3Y2Gy/0iWRHoGwkMS4mQwALEDfZ2SQUV
jMxCTsnVCTglBrq0wqKVjMjSirVBCOMkmK3GmOZEOcB9b5XXH9LK1QOryRQ0V3F0+BpuLJ13lKU3
uDdt4iGKDmx2H7WCoFvBwNxnf5EEwUfw3F3Ips0w2khKHc9/37uqOe8NEYl5s0IR8PGMl0sAit70
ciNmgW74qhZysxM//pCtqkqDnFZO2Z50ilDih2duQATkZAmBSmhyDM19PYILUz4edTppMYICbzCC
AmsCAQEwbTBdMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEzMDEGA1UE
AxMqR2xvYmFsU2lnbiBQZXJzb25hbFNpZ24gMiBDQSAtIFNIQTI1NiAtIEczAgw0yj+vSu8dMgsI
B6wwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEILw4BmTVXKlvCONDHiuLOIElVazc
oXvmsMGxttg4U6uqMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIw
MTAyMTExMTE1NlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQAlGz6fvji9qQ4v/9jL4M4s/elC5G52mc4SCIuyb7DvQbaa
G6lDpz3vhbZbGLi+Cya4J/ZTImzQUIjDPAQ9hYVOqYyGVhszlbXfvUuQ7h5OZQOVeIWTBpH10fjI
vgmLxAfV1v0De7wr9os+BecHfGz4xtzNleVen1bOzKDkUtOzRm3xNWivlORmEnjiQfY4IvRNScOZ
DNfY4dIVqX6FN9fxKICVHOnzNsNfNWdGRAJe+ew5q8GPkbgYnQLZpz9JOorYZZyDoItcd34i+kFi
b9oCVmbPg4I506bWFa/NJm9Bds2LnQD0cfeZfqFo8NL5GiJ2CjnJcdyN7N8GVHWKfIte

--0000000000005e5a0405b22c6a50--

--qBscsipIjopeXpNNXofJ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5632): https://lists.cip-project.org/g/cip-dev/message=
/5632
Mute This Topic: https://lists.cip-project.org/mt/77701906/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--qBscsipIjopeXpNNXofJ--

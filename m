Return-Path: <SRS0=/G4E=D4=lists.cip-project.org=bounce+64572+5631+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E17C4363A
	for <cip-dev@archiver.kernel.org>; Wed, 21 Oct 2020 10:57:32 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD93B208B6
	for <cip-dev@archiver.kernel.org>; Wed, 21 Oct 2020 10:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="NurYq/Zq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD93B208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5631+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id LgiaYY4521723xymzJk7R1O1; Wed, 21 Oct 2020 03:57:30 -0700
X-Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web09.10022.1603277849555008364
 for <cip-dev@lists.cip-project.org>;
 Wed, 21 Oct 2020 03:57:30 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 09LAvQJk031195
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Oct 2020 12:57:27 +0200
X-Received: from [167.87.53.106] ([167.87.53.106])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 09LAvPR1023179;
	Wed, 21 Oct 2020 12:57:26 +0200
Subject: Re: [cip-dev] Request for Camera CSI support for IMX
To: Lakshmi Natarajan <lakshmi.natarajan@sanmina.com>,
        Rajashree Sankar <rajashree.sankar@sanmina.com>
Cc: cip-dev@lists.cip-project.org
References: <CA+UxhRrWr_1VNmcrujPKjPWxoZw47XCSpGY2sqbkein2vHtYug@mail.gmail.com>
 <8ba7cf9c-7f55-7f06-4e34-6f4d92cce821@siemens.com>
 <CA+UxhRqONS33a6da-nhRMApuyMeGzHpYstwH3AB83FH5ELALAw@mail.gmail.com>
 <CAMbjpb-YqOOFvRc50aw-1uqpmnTgbAi9VGzs4k2t21ScsUG-bw@mail.gmail.com>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <8dccd65c-1539-0ef6-3a3f-3978874c14de@siemens.com>
Date: Wed, 21 Oct 2020 12:57:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAMbjpb-YqOOFvRc50aw-1uqpmnTgbAi9VGzs4k2t21ScsUG-bw@mail.gmail.com>
X-MIME-Autoconverted: from 8bit to quoted-printable by gecko.sbs.de id 09LAvQJk031195
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: lOMvwopTUOSwt6Nzn4Zc96Irx4520388AA=
Content-Type: multipart/mixed; boundary="FHdoFk5aAYkXK2FfxnAi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1603277850;
 bh=yACiYPAlV8eHUsz6T56Y8oj2D4EPaOIuk9izmhT/t40=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=NurYq/ZqmYuDzI6BI6oAx1ICz9LXefxtTx1TSqGwQ3H7kaRdl83VA+wAEVnfxCnv6zH
 MKP3zyq7woIOQfSIS1aIZQnsTEI3NDQXHUMBeA17i4cQJphAqJ+qJup1dKaLEHbRyD/Bq
 6ivYtKiFRmC5N8LT6WqTPfY/qnEUnexkhpc=

--FHdoFk5aAYkXK2FfxnAi
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi Lakshmi,

On 21.10.20 11:50, Lakshmi Natarajan wrote:
> Hello Jan,
>=20
> This is regarding requests=C2=A0for CSI support in the IMX processor.
> We were using Yocto=C2=A0+ NXP provided kernel to use the CSI periphera=
l of=20
> the IMX6 processor. We have complete support from NXP for their kernel=20
> along with the Yocto framework.
> We want to move to CIP 4.19 + ISAR framework.
> When we checked CIP kernel 4.19 - there was no support for CSI interfac=
e=20
> as well as there were some differences in the arch support too.
> After study of the NXP provided framework, we found that they use the=20
> kernel from https://source.codeaurora.org/external/imx/linux-imxand=20
> commit ID 0f9917c56d5995e1dc3bde5658e2d7bc865464de.
> Even linux kernel 5.9 doesn't have the imx specific support.

That's unfortunate.

> Can you guide us on how we should proceed with the same - will it be=20
> possible for CIP to add IMX support (or) should we request NXP to add=20
> the patch for CIP kernel 4.19

Yes, please reach out to NXP and ask what their answer for upstream is,=20
today or at least for the future. It's their issue in the first place.=20
Also for that, you should prepare with naming the kernel interfaces or=20
drivers you need in more details.

If NXP cannot or do not want to answer this appropriately, plan B) will=20
be identifying the patches they provide on top of the upstream kernel,=20
optimally 4.19. Those patches then needs to be applied on top of the CIP=20
kernel but, as they are unfortunately downstream only, you will then=20
have to maintain them for your product and can't propose them for the=20
CIP kernel.

Best regards,
Jan

>=20
> Regards,
> Lakshmi
>=20
>=20
> On Tue, Oct 20, 2020 at 5:48 PM Rajashree Sankar=20
> <rajashree.sankar@sanmina.com <mailto:rajashree.sankar@sanmina.com>> wr=
ote:
>=20
>     Hello Jan,
>     We have used Yocto Framework provided by NXP from the following lin=
k
>     <https://www.nxp.com/design/development-boards/i-mx-evaluation-and-=
development-boards/evaluation-kit-for-the-i-mx-6ull-and-6ulz-applications=
-processor:MCIMX6ULL-EVK?fpsp=3D1#documentsandsoftware>.Refer
>     to the Document
>=20
>=20
>           L4.19.35_1.1.0_LINUX_DOCS
>           <https://www.nxp.com/webapp/Download?colCode=3DL4.19.35_1.1.0=
_LINUX_DOCS>=20
>           in the above mentioned link.
>=20
>     The DT-bindings and the IMX Camera capture information will be
>     available by following the steps mentioned in the document
>     i.MX_Yocto_Project_User's_Guide from the above link.
>     The Kernel which we are using is fetched from the bitbake files
>     attached below( linux-yocto_4.19.bb <http://linux-yocto_4.19.bb> an=
d
>     its append).Could you please let us know whether CSI=C2=A0 Camera c=
apture
>     supported in this kernel be included in the Linux CIP?
>=20
>     Thanks and Regards,
>     Rajashree Sankar
>=20
>=20
>=20
> CONFIDENTIALITY
> This e-mail message and any attachments thereto, is intended only for=20
> use by the addressee(s) named herein and may contain legally privileged=
=20
> and/or confidential information. If you are not the intended recipient=20
> of this e-mail message, you are hereby notified that any dissemination,=
=20
> distribution or copying of this e-mail message, and any attachments=20
> thereto, is strictly prohibited. If you have received this e-mail=20
> message in error, please immediately notify the sender and permanently=20
> delete the original and any copies of this email and any prints thereof.
> ABSENT AN EXPRESS STATEMENT TO THE CONTRARY HEREINABOVE, THIS E-MAIL IS=
=20
> NOT INTENDED AS A SUBSTITUTE FOR A WRITING. Notwithstanding the Uniform=
=20
> Electronic Transactions Act or the applicability of any other law of=20
> similar substance and effect, absent an express statement to the=20
> contrary hereinabove, this e-mail message its contents, and any=20
> attachments hereto are not intended to represent an offer or acceptance=
=20
> to enter into a contract and are not otherwise intended to bind the=20
> sender, Sanmina Corporation (or any of its subsidiaries), or any other=20
> person or entity.

--=20
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

--FHdoFk5aAYkXK2FfxnAi
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5631): https://lists.cip-project.org/g/cip-dev/message=
/5631
Mute This Topic: https://lists.cip-project.org/mt/77701906/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--FHdoFk5aAYkXK2FfxnAi--

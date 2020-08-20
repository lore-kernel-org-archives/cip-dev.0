Return-Path: <SRS0=al3d=B6=lists.cip-project.org=bounce+64572+5161+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B96C433E1
	for <cip-dev@archiver.kernel.org>; Thu, 20 Aug 2020 08:50:35 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B27120738
	for <cip-dev@archiver.kernel.org>; Thu, 20 Aug 2020 08:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="p4jp2qap"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B27120738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5161+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id H1bOYY4521723x3SfdjcrLLY; Thu, 20 Aug 2020 01:50:35 -0700
X-Received: from david.siemens.de (david.siemens.de [192.35.17.14])
 by mx.groups.io with SMTP id smtpd.web12.106114.1597913433385472642
 for <cip-dev@lists.cip-project.org>;
 Thu, 20 Aug 2020 01:50:34 -0700
X-Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
	by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 07K8oU8q002987
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Aug 2020 10:50:30 +0200
X-Received: from [167.87.58.237] ([167.87.58.237])
	by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 07K8oTbA022175;
	Thu, 20 Aug 2020 10:50:29 +0200
Subject: Re: [cip-dev] [cip-kernel-config PATCH] qemu_cip_defconfig: Add EFI_STUB to config
To: cip-dev@lists.cip-project.org,
        "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
References: <20200803101217.6961-1-Quirin.Gylstorff@siemens.com>
 <OSBPR01MB298330C0C2BA66778FAB84AD92480@OSBPR01MB2983.jpnprd01.prod.outlook.com>
 <c0e08e23-2cc0-0ded-6266-2c4da2ccf4af@siemens.com>
 <OSBPR01MB298341D4C5B082E32DB5587792490@OSBPR01MB2983.jpnprd01.prod.outlook.com>
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
Message-ID: <d5786804-0453-cfe5-aeef-f090c363a0fd@siemens.com>
Date: Thu, 20 Aug 2020 10:50:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <OSBPR01MB298341D4C5B082E32DB5587792490@OSBPR01MB2983.jpnprd01.prod.outlook.com>
X-MIME-Autoconverted: from 8bit to quoted-printable by david.siemens.de id 07K8oU8q002987
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: mjNN93zg47CEHRC9IjueY622x4520388AA=
Content-Type: multipart/mixed; boundary="u03sDhtX1xwZJNf62kfS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1597913435;
 bh=lFClX42s5u6xe0gRaT11YHwHjrpdFrePZVAQPw/Ux80=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=p4jp2qap4Nw7tfio2J+mAUSGQoNEE2X4mfU9nUOp/+gpsdrFb50oBWvuQSwz1HSpqXR
 ac4vCDqWKhjT6Cq931tpHRwsvcBP6naCVz5YgIRuZXm/+fJZEWRgWuRrVNXeM+iF5C7t/
 hXa4K2wrcXGgXhlT8IYGy62OFcUtnRWFowk=

--u03sDhtX1xwZJNf62kfS
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 8/7/20 11:31 PM, Nobuhiro Iwamatsu wrote:
> Hi,
>=20
>> -----Original Message-----
>> From: cip-dev@lists.cip-project.org [mailto:cip-dev@lists.cip-project.o=
rg] On Behalf Of Quirin Gylstorff
>> Sent: Thursday, August 6, 2020 11:27 PM
>> To: cip-dev@lists.cip-project.org; sangorrin daniel(=E3=82=B5=E3=83=B3=
=E3=82=B4=E3=83=AA=E3=83=B3 =E3=83=80=E3=83=8B=E3=82=A8=E3=83=AB =E2=96=A1=
=
=EF=BC=B3=EF=BC=B7=EF=BC=A3=E2=97=AF=EF=BC=A1=EF=BC=A3=EF=BC=B4)
>> <daniel.sangorrin@toshiba.co.jp>; jan.kiszka@siemens.com
>> Subject: Re: [cip-dev] [cip-kernel-config PATCH] qemu_cip_defconfig: Ad=
d EFI_STUB to config
>>
>>
>>
>> On 8/6/20 8:46 AM, Nobuhiro Iwamatsu wrote:
>>> Hi,
>>>
>>> Thanks for your patch.
>>>
>>>> -----Original Message-----
>>>> From: cip-dev@lists.cip-project.org [mailto:cip-dev@lists.cip-project=
.org] On Behalf Of Quirin Gylstorff
>>>> Sent: Monday, August 3, 2020 7:12 PM
>>>> To: cip-dev@lists.cip-project.org; sangorrin daniel(=E3=82=B5=E3=83=
=B3=E3=82=B4=E3=83=AA=E3=83=B3 =E3=83=80=E3=83=8B=E3=82=A8=E3=83=AB =E2=96=
=
=A1=EF=BC=B3=EF=BC=B7=EF=BC=A3=E2=97=AF=EF=BC=A1=EF=BC=A3=EF=BC=B4)
>>>> <daniel.sangorrin@toshiba.co.jp>; jan.kiszka@siemens.com
>>>> Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>> Subject: [cip-dev] [cip-kernel-config PATCH] qemu_cip_defconfig: Add =
EFI_STUB to config
>>>>
>>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>>
>>>> If EFI_STUB is not active booting QEMU with OVMF efi will fail
>>>> with the following error message `KVM internal error. Suberror: 3`.
>>>>
>>>> OVMF efi is used in isar-cip-core to demonstrate secure-boot with
>>>> a unified kernel image.
>>>>
>>>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>> ---
>>>>    4.19.y-cip/x86/cip_qemu_defconfig | 1 +
>>>>    1 file changed, 1 insertion(+)
>>>
>>> Please update cip_qemu.sources too.
>>
>> When i try to generate the sources - all .c and asm files are no longer
>> part of the cip-qemu.sources. Did I miss something? Or should I try
>> again like the last time this happened?
>=20
> Thanks for your check.
> Sorry, I wanted to check if there was a fix in cip_qemu.sources.
> I applied this patch.
>

Hi,

I didn't find the patch applied to cip-kernel-config. Is something missing=
?

Kind regards,
quirin

>>>
>> Thanks,
>> Quirin
>=20
> Best regards,
>    Nobuhiro
>=20
>=20
>=20
>=20

--=20
Quirin Gylstorff

Siemens AG
Corporate Technology
Research in Digitalization and Automation
Smart Embedded Systems
CT RDA IOT SES-DE
Otto-Hahn-Ring 6
81739 Muenchen, Germany
Mobile: +49 173 3746683
mailto:quirin.gylstorff@siemens.com
www.siemens.com/ingenuityforlife

Siemens Aktiengesellschaft: Chairman of the Supervisory Board: Jim=20
Hagemann Snabe; Managing Board: Joe Kaeser, Chairman, President and=20
Chief Executive Officer; Roland Busch, Lisa Davis, Klaus Helmrich,=20
Cedrik Neike, Michael Sen, Ralf P. Thomas; Registered offices: Berlin=20
and Munich, Germany; Commercial registries: Berlin Charlottenburg, HRB=20
12300, Munich, HRB 6684; WEEE-Reg.-No. DE 23691322

Important notice: This e-mail and any attachment thereof contain=20
corporate proprietary information. If you have received it by mistake,=20
please notify us immediately by reply e-mail and delete this e-mail and=20
its attachments from your system. Thank you.

--u03sDhtX1xwZJNf62kfS
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5161): https://lists.cip-project.org/g/cip-dev/message=
/5161
Mute This Topic: https://lists.cip-project.org/mt/75962579/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--u03sDhtX1xwZJNf62kfS--

Return-Path: <SRS0=OR8H=GR=lists.cip-project.org=bounce+64572+6085+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95505C433E0
	for <cip-dev@archiver.kernel.org>; Thu, 14 Jan 2021 06:07:48 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34A57238E7
	for <cip-dev@archiver.kernel.org>; Thu, 14 Jan 2021 06:07:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34A57238E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6085+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 7mNHYY4521723xcWwG0dFef5; Wed, 13 Jan 2021 22:07:45 -0800
X-Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web09.4354.1610604464424750639
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Jan 2021 22:07:44 -0800
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 10E67gKo020409
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Jan 2021 07:07:42 +0100
X-Received: from [167.87.43.185] ([167.87.43.185])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 10E67fWa026790;
	Thu, 14 Jan 2021 07:07:41 +0100
Subject: Re: [cip-dev] [cip-kernel-config ][ RFC 1/1] 4.19.y-cip/cip_bbb_defconfig: Add config switches from isar-cip-core
To: cip-dev@lists.cip-project.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        daniel.sangorrin@toshiba.co.jp,
        Quirin Gylstorff <quirin.gylstorff@siemens.com>
References: <OSBPR01MB2053E648BDBD2C9934BAD1A8D04B0@OSBPR01MB2053.jpnprd01.prod.outlook.com>
 <20200817092927.14658-1-Quirin.Gylstorff@siemens.com>
 <20200817092927.14658-2-Quirin.Gylstorff@siemens.com>
 <OSBPR01MB2983FB2BF167336EB6181B8A925A0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
 <c465136f-efdf-9a1b-b187-e0511e05aa52@siemens.com>
 <OSBPR01MB298386E0EEDFCA960354F14592230@OSBPR01MB2983.jpnprd01.prod.outlook.com>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <e197281e-f414-4d11-788a-d0d7ca5c8f66@siemens.com>
Date: Thu, 14 Jan 2021 07:07:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <OSBPR01MB298386E0EEDFCA960354F14592230@OSBPR01MB2983.jpnprd01.prod.outlook.com>
X-MIME-Autoconverted: from 8bit to quoted-printable by gecko.sbs.de id 10E67gKo020409
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: duOsyJMTvjS8YUWRfRXtqywlx4520388AA=
Content-Type: multipart/mixed; boundary="3R238AwlxHUpr4wB0qU0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1610604465;
 bh=xEDq2jBD7+jAA7ZQvdZcmQLrmqODOW5pWbaZMLf0LpA=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=CPH5sKE4pbiwHWlVuy6+xGZvuCyIa0wxIr9RecHMZ17EwP2kjBpUhA9Agvq29oKCXXq
 ewlrwICo3laqG9+YWkhbkKeEbMSTtRIGI2ArwbiBk0XkobeRyn5gtSC4pwJZlu5fKznKu
 2BySQrJZbEslLNS5kFvCmp62ZCoP69saH4Y=

--3R238AwlxHUpr4wB0qU0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 15.09.20 01:50, Nobuhiro Iwamatsu wrote:
> Hi,
>=20
>> -----Original Message-----
>> From: cip-dev@lists.cip-project.org [mailto:cip-dev@lists.cip-project.=
org] On Behalf Of Quirin Gylstorff
>> Sent: Friday, August 21, 2020 6:52 PM
>> To: cip-dev@lists.cip-project.org; sangorrin daniel(=E3=82=B5=E3=83=B3=
=E3=82=B4=E3=83=AA=E3=83=B3 =E3=83=80=E3=83=8B=E3=82=A8=E3=83=AB =E2=96=A1=
=EF=BC=B3=EF=BC=B7=EF=BC=A3=E2=97=AF=EF=BC=A1=EF=BC=A3=EF=BC=B4)
>> <daniel.sangorrin@toshiba.co.jp>; jan.kiszka@siemens.com
>> Subject: Re: [cip-dev] [cip-kernel-config ][ RFC 1/1] 4.19.y-cip/cip_b=
bb_defconfig: Add config switches from
>> isar-cip-core
>>
>>
>>
>> On 8/21/20 1:34 AM, Nobuhiro Iwamatsu wrote:
>>> Hi,
>>>
>>>> -----Original Message-----
>>>> From: cip-dev@lists.cip-project.org [mailto:cip-dev@lists.cip-projec=
t.org] On Behalf Of Quirin Gylstorff
>>>> Sent: Monday, August 17, 2020 6:29 PM
>>>> To: sangorrin daniel(=E3=82=B5=E3=83=B3=E3=82=B4=E3=83=AA=E3=83=B3 =E3=
=83=80=E3=83=8B=E3=82=A8=E3=83=AB =E2=96=A1=EF=BC=B3=EF=BC=B7=EF=BC=A3=E2=
=97=AF=EF=BC=A1=EF=BC=A3=EF=BC=B4) <daniel.sangorrin@toshiba.co.jp>;
>>>> cip-dev@lists.cip-project.org; jan.kiszka@siemens.com
>>>> Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>> Subject: [cip-dev] [cip-kernel-config ][ RFC 1/1] 4.19.y-cip/cip_bbb=
_defconfig: Add config switches from
>> isar-cip-core
>>>>
>>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>>
>>>> Add the config switches which exist only in isar-cip-core
>>>> to the defconfig in cip-kernel-config for the beagle bone black.
>>>>
>>>
>>> Thanks for your patch.
>>> The cip_bbb_defconfig created by me had minimal functionality enabled=
. I didn't know that Siemens didn't include
>> the required features.
>>> So I think this patch is necessary.
>>> However, we think that it is difficult to do it with one defconfig wh=
en testing the necessary functions as CIP in
>> the future.
>>> Therefore, it may be necessary to prepare defconfig for each required=
 function in the future.
>>>
>>> By the way, is this only 4.19? Do I need to change RT or 4.4.y?
>>
>> This patch is only for 4.19. I can prepare a v2 which includes v4.4. A=
s
>> posted it was intented to show the current difference between the bbb
>> config in isar-cip-core and cip-kernel-config.
>=20
> I see.
> Would you send a patch for v4.4 as well?
>=20

I just noticed that this topic is still open. Unfortunately, I do not
have a BBB in reach. Who has and could complete this cleanup?

Jan

--=20
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

--3R238AwlxHUpr4wB0qU0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6085): https://lists.cip-project.org/g/cip-dev/message=
/6085
Mute This Topic: https://lists.cip-project.org/mt/76240452/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--3R238AwlxHUpr4wB0qU0--

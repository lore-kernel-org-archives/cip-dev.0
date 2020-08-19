Return-Path: <SRS0=yVuK=B5=lists.cip-project.org=bounce+64572+5140+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F48BC433DF
	for <cip-dev@archiver.kernel.org>; Wed, 19 Aug 2020 06:32:50 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ABDA20772
	for <cip-dev@archiver.kernel.org>; Wed, 19 Aug 2020 06:32:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="vSwCNboX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ABDA20772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5140+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id dsTlYY4521723xtA8h9HZfiI; Tue, 18 Aug 2020 23:32:50 -0700
X-Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web10.83831.1597818768185968988
 for <cip-dev@lists.cip-project.org>;
 Tue, 18 Aug 2020 23:32:49 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 07J6Wkow007005
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Aug 2020 08:32:46 +0200
X-Received: from [167.87.31.209] ([167.87.31.209])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 07J6WjKp017972;
	Wed, 19 Aug 2020 08:32:46 +0200
Subject: Re: [cip-dev] [isar-cip-core][PATCH v2 3/3] testing: Add test.yml
To: nobuhiro1.iwamatsu@toshiba.co.jp, cip-dev@lists.cip-project.org
References: <20200819044201.1255803-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20200819044201.1255803-3-nobuhiro1.iwamatsu@toshiba.co.jp>
 <436e7176-7fd0-086e-6aad-784e3ea1e68f@siemens.com>
 <OSBPR01MB2983FF1811B79A187E85921D925D0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <10bdb2ff-1f21-5a3c-2af4-ee275e117215@siemens.com>
Date: Wed, 19 Aug 2020 08:32:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <OSBPR01MB2983FF1811B79A187E85921D925D0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
X-MIME-Autoconverted: from 8bit to quoted-printable by gecko.sbs.de id 07J6Wkow007005
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: UiONGu19XHIWgoLAxO5jMAwyx4520388AA=
Content-Type: multipart/mixed; boundary="hQXf8n4UWyjG1RZ1ySGd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1597818770;
 bh=UwYiCpQITsLt1C4UFUXfZu7LMgVVNpdE1kAB4SNomig=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=vSwCNboX9IMvgmcj1NR2qkzpnNJ49Ho/0BfnLdcBY4MUGg2ks/GD2vOX+b6cCW8D/Mz
 JkCx4oBAai1V90BEp3WJAJq1Fi+Q66pm3jYFw21aG5T3b/CbGwgZ6h3t/S1wp3BNVYVPt
 X5ObzDO12Kjj3ZuPGuKf2Ro3CY5IUYn65Qo=

--hQXf8n4UWyjG1RZ1ySGd
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 19.08.20 08:31, nobuhiro1.iwamatsu@toshiba.co.jp wrote:
> Hi,
>=20
>> -----Original Message-----
>> From: Jan Kiszka [mailto:jan.kiszka@siemens.com]
>> Sent: Wednesday, August 19, 2020 3:18 PM
>> To: iwamatsu nobuhiro(=E5=B2=A9=E6=9D=BE =E4=BF=A1=E6=B4=8B =E2=96=A1=EF=
=BC=B3=EF=BC=B7=EF=BC=A3=E2=97=AF=EF=BC=A1=EF=BC=A3=EF=BC=B4) <nobuhiro1.=
iwamatsu@toshiba.co.jp>; cip-dev@lists.cip-project.org
>> Subject: Re: [isar-cip-core][PATCH v2 3/3] testing: Add test.yml
>>
>> On 19.08.20 06:42, Nobuhiro Iwamatsu wrote:
>>> Add YAML to add the test application to each images.
>>> The following test applications will be added.
>>>  - ltp
>>>  - rt-tests
>>>  - stress-ng
>>>
>>> And this appends '-test' to the generated image filename.
>>>
>>> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
>>> ---
>>>  kas/opt/test.yml | 20 ++++++++++++++++++++
>>>  1 file changed, 20 insertions(+)
>>>  create mode 100644 kas/opt/test.yml
>>>
>>> diff --git a/kas/opt/test.yml b/kas/opt/test.yml
>>> new file mode 100644
>>> index 0000000..75b257d
>>> --- /dev/null
>>> +++ b/kas/opt/test.yml
>>> @@ -0,0 +1,20 @@
>>> +#
>>> +# Copyright (c) Siemens AG, 2019
>>> +# Copyright (c) Toshiba Corporation, 2020
>>> +#
>>> +# Authors:
>>> +#  Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>> +
>>> +header:
>>> +  version: 8
>>> +
>>> +local_conf_header:
>>> +  testing: |
>>> +    IMAGE_INSTALL +=3D "ltp-full"
>>> +    IMAGE_PREINSTALL +=3D "rt-tests stress-ng"
>>> +    DESCRIPTION_append =3D " with test packages"
>>> +    IMAGE_FULLNAME_append =3D "-test"
>>> +
>>>
>>
>> Ah, nice solution with the _append.
>>
>> Can you follow up with a patch for CI that adds the test feature at
>> least to some of your images? I actually wonder if we shouldn't add it
>> to all, or even have to in case the CI images are directly used for te=
sting.
>>
>=20
> Yes, I planned to do it after it was applied.
> I will add this to v3 patch series.

No need to resend, the patches are already in next, locally. Just add
that patch on top.

Jan

--=20
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

--hQXf8n4UWyjG1RZ1ySGd
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5140): https://lists.cip-project.org/g/cip-dev/message=
/5140
Mute This Topic: https://lists.cip-project.org/mt/76280651/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--hQXf8n4UWyjG1RZ1ySGd--

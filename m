Return-Path: <SRS0=7Nh/=B4=lists.cip-project.org=bounce+64572+5128+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E66C433E1
	for <cip-dev@archiver.kernel.org>; Tue, 18 Aug 2020 05:29:44 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61C9C2076E
	for <cip-dev@archiver.kernel.org>; Tue, 18 Aug 2020 05:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="YMYR+LXM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61C9C2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5128+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id x2NmYY4521723xfBcx2VMogM; Mon, 17 Aug 2020 22:29:43 -0700
X-Received: from david.siemens.de (david.siemens.de [192.35.17.14])
 by mx.groups.io with SMTP id smtpd.web11.60539.1597728581909194147
 for <cip-dev@lists.cip-project.org>;
 Mon, 17 Aug 2020 22:29:43 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 07I5TcNf028922
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2020 07:29:39 +0200
X-Received: from [139.22.40.250] ([139.22.40.250])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 07I5TboG018008;
	Tue, 18 Aug 2020 07:29:38 +0200
Subject: Re: [cip-dev] [isar-cip-core][PATCH 1/3] cip-core-image-test: Add recipe
To: cip-dev@lists.cip-project.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
References: <16281511DE955BB5.19258@lists.cip-project.org>
 <OSBPR01MB298327233BFADC291456E190925C0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <b2289205-5f7e-9f57-ba0a-496a4c8749b3@siemens.com>
Date: Tue, 18 Aug 2020 07:29:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <OSBPR01MB298327233BFADC291456E190925C0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
X-MIME-Autoconverted: from 8bit to quoted-printable by david.siemens.de id 07I5TcNf028922
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: em41dPXHUc1AcBaqG2nL7Uhox4520388AA=
Content-Type: multipart/mixed; boundary="kaRWn5yE2csNB5ZRbhMH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1597728583;
 bh=konS1eyyYaz+O5/g21wV8bKc/1HjM6QEFyzK4rrnHDo=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=YMYR+LXM2MO7W9zaPWVZ/pkvoZp2kR00CmsrQgr+X8LDk5GI5+Zk2Euzr+NfLQe2w7Q
 T+DQXB6fZ4ZMiQ/To2NrGkoHWp+lH4YBEWBDz0XVMUrtB5WewcgckOHSwCogJU9HYNIDi
 WZ7Q9/uxDmUXKgi37Hb2XU2TbW5XA38SKlc=

--kaRWn5yE2csNB5ZRbhMH
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 18.08.20 06:57, Nobuhiro Iwamatsu wrote:
> Hi Jan,
>=20
> Could you comment on this patch series?
>=20

Ah, yeah, sorry.

I think now it's better to model that as extension of an image, given
that we already have two (regular + security). Or will we implicitly
test the security image via the regular one?

Jan

> Best regards,
>  Nobuhiro
>=20
>> -----Original Message-----
>> From: cip-dev@lists.cip-project.org [mailto:cip-dev@lists.cip-project.o=
rg] On Behalf Of Nobuhiro Iwamatsu
>> Sent: Tuesday, August 4, 2020 10:54 PM
>> To: cip-dev@lists.cip-project.org
>> Cc: iwamatsu nobuhiro(=E5=B2=A9=E6=9D=BE =E4=BF=A1=E6=B4=8B =E2=96=A1=
=EF=BC=B3=EF=BC=B7=EF=BC=A3=E2=97=AF=EF=BC=A1=EF=BC=A3=EF=BC=B4) <nobuhiro=
1.iwamatsu@toshiba.co.jp>
>> Subject: [cip-dev] [isar-cip-core][PATCH 1/3] cip-core-image-test: Add =
recipe
>>
>> This recipe provides an image for testing.
>> If use this, it will create an image containing LTP(ltp-full), rt-tests=
 and stress-ng.
>>
>> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
>> ---
>>  recipes-core/images/cip-core-image-test.bb | 18 ++++++++++++++++++
>>  1 file changed, 18 insertions(+)
>>  create mode 100644 recipes-core/images/cip-core-image-test.bb
>>
>> diff --git a/recipes-core/images/cip-core-image-test.bb b/recipes-core/=
images/cip-core-image-test.bb
>> new file mode 100644
>> index 0000000..e2b15fc
>> --- /dev/null
>> +++ b/recipes-core/images/cip-core-image-test.bb
>> @@ -0,0 +1,18 @@
>> +#
>> +# CIP Core, generic profile
>> +#
>> +# Copyright (c) Siemens AG, 2019
>> +#
>> +# Authors:
>> +#  Jan Kiszka <jan.kiszka@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +#
>> +inherit dpkg-raw
>> +require cip-core-image.bb
>> +
>> +DESCRIPTION =3D "CIP Core image including test packages"
>> +
>> +IMAGE_INSTALL +=3D "ltp-full"
>> +DEBIAN_DEPENDS +=3D "rt-tests, stress-ng"
>> --
>> 2.27.0
>=20
>=20
>=20
>=20

--=20
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

--kaRWn5yE2csNB5ZRbhMH
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5128): https://lists.cip-project.org/g/cip-dev/message=
/5128
Mute This Topic: https://lists.cip-project.org/mt/75987091/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--kaRWn5yE2csNB5ZRbhMH--

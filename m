Return-Path: <SRS0=m6eW=CK=lists.cip-project.org=bounce+64572+5348+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1398DC433E6
	for <cip-dev@archiver.kernel.org>; Tue,  1 Sep 2020 11:39:14 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6940A206EF
	for <cip-dev@archiver.kernel.org>; Tue,  1 Sep 2020 11:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="fhrJOoLs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6940A206EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5348+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id RZBjYY4521723xenejwzrWUw; Tue, 01 Sep 2020 04:39:13 -0700
X-Received: from david.siemens.de (david.siemens.de [192.35.17.14])
 by mx.groups.io with SMTP id smtpd.web11.10884.1598960351142746448
 for <cip-dev@lists.cip-project.org>;
 Tue, 01 Sep 2020 04:39:12 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 081Bd7rY014427
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Sep 2020 13:39:08 +0200
X-Received: from [167.87.3.153] ([167.87.3.153])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 081Bd6Qc027181;
	Tue, 1 Sep 2020 13:39:07 +0200
Subject: Re: [cip-dev] [isar-cip-core][PATCH 3/3] linux-cip Switch to gitlab source and update to 4.19.140-cip33
To: cip-dev@lists.cip-project.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
References: <cover.1598865682.git.jan.kiszka@siemens.com>
 <162be0421d8f27072b2476f95c6d2df9aa09b5f6.1598865682.git.jan.kiszka@siemens.com>
 <OSBPR01MB2983FE1E312CD4BA40B8FDFD92510@OSBPR01MB2983.jpnprd01.prod.outlook.com>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <cbff7ccb-603f-a4f0-3484-fe2ef22b5c06@siemens.com>
Date: Tue, 1 Sep 2020 13:39:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <OSBPR01MB2983FE1E312CD4BA40B8FDFD92510@OSBPR01MB2983.jpnprd01.prod.outlook.com>
X-MIME-Autoconverted: from 8bit to quoted-printable by david.siemens.de id 081Bd7rY014427
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: OZQboOr52ztqTy6XASjGqaL7x4520388AA=
Content-Type: multipart/mixed; boundary="3dJP987AYPv5TzSwpJsK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598960353;
 bh=7j81gbhcZYB0idb2SflghBAvzEFD17UcpG8aQI/fedw=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=fhrJOoLs+LiTyp97uN5B3g0Sq5uN6y2XmjIUTN+F7fUNPzCD+gDY7gsLiOxPyEAdCzb
 1Kj/oJHJtERQfqDzAbur26RFeX5SXgW3tT+Wvtk7TFN24j3XDqt9MZZBW2XaLpI7RBzZ6
 Fq6HFwytZLxIu8kFa/eZXva6SZMe9ICVyDw=

--3dJP987AYPv5TzSwpJsK
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 01.09.20 01:03, Nobuhiro Iwamatsu wrote:
> Hi,
>=20
>> -----Original Message-----
>> From: cip-dev@lists.cip-project.org [mailto:cip-dev@lists.cip-project.=
org] On Behalf Of Jan Kiszka
>> Sent: Monday, August 31, 2020 6:21 PM
>> To: cip-dev@lists.cip-project.org
>> Cc: iwamatsu nobuhiro(=E5=B2=A9=E6=9D=BE =E4=BF=A1=E6=B4=8B =E2=96=A1=EF=
=BC=B3=EF=BC=B7=EF=BC=A3=E2=97=AF=EF=BC=A1=EF=BC=A3=EF=BC=B4) <nobuhiro1.=
iwamatsu@toshiba.co.jp>
>> Subject: [cip-dev] [isar-cip-core][PATCH 3/3] linux-cip Switch to gitl=
ab source and update to 4.19.140-cip33
>>
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> The switch is needed as kernel.org snapshot tend to fail too often.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>  recipes-kernel/linux/linux-cip-common.inc                     | 4 +++=
-
>>  recipes-kernel/linux/linux-cip-rt-common.inc                  | 2 --
>>  recipes-kernel/linux/linux-cip-rt_4.19.135-cip31-rt13.bb      | 2 +-
>>  recipes-kernel/linux/linux-cip-rt_4.4.231-cip47-rt30.bb       | 2 +-
>>  ...inux-cip_4.19.138-cip32.bb =3D> linux-cip_4.19.140-cip33.bb} | 2 +=
-
>>  recipes-kernel/linux/linux-cip_4.4.230-cip47.bb               | 2 +-
>>  6 files changed, 7 insertions(+), 7 deletions(-)
>>  rename recipes-kernel/linux/{linux-cip_4.19.138-cip32.bb =3D> linux-c=
ip_4.19.140-cip33.bb} (67%)
>>
>> diff --git a/recipes-kernel/linux/linux-cip-common.inc b/recipes-kerne=
l/linux/linux-cip-common.inc
>> index 0c76835..7e09090 100644
>> --- a/recipes-kernel/linux/linux-cip-common.inc
>> +++ b/recipes-kernel/linux/linux-cip-common.inc
>> @@ -20,10 +20,12 @@ def conditional(variable, checkvalue, truevalue, f=
alsevalue, d):
>>  require recipes-kernel/linux/linux-custom.inc
>>
>>  SRC_URI +=3D " \
>> -    https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git=
/snapshot/linux-cip-${PV}.tar.gz \
>> +    https://gitlab.com/cip-project/cip-kernel/linux-cip/-/archive/v${=
PV}/linux-cip-v${PV}.tar.gz \
>=20
> I thought it would be good to use a URL as a variable and overwrite it.
> Is it difficult because the hash of the file changes depending on the m=
irror?

Yes, unfortunately. gitlab packages differently (under a different
directory) than korg. That prevents simply providing one as a fallback
mirror of the other, at least when pulling tarballs rather than full git
trees.

Jan

--=20
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

--3dJP987AYPv5TzSwpJsK
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5348): https://lists.cip-project.org/g/cip-dev/message=
/5348
Mute This Topic: https://lists.cip-project.org/mt/76530564/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--3dJP987AYPv5TzSwpJsK--

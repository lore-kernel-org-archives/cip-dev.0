Return-Path: <SRS0=SM6f=G7=lists.cip-project.org=bounce+64572+6150+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E8EBC433DB
	for <cip-dev@archiver.kernel.org>; Thu, 28 Jan 2021 14:13:19 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A777C64DD9
	for <cip-dev@archiver.kernel.org>; Thu, 28 Jan 2021 14:13:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A777C64DD9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6150+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 33QsYY4521723xLRaKi48Ql5; Thu, 28 Jan 2021 06:13:17 -0800
X-Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web11.24876.1611843195931459052
 for <cip-dev@lists.cip-project.org>;
 Thu, 28 Jan 2021 06:13:17 -0800
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 10SEDCw3002750
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Thu, 28 Jan 2021 15:13:12 +0100
X-Received: from [167.87.246.159] ([167.87.246.159])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 10SEDBBM014526;
	Thu, 28 Jan 2021 15:13:12 +0100
Subject: Re: [cip-dev] [isar-cip-core][PATCH] linux: Fix warning if USE_CIP_KERNEL_CONFIG is not defined
To: Gylstorff Quirin <quirin.gylstorff@siemens.com>,
        "Bezdeka, Florian (T RDA IOT SES-DE)" <florian.bezdeka@siemens.com>,
        "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <20210125172748.839290-1-florian.bezdeka@siemens.com>
 <a5e47480-6b59-e0c4-7a76-f9599ad05814@siemens.com>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <247140a8-d733-598e-082f-4feda0679954@siemens.com>
Date: Thu, 28 Jan 2021 15:13:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <a5e47480-6b59-e0c4-7a76-f9599ad05814@siemens.com>
X-MIME-Autoconverted: from 8bit to quoted-printable by gecko.sbs.de id 10SEDCw3002750
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: L0HMXx9nMLrwbSDKQQ44yiCwx4520388AA=
Content-Type: multipart/mixed; boundary="aH9cGVpL4jSslsfCzKYB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1611843197;
 bh=tustPnpdgEgn16117vMRkyUtZ1muHw/F5rCAF26fFiA=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=YGzAAqknpDMZS3bAqXsDT75UyGH7TMUkvrZjKimV/o+GpoaBHVmjjItTEk3fCs7yQXQ
 4gao02aRlULP0X6NDm83cwNsVcdKHXXJPoq69c9YuyeX55LOqA9gGE5h7UVOIvqvrS8t3
 hrKU6wNSFTex0wT8wCctAJ+zCcQvFtyIzWk=

--aH9cGVpL4jSslsfCzKYB
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 25.01.21 19:23, Gylstorff Quirin wrote:
>=20
>=20
> On 1/25/21 6:28 PM, Bezdeka, Florian (T RDA IOT SES-DE) wrote:
>> USE_CIP_KERNEL_CONFIG may not be defined in all layers using the
>> isar-cip-core layer, so we end up with the following warnings:
>>
>> WARNING:
>> /work/cip-core/recipes-kernel/linux/linux-cip_4.19.140-cip33.bb:
>> Unable to get checksum for linux-cip SRC_URI entry
>> ${MACHINE}_defconfig: file could not be found
>> WARNING:
>> /work/cip-core/recipes-kernel/linux/linux-cip-rt_4.4.231-cip47-rt30.bb=
: Unable
>> to get checksum for linux-cip-rt SRC_URI entry ${MACHINE}_defconfig:
>> file could not be found
>> WARNING:
>> /work/cip-core/recipes-kernel/linux/linux-cip_4.4.230-cip47.bb: Unable
>> to get checksum for linux-cip SRC_URI entry ${MACHINE}_defconfig: file
>> could not be found
>> WARNING:
>> /work/cip-core/recipes-kernel/linux/linux-cip-rt_4.19.135-cip31-rt13.b=
b:
>> Unable to get checksum for linux-cip-rt SRC_URI entry
>> ${MACHINE}_defconfig: file could not be found
>>
>> ${MACHINE}_defconfig needs to be added to SRC_URI only if
>> USE_CIP_KERNEL_CONFIG is set to "1".
>>
>> There is one in-tree machine definition (the bbb) that does not set
>> USE_CIP_KERNEL_CONFIG to "1" but still needs the defconfig added.
>> A machine specific SRC_URI was set to take care of that.
>>
>> Closes #7.
>>
>> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>> ---
>>
>> Some additional notes:
>> =C2=A0=C2=A0 - That's my first contribution, so review carefully ;-)
>> =C2=A0=C2=A0 - Both branches (master, next) are affected
>> =C2=A0=C2=A0 - The gitlab MR: [1]
>> =C2=A0=C2=A0 - The gitlab issue: [2]
>>
>> =C2=A0=C2=A0 [1]=C2=A0
>> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/merge_requests=
/10
>>
>> =C2=A0=C2=A0 [2]=C2=A0
>> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/7
>>
>>
>>
>> =C2=A0 recipes-kernel/linux/linux-cip-common.inc | 15 ++++++---------
>> =C2=A0 1 file changed, 6 insertions(+), 9 deletions(-)
>>
>> diff --git a/recipes-kernel/linux/linux-cip-common.inc
>> b/recipes-kernel/linux/linux-cip-common.inc
>> index 6db1d1d..9aca9af 100644
>> --- a/recipes-kernel/linux/linux-cip-common.inc
>> +++ b/recipes-kernel/linux/linux-cip-common.inc
>> @@ -11,21 +11,18 @@
>>
>> =C2=A0 KERNEL_DEFCONFIG ?=3D "${MACHINE}_defconfig"
>>
>> -def conditional(variable, checkvalue, truevalue, falsevalue, d):
>> -=C2=A0=C2=A0=C2=A0 if d.getVar(variable) =3D=3D checkvalue:
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return truevalue
>> -=C2=A0=C2=A0=C2=A0 else:
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return falsevalue
>> -
>> =C2=A0 require recipes-kernel/linux/linux-custom.inc
>>
>> =C2=A0 SRC_URI +=3D " \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
>> https://gitlab.com/cip-project/cip-kernel/linux-cip/-/archive/v$
>> \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "
>>
>> -SRC_URI_append =3D " ${@conditional("USE_CIP_KERNEL_CONFIG", "1", \
>> -=C2=A0=C2=A0=C2=A0
>> "git://gitlab.com/cip-project/cip-kernel/cip-kernel-config.git;protoco=
l=3Dhttps;destsuffix=3Dcip-kernel-config;name=3Dcip-kernel-config",
>> \
>> -=C2=A0=C2=A0=C2=A0 "file://${KERNEL_DEFCONFIG}",d)}"
> The easier way would have been to delete file://${KERNEL_DEFCONFIG}
> instead of create the logic anew. The conditional function should allow
> an empty string.

I'm not yet sure which string should be empty and would break with the
new version. Can you elaborate?

Jan

>=20
>> +SRC_URI_append =3D " ${@
>> "git://gitlab.com/cip-project/cip-kernel/cip-kernel-config.git;protoco=
l=3Dhttps;destsuffix=3Dcip-kernel-config;name=3Dcip-kernel-config"
>> \
>> +=C2=A0=C2=A0=C2=A0 if d.getVar('USE_CIP_KERNEL_CONFIG') =3D=3D '1' el=
se '' \
>> +=C2=A0=C2=A0=C2=A0 }"
>> +
>> +SRC_URI_append_bbb =3D "file://${KERNEL_DEFCONFIG}"
>> +
>> =C2=A0 SRCREV_cip-kernel-config ?=3D "7f2930b9667372f94f2edb42ca9cf6fc=
6c0aed50"
>>
>> =C2=A0 S =3D "${WORKDIR}/linux-cip-v${PV}"
>> --=20
>> 2.29.2
>>
>=20
> Quirin

--=20
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

--aH9cGVpL4jSslsfCzKYB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6150): https://lists.cip-project.org/g/cip-dev/message=
/6150
Mute This Topic: https://lists.cip-project.org/mt/80109577/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--aH9cGVpL4jSslsfCzKYB--

Return-Path: <SRS0=z9tj=HA=lists.cip-project.org=bounce+64572+6153+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C428BC433E0
	for <cip-dev@archiver.kernel.org>; Fri, 29 Jan 2021 14:20:06 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D68A64DEC
	for <cip-dev@archiver.kernel.org>; Fri, 29 Jan 2021 14:20:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D68A64DEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6153+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id JPlOYY4521723xfAABLDUGtN; Fri, 29 Jan 2021 06:20:03 -0800
X-Received: from thoth.sbs.de (thoth.sbs.de [192.35.17.2])
 by mx.groups.io with SMTP id smtpd.web10.10094.1611930001703213740
 for <cip-dev@lists.cip-project.org>;
 Fri, 29 Jan 2021 06:20:03 -0800
X-Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
	by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id 10TEJxln010627
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Fri, 29 Jan 2021 15:19:59 +0100
X-Received: from [167.87.35.91] ([167.87.35.91])
	by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 10TEJwMQ012059;
	Fri, 29 Jan 2021 15:19:58 +0100
Subject: Re: [cip-dev] [isar-cip-core][PATCH] linux: Fix warning if USE_CIP_KERNEL_CONFIG is not defined
To: Jan Kiszka <jan.kiszka@siemens.com>,
        "Bezdeka, Florian (T RDA IOT SES-DE)" <florian.bezdeka@siemens.com>,
        "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <20210125172748.839290-1-florian.bezdeka@siemens.com>
 <a5e47480-6b59-e0c4-7a76-f9599ad05814@siemens.com>
 <247140a8-d733-598e-082f-4feda0679954@siemens.com>
 <9ea6b528-3db6-2e2f-ebeb-b7b8cd887341@siemens.com>
 <2549c747-7e63-71c6-8cc4-5a7fe18e84eb@siemens.com>
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
Message-ID: <b576f582-ea7f-4f42-6d35-14afc92caf8e@siemens.com>
Date: Fri, 29 Jan 2021 15:19:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <2549c747-7e63-71c6-8cc4-5a7fe18e84eb@siemens.com>
X-MIME-Autoconverted: from 8bit to quoted-printable by thoth.sbs.de id 10TEJxln010627
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 4kddeJigN8VHS7a83VbPKZ3Hx4520388AA=
Content-Type: multipart/mixed; boundary="5LPZvJZRynf0FIrM2Vkc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1611930003;
 bh=ypnGfVltGcHWJhqj5MOnTCYk1+wQa8NONCS+qYfqecU=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=Hma5Gi+EyPAKG/q0+LPRLRF3NbXAb9LJG3s1seGi7hW5hDnhuX3auWfkTCyp5uzD7K/
 DbhWsomcGkTR41iXwQ4lPq1oZxI7DD4fYi93Zo0g0WIKHSLwp1CbA/MNNMk8mQWWYuf9e
 S84MchZe+XhmidV5B3GR3KVOynL2PZz3lo4=

--5LPZvJZRynf0FIrM2Vkc
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 1/29/21 3:18 PM, Jan Kiszka wrote:
> On 29.01.21 13:22, Gylstorff Quirin wrote:
>>
>>
>> On 1/28/21 3:13 PM, Jan Kiszka wrote:
>>> On 25.01.21 19:23, Gylstorff Quirin wrote:
>>>>
>>>>
>>>> On 1/25/21 6:28 PM, Bezdeka, Florian (T RDA IOT SES-DE) wrote:
>>>>> USE_CIP_KERNEL_CONFIG may not be defined in all layers using the
>>>>> isar-cip-core layer, so we end up with the following warnings:
>>>>>
>>>>> WARNING:
>>>>> /work/cip-core/recipes-kernel/linux/linux-cip_4.19.140-cip33.bb:
>>>>> Unable to get checksum for linux-cip SRC_URI entry
>>>>> ${MACHINE}_defconfig: file could not be found
>>>>> WARNING:
>>>>> /work/cip-core/recipes-kernel/linux/linux-cip-rt_4.4.231-cip47-rt30=
.bb:
>>>>> Unable
>>>>> to get checksum for linux-cip-rt SRC_URI entry ${MACHINE}_defconfig=
:
>>>>> file could not be found
>>>>> WARNING:
>>>>> /work/cip-core/recipes-kernel/linux/linux-cip_4.4.230-cip47.bb: Una=
ble
>>>>> to get checksum for linux-cip SRC_URI entry ${MACHINE}_defconfig: f=
ile
>>>>> could not be found
>>>>> WARNING:
>>>>> /work/cip-core/recipes-kernel/linux/linux-cip-rt_4.19.135-cip31-rt1=
3.bb:
>>>>>
>>>>> Unable to get checksum for linux-cip-rt SRC_URI entry
>>>>> ${MACHINE}_defconfig: file could not be found
>>>>>
>>>>> ${MACHINE}_defconfig needs to be added to SRC_URI only if
>>>>> USE_CIP_KERNEL_CONFIG is set to "1".
>>>>>
>>>>> There is one in-tree machine definition (the bbb) that does not set
>>>>> USE_CIP_KERNEL_CONFIG to "1" but still needs the defconfig added.
>>>>> A machine specific SRC_URI was set to take care of that.
>>>>>
>>>>> Closes #7.
>>>>>
>>>>> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>>>>> ---
>>>>>
>>>>> Some additional notes:
>>>>>  =C2=A0=C2=A0=C2=A0 - That's my first contribution, so review caref=
ully ;-)
>>>>>  =C2=A0=C2=A0=C2=A0 - Both branches (master, next) are affected
>>>>>  =C2=A0=C2=A0=C2=A0 - The gitlab MR: [1]
>>>>>  =C2=A0=C2=A0=C2=A0 - The gitlab issue: [2]
>>>>>
>>>>>  =C2=A0=C2=A0=C2=A0 [1]
>>>>> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/merge_reque=
sts/10
>>>>>
>>>>>
>>>>>  =C2=A0=C2=A0=C2=A0 [2]
>>>>> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/7
>>>>>
>>>>>
>>>>>
>>>>>  =C2=A0=C2=A0 recipes-kernel/linux/linux-cip-common.inc | 15 ++++++=
---------
>>>>>  =C2=A0=C2=A0 1 file changed, 6 insertions(+), 9 deletions(-)
>>>>>
>>>>> diff --git a/recipes-kernel/linux/linux-cip-common.inc
>>>>> b/recipes-kernel/linux/linux-cip-common.inc
>>>>> index 6db1d1d..9aca9af 100644
>>>>> --- a/recipes-kernel/linux/linux-cip-common.inc
>>>>> +++ b/recipes-kernel/linux/linux-cip-common.inc
>>>>> @@ -11,21 +11,18 @@
>>>>>
>>>>>  =C2=A0=C2=A0 KERNEL_DEFCONFIG ?=3D "${MACHINE}_defconfig"
>>>>>
>>>>> -def conditional(variable, checkvalue, truevalue, falsevalue, d):
>>>>> -=C2=A0=C2=A0=C2=A0 if d.getVar(variable) =3D=3D checkvalue:
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return truevalue
>>>>> -=C2=A0=C2=A0=C2=A0 else:
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return falsevalue
>>>>> -
>>>>>  =C2=A0=C2=A0 require recipes-kernel/linux/linux-custom.inc
>>>>>
>>>>>  =C2=A0=C2=A0 SRC_URI +=3D " \
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 https://gitlab.com/cip-project/cip-=
kernel/linux-cip/-/archive/v$
>>>>> \
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "
>>>>>
>>>>> -SRC_URI_append =3D " ${@conditional("USE_CIP_KERNEL_CONFIG", "1", =
\
>>>>> -
>>>>> "git://gitlab.com/cip-project/cip-kernel/cip-kernel-config.git;prot=
ocol=3Dhttps;destsuffix=3Dcip-kernel-config;name=3Dcip-kernel-config",
>>>>>
>>>>> \
>>>>> -=C2=A0=C2=A0=C2=A0 "file://${KERNEL_DEFCONFIG}",d)}"
>>>> The easier way would have been to delete file://${KERNEL_DEFCONFIG}
>>>> instead of create the logic anew. The conditional function should al=
low
>>>> an empty string.
>>>
>>> I'm not yet sure which string should be empty and would break with th=
e
>>> new version. Can you elaborate?
>>>
>>> Jan
>>>
>>
>>
>> I will skip the url.
>> You could have written
>>
>> SRC_URI_append =3D=C2=A0 "${@conditional("USE_CIP_KERNEL_CONFIG",
>> "1","git://...","",d)"
>>
>> instead of
>>
>> SRC_URI_append =3D "${@ "git://..." if d.getVar('USE_CIP_KERNEL_CONFIG=
')
>> =3D=3D '1' else ''}"
>>
>> The result is the same. The second method saves some code in form of a
>> function.
>=20
> Means you are fine with Florian's patch? If there are no downsides, I
> would prefer that pattern as well.
>=20
> Jan

I'm fine with Florian's patch.

Quirin
>=20
>>
>> Quirin
>>>>
>>>>> +SRC_URI_append =3D "${@
>>>>> "git://gitlab.com/cip-project/cip-kernel/cip-kernel-config.git;prot=
ocol=3Dhttps;destsuffix=3Dcip-kernel-config;name=3Dcip-kernel-config"
>>>>>
>>>>> \
>>>>> +=C2=A0=C2=A0=C2=A0 if d.getVar('USE_CIP_KERNEL_CONFIG') =3D=3D '1'=
 else '' \
>>>>> +=C2=A0=C2=A0=C2=A0 }"
>>>>> +
>>>>> +SRC_URI_append_bbb =3D "file://${KERNEL_DEFCONFIG}"
>>>>> +
>>>>>  =C2=A0=C2=A0 SRCREV_cip-kernel-config ?=3D
>>>>> "7f2930b9667372f94f2edb42ca9cf6fc6c0aed50"
>>>>>
>>>>>  =C2=A0=C2=A0 S =3D "${WORKDIR}/linux-cip-v${PV}"
>>>>> --=20
>>>>> 2.29.2
>>>>>
>>>>
>>>> Quirin
>>>
>=20

--5LPZvJZRynf0FIrM2Vkc
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6153): https://lists.cip-project.org/g/cip-dev/message=
/6153
Mute This Topic: https://lists.cip-project.org/mt/80109577/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--5LPZvJZRynf0FIrM2Vkc--

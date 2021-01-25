Return-Path: <SRS0=rNnP=G4=lists.cip-project.org=bounce+64572+6140+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 029E3C433DB
	for <cip-dev@archiver.kernel.org>; Mon, 25 Jan 2021 18:23:49 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FE4A22D58
	for <cip-dev@archiver.kernel.org>; Mon, 25 Jan 2021 18:23:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FE4A22D58
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6140+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id segXYY4521723xIK0988gWJn; Mon, 25 Jan 2021 10:23:47 -0800
X-Received: from lizzard.sbs.de (lizzard.sbs.de [194.138.37.39])
 by mx.groups.io with SMTP id smtpd.web12.819.1611599026453383458
 for <cip-dev@lists.cip-project.org>;
 Mon, 25 Jan 2021 10:23:47 -0800
X-Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
	by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 10PINhAP005083
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Mon, 25 Jan 2021 19:23:44 +0100
X-Received: from [167.87.17.139] ([167.87.17.139])
	by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 10PINhaV022747;
	Mon, 25 Jan 2021 19:23:43 +0100
Subject: Re: [cip-dev] [isar-cip-core][PATCH] linux: Fix warning if USE_CIP_KERNEL_CONFIG is not defined
To: "Bezdeka, Florian (T RDA IOT SES-DE)" <florian.bezdeka@siemens.com>,
        "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Cc: "Kiszka, Jan (T RDA IOT)" <jan.kiszka@siemens.com>
References: <20210125172748.839290-1-florian.bezdeka@siemens.com>
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
Message-ID: <a5e47480-6b59-e0c4-7a76-f9599ad05814@siemens.com>
Date: Mon, 25 Jan 2021 19:23:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210125172748.839290-1-florian.bezdeka@siemens.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: DQRUvqdkIoMQYGFP1ak9qNw8x4520388AA=
Content-Type: multipart/mixed; boundary="2bHtrIdoEJ9Opl6EJPwK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1611599027;
 bh=5Kz7ZQsoAzehlVM433WRpN2L35PAzbB9UX68ZIS6PbM=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=KgbozCJDZax699pNaKGrZDv9uc4vAGECC0fUzG+AfMU3AOQ7X+IHAYtrsHPgaDqLMiz
 ydifnHdQi0/dosmOHfpHjGBwfHRz3xo+mtB9Jd18d7A0zpYBdAOfiIIHTrPDlHrhjTWiH
 XtGCk8xCVxEpB8YUFgN/3RWlE4HMtP3hHsc=

--2bHtrIdoEJ9Opl6EJPwK
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit



On 1/25/21 6:28 PM, Bezdeka, Florian (T RDA IOT SES-DE) wrote:
> USE_CIP_KERNEL_CONFIG may not be defined in all layers using the
> isar-cip-core layer, so we end up with the following warnings:
> 
> WARNING: /work/cip-core/recipes-kernel/linux/linux-cip_4.19.140-cip33.bb: Unable to get checksum for linux-cip SRC_URI entry ${MACHINE}_defconfig: file could not be found
> WARNING: /work/cip-core/recipes-kernel/linux/linux-cip-rt_4.4.231-cip47-rt30.bb: Unable to get checksum for linux-cip-rt SRC_URI entry ${MACHINE}_defconfig: file could not be found
> WARNING: /work/cip-core/recipes-kernel/linux/linux-cip_4.4.230-cip47.bb: Unable to get checksum for linux-cip SRC_URI entry ${MACHINE}_defconfig: file could not be found
> WARNING: /work/cip-core/recipes-kernel/linux/linux-cip-rt_4.19.135-cip31-rt13.bb: Unable to get checksum for linux-cip-rt SRC_URI entry ${MACHINE}_defconfig: file could not be found
> 
> ${MACHINE}_defconfig needs to be added to SRC_URI only if
> USE_CIP_KERNEL_CONFIG is set to "1".
> 
> There is one in-tree machine definition (the bbb) that does not set
> USE_CIP_KERNEL_CONFIG to "1" but still needs the defconfig added.
> A machine specific SRC_URI was set to take care of that.
> 
> Closes #7.
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
> 
> Some additional notes:
>    - That's my first contribution, so review carefully ;-)
>    - Both branches (master, next) are affected
>    - The gitlab MR: [1]
>    - The gitlab issue: [2]
> 
>    [1]  https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.com%2Fcip-project%2Fcip-core%2Fisar-cip-core%2F-%2Fmerge_requests%2F10&amp;data=04%7C01%7C6549bcd2-981c-4c06-8e1b-b5c6cc3441b4%40ad011.siemens.com%7C1a78e530b9ba4e41925b08d8c156918d%7C38ae3bcd95794fd4addab42e1495d55a%7C1%7C0%7C637471924851339538%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=FHMuzH9wdzo2s%2FHfd5B2y3sMfOSN7Y1ZF23E8xa4TEg%3D&amp;reserved=0
>    [2]  https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.com%2Fcip-project%2Fcip-core%2Fisar-cip-core%2F-%2Fissues%2F7&amp;data=04%7C01%7C6549bcd2-981c-4c06-8e1b-b5c6cc3441b4%40ad011.siemens.com%7C1a78e530b9ba4e41925b08d8c156918d%7C38ae3bcd95794fd4addab42e1495d55a%7C1%7C0%7C637471924851349487%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=NCLmMQK68OT0eM9lr2FN85i8EIdkvz73gc1ewGmGCjc%3D&amp;reserved=0
> 
> 
>   recipes-kernel/linux/linux-cip-common.inc | 15 ++++++---------
>   1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/recipes-kernel/linux/linux-cip-common.inc b/recipes-kernel/linux/linux-cip-common.inc
> index 6db1d1d..9aca9af 100644
> --- a/recipes-kernel/linux/linux-cip-common.inc
> +++ b/recipes-kernel/linux/linux-cip-common.inc
> @@ -11,21 +11,18 @@
> 
>   KERNEL_DEFCONFIG ?= "${MACHINE}_defconfig"
> 
> -def conditional(variable, checkvalue, truevalue, falsevalue, d):
> -    if d.getVar(variable) == checkvalue:
> -        return truevalue
> -    else:
> -        return falsevalue
> -
>   require recipes-kernel/linux/linux-custom.inc
> 
>   SRC_URI += " \
>       https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.com%2Fcip-project%2Fcip-kernel%2Flinux-cip%2F-%2Farchive%2Fv%24&amp;data=04%7C01%7C6549bcd2-981c-4c06-8e1b-b5c6cc3441b4%40ad011.siemens.com%7C1a78e530b9ba4e41925b08d8c156918d%7C38ae3bcd95794fd4addab42e1495d55a%7C1%7C0%7C637471924851349487%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=lPFSoIApETXAdkPI0fyWSfK%2FuIThRGuBQx9kOf3MQ5s%3D&amp;reserved=0{PV}/linux-cip-v${PV}.tar.gz \
>       "
> 
> -SRC_URI_append = " ${@conditional("USE_CIP_KERNEL_CONFIG", "1", \
> -    "git://gitlab.com/cip-project/cip-kernel/cip-kernel-config.git;protocol=https;destsuffix=cip-kernel-config;name=cip-kernel-config", \
> -    "file://${KERNEL_DEFCONFIG}",d)}"
The easier way would have been to delete file://${KERNEL_DEFCONFIG} 
instead of create the logic anew. The conditional function should allow 
an empty string.

> +SRC_URI_append = " ${@ "git://gitlab.com/cip-project/cip-kernel/cip-kernel-config.git;protocol=https;destsuffix=cip-kernel-config;name=cip-kernel-config" \
> +    if d.getVar('USE_CIP_KERNEL_CONFIG') == '1' else '' \
> +    }"
> +
> +SRC_URI_append_bbb = "file://${KERNEL_DEFCONFIG}"
> +
>   SRCREV_cip-kernel-config ?= "7f2930b9667372f94f2edb42ca9cf6fc6c0aed50"
> 
>   S = "${WORKDIR}/linux-cip-v${PV}"
> --
> 2.29.2
> 

Quirin

--2bHtrIdoEJ9Opl6EJPwK
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6140): https://lists.cip-project.org/g/cip-dev/message=
/6140
Mute This Topic: https://lists.cip-project.org/mt/80109577/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--2bHtrIdoEJ9Opl6EJPwK--

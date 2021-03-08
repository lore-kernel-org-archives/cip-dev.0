Return-Path: <SRS0=w7tW=IG=lists.cip-project.org=bounce+64572+6215+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C6CC433DB
	for <cip-dev@archiver.kernel.org>; Mon,  8 Mar 2021 13:24:15 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E84D9651BB
	for <cip-dev@archiver.kernel.org>; Mon,  8 Mar 2021 13:24:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E84D9651BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6215+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id HHetYY4521723xSj45x2Vo8z; Mon, 08 Mar 2021 05:24:14 -0800
X-Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web09.35574.1615209853241062147
 for <cip-dev@lists.cip-project.org>;
 Mon, 08 Mar 2021 05:24:14 -0800
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 128DOBQA002652
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Mon, 8 Mar 2021 14:24:11 +0100
X-Received: from [167.87.91.100] ([167.87.91.100])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 128DOBD8020723;
	Mon, 8 Mar 2021 14:24:11 +0100
Subject: Re: [cip-dev][isar-cip-core][PATCH 2/2] linux-cip: Update cip-kernel-config
To: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>,
        cip-dev@lists.cip-project.org
References: <20210304170934.7424-1-Quirin.Gylstorff@siemens.com>
 <20210304170934.7424-3-Quirin.Gylstorff@siemens.com>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <c05ff822-8fe2-f8f4-5abf-145c5bc85fe8@siemens.com>
Date: Mon, 8 Mar 2021 14:24:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210304170934.7424-3-Quirin.Gylstorff@siemens.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: BWRNBp2LyKOJu2YA1IozDFlhx4520388AA=
Content-Type: multipart/mixed; boundary="yKvErNEF5ka306s1Y09W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1615209854;
 bh=3gvrKfxkybiP2TXHa3z9Q9lV9lPf9jocFL24BKFWOus=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=aodykxW/SQ09/0KtZlH3gn5KIPq9b9v6N5d82biBFKYTZ30Jc+No8oF3vHJ/XpSQ53Q
 ZbNkgrj/Obiij5Em3oQv8X6nncC7M0mip37juwZYOzTpmN76Un6wwbMIYnI9zVDsScc4y
 c9mgSBt+UWGzX+IScIl86IHURNGtOnDmUho=

--yKvErNEF5ka306s1Y09W
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 04.03.21 18:09, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Update the commmit to "22001e31c9ddf93b266b00c563e7b92f0ee21548".
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  recipes-kernel/linux/linux-cip-common.inc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/recipes-kernel/linux/linux-cip-common.inc b/recipes-kernel/linux/linux-cip-common.inc
> index 6db1d1d..85696f8 100644
> --- a/recipes-kernel/linux/linux-cip-common.inc
> +++ b/recipes-kernel/linux/linux-cip-common.inc
> @@ -26,6 +26,6 @@ SRC_URI += " \
>  SRC_URI_append = " ${@conditional("USE_CIP_KERNEL_CONFIG", "1", \
>      "git://gitlab.com/cip-project/cip-kernel/cip-kernel-config.git;protocol=https;destsuffix=cip-kernel-config;name=cip-kernel-config", \
>      "file://${KERNEL_DEFCONFIG}",d)}"
> -SRCREV_cip-kernel-config ?= "7f2930b9667372f94f2edb42ca9cf6fc6c0aed50"
> +SRCREV_cip-kernel-config ?= "22001e31c9ddf93b266b00c563e7b92f0ee21548"
>  
>  S = "${WORKDIR}/linux-cip-v${PV}"
> 

Already done (Srinu's patch).

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

--yKvErNEF5ka306s1Y09W
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6215): https://lists.cip-project.org/g/cip-dev/message=
/6215
Mute This Topic: https://lists.cip-project.org/mt/81082367/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--yKvErNEF5ka306s1Y09W--

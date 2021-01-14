Return-Path: <SRS0=wuZa=GR=lists.cip-project.org=bounce+64572+6084+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28FBAC433DB
	for <cip-dev@archiver.kernel.org>; Thu, 14 Jan 2021 06:06:59 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71AFD238E7
	for <cip-dev@archiver.kernel.org>; Thu, 14 Jan 2021 06:06:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71AFD238E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6084+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id nPg3YY4521723xQ157T9pP1e; Wed, 13 Jan 2021 22:06:57 -0800
X-Received: from lizzard.sbs.de (lizzard.sbs.de [194.138.37.39])
 by mx.groups.io with SMTP id smtpd.web09.4346.1610604415732249385
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Jan 2021 22:06:57 -0800
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 10E66rah009304
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Jan 2021 07:06:54 +0100
X-Received: from [167.87.43.185] ([167.87.43.185])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 10E66rq5024670;
	Thu, 14 Jan 2021 07:06:53 +0100
Subject: Re: [cip-dev] [isar-cip-core][PATCH] linux-cip-common: Add files directory to FILESEXTRAPATHS
To: cip-dev@lists.cip-project.org,
        "Kanagarajan, Vijaikumar" <Vijaikumar_Kanagarajan@mentor.com>
Cc: quirin.gylstorff@siemens.com
References: <20210113212505.15175-1-Vijaikumar_Kanagarajan@mentor.com>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <e8286b00-b8b3-cec0-58ac-9a92b977c7dd@siemens.com>
Date: Thu, 14 Jan 2021 07:06:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210113212505.15175-1-Vijaikumar_Kanagarajan@mentor.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 9FNZ47bGdLTMEtirl1DOnS6Lx4520388AA=
Content-Type: multipart/mixed; boundary="oNQj6aXOgLp4DV5xJNJr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1610604417;
 bh=g1sJib38VIyRc76ozSI29jJ1t7Wq30OuI+7IAd7NJiA=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=WajjxhqucATyQ8wb2JbAJKSOcLd9GlpLKXKeYNSv+PBlBs1EqH9QA+R20DvP08D1/kI
 NsPyOmS/6IlRUx9UMdkyWtUIX6TH3hXjtUH9CyokWDRrEew0KOV+mEr5Fwvgw33DFLqV9
 6+xNGxd+Lus4yGfLlY8vSETm9BsnoB1KtXA=

--oNQj6aXOgLp4DV5xJNJr
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 13.01.21 22:25, Kanagarajan, Vijaikumar wrote:
> Add recipes-kernel/linux/files directory to searchpath.
> 
> Files like preempt-rt.cfg are not accesible when you use
> the linux-cip-rt-common.inc file in linux recipes defined
> in other layers.
> This makes the linux-cip-rt-common.inc file unusable in
> other layers.
> 
> Fix that by adding recipes-kernel/linux/files to
> FILESEXTRAPATHS.
> 
> Signed-off-by: Vijai Kumar K <Vijaikumar_Kanagarajan@mentor.com>
> ---
>  recipes-kernel/linux/linux-cip-common.inc | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/recipes-kernel/linux/linux-cip-common.inc b/recipes-kernel/linux/linux-cip-common.inc
> index 6db1d1d..f35168f 100644
> --- a/recipes-kernel/linux/linux-cip-common.inc
> +++ b/recipes-kernel/linux/linux-cip-common.inc
> @@ -9,6 +9,8 @@
>  # SPDX-License-Identifier: MIT
>  #
>  
> +FILESEXTRAPATHS_prepend := "${FILE_DIRNAME}/files:"
> +
>  KERNEL_DEFCONFIG ?= "${MACHINE}_defconfig"
>  
>  def conditional(variable, checkvalue, truevalue, falsevalue, d):
> 
> 
> 

Thanks, applied.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

--oNQj6aXOgLp4DV5xJNJr
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6084): https://lists.cip-project.org/g/cip-dev/message=
/6084
Mute This Topic: https://lists.cip-project.org/mt/79661830/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--oNQj6aXOgLp4DV5xJNJr--

Return-Path: <SRS0=7iGX=BJ=lists.cip-project.org=bounce+64572+5068+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43ABBC433DF
	for <cip-dev@archiver.kernel.org>; Thu, 30 Jul 2020 09:21:25 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0622920809
	for <cip-dev@archiver.kernel.org>; Thu, 30 Jul 2020 09:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="EeCUVpKS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0622920809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5068+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id QeJsYY4521723xkQKpKt504U; Thu, 30 Jul 2020 02:21:24 -0700
X-Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web12.4735.1596100882968997553
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 Jul 2020 02:21:23 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 06U9LK3G018325
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2020 11:21:20 +0200
X-Received: from [167.87.91.228] ([167.87.91.228])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 06U9LKST009468;
	Thu, 30 Jul 2020 11:21:20 +0200
Subject: Re: [cip-dev] [isar-cip-core 1/2] opt: Add kas option file for security image
To: venkata.pyla@toshiba-tsip.com
Cc: cip-dev@lists.cip-project.org
References: <20200730091022.602-1-venkata.pyla@toshiba-tsip.com>
 <20200730091022.602-2-venkata.pyla@toshiba-tsip.com>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <51ec0d91-7eae-0c2d-5711-ab20f4b7ad26@siemens.com>
Date: Thu, 30 Jul 2020 11:21:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200730091022.602-2-venkata.pyla@toshiba-tsip.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 2I4mbhz37zDL4YLZ4qIjfxSyx4520388AA=
Content-Type: multipart/mixed; boundary="X5bxBPzolgRDCi92v6oV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1596100884;
 bh=IPRnUUFj2Pk/locbIzPoIcP02jw0ZRijVw6hRcCwgxY=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=EeCUVpKSEwzURSugyLYHq8S3tQTQqR/wyvFDRI6lfpr522nFCtFnhYJkeabnnMjslUJ
 1ZE6fs3+IlQO4vSTO+Eiog37UhTAdz3LStgz2i7L4kVZeDw2LRRlUSq6zTgX0yUTE1R5p
 DOYLJcMMApre0Pb18gcvmIArEGdHbeT5C7A=

--X5bxBPzolgRDCi92v6oV
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 30.07.20 11:10, venkata.pyla@toshiba-tsip.com wrote:
> From: venkata pyla <venkata.pyla@toshiba-tsip.com>
> 
> Signed-off-by: Venkata Pyla <venkata.pyla@toshiba-tsip.com>

Different capitalization of your name. Only reporting that as my tooling 
detected this mismatch. It checks if signed-off and authorship match.

Both patches applied to next - let's get CI started.

Thanks,
Jan

> ---
>   README.md            |  2 +-
>   kas/opt/security.yml | 14 ++++++++++++++
>   2 files changed, 15 insertions(+), 1 deletion(-)
>   create mode 100644 kas/opt/security.yml
> 
> diff --git a/README.md b/README.md
> index 26fbbef..250dbad 100644
> --- a/README.md
> +++ b/README.md
> @@ -39,7 +39,7 @@ card, run
>   ## Building Security target images
>   Building images for QEMU x86-64bit machine
>   
> -    ./kas-docker --isar build --target cip-core-image-security kas.yml:board-qemu-amd64.yml
> +    ./kas-docker --isar build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/security.yml
>   
>   Run the generated securiy images on QEMU (x86-64bit)
>   
> diff --git a/kas/opt/security.yml b/kas/opt/security.yml
> new file mode 100644
> index 0000000..237cbeb
> --- /dev/null
> +++ b/kas/opt/security.yml
> @@ -0,0 +1,14 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Toshiba Corporation, 2020
> +#
> +# Authors:
> +#  Venkata Pyla <venkata.pyla@toshiba-tsip.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +header:
> +  version: 8
> +
> +target: cip-core-image-security
> 

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

--X5bxBPzolgRDCi92v6oV
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5068): https://lists.cip-project.org/g/cip-dev/message=
/5068
Mute This Topic: https://lists.cip-project.org/mt/75882938/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--X5bxBPzolgRDCi92v6oV--

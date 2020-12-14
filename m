Return-Path: <SRS0=I8hK=FS=lists.cip-project.org=bounce+64572+5965+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77ADBC4361B
	for <cip-dev@archiver.kernel.org>; Mon, 14 Dec 2020 09:46:24 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBF6520882
	for <cip-dev@archiver.kernel.org>; Mon, 14 Dec 2020 09:46:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBF6520882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5965+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id cljmYY4521723xFPyIkwBqNH; Mon, 14 Dec 2020 01:46:23 -0800
X-Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web10.32051.1607939182331611220
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Dec 2020 01:46:22 -0800
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 0BE9kKwO002225
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Mon, 14 Dec 2020 10:46:20 +0100
X-Received: from [167.87.38.225] ([167.87.38.225])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 0BE9kKeo031580;
	Mon, 14 Dec 2020 10:46:20 +0100
Subject: Re: [cip-dev][isar-cip-core][PATCH v3] initramfs-config: remove FILESPATH
To: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>,
        cip-dev@lists.cip-project.org
References: <292d014e-f372-7276-0a0e-8aaafcf5dd2f@siemens.com>
 <20201214094506.7643-1-Quirin.Gylstorff@siemens.com>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <4eaa15b1-53bd-85e5-167d-2116be799e0a@siemens.com>
Date: Mon, 14 Dec 2020 10:46:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201214094506.7643-1-Quirin.Gylstorff@siemens.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: ioT08FF7nf1XwCXmnlX1dyXDx4520388AA=
Content-Type: multipart/mixed; boundary="N9WPRXA8oVV5YnNyhPUx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1607939183;
 bh=cZbzDngUR4PhkrXg7YTWDt6Ko8tEgcmUGL+WtFjof8A=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=FV59owNvi1WYG9OoDbofU7Mb+MfXfOXZajSFXqPWaqdeOm8EHeq0TTR5rGrOAwhKSds
 s3lvHcyZ9gzBnIcMFbST0Bs7twTKwoG8jw2b4pEasSDAtZKdYbEtql6PgwCsQidD/Ibx5
 8qhEFw7FRd3DNiOTXQBWBHiM1f46YSAYmoo=

--N9WPRXA8oVV5YnNyhPUx
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 14.12.20 10:45, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> The file patch is wrong and not necessary.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  .../initramfs-config/initramfs-abrootfs-secureboot_0.1.bb        | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/recipes-support/initramfs-config/initramfs-abrootfs-secureboot_0.1.bb b/recipes-support/initramfs-config/initramfs-abrootfs-secureboot_0.1.bb
> index 4243b41..a5e09a2 100644
> --- a/recipes-support/initramfs-config/initramfs-abrootfs-secureboot_0.1.bb
> +++ b/recipes-support/initramfs-config/initramfs-abrootfs-secureboot_0.1.bb
> @@ -10,7 +10,6 @@
>  
>  require recipes-support/initramfs-config/initramfs-config.inc
>  
> -FILESPATH =. "${LAYERDIR_isar-siemens}/recipes-support/initramfs-config/files:"
>  
>  DEBIAN_DEPENDS += ", busybox, patch"
>  
> 

Thanks, applied (with extra blank line removal).

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

--N9WPRXA8oVV5YnNyhPUx
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5965): https://lists.cip-project.org/g/cip-dev/message=
/5965
Mute This Topic: https://lists.cip-project.org/mt/78947302/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--N9WPRXA8oVV5YnNyhPUx--

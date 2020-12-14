Return-Path: <SRS0=qYiX=FS=lists.cip-project.org=bounce+64572+5958+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA71C4361B
	for <cip-dev@archiver.kernel.org>; Mon, 14 Dec 2020 07:43:51 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F315A225AC
	for <cip-dev@archiver.kernel.org>; Mon, 14 Dec 2020 07:43:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F315A225AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5958+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id lv5iYY4521723xzZpPwMQUcN; Sun, 13 Dec 2020 23:43:49 -0800
X-Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web10.31133.1607931827381840775
 for <cip-dev@lists.cip-project.org>;
 Sun, 13 Dec 2020 23:43:48 -0800
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 0BE7hjdw007524
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Mon, 14 Dec 2020 08:43:45 +0100
X-Received: from [167.87.38.225] ([167.87.38.225])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 0BE7hinV013003;
	Mon, 14 Dec 2020 08:43:45 +0100
Subject: Re: [cip-dev][isar-cip-core][PATCH 1/2] initramfs-config: use correct syntax for FILESPATH
To: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>,
        cip-dev@lists.cip-project.org
References: <20201211135448.17147-1-Quirin.Gylstorff@siemens.com>
 <20201211135448.17147-2-Quirin.Gylstorff@siemens.com>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <6c1a0b90-4242-987b-5802-0dcb8ea3505d@siemens.com>
Date: Mon, 14 Dec 2020 08:43:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201211135448.17147-2-Quirin.Gylstorff@siemens.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: o3HHpHnGEJrQZ7cLKxPOygbgx4520388AA=
Content-Type: multipart/mixed; boundary="dxnxQe6vkWQqYBLlCTGP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1607931829;
 bh=Jzao2vPgqTXwjgsrk6ab21G5wb0yy4Aued8yx373dQA=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=YQ5jDUCp6UG+UXM/1Ya0Akgqth5fx+zgnDClVa4aftbnFPzmOaTgfJSvjG2l1RLmc6c
 OxsEWYgRRlqowrvXp0RFfxVZB6QmTjGSD5qgjWsP2g8myU09qrGe8qAAsS9IcYE0RcHct
 B79lUWg/885Dm1gY2vjxus08ja0EQpfrmHs=

--dxnxQe6vkWQqYBLlCTGP
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 11.12.20 14:54, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> replace the incorrect usage.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  .../initramfs-config/initramfs-abrootfs-secureboot_0.1.bb       | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/recipes-support/initramfs-config/initramfs-abrootfs-secureboot_0.1.bb b/recipes-support/initramfs-config/initramfs-abrootfs-secureboot_0.1.bb
> index 4243b41..68d064f 100644
> --- a/recipes-support/initramfs-config/initramfs-abrootfs-secureboot_0.1.bb
> +++ b/recipes-support/initramfs-config/initramfs-abrootfs-secureboot_0.1.bb
> @@ -10,7 +10,7 @@
>  
>  require recipes-support/initramfs-config/initramfs-config.inc
>  
> -FILESPATH =. "${LAYERDIR_isar-siemens}/recipes-support/initramfs-config/files:"
> +FILESEXTRAPATHS_prepend := "${FILE_DIRNAME}/files:"
>  

"files" is in the default search path of every recipe - just drop that
line I would say.

Jan

>  DEBIAN_DEPENDS += ", busybox, patch"
>  
> 

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

--dxnxQe6vkWQqYBLlCTGP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5958): https://lists.cip-project.org/g/cip-dev/message=
/5958
Mute This Topic: https://lists.cip-project.org/mt/78879163/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--dxnxQe6vkWQqYBLlCTGP--

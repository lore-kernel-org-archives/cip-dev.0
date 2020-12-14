Return-Path: <SRS0=FPHw=FS=lists.cip-project.org=bounce+64572+5962+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3091C4361B
	for <cip-dev@archiver.kernel.org>; Mon, 14 Dec 2020 09:24:14 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A67820771
	for <cip-dev@archiver.kernel.org>; Mon, 14 Dec 2020 09:24:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A67820771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5962+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id bLzKYY4521723xni0UBSBQO4; Mon, 14 Dec 2020 01:24:13 -0800
X-Received: from goliath.siemens.de (goliath.siemens.de [192.35.17.28])
 by mx.groups.io with SMTP id smtpd.web09.32375.1607937852510549962
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Dec 2020 01:24:13 -0800
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 0BE9OAS4011770
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Mon, 14 Dec 2020 10:24:10 +0100
X-Received: from [167.87.38.225] ([167.87.38.225])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 0BE9OARo027372;
	Mon, 14 Dec 2020 10:24:10 +0100
Subject: Re: [cip-dev][isar-cip-core][PATCH v2] initramfs-config: use correct syntax for FILESPATH
To: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>,
        cip-dev@lists.cip-project.org
References: <6c1a0b90-4242-987b-5802-0dcb8ea3505d@siemens.com>
 <20201214092257.385-1-Quirin.Gylstorff@siemens.com>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <292d014e-f372-7276-0a0e-8aaafcf5dd2f@siemens.com>
Date: Mon, 14 Dec 2020 10:24:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201214092257.385-1-Quirin.Gylstorff@siemens.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: HNh1JQ4X04xWlatmFMuKmfm5x4520388AA=
Content-Type: multipart/mixed; boundary="s5wwUoxYEuhwD0FxCV9e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1607937853;
 bh=fw5+1nOpY2Tta3SVmKGR6PQtIo93Kiu1glDweijzqJ8=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=P7rjAoW4yUnVdGRRNB+sc37bOP3Qa2RN8edwS4qF5wdcn1RZrHsiFRSc6eRXnA+MA6h
 Df8HTObIrTIRzPRkSxKWUC6wNWFaszs8Dcz3Zc4ESCBDqHQFYkDGr93AGhSn/78cDjESh
 9JwJdFEabKXbB5uXq1SHWqz14tQ9eztKT+k=

--s5wwUoxYEuhwD0FxCV9e
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 14.12.20 10:22, Q. Gylstorff wrote:
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
> index 4243b41..3322d71 100644
> --- a/recipes-support/initramfs-config/initramfs-abrootfs-secureboot_0.1.bb
> +++ b/recipes-support/initramfs-config/initramfs-abrootfs-secureboot_0.1.bb
> @@ -10,7 +10,7 @@
>  
>  require recipes-support/initramfs-config/initramfs-config.inc
>  
> -FILESPATH =. "${LAYERDIR_isar-siemens}/recipes-support/initramfs-config/files:"
> +FILESEXTRAPATHS_prepend := "${FILE_DIRNAME}:"
>  

Why that? Just remove FILESPATH, do not add anything, and it should
still work.

Jan

>  DEBIAN_DEPENDS += ", busybox, patch"
>  
> 


-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

--s5wwUoxYEuhwD0FxCV9e
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5962): https://lists.cip-project.org/g/cip-dev/message=
/5962
Mute This Topic: https://lists.cip-project.org/mt/78947110/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--s5wwUoxYEuhwD0FxCV9e--

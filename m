Return-Path: <SRS0=wp6a=BI=lists.cip-project.org=bounce+64572+5048+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A53C433E0
	for <cip-dev@archiver.kernel.org>; Wed, 29 Jul 2020 16:47:33 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FB7320809
	for <cip-dev@archiver.kernel.org>; Wed, 29 Jul 2020 16:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="D/06Xr56"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FB7320809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5048+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 2ASNYY4521723xCzEHNWwqaV; Wed, 29 Jul 2020 09:47:32 -0700
X-Received: from goliath.siemens.de (goliath.siemens.de [192.35.17.28])
 by mx.groups.io with SMTP id smtpd.web10.400.1596041251474152777
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 Jul 2020 09:47:32 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 06TGlSPQ020615
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Wed, 29 Jul 2020 18:47:29 +0200
X-Received: from [167.87.13.2] ([167.87.13.2])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 06TGlShU015046;
	Wed, 29 Jul 2020 18:47:28 +0200
Subject: Re: [cip-dev] [isar-cip-core PATCH v3 1/6] kernel: add fat for qemu-amd64
To: cip-dev@lists.cip-project.org,
        Quirin Gylstorff <quirin.gylstorff@siemens.com>
References: <20200629125400.13968-1-Quirin.Gylstorff@siemens.com>
 <20200724150147.8253-1-Quirin.Gylstorff@siemens.com>
 <20200724150147.8253-2-Quirin.Gylstorff@siemens.com>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <abdbf160-34d1-0d84-f218-2efaaf9dd355@siemens.com>
Date: Wed, 29 Jul 2020 18:47:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200724150147.8253-2-Quirin.Gylstorff@siemens.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: Dy6J4Ne69s3iwTCB1djN4vOIx4520388AA=
Content-Type: multipart/mixed; boundary="Sed5CH6kFQYZL2EqEqc0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1596041252;
 bh=J02W/BWtDSn2ODW4LgBAEDdiFamgHobJY9n/4mzPGk8=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=D/06Xr56MDse0vUimxMQlVGwUGaXb22eodbKtuGvmA/TsNVRdMvSe01H/jTxiBe4UUT
 kd9Omo6zdCP8LfJTCW1UjbqRrABeR3HB12D3Czgfpd3KcOLCkZqwvE7rI9UNHJZPcXib1
 Q9KzrRFpwgUzOc/+6RLca9u6K3bO+w2/KaA=

--Sed5CH6kFQYZL2EqEqc0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 24.07.20 17:01, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Add a fat configuration to access FAT Partitions on the qemu-amd64
> target.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>   recipes-kernel/linux/files/qemu-amd64_defconfig | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/recipes-kernel/linux/files/qemu-amd64_defconfig b/recipes-kernel/linux/files/qemu-amd64_defconfig
> index 7487152..5449317 100644
> --- a/recipes-kernel/linux/files/qemu-amd64_defconfig
> +++ b/recipes-kernel/linux/files/qemu-amd64_defconfig
> @@ -351,3 +351,9 @@ CONFIG_CRYPTO_DEV_CCP=y
>   # CONFIG_XZ_DEC_ARM is not set
>   # CONFIG_XZ_DEC_ARMTHUMB is not set
>   # CONFIG_XZ_DEC_SPARC is not set
> +CONFIG_MSDOS_FS=y
> +CONFIG_VFAT_FS=y
> +CONFIG_NLS_ASCII=y
> +CONFIG_NLS_CODEPAGE_437=y
> +CONFIG_NLS_ISO8859_1=y
> +CONFIG_NLS_UTF8=y
> 

Taking that for now, but we should quickly move that defconfig into 
cip-kernel-config. I'm not sure if there is anything for qemu already. 
Could you check an propose our defconfig for it?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

--Sed5CH6kFQYZL2EqEqc0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5048): https://lists.cip-project.org/g/cip-dev/message=
/5048
Mute This Topic: https://lists.cip-project.org/mt/75767901/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--Sed5CH6kFQYZL2EqEqc0--

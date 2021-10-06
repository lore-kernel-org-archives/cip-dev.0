Return-Path: <SRS0=6XJu=O2=lists.cip-project.org=bounce+64572+6795+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C3ACC433EF
	for <cip-dev@archiver.kernel.org>; Wed,  6 Oct 2021 17:44:22 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EED360FC3
	for <cip-dev@archiver.kernel.org>; Wed,  6 Oct 2021 17:44:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1EED360FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 3C3hYY4521723xsoItPO4scv; Wed, 06 Oct 2021 10:44:21 -0700
X-Received: from goliath.siemens.de (goliath.siemens.de [192.35.17.28])
 by mx.groups.io with SMTP id smtpd.web12.291.1633542260593144428
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Oct 2021 10:44:21 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 196HiHr0016801
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Oct 2021 19:44:17 +0200
X-Received: from [167.87.72.94] ([167.87.72.94])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 196HiHNX005411;
	Wed, 6 Oct 2021 19:44:17 +0200
Subject: Re: [cip-dev] [isar-cip-dev] [PATCH] Uprevision the ISAR to latest one
To: Srinuvasan A <Srinuvasan_A@mentor.com>, cip-dev@lists.cip-project.org
References: <20211006101422.1976005-1-Srinuvasan_A@mentor.com>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <cea9be82-1809-0ea8-55d7-7074c4e7e55f@siemens.com>
Date: Wed, 6 Oct 2021 19:44:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211006101422.1976005-1-Srinuvasan_A@mentor.com>
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 6DBwWsA9XGv9zKMUMbOBl3A5x4520388AA=
Content-Type: multipart/mixed; boundary="W7rBC8p2oj7CoV4a9Cyt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1633542261;
 bh=ZaKrpBcLzFWUKNSnyJ32uP8LzHQ4/ZCo0JG5+zT7qRk=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=tOQeUJ9BsjJwww9LSE9T/rLnL61evnhelkQuN0/gqHalWv4eYH+4nmkqih7QeFrbk2e
 D65WZ/+mg266hdPngHn1z+S74ur9KZSWGK5ZPDHfa7+PxCqLpV3PXnKPfAh2GaL255Px+
 8B0JurL3abT0z8hOzKnEqVIDu7rJRVeRze4=
Message-ID: <20211006174416.Exx6Ui3PwQIQB2uQzEWcEWWiwITJnmu9Hsmcdinrf-Y@z>

--W7rBC8p2oj7CoV4a9Cyt
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 06.10.21 12:14, Srinuvasan A wrote:
> From: Srinuvasan A <srinuvasan_a@mentor.com>
> 
> Update to latest ISAR.
> 
> When we build the images with efibootguard wic plugin it is expecting
> the KERNEL_IMAGE and INITRD_IMAGE variable, but it is removed in
> Upstream ISAR due to cleanup the unused variables.
> 
> Ref: https://github.com/ilbers/isar/commit/6fa0197ac36a86b2ae5c27f5b7804dd9a46d3c0b
> 
> But those variables we used in downstream layer with efibootguard wic
> plugin hence added required WIC variables in efibootguard.yml to genereate successful wic images.
> 
> Signed-off-by: Srinuvasan A <srinuvasan_a@mentor.com>
> ---
>  kas-cip.yml              | 2 +-
>  kas/opt/efibootguard.yml | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kas-cip.yml b/kas-cip.yml
> index 8522957..4eadaa7 100644
> --- a/kas-cip.yml
> +++ b/kas-cip.yml
> @@ -22,7 +22,7 @@ repos:
>  
>    isar:
>      url: https://github.com/ilbers/isar.git
> -    refspec: 03124cca669f50b682336a0bdf4ede5a4238e144
> +    refspec: 9b31dae3284127d4aed4b9331af1b1c3c31152f5
>      layers:
>        meta:
>  
> diff --git a/kas/opt/efibootguard.yml b/kas/opt/efibootguard.yml
> index 705a76d..580c315 100644
> --- a/kas/opt/efibootguard.yml
> +++ b/kas/opt/efibootguard.yml
> @@ -22,7 +22,7 @@ local_conf_header:
>  
>    efibootguard-wic: |
>      WDOG_TIMEOUT ?= "60"
> -    WICVARS += "WDOG_TIMEOUT"
> +    WICVARS += "WDOG_TIMEOUT KERNEL_IMAGE INITRD_IMAGE"
>      IMAGE_TYPE ?= "wic-img"
>      WKS_FILE ?= "${MACHINE}-${SWUPDATE_BOOTLOADER}.wks"
>  
> 

Thanks, applied.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

--W7rBC8p2oj7CoV4a9Cyt
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6795): https://lists.cip-project.org/g/cip-dev/message/=
6795
Mute This Topic: https://lists.cip-project.org/mt/86115871/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--W7rBC8p2oj7CoV4a9Cyt--

Return-Path: <SRS0=6zC1=OZ=lists.cip-project.org=bounce+64572+6784+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC84CC433F5
	for <cip-dev@archiver.kernel.org>; Tue,  5 Oct 2021 13:08:24 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F42261354
	for <cip-dev@archiver.kernel.org>; Tue,  5 Oct 2021 13:08:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4F42261354
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 4N0SYY4521723xW6bVIrUPR2; Tue, 05 Oct 2021 06:08:24 -0700
X-Received: from david.siemens.de (david.siemens.de [192.35.17.14])
 by mx.groups.io with SMTP id smtpd.web11.21.1633439159878238899
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Oct 2021 06:06:00 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 195D5uPh010591
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 Oct 2021 15:05:57 +0200
X-Received: from [167.87.39.245] ([167.87.39.245])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 195D5uMH002385;
	Tue, 5 Oct 2021 15:05:56 +0200
Subject: Re: [cip-dev] [isar-cip-dev] [PATCH] Uprevision cip-kernels to latest one
To: cip-dev@lists.cip-project.org
Cc: Srinuvasan A <srinuvasan_a@mentor.com>
References: <20211005064703.B-_uDfQwwzE6k0feU9U2_E4YZ8onL3WNkUYUyjPUhXs@z>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <c2435647-ce3a-38aa-2285-28232a7eb8e7@siemens.com>
Date: Tue, 5 Oct 2021 15:05:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211005064703.B-_uDfQwwzE6k0feU9U2_E4YZ8onL3WNkUYUyjPUhXs@z>
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: cdqRqOjQbZYWC7MdOjiOWR8Tx4520388AA=
Content-Type: multipart/mixed; boundary="afzLEyAUjLRX66oIZWzn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1633439304;
 bh=syk4Jm0byqOYSREvKB2T7EBuo/qFAddGJFhLqKbkxbY=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=HT6IVQ6AES/SU5OOLdqxX00A+NIsKW2PJNE25eCVqjNwY2LfZk6NxUfQjNQBCuiZP/k
 D0SEdAC7RI1HFOxLAOs+FXpnVo/6inXfrAEqRZem3y8jVmQQDRwNyEFxF23eHni9eNK1E
 1mo/TSfxTE0PmD45lGeqUsitKYM+piuPopI=
Message-ID: <20211005130556.rqR2t1hmQ6JiXvWPBi3nltiidFoOGjPRbqf3CJY76JM@z>

--afzLEyAUjLRX66oIZWzn
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 05.10.21 08:47, Srinuvasan A wrote:
> From: Srinuvasan A <srinuvasan_a@mentor.com>
> 
> Update cip-kernels to latest one for 4.4 and 4.19 versions.
> 
> Signed-off-by: Srinuvasan A <srinuvasan_a@mentor.com>
> ---
>  ...19.195-cip52-rt20.bb => linux-cip-rt_4.19.206-cip57-rt22.bb} | 2 +-
>  ...4.4.262-cip55-rt34.bb => linux-cip-rt_4.4.277-cip60-rt35.bb} | 2 +-
>  ...{linux-cip_4.19.195-cip52.bb => linux-cip_4.19.206-cip57.bb} | 2 +-
>  .../{linux-cip_4.4.272-cip58.bb => linux-cip_4.4.283-cip62.bb}  | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
>  rename recipes-kernel/linux/{linux-cip-rt_4.19.195-cip52-rt20.bb => linux-cip-rt_4.19.206-cip57-rt22.bb} (68%)
>  rename recipes-kernel/linux/{linux-cip-rt_4.4.262-cip55-rt34.bb => linux-cip-rt_4.4.277-cip60-rt35.bb} (68%)
>  rename recipes-kernel/linux/{linux-cip_4.19.195-cip52.bb => linux-cip_4.19.206-cip57.bb} (68%)
>  rename recipes-kernel/linux/{linux-cip_4.4.272-cip58.bb => linux-cip_4.4.283-cip62.bb} (68%)
> 
> diff --git a/recipes-kernel/linux/linux-cip-rt_4.19.195-cip52-rt20.bb b/recipes-kernel/linux/linux-cip-rt_4.19.206-cip57-rt22.bb
> similarity index 68%
> rename from recipes-kernel/linux/linux-cip-rt_4.19.195-cip52-rt20.bb
> rename to recipes-kernel/linux/linux-cip-rt_4.19.206-cip57-rt22.bb
> index 4c9a735..e6af865 100644
> --- a/recipes-kernel/linux/linux-cip-rt_4.19.195-cip52-rt20.bb
> +++ b/recipes-kernel/linux/linux-cip-rt_4.19.206-cip57-rt22.bb
> @@ -11,4 +11,4 @@
>  
>  require linux-cip-rt-common.inc
>  
> -SRC_URI[sha256sum] = "fee95d77599f5a0321ae818f63bf595f5e3015e674f2f428503267b8471379fb"
> +SRC_URI[sha256sum] = "586ff1af1c0ee794794db4af40544391d8b2dde88417136e32e6105c6f9d77b3"
> diff --git a/recipes-kernel/linux/linux-cip-rt_4.4.262-cip55-rt34.bb b/recipes-kernel/linux/linux-cip-rt_4.4.277-cip60-rt35.bb
> similarity index 68%
> rename from recipes-kernel/linux/linux-cip-rt_4.4.262-cip55-rt34.bb
> rename to recipes-kernel/linux/linux-cip-rt_4.4.277-cip60-rt35.bb
> index 37f2018..0a2de66 100644
> --- a/recipes-kernel/linux/linux-cip-rt_4.4.262-cip55-rt34.bb
> +++ b/recipes-kernel/linux/linux-cip-rt_4.4.277-cip60-rt35.bb
> @@ -11,4 +11,4 @@
>  
>  require linux-cip-rt-common.inc
>  
> -SRC_URI[sha256sum] = "5f8c3fe1ec1cb82e12a6929945f29bfd7dd432a81ad9891cd7490e86d7d91d7a"
> +SRC_URI[sha256sum] = "ea4a5de21e6ad82001685bddcfaacd2eaaf524fea61dd774c2895c7adb3b934e"
> diff --git a/recipes-kernel/linux/linux-cip_4.19.195-cip52.bb b/recipes-kernel/linux/linux-cip_4.19.206-cip57.bb
> similarity index 68%
> rename from recipes-kernel/linux/linux-cip_4.19.195-cip52.bb
> rename to recipes-kernel/linux/linux-cip_4.19.206-cip57.bb
> index 05dc765..f23ab83 100644
> --- a/recipes-kernel/linux/linux-cip_4.19.195-cip52.bb
> +++ b/recipes-kernel/linux/linux-cip_4.19.206-cip57.bb
> @@ -11,4 +11,4 @@
>  
>  require linux-cip-common.inc
>  
> -SRC_URI[sha256sum] = "9eb4fb2a9b0065e3c8ac2a1045da7bc6377309dd7c01292985c3e978b8d61d8f"
> +SRC_URI[sha256sum] = "a88ab84c6cf072743890a11e2f782540ecf1081167f3a2f34311060f99eda44d"
> diff --git a/recipes-kernel/linux/linux-cip_4.4.272-cip58.bb b/recipes-kernel/linux/linux-cip_4.4.283-cip62.bb
> similarity index 68%
> rename from recipes-kernel/linux/linux-cip_4.4.272-cip58.bb
> rename to recipes-kernel/linux/linux-cip_4.4.283-cip62.bb
> index e883794..bcb754d 100644
> --- a/recipes-kernel/linux/linux-cip_4.4.272-cip58.bb
> +++ b/recipes-kernel/linux/linux-cip_4.4.283-cip62.bb
> @@ -11,4 +11,4 @@
>  
>  require linux-cip-common.inc
>  
> -SRC_URI[sha256sum] = "e8300f194bd99866d5d1b467475270f2739aaf1e87536097465f636d37437ff9"
> +SRC_URI[sha256sum] = "842c443e6adc43cebe73acb071a59a8c410cc6cd83488502f297ee1a995dbae6"
> 
> 

Thanks, applied.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

--afzLEyAUjLRX66oIZWzn
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6784): https://lists.cip-project.org/g/cip-dev/message/=
6784
Mute This Topic: https://lists.cip-project.org/mt/86087678/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--afzLEyAUjLRX66oIZWzn--

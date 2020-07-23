Return-Path: <SRS0=PESt=BC=lists.cip-project.org=bounce+64572+4985+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB38C433EA
	for <cip-dev@archiver.kernel.org>; Thu, 23 Jul 2020 10:40:05 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B183520B1F
	for <cip-dev@archiver.kernel.org>; Thu, 23 Jul 2020 10:40:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="I7QdRLzO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B183520B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4985+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id qT2aYY4521723xKrlOw8QdmC; Thu, 23 Jul 2020 03:40:04 -0700
X-Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web11.9462.1595500802941732551
 for <cip-dev@lists.cip-project.org>;
 Thu, 23 Jul 2020 03:40:03 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 06NAe0DE026162
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2020 12:40:00 +0200
X-Received: from [139.25.68.37] ([139.25.68.37])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 06NAe0UM014652;
	Thu, 23 Jul 2020 12:40:00 +0200
Subject: Re: [cip-dev] [PATCH 3/3] README: Add steps to build cip-security image
To: cip-dev@lists.cip-project.org,
        Venkata Pyla <venkata.pyla@toshiba-tsip.com>
References: <20200721081645.1789-1-venkata.pyla@toshiba-tsip.com>
 <20200721081645.1789-3-venkata.pyla@toshiba-tsip.com>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <544b0f34-c55b-2be1-d672-6a5eb796403e@siemens.com>
Date: Thu, 23 Jul 2020 12:40:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200721081645.1789-3-venkata.pyla@toshiba-tsip.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: cxq9Sb5LHBp28GfT88o2fgGHx4520388AA=
Content-Type: multipart/mixed; boundary="nF0oR1eGigklhmxQJaV8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595500804;
 bh=YVfQC1WC76azNuBUtHB+zUpcnuDttD2gEMOSpfQ16NE=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=I7QdRLzOlQPGP4NMIQBGJavBB9iN97un5k8XEn+kKgNbkvW3iXzisVo9gSVnefIYDhe
 CMeffJiNX/bk9oAgDeoFuhyEKSHkeeDHlguo+oZu07HHg46EfqfBcQnewuhOcaJIqrET6
 RSgMWmOeESPjIB3f+gQ1vv+QttwLHSwLMQ4=

--nF0oR1eGigklhmxQJaV8
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 21.07.20 10:16, Venkata Pyla wrote:
> From: venkata <venkata.pyla@toshiba-tsip.com>
> 
> Signed-off-by: venkata <venkata.pyla@toshiba-tsip.com>
> ---
>   README.md | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/README.md b/README.md
> index bbad1a0..b2c4166 100644
> --- a/README.md
> +++ b/README.md
> @@ -36,6 +36,16 @@ card, run
>       dd if=build/tmp/deploy/images/bbb/cip-core-image-cip-core-buster-bbb.wic.img \
>          of=/dev/<medium-device> bs=1M status=progress
>   
> +## Building Security target images
> +Building images for QEMU x86-64bit machine
> +
> +    ./kas-docker --isar build --target cip-core-image-security kas.yml:board-qemu-amd64.yml
> +
> +Run the generated securiy images on QEMU (x86-64bit)
> +
> +    TARGET_IMAGE=cip-core-image-security ./start-qemu.sh amd64
> +
> +
>   ## Community Resources
>   
>   TBD
> 

This patch is fine, but I'm missing 4/4: Add this image to CI (same 
comment as I had on the MR on gitlab).

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

--nF0oR1eGigklhmxQJaV8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4985): https://lists.cip-project.org/g/cip-dev/message=
/4985
Mute This Topic: https://lists.cip-project.org/mt/75699595/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--nF0oR1eGigklhmxQJaV8--

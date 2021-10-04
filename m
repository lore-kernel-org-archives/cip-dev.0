Return-Path: <SRS0=GGaT=OY=lists.cip-project.org=bounce+64572+6777+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A2EC433F5
	for <cip-dev@archiver.kernel.org>; Mon,  4 Oct 2021 13:44:41 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 656D760F59
	for <cip-dev@archiver.kernel.org>; Mon,  4 Oct 2021 13:44:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 656D760F59
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id XMVsYY4521723xopBNRWdt9k; Mon, 04 Oct 2021 06:44:41 -0700
X-Received: from lizzard.sbs.de (lizzard.sbs.de [194.138.37.39])
 by mx.groups.io with SMTP id smtpd.web12.9507.1633355079911581361
 for <cip-dev@lists.cip-project.org>;
 Mon, 04 Oct 2021 06:44:40 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 194DiaPa028909
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 Oct 2021 15:44:37 +0200
X-Received: from [167.87.3.213] ([167.87.3.213])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 194Diaco010822;
	Mon, 4 Oct 2021 15:44:36 +0200
Subject: Re: [cip-dev] [PATCH v2] kas/opt/swupdate: Change assignment of IMAGE_TYPE and WKS_FILE
To: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>,
        cip-dev@lists.cip-project.org, dinesh.kumar@toshiba-tsip.com
References: <be00776f-c1c5-9c84-c904-2d8e17cc298d@siemens.com>
 <20211004132713.1827767-1-Quirin.Gylstorff@siemens.com>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <dedb4f99-d18f-de18-53c9-170f2fea471e@siemens.com>
Date: Mon, 4 Oct 2021 15:44:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211004132713.1827767-1-Quirin.Gylstorff@siemens.com>
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 7qqYQXEdkyw53gpBKwh2E2VUx4520388AA=
Content-Type: multipart/mixed; boundary="Nv7plWKKLnBM7SM7jt68"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1633355081;
 bh=Ly9sJOqaw6Tnekr87ro7mZhHNpsRiGYX3cShQ7EGdlE=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=R8QCdtiJlt/38sEzSX2GILk6RosUgOc6O3vVwgsvYfjhlkeLSB9CvJqmAOFdro6aPKP
 YNyTueIJVX+8cr8GcSklppKnStS3XbDNO5TcbXxe53CcmESBVYw/H47kFm359qZoTukT6
 rYv3Iv7G0rK4XcrEeiXSkRHeKC9IEh1sYsM=
Message-ID: <20211004134436.9W7aRIeAHiag-GH0FRGX-N5k70bJRTuM4Mf8ns4oT74@z>

--Nv7plWKKLnBM7SM7jt68
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 04.10.21 15:27, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Replace the default assignment to ensure the generation of the
> swu file. As stated in [1]: If multiple `?=` assignments are used
> the first of those assignments ends up getting used.
> 
> This fixes [2].
> 
> [1]: https://docs.yoctoproject.org/bitbake/bitbake-user-manual/bitbake-user-manual-metadata.html#setting-a-default-value
> [2]: https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/14
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  kas/opt/swupdate.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kas/opt/swupdate.yml b/kas/opt/swupdate.yml
> index 7d86ad5..bd0f6e4 100644
> --- a/kas/opt/swupdate.yml
> +++ b/kas/opt/swupdate.yml
> @@ -19,5 +19,5 @@ local_conf_header:
>      IMAGE_INSTALL_append = " swupdate"
>  
>    wic-swu: |
> -    IMAGE_TYPE ?= "wic-swu-img"
> +    IMAGE_TYPE = "wic-swu-img"
>      WKS_FILE ?= "${MACHINE}-${SWUPDATE_BOOTLOADER}.wks"
> 

Thanks, replaced v1 with this in next.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

--Nv7plWKKLnBM7SM7jt68
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6777): https://lists.cip-project.org/g/cip-dev/message/=
6777
Mute This Topic: https://lists.cip-project.org/mt/86066250/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--Nv7plWKKLnBM7SM7jt68--

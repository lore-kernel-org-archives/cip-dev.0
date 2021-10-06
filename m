Return-Path: <SRS0=DAMO=O2=lists.cip-project.org=bounce+64572+6794+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3324C433FE
	for <cip-dev@archiver.kernel.org>; Wed,  6 Oct 2021 17:43:04 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 463E760FC3
	for <cip-dev@archiver.kernel.org>; Wed,  6 Oct 2021 17:43:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 463E760FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id YjMeYY4521723x0hFgqpyivY; Wed, 06 Oct 2021 10:43:03 -0700
X-Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web10.270.1633542182844230983
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Oct 2021 10:43:03 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 196HgvkC026733
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Wed, 6 Oct 2021 19:42:57 +0200
X-Received: from [167.87.72.94] ([167.87.72.94])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 196HguY4005133;
	Wed, 6 Oct 2021 19:42:56 +0200
Subject: Re: [cip-dev][isar-cip-core][PATCH] scripts/wic/efibootguard-boot: Add missing whitespace
To: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>,
        cip-dev@lists.cip-project.org
References: <20210927083803.15507-1-Quirin.Gylstorff@siemens.com>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <5414133c-9749-820a-876e-f0b3175f7e2e@siemens.com>
Date: Wed, 6 Oct 2021 19:42:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210927083803.15507-1-Quirin.Gylstorff@siemens.com>
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 2s6z6QLmw9t0zhxm8HkDBWWpx4520388AA=
Content-Type: multipart/mixed; boundary="99ZYnuFYS84rXkV65ZA2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1633542183;
 bh=LLhJ5W8z0sznla7HuLuRTqxp7ZSS2VtdcOMaSRVbPls=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=j5MXM2c/ZcbaS70FVX8uKmWJHP57iz2QByo8yl/+/lHUptpXlaUee5Tiqckf6wvpx+m
 PYRIepKYLBTnExCRwir45pIuM/4piok9MAhJN/+MIlV9LalgUCcbMpOZ+7SyavnbazdJr
 7moZY7CPsPNK0umi49NoOq5VblVs8aMHIQU=
Message-ID: <20211006174256.0cgy1ilnck-DmzgEPCw0D8DYoh5nTOfhJ-C3uR9un9s@z>

--99ZYnuFYS84rXkV65ZA2
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 27.09.21 10:38, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> The generated Kernel commandline was incorrect concatenated.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  scripts/lib/wic/plugins/source/efibootguard-boot.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/scripts/lib/wic/plugins/source/efibootguard-boot.py
> index b85cfca..882729a 100644
> --- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
> +++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
> @@ -99,7 +99,7 @@ class EfibootguardBootPlugin(SourcePlugin):
>                  exit(1)
>              root_dev = root_dev.replace(":", "=")
>  
> -            cmdline += " root=%s rw" % root_dev
> +            cmdline += " root=%s rw " % root_dev
>              boot_files.append(kernel_image)
>              boot_files.append(initrd_image)
>              cmdline += "initrd=%s" % initrd_image if initrd_image else ""
> 

Thanks, applied.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

--99ZYnuFYS84rXkV65ZA2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6794): https://lists.cip-project.org/g/cip-dev/message/=
6794
Mute This Topic: https://lists.cip-project.org/mt/85895818/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--99ZYnuFYS84rXkV65ZA2--

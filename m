Return-Path: <SRS0=6uCW=OY=lists.cip-project.org=bounce+64572+6771+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C22C433FE
	for <cip-dev@archiver.kernel.org>; Mon,  4 Oct 2021 09:28:10 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E292A6126A
	for <cip-dev@archiver.kernel.org>; Mon,  4 Oct 2021 09:28:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E292A6126A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id yF3KYY4521723xTFnkE1JAk5; Mon, 04 Oct 2021 02:28:09 -0700
X-Received: from thoth.sbs.de (thoth.sbs.de [192.35.17.2])
 by mx.groups.io with SMTP id smtpd.web11.7005.1633339688406911247
 for <cip-dev@lists.cip-project.org>;
 Mon, 04 Oct 2021 02:28:09 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id 1949S5SM001203
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 Oct 2021 11:28:05 +0200
X-Received: from [167.87.3.213] ([167.87.3.213])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 1949S44A001065;
	Mon, 4 Oct 2021 11:28:04 +0200
Subject: Re: [cip-dev][isar-cip-core][PATCH 1/2] kas/opt/swupdate: Change assignment of IMAGE_TYPE and WKS_FILE
To: cip-dev@lists.cip-project.org, dinesh.kumar@toshiba-tsip.com
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
References: <20210928184948.737071-1-Quirin.Gylstorff@siemens.com>
 <20210928184947.AYjduU9bTolWO5fGM5sHK1KwOFt_xWwyNQv5uQOgPvk@z>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <5da61997-9b25-d965-9d5b-0f148c8f4e5b@siemens.com>
Date: Mon, 4 Oct 2021 11:28:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210928184947.AYjduU9bTolWO5fGM5sHK1KwOFt_xWwyNQv5uQOgPvk@z>
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 781bnBwQvqvnxZi7ImXLitZZx4520388AA=
Content-Type: multipart/mixed; boundary="iQiURn8wW9SzCEVM4YNk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1633339689;
 bh=SJaVlkXaBdrZ9jwZUr5f4lCAzi5TdsAdwZ5+BXzbPrs=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=fOSIDSBjwGYvdCYVlb3Es918bbD8MS2yFY+DqHd7XXgJhb/BCIVV9dCxky3QoG5ywSn
 aZCKzuwc6iCApd5zJaXk0i29tpfjLnXT4CErXm/qmWvIWnJTCC7RydKmlIRsEUWuRWnQE
 c2fl4HBinTCO4v/zIhR9ZqF7fuDlcnVMiX0=
Message-ID: <20211004092804._0z3dbqy0EKYq9lQvIRaef5HZZDgemDmCwTRkmXVbMs@z>

--iQiURn8wW9SzCEVM4YNk
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 28.09.21 20:49, Quirin Gylstorff wrote:
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
>  kas/opt/swupdate.yml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kas/opt/swupdate.yml b/kas/opt/swupdate.yml
> index 7d86ad5..3cc02a3 100644
> --- a/kas/opt/swupdate.yml
> +++ b/kas/opt/swupdate.yml
> @@ -19,5 +19,5 @@ local_conf_header:
>      IMAGE_INSTALL_append = " swupdate"
>  
>    wic-swu: |
> -    IMAGE_TYPE ?= "wic-swu-img"
> -    WKS_FILE ?= "${MACHINE}-${SWUPDATE_BOOTLOADER}.wks"
> +    IMAGE_TYPE = "wic-swu-img"
> +    WKS_FILE = "${MACHINE}-${SWUPDATE_BOOTLOADER}.wks"
> 
> 

Thanks, applied.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

--iQiURn8wW9SzCEVM4YNk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6771): https://lists.cip-project.org/g/cip-dev/message/=
6771
Mute This Topic: https://lists.cip-project.org/mt/86062392/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--iQiURn8wW9SzCEVM4YNk--

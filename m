Return-Path: <SRS0=WK47=OS=lists.cip-project.org=bounce+64572+6759+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFDE2C433F5
	for <cip-dev@archiver.kernel.org>; Tue, 28 Sep 2021 22:55:15 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53DF36138F
	for <cip-dev@archiver.kernel.org>; Tue, 28 Sep 2021 22:55:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 53DF36138F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id GmGTYY4521723xVl0iqwBfiS; Tue, 28 Sep 2021 15:55:14 -0700
X-Received: from mout.web.de (mout.web.de [212.227.15.3])
 by mx.groups.io with SMTP id smtpd.web12.1136.1632866994338286414
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 Sep 2021 15:09:55 -0700
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
X-Received: from [192.168.178.20] ([94.217.148.121]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MXYTG-1mImW902xa-00WZnM; Wed, 29
 Sep 2021 00:09:51 +0200
Subject: Re: [cip-dev][isar-cip-core][PATCH 2/2] kas/opt/efibootguard: Move setting of IMAGE_TYPE
To: cip-dev@lists.cip-project.org, dinesh.kumar@toshiba-tsip.com
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
References: <20210928184948.737071-1-Quirin.Gylstorff@siemens.com>
 <20210928184948.CyweMK8GgelNPuFVMaTF1OrJUCtJ1G-3X9DeSeSKkUE@z>
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <15ad275a-a9f4-9e8e-149d-e09c17a196c4@web.de>
Date: Wed, 29 Sep 2021 00:09:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210928184948.CyweMK8GgelNPuFVMaTF1OrJUCtJ1G-3X9DeSeSKkUE@z>
X-Provags-ID: V03:K1:J2TXk7PDQnSzCBr7DA8wa6PqizHgR019QeyaKwzpcJmCQKTMsoP
 70ryTxjaSUc+s0gvPjmSropZ3KWGoMUk1NP5YcR5hSKJ3GNBvofjr//Y64ffnCw+77mrYDE
 /NdoHmoH9kTTf6gZ9KVqRiQPO2npKIsJa92D3B8jpZPlQhYmLGd3yfZ7XiMdx5bH4Gn18V3
 io0RsKKmh17KeFd+ZxeKg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:p8FrVFdqe3U=:6SHefsqoNcsdnhRqBkHc28
 MlPaVJTlEXLCWclmEbVATzyZZhPhd+refXelDuQNJsLgW8oFkKDP/hkj8xM6jmxzNewV4/X5R
 LGxcHzThuI6lAfSTRf4O90w0PoJvI3lCyI+d5OXyEmPB37XldPSFvaSzlHrSa+cEGmwRhMNUt
 XVMBuvj0aQ0qP7wbP9MYuqLPaaQ5Burhb91BOHjoJFnmjM+taO6QErilRR+MU9JmpKPQpq6Ms
 4kwffCjHHLu6F/YY0sYETcn4DypYZXOrZ0p4qNbJaNooxxs1UAos9c7NqYL8fY76YXJQNydEG
 iW1Wup+gcbj625/jztK1GP8Vbrc+780aeLNy8p6X+hRex4pz+faZZXm/H0r5IECh74O7wvH/d
 fp5Wqm6EmeTu1qAimGPdy0R+/V6+Aj5qO0LWuNm1rDOVZBX8PyM35Mmkh4niZ8orzp8CHch/E
 2UUkcxvvfkEwow5lcTd8C4nlcDjBPPIwp1IaKiGp7OGAboSaFgFXRRhxXUE4l+loER13mkFqa
 6cST+hSlM55vLhoGgFAD4oavkL9l8nZFLFN5fVrSb7izKHpIJdotfGQE2xAaDC0TBTMvD/72D
 ZPcgdZFw+7CqOG2EL5A19SrKco2iU7+v690hJuorPrry4RlAxAoVM4twQNXamIa4dYSiKZjft
 cAgOd6xXar9nYqxL2pS8hVANgpUnjf+UxoTDi/QMxIjxI5pPYtACURV1k6iBwTCQ7pUF/31vv
 XD5y0438ME8Ch02bbPG0FpZPRPcpDj2uR0forCCJpAbEc8g1/vZIXWIQxwoFkcbBFnsirWi0Q
 Y8D8CSyfVMp11xnLspeHLSJ08TTeHHKTITpvULy1yiBt3m+Cw5Wuu2fjyI2rhxpWgs048wt3H
 Q4cskTmB0ZiWCLWLGjZWbsOWsS6Hyv3kJV0BdEJrnglgqOski0rNwyYUkjGwHPWr4GrKKRkHz
 kQPmyXHXFSe2bjLBTFqyl4nlVhvJI5pCTo7Q62Pjej5GUcfGPsrF7Tq7xQFISJu52wXP9uPI7
 ad1515hl7uNs9zFqerbI4whvrMd9WG95owtzdkBZJ1mgdcjnLOz+6iNHXI4+16WffiSzB0SjO
 vXzFTPmlm5kTYA=
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: AtpgqBbnrDXlvKGJj8co8JhWx4520388AA=
Content-Type: multipart/mixed; boundary="fFzpR75FtIiZjPZmBQmp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1632869714;
 bh=EvNeZ5BPgsQoVxcSRF+JCp3r34xvh4UFIhwJExrltMw=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=FzVnaQLl98c+sns197CMYTz7BW1tTl6tIoGwszxaUf/Sl2rpqETLLLBPRu+unR7xvVb
 6CIBkYQG6ykPmSNvfLxhTT4MjWvBTfMHk2A/FOlT5p4Zk5s320tZt7FclWcKH9M42p3Q0
 7/EGPSeWYy0et2X8le9/DqbKearPZl47OFw=

--fFzpR75FtIiZjPZmBQmp
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 28.09.21 20:49, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>
> This seperates the image type from the boot loader.
>
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  kas/opt/efibootguard.yml |  1 -
>  kas/opt/wic-img.yml      | 19 +++++++++++++++++++
>  2 files changed, 19 insertions(+), 1 deletion(-)
>  create mode 100644 kas/opt/wic-img.yml
>
> diff --git a/kas/opt/efibootguard.yml b/kas/opt/efibootguard.yml
> index 705a76d..4e8be69 100644
> --- a/kas/opt/efibootguard.yml
> +++ b/kas/opt/efibootguard.yml
> @@ -23,6 +23,5 @@ local_conf_header:
>    efibootguard-wic: |
>      WDOG_TIMEOUT ?=3D "60"
>      WICVARS +=3D "WDOG_TIMEOUT"
> -    IMAGE_TYPE ?=3D "wic-img"
>      WKS_FILE ?=3D "${MACHINE}-${SWUPDATE_BOOTLOADER}.wks"
>
> diff --git a/kas/opt/wic-img.yml b/kas/opt/wic-img.yml
> new file mode 100644
> index 0000000..2b02b42
> --- /dev/null
> +++ b/kas/opt/wic-img.yml
> @@ -0,0 +1,19 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2021
> +#
> +# Authors:
> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +# This kas file set the IMAGE_TYPE to wic-img
> +# The device specific WKS_FILE needs to be set seperately.
> +
> +header:
> +  version: 10
> +
> +local_conf_header:
> +  image-type: |
> +    IMAGE_TYPE =3D "wic-img"
>

What's the purpose of this file? When should a user specify this option?
I think we already have too many option files and rather need to reduce
them than adding more.

Jan

PS: Something is currently off with archiving on lore.kernel.org.
Messages from this thread but also others appear twice there:
https://lore.kernel.org/cip-dev/20210928184946.GHmZQFBkA_wEzR1iQiB_04frBV5=
2DnaYGHOSYtAdjok@z/T/#t

--fFzpR75FtIiZjPZmBQmp
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6759): https://lists.cip-project.org/g/cip-dev/message/=
6759
Mute This Topic: https://lists.cip-project.org/mt/85936916/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--fFzpR75FtIiZjPZmBQmp--

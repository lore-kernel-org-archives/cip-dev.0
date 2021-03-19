Return-Path: <SRS0=3/1j=IR=lists.cip-project.org=bounce+64572+6302+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D5FFC433DB
	for <cip-dev@archiver.kernel.org>; Fri, 19 Mar 2021 09:07:33 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2C3264F42
	for <cip-dev@archiver.kernel.org>; Fri, 19 Mar 2021 09:07:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2C3264F42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6302+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id P5jTYY4521723xWveLcXCwxj; Fri, 19 Mar 2021 02:07:32 -0700
X-Received: from lizzard.sbs.de (lizzard.sbs.de [194.138.37.39])
 by mx.groups.io with SMTP id smtpd.web12.3721.1616144851040983053
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Mar 2021 02:07:31 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 12J97T6g005345
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Fri, 19 Mar 2021 10:07:29 +0100
X-Received: from [167.87.41.130] ([167.87.41.130])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 12J8vS6B013629;
	Fri, 19 Mar 2021 09:57:28 +0100
Subject: Re: [cip-dev] [PATCH 1/1] Secureboot: Disable initramfs debug shell
To: cip-dev@lists.cip-project.org, Michael Adler <michael.adler@siemens.com>
References: <20210319072036.16091-1-michael.adler@siemens.com>
 <20210319072036.16091-2-michael.adler@siemens.com>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <9cb77dff-97da-0ada-37c0-5f10fd703425@siemens.com>
Date: Fri, 19 Mar 2021 09:57:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210319072036.16091-2-michael.adler@siemens.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: BTseC9vCkbmrmIfEorz7wlkcx4520388AA=
Content-Type: multipart/mixed; boundary="uHcQF93qPgPCQxs8LlgL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1616144852;
 bh=w/Mgw6p1cICmPwAXVy/m7Dcq02vMANgs9GGhRKds134=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=W8IlANB0occTCMPC3yJnqKuSnBXjyMmdL6pvWYYgOar5yJIiNpVnQcD5fAxx/PD1igr
 mJKctNqQRqkk29B8gGPx2rYRMKwoXWOHk05OtfDA1Xzg3AD/MYMh5KxpjNohebUQeVHI9
 xbGPEZOiW9Rm6eepWV0pFB2GwN0KRBSJbXM=

--uHcQF93qPgPCQxs8LlgL
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 19.03.21 08:20, Michael Adler wrote:
> This closes a loophole introduced by the initramfs debug shell which is
> enabled by default:
> 
> "The initramfs-tools package includes a debug shell in the initrds it
> generates. If for example the initrd is unable to mount your root file
> system, you will be dropped into this debug shell which has basic
> commands available to help trace the problem and possibly fix it." [1]
> 
> [1] https://www.debian.org/releases/buster/amd64/release-notes/ch-upgrading.en.html#recovery-initrd
> 
> Signed-off-by: Michael Adler <michael.adler@siemens.com>
> ---
>  wic/qemu-amd64-efibootguard-secureboot.wks | 2 ++
>  wic/qemu-amd64-efibootguard.wks            | 2 ++
>  wic/simatic-ipc227e-efibootguard.wks       | 2 ++
>  wic/swupdate-partition.inc                 | 2 --
>  4 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/wic/qemu-amd64-efibootguard-secureboot.wks b/wic/qemu-amd64-efibootguard-secureboot.wks
> index 9ccf501..ff351db 100644
> --- a/wic/qemu-amd64-efibootguard-secureboot.wks
> +++ b/wic/qemu-amd64-efibootguard-secureboot.wks
> @@ -7,3 +7,5 @@ part --source efibootguard-boot --ondisk sda --size 32M --extra-space 0 --overhe
>  part --source efibootguard-boot --ondisk sda --size 32M --extra-space 0 --overhead-factor 1 --label BOOT1 --align 1024 --part-type=0700 --sourceparams "revision=1,unified-kernel=y,signwith=/usr/bin/sign_secure_image.sh"
>  
>  include swupdate-partition.inc
> +
> +bootloader --ptable gpt --append="console=tty0 console=ttyS0,115200 rootwait earlyprintk panic=0"
> diff --git a/wic/qemu-amd64-efibootguard.wks b/wic/qemu-amd64-efibootguard.wks
> index a9a8446..6653068 100644
> --- a/wic/qemu-amd64-efibootguard.wks
> +++ b/wic/qemu-amd64-efibootguard.wks
> @@ -2,3 +2,5 @@
>  # long-description: Disk image for qemu-amd64 with EFI Boot Guard and SWUpdate
>  include ebg-sysparts.inc
>  include swupdate-partition.inc
> +
> +bootloader --ptable gpt --append="console=tty0 console=ttyS0,115200 rootwait earlyprintk"
> diff --git a/wic/simatic-ipc227e-efibootguard.wks b/wic/simatic-ipc227e-efibootguard.wks
> index 74446d3..f6191bc 100644
> --- a/wic/simatic-ipc227e-efibootguard.wks
> +++ b/wic/simatic-ipc227e-efibootguard.wks
> @@ -3,3 +3,5 @@
>  
>  include ebg-sysparts.inc
>  include swupdate-partition.inc
> +
> +bootloader --ptable gpt --append="console=tty0 console=ttyS0,115200 rootwait earlyprintk"
> diff --git a/wic/swupdate-partition.inc b/wic/swupdate-partition.inc
> index 15fbe80..7bec9d7 100644
> --- a/wic/swupdate-partition.inc
> +++ b/wic/swupdate-partition.inc
> @@ -1,4 +1,2 @@
>  part --source rootfs --uuid "fedcba98-7654-3210-cafe-5e0710000001" --size 1000M   --extra-space 128M --overhead-factor 1 --label systema --align 1024 --fstype=ext4
>  part  --source rootfs --uuid "fedcba98-7654-3210-cafe-5e0710000002" --size 1000M   --extra-space 128M --overhead-factor 1 --label systemb --align 1024 --fstype=ext4
> -
> -bootloader --ptable gpt --append="console=tty0 console=ttyS0,115200 rootwait earlyprintk"
> 

Thanks, applied.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

--uHcQF93qPgPCQxs8LlgL
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6302): https://lists.cip-project.org/g/cip-dev/message=
/6302
Mute This Topic: https://lists.cip-project.org/mt/81450090/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--uHcQF93qPgPCQxs8LlgL--

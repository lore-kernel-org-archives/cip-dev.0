Return-Path: <SRS0=jJOB=NI=lists.cip-project.org=bounce+64572+6683+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38FADC4338F
	for <cip-dev@archiver.kernel.org>; Tue, 17 Aug 2021 12:16:37 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE4A86023F
	for <cip-dev@archiver.kernel.org>; Tue, 17 Aug 2021 12:16:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AE4A86023F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 4ksqYY4521723xfZt8U0dTRU; Tue, 17 Aug 2021 05:16:36 -0700
X-Received: from david.siemens.de (david.siemens.de [192.35.17.14])
 by mx.groups.io with SMTP id smtpd.web08.38240.1629202594893216021
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Aug 2021 05:16:35 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 17HCGV5E015678
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Aug 2021 14:16:31 +0200
X-Received: from [167.87.37.135] ([167.87.37.135])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 17HCGTOM018557;
	Tue, 17 Aug 2021 14:16:29 +0200
Subject: Re: [cip-dev] [isar-cip-core][WIP][PATCH] Add kconfig menu
From: "Jan Kiszka" <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>,
        isar-users <isar-users@googlegroups.com>
Cc: kas-devel <kas-devel@googlegroups.com>
References: <43993e08-b055-d2f5-012e-8ededd8485e6@siemens.com>
Message-ID: <b6eecc00-d4bc-45ff-9418-d0f4e1e6d7d7@siemens.com>
Date: Tue, 17 Aug 2021 14:16:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <43993e08-b055-d2f5-012e-8ededd8485e6@siemens.com>
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: dsDQNs2LTdLKdkGgm1DsxMb1x4520388AA=
Content-Type: multipart/mixed; boundary="xEBhymbupRsoeccjyhoH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1629202596;
 bh=uREKcVhiZEQFXJM6nc0mtsS+G3R5fAzrNKyBu0/NGKU=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=QPSPmuBMl0X8xRXZO2nu0j4W1sN8skkxkpIELx+TjrKn3ou/2pGMY4uROwUKStruCnj
 cvzl6IYeRSu3XeD94XYakDFvAzPz4Q4PxVSXzXghL7U8lSaNlOY6oDoTSr6C7t6jyUkdO
 LqX6dz7Gsv+yrgNaW+6WWk+dyYiksd4tnpM=

--xEBhymbupRsoeccjyhoH
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 17.08.21 10:12, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Use the new kas menu plugin to present available image options to the
> user. This also allows to model their dependencies, specifically as not
> all options are supported on all boards.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
> 
> Only for preview as the underlying kas feature is not yet merged. Try it 
> out by fetching kas-container from the kas next branch and then run
> 
> KAS_IMAGE_VERSION=next kas-container menu
> 
> This is the first more complex layer modeled via kconfig/kas-menu. I 
> think it nicely demonstrates the potential of this approach.
> 
>  Kconfig | 146 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 146 insertions(+)
>  create mode 100644 Kconfig
> 
> diff --git a/Kconfig b/Kconfig
> new file mode 100644
> index 0000000..72c75bf
> --- /dev/null
> +++ b/Kconfig
> @@ -0,0 +1,146 @@
> +mainmenu "Isar core layer of the Civil Infrastructure Platform project"
> +
> +config KAS_INCLUDE_MAIN
> +	string
> +	default "kas-cip.yml"
> +
> +config KAS_BUILD_SYSTEM
> +	string
> +	default "isar"
> +
> +choice
> +	prompt "Target board"
> +	default TARGET_QEMU_AMD64
> +
> +config TARGET_QEMU_AMD64
> +	bool "QEMU AMD64 (x86-64)"
> +
> +config TARGET_SIMATIC_IPC227E
> +	bool "Siemens SIMATIC IPC227E"
> +
> +config TARGET_QEMU_ARM64
> +	bool "QEMU ARM64 (aarch64)"
> +
> +config TARGET_HIHOPE_RZG2M
> +	bool "HopeRun HiHope-RZ/G2M"
> +
> +config TARGET_QEMU_ARM
> +	bool "QEMU ARM (armhf)"
> +
> +config TARGET_BBB
> +	bool "BeagleBone Black"
> +
> +config TARGET_IWG20D
> +	bool "iWave Systems RainboW-G20D-Qseven"
> +
> +endchoice
> +
> +config KAS_INCLUDE_BOARD
> +	string
> +	default "kas/board/qemu-amd64.yml" if TARGET_QEMU_AMD64
> +	default "kas/board/simatic-ipc227e.yml" if TARGET_SIMATIC_IPC227E
> +	default "kas/board/qemu-arm64.yml" if TARGET_QEMU_ARM64
> +	default "kas/board/hihope-rzg2m.yml" if TARGET_HIHOPE_RZG2M
> +	default "kas/board/qemu-arm.yml" if TARGET_QEMU_ARM
> +	default "kas/board/bbb.yml" if TARGET_BBB
> +	default "kas/board/iwg20m.yml" if TARGET_IWG20D
> +
> +comment "Kernel options"
> +
> +choice
> +	prompt "CIP kernel version"
> +	default KERNEL_4_19
> +
> +config KERNEL_4_4
> +	bool "Kernel 4.4.x-cip"
> +
> +config KERNEL_4_19
> +	bool "Kernel 4.19.x-cip"
> +
> +endchoice
> +
> +config KAS_INCLUDE_KERNEL
> +	string
> +	default "kas/opt/4.4.yml"
> +	depends on KERNEL_4_4
> +
> +config KERNEL_RT
> +	bool "Real-time CIP kernel"
> +
> +config KAS_INCLUDE_KERNEL_RT
> +	string
> +	default "kas/opt/rt.yml"
> +	depends on KERNEL_RT
> +
> +comment "Debian distribution options"
> +
> +choice
> +	prompt "Debian Release"
> +	default DEBIAN_BUSTER
> +
> +config DEBIAN_STRETCH
> +	bool "stretch (9)"
> +
> +config DEBIAN_BUSTER
> +	bool "buster (10)"
> +
> +config DEBIAN_BULLSEYE
> +	bool "bullseye (11)"
> +
> +endchoice
> +
> +config KAS_INCLUDE_DEBIAN
> +	string
> +	default "kas/opt/stretch.yml" if DEBIAN_STRETCH
> +	default "kas/opt/bullseye.yml" if DEBIAN_BULLSEYE
> +
> +comment "Image features"
> +
> +choice
> +	prompt "Image formats"
> +	default IMAGE_FLASH
> +
> +config IMAGE_FLASH
> +	bool "Flashable image"
> +
> +config IMAGE_ARTIFACTS
> +	bool "Separate artifacts for NFS boot"
> +
> +endchoice
> +
> +config KAS_INCLUDE_IMAGE_FORMAT
> +	string
> +	default "kas/opt/targz.yml" if IMAGE_ARTIFACTS && (TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM)
> +	default "kas/opt/wic-targz.yml" if IMAGE_ARTIFACTS && !(TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM)
> +
> +config IMAGE_SECURITY
> +	bool "Security extensions"
> +
> +config KAS_INCLUDE_SECURITY
> +	string
> +	default "kas/opt/security.yml" if IMAGE_SECURITY
> +
> +config IMAGE_TESTING
> +	bool "Test extensions"
> +
> +config KAS_INCLUDE_TESTING
> +	string
> +	default "kas/opt/test.yml" if IMAGE_TESTING
> +
> +if IMAGE_FLASH
> +
> +config IMAGE_SWUPDATE
> +	bool "SWUpdate support for root partition"
> +	depends on TARGET_QEMU_AMD64 || TARGET_SIMATIC_IPC227E
> +
> +config IMAGE_SECURE_BOOT
> +	bool "Secure boot support"
> +	depends on TARGET_QEMU_AMD64
> +
> +config KAS_INCLUDE_SWUPDATE_SECBOOT
> +	string
> +	default "kas/opt/ebg-swu.yml" if IMAGE_SWUPDATE && !IMAGE_SECURE_BOOT
> +	default "kas/opt/ebg-secure-boot-snakeoil.yml" if !IMAGE_SWUPDATE && IMAGE_SECURE_BOOT
> +	default "kas/opt/ebg-snakeoil-swu.yml" if IMAGE_SWUPDATE && IMAGE_SECURE_BOOT
> +
> +endif
> 

Oh, wrong primary list. Was supposed to go to cip-dev, but possibly not
uninteresting for Isar as well.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

--xEBhymbupRsoeccjyhoH
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6683): https://lists.cip-project.org/g/cip-dev/message/=
6683
Mute This Topic: https://lists.cip-project.org/mt/84946102/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--xEBhymbupRsoeccjyhoH--

Return-Path: <SRS0=BSbD=BI=lists.cip-project.org=bounce+64572+5050+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B8CC433E1
	for <cip-dev@archiver.kernel.org>; Wed, 29 Jul 2020 17:05:22 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E34920809
	for <cip-dev@archiver.kernel.org>; Wed, 29 Jul 2020 17:05:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="S4iAGPA9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E34920809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5050+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id rEvrYY4521723xe6VvhP2Tf3; Wed, 29 Jul 2020 10:05:21 -0700
X-Received: from thoth.sbs.de (thoth.sbs.de [192.35.17.2])
 by mx.groups.io with SMTP id smtpd.web11.800.1596042320155952211
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 Jul 2020 10:05:21 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id 06TH5Its017452
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Wed, 29 Jul 2020 19:05:18 +0200
X-Received: from [167.87.13.2] ([167.87.13.2])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 06TH5HOJ000508;
	Wed, 29 Jul 2020 19:05:17 +0200
Subject: Re: [cip-dev] [isar-cip-core PATCH v3 4/6] secure-boot: Add secure boot with unified kernel image
To: cip-dev@lists.cip-project.org,
        Quirin Gylstorff <quirin.gylstorff@siemens.com>
References: <20200629125400.13968-1-Quirin.Gylstorff@siemens.com>
 <20200724150147.8253-1-Quirin.Gylstorff@siemens.com>
 <20200724150147.8253-5-Quirin.Gylstorff@siemens.com>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <c6536207-e421-b489-079b-1a9c4823fb43@siemens.com>
Date: Wed, 29 Jul 2020 19:05:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200724150147.8253-5-Quirin.Gylstorff@siemens.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: swoW5CJFufjln1mP19HhD2SJx4520388AA=
Content-Type: multipart/mixed; boundary="gGRyioqrwytoC5Dh3vtn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1596042321;
 bh=eyy5GbfTiUNvQSxygdhiPYAq6ZRgINjZgHPbJfzwu1E=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=S4iAGPA9Jq0tFVB8eTpeqdEFqGaOzvkzjC5Wrs2lwp4lnNjCQTTeeaDE1Pfra24CTiP
 qk+OywUrgMsGR3vluyBhOUo3RixStdw5sjGnzrD62mLWbAjKkq+ACArY5xfx+C4DbXnny
 8CQGyrM0Udnpe4yfpYbtQwfQumsAaOo+FQM=

--gGRyioqrwytoC5Dh3vtn
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 24.07.20 17:01, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> A unified kernel image contains the os-release, kernel,
> kernel commandline, initramfs and efi-stub in one binary.
> This binary can be boot by systemd-boot and efibootguard.
> It also allows to sign kernel and initramfs as one packages.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>

...

> diff --git a/start-qemu.sh b/start-qemu.sh
> index 49f0266..74d1b54 100755
> --- a/start-qemu.sh
> +++ b/start-qemu.sh
> @@ -15,6 +15,8 @@ usage()
>   	echo "Usage: $0 ARCHITECTURE [QEMU_OPTIONS]"
>   	echo -e "\nSet QEMU_PATH environment variable to use a locally " \
>   		"built QEMU version"
> +	echo -e "\nSet SECURE_BOOT environment variable to boot a secure boot environment " \
> +		"This environment also needs the variables OVMF_VARS and OVMF_CODE set"
>   	exit 1
>   }
>   
> @@ -22,17 +24,25 @@ if [ -n "${QEMU_PATH}" ]; then
>   	QEMU_PATH="${QEMU_PATH}/"
>   fi
>   
> +if [ -z "${DISTRO_RELEASE}" ]; then
> +  DISTRO_RELEASE="buster"
> +fi
> +if [ -z "${TARGET_IMAGE}" ];then
> +	TARGET_IMAGE="cip-core-image"
> +fi
> +
>   case "$1" in
>   	x86|x86_64|amd64)
>   		DISTRO_ARCH=amd64
>   		QEMU=qemu-system-x86_64
>   		QEMU_EXTRA_ARGS=" \
> -			-cpu host -smp 4 \
> -			-enable-kvm -machine q35 \
> +			-cpu qemu64 \
> +			-smp 4 \
> +			-machine q35,accel=kvm:tcg \
>   			-device ide-hd,drive=disk \
>   			-device virtio-net-pci,netdev=net"
>   		KERNEL_CMDLINE=" \
> -			root=/dev/sda vga=0x305 console=ttyS0"
> +			root=/dev/sda vga=0x305"
>   		;;
>   	arm64|aarch64)
>   		DISTRO_ARCH=arm64
> @@ -71,21 +81,41 @@ case "$1" in
>   		;;
>   esac
>   
> -if [ -z "${DISTRO_RELEASE}" ]; then
> -	DISTRO_RELEASE="buster"
> -fi
> -
> -IMAGE_PREFIX="$(dirname $0)/build/tmp/deploy/images/qemu-${DISTRO_ARCH}/cip-core-image-cip-core-${DISTRO_RELEASE}-qemu-${DISTRO_ARCH}"
> -IMAGE_FILE=$(ls ${IMAGE_PREFIX}.ext4.img)
> +IMAGE_PREFIX="$(dirname $0)/build/tmp/deploy/images/qemu-${DISTRO_ARCH}/${TARGET_IMAGE}-cip-core-${DISTRO_RELEASE}-qemu-${DISTRO_ARCH}"
>   
>   if [ -z "${DISPLAY}" ]; then
>   	QEMU_EXTRA_ARGS="${QEMU_EXTRA_ARGS} -nographic"
> +	case "$1" in
> +		x86|x86_64|amd64)
> +			KERNEL_CMDLINE="${KERNEL_CMDLINE} console=ttyS0"
> +	esac
> +fi
> +
> +
> +
> +if [ -n "SECURE_BOOT" ]; then
> +		ovmf_code=${OVMF_CODE:-/usr/share/OVMF/OVMF_CODE.secboot.fd}
> +		ovmf_vars=${OVMF_VARS:-./OVMF_VARS.fd}
> +		QEMU_EXTRA_ARGS=" \
> +										${QEMU_EXTRA_ARGS} \
> +										-global ICH9-LPC.disable_s3=1 \
> +											-global isa-fdc.driveA= \
> +										"

Looks like someone fell asleep on the tab key - please indent more 
reasonably.

> +		BOOT_FILES="-drive if=pflash,format=raw,unit=0,readonly=on,file=${ovmf_code} \
> +									-drive if=pflash,format=raw,file=${ovmf_vars} \
> +								-drive file=${IMAGE_PREFIX}.wic.img,discard=unmap,if=none,id=disk,format=raw"
> +else
> +		IMAGE_FILE=$(ls ${IMAGE_PREFIX}.ext4.img)
> +
> +		KERNEL_FILE=$(ls ${IMAGE_PREFIX}-vmlinuz* | tail -1)
> +		INITRD_FILE=$(ls ${IMAGE_PREFIX}-initrd.img* | tail -1)
> +
> +		BOOT_FILES=-kernel ${KERNEL_FILE} -append "${KERNEL_CMDLINE}" \
> +						-initrd ${INITRD_FILE}
>   fi
>   
>   shift 1
>   
>   ${QEMU_PATH}${QEMU} \
> -	-drive file=${IMAGE_FILE},discard=unmap,if=none,id=disk,format=raw \
>   	-m 1G -serial mon:stdio -netdev user,id=net \
> -	-kernel ${IMAGE_PREFIX}-vmlinuz -append "${KERNEL_CMDLINE}" \
> -	-initrd ${IMAGE_PREFIX}-initrd.img ${QEMU_EXTRA_ARGS} "$@"
> +	${BOOT_FILES} ${QEMU_EXTRA_ARGS} "$@"

This file is in conflict with changes in next. Please rebase.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

--gGRyioqrwytoC5Dh3vtn
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5050): https://lists.cip-project.org/g/cip-dev/message=
/5050
Mute This Topic: https://lists.cip-project.org/mt/75767905/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--gGRyioqrwytoC5Dh3vtn--

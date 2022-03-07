Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A3E5C433F5
	for <webhook@archiver.kernel.org>; Mon,  7 Mar 2022 06:48:03 +0000 (UTC)
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (EUR03-AM5-obe.outbound.protection.outlook.com [40.107.3.60])
 by mx.groups.io with SMTP id smtpd.web10.23679.1646635681752452298
 for <cip-dev@lists.cip-project.org>;
 Sun, 06 Mar 2022 22:48:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=sZtVwxzv;
 spf=pass (domain: siemens.com, ip: 40.107.3.60,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NkFvD7IykqEQ/J27DiFdbI7X/hlqTBwBcwtoEUuXOTsybGWY73S4JwKdpDIj0TL1r9euxoQvV+00tILacMunMgGAS6GeAutUsQ8DC4vyj6L5S9PArfzGE92/7ISxb/So7sW6GAiD5KnkkY+v2NzIPPCwu9/mRlPiKcDQYpKO6vx9GJIrx0caTtWK7r4Y5NvBk46X6akHxyovHQEEQbr8BAIgt/tSUfb7+E5K9gdkUsBoI7Ffm5gov/o+40rXnJv6mTVXU6ONDBtMdbiWsKTf3NdJZCQqf/vY9Fha4SW21GYnFsPZ6duRJvPh1WGu1EwiD6zw8FS8wa/YaG6J1CNDKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=arM3pIgnH7mzAiqZQe2z7pLHeyKpzCpy9xZ+P/XNY8k=;
 b=IZ7zTM4ethpOjshwDJQlmXEvbEAvWbrPlYic6BoWa/Hx+WMa4lJ2CgdTqNzpCumpspsytm0LsE953ZGD6e0keoZpFLJ0hUY84cF+/tm+PnpMK0ibvANn9ytA3e3F6VvjXjPvjSYe9JKZSb+gJM2D9c/RwI6aVij/GuD7EILBE1z2Iv5CQ6v1ZXsUr5545knJ59kmizQBRdQkQyV1pAqI0ahUjj11EREc9BoqHDI8bNIwEdghQHYMQcr/OJIdm06wyUpkhJyUuEGXZ1UnzpMzzp2sGOjiCHGwAXpDQsRLzGwxV1rBpUBrxH/Ygmf8Nx1usS8IRiBbFpgiphLGMvxttw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.73) smtp.rcpttodomain=mentor.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=arM3pIgnH7mzAiqZQe2z7pLHeyKpzCpy9xZ+P/XNY8k=;
 b=sZtVwxzv9rY1vUK/YBcT6de8PpL+1ymPjXyjsUd8+rWZ98mYbem6yXP/JHPc6M6Hht5Y5lRqrxv6Mve6ApXsheMu5PRxy/TJ6TRnuxXPhcUFdxhPs+DRBnXq5SEv9SqpmP0hX4KGevyWAlHkHHGjo+vamvKERdntiq58WXMfC+dSr+GL7KY4triYppe04xw5AaPRld/NVK1ePlURLotHjVgNHOztUg9LWa+Jo9DN7p9tZiweUWVx+RuNqFh0ueJnZ0f3k8Xp02Aa/EVsWY0j4h/tLBPmn3GuFM57BsVIQxH2F9BC+vDDWfgGXlWqNvleX9JwezGucDCBbwBkoYDO8w==
Received: from OL1P279CA0049.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:14::18)
 by AS8PR10MB4582.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:2eb::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Mon, 7 Mar
 2022 06:47:58 +0000
Received: from HE1EUR01FT026.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:14:cafe::30) by OL1P279CA0049.outlook.office365.com
 (2603:10a6:e10:14::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Mon, 7 Mar 2022 06:47:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.73)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.73 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.73; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.73) by
 HE1EUR01FT026.mail.protection.outlook.com (10.152.0.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Mon, 7 Mar 2022 06:47:57 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SNA.ad011.siemens.net (194.138.21.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Mon, 7 Mar 2022 07:47:57 +0100
Received: from [167.87.0.7] (167.87.0.7) by DEMCHDC8A0A.ad011.siemens.net
 (139.25.226.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 7 Mar
 2022 07:47:57 +0100
Message-ID: <17bf129c-9cfc-a9ee-bf7c-c00b02ce6251@siemens.com>
Date: Mon, 7 Mar 2022 07:47:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [cip-dev][PATCH v2] start-qemu.sh: Remove BOOT_FILES variable and
 call qemu directly in secure,swupdate and normal path
Content-Language: en-US
To: Srinuvasan A <Srinuvasan_A@mentor.com>, <cip-dev@lists.cip-project.org>
References: <b2fe71e9-c323-8dde-d9b0-d1d2a503d4d8@siemens.com>
 <20220304080349.4186067-1-Srinuvasan_A@mentor.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220304080349.4186067-1-Srinuvasan_A@mentor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.0.7]
X-ClientProxiedBy: DEMCHDC89YA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01ba317f-58e1-45bd-3077-08da00066a49
X-MS-TrafficTypeDiagnostic: AS8PR10MB4582:EE_
X-Microsoft-Antispam-PRVS: 
	<AS8PR10MB4582702A05CEEDCEF059590295089@AS8PR10MB4582.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	nA6gtGzfEfFdSmYUlYzFVyw9lbEytyjDDSfh+GWciBE9z9mfVRU8jLQIb8AL04ysz35DGprBZuhdNf7KxDlyl301iN+od8O5v85bhxpUXzadPne+QRMNmLQenR8jfNc31QVKOEfxz9xXz/yC+sbaRd5G5f2xxAC+hSFGZCjgYnpmZDwdRsZtXoQwFJ8SEbmWI34ubAAmXNW6zZzYWjo49o3kPFabZY9RlbHTB7VGLSTu3Sh+TIAbtc/uAkK0aEKTf+KfLgV0DdYzouNRLmKJSKS/GGEaLwkGID0q6pbUOWFFsbEtaP4fKY8t0O9HMjjxfLWLb623LyoA2nyk8VayGLKNSXcaekaq/4cIRI5lNlzQN1zw5LS/G9JxqIfSS/GdGNvKfanHXrW2r5v/OcQOMjjiuN38adylljlZVZDgaKZ7DIbTV+XCajGimUoNjqYkQG2Kurj43XTFS+0jf3RQpNksVu6a8WvL3Bj8KUEhrjOnVlOFA9O8h6bYnoUJpZaZWcqKyB2hBC/8BoaYs4nLC8MMw4437Na7yG0ite+h50lhAtARh3A2uCi+qzB/vppZAfo3eR6On8cNUzTdey+A0u9zqbkZqsu65Cl+hhu+Xg/PNQo6PFYLRBUuvObg7zRp4q8nomjC2aMcBjiplUoAXME3d0eDFkwqIk2U9jp8jWhvL/2I2FuhqsKKSkk/WkvQt1bq79s+e2W1SgdZOlMHqiWeHkUNMAuc8zgPc2IqyTU5fxenUt0OXb0qq9Cc7uENlnwQ8Vdv9kYTyiwG4sf3rw==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.73;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(2906002)(81166007)(82960400001)(356005)(36756003)(31696002)(83380400001)(40460700003)(47076005)(956004)(2616005)(82310400004)(336012)(36860700001)(16526019)(186003)(86362001)(26005)(31686004)(44832011)(6706004)(110136005)(8936002)(5660300002)(16576012)(8676002)(70586007)(70206006)(508600001)(53546011)(316002)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 06:47:57.8550
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 01ba317f-58e1-45bd-3077-08da00066a49
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.73];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT026.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB4582
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 07 Mar 2022 06:48:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7659

On 04.03.22 09:03, Srinuvasan A wrote:
> From: Srinuvasan A <srinuvasan_a@mentor.com>
> 
> Broke the normal boot part.
> Fixed them.
> 
> -append takes arguments inside double quotes(""). If we escape
> and pass the " along with the value the final command would form
> like what we would expect.
> 
> qemu-system-x86_64 .... -append " root=/dev/sda console=ttyS0"
> 
> But when the shell parses it, due to how whitespace splitting works
> for arguments passed via a variable, it parses the first quote(")
> as argument 1 and root=dev/sda as argument 2 and messing up the
> command.
> It should ideally treat the whole " root=/dev/sda console=ttyS0" as
> a single argument.
> 
> Hence Maintaining argument splitting is complex. A simpler one for here is to
> avoid BOOT_FILES and unrole the actual qemu call with its different
> kernels into the secure, swupdate and normal path.
> 
> Signed-off-by: Srinuvasan A <srinuvasan_a@mentor.com>
> ---
>  start-qemu.sh | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
> 
> diff --git a/start-qemu.sh b/start-qemu.sh
> index a7e0588..4105d4e 100755
> --- a/start-qemu.sh
> +++ b/start-qemu.sh
> @@ -114,6 +114,11 @@ fi
>  
>  shift 1
>  
> +QEMU_COMMON_OPTIONS=" \
> +	-m 1G \
> +	-serial mon:stdio \
> +	-netdev user,id=net"
> +
>  if [ -n "${SECURE_BOOT}" ]; then
>  		ovmf_code=${OVMF_CODE:-./build/tmp/deploy/images/qemu-amd64/OVMF/OVMF_CODE_4M.secboot.fd}
>  		ovmf_vars=${OVMF_VARS:-./build/tmp/deploy/images/qemu-amd64/OVMF/OVMF_VARS_4M.snakeoil.fd}
> @@ -121,22 +126,24 @@ if [ -n "${SECURE_BOOT}" ]; then
>  			-global ICH9-LPC.disable_s3=1 \
>  			-global isa-fdc.driveA= "
>  
> -		BOOT_FILES="-drive if=pflash,format=raw,unit=0,readonly=on,file=${ovmf_code} \
> +		${QEMU_PATH}${QEMU} \
> +			-drive if=pflash,format=raw,unit=0,readonly=on,file=${ovmf_code} \
>  			-drive if=pflash,format=raw,file=${ovmf_vars} \
> -			-drive file=${IMAGE_PREFIX}.wic.img,discard=unmap,if=none,id=disk,format=raw"
> +			-drive file=${IMAGE_PREFIX}.wic.img,discard=unmap,if=none,id=disk,format=raw ${QEMU_COMMON_OPTIONS} ${QEMU_EXTRA_ARGS} "$@"
> +
>  elif [ -n "${SWUPDATE_BOOT}" ]; then
> -		BOOT_FILES="-drive file=${IMAGE_PREFIX}.wic.img,discard=unmap,if=none,id=disk,format=raw \
> -			-bios OVMF.fd "
> +		${QEMU_PATH}${QEMU} \
> +			-drive file=${IMAGE_PREFIX}.wic.img,discard=unmap,if=none,id=disk,format=raw \
> +			-bios OVMF.fd ${QEMU_COMMON_OPTIONS} ${QEMU_EXTRA_ARGS} "$@"
> +
>  else
>  		IMAGE_FILE=$(ls ${IMAGE_PREFIX}.ext4.img)
>  
>  		KERNEL_FILE=$(ls ${IMAGE_PREFIX}-vmlinu* | tail -1)
>  		INITRD_FILE=$(ls ${IMAGE_PREFIX}-initrd.img* | tail -1)
>  
> -		BOOT_FILES="-drive file=${IMAGE_FILE},discard=unmap,if=none,id=disk,format=raw \
> +		${QEMU_PATH}${QEMU} \
> +			-drive file=${IMAGE_FILE},discard=unmap,if=none,id=disk,format=raw \
>  			-kernel ${KERNEL_FILE} -append "${KERNEL_CMDLINE}" \
> -			-initrd ${INITRD_FILE}"
> +			-initrd ${INITRD_FILE} ${QEMU_COMMON_OPTIONS} ${QEMU_EXTRA_ARGS} "$@"
>  fi
> -${QEMU_PATH}${QEMU} \
> -			-m 1G -serial mon:stdio -netdev user,id=net \
> -			${BOOT_FILES} ${QEMU_EXTRA_ARGS} "$@"

Thanks, applied. Further cleanup on top will follow.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


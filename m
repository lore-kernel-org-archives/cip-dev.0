Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8919DC433F5
	for <webhook@archiver.kernel.org>; Thu,  3 Mar 2022 14:54:27 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.48])
 by mx.groups.io with SMTP id smtpd.web11.11566.1646319266469226973
 for <cip-dev@lists.cip-project.org>;
 Thu, 03 Mar 2022 06:54:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=JOFJESzt;
 spf=pass (domain: siemens.com, ip: 40.107.8.48,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QeSrLXJc5pG7uvTJOjraEr8PLHKAxmf9zM3XJdfpnNIHUgbTp7+vQBqbAlUYTlHbpRv76+UT7LI8wH6vz31DDaxqe91kk0f6+pQlPKitbhai3OMjkXj58qXt95gXJrEY4Fx1hMqbGusXTiDx0aRs5J58mlOBjkpTV/PHQleAcOj0ADK5+9GfqYcuTOlOTAGHGunDxm0Lru14lucMkRMnfFncQ2U2H4t3bG1ZuCwD9DY7u8XVZcGhs83guFFZCVIX3CWiTu0Z2JZluY718VSCxe2wiru4ZzA+mDcJeQ+zV885wzBSz1nzcRalcqNycwy2dB1JdfvEuQgMMTHMshOWSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5b3K6sTceKUh5nylNzh6UxqFlshuKIa/FYOAtpDKkdc=;
 b=KLCTRjC9GWTO9ld5vDgpPHGBTQIAgTPjUThlydwrSo+HDS6qO1J1WmjzvN/DD+qgdqly+idgvP+NrPPKPI1GmV4owNm1iBAoNbkjiehS/UjkkaO2Vw/M3tHsQ40bHdL8iEs4wHKcayNpSkV115WtoN2+G6JO4LEH9lVBLSdgvvTq5CXQb5GJ+jgCTRoV4ilt3pxUBLY2eyZUk6i9wY62JtMMyevKa6pCFi6TeMX06jZ8Mk7kRgiSOdZjQI1Ef7MHjBKF1R4q6b1E6HoZBZtcmox7OYwgw5lyiNYoaSq7mG9S6sVjWcf0wYKtXgZZjuMttOR//+nqXPE1LI6kD9tdHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.73) smtp.rcpttodomain=mentor.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5b3K6sTceKUh5nylNzh6UxqFlshuKIa/FYOAtpDKkdc=;
 b=JOFJESzthCYlVwQzCvhd7eSSomPufG67LJ4xXq8qofCulOsS5GgnLlRtL1M2z8U91V4W9m2BrOIfBuMN0+6V+DITvk8Ntsn4EY3CLxSodDICDycUPa+0GmtWkHHEKMjRa8oiYh3eZqS6ads4Wt2Ugpxk4iQjH9E1LaDU446iihAkVChSY3W6r392B5+fIq4UaonIAj8dGgaDIrFoNkZVkM+LCkh+0BcBxT35vOGiffiGXAdLxAkmZuxtmEhl0SHf+PeNM+UP0SYU3aztLWIOPDx7GuAwX5tRgFiWixwq9B9tYSiS6P/+W7FdiEzjAJyqWV/CsgYkewSaDj9auWBNMg==
Received: from DB6PR0202CA0029.eurprd02.prod.outlook.com (2603:10a6:4:a5::15)
 by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 3 Mar
 2022 14:54:23 +0000
Received: from DB5EUR01FT057.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:4:a5:cafe::a3) by DB6PR0202CA0029.outlook.office365.com
 (2603:10a6:4:a5::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Thu, 3 Mar 2022 14:54:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.73)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.73 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.73; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.73) by
 DB5EUR01FT057.mail.protection.outlook.com (10.152.5.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Thu, 3 Mar 2022 14:54:22 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SNA.ad011.siemens.net (194.138.21.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Thu, 3 Mar 2022 15:54:21 +0100
Received: from [139.25.68.37] (139.25.68.37) by DEMCHDC8A0A.ad011.siemens.net
 (139.25.226.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 3 Mar
 2022 15:54:21 +0100
Message-ID: <b2fe71e9-c323-8dde-d9b0-d1d2a503d4d8@siemens.com>
Date: Thu, 3 Mar 2022 15:54:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [cip-dev][PATCH] start-qemu.sh: Remove BOOT_FILES variable and
 call qemu directly in secure,swupdate and normal path
Content-Language: en-US
To: Srinuvasan A <Srinuvasan_A@mentor.com>, <cip-dev@lists.cip-project.org>
References: <20220303144517.4182918-1-Srinuvasan_A@mentor.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220303144517.4182918-1-Srinuvasan_A@mentor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.25.68.37]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd4ab559-bd81-4029-31fb-08d9fd25b431
X-MS-TrafficTypeDiagnostic: PAXPR10MB4734:EE_
X-Microsoft-Antispam-PRVS: 
	<PAXPR10MB473481F063E60EF659629AE295049@PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	u1kdMXg/ceFbqKRwB3gvCcM30WQMwuaYSycteKCcFGMGJAHFfVSM3YHU+ILi/0zzFWsCL+IWFwJeUchOgjzB8eaf9mPvH+p3kNU/aflPvb9mlUYx20RRbKnjb6lOd25mwJuxG5ZE2b5uCvERzGqJBfD/AoSbdzRVmaaxJktKCeQ2g2yNdyGbvVFGihlssoWtVJP3116YTWFkS7XV2l/uFUSdhUCQu9r4aReOrZ263JHMj7uak9bTBF9+B06xtXpX3F3ALmQjo4+RUe9Sz9uz3Qca0npbYjK3ApuAc/MTvMNr3Qh1agSPnv8BbgvZ4CCtMSxou2x2bnzzAawId1zw8unZmHIlk4nCLr/5mtZozZFLdwCq6EsIvE4b8Mae8wqWLA17pdncA1gNrr/olPS0ezd5oRYwLvUvmS1E+15HaGNL4e5g0NXE6KHvuKbJvNihpM8giK9k511WUewxWZdH0L23WsJvTariK2Xo8c9MxOOc+p1BgEQtiRcqn+364cXykfrov+6YzqRgPZ+zzEs/KPO5UfKriGUokYR+XluEiAVFWLwhMUstZjZgdic4/7Nx2NydVKuoN353WEpRPCUy2GhwA+0DJQD1kSUU2po75WVm0fplJbfaGgiay9q6UMzuCjl0V6wtleJayNrOHzpKeytbEO3VjMcapahejW+e/pgeAi37QkNxZGQYgXISdknA9ZYJey12s6pBZlJrJEz/GhRCgc/AOx3Y96au0ZvZAcqm08y+W0PGJkizzaepqVqJvdWLNdBBosfqm1pmgawUyA==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.73;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(110136005)(16576012)(8936002)(316002)(6706004)(31686004)(8676002)(36860700001)(82960400001)(26005)(36756003)(31696002)(40460700003)(508600001)(70206006)(44832011)(70586007)(5660300002)(53546011)(356005)(81166007)(2906002)(956004)(2616005)(82310400004)(336012)(16526019)(47076005)(83380400001)(86362001)(186003)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 14:54:22.7594
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 bd4ab559-bd81-4029-31fb-08d9fd25b431
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.73];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT057.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB4734
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 03 Mar 2022 14:54:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7652

On 03.03.22 15:45, Srinuvasan A wrote:
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
> hence Maintaining argument splitting is complex. A simpler one for here is to

"Hence maintaining..."

> avoid BOOT_FILES and unrole the actual qemu call with its different
> kernels into the secure, swupdate and normal path.
> 
> Signed-off-by: Srinuvasan A <srinuvasan_a@mentor.com>
> ---
>  start-qemu.sh | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/start-qemu.sh b/start-qemu.sh
> index a7e0588..d19cd98 100755
> --- a/start-qemu.sh
> +++ b/start-qemu.sh
> @@ -121,22 +121,27 @@ if [ -n "${SECURE_BOOT}" ]; then
>  			-global ICH9-LPC.disable_s3=1 \
>  			-global isa-fdc.driveA= "
>  
> -		BOOT_FILES="-drive if=pflash,format=raw,unit=0,readonly=on,file=${ovmf_code} \
> +		${QEMU_PATH}${QEMU} \
> +			-m 1G -serial mon:stdio -netdev user,id=net \
> +		        -drive if=pflash,format=raw,unit=0,readonly=on,file=${ovmf_code} \
>  			-drive if=pflash,format=raw,file=${ovmf_vars} \
> -			-drive file=${IMAGE_PREFIX}.wic.img,discard=unmap,if=none,id=disk,format=raw"
> +			-drive file=${IMAGE_PREFIX}.wic.img,discard=unmap,if=none,id=disk,format=raw ${QEMU_EXTRA_ARGS} "$@"
> +
>  elif [ -n "${SWUPDATE_BOOT}" ]; then
> -		BOOT_FILES="-drive file=${IMAGE_PREFIX}.wic.img,discard=unmap,if=none,id=disk,format=raw \
> -			-bios OVMF.fd "
> +		${QEMU_PATH}${QEMU} \
> +			-m 1G -serial mon:stdio -netdev user,id=net \
> +		        -drive file=${IMAGE_PREFIX}.wic.img,discard=unmap,if=none,id=disk,format=raw \
> +			-bios OVMF.fd ${QEMU_EXTRA_ARGS} "$@"
> +
>  else
>  		IMAGE_FILE=$(ls ${IMAGE_PREFIX}.ext4.img)
>  
>  		KERNEL_FILE=$(ls ${IMAGE_PREFIX}-vmlinu* | tail -1)
>  		INITRD_FILE=$(ls ${IMAGE_PREFIX}-initrd.img* | tail -1)
>  
> -		BOOT_FILES="-drive file=${IMAGE_FILE},discard=unmap,if=none,id=disk,format=raw \
> +		${QEMU_PATH}${QEMU} \
> +			-m 1G -serial mon:stdio -netdev user,id=net \
> +                        -drive file=${IMAGE_FILE},discard=unmap,if=none,id=disk,format=raw \
>  			-kernel ${KERNEL_FILE} -append "${KERNEL_CMDLINE}" \
> -			-initrd ${INITRD_FILE}"
> +			-initrd ${INITRD_FILE} ${QEMU_EXTRA_ARGS} "$@"
>  fi
> -${QEMU_PATH}${QEMU} \
> -			-m 1G -serial mon:stdio -netdev user,id=net \
> -			${BOOT_FILES} ${QEMU_EXTRA_ARGS} "$@"

Functionally fine, but your indention is not consistent (mostly tabs,
not not always).

When you do a v2, you could use that chance and factor out the common
arguments into a variable (-m 1G -serial mon:stdio -netdev user,id=net).

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C20CC433F5
	for <webhook@archiver.kernel.org>; Thu,  9 Dec 2021 11:20:01 +0000 (UTC)
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (EUR02-HE1-obe.outbound.protection.outlook.com [40.107.1.87])
 by mx.groups.io with SMTP id smtpd.web10.10268.1639048799548070738
 for <cip-dev@lists.cip-project.org>;
 Thu, 09 Dec 2021 03:20:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=dABVRmT8;
 spf=pass (domain: siemens.com, ip: 40.107.1.87,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=geU6r/WUJ4BuczqINQULLhgV+xylvLFREhDXzF1cVS7WFJZSPiVLiZ0RBFLEZ2cM/ueWWqL1TzIPwMM8kC7orDb8QRqMOQb5EZP2cMt+M+qHc9U8G2F2lOzYdSjiTgb+fBeTJc7PLp100aqUhjEGkqPBq3IsZZVdKYOszkntZZezqJA4GVqM+Gb9o/4ZGqGCnTXFNolZwLM11ENVUzyZAv3d/yG7QDQqv2bcAwWRAibLYghw5c74CExZyAbTdTtkYFUsHonRhi4bMOE+TF8DQrLg+hOZlFV6mu3FVQmahv7v+NAclvDGVFChKqowHHf61d2zImD77cQFefsPCDc99g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xmNK7tQE8x3vTXvYKvIOEJs9eqh+a8nqFUoJC/qDDPk=;
 b=Zc1DZCQ/maz5iCqXs1t1yItb92W38Wasv8ePsakmrdniVqcdoRUIa0B9mWQe7Aem0bXPDiW5N6UkZXYUIn0JOmBIR01kcUspKKnTlvM79kGpUlepbxSHEwS9TJq2pTSuD6NrxImPN4mbRGmMiYOMgKZ5GVEaBdgZYRR+kdaPXoi/NJcL5Herg3hrf8nIVYrR0J4lgfX4XgT773K1byDz2P83pg0oF+lQz4dwHHPyY/34XypGzNluNFlMwhFJKBKlKNOVd85bU5A7DsbqndJexrqSBPi/dNcCFJufYByfn7fTVG1IBFryVVfC/wODsRkWNk5e91BWEtpCI9omQLXg4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.72) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xmNK7tQE8x3vTXvYKvIOEJs9eqh+a8nqFUoJC/qDDPk=;
 b=dABVRmT8wqeLKOMw8ncqQ6KNPcUkXc/0VUiQewjmhyGqSsl3k3scPLvvUBWmiv13c2fAjZaEj0daVh2ZPatz+MWXUkbBG8t9KwiOXwL6qeofm4ZeKQk2+WR2eTiQlMx/qlk4D/YRwdQGxsv5h9LVl04chPBNDWU8jEhkeSjpF/AsnQKplK2jX7Nlyp3wABuA9WXjl0/UpO8CEEAkpOAF6Aj9aAu+lXfq5Q5dBYvnD6fED8yen/SStyifQo6uuEgAT0vLMwSzCCZ8h7atc27hQewT1fLr3wE4cawENMTt+sf/S0nEOgTWVtiPfJAuChGOGBoC0AVnuAuDeGKdrXLGtg==
Received: from SV0P279CA0072.NORP279.PROD.OUTLOOK.COM (2603:10a6:f10:14::23)
 by DB8PR10MB2620.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:b2::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Thu, 9 Dec
 2021 11:19:53 +0000
Received: from HE1EUR01FT053.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:f10:14:cafe::df) by SV0P279CA0072.outlook.office365.com
 (2603:10a6:f10:14::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12 via Frontend
 Transport; Thu, 9 Dec 2021 11:19:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.72)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.72 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.72; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.72) by
 HE1EUR01FT053.mail.protection.outlook.com (10.152.1.73) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.12 via Frontend Transport; Thu, 9 Dec 2021 11:19:52 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SMA.ad011.siemens.net (194.138.21.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 9 Dec 2021 12:19:52 +0100
Received: from [167.87.72.174] (167.87.72.174) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 9 Dec 2021 12:19:51 +0100
Subject: Re: [cip-dev][isar-cip-core][PATCH] start-qemu.sh: Add option to
 start a wic.img
To: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>,
	<cip-dev@lists.cip-project.org>
References: <20211208160935.157897-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <a07c6a1d-8418-359c-f12a-5dc6b9adc88f@siemens.com>
Date: Thu, 9 Dec 2021 12:19:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211208160935.157897-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.72.174]
X-ClientProxiedBy: DEMCHDC89YA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40977742-2ff2-4257-2ea1-08d9bb05d24e
X-MS-TrafficTypeDiagnostic: DB8PR10MB2620:EE_
X-Microsoft-Antispam-PRVS: 
	<DB8PR10MB2620F5A7CB952E2482321D6E95709@DB8PR10MB2620.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:1013;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	pCOtNSEWGjRtg3kh1Z1LnRJQ37muRsrRx01MWk71mLuI1ZAAAa/f1nc2V1bGPeq2atHzTX7Uy9lVAnOpGzDrOlBVIJn/WPHConxfYm+W2ykEBPSN+S7Sfv1zwEbSWcX6S1XiVFVto7uAkVXgd9MTxOVJFEGSU0r4nacAfLHqkiSSZBoBiKJYSprzjvG4bFOG2LHmDaGgfWJMOvj5hfEw/9moiWC7EFzbM/fDl/y19Az6oYLuWHHipTKQ66kPphGgWzlrqYzdDViIUkiBSZjGVxR5mzcTrpThQ5zDGoBEZ8q7WyNwz95eEuG0/PtOmgLUxAS4oDmnAA03d5WMGFUFVITuvoD9YNjqyS6NbOV/iWPPFk3JAlVXCAmd7PIDbtDT6+uZyTE3o7uO3ahcJ6C1IH/YOe/F/3ksXSQngCnr5friVE5tTKD3zfFpQ1njOpCzw7ETm2WWQBmObrf0plMzpHZPA/PQVeNfdMMjrE9O6kZdK8+lohvG+NyV+6ItEny7ZMBGfj65Z1d1UsTMEcnnm7LXaAhXPAvbDhAfaamgUxrHOgeoOzp78JRI7dlgmGYi17Dj1i7989nF6aGV7aLTh1wnuKLJQO5fnlb0d+1emS+HSEeeXPKeWVjoVKBkvj2EzbnO+65xoTFmg7NymToX5TD1VWZzl/ZFPXS4UcJpJxYDGdQqlfnNqsOiqS+OogmEPY4qXRz3DkrOsGZFs5jy7JO4e0aZh1Rv90fY7w7mlo4B89Kiemszmtt6gK98ZzGY9udPjsGkWvmLclNPIRgVfR79IqO6zOdTptQnzddecQbcZpflQsSqwjEs1ynVvrn3nocIMjmKPTnGNGOoGy/P1nIA83WoHH125xwrOgw/OpbaJxZunaaDQa+Fl7ljKSd6
X-Forefront-Antispam-Report: 
	CIP:194.138.21.72;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(31686004)(81166007)(316002)(16576012)(110136005)(508600001)(356005)(86362001)(966005)(47076005)(82310400004)(83380400001)(82960400001)(36860700001)(2906002)(16526019)(5660300002)(336012)(26005)(186003)(70586007)(70206006)(8936002)(956004)(6706004)(8676002)(53546011)(36756003)(44832011)(2616005)(31696002)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 11:19:52.6292
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 40977742-2ff2-4257-2ea1-08d9bb05d24e
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.72];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT053.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB2620
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 09 Dec 2021 11:20:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7082

On 08.12.21 17:09, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> To test image created for swupdate the resulting wic image needs
> to be boot by qemu.
> 
> Also fix indentation.
> 
> This fixes issue [18]:
> 
> [18]: https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/18
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  start-qemu.sh | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/start-qemu.sh b/start-qemu.sh
> index c700974..4ab3861 100755
> --- a/start-qemu.sh
> +++ b/start-qemu.sh
> @@ -22,6 +22,8 @@ usage()
>  
>  if grep -s -q "IMAGE_SECURE_BOOT: true" .config.yaml; then
>  	SECURE_BOOT="true"
> +elif grep -s -q "IMAGE_SWUPDATE: true" .config.yaml; then
> +	SWUPDATE_BOOT="true"
>  fi
>  
>  if [ -n "${QEMU_PATH}" ]; then
> @@ -42,7 +44,7 @@ if [ -z "${TARGET_IMAGE}" ];then
>  	TARGET_IMAGE="cip-core-image"
>  	if grep -s -q "IMAGE_SECURITY: true" .config.yaml; then
>  		TARGET_IMAGE="cip-core-image-security"
> -    fi
> +	fi
>  	if [ -n "${SECURE_BOOT}" ]; then
>  		TARGET_IMAGE="cip-core-image-read-only"
>  	fi
> @@ -58,7 +60,7 @@ case "$1" in
>  			-machine q35,accel=kvm:tcg \
>  			-device virtio-net-pci,netdev=net"
>  		if [ -n "${SECURE_BOOT}" ]; then
> -            # set bootindex=0 to boot disk instead of EFI-shell
> +			# set bootindex=0 to boot disk instead of EFI-shell
>  			QEMU_EXTRA_ARGS=" \
>  			${QEMU_EXTRA_ARGS} -device ide-hd,drive=disk,bootindex=0"
>  		else
> @@ -127,6 +129,9 @@ if [ -n "${SECURE_BOOT}" ]; then
>  		BOOT_FILES="-drive if=pflash,format=raw,unit=0,readonly=on,file=${ovmf_code} \
>  			-drive if=pflash,format=raw,file=${ovmf_vars} \
>  			-drive file=${IMAGE_PREFIX}.wic.img,discard=unmap,if=none,id=disk,format=raw"
> +elif [ -n "${SWUPDATE_BOOT}" ]; then
> +		BOOT_FILES="-drive file=${IMAGE_PREFIX}.wic.img,discard=unmap,if=none,id=disk,format=raw \
> +			-bios OVMF.fd "
>  else
>  		IMAGE_FILE=$(ls ${IMAGE_PREFIX}.ext4.img)
>  
> 

Thanks, applied.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux


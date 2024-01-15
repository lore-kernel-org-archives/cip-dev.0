Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03139C47422
	for <webhook@archiver.kernel.org>; Mon, 15 Jan 2024 08:59:55 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.49])
 by mx.groups.io with SMTP id smtpd.web11.73353.1705309188918551641
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Jan 2024 00:59:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=S8YvYaO0;
 spf=pass (domain: siemens.com, ip: 40.107.6.49, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RAxIK0gdNkeeBP9I+3v3ZbnPlWtisC7UTbdlPzK1q5jE6RVHzJ3QXMD3TIp3s9V4CkFlQ0t3GZCd69cssh58KKeAJslFMbJhTUjiwGEDUQCgGy/U2Evby+f8xevPlZno3DNxdLxsG9ktriC5X+4egEWTOoyekvRkGCPMP2zWryP4mIbGKTnTELCH976iccUkL6sFtT9XIsKGIWTsCSexaH1G9Hp9nVN+CPLbAD5SWY787St/H+2Lljb9NEauzWsS5rfKOKQ6AofD9t4CyXTTFDEABHHgHLyjeuQFgknEC/RKU5/WiYgmDeJaoBx46xfZvqadHmoPzWzNB6QlmzblSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K/t61LiUiwV0AZYkf+L9yVNVKFgUjSjaIxrjy87h4uY=;
 b=kkf/3EoUlmtiTp1G6G0MS5ySMyb0blvWCn8AXRYtqRvEzeymwrslTil7qp6NGXeh8807Hkm8fWbIoHSgeSqnw+Iz50tKyDufw9L7D0WU6a9/n0Y6XsQDlhrtrFNk1MaExvMZS27eUo3tS1zkQo2r3JW4Q2sWt8T05QUrT2cGiDFoZrXn20BWNabQVVmehc0R+LbzS7XU3XasAnh6EVKxkhx3/b6gZCQ62KlBubigeB8c/WTsC+r/AFZGBWdW08JjfraZGEctIuGuh0I9hl+OE41j3VM40p3I/DwKL3upchtX1jcKrgqyUNdfs9i8CiP0XmxofAn0WbvBs7riPOxydw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K/t61LiUiwV0AZYkf+L9yVNVKFgUjSjaIxrjy87h4uY=;
 b=S8YvYaO0JJyVyZ6CwOlvQYoUOuITTrDPhmr9OvaRCu2KNTb9g3Qovz7/m+NjwoesivVC+BvB7/Kx75tt0T6SHLzwybB4P4/VJM+VowPPlfHYZzIxvvAXwLbaGS+tfKha+Q767j7/h2ORjBfN2FvppzDOPvcUAPhtbOCbv+c+foo9U53B57Cx69r+P+3/Zj9KtbHbbB7f4ElkqwTg8bCWICqnucfvTEbXkUug3MVL6MqwdXUQxjy0KtntVqkA+KdQ/rKQ81loxtRAfwvVNZFeQRWireJ2C+XgCj9LUorfr81V47H4xo1MvxlzZ9kQF3iIFa1Hv/vYJGB9pnav7OtKhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6698.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:564::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Mon, 15 Jan
 2024 08:59:42 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7181.026; Mon, 15 Jan 2024
 08:59:42 +0000
Message-ID: <bade7bd3-bd13-4c2a-9f9f-9adcffa23344@siemens.com>
Date: Mon, 15 Jan 2024 09:59:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] u-boot: Update to 2024.01
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
References: <de204e94-5c9f-42c2-8d6d-951d2ad8fc4b@siemens.com>
In-Reply-To: <de204e94-5c9f-42c2-8d6d-951d2ad8fc4b@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0412.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6698:EE_
X-MS-Office365-Filtering-Correlation-Id: 48445c5a-6ad2-4fcb-9c63-08dc15a84ff9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	o9rC95Onwz3ZVhRZ6XB9uDHC+zsnROBBGD8hCQ/kswK/sYwPksX7KTPLzKCnkUyNfxnTDeMrzN9/qR7QDsWJ8/gmScyht+31haSqwSV4R4hLSGasAtANDcjw9IC2geAYbIUDRSkHB87+CPKltavkNhQLJOcaaBMx09ISiSTGGE6h0lyEMS2zg/oqVZfkMjF/4DXj6cZgWEn9y3aNQGsRfbHnZBja26pjAxW9Dt0hNo6/xAaCZkHF2C1ani9/NdbvtYGGZXTtzv+rOboCJcvQArGLPZ2GfdVBtm8sgepfxioQlDdSduH8qGl9eoq0/onHXKcc0Ill2DYZBxuxN098PmDw2vWaIlI0i+yK1w/iaMesDUkJKdF9x5P519BWXvKecLVg7kQoDE8TJlKiEAPJt+G9tobKGVsO8OVwPAhg71JGEODfy5I4pCn9eEPVoQG3UioVnNOVn21jKUb05+jcZZYIlgAZxpEiji6jOv+9fA+pJrkaBbDedVS+e4RiQnDkDyri/QprQr3ZVTPGZ1PjRmIDkkFG7JPWsrDSfAhQbKiA0kEF/PkyOYGDNAQR8cyAalMCDMJsvf+//CcNusQwuirFrZG0CKEwvdt46JXerDlm0cxo5m9EIfiL9/g8Rf+Sqdt9r1jWZR7debdQl0Y+KA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(376002)(136003)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(36756003)(2616005)(26005)(15650500001)(5660300002)(38100700002)(2906002)(83380400001)(41300700001)(966005)(6486002)(44832011)(66946007)(6916009)(316002)(8676002)(8936002)(66476007)(31696002)(66556008)(6512007)(6506007)(31686004)(86362001)(82960400001)(53546011)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MzhEejBTcmxLTU0za3pWM2lDdTU1T1B4ejhGOUx3a2ZWYlNSb1hJQWJoZDhI?=
 =?utf-8?B?M3FnMUZiVXRhWmJWTHk1UGlJbkJDQjJMYXp6OFdGalovajFNMFk1OURjZUls?=
 =?utf-8?B?cys0ZllrZElxaS9FM25EVkZ3bE5sTXAwT1NRYjM4SUR4bTlrUkNUam1pOXg1?=
 =?utf-8?B?U0VxNmV2QXU2MHRnV2x1RTd6M0VPV1lXR0tMWHdmSW50R3o1bFl1YWZrc1dL?=
 =?utf-8?B?SCtlaTRGcExNTWJBMzFRZG5odit3QnB4NGFzcWw4d29sQkF0bDl5ZXo3Rnhs?=
 =?utf-8?B?d0dUWGt5U1pXb3JIR2M4UERGcFROWDkyUk5UdXVsRkZQTDVuU3JsZW5tVlp4?=
 =?utf-8?B?R2RuSFM2UzBsYlAyRm9iWEN3MEFiKzkvcm9wT3VwVnYybnZHeWZuUys1MFdM?=
 =?utf-8?B?dTZFZ1hLeVp4Q0p1ZkZmYnVhRDNHSGU3aWdnVkZHZk5JSU8xY0NpZ2F5NmZm?=
 =?utf-8?B?VERWNE5KUTRyN3lHdmJkS09wZmE3ZEpsR2VrcFRldk82enhnOEhKbDhWd0hq?=
 =?utf-8?B?MUJ2Nmw2U2E3RUp6QkhRMW9Makdabkg4RlFnU1ByNzlOcEFrUUY2QnByNUlH?=
 =?utf-8?B?WlNNMFlkV01JV2p3T1lscjZWbzU2b2RJeDdaalMrQU4xRFJhMklQelJxVWpU?=
 =?utf-8?B?S1RrZzBWaUo1cW1aOHBNLzVRNHdYSU56ZFJXUHJIV0F1U015UEs1eXNhNkZT?=
 =?utf-8?B?ejg2bW9aNVRyNGgvOE9pWXN4QU92TmFSMU52ajY2eU9meEQxSnpWeVZ1Ukk0?=
 =?utf-8?B?WWU1SnBYcnd6dklJWU1KMU1ZV2NRcVVIQ0lSRW5MVTdST3BmN1g2WG8vZjBa?=
 =?utf-8?B?K1Z1WVp2TzFhWHBOc0ZGemIxWUpEdThqRzBrc1BnSU4ydjlJYzZIek5tMjNl?=
 =?utf-8?B?REliOThUc0FHcmRCVGpFWkRjOWJDSXVaZGxuZ0R2c1FCdlV2S00vaTdUdVdT?=
 =?utf-8?B?bjNJMkJ4cFFPVE1jNHo1bWlmeFB1bWlkaVBmUExGbHBoMm44bVpPN201bnpO?=
 =?utf-8?B?eHhZL2NBZUhORFA5Yk84R1BWTFJVUzJXN09GOHpwYjBTak5qWDNKaC9GTkV4?=
 =?utf-8?B?emdkbFh3WDdYK0F2K1VjMkxIT24wUit0QVFoYWF5eUgyeHduWldsYW5IT0JK?=
 =?utf-8?B?eW5RMmowU01hdEkxUEtiMDFCQ0RNZkVHWDlmcWtoa3prWmN4QW5ESVVud0Rv?=
 =?utf-8?B?bUtsVHZtSU9wcnVBWmZiK3IzRTFwTE9ZTmwzRzhPNHFyelRNSTBQU3RxMGEv?=
 =?utf-8?B?MHNkdE1XWFBVaE9oa2VpTUlWaGpyakFHVEFrcGpUcUNWOXVGUWVJVWxEYk1H?=
 =?utf-8?B?NjNpK1pCT01kckNFL2ZYQldHSjNtZUcxSnZNN1p2TVBqZmJzVEozelNCN1ZU?=
 =?utf-8?B?Z0txS0UzUFI1ZmhOVXNRMHVTemZQaDJlRGdqN3FwYlZJVTBON1R3LzJFMmlJ?=
 =?utf-8?B?Yy9ldVpkdHRKWlZjU0d0Y0swRlFVS2I4ZjZZZUxaN28ybEUyanowZ2o4SHZS?=
 =?utf-8?B?ME5JWGVHUXBCWEdIdWRmcVdjQzJmenpDaGY1b1dVZW9PMUdYZ0FRTTFrbktV?=
 =?utf-8?B?NjgrVmRYN2Y0WEcxWWNBcGx3VDZZSGVIR1dxVEROeFZZcUFmcE1Ub2gxYWt3?=
 =?utf-8?B?cS9mWVJ4NnhwVWgrM2paVHB3WHpWcjV0QWkySTIrbHhwTURXenRUTmVHSlE0?=
 =?utf-8?B?cXdOQXJoWklkWEI5M0hKaVlCemhXT1MrcjV5YVdha1VQK1V4Wk1waUVESm5O?=
 =?utf-8?B?NzlGS293U2dMWE14TmYvb0FldTZCdm8zVlNwQVlnQTBpWXZPNFRsZkpQRTBk?=
 =?utf-8?B?b3RYQ0pVMUF2RUUvWW1EL2k1b2dpaDdKY1VsNUI0a25ZcE02M2JvZTZncEpP?=
 =?utf-8?B?ZUROeUlpTDZwTUpGdEtmWno1dUhUMjFPN2JDV1ZpY2NnYkdGektFTmhmVGpp?=
 =?utf-8?B?ZWlLakQwWE1aV2pmZEZSS1BHbDYvbFpDbUVzODdURitBU2dEaDZUUExpWGxn?=
 =?utf-8?B?QnpoRFlpd0I0SmF1Nlo5WnJ2MlNzdVZON0pwaVJnbUhhSGJaTHpJeURVRXJT?=
 =?utf-8?B?ekVJT3RZSkgvMW5lV0dOMnM0d2orQmNGY1lBdVpVTWl2WnhYUi90dW1LN2h1?=
 =?utf-8?B?UVBrR0xyV0tnZHBnaXFraGJYYlRrV1cvY2JpWHhGVGJPZCt3NGp3UFZFeXpV?=
 =?utf-8?B?SUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48445c5a-6ad2-4fcb-9c63-08dc15a84ff9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 08:59:42.1303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /jlVvY/meNQx8WSW8thqRbiC1JJv2OlwYsoJ4P28cPB19gV0q4Zjb6tSy+8VS3pYG3erOfrux3SLJM2lbfl3Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6698
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Jan 2024 08:59:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14383

On 15.01.24 09:10, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Allows to drop the riscv patch.
> 
> u-boot-common is actually version-specific as it carries the sha.
> Reflect that in the file name. Using ${PV} for its inclusion only works
> directly, not via u-boot-qemu-common.inc, so do that from the respective
> .bb files.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  ...iscv-Fix-build-against-binutils-2.38.patch | 55 -------------------
>  ...t-bbb_2022.07.bb => u-boot-bbb_2024.01.bb} |  4 +-
>  ...t-common.inc => u-boot-common-2024.01.inc} |  4 +-
>  ...022.07.bb => u-boot-qemu-arm64_2024.01.bb} |  1 +
>  ..._2022.07.bb => u-boot-qemu-arm_2024.01.bb} |  1 +
>  recipes-bsp/u-boot/u-boot-qemu-common.inc     |  3 +-
>  ...2.07.bb => u-boot-qemu-riscv64_2024.01.bb} |  6 +-
>  7 files changed, 9 insertions(+), 65 deletions(-)
>  delete mode 100644 recipes-bsp/u-boot/files/riscv64/0001-riscv-Fix-build-against-binutils-2.38.patch
>  rename recipes-bsp/u-boot/{u-boot-bbb_2022.07.bb => u-boot-bbb_2024.01.bb} (82%)
>  rename recipes-bsp/u-boot/{u-boot-common.inc => u-boot-common-2024.01.inc} (87%)
>  rename recipes-bsp/u-boot/{u-boot-qemu-arm64_2022.07.bb => u-boot-qemu-arm64_2024.01.bb} (88%)
>  rename recipes-bsp/u-boot/{u-boot-qemu-arm_2022.07.bb => u-boot-qemu-arm_2024.01.bb} (88%)
>  rename recipes-bsp/u-boot/{u-boot-qemu-riscv64_2022.07.bb => u-boot-qemu-riscv64_2024.01.bb} (71%)
> 
> diff --git a/recipes-bsp/u-boot/files/riscv64/0001-riscv-Fix-build-against-binutils-2.38.patch b/recipes-bsp/u-boot/files/riscv64/0001-riscv-Fix-build-against-binutils-2.38.patch
> deleted file mode 100644
> index 6f8a2ae0..00000000
> --- a/recipes-bsp/u-boot/files/riscv64/0001-riscv-Fix-build-against-binutils-2.38.patch
> +++ /dev/null
> @@ -1,55 +0,0 @@
> -From 5df4b2299f86933fa79aa3bc6a3986fc7e55b7e0 Mon Sep 17 00:00:00 2001
> -From: Alexandre Ghiti <alexandre.ghiti@canonical.com>
> -Date: Mon, 3 Oct 2022 18:07:54 +0200
> -Subject: [PATCH 1/2] riscv: Fix build against binutils 2.38
> -
> -The following description is copied from the equivalent patch for the
> -Linux Kernel proposed by Aurelien Jarno:
> -
> ->From version 2.38, binutils default to ISA spec version 20191213. This
> -means that the csr read/write (csrr*/csrw*) instructions and fence.i
> -instruction has separated from the `I` extension, become two standalone
> -extensions: Zicsr and Zifencei. As the kernel uses those instruction,
> -this causes the following build failure:
> -
> -arch/riscv/cpu/mtrap.S: Assembler messages:
> -arch/riscv/cpu/mtrap.S:65: Error: unrecognized opcode `csrr a0,scause'
> -arch/riscv/cpu/mtrap.S:66: Error: unrecognized opcode `csrr a1,sepc'
> -arch/riscv/cpu/mtrap.S:67: Error: unrecognized opcode `csrr a2,stval'
> -arch/riscv/cpu/mtrap.S:70: Error: unrecognized opcode `csrw sepc,a0'
> -
> -Signed-off-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>
> -Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
> -Tested-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> -Tested-by: Heiko Stuebner <heiko@sntech.de>
> -Tested-by: Christian Stewart <christian@paral.in>
> -Reviewed-by: Rick Chen <rick@andestech.com>
> ----
> - arch/riscv/Makefile | 11 ++++++++++-
> - 1 file changed, 10 insertions(+), 1 deletion(-)
> -
> -diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> -index 0b80eb8d86..53d1194ffb 100644
> ---- a/arch/riscv/Makefile
> -+++ b/arch/riscv/Makefile
> -@@ -24,7 +24,16 @@ ifeq ($(CONFIG_CMODEL_MEDANY),y)
> - 	CMODEL = medany
> - endif
> - 
> --ARCH_FLAGS = -march=$(ARCH_BASE)$(ARCH_A)$(ARCH_C) -mabi=$(ABI) \
> -+RISCV_MARCH = $(ARCH_BASE)$(ARCH_A)$(ARCH_C)
> -+
> -+# Newer binutils versions default to ISA spec version 20191213 which moves some
> -+# instructions from the I extension to the Zicsr and Zifencei extensions.
> -+toolchain-need-zicsr-zifencei := $(call cc-option-yn, -mabi=$(ABI) -march=$(RISCV_MARCH)_zicsr_zifencei)
> -+ifeq ($(toolchain-need-zicsr-zifencei),y)
> -+	RISCV_MARCH := $(RISCV_MARCH)_zicsr_zifencei
> -+endif
> -+
> -+ARCH_FLAGS = -march=$(RISCV_MARCH) -mabi=$(ABI) \
> - 	     -mcmodel=$(CMODEL)
> - 
> - PLATFORM_CPPFLAGS	+= $(ARCH_FLAGS)
> --- 
> -2.30.2
> -
> diff --git a/recipes-bsp/u-boot/u-boot-bbb_2022.07.bb b/recipes-bsp/u-boot/u-boot-bbb_2024.01.bb
> similarity index 82%
> rename from recipes-bsp/u-boot/u-boot-bbb_2022.07.bb
> rename to recipes-bsp/u-boot/u-boot-bbb_2024.01.bb
> index 6632bb6c..52dec142 100644
> --- a/recipes-bsp/u-boot/u-boot-bbb_2022.07.bb
> +++ b/recipes-bsp/u-boot/u-boot-bbb_2024.01.bb
> @@ -1,7 +1,7 @@
>  #
>  # CIP Core, generic profile
>  #
> -# Copyright (c) Siemens AG, 2022
> +# Copyright (c) Siemens AG, 2022-2024
>  #
>  # Authors:
>  #  Jan Kiszka <jan.kiszka@siemens.com>
> @@ -9,7 +9,7 @@
>  # SPDX-License-Identifier: MIT
>  #
>  
> -require u-boot-common.inc
> +require u-boot-common-${PV}.inc
>  
>  U_BOOT_CONFIG = "am335x_evm_defconfig"
>  U_BOOT_BIN = "all"
> diff --git a/recipes-bsp/u-boot/u-boot-common.inc b/recipes-bsp/u-boot/u-boot-common-2024.01.inc
> similarity index 87%
> rename from recipes-bsp/u-boot/u-boot-common.inc
> rename to recipes-bsp/u-boot/u-boot-common-2024.01.inc
> index 0486cdaf..163532b0 100644
> --- a/recipes-bsp/u-boot/u-boot-common.inc
> +++ b/recipes-bsp/u-boot/u-boot-common-2024.01.inc
> @@ -1,7 +1,7 @@
>  #
>  # CIP Core, generic profile
>  #
> -# Copyright (c) Siemens AG, 2022
> +# Copyright (c) Siemens AG, 2022-2024
>  #
>  # Authors:
>  #  Jan Kiszka <jan.kiszka@siemens.com>
> @@ -14,7 +14,7 @@ require recipes-bsp/u-boot/u-boot-custom.inc
>  SRC_URI += " \
>      https://ftp.denx.de/pub/u-boot/u-boot-${PV}.tar.bz2 \
>      file://rules.tmpl;subdir=debian"
> -SRC_URI[sha256sum] = "92b08eb49c24da14c1adbf70a71ae8f37cc53eeb4230e859ad8b6733d13dcf5e"
> +SRC_URI[sha256sum] = "b99611f1ed237bf3541bdc8434b68c96a6e05967061f992443cb30aabebef5b3"
>  
>  SRC_URI:append:secureboot = " \
>      file://secure-boot.cfg.tmpl"
> diff --git a/recipes-bsp/u-boot/u-boot-qemu-arm64_2022.07.bb b/recipes-bsp/u-boot/u-boot-qemu-arm64_2024.01.bb
> similarity index 88%
> rename from recipes-bsp/u-boot/u-boot-qemu-arm64_2022.07.bb
> rename to recipes-bsp/u-boot/u-boot-qemu-arm64_2024.01.bb
> index 29ca0a55..db47ee93 100644
> --- a/recipes-bsp/u-boot/u-boot-qemu-arm64_2022.07.bb
> +++ b/recipes-bsp/u-boot/u-boot-qemu-arm64_2024.01.bb
> @@ -9,6 +9,7 @@
>  # SPDX-License-Identifier: MIT
>  #
>  
> +require u-boot-common-${PV}.inc
>  require u-boot-qemu-common.inc
>  
>  U_BOOT_CONFIG = "qemu_arm64_defconfig"
> diff --git a/recipes-bsp/u-boot/u-boot-qemu-arm_2022.07.bb b/recipes-bsp/u-boot/u-boot-qemu-arm_2024.01.bb
> similarity index 88%
> rename from recipes-bsp/u-boot/u-boot-qemu-arm_2022.07.bb
> rename to recipes-bsp/u-boot/u-boot-qemu-arm_2024.01.bb
> index cdad19a3..621cf01b 100644
> --- a/recipes-bsp/u-boot/u-boot-qemu-arm_2022.07.bb
> +++ b/recipes-bsp/u-boot/u-boot-qemu-arm_2024.01.bb
> @@ -9,6 +9,7 @@
>  # SPDX-License-Identifier: MIT
>  #
>  
> +require u-boot-common-${PV}.inc
>  require u-boot-qemu-common.inc
>  
>  U_BOOT_CONFIG = "qemu_arm_defconfig"
> diff --git a/recipes-bsp/u-boot/u-boot-qemu-common.inc b/recipes-bsp/u-boot/u-boot-qemu-common.inc
> index b222155c..0bf7b621 100644
> --- a/recipes-bsp/u-boot/u-boot-qemu-common.inc
> +++ b/recipes-bsp/u-boot/u-boot-qemu-common.inc
> @@ -1,7 +1,7 @@
>  #
>  # CIP Core, generic profile
>  #
> -# Copyright (c) Siemens AG, 2022
> +# Copyright (c) Siemens AG, 2022-2024
>  #
>  # Authors:
>  #  Jan Kiszka <jan.kiszka@siemens.com>
> @@ -10,7 +10,6 @@
>  #
>  
>  inherit deploy-firmware
> -require recipes-bsp/u-boot/u-boot-common.inc
>  
>  U_BOOT_BIN = "u-boot.bin"
>  
> diff --git a/recipes-bsp/u-boot/u-boot-qemu-riscv64_2022.07.bb b/recipes-bsp/u-boot/u-boot-qemu-riscv64_2024.01.bb
> similarity index 71%
> rename from recipes-bsp/u-boot/u-boot-qemu-riscv64_2022.07.bb
> rename to recipes-bsp/u-boot/u-boot-qemu-riscv64_2024.01.bb
> index 8dfac457..1cc0afdd 100644
> --- a/recipes-bsp/u-boot/u-boot-qemu-riscv64_2022.07.bb
> +++ b/recipes-bsp/u-boot/u-boot-qemu-riscv64_2024.01.bb
> @@ -1,7 +1,7 @@
>  #
>  # CIP Core, generic profile
>  #
> -# Copyright (c) Siemens AG, 2022
> +# Copyright (c) Siemens AG, 2022-2024
>  #
>  # Authors:
>  #  Jan Kiszka <jan.kiszka@siemens.com>
> @@ -9,6 +9,7 @@
>  # SPDX-License-Identifier: MIT
>  #
>  
> +require u-boot-common-${PV}.inc
>  require u-boot-qemu-common.inc
>  
>  # we run as OpenSBI payload, hence use smode
> @@ -16,7 +17,4 @@ U_BOOT_CONFIG = "${MACHINE}_smode_defconfig"
>  
>  EFI_ARCH = "riscv64"
>  
> -SRC_URI += " \
> -    file://riscv64/0001-riscv-Fix-build-against-binutils-2.38.patch"
> -
>  U_BOOT_BIN = "u-boot.bin"

This breaks secure boot mode, needs more work.

Jan

-- 
Siemens AG, Technology
Linux Expert Center



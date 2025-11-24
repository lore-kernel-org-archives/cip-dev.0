Return-Path: <s-adivi@ti.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 287ABCFA466
	for <webhook@archiver.kernel.org>; Mon, 24 Nov 2025 09:31:47 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com (CH1PR05CU001.outbound.protection.outlook.com [52.101.193.65])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12814.1763976703173564145
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Nov 2025 01:31:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ti.com header.s=selector1 header.b=BIRqiFoy;
 spf=permerror, err=parse error for token &{10 18 spf.protection.outlook.com}: limit exceeded (domain: ti.com, ip: 52.101.193.65, mailfrom: s-adivi@ti.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x8GkOa9rJrwmG7y2+n7i041cmXOPc0U727QA63UhxnublVhsePONfv70BHcuMLha1prcgV8aR9vPCu3MigIBSqIP6adx6c/ONlQuFN/bAlaONN7jz4TlZ8C4aIMSZZHUuug8dI26Kx8uiS74J0skujif64W6xGQsZKLlL6iLrReYVtHhKIyuz/W84Tm9N4aOFlkOTDiVwTFfkRa+R87Ome/Qlc2cJYZnBNFuS/btSBJo6B5L0/oq6u4bQxV3+z3Q5pOu+e3lfA8CaxQh1laQvxq/cp2GjkPR9zr0gjcx2KC8/8yurIdBEARKhOdIxcAZFtbLSMBuLEohw1YSdw5+5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z4DoP4wccrbzHcSDZ9JTypjDXm8RfziXgoIT3yzOke4=;
 b=I4D/BPyt8R/PCt2YT5f3SFkFFGXK+n1B+KWFSEPtJAOqpbAbMySa7/q/GLVpUmbP/8kfwxY6zImUBCxx5EN/rXjaTXfpg569nwV8ISiXgicLF9z7LEy+4y5r1KDtXjMI9e9fJeAdnqwTSQbUl102bxyfjqggzWqdA+wARIBwSXGmrDBfY/NW6C6Ts0qnqr1iM+5laUg1tqAi+PewIc1h2DpXHbnvxJyE3JHEWB17QGoVQ1smrqm3m5TZY09LkqyIpAq3Z5wFaLjOo6rQpUmDwkMw0xggAX3RfTDXLFbZqWm2/B+SCITtJN7i57Yli21P8PL/0EN1VWeTtx5CnYsW+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z4DoP4wccrbzHcSDZ9JTypjDXm8RfziXgoIT3yzOke4=;
 b=BIRqiFoyaywcciHc7qg3fe8kNJW9omlB2TDQCa+0gj/ESYZmlcbVBEKCAuR2qdIrIHT5+L2R/AjNHpnlWEIT6MOP3GuKTkl6C4PNrVOpJvEUWqt76Aj6eilHM6G5rIfuj21UA2484ix6UwH48hvD2+EXjSc7tiORpruQirYjJug=
Received: from MW4PR04CA0283.namprd04.prod.outlook.com (2603:10b6:303:89::18)
 by DS7PR10MB4877.namprd10.prod.outlook.com (2603:10b6:5:3a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 09:31:38 +0000
Received: from CO1PEPF000042AC.namprd03.prod.outlook.com
 (2603:10b6:303:89:cafe::a5) by MW4PR04CA0283.outlook.office365.com
 (2603:10b6:303:89::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.17 via Frontend Transport; Mon,
 24 Nov 2025 09:31:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CO1PEPF000042AC.mail.protection.outlook.com (10.167.243.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Mon, 24 Nov 2025 09:31:37 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 24 Nov
 2025 03:31:28 -0600
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 24 Nov
 2025 03:31:28 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 24 Nov 2025 03:31:28 -0600
Received: from [172.24.233.117] (uda0498651.dhcp.ti.com [172.24.233.117])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AO9VQJR1684278;
	Mon, 24 Nov 2025 03:31:27 -0600
Message-ID: <9d4406c8-6599-437a-b4b0-d2f07d6442f9@ti.com>
Date: Mon, 24 Nov 2025 15:01:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 3/6] arm64: Switch to cip_merged_defconfig
To: Jan Kiszka <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
CC: Biju Das <biju.das.jz@bp.renesas.com>
References: <cover.1763399717.git.jan.kiszka@siemens.com>
 <ae9f51993b0cf98e41452074a51cf1a15716f21d.1763399717.git.jan.kiszka@siemens.com>
Content-Language: en-US
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
In-Reply-To: <ae9f51993b0cf98e41452074a51cf1a15716f21d.1763399717.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AC:EE_|DS7PR10MB4877:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ed7032c-f12f-4950-62be-08de2b3c4484
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RlpsejhibEViYmpsWi83WUZVYkQvbXZxbEdjOCtvZDNIUjNVZDc5a3BnZHJw?=
 =?utf-8?B?WFVoTE80djM5TktUN2tKdTJSenpVVEg3eE9pdDFiMHNMTzVvSGg4L2RJajlC?=
 =?utf-8?B?d3dKeWhZdzZ6WFF3ZjhnZytHR25MZ0diQnJVWlVIV1huYityY3lPRmdKS3BF?=
 =?utf-8?B?L3ZlbTRkeUNJRllqSGhnNXk5SkpWTFFyZFlEODhuNW9hK0NUaW5IMFJIcktZ?=
 =?utf-8?B?ZktwSUcyWi9yUEtXNWMyYnJBS0QzQmxtWkFGZGxSQVg5SnhPZnJlZWg1L1FJ?=
 =?utf-8?B?dVUvWHptK2tJMDRtTUZyb0ZYY2I4eFhhOW5oN2RYMkhPNFgxZ0VNcmY5TlFx?=
 =?utf-8?B?ampSKzNRVUhBTnplLzA5RktSbGNNUXdNK1laSWZSQzBhTkU4TE81MTQ4di96?=
 =?utf-8?B?dnR4M3Q0eDhPNURxZDNyaGlKNFplQlVXUzA1MDQvMGgybHBEUDNBc2RKNk9F?=
 =?utf-8?B?NjRHckpGTU94bTdsdForZXlsOUk4N2dZbGRod0Z4QkwzOE9qdHp1ZjBSRUY4?=
 =?utf-8?B?dlBrWkx6d2ZSSm9xZkhSYjRpUnZ1TEpBRFppSHA5VFlFdSt5VEtnby9oUk1x?=
 =?utf-8?B?aDdQMDI0ZTJnUHg2WkxDUVBHeEJLOENhTkNicUhvQlRPRGRQNVA5b09JdCtS?=
 =?utf-8?B?UWNGQ1VaY0Y5am9SZ2l1cnR2em1rVDYzbjQ0UndoMmxUT1V4OURsT1hQQ3VD?=
 =?utf-8?B?N1A4VmZjRkhwWkFpbGRXdXVaaVZ1ZGpvOTg5b0JiOWxvUjVFOGZBb3Y2SWt6?=
 =?utf-8?B?L0MzVnZidU9WS3ZGeGp0bmlKRmlzQmVjaHFSdVQyaGVMbkxEN0hyS01VaUgy?=
 =?utf-8?B?L0dLVkdvcGtJYlNOeEtGcnJnN2xtczh5VDcyckU3eU5USjNkOUhDT2xpSHhk?=
 =?utf-8?B?UEhlT1JkY28vWCs1SGtyR2RWeTd2OHVVem9ISklyZGREYUpIZ0U1S3JsSUtH?=
 =?utf-8?B?MUpqdVI3Z1BLUCtBbHEwaEN0SFlFYzNJbjUyNjdhSFJvUUxUWDI4TE1oMUFO?=
 =?utf-8?B?WmJTYlNqaTdlVkJTWk9LUDN2aXJsZjlEZWFHNm9YaTRJMGRMcnp2Q2V5NzdL?=
 =?utf-8?B?cTNtcXVSQmNwWjhwVEd3eFlrbTBoV1N0Q29TbDNod3lpWHpGYnRxVWdtcU9Y?=
 =?utf-8?B?eXhKcTNycVVGc3psSCtwUzczK0R6MGdLUjZJTXdUbWllR1ZIQkxBbWxFT1BO?=
 =?utf-8?B?U0F1c1dtZE9mR3QwNmREdlZNYVAzZ3p1b2gyNWczRXEySXhiQ2VEL3V2Y1Nj?=
 =?utf-8?B?aHUzMGtjUDVwSmhxUGZnMStPRlNRMTBVSGwvS3JJcmdHY0g5SmZuUnZ5TGMy?=
 =?utf-8?B?eDRvdG9hemFnTG9TUzlwZ2ZIdW9seStkR0FDNGhTRlZ2S3N0cmJpREFiYjQw?=
 =?utf-8?B?ZkxySEQyRjliR0t2NEpJQU43R2FENHFTdW45M0JkeE1DWkVYNUU3TnkwVlla?=
 =?utf-8?B?NzFCOStZTytDcEpmMTNmL0JGcW9zeFEvTzh0b3RRaFlFME1kdXEwMlpLRHNI?=
 =?utf-8?B?a2NJU0pqQm5oRGFPeXlUZXM2UVFLNU5oUEZTL20xMlV2K3ZZSFJFb05BcWhh?=
 =?utf-8?B?bTBIaFd5V25Yby85TjViZTlMY3JqcjFkWkRPcElCR1lsQ3Nwai9mMk53OHJv?=
 =?utf-8?B?QStqS3Boc044UVF2OVBOdklGODFmVjdqVUEzS09mYkNIUzFKYWcyMCtwNGNi?=
 =?utf-8?B?UCtqS1lydlNVT3U5eVF5cWZlWVRXeEZSdE05TDdCSVVSS2FlWE5NMFUzeHhU?=
 =?utf-8?B?MCtrWW0rY2RQYnczbmh3TTVJSmE0MEhxcTI2UUV5QXp1ZzVzNmExejl3eS9M?=
 =?utf-8?B?aXoyUlB0Unc2bHJzbGgrREN2VnNCT1FnNSsyMnJuUmhTVndjbFVRdFBEVGhW?=
 =?utf-8?B?MGtZdTFPMUl3NDRWRm4xRVdEa3MzTXJtQm5PTHpiRitlMng3K1NsYi9tenN6?=
 =?utf-8?B?ZUMxTW5kSDRqdG82UDFHdU5FOGhyZzFYUnQ0d1A0bFVHN1JPc0Z5Q09YNHBu?=
 =?utf-8?B?OFVDb2QvRGFxTHVhVElKZExuS3grZWI4VVhzdGxCODBrdnBMU2NGRXdWbWds?=
 =?utf-8?B?cWlGMys4aXYrOTg2RklCNTZpUXpTbDZMZ25PVW50cVhBb1RtdHRQTFRqL3FN?=
 =?utf-8?Q?YflM=3D?=
X-Forefront-Antispam-Report: 
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 09:31:37.9379
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ed7032c-f12f-4950-62be-08de2b3c4484
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	CO1PEPF000042AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4877
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 24 Nov 2025 09:31:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20703



On 11/17/25 22:45, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Allows to use the same kernel for all arm64 targets.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>   conf/machine/hihope-rzg2m.conf | 4 ++--
>   conf/machine/ti-am62px-sk.conf | 2 +-
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/conf/machine/hihope-rzg2m.conf b/conf/machine/hihope-rzg2m.conf
> index 0b3acf49..485683b2 100644
> --- a/conf/machine/hihope-rzg2m.conf
> +++ b/conf/machine/hihope-rzg2m.conf
> @@ -1,7 +1,7 @@
>   #
>   # CIP Core, generic profile
>   #
> -# Copyright (c) Siemens AG, 2019
> +# Copyright (c) Siemens AG, 2019-2025
>   #
>   # Authors:
>   #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> @@ -13,7 +13,7 @@ DISTRO_ARCH = "arm64"
>   
>   IMAGE_FSTYPES ?= "wic"
>   
> -KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm64/renesas_defconfig"
> +KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm64/cip_merged_defconfig"
>   USE_CIP_KERNEL_CONFIG = "1"
>   DTB_FILES = "r8a774a1-hihope-rzg2m-ex.dtb"
>   IMAGE_BOOT_FILES = "${KERNEL_IMAGE} ${DTB_FILES}"
> diff --git a/conf/machine/ti-am62px-sk.conf b/conf/machine/ti-am62px-sk.conf
> index 589f071e..bf3cf9ab 100644
> --- a/conf/machine/ti-am62px-sk.conf
> +++ b/conf/machine/ti-am62px-sk.conf
> @@ -23,6 +23,6 @@ IMAGE_BOOT_FILES = " \
>       /usr/lib/u-boot/${MACHINE}/tiboot3-am62px-hs-fs-evm.bin;tiboot3.bin"
>   
>   USE_CIP_KERNEL_CONFIG = "1"
> -KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm64/ti_defconfig"
> +KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm64/cip_merged_defconfig"

Jan, I'm seeing a boot issue after this change. The boot stops at 
initramfs with the following log

No tpm device exists or supports pcr_hash 'sha256' or 'ecc' - cannot 
create a encrypted device!

But the tpm2 device is available and the `tpm2 getcap algorithms` 
command confirms that the device supports sha256 and ecc.

It's working with ti_defconfig. So looks like there is some timing issue 
/ race condition when the tpm support is built as inbuilt instead of module.

I'll run some more tests to properly identify the issue and post a fix 
in here or cip-kernel-config repo.

>   
>   WDOG_TIMEOUT = "0"



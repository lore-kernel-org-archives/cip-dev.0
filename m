Return-Path: <s-adivi@ti.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A881ECE8D6B
	for <webhook@archiver.kernel.org>; Mon, 17 Nov 2025 11:13:32 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com (BN1PR04CU002.outbound.protection.outlook.com [52.101.56.16])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6938.1763377995579164682
 for <cip-dev@lists.cip-project.org>;
 Mon, 17 Nov 2025 03:13:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ti.com header.s=selector1 header.b=qcwUhpSg;
 spf=temperror, err=temporary DNS error (domain: ti.com, ip: 52.101.56.16, mailfrom: s-adivi@ti.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hZis9RQs0DE3QCwwVrm4iFtX5QQXrZVyMtSDcXVlPx8l+n4omzl+qwRaa2C/sZ5isahjm6gUoaxCFL/lgwwtRDCU6TAkMxTOQXZS+TBW0KTQUVbIdXP/5VQdjnseXMe3dy7TuvR+njELDEvtQBHcJ1vSqDz4FcL/3QH1YWWZVWuo9BOAlTNmmkG7N3KD1nK8SBMlMNeNUqA6exfgibzpowsPzcusOB1FgxzzZO/+PlEB3id6qm2bgYabZR0FNjAcDgiSAlNXjllIEdwE7rj45EbbF2wEoXIEftKAtowwTb1sSnipoeEZ0gW8291X+iTp6p7hmD6MalDvD5J8U27mlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3zYN/sEV+FvRPM4H1H0uL/3cRju33M/ARbLXBnZK9YE=;
 b=mQvJYep3YG2v3g/9lwq4PPxZGDeJyTg7arzGbouN2VilQk6m2CIeepoBN8JeXPOgh0lfPb9QL2t3Uj8/ylEjE7MOtgpXH0ZLQmIJcPxuKyNj6xGGlJZWJrIwdd/HPP2Pd5JRZD5p7lGnnzalaFh1PTeL6w4dkHx/f/pzrVma49oVMOViLjqQzFEk1v7DB2n+ju+0Xz4UXixa024XfKcL3giXjKik4V+Pe+j3NqQK1dLsSmDtcOyt3Ef8VN6okzTCrbqwBfmCGoulCKAaBHZIn6UfFA6xQy7XYR14Uis6g3m06BsxthNUAs6aFLePWinjjaIE944sMc8humnYzRslYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.cip-project.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3zYN/sEV+FvRPM4H1H0uL/3cRju33M/ARbLXBnZK9YE=;
 b=qcwUhpSgB9xYsbnNLhMJSfeVdGQCuN8JLnOUI2kOxihOz6WPvYmeEGZjJCqQfMuGdL/HiCR1u3thPk2kIzTBDu8KpIpgNO0QiaH3oHq4FTOOB6YWbb81/slvq4o9ElPAkS/C1tsu9OJEbb0StUU7TL4+mrc+1Dtkv4vKAs6DXrg=
Received: from DM5PR08CA0058.namprd08.prod.outlook.com (2603:10b6:4:60::47) by
 SJ0PR10MB6376.namprd10.prod.outlook.com (2603:10b6:a03:485::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.20; Mon, 17 Nov
 2025 11:13:12 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:4:60:cafe::8) by DM5PR08CA0058.outlook.office365.com
 (2603:10b6:4:60::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.22 via Frontend Transport; Mon,
 17 Nov 2025 11:13:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Mon, 17 Nov 2025 11:13:11 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 17 Nov
 2025 05:13:08 -0600
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 17 Nov
 2025 05:13:07 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 17 Nov 2025 05:13:07 -0600
Received: from [172.24.233.117] (uda0498651.dhcp.ti.com [172.24.233.117])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AHBD6Ta2399957;
	Mon, 17 Nov 2025 05:13:07 -0600
Message-ID: <6aacb3eb-9f12-470d-86ad-5ca712f6aaf1@ti.com>
Date: Mon, 17 Nov 2025 16:43:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v5 4/4] ti-am62px-sk: Add support
 for secureboot & data encryption
To: Jan Kiszka <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>,
	<vigneshr@ti.com>
References: <20251114090509.2935933-1-s-adivi@ti.com>
 <20251114090509.2935933-5-s-adivi@ti.com>
 <07b0cdc9-6aa1-4ec5-b9cf-44fcd5a663f3@siemens.com>
Content-Language: en-US
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
In-Reply-To: <07b0cdc9-6aa1-4ec5-b9cf-44fcd5a663f3@siemens.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|SJ0PR10MB6376:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b3f308e-4968-4fef-e97a-08de25ca4bc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SlFhbjZnUENEVjBjSGhNQm9DTzJYSFYyYUs0QWhOZGJodkRPbDVoTG9ZcVpx?=
 =?utf-8?B?TVpWOFAvZzRyQkswZkhOUHRJMm9HeExEcHY0RThuZ1JpOEowSWltbFhBN3l2?=
 =?utf-8?B?L2VzbGtmbWJoazBNeHE4NmN2UnZqUGFlSFZ2V0lKNTNqSG1wUGx3VktCZlRq?=
 =?utf-8?B?RGJrT0Zrdlk5Vlp1U1RFeGdLNjhLdlBpN0dRYXViVURFTDllNmhJUXRpeGlq?=
 =?utf-8?B?Z2RZRDhwbDJ3ck9LeFpwWS9ocE9hUjl0dzVpQmVEbHcxZ3hRQnY2RHo5MXg4?=
 =?utf-8?B?RWpMbWtvb09HRS8rdFFnQ0IwMm5XRUg1NmFSWStKZjVHc3NNcG5yb01Oay9S?=
 =?utf-8?B?WWVDV3VEM2xYVW80QUc5MmVjTndjL3lHR3BYcXhYdzQ4NnRuMUJobE5lclVy?=
 =?utf-8?B?OWNjT3NBeStMcjBqYmZ5YkVqZDhoTEhIK3NSY3ZPTGNkaTQzMkpMZEVOYlRW?=
 =?utf-8?B?eXhjaGZsZk9jWFNQQ3hlWlBGYzhNRlNxZTdNSWVITnV2M2RlS1NKeHc0eVFC?=
 =?utf-8?B?Nmlob0xjWHZhdUttbWRMeEIwQzNTUEVvMzhqUDFEajVvSjcvczNDUmZoSDZR?=
 =?utf-8?B?eVJnemVpazJ2MVIzaFRLV2pBN0RaTVhvYVBXSERuU1JqbkFXc3FzN2xsY2JO?=
 =?utf-8?B?WVorc0pHbDV6YTNRbEJXejgwWDFzaEdJVFVUejVSaGNGS0M0cTBSWklHbkpY?=
 =?utf-8?B?NXlUNTV5eEVuQkU5OUJHOVZ0TkpTUktKUjNOcG81MlJOOVU4RVhWVUdHbjJv?=
 =?utf-8?B?bU1BaU1FYjVKLzJuV3o4VHFqempqS1hSREtiWXdGR1YvMmxVYlBPSFNsRzQy?=
 =?utf-8?B?V2NLNllDcTlsRjZ5VHp0czBiWWlibTBRdEVlRUR1UW5ZZUM4alc5bisvNkQv?=
 =?utf-8?B?SEpaZ2VNd0crZ2owaFM3ODV2U2VtY3lYQXhJQWluNENKV1grZDEyaEYzRjF1?=
 =?utf-8?B?aGpMcjEwNXhieGgxV0tsVm42QzdJMWExcXgxR3hEUTFFRlpJeFdaK1pheVVS?=
 =?utf-8?B?R0kzb0x6QkR3aHhqNDV2WXpNOTVpNGtMbFBNY0x5Y3JMQ0VjZ0s3Qm91N09S?=
 =?utf-8?B?R21HbW9ObXNHTEM0ckppWFlGSGJGWlE2U2JLMkVneVpIYzRvSUw4ajJjQ1Np?=
 =?utf-8?B?YkhNeGZ4L2RXNG8wbkJjRFdDd3NQQUZPUk9SZlFlR3hzZUdTdU5uQzQvMUtl?=
 =?utf-8?B?dlZ1cTNqeGk3R09qRzlIb2V5a3UxVnJvbVBicG5UYVNPb2hyWFJsUEJINjlu?=
 =?utf-8?B?UjlZV1d3d3dRY1drMkxSWFBnMmpMSnhrTlpTWVhPM3l0UkpjUmZ5cm5YclRV?=
 =?utf-8?B?OXZ0ZER1ajhkV3p6dys1V2kyazl4OVZNNmVOZEhCL3ZtM3lJUjh2NnVlZkg3?=
 =?utf-8?B?Ty95Rjg1MVFHeUNtdDdBa040emxDa2svY3Rtam41TzBxeDYzYys4NFVUNmg0?=
 =?utf-8?B?am54Tmhsa3JkTVpYOUZzNEJ0b3BxQlVBU1RQcE02RjJRcXkxRTBoYjQrdUc3?=
 =?utf-8?B?Y0hGMjVhNHZjTmpuQkF5L3FDemoyN0Z4cElTSWE3TVI3ZzE5V3kzeTJjNktG?=
 =?utf-8?B?Zld6L2pvS0R6S25IbHRGdzlJZXFnRzhzOE4xUDl1WkdlR01BeDVxVTB0M0Jt?=
 =?utf-8?B?UTBjVkFNQ2VLbmcvY2tldDF0WldTRXZSeDJMQ1c0MnVQbUQwQWZYK3FNbzlo?=
 =?utf-8?B?SFNVdmJuM2FTWEtraS9qOU1aWnl6Z1NxQ1gvendpSU83c0VXUW1QVDVDM0M0?=
 =?utf-8?B?OWlrc01jRXJvOUZyL3QyclR4WnB2NWtWVGJpQW1yRTFRbjduVlkrZnFibVJo?=
 =?utf-8?B?NmZ2QVBtUWVIdkZicHB4S3BaK0orY0NRcEgrZnBDalc2S3JhYk82b2dqYkts?=
 =?utf-8?B?Q1hENTViM2pMS1ltYUdRazdaRlM5N0NrN1JYUWFJbi9pWXNSY0pGeDYxcnEx?=
 =?utf-8?B?ZFpoVEtzUEQ3TVRjYlNvdU1ta3h6UEJZcG5FVi9McGFFUFlTa1JDcEFsOE9a?=
 =?utf-8?B?a1VvcWMrajY3b3NNbXRTWi9aV2k2Z2lJaUFUa3lxdURTcDBGUERTUU9LUkZi?=
 =?utf-8?B?TzRWQVNRUS9USlU5QTF6SEc3M2VvbStFUnpVNS9JT0cxQU1TNi9Ja1Y4aXdV?=
 =?utf-8?Q?7Yck=3D?=
X-Forefront-Antispam-Report: 
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 11:13:11.7157
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b3f308e-4968-4fef-e97a-08de25ca4bc1
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6376
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 17 Nov 2025 11:13:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20577



On 11/14/25 23:07, Jan Kiszka wrote:
> On 14.11.25 10:05, Sai Sree Kartheek Adivi wrote:
>> - Add new recipe for optee-os-tadevkit, optee-ftpm
>> - Integrate OPTEE-fTPM, StMM
>> - Add ti-extra.cfg for enabling RPMB, FTPM and StMM related configs
>> - Update Kconfig to enable secureboot
>> - Add wks file for use with secureboot
>>
>> Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
>> ---
>>   Kconfig                                       |  4 +++
>>   ...ptee-ftpm-ti-k3_4.8+v1.62r1-48-ge9fc7b8.bb | 28 +++++++++++++++++++
>>   .../optee-os/optee-os-tadevkit-ti-k3_4.8.0.bb | 13 +++++++++
>>   recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.bb  | 16 +++++++++++
>>   recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.inc |  5 +++-
>>   recipes-bsp/u-boot/files/ti-extra.cfg         | 19 +++++++++++++
>>   .../u-boot/u-boot-ti-am62px-sk_2025.07.bb     |  4 +++
>>   ...i-am62px-sk-efibootguard-secureboot.wks.in | 23 +++++++++++++++
>>   8 files changed, 111 insertions(+), 1 deletion(-)
>>   create mode 100644 recipes-bsp/optee-ftpm/optee-ftpm-ti-k3_4.8+v1.62r1-48-ge9fc7b8.bb
>>   create mode 100644 recipes-bsp/optee-os/optee-os-tadevkit-ti-k3_4.8.0.bb
>>   create mode 100644 recipes-bsp/u-boot/files/ti-extra.cfg
>>   create mode 100644 wic/ti-am62px-sk-efibootguard-secureboot.wks.in
>>
>> diff --git a/Kconfig b/Kconfig
>> index d322a94..536162d 100644
>> --- a/Kconfig
>> +++ b/Kconfig
>> @@ -104,6 +104,10 @@ config TARGET_TI_AM62PX_SK
>>   	bool "Texas Instruments AM62Px SK"
>>   	select ARCH_ARM64
>>   	select HAS_SWUPDATE
>> +	select HAS_SECURE_BOOT
>> +	select HAS_DISK_ENCRYPTION
>> +	select HAS_OPTEE
>> +	select FTPM_STMM
>>   
>>   endchoice
>>   
>> diff --git a/recipes-bsp/optee-ftpm/optee-ftpm-ti-k3_4.8+v1.62r1-48-ge9fc7b8.bb b/recipes-bsp/optee-ftpm/optee-ftpm-ti-k3_4.8+v1.62r1-48-ge9fc7b8.bb
>> new file mode 100644
>> index 0000000..2cfff21
>> --- /dev/null
>> +++ b/recipes-bsp/optee-ftpm/optee-ftpm-ti-k3_4.8+v1.62r1-48-ge9fc7b8.bb
>> @@ -0,0 +1,28 @@
>> +#
>> +# Copyright (c) Texas Instruments Incorporated, 2025
>> +#
>> +# Authors:
>> +#  Sai Sree Kartheek Adivi <s-adivi@ti.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +require recipes-bsp/optee-ftpm/optee-ftpm.inc
>> +
>> +SRC_URI += " \
>> +    https://github.com/OP-TEE/optee_ftpm/archive/${SRCREV}.tar.gz;downloadfilename=optee_ftpm-${SRCREV}.tar.gz \
>> +    https://github.com/microsoft/ms-tpm-20-ref/archive/${SRCREV_ms-tpm}.tar.gz;name=ms-tpm;downloadfilename=ms-tpm-20-ref-${SRCREV_ms-tpm}.tar.gz \
>> +    "
>> +SRCREV = "04cbc8a136e8fe6731a536f5fe145e2862feafd7"
>> +SRCREV_ms-tpm = "e9fc7b89d865536c46deb63f9c7d0121a3ded49c"
>> +
>> +SRC_URI[sha256sum] = "7adfa71c4b49affef7d4db2436d8d6b93cdc3aaa9bdc9cf795c0bf7488a4cac6"
>> +SRC_URI[ms-tpm.sha256sum] = "b77d092c0dde362adf6bc88a580ca7c8abe124d69bb734bf28f8904ae30494a4"
>> +
>> +S = "${WORKDIR}/optee_ftpm-${SRCREV}"
>> +MS_TPM_20_REF_DIR = "ms-tpm-20-ref-${SRCREV_ms-tpm}"
>> +
>> +OPTEE_NAME = "ti-k3"
>> +
>> +TA_CPU = "cortex-a53"
>> +TA_DEV_KIT_DIR = "/usr/lib/optee-os/${OPTEE_NAME}/export-ta_arm64"
>> diff --git a/recipes-bsp/optee-os/optee-os-tadevkit-ti-k3_4.8.0.bb b/recipes-bsp/optee-os/optee-os-tadevkit-ti-k3_4.8.0.bb
>> new file mode 100644
>> index 0000000..6e396fa
>> --- /dev/null
>> +++ b/recipes-bsp/optee-os/optee-os-tadevkit-ti-k3_4.8.0.bb
>> @@ -0,0 +1,13 @@
>> +#
>> +# Copyright (c) Texas Instruments Incorporated, 2025
>> +#
>> +# Authors:
>> +#  Sai Sree Kartheek Adivi <s-adivi@ti.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +OPTEE_ENABLE_APPS = "0"
>> +
>> +require recipes-bsp/optee-os/optee-os-tadevkit-custom.inc
>> +require optee-os-ti-k3_${PV}.inc
>> diff --git a/recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.bb b/recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.bb
>> index f8cd973..e73a7bf 100644
>> --- a/recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.bb
>> +++ b/recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.bb
>> @@ -9,3 +9,19 @@
>>   
>>   require recipes-bsp/optee-os/optee-os-custom.inc
>>   require optee-os-ti-k3_${PV}.inc
>> +
>> +# StMM integration, required by UEFI auth variable management
>> +DEPENDS:append:optee-with-apps = " edk2-standalonemm-rpmb"
>> +DEBIAN_BUILD_DEPENDS:append:optee-with-apps = ", edk2-standalonemm-rpmb"
>> +OPTEE_EXTRA_BUILDARGS:append:optee-with-apps = " \
>> +	CFG_STMM_PATH=/usr/lib/edk2/BL32_AP_MM.fd \
>> +	"
>> +
>> +# OP-TEE fTPM integration
>> +DEPENDS:append:optee-with-apps = " optee-ftpm-${OPTEE_NAME}"
>> +DEBIAN_BUILD_DEPENDS:append:optee-with-apps = ", optee-ftpm-${OPTEE_NAME}"
>> +FTPM_UUID = "bc50d971-d4c9-42c4-82cb-343fb7f37896"
>> +OPTEE_EXTRA_BUILDARGS:append:optee-with-apps = " \
>> +	CFG_EARLY_TA=y \
>> +	EARLY_TA_PATHS=/usr/lib/optee-os/${OPTEE_NAME}/ta/${FTPM_UUID}.stripped.elf \
>> +	"
>> diff --git a/recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.inc b/recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.inc
>> index 444f6b3..5ee5020 100644
>> --- a/recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.inc
>> +++ b/recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.inc
>> @@ -21,7 +21,10 @@ OPTEE_EXTRA_BUILDARGS += " \
>>   	CFG_ARM64_core=y \
>>   	CFG_USER_TA_TARGETS=ta_arm64 \
>>   	TEE_IMPL_VERSION=${PV} \
>> -	CFG_TEE_CORE_LOG_LEVEL=1 \
>> +	CFG_TEE_CORE_LOG_LEVEL=1 CFG_TEE_TA_LOG_LEVEL=1 \
>> +	CFG_CORE_DYN_SHM=y CFG_CORE_HEAP_SIZE=524288 \
>> +	CFG_REE_FS=n CFG_RPMB_FS=y \
>> +	CONFIG_INSECURE=y \
>>   	"
>>   
>>   DEBIAN_BUILD_DEPENDS += ", device-tree-compiler, python3-cryptography:native"
>> diff --git a/recipes-bsp/u-boot/files/ti-extra.cfg b/recipes-bsp/u-boot/files/ti-extra.cfg
>> new file mode 100644
>> index 0000000..faff390
>> --- /dev/null
>> +++ b/recipes-bsp/u-boot/files/ti-extra.cfg
>> @@ -0,0 +1,19 @@
>> +### FTPM + RPMB + StandaloneMM setup
>> +CONFIG_TEE=y
>> +CONFIG_OPTEE=y
>> +CONFIG_OPTEE_SERVICE_DISCOVERY=y
>> +CONFIG_TPM=y
>> +CONFIG_TPM_V2=y
>> +CONFIG_CMD_TPM=y
>> +CONFIG_TPM2_FTPM_TEE=y
>> +CONFIG_CMD_OPTEE_RPMB=y
>> +CONFIG_SUPPORT_EMMC_RPMB=y
>> +CONFIG_EFI_MM_COMM_TEE=y
>> +CONFIG_MEASURED_BOOT=y
>> +CONFIG_CMD_NVEDIT_EFI=y
>> +CONFIG_CMD_MMC_RPMB=y
>> +CONFIG_EFI_TCG2_PROTOCOL=n
> 
> Some of those are part of ftpm-stmm.cfg which you get anyway. Maybe you
> can drop them in a follow-up patch.
> 
> Then you don't need TPM support in U-Boot for our integration - or do
> you have scenario for that? Doesn't do any harm, just curious.
> 
> Did you already test if measured boot works for you?

I've enabled TPM support in u-boot because measured boot depends on it. 
And no, measured boot is not working yet and it's still a wip. Do you 
want me to remove these configs and re-enable them with measured boot 
related patches?

> 
>> +CONFIG_BOOTCOMMAND="setenv pair_rpmb_key 'setenv -e -nv -bs -rt pairing 1; setenv -e pairing'; run pair_rpmb_key; bootefi bootmgr"
> 
> This looks suspicious on second glance: pairing with the RPMB should not
> be done in production but via a special firmware. Critical here is
> optee, but I see that you are not setting CFG_RPMB_WRITE_KEY=y (unlike
> we do for testing of qemu-arm64). Still, do we want that code above in
> the regular, secured, likely signed firmware, even though it should
> never trigger there?

you are correct, this is a leftover from my earlier experiments. Will 
post a patch to remove this line along with the redundant configs that 
you mentioned above.

> 
>> +
>> +# workaround for v2025.07
>> +CONFIG_USB_STORAGE=y
>> diff --git a/recipes-bsp/u-boot/u-boot-ti-am62px-sk_2025.07.bb b/recipes-bsp/u-boot/u-boot-ti-am62px-sk_2025.07.bb
>> index 8fecee8..b97b70f 100644
>> --- a/recipes-bsp/u-boot/u-boot-ti-am62px-sk_2025.07.bb
>> +++ b/recipes-bsp/u-boot/u-boot-ti-am62px-sk_2025.07.bb
>> @@ -20,6 +20,7 @@ SRC_URI += " \
>>   	https://github.com/TexasInstruments/ti-linux-firmware/raw/refs/tags/${TI_FIRMWARE_PV}/ti-sysfw/ti-fs-firmware-am62px-hs-enc.bin;downloadfilename=ti-fs-firmware-am62px-hs-enc.bin;name=am62p-sysfw-enc-hs \
>>   	https://github.com/TexasInstruments/ti-linux-firmware/raw/refs/tags/${TI_FIRMWARE_PV}/ti-dm/am62pxx/ipc_echo_testb_mcu1_0_release_strip.xer5f;downloadfilename=ipc_echo_testb_mcu1_0_release_strip.xer5f;name=am62p-dm \
>>   	file://rules-${MACHINE} \
>> +	file://ti-extra.cfg \
>>   	file://0001-configs-KASLR-OPTEE-RNG-support-for-K3-devic.patch \
>>   	"
>>   
>> @@ -56,4 +57,7 @@ do_prepare_build:append() {
>>       cp ${WORKDIR}/ipc_echo_testb_mcu1_0_release_strip.xer5f ${TI_LINUX_FIRMWARE}/ti-dm/am62pxx
>>   
>>       cp ${WORKDIR}/rules-${MACHINE} ${S}/debian/rules
>> +
>> +    sed -ni '/### TI extra config/q;p' ${S}/configs/${U_BOOT_CONFIG}
>> +    cat ${WORKDIR}/ti-extra.cfg >> ${S}/configs/${U_BOOT_CONFIG}
>>   }
>> diff --git a/wic/ti-am62px-sk-efibootguard-secureboot.wks.in b/wic/ti-am62px-sk-efibootguard-secureboot.wks.in
>> new file mode 100644
>> index 0000000..52fcb09
>> --- /dev/null
>> +++ b/wic/ti-am62px-sk-efibootguard-secureboot.wks.in
>> @@ -0,0 +1,23 @@
>> +#
>> +# Copyright (c) Texas Instruments Incorporated, 2025
>> +#
>> +# Authors:
>> +#  Sai Sree Kartheek Adivi <s-adivi@ti.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +# Boot partition containing Bootloader binaries
>> +part /boot/firmware --source bootimg-partition --fstype=vfat --label firmware --active --align 1024 --size 16M --overhead-factor 1 --extra-space 0 --use-uuid --part-type E3C9E316-0B5C-4DB8-817D-F92DF00215AE
>> +
>> +include ebg-signed-sysparts.inc
>> +
>> +# ABROOTFS partitions
>> +part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
>> +part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systemb
>> +
>> +# var and optional home are extra partitions
>> +part /var --fstype=ext4 --label var --align 1024 --fixed-size 512M --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 423f0a2e-b9b3-4615-85be-2a4261fa32d9
>> +${WIC_HOME_PARTITION}
>> +
>> +bootloader --ptable gpt --source hybrid-boot --timeout=0 --append "rootwait rw console=ttyS2,115200n8"
> 
> My questions are comming late, so I'm taking this as is. Please try to
> follow up on the points I made, patching on top where needed.

Thanks, will do.

> 
> Thanks,
> Jan
> 


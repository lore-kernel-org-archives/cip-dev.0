Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1BC1C001DB
	for <webhook@archiver.kernel.org>; Thu, 10 Aug 2023 10:36:45 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.58])
 by mx.groups.io with SMTP id smtpd.web10.14201.1691663803059014119
 for <cip-dev@lists.cip-project.org>;
 Thu, 10 Aug 2023 03:36:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=NcGpbnxj;
 spf=pass (domain: siemens.com, ip: 40.107.241.58, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IxrhsmOpkEhlHZTzPJ+niY5Y4obdwelnJx4tTKUx+rN6+HoSkg714e4mW7qjKf9A4Pbaj0oEPlcjDLREd+brr9ctteq4GAEMu/UdN0xHOqd3nc4/bgK+IGEGtSRcB93rON7L9qenRQ8cKsxIi1ymrtWh8A+qczO29krxlVeOab+2JYeU3ovmlEtIMA0Y979/6dC5PykM6tZCsucuzpddSCf9ppVq5HocO4gE1AKlZ4YfFc9BTPxx56GKr8UNbK1Fof7cVUfb5hVnyIC6EXS9agE796LWYGMP7/aLeCXAtpxkngJxBNyPuCJchXzWx1hdfzZxeT+Klta8HA0W0wu7yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w+nWt+CD2lYscxCWSr8jK6UqbiLGuaZ1vYWTzlLowZQ=;
 b=lsx8s6eOPLIQadBRyfzIiuWwUSRQoaOqFB17WAzWIE4TnR/SYmraLH4Tp85jlUkpHBEIq99fsSouG5wRY3BzCq80798e3HNjCt9MT9UDvjgKTjP256DAXDkx4VfX/rs9CNkiVeiJiNmSzZ3/Of934YFRr4ASyi8HfUJ97/83QvknsZcld1kwb1eTx0IULutGIozO2CBaixRynic70U9RYbhA1SzeDxmxojd8DGFTLeRuX1Y/N+HNwKCNxf9+/Z+Uiu6u4NY3A8WCdIc4CdeR+Vxqyb7E5Jnrtk/0pvmmkKJOCjYVVYm4P3EW+B77LOXmg9MLR+dcvL342veTUErT+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+nWt+CD2lYscxCWSr8jK6UqbiLGuaZ1vYWTzlLowZQ=;
 b=NcGpbnxjkNvIkjmP3UJdJJUd+pLVrSIcHpohrhygR+MNmAoZ3V+Bz2E/8Gw490BtMK72XVh+DNjf9o+Gg6p1hBJ2e98Up0M2hHLK78N4yHgmcy7JadWj9GIkf3pkGSFuHrSCAP5CRosy8b+kxC9V5JwgUwZLCMs4LAplsoDktFbsJrrgolHVO24loovrfbVLqOQPGkirxHLbQC8sPI4WoAmC6uO0FakaZNIKCNjivIMqsXmKLAhaXcJq9nOe5eTCnJ9ZPQ1oJ+6n+rmySKY5ny8k9yaeGXnZOW17mDN+M8EwWSvXS3XUOD4V2OFsoK0AJu+BFYvJ+2QpYa6pqNRQwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAXPR10MB7928.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:24e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 10:36:39 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 10:36:39 +0000
Message-ID: <15101ae1-62b7-47fd-808d-501433da81f1@siemens.com>
Date: Thu, 10 Aug 2023 12:36:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 3/4] initramfs-crypt-hook: Avoid calling of
 tiny mke2fs from busybox
Content-Language: en-US
To: "Koch, Stefan (DI PA DCP R&D 3)" <stefan-koch@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Cc: "Storm, Christian (T CED SES-DE)" <christian.storm@siemens.com>,
 "Adler, Michael (T CED SES-DE)" <michael.adler@siemens.com>,
 "Sudler, Simon (DI PA DCP TI)" <simon.sudler@siemens.com>
References: <20230728143320.3891194-1-stefan-koch@siemens.com>
 <20230728143320.3891194-4-stefan-koch@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230728143320.3891194-4-stefan-koch@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0247.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAXPR10MB7928:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fcf41d0-5d34-468f-680a-08db998dadfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	aNdCMx+FOVAv7t1439JC9hrq5RHisGCFNwEBN923b31XzX7WrSoYfvaJAh9gYF0LeH4Cro6A06Su2A0HscbV/R0GyXf6iMwBjLdvMPB1X4jwS8fELj5PSgSfaVlRpl7z1ey4G8kyJ1gm7irpN37hOMQLgqycW+zHgxoC3fSH5T5uQIwPxXXNM1lZHf8+//AuvZyQFOsNc7IgFF7zGSrFCKzS680Ac3tlU1QjTi5msK6GbALHepw/dw7G02bqi1nf27smxb7sQ/rIj5U1ZPelfHrT6QEm7iFDAm7wL/kvjUripADhjyH2/5w6UsMh65HPUcVWgjj5uGthWOHIQOdFWNlKfFYZQ+c1VvWYtf/XcfIEPNwSp0jLLF0Esu7BG+koykiLOANrDsQD5drmtbxJLomOQXf2/V/NA6/RgWxYRO+qbgpTMciqS0h8nP/EMr7eQn/Ue6K807CclNUFV8YYwGSFYikmPNsN0k9v4H2ykgeZpfcnnOTOSCI/rsxsiih52Xm9Wd42Q0F9y4BH75khIYveKtutSnoc/yDsoUrYy7WXvUKRtP5XjhNFn4b9vODQ3Hby7NLRPpV8juJyAQZ4vjlrhQ3jh/SUJSZ4TJdkNGsNq3hiOZZoTluJwM7yNBdb6K5laHQfNpn5KvCmbn+arQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(39860400002)(366004)(136003)(451199021)(1800799006)(186006)(2906002)(41300700001)(316002)(44832011)(8676002)(8936002)(5660300002)(36756003)(31696002)(86362001)(110136005)(82960400001)(31686004)(54906003)(38100700002)(478600001)(2616005)(107886003)(26005)(53546011)(6506007)(6486002)(6666004)(6512007)(4326008)(66556008)(66476007)(66946007)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZlhoUlh5U0pJZDlwdXVqdGRpRkRLczhLeCtORjZjclA4NXNzQmptYkN5dC9u?=
 =?utf-8?B?VUdQN01oL3BPMHBVQ2hoQ2hWRDdUQ0RxTVJydHNQZXpkT0d2TWtUYzlTQjJX?=
 =?utf-8?B?UGFQWnRlM1p4M2V2QXJmT0dSZTdrc2lUNjNweFlvdUdvZzlwaWhxOG1tdzBY?=
 =?utf-8?B?Q0lHQ2lJekozcjNlcURUbFMvaktiazlwaXNjbG1DN2JydFdPVzVNM3lXTUpQ?=
 =?utf-8?B?NnQrV01IcFBNTWJKc2IwU2JEVXJNblRZSlU4cm8zc3JiNHlrYUZINGhFSUtZ?=
 =?utf-8?B?TjBieTg1YmRaQkd4c0lkeGFDR3h5SGpqamxPRlZ2Z2tZcTZKemsxcTN3NEd5?=
 =?utf-8?B?aUFOaWtWZmxYWEc2UTBRTGFyQXBNcjNqWHN1L0tINTFONC9TckErMmRxZXB0?=
 =?utf-8?B?aWNkRUFxRmxYQm1oMkdNbUVLTDhzSkpCLzJKWUE1bmlXUVF2cHEyQXgyRS9C?=
 =?utf-8?B?dkh1aGczVmFmU2NxaVNoQ1JLTGkyck9qcWd4REFrQXhmQ2FVS3h3d1VHQ2dD?=
 =?utf-8?B?YzcxMmxqeDcyeUc1TG8rOHZscVEzT3NTa3pSZ2VWeXg0alNkbzVzbFNUdExu?=
 =?utf-8?B?Q1FEY1pKVXFtaktoV2N5Smo3eCtDcUthT3NocFAzdStIMjg3VDhFbHZ6MFA3?=
 =?utf-8?B?VjBHVFlxVXJmMHBJOFhWVkRSMnlkUVRIUUtuaDVNSEFGRjJaSGtPMmpEamdK?=
 =?utf-8?B?M3BxSVRacmowU0JaZitIUDl0bE9STkp0QzlGK3lxRmZQV1ppcWpkTlE3Rytq?=
 =?utf-8?B?SDZGY1o0WHl4RnZSdEh3Q0l3Z2pWQ2hNS3NWMjcwV3FrRVVuTTB3SWp1bmla?=
 =?utf-8?B?NFFNWW95TkZ2dEl1eHNGdmxxc0Z2Q1lsLzQ4SWszR3lMYjhmcFZzMFd4b2ds?=
 =?utf-8?B?ZjNmS1A3a2psb0E0cGZvMW9ySzJyTGU0cjJDOVh0WW41cjNnNFZYbDRxUWR4?=
 =?utf-8?B?RFRDdVVKTEJ5M1A4YVQycmJlcytlcnMxYjErdkI2azdaM21Fd09qRldYRnlq?=
 =?utf-8?B?NXovQ1FKKzE0cVM2YW45MUZod0VONHFIVFVIRkV0VldFbm8xMlArMXE5RGRS?=
 =?utf-8?B?ZEJiV2pYWU40SjkxNUpXM1RrOCtKVDVPZ0pYTHlvS1RtMHlqSVhTbk8yWVBM?=
 =?utf-8?B?OWlJNGNVWTZzUkY4dW9obzF3NzRmYXlaM3NrRCtlK2NtRTlVZUFyYnlUcU4r?=
 =?utf-8?B?TnBHS0k2MVdPaXFmN0E0UlhuL1c4Y3hTRHVST3crRlhRZE5vMVB1Ky9zNi9Z?=
 =?utf-8?B?WTRTbXZWTXQrMitpNXNhMXpRdnUwcGY3aXlsa0RBU1UyeU96SWRtS1VuSnl1?=
 =?utf-8?B?bUxCbngyV3hOSi8vNXU4VjRTamFDcHMxRm13akp2L2NXTXlibTJGaEVZUTho?=
 =?utf-8?B?NWtBbW9jNDRNNjV0ZDhPZFJjcUhKaHczSVFZbm1sRlpaN1U1UFVORklITkZW?=
 =?utf-8?B?S3dkclBXU0dYbnhxTndyRy9vd0d6UlJGN2hIZ0VQbmVSNExZSTJuVFQzU1pv?=
 =?utf-8?B?WlZwZDFCNDdCNnhSblZIdWVpMFJtYk90R1BwZG5qQlRHNXp3aStQOVQ4dCtI?=
 =?utf-8?B?Zkc3SWFrMmlWNUc2RXhxV1A2dlhMNnJSYXNmRnF1R2dXSE9Vbm5CZ3JRU0pz?=
 =?utf-8?B?cDVPTFJSamlGajgwbEt5a0RrdkdOeVpFalNSVEhrQm92QSs5QWRZc3NPeWh3?=
 =?utf-8?B?N0tJWXZITmthRFZWaEhmZ0JJR0Fmd1V2ZjQ2WTB6RkZmcEV2dEFELzZkZXY4?=
 =?utf-8?B?Ui9mT1lhdG9ISEd4WXhUcWNFTFcwS285VVV3ZHdwaWQ1S2NOWUF6Q2c0bVJS?=
 =?utf-8?B?WTRnUHFlVUJWRnJqRFlHNWJqNGdGcnZWNVRZa1dFaitRdW5URlJnamd0c2pS?=
 =?utf-8?B?UWN5RXZVTXR5YXFkeGgwQno0cGhVb2NMNlBIZ1RTNFl1K2tFR0xRaE1jbFRa?=
 =?utf-8?B?eHNWMFFBUEg1SGIySVRQSFpZOWJBVU4rNHhtaXdZOUhDSFBhU211V0NpYUNy?=
 =?utf-8?B?YjA2MWk4Sk4wNURSOTBrcFVqSFBwbnRJMmFISTM3REdERkFLZzl3aHlvRHND?=
 =?utf-8?B?WXl4U1pHWHJiZzE3MWZVRTJpRHJ6dzZnaU9DcnMvNkhMY3prbnZzbUVMY0Fi?=
 =?utf-8?B?ekdYZ0F5eDQ0VHIvbWh5WTYvK1kzZHkrYmdxeWxzVkcwbGp3Qk1ob09lSmRh?=
 =?utf-8?B?ZkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fcf41d0-5d34-468f-680a-08db998dadfb
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 10:36:39.2345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RVlqxJaAwzUEQbc6ipYogcq/HgFJBO50LHpXW9N9yDVNcRB2jI4k4OQ3QM3VmXtlWiUfgNEp1UrD+YbNioKxLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB7928
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 10 Aug 2023 10:36:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12591

On 28.07.23 16:33, Koch, Stefan (DI PA DCP R&D 3) wrote:
> The tiny mke2fs does not support the used -t option.
> 
> Signed-off-by: Stefan Koch <stefan-koch@siemens.com>
> ---
>  .../initramfs-crypt-hook/files/encrypt_partition.systemd.script | 2 +-
>  .../initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb            | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
> index b32b2f2..4e04d37 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
> @@ -42,7 +42,7 @@ partition_sets="$PARTITIONS"
>  create_file_system_cmd="$CREATE_FILE_SYSTEM_CMD"
>  
>  if [ -z "${create_file_system_cmd}" ]; then
> -	create_file_system_cmd="mke2fs -t ext4"
> +	create_file_system_cmd="/usr/sbin/mke2fs"
>  fi
>  
>  service_watchdog() {
> diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
> index 1c1bf3d..3c3f6bb 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
> +++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
> @@ -32,7 +32,7 @@ SRC_URI += "file://encrypt_partition.env.tmpl \
>  CRYPT_PARTITIONS ??= "home:/home:reencrypt var:/var:reencrypt"
>  # CRYPT_CREATE_FILE_SYSTEM_CMD contains the shell command to create the filesystem
>  # in a newly formatted LUKS Partition
> -CRYPT_CREATE_FILE_SYSTEM_CMD ??= "mke2fs -t ext4"
> +CRYPT_CREATE_FILE_SYSTEM_CMD ??= "/usr/sbin/mke2fs -t ext4"
>  # Timeout for creating / re-encrypting partitions on first boot
>  CRYPT_SETUP_TIMEOUT ??= "600"
>  # Watchdog to service during the initial setup of the crypto partitions

Do we have both already? Also in case of the isar-cip-core generated
images, or only with additional customizations of the initramfs? Just to
understand when this issue is currently visible.

Jan

-- 
Siemens AG, Technology
Linux Expert Center



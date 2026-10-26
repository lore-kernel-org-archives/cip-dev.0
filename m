Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.35327.1792986223863830468
 for <cip-dev@lists.cip-project.org>;
 Sun, 25 Oct 2026 20:43:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ZObHDIBC;
 spf=pass (domain: siemens.com, ip: 52.101.72.42, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TtHJqQBsl/9+jRRTPvbdOoHQ2sypt1ei+CITS80QAm43x1O6aAuwlZwXuUeLqdYhuUqBWfLPQIlsdfAaM1eNpYLDIh40B/dg45/11C8585wiM0Ob9oQA16Xd6J+ArsPKXVRgG/Fe+EedIZ2mu3KfLzTQ0COMbn2ij6/+lf+l9tptsKcJD0M4ZEE39Wp66hCL1lyOhTpFr9tTn/57Rj1EtBdBlOW5LEpRDoi0UpD0yw1fWBiyo42o8Lmb7Hg7k1mPLMbIYFPT2apzJnp+RvNjlbguWfGGyx2dLu4sZe+IfxSbyVBX093hLUYs2m9vkOs0zcI31SipRr0UbiFT2/i6Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x8UjBlQ/qz+dlNPfMKNtOssb9ic09K24qZeII4PbWwk=;
 b=K/1XehdRwmhYff/mDVJZn4QREHtfIwLAGAcnrTtm/pCU/EyBBLJ8E3EVkc3UxgxweLE4cHWMlGPJho/J9pNbKB4ptP2y4tnBRERUyfDsWWrf1oVJ2QloqK0MxhKkZW4tBRBCVIvKWyAq9ItSfgn5afPeWq1Xet6jQfWHuVMnab+XdSB78xpRXwpJH4R17LFUK9bc1yhcIG2rt5EdVa8WofC8ir/+NQ2+QZIVcuuUh8lnxfQ3KpsPipW3JnK3KIyzgX5OjF0UHwscNDwg4YuZMhX1zuQ5C7XgFSXhr1fDDJ+wZjrfNLl4Bn1DzFCmlL+8WHr9s9V4S0fH/cHv0hjQYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x8UjBlQ/qz+dlNPfMKNtOssb9ic09K24qZeII4PbWwk=;
 b=ZObHDIBCnn7TtLtiqQEtEfQ+Ro4uPf9AEBbCES4NcAV8DP6RaInj77y8OAVrtve4NqAMZfrJza3DnvQmi/C0kPI3u/cxdK+kJnRGt2Mre7Lln0J/+yiOX+agmechfBg3UaZ8Bwr6VMi5s+9RWTJdQumzM1v50KgzmhyejeiaeL/AW1IFKOfGNGkglEhn/eHN6zJ2Msr0BQulA3N3OUQfOXWsL1qK6QzNaOZNiuJZwcvBn9zPS5MeU/LMoOtscrY2if11KtdZTQDH/u4CyfMlwkIkrqa9ztk533fqx/pT5ymorOUz7CQFx+ZoOfcOgURLHQ5cnCWKZz2WiR8j4ECcVA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by VI1PR10MB3184.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:12f::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.6; Mon, 26 Oct
 2026 03:43:39 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0569.006; Mon, 26 Oct 2026
 03:43:38 +0000
Message-ID: <eec14acf-dada-4dd8-9245-6d29187a653b@siemens.com>
Date: Mon, 26 Oct 2026 11:43:31 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] README.tpm2.encryption.md: Add additional
 information for SWUpdate case
To: shivanand.kunijadar.v45@mail.toshiba, cip-dev@lists.cip-project.org
Cc: kumar.dinesh.h95@mail.toshiba, kazuhiro.hayashi.f74@mail.toshiba
References: <20261023044623.3269357-1-shivanand.kunijadar.v45@mail.toshiba>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20261023044623.3269357-1-shivanand.kunijadar.v45@mail.toshiba>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0125.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::19) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
Return-Path: jan.kiszka@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|VI1PR10MB3184:EE_
X-MS-Office365-Filtering-Correlation-Id: 08797b14-5fb0-4b74-ab1b-08df3313522f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|11063799006|56012099006|261021121427099003|261022105027099003|261009223027099003|260925021911599003|260925021311599003|260925022911599003|10067099003|55112099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: FgFqfBtoSLp6fSWzf35Tk+/OYRdd46vIs3HpGiqfSl4DeRZ2aQYTGzWhY55YB/uytRXQMjpUM/9TjXvUbJ5EV4cMlzSJLncYs7aCPJc2lYawCiTHxNB8t+U/pFbdl23KQqmnkzGNtS1tas9VddCeCYJ458jjLFe7kx00MAZiyMCaC95bqMIAhmnG1+oTZxbs+LQlmA60c+NOrtYfJ4N5ZVQwUo44RizJBcP5wT1Qh+oAGi/xB578ZBZZbNIIe7zOnIq+cC67vb/IHcvtZ1B/pm5rUDgyrb4oD1QolTT3l+4jBJkEnc9fjhtD6jZL+bqYfMYKmY9FYLgSJcxEDrK9s8PzXCqc3lzDzYMBW+Yu2aiSvtF3fWx4AkkRKFF8uts327+N3ek8X1Vqz0aIeuiE/FlegE33YTf/GgaWdDNpBalRedjMfnqFwW5TEoJ+5yzSHwf1gmaPMeoKQ6zjGJ03V7osyuXFWaWiUHQhcbCF2jdnfZFLfbL8rEfMFIv0I7PsmrTOFaJ1y8W1amWVnSk8jnRS4TL/vjaZGtd+7zkYoIIlaauAORYbx5h61Xoyrv6hHgdsbS1RzGULMG2oSqBAih1KHwV7V3LBdyk7CXTtQNIpMFs9kedi2pma1IGZkQJyUzba8qZdaAGMjou9x0OIJLFlsvHcowJchciAuxjXDos=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(11063799006)(56012099006)(261021121427099003)(261022105027099003)(261009223027099003)(260925021911599003)(260925021311599003)(260925022911599003)(10067099003)(55112099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0JuWjhtQk40Q2pMSkNidFdGZDkwVVVtc1BLdDNQN1NhYVdaT1ZhMTRZYndF?=
 =?utf-8?B?V0l2NVliYTlLcFRHTGhGR2RESjVjejkrVkRmVEMzcDEvZ09BdGJ6MGJRcUJO?=
 =?utf-8?B?WWJwcEZDaHBlYitsRTJXVTdjTDRwcXNidHZCNnB2STc3L24rOUR6alZkd00w?=
 =?utf-8?B?TlkyOHB3S3JlQWMyeDFBUlNWaUl5SjJyTUVaTVd0dU5WUXA5NEU0dEdHa1d5?=
 =?utf-8?B?ZWhnOWFkUTkybGtSSCttVUFHT1ZrU3lWSzNBeTc2bFJjRms1OGdKUjl5UTRU?=
 =?utf-8?B?ZTA4aHpUNWpQeW1RWlltc2tBSWcvVUtEQnIzQUxYSEJFWTg4Z1BXTVBDTGZN?=
 =?utf-8?B?b1g2bG5ncXVtMVlZUEtPbVNZVGRqZjExNG1xY1dHclVvZ1lGQ3o3VTJOYm9x?=
 =?utf-8?B?OC9aaGcyc0t0a0hoZ0FyYkVxSEpVdkR5dm9SRG9EUGRaWVRHMUY0ZjB5QklO?=
 =?utf-8?B?dlI2VC8vVzh3QVdpQ0kvVk9iaDBvd1htelorTmNIc2J4QnVRVS9rYTVnRGdk?=
 =?utf-8?B?dHMvclJLa0VHbVo2VHNlK0dMQnVzSDRnSzU1bU5DSUNYUlZFUmJQSjQ5SXFo?=
 =?utf-8?B?eEZ4NFhwbkpSTWdFUlI5dDJjRnd2L0puM05XVTFlL2NHc1VTTTJKNjhxSEJl?=
 =?utf-8?B?N08rWFhxRDVuV2QxLythZHEra2VKeEw0VUw1K0ViVkZQaW52dWpPYUpzbWlF?=
 =?utf-8?B?RWdLOW1jL085ZlY3c25GemNYN0VZbDdndm5OODlNRlNJZi8wZTg4L0s4Yzdy?=
 =?utf-8?B?aFNFOUs1YXpsaEhrNUxKQWFja2FYOTEvdWtiR2dOcmxqQmJianFKMWNzczB6?=
 =?utf-8?B?dHVGMGQ4RENTTnd0MHg4K2NjYXRzWjNHV05od0YvWFF2am53Ymh6WGw1Q3BK?=
 =?utf-8?B?REgvQWdYQ3VsYnRmQkRlaXZrRWFqSTBpWkY5bVhxSms3ZTNtNUNlYXdQaWd4?=
 =?utf-8?B?WHRMSWRySmFBeVNBRnpYSDZuMERhME9YMWM5MHVXbTA5Um1qUFYyZDdTOGV3?=
 =?utf-8?B?RG9pbTBpMlFqSVQrTEVzS1lDak5zem55WFpnOGNwVzBMbmlab3ZzcnZ5c0pM?=
 =?utf-8?B?bWJ4N0lwS3pPRDRwcFdLQ2tIdWwveXFPaFlrS2IxVlBqNk1xYzlyZkxIRkI4?=
 =?utf-8?B?MnF1SjI4aWhtVTVONFJnTUZFcVROSWlZeWE2RGJoZGpoTEFYdFZzZjJPK0th?=
 =?utf-8?B?TGhBWGJkV1NwYUt3ZzRjdjRPY0lKYkVYbk4yTWt2RUZqQUIrNVVUNFJVRHRk?=
 =?utf-8?B?MGN1Z3hLV0R2d0ZjT1c2UUJsYzF2TkdDWXZyTG1pbFpJTk1iSVhNUmhnRVJj?=
 =?utf-8?B?akh2STZ5c2p1Ulg3MG9GZVF1d0MzNkNxVkJKYzhxVHZBeG56VWEwWFhDNUo5?=
 =?utf-8?B?QnZrU28rak90ZnpYRm96dHpvaDhuVnBZOExyYWM0YU80VmMrbXNqdDFaVUZ1?=
 =?utf-8?B?U3dkekl5aStzeWJ2aFdsLzhwRDdoYTg5SUxKNW1SQzdrQmhEOXI5SjVEZjd4?=
 =?utf-8?B?QktIOXo3YWh4ZE5jV3VBSUZCWU5YNzc1YTVqMXJNN1NUYzBpYVR5aktobGFw?=
 =?utf-8?B?eU8rbCs1VVFFbENzV2dqT0llOHNHWXMzbGprQ1BaMkI0ekNjRzN5d3NxaGs2?=
 =?utf-8?B?OWFYRG9BenY4WXo3UWJ3K3RHYnpKeUlyd08vdk83TjVxWVdMMDU5VXIxdjZ1?=
 =?utf-8?B?eTg2dkZCNW80SDd3R2czUnNJYnUvcWMrRjVMVW52NENHS1dRcjE0c2FDWi9s?=
 =?utf-8?B?bThNcU40WnZyUUNCa1FIb1pLaHl1VTNqdFIwN05ia29lS0pmdXBZQUROWmg1?=
 =?utf-8?B?cTdlS2RLR0JlYWVKcjdIK3h6ZFVZcENiSzZYM1RUZkdGL1lGYi95amptdDVa?=
 =?utf-8?B?dGxySm9xbHZSdlpqTXkyT3M3TU1zNnVFOHRJR1EzNDNweEZFN2k5djRoMUxY?=
 =?utf-8?B?aEJrYkxWZXVRSnExZm9Mb04va2FtVjFET0VOa25hTURPelhxZHI4NWFTYXVO?=
 =?utf-8?B?M0ZQZDNmMk5FanF1ZFBrUy9xSlhpNFE4aFVOa1Ezazk5V0VHa01HUllFRzdj?=
 =?utf-8?B?S1MrWmJqVGVXR0VkSHMyQm84T09UcmZJL21vMWpLRVU4bkFEQXIrNnhEOFJD?=
 =?utf-8?B?Ky9BeFJpaEhMVHltNll3OHRFRTVWMnBSVXRzMWNGTWoweU9qQ0M4S3MzZXZZ?=
 =?utf-8?B?ZUZLUGdCNGZtdW1PSHQ0ZDlqQ0JtblNwekRrVHFYS094R3NXL1hIMXRucDZp?=
 =?utf-8?B?VDdlbXJSNkp3SkJqL01mRGExSlRibjgrN0xYazcwUDA2N2p1cFhFZkt2RXNF?=
 =?utf-8?B?aldEL1dyaGVZdGw4YkhPRFJWZUhsS0NKVk9ORWxCRlN1WDF0Qkx4dz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08797b14-5fb0-4b74-ab1b-08df3313522f
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 03:43:38.6747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0MZ1wwPu5Wx7gp6N0jnFhxmd3B9d/gAatPEHu2P3cnU+D6OB2hCQrjUIXs3H72F2nuG8qtgBQiE36nuoNBC7JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3184
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 26 Oct 2026 03:43:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24536

On 23.10.26 12:46, shivanand.kunijadar.v45@mail.toshiba wrote:
> From: Shivanand Kunijadar <shivanand.kunijadar.v45@mail.toshiba>
> 
> This adds the additional information with diagram which shows how to
> apply the SWUpdate safely for a system already running without encryption
> support.
> 
> Closes https://gitlab.com/cip-project/cip-core/isar-cip-core/-/work_items/161
> 
> Signed-off-by: Shivanand Kunijadar <shivanand.kunijadar.v45@mail.toshiba>
> ---
> Refer the rendered mermaid diagram in the update here https://gitlab.com/cip-project/cip-core/isar-cip-core/-/work_items/161#note_3928442286
> 
>  doc/README.tpm2.encryption.md | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/doc/README.tpm2.encryption.md b/doc/README.tpm2.encryption.md
> index 6ae2c89..209b750 100644
> --- a/doc/README.tpm2.encryption.md
> +++ b/doc/README.tpm2.encryption.md
> @@ -88,6 +88,34 @@ The data partition in the fallback system will have the `noencrypt` flag set, wh
>  - Update fails at a later point and is not blessed; system reboots into the fallback system on slot A.
>  - Fallback system now needs to be able to use the shared data partition.
>  
> +Example:
> +
> +```mermaid
> +flowchart LR
> +
> +    S1["Step 1: Field State (v1)<br/>Slot A: Active<br/>Flag: none<br/>Slot B: Inactive<br/>Flag: none<br/>Shared Data: Unencrypted"]
> +
> +    S2["Step 2: Apply SWUpdate (v2 with noencrypt)<br/>Slot A: Inactive<br/>Flag: none<br/>Slot B: Active<br/>Flag: noencrypt<br/>Shared Data: Unencrypted"]
> +
> +    S3["Step 3: Apply SWUpdate (v3 with reencrypt)<br/>Slot A: Inactive<br/>Flag: reencrypt<br/>Slot B: Active<br/>Flag: noencrypt<br/>Shared Data: Unencrypted"]
> +
> +    SUCCESSFUL["Case 1: Applied successfully <br/> <br/>Slot A: Active<br/>Flag: reencrypt<br/>Slot B: Inactive<br/>Flag: noencrypt<br/>Shared Data: Encrypted"]
> +
> +    UNSUCCESSFUL["Case 2: Failure after encrypting shared partitions <br/> <br/> Rollback to Slot B<br/>Slot A: Inactive<br/>Flag: reencrypt<br/>Slot B: Active<br/>Flag: noencrypt<br/>Shared Data: Encrypted"]
> +
> +    OK["noencrypt flag prevents re-encryption<br/>  <br/> Encrypted data remains<br/>accessible"]
> +
> +    S1 --> S2
> +    S2 --> S3
> +    S3 --> SUCCESSFUL
> +    S3 --> UNSUCCESSFUL
> +    UNSUCCESSFUL --> OK
> +```
> +
> +* v1 (field state): cannot decrypt
> +* v2 (intermediate update): could decrypt, but must not encrypt so that rollback to v1 still work
> +* v3 (final update): can decrypt, thus encrypts, and rollback to v2 would still be possible
> +
>  In this case, where encryption is added via an update, the `format-if-empty` option is also useful. The system with encryption enabled has the `format-if-empty` option set for the partition(s) in the inactive update slot. This will cause both sets of partitions in both slots to be encrypted after the first boot on a fresh factory flashed system, but will not disturb existing data of any fallback system if booted after an update.
>  
>  ### CRYPT_CREATE_FILE_SYSTEM_CMD

Thanks for drafting this, very helpful!

Applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

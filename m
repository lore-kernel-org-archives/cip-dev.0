Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 709B0CAC5A5
	for <webhook@archiver.kernel.org>; Thu, 25 Sep 2025 07:27:47 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.40])
 by mx.groups.io with SMTP id smtpd.web11.5790.1758785263500478582
 for <cip-dev@lists.cip-project.org>;
 Thu, 25 Sep 2025 00:27:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=iQUEwBj4;
 spf=pass (domain: siemens.com, ip: 52.101.66.40, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ADFX2+IUWXcrOdfnLwcHFjLLMvnJ6bifhiL1ylCr7aHJsfL/ia9x2OjCqFXvkzPivUrcNSlCkZn+a5m2Q1dPwscEOlOmDg7oMRXN0vdNFqf3FJu+7YpGAjkjJ7m0yg6b6RqcYAsa7CRekq/GN1e7MIGWH965F6hNhyqh8igTpR8mInm57PSFzQcLslrQwyrjoHyF6z+JF0ZHC4hB+nnkWmPujL3ym4vgPmBDbQk0uQKqfHrftf/szpnVQud8vsj1aqPJGVhPS8wDViX2z2F6sT4L+/Jg2lea7Ml1opLqkY8ajp++PX97GkHTqn+7XupKYGd/j/hxyJzwUoabXQ6PoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BhUApeSm+1ejtogobe0qbwJfPwfXSz1EzHbcOSY29Ro=;
 b=ussChQwIXEsXUr3ePV9NHSrzDNyEzE1w4/zT+57GllfvUMlylvFZt1V6JQ+HpQBVnviGa1aXN5IHdNW6EQgGJDGCB7mv2CXyiz6B2r7TpIrwYm8yMlWAH40HBvv19jhHz/aTkGi0/88ow75rsI5UszuwO6b3I4zd0185n612kdi1Fzxmb/MCqAunhwmo5PW8DMPzcBd8fIYrExGpvds0IpqrTxRmSmerOPLiqKnfOjvTxHkHVLZZv5ZdXH6rWqlxEqlu2UcAQ+02cO3l2BddLCPyMu53gzXYUPYVNpvQhfURIIO3D0HoOm4OrFpInBYQTsj3BPZbzhmJfDPDQZojcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BhUApeSm+1ejtogobe0qbwJfPwfXSz1EzHbcOSY29Ro=;
 b=iQUEwBj4FuG4AYkW1raQ/xD3yL99iLDrvTOv9lQylTutHLQtxCuVlL8rvn+gYoZee6gMGzvEG3j0E1cXksjuXMiN6MtbP8P+ZMEJsxIhaBzbcKQKb2Ua3kPt3MsBAggHFobbzAcmGUHsIKEeXScp4TEaXxQ/9kcoj5AEoPodQ499rgAytFFNA1iphW1oQkPu4BxQ4j19bHav2eLVlBVkuc4Za6O8H+APgo2PjOILN8leceta6Y/PFENzMZ1Uz2sedtkqiPt8DjZH5gzKTDn27J1/oYlBgCrQLvNbj7eLxXxa8wrLBuhIRypFJFABxN65jvA+1/QGTcPVikyGmPGuBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB8807.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 07:27:39 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 07:27:39 +0000
Message-ID: <473929d4-40c4-4d4d-86bf-32913bf612ce@siemens.com>
Date: Thu, 25 Sep 2025 09:27:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v8 0/8] Add factory-reset
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20250925060009.1711605-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250925060009.1711605-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0151.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB8807:EE_
X-MS-Office365-Filtering-Correlation-Id: 39804437-cad3-4ae5-1a2a-08ddfc05018e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ZHREMWlUQkdGclBPdFo5alcyanRZNERMMGswTzJORFlkbkZRdkRsWmFRaDFj?=
 =?utf-8?B?YjAvUFUwZ0U5Qm83TEQ2cmc2OVVtZnhVc0w4VVVXQzJGSHhML0xqbi9JSUxh?=
 =?utf-8?B?UnhUemQ2cmNJRmZPRXpZUTlaWS9DRkc5MWRDZVYwaTZSQ3hYQ3FPeGQwdTc1?=
 =?utf-8?B?UWNIWTBVc1Jxc1pEOHdmaWJ2dnAxZjVKRGRLNlcyZVZ2bTZsQm5VcjB2bk5h?=
 =?utf-8?B?YnNwWTRqRkJhMHVEVmcrODUxcGI1TEJJUU55aTR2bndwUlAzSEZaejZRVzBy?=
 =?utf-8?B?NERaUUdlZGozTkovMFdRUGxhSThZM2JKSlNLOEYvZEN5R0k2eTRDK20waHhM?=
 =?utf-8?B?a2k5M25sQlhlT0QvT250V2owN0dvcmphaHdtZVJDZFFIL2xFN3lhR3ozVFE4?=
 =?utf-8?B?YU1WaERCNDNLaVRZcmdQa3VOOENoaEoyWW1RRXdlMm1NSyswczhaaFVrMG14?=
 =?utf-8?B?OFJrSG9KSEZsN3N5R2FqaHhKdHBCd1N4UFRBanp3QWE1QzZMcjZXRW03c1JC?=
 =?utf-8?B?aC9QZktrQkJ6U3dGcWFiYzJCQXFDN1NsbDYvY1FXaTNNNVA3NXYyZkxJa3J4?=
 =?utf-8?B?SFZzdnk5UmpKQm5hbWthK2d4RWllTEkyUDMwek5GeTM4dW9YRDBFNTl1TFhQ?=
 =?utf-8?B?c2Q2UW5KbFEzU2VURTh2MHl0SWVPMVIzb1kvUHl1SFNJakp1cHQzTm1mSzk0?=
 =?utf-8?B?YWVRZCs0ZlVYYitwMnpLbXYvVFIyZ3k4aFQxdkIyRDVkbTVLbEJVeXdwdUtp?=
 =?utf-8?B?N0Fjd3ZIQ0sxdVJNaFFSb0NqT0VGZ1lkNThROU5xNCtTVHd3ejdqelZETFNM?=
 =?utf-8?B?NDVzd2M1NGRIaHBleVZOMjZkYzVwOVRPdFpDNXozbW9yNWlKcG1qdmJCUERn?=
 =?utf-8?B?T3d1MXBEdUk4ZDZSZXB3YXNQV255d1BaOVNkNkpJRUtDT1JpZUtXcVlST2Jp?=
 =?utf-8?B?dnFhd3NJSUpnOHVXZUJmV2lSZnpWS0JxbmxCdC85V2tlNHBpUER6Z2hyWWxz?=
 =?utf-8?B?cHNzNFZZVzY2RHh5UjRuRE5WMlBaQXA0RklnNXZyUnJuZzJJYTcyWk1KOVpq?=
 =?utf-8?B?WHErcUxOQnlRR0xBeUgvQWtSYXc4eUQ4MkhMV1FuM0Mvd1c5ajY2cGlPcXFX?=
 =?utf-8?B?b0hvWENGaFV1WGJLb3BicTBmT3BHbHdVS00rZ2FxSitpOXRGY1hIaHIzQzVj?=
 =?utf-8?B?YjNRb0lXQ3E3SkNQcVBwTW4xVkRyZFVDS0I3N2dDRHhIaU92WCt6dGo0Qm5J?=
 =?utf-8?B?WWZuNHF0OHdwYmQvTFdrdExwU3hVL3lvMXBzS0taVUQ1VnZBd2FLTzZja0Rl?=
 =?utf-8?B?N1J5K29qUkMxUmg3U3JOVktFZDhHc0JrMEZ6elZKWUtSVVFNSXV2Y01zbEJh?=
 =?utf-8?B?M3hHc2ppQVYrRDBneENwbTBKclhSazJUaDFlT0J4SVhzL0hTTFhUWHNDSWNB?=
 =?utf-8?B?UUNqVTR1YnI3VEdXd1k2UkFuSWJMMlhDMHdnbW82Sk5JYURzb0kzT0VKRFlG?=
 =?utf-8?B?MzZ5emJPYkJ4cFhlMVUreWtiNlg2L0FiY2ZuZTJWRkV0cHFna0RHbUplenR0?=
 =?utf-8?B?c0ZvNG5WVjFScUpkM3JKcFptdUVnVFk3OXFSVzl3N2VxSm5oT1ZGKzhsNVoy?=
 =?utf-8?B?WFR0Vjl5WHUxeE92b1RBV1o0VGtFd2UvUmNMNjhld0NJQzZyZ2sxalhtcThm?=
 =?utf-8?B?dko3UzVUb2poRzUxd0VwR29NdHkvcDdGcHFRTGR6a1E4MUJmMWgvcnltbWZ5?=
 =?utf-8?B?OVROdHE0c3lhSDd5VDBOS3gyYjExS09jNHUvdFZ3NFJmRHVQOEdpY3hUQUhT?=
 =?utf-8?B?dTJLMFMxVWJ3SGJNZUVlalVIUUFEenQ5cnRMSzZ3dXNPb0ovWU8wV2RERzVw?=
 =?utf-8?B?UUhhSVVidmNkVFJNWEc3UlpwRkpiUVVDZmNWaW1YbXloa3RXUExqbFR2Snhm?=
 =?utf-8?Q?dYhlA4m42tc=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SVVxU1FMSlFvV0RaUGdQYlg3SkF2d1BvdThzdVJwYjRoY04wcVhhc09aY2pv?=
 =?utf-8?B?cGZVa0ZuY3VZNXlHR1hRU3MxSzc0WEEyWFBtN2pCZkliR3R4WkJiY0k4Ym1p?=
 =?utf-8?B?cTFoTmRNNStBRER2Qm5VYzBuZ0RiK0xhY1ZNbmVqS1FFTVJoYWlwWXFXM0Nr?=
 =?utf-8?B?MW1VaWE2cGszNTJrdXdWUHVjYTJLNkJWcVlWbS9HZURRbjYwUXdPcXFmM1lK?=
 =?utf-8?B?bjJJd3FXUHFabG1XcytmbU5sYXlnaUtSdlpFVGlEL0lWeVNXRWVzcmI4akFP?=
 =?utf-8?B?QWo5NlJkSWQ3Y2JlRjQ3TTloVzRaZTZ0Z2V4NnF0WWRDZXdMSktnY2YvWTNp?=
 =?utf-8?B?OHUxQW0zcGJodTd0a0I5M2ZISGpUalhIa3FOYmZjRlV4eldoY3JlREQrS2Zp?=
 =?utf-8?B?VHUwT2pQY3BZbkdYV3Y2Z2dtTlV6RGNaRncrcmZZUWxFZXR4YmZuMkVaQ0Vu?=
 =?utf-8?B?YVlnNy9haENic2dYancxNFdWRzlXU2VFVW1TYzlqRU1FWUZteUJVSHpHUnVX?=
 =?utf-8?B?K1B5Rmt0dy9ORUxLNU84Y1RMUHgrempHY2k3dDQvN0JRTWV2d1E0Yzlxdkcr?=
 =?utf-8?B?T0Q3VkZ2RDlsUkU1dWRTQUVISndZcGdHSlZvRTVzT1hlYTNvNEQ5aE9KamZR?=
 =?utf-8?B?ZHZyMHQ1VmJWcHpxOXN3cTNJTHFhSDE0dC9XNkZGVzhkTDNtZUw4NDZ6Ymk3?=
 =?utf-8?B?VlltZTJaZnk2ek5ZNzIveWFkcExjRnBWVllYQW0zVUgzdm5wa1Z1UElIVzli?=
 =?utf-8?B?NFl1bUhwVDE1OFMyeVl6UVpCR3RGSzVSMXhGYjFIOEFJVkVKZ0d5cElkTzhr?=
 =?utf-8?B?OTBVaEw2aTc4ZG9rLzhybUtnd25ZcVhsc2luc3JXTWdvWnpYZXBxQU54K0lr?=
 =?utf-8?B?ck5PYlVOU2dxanRsS2UwR0l4YVNQSkswTUxxS1dKK0w1d1FNbzdNditVWkdn?=
 =?utf-8?B?Z1Y0RHVjSzFYOTFmMmpLVDRPRW56MnJvNnJySldGZmJxVUhqWnNOcDNhRURh?=
 =?utf-8?B?MFhsb285Y1MwbVZldk85R2V6d0cxZm96MVhJMENmVmlsKzZ3czRrY2dER2RH?=
 =?utf-8?B?YUpzZEE5QnRmYzdGOTMwLzlhNjhlMndaT0JnQ0x1cjR0Slo1MDRrbEFuNDcx?=
 =?utf-8?B?SXdmMXZ1SHZFaFRRRGdDUWt2ZEIvYmd0VXM2d3MwMm9IckhSQ2pQcHp0RldF?=
 =?utf-8?B?ZThKaTN2cHBwOXdqejloaUFhbXVuS09vZWpCdFk5eFZON3kraEZXaW5Lb3p2?=
 =?utf-8?B?ZXhuRElJL0hYRjgrODlOQjZnRzZ0dVIwRzliUnRpUENJckNxTTgvV01GRWdu?=
 =?utf-8?B?WGR3a0NqbXZuLzZpNk1KY3VsSXFLeUJsRmc2Z01aWUlPOHBuRHF3eHMvRW9G?=
 =?utf-8?B?UHBjWHpFVkp3NVpmT0RrT3lXc0kvL08yWTY2djI1N3VvNmRQakh6cXQvbVdq?=
 =?utf-8?B?OXVicUNjMURkWWM1YkpNaFB6UEdUUUNsNUpmbURDeXlCMGNTM3hKT2ZPREQ0?=
 =?utf-8?B?V0g3dldEK0tTZkI5WGpiNEMyL1B4NEhLTUhOdHZzZ3NTbWtNL01yanR2cjBZ?=
 =?utf-8?B?RUhlSVNhbHhrWk9WczB5WERDRUw1MlJPeEhTbmNTNXZ6bkpQZGtKb1BCalE1?=
 =?utf-8?B?SENlRlIvSWcwNFRzcWlrSXdwcmRJL2VGRFBQZXp4ZGRFNG5lM0RNK2Erc2w2?=
 =?utf-8?B?UU1VdDB6SmZZei8yWXNGckpkSXoydE1lNG9qUUNJUzdMQkswdkNRNllpUUZ5?=
 =?utf-8?B?d1RIc0tROFpjbVczcnFaM3ZRMCs1c08yd3JUb1B6bUtlNVdhOTM3am9JYUdX?=
 =?utf-8?B?NktTU0xjWEl6NnUxL3R4RkQxWlBFVkVNUHhpeVBwT0JSakdKMEhZd2lnVlQ2?=
 =?utf-8?B?RjVFamxsSkptc1RaRFdzT1FYUXNQdEdPL3NRUkwrQ0VFL0RacHY1RUpIKzl2?=
 =?utf-8?B?enNzWnlJRXFPVW00WW1oOTFKSlRyK1RObkVzTitOTmp4dDY4cUxic3kydkNZ?=
 =?utf-8?B?N1NOTG41TmN2VnZibTVSeTQrUDNuRzBDL2pMQ0lVRjZGMUtpVWFVUEZsbjFV?=
 =?utf-8?B?UmRzcXBrZlRoRUpBaS9sdUtLNmhnVUVmdzZCTDJTamRQcXJyZldUQmtIQjY0?=
 =?utf-8?Q?um4b/vZZD6u+0uF5DfgXC/SK7?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39804437-cad3-4ae5-1a2a-08ddfc05018e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 07:27:38.9575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WLKKfmgUOKXhc2gwwhBp4GVu+FDzOD2mHoq8pTbx+43OeRC7Vi2622evXw46i0ThL7vvFJnavVfE4ujWVuaTZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8807
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 25 Sep 2025 07:27:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20131

On 25.09.25 07:59, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This adds an new hooks for factory-reset to the
> initramfs. This hook will
> 
> - format the disk.
> - In case of a encrypted disk factory reset the TPM is cleared(all keys
>   are deleted)
> 
> In case of an encrypted file system the marker hook needs to be stored
> in a readable location, e.g. one of the boot partitions or the efi
> partition.
> 
> Changes v8:
>  - build qemu-amd64 with factory-reset
>  - check incompability after fetch
> 
> Changes v7:
>  - reorder patches
>  - kconfig add conditions to enable factory reset with disk encryption
>  - fix indentation
> 
> 
> Changes v6:
>  - clean up white spaces
>  - fix shell check warnings
>  - Use efivars in case swupdate is enabled.
>  - add an error message to the factory-reset-helper-file. This error
>    message will be printed if the factory reset is used together with
>    disk encryption.
>  - correct wording in README
>  - add kconfig option to use factory-reset. This avoids
>    build errors due to the availability of EFI variables
> 
> Changes v5:
>  - Add option to disable the TPM reset by setting
>    INITRAMFS_FACTORY_RESET_CLEAR_TPM to 0
>  - correct options for efivar in trixie
> 
> Changes v4:
>  - don't add factory reset for ext4 builds. The factory reset feature
>    needs a full disk image or a efi bootloader to store the reset
>    variable
>  - remove bashism from scripts
>  - add README
>  - change uuid to avoid clash with systemd
> 
> Changes v3:
>  - move marker setter and getter into helper. This removes the
>    duplication of variables
>  - Use efi variable to indicate a factory-reset
>    As default we use the same variable as systemd[1].
>  - The file based marker is still used for qemu targets which don't
>    support writing efi-variables.
> 
> Changes v2:
>  - make marker check a separate script
>  - change data-reset to factory-reset hook
> 
> Quirin Gylstorff (8):
>   Add factory-reset-helper to set the Marker correctly
>   Factory-reset-helper file is incompatible with encrypt-partitions
>   Add factory-reset initramfs hook
>   Set PREFERRED_PROVIDER_factory-reset-helper for all machines
>   Add settings for factory-reset with a separate home partition
>   Add README for factory-reset
>   Kconfig: add option for factory-reset
>   ci: Add factory-reset to qemu-amd64
> 
>  .gitlab-ci.yml                                |  3 +
>  Kconfig                                       | 16 +++++
>  README.md                                     |  3 +-
>  conf/machine/bbb.conf                         |  1 +
>  conf/machine/hihope-rzg2m.conf                |  2 +
>  conf/machine/iwg20m.conf                      |  2 +
>  conf/machine/qemu-amd64.conf                  |  3 +
>  conf/machine/qemu-arm.conf                    |  2 +
>  conf/machine/qemu-arm64.conf                  |  2 +
>  conf/machine/qemu-riscv64.conf                |  2 +
>  conf/machine/x86-uefi.conf                    |  2 +
>  doc/README.factory-reset.md                   | 29 +++++++++
>  kas/opt/factory-reset.yml                     | 17 +++++
>  kas/opt/separate-home-partition.yml           |  2 +
>  recipes-core/images/cip-core-image.bb         |  2 +
>  .../cip-core-initramfs/cip-core-initramfs.bb  |  3 +-
>  .../initramfs-factory-reset-hook/files/hook   |  5 ++
>  .../files/local-bottom                        | 48 ++++++++++++++
>  .../files/local-top                           | 52 +++++++++++++++
>  .../files/reset-env.tmpl                      |  3 +
>  .../initramfs-factory-reset-hook_0.1.bb       | 40 ++++++++++++
>  .../factory-reset-helper-efi_0.1.bb           | 23 +++++++
>  .../factory-reset-helper-file_0.1.bb          | 25 +++++++
>  .../factory-reset-helper.inc                  | 35 ++++++++++
>  .../files/get-factory-reset-efivar.sh.tmpl    | 40 ++++++++++++
>  .../files/get-factory-reset-file.sh.tmpl      | 65 +++++++++++++++++++
>  .../files/set-factory-reset-efivar.sh.tmpl    | 59 +++++++++++++++++
>  .../files/set-factory-reset-file.sh.tmpl      | 56 ++++++++++++++++
>  28 files changed, 540 insertions(+), 2 deletions(-)
>  create mode 100644 doc/README.factory-reset.md
>  create mode 100644 kas/opt/factory-reset.yml
>  create mode 100644 recipes-initramfs/initramfs-factory-reset-hook/files/hook
>  create mode 100644 recipes-initramfs/initramfs-factory-reset-hook/files/local-bottom
>  create mode 100644 recipes-initramfs/initramfs-factory-reset-hook/files/local-top
>  create mode 100644 recipes-initramfs/initramfs-factory-reset-hook/files/reset-env.tmpl
>  create mode 100644 recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.1.bb
>  create mode 100644 recipes-support/factory-reset-helper/factory-reset-helper-efi_0.1.bb
>  create mode 100644 recipes-support/factory-reset-helper/factory-reset-helper-file_0.1.bb
>  create mode 100644 recipes-support/factory-reset-helper/factory-reset-helper.inc
>  create mode 100644 recipes-support/factory-reset-helper/files/get-factory-reset-efivar.sh.tmpl
>  create mode 100644 recipes-support/factory-reset-helper/files/get-factory-reset-file.sh.tmpl
>  create mode 100644 recipes-support/factory-reset-helper/files/set-factory-reset-efivar.sh.tmpl
>  create mode 100644 recipes-support/factory-reset-helper/files/set-factory-reset-file.sh.tmpl
> 

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center


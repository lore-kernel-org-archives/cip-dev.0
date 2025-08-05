Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D8ABC87FD1
	for <webhook@archiver.kernel.org>; Tue,  5 Aug 2025 10:43:25 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.12])
 by mx.groups.io with SMTP id smtpd.web11.18545.1754390600919759592
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Aug 2025 03:43:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=OFEfZHXQ;
 spf=pass (domain: siemens.com, ip: 40.107.130.12, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ckGydp3OSZHDgyA5aa6P8u989dJMqgI0V8E/9Iej2snXWgTEN5Y0pJStzztq7ekI/r8lk6tO+Nb6iln/xpUuuFZSq6sqJZMCe05zCvTP7aG+e0fZpVTOHFRwpc8tNq4GAlcnsrSRKML1dNjiZ/xTd7YCo1gIcuZWf1EyJUnliruEfqqXtjDOiDxa2UY6yU0CF50RXbc3AmAyo2XIVpR+skl2Hunb69qM9sqMPo2T6B2HI4zioz3CqKO/KmoPqW3GtiaDlBhNsbF3PGnjDyKo3Ol3lCsm0Bzk43LrvG9jv5niQvG4p+rOOSoJa9qyc7N43c6PNmjHR4/TS52vcfOsSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZFw/fD53VIIOhsLdKSsZYK1dWnmLbSPztIU9Nw76kzA=;
 b=t/9GGl6lrbg0kz7hPpkoRyUCIPA3cHGPWitxPVAM8/BapZqz5XtmE30WCBaRrv+yErq79AJm7R6dFJ5wzhxGxULGuJTOGQmM3Wapz8DnC53eZJDrkmBv05oSgSXhrJPHF8yQIhKn+9rtD4OCXOsPLxI8bbX73gfvW/nGJf10R3qw/XUA4v0YoKYCs3+Kzwj3y99wY9XcQIZsLTgQDEkiXEWVEcwOyhmf2itvrkpwZyHirHHmJKq2tiBIy5/hbMU/YKG4h9hZ35WBLmwWWMKV3jpkvKGibz3CjMq44Gxnjv3BejxvPzqKHZDboSUPeqZgrZ/+suZXekcQF9g5NKwVUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZFw/fD53VIIOhsLdKSsZYK1dWnmLbSPztIU9Nw76kzA=;
 b=OFEfZHXQtL/la75ib6JCn+G3Cfk2JXjHfXPGvUvkRC8ZVhx4EI8FVFt4i0Cyj/cHLd0MDrVChv5n6jLIrzhiS3Ec3nhwXDzOqnQayL0RhHOJXQ692R+/F4+Mw5jQHCD5IkZo2lwtkApKJQsnVEakfCHd+C5ffwjjSXZMpwj3U2Nuyfs2rHTJ/ejIs+6AwASHKtLHj//pPvLLrU2LiAcfFlcF7fsywXjzsOFatgTPIrRLeBjCrAGMWJCmdo4nBnkyXz/GsHZ2/hw9IBw899q32ARSzcZWehYt9PgNRxSWHtfTTaO+7QPkesfZrtrIghZr/TGKNgpqu41UUkrE65CcVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7682.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:633::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Tue, 5 Aug
 2025 10:43:17 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 10:43:17 +0000
Message-ID: <9b035d7c-9f15-4000-8c76-c1c0ae5a3fa5@siemens.com>
Date: Tue, 5 Aug 2025 12:43:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v3 0/7] Add factory-reset
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, gokhan.cetin@siemens.com
References: <20250731120043.333345-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250731120043.333345-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:610:59::27) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7682:EE_
X-MS-Office365-Filtering-Correlation-Id: bc432d2d-2410-4a2d-7644-08ddd40ce2e3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ekVXRDliTk9PeTVyY3dkZTQvem9ER1IySlVGZVJiSUJWalYyVWFpbGRFdFlx?=
 =?utf-8?B?NVB0aHV0OVo0TU8xbjRPOEFLNkJtWFJrUjVTRmJsMnpYWTdPZlMyQnhGTnIv?=
 =?utf-8?B?QzV5dVNaRUtpV2UxSlg1LzJQOUhobldMTUNGZ3k3WVJrWkk0YXMwSlpKVkU2?=
 =?utf-8?B?cXU1UTA3WUxWQzdDTW5FUm5wSC9qMmkrRXNhRzA1WGxsbEZrL1Y3WXZ5MThO?=
 =?utf-8?B?Rk1SeXNzbDFwTGpxc2dUTjBGWFpDaXZhVWhhN1Y2WUMyakJRNTBsaStPSjVx?=
 =?utf-8?B?OTZsRkhmZklNWlZtakE0R2hPVHpMUzlaWFhScFBPZEpyOE1IYXlOSEI0UkJr?=
 =?utf-8?B?L29OcnRhcmthdDR4elpybmIzLzk1RHdSWWY0aDFLZnJ6Z2FJWXkva2E4QVAv?=
 =?utf-8?B?dTR0MjByQnduTGY1OTRqd0RqSExtWmpod1I2ZDJGK0Z2b0txRTVwcXBvUUYr?=
 =?utf-8?B?WTdLU09pcEZZT0E1bjNLYm5VYW9kZG1ZbXJiRGU3Y2haZ2ZZOGdRa3k5L1E3?=
 =?utf-8?B?SmpCRkFXWUY2bE03NkQ3dkI1S3dWTzdzZ0NCVWVaWnJGckNFODlRSS9UZXhJ?=
 =?utf-8?B?L0U2SjgrL0ovNVJPZ2RZbWF2YXUzWTZ6U1FRNzRTVFVaOG9yaExkSnBvNEkv?=
 =?utf-8?B?STYwa010MXYxRzc4YUpwZGp5WGU5eVF4M1BEZUZxYW5PcmpNdFJoYml1WE8w?=
 =?utf-8?B?OThFVy9tby9ZWEhRaStHMVV2UWIzMjZqMSs5UVJEMmJ0b0tWOVIrU1dHZWQv?=
 =?utf-8?B?dWpQZE9mMWJTZ0JaTzNuNFZlVndSNnRKbmJ2d1piSWJHYUZEZnk2clNpWDdq?=
 =?utf-8?B?NHBZbnBKUldWbTJyRzRZUmdab1lnNHFxZm9QbTV2RWwwQ0xMNDdHRjlJZTJZ?=
 =?utf-8?B?d29PSVh4aVEvZjMveDIwNERrNkdUQTRFOTBHV2xJVGcwcGRtbFBkeFdNVzhG?=
 =?utf-8?B?blgyWi9iZ2dDdGY1ZjBYdmtNU3VHOWhtUkdTcDN5a2FHdWhabDJrZVlwUmxG?=
 =?utf-8?B?bTRyWllvVWlMdEpKdkhIY0IvVjI5MXppNlFiWTJPQzZPWkZBMndxdDllVXhx?=
 =?utf-8?B?VnVvK1RVZWx4eGpRNFFGVzhwSTlIOXZpWHlDZUFzOXVBREZsait0dWhVbzBK?=
 =?utf-8?B?bUwrSzNWWTQ1QWFPKy9nVFM5b1BPQWJ6eVZ0V3A5QkJNNmtOYlJjZ1hWQjhu?=
 =?utf-8?B?RkRzQURJd3FJNERQei9tcmRzNlp0bHB4RGdQQm5ubTJ0Q3dvd21KdnZ1eWhJ?=
 =?utf-8?B?dlowS092K0p3MTM1NVRZWWVqUHB4YlVtaUlCb1R1SVh5V1BtOXlYa1d1MFVP?=
 =?utf-8?B?YVRKTXdpY3BOVGpDYmM5MmsyZlZ6eUtPYkdQeTJQZTdRZW1ibGhJVkFBbVg5?=
 =?utf-8?B?UXBLWnkwTHJybXVyalRrS3FVNmxWNTRRbk80eWNtVVhpVEhkY0pVSnUxeHJz?=
 =?utf-8?B?NkpXWnR3UDFNRTNzdE1GN1hHZTJLVExDck5wYnpiYTZzS3AvRHJKbmp4YWl2?=
 =?utf-8?B?ZllkSGtMOThKdlJ2MU5kMkwxSVRROVoxREZ5S3ZxbTJDeURjbTZHR0JMUUx2?=
 =?utf-8?B?QmV2UFZqekkyRXQ4a3MvQ3lLWEZwdGh3OGZ4OEdKSUV5WlNuTU1iYjB2Q0ho?=
 =?utf-8?B?YWNaMWZQdDRSeVlaYTE2WHo2VTBrOXhnS3RieHczV1N0UFE3T0dwYU45Uk1Q?=
 =?utf-8?B?eGJCZHg0dllLS21GNGRFV3ZkbCtPSzc1NXNXSFo4aWhoMysrR2J2S2ROYU83?=
 =?utf-8?B?RysrdldReWhaVVpobjdWaUNhdUZPTjdwQlRvdUNFekNiRGVXUjBGeVhITnVz?=
 =?utf-8?Q?dg8eGcwDWfR/pY4RXXTYMy1FmM0BCTL0dwNjg=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VDRHM3ZoVCtQYkppcTllWUltRWc5bzZrMHk5QTFvUzh5Uk9TWDhDbk1UZ29h?=
 =?utf-8?B?QUlDcmZtQm40MDRTR29PanMvZDVJWVZsdVNiUXExQ05VOFZRK0JOZ0w1SEI1?=
 =?utf-8?B?YlZobVhrRmphRHhsbGdHMVZ3aHh6QTVYYjQ4Zi9kUmNLWVJKWEF4L3Niak5T?=
 =?utf-8?B?Vk41KzFmN1dDeGl3aUlQNENlZ2tXQ0t3Z0o1R0VlZzVVUDREbXR4L1E4VUE4?=
 =?utf-8?B?ak9UbG40Mkh2eURiQm1wbVVIa3NqSHhkY2R2WGNvN3FXd0lJb1FCL1JSZXdl?=
 =?utf-8?B?ZG9TdEdnRllpSTRHTVFjcS9GSkd2VVhibzZwc3lTOExlbnhQYkcrelpmdndW?=
 =?utf-8?B?bmFETjBLTjdlRWdXVFVZZUtjZHJvNEJneFBqMEdsc28vL2RYREhWRll3R1hp?=
 =?utf-8?B?OUpZSE1rRXVUYzdDZUQ5N0xzMUpFV2VCNVRwZDV4T2NnNjNvd0Y2b1M3cXpR?=
 =?utf-8?B?RW9EbmlsN0ttRGp0SXFTSEtvNWh4ZHdESzNqb0lsSDhtb3Y5eGFDdFlWQkpX?=
 =?utf-8?B?TWloMnh5V0dybzB4REFDeDlKTkhlYW9HK0lTR3ZVVS9MWGFES2NaSW16YnIx?=
 =?utf-8?B?czZIcEVzcTVYbSthVU9ZUDNRT1lrVnNFQVczMU5aUTVBUk9lODBEQXBwbHBD?=
 =?utf-8?B?ZjJ6TnhSVnEyUlhaaWt5c2lVdGNPa3dPMmJQSmJVTW5Cbi91dlFyNTdwUndy?=
 =?utf-8?B?L0JhZE5Wcm56aEVmVU0vZXM5SVA4MTIzenFaWlJva3hiMjExYUdIRjJQbHFi?=
 =?utf-8?B?MjgzcFdjbkJhLy9pdTdJT3YzMkdzOGF6d3pYMkp6bFZwRXc5NjdtbmhjdGRt?=
 =?utf-8?B?U1BVcE5OL3R3ME5mUlNsTWhFd3RxTWdJMkpERWxIQ2FIdkZCc05MaXpTcWsr?=
 =?utf-8?B?c1NJWVhEaU5jcVhRK3F2ejJzcGhraTV4RWRiRDg3cjNWK3FhSlRjTWc5WmZC?=
 =?utf-8?B?TDFpMHB0YlF5R1VVclh5dXdUeGdFaVZBblNzbmF1LzBpWHNsNURmS09zTFNP?=
 =?utf-8?B?SEppRDBPL3lBdG95aTg2dUl6dXh5VlB0aHUvRUFLeExSSmwzTTg4cENJbkMv?=
 =?utf-8?B?bTVFTWZpaDdPUC9uaCtLNzBxNWdsVUd1MjN4cTNUQjR1L21QWHh3RFVqSVFU?=
 =?utf-8?B?Q1lMZnNFQ3poM0NwZEJ0SzNITUtmTDJjZldVUTBudU41Mkl6N3B3YVBjRjh5?=
 =?utf-8?B?QlQzeEJFOWZJenJZTmhBQjl5U0hSMzFjQ1pUc2R4N3g4eXNvOG1BeW5RMnND?=
 =?utf-8?B?cTBuNDF3L2ZINzBEd2x5L1lnQ1I4dWtXMFljWlNGaUFLa2pEU3FCQXZrVkww?=
 =?utf-8?B?VE9obncvRkRJdXZpNGdLTHV6UHZaV2xjbzdjMGlMcUdWRHV4RlpmSWpwaEtC?=
 =?utf-8?B?SEVBb2lyMlNSQ0Z3d2tPZUFoMjlPZWRveXhOSk9PUzJtMWZRamZIWldHcGFv?=
 =?utf-8?B?M1MydFdPUE1tWGlKRGU2VEpOL1YyYklYVk1zTXdla1BMYm1YRTBRVENDNTdU?=
 =?utf-8?B?MDZDM3NxQ251QkdpOXlDNEo1VkFCcm9PMmNlR3o4OTc2eHFzZzhtbDMvNnpv?=
 =?utf-8?B?MXdSRUdrcmk1MzU1QTZkOTVOcmhOTUJrNGxQVE5tbzE5Kzk2Ty8xS1R3T3Ay?=
 =?utf-8?B?UVYxYyt2dXBobjFCTE9oVHFVSE9Db0VHUGRnbWhjblUrdEJRVTNJZFdLeTQ2?=
 =?utf-8?B?QmZJZTBiWTFhcFFLZGxIdUdjQ1phM1VSZ3VhUEpQaVZhbC9tN1hQZjRjUnZn?=
 =?utf-8?B?bnhkQ09hK2t0YzQ1blk2S0kzR2MyWTNMQlJ0V3FuMXRWR3RuUEkwRFg4eDdr?=
 =?utf-8?B?TGdVVWxYTnVheXRLNTloQUp3cXc5RHptdGlHNllaZnVOV3REeHM2RGd3ZXpn?=
 =?utf-8?B?R2tQdUd4aFd6Z2gzYVhhQnRqRm5tcURySW1iT29nTlU3WmwvMlJVcm5Oeitv?=
 =?utf-8?B?ZGlrcTI3bnFsdFBjSmlMUTBRVWhoQ2oySE9nUXlkbk5VR3hmbXV4cmtNNnVO?=
 =?utf-8?B?MUlCdXdZWXJpbzQ1V3RQSzVHVCtyQTZTbVdScE4rMEhRL094bDduMFJkd0M5?=
 =?utf-8?B?M0hYOFpLVnRlTjZsa2hZcS95ZXlCSCtCczhxQWNvREVVcGVJT0Ira1ltRGhS?=
 =?utf-8?B?dCtVZTFKRmlxQXplVHE5RzBRREZVY29yMEw1TkdydG4vUHlOaCtBUlJRTmNJ?=
 =?utf-8?B?Y0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc432d2d-2410-4a2d-7644-08ddd40ce2e3
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 10:43:17.0553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NklcTOjfGYbS0UIiS8BNbko8DfOSQmuXNYLYY/ywdW7DOuifB+OIJDGMdrwOYCGfhJa49+9l5JFjPYdmmIL8aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7682
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Aug 2025 10:43:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19671

On 31.07.25 13:58, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> So finally I had time to post this update.
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
> 
> Changes v3:
>  - move marker setter and getter into helper. This removes the
>    duplication of variables
>  - Use efi variable to indicate a factory-reset
>    As default we use the same variable as systemd[1].

It is good to see that systemd was choosing the same design here.

But are we sure that re-using the very same variable will work for us?
Will systemd evaluate it as well, or will our initrd already clear it
before systemd sees the request? If the latter, and once having systemd
in the initrd later on, will that still work as desired?

Jan

>  - The file based marker is still used for qemu targets which don't
>    support writing efi-variables.
> 
> Changes v2:
>  - make marker check a separate script
>  - change data-reset to factory-reset hook
> 
> [1]: https://www.freedesktop.org/software/systemd/man/devel/systemd-factory-reset.html
> 
> Quirin Gylstorff (7):
>   add factory-reset-helper to set the marker file
>   Set preferred_provider_factory-reset-helper for all machines
>   add factory-reset initramfs hook
>   encrypt-data.yml: Add factory-reset information to encrypt-data
>   cip-core-image: add factory-reset helper
>   add factory-reset to initramfs
>   Add settings for factory-reset with a separate home partition
> 
>  conf/machine/bbb.conf                         |  1 +
>  conf/machine/hihope-rzg2m.conf                |  2 +
>  conf/machine/iwg20m.conf                      |  2 +
>  conf/machine/qemu-amd64.conf                  |  3 +
>  conf/machine/qemu-arm.conf                    |  2 +
>  conf/machine/qemu-arm64.conf                  |  2 +
>  conf/machine/qemu-riscv64.conf                |  2 +
>  conf/machine/x86-uefi.conf                    |  2 +
>  kas/opt/encrypt-data.yml                      |  3 +
>  kas/opt/separate-home-partition.yml           |  3 +
>  recipes-core/images/cip-core-image.bb         |  2 +-
>  .../cip-core-initramfs/cip-core-initramfs.bb  |  1 +
>  .../files/detect-marker-file                  | 14 +++++
>  .../initramfs-factory-reset-hook/files/hook   |  7 +++
>  .../files/local-top                           | 53 ++++++++++++++++
>  .../files/reset-env.tmpl                      |  2 +
>  .../initramfs-factory-reset-hook_0.1.bb       | 46 ++++++++++++++
>  .../factory-reset-helper-efi_0.1.bb           | 22 +++++++
>  .../factory-reset-helper-file_0.1.bb          | 18 ++++++
>  .../factory-reset-helper.inc                  | 34 +++++++++++
>  .../files/get-factory-reset-efivar.sh.tmpl    | 25 ++++++++
>  .../files/get-factory-reset-file.sh.tmpl      | 45 ++++++++++++++
>  .../files/set-factory-reset-efivar.sh.tmpl    | 60 +++++++++++++++++++
>  .../files/set-factory-reset-file.sh.tmpl      | 57 ++++++++++++++++++
>  24 files changed, 407 insertions(+), 1 deletion(-)
>  create mode 100644 recipes-initramfs/initramfs-factory-reset-hook/files/detect-marker-file
>  create mode 100644 recipes-initramfs/initramfs-factory-reset-hook/files/hook
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

-- 
Siemens AG, Foundational Technologies
Linux Expert Center


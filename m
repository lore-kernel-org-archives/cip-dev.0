Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38565CFD376
	for <webhook@archiver.kernel.org>; Tue,  2 Dec 2025 09:22:09 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4108.1764667322089639051
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 Dec 2025 01:22:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=uA/lAIev;
 spf=pass (domain: siemens.com, ip: 40.107.159.44, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vPp/TNAYftBMzPrxquhnXM/wgHewNxN/PsB8tVO70Yf8CrrgvSUFFZq6Tb5bNrdZx/wgfzwzE5xn05otauo7j0u+ixhhmH5iFTZbo8bTf0kxas3Ud4UbjtGK+gAL2bB0hYra52L1X79lRL5xsalvZWqEwZEP3vZHPEsnxnJZE8RZdF+8Wpc/eonTcspVO+MdlE6YQIfw7gXIkLPyA0MeUKqXLCtzxlycHSi+L+OJGhbVlBJw2K4ukCevQ1cPeiFbKTHEpPjnFWEHNJPyW3Awbugm7BlUmzdsgGuQLryamSVHNz8OYN5Fp89A42Avco4Fms1cJ1LtFEVXI3Uw+R92mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bUAdMv+mZXdYxvxG1Z93QbIit8h9Qmaa2USsEY75eW4=;
 b=WnfLjL+kHay3atL6kKm82n+2QVy0jizTpO2qhlMbw+81mfDsok3OwuueGxhLfe868w8RkqVDFPiPgeRSl/altpiuD/3qDUDBh3ZI4g4THRzSafv0WqzZnH8ro41gZngO1VXOBSujyO9BzKYjJ0d9Ig7RicIjC9i9Ro6qAPOnTeGfXWb15EbIlEASesJtztdT10CVoJJTh91exIq3mFcfZ6spPNPlEUuze+ZIlxz/ZhSDiC0J9VBoJSQAy0TH/I9yKqfkhuaXiOO+IORVhXy9TBfjcytzXUb1frKb4XfPjP8kuG8Dauqu3gUh1If0XPkqoFb/5TU//x5J8eoe+13rEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bUAdMv+mZXdYxvxG1Z93QbIit8h9Qmaa2USsEY75eW4=;
 b=uA/lAIevyp7equjaH3FPHqgH0d2vVMRTfnho0cxB/2vzrlJsvK5y8wgSkhK6LEZ/3onmAFl3xmp/EneUu6UmsRdWPhZhyMXNjUcVO+a9NyOYeyGiXEJNLycuqr1952o8bv+a56WJBYppllHPIdz5yuABjNSJTWbYBI/58DlJdWMp6YKriKsIzzXrzC0wBfqeh/Zrq3rKxWM4q5Ifi7Yn+A+iPe4NDJn1EHGfp2OpQ9aCFcea4ACi1spCHt+fG7xXZUQ1zuCj/xWLB2B1sK7zxBdCLQcmrX3UMrqmuxQ16urg2DsmGQFfhFtaKmG59ay0l1U2wnB97UtbtwSiQQHy9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6127.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:548::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 09:21:58 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 09:21:57 +0000
Message-ID: <e5ffdb12-cff9-43bf-a705-e022abcd66f1@siemens.com>
Date: Tue, 2 Dec 2025 10:21:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2] u-boot-ti-am62px-sk:
 ti-extra.cfg: Remove redundant configs
To: Sai Sree Kartheek Adivi <s-adivi@ti.com>, cip-dev@lists.cip-project.org,
 vigneshr@ti.com
References: <20251202074159.480744-1-s-adivi@ti.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20251202074159.480744-1-s-adivi@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0073.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6127:EE_
X-MS-Office365-Filtering-Correlation-Id: 87d6d8ac-1893-4d45-bfab-08de31843df3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?dDNEVk1YOWYva05VNGxQMVdpcXR4bmtlOFYvR1lSUmt0enRob2JuOUJZMHRo?=
 =?utf-8?B?ejZESEwvRzk1MGdxNWV4WDRabkFZWlA2N1lxSUQ5cjJKbW92c2ZrS3I3dDU3?=
 =?utf-8?B?RloxWlljT1d2SXEyRVdoWEl6eit0TXlyVFoyYkhXQlR4Q0p3S1dabDV3T1RK?=
 =?utf-8?B?bFFYYzZYOUgyM3djZ2s1ekJFaHBkNDhpczNVSjNlQy9IUjZzd0k5d2NkL2JT?=
 =?utf-8?B?VDRic0tnMG1XL2NGRTJ2L1FmMWNOSS9Ocks4aEVOaFBYSFkxQzBUSmV1L0Ny?=
 =?utf-8?B?KzdKUVlSQTJlY1Q2dFAzVFJuSWRtdWRZQUhkMWlPaDREa1BPNjRMdXdmeWwr?=
 =?utf-8?B?RWExTjhJeENMelY0clVRYUZIdzVMaTU4TkY1bm56ZW0yeWhnalNCdUhub3Bu?=
 =?utf-8?B?VEpTRWEvbDhhMkdKZ0RQQzArN1hTSE4yWEtkeEJRZXJrREJHaHJ5aXpVVTM3?=
 =?utf-8?B?UVlqMy96eU9OdmZKWGRsSE0vdElXNlcwb3kzOHlKQU81Zk1kODExaU9KcVlS?=
 =?utf-8?B?SFFJV1JQNEpCdVh5dWZmQmRpUXlrZ2NTY0txdnBpRkFQd3FtTzBZR2tpWFht?=
 =?utf-8?B?N1pZK1RCZzVqVGxHZnhyTWRWcVFwd2QzZlYyc3hxNGVXM2x0YWF3cExnNWp4?=
 =?utf-8?B?cStTTkNrTWMxNUtRb2JreUdXTGNlelNOUUFyL1JxQjZSY0lDcm03QkV2TGtJ?=
 =?utf-8?B?RWZOWXZnYTZwWWFNeVlKemZOQ3ZUb2xRQVdDVndsc296dlcrbk5qaVZEVmxC?=
 =?utf-8?B?V1ZRa2EvMFo5WXZRUTdHcnI1cTl0WkVpRHJuTzUwak9odGRNR2dBS1ZhTnIx?=
 =?utf-8?B?K3ZpQ2NvUkc3OStGSjd6ZC9zeloveUs3K1VmM0JTWC9zakNoL2NSaDcrakhr?=
 =?utf-8?B?KzZDbWV1bGN5MXlpRkp4RnMzdytxNzI4V0NGMjB5b0ZwZmJHWTJNWTVmWXZy?=
 =?utf-8?B?RjNWMEd6ZDRVeXh1K2cwUzFrTklTM3ZCNlNVWk9oWmVYZWgvWnpBbk1hTFB4?=
 =?utf-8?B?dXhPR21lWXg4cUhpZG1SbWREMHdzSmhwVUpiSFQ4YWVXUC9LMnA3cjJheW9D?=
 =?utf-8?B?MXExWDF1WDNod3hIYm0yMmZDaGxNdFpIcEVDc3EvZkEvTlJMYmxYMGN5K0Fz?=
 =?utf-8?B?UHJRdWZYcHplUC9mRnhVM0FEZFFLNTVkZGlOZ1VmMU9wYVh1eDQrTkRaRFdL?=
 =?utf-8?B?TWpIR3NUSS9JL1psQW96dXFWSWhUY0RjVFBPRWFYa083TUMxbHBqR0VMTFps?=
 =?utf-8?B?c3B1SHlDa1NkTUQzQmtBSmdiUTl6ck8wYW1FaWpRMnZCdDJENWJ1ZVRCdHBv?=
 =?utf-8?B?Y29aRURlZVd3R0h2QnhJYlZRbHkzTFNTa0xzcEc5NEMyaGozeWR2ckFlaGg2?=
 =?utf-8?B?cWR3NTVJWFZtcVh2ZEovUFZMN0tQNWNTTHpUVFZWSzV2dVBXWXRDeXZrUUY5?=
 =?utf-8?B?NnBOMjZyNDA4eGlNcytEdkFwaXp0ZkZsVHVwYThULzVsOWt5cFYxTU8rRWx0?=
 =?utf-8?B?TGpnR21uRDIxOGV6eWx1MHR0WlNUTnZhODUrZFRINGk2WUVKODAwbWN3R2Na?=
 =?utf-8?B?N1RMS1paV3VoNWJlSEw5QUhiaE95ZjRBY082NnhXeFhxUTVEM2hWR2JBOUJD?=
 =?utf-8?B?dDN6dDRoVTVJNi9Na2VmQWhQT0NzK2U1eC91NWU1VnpsRlc4blFZMGc5V0xl?=
 =?utf-8?B?Mm03N0dLVTdJQWs1cTdBdGVkYW5TNEhTUGtkZXdWdERIQkFINXpRYXZVU0Ev?=
 =?utf-8?B?dmhBVHgrYkUxeXRIdWRSb2xVK25sd0wwazl5MjB3eGszS2pncTB0ekZFU2F2?=
 =?utf-8?B?N09QRGphaDdqeUl6dnh2RTlkU2k0VkdwMWFZTi84SnZwdUlQNnplcGd1YnBK?=
 =?utf-8?B?NWMzYWdyMGlKd09PUTcreE5vVlhHbEpRMkd4eW1DbW03K3c9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dy9NTGFDeWFJakt4N1o0T1pONDV1cXZZam5vVGt4a0NvYWRIUmh3N3VZTi9S?=
 =?utf-8?B?bzE1blhwME5TUEFrSDNZNUczcS8zVGJjWEFIb3pCQ3FlbjJONS9nSjgyOWV3?=
 =?utf-8?B?NTc1RkxxbS9qK1RybUdhS2svYkUydENZUE1oRDJ4Ry96STZFWWNYWWxycWN1?=
 =?utf-8?B?cXZEYXh6b0RhUHZ0OFZsRHYxbWNIVmtBVEtDbHBWMi9qL0pqRmY4QldPaUtD?=
 =?utf-8?B?VWdTWlNsOWoweW5NWVQweU9qWTFLZzAwTmFQeUdON000Z29PWHRPK0hBdGRD?=
 =?utf-8?B?cW11SktQdHZPVVg1QTRIK29EZm9UY2RGSkpUa2RGWUdETjU5WEplMk95eHlz?=
 =?utf-8?B?RGpubGhKQk8vdVdaWHc2K3o1Y0hRZEF4VlJVS2tDWjhsLytyOStxODVlM2xF?=
 =?utf-8?B?bnFUd2VzZU1BYUthV3U1NTIvS1lPWEY4OUFYTnNoNkIwb1ZCMENIOFlMeVpv?=
 =?utf-8?B?MzVXdWJxMlhpYVVVNEV2VVVQaWxCeVdsbXRRSEJ5dm4vcnRYN05yN2VtTkl0?=
 =?utf-8?B?YVgrazFLc0RiUWpmbk9CODFuaitBeE1DZWd3b2FtQzM5VldGOFkzZ0szcnNu?=
 =?utf-8?B?R0lUbDI4ODV5T3RoTUIrQ3pPOXNrUHJMRnVxT0oxMHRSVlZoVktVcUpkU2Zh?=
 =?utf-8?B?WUhuWDhmVVJTaW5lTmY4SUI2VnZsL0dVK0pUSVltT2ljNHBjU1BzWncvNmRR?=
 =?utf-8?B?bHR2bDVCSm90NDJYSGRKQXFsalRwZzVncllYVit2UnpNdGYrdlBmZVhhVFd3?=
 =?utf-8?B?Y0tmb2xJWkZaSDljcGxsSGtXamNBN1l0eFlHeWo2Y043eWRuazI1MElMRVli?=
 =?utf-8?B?NGRyQnpTM2N4R2JOV0JnYkhiSTErNVhNSkJrMGRoS3ZkbjJRbm56cGdFTkkr?=
 =?utf-8?B?TUxlUmZrR2NZWWtLN3MvSHA3cStyYkYrVTBqcjhUZzBGcFc0ZlArZXlpcDM0?=
 =?utf-8?B?REJHL2cva2txU0RXdm5rVExVODZhQVBWeUFnbmpTVFdyZDA1eE5oTXJnZ2JJ?=
 =?utf-8?B?WUJGb2Y4OEFpWC9ZMFRZTVdnNjZxUm1aYngxTGFITjVTMzd4OG5PSDdZRnoz?=
 =?utf-8?B?Q2xlZTF2aU9pRm5Cc0h2a2FHbWRzZFZpUHl3L3k4TVZLQnFaZ2ZZb2RUWmlk?=
 =?utf-8?B?eTA5c0lFRWZZL29TQ1U0Uzc0c2VIMUo3cUFvcitvWStUN2p6bGV0Z1FBOFRJ?=
 =?utf-8?B?RUd2TDU3VlFEVnZyRFBydFdmNjlOdHZtYzl1Y3g5WHVWcU91ak90T3I5L1p4?=
 =?utf-8?B?VU95VUFibFFSelhiYnVTUGN1NjJ0THZxS1kyYnlWNjZpZ3VoLzl1aE9EUmRp?=
 =?utf-8?B?OVF0NHdFYWRTKzJXQnpYRGFqV3V4NXdVd3c1dnhod2RqL0Y5Y3QrYTYvcnd5?=
 =?utf-8?B?YmhROTZMeTJDODQrM21ZdlRWOFhzVnRkelVRbDROVkdsWXJ6RllwQzVvWXV2?=
 =?utf-8?B?WktyVDg0MjNoTVlXWmZvbW96Mm1jeGR2MUMxUzdURmlVYThiUWFXUkxoTVJP?=
 =?utf-8?B?WHNzUmVVZUhrU1gvc2ttQ1RUM0hGK0hhWTNQeWNmdVBpSkpVVDB1OWx0bnVU?=
 =?utf-8?B?UEE4SHZLMFNOYnFYK0MvZ3pZOUJxVlNpQk4vckpQMjRTZlY4RjZGeFNoRDQw?=
 =?utf-8?B?Z0ZKSWhlRGoydVNUblRKdUVWMDFLbTR0UTVJbEsyVGhTWVlNUFRBR0s5alFO?=
 =?utf-8?B?aytyK3Y1eDQwYXVVRFIxNFI4MndXSW9CUU5QS1pmcHV1T2xzRW5yODc3MXZR?=
 =?utf-8?B?cGxVWXJDZCtiVlQvcnM5b2d0L080Qm1uVmdUR1FDOG9COWFTQktXbnZxTE9Y?=
 =?utf-8?B?QXY0RlFKb0o5eGVmdmN4ZERXN3VKOFZUUS9iTVU1VG05dVZBSUcwdmhVbVN4?=
 =?utf-8?B?dUFlUXhtZG93YzJmNG8yVzhQQzN1Qm82d21VZUYxVVFhWjBGbU5tNkpnTWJz?=
 =?utf-8?B?bnFSam42c1l6MWFwWm5QbGZnWE8xVXJ1d3dwdmhONjFEWUd2QTJ0R2V2TnB1?=
 =?utf-8?B?L2ZybUVFc0N6dmJrQTBtRFB6ZllrNkcxZDlRNWlCa2VDc3llQkZGVTNFLytQ?=
 =?utf-8?B?Vi9NWGF0OG4zdkd2MWFpeFVFZ0p4N2NxMDBrdUNITWpuT2JEN1BObXJETEpK?=
 =?utf-8?B?bWZUMzROUE5iRWhXTXpGc3hoeWtNdFZha2M3R2l1NC9RMGRVMGQ5WCswZFlW?=
 =?utf-8?B?TGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87d6d8ac-1893-4d45-bfab-08de31843df3
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 09:21:57.9028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AVUpQb9sJw/QSUPbGrdZZL8qI1EJ/VhOgagFFT6maXPJPgm2wKxcBEYPeY80/ay6VkJFouHr4cIv75MShHBbJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6127
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 Dec 2025 09:22:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20802

On 02.12.25 08:41, Sai Sree Kartheek Adivi wrote:
> TEE, OPTEE, CMD_OPTEE_RPMB and EFI_MM_COMM_TEE are enabled in
> ftpm-stmm.cfg and it is always included for TI AM62Px builds. So remove
> it from ti-extra.cfg.
> 
> The BOOTCOMMAND is stale which was initially used for testing purposes.
> pairing with RPMB is not recommended in production environments and also
> CFG_RPMB_WRITE_KEY=y is not set so this doesn't get triggered. Remove
> it.
> 
> Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
> ---
> Changes in v2:
> - Write detailed commit msg
> Link to v1: https://lore.kernel.org/cip-dev/20251127063738.435868-2-s-adivi@ti.com/#t
> 
>  recipes-bsp/u-boot/files/ti-extra.cfg | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/recipes-bsp/u-boot/files/ti-extra.cfg b/recipes-bsp/u-boot/files/ti-extra.cfg
> index faff390..c10d046 100644
> --- a/recipes-bsp/u-boot/files/ti-extra.cfg
> +++ b/recipes-bsp/u-boot/files/ti-extra.cfg
> @@ -1,19 +1,14 @@
>  ### FTPM + RPMB + StandaloneMM setup
> -CONFIG_TEE=y
> -CONFIG_OPTEE=y
>  CONFIG_OPTEE_SERVICE_DISCOVERY=y
>  CONFIG_TPM=y
>  CONFIG_TPM_V2=y
>  CONFIG_CMD_TPM=y
>  CONFIG_TPM2_FTPM_TEE=y
> -CONFIG_CMD_OPTEE_RPMB=y
>  CONFIG_SUPPORT_EMMC_RPMB=y
> -CONFIG_EFI_MM_COMM_TEE=y
>  CONFIG_MEASURED_BOOT=y
>  CONFIG_CMD_NVEDIT_EFI=y
>  CONFIG_CMD_MMC_RPMB=y
>  CONFIG_EFI_TCG2_PROTOCOL=n
> -CONFIG_BOOTCOMMAND="setenv pair_rpmb_key 'setenv -e -nv -bs -rt pairing 1; setenv -e pairing'; run pair_rpmb_key; bootefi bootmgr"
>  
>  # workaround for v2025.07
>  CONFIG_USB_STORAGE=y

Thanks, will apply this once the dust over trixie CI settled.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center


Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A05C87FD1
	for <webhook@archiver.kernel.org>; Wed,  6 Aug 2025 07:13:10 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.0])
 by mx.groups.io with SMTP id smtpd.web10.19356.1754464381928390699
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Aug 2025 00:13:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=sUwIq+Bu;
 spf=pass (domain: siemens.com, ip: 52.101.70.0, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EEdI4v/9LAPmrJSx1hyaG27mjNy+Vaqs4WZkfvMLrkcmBdPtd4zN0MmnPZ+ikLE4JCW8b8n5Ra/KUSGCeOm6b1mAdfWwIeKquJkd0cb545KfZOt9hz4mj7IabrfMhE7nau5gQquMtobXgM6pFQnxXb4M4XdKUVLjEbNJdNUrbQDsEKIx0MvYMKV0T47RbLhZQzUJKqYgNY3EwpUjhAss/EmjCXGBVwpUCP9CTiaiH+hmtTiRtklgCDSQdvP7pB26vDTGPDhXqKq85MjjaOK/9MZfN5/U/49ttsQpuqZJ2i6hoNOFk7Tv/38s6eIrQh4+ESRG6f9d3RBovhxwORW/iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y/vahKyrhOjRiS/eYr8Fwe8toR0bwcb1OCbhmFJKH0U=;
 b=Zs3HH9zAiaGz/tk7H39vovx9Op571wvX7G+zvlIpPgJLniyV/1e/Un1XrMNm2l+qPpTqJJ0kAlPSEkLNkxuymFhnwBpGq80tK8k3LtQwZAew5MBFTQnm4Zq1AcIRAPogExoQCvyLPSV3nldQeO6WgGYhx/nzaO2aOfGbcPlCmYhyFpLx/QMUt/vay9oQDKZYyh/83KLbgE3o1IoQhhaeMSR/ikq/dy1oz2qU1CNDOtM07oA1DpV95A+M7qlJsBvFnoHGfqsFZ22WeCZQr6wJJtwiHtTpmb9zK48XtT6Z7nPPpTl1ByOT5h9GjoQwWf5UwY5L2hDBuIOJBIpCxwBn8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/vahKyrhOjRiS/eYr8Fwe8toR0bwcb1OCbhmFJKH0U=;
 b=sUwIq+BuJm8l2TGCX9EX0TRpxVdvhkc6XLqOQXSxVFshRBED6u03iJqacLa1zhDnZVz2cjjJvMr0ZJqobJcSdgeFVOoVrNxfNMIwNjYwvSmNwFklKScCPtYtN8qQ/Rxhv4zAQZUbq0KdMG9qVjs7KL1PQB6b8FXSzC353wD7sLlMcoacf5iuo4Jpd6rHYY34KtmWdN87LVeeH7qPBrptl7RoOr1KbOOJ42btEmLA5uyQ8sieG9clI6u+Xsl3P+/NzDv41z6X+YoM/CRRUw/rkfnf3CRbcbreAEQ0P7sT3VBxyJ4WS6TZl4j4BI/gC0inkfzeY8+rZrUYD0pncy7yyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7369.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:607::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Wed, 6 Aug
 2025 07:12:58 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 07:12:58 +0000
Message-ID: <ad7c3971-0c32-4288-ad45-8e96e07742b1@siemens.com>
Date: Wed, 6 Aug 2025 09:12:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v4 1/2] kas/opt: Add option for not install
 kernel
To: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc: cip-dev@lists.cip-project.org
References: <1754457742-4006-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <1754457742-4006-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0178.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7369:EE_
X-MS-Office365-Filtering-Correlation-Id: 91113221-9dc1-46b6-2dcd-08ddd4b8ac02
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?OFVZay85ZkFFNGVrbVIxY3JzeUJUNE82MnB2MW12ZENZb2EwRTV2N29jODcy?=
 =?utf-8?B?bm5PL3pSSDhnVXVmVDlFWDZMcG1TZFlud2c4REVEdXZOUlBIN1pFei9Day9l?=
 =?utf-8?B?MEcvNHAvQnNxU0dlc2I0eEFwVk9jdi9rUFpqK1ZKVHREd1hxWlVkU1J3TUFa?=
 =?utf-8?B?cEdmbG5JOWdtTnBjQTYyZXhSN1dCbEZwSU1BTXZaUG1zbytZMlVZQldFbTRR?=
 =?utf-8?B?emxSUWQvdmNpZmExZWVyMUFTODRTbHplV1NjaDkzVkg5L2FyQnBYMFo1MkJZ?=
 =?utf-8?B?dUQzd093Q3dTZ1VQTnB4bEl3SFRwRUVRZTJldmFnL1NWM2R1Z2VCTHV0em1q?=
 =?utf-8?B?ZnV6UUxxamhldGp5TkdwL0FiSDd4TkdKd0dsWTJJNUhlTEZ0eGF6RDVJUG91?=
 =?utf-8?B?QU4xbUJrYk12Skp2ZEN3RHY5RDFLR1JqWjZmY3AxczZkRlpBUlorZ2RROHZC?=
 =?utf-8?B?TXZNc096N1lsU2xleU1xeVNJZWlsKzcrdXdJb29Kam1XaTdhN2JXdkk4MnBw?=
 =?utf-8?B?TFBZeTd3ZU4ybVU1ZWptWWhYWFlBUEJiWVlqMWxud2p6ZDBhWlU0bTMvOVFJ?=
 =?utf-8?B?eG9JdUUxZG9NRVRnL255UDd6YW11MWlVWnF6NTFRaDRUNFFlOVI4QUpyTmx2?=
 =?utf-8?B?THNzb2k1aTRJeFRxWmpMcDJwL0ZIWmkvWXc4c3dOVGkwam9IOEQvYjZBVldQ?=
 =?utf-8?B?a2g1SWtFSnVHa3FNdXZ0OUdhcmU2ZHo2K0lKNmFwMEpkaUxEd1pHb1E0cDhC?=
 =?utf-8?B?SDRIanZ6ZUsxZFhnWVRGa3lCaFdjaWkvSlhlNTRmREpIelpYQkhIM3hvdmVS?=
 =?utf-8?B?QjEzblpPUU5OOEpWeUp6WkF2QVdQL2VVcjNLcElrU295dXN2UjkxOWlQODF3?=
 =?utf-8?B?MXFWZFB0U2MwYThRdjBzbGFTV3E3VWtocTJ4TitGNzhwWFRVZGFNNDhEaHB2?=
 =?utf-8?B?WGFNaTlMalgxczR2SGxtTVl2bTJUMGMwRHVLdFEySHJDVDd6SjhlaFZRejF6?=
 =?utf-8?B?TURscFpLckZSYUtoYVZHTTIvblBMR0l4WG5XOTdrRXZZNUtpdTIzQmVXdklW?=
 =?utf-8?B?MlFtYi9ITmtNYzJMRERORWtLRTVXVVlQNWhEc0tXUlVhYTVDSEJTL01vTHgz?=
 =?utf-8?B?N0NDQ2l2OHFBS2hDY0cyMnRiQ2hYYjE0SDFQUFVnNlZ2cTZjRzlKZTVPd09P?=
 =?utf-8?B?TDlUc1g4aFk2b2xEdktOOFlJWTBnbmJ1Y0hleFc5NjMvcjI0eWxFS3hJRktQ?=
 =?utf-8?B?NFFuNE51dDNXdjFoMlZ0K2ZiY3U1emM5bjJUU1poRlFBSnJQaFdYc3dxY2Fx?=
 =?utf-8?B?MFUzeHNLVXNmVHZyd1VQTDh3cjRjK2RPUDE0aGlyd1dvaVM2UEk5U0oxbDRN?=
 =?utf-8?B?OXRMc3ZTd3dvbGN2TklBQ1Y5NmVpYjZ5R2ZYYkxEejZ0ak10S3B0a21oNnli?=
 =?utf-8?B?SjFhTlZDY3h0dkJxQTV0bC95OHk0Q09rbllYYURXcmxCaytqQ0FJQk5qL3VF?=
 =?utf-8?B?VFFGNnZwQ3R0YjRhVXlzdE05Y2JHT1d1bTMrdFBvYmg3SWZ1bWlaMGlBTGp1?=
 =?utf-8?B?cnRnQWhIdStrZFR0ZWpYQlhmQm82cm1zUVdSTjBDVktNTkZ3SXFZbjVFSmVx?=
 =?utf-8?B?aUI5WG04UGxlUThtbFErOW5OZXpMeGt4UWp1SW5hKzhLTFJoMVhXN2ZnYjhn?=
 =?utf-8?B?Ti8zS0tYbzdMcGROYTRzZ0xiUVdJbXN0UFY1TDFTZjZuV2VCR1M1ZlNWYmJw?=
 =?utf-8?B?NENVR3Flaml0bXpadU92bXlRcnd2S21BelFoN3BOZlhzZk5mVGUzZ3V5Qk5J?=
 =?utf-8?B?dWdic3NoaERFd3lxaWs1dTZnakV4QjlJY2syVVlzemZwcHFHNFEwTEdDM2pn?=
 =?utf-8?B?V080R2g3RW8xbHV6bnpzdnA1ZkE5LzVWWDdwYUoveUd2UEtPWFduVURoV1hm?=
 =?utf-8?Q?zGKPhgIMwRo=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QiswL2hqaXQ3ZG1yeHpPaFA1V09EaUwwRWNFQitlaUlHdGFsd21hQTQ0LzJW?=
 =?utf-8?B?L2lySElaeWZDSWtBK0xhdlEvTVNkU1JlVmpmbm8zSVZ3ejZZNjh0bWVJZUwr?=
 =?utf-8?B?M3NRM1NodlNWMTVnVEg4TElJL1BBRDA3TlE2aS9PSzdaRWd6TnNLUGs2WUxS?=
 =?utf-8?B?NzI3Z3RJWCtMdWc4YlpiTmlDL0xxb0lXaUd0b2NsblRCb2tsc0JNamhmMkpZ?=
 =?utf-8?B?Tm96Rm5iUTZqOTBFRkRBRVdNNVRLSk5RUzdONWlqakNkU0lrc2J2MmZXaVd4?=
 =?utf-8?B?ODQzY0h4RDl0R0R6VjVvd0tqcE50SC90QTd6VjhRaEhMb1lDNGJvWWNzbE90?=
 =?utf-8?B?cnliMHMrQWZqNTB5UkV2UjZGL3JRSUVicHhlRHBIaldUUGI4S081UzduS1dz?=
 =?utf-8?B?MWhVNCtLUUVrUkdoU2hYcjNWa3pkRHAwWGpJNlNicUlJZWdPRndEelhCTDBl?=
 =?utf-8?B?dFowUDJleHFMTzRWQjYzWjQvVUFxaUtHdVJJZEJkRUc1eVYra1BrT1F6cUcr?=
 =?utf-8?B?MGxyQTQyUWI5NFJvYmxTOFRlV3hCQWFXSG8yZ1NraUFJVzZENDF2UjUxeE9Z?=
 =?utf-8?B?Q1ZrcjlHdGlYdjJKSHNkMTJCQzJXWld6WEtVcTl2UDdWOVRZVWlQdVVzYlV4?=
 =?utf-8?B?WmI0MjV5eEhndHN4dkFBR0xJcDdoRWh6K1BWSXFITUpyWHR1ekgwME1WTUhn?=
 =?utf-8?B?V3VpaUQrQ3dNZTRUOGNqT3RaT3NQY1BZbXV3RmlLWmxkVERyYmxnMWFhdzJF?=
 =?utf-8?B?RWNmc3RRdU5ReFlZalIrN2s5akpUSjBXd2xzcjRZL2h0T2N1bmpaVkdyTlgx?=
 =?utf-8?B?NkdFN01xaUJGZmQyQ1pmNEVZdGhkZ0d1c0xsdEJCeVpzczV3Z0FmRmh0dTRx?=
 =?utf-8?B?M1RwaTdXS0VqaEsvR3JQZjdueU9VeFBZSDRaTkNROVFTMytrbi9oKzVheGNt?=
 =?utf-8?B?aWJqS3FWUmcwZHE5cm1wSGxtYlBPY2dOeTFITzQydmNZOWY3NW41blJyKzMv?=
 =?utf-8?B?WVFZSVNJZDRMajhYWmhFVUp3R1VKbEtTaDRTcm1WTTJOdHB5czdxMHFQWmE2?=
 =?utf-8?B?K3BtZjhsTUM5ei92YldyTy9Edk5IV3dieW5Dek9ScXVmQlQvSGJCTGNKVnJh?=
 =?utf-8?B?OWFTTnlkOVZDYmpUMFVrUHI3SXREdUZQOVlLTmt0ekpjNmo2emJFZTQ4bUwz?=
 =?utf-8?B?WjVmZEZnZEFodllwN0F3U2tBTjJkelFTMHd0WWc0bXo5WDJZUkNQVXMrYk1N?=
 =?utf-8?B?UDBlRUdXRlVReWlLWEVlT1ExSE5DQnJaeDAvK2FYWDdGTkdKc1NyZFZXY3M4?=
 =?utf-8?B?Z0trK2JPNkorNWM5eHlJZ00yNU9tR0YreW8zeGFKaUZoM3lFU0d2M0VkQjVn?=
 =?utf-8?B?dkM2WTBwM1g1UGpuRVJJREtmaUluWjMwOU9vTUtTckhrbWRoTzk0dks4dU1L?=
 =?utf-8?B?eVVMTldRZFRSSTh5clYyTmwzR0swZGxQaWlRc0hCVFJET3hibkJvaCtKNDJo?=
 =?utf-8?B?c0NHazlYSzRTaUg2bDZWR2hQUDA1cHhWUmNOeVhDZVpmYWZHZ0ZxdmdoQ3Vl?=
 =?utf-8?B?VUxMNHFaV2JwWG51aFF1aHpkTXg1OU0rTUhiZVczekZ5SkJNRzUwUXIwSVBQ?=
 =?utf-8?B?TkVWYnBxQ1lqOWF1RkQ2cm1hRGtONmh4bTJkcmlpa3Aycnl3VVZUNUI0NEIv?=
 =?utf-8?B?VlNYUG5JU3NCR2VsOEVyeFdMTnJqTDRJSFp1N2hITUhzamRvRFl6RGFpZWlG?=
 =?utf-8?B?RjlzTTJPYjNnV05qVUl2RmR1bWI0SWNWVlArcEtubXVzVjNZUDVTVlF0NFI3?=
 =?utf-8?B?ZVE0bHVrd2svdUV2a3U2aUsveXQyNlhuMkJmTnkweE8rVnZGS2JFTWtZYW1E?=
 =?utf-8?B?YmlRSjF0bWlzZVQ4c2lLQ3FOOXJhNkh6VnBMeHFUNFk5RVZ2azQ5cHZ4R2No?=
 =?utf-8?B?Slp2dVFNTmdFb2gxa2RIOEJVV1NzU2pYclBTZFhSSHRDZHYxOFkzSHF2Wkk0?=
 =?utf-8?B?K21DelF3VE5mNUhPRXlKdFdza0pnYTRsSlRGaXNYVDVmVW0rcTJxK0dFaXM4?=
 =?utf-8?B?aVBjVUVmeUd0cC95b2RBOXAzcDlWT0ZTTnJWNHliaGNaeW90K0d5YmpTakI2?=
 =?utf-8?B?Wk1UZGYzanVDNnFkQzM0ZFF5TUFOZHgvVkVGaStNRG0yMVp4ZEZZSjVnLzBX?=
 =?utf-8?B?Nnc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91113221-9dc1-46b6-2dcd-08ddd4b8ac02
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 07:12:58.2775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: naB/4MZblR0+JiqLlRFVmzdt47i2ovo9F+6k9Z6I4xmCDxXlYeAv503J40U5OD2zqJY7eEp9Q47HTE/UwjFTMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7369
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Aug 2025 07:13:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19684

On 06.08.25 07:22, Nobuhiro Iwamatsu wrote:
> This adds an option to create an image that does not contain the kernel.
> This is mainly intended to provide images for kernel testing.
> When testing the kernel, kernel image files that are not used for testing
> are not necessary in rootfs. Providing images with these files removed
> allows you to reduce the size of the rootfs image.
> 
> wo_kernel is false:
>   -rw-r--r-- 1 iwamatsu iwamatsu 351M Jul 25 17:31 cip-core-image-cip-core-bookworm-qemu-amd64.ext4
> 
> no_kernel is true:
>   -rw-r--r-- 1 iwamatsu iwamatsu 275M Jul 25 17:09 cip-core-image-cip-core-bookworm-qemu-amd64.ext4
> 
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> 
> ---
> v4:
>   - Fix the NO_KERNEL check to 'enable' only.
> v3:
>   - Update commit message.
> v2:
>   - Use KERNEL_NAME instead of IMAGE_INSTALL:remove
>   - Add build:qemu-riscv64-test-nokerne; pipeline
> 
>  .gitlab-ci.yml             | 36 +++++++++++++++++++++++++++-
>  kas/opt/no_kernel.yml      | 17 +++++++++++++
>  scripts/deploy-cip-core.sh | 49 ++++++++++++++++++++++++++++----------
>  3 files changed, 88 insertions(+), 14 deletions(-)
>  create mode 100644 kas/opt/no_kernel.yml
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 628e624..496a56d 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -28,6 +28,7 @@ variables:
>    swupdate_version: default
>    test_function: swupdate
>    separate_home_partition: disable
> +  no_kernel: disable
>  
>  stages:
>    - build
> @@ -69,9 +70,10 @@ default:
>      - if [ "${watchdog}" = "disable" ]; then base_yaml="${base_yaml}:kas/opt/disable-watchdog.yml"; fi
>      - if [ "${security_test}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/security_test.yml"; fi
>      - if [ "${swupdate_version}" = "2022.12" ]; then base_yaml="${base_yaml}:kas/opt/swupdate-2022.12.yaml"; fi
> +    - if [ "${no_kernel}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/no_kernel.yml"; fi
>      - echo "Building ${base_yaml}"
>      - kas build ${base_yaml}
> -    - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${dtb} ${CI_COMMIT_REF_SLUG} wic; fi
> +    - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${no_kernel} ${dtb} ${CI_COMMIT_REF_SLUG} wic; fi
>      - if [ "${build_swu_v2}" = "enable" ]; then
>            mkdir build/previous-image;
>            if [ "${extension}" = "security" ] || [ "${extension}" = "ebg-secure-boot-snakeoil" ]; then
> @@ -229,6 +231,38 @@ build:qemu-arm-test:
>      target:  qemu-arm
>      extension: test
>  
> +build:qemu-amd64-test-nokernel:
> +  extends:
> +    - .build_base
> +  variables:
> +    target:  qemu-amd64
> +    extension: test
> +    no_kernel: enable
> +
> +build:qemu-arm64-test-nokernel:
> +  extends:
> +    - .build_base
> +  variables:
> +    target:  qemu-arm64
> +    extension: test
> +    no_kernel: enable
> +
> +build:qemu-arm-test-nokernel:
> +  extends:
> +    - .build_base
> +  variables:
> +    target:  qemu-arm
> +    extension: test
> +    no_kernel: enable
> +
> +build:qemu-riscv64-test-nokernel:
> +  extends:
> +    - .build_base
> +  variables:
> +    target:  qemu-riscv64
> +    extension: test
> +    no_kernel: enable

This cannot work: riscv64 is trixie-only. What to do? Lift this to
trixie or drop this target?

Jan

> +
>  build:x86-uefi-secure-boot:
>    extends:
>      - .build_base
> diff --git a/kas/opt/no_kernel.yml b/kas/opt/no_kernel.yml
> new file mode 100644
> index 0000000..7bba6a5
> --- /dev/null
> +++ b/kas/opt/no_kernel.yml
> @@ -0,0 +1,17 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Toshiba Corporation 2025
> +#
> +# Authors:
> +#  Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +header:
> +  version: 14
> +
> +local_conf_header:
> +  kernel-version: |
> +    KERNEL_NAME = ""
> diff --git a/scripts/deploy-cip-core.sh b/scripts/deploy-cip-core.sh
> index 6e4dfd7..5647381 100755
> --- a/scripts/deploy-cip-core.sh
> +++ b/scripts/deploy-cip-core.sh
> @@ -13,9 +13,10 @@ fi
>  RELEASE=$1
>  TARGET=$2
>  EXTENSION=$3
> -DTB=$4
> -REF=$5
> -DEPLOY=$6
> +NO_KERNEL=$4
> +DTB=$5
> +REF=$6
> +DEPLOY=$7
>  
>  BASE_FILENAME=cip-core-image-cip-core-$RELEASE-$TARGET
>  if [ "${EXTENSION}" != "none" ]; then
> @@ -29,6 +30,23 @@ fi
>  BASE_PATH=build/tmp/deploy/images/$TARGET/$BASE_FILENAME
>  S3_TARGET=s3://download2.cip-project.org/cip-core/$REF/$TARGET/
>  
> +if [ "${NO_KERNEL}" = "enable" ]; then
> +	__BASE_PATH=${BASE_PATH}
> +	BASE_PATH="${BASE_PATH}-nokernel"
> +
> +	echo "Rename from ${BASE_FILENAME}.* to ${BASE_FILENAME}-nokernel.*"
> +
> +	if [ -f "${__BASE_PATH}.tar.gz" ]; then
> +		mv "${__BASE_PATH}.tar.gz" "${BASE_PATH}.tar.gz"
> +	fi
> +	if [ -f "${__BASE_PATH}.swu" ]; then
> +		mv "${__BASE_PATH}.swu" "${BASE_PATH}.swu"
> +	fi
> +	if [ -f "${__BASE_PATH}.wic" ]; then
> +		mv "${__BASE_PATH}.wic" "${BASE_PATH}.wic"
> +	fi
> +fi
> +
>  if [ -f "${BASE_PATH}.wic" ]; then
>  	echo "Uploading artifacts..."
>  	if [ "$DEPLOY" = "swu" ]; then
> @@ -48,17 +66,22 @@ else
>  		aws s3 cp --no-progress --acl public-read "${BASE_PATH}.tar.gz" "${S3_TARGET}"
>  	fi
>  
> -	KERNEL_IMAGE="$BASE_PATH-vmlinu[xz]"
> -	# iwg20m workaround
> -	if [ -f "build/tmp/deploy/images/$TARGET/zImage" ]; then
> -		KERNEL_IMAGE=build/tmp/deploy/images/$TARGET/zImage
> -	fi
> -	# shellcheck disable=SC2086
> -	aws s3 cp --no-progress --acl public-read $KERNEL_IMAGE "${S3_TARGET}"
> -	aws s3 cp --no-progress --acl public-read "${BASE_PATH}-initrd.img" "${S3_TARGET}"
> +	if [ "${NO_KERNEL}" = "enable" ]; then
> +		echo "The image does not include the linux kernel. Therefore, kernel related files will not be uploaded."
> +	else
> +		KERNEL_IMAGE="$BASE_PATH-vmlinu[xz]"
> +		# iwg20m workaround
> +		if [ -f "build/tmp/deploy/images/$TARGET/zImage" ]; then
> +			KERNEL_IMAGE=build/tmp/deploy/images/$TARGET/zImage
> +		fi
> +
> +		# shellcheck disable=SC2086
> +		aws s3 cp --no-progress --acl public-read $KERNEL_IMAGE "${S3_TARGET}"
> +		aws s3 cp --no-progress --acl public-read "${BASE_PATH}-initrd.img" "${S3_TARGET}"
>  
> -	if [ "$DTB" != "none" ]; then
> -		aws s3 cp --no-progress --acl public-read build/tmp/deploy/images/*/"$DTB" "${S3_TARGET}"
> +		if [ "$DTB" != "none" ]; then
> +			aws s3 cp --no-progress --acl public-read build/tmp/deploy/images/*/"$DTB" "${S3_TARGET}"
> +		fi
>  	fi
>  fi
>  


-- 
Siemens AG, Foundational Technologies
Linux Expert Center


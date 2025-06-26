Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A9E2C7EE30
	for <webhook@archiver.kernel.org>; Thu, 26 Jun 2025 16:32:50 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.23])
 by mx.groups.io with SMTP id smtpd.web11.165.1750955563159284978
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Jun 2025 09:32:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=OAcSMzdu;
 spf=pass (domain: siemens.com, ip: 52.101.70.23, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b92hnodxRZ4EHwtwOQ/g2PZ7HIHRcy72J1f0A72UdtXxNa5wxfpzDovS1wqAwrj0qePOdOn1DZUq6RJM7LxvxBhpEQYYscij5x3CBFoXzjEy4K3uJVcAxlQj9JjtWGut/d/VbOBti8SHwrH8gESG0cmm4CQPTUo6wakQOWc/8/ETEX0D03/NYH/7I1ZMqFVq50WJSdUEfti6zAObNmZ12k+VihfzclTe30cbroi6EtctPMRW+Bj6hr2haOS9XINCPDz0jpPldeqXAh6Sjq1q4EJFGVRrlhYNq5BbJIrcndwQG3/1TfJItnqPGMJtNXmBjpWRZw4CBgDr7Aivqr2XzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EElKXnlYh519SzD66D6YwnD4RuTwo8qp7dAc7oTtT+E=;
 b=Al7qhhjHkptt9KjONTBzB36WwmAtSbveOWShldLubzdTF4VlJA36QOw1ECaB86NTCOhJ40zckAu0/yS9FwqBFAaNySr8Lz+5gcPa6wO+ponOmba87ohfRpAqzEQE5sq+eu7s4I8TNRxI81yoZET1TT3/kpPk6ueaI/W2l5n5vHRslLmjIKZTj7MFdvTHDStskOp4cQKmTn6oYeTX5riYdOOX4I4nqk6jEJsCWsyJjp4bpTyyqsdAQXWKCheh35PVWqj0YFeXFwURSrgj+aVIaFxuzQw8uZI9kdjRQi7g6pX1TCM1gi+KeKb8OoV52nOYrUsYHR47NcHKeQJ5tgKJ8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EElKXnlYh519SzD66D6YwnD4RuTwo8qp7dAc7oTtT+E=;
 b=OAcSMzduvW7GDtNo3oudOypazKEW+h9XjobBrkXSjPRLhm00M0FnnokTYy3vbLbovEpHcSb97FRiGTyctUQBh2WFIfDTwLK8pMpYu4XRo+QDIyvocwxqiv44RmTOZxy5uQ3ETZSUC4T7MKp5Gdwo3rKnbPW5VJ3heq+lu/nmiy3JrgQm4Y7JE2ouYGDTT6NTPPXAGGJoem8y6OI9hnXQjyWHEEOkiGE5OEYnYkgENQKwSSaOa4mZR+PUEX+jgmm/bQ/7tkkYShYX3VJGSp68208aVx/ws1dLxCvk6HR0amSzYqVT8/2Q3TAD2wpyczqx7EK411QJsGlrYZcn3DpIJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS5PR10MB8102.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:673::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Thu, 26 Jun
 2025 16:32:39 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8857.026; Thu, 26 Jun 2025
 16:32:39 +0000
Message-ID: <d2ae69df-f426-4317-840a-10b6e488da3f@siemens.com>
Date: Thu, 26 Jun 2025 18:32:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/4] initramfs-crypt-hook: store initial encryption key
 in TPM2
To: Claudius Heine <ch@denx.de>, cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 Heinisch Alexander <alexander.heinisch@siemens.com>,
 Cetin Gokhan <gokhan.cetin@siemens.com>
References: <20250626-initramfs-crypt-hook-patches-2-v8-0-46f000788686@denx.de>
 <20250626-initramfs-crypt-hook-patches-2-v8-1-46f000788686@denx.de>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250626-initramfs-crypt-hook-patches-2-v8-1-46f000788686@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0124.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS5PR10MB8102:EE_
X-MS-Office365-Filtering-Correlation-Id: bb7b2f56-fecd-4261-584a-08ddb4cf110a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?V1B5VHZ4dzdocDNoZTZEUUtvVmRuaTNrcDIzTUFudGdtY3UxbGY1Q1lTSlpV?=
 =?utf-8?B?V25ablJiLzF2d2loMEw1ZnFpSnpoSVNyRFZNMUJoajBXQ2orMVlLTTJjc1pu?=
 =?utf-8?B?Q0lCMk5tam9OemtlSHNhSGplRG80djdNeUxmbUIra1pWa0lMa1VRcDNidjc4?=
 =?utf-8?B?Zm4yakNEalFvS0R0QXh4bnB4M1NUR0w2d0ZCck4zWmtvMHROenhvUFNFUVgz?=
 =?utf-8?B?L2VFWDBScE5FWDFBYlBDMVFsOENVVGRid1RwRFd0RlhnTFJncXNyRjMrcDV0?=
 =?utf-8?B?K0QrUlBmU3QrNzZvZVFZNHo4eFB6U0dwSUZTb0wwRGxWUS9UTFZJeVBGL21L?=
 =?utf-8?B?RGc3Qzh2cXpMNFdKSTFyNzZQNXU5TWNaTkprN2orZk9waC9wQkQ1cDB1eFht?=
 =?utf-8?B?V0tQRDg4SDN2Zm9aV09MNEFHUktEa2lMVWFpUHNZWEhVYmhJN3JkQUlMNnBp?=
 =?utf-8?B?ZmxEMnczbTVmTzZWRUxPMmtSQ3VGQ3h3eTJ3VjFhV0N2NWloam5NRFdUaW1K?=
 =?utf-8?B?MmdoZkdHZHVqQjdLdTdWN1hBR00rWGlFM1hQYjRxSHFyb3Via2hjVHRxWmZ1?=
 =?utf-8?B?QTA4RmhMb3FKaFBoWHhsek1jMmhPRmFEMjZWcGR4a3R2SmZQZnJkQWErVHFO?=
 =?utf-8?B?MzZlYlVreGF1RWk2ZC82akNUbUFMajlGbkMzZkJrOUpFRy9NQnM4ZERDdFdP?=
 =?utf-8?B?Q2dXYmRnQ2pQLzJSL252QVZza3l0NlF2L3MwbWRIcDlYMGNEd3NQK1c5eWcz?=
 =?utf-8?B?Skk4N3hVaUUzTWYrYlN2YWtjMDlVNFNLK2lTNVNXa1c2bGZ1dS9XVE0wSHJI?=
 =?utf-8?B?TnV6MlFkaHdTakM0N0wxRGsyMnBKRnhzU0dScmh5U3JDU3kxbU5nWkRuTGhT?=
 =?utf-8?B?MGJBajBMU0ErU3NSMzFjc2xJb1FOY3FEbkRRQnlZYmVMd2MrZUxPWHlQVzdO?=
 =?utf-8?B?aHZWcEx6REg2bTNVQndUWE44NGhlYXhSZ21PZnFRRU84YzVMNm1mSkg1cXE5?=
 =?utf-8?B?RC9pcGRGWi8zbGV2WWloczFORnhhVkJPck9FL1dSSHZiZXl3czlId21mNm1v?=
 =?utf-8?B?d2x0OUo3QjdRM1oxREFEMHZvMENZbmViN0hUMktXQ1MzdmV6WjQvY1gvYkI5?=
 =?utf-8?B?TGF0U3FQNXVzb0ErK3hMT1hHS2k4K3cxQzRPQnBVSWt6SkgyNHBNdGN4ZzN4?=
 =?utf-8?B?emgxTmQvMXFBaDB6VGEzM2dHTVlrdHVoWE50ellySG90Y2hSOXJkRVl4QXFM?=
 =?utf-8?B?OHdRb0NSYU1VMm56WEpDWWJ1OVJIWjZGRXl0Y0t2NjF2Z2tYWWhsRkxLQjF6?=
 =?utf-8?B?MVZXd282eWd3QjZCaUhXUHZJRWw1N205ZTF2d0NybnFCVmdsZTJ0MFlsWGVr?=
 =?utf-8?B?bWhiSjA3L0hkK2s4QzEyeW5Ud09vYWRtU2tYeHQyN2RiRmJib05rREZUYnM5?=
 =?utf-8?B?SmN2MUR3dHVFYkpwT01WbHgySGNpRnJpZStScmxMNTY1VmdDc29LVkpLcnJp?=
 =?utf-8?B?aTdEVlpHd0JaMC80THFmWjQxUmxJbHNRNHJMb3pBYko3YmIzclFWNTVuOWpJ?=
 =?utf-8?B?T1NaUkdWc21SOFRmZXFtMk1ydmdsbkgvY1Y1TG5PUkMwaVY5eCs3MFpUZ21G?=
 =?utf-8?B?YjdEakdCdTVUVE9MaE0vMzN6S0RUY3BRUjBWZDBBblR0ZHhzNHhOUGdUWlZi?=
 =?utf-8?B?b0lrTGtQZWlka0w0cGlMVURSTWJpZnUzS0x4elc5MEsvU1Fza1pubjR5NWdn?=
 =?utf-8?B?ZHBScmJicURnODNQcFZ1OHd0dlBISG5tQTkvUXhLVFNpZC8vZm1IOWJwc2NX?=
 =?utf-8?B?Qjc3dWZaVnUzc0lKOFFmTDZUKytrL2NwKzY2VXUvQXlvYWdyWU83VGIraE1H?=
 =?utf-8?B?aGVjYXROWjJGemk2NTRMNXJhUGF4THJDWFRTYi9SYWlaT0MxRHhITlZqUUY5?=
 =?utf-8?Q?Sei7kyXZtkQ=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SWtRVXh5YkhoYzFBdTRBbzZTU2lnS3hBc2dvVUc1OUM3RENXdHV6SlFmM2pa?=
 =?utf-8?B?ZTBJY0tZRW5CdEQ3QXBSbFM2d0FtaDVUOHJjT0hzV0M3eHNhVTdxYlQ3V01G?=
 =?utf-8?B?cys5c2VuczhsV3J0OEsxR0V5REhJQ2RwTW5PNnl0YlJ2TzBPc3dPMnFHRzNQ?=
 =?utf-8?B?amQvOGVkRC9kRW5yMXBUQjNqQ3pXTlI2N3BYYjdhWks3UXRQRWNtZng1SWdT?=
 =?utf-8?B?NXM3QkhmdXd5YUo4WURKeWozdmVGbHZHcTBnTnViT2NFcTlCWHo2OCsxaklu?=
 =?utf-8?B?ak00VjZCOHB4TkI4cDRmQkg3Qit0UGs3WEFhZmVHS3lFVTd0a1ZQb2VINFQ2?=
 =?utf-8?B?cEFKcVdXaFY3Y0x3ZHErc2ZhRkhFck9Dd2wzWDIyV0dYUzFXQW1tQktlT2ZL?=
 =?utf-8?B?MDJnSm1GY3FHQitYWHlkVDJVWkhaNGpuelBNVDZ4QWlKNTRqc2RxOFQxVmMy?=
 =?utf-8?B?aXBmeUM3Y3E2eVVaUkIxSTdLK3FxaEt3TnVuRHdQdy9LbDhLMWVEVlpCcCs4?=
 =?utf-8?B?OXN4WjVKNm9vZ2VNbE9wWk0xSzh2dTJGeFRtOGdwQ3p4QUh6cUQzdXFKSVZF?=
 =?utf-8?B?dHRFd0J2ZGs4dkxIeFFmL0I4QmMwMlFibjdqZ0x6QVBGUkhxbGtxZmZCTmZJ?=
 =?utf-8?B?WHY0OUk1QTdDUWRvWWRwdDZMSjFXdmpaRnMzdmp5Z3BGZm9HRzdwdjhjMWZV?=
 =?utf-8?B?eW9NMXZKUFBaS3Z2dHo2VER2M0pjREU3QjcxemdXblFrL1hLQW0yc1ZQSHcx?=
 =?utf-8?B?WGZXZmpjVFFrYmt3N2RheE1ySndCUXNjNFd6MVFYK0paT1J3UXVLaDlTOUQy?=
 =?utf-8?B?Mjg4ZEdzeVA3UVo1ZkkzUFBNU29YZVhHSEFSUDNQbjY3Rzd0QStkaGkvNDBT?=
 =?utf-8?B?QnBERmhPenI1NEVEOGRVOFVkYTZBZk9BalRtTEJJYkhGM0FaVDFxdDhQaE53?=
 =?utf-8?B?ekpGUk83blNrMGd4Z2dIcG5HcUxqdXRad2tPMmNrSmRxT21RQW9VYVd6Z3dI?=
 =?utf-8?B?bjFaL0FkeExmZHpCR01wcFBvZk5hM1hMVEo3RElKMFIyaS9RMm9NQjZRT2wz?=
 =?utf-8?B?ZjFocE9rbXpZUktSSUZTWk1qekpSS01UQTA4YVJucTc3K0FzYUt1bkVweVo4?=
 =?utf-8?B?OUlPOWpmajhlc1krZWZQKzF1NE9oKzk2Rm8zOVJMODhpcWtJbTZzSzFNNDJ0?=
 =?utf-8?B?SUNYUmF3dFhvblZiWXhKdHl6UVJsS1ZUV21vWDFpb1FCdndUSjVoUFEzYjZC?=
 =?utf-8?B?RklxTytjVzk4R25Od1NXU2RSckFlMzM4WVphTXhTeUs3VTdDbitTRVVialRV?=
 =?utf-8?B?cXJrYUFQeUFKczMrSUY5OGFZU0ZaOE42OWRKVFR3UlFDRmh6SlcyZVRZK3Nl?=
 =?utf-8?B?cnhnQ2kzZkpLbWxCMkhKN3FiczNxNlp6Rmt6SDczd2pMZnI2QSt6Qm1vbElD?=
 =?utf-8?B?eW15Q0trZXFDR055Vzl2TFk3Mm9XUS9HczdoMGJsajdGUmYxc3pCQzVuUEt1?=
 =?utf-8?B?R0FwOGhUb3pRSGFkMzVDM0tBL0NPaXNqYksyN3RSLzhwMEFmM2kxRDhLUHlX?=
 =?utf-8?B?aUs3eVdXZjYyeEFNNUNRN3lTK0RhWXVRaUFQeVg1NnRsQk8xRm9kL3g4emZZ?=
 =?utf-8?B?Rm1wU1pKOHFxQVU1L0hiVWlDOFFqUDJxUW5Fc3ZPVk8xRjlvOEpUZW1BYWRv?=
 =?utf-8?B?Slk0cHJjRnlza1dLbG95N3FFUlk0ajRRZUhiVThsemNHWExSQzRrTU95cnZD?=
 =?utf-8?B?OENyT3BYeHU0Vm54d2xMRjVReTQxNzZETDU2RTUzMG5yTkp3cTBrMyttbXRH?=
 =?utf-8?B?R0NDSVlCMEpvVyt2eUxtV0JhTGw0L3hWUG5DNXlVbGJGL2JQbDQ1VWdVbmxk?=
 =?utf-8?B?dVFPc0dVMlh2dTNjMTZ0SFNXMjk1dDZiWksveFNQMHJVTXNrM3J6bG9PMmJI?=
 =?utf-8?B?bzBDa0pHaUpxZEZCSVI0Y0hZNDVEMjVXZ1AraDdBdVUxV3FXc0RqdEU4clZZ?=
 =?utf-8?B?TXYyZU9MWHhWOHNFRFdnTC9DV01TVVR4cENDWkl0UnhqOXZPcVpqNW9KbDN0?=
 =?utf-8?B?V0ViNU8rWld5dE5sRHAvajhMdjRDajEvN01PU0RONjRlZjI3MHdWUmd5bkd2?=
 =?utf-8?B?d3pqWmRFdm82anNhMmlxS1p3S28yWGl4T0VCU2JaVGFhVUY1T3hMbnliMEZD?=
 =?utf-8?B?NWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb7b2f56-fecd-4261-584a-08ddb4cf110a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 16:32:39.5547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hwVqm5e0CLGdaQtscrAX85Wt0bWPpYYYszpd9Lumi/7M02BPPDa3rOeqe2jnahjMCyi15QW89uyb1GD1iglFAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR10MB8102
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 26 Jun 2025 16:32:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19245

On 26.06.25 11:09, Claudius Heine wrote:
> cryptsetup and systemd-cryptenroll do not currently support encrypting
> partitions directly with keys stored in the TPM. For that reason a
> temporary random password is used for the initial encryption, which will
> get removed once the TPM2 token is added to the partition.
> 
> However this process does not allow continuing with the encryption
> process in case of power failure.
> 
> For that reason store the initial encryption password in the TPM,
> protected via measured boot based on the TPM2-PCR:7 register, which is
> the default for `systemd-cryptenroll` and load it if it exists.
> 
> Signed-off-by: Claudius Heine <ch@denx.de>
> ---
>  .../initramfs-crypt-hook/files/local-top-complete  | 56 ++++++++++++++++++++--
>  .../initramfs-crypt-hook_0.8.bb                    | 13 ++---
>  2 files changed, 60 insertions(+), 9 deletions(-)
> 
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> index 2b4bed02484bface7b0370e6ef1b9953e8ae4eff..9e7525117a03debdf2c526ab742e9428372cd0cf 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> @@ -216,6 +216,54 @@ if [ ! -e "$tpm_device" ]; then
>  	panic "No tpm device exists or supports pcr_hash '$pcr_bank_hash_type' or '$tpm_key_algorithm' - cannot create a encrypted device!"
>  fi
>  
> +export TPM2TOOLS_TCTI="device:${tpm_device}"
> +TPM2_HANDLE="0x81080001"

Is this address something we may want to or have to make configurable to
avoid collisions?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center


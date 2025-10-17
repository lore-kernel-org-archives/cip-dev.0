Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7345CCD19A
	for <webhook@archiver.kernel.org>; Fri, 17 Oct 2025 08:05:58 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.6])
 by mx.groups.io with SMTP id smtpd.web11.10640.1760688345826288498
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Oct 2025 01:05:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=VIrVMK1L;
 spf=pass (domain: siemens.com, ip: 52.101.65.6, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q0vEo2r6QVO/zqh7Je/J6VHoqvEy3FjXHnhfy795vU7lIegVlnf/BPK6SUK1/xxd7zCuxsnC6L2hpQIiS2t4fmJGFFZ76gRBG0IJAWuD3HvszvtQ0SCt87z9Ytqsk413yYtNAz205rDh8ExSom2oUMc/hDqEoB2l0eKlxL6mp6zr9St4l/Rz81UpZKt60y2Wko1FUuq7AWpy+0NJSyrjcXE7syCv0l924Me32MsHdOAPJNg+1AxbAOfVRYgQkbKI+sXuy13/GkeKmT+GUOUJsLhaw3ycZZ2DVTEzMI2gIBL/QRR4MTuThB/6Si01rmKbRrZ83WNU3BPe0adYXCM8JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KdA1HEI1p3+yXUMfMEFhRqVSs2USbpFCDK2ePIW4Ew8=;
 b=sNwyfhAIvLHiDOTrk1/AglQPPrn5hWVkdrDwpTX9TN0p6Rwhb+v+6xxmNa76/9DHE16GPq7zsn+AhB/VUEcE6pVpJvzWWuuANE9KxPFwikgpBx1Dn/auZq+6tV4xbvL8b2IdmztjdAM0mPI596nnH3o918upCJmZTZbRthv+ZYs86Cvz7AMpQGqTpUd0gyRfUBd6PRrivGWDwkh5kc+YrOwo+DAsZUa9XBmXmM8uJ45GVSfy0ze+hYSc9AInafaFbSM/nb1LTHZPXmwgMZ1kMOtrbRW5vuikV1+Uw7wpd1kAyVhcr4fHb1jX7g5zVOIS12NOisXNCgXXDSnHf14qxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KdA1HEI1p3+yXUMfMEFhRqVSs2USbpFCDK2ePIW4Ew8=;
 b=VIrVMK1LYFzPog5m4dHsRKnUzF1e8PNGTaU1FuV11F84bgWyGXVDqrx09Mw9tFgaBbqQDGyG4bP7hubPx/dvJ4+gsoeYfJJChpORQd/o9bdbBUy3iVuzUkjLVXc8UwPumWQc/+eDBC2j8wwkabhiPJ/k2cJDbdf4l6RZKfgwDA7ze5rVAcMqE2hhmz8lU0mul+fLBm0Ll+ryncTItMq0mSeNqtv2S5Y+G49XulUmzxS26z93IeWmIlM0OpBqfLVPLh1Oc9EnVyttBHiWYkZPKSpRQJ5EweKl2Q54g8G1k1NXDqLuLdlZEG+/wogoPCiFk21FBbcHR4+G+vAv7ubcGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6269.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:54e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 08:05:42 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9228.011; Fri, 17 Oct 2025
 08:05:42 +0000
Message-ID: <1898f0f3-cc2e-44fe-9fce-33720bd182d3@siemens.com>
Date: Fri, 17 Oct 2025 10:05:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 1/1] make apt cache world readable
To: Felix Moessbauer <felix.moessbauer@siemens.com>,
 cip-dev@lists.cip-project.org
Cc: christoph.steiger@siemens.com
References: <20251016135349.2030862-1-felix.moessbauer@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20251016135349.2030862-1-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0002.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6269:EE_
X-MS-Office365-Filtering-Correlation-Id: 80932f69-2991-4af4-4c69-08de0d53f76d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?VE1hTlpiOVpMTjBxV01LWHZGdXFBWVdqMDV5ZXF2RmJIbjduWHYxalBqU3dH?=
 =?utf-8?B?ZUpjZUV0RGl6NjJsUzJyNGhzcXp6WnVtOHJ6ejZqd1ZWNDVPQVQzL3FTbDlY?=
 =?utf-8?B?NjhLeEVPclB3dW51bnpudVBqRG5nUkp6ZmMxUUFBaWtVamdPVU9Kbm9yMDVw?=
 =?utf-8?B?MWhlV2dZcks2TTF2byswSVdSSGNVTUlBNnBaNWFJZVZtMlBtd0RyNmpJUDlT?=
 =?utf-8?B?RVJ4MmhJN3NjUXppSkFmcU4zNTFtcW9od2xBRVJqeVZFWktrbjJiSjdKcjhq?=
 =?utf-8?B?aVZZSkozUEVCSGw2YmhVN0JGVGNrNFh2Y1FMQW5tZklDUnhFR2EzR1F3VjZV?=
 =?utf-8?B?YTY0QTlCOEZENUFWRERIaUY1MWEvZDRONWtnSkExRnJxTUpqZUJQdjVieXly?=
 =?utf-8?B?YXVVTFN4RkhqQUpHdEtpaGdyN1ZzWmJrWkVZWnh6eUpqSThLaHArN3RNOXhF?=
 =?utf-8?B?R1ZwbGI0NUpsMkVneWpQTXltcStNY0dmVWJSbmZad3FJZmtTdkorOTRnejJ1?=
 =?utf-8?B?cVprVzRhWjhrTC80Unl3QzNTZWVmZTlJc1R2eXFXM0JYSHMvWDRrVHBJakcy?=
 =?utf-8?B?d25KM29Cd2tNWjRKejUwNGc5VHlnNEtJdWE0eUg4WUZ4L2VNS2pIL0pCL005?=
 =?utf-8?B?MUhZOURiVk5ydWFCNXQyU3dOVVZqcHZFSWJPS0dxN0toRzZhdGMxR3pxM2h6?=
 =?utf-8?B?N1pxRm15UUg3MEdmeWNmMmlNRFhLbkYzcW9vazFndlNrL1VJLzlMWW9sSFox?=
 =?utf-8?B?U1lFcWxrYVdCTnp1aWhyNUFoTGEvcU96TEtxZkxnWVpGUnllS1lZQysyZzlJ?=
 =?utf-8?B?Z29jNUNQbXI2VHJKV0JXUVpHT0NtY1BlbXZkaU8vTm9KK0FQSUQvZFNzUnNi?=
 =?utf-8?B?K3JkVXNqQWhKbGVqVGlqb0EyVzJ3WUk2TTNZNlJFMjBqaEVjeGQ2c1p6R0cw?=
 =?utf-8?B?c2xkOWdzQW54UG1IT202NStlMGduN1g4cnJrcys3ekRIVDkrK3FyT0pFTjEw?=
 =?utf-8?B?Vnl5S3ZQSlAwL2NsaExmMUJSVHdEb1FXNjVCckhJQjF1TkNJUjBsWmZCb3l6?=
 =?utf-8?B?SEE3dEF0N2hJRGlqV05nSVJsb2tWWGVsSWxyQzBWTDJBamRHbnpJWHRDTnhp?=
 =?utf-8?B?dStpQnJxeHhFdk9ZNUk2WXlKT0tJU3BYc0hvaHlJNHJrVCt4Y2VPZnkyenpr?=
 =?utf-8?B?Y0lJZk51NEluSFJPaHBJRjVIZERzdVN0eEFPRmhJWXdCNkw2ejB4VTQ5bWVQ?=
 =?utf-8?B?NVluSk4vV29Ob1lQakVGdUlCMGNOT291TllDUm1GTzZhSTRWOTByNEQrTDQw?=
 =?utf-8?B?ajZtdVNEYkhQdHA2c3c3Q2lHck94ZGNvNldaRldWSm5wOGovc05YcVF5UXpQ?=
 =?utf-8?B?OGlmbVBPWjhWd1VhOWxaY0hpdDlFSmh5T1NtQWZZbFdjaFpPd3BBdlVkemFO?=
 =?utf-8?B?TDVkVVR2OFgvSjYrMGxaUVVKUnJXcGVrSHJOS0lDZXlYazBuQzdQbSszNmZZ?=
 =?utf-8?B?Rk1vQm9uQ2w5cjJHcVowSmN4cXNHTGo2R0I3K1FvbFEwTzE5K3h3SzM4UWNW?=
 =?utf-8?B?eTcrUi9SYU1tVGQ0cHl2aFQ1bCtPOFE4K1gyUXhXbUlTcm83UjNKWWVPajJT?=
 =?utf-8?B?Y1pZMytNaXkxa1BpbVJNRTVJK2Nic0dXUzIrajZPS2FDOFg3clB6VVJVTTVa?=
 =?utf-8?B?ajQvcklHT1VPOUMvc0NwM2lSSzYxaU9MSEgraUJjb0h3TGJ4QytsYitBUFg2?=
 =?utf-8?B?dzJwUFVTQnZaTWlpQmtrTU9GSWordlRodEx1S3NtdEgvNWhUdWRsVkJCOFFa?=
 =?utf-8?B?akllaUVqeUhPODZ6MzhVbVpCdlpjVmhwNXhKMWhRVE9OU0NrV285T2tpTUpY?=
 =?utf-8?B?MUxmakk1dkExaEZleHpsNVVSNktxRllsVTF1MGN3R0RVTVcrMGpFN2RBREt3?=
 =?utf-8?Q?NW2masf7ND5ExY6Bh5XgxLwaSU6MCBPA?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VmlzMFRRV3E0aG5XcG5OV2xkMWNQY05hWU5OVjFxYTMrU2F2RGFvTG1WTEZG?=
 =?utf-8?B?UnJENEhGancrcFVrL0NGT1BNRmczYTRiYjFiRVhsZis1Vk9VNUJtNEt6ejdQ?=
 =?utf-8?B?VVVFT2RWMk01blYvTWpicHBWTU1vS1B2aGJ1dzh1UW5UWmZmZHNWVHRRVkxI?=
 =?utf-8?B?K3RsN01BZFhpYkpWTHhCR1NlM3RFcVdpU3hIK1NwNzBDNm1NU01HaXR0aXk0?=
 =?utf-8?B?NDM5cjVBQVNZVXd0YVNNSHduY3ZHTk5yRFI4VFJyR0JubU5xZlJvWnN0a1hC?=
 =?utf-8?B?NTV1NnE5T1RVWUV4di9hNlBrdk5aMGN0VENCdlpmU1h3OHlEclZHWEh6RjBu?=
 =?utf-8?B?Ni9TbE04YlBTK0xSYUFSWEF0UTFPR2dLbklDU1lXSlhtWFJ6TStGZmJHbXFP?=
 =?utf-8?B?UnRvRUV0OHFaZnJmc3dTdzFjZFFGckRtMnRpNUhtVnNZazZrSDNiMUhQZUlU?=
 =?utf-8?B?Y1Q2Nk9Ndy9peEV1TFFmOWphRDNqVFpRckMxSUxFSVVPc1F6R3RJYjZIazM0?=
 =?utf-8?B?cnhlV2pqL0RXcEk5UmJGb20zWGdpb2RJcVZQbUtOd1daQy8zcGs5M0hkY2Q1?=
 =?utf-8?B?Ym51NTZTRjhvUjFVQlpycG13Yk8yaitxY0VYWW1qRlJ1SW5KeEFxNEdTeGh0?=
 =?utf-8?B?Y1N0NnNrL3hZcGROMXNlNkpvM0MxQWYzd1p6NmJBak1oZ2FaV24rU01NRUNy?=
 =?utf-8?B?RVRJVXFidG1VMkRvUFJYdzVTTDdmUWR5Z0FwZjlwVDNhWVN5bzltRkhDOWJl?=
 =?utf-8?B?bk5lT080M3AycXNxUC8zNkxyNDdlQUJnT1pjNkNjVjB4V3htS0RWY000RnVk?=
 =?utf-8?B?bTFCbzEvdHFLRW9JZ2dSenNYUkRjazZiMHZwRENOeFpaSDR3MHlWdnFNaUsw?=
 =?utf-8?B?V1B2MFJZVnZLaXRSYmVPeGpBbGZEakhPRWVKTWxSQUpjZ2tIc0RHWVRmUmdu?=
 =?utf-8?B?clIwdFhDK0xxYXRBbEJZYklFRnBZSHNwZkJaN0V5TWFUYURBMDBXVVVKM1ZR?=
 =?utf-8?B?ZzdMVEFEL0pZcHRJTFNCRDFJdlEyS3hDbGthZkVJMm9Ib3NvalJCS2xGbm12?=
 =?utf-8?B?MHY5aEd1VDdRaVA5RTNCYjhhVUVjTEduNHowYmJ0RzJ4aE5rYXB5dXhMNTdP?=
 =?utf-8?B?cHlrRTFyQ0EzV2pDM3RiM1MzaUhaN0lVUHBkU0RDWVQ4dVNBZlZySHVyTzA5?=
 =?utf-8?B?SmF5bW5tUFZCVncxbFBIQkQ3Z3JMYjVQckFJelNxRDNKL1RaSzRQTlpEa2hi?=
 =?utf-8?B?Tittc2loNkVTWFQ3RTliVnBoYzYxNnhUUkd6NTFwYjFENU9RWGRHamVrQzZu?=
 =?utf-8?B?emkybFRaamRnaXBveFdnRHRDaitkdzlwRUZKTUduUTBKOGVTbmFydHF4VXNt?=
 =?utf-8?B?Slh0T1pNQW1xcHpXZzNBT3ZsaWtHdDBJbEFqU3E0azFPbjVJVkJON0RTNTVr?=
 =?utf-8?B?MWxLbWg2YlhmeVd3WlhVL1VGb01TWUlTT2JwbTNJVWxhWDJVbUQ4QXNLQWZB?=
 =?utf-8?B?WTdJSkdPODVqM0Zhd2ZGR3pnMnd0bUtEdGczRHY1WE9CSHVBTVN5enhySE1B?=
 =?utf-8?B?cjJmQnJPWWNWS2graGk1VldpRUdSNzVtL01pOCtPSFdpbkp1MzlnMnNsNjJM?=
 =?utf-8?B?cWJhRTlmcXhKWjJ6SXhiYTdONTUyaHJGVXFCd3VETjFJYk01VWpoWWFXSnE2?=
 =?utf-8?B?dG11a1BvRzZNRTRyNkF5WFlvdHVBcDBPZzNraVhCZFN2bDVPV2ZYQm1yL2V2?=
 =?utf-8?B?WDV3YkE2WWw3aUtoK1BmUzNiZEozdWRUTmRKNnJSZ0d6TFRXbVlnUjR6Y2h3?=
 =?utf-8?B?ajREZ2pSaVdMSklFblVEazRzaVRIdE03TUZYakxISnFoY2JIRGlhQ1NNK1U5?=
 =?utf-8?B?NW9jQ0tSeVV3ZG9yYm9pLytHdnZBaUN3M1FXWWNOdEhWVXNxMUFuYkhCbVdh?=
 =?utf-8?B?RmpvYndSYjhxRzg2NHoxVm92Y1NqNzlLSC9zcmZDTStJaWMwR01Cb0dPcEN1?=
 =?utf-8?B?NjR4S1NlVW5SS2g2d0dDSHdHNGQwd21UQnQxdlB4K0ZrNTlmeG5NZ2Q5SWdQ?=
 =?utf-8?B?dzlNRm13cUkvY0pDTkwvTWNjZWp2TGtFaDNHRkxrM2pwSzFLZGRsRmQ4VTFp?=
 =?utf-8?Q?qnO/eKj/g+4WpzbJskYy0SpUo?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80932f69-2991-4af4-4c69-08de0d53f76d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 08:05:42.1807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2wEuCkcC+B0P66ZsElbD3KenieZePu+fzk4Zu/QfJPDIeU2rkVUbDRKPK6pcqM2B1mSIwmf0kgCtYXl6Z//xow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6269
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Oct 2025 08:05:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20193

On 16.10.25 15:53, Felix Moessbauer wrote:
> The apt cache directory in /var/lib/apt has default permissions of 755
> on non-ro systems. By that, unprivileged users (or tooling) can access
> the apt cache. When running on a ro-rootfs, we need to create the
> directory using systemd tmpfiles, as the system is deployed with an
> empty /var. This should be done with the same permissions as before.
> 
> Note, that this should not have any effect on the target systems, as
> we anyways wipe the apt cache before deploying. However, as this
> tmpfiles snippet comes as a package, the limitation already applies at
> assembly time, which breaks BOM scanners that run as a rootfs
> postprocess command.

But not as root inside it, right?

> 
> Fixes: 26763b3 ("create apt directory as needed by apt-daily")
> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> ---
>  .../immutable-rootfs/files/immutable-rootfs.tmpfiles.tmpl       | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/recipes-core/immutable-rootfs/files/immutable-rootfs.tmpfiles.tmpl b/recipes-core/immutable-rootfs/files/immutable-rootfs.tmpfiles.tmpl
> index e8e58b3..e6d25d2 100644
> --- a/recipes-core/immutable-rootfs/files/immutable-rootfs.tmpfiles.tmpl
> +++ b/recipes-core/immutable-rootfs/files/immutable-rootfs.tmpfiles.tmpl
> @@ -1,3 +1,3 @@
>  L /var/lib/dpkg - - - - ${IMMUTABLE_DATA_DIR}/var/lib/dpkg
>  d /var/log/audit 0700 root adm -
> -d /var/lib/apt 0700 root root -
> +d /var/lib/apt 0755 root root -

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center


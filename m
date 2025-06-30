Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C94C83030
	for <webhook@archiver.kernel.org>; Mon, 30 Jun 2025 20:10:22 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.26])
 by mx.groups.io with SMTP id smtpd.web10.50770.1751314213727208847
 for <cip-dev@lists.cip-project.org>;
 Mon, 30 Jun 2025 13:10:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=spOV0L5P;
 spf=pass (domain: siemens.com, ip: 40.107.130.26, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YrfdVUTexH9pH+xyCMGtBO8wGodCFliQXxFqDvvcsygXmivRTrL4ZQgJsXAVLeIrKSQmFg4xW/a3GuOYiN/Y0BGGKJS5F0PN63Wek7yN95hS1W7fkuMGBDNo5+q3sPO+WhKyDVUtbXSiu46ucv9MjwsDsH0FH5ypvp6rOjYtGLO4xxTkgKqO6C3VMQa9vU5a9tBOmdlvFnb6EbfhFyE25qseoy07zf/uD9htLHOt6L4gq6cpQnbVegvhf4qyg6kR86S0RvS/zv+0w9Th2fba9L/8CktlGsx8N9cGzzw7IEfxYuxI8iP/6U4bJXf/g/wWqgJGH8J5cd0KeEOP++/lDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5x0XTkIg++Ho1b7xiZcU3bZ46ZXWcUT1KJkhDwzZaaA=;
 b=Fc63IBIXfs1kCe0w+Sji6JQRS2ekIb2smvsrTVuNk6beZszIrh9UtxkAc/4pLzNTohbj1op80LQgRPupQiUdUYKWTQgpMZeHdu8Za6WVpef7FPIy00nxSAjGcezDzIw4IZt5ApzrlDvw3DYleUD2d9IWcrqBFH998Jl6bIzdeKsnMNVX8hA+chodaXUembGB+vsvxhW2vIBdJeNt5vYveDigGbwRYgwklr2MkcGvCDivgCMZAare9d22AyvkefWYvn+4XjPcVZWEJwC+KkGh6M0QD8K9dhSvmyTiQ3zLjVcLPfzJROEI+tR1c9tk8qVzQDvK1BxEZArG4ggge5KRHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5x0XTkIg++Ho1b7xiZcU3bZ46ZXWcUT1KJkhDwzZaaA=;
 b=spOV0L5PYtWhY/f+qooT+3ErnAWzLcv1KaknAxAJ1B7rwTRlD5Gft35N0/TtX0EJx2jLGPf0IqIeRLDhSw81osaSb903+UFBtQ/TVijToPQKCzR0Vg0FE7wC9dtBH590CqWIToLWEmi0YE4dZwnM/ZqciKGn1Fusyt4XpZnJ8853cuTxr5P2lMWAfKNhQ1g8lrtqE3adJIjiCwxW7d+ynCaoA9PfrsadNnWV/SfJTxsWvfUx6KGQK4sjZZOxiSAu0kihLfilGRq3+h/09OzFKEV9nc5b0OvZ5v0I9hTIzAdZy/qeKbBoPiET7ZYENvcflzsWe2ab0CmXN6DYfygwIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3745.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:14e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Mon, 30 Jun
 2025 20:10:10 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.8880.021; Mon, 30 Jun 2025
 20:10:10 +0000
Message-ID: <881c1466-0b98-4f48-9faf-0c7c65cbfc57@siemens.com>
Date: Mon, 30 Jun 2025 22:10:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][RFC 0/7] Immutable /etc
To: alexander.heinisch@siemens.com, cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com, felix.moessbauer@siemens.com
References: <20250630181516.1718712-1-alexander.heinisch@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250630181516.1718712-1-alexander.heinisch@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0119.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3745:EE_
X-MS-Office365-Filtering-Correlation-Id: fa873078-65eb-44e5-da8f-08ddb8121d45
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?eHFDN3B1dUVGYVhyODB6djQ4RTZyd1ovc1kxc1JiMFl2dVFYTDFvZWIvTHpi?=
 =?utf-8?B?RkluQXozQ3JacGwyZkxXWWljUTFIUEZLNlduZ3Mxblh1NzV0S1dsSWFBMDRa?=
 =?utf-8?B?aWhaU3dJUER5N0tnTit4ekdkTWp2dy9MbGdpeStoYTVJYkw1d2pkRXM3L2M1?=
 =?utf-8?B?Y0E0dW1USDVhYkIxVUwwSVVmaUFFaUJMWXNSTXF5U3FISGtEcU9uSnU3RCs0?=
 =?utf-8?B?M3NrNHg4SllFUkxOK3JpbEg5d2RQUDVsUEVnV0htRTNEb0VUdTR4aWl2L3RR?=
 =?utf-8?B?WldMQVpZN254dkFIQytxb25BRmI2N3ZOS2NZMGxPNU80QnE2YzNFeHRNWldj?=
 =?utf-8?B?djAwRHBqTUhIbks3MUNZblFZelNWbUt4V29sRjIzYXZKZDBGbXF3Y0Y2RXhj?=
 =?utf-8?B?ZHRqaUdJMm0vTFRYdUhVQWIrUit1TVIxWkc2alhKZGFCVUEyY3I2Y2xHSUVs?=
 =?utf-8?B?elJ2MmxEUU55Y2xEMDVkV0ViWGhMdlRNeUpIYmZheENBYmlNb0tKalc1bExD?=
 =?utf-8?B?QVY2d2Y4a2h4Nm1CK3AyZGdnK284WnQrYVRVZS9rL3FlSkpiUWFFV2M2UFp3?=
 =?utf-8?B?RSt5Q3ppVXlNeTlKSHBzL1BPTTlGMlZtd290RXpKMzNsRGJ1Wk9xdzNyMGlL?=
 =?utf-8?B?eWVkNWF5ZTQ2ZVB6ckV1WkRUOFZFMzBnczZwL3Z3V0h6Y3ZwbjAwdEFPQ05l?=
 =?utf-8?B?WWpHOC9ra0RHT09hR0tVOWJsZU1zQWt6Q2pLckdXRHlLaE40cUp4THdxUktX?=
 =?utf-8?B?SHFWaHFPdlVjSEgrYy84QVBRUS9SOFNTQkZqU1QrS3hIM2J0MUpkS1ZlaHcx?=
 =?utf-8?B?dW1tVUhwTHRWVUtCSm8yTzlUR1Y2SmREMTU2UzVLSUk3aTFLRTVZNnVsUk51?=
 =?utf-8?B?K3d0Q3F0K2pnWjJ2K21lU3l6MmdVMDAxOU4xRHp1OVR1aDRNTlFUTktDSnJy?=
 =?utf-8?B?TmdtZ2VuaGtNWFAxSHpHcFNzelgvR3ZzWDQ0c0xMVDc2aFM4ZUMrdzdkQ0VC?=
 =?utf-8?B?UGtaVmhtdkIwMzhXYU9qQW16WmJZc3pVTER3bFJuZ0xEcGxlc085S3VFcEtq?=
 =?utf-8?B?by9Na3VYeTBXUDBrNkVwdUhhV2QvRnVIOEVEdkhPSkVUcWU0SFBsZHYydzYz?=
 =?utf-8?B?aDR5aDRZbDhGVGlqRHZWWDFmNGhkQnM0dVhEYkgrYXBzN1ZSQ0tsaEFueVNU?=
 =?utf-8?B?dkE2UTBwbjZvcDFFbDNMenBrSlVtK2NhenhnZUM4aTRLOG9Wb3FQRlZpenYv?=
 =?utf-8?B?ZXlSY1Z0MFdDZmNaYi9mWkw0VGJpNlhsdzVkWVFGN2FiL1pUbkFlWE5qRW5H?=
 =?utf-8?B?TWhuUitOeEw3dklGcTJESkNETVRWOStBWXFOYVIwbWszRFJmdlhYeWRyVTBN?=
 =?utf-8?B?RmFzZW1XTGlwdWlVbnFlOFZMYldtdUtEa251bWZNSU12SUZyR1lubUFIbkRP?=
 =?utf-8?B?MXdlQ3gvMmk5aXJBYkdtRmlUb3NXMER3WTZPaU54SUxVeXVrOXh2S0hhVnRR?=
 =?utf-8?B?OTdmdU1DV1ZnbFZrbSsyN2V3a0w3MFZhRzBiYTB1VnE4ZzdhaUhXRllLb1A0?=
 =?utf-8?B?bDVtQjhGZGRmNk5TajgydjdCQWVpUW0xOTF4NVU4NkNjb3VIUHIvaWc5dURh?=
 =?utf-8?B?cmZkMlhLUFlpa2NaTkIrWDhwaDl5K0xaU1ZWZVNBZko4c3BTZGRRWUNWVjRv?=
 =?utf-8?B?VmwvYjhKTEp4WDJCSnNaRnVuQWpPWk1qcVZkQ1hub1ROTGY5WmFCYnlQSUcr?=
 =?utf-8?B?SXBSVTlZb3RKUmIwbE1BRTZtaGdtcy9CR3ZIZks2R00xTU1TcXpiR1dBb05J?=
 =?utf-8?B?eVJBSHlDcmRXOEo0MXAxK2RDakdodnBYU0xnazcyWmM4VVpLQTNuL2t2cGJi?=
 =?utf-8?B?eDdlRWY2bTYrd3VnSWo4MHAxZlNFQ01FUFI3Y0tTYlM5QzRJZVBsTkhYQUtG?=
 =?utf-8?Q?4NxqqsYT/9o=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZUJmZHF1d3M4ZFFiSjJsbVJ6VVBjWVNSZjgrVjU3eTBaSkpnMkthL1FJTG9Q?=
 =?utf-8?B?eVAwQVEremoxWVl4NFFSTW9wQ2pLcmN1L2J3V1Q3WERETHY5Rm1WOCt5bXdw?=
 =?utf-8?B?TkJNNXBURFp5cTJ3R2E3dFVmOGFmOWxveTdxN1BUL2lFcmhGemUzVEtCRzJJ?=
 =?utf-8?B?cjhTaU8wSk5VNG14NjZMcmNxRHBOKzd2UVVtbldabWJzNXdnbkJjWnZZNCsx?=
 =?utf-8?B?cFRXM1lpU28rT1p6My9XNVFuU3BkbDNrWHZBUndwUWZ3a2MwUk9iNFM0Q1Jq?=
 =?utf-8?B?YlgzblNma3NTOGRMeWJtWTVkMURBeFAyK00zT1QxWU5VQnYraWJhYXlZMWR5?=
 =?utf-8?B?dXcxMEY5S25IL0FtYjhRdHlFUFczSFJpOTE3NDNic0FQbnd6bWU1K0xwRXds?=
 =?utf-8?B?RGh6d2JMSTNqQmdaQnNDaisyS2U0Ny9YREZXVkhvUEFJaFZ0b05ZZlo2NzRR?=
 =?utf-8?B?ZTZNMnVJUWx5THVTdlA3Z2tmaXp3SXl5OHEzL2JNRVpMYWx2NW1RNHRmd213?=
 =?utf-8?B?NkJybmZwZGU0QTQ3ckNVdEdNcTc3QmxnYU1YYzk4c1UvQTZ3czN2M3NCSkpl?=
 =?utf-8?B?NEZseGdOQlN6NlpxRzNSQ3hoNHVWVncyZHpORVBqc2g5R1BkTVBJZU1yQVZW?=
 =?utf-8?B?VFJET00wcmd4RXlOcGttQ3lhaUhPeWRBZ3FrNGtaSUYvV0VGbEtRRnZiVllo?=
 =?utf-8?B?K25lZjZVcm9uK1RIckY1dE5ZRVAvK1MrTnNzaVlEbU9ZY0NJZWlDNFY0ZTJn?=
 =?utf-8?B?SjFKNVRYSVlQeGF2S0pkZ1NnN2ZWNXE5QkdYTDR2R2lYU0Q0T1puTTRsU3k0?=
 =?utf-8?B?TXM1MjFlTnFIYjJNL1pCVGFnY2cxN3J3TWc3RWVIbGZLYzlqNFBqVWViQUcz?=
 =?utf-8?B?NEE5dmRLODlWSTU0RFl4VzNyeXdoNUh0ZWtCbFlNTXBqS1FwRVF6VW8yeFF5?=
 =?utf-8?B?YzkrUU9SRm43VjJOa2RDVFpGR1NMcHpuS3JkejVtUHl6MzZvYmlNaWIva2FM?=
 =?utf-8?B?c3JaZnNPQkVCWmFlYkYzQnc2NUhCdFc0eVFwbEQvSW1KN3ZHZThBOUlua3Qv?=
 =?utf-8?B?eXB1Y1FiRUpRbHJpOHRLY2lyMmVSNWc2cjhPTlJ1WFdDOWhnTDZ3U3NUNHZn?=
 =?utf-8?B?ZXN0clNUSEdNajZTdCtZaW1VNW96UHF5T2FrWGNXM3dSck1hSDgwWVVmWS9Z?=
 =?utf-8?B?RDYzQWwzSlFFc2hJYlVydHVHZHk1Q0FhYVZCMTlmNzhBcis1N3liTWJkMzJF?=
 =?utf-8?B?Qmk2QUREamloZXM0bEVpOEhuazZKUGxnQWRrNzRHOFFKUkcyMFA2RUYvQmJC?=
 =?utf-8?B?dzNzNmhVdzA3a0NWVHg1aFFJcy9Ja2VuNkZKR3R1anJnb2xhZVBPczMrRmRh?=
 =?utf-8?B?VWoxZmJiRnlDdnAvY2hCVWVyaC9PZ2xsektCQkdXdGtkcUJhNG83L1Fmd2dF?=
 =?utf-8?B?ZGZRTEhYWDRHcm4vb2xhdVhuRlQ4bkhtY29YbnoyNzVaUlJhSGVZWnpvL1hz?=
 =?utf-8?B?SHhFVVh0T0tlUThkOGpGNnRKbUoxYXAvWGpDWnFWcGVIZWtlalh4ZEJiTkFy?=
 =?utf-8?B?OGlIYmxSUHcwU2xrK204VTZray9nZ3gvREZMcnpJRHpFaE5DaWxzWnIrODNB?=
 =?utf-8?B?YVhjTXIvb1JKdlprSXNMM3h1RGF1bkw1MHFMUnlnUFhyVklrdWU4cGRqUTF2?=
 =?utf-8?B?TVpLRFZ0QXc0T3JqYzNGZWhaeGRrSzgvcWt2aGduRnhkL2NCSDJvOHNrdzFy?=
 =?utf-8?B?R3RBTkpRcGtoVXJrQldkY3E0T1cvRUZXQjRxd0ZTcCtLTFBkcStQM2Iwb3hX?=
 =?utf-8?B?VlQzRUw5akJoc1lYdzYzNDcvUnN2bS9tTDdGRVFjVnQ0dGQ0a0JtRE9uOGhW?=
 =?utf-8?B?VGpVR3NKMERjbnRqb05MZnNEcitPTjdpQnZuNXdUUlRFSjZZWmRrMzVPVU1R?=
 =?utf-8?B?MUtPL3QvMXRyR2t3QUVRanc0Wk1QSmNnSUlrUjQ0QzdQVEkzMFlKYjVaTFd0?=
 =?utf-8?B?NnZiNGZYVklhK1RkeXJ0cnpmeGppUy9SeE94ZHNuN2tsbjl0ODdxQ3oyMWtp?=
 =?utf-8?B?cksyMXNEYmRhanhaRHRjMVFYS2N5NTRYZHRacklIZldMT1hmRmY1OXcwN3FM?=
 =?utf-8?B?VUllSDZieW9zWEpPT3J2NkxwcDVPbUNwQnpWQ29ySVBRMEhjYm0rdEYrNnpX?=
 =?utf-8?B?WVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa873078-65eb-44e5-da8f-08ddb8121d45
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 20:10:10.1025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Jktv2P7WgkW//lw8I3/dMcunx0LREJwKamvJfFBTkkncPvwIufyNOVnQLQDD7DFDvWdOIMGALgZ42oM0OX9ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3745
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 30 Jun 2025 20:10:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19266

On 30.06.25 20:15, alexander.heinisch@siemens.com wrote:
> From: Alexander Heinisch <alexander.heinisch@siemens.com>
> 
> **NOTE:** The patch series appended to this RFC mainly covers
> handling of /etc/machine-id (see below) in the proposed solution and serves
> as a basis to estimate additional complexity ro etc introduces.
> Thus, be aware that some of the patches included are not to be applied
> on next, (yet), and therefore, this patchset does not cover all
> cases and introduces some regression on the images built
> (e.g. ssh-regen-keys)
> 
> The setup used for the PoC was built using:
> 
> ```
> ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/6.1.yml:kas/opt/bookworm.yml:kas/opt/ebg-swu.yml:kas/opt/readonly-etc.yml:kas/opt/machine-id-on-var.yml:kas/opt/config-on-var-demo.yml
> ```
> 
> ## Background:
> 
> During hardening activities we identified potential
> security implications of having a rw /etc.
> While this most certainly is a problem when attackers gain
> root access to the device, it prohibits unnoticed configuration

You likely mean, that rw /etc "allows" unnoticed changes.

> changes by tools running on the system, as well.
> 

Can you please elaborate more on the actual threat model? I'm not a fan
of adding such complexity based on "something may go wrong".

> Further discussion is based on following observations:
> 
> 1. Many services don't need to be reconfigured during runtime
>    and shall remain static. With an (rw) overlay on /etc this cannot
>    be guaranteed.
> 
> 2. Having fine granular overlays won't work either, because
>    some services rely on files put in /etc directly.
> 
> ### Systemd:
> 
> Systemd maintainers suggest to have full /etc rw and
> put immutable configuration to /usr.
> While this theoretically could work, many programs
> don't fall back to configuration on /usr and if so need
> to be reconfigured (efforts not estimated yet).
> Further potential to reconfigure services (permanently)
> is still not prohibited, since in case of systemd
> /etc has precedence over /usr (/lib) based configs.
> 
> ## Proposal
> 
> Therefore, our RFC proposes the following:
> 
> 1. Having an immutable /etc
> 
> 2. In case of non-epemeral, rw-able files use soft links to /var/mutable/...
>    In case attackers get (root) access, this still impacts those
>    configuration but the rest remains static.
> 
> 3. In case of ephemeral, rw-able files (e.g. config that can be regenerated)
>    same can be applied backed by tmpfs and config service / tmpfiles.d
> 
> 4. In case of rw-able dirctories fine grained overlays are ok.
>    But most probably on hardened systems config tools exactly know
>    which files to touch (so use can be limited quite exhaustively).

Are we the first to propose such a scheme? What do others do to achieve
similar protection goals?

And how many services will now need lots of fine-tunings in order to set
up all those links and folders?

This sounds like labeling a system for selinux: Can be done once, all
looks nice afterwards, and then something changes, people loose
overview, and the whole concept erodes until everything is reverted to
normal mode. Such an approach must not only technically work. It must be
*maintainable* first and foremost. And I'm missing the latter here.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center


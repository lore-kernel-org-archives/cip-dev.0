Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 932BFC5CFDB
	for <webhook@archiver.kernel.org>; Thu, 13 Aug 2026 08:19:31 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.16])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14352.1786609166594951384
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Aug 2026 01:19:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=DC9cOTWu;
 spf=pass (domain: siemens.com, ip: 52.101.84.16, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TPNL3qCvkBBvZTq+ml1CbEwOF27ZGMsPsc+CsP0AkaJOJWXd3s/mLv4yUvrU+uSqxIzGYdy1Hf17PWCFPnyBz3K+uQCZFLEnUpcS6ym5SJoPrxJUPqmAPTmBx5godNFC65g/Vf1rKZk2q+MpeE0WKJAq56ZLPQz5uk2f9syb67BSRbv25s2uw4fJUC38lwyx+pT7LZMBMggC1Fzfp5hS4qnyC4em3UL7drW1Z1qPvgPSXQ78wR7FPLcIatsMHCAfqMDKprJi0EQR/v8bI+sJs7AYzrDCIXE8EDyCFdrfn4yLs7FA8bjpFOjtNIWGtIJ7DmjnPV+nVNtEk+/aHJrXGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FjzqnM72bsVGw9c04hXrODcYlVdRTBK+pKAXSshPNRw=;
 b=H8pSCnDyz6UBXPm48xMvXxGnUZ1i8DBZzHJYohj/eZMqprFFU0fEUgJUMPyccep2565mUTHdGvTUGSAJX+a9o9RJGUk1i8tHcEZHs5s5XrUtBprKavmsWrk6QMfldHhaUbdZle89QJWkcYarb6s1Yvmm5i3hyL6PBpgziFcNwdUYhE9ZeFmkXLpsqE5YB1mNh85KmG0/nLxKj2UHHV9wjR0022mGYSJvQtro3VAuE/lxV7En4xQOQnqSkklJA/YcE0NW2yt5xTitsYatcy9k2T/SUK6yFREJllGNKPXi2bi+hBh4LoDD4CQk5Y8dWeUq/ppixPRM3J+EhDqHaRcJMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FjzqnM72bsVGw9c04hXrODcYlVdRTBK+pKAXSshPNRw=;
 b=DC9cOTWuCKsAomEI6vXsW2WFkNok/8vxoJF6x3GoE4h+eO3HDrXNo9AMHapVGJJyBtpICTMExQbfz6Snk6+E5EBWySSrCGNNio+uEaS64fbfZ8yFr4HuJxt3nzvFb+JnyWgJmWr+GL3ovINDxXAt2ilVvkBQAqpNiyfPdd5mC/CkIsVx45Wm8BEvig6RpoS81MIV9/reNywAX3fq1OUd7oj1IuZ3cxBS+J77B1Zx98CwBqLaBeSuwDvwgd0wx87HhDSLiHsLrp4jtY7+Z7x//zjPQt9b5hV3v9rYa6PZr9WEcFTvE7kNh9DfcGq4G6QOnMhktbOVX1alp1LjRDgQTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB7734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1be::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Thu, 13 Aug
 2026 08:19:16 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0315.012; Thu, 13 Aug 2026
 08:19:16 +0000
Message-ID: <b186025a-ccfa-463d-9b08-66b39790f711@siemens.com>
Date: Thu, 13 Aug 2026 10:19:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][PATCH] Update Isar revision
To: "Moessbauer, Felix (FT RPD CED OES-DE)" <felix.moessbauer@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <18CB4BA7E4C4581A.4010738@lists.cip-project.org>
 <1a68ac7e7d8216e41324897946028482858d6bdf.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <1a68ac7e7d8216e41324897946028482858d6bdf.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0235.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB7734:EE_
X-MS-Office365-Filtering-Correlation-Id: a67c67ad-74d0-43ce-91a6-08def9139099
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|22082099003|18002099003|55112099003|11063799006|56012099006|6133799003|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: 
	z3ab41zmCR3b6lOyaPXv/ukdw96mBXZWPiJZQghyR5NZo/0n8z7HvmRpX4MBx2HgbVfoi3wpe20aGd4sQHQzUWrlslUhAFlkwfyLvHjWMxHhdylKoiclnmEjQrbXPTtWM2Bp7G0yeVf1Af6MawC0+UZjonvxRKLZvwUUOQoAJLZ8ftPXzuadpqml8sEeuMtTfU8zLHSpmXJeq0hgR6BvcEaBByPZAJYYwqQVCIGF0H/Co1QyoDew7mszLrVWcjqNa0DCdarWarHFBTnzOupuwNxLZ+gfXkUqC8Vo4QwDVF1gRGTecN9n9wSmJfJrlCbKDkDUNkure1wXs5UshRR5kQfaA7v7TjOZ7ec18jnuOzGmLl5mNmnQp0nE439yLX3rNj6euIdoHhHg5TsHLTOwB6TwjHySaZL0jhyrkD3DwFYn07ZRGLUWJ9FiO3RFs13lWvG4Emch1Zgfw/Zi1HRckYKlVgKk3mu+yNcNOsn5HnQDQ21ovQ/DnCckojec65IPgt4iQqRRc2akPJ0Hnp6adrqIqB54bCID77h5MCG5dPHqdVfLoiHCcKNMRMZZiIHYSfb0Wq/qUsdoPCYzq0smLSYdLXbqMiji8fl2DKKCQrVxxbaUL9t5pJ/xWkCZllt/1uQSLPvFNPK9vuWYDtlIzmpKi8hoo+DftkhhP6t41VM=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(22082099003)(18002099003)(55112099003)(11063799006)(56012099006)(6133799003)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dm0yTHFPUndybndpMUJ5cnZoQTVJSmVEMmR2NjhkQW9MV1NITlJ6RDlUd3Bj?=
 =?utf-8?B?dGVLZTlnUkFCMDMrQ1V4Z0JxbnZBWTNaV1dqMnoyckhTbDlxTWZoNlozTFl4?=
 =?utf-8?B?eVJPdzNtVVJ0czErQU5YMmlSbDkwNzRuVk5xdlRkWVV0U0dmd2ExaTlwSHBl?=
 =?utf-8?B?ZGpaNENJVjY4cEJYamExeWlDZm0yM0lXbld2NXNOd1Y5YUZKUVcxbGVXT01B?=
 =?utf-8?B?WjJzRGk0bUZMc3dwWTNnVldOR2x6R3NMbzFPV0FqbDVUNVFwYWpwN0EydzA3?=
 =?utf-8?B?eVFOVHBDVGtkTjNwN2VFNEJXZUtrQWJQOFJhQW9tQmgzaUVxd21pc2hzR2FT?=
 =?utf-8?B?MXhhVlV3eFkwZ1p0YmNycC9ZR25qQ3ZwZzNOeGJCRmpBR1czeExtNFQ1Vitp?=
 =?utf-8?B?bmdySkZmWWowMXdlRk9xeFZac1IyRTA3dlprQnVjRmRKWEp4cDlibFVvL2xM?=
 =?utf-8?B?TmdYREw2Y1hrNXVVaWJVMDBFSVBOM0U4UVc3Y1lla3hUaFJxTW44VVlLZ0t1?=
 =?utf-8?B?NEV0cEZRM2hsNU1hTENVVEs4ZnRUeXFIN3h0OUhaNk9URjJWNXJ5VHI1Smcz?=
 =?utf-8?B?cXUxZDVKM0EyNGV3bDJSN2M2NVJ4SGhkUGRsd3dYQWRRald0ZUxFQy94a01S?=
 =?utf-8?B?aDBzby8xUU5ta1YyMC9SMUxaS0g5M0lnRGhucnhNWk1wUUp0bkwzUW9ZaFlq?=
 =?utf-8?B?RDRKNHNoMGxGSHV0VThHc0sxMHdEcFBQMVQrYmpJMWdoOTRxTG5xUEtSRm5v?=
 =?utf-8?B?S3R6a2pRK0Job0N5elRsT1QzeXBEMS9pSDBET1cwTG8renl0cGhJKzBqRDB6?=
 =?utf-8?B?bWFBUEIvL2hxRU1ldHVEMkFCYldTUEFPNmdwdmVjLzl1cW1Cb1dFSGdGcjRu?=
 =?utf-8?B?SGc2eDlMa2lZdHJhcnJEWTNudmR3cEQwTTJGYzVUd2J3ckJESTl1OUxXVTdQ?=
 =?utf-8?B?dnQ3aWJHd3pKSEVDM2VVcEdPYnVvREphV2dvNk93ZmhFblVoOU56T2pXQ3Ix?=
 =?utf-8?B?VjVVSGt3WkIzL3Q4NW4ycVhwcWhIei94TjlwTmNCUjRGLzMxMkhKa0srNFhw?=
 =?utf-8?B?OVR2OFhaTy8xTXNEWnE3RzJ0M3BnSjZUeS9lOG94bFZySXJrMmQ4dXlxZEYw?=
 =?utf-8?B?Q2dGdDZ3WVFUekV0alAyTHBMZXp6N2xUdW9tQmdzTWRqcHYzZTZKM1ppME50?=
 =?utf-8?B?UGppOWNMMnJSbUZPRDZacDZFMnNGdU9WaHBNQURwZWU5Mk9JQU1oZENqd3hE?=
 =?utf-8?B?d2lxT2oyTWFCbXAwVkRmSGJOZ0sydHVCRWk3eHpDMnFBR0NpOVhvZS9PbS9Y?=
 =?utf-8?B?MjlpZUFBSlE2ZTBnVFVWb21YODhiN2duZnVVaWtjNVNBbU5hZHhSOHI2Snli?=
 =?utf-8?B?QWREbVdSaXFoMDJ3UHhNR0gvTTVIK3gvMkY5c3JUOXk1MEJZZWtMSXN4R284?=
 =?utf-8?B?TktkdmdsQmVYMDZjdUhJMkI3am9IQ1lmMlB3SEVGeWRaV0s4VkdqKzdCYWdP?=
 =?utf-8?B?akFSY2tKV2l2Q0ExT3lrUU1nb1p6SFZvTDJ5VkJYc29LY3M1V3JkLzBZZFh0?=
 =?utf-8?B?T2pWTGZlZ0lBamU1Y0tqYkpjS2FLb3hEUkdmY05kYVl4MWhzbDl6VzVvUU51?=
 =?utf-8?B?OVVyaUdETWNvbzZqbVlYMnhCT29YclI1UW42SW56SzAzREFiYU5yay95ZGg3?=
 =?utf-8?B?Y3FqT1g2dG9pYm8vWVR0RXhITXBKQS9DM2E0clk2Q2VuTzFXL0VsZDlCWENS?=
 =?utf-8?B?bkVxaUFoazRWY1VHekxaWDVZV0Zad3FNdUsrUkR2ekxxV2pCOWx1dC9HMUhS?=
 =?utf-8?B?bGRmL2ZjcUttbjZqbkg3NWZZb3ZSNE9uRThzblduVm93R083QjRYYjhVblBL?=
 =?utf-8?B?cWZhRUZzKzhYd2RYdmMxeC9QOTdJUDVQZ1F2VmZhTmtjNUt1SzdkVk9oUjB1?=
 =?utf-8?B?dnJMa1NkN2pURUg0Z0NIV3RkNzlIOCs0QTVvMDMvc1p3eDg3NjVZcS9IZEpq?=
 =?utf-8?B?d0tHMEpFbmlFNmoyd1V0dlpaZUNLUnpaeWlQVWg0ZlpVQTIrM1QxcUZIaVJm?=
 =?utf-8?B?QmUyeVByMm9oUWM4ZmpWdnQxVDdxMDZjTzJTTlVpL2FnaGR3MkhZb1lxdGoz?=
 =?utf-8?B?cDVVc1lkMGxOWG83aDQrN1JYcGFrUXU5RlZ3N09xQUd2QXNxUjdwS0ZEc1cy?=
 =?utf-8?B?N2k3Wmlmc2l0VlJMalBXby8weThZZEtmbWlySE1hNTI3V245VWQ5QVlzVFQ4?=
 =?utf-8?B?VEVyeUxwNXY3eFM1dHNDMkM3VUNLMVl1UGpleHdqMUFqVmV1NlozRnNINS9X?=
 =?utf-8?B?ODR0RGNvMFN6NHZndHlHYnJ6SnpGci9mYzFuVUxtSTV0WWQwMUUrc2hEbENG?=
 =?utf-8?Q?qi7DhgQJT8eLEWjM=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a67c67ad-74d0-43ce-91a6-08def9139099
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 08:19:16.1024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9lPkD0vwXVJlLVC7qiS9QiChyKhuwSxJ/+uEqwSGF8R8EzLDL1YLPTSX48V9JQZYa6rHcff21dI3imfTFrDCtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7734
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Aug 2026 08:19:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23914

On 13.08.26 09:40, Moessbauer, Felix (FT RPD CED OES-DE) wrote:
> On Thu, 2026-08-13 at 09:07 +0200, Felix Moessbauer via lists.cip-
> project.org wrote:
>> By that, we also need to update the firmware deployment again, as the
>> previous interface was incompatible with sstate in combination with
>> hash equivalence.
> 
> Hmm... this breaks as our kernel source package is arch / machine
> specific, which breaks the single-source rule.
> 
> We need to clarify if isar in general should append -${MACHINE} to the
> kernel source package, or if this is a downstream problem.
> 
> For machine specific kernels that are anyways just built for a single
> target, it does not matter. But here we build the same kernel under the
> same name for multiple targets.
> 

Hmm, it should be machine-specific. Is the cip kernel config causing this?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center


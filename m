Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 726FCD116F1
	for <webhook@archiver.kernel.org>; Mon,  1 Dec 2025 08:31:58 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.23])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16728.1764577909897651221
 for <cip-dev@lists.cip-project.org>;
 Mon, 01 Dec 2025 00:31:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=K1IufS4H;
 spf=pass (domain: siemens.com, ip: 52.101.84.23, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j3YoVR9k8BtwKEsNuynk5jGCWrcH3/j4Nw83m2E7bPY9QiJc+AqoOyC+nSGSP9tcwxmxQXJUX0IsCMQogSucESGRCJgUwgyEcRukgPEy96jFFhSImUw6u8UY/ML3CDKSBIdxFuvgPWwPeLwh4oL8KlUtLKYpH7hI2kEK5tQ7XG06Psq5YUQ1T97TOYUwuCNjeIWduAWZU6k88al73ecscZnAvsMdAaESsDCod7hZuY7BpSTzID/9oYUmzhIIXp5AYvrEly74PF5FOG53hRZ1xjwZKvS5t3loDJSxWSZIyw6OVz0c+n66cDPcMNlnGKUDY8iPAEcnSujKz6KuddVi6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KlKqehEnN3hB/IDdspgJl6IOsrmHG6s2avkRxxcJ/4o=;
 b=foHmyV1bZWhohJO8jTfiJNH37RPf57fVegdbC7o6Z52oxLUsImRT02/6ZTs2ADUSDe6FrN/DnYkN4H1TBpyWLtPTke7MuQbHotOUazbtGJDsi7LLUO/bLMPRezsAC4n6DHQ7sZg8XA/kIl2Skz9iundE8Uv1DnbN1THbJi5aS7A7zeQruP7O8WgqjDYM9lzg4/k7QGJq9MMKTB4zkYXWjxBoFNxpHGmjA/MrmLZYZPF9rIDCxfeEPv+Bx+8NN9Q1gMOAwjx7b/tShmYXvMQAOWttzAkLRI0jIPjwxsudBBEVSGkwIJ7pSIdS5CDpedFwqQSCjpJ3+N0kHWVHEFJIxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KlKqehEnN3hB/IDdspgJl6IOsrmHG6s2avkRxxcJ/4o=;
 b=K1IufS4HWVAr5dAAgR3WPVhzYzrtDATxogoKXGwDK0rGeTidg49voTDcej5l/cl3oAxbX/7Y/hy8rP5EjjlkkduRMqQmBkQd5wgalxhIT9hPUteP3ZEhRybnAuzqcDO5JgfLSBDvBtR4H0Pg22sq+CfsTRtIwa7Ewov2SNmHyrRVRzwarRzYr00LLCZIgxscDo8HrvJ9BcKanLlBYTwScCg1MJFmIEfAhofCnyCC1WgsUHHOe+zxusm8JY1J/wzAOrxKbD5bSZUmIvHkSAbEYqrFOyFtA9jyIK5qCCkQd4ls96U4tOtL3Dw0lG6kervjFxkhAynTNKDesyAhghp5og==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6932.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:417::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 08:31:44 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 08:31:44 +0000
Message-ID: <bbb91f28-1475-4b64-a2da-2883b784f1b4@siemens.com>
Date: Mon, 1 Dec 2025 09:31:43 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
 Chris Paterson <Chris.Paterson2@renesas.com>,
 Arisu Tachibana <arisu.tachibana@miraclelinux.com>,
 cip-dev <cip-dev@lists.cip-project.org>
Subject: Deployment of isar-cip-core images, lava images
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0014.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::24)
 To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6932:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ddd9b80-6a98-47c6-cc9f-08de30b40f68
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|3122999012;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SWZYOG11ZWJiSnFuNjIzNXpXd2NnTTNlcUlrNXczUUI5K0NGN0Urb2RIbjUx?=
 =?utf-8?B?OC9WK1ZDamI1L0JoV1pRV0N3ZndNQTQyQXpVcDcycitkSkFuWjhqVTdaVlVs?=
 =?utf-8?B?UUtxRnF3ZnJBTFBReXUweElUeXJ2S2U2TkNDM012OHVYQVBjTTY5MlBxb1BM?=
 =?utf-8?B?UWRaazNVNS9wRlFtKzBLVEkwbWkrd21JQnI4QzMxd3RwN3RkTVpCWUwrRWRL?=
 =?utf-8?B?aWVjeFFiNGVaTFZmbG1BdDROVm9EL2hBanp3a3ZKUUs2K3dvb0gwSmk1bG0r?=
 =?utf-8?B?ZE9uTWJtNis2ancxdVhqU1dSRnZaYWtJelY5SDFkSVhIT3FsNE5TT1hubERp?=
 =?utf-8?B?U1FNMjgyRWQxVzBZSC9tc2JZYzZoZ3o5VGRvSzF2eE0vUlJkTVVUZlFoZ243?=
 =?utf-8?B?bVBmdHBGY1hoK21RcmJVTzROY29uQncyZjFtVGpvblRLVXdPbjBiTCtpZjVG?=
 =?utf-8?B?TG0xUncvSi9DdTIwcmZzcXpua0Rlbmo1RC9wMTk1enpYVVk2TlRna1YraFVH?=
 =?utf-8?B?b2NLbFZvd3hiVGx6bnZUcDJQUnlKUWFRR2NBRkxXemZPUll5R0dyZDFOcDlK?=
 =?utf-8?B?MXFNdnY0c05jc2lBcEhZV3lFSDRvekxaVzlVSlN2bFFjY0VRTU41aEk4VklN?=
 =?utf-8?B?dmZJcEJ5ckh3RzA1YmJrNzZMK0JhQzNwTFJtU2l0TnNpaUgyOEhGeGFsRXp5?=
 =?utf-8?B?WWdRbzVWTlVVckVxTlR3TG8zU0Jxd1NxVHRaREVOclA3OHlhSFIvSXc3NFFD?=
 =?utf-8?B?M1Z2TzdVWWNManRyTHdRTXJaRnJrZlJHYVRzUGE2bnp0eTNSemFqODNzTERn?=
 =?utf-8?B?aGxYamFtYXBtUThpM0hFMCsxTHZtMmFmNFB3WmNQSnh2QmI3cmVRWVFqb1B4?=
 =?utf-8?B?a3U3czZRT3dseFhNT2daZHJJbDVvZjVlNGVPSG5ta3RVUnBYQTZSUEhGV25y?=
 =?utf-8?B?YnI4NjJoUGFjQ1k3cWtFdGZPVVM5LzVOdjROeVhPQXJBRGpmNy8zWHJ1UjQ0?=
 =?utf-8?B?aHNLZzhNZE5Fa283aysrQmJFa3ZFNzdmSGxObnIxRVhJd1JjVHZHS1Jyd3lk?=
 =?utf-8?B?a3ZmeW5pajZ5TERjY1FjbDRVb0l6WVk2UkR0YzNtKzRCeXVPdjhjcWFlNlFQ?=
 =?utf-8?B?UURkR0JzTkFRUHcxc3UrUy81SDZRbFptYy9sZStEMGhnUlAxUzhPVHF5dWpo?=
 =?utf-8?B?NDJZaU1adXJWSGlPU2xSMm5RWlpsVlI5SG9Dd2ZaU2RBYURVbkl6Y0pUNVRh?=
 =?utf-8?B?T2tDVU81L280MkttS0JnY28zMmtpRUFpaGo2WCtCc1VWRzIrMWxyK1lua0lJ?=
 =?utf-8?B?dktFOG9wMjFlei9uejhhSDYvYmNiUkVUZGpiOHlBdHBvUE5GdUpPcFJKeE53?=
 =?utf-8?B?Zi9lVSs3amtmUnhRaGhMSDIyUitrY0hTanQvUTVpTVpuRFlna1VZcS9Xay9w?=
 =?utf-8?B?VzhKbTNvRTAzVHIrQ2puRy9FZy9zeldSRlBXZThxSnE2aW5aSm5yVWVkVTFR?=
 =?utf-8?B?Qk96N24zMUV1OFJVREZwZ0I3SHNldW1ySmFLYWlnU3p2WGxjOHZVMzM5UkpU?=
 =?utf-8?B?SDFWaml3a2ZnYmFKdThwbDJqTWt5cVQ4MjNHanRCQXAySDhhU2NkSVh1eElI?=
 =?utf-8?B?OVlyZkQrSTJESXZZMkxxK25FNVBadWg2V3YyM3ZQdDNNeUhkMi9YYkdVeGJp?=
 =?utf-8?B?RUU5VmF2UHNWSGdQdHZuNzBSakI1VHVBalhjUkdxdStkYzJkN01SMVphUHN5?=
 =?utf-8?B?QllKbjFVRC9UQWppOXB3VGZ6NU5XWC81a3IvRmNNNjk2ZnNabTdzZEtvMGxP?=
 =?utf-8?B?d3o0aVNCZTdHVUdXK1p4UnVWWGpKMGFUSElLSXpIaHlvTEk3NURMcFVyNnlm?=
 =?utf-8?B?a1Z5WlN5WUhDN2pGM2hDeUs4OFR6YUN0d2RicjlSVi8wdlpFQVB3TjdIT1dO?=
 =?utf-8?B?ZlZjSGRZY2U5cmF3b2FqeldmT0JSOG5tTHllakJhbEYxTTlWTXV6NmtZdXU3?=
 =?utf-8?B?Vm01YmNNLzFnPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(3122999012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aHZTSnRxdTh3ZUZtbVJZVHg1Tjc5UW8wTnpreHJpS0F0QlJlYXV5cGJud2h5?=
 =?utf-8?B?ODYzUWpTaUl0bmQ2OUR0U2hiSVppRUlEUDNnRWpsYjE4UmtmYXpYVC8vSWVp?=
 =?utf-8?B?cUJLQXNDZ2hKUHZONGRRRWFFWG1FV0hCdDZmL0NsajR1cDI0amhKaGd1WThv?=
 =?utf-8?B?U2FHNXcydlFaY3VReDgrQUErdGVsUkdyVzFjQUNNRy9zbG9TSjNyajlJM2NZ?=
 =?utf-8?B?bmgwNkxYd3U0QkRsNHFZdUVoUWd3QzVhOHRtVVRNVDBlVXdRdGw2a0FaT3lM?=
 =?utf-8?B?WloyVnpNQVFyOUZVTzJkVzROa0hGWlhzOGlxVEF3R3p3R0d0YXJBa2x1bFpB?=
 =?utf-8?B?alF0VkpwTnhHWVdZVE9ETlN6WXNBNHk3YzBCdkRiRXNGZmk3TFRsaGZkVEpl?=
 =?utf-8?B?M3crTit1K0JoVXVka3F6TDNFWmdyQnF5NlVSZ0tVT0p3NWdvUi9xdDlBQVBo?=
 =?utf-8?B?V2tDb3pVRU9nYmg3MVpXTXhGeWZkZ01IOVREZFlweTNEbWR6eVFhUXB6YlRu?=
 =?utf-8?B?djFVdVVNUHNRaWNKL0ZnZm1BRURmVzJrM1RtNEF3RjF6aHRIOFpVVkJ0MXN1?=
 =?utf-8?B?N3NtYzc0clJDbFlCMFE3MEpTdVlZYnplWm95bHNsNFc5ellYR21qdUJNQldr?=
 =?utf-8?B?M2drSDM1OWUySndRVkFsQjk5SVp2SGdhbDJSYjJCUTZKTVFXY3VxMEJYLzA3?=
 =?utf-8?B?ZTNCU2FtMXRRRktraWhyWGlCdXhYeG4rVnpXdEluNzNGbEY5bWV6ZjdQU0xl?=
 =?utf-8?B?dGJPWTN1NlUxVmdqaEF5WXJQRjh1dWJtUDgrc3ZCZUNUbEhkQ3BNenRlbStY?=
 =?utf-8?B?djQxRGF5Q3JTZ3hMSHFydU9zRy8vY2N3ejUzTi94dURzUDZyckpnZ3FaZlFp?=
 =?utf-8?B?NkVJRmJMTFJjajduR2ZucmQza003dWlKWTJwZnVjZXR6VGZsWWdkVkR2T3FP?=
 =?utf-8?B?ZFNaZGR1Ykdtc1RQSUV4cnFUMytGeGg0bjRaM1JDalUxWjY2dTZLK0FaTGdF?=
 =?utf-8?B?dGdKOHMwNThRRXhXMk4vcktKbFBmbXEweTJtS2svUHJGcWpWUnVMeVZpUnNh?=
 =?utf-8?B?MkdNM1gwVjN4WnVnSUR3U3FFOEJNVHQ4NUJQSmdaNEs1SDJIaHdGbHVSTGtF?=
 =?utf-8?B?U1JCKzhqczc3a2hHRjF5YWROT0o3Wkt2QWNtOEZPQzR3S0hnR1pUTnptSGlD?=
 =?utf-8?B?OWt1NDlySTArMWordnhtNzRISmVzanNiejY1UjhlV1pFUmhobHpOTTNHMTd2?=
 =?utf-8?B?MkVBanFTMTBNNjJxbjN1ckdWV1RJYmNZTzkya24vV1FKUjJPWEYyK25jcmdE?=
 =?utf-8?B?d1NwamlyckFhS3hsbEU5MVVaYS9JdGlXWktmaWNyRG9ReHNHSDhoZmRnUVRG?=
 =?utf-8?B?TDJndENxaGU1Vmx2K3JoQ2cya2JyNFcyVnBsbkNxNm5HRzcwbFZEL0hSL1gy?=
 =?utf-8?B?VHZXbVZsQW1PZlFoQlphNHMvWUtQL2VYeFNRU3FZV2V5YytSRVNMT3hZdWkv?=
 =?utf-8?B?Z3BlU0ltMk1PbWRja1ZITXVMMnlZYWZWdnp0ME9Ld21EaXovaE5LQW92QlV2?=
 =?utf-8?B?aTRkQXgxRVRMN2hpS2lGWVhqOGUrSkZkLzRhcHE0SldUWlBmSDA5QVk5RGdZ?=
 =?utf-8?B?Qk5WZ2o1d2ZFYWMzVXlhak5XSlduU1lSN2MyQ0psVUswTjN3dVEvNExUVnZn?=
 =?utf-8?B?STRuVm0xM3ZpMXJhd2JaRFV4ODRpWU1VNVVtekxvdFhrVng3RDQ1bURBYUlx?=
 =?utf-8?B?OEIvQW1nOG1EUjNNcGx6eGptQms5K0djVlVQMFdJanhkYjVld3pBYXlnek0y?=
 =?utf-8?B?M0UvUG4zVnlQUjl4dE50dFhCd0U3YkRiMG96TklUTHRoQTFIcmY4MGl4T2dV?=
 =?utf-8?B?c3NVMmlIeG41ZzRxOXAxcmc3dDRZVUswdDJPdXJ1amhGYlE0VDZkNkpjZkdR?=
 =?utf-8?B?REc1Q3dxdEtXU0Q1QlJRN1d6NUppeTNxNVJJRkhvNXJ4ZUlEV2c4TlpOVk9r?=
 =?utf-8?B?dW1BazE2OXpJaC9hOVFNS2JoK1h4TjJtbDhwZWZpOVJZbUxzT0I2K1NwTlp2?=
 =?utf-8?B?U0dGQlg5bjE0dlRYKzUxQ0pyRGhQU3F1Q3Jya282SHJtWHdKYUxlcEZoNzdL?=
 =?utf-8?Q?l501iSGFvOQmy+ReguPwHZ1dh?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ddd9b80-6a98-47c6-cc9f-08de30b40f68
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 08:31:44.6132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PLGRLMKPKEL+/V6cFH5P8ApPKKydkMRvTwmFkj+bMbLqR6UyU1zAZrFEXClyur419ov8GY3S6HgJprkGSfQbyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6932
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 01 Dec 2025 08:31:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20779

Hi all,

while fixing our pipelines for trixie testing, I was also studying once
more what all we are building right now and what we are deploying. Some
questions arose from that:

First, I would propose to reducing what we deploy to S3 to only what we
also test in the CI pipeline of isar-cip-core - or are there more use
cases outside of that? Then let me know, and will keep them while
switching from opt-out to opt-in deployment [1].

We once had deployment to kernelci as well. We disabled it after some
API changes there [2] and didn't re-enabled it so far. Did the situation
change by now, and would it make sense to look into that again?

Finally, we are building those kernelci images and also test images for
hardware and no-kernel qemu images for our own lava lab, right? Do we
need them all in the pipeline [3]? If we can't consolidate extension
variants, do we need to build them for all archs? I'm just looking for
ways to reduce our test matrix where possible. It's growing
automatically, shrinking it again is the tricky thing :).

Jan

[1]
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commit/7b62ed2342a456fd821dafa631bbf96effa2d649
[2]
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commit/9c2cd8d9bec20ce32eced54293da77b8c23fce27
[3]
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob/master/.gitlab-ci.yml?ref_type=heads,
build:*-kernelci vs. build:*-test vs. build:*-test-nokernel

-- 
Siemens AG, Foundational Technologies
Linux Expert Center



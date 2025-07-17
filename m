Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9179C83F22
	for <webhook@archiver.kernel.org>; Thu, 17 Jul 2025 09:29:03 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.26])
 by mx.groups.io with SMTP id smtpd.web10.44391.1752744533573102545
 for <cip-dev@lists.cip-project.org>;
 Thu, 17 Jul 2025 02:28:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=AbDou7tN;
 spf=pass (domain: siemens.com, ip: 40.107.159.26, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VMizfKfOiIQ80AmIYK5sy+bkV6ctZ/JKkF//A0qyBsS6TMba0Vx5ruMU6aS0nbHv4aKeSUz4hpg3lHY8FACneVr20vC6h4eVVlngrCVPoDAVW1Yf26Ti/Ya/dUqNZL5NHUy3fTQ4XN24WJbr15J5yaxWbjZ5lkZgruCmRY3vuCT1ws8HiHPSYMz+QwbPIkwkJGRBh5YtwLYIhIe2x70z6Ja+wtvwhTLd/aIGuhwQ7dRmcWqbjZi4eJhhC4pbtfEX4XWmAoD/jLQnZjD2hX9y6k399zdBdPkiI0xIMjHtm/7ymITl7nf8hDNeusbQQZSQ5mciZZfZ1i1dhEoZZlm/VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lLyYP5AJxC62BAOYfpr7nOZ/FOYNrpXFmSSz6rD5T+c=;
 b=Qx1Z8pOXP4s/ehmZwDduu3vv/Akya/Z2YsdI9hkO3qGkDCeMVsvuWLCnVjJqXyg79+vfG99BIV09sOE5P4NE8r5vFmNeAk8gua+t1VK7RomjETAlahMMzOZHOTHRjRi7Mf1OrBlJ+nFzPE5CskbSfWMg6IOVslyNN8egdinellDCyJlquucTaUwFnMW8kEe0GwBNKmOjMxAMKG6EKhrVeTD9PWbIXBAFhHuv94uX7Ft+WaTiHZG9DmSDuYn3uoNGqzeVjmhzlR6+ixhA8PIp494xRinwfbp6l11sN36G71Ydlr8NX5s4EW5SHerbXvEA6lL59zDZuyrR2XmrH3Stww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLyYP5AJxC62BAOYfpr7nOZ/FOYNrpXFmSSz6rD5T+c=;
 b=AbDou7tNm1F4Y2vFn6G9RSmMKhCpdADsDxCkkGH1G7QvhMflI0s2XOihwf0xtL8jRwdvH4onXUbOLfurrNl6TgX5r/7nIarkZKfEZ91SIEJEfcKqPfbqMwdA1cKjQuEt6BlmuMMzMfqb45M4Nu+64Eaz1fvooongSgx33Szv/dxf3w3QzQVWw3AKwgxejYqBqN85CYwmnqWLF61+DZFh7MVikengAAYHlxCduc4BphNqy0vb/zrQ9SR6jsR4uws/cQ7zeA0CQkRFST0P1jAtGt2OHhchNJULBmIoICtZJovtfFpgGU8cU563YXxZWv+AK6khi1oxvwyFgUmpK5EQXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU4PR10MB8365.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:55e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 09:28:50 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 09:28:50 +0000
Message-ID: <315f0b68-131a-420d-b4df-3f806af6c556@siemens.com>
Date: Thu, 17 Jul 2025 11:28:46 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] Add isar patch to pull buster from archive.d.o
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0437.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU4PR10MB8365:EE_
X-MS-Office365-Filtering-Correlation-Id: 05d30d17-5302-41e3-d758-08ddc5145677
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|10070799003|13003099007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?clJNYVdVcmNSYTNDYytUMGx6L1RHcGpMQTBZK2lwbWx2YjZKa2tPUkdOS2Zt?=
 =?utf-8?B?bFhtb1hkNUtjMFRkRFdhVHpqU1BRcHdlOThKRjgyN01EWGVwb3RLVkp2Q1FH?=
 =?utf-8?B?K2N1ajZSMHEvUzhJdnZud1d3aXhCSGwvS0VZdSsyV09oK20vcDdDTkk3OTBt?=
 =?utf-8?B?Wm9qNlBlNTRZTmMzaktmaXh4YmRXZm5MY2czeDdyampHaWtEZ1JmRDdqMmti?=
 =?utf-8?B?K2FObXEzRStOUjNUR3phMDVxOXg1UWNzaDFwNHZaYUFkZlpBeW9iQ2pEeGY4?=
 =?utf-8?B?b1NkOVpNUkwzMXJDYWxCZWIxYXFEQS9LQkk0Vzg2dE9FMjlxeVFuRGVZOTQv?=
 =?utf-8?B?aW1PVTBNU1gxdUI1eUNsZWV4T0VibS96WDQxQ21IVnRJdUxCeG56NXUwZFEy?=
 =?utf-8?B?WkJlYk1VR2o0dmVCK2JhTnFBci9wZ01EZzkvNThGZ0FTV1RTcW5IWmxnRGVX?=
 =?utf-8?B?Y0p1WWhadi9LY2hMcy9GTDRuMmFqcFFBNTgzMUdNclZ6WWFlbTAzekthQXVV?=
 =?utf-8?B?aVJ4cmlnMmY1QmUzcExPblZUOWlub2FSbURhR1AraFpaMy83bjYrZ0wxTSs5?=
 =?utf-8?B?Q1lXbGVUNkhvSXpzREJSU3lHaS9KNnF6M3Z3SW5DZ0dmazduMmtSVFd6NklW?=
 =?utf-8?B?NlR4MXhpZkhqQzJqZWJnWTU5Wi9VOUhSNjFva3lwMisvYm5VdU1pNUVpdER3?=
 =?utf-8?B?Y1J6aUdjbHNBNDJweTBLVjg4SWk1TDMxK1VVeGJsVjFyT2hpTFRObVZ0b2I3?=
 =?utf-8?B?M0swV1JuS0F4NjRjR0M1S0I2VlJYM0xDU0gzUnIrazBlRy9uQVNBQ3BRNUo3?=
 =?utf-8?B?QTV2dGsrR3FHU2pna1FPZCs1S3A3TlpDY282UlJzVkhkU3p6OE5ENm9SbFRl?=
 =?utf-8?B?OGs1ZGljeVBnaDArbmU3TlFGWW9GaVJJeVczbVovRmV3UG9xeHRjdzA3aUhT?=
 =?utf-8?B?dDJYTW11ZXlVQnBYRFRBbHhZMDdJUmFrUVRJb1ZzSlUrSU8xOWxMYzZ1YU1D?=
 =?utf-8?B?d1g4M3JrR1dzbGc4N3RJM1lHS3d2SDlYcDRMM2R1T1RCcHFiTWJybGxwNXpM?=
 =?utf-8?B?dkVFUkpqcURZMVE1U3B1L1JuRlZTUzdBb2k4WDFsNzBTVGZKUHRKc2lYTzBv?=
 =?utf-8?B?UFZPQWM2MTNSaVJacFRDTjFiTjhaczJMOWVjVUduQ1crWXUrVkRTaVRTWmpX?=
 =?utf-8?B?NzNSTDRybUo1djZ5MXd3VFhUL1FGUG1WcFlFQm5SdWkzeU1ZNUZYRytPQTE3?=
 =?utf-8?B?RHRSZW8vL3JUNXI2RERNdFhwM21Hb3FZYkgydXVHMGRwOHdQNUxlblJKeUs0?=
 =?utf-8?B?dk81UFFOUjVsb0ZZUnZ1b29EVzNZRHJxbzZqYXBwakpVU0xKdVZIWU1Cb2V0?=
 =?utf-8?B?RUpnSXkvRStWZm16NklQQzRVMjlEQ0dieU5OY3pYb2hQT0pRbThkVXRMbUQw?=
 =?utf-8?B?c0w1SnhaQUNBaEUycW8yQS9JNU04WSs0MXhuV055OWt1ckJ2T01MelRrT2lU?=
 =?utf-8?B?b01lbllyMUZFNzNmVGdUNmtRRFJiSlUxbXBhYXlGaXNMZDNSZ3FkY1ZFdTFw?=
 =?utf-8?B?c3dRUDZKVS9lQkM4aUppRVhrVGRrNU1WYWl5blpzSkJiMGs3MFhJSWtndzJZ?=
 =?utf-8?B?SysvWWMzaVFESGtCUVhiMm9oS1hhaXNZTUlaMlVlQlczNjRUaHN4UWIzMlNm?=
 =?utf-8?B?MmFZcUd0NStOazVyS3VHNGg4bTJrNDA4UnpPdGI2NC94Vk5EV1FuRzZ1Z0tH?=
 =?utf-8?B?b2dqWEZnMHgvOGZIaVRjZkN1ZDlpNFdXODg0dU5Qb1BBTFdBZGNVd1lqYUhC?=
 =?utf-8?Q?PnjiNN+WgrQUtzNzsyTQfuiy84Z7lrzN25HNo=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RGMrb2d5eDV0b2JxTHBEMnI0STVpK3JMamJwbmZuOVZBOVh4VmxtRDM0NTRF?=
 =?utf-8?B?dlJycTRVZ2EwV0VCenpRU0tYM2E1YlU1OFZmcHozdTdGcDBaQmRpL3RkMG9n?=
 =?utf-8?B?MWVHNGNUR1A5ZVEveTFDVUhGc09zMmgxaVc2YU9iYWdLRUtSNnhHTFhZTjlI?=
 =?utf-8?B?dE9OZms1U08yMEwvbU9MR3JiN0Y5MEtIODhKWHJrQkdaK0NBb2tlRjgzVkxv?=
 =?utf-8?B?emNxc09rKzdjQkVQdVAzNjlxai9sZXFaOWhBTGZqZ2lIV0tQOUV1WHBCNmc3?=
 =?utf-8?B?SXNVUm5TWGRVTVhUN0ljZWhNUVJmaW0vclJyb0QrVUJZam0xN3ZhQ29pKzYx?=
 =?utf-8?B?WDY3UHdLSjNCZ3lGUE15NHltZWVJSmUvUDJOUlllUy9JOTVUS1ZtS25ySDhG?=
 =?utf-8?B?bEtPbkNUMnptNER5U2RxeTBtb0UvTUQvemY2MHFPRE1IZVhialZKU2tkREFY?=
 =?utf-8?B?cVV2S3lPbDJDa3NvMUZiQ1pHcVJmV1J1QS91Wno4cm1vZWRBK2t2Nnc1a2hJ?=
 =?utf-8?B?WStQUkZCUjVzSDltQjFiTWMyU3FMenIzTHoxSGc1c2tOaUhOVEZ0cGJoSmNI?=
 =?utf-8?B?Nm1qQ1NKVGlrMEJ4TUEvM25uOWwwQStKNytmY3BadnpqODZQeWF2RnUwTjA5?=
 =?utf-8?B?NmpiWUFhNmhtdmhWcFZmLzl4SjJRa0dvR1NQa2R0QXg0NEN0R2J2WUkwN1F0?=
 =?utf-8?B?NG5odjNoUHBFTjJwUUdGaTVKUjVKRzlvSUE3WExnSVp2ZEpmeVp4Q0s3RzU0?=
 =?utf-8?B?VmcwSkdpQnVxVTBrOStOVHZuZHhmS2dVZi95dFhSRlBYTGphaElxSGdKa1Vt?=
 =?utf-8?B?WGNxTGRBUm1uZ0dhMzFNWlcrMjdhc0grS0QrQ3JwdElPQmM2d05JeVlLYkla?=
 =?utf-8?B?RHpOR0pEcGhHUVlYbitSWitMZUt5YVZxSDlSV0xKZ0dmdEM2M0Z1enBVSDBJ?=
 =?utf-8?B?blptM2dQSy81RjBHOGN0Z0ZKbXcwMmd4WkZRN1AzUWkveSsvcXJOYjdxd1hG?=
 =?utf-8?B?THlzTDFORkNiVFlrSENrY3NKMENPbkFHUkNrck82bnBxNDhTS2sxcVREWmtk?=
 =?utf-8?B?dEY4d0hXbnhPbDRtSVl5RDhwRzJNM3BybndQWXkyODlnWDRtUEt0bWRZRDJR?=
 =?utf-8?B?N0VEWUthQmFjSlh3SVQ4bm5VZHltRzdBRmNjZDdvZFM0d2VUMjBxb05GSldj?=
 =?utf-8?B?OVRwZWpuUDlveDhKcmNlYThoQnBCdWdWc0dYL3JTNENMNzAyTisvTWdvTWRP?=
 =?utf-8?B?WlRMeTEwT1E2cnJwY1JuZFM5RXlpS3hrTjRzT3F1N0kwdzc3cjA0SDhrc0RF?=
 =?utf-8?B?ZWM0dzR3YkhzeDRLNTVKd1ZuREpocGVJMnhwbVA0VUhINUVBWnJ5VGZBekhz?=
 =?utf-8?B?azZZWEdWVzVQSVpDOElOQVBGYXVyUHF5R1pvZDZQWWtiUFUxOVVIampVcDNy?=
 =?utf-8?B?WnFTUHQ4TkVSanVLdDlDR3ZrU3dSeWlpODNvRlRjQlNMVlNvZFVacjNsOWxm?=
 =?utf-8?B?d3Y3d0V1SS9Gd0JuME5UT2xGMFArYlFvYTN2eGh5L3I2aHNYcGN4TXd3MkxI?=
 =?utf-8?B?NUc3NVF1MWVpQUQvNXdZL2J5YXFOaVpOYkt3c3laQW1RNEczR2V0UzhENW13?=
 =?utf-8?B?YWZvbUdHakpiRzRFcHdDbFNSVWtobGRna01LV25IZ0dkWmlFcUcrVjZyN0F6?=
 =?utf-8?B?UlREOGEwUEMwMGZGZS9nbDVvKzZQZWo3SlJpN3FkVmJJVWdXb2k2TGxodDVC?=
 =?utf-8?B?SHVRdkRPN3lUUlNURUc0em1DL3lhYnUyNFlhVXlTQzROY2xxOC9lUHhYckQr?=
 =?utf-8?B?QnpRamRjR3QxSVhjMHY4MStaUVV1RHRQRWJZZkRRSmhsU0MxZFZEK2xPZjhu?=
 =?utf-8?B?enVCTVo0MTgxWmdhRWI3dUdXNUFJUFpxNFhVNHJJM0hoNGgyVktkUmhpM000?=
 =?utf-8?B?UkdiR0NRYUNUTHZIT0pqZXo4RENNaEx1TlorOVVHNk5aL3cvbEZLOVphdmx4?=
 =?utf-8?B?ekROLzR5QWY0N2tUcVZiV0NzbkVYVHllUTUvUWw0aUJBNWdXbTB6UERzNmY3?=
 =?utf-8?B?K0FkM2hZRmZTNzI2b2k2d25XNUMrZ2w3cjlTcDB3cmNMWTFXSEdwclQySGpQ?=
 =?utf-8?B?RG1SM201cWcyT2JuMTd2bTlFOWJxdzdTbytqZ0gxdVF0QW1Wb3FDMkR5ZDUw?=
 =?utf-8?B?SHVWOFRZT2YwaDZkWkNSYzFjOFB0MXhxc1AzY0VHWHRVbUpjRTZMNFJmTWVy?=
 =?utf-8?B?NlVRNG50Sml5NE84V3N6ZGNoQklBPT0=?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05d30d17-5302-41e3-d758-08ddc5145677
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 09:28:49.9039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bq2Eh6HSzbafIOkjQu7XWB+LbdrpLdyn2Z01YyEP9d4U5NyVJBtOYjeMdNzYCM5qOVHbzmpPFq4bwLsqBdryFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8365
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 17 Jul 2025 09:29:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19553

From: Jan Kiszka <jan.kiszka@siemens.com>

This is now needed with the LTS phase of buster having ended.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

The isar patch is pending upstream.

We also need to discuss how to motivate the usage of ELTS without 
promoting the over-use of its apt repo. This here only restores building 
of buster images.

 .../0001-Pull-buster-from-archive.d.o.patch   | 40 +++++++++++++++++++
 kas-cip.yml                                   |  4 ++
 2 files changed, 44 insertions(+)
 create mode 100644 isar-patches/0001-Pull-buster-from-archive.d.o.patch

diff --git a/isar-patches/0001-Pull-buster-from-archive.d.o.patch b/isar-patches/0001-Pull-buster-from-archive.d.o.patch
new file mode 100644
index 00000000..20c99172
--- /dev/null
+++ b/isar-patches/0001-Pull-buster-from-archive.d.o.patch
@@ -0,0 +1,40 @@
+From cfb78915e9c272c74bbfda7ab5f91bfa2892daf3 Mon Sep 17 00:00:00 2001
+From: Jan Kiszka <jan.kiszka@siemens.com>
+Date: Wed, 16 Jul 2025 21:53:09 +0200
+Subject: [PATCH] Pull buster from archive.d.o
+
+Debian buster is now out of LTS, so update the URLs to continue allowing
+to build against it. Security updates are no longer provided this way.
+For supported packages, those are now coming from Extended LTS [1]. But
+as the provider is asking to not use their server heavily, we refrain
+from providing those sources here.
+
+[1] https://www.freexian.com/lts/extended/docs/how-to-use-extended-lts/
+
+Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
+---
+ meta/conf/distro/debian-buster.list | 12 ++++++------
+ 1 file changed, 6 insertions(+), 6 deletions(-)
+
+diff --git a/meta/conf/distro/debian-buster.list b/meta/conf/distro/debian-buster.list
+index b3a3b769..3fe0d61b 100644
+--- a/meta/conf/distro/debian-buster.list
++++ b/meta/conf/distro/debian-buster.list
+@@ -1,8 +1,8 @@
+-deb	http://deb.debian.org/debian buster main contrib non-free
+-deb-src	http://deb.debian.org/debian buster main contrib non-free
++deb	http://archive.debian.org/debian buster main contrib non-free
++deb-src	http://archive.debian.org/debian buster main contrib non-free
+ 
+-deb	http://deb.debian.org/debian-security buster/updates main contrib non-free
+-deb-src	http://deb.debian.org/debian-security buster/updates main contrib non-free
++deb	http://archive.debian.org/debian-security buster/updates main contrib non-free
++deb-src	http://archive.debian.org/debian-security buster/updates main contrib non-free
+ 
+-deb	http://deb.debian.org/debian buster-updates main contrib non-free
+-deb-src	http://deb.debian.org/debian buster-updates main contrib non-free
++deb	http://archive.debian.org/debian buster-updates main contrib non-free
++deb-src	http://archive.debian.org/debian buster-updates main contrib non-free
+-- 
+2.43.0
+
diff --git a/kas-cip.yml b/kas-cip.yml
index 6643b341..a85a8d2a 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -23,6 +23,10 @@ repos:
   isar:
     url: https://github.com/ilbers/isar.git
     commit: 8e3122249a52db470efb32b92ed9c44e4b758712
+    patches:
+      00-archived-buster:
+        repo: cip-core
+        path: isar-patches/0001-Pull-buster-from-archive.d.o.patch
     layers:
       meta:
 
-- 
2.43.0


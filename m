Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B51CA0EE4
	for <webhook@archiver.kernel.org>; Mon, 18 Aug 2025 16:24:39 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.55])
 by mx.groups.io with SMTP id smtpd.web10.80070.1755534269648580968
 for <cip-dev@lists.cip-project.org>;
 Mon, 18 Aug 2025 09:24:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=EYz10wtN;
 spf=pass (domain: siemens.com, ip: 52.101.84.55, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WGKDVtGPZhJVVaOxhgGuwD9xgKjwVvToXSjrJvkrqZytoDaa/i2cxgsXI0FuHZzbqDXZgkdHpyoMC/Z98/oaUOLSUs+VTMaUml0Qw1lUe7uoyp7qXWWoF1eskc49c4D3Py9o5vrYEK1Qr4gZzwH9QdahlQObK2kSiUSmpd6DEGawri3baJUpFU6OyIW2mX0fSu8JidknWNwHc34y2jWwiBYbKNtGcdjT8tanG2OcANAvSthzjCOoMOT+FfLA1NxEYHgEZd0HU3KQSmbJUkRxlUcWeQEUwNCtAR6u78iXicN4YDiR2Fb3BYH6r9m1eNJlx7jfHnJjC/ECNhmElfca3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J59Nudg63YnCtSDwZEVWeOhm84+DM67OTw2S8JprzHE=;
 b=PqwxFIZwueo2KYAvayh4Q00XWkOW78yWWsytq9cEHPKfno7LSr3KgzYXvhYjO3qxTxZ03hlKc0/+w+rQ/n+NwfClj6ewIc/RH9H6IzrT+SPq7lY+fkVWKnj4IWrlY4ffTgZwuzoZvfPegp50dd7PtPhjTap8x/ln0kuYX/EByouoH/S4eAYczvBDgMMHlqsOTuKgk0jkmdMFUUuCcOeokM/vtiM+CxnFmnooH7mI7ZSW9R5KnzOSRZ9BnB1UmFKK29boWGngSp/9Gs3VKnrO97jdiKG9JFEVZpcFr1qmx13yNXDXTBhp+l+6y+TksH0Y5XG4slrss/p/GKjYILG9CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J59Nudg63YnCtSDwZEVWeOhm84+DM67OTw2S8JprzHE=;
 b=EYz10wtNfPyGko97XA1BK33DElEgvZUNiiEqk2UPbXFUEJuruqz8uJKaEX4HQsmtH9BPus7IoU8OPYM/iXuiN86kHUCwJtLNZNJ5CrdTD2kZjXTLWgvteVX9AZzwW0RxJKas8MvDpm1xjwzoKMRAVQ800mwMKmPM4uLZFI060CrtfjE3HKQlG6gXgFmnQ6MCTYos0L4bPM6+vH0mjh4ljfz2AUd/VGqiyq26k776S/4UyVKBCnp6ILq4+aty2ccX8Xtm4f3a/8NoCyZjKM473VHQYOikS/Fm/YJZOGR7L0kP0yfBdjRTREwRORI3Fb586UbE7UgGCGbAFj+i2AO6ng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3152.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:137::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.22; Mon, 18 Aug
 2025 16:24:24 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 16:24:24 +0000
Message-ID: <c07f0dd8-d717-41c7-abb4-a84bc01ae14a@siemens.com>
Date: Mon, 18 Aug 2025 18:24:22 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] edk2-standalonemm-rpmb: Improve recipe
 internals
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0161.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3152:EE_
X-MS-Office365-Filtering-Correlation-Id: f0e804db-a0ff-4059-eb90-08ddde73b1d7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|13003099007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?MThjdmYrOVovakczZFJpdEdtQWc1OFZRT2gySEtKWUNWaC9JMFErN0tRZXU4?=
 =?utf-8?B?ZGVSL0g2MGFHWitpSlliOWJPeVUrMzBLN0NERU41KzVsTktMZjdxV3dCaWNO?=
 =?utf-8?B?UzRiMGN1M3lYeDJXZllhMWNHdFdhSDU3SnFMRUM5STBXaFZySW1mVTFPU3Rr?=
 =?utf-8?B?KzgyL0N4VU83TGlaaldFbmlmMWpXVzdFdDJ5OUo1aDdDYk56dUtmaWVnZ0Nk?=
 =?utf-8?B?QlU5aFJFZU5DODhqVE84UkRZWm1Pb01OUk1SdFNnR1QwYlRSSHJpTGJqQmNZ?=
 =?utf-8?B?Q0JNZkxKemZFRUNacWc3ZzhNUm1WNjFISVc4b3c1N1dUN2xxSG5NcXkvTXhM?=
 =?utf-8?B?eEhOVlVyUExvcG5tY2RsbzlsSC9LUXNLdE1heTRFWHNJd1EvcFJydjRvWjBz?=
 =?utf-8?B?aVJ4aFVXcmFPdnRFbzlRL2xtRGF0cytnUUVtQjZPZGlTSzAzR3ozc21tc3Y1?=
 =?utf-8?B?RkthL243cGVRenhLUEFMd2FEM0pJVnFwNDZWa0hvYTYwK2tXOHVLK0xWNnVW?=
 =?utf-8?B?ZnNuTVBiVWZCU1BFcFhxWGs2T0lsYlZUWlNSa0t3bkZpZHQvN3hSWk45SDN1?=
 =?utf-8?B?RHdJclMvM2h5NzZpNDZySFRuTFAzMVQvTWhhRWdNRjlIajZRUHVMdkZScjZY?=
 =?utf-8?B?TzUycXA1ckh1VUl3Z3lYNlNjV0lMUmJDLzZSd1l4YlB3TEc5bEZ2eXczRm9S?=
 =?utf-8?B?eUVhdlBvQlY4dlZyVjNKWnNZT1pUdWtXR2Y1eHhDWGVOdWZqblkzUDJpdWlw?=
 =?utf-8?B?ditjNmFKbEFCSENGVlBOSTJDUFc4NkZoY2FZNDI1L3dUOU55ZVA0WE5rZUZt?=
 =?utf-8?B?eC8zQTQvRzVBM2w2c1pVT2ZTTDdKZ3dxVi95R3FwZW9JN2ZqaXorTU9Jdkdw?=
 =?utf-8?B?bnE1L0ZTUkVlZDZmVThUb3EyY2hVbWdyN1Raem45NnZYWTVMMGtWQ25Da2lm?=
 =?utf-8?B?cmY5UTQrNkhBdTE0eDl3ZFJiakw0TW1PckRqZ045MFl6V0pQM2VldndoSkli?=
 =?utf-8?B?bWxXVmwrZVBPZXhxSzZRZXhQbVhjMkRpUnNSTzVSQk9Oa01pVHd6WjB1MHNm?=
 =?utf-8?B?UWVqNTZnMzRtd3BZNmM0Q0pscFl1RHMxQklwY1QzUk9VbThvNUR2ZXQxRTFE?=
 =?utf-8?B?VXhvTGRiS0NwTXlzNHUzak9FNkg2MHQ3OHhSSUp5K0dNeU5tNGFTZGpTRWt2?=
 =?utf-8?B?M0k3VDRlZS93bUR6WWptamZXTTdVV0ZhZmFoTmhZemZiNUdISldabHdlUCsw?=
 =?utf-8?B?V0U4K0NUK0pRc0dUOHk0TEpxZUo1NmVXNzltNVNvVVZadmJwV0MwWHlrSWI2?=
 =?utf-8?B?SyszT1pBeDQzcEFvWmF1VlMxWG5xd2lPdDF5NTVvVU1ydFpBWXlIK3FtRnYy?=
 =?utf-8?B?NjFhYStNNmVYTjRuYWZtZW5OSjJ3SDFIcVdTQzZFWGo3N2x5ZUVTL1pYRnZ6?=
 =?utf-8?B?THlpZ0RYTW1SclR5aGNUZHlxR3pROUhkbEdMTEZ5RXdTZFRJaWFhMkJnSm16?=
 =?utf-8?B?bUVQSkFXQjVrQnovcFZ3WENnR3pKazFvemM1Z3JHV1A0ZGVJWlZteW85U3BD?=
 =?utf-8?B?UHN3RVo5em1qQ2sySklUVFRlR3hXcnVGK0pKNVBxWmJ1VEc3RWVNOWJ5OFFR?=
 =?utf-8?B?YmpWUFhqM3JGSERMalNjU3VreDdsVXNFSlFEUXg4OTJocE9DRWFrUWJIMG9K?=
 =?utf-8?B?ZGo5a2ZqcnR3VkpYRWRmRHRLK1kxSVpYenU4aWZ6Q0VoR3RPRkYycXZhTFM4?=
 =?utf-8?B?Uk5yQkpVSUlCWGZWc1htbC9FdzVNRGlsZ2tBK0orbkVvMVhwelhGbW11YzNt?=
 =?utf-8?B?T1pzRUpnNithOVZCeG9Ucm5HZE9KbElneWFrVzlHQnNTaUNTenVNamxqSmpU?=
 =?utf-8?Q?AHi2vp8aUU65D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MkJPTnpMZmI5SzdtY3NRa0plK2wvck1vbnhZcFJqc0JBNFZqRjYxSm9TRE5q?=
 =?utf-8?B?Z3Y0Vld1NmZhTkxEZ0JVOC81WTcwMndweXA1OGl0dDFxNEdGWm5JTXdMaU14?=
 =?utf-8?B?S1h0NGwvMmJtVzVlV0hrc0hSKzBraXdTdFcrWjU0TUh4aU56N2p5bTFoN0Uw?=
 =?utf-8?B?UldlV3I3YjBzNlhwTGhseHF3T29oSW9NQ0dVaGtNdm5vUk1haHJTZjJ1QWJj?=
 =?utf-8?B?LzdIeTUvbCtTdkZKTjg0bU5lZytYaFNqdld3TkpHb3lNMUR0OExwTjYyM3hk?=
 =?utf-8?B?K0tGZHUwekdqRTlEN3lGaVgvTGJCMU9TY3RieW1IdmdCQ0I1aDlLd05TNWZN?=
 =?utf-8?B?ekQxZGJKUGY1OWFLMWM3ajZ4b2t6bEJ1Vm55TUFPTmszcU1TTGMwOGJxUDdW?=
 =?utf-8?B?REQ5SHo1T3drTUE2TXNZNjI2a3VucGdMenFGRXFQUXl3ZjVxWHowL1E3b1k3?=
 =?utf-8?B?dUk0d0NseGlOU2d6STJjUkIrdEpaOVJubzBhbHNsZVI1WThiT3E1ODVYN0dU?=
 =?utf-8?B?S2VTMkNVZGxoSUQ1T2YrT3hKRnNoOEZVWGZjejhYWXNlemt1WmdkQUZXSFli?=
 =?utf-8?B?VnZ1MHR6R3BrNnhRZ3JMTmpMTG40RFBSdlFOdEM0QllKaE56QmJaQ3VEaHhD?=
 =?utf-8?B?MEtOd2dSZ3p5eDdydkVjdk9zU1FiYUdZMlJwbjM4ZGJDMWdmRW56T3c5Ynhm?=
 =?utf-8?B?cDBkbkpSTVlDcnhOSzBuRXp5R2w3TXFrNjFqUGJ4ZFdlNkgyMVlTdi9VcHY0?=
 =?utf-8?B?QTAyRjZCVU5RYjJJbEx2WFhwVWVRbEpnaDhPcGN3WFZXdmYvd0lYc2FSMzh3?=
 =?utf-8?B?ZUlBUnIwempEWGkyZUUvaVBMQ21uRm5nWnVvaHBxYlNtb3VIeFJvQVZ5M2Fm?=
 =?utf-8?B?Y2cwZldnT2FVbEo0dllIdU1weXUxS3V2eFFCeElJWjBkZHhFYTkyWVpPUkJh?=
 =?utf-8?B?WFl5UkRMNUo2b0pHMnZWRi9EMFZsSUJYbHFlL0I5bFZtOG1EVnpRME9IdlEy?=
 =?utf-8?B?TDVPSUdCOFNYNk41VHhDV2liWUlodXRySUxKSko5QTQ1UXJ0R0xOTlA3SG9C?=
 =?utf-8?B?L3diVTZwM0FUdjZvakRLc3U3UGJOY2tOeHZXbVluWEwwTlJUbHVzVnh6ZTZx?=
 =?utf-8?B?OVIvSXBReXVFMS84TFdkMitZL25tYjhhWTZrUHozRS9HdEhZSm8zMjFHVmhZ?=
 =?utf-8?B?NlY4QVRrQktLSTFTakIvZGgyMnRNaVBWN2hEdkJEa3dvZkt6eVVxdlVrVTBR?=
 =?utf-8?B?UnVnTlEvZmplMTB1UzlTQjNIZlFWSEcxNGx5S3JJdkltakFUMGlNQXV2a3pX?=
 =?utf-8?B?RC8zK2dIQ3V6VVBjTGF3YUx6M0dsTnVqT2F1dDQ2am9NV3BoeXFNMVdJaUpn?=
 =?utf-8?B?QnF4cTliSzA0cTNKNzVyaVp2WkRQeW5aNnozQlByZHpIY0crdXBiNERMajdN?=
 =?utf-8?B?aHdaSTZNeEZ1dlVjbUV2Z29Oa2VSK0Z5b0hDZmN5OXI3MkJZYy9NSGlTb2Yv?=
 =?utf-8?B?ZXV5VFRRb0ZERXExYTh3bXVmOTJsTzJDcU9xdGRlK3ZMYWh5ZVBKckV4R3la?=
 =?utf-8?B?YzV6bUNXdkJ1QUJMRlh6YWJaRXhKUG5pN3pNZ0EyUjArdlVaTkh0bHpyVloz?=
 =?utf-8?B?QTVLSVR0VCtGcWRnWWhmTWlnSG0ybzlQNXo3V2lHZUdhekN4QnQvWGxxaVpq?=
 =?utf-8?B?MjB2WWt2ZDBTY1Vad2ZHd3NQdFdaRUUwcjhuN3FBbkh5WEVIcHJ5ODMyZzR4?=
 =?utf-8?B?WExtMnJtMnRMSlN4SStFZ2NQZmN3aHdCa2oyMmxrL2FRdGkrWmhPSWg3cWxC?=
 =?utf-8?B?Ni9NY3FMQkNJdEl4MDIzNzRkZFdQckRYbUpySFg3VFdDYVhla05OUUVIQzdK?=
 =?utf-8?B?RGFuUXAzcjlCVlptVlpPbkVhcS9OcTkyNENBWFliQkRIRm9oVFFraExzWFVH?=
 =?utf-8?B?UDMvajRTdlk0TkpPbXBqV0dESW1COVkrdjJuVFVNZE5UM1o3bmNsTTJJZWxN?=
 =?utf-8?B?REErVnVWNUJvNFdJbWFHUFNtRGpKQlNWQWVLaUZZakdINzVkQWplYlVLOUJl?=
 =?utf-8?B?UXUzbk1mdEtlMGorV0I2bW10dVRNeUNtWjM3eWNOZnFKRHNocVJOYmJxZ0xV?=
 =?utf-8?Q?BAtIq44eS0RvRf6p6o1iWn/cu?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0e804db-a0ff-4059-eb90-08ddde73b1d7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 16:24:24.4593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NRStAiVPUDJLbnnc9E2CQ7gAO+UJMDAKoZAyzbu7tKK6vQ+8CJyiAz3FlXWACir8FtQbirnN0GSCo0jQQbdj/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3152
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 18 Aug 2025 16:24:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19759

From: Jan Kiszka <jan.kiszka@siemens.com>

Fetch additional artifacts into a telling filename in the downloads
folder, reducing the risk of collisions with other recipes.

And add a description that finally spells out StMM.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-bsp/edk2/edk2-standalonemm-rpmb_202505.bb | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/recipes-bsp/edk2/edk2-standalonemm-rpmb_202505.bb b/recipes-bsp/edk2/edk2-standalonemm-rpmb_202505.bb
index 4f80cc70..8cffdcad 100644
--- a/recipes-bsp/edk2/edk2-standalonemm-rpmb_202505.bb
+++ b/recipes-bsp/edk2/edk2-standalonemm-rpmb_202505.bb
@@ -14,16 +14,18 @@
 HOMEPAGE = "https://github.com/tianocore/edk2"
 MAINTAINER = "Sven Schultschik <sven.schultschik@siemens.com>"
 
+DESCRIPTION = "Standalone Management Mode from EDK2"
+
 inherit dpkg
 
 SRC_URI = " \
     https://github.com/tianocore/edk2/archive/refs/tags/edk2-stable${PV}.tar.gz;subdir=${S} \
-    https://github.com/tianocore/edk2-platforms/archive/${SRCREV-edk2-platforms}.tar.gz;name=edk2-platforms;subdir=${S} \
-    https://github.com/google/brotli/archive/${SRCREV-brotli}.tar.gz;name=brotli;subdir=${S} \
-    https://github.com/MIPI-Alliance/public-mipi-sys-t/archive/${SRCREV-mipisyst}.tar.gz;name=mipisyst;subdir=${S} \
+    https://github.com/tianocore/edk2-platforms/archive/${SRCREV-edk2-platforms}.tar.gz;name=edk2-platforms;downloadfilename=edk2-platforms-${SRCREV-edk2-platforms}.tar.gz;subdir=${S} \
+    https://github.com/google/brotli/archive/${SRCREV-brotli}.tar.gz;name=brotli;downloadfilename=brotli-${SRCREV-brotli}.tar.gz;subdir=${S} \
+    https://github.com/MIPI-Alliance/public-mipi-sys-t/archive/${SRCREV-mipisyst}.tar.gz;name=mipisyst;downloadfilename=mipisyst-${SRCREV-mipisyst}.tar.gz;subdir=${S} \
     https://github.com/openssl/openssl/archive/refs/tags/${PV-openssl}.tar.gz;name=openssl;subdir=${S} \
     https://github.com/Mbed-TLS/mbedtls/archive/${PV-mbedtls}.tar.gz;name=mbedtls;subdir=${S} \
-    https://github.com/DMTF/libspdm/archive/refs/tags/${PV-libspdm}.tar.gz;name=libspdm;subdir=${S} \
+    https://github.com/DMTF/libspdm/archive/refs/tags/${PV-libspdm}.tar.gz;name=libspdm;downloadfilename=libspdm-${PV-libspdm}.tar.gz;subdir=${S} \
     file://rules \
     "
 SRC_URI[sha256sum] = "5f2b5e3a267230f82e4566592fd0bfac5e205ad90520b2c9bf80f575293b7015"
-- 
2.43.0


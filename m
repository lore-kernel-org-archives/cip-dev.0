Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E148C4725D
	for <webhook@archiver.kernel.org>; Fri, 19 Jan 2024 12:48:17 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.80])
 by mx.groups.io with SMTP id smtpd.web10.21174.1705668492877241071
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Jan 2024 04:48:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=hhbV1X5P;
 spf=pass (domain: siemens.com, ip: 40.107.247.80, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m5RbYZbqnnmNiBAZ84NQf8TRiVUvHYex1nNwSvZH1WzqYWEAq/qks22GzYGSxIdxLorR4VoAh64PFLB0on7H1Xt6KobrE1GrI0ns2ErP9cs+8D967v9V2c1Vs4sB6u13FWHmVJlC5i7okDPYdD33uujl3oLGeI4RDfhh16fCOtFVib79ZPHXcYsT9hKjTFiRHiMmqeAjh7F2b1VCb6TNxJ/uxVNeyPp/Hvxvlkj6M6VLSBGWqa+iuSCniz4n8iMFmfGHeW0mSva4P9gwN41ua1fyEYDh6stDm71qcSedsVaJlMPaSjuv01m/uzoVMakRpYZZMbk78eypLL8Dl5tuoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VOXl9xeVFDAsS+DI2B33zBSBwcQWDVvtuIgJdTpzkSE=;
 b=fmW6C5piup55rhdzph5BCHOd8bcQMYM160f58fpVuBk3bLZ4kEOOlqRykTye+Vui1HdWKjBmUn1KniLgc33TZQKLuAu4ZOUaxP9wYVgsTKCpxWsPP+TzX1h6uXxVNHzPKVl93dQe3cjDlMXXNGshZgy3HeZfB+Th/g+FuMY9tHXdwcRM8/nxFfrSt7byBHw3g85jUVHHlnuzPjasKGI5TqMTmWeESGwuuXAg13qpxHnOBxPk2ZV1bjwX8vzy8F7zyrCK+3ChQzvFhsW2DPeVS4wkNGtr42IDtPIyflJsINXMUHCA6DUC4hBEgjIwb3AIwShx5HNM6ZVDCP3Zcb4KSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VOXl9xeVFDAsS+DI2B33zBSBwcQWDVvtuIgJdTpzkSE=;
 b=hhbV1X5P+vtl9RxOJ+K0e/G/0qCZq/4Op8P3pKVSjQa9QR/Q6A/Svz6yN76y1C14AlFbkstWBjXrsyIUG0ygE6BmbSktE0tK30Y8FL2Lz2Frf2tL9m0L9SbULChjAWmutryR/Apc/drfmepiWPPIc4ajy2xm+sEU6gwk66ek/8e9akbXCg2/TM7Ftk29D8Prow//15LKFIb7CrVLQnUQlUXFqfYcHA18DY2WDjsUkpu0uMXYuizcf2Xb2nxUP77udCv5+EW2JblyLDKy6KhcYXWFgyyRRF8oOx9FLCKgXNpfpoyh/ryIWnWqFktMC5ZbHfBjcDl/eAiCGCyrTChnkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6101.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:535::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 12:48:08 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7202.024; Fri, 19 Jan 2024
 12:48:08 +0000
Message-ID: <99645445-a13a-4dcc-8c7b-0a06bb3c1848@siemens.com>
Date: Fri, 19 Jan 2024 13:48:07 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] efibootguard: Fix broken SRCREV
Content-Language: en-US
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0405.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6101:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ae0df31-ea85-4ce4-f7cc-08dc18ece352
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ZSbYxaIsLVZkkddARfiIY+4we3JL3csH/SmrHUkudwZVIkqIp+qDDpRtFz7zXogwhdF4EiLkHA+FI4UWIKZPVYGV9hWldKqQ2sgCFVqwoLYkl2NQGOuwt4zRtnYqJ2WLwK4/Z5UbTsW24puIDt3qQila26YuP/0dIwg0xv1J8DMsE2G1NAuHndIlY/49TkqNJWohYWyeFbWUlOa7XukDNDURr6iyD3X5rHTDXb2z3sUzxfow5n2d8XjDM0Eb12u8Iob7U578xVvP4jnyYrz/p0Wjl0MEhJXcY/xZGaM9sb2ucxX/XNf2zYTTSebYcCUBBv8HfEewyFERuMooTKSYaUn/ej7BZ2xQYmFTGWVRU2P3P7zqySC1D21ZN83zfzIxR5a046UcDp4TIOuw9iTv15w7DJt8RSZ7jx7y7jm60xxwYvIAfmNGRdGqBcVg23IvpiBgfYfvFzanrHS3TNHROzTUlpo1T0otlqFzUgWUFxkGGwwElqpu5t1LDknFy2o5gxWSW2x1yjKLeabcrXVy28oYcVPDSK7kqPz66p63az9u1B20+UPl4hUqbuWdynNsIBVeN5YqwEDNTeNyR1za8tMAQt7Dpr6BsHsHz1aLOLKrqagm+4EV6O7DMGkJ+uAX/UeZexuiMYOn3vtANxJrbA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(346002)(136003)(396003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(8676002)(8936002)(4326008)(66556008)(66946007)(66476007)(31686004)(2906002)(5660300002)(2616005)(107886003)(26005)(83380400001)(44832011)(6512007)(38100700002)(41300700001)(82960400001)(31696002)(6486002)(6916009)(478600001)(6506007)(86362001)(316002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YmdHdEhuN2ZjS2VzRVRnN2grd3pKWG9VTGZJNDF1bEdxTDQ4ZjdWc2FhY3RZ?=
 =?utf-8?B?cUY1VCtiVC9qeGJST3ZuQzFjR2dUdFQ3bmUxdjQzUUJVQ1dCRVNYZEp0dUJX?=
 =?utf-8?B?VnA0SFh0eFlIaDBjZWxoZnVTSGZ5dzRsTnZzWnJtQ2E2dmx5dUNCeTdpSGky?=
 =?utf-8?B?Zmdxam95UG14WUI0MzAzSWhoOS9iZWNQMWZ6YnFJRDYwWGtRbXJ4Q2ZwWUp0?=
 =?utf-8?B?Z3NERm0raU5LanBRV00vK3lVcGZOdjJmc1F5eWoyeGgvdUlHZ1c5Mjk2RExG?=
 =?utf-8?B?TTdxMFY0a2J5TkpUcjdxdWhKbTBFV1dyL3RxNGVXbklSdjNrSjBER3R5bHVN?=
 =?utf-8?B?N1hydDZZbjloTTFLRG4zTDRTSW9sSml5bm4vQmdmT2d4dzNiTGRtM2hhZEpX?=
 =?utf-8?B?SkVrTVIydVR3MVpIYnQxMDBaQXZnVkJvSG0xYi9yR1cxYnJ3bE9SdUErWjdo?=
 =?utf-8?B?UWprWENHMHhENzZnMnZSN09waysrTVpzdWNEaCtrTnZwUVMzZDh6SkdnOU5w?=
 =?utf-8?B?UTZaMEtxN0FGUERMSlJuRElKSExPbVBBMURHbFVHd05ZQlRnNFNzN1phN2Js?=
 =?utf-8?B?M2tWL2F2Qk93bHN5b0hmTnR5cUhmRFR5V3R4T3BLK2JrOFFQWGtMVUV4dXhD?=
 =?utf-8?B?YTNYRzBGbWpIRjJwTEFzc1BxU29rVFhjZmQ5cTZEYm8wbng5VXlzRWVTanpI?=
 =?utf-8?B?bllMSmhvb0lmeHAzcGFCOW51eC9QWTY2OFJ2NE5qell6Wm5JWkJIYjdoUW5M?=
 =?utf-8?B?NGk0L3NxVjUwcnhML2p5RU5Hc24xOGhXcDlwdmh2ZU9tQkRyRFpWa2JhaUpx?=
 =?utf-8?B?cG54dlVjRzBHWHVDbFdIcVUzbnVlcFhHYU4wOFVHRmtCcU5ENFNQOEpWcGNX?=
 =?utf-8?B?NURrdFVDMWpuSjlmVENZU0ltOHNFald3OUc3aWJ1aWdhMGtnK3ozVTFXaWRZ?=
 =?utf-8?B?NERTR2w3RWFNVW1QUDlhaDJNd0R2TWNWK2hVckE4M3o2NFU3U1BGaCtYZXpo?=
 =?utf-8?B?MWhIVHhGL0tRTDFNenphMDM5eGtmb0VRcXVROTltRTFJVFFMQ3JyOGFKWTk1?=
 =?utf-8?B?Si9TcmpSdnpmK055SFNMME45NTRVYytmdXR2TWlHNitSSDhpaldDc3U5amRt?=
 =?utf-8?B?R2k0TG52cHBtUWRCWkxLeTFNTGJjRWxRT1Z3M25nSmx2OXRHQkZ6emlrSmRj?=
 =?utf-8?B?RVFYWDFvY1oxSktHUi9EM1praE56Yi9hOHc5RnVHb21qdlJSOHEyMndsK1VI?=
 =?utf-8?B?c1owaGcxM1FVbzUzOTEvUUoyR3VmeENYcjFWR3ZrVktVWnlsa1dEL2JTRit2?=
 =?utf-8?B?Zng5bHdiU1RPWW9leEdJbUdzU3hoUmhhdlZNTnhDWGRGTXVNWHl4dnRXN2dP?=
 =?utf-8?B?SEc5RkRXVU1ybjJOM2kvWHZmWkpWS1oveFJZeFE0OFFVWTdUTGdtWG5oeVNT?=
 =?utf-8?B?Z1FCTG5TNkZoOGV2YXQzbWp5YlByTG9uN3pRR0JNUkVBYnI1SVdpTjc2TGYx?=
 =?utf-8?B?Ylc4QkdRcStPUTB6K1hWUEIwRHBCZlhRQmhjVTdEZ0I3WjdtcEg2UmxONDJU?=
 =?utf-8?B?TGcrWVJvQXRZZFN1bFNWSnJ1RUhOOGsxNEE3R0xWUUx1Um9YSDF3NVR2aURm?=
 =?utf-8?B?akQwMXE1Yk91a05kOHBVOWJ0UEx4MFRlZmx4Rko1Z3Y1alk5Nllnak4vT0NU?=
 =?utf-8?B?MXQ5Z2d4N1hPR1FCVk8rLzVaQTE2Y1Y3NUd4Zm1uelcvVHBjUFowSGh4dzQ0?=
 =?utf-8?B?RmxkRjdld2xPUXZVQlpNZVBPVHdvbjJlMnEwcEVTZGhDTStoTldqWWFoRXVs?=
 =?utf-8?B?RFJMK2I5VW5ZL1pHOWVxQkR5RVBkOXhpbTFUMGU0MElDRzZYbCtxYUxJRTVt?=
 =?utf-8?B?Zk5vTGNGZU1jNEZ3cjBHZ09uVUJBczJpcFhpb3R6c2lHQ21BVnRKRm1jdTZh?=
 =?utf-8?B?a0JQMEs2dFpoNlBUQlZWODR6ZGEzdEZ5WHArNHJZWWVMTUpSTzNyb1VkbWF3?=
 =?utf-8?B?eTBCekN1L2cxV3NZZmtiR0RyU2RFWUtzRXR3TjRNNEloNklpeFZnNjZIdVQ5?=
 =?utf-8?B?YURYV3NDM1I0VXhjZExsUzRIbnYzTVlNRjNWeGVTNEhrcmtjblJlc0xJQXo1?=
 =?utf-8?B?UHVTSS8vY0NKUUJibkx1Vm5rd2tPOUQzQnVNb1lReUdXOHdaSTJ5YVh4c0Zn?=
 =?utf-8?B?L2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ae0df31-ea85-4ce4-f7cc-08dc18ece352
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 12:48:08.5850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4k048kXG1NOzePFqXXLdN3Z7Fmu+GmbVj36Gheqa0ug+yeCGKy5TPwRH5ogubuYYUG54WUE5RR+9wkMbHevkNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6101
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Jan 2024 12:48:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14426

From: Jan Kiszka <jan.kiszka@siemens.com>

Debian hard-rebased its master branch for this package, breaking our
fetch. Switch to the new head of master in the hope that this will not
happen again.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

May be upgraded later on to the next proper package release, but as even 
master is broken now, better not wait.

 recipes-bsp/efibootguard/efibootguard_0.16-1+cip.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-bsp/efibootguard/efibootguard_0.16-1+cip.bb b/recipes-bsp/efibootguard/efibootguard_0.16-1+cip.bb
index a7ffb00b..93114c3c 100644
--- a/recipes-bsp/efibootguard/efibootguard_0.16-1+cip.bb
+++ b/recipes-bsp/efibootguard/efibootguard_0.16-1+cip.bb
@@ -24,7 +24,7 @@ SRC_URI = " \
     file://debian-patches/0001-d-control-Make-compatible-with-debian-buster.patch \
     "
 SRC_URI[tarball.sha256sum] = "d6d37c59aed17489d02b4f0b63db16994dfb8f9f70f54be4d65c366f58c6be9d"
-SRCREV_debian = "2e80fafa87f8f6fd093f49ff33ad7cac61592871"
+SRCREV_debian = "eacf94e767136a0257850ea0c888d234cb8cace4"
 
 PROVIDES = "libebgenv-dev libebgenv0 efibootguard"
 
-- 
2.35.3


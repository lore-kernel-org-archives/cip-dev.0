Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B84DC47258
	for <webhook@archiver.kernel.org>; Thu, 11 Jan 2024 13:52:01 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.64])
 by mx.groups.io with SMTP id smtpd.web10.11645.1704981111815352979
 for <cip-dev@lists.cip-project.org>;
 Thu, 11 Jan 2024 05:51:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=mfwdji/A;
 spf=pass (domain: siemens.com, ip: 40.107.241.64, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZG7BdyOcdExtTEYYgCxmzDDs/iIrYHgqhveyhGcfmJN+M7UOuUU6g0YPKyEdk6Nxas9/CqVOgFvyxNSL9i2pd+Kl0iHo7RepXxfuF48a5m7KEdxnIxpZeHR1WM7BZd+IC9tMAJR8sdz+UI+Ixz/RaIcl1H5QTiUmBc6X8a7Fe0DMXgRpI9rCHCxaTA5Z4YHvo6BCk7FFvMlzt1B2Ap28mfyx2RDSnvdACpCRBYmkis2+9VrwVObZabh8Zb1XGumLVz1Z82F7fCBqmSmwUYh8nXd5Ir0ldUDdQB6i00g4Wfd2DJAHP+nG6XMMlp7cD76OKGqGHB/fElgygaO7AFO2HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q58lwYETKqtmB2+uzbgCqe3SPgn8Pr/eFg2XypLLrrU=;
 b=U29vCs/S9/Nd58nppyRBWfC9J/jlgkLH0PiicJDrPNR1fzRNivzXEtLvoQl0oXPQthbEI6jsX2QoEdF3Whr87Kw5Eb6CId2V/ycO5FPlC33nAi5uAh4NR6B7A2k718GjwW/EK2h53FkCiCu8I3hA+JG6nLP37qjoQKiwKkLOl54QrJAiEbsJc1bMX8jQ0WkjDnnCmkNRP0v3gTJW69YdMPisFQ1pfgypoT3vPwGkA/OeA+gBYCzIEXmh8oHIn3kdvNf4u8PdHilQ/L/8ke17BcKJT2JbHkhH4rwbMk2A/AWJ3fGgc6LDTglehqfmI3JVE5kJrBGWLaty2l1kF1A82Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q58lwYETKqtmB2+uzbgCqe3SPgn8Pr/eFg2XypLLrrU=;
 b=mfwdji/A7Dvh5mbD1WIlOMOW36MiDsa0VR9BQdtN4RFiUQZfRtbzL4O7daTyViW80iziXufH6SlOzbGMK8qvihjXt1G5cNiBHvEfGfk1cgf2spIszGq3J4leqsAV5EioDcF6868f/GxW91x1sHlSux41YinEVTHPIqPaVJKvGFcTe+ueizvelAFAF7/O3zZCy3NWTrOXaQbnwKf3c7d27TRfudxq5LfeadMomSJnicQOXZ80EfDcjG7TdctmgzfuRul3D2P9ABTBtknGLGIGl22bmoqpmGNEpmTKV8hANwdP3f9q6Vd+UBCVFQYrdF3x3uYM7mRAqaYgyF5ODcVpwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6297.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3ec::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Thu, 11 Jan
 2024 13:51:48 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7181.018; Thu, 11 Jan 2024
 13:51:48 +0000
Message-ID: <31dd2781-6864-4dea-9aea-b50764a3e507@siemens.com>
Date: Thu, 11 Jan 2024 14:51:42 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [isar-cip-core][PATCH] Kconfig: Fix dependency of security extensions
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
Cc: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0468.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d6::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6297:EE_
X-MS-Office365-Filtering-Correlation-Id: cb1ecd67-79fe-4784-b506-08dc12ac7495
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	sbBsGLM5DrcHhNNM9fKsucxwo1OMBw/hUL1Jcs2Vx0rGAxVFfiFwDK9FOC4S6Rf3JQtU/UEpaPfZCk4vnC82K8I9D/Y3vmCxQAAheCeckGP1dyFERaFf3AWT/2HSYW08rMrvaiggSjSGwt0PuvLRTKe1luPlq57vfqzPdEOrHxwkrEepP5ALrvTnnKwUvmYmr3GZDaGwalsVDHQTMXkl/AycryGzfko0W0ICk1GB2x5UJ7eCm6XXWF0TOrvp0NTonrFcgKDIFqFx6MuyC/Re7hzxayba8ZBtHRRag3YDc9decoZjTZ8LDZhqHAyNDyNn7+o2IcJPVZfw8CHqvKjQPGM0JOgxmu5sUi3rGrmGjJdMzrl5prItKcgsAS+kl/UDhX0ck9ypLvsnIg/WE9bqkcK2rwjl/aYULTi9Yr20/TGtRE9SQDbkx0RmhwgFRxDcW0yD4VE8BDNdLtNaOYHqtG/0tFka2ZITfqmX+x5MZd9aXX8wet6KKIMM9IL1vHhL4lBNlI/ai9+jKjdpTfsfTmIcELFsp75plrbjLzmh/otlZ0ns/FLuR3TexVygErthcRlDFJwaH78Ij5SY4fw/fMmpBvBjNROBtM7zDGDi7/FB1tbLb6u/hKhqS91mn/dYydfEOXQzF+xNYFqwP4UFrA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(39860400002)(376002)(366004)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(31686004)(6666004)(478600001)(6506007)(2616005)(6512007)(26005)(86362001)(31696002)(38100700002)(82960400001)(36756003)(2906002)(41300700001)(4326008)(44832011)(83380400001)(5660300002)(15650500001)(4744005)(6916009)(8676002)(66946007)(6486002)(66556008)(8936002)(66476007)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WDNzL0Y1NW9vRWtzQzJiQ09XRlVKR3h0K1pRangyS05OMmJCOGpZbW5CQzBL?=
 =?utf-8?B?VmM2UmlRSGxOdTBuU0lNUi9ldWwrWk1oNnVjVmwzbzRmSTBUcDhvaVJlMkxR?=
 =?utf-8?B?Wlh4TFFMSGRLUWljWWNhaXZYc29pSmlPcjJoYUc2Z2F5NndaNWhZSGJ3bVBB?=
 =?utf-8?B?OGQ4VWxXUXdlODUwcjBQdk5vaTRiUGU4L1pta1BtbEpDdjlRRWVHektiVjFo?=
 =?utf-8?B?TG9NdmhZYnNjVlNRSUMyT1UwQ3B4M1pyVWlvV04wVVJJdHpHa1VmN05MNTV4?=
 =?utf-8?B?clRBdzJOalpqRTdxWUhlYld2RFZJRGg2SXBXbnJNRWFpU1FYazVuMXlYYXNV?=
 =?utf-8?B?NGtxaTIwUko3RG43aDl3NjBRdktRZGZzOEtDRTVIQkZieU1JdnJBaGZrUTNt?=
 =?utf-8?B?a0lWYXNSNENRTU5zaTVGVmNJT09EaEZtenBlQjRLb0dCMkFEa1haOWJuYlls?=
 =?utf-8?B?byt3cDEyRmU1Z0lJWWlEQTJ1ZGJrSlgrTThqT1BpcGcvdW9KYkpaOHRuaFhz?=
 =?utf-8?B?QUxxaWlMUWJwc3VFUVgvdWNJTjUrWjBOYlNpanYxU1k4Q2swSjg0d3V6bGlp?=
 =?utf-8?B?K3ZwSDBDVTgzMldXek9qRHpXZVpCNEExWjZOTmFMYm1Pc1BkcEp0ZXBrSGY0?=
 =?utf-8?B?QlM3K2ZYT215MlJya244V0xmTTNqbnU0eHRCZ3NsSVY5bkFCNGZEcnNycmJl?=
 =?utf-8?B?RW9XeTdINzdWU3lsQ3BtTTZVQStmaHJMSGhJcUJoWlRPQitteFZtYTdZOFVL?=
 =?utf-8?B?c28xclRwcEVCc0ErZW5xVnF1M2prSWVNeDBrWCtiU3JEVnNieGJEMDNGT2JM?=
 =?utf-8?B?aitKeExlTzdPTEg3RHk0OWZHSGhvSE0yaFV5VzZRTUk2aVVZckNhbzcrdzFr?=
 =?utf-8?B?Wi94b1pTTHZlc082Yk9jYVg3YzdBUVF3M2RZK3hVUmFqb2NFY01sYjRvQXBm?=
 =?utf-8?B?R3p3UEFKU1BUY1QvRzVxck0wZktIakZXYjdWekJyY3hFN0tkRnRUV3EzdzFX?=
 =?utf-8?B?UHRUWWVOSDZrbjd4SDVRb0VKdGo5L0FYenJMUmp1a0doYmtwc2RTTFBRUEp1?=
 =?utf-8?B?anNyTkNFR3lGUngzSHlFUkgvb2hMMnA3K1VqUTNJMlg3VHZQWThjczhtNHFm?=
 =?utf-8?B?WUF2dTVtUDU0VHpNWUtod2VwdmdvaVlCVW0wWHJZUWNxSE5veVE3TkdoeVg1?=
 =?utf-8?B?cktEakhiYlg2NnJZamV4S2kzVFprYW5oYkNzQWVhU2M0MDhUZEkwRkxkNTRF?=
 =?utf-8?B?ODdENUNLNFZNK1ZaRi9vYVpmUmVGTjhVekp5V3J5eTBEK3piODdCR3A2Z0cr?=
 =?utf-8?B?VG1zSVlPcDJBUnd4WTVqN09CTXUzTzkwZEtna3k4SGlKOThBbFR6QytNUG10?=
 =?utf-8?B?dkRCZFg5QjYyV0ZDdVVaNmY4WEdpbnhmYkxYeXBGRitsNGZ1c2YwVTlnK2FM?=
 =?utf-8?B?Tmc0dDhRbDlsN3k4MVVLV3NuUDVyNXlTbWtqT2wyUFNCOTZFcWFzVnVyalNp?=
 =?utf-8?B?d05VYUs2b25MWTA1akVFUXc4eHlMVjluQVJRc2huT0ZGMUFoSnFkcXdtWUtt?=
 =?utf-8?B?eEkzbi9XMEg5M1VoL0xMYXBqa3NPdW1hN0NBYkZWVE5TYlJETWtwNDNYbFhS?=
 =?utf-8?B?c1V1TDBKNjBsMThla2g1VGRlQzFDcWthZDJHRGlpbjBwV2QrbElaOFVoNGR1?=
 =?utf-8?B?Qm9vemViN0FuTHduOFJoMDd6L2w2ZHhNYXdqZDlJTUY1aGpsVjFnbzRQdm44?=
 =?utf-8?B?QmpZZi92bDZXWFF3Q0pnMmJHZ21hSjlOL1dLd3ZYT2NlSXR4M29zQmt6T1Bz?=
 =?utf-8?B?OXVxT2lwVVJkQ0tjQW9rMDhrcTNyL2VkQUpBVHFscEZtSzhQZzJKQUJxcmVJ?=
 =?utf-8?B?VE1UUzk4V3hFaTdjMGcrYTVVY2IweXlBZ05nTmUvMjc5ZzgwSlRrMnBzQUdp?=
 =?utf-8?B?Nm11UkUvRUlmbER6UVlFMGRMaUlQc1U0R1NJSFRQSUR1UDhXVmd4Wjh2OUI5?=
 =?utf-8?B?NU80UjFuUzhOT1hxZ2FJNnJNNm5ZRFZLRHR0azZBb0NDQzNQd3JvQkhlOFlT?=
 =?utf-8?B?NHFLaU5EMkdtSGhjV0JEbUdyWkpDaFNlUzhZb1JKdHR1TEdmdzJJcU1OR3Vi?=
 =?utf-8?B?bW16blpUbnVnOHZiZnBUZ0lPdGpqWkdHYSs3WjdzeEdQR2R6TjBVWm1vR1pj?=
 =?utf-8?B?Z3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb1ecd67-79fe-4784-b506-08dc12ac7495
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 13:51:48.1538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Y4SMqeIMuMeEjc6uNKJiYsPxDctQV4OivIL5diey1KqGsGOLGM8ohkKtAXje+TMF1uDpAE7TdeU4lF7qSom+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6297
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 11 Jan 2024 13:52:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14329

From: Jan Kiszka <jan.kiszka@siemens.com>

IMAGE_SECURITY selects IMAGE_DATA_ENCRYPTION, and that is currently only
supported on QEMU AMD64/ARM64/ARM.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 Kconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Kconfig b/Kconfig
index d0dc13b1..7c196404 100644
--- a/Kconfig
+++ b/Kconfig
@@ -171,8 +171,9 @@ config KAS_INCLUDE_IMAGE_FORMAT
 config IMAGE_SECURITY
 	bool "Security extensions"
 	select IMAGE_DATA_ENCRYPTION
-        help
-          This enables security, encryption, secureboot and swupdate for IEC 62443-4-2.
+	depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM
+	help
+	  This enables security, encryption, secureboot and swupdate for IEC 62443-4-2.
 
 config KAS_INCLUDE_SECURITY
 	string
-- 
2.35.3


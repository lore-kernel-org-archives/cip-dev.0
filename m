Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 825B7C83F2D
	for <webhook@archiver.kernel.org>; Sun,  3 Sep 2023 06:24:24 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.72])
 by mx.groups.io with SMTP id smtpd.web10.23518.1693722258562614509
 for <cip-dev@lists.cip-project.org>;
 Sat, 02 Sep 2023 23:24:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=gw4UsWZ7;
 spf=pass (domain: siemens.com, ip: 40.107.7.72, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eLlXe0ADvL7ytvDaScHm7+Kk6Qqu3WImGE1q33fxI9sYDClT6hY+nPHp/mskP2bHTUfJqikLrnPgSeRiZPcm8YIcePgCl/5YT2LEQUb8qJpkXWYvuYsPCSG6wpFa+YOpc9LzdexewVHaeYPuLnhg73KfQVKVHhVi0tQ5seKQMBwtyUn+ol7EUOkky3gqkno1mT5njmyMN5NkVvZjrkSv8C8az9CGebhvQl68tYt0akaL2vPxGzWs5GaaN66FlGp2HlwqM66XoJTzI54nspEPGopc+7JzAVDgHRNgTKrUf1xD0z2ZfG5F7pZvASWOcqqVtSlRzO0kBu2VgZjyn09apQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ROO59ahq9DS+0oPXxsbiYQd/EaOY1R6XXECcu6WpYHY=;
 b=dFYmg8MWL1MxvIqvQ9v806nPyWcIrdrPVYOrce22ZeuyqZd0bZn3jJ7RCevSteRtXyegGNgzeH7ELVZ2J213c2V/LFSq+dxCso3RyEcb5MDmi72f3XWOT3tmBaNT7qlFoIIp3J5BDYHHIsrPYzZKMnGZg/ALSZcglI+cfEKgGHC44pRjJxAfbLXo6SOIMeA8OTCr0eR4l6GEfSrnM/p4b/ksZRaX1r7wpVrvcJFjsEca6yPlqUgKq5F7oAt2Vnu+KEmtIQNQ8qq3CeESXpibGSI4k0IWnaT4bdf0ajihMmV6VU+U3XczSe10kWObceIpZ7Ft+poszeIp7gNM5+ICng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ROO59ahq9DS+0oPXxsbiYQd/EaOY1R6XXECcu6WpYHY=;
 b=gw4UsWZ7VPYK3r3XOKNvxdQ98N823Pvcg+l8YlBvg5gNdObz3A13k3k1b9KHuRRuXvKFPP+V25dGq54ZGT1xRxKcZawN4FqEWGRWsCo3OgZcdtbbhOv0h3NzJv/ydJSPfX3k0rD8AXxERxknxduS1xJx1RTilJDwRlJUw7C4Uv4RzuO8lItH/tzXmMdSlKEnn810PJkumx7Up/LoEXl70EBQp0Z7SyZ6j3XsI6AxdYBxFUDpHzHFSkPoyS+kq/yqdztXUDQ20Y0+K9oMh4CXQENs2Kb6frBdcm9oXnTPWjvHwyoDkjZ4Wsxu6MvGu06b/GxO9JhT3IQN/G4SyYZbDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB6403.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3dc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.30; Sun, 3 Sep
 2023 06:24:15 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6745.030; Sun, 3 Sep 2023
 06:24:15 +0000
Message-ID: <f9c63af5-87db-4432-b07a-590981e9ed86@siemens.com>
Date: Sun, 3 Sep 2023 08:24:14 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [isar-cip-core][PATCH] linux-cip: Update to v6.1.46-cip4-rt2
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0001.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB6403:EE_
X-MS-Office365-Filtering-Correlation-Id: 888a70d0-fb7a-4e2a-072b-08dbac46655f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	8wzXSs2HAj9d4g1RAgFPYTKNG219BE6NiUvaGvtBsM4wqe5D/tjadaNd249/CasE78pu91WfcYj/7XYDcvYRNs/syYWbmHU3LnrxvHyKOmZSHeRjQF4zsB8hTThOnv9a85z4VtLS7JfdvrNEeLHRPCukcTFJLEcaYfPyW0zzQ9l2wcC2uVHTgGXO/QdGLJ/5272HqNKU4X3ryEFgNOpdtDR1A0Z5iA4FSPhKRCoZ72xgrrrSgPRspGZdEap0kczMSiHHhU/EwispFmgqTihsd3RQxBe6yK1yMD4wCJZ4AYgb7IwZpPwCPA68tLL34yIgwvBfNBFss9Hx3VlTu/mZYWU4jTzSpMoWr96oxwhsIZJQIQ9U1wy4T2mb+sTbAbvkLz0KEI7g64Uq5NgKOqQRtRl6Nh7ymgnik8NJgShQfEGK78uGk+rOTRaGu8fdfjkdDAxs7peQybSQGCz8HNtcb9b7M4KeNTuhVLO8TkAVob669BUcm/D4UU+RXGY8t9bOAApo9qcqG2l59Gqwc+IN4vk2TIHfaN+L3VUtGNisxZlmFP+G+RWOyeMgu7DGBAsY3EdTgylHUwNn+IVRInkvli5VDJalQmlPjXs7sYs24fzPOs4+9n9b4BKgdqs4ThaNHdBWlBqNCSKh01Hlu4td3A==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(376002)(396003)(366004)(451199024)(1800799009)(186009)(8936002)(41300700001)(83380400001)(44832011)(478600001)(2906002)(5660300002)(66946007)(8676002)(31686004)(6916009)(66476007)(66556008)(316002)(6512007)(2616005)(6506007)(26005)(6486002)(36756003)(38100700002)(31696002)(82960400001)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RlNxNURtQXhDWW5peEh4Z21xRlI5S1hxYStUQ2YrZ3MzNUwzV1owdmM2akdP?=
 =?utf-8?B?cWNMMnA0SHRJcmpYVGZJWk9MaUFBcG5aa2l1bXIwL0NqWFdhOUQ1dzhYanVW?=
 =?utf-8?B?VmVFd0JTS3dtT09MZ2Rod1dtQ04ybjVYNFFhL0VUanA5RlJuM3pLRU1Pbzl6?=
 =?utf-8?B?NWNxNVpOOXlmVDlqdnB2UStDNTg2eFYxaGFXSytNTUFWZElOQVpxOEY4TG1s?=
 =?utf-8?B?WnpobG5zUmJzNytkQXhITHAyZjFJa3BDcWN5bGc3YVBkODFvdWxmb0RWN3Rq?=
 =?utf-8?B?NCt5QXViTmZTeEdZSXRvTGF4MG55cm1oSWkvNXRnRVVCVnMrUTFYVUI5aE1z?=
 =?utf-8?B?eU9hczM1QlBDbFRHdXNBREU0dkt1RDJaMmltb3N2U05vTFpQTnFoWHkxUzlO?=
 =?utf-8?B?eEg2Q0o4SFYzbW1EcTRzM2ZIQldkRTRXdVpET1lWV3YwK0ZQSUtiem44eVlY?=
 =?utf-8?B?SUM2aTFxZjF2OEVGVU5yV1Vrd2RGWGIxUEZ2cFplb2ZJNWIwbFlkNHpjQUtD?=
 =?utf-8?B?aDJXYkdPSWVPYzgxeTZkVGJGV0RGSW9jREY1aEJud0pUK1Byem5SaGN4QW9M?=
 =?utf-8?B?VTliNWFLemtkbERZb1JyWURMV1hvbXl2cG9VNk45dGhOQS9ZTWNjdE5YZE04?=
 =?utf-8?B?QlZjZUIrYXFNVTMraStOQjVQMnNiOGNUVVU0aXRDNTR0ZFhBdzNxOU5yZzQ4?=
 =?utf-8?B?WEJOemNubjUyUTR4MmtKVWU0d1diOTVYUTJwdXB3OUc1OTJtdWRGemZwcElK?=
 =?utf-8?B?NEloSjVzSE55dXAvNG43Y1hrTnkvUFFIMTArYVFwRHd6USt6VVBBRUpXQWc3?=
 =?utf-8?B?dXBFb01rNFZqZzdsREVMamtla0ZENEFMa1ZURjd6Wk93L0creGdUUGdGV3pW?=
 =?utf-8?B?d2l4M0cyanRNcjVpS0VzNlpYc0s2TjB4R2V6ZVU3YVJDMjBGZndGK2ZTK2dJ?=
 =?utf-8?B?ZWNhTVNsK0dZUjAxWDVKVk5pYXg0MjV5WFBRVVI1Sk96Zm1YaTJNSis5RENk?=
 =?utf-8?B?QVZIaTV1SnZVSG1BcXBKaDBVdDEwSjBWT3NYMDhpSjhORytrVzZjNXQ2OXpm?=
 =?utf-8?B?a1UzcExiaHpldXNWL1NpQnFBbmVYNlNSdGJSQkg5QVZRMG5ISW13SHZaaXZa?=
 =?utf-8?B?TU04SVV5aTcwR2l0endIV1N0UldLNzlMTURxcldhS3ZGUE1JWmoxaHdvenlJ?=
 =?utf-8?B?SGtRNFRtNi8xeDIzVVNINFFwemJsSEtJN2NtWFNWUUY2TnNOQ0lBUDFlalNG?=
 =?utf-8?B?cnAxQWVxdjd2L0UwVTF3aXpFVC9Lc1Z2aDBsRFZjRzlxRHBxano2K3g0SFFw?=
 =?utf-8?B?K2ZMNmthYUFFcWtDcEVCWkphcEpsTHdBeTVqK2JaTFlOM2VWS1BWYk9PM1Rn?=
 =?utf-8?B?dU5ISU5SbkMrbUplUm9sdkdsK1hQYUp4anFoRUZEWUlrYzE4elJZaXpuZ2M4?=
 =?utf-8?B?eHVmcm1UVGpQdUtqZUFDS0FweEEvdzJWQ3VTb2UwY09GRzlkWnRCSTBiMkR4?=
 =?utf-8?B?aW5xcm1xNmxoam5uMDc2OUowYzEzdUk0ZUZKRy9pYmhlZzN1b3dJZ3paa21K?=
 =?utf-8?B?VW4zMWdnNU9kekVLclgxYjFGRWlOK3I3R2xibjJDMmZDUHB5MFd3d0h1QUVy?=
 =?utf-8?B?V1hnaXpkRWJJQStUWkU2eXVLeTJDQyt3UTRDeExjbzRkYm9OZ2tybDdsOGNw?=
 =?utf-8?B?NmRKWm9XTkFBWERSU3ZQVDJOY3lmWURLV21wVVl5Ymwycm5MVXU5Nmcwb0hY?=
 =?utf-8?B?MFZPYytjdFAwclBka1VPUTJYTVk3amVSaWtmVzFVQ3dXRUVnYjFrcGZML2lT?=
 =?utf-8?B?QXYvaHFmU1R2QVJ6dzAxY2hkejYrYTFlRHgvQW9nUEJSRXZBenprYWp0UVFo?=
 =?utf-8?B?ZEZhakZLSjkyM1VUcEJnVXpYTXUzTHM2YTNsUTJTY1NNY0E3QjhsejY2SEhn?=
 =?utf-8?B?VDBjVUVIdlJhVVA4UFZzNE1FZG9KTE1jUng2bDRqUTZZVzA3YkRqQ3IxQ1hW?=
 =?utf-8?B?K0hIV3BZb0xLMjI0KzVRR1RsY3VxeGs5UjJkQjFjQTViUUs2WGhwZm5IZGxm?=
 =?utf-8?B?bWJFdjQ3ZUI3aktPUVo4VzFHbTFTTno1TDhEQWJjeE1wZFV3dERQZ0dmaXZy?=
 =?utf-8?Q?Ey7odfmZW7Zuh2mBzSHYBk9O+?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 888a70d0-fb7a-4e2a-072b-08dbac46655f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2023 06:24:15.2351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LabNEFWZR9M/EGyoTuCobzRQDnGveWTtOMj32UKEM4kSZZ9KSvRFd9jy2hT+Ez539381GIFHK4OvidAycSFJbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6403
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 03 Sep 2023 06:24:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12936

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...ip-rt_6.1.38-cip1-rt1.bb => linux-cip-rt_6.1.46-cip4-rt2.bb} | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename recipes-kernel/linux/{linux-cip-rt_6.1.38-cip1-rt1.bb => linux-cip-rt_6.1.46-cip4-rt2.bb} (65%)

diff --git a/recipes-kernel/linux/linux-cip-rt_6.1.38-cip1-rt1.bb b/recipes-kernel/linux/linux-cip-rt_6.1.46-cip4-rt2.bb
similarity index 65%
rename from recipes-kernel/linux/linux-cip-rt_6.1.38-cip1-rt1.bb
rename to recipes-kernel/linux/linux-cip-rt_6.1.46-cip4-rt2.bb
index a1ba50a9..c3dfc3ba 100644
--- a/recipes-kernel/linux/linux-cip-rt_6.1.38-cip1-rt1.bb
+++ b/recipes-kernel/linux/linux-cip-rt_6.1.46-cip4-rt2.bb
@@ -9,4 +9,4 @@ require linux-cip-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "6.1.y-cip"
 
-SRC_URI[sha256sum] = "5e4dd386aa8a4cce341b8efeec76320feed53770ead67c838ffb321edd47b157"
+SRC_URI[sha256sum] = "121802df58549b5641f2171bcdca3932883ec81f9f175e8bdcc7c43a925cb53d"
-- 
2.35.3


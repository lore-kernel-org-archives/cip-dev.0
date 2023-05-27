Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB9CBC77B7E
	for <webhook@archiver.kernel.org>; Sat, 27 May 2023 16:48:41 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.47])
 by mx.groups.io with SMTP id smtpd.web11.13769.1685206117510395099
 for <cip-dev@lists.cip-project.org>;
 Sat, 27 May 2023 09:48:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=XZOsn1FH;
 spf=pass (domain: siemens.com, ip: 40.107.105.47, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WqMuFwN9vI4FMxK44l3725/NfVJeyx/dcFOCuVVv3tLNox9YiYol6vsFcORGMczlGVqlN6EQXmKaa2Iz+2UabAzN1gdcVBba8PUvDeiUZRZMJxJgkvDYj8y+R/KKj7j6WTG1CKm/zcvi+bYUJ3lZLztArYEjxeCy9zmVSXkd8KJtQfr6QAY4D/dUvTQtxdc89Ddlw0RUkvK4Jf3fI4e4FCnfVqzc5hkLL2NFY0MyaPcUudj+2Ej25x/D45i65Dq+J6GRsG0QL8fYgzBL0vIYFtyps8C01fEKPFOHbKpvz56aLFmJxX5egJ6kfKDrF+P6PsTxQeE4bkdAXgiPYCCHWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dWAaE7mHoMqy9edke4tuAGTfHMsBPtnYeVbYjqqZeEA=;
 b=d3Aoiv3X/PGyercn/9MScxfsx2dnHgZOwbmdkFspJ4XnwpCmYRSnojf5dpcvV8DauRIIJxXcDekqTKCsANwpHwRuHkr3UhsX699H5kBhZkJmT1uSLuVOjVhuKrYDaijzmWq1UzpFQNiHO7F77DSLFoanGsSSfWubfmkmND3zfkif5M7W7h/qjvphrOPB6FLuNKiLUddhK2oXVUFrlvu7OcnqvL6DDl2aDMj1Cq2Fi1rjJFMzsnYSgrxNe55b16tTuHHcjw+UecEIUe24U2unPLs1hsXFEX+N7i0a8FiowYDfVwkxix9dxvEvJk01HnlS/o94olWHsRryaodEjMNLhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWAaE7mHoMqy9edke4tuAGTfHMsBPtnYeVbYjqqZeEA=;
 b=XZOsn1FH7UoF0gujxRmhK/sCwub8ReLa/Q0KA4qh9tdI5+JScAWgDnkcs6n0NGyfEIPydyfqyds7XX8clMlSXQMuNNMdpwE3cw6/5KLvW5tF38XOZb3GXNY7MUJ2SzXCGK0/YsssXRZRLC74/0PxokjH1vD2MCYp6itKJa8Pqxfcdj6EWxvjJMcAmfA2dVkP90d4974Ca7TIRnP5bCpiEb0eEY4fjVtZ1/a3ZZPPZl/rJE1ydtDC04WmSzf0lofzihEFRX7KR7jmVw2o7m3etnzeN6ZAGeUnTcnuwCkg2Qr81D1weiUpRIC7rGj0SRwyuVhUsDpFeqElxB+HHDoLDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAXPR10MB5589.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:241::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.18; Sat, 27 May
 2023 16:48:33 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d638:8333:21fb:5f18]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d638:8333:21fb:5f18%7]) with mapi id 15.20.6433.018; Sat, 27 May 2023
 16:48:33 +0000
Message-ID: <5728b6ca-8c6a-9eb3-3926-e99cf7081414@siemens.com>
Date: Sat, 27 May 2023 18:48:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: [isar-cip-core][PATCH] squashfs: Calculate a smarter default
 SQUASHFS_MEMLIMIT
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Cc: "Moessbauer, Felix (T CED SES-DE)" <felix.moessbauer@siemens.com>
References: <46e8b3a2-128f-c63a-cbfc-6d38a1792a35@siemens.com>
In-Reply-To: <46e8b3a2-128f-c63a-cbfc-6d38a1792a35@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0122.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAXPR10MB5589:EE_
X-MS-Office365-Filtering-Correlation-Id: 44f23eed-1b39-4c62-7766-08db5ed2350f
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	28HHG0lvj6jYI/g/AsoVye9nSYNZ0A2N0BSjNL0Ra4tHzGHhj1oGKHw39PMLgtPAWdVFiHhlxhjOgH1jwdWP5c5jc+KY3q1A4wzxvTpWioD4hc0wz6WFdoqdDWZQoRgLBCLXkdyDgRCp8QC21qZwYgPcvoZwr0+aTDWU0TCcPrgRXGL7Y0wstGBhhMxmrTh1v0A8kM2iBiK9sagc5xSbzn4/LNKWdRyFQ2pX9P0jqbkfeeRJHKXMvW5hR37zkPDOBXe3GVYCQ9Lm6AYO1LyeZn0tP4JEu6IA0lqEObeH23LMaIkgCiRZiXpGPtoC/tlrAzqhV9UJSesjZLErKXek8X/z3xkQ/LLB85TgOIIC/J5Z/ECR1EfDvHbHz3P0/tqoQKN9fkn1tjrLBKOZfwOgT/tWjWza5rUc773ReyFZwI17VOtyrpV260+/yXwh6FNCC/AsXyqES9IfKRNxYbVwY3JV0bAxjpPtOpWCjQQG/RjSImv0/q+sdDLd/bhKVvUaj6f5BUf08SeZs2HL1xK6jaXLqvnyMSkCr1IHScWG5cAjMqHYcNAJtp9/DsYo1dKNO5Vv7nBt02Gal6oWD/4s1Qmg60ZweRcEJ5TF0/ynLnTj8hnGr7dxW0QOfSteGAN4RGV3egKlvJEq1AzL9Jowo6/sJlFPEcKMqVaVhMcnlYBcrK+lpbY+7BxiUc9DBYiV
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(346002)(39860400002)(366004)(451199021)(5660300002)(6666004)(8676002)(8936002)(82960400001)(38100700002)(2616005)(31696002)(83380400001)(86362001)(6512007)(6506007)(6486002)(107886003)(26005)(186003)(478600001)(66476007)(4326008)(6916009)(66556008)(41300700001)(44832011)(36756003)(316002)(66946007)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dXJVL2F6WEFnczRTZ3YvblB5c0pJSno2S2xRY3dFOGpTQzZ5d1cyNnpZS2JI?=
 =?utf-8?B?YzA3QjQzMml2bEwzdmtCWHF5ZEppR3IvVkFYTDBhTkMxZUVucllqalpBRFgz?=
 =?utf-8?B?ZnZNRXV3ZngxbVRreFJON3Q4cFdNMUljQXFHN2RBdUlBMHdnT0hlcnNWbVRk?=
 =?utf-8?B?UmxqVXdMUU0rY1FMWmpqUDJBY1gzN1ZNRFNwZktUaStmSnlFeERLK1k4ZC9I?=
 =?utf-8?B?MVhnamdOd1lYWFlLd3N5UnNQVUVLeDRXdElmaVEzT2hFbitlWHZyTEFRRmxt?=
 =?utf-8?B?VDEwSnhSSVJ4M015YzVBNTE1WGtXRVJGdzFIWS9nT3IyM05tTDRvSWw3bytM?=
 =?utf-8?B?b2x4VHVuRmg1RHFHOG9kSmVCTXl3UURyZnJUSis0Q2VrWXlvRFRLQ1Z5YTdM?=
 =?utf-8?B?WU1sZ3N5a25CMFlsQTlkMjdWMmx0aVlLM0NRczcyd1gwMGdHa2VxMGpzeFhh?=
 =?utf-8?B?dnprYlFRNk9ZWHo3N0U0TmlxTmJKZklhWkVCdTV4MlJtREJSUGhVWkd4ZkJY?=
 =?utf-8?B?RVhQNXlHQldvdFYxR2tNT3JvUHFMK25qZGFMRy91OEpaYkRIVjhVTGllMXN6?=
 =?utf-8?B?d1hZUXYzRFV2R2laV2xQWjNVU3RieHlmbmttWHA4WlVxWlJuK1dhZ1kwS2E2?=
 =?utf-8?B?WHY3b1BFeXFtdDVkTVJ3eTFNVThKOGs0Zkg2UzVGWkpMSTZzUVdBRlJ2TmVj?=
 =?utf-8?B?NENHcE1sc3NURkUwS1RFWmh6VnFPd2JNQjZNaVpUWFVLSTdoZnRienhScmxC?=
 =?utf-8?B?Y0YwK3hqeWZpVjdpNlh1dzR4dCtjWGk1L1VWRHBxOVNZMVdFaUtUTU1HclIx?=
 =?utf-8?B?VVlBZ2JxQXRXWHl0R294Rlp1OXdiYmRMUzZXVkxsZjcyOHBibDBnaGVJZi8v?=
 =?utf-8?B?eGpDZnRkN0p1V2p2U01TcVM3VFcyVWhIYnhBbTlvMjBrRHQvMEVCMHhQRU5s?=
 =?utf-8?B?MHhwUWNyQ3FWN1dlOVVNeDBhSG1zVTVwWUtpV3lDZUdnYzhRNkNJWGxaTnhw?=
 =?utf-8?B?cHNhekk0T1diYzQwNjlMOUt3bksyV0Nob3MybG9aS1A1TTBNcnRXYVBpejQ1?=
 =?utf-8?B?OTZzck13YXJZU1FTcmhpTmphRmNIQzZwd3g0Y2tndUpLbHJ0T25MdElPWFlh?=
 =?utf-8?B?SWY3TVZhTk1NZldMZWtDVk1MNjVVTFBTcENOc2JLWlZla2RBaFhFb05rMUEv?=
 =?utf-8?B?QzM1YU5UZXRGSmFJa0xuU3ViM09aWkVyQ3cwOUdacHhkR1grcTJucjlEc0VS?=
 =?utf-8?B?L3hnRFg5Y2hKMk82RmcxU2ZhMW9xNnRPa3pCeCsrQ1g0dHNubEk2cm1wa0Za?=
 =?utf-8?B?UXkyaURIQ01QVFlNZFhFOTlwNHlwNFA3V2djTEcxTy8rdUZtYWY3clNwUS83?=
 =?utf-8?B?SldSc2x5REwrcVJDaTlDdnZQOHd5LzdSRFZrM2VpbjM3QlFScHo0VUJlSWxE?=
 =?utf-8?B?NTdDU3dvQktyaGRiSEJvOGhTQzdzRDI3a0pNaFlzSjJ1RERIUE1sV25nZHZi?=
 =?utf-8?B?ZXVoQ092Slpzdys1bE1Mek04Y0xIdDQ4a2FkQVBVVG1YQjVwc2ZrdkRZNEpE?=
 =?utf-8?B?OHpWL01xb3lrMWk2NDRhNDh3bTMwVFZ4ckJabXRJNlJGenliWGtDSGsxeWRX?=
 =?utf-8?B?cXluTDZGQ2xpNVVDWnpETHh4ZVhtNXlieVpjYXZVSU5DWXFnTjU3dk52TzJ6?=
 =?utf-8?B?R2Y5SGdlRWVkMklHMTVOclIwNnBScWhodUI5RXJ0MzFxZ0VUMU13eGlacWJn?=
 =?utf-8?B?dkI0UFF4S0hMYXRpRklMa2pvaHdOa1lOZWl1RkdtMERsTmVZd0dFcDJHc1dJ?=
 =?utf-8?B?NTFWOUFQeWhxeDFuQTg2UUNoR2U1b2IzdjBJUzBNMkk2MlJLUnFZRktyeWNx?=
 =?utf-8?B?YlhFZFpZdHdxMG04ckRRaSsrYnZuUmxtMzBZRjdVYUJmck1zbzdob3Q5WEFy?=
 =?utf-8?B?Um9LZzdMOTVkcHo4anFKMEpWU2xRVXZFSnFYUXJESW0wa1JhYTFiVDFSWFNE?=
 =?utf-8?B?ZWd4ckFJNXdnc0NSYkdscjdCb1YvU2hhVmlWU3RqSi9tMXZYMFN4Wk5sVjNZ?=
 =?utf-8?B?SHpqZFB3TlpJVVhXUCtDdXV1YUgvWkJpemdhcVRuUVBYYnVNZTZ3TGZmSjVn?=
 =?utf-8?Q?LLn0ndoB4pkcHVXBp7eSk5YqX?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44f23eed-1b39-4c62-7766-08db5ed2350f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2023 16:48:33.2616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: luVnNj79LhCstI3QRSdW4IiM5duDSWyv55U+nkna/7Dbh5XHLZNFZz+no6bADPrIqHvbVn/o0yATAcQWZJ2F4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5589
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 27 May 2023 16:48:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11665

From: Jan Kiszka <jan.kiszka@siemens.com>

This should obsolete most - if not all - manual tuning in constrained
setups.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 classes/squashfs.bbclass | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/classes/squashfs.bbclass b/classes/squashfs.bbclass
index 1f2a7595..b39be0cd 100644
--- a/classes/squashfs.bbclass
+++ b/classes/squashfs.bbclass
@@ -9,6 +9,17 @@
 # SPDX-License-Identifier: MIT
 #
 
+def get_free_mem():
+    try:
+        with open('/proc/meminfo') as meminfo:
+            lines = meminfo.readlines()
+            for line in lines:
+                if line.startswith('MemAvailable:'):
+                    return int(line.split()[1]) * 1024
+    except FileNotFoundError:
+        pass
+    return 4*1024*1024*1024  # 4G
+
 IMAGER_INSTALL:squashfs += "squashfs-tools"
 
 SQUASHFS_EXCLUDE_DIRS ?= ""
@@ -16,8 +27,7 @@ SQUASHFS_CONTENT ?= "${PP_ROOTFS}"
 SQUASHFS_CREATION_ARGS ?= ""
 
 SQUASHFS_THREADS ?= "${@oe.utils.cpu_count(at_least=2)}"
-# default according to mksquasfs docs
-SQUASHFS_MEMLIMIT ?= "7982M"
+SQUASHFS_MEMLIMIT ?= "${@int(get_free_mem() * 3/4)}"
 SQUASHFS_CREATION_LIMITS = "-mem ${SQUASHFS_MEMLIMIT} -processors ${SQUASHFS_THREADS}"
 
 python __anonymous() {
-- 
2.35.3


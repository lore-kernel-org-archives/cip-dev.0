Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4786C04FFE
	for <webhook@archiver.kernel.org>; Fri, 17 May 2024 15:12:45 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.51])
 by mx.groups.io with SMTP id smtpd.web10.42562.1715958760401302251
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 May 2024 08:12:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=UaqMnbHb;
 spf=pass (domain: siemens.com, ip: 40.107.8.51, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kTBRHjasnnBmpyFUpVd/06P2TNQL0YSTWdLoGBUBaRCSsjAnI4exSRzfKGe3nSXZztMRVuh4OrmQa7SLTkxtuqFZU/63XqM+3U0Es6EhTAAsnHnXdvcVXIEWgUSgW/Dqq9/njd/fUA6SftD79OUj3G9mdmQu0ofvamgG6yQF2eDw5HrBQ2dW+terhxrGItTbm5BZPmM++o2Fz6ssVoPUZuwPnsnRzqlKCw56L+DicZgZJO87v845UQtOBatutoG517x8PdJGERlDWGsl1NuKtnRHUFRX4K6xh83Y3AlK6RXswT0SxTTqir8Hn7OBMyqYe6BaEoecIrO7QZ9zrwAdvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8U0NZRvtlDsh+Y+RerQt56q6TgMuoyS2O3f8kfJ4QTM=;
 b=YL1MnMTYZO8JfzKrOX6tzFqlJ34gOESe5qCENZBa1Jn5gyFEiup/kGvTQ+VdCGFyXX0fN7bfqzpSxNmY/D8aGZnxGBfD2I3CTm0GCjMMC/qlMXJDx3fxGL2s2kynkTzEUYwA4BgWshIeJZVXYhVVW19DTdSA76ijqGbIO4MbzRrZ75UNABiXeLE9z7R8PPt0jLHpEJ5O/QPHa9fM3FYq4wq9xeK2oxXP/7od0zM1QYpwnDMVU1JABVnf5E4oH8pim8wlwny51oDBjpnX+s0lVW6MbZtGCDkxOiPLShtNaY0gKMSLPt2xw86idqub2lK5T91M2wwR/vNGfIZpI6XaJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8U0NZRvtlDsh+Y+RerQt56q6TgMuoyS2O3f8kfJ4QTM=;
 b=UaqMnbHbeTdoyOs4sisI1gnbYW4fyHYAzhVUpafft+FhAmRJDLcMapaHZNFm0x6TtUwfUPaidrrxpLSxM7bv9dHDB/51Ss/n8sfdL8wfxiMD1CeOeEK1nOunp/58edyz4Ojrpz7p0RkJIvFeSq89i0mFK/4k61gURfNj4xbaUW0zpU2oifR/0yYLONwcoSu5qNBVNtIgU97DP6rdzWY5DbcxBzEmNpxO26JBk/g8QB4GVVYzheZ7WY6JRs4JN6L06uWl+tjyr1Hw/Y5SfHWJ3R3sM950yudc1P+rF5PK2xuIFEPh2ZEPfv9tdxlJ8igijLdNMA0KDhgGhX8F2ONlsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5502.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:305::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Fri, 17 May
 2024 15:12:36 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7587.026; Fri, 17 May 2024
 15:12:36 +0000
Message-ID: <a811770b-1ca2-424e-89d1-8a5da2df729f@siemens.com>
Date: Fri, 17 May 2024 17:12:34 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] Refactor tar.gz image option
Content-Language: en-US
Cc: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
 Chris Paterson <Chris.Paterson2@renesas.com>,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0050.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5502:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b420865-08fd-47e7-2210-08dc7683c8fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?bGlmb0FDTlkrUm1kazFQSytlZ2ZDTGlBcDhSK3czRWsvWDI5ME5HUFpEdjUw?=
 =?utf-8?B?eDVCVkNLSFhzYld2OENveCtUcm9kVjl1MDJYRVp5VHhRWWZGZXJrRFNkOVgr?=
 =?utf-8?B?MEtvTzFKQmZWTnIrTithZ2lZcVdnWnFMbHh1NWluWjZiMzJoT3UwYkp4eVNo?=
 =?utf-8?B?alRJczF4eEgvSFJwc0dyWm82TGFSVnRFdmdmOWhZYkVnQU0yVzQ1eFJhZitN?=
 =?utf-8?B?U1gvT0RuZk5uS05NaUF1TzBlSFNzTzFsR2J2bU0xdVJpc3plUVQxemFuVGt0?=
 =?utf-8?B?dUw2L0o4V29venNQejBZNWs4Q1oyeDk0NFkwMnh6L2p1ZVY0WEJDNlNxWWpW?=
 =?utf-8?B?T3B6clk2SDZURGtaWlowbjZ1U0FQbTk4WWNtODJYNDhRNFlUNVZ1clZNQllR?=
 =?utf-8?B?RU13ZFFyTGNoZkNuY0ZlS2hBaWxOQzhzalB2RjNHMmZxdW9HQzliSGZJcWZp?=
 =?utf-8?B?QTlwRVFiWmU4UExDdUlvME1wWDZFbGRIRGFhTVhrZWZaYXkwU3FnV25GOFJM?=
 =?utf-8?B?NkhoM29YYjRLU2tDbEZIOTRicndkNDNSTGVMcjB2TFVkWXdkL2d1ZkVXc05T?=
 =?utf-8?B?YmpEZUd6WEYzbTZJVzJ5aVdDV0VYa3JWUGpHekdabWZrenFzTTl5Q01HTmRV?=
 =?utf-8?B?eU9ZRlRvdGxSMWhJWWE4ODVxQks5RmttZkxYQ3c4UFhWSE9YYTNnMG9HZCs0?=
 =?utf-8?B?U0pVSTlFZjNaMk14YnUyMDFmUWxjSFRzbUdHdUQrbUloa1E1bmR3NVp1eTBN?=
 =?utf-8?B?end6cXA1MG1wRUhhb091aEZONHRpekhFSnN3OHlMNy9mSmV6NzBMVkZrODFZ?=
 =?utf-8?B?THJEMElDV21EanFGMWd3Uzdoamw3dGY3dXZ3MVRDMGNNb1ZHMURwVEgyWDk2?=
 =?utf-8?B?VHFRTDhDZzJGdmVkM3MycmtLMUlMZStsMk5kclJaYmxsQStXcEJ2b1EvN0Jl?=
 =?utf-8?B?SUlFaWFpK3ZwMW1QVWQvV0o3anRSK1hSWnFWaXNOaC9kOXVVMXZHV25EMEp6?=
 =?utf-8?B?ZzE4VkQxREJRZENHWk1SMXBqNmtYa0ZvRFgvRFN5VWpvZk02MTBHRDdsdEk1?=
 =?utf-8?B?MzhxdXYwRFhmMkEvZlcyS0Y2WG9EdlRvS1lYcGIwY0pLcksvNlZ1REJMaGZx?=
 =?utf-8?B?c0tZb1daOXdSdzVQN3ZTMWRTZVJNaHU0YVhsZWdrWW1UNXVuK0FkZmxVNFhK?=
 =?utf-8?B?bEJFQkVRVU9LMUQ5cVJ5ODNiQ3ZiT1pyTkJIaXY4UEdBL0liMzZJZzdBdENB?=
 =?utf-8?B?RHNMdWtFRnZSemtheDQ3L2ZPNllhbGF2NGoxdkdhRDJCdm9DU3E3cUZnSFNs?=
 =?utf-8?B?d0xYaUZPQkc1anJMYlA2YjNzV2lWb2VmbFlWL042TGNrZ2F5SERBc0U0Nmtl?=
 =?utf-8?B?Y1VIMWdPUFNqbktzem11M1hXY2Z5K05GNlVkRytZRlAyOFNlRkt3YlZyNit6?=
 =?utf-8?B?MGZtSHB1M3ZSRVpsU0xpbUQ3OGZSQ1ZHVzFlWWRZdkNxQ1grenlUeFFLczEr?=
 =?utf-8?B?WTRydmhNZHd2VUozN09YdDZJNFg0SHRkN25OcTlLTUJaclpiRHlabDlHMG5X?=
 =?utf-8?B?NlBDcnVDcHJPaXM5RU5EeTlwMVhiTFRHdkRNbHI2OGRyMDRCOEZqREdrdlFh?=
 =?utf-8?B?WHJmNDNsK2cxRmpSM2N4alppU2dyWGJtZXNrTHVVN09FNktFamhKZTYzQTJQ?=
 =?utf-8?B?T2VtaE1yTlFyL0xaVXZBTGpVeHRTV1g4NXRxalFxRG1STWp5ejQ2b0JRPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VUlTSFV4RWUwci9GeXFMeHVSSU9XaWM1TE01bXlXVXE2Skg0Sm9wMmZwKzh4?=
 =?utf-8?B?TGVRSnBFR3BQZ3JwMDVFaTBjTFBxNkIrbTJBeFllTExXbWFYNGZ0RGo1RG9J?=
 =?utf-8?B?cUZRdzVWaXBUYTk0VWc5V2VwYW5JTE1HcStsR1hHQ1VRMHFDekl2TnhIczRs?=
 =?utf-8?B?N0RQcjFQTHNHVTJLbFg2M1VSQXFKQ0Z5YjhzMnRyUDNIcU9HOHNSOFYwZUQw?=
 =?utf-8?B?dzg3TWtGTHh6TkMrdGhZOUZCV1BpSnBwaWx0bS9JajFZZlQwSXMyZjZFdDNz?=
 =?utf-8?B?MWZtVWE0UHVxWUYydit5eWV1MUFoUVZXbVVRK2YxL0puZ3VmL0lIbjZYYklq?=
 =?utf-8?B?R3hWbFpFb3VRVVFPQUtURjY5ZnFIaTVwQTRvSnljZlNVMFhONDF6dXI0b3JJ?=
 =?utf-8?B?TFZsc3I4dytsSDRST3oxbXlBdlhhY3pCOWJZYmhta1MzcVFLTWhGYTdRbnBz?=
 =?utf-8?B?V25PTHRYSDFjQWg1UjdQQVNFd21VR2xTMGN5OU54TStrWkFmV0t2NngzV1Z5?=
 =?utf-8?B?NzNnSEFxeGlhSWFyTXY5OWI2R1hkeFliSlYyR2ljRFB3TVo4d0hZblQ1V2h0?=
 =?utf-8?B?ZUoxUXdpaEtTajlHem1SSGhISzlQZ0F5bVlwbWNSWW5GUUZ6WHprelo3bHhC?=
 =?utf-8?B?K2JEOVZYRFJUSW9QMXFPb3ZhdW85Syt5YUNyK0JxbkdTRHFKR2VEYWJsWDJu?=
 =?utf-8?B?eEtLUEEyeTVwK2dhQ2g0YkdhOFlhTjV3dEtTRjR3Qy9xMGN1b2phVkpkemhZ?=
 =?utf-8?B?QmZmNzkzOHNyTG5POFdRV2theFZOc0x1Y0NobmxMZWFZdkkxdFk3amJiSllN?=
 =?utf-8?B?cUZCQ1pHZ1ZMUzJYU3Ywb1ZVSWJENUFVaHNNclJkSFZ2dUZxTXpGRzdVUlph?=
 =?utf-8?B?MmViWHlRTXJhN3k5Y3dzVy9Hd0NJeWlqNWVWVFNvOHYyTTJQMi9ndHEwQkJ3?=
 =?utf-8?B?Z293aVM4aTRUZzVpUHFaclF5L25CaVNKcE0vZjBHaFdWU0l0MHBmQ3NjWE05?=
 =?utf-8?B?SHl3clU1ek9EYUpkNHJaSVlnOXRVZkFsa1ZYNUZLeEh2eExlV1htUnV2Mm43?=
 =?utf-8?B?enZZS2VDZE5iSFRKVEM1ajBUYzB0MjF0eWRodjBmZUdnTlNFWWxOQXVYYXB1?=
 =?utf-8?B?ZzZKWnJ1bFJlbVQxVFNUR29wSjBGUUtpZ2svbFFuWnhKOHRDYU5majdzVFVn?=
 =?utf-8?B?ZzhNT3Rtc2RPRDZrTjlkUE51bjEwVHFwNS93emdQd2dTZ2xxdkN2ZXVkcS9x?=
 =?utf-8?B?cE02NU1kTjh5dmF3bmFLOGhxaWJ3VzduS0duaFBOT1poWXUyaUlCYVJGYWJ6?=
 =?utf-8?B?TElYL3FNUU5aNGk1YTNqQ0ROTFpRUFhZcU5FYi9taDhXZUNTdlhnWEo3OEkw?=
 =?utf-8?B?NWZ2czNsMHhXVGZKd3BlbWJyL0djdVJVeHJVdmkvSEIrUlFqb21jUFpXK1ZJ?=
 =?utf-8?B?V0FsakxGa3p0NTBGVmd3UGZkNi84VHBjK3FHcG5RUU5oZUhpcDloVVg0YTFQ?=
 =?utf-8?B?UUpyUlFVNW95Zk1DVDVvNlNrbnhzWHczTGFvcjZQdXI0ZHRhNnFMR3NLRW5H?=
 =?utf-8?B?R2ErbVZkNnByZzZPL3h0VUR6YkdDRHVoU3M1RHZsTnV3MlNqRWpTZzF6OGx2?=
 =?utf-8?B?L3Q1VFdrdDlBWUt6TGVNRkZ5THR6eHhaR1B6QjN3WlZnRVg0Q0pZVjFaODVY?=
 =?utf-8?B?M2xDQ0N3d1RiaGNjbndScG96R2tjRm5FMGh1WjFTTnBMcmduaDREbmRidlpK?=
 =?utf-8?B?ZVZZa3NxQjl4RlZjcVVkTFQ2ZjBlWktEYW9uRCtmaVFpOGpTazNyVnI4Y2hU?=
 =?utf-8?B?T1NGbnFIelRMbFBTZzRlbk9rdDhuaHg3YXlxSlJLK3pLQzRCM1dxdnRJVDRy?=
 =?utf-8?B?MDJBblQzQ0xmNEFGWEFzb0ZaTE1BR0lCbytQU0t4K0FyTGpzblIvdFo3b3pV?=
 =?utf-8?B?RHhBdUp4NkEvTkkyS0ZvalBwd2N4dG53dVEwY3pVU2JBcVAveVJpamtwSkx5?=
 =?utf-8?B?RnQzT0xtS0lEamNFdlMxOUhYTi8vdjBaRXNnand3YkZBNG0yVFR1K0p3M1p1?=
 =?utf-8?B?K0dGdkNUK1hhNWhGc0Vwd0VIQ3B2Z09xanp1anlqdklxME9pTFBGZHBFVUJM?=
 =?utf-8?B?b2lXcXhuNU4rWnNqcDlyWG9pckg4d3MzVC83cUk1QUJsNVdGNGh3OFl3Wnp3?=
 =?utf-8?B?aVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b420865-08fd-47e7-2210-08dc7683c8fd
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 15:12:36.5470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H+Ej8D6AhSsmWF1QuZvJRXhBcpEoEr93hwRieQP+FWnAAWWaXfUq1O1mDtwqYFdNx1pNAIAVUdUemabp+mz49A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5502
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 May 2024 15:12:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15911

From: Jan Kiszka <jan.kiszka@siemens.com>

We have wic-targz.img, we have targz-img - that'c confusion. What we
need is a way to say "generate (also) tarball of the image" so that we
can feed LAVA specifically. If the normal target image is wic or already
a raw partition (simple QEMU targets) should not matter.

So, consolidate the kas options and the kconfig menu. Furthermore,
simplify the CI options so that tarballs are by default on and turn it
off actively in case that format has no user or cannot work in the first
place.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Please double-check that we aren't missing relevant artifacts for 
testing now. CI passes, means that something to deploy was found when we 
requested to deploy.

 .gitlab-ci.yml                       | 40 +++++++---------------------
 Kconfig                              | 14 ++--------
 kas/opt/{targz-img.yml => targz.yml} |  4 +--
 kas/opt/wic-targz-img.yml            | 20 --------------
 4 files changed, 14 insertions(+), 64 deletions(-)
 rename kas/opt/{targz-img.yml => targz.yml} (71%)
 delete mode 100644 kas/opt/wic-targz-img.yml

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 72084f33..b4291d0d 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -20,8 +20,7 @@ variables:
   extension: none
   use_rt: enable
   encrypt: disable
-  wic_targz: enable
-  targz: disable
+  targz: enable
   dtb: none
   deploy: enable
   deploy_kernelci: disable
@@ -58,8 +57,7 @@ default:
   script:
     - if [ "${use_rt}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/rt.yml"; fi
     - if [ "${extension}" != "none" ]; then base_yaml="${base_yaml}:kas/opt/${extension}.yml"; fi
-    - if [ "${wic_targz}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/wic-targz-img.yml"; fi
-    - if [ "${targz}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/targz-img.yml"; fi
+    - if [ "${targz}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/targz.yml"; fi
     - if [ "${release}" = "buster" ]; then base_yaml="${base_yaml}:kas/opt/buster.yml"; fi
     - if [ "${release}" = "bullseye" ]; then base_yaml="${base_yaml}:kas/opt/bullseye.yml"; fi
     - if [ "${release}" = "bookworm" ]; then base_yaml="${base_yaml}:kas/opt/bookworm.yml"; fi
@@ -111,8 +109,6 @@ build:qemu-amd64-base:
     target: qemu-amd64
     extension: security
     use_rt: disable
-    wic_targz: disable
-    targz: enable
     build_swu_v2: enable
 
 build:qemu-amd64-base-kernelci:
@@ -122,8 +118,6 @@ build:qemu-amd64-base-kernelci:
     target: qemu-amd64
     extension: kernelci
     use_rt: disable
-    wic_targz: disable
-    targz: enable
     deploy: disable
     deploy_kernelci: enable
 
@@ -134,8 +128,6 @@ build:qemu-arm64-base:
     target: qemu-arm64
     extension: security
     use_rt: disable
-    wic_targz: disable
-    targz: enable
     build_swu_v2: enable
 
 build:qemu-arm64-base-kernelci:
@@ -145,8 +137,6 @@ build:qemu-arm64-base-kernelci:
     target: qemu-arm64
     extension: kernelci
     use_rt: disable
-    wic_targz: disable
-    targz: enable
     deploy: disable
     deploy_kernelci: enable
 
@@ -157,8 +147,6 @@ build:qemu-arm-base:
     target: qemu-arm
     extension: security
     use_rt: disable
-    wic_targz: disable
-    targz: enable
     build_swu_v2: enable
 
 build:qemu-arm-base-kernelci:
@@ -168,8 +156,6 @@ build:qemu-arm-base-kernelci:
     target: qemu-arm
     extension: kernelci
     use_rt: disable
-    wic_targz: disable
-    targz: enable
     deploy: disable
     deploy_kernelci: enable
 
@@ -211,8 +197,6 @@ build:qemu-amd64-test:
   variables:
     target:  qemu-amd64
     extension: test
-    wic_targz: disable
-    targz: enable
 
 build:qemu-arm64-test:
   extends:
@@ -220,8 +204,6 @@ build:qemu-arm64-test:
   variables:
     target:  qemu-arm64
     extension: test
-    wic_targz: disable
-    targz: enable
 
 build:qemu-arm-test:
   extends:
@@ -229,8 +211,6 @@ build:qemu-arm-test:
   variables:
     target:  qemu-arm
     extension: test
-    wic_targz: disable
-    targz: enable
 
 # secure boot images
 build:qemu-amd64-secure-boot:
@@ -240,7 +220,7 @@ build:qemu-amd64-secure-boot:
     target: qemu-amd64
     extension: ebg-secure-boot-snakeoil
     use_rt: disable
-    wic_targz: disable
+    targz: disable
     deploy: disable
 
 build:qemu-amd64-secure-boot-encrypt:
@@ -250,7 +230,7 @@ build:qemu-amd64-secure-boot-encrypt:
     target: qemu-amd64
     extension: ebg-secure-boot-snakeoil
     use_rt: disable
-    wic_targz: disable
+    targz: disable
     deploy: disable
     encrypt: enable
 
@@ -261,7 +241,7 @@ build:qemu-amd64-swupdate:
     target: qemu-amd64
     extension: ebg-swu
     use_rt: disable
-    wic_targz: disable
+    targz: disable
     deploy: disable
 
 # secure boot images arm64
@@ -272,7 +252,7 @@ build:qemu-arm64-secure-boot:
     target: qemu-arm64
     extension: ebg-secure-boot-snakeoil
     use_rt: disable
-    wic_targz: disable
+    targz: disable
     deploy: disable
 
 # secure boot images arm
@@ -283,7 +263,7 @@ build:qemu-arm-secure-boot:
     target: qemu-arm
     extension: ebg-secure-boot-snakeoil
     use_rt: disable
-    wic_targz: disable
+    targz: disable
     deploy: disable
 
 # bullseye images
@@ -312,7 +292,7 @@ build:qemu-amd64-secure-boot-bullseye:
     target: qemu-amd64
     extension: ebg-secure-boot-snakeoil
     use_rt: disable
-    wic_targz: disable
+    targz: disable
     deploy: disable
     swupdate_version: "2022.12"
 
@@ -342,7 +322,7 @@ build:qemu-amd64-secure-boot-buster:
     target: qemu-amd64
     extension: ebg-secure-boot-snakeoil
     use_rt: disable
-    wic_targz: disable
+    targz: disable
     deploy: disable
     encrypt: enable
 
@@ -354,7 +334,7 @@ build:qemu-riscv64:
     target: qemu-riscv64
     release: sid
     use_rt: disable
-    wic_targz: disable
+    targz: disable
     deploy: disable
 
 cve-checks:
diff --git a/Kconfig b/Kconfig
index 600e568a..e88cb5fe 100644
--- a/Kconfig
+++ b/Kconfig
@@ -151,22 +151,12 @@ config KAS_INCLUDE_DEBIAN
 
 comment "Image features"
 
-choice
-	prompt "Image formats"
-	default IMAGE_FLASH
-
-config IMAGE_FLASH
-	bool "Flashable image"
-
 config IMAGE_ARTIFACTS
 	bool "Separate artifacts for NFS boot"
 
-endchoice
-
-config KAS_INCLUDE_IMAGE_FORMAT
+config KAS_INCLUDE_TAR_FORMAT
 	string
-	default "kas/opt/targz-img.yml" if IMAGE_ARTIFACTS && (TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM)
-	default "kas/opt/wic-targz-img.yml" if IMAGE_ARTIFACTS && !(TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM)
+	default "kas/opt/targz.yml" if IMAGE_ARTIFACTS
 
 config IMAGE_SECURITY
 	bool "Security extensions"
diff --git a/kas/opt/targz-img.yml b/kas/opt/targz.yml
similarity index 71%
rename from kas/opt/targz-img.yml
rename to kas/opt/targz.yml
index fd8303e4..5c0b87bf 100644
--- a/kas/opt/targz-img.yml
+++ b/kas/opt/targz.yml
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2019
+# Copyright (c) Siemens AG, 2019-2024
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -14,4 +14,4 @@ header:
 
 local_conf_header:
   image-type: |
-    IMAGE_FSTYPES = "tar.gz"
+    IMAGE_FSTYPES:append = " tar.gz"
diff --git a/kas/opt/wic-targz-img.yml b/kas/opt/wic-targz-img.yml
deleted file mode 100644
index 74053f52..00000000
--- a/kas/opt/wic-targz-img.yml
+++ /dev/null
@@ -1,20 +0,0 @@
-#
-# CIP Core, generic profile
-#
-# Copyright (c) Siemens AG, 2019
-#
-# Authors:
-#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
-#
-# SPDX-License-Identifier: MIT
-#
-
-header:
-  version: 14
-
-# lava uses nfs to deploy the image. For this we need a tarball instead of
-# full image
-
-local_conf_header:
-  image-type: |
-    IMAGE_FSTYPES = "wic tar.gz"
-- 
2.35.3


Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7040DC47DB7
	for <webhook@archiver.kernel.org>; Fri, 19 Jan 2024 09:49:16 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.57])
 by mx.groups.io with SMTP id smtpd.web11.18545.1705657748144445248
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Jan 2024 01:49:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=fcyMKBtH;
 spf=pass (domain: siemens.com, ip: 40.107.20.57, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FxVN95FRyLML9R7xQPuSG4jsemwAzTeNNgmoEQ/Dq5UGQ3dmrbUHOHqHOcqiTmbAKQ5L243nFYU0kTDACIF/2D+Be8MuEZ32g+P8dIakHrIn07wu0H2ZAjQc6eTw7YNuZ1DRYywRk5FUjHbcTVg4qt6J8h7EQlgCOOe1lJjpI92jiBPzGmcNJj+L/U9GaNCJLeL7DTrxn8YPC9RhigCjEVTX6Y0QPua8Lro7U5z957QuEXaKZlVPgunNxbkiG/EkxLeOp6duRFgPwYGmMm0Ggom0539WCEY7gqaWpG3X/THuPHx5353oQWLSu9olxY03dnMEOHkaPzOU4AffJGjF9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KgM7f34KBsm0DCo4PSXafKgsKbrSX4INqQd2y7e8m4I=;
 b=KSVD3lzRlao3Fo4tDfx9QAO/QEoc0RkuDwWOMX6SqOF8irSEWdHZMji0evNd4A0jAffb6UbVUYn6GDus6KvdQpztTohtnrZp/YmQvpfd3vd8kFVRaeXgJ1p72N4c4CoFdgSyv3IftDlSXQghNOnonNtdPZqUrsg3jQU6jhtdgpVwFKE5DX8O89VNYg7QZ8iFj4ZrZA5XoC+yvrep0J1WOjBEKmcs6V21UFsebKQZlGNJyCIIXwN0tJrcQ+ZGZ9YyPnYs9R3117NbRBDc8vn8h8a17/tIZxNMhc9NZcazCljkq5SAlEwm5qU26OP0IMXgDURj1wBVp2CVv26HwAwhxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KgM7f34KBsm0DCo4PSXafKgsKbrSX4INqQd2y7e8m4I=;
 b=fcyMKBtHAjulQjHxjcrBMiobBB/Vl0l3/7A/R1mLT07vcbtMuBCOQ9YkmMEX3rfXIKpA9qrX9DZUbCrIw0869tpE3l1LiNuZx34t4iQFG2Sj4eD2VI+bORLpheL5MgW/MoflP6OutqZNZ02jcBdSW4qrdI5i4ItCe11IZIxfwHKc9xywJ8PIM9cmEltbrmYSktgggpoEBQHDeNN1AIh0rHHgbUBAoER/dDRE0bbENgyfetnr/zF9rhHBJzwpnyzXuOTFOPB9wDsofAiDSzz3qNz6G4C1YxXOdV0tkG8Vg4TPPHzTJkcTTjXA/CqJ8+45CfCdwLg7sZ68uy/NVzSluw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6363.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:56f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Fri, 19 Jan
 2024 09:49:05 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7202.024; Fri, 19 Jan 2024
 09:49:05 +0000
Message-ID: <fd3b70b3-51db-4959-b35f-250b44165234@siemens.com>
Date: Fri, 19 Jan 2024 10:49:04 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 5.10.208-cip43
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0053.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6363:EE_
X-MS-Office365-Filtering-Correlation-Id: 45afcbf5-8ec1-4c2d-163c-08dc18d3dfed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	y30FKV6pthiNBxw4KWSYEl6gERuGZQ7vjBpvmVa1adhHSI6WectH9EBDXJjOWKCNvonjePk4aUcBOfIB7Yr2LKStpCjKSo243FD9jf7tl0dM0v6EK8Vvag3q/frfpK//DX/5Yub7aPIZZmKp3QPJ1231xp7lZW48knpIxKmL4LAJcaGubLuYn2z+kZ61E2J40lHR8qvzg5KXk+WRQwoXIUiqWisBmhfyp4Z9ImYenEerundScyJ7ZAEGVtHNekv+R3spDcUcwwHHUTh/lN0aQpaJtQwPTeY7J3Dp5qthX4U9K97mXg/0VGP+EJoYSFh7IZ90TMz8ToQW4kOh43mcLBldXbJqD4dggAz/3IELcXOnxBq8x/yHUuYezLNusxySw5MmDpDm2x4putYFi1x22gV7CyKWt9GqqHRoJMVv3gOaftsEregkio7FYbQdiKTqliKwV3f2wxOj+fiNGsSCX2phqtxy8r/LM6DoIozP+b5ivggz2p0H57iBVbKn/yqDP2P87+6hTLYHC/VGI3DH1IW3Shux31wQwiFlrh4HsVLCMJw/VKR6pTt2+4CSIkaAX+3yujCEoaVredd+GdQHY5Rl9RIieszGHHwbaTRqpbXPydFewAEEEqqBhyu0IOPjTRT/hKr49Ot0DYQ1m3ghxA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(136003)(366004)(39860400002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(82960400001)(2616005)(6486002)(26005)(44832011)(36756003)(31686004)(6506007)(6512007)(478600001)(83380400001)(66476007)(6916009)(316002)(8676002)(8936002)(66556008)(38100700002)(66946007)(86362001)(31696002)(2906002)(4744005)(5660300002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?S1dNUGVTYkI4SDQxdkpvR3gzQmRuRXBTb3pvek54NUpXb1Zzb0dpcjV2dGxL?=
 =?utf-8?B?dmxLcThHa2F5cG0yeExBR1lmWEljd2J4cFB6K3NUWVQ3Qjg2RkVQdlcrajRi?=
 =?utf-8?B?bklIRmg4QkhCZ3ZxQWY3ZktwMkIxOERJMDNTS05vQXd0TEVUeU9ZZVdUTDFU?=
 =?utf-8?B?Mm0wbk5EOVZNOVMvWERCS2NBM1MweW5zSmNFVkdjUFpHNy84aWFTVkJZSHEy?=
 =?utf-8?B?MFJYZ0NtWnVCcENuQW5la0Q1bVBpRzkrZlJBTTNMRTBpUGRVK3NBUGpyS3Ar?=
 =?utf-8?B?WGdwM1hhTDI4azYrQkVtS0ozbS9kcU5Fc0plL1ZTd2VwYTF6UFJZT1Urb1l2?=
 =?utf-8?B?eC9oa0paRm4zcTZLNjVHc2x3dUxNV2QzaHR3b0tmRWtrMm1OSnYvOUI0b2FG?=
 =?utf-8?B?Q0g2MXEwTWZUWVozQnNyQWs0dE9FSWZ1UFZVSmcrZlJtaSs1dFhnaldJWTZq?=
 =?utf-8?B?eVVBczlGN2RVUGxOVXRzcWFrbkptZjlZSjI1QUk2d2doZnUxdnVwWVJIUkRt?=
 =?utf-8?B?ck9NaEFhRXl0cFdkcnQxcGgxd0xQMkVqRnlkUzZrWUd4MldxOXJ5RkF0NWNI?=
 =?utf-8?B?dlp1aWtJVXpIYi9SV1VnVmFWZU1pcTc2Q3QyVWM0WFJMTHR4UTlObHFXWGxp?=
 =?utf-8?B?MkhpcEVUdVd0OXNUdUNiT3RXYm5PQXlQb0dsMUtaa1E5TDdRRHlGdkRsNm5k?=
 =?utf-8?B?YkYrd2pGdmdzT3NPN2tNdkhxbFpyQkhCMEVsQ0xGZmhFME4rVDYwM2VrdVBY?=
 =?utf-8?B?bXRvWk9Xa0pYLzFoZW5LL1l3M3hDRVAzNGtOMkkyY2hOQjY1T1NLVzBlRFRY?=
 =?utf-8?B?YkdTOWlrU01WYTVzWjBCNWpoVzU3SzRRbEE0VDdYL1NyaUFkM0pZa3YxRVNj?=
 =?utf-8?B?eEhCUmU1Z0VjRE16NURtdU5saERDOGRnMTl2OE1TMGVEOEZZa1VuS1VjdTcv?=
 =?utf-8?B?ZmdSTEhrbXhTSHY0R0tUMGFWSk1YOFd1YVpuakZXbjgrZEpIdUROemtXWXds?=
 =?utf-8?B?TnpFR2FmWDg0eDE4d2hWZ3RyTXFnWVNEdDd2WHBjYzBzQzBZU1NFNFRRMUl2?=
 =?utf-8?B?UWg3MTRpclRkbkg3UG5QL2xsdXFPQjkxcCt0Sm5XaGJqdjd6UWU2MlFqTTR6?=
 =?utf-8?B?SFJNQTg5SVdja1VBeHh3MndjTGkwMnVhNFJkZUtncUpKeHlMdTZWTVZSdG4y?=
 =?utf-8?B?eDV0cjV5bG84dStvTVl1MXNWRkVneHUxdzZwenRVY1lRWlM4Mlp6T2JWbmU2?=
 =?utf-8?B?aWVRMDN6cjhzT3ZCRlN3Q2RFVEVPdGw4WFNjRjRxQnJlbmdRVEpsNUZIV1l1?=
 =?utf-8?B?K2ZvTExIZ2N4eGxheG5mQ3UyeUdFZFdteFUzd0xPbW1UQmRGRmpHelc5dlBw?=
 =?utf-8?B?VW96Y1ZrTVk5cWUwbFhzQXlOZ1BSdTBYOFg0SXFKU2FYR2pXTEYzOVdmOWRv?=
 =?utf-8?B?eFA1UWkyUldNbkZrd3hjTy9UWEg1RnZ4SmxpMldpMnl5YVFNcGg1a0Mxck9B?=
 =?utf-8?B?TnZWVWpNd2pSUXlPdWlSUWRmelgrNVBVdVhZUUFLWXR6aTNFV3RLNzBOeVlM?=
 =?utf-8?B?SVVLTXF2VDV2dzlLMmZXRHhXM090a1gxQnBLMU5GQ0d6aUNIdUZKQnZmSlJ0?=
 =?utf-8?B?eXZzWjMvREdkT1B6M3M2M2xubzZRcFZPVTNFK2M2Vk1VeDNMK2hQdzJhUWtI?=
 =?utf-8?B?KzdIU3N3cmJYbXdVSjNsanRGUExMUDVKand6dXprSVR2bHVTLzJjTmlrUGZM?=
 =?utf-8?B?Lyt5anYzc1Y2V2gybTE4aXlFeldMRHd6aXoveERHVjdsaHpaNnlyaHlVS0FF?=
 =?utf-8?B?dmV2aVdIc0cwYzJvNHcrUmd3TFRmTUs4ckVWOTYxRHUvcHVsamlwbUxBZHhu?=
 =?utf-8?B?T2tTRGZobm5XNEdGSVR5bXRUTENEWDYva0U4MDZjWm1PTG5SbTA2Z0JiK3R0?=
 =?utf-8?B?c2JLcEk0QXdCaVNWTHJHRW0vR01sOGlvNmNPWXU4V256NFp3MDk1SHlwN1J2?=
 =?utf-8?B?M05pNWJaZmd5Ym1jU050MHM5SWkzb28rYW9ZRkYyNTI2ZFVLMHdOdENXTndX?=
 =?utf-8?B?R1hKNGxkekVGdjNPVHRublpKcXFyMEdqNnZkVlJOLy9XTGUzVjhPemdRaXNq?=
 =?utf-8?B?bU5hTkdvRFBadzFhOUs1VzFtR2hQN2ZqOW1GS05OSjdHR204YjJkeGUyYWFE?=
 =?utf-8?B?Z1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45afcbf5-8ec1-4c2d-163c-08dc18d3dfed
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 09:49:05.4831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: trKxIc3FNAxHX+unQvrpalmS9TTFF2FcEXVz85IG/0DaHsGdRIgzMYHq+esK4QMJdbGgfVWTlfkVvEabYjLzUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6363
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Jan 2024 09:49:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14425

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...{linux-cip_5.10.205-cip42.bb => linux-cip_5.10.208-cip43.bb} | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename recipes-kernel/linux/{linux-cip_5.10.205-cip42.bb => linux-cip_5.10.208-cip43.bb} (68%)

diff --git a/recipes-kernel/linux/linux-cip_5.10.205-cip42.bb b/recipes-kernel/linux/linux-cip_5.10.208-cip43.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_5.10.205-cip42.bb
rename to recipes-kernel/linux/linux-cip_5.10.208-cip43.bb
index 707be1fe..35a29fae 100644
--- a/recipes-kernel/linux/linux-cip_5.10.205-cip42.bb
+++ b/recipes-kernel/linux/linux-cip_5.10.208-cip43.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "b4734a7a22a30f3c20f9437c366bde0dd584bebe836d1ef622d4c1d7205e6f54"
+SRC_URI[sha256sum] = "610da17b684132cc30480c496f8d75335d112ee20d683d68268d44717ae2be46"
-- 
2.35.3


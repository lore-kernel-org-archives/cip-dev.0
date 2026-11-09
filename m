Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3921.1794223087794191231
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Nov 2026 03:18:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=oARwFTT+;
 spf=pass (domain: siemens.com, ip: 52.101.72.47, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JnyLIEB9A9Rej8Mp7M+PQXzyNFI9RRRa53CuiqihI9K3tscmQFy9/VMjADZI8H0ox4UIgnDrs2IHZPK+QyDsAYFDZ8CgGt+Zi8ljN5nb7hmvhxQ5sHRrP8Gf2zNbGwoTAzIDSsJKj/QtXQ2atw9WvTTODfK5Dp1wn3Jxc0+S1YATxTkdlz/erIESuXK3zOfU5stvxPflHVK9DsQ05oulj+vNJrBwJa4S80X0GYAemMNud0n0kZLYQkbps79NfnpPqMWb41tlaTQPqB0TpeTnY77HsqME62kKEmvu3MVpb3eB99ORnT7JwZO+ZMCrd4l/GCrrQFTJgwyO5TRRqFSPWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eQfoZtZbKOO63brrNX+IyX3YS22kzHSNBKx+ThzOnmU=;
 b=E0WOSWMOmUObhFlrah+x5rjhBIRtKwuQZos0ee2QI2K7BgiU81ncgDNyL40k+D+koMSsQiJJjASwTXCeF2Pnzapbah/R1x8G6WnDDIoaAigBdXWV5Uu2X4fW365yE/B2cv1h4VtC16Utg53ZVOwrSzvKbSECJIXcGt+2TE4d48iKe074V2+08gUIOyx8fTWuS7F3NeaPJjgzjK8WnfBsl9zqBMh7iKKkpMaWZv3anwCHHNJtg4rZ8uQ+nyjIxEp4U28bWKYcLHgKlRYLR3BPLuYWveIrcFtmP7TcJBqbtlxPpft3HbrlW0LHeEF2UGyy0yVX1QLMIdCtDlVvLRdKMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eQfoZtZbKOO63brrNX+IyX3YS22kzHSNBKx+ThzOnmU=;
 b=oARwFTT+OfmGIsdpQZ0h52bRie7O6Bee5n0Ylf3cm1xQhO0riRVYrfgRqIX8gUswFxwViLpTdIUavtE5WvQEeBtpT6PjrL/DMA91FiFzMAP+9H7ITpCVQ4nW/mV9TjdbaAFuMikPLf4hXRyYGwKRx0RNNSFqW3QhMVUe9LA6fE+HoP5ZmVEROy/2a/sgdS9t7HdKk/qNRhEPA3Fugfcc49DAbwQd1/bNgebW/GB1CkGOsqy4tGQbg3hvI0Tsa34d2mzg7MB5jyru2psvlBkE+LwfqVcE/WlIrecPRxQ4/a5MHIv2jEIZLFFmjPBZp7PiG9RKmdxmVWSgEH14aSpNbg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by AMBPR10MB830290.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:7b3::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Mon, 9 Nov 2026
 11:18:02 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0615.007; Mon, 9 Nov 2026
 11:18:02 +0000
Message-ID: <fc99e76e-cea3-478f-aeb1-8e14f6d528a7@siemens.com>
Date: Mon, 9 Nov 2026 12:18:01 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] start-qemu: Fix execution of test image
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0049.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::9) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
Return-Path: jan.kiszka@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|AMBPR10MB830290:EE_
X-MS-Office365-Filtering-Correlation-Id: 10499d90-6df4-46e1-2763-08df3e531e8d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|18002099003|10067099003|55112099003|56012099006|11063799006|261028144727099003|261102123227099003|261022115727099003|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: 9qbEcTXNDmggZfg+Jlylto/0ZM9QNA1//UgyI1bSHzlDKZGS/8S2nFJXvzJCwou3jO/seULpAXE4HnMw8PWDTh3QZaIGSxv9EztrxpVGrZcOb+MmnjT5l4lB7ra9KT631HW2SZ2SdgZ3VpfU9BrPQjpYB3zJiEDnVqZ/im1S05BA4p6B/pTRFWKaojsnI3o5IqZJN5ZtP7OJprvXKFBebKQ/jOaf9PWCMdOG4CbXrQK6iDowftYpZMsRIOUftWse2oVFvlOs+RZyjnfl3GJtfE0i9ddAn2x8Vsn7JTJXEVi6fTAv58dRYLNpo/9dAnSV23ZiG+ZkSf3GtQBwmnhGRKqymMuBqLbZsUnFvQQzanXR9mjZWCW7gYSQBz0e7YymLMZNe685pOtz036xSNp4YiFfI0WsqqTIn5PEcfFXOhE7mjmAsT3QOJOa1o8pI0LuQGmFkv3iKcY7uNTkpjFKsA+HMjBhax4kotHvMpq+T5hJc05QSH+CPgIWcZeVtz1MSkgJehR6X1wowXJORk+IQioOoW6+5xPd8KYxBCzT5HnqQLQ86+VwYVf1E6iJTbgLIy5PFPdc2Ub0IXs76ujySGPYsFIAQ8+ynEKtqSy/AqG1kGHJwFTKd9FAWxXfj0SvmjrvPOfaG3OR1RxQlTMR5Hx8wRQWA+6wmJFeqFlHNDY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(18002099003)(10067099003)(55112099003)(56012099006)(11063799006)(261028144727099003)(261102123227099003)(261022115727099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VG11aVd0UVJyVlZLMXB0aWdlWHRjYVJDY21WNnNzZFBRSy9ZUy9iUjJCRTl5?=
 =?utf-8?B?QzRHUFBGWVBXbDFPemNTRGVld01KVGpLOVFLblRIUTQ3b09rak5nMlVvTDAv?=
 =?utf-8?B?VXkzME5QVHhhUTBkeXFxY25kYWYydlQyRG8rMjEvUUJJdUhSNHBnK1dMNUp3?=
 =?utf-8?B?dEJzMVI5K3QzNnZHQVBoSDV4eFdhNmEzTktJV2M4eW9BbjB2UlJrYVBDVDRO?=
 =?utf-8?B?VVAybVNaRlB5SEdKUFJZb2k1M1B1eGZveGpKdG4wY1ZMeTNEL1RhS1UrcVVt?=
 =?utf-8?B?SzMrbkFqRkZBNFpBKzJVSEJIMVlSWU4yMVRidS9obkdjY200eU1NbVZ2T2k2?=
 =?utf-8?B?Z3BzVlJ3YnVDSVpLK0FVaEszbDlNeHJYeWVxWEpXOWNNTUtNb0tMTUxxQmVE?=
 =?utf-8?B?Z0w1VWw1WXdpS3NYUnpqVW1ldk9WL1NGdUEwNVhmSmRhTnVTVGlacTBkYWU2?=
 =?utf-8?B?YjJSN3h4alZnT2FBb0RtTktMY1Iza2ZvemxXbHZsWEd5SWM3NTFDS2xOQTVn?=
 =?utf-8?B?Zjg2V3Y2bmRKYVRGdDQ5VXpCbHFQOXBUUGh0RllmdG9jUjRPZDhLUmpTWEtF?=
 =?utf-8?B?OGxwa3Y0SmQ2a0oyckJUN1YvNzBMOFZaZ0RXK3V6cVB1dXNXZXRYbWxEcGpr?=
 =?utf-8?B?UU85TVNsMlE1SU55My92d2w4QXU2R2V5SmlJVTRUS2xVOWJwbzRyOUljNzNT?=
 =?utf-8?B?K1U3M1dUZ0IyWngxZ3FIRnNMSmFtQ3NyM29KZ2xXVm9CbTliYVh0RWhqL0cx?=
 =?utf-8?B?U0QyTkE2Sk5NS3AzZ2F2d2U3MGN6d1U4RnhGWk93U1FSQ1ptQ3dMS3NkRUlu?=
 =?utf-8?B?b1RiRFYyYVUrU2k3dm1xVE55STl3Rm5MbzA5UFI2blF1S29SeS9IU1hOcjVP?=
 =?utf-8?B?NU04elI5Mm5zL0JpdkRhQXdTVXY2bmFDZmp1ZVdBUFhWamJwa2U5K2VuNnNF?=
 =?utf-8?B?U3VPMGtMaFU5WG5ZODFvc05XOXkyQ3ZhZ0RIZUx5bkMwY2VJL2p1ZTh1Nm1t?=
 =?utf-8?B?c0NTNXBaRHZhVW9Gd0FiT1FOa2dDQ1ZtMmpHMjRsOG9leTRMUU9HUlIwM1Z2?=
 =?utf-8?B?UU1SbzZLRkxFVmluOFN2eUh0T0M5dEFxblVTcU1LdWh1bC9FNjhCY1dra1Er?=
 =?utf-8?B?L2cxRzltS0k2bFRNZXp6amhBaWJJbjUrcUt2TXNsU1lPOVVyUzA4cUJJU01W?=
 =?utf-8?B?SytHcDEySG5lSThMWmdweGFXdWkyRG9uYTUyczJ1bEczVVRQTkZZa3RzWGdM?=
 =?utf-8?B?YlVZdk1qRXlFUlpjb0s0YU9raVdDNTJoSEtGNnk3Wk85SGJhQ3RGR0FCa3lN?=
 =?utf-8?B?eERJbjVrMHJ1TUNNZ1IrOWZwczJORjk0R0kzd0JVRVdTKy9icjFnbTRNUy81?=
 =?utf-8?B?ZmwxUFcxN0JMaTJUY1poRVBCVTBGeVBnaGNnek1LeTcwc3ltOGw5alU4TzVV?=
 =?utf-8?B?YmxNa011TDloTGtadWlkL3RNKy93RFlLMmRsRkF6akw1TFcxcXY5c1htUDRZ?=
 =?utf-8?B?STZoSHVnTE44S1FWaWVxVlVaLzhxRWxSYWFPNGs3TGNPT1loZGtCOER5NUZY?=
 =?utf-8?B?Tm5TdVZ3STBVWVROeUozbVBlcjRWZ25kUW9weG9xUFVmT0JEVmZTNUJaMURN?=
 =?utf-8?B?SEhhTXczNytVcmNRQWtLV1I0QjhFNDFaclBYTklUekNsMmd2UTJRam5sOG9D?=
 =?utf-8?B?bVBBN0lqcElYYW9qQk9sRW1PRHdDdEtqWWhXT29oeTBsNDlCQk5rKy93T29I?=
 =?utf-8?B?V0Q5OVE0SzhMMTJoeklEUXRiUlR3dmsyTHpCNW1Sd0Jzd1lQaFRIU2FVT3ps?=
 =?utf-8?B?azQzb2hLUnNDR3lKVjE0ZVd1QUVqRklZVzhVR2N6b2g2N3FPbzRuNFdLYS9V?=
 =?utf-8?B?YVgxcllBRkpRd2g2S05DdFRBdVQvSkN4U3NXNkVLR3lLY2pGd0NwNjJyRU4y?=
 =?utf-8?B?Z2hxZ0VrWUYzMjlrSTU3ZER6MWk1YzF5QTdZWVpiQmhkZWdQaDgrZmltZDNk?=
 =?utf-8?B?Zy9aNUo3d0M5U0pCK2hRMGZ2bVY1R05tTDBpYWJnNXlIaFJkY0ZmUW1OeGhh?=
 =?utf-8?B?cnRQaHY3SGJ3Z3BlclpSVGRtbEp3MEllNTJjaUVHcTVuOHpLUlYxVE1NaXpD?=
 =?utf-8?B?OHVYZE4yRGNjVzZaMDdSekJ3VnRVdkduaDZkZUJBeDBQN281TEFkVGVlQzlh?=
 =?utf-8?B?clA4VXRPdmFjb2lWK05mdnZSMi85MkRyUTFoOXk3aFlva09iQkM3V3JJR2F0?=
 =?utf-8?B?bVlMK3hKdnUwOEp3VG50T3N5OVlnb216TXBaREI3N0pLVUg5UExqbFYzczh5?=
 =?utf-8?B?YVNVR201UWxWaG9OOExpNXlDQW00VCswTmFteC9FVHBuU0lHUEhGUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10499d90-6df4-46e1-2763-08df3e531e8d
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 11:18:02.6433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZroeoMI1kwnmNpEk31JU9+hael1+RwE5I9xsrVlqsj7VDtSRIlVNQbC+fg+NJh9WiTijtoHb+KQ+GI8x2K0AVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR10MB830290
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 09 Nov 2026 11:18:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24695

From: Jan Kiszka <jan.kiszka@siemens.com>

Either Isar changed the way initrd image names are constructed or this
was always broken. In any case: the test image suffix is not part of the
initrd file name. Strip it in case it was part of IMAGE_PREFIX.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 start-qemu.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/start-qemu.sh b/start-qemu.sh
index cdc6d931..da2ffdb3 100755
--- a/start-qemu.sh
+++ b/start-qemu.sh
@@ -273,7 +273,7 @@ else
 		IMAGE_FILE=$(ls ${IMAGE_PREFIX}.ext4)
 
 		KERNEL_FILE=$(ls ${IMAGE_PREFIX}-vmlinu* | tail -1)
-		INITRD_FILE=$(ls ${IMAGE_PREFIX}-initrd.img* | tail -1)
+		INITRD_FILE=$(ls ${IMAGE_PREFIX%%$TEST_IMAGE}-initrd.img* | tail -1)
 
 		${QEMU_PATH}${QEMU} \
 			-drive file=${IMAGE_FILE},discard=unmap,if=none,id=disk,format=raw \
-- 
2.47.3

Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D77AD232F4
	for <webhook@archiver.kernel.org>; Fri,  9 Jan 2026 08:35:46 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6167.1767947745300261368
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 Jan 2026 00:35:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=gZGgQ6Yn;
 spf=pass (domain: siemens.com, ip: 52.101.70.46, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e90IomjakKNoSN+LLox5g9u8xkbBttEYnbTk7IZc+N5CZGcRLUK1zf6VJsVjtAkQZMkCac6uTyyL+k8N/B/jt0dFqett1x7qIrS5wjWM2GmZt5/e5MzaCyDXw9HyV3rbItakiN8P+ENjQziXUg/TqWRHkniuJs45aAMik6Jyvt27VIqRxFpxP3US03d/Xvg6zG8nN0phSaiEVBeV1qVUVLdzAW3cg0vUOCExZNdx/p4flGl4GOHYnurH87LGhHfhv8RaEA3syKj6aVjbEmmsYCcklY6vrEKHAPFngrVvP7sjmWV2wtJguSrv1Fo5w0+5xk6ZNxpuuUtsHgRR+qhgeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HtRxNuFm2B9nnhQv7lFwBLZB5KWKuK0/khSa7i1Ojqs=;
 b=v4omkE+u3RACdOXuZsXIHiJpOLKxfXXr4GLRRviBezztl5Xk36xs5mualhf4kStQEVRlaI/n1rRGD5bq0vBcd3k1GCXw9VL62IQW392Yzi6p8sA6yYbj/aQZeeGscj64oxdBJ9yM7+qbNqPJo/FkXxF33joCm6S+vKHHVKGKbKEh0CepnRHLooqez3V5cB+YqABDclU+yKjJk5BmY4It0JHUEIARgS4unyeUQTRvOOPV/CwytAA0HldlPpBKf0NayVLShTTignl1p4HQHVoXSvGB1WuY57N9ZU4Hg7bi0w4OiqjKIL2cIvdU3ozEqVb8XooJGAIB1f1PnG+9FDK3LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HtRxNuFm2B9nnhQv7lFwBLZB5KWKuK0/khSa7i1Ojqs=;
 b=gZGgQ6YnPBwqmVjeGCAg9cT1ksgSy0B54eFoEdv/xxD31IpBFJW39hCDhczVuGMakp08GN+DdBfUCiegHiKBL4NC2kWkTRkNR39DXdl055JHYS/sWs3tCn4TAsM8GPTlfDTlEP61Gp+/DPzWI92L0eR1TarrC49iftM0GT3bHph8H20MK6qjFnUb5bpVmcqS2OaQtIusX2SmBM0wQa7q+76spLo4aOPmNeAffWCtm3pkkjhEXrHqw0N99D4ThXI7ID57AOk3emwZyfZdMHH3MsIuJwkShkTCk/1TKjK694UHE2GgPjyR7iH647sG+SI8QwGzOlsQR4ivsDacrH7VfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB4PR10MB6118.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:38d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Fri, 9 Jan
 2026 08:35:40 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9499.003; Fri, 9 Jan 2026
 08:35:40 +0000
Message-ID: <f4486b4d-c874-4744-80b9-46af6fcd5f1b@siemens.com>
Date: Fri, 9 Jan 2026 09:35:39 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 4.4.302-cip106,
 4.19.325-cip127, 5.10.247-cip68, 6.1.159-cip50, 6.12.63-cip15
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0160.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB4PR10MB6118:EE_
X-MS-Office365-Filtering-Correlation-Id: fa38936a-37cb-44fb-5da3-08de4f5a11e8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?bnBmOSs3cUFMazNDY0xQZzVZYzlYMlpFeUFMZHdFaXMrWEF2SXl5c1pubFB6?=
 =?utf-8?B?SlJqZGZhTHJhc3dKTTJwaVZSR1pzdlU2bFRSNXl0MlhQZWZOM1JKM3d6am5w?=
 =?utf-8?B?SEloMk5mQXlzSjNDczlzQllVQjQ3Vml5Qlk5bGJpNEpNMEQ3SFVsQ01sdFVQ?=
 =?utf-8?B?QUtLZEJiV2svNGJSZFRuM082K3BydHU2WXN2cVd5eU1LYVBlUkF4OWFJTjVx?=
 =?utf-8?B?ZEZGZElFenN2QjRLYWVUamxPSU94RXJZSW10VEtFQTZjQmhqVnhDKzdBOGtr?=
 =?utf-8?B?TlNVODFkTkZPZnJuUHV3aGZtTGkvQURlc3ZKMjlKVjJmM204UkIrc0NjdXpn?=
 =?utf-8?B?aGMvcVpwUWxtUW5ndDVpdW1MbHU4TDNRQVBJUVFJc3Jia0daYnBSb0dYNFBk?=
 =?utf-8?B?RlRuMzR0VExkUmVScWZ1YUovTHNMMlBBUVp5ZGRDMEljbmwzNVp3MnltS2JC?=
 =?utf-8?B?ZVVObmNCZlpvWXlsN1VXNWwwSHFLaXZ6c3lTM2hINU5rdDQ5amhZa2dzZzNL?=
 =?utf-8?B?YnJTZXlUb1FuTFdVS3ZaVDY5UlNCYWxmVnZQQVVFYmdQb2YwOGEwd3hWYUli?=
 =?utf-8?B?SVF3bXQrMmdtbzFka2NBL2trSjVaN2dxSGZOUlVZOE93S0RsRVdLNmJ4MmVu?=
 =?utf-8?B?SmdLSzNYM3hFWjMvTUl0WE5WanRIUDdLWVJBWlBFVTBFcjVrYUV3dGM4c3BS?=
 =?utf-8?B?TWN6aEoyc1ZXdlNVZS83MFd6dlhUcnQ3NnY4ajR3MjlnNFhKWnp2ZFVuaTF1?=
 =?utf-8?B?RVpXSWpCZjVFNEczM21UT1JwWFJNVmh4N0RMK2I4azRUYzkzSno5aHE4dVhL?=
 =?utf-8?B?aXJjdWxid0tTeDRGMDA1NTdxNzJ6U0h1SVFxSkdZYzZUS0I0WXdMa09WbzNq?=
 =?utf-8?B?ZDRDYm1obXROaFBGZjFVSzBJOXY0TFUvR1NsZkhMUzR3bHcwbS94KzhoRXFU?=
 =?utf-8?B?Vnp5VHo1bnd3blNuZlRpckovUWkrMThsd0dYWW5LQUh5RFJuTkhrSDdiaXI0?=
 =?utf-8?B?S20wbWJ0NmNmQVVOdkxiRmRZZlRMM2FRWkRYL2dmWnRXZWxZMG9PT0QyMXRn?=
 =?utf-8?B?RmdmU0szTDRGUDl2WlpQalhHVDhiT0twRy9LQWQ3Y0UyZHpDMGp6SDFYOVdr?=
 =?utf-8?B?V2tUQ0ZWWGFuR2JKQUdBZzc2UlhrUzUrZjMvbVplVjBOM0tSbjJNN2dmYjdm?=
 =?utf-8?B?RVc1bWJnOVJxSEp4Rzh2cktJcE92N2RzM3dmWkpoTmgzWWlTZzcxYndhYVo2?=
 =?utf-8?B?eDVTV0ZxaHR5YlcxQ0o3Y3A2RGFwd0kzaWZLaWpqSndReWR3SU1LYkQ3bmVu?=
 =?utf-8?B?bXoyVHZvVFpqejE2N3NBY3JTK2YvaG1Ob2JrTHRGY2xVcysvcHZ2VEtHT2NR?=
 =?utf-8?B?bDQzbWR0c21zbzdmazI1SVZDdW5SNmlsa1ZETjV6RXMrSThvKzlpYklLQSty?=
 =?utf-8?B?SStyeHgxWlMzbkR1TEJKa2Ryb3d1NmFYZVUzcXRRU2lKL3NwMnlGaWp3YmRV?=
 =?utf-8?B?ZnJKVWtERmJpb2NxNXh5MlNEUkZIMFl5UGl3YlZJczR1MVdrK25jc2pVbFJ5?=
 =?utf-8?B?MmNsb1FVdGpBSUM0dW9QTGRFSWp2MHlSU0ZpSzBqUWhZRWNOWVpHaXJjdmFu?=
 =?utf-8?B?MVNEWldyMS9kWHBZMDRUdDBodEZlRDd6NnA1ZmhWWmw2ZWlPWUEyMll1OHY5?=
 =?utf-8?B?MGJ1NnpMQWo3Y1ZlcUdsbFprV0tUVjZKR3RBTG5TbVg4N04vZzBhYXcxc01B?=
 =?utf-8?B?SG1RdHBMMDlCSE94WXBubkZjM3ArUEc1MnRtTlc2Q2U4akgvcjlGV1lIbHRh?=
 =?utf-8?B?YXl6MU9HZC9HSjlLZHdSM2xkWUpSblRvcDJPQXRINjd4OU1Eb3pNUjVvNXZS?=
 =?utf-8?B?NG81b2VwQTVjMHpXVVluc2h5Z2FRSzNNOFVQZW5SZy9ZVytjTFpQdE5Fa2F5?=
 =?utf-8?Q?UEgeIiTDbgAhCk1d9BsiB4FfwB8vBVsB?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YXhZaXIycWQyU0RxTlVuQTJlUEdZVTlzRkVOdlFKNGYvNlNpeEVuVmdneUgx?=
 =?utf-8?B?ZTZqZFRFTUhPZVN5SFBxbEdBdVg1OW9yRjQxMVRscGp2a09pc0ovR2I0anhu?=
 =?utf-8?B?WnF4TEhrS0JKbmNBaFRkQWZwMUt3b2toeS9lZktvZFJnQ3RIUmlOSnBpQ0Mr?=
 =?utf-8?B?bnN5U2FaZUYwRGxxbGNLeENISzV0WmNWREJtUERGQ1YvV0dJTXJ6UWtpOUx5?=
 =?utf-8?B?emRpeTBjc3hiTjFxOHpuUXFqZlRlUCt1TGkraStsTmxtcGdxRGM0d0Zsa1A4?=
 =?utf-8?B?aHk1a3p0UlBZNFVPbVBPaWlBcEEzVk5qZTZlbFpRci9nSU5mNnlDQWUrN0Z1?=
 =?utf-8?B?R0h5N1Q3bTRHRFlwVVhIZzhlbis2RDJaaUJ0cWZtT0Jja3kzemg5amg0MFJl?=
 =?utf-8?B?L0pNZnByMzBIZmQ4NHhwTUZGbTdibENIYkhiclFPVWxaTEV0eUhtOTBZditq?=
 =?utf-8?B?eDFiOGZNU2V6NThSaUI2Z3dhSVhHbVpPcFZaZVUvUHlNRUxJa2x4SW5wemY0?=
 =?utf-8?B?elgzZXFGU0NsaFAvVTNQMUhETlBrQXFwaGtjSWlmZUFEbUxvK3BKU3dKRlUy?=
 =?utf-8?B?L2FtU2Fsb3d4bzllWlQ0bkUwVE5YRkFwMy9qQWpXeGhtc3NsSDE3b0pVYUJt?=
 =?utf-8?B?U2Z6aXZvdE9GcU85SUQ1VitrOU5LcG5Ldk5YbCtBN2QyRnJPeDIyaU9NMHk5?=
 =?utf-8?B?ci83S1NZbUNEMHVjbEhnYjlOSkNHWmtFQTdaNDRqdWFhNGtOUXViRmFkTzdl?=
 =?utf-8?B?VDRxQmJKeUsyRnd3SWRBQWREQ1kyWFF4MUtBcHl3RkxnYmZ1d2lnTHJaek5w?=
 =?utf-8?B?ZTlqSWdmL3lYZno3Qk9OZWdKSHRLS1dkUEE5ZWc4T2kwbDNHbXhoc3U2dFJq?=
 =?utf-8?B?dlVyYVdrZVZWbU11MTZkUVR6SkV3eUh4VXNnUlZYd1BHV2hvT3ZNWVZIY1lu?=
 =?utf-8?B?TXNWaFpBSzI4WkdpZ21NOUNZV01qSmJFUXE4bEo2d1pFVFVyKzBzclk4amJT?=
 =?utf-8?B?M1lYTGNNZjA5NzJydXdvNnMrSENLUjhZeGN4TEJvODlCVzQ2M1pHQjRjdGhw?=
 =?utf-8?B?UlR6MnBGRDVhNTdsVk0vNkh4Z0hwc2RzcnFjeVhnNUtBVHpCVFVZMHh0SFdW?=
 =?utf-8?B?aHhOZm9WWFQrRjc5NWpEVWZRRy80dFZUd2dEUTQrUlV0Qk9VQWsvSjcwaFBm?=
 =?utf-8?B?U0ZxYnprZjZ6YlQ4T3lOcFdSNWloaWtHeW1QeG9GWGpYWkxhVW9nUGhab2w3?=
 =?utf-8?B?dkJvOU1zM0ZWQ2ZZQjVKOWFvWEFkSlZGTFVtbEtnWUZUUDc0NDh2TE1wK09L?=
 =?utf-8?B?YU9Qc3laaTEwWUYvTzdoaVp2dVFSc1pYQ29rUDlEeFEveXNXUWxBMnVuQUk2?=
 =?utf-8?B?LzRxRjQ5dzI0NlJzU2ora1gxVE1DVjFtaVRDNWY3a2Jaa24vSWhGY1NMT1pH?=
 =?utf-8?B?dTBxSUpGTUowUzJ0cS9lMUxEVENyblk1bzl1UUVOZVhodm1oSUl1NHRPbEZj?=
 =?utf-8?B?SEpJT2FFbVhFeTB5aGpsMGZ5eXdZa3ZrSWIyN0EwTm5lUWE4UjZzSiswTi95?=
 =?utf-8?B?WVJPKzNLdkN3dTg3VkdKd0xCV0x1T2VzcXlFRXlUanIxNDFnV251VlFLOU5q?=
 =?utf-8?B?a0lmemFvK3FPcHQ3VnVtQ2NJN3RPVzJTdGJxTWpkVE1lR3M1VitLa292cWZl?=
 =?utf-8?B?M29RNzR3Tzk1czhVM0dwd2R4THNta0ZGVTdVWTRrb05EV2xmM1ZpcjhuWkRB?=
 =?utf-8?B?WE9BaGUrODFZOENFRWNnbzFBeDcwUUZ1WGxOZ2FOYWpvZWRpZUEybWFsNTdF?=
 =?utf-8?B?YkxhdjBHVjBoOEoreGtxODBTZjE0R1JCQzJKejdYTjREZ0N3V2lxWWtEcFhU?=
 =?utf-8?B?LzlqRDdBQXlkaEE4dThLVlBsbUlINXFMbnVSSllBT0Nxa0JEWmk3SE9iRERC?=
 =?utf-8?B?TXNFdWVCM0RjK0cyUUloUEk2QkVLcEcrcGRuV05sMTRFdjUrZUtPVFRiQklF?=
 =?utf-8?B?bUFiSGJKcG8rdHVZWHc3VURjRDhaaGtLS2NLLy9obTA3eHZqdFVlU0hNMXBG?=
 =?utf-8?B?Ti9QaUVLZ3BVMGlSa2tueTA2YjRZNEFjNGl4Vk1adG1ndlkzdUtoZHdoaEJH?=
 =?utf-8?B?b0xsZmR6VC9KNVd6YmJ4dEhqVmlnR0pTU04waEtzV2ovMURwbW81VWFMNyty?=
 =?utf-8?B?LzBZSzVJNzFIRlJYWHd0RVBOcjVvNFZIdXNValQxdFNLU1BTYXpsbDd3ejUv?=
 =?utf-8?B?Tmhuc0hYdy9qVzBFQnRHZlVFMzF4VytFc0pHTWZ3UWVSalYxdFBtN2NYZ3Uw?=
 =?utf-8?B?RGZUM0FsMytDNmpEVmpjVzdtdjRkU2RrdU5WR1ViWTFMOHJsdHZwQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa38936a-37cb-44fb-5da3-08de4f5a11e8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 08:35:40.3042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xolp+0s1c6FDTDglwNeOL5aXHRVdSd55STFULB7P20S1Y2ZVryeGAnUFK5J7Pu7G04K/pOO/OANeU2Ejw/divA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6118
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 Jan 2026 08:35:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21490

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-kernel/linux/linux-cip-rt_6.12.59-cip14.bb              | 1 -
 recipes-kernel/linux/linux-cip-rt_6.12.63-cip15.bb              | 1 +
 ...inux-cip_4.19.325-cip126.bb => linux-cip_4.19.325-cip127.bb} | 2 +-
 ...{linux-cip_4.4.302-cip105.bb => linux-cip_4.4.302-cip106.bb} | 2 +-
 ...{linux-cip_5.10.247-cip67.bb => linux-cip_5.10.247-cip68.bb} | 2 +-
 .../{linux-cip_6.1.159-cip49.bb => linux-cip_6.1.159-cip50.bb}  | 2 +-
 .../{linux-cip_6.12.59-cip14.bb => linux-cip_6.12.63-cip15.bb}  | 2 +-
 7 files changed, 6 insertions(+), 6 deletions(-)
 delete mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.59-cip14.bb
 create mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.63-cip15.bb
 rename recipes-kernel/linux/{linux-cip_4.19.325-cip126.bb => linux-cip_4.19.325-cip127.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_4.4.302-cip105.bb => linux-cip_4.4.302-cip106.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_5.10.247-cip67.bb => linux-cip_5.10.247-cip68.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_6.1.159-cip49.bb => linux-cip_6.1.159-cip50.bb} (59%)
 rename recipes-kernel/linux/{linux-cip_6.12.59-cip14.bb => linux-cip_6.12.63-cip15.bb} (59%)

diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.59-cip14.bb b/recipes-kernel/linux/linux-cip-rt_6.12.59-cip14.bb
deleted file mode 120000
index 9294da0e..00000000
--- a/recipes-kernel/linux/linux-cip-rt_6.12.59-cip14.bb
+++ /dev/null
@@ -1 +0,0 @@
-linux-cip_6.12.59-cip14.bb
\ No newline at end of file
diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.63-cip15.bb b/recipes-kernel/linux/linux-cip-rt_6.12.63-cip15.bb
new file mode 120000
index 00000000..bdffe30d
--- /dev/null
+++ b/recipes-kernel/linux/linux-cip-rt_6.12.63-cip15.bb
@@ -0,0 +1 @@
+linux-cip_6.12.63-cip15.bb
\ No newline at end of file
diff --git a/recipes-kernel/linux/linux-cip_4.19.325-cip126.bb b/recipes-kernel/linux/linux-cip_4.19.325-cip127.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_4.19.325-cip126.bb
rename to recipes-kernel/linux/linux-cip_4.19.325-cip127.bb
index 6f5e5bd1..9913a122 100644
--- a/recipes-kernel/linux/linux-cip_4.19.325-cip126.bb
+++ b/recipes-kernel/linux/linux-cip_4.19.325-cip127.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "88d02001518e19e4d52fc12ce00fec6db191bbe54f576bba9f6be3bc7fe816b2"
+SRC_URI[sha256sum] = "e1729063636977feb5d570009b4affab04206ad7d8a111a9a7f574e71d6d611a"
diff --git a/recipes-kernel/linux/linux-cip_4.4.302-cip105.bb b/recipes-kernel/linux/linux-cip_4.4.302-cip106.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_4.4.302-cip105.bb
rename to recipes-kernel/linux/linux-cip_4.4.302-cip106.bb
index 807b0a92..b543d1bb 100644
--- a/recipes-kernel/linux/linux-cip_4.4.302-cip105.bb
+++ b/recipes-kernel/linux/linux-cip_4.4.302-cip106.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "ca3e4c6dbcfca09eff9d2c3c8b3c5c5d76f3a36951551f1717976337bbe46199"
+SRC_URI[sha256sum] = "4d41ccaf4ed1fc0f599289d83a4687c26aebff2a107c8d3e061fe21308e12792"
diff --git a/recipes-kernel/linux/linux-cip_5.10.247-cip67.bb b/recipes-kernel/linux/linux-cip_5.10.247-cip68.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_5.10.247-cip67.bb
rename to recipes-kernel/linux/linux-cip_5.10.247-cip68.bb
index 872af231..be45795f 100644
--- a/recipes-kernel/linux/linux-cip_5.10.247-cip67.bb
+++ b/recipes-kernel/linux/linux-cip_5.10.247-cip68.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "04e1a12d68bbc64079d6c3aabc833844e91932cdfb1a91154c24711469c63a60"
+SRC_URI[sha256sum] = "68942a5e17039b54731c763e274cef62c0807c1e3b2c1276a1f4d63e7769bbaf"
diff --git a/recipes-kernel/linux/linux-cip_6.1.159-cip49.bb b/recipes-kernel/linux/linux-cip_6.1.159-cip50.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip_6.1.159-cip49.bb
rename to recipes-kernel/linux/linux-cip_6.1.159-cip50.bb
index 1b0b0f75..182b34ce 100644
--- a/recipes-kernel/linux/linux-cip_6.1.159-cip49.bb
+++ b/recipes-kernel/linux/linux-cip_6.1.159-cip50.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "7e968abceb8c949d2b7e8cf3885293dc18f367da5d95d466105851fbbc77a41e"
+SRC_URI[sha256sum] = "528d3ce9aa06dffa3359e26c73492a2f2ce7fd7026e5b82f33f355a8263e544b"
diff --git a/recipes-kernel/linux/linux-cip_6.12.59-cip14.bb b/recipes-kernel/linux/linux-cip_6.12.63-cip15.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip_6.12.59-cip14.bb
rename to recipes-kernel/linux/linux-cip_6.12.63-cip15.bb
index d27b1114..2d206e8c 100644
--- a/recipes-kernel/linux/linux-cip_6.12.59-cip14.bb
+++ b/recipes-kernel/linux/linux-cip_6.12.63-cip15.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "ca060dcabf8588adcb702b58777c1a3d68f1eccaf899d39a54a7e6ed8288fcc7"
+SRC_URI[sha256sum] = "97989d99f2baab30964df667aca6c98867be24aeaf34130508b443fe4580ebf0"
-- 
2.51.0


Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCFAAC3ABA9
	for <webhook@archiver.kernel.org>; Thu,  1 May 2025 07:55:30 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.68])
 by mx.groups.io with SMTP id smtpd.web11.6859.1746086124669567756
 for <cip-dev@lists.cip-project.org>;
 Thu, 01 May 2025 00:55:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=cZ+mZkNl;
 spf=pass (domain: siemens.com, ip: 40.107.247.68, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YWKlavgKjn/FKH5e4C6h9zsb6mSfvhV7Zl833yWyEvhYFmQARt+6G8KK+jhs8ytRjJcc2LaM2YMhm9VN35Q7SUuHKFTPD+hzIsb7ec8Ertee8zTaXBwuU7CgkiJIWjxojX8KbSHNqXP1KBP2oTIgUZWl99oj/aswJ0n0ZHlCbE+LIm5xVffX1uC4dSQjVaQNTjGU7hmiawqQ0FQQe2E0GeQmU/cppqU7dzauiRG40eA4oVFz4OgCGP0TSOWC5+QTPlufeGbB/THMmAc4hJFeHUE94qJH/EQxIhXJOGA4/2FE53hx52i/rPxPqqnH5+fXK3xg2CRlrY4L02R4oZ/UNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5suvwdpHALf18HM5ak+YOtfBXNGNms/KflyWiAqgXv8=;
 b=SZtwJ2FNbEFnKbtiJCBYTG73ssKsge4uDgMCfODjd2uqFHbz13iJQyUZ5dDuVPOZMmx3KG7keD9IONSlNBFQnOovWUoftYi+kAC3Zt7W4s8YAXoD9zeQqmb4oCzUORsZGlH2dztuYIblunuAHTCyqWjG7G0TwDdzTt5tcCY+Nhz9ag+f6MQGlX9eIqGlaYEsKu1z85LA0N9tgdg1xHHrGrmDg+EUTbyYYu898yfnfWPmk5Tg4ZGhHee3LlQIwZXJ42pbrAo+hkevL5hqN0anaHbKADReL24XJBuGYHAiOcuY23XR8rhLs8o1Lfy1rS5NKR/ZCNqVG4TIwGvOh8czYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5suvwdpHALf18HM5ak+YOtfBXNGNms/KflyWiAqgXv8=;
 b=cZ+mZkNlIARe4Q6bshCHBqRiH63tSSDKeA10DxUPpsJkbE62KYXaSamVhR0GYqcbgA9k04B//6o4XSxqNVKZ9fV4y3OOzD0qjzjMxBLW65JmnXSdcqQXABjg5xCZer6Jaeo52sjmMMRGfX41I/8/zFqWmtwBIGWbV6rUzp0usHs3HzKXfEym2giJZ49vTPtqlkpwJdtB3FRa6HFRB4dSTFgAL+1vcSuXABJbroZp7e9Gpp3Mun0Z6uSLAG3AQlk7LlOZIuGPWg9l1nGu+zoMVJuBdNqiFjPn1i1JTWHMdxVFs5SjzWsQgm5oC+sVpbiPwZmD2frMCPK06nNWvHfNPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU4PR10MB8889.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:56c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Thu, 1 May
 2025 07:55:21 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8678.028; Thu, 1 May 2025
 07:55:20 +0000
Message-ID: <4f8d4955-454c-4999-b450-541613cc0452@siemens.com>
Date: Thu, 1 May 2025 09:55:19 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: skip CIP IRC weekly meeting today
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0134.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU4PR10MB8889:EE_
X-MS-Office365-Filtering-Correlation-Id: b2019377-e6c3-41ea-66fb-08dd88858565
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RFU0NkkzYjNmTXV5TmJNSkt6V0VBUS9hVnJLOUJ5b3l5MFRUdFkrV0srbC84?=
 =?utf-8?B?VXpqS0l4VngzSlVlUG9YWldTVWo5OWJ2MURkSGNSYzJqTFVyckZ5M2JmU0FW?=
 =?utf-8?B?bzFrMTJKZEhoVTlOMkNBSHlsYXBWWVRWdGJkczVhTVlKek8wUWhZQncyRGNS?=
 =?utf-8?B?SHBvbGVWSEZkMCtVZEg0cUxyL3lRZVgzcnkxOGduWVFiVWxULzFwbmVoY3J5?=
 =?utf-8?B?THlYdEV1dE9hWjJIYno1dmVXY3hFTnlwU1BSYURCOWVjWTVGZHJ4T0xPRUVO?=
 =?utf-8?B?U1NWR0lYMHZUTnpsNTMzU0R4aFdoUVpWT2pLZndFTmE5d3JFK2Vqb3d2SVQw?=
 =?utf-8?B?OTA5UTRUVXVIZlpXMWdncU5NUUcyaWVTUXZBbytrSFVXNWhKNnlPRlM3UThY?=
 =?utf-8?B?d0ttU1JEaW16MkxxbGlCUEhzc041a2pJNGNvOGdYTEpQcnVjNDNNdVZHSE9j?=
 =?utf-8?B?KzBuTDZFNVBWQXcrNUEya0phTmRJSnpaclpnU2xsbGkwd21CRmhKenZGaFRt?=
 =?utf-8?B?ampDS0g5V2pqTWIyOTQvRjRhSVFPanhJcVRaODhLTGpWTnhjVC83YlBYMUx2?=
 =?utf-8?B?aVNyakIwaVMzWHoveEFCNHhrdzZ5ckhuK21RRWdnckZLRXZ2bFNYSmNlekw4?=
 =?utf-8?B?bHlvbzkxb29jODhvYWtNU1Q2VDRxajlaamtuZmhDRklpR3g2MG95S05JdC9r?=
 =?utf-8?B?TlZQWHhqKzdqVXFuQjhSR2pRTlVlcFEzcWtNMjFCbVpKT1ZNVE8xVVAvUXhY?=
 =?utf-8?B?Q3p0dTBiOGhQQmo2Uk9tajdlSHBUM0lUYUpJNllucDZpdlQ0ZmtrK0ZrWG1N?=
 =?utf-8?B?Rk9HZXFkVldZYVdIaDB5WkxkT2orUS8ydkZ0YUEzdTI4VWU2Y3hvR0lCZnov?=
 =?utf-8?B?NXFZalcwS0tISS9adzFxU3JRZnF6bE5hKzUrTkFRVGRDRHJBYjB1V21La1JK?=
 =?utf-8?B?Sm1oU0dCbExjVHgxR3JSK2xuZjNPaDVWVVZFbU0vZmtqRkZUdUMzNjlTUFFk?=
 =?utf-8?B?Zk8zNVRnVmhQenZoOVgzcnBmK1Fjd3E5NUJBbm9veGNKVWxmNjRMdnQrQlJV?=
 =?utf-8?B?R1VSQ09yNmtrcndJTGR4Rjc4RjMvZkdjaVFVbUp3bW5UR1B1bXRvUTdmMmZF?=
 =?utf-8?B?M1E0eHYwN0RJWW5uUUNCcmJRb1V4WGhrSjJsNUNML1pjMDlvdFdKL210OFox?=
 =?utf-8?B?cGYrUDVFK0NrMXFCaTRDRVp1YUkvOGdxWEUrL1pqblR2YjFQWXNFeGhGeEhw?=
 =?utf-8?B?OEg3bGNtNEltWU1KMHZGbG01bkUwTDMya0o3Vy9OZVV5ek0vcDJ2UFdXOUFi?=
 =?utf-8?B?azJqYW96TEZxSWZQUGtGQW50QzR4ZzdpSk9xc0wxcDNuVkRVMXR6emRKZVNQ?=
 =?utf-8?B?dGNhZUkwTUswRlRvRUgrN05aQTZEVWZtWmFaSTJnelFXU3FuTThVZnlzSWU2?=
 =?utf-8?B?ZG1MaGhycDlaOEJYZXdtUm5OMjd0UUFmT3FYT2NXSm1tZ3NrdThDSzN1Y0Rp?=
 =?utf-8?B?TllUV3NQQWsyVmoxazdTOTgySTZVMDU4S1o0QXFtRjR5YVg1S3RqZldNL3Vq?=
 =?utf-8?B?am13VGlMK0VVSGNJWjNGSzc5MHlMTU8vQ3RsclY5TDlWRk55TUEwellRa2Nk?=
 =?utf-8?B?ZzZ0NjkxdDJWRHdlM0lqT1lXVFgxZUZNZkN6YnF0ZVJ5bU4xMnNobm9QcFhE?=
 =?utf-8?B?NzZIbVAvUWt1SCs3Q3FFc0FOL09IQ1pWTTRUTW4reXR2TkJLVnRLRllFUVVZ?=
 =?utf-8?B?bWJkNVVKL0dvUytlV0ZzNzVhclJTN2VzZ3FwL0FTWU9rSmVCWXdTTXZzUEk2?=
 =?utf-8?B?VXkxWWxEcWc3SkVUbEdNRkpTbUg2VGdFOVM1Z0YxUnFBcHRaemQ5bWNkUmlp?=
 =?utf-8?B?Mm1oU3k3cXpJREtGbFU5SEZXRXhpd3V1RHp3N043aTRnVEptTFVOWnJMOGQ1?=
 =?utf-8?Q?8v87h6xEcJc=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cVZqTERZeUdjSzE1cGhGVVRMYTkxZ1VOKzVFK2xwcjZld2FNOVI5SGJLZE1S?=
 =?utf-8?B?Y1VVU0ltZGdEV0hGVEJRekJidzJhMWJRcXNTUmpJczBJQmQyMi84aFVWYVNF?=
 =?utf-8?B?S2xVdlNJNHYwSyszSGM3QWY1YXpBaVdHaU5YTCtUdnQ0VGZXbklVMHcvdzNV?=
 =?utf-8?B?VU9ndG5aclF6dXF3STI5RjhsVnNuQm5kbjUyZnhEVWdCdXFnSk0wMmk0Q3Rj?=
 =?utf-8?B?aG5XY0lJS1ZJZmJCa1h3MVFrMGVJeUV1eDU4RldXWkhvK0N5NDJSNlIvQlRZ?=
 =?utf-8?B?RlFPTHFUVGFOSnNWUjBZS29YUmxDR2N4SEtxQmVQMTh1elJrd0t4ckdPOThU?=
 =?utf-8?B?Mll6RWRUUG1jOVMrRjVESkFsTmR1Mm5SU1IxTmpMT3pvSjJwU09SbFVtT3BU?=
 =?utf-8?B?eVl6eTBNNHNjaGc1eDA2Y0FBNVE1TlFpZmhXTzJvYU53RlB3RkcyK3RHWmJm?=
 =?utf-8?B?RG52azVZSGtRa3Vpbnc1ODVLOHRVcVdDcmVzL3NZYWxCY29YYmtvTDRlcWF1?=
 =?utf-8?B?QTRUWWtJMUQwV2JCdk1ZY1RvalBuNHl6d3J2elFtd1Z0TGxoeTA0NWNZZG13?=
 =?utf-8?B?TVJ5YmQwWFNCUXZIWGNKL29URG9VUlZ1dFhxSTNlQzkrNmwvMko5bS9tZlNX?=
 =?utf-8?B?NjJHbUw2dmw1aHpTang2aVpjUTJncU54ZVlLWlovcUZPZ01sTEJwa3AvMHlx?=
 =?utf-8?B?bHBaU0tOVytuK2JhcGkxTXZURGNVQm9abVMrK2dqNWZmMnV2cXp0VENWMzJL?=
 =?utf-8?B?TmROMzl4amxCNERNTjQvQlp0SUhXbzhrUEdZbnNocUdweHlpbXdBMGhJaEZ3?=
 =?utf-8?B?UXVyeDlDTlIybXBodGJoVEZjTnBEVXJIblA2akVZWmxPTjRZeXhoQUZYYkV4?=
 =?utf-8?B?TnVBQlJMMjFxSmUrcEFERStQRmVQdUlCclFHcldYSjFVWlR5VjFvei9RMXVH?=
 =?utf-8?B?M1QxVCszVm9GV2xKd0dzdXJva09DcHdKZzRkdkhwVGhpaUtSSlBEM3dqN0NT?=
 =?utf-8?B?RjZObnlhQi90cXcxd3AyTlNYK0htc0dpTnFtd3QrZWNMQUdscTM1Wk9TVkZi?=
 =?utf-8?B?R0cvQmZaWTFPTEtDWXVsZTl4bmR4d1NBeFlZQzdGNm0zQmZYaU1vbFpTRVJE?=
 =?utf-8?B?cC9tRWFyZG5EcHRWb1VGK2VVWkw1ekUyNVF1K3ovU1Q0cVJpMTArSnI0T3ZD?=
 =?utf-8?B?QUtJZE1ZMFUwNWgwSUdYWWZ2R1JIUHN2MmkwT0JaWUh6RDlPQWZSZE9CaWIr?=
 =?utf-8?B?bEFyMlhOSzYzYWpUQUtrTnF0RzAzTkxGTFVMTWlKcWxyKzJFQUlKaTVUdlla?=
 =?utf-8?B?S3pUWlpBR0dzaytaUkM4Z2hnLy95d1BUT0pZVmQ5UmVIT3g1OXpGdWNmVmsx?=
 =?utf-8?B?c21mbEk1emkrZE9iSGdWZ0pOREtDdDU3OEszL1JnYlBXWEtVMHZ3R25ZbGpS?=
 =?utf-8?B?WndybGxUenFkd2RscFlyL09VclBZM3htQXV4YTNtQmVjbG1hNWZtS3o5N1ZE?=
 =?utf-8?B?SXdGeGhVa1U3VDdGc0JuS0I4MEluY3ZBaUFURHQ1VkRYdk1pcXhKbWpIaHUr?=
 =?utf-8?B?NzdSRkZBTFo1em9uckc5RytkU1BPNng1WlJ3KzRFMkp3MVlLSnZUeGFRM3hK?=
 =?utf-8?B?bk02MlhsblB3bVc1bVdOYjM4aHNzMG1EMGZZUEVxeDh1dWRqS2RGVk0yTExH?=
 =?utf-8?B?MUpEdlJqUFRuNUtqR0pHOHU2b3ZjRWJ6Wk1qT2hGQ1NFRitRckY4bnR1TTlE?=
 =?utf-8?B?M2JIcy85V2FESEVrMStla2JDaGJDWklYYUtOckluYzZJb0FyNDY1bUxtb2N1?=
 =?utf-8?B?ZmI2STlOb3c4NXM1YWduUjljN01hbXF2MlBWVDJtUHNrTzZkd3JpcmhKdkY1?=
 =?utf-8?B?cTFZT2psZGpSeVF4b2xMWCtIcFFSTkpDSjYyT1NEQXFQdFFRcGw4Ulo4dVA5?=
 =?utf-8?B?TGpUTXdTNEczQXMrMWpEaUJKUHNUcEtXa3RURmhhQk9jblExaWQ5OW1GR2lI?=
 =?utf-8?B?N213MjYzWURiMVYyNHhUcjNmQnRzc0lpYkw0REp6aE1wOUNVazlpWXFpVnpw?=
 =?utf-8?B?dU9XejNpdHJrMVJtVHhtTzBLS0dlSTNLNHV4ZllncTNldDQ4ZTEybnV2OHdY?=
 =?utf-8?Q?09mu47MOnJKqNAxE9bekBxfEj?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2019377-e6c3-41ea-66fb-08dd88858565
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 07:55:20.8306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KTmzYqAM48YhaUmrQRodmL5UPolsWE6xiA4k6C7eK4SC4AxhqTxhJ6iWZa+kgGCgYiuG3T+9vorxce4SOX8EnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8889
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 May 2025 07:55:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18744

Hi all,

given that it is public holiday for many of us, let's skip today's
meeting. Drop a note if there is something urgent to discuss nevertheless.

Jan


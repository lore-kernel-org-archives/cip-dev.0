Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4CFDC61CE7
	for <webhook@archiver.kernel.org>; Wed, 11 Jun 2025 10:55:07 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.38])
 by mx.groups.io with SMTP id smtpd.web10.4837.1749639303925729681
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Jun 2025 03:55:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=zJ4mHiG2;
 spf=pass (domain: siemens.com, ip: 52.101.84.38, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=azdflxliLI7l6OpwTvulzcorE+0+0xzLuUeZXERT8DcOJ4Y8sm2+8bXWiIvC43o5smKpo/U/e5FKZMBnS0uLb5OTEh86DV98BiPYqkmNtdDilmplrNHOWLvqfjrt4IxWMlu/L8EzBlx/AzIeykhRYuFgTdk9MV3wCxofTCmrFxLuRUGwFRFX3wpPzCJVai4pvrnO0EBcqkNoMpMW8qnZtgCN0gIqAD2mVX+RGjJIcwqJ0k7kgadHp/XGp/V7kkxOLVHKF1YHT4XZkbNLso2234jRd+mprhp0FJoscM4wCUVHHPTZ7/HK+5v4kEH7BcypODoSBI+3qPqmVK2BCKEsdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p58KnqgHqBfHGOQU9OiAhf69E2n4a+c89lUVLrnN+rs=;
 b=mpe0JguURUjEGtJhjXTzVrFSP+SdHJ5Rptj98+/mZaoQHcz6Y3sIWqNy8V0tvRl2ZeQAso0//kG3w6k/JZJpWmIqbLFG4VGeSEjQtUUEU1X1ClJsQ8NZUXlxGWBrPRTd2utdE1nzV/GdwiVuVEQ8hJLRQ9vocKa/c8KhYwYdC1iCtwPpU9h2CkyPr/GSiwFw+sTY3gLKk7MkOu5W4Cf/Qgsy0aJM1ZP+rD6gFho7pafOOUNOSjMPSLzhcT51kW80AmlkwxrQegg0U+bc8UgRkWsldUFm544/YjDNkt61x4HlEMZc5e7lURQI7tANOXDJuU+cL3SlQtFZjg4HuzezBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p58KnqgHqBfHGOQU9OiAhf69E2n4a+c89lUVLrnN+rs=;
 b=zJ4mHiG22qr5MFryiZ6vLDVrXKCVKzad1vZ+upiUfDgyhTqJq9hC+VNUBdPC/MftynrrbI3e98SCUGrs5n5IXlPAJR3GCofzxS+gLMWgAEISvAZa/E5OwOzxrRcJX9a9PA7IzOgvW5kXUduv3i+CShD5ytw3s9JS2MGNX/Owm+RMU/KFLfzP/w1n8w3YNxPK0M1KwUjn0eLzxE3uJXmfC2+VVgWom2mR7GeMJgabCO6LuuW2g/YQ+N57TWh8V4U81kAu2D5Hk8S/prqKTYpwsErx5Jl76u2cJbomVskAkHpD0bZ+Hfhlq32yjw4LPdB46QX7ZZt+NlmQ200uGyiIBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB6111.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:583::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.26; Wed, 11 Jun
 2025 10:54:59 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8813.024; Wed, 11 Jun 2025
 10:54:59 +0000
Message-ID: <d6c596d4-4fa0-4148-b3cd-b49d9128ec38@siemens.com>
Date: Wed, 11 Jun 2025 12:54:58 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 4.19.325-cip121 and
 6.12.32-cip2
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0117.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB6111:EE_
X-MS-Office365-Filtering-Correlation-Id: f20c1e65-ec38-470f-ad6c-08dda8d66901
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ZjhvblVWMEJWZGFvZ1JMeE94Z2oyVjZrNWNnaG15eTBTanZCclhTWnZrOWt3?=
 =?utf-8?B?eUZUTmlCS0FkaWdtLzFsOXplRVcxWHB3NlhEZms3elNuMkhqSjhhQzBPemNR?=
 =?utf-8?B?a0VOLzlSenpBWXNqWXBwVDBxQURLQkVFSnlSK2xYZEtnNXFJZnVKYVJlQTJG?=
 =?utf-8?B?dEtDQjZIaFFvbXVpamJDL1hETDdnMGlJaFMvcVRCaDJuSHZ3RlJyTHhuU2p1?=
 =?utf-8?B?MDNjZ0tZYTRqWnNBUWtvT0IxWVgyL0lUUFlMd1IzMERtR2orbkVXODJiQU5E?=
 =?utf-8?B?NFJ3bWY3alBMQzNkemJsaEhPU0xOSEVKY0ViSEZRSWRHMTByU1NxTlFoQmI0?=
 =?utf-8?B?bzJZbHFSQnh2MCt6MVlvWmthUy9tcDAwaVd3TEUrNERTZ1F5UWs4dFR0bUhp?=
 =?utf-8?B?TkdFZ3BLMXFxVW81THdQdG94dFZiU1BPbnBSNUVwa3J2Z0M0WUFqaUdMOHcz?=
 =?utf-8?B?ZVdWaW45WnNFZlFwMTluczhyMDZqcTRJTSszNGNpbSs5SFBxNHFlYkNCS2Y4?=
 =?utf-8?B?dFhvVmFqbkcvM05zUTRjMkNDcGRNR3p2V25YRGF6TVYwR21NYWttUEx5bFdI?=
 =?utf-8?B?T2MvMHh0VytxSDRTbStQZCtDV2xhVkR2WEoyZiszTVZBOE5ybWMzQlNmQzJY?=
 =?utf-8?B?N2hGUGhxS2N6Z3RVbWVZNXdESFVnZHpENUQzb2NOeUpaQmlJNG56Y1RiNGg5?=
 =?utf-8?B?aWgvWXY1S09ETUZzb2duNkhDMmpEUmVKTkVMODBHc3ROcVNsN2pxRlduaGky?=
 =?utf-8?B?b1RNU2lmamI1QW9tZXcyRGhCMWxGbGRSWUppQkV3K04yeXhoREh5OGswL2JU?=
 =?utf-8?B?ZHgycmxhcVhySWZ4czNMalpYK3ZvaFptTHgxTlB6ODRLN2VTUVgvSk8rNkl5?=
 =?utf-8?B?Sm9ZYlgzU1ZLbEYvekVSd1diWk5aTERzSUNmai8rQ2Nob2N3RW9PN25WZ1Fz?=
 =?utf-8?B?aitjaHl6OUtvbU1wTldYRDZYL3ZieGVyK3FSLzdvUkpKRldXalBOOEo4SEZD?=
 =?utf-8?B?dFJnemtibjZjNFV6UW9vaCt1aWVPMG5pRXJyYm1Ma1hNSTBTMC95aDJzS21K?=
 =?utf-8?B?M0Mrb1E2ZFh3SVdjOVNyRTE1R1U0bEx0KzZDa0tacktpWnpndjMzZ1kzYzdZ?=
 =?utf-8?B?VVRrZ0hrRk03VW5XNFRQQzlXM0dFWUhOWlExbDh3Sm5CK0RzZFdZU0NOOFpS?=
 =?utf-8?B?VldmZHRkYU95QS9KcERuSHIrR00rL0QwYUIzejcrbnFwc29najlEWnJNekdH?=
 =?utf-8?B?SXJSL1IyTmNPdk9YOFJjZUNSdE9oM2JLTzZDeVBFcTdhelBnWWE3RHlmUHdY?=
 =?utf-8?B?Q053S3E3V2p0QjhscE9ROXFZdTRzVGk5ZXlvcitNT2RuN0JqVmZqWk4xeitI?=
 =?utf-8?B?YUwwZnp1MjJEbjU0cURpa3ZYNUFYeHkxR2lOZldidTZPNEhOak82T3dSOWZi?=
 =?utf-8?B?SDdzZzFFUkl4WkZQM1JmTGJmaGxEWlVKN3Q4VTRVZ2Y3TkxkQXhvVXB5N3ZQ?=
 =?utf-8?B?OUVOTm4wcjRnbzVtN1VTOWR5ci93OXZhUHpyTTJmQ3ZPdzgrYzZOdVRzWkRM?=
 =?utf-8?B?byt5VHVXekNTcjV2S2lNVVVGWEYwSUNkWUMxV1FURTR3V0hMeXhUZnBjQ2pZ?=
 =?utf-8?B?RTc4SzVYb2RFbVVkZEl1YUcwZkVNV1g2dko5MFIyS0w5Z2JGK1Y1ek9ySlY0?=
 =?utf-8?B?Sy9EMWphSWxzdXpiZFUrVWNXY0FzY3pISkZ5aGVBRjEvc1lBaHNPUXFHdFR3?=
 =?utf-8?B?dlQwZm5PUThxdmwyYmtlY2dwUG1jWVVBMGhRMXhNbGxQOXNabDRZeDg1RHl6?=
 =?utf-8?B?anFOaEMzRVNBVnRJYVNjTjdyYmwwMHlCdlJGNTVzK2s3M2hnQnZ6M0VnTk5i?=
 =?utf-8?B?SmovbVF2Y0FSY3RMNkE3ZEFISnVGY0ZycUNaZmRhQkM3S214SFcvY1Q1bWRB?=
 =?utf-8?Q?VUb1E9UNWBY=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WEdVcWpxTTlEVDd6WGdoZ3gyU0NwLzZKQUhqazZ3K0UyanlneUJWUzlIcnQ0?=
 =?utf-8?B?bWpZRzd5YTcvRks1blNsTHNrZXJselRIb1MrYTdEaUZIL285WnRuVDZLRS8w?=
 =?utf-8?B?dVVDTFdwYUZJMHRLK1ZFZkNJemJlTVkzY0RlOG11bmNqY1U4S0lsR3E0bUtq?=
 =?utf-8?B?dk51NzJza09MdVdaS3Z0VXBGN284MzRPMG1icHB4c0M5OXIvdVJYdzVMOE0z?=
 =?utf-8?B?UFVLUk5qNG5FM2VXZDFmS0daU2ZGdWlUUERQaVFTdldsZ0FpWDZ4SzlQNEJ6?=
 =?utf-8?B?d21Ib0VlRUc5dGQ5YkVKaGN6bHc3OWdvTTlMR2VLWFM5NkJEL1liYjdackZC?=
 =?utf-8?B?VjJMRHpUL1lGdnRiYkJwa2hHYVErTENBSGJranYyR3N5R0dsNDYzbmVGSXR3?=
 =?utf-8?B?Y1NSVTlCVldubktJMVcxNUVUMUIyVVJ5WmxlTytDYXV6V0J0clp2WVlFYkwr?=
 =?utf-8?B?ZkY4VDduNlZmemVYZTJoeG9LUjhRbG1EbE1PUUtVeU5PR2JrNlUyejd1cGZm?=
 =?utf-8?B?WS90MVJneWFEZFRITDV3bjFCM3pIWis5aFgrM0YvczRDN3R2VUNzUXJSYUZD?=
 =?utf-8?B?WnZya3RaSjhmaktPa2VIYVNZcE83V3FzUHJMSmJXOHBBd25mYjdkMm9JN2xL?=
 =?utf-8?B?MFNuVmdEY3JjUUoxVXN4YitxYzI4TWZBTUVqYkdoSDE0ajgyNXVHZllTSkUx?=
 =?utf-8?B?MlpBb3VVd21lRTAxSDRkcHBZdENlOFBMNHdMNE9xakMyd2cya3RDVVVxblBz?=
 =?utf-8?B?RTNhallnQzNuWTNoUzEvdENMU0hjUVJJaWtmclhWdmwybjVvdnhSZHJKMHg4?=
 =?utf-8?B?bUZoeEF3Q3VMWjlNVjcyZlJaL3NsSzVXUEdTb1FxTnprTW44ejJxUHBDb0dG?=
 =?utf-8?B?aFBTNjd1Uk5RUURGTzdkaHFlQWRFL2JpcGg0QnN3c2hiWGgxVlI1czMvaXIr?=
 =?utf-8?B?SlpITUxpZVhLaFhwaFhhZ1RRWnpqWTBkazBKR1JYVHBVUnk2KzhsaW10d3FU?=
 =?utf-8?B?U2gyeTN0Sk1SdGd1L3g0TFZjT0hRaVVEVzZGbmxXNkU4cG02NGQzSGxzZ0Vx?=
 =?utf-8?B?VkE1M2xVSFhETG16TFRMa0l0bi9XRWF6THNsZDFRSTlxSWhMejFucjZqSjYz?=
 =?utf-8?B?T0V2L0hqbUhQNHRiNDI4S1dBZ1RTY2RzQUZnQUxOU1lkdU9sQjVWTVRHR0xr?=
 =?utf-8?B?aGtqWHMxcW9hOHBNcTlia3BBalltMy9sR3E4SEp6eG83R0F6TUFyMytHMHNP?=
 =?utf-8?B?cSs2bUNxUUlCdnN3K0pDOEk2a2ZqWC9CSk9naHNYdFgzUWpVU2NjSGhLaG9u?=
 =?utf-8?B?U0FTdFFxVGRzNVpSOGZsR1pHZ0c2Z3dwdkdEbEZ1YVVMbTlJT2VtWW0xTG12?=
 =?utf-8?B?QS9tV1J3VXN2MEFGQ1laWmpGbFE0WEkySkEvV3lFYXdCN3JsQU5OeXJXaGZJ?=
 =?utf-8?B?N3lNamlOZjNDUWFnNEpqVkNGMXYxQyt6S21jWElLTXJlemdZcjM3NCtNMVpH?=
 =?utf-8?B?OWZXTmhVQlZyN0pKdWhXOC9HeXB6Z09zZjlqdERidlUzM1pNUFhaWE44QlN0?=
 =?utf-8?B?YXNBVTgwR09PNEh6MzFWZXFuamdLZS9OcUFzZ2hybFV6anR5SWRjdkN2VEpT?=
 =?utf-8?B?a3dxQU9ZR3JyRlV4cWc0eGQxQXVQWVlQQ0tMQzJTRnF6R3MzZmk0VzdKMFlG?=
 =?utf-8?B?dUpkU09NNEdtNHppM1NFSGJDTUtiL1h1Q25tTzBaTDA2YXoxTlF2NFBUcnVU?=
 =?utf-8?B?VUt2Rm9LaHU1UzU1MlJUZ0V5NWlJdFYwaGg4UWs3MXc5cldOQ2xKaWNqKzht?=
 =?utf-8?B?cGE3S2hWRDBUUzRIVU9rUmhyNkN2VG1qQXNZYVhnMXgrT0tjbXVmNW8zLzhU?=
 =?utf-8?B?b1VFdWplOHE0Rjd3V1M5OWxMbGE0NjRRK3pSdnpCOGFURmhEZG9tU2hOK3dR?=
 =?utf-8?B?NFFJcllCNVY5VTJwNHNVYjVuT1VNT0Q0UEVIWjUzSG1aL0ZURVlwdUxyZktI?=
 =?utf-8?B?Wng0dEcxWjRMYkhpWUtGTXo0OUsrN1l5Z2JoUDc5VVY2bFFVQmpheVY4TFNU?=
 =?utf-8?B?NFdXQ2pLYUplMWNXWUVOSUN2VXNLeFp3ZFhGNlhMNDN0SGFKbjk0VDNzVmpa?=
 =?utf-8?B?UG9ndjg0Z3pMajVQbXRMMTNwdlBUTTlqRTVNc2JkMjFoUUg2K3M5MjZuK2x2?=
 =?utf-8?B?ZEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f20c1e65-ec38-470f-ad6c-08dda8d66901
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 10:54:59.6331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s74H5+eHkZoj7xJa8k1uoHuxGEtqLfF4ElgW9AbxvMcfJ73mi+3Pm+JiIP9m6R8qu/yDpIR4PxEFiyuMktbAOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6111
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Jun 2025 10:55:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19026

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-kernel/linux/linux-cip-rt_6.12.29-cip1.bb               | 1 -
 recipes-kernel/linux/linux-cip-rt_6.12.32-cip2.bb               | 1 +
 ...inux-cip_4.19.325-cip120.bb => linux-cip_4.19.325-cip121.bb} | 2 +-
 .../{linux-cip_6.12.29-cip1.bb => linux-cip_6.12.32-cip2.bb}    | 2 +-
 4 files changed, 3 insertions(+), 3 deletions(-)
 delete mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.29-cip1.bb
 create mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.32-cip2.bb
 rename recipes-kernel/linux/{linux-cip_4.19.325-cip120.bb => linux-cip_4.19.325-cip121.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_6.12.29-cip1.bb => linux-cip_6.12.32-cip2.bb} (59%)

diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.29-cip1.bb b/recipes-kernel/linux/linux-cip-rt_6.12.29-cip1.bb
deleted file mode 120000
index 4986a547..00000000
--- a/recipes-kernel/linux/linux-cip-rt_6.12.29-cip1.bb
+++ /dev/null
@@ -1 +0,0 @@
-linux-cip_6.12.29-cip1.bb
\ No newline at end of file
diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.32-cip2.bb b/recipes-kernel/linux/linux-cip-rt_6.12.32-cip2.bb
new file mode 120000
index 00000000..24622cf6
--- /dev/null
+++ b/recipes-kernel/linux/linux-cip-rt_6.12.32-cip2.bb
@@ -0,0 +1 @@
+linux-cip_6.12.32-cip2.bb
\ No newline at end of file
diff --git a/recipes-kernel/linux/linux-cip_4.19.325-cip120.bb b/recipes-kernel/linux/linux-cip_4.19.325-cip121.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_4.19.325-cip120.bb
rename to recipes-kernel/linux/linux-cip_4.19.325-cip121.bb
index cbeef699..dbed929a 100644
--- a/recipes-kernel/linux/linux-cip_4.19.325-cip120.bb
+++ b/recipes-kernel/linux/linux-cip_4.19.325-cip121.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "9149d5ce9bd1a27ebb67358db8c81ef5c3e960c196007d501b731295ce8f7f69"
+SRC_URI[sha256sum] = "0c14765ee5a6f3689a22578f3d0270df8a72c49fbfe17ffc3566f4d4aaee455e"
diff --git a/recipes-kernel/linux/linux-cip_6.12.29-cip1.bb b/recipes-kernel/linux/linux-cip_6.12.32-cip2.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip_6.12.29-cip1.bb
rename to recipes-kernel/linux/linux-cip_6.12.32-cip2.bb
index 40a3a702..45705a4c 100644
--- a/recipes-kernel/linux/linux-cip_6.12.29-cip1.bb
+++ b/recipes-kernel/linux/linux-cip_6.12.32-cip2.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "27bf5750e3ac4ed50b3cca0eb910e330eb3b24ec3d078af3d7d626123ba7b819"
+SRC_URI[sha256sum] = "948b118eb9f36a881cf77e6a20e508362131bcebff6fa46353062ceb939a4d5e"
-- 
2.43.0


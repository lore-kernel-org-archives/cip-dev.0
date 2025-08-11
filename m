Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B47D8C88CB9
	for <webhook@archiver.kernel.org>; Mon, 11 Aug 2025 14:18:56 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.64])
 by mx.groups.io with SMTP id smtpd.web11.48868.1754921928315901008
 for <cip-dev@lists.cip-project.org>;
 Mon, 11 Aug 2025 07:18:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=j0o2SMNU;
 spf=pass (domain: siemens.com, ip: 52.101.70.64, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TS6h2pquJjDpsRQLpdt/18Ib+CSijCJErZW+YkgieW3Iih/KLon7i0PYkgWCcPFm2mbpHavDUxeBv48vS7xDUVJ2bXf+OdQsXY8Hsr+RaJPTS/2wl3BVnJmpfdUl+A+ZheM6OeFRbJCySm49aMUMeL4zrxROMBEWQ/opBYZKt4gfYb3jrR8c8l1e8B5kSk2dT5po9dsaXz/pf407V65FaYwva/Has3lfjEh5Go98HAZBDpwRnSnksRJu60VJu61nOC9LasSBIpYBG0EBVMg8p01FGGUeOCeGDlZPmeHwC2iLu9QMrSWSvsCKrIOXL3fAhdKhv6/odIat14KJ7Kt7qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+sAUm6hElQcmSmY4LiifzatQGEVWqUfR8UQuD7DIg80=;
 b=pXgJKalk453MrmecMKADVqH1hc7GBR8uBybqBM8CaE5HaKaD6f80n536uRi69NFEam740I6SuQZHTg4N5HTSiH12rP79EYr3644W1Skpv+R4D1yi2GtPkjh8e/54rr89iAyP1TYPeaMMVSFv+nZJuD/pVsKL9PXKgS26U2y9kBMfEiBt2ttjEPyyQngyQDAkEgjDrq1aeetOnkkjRqrNZbW0bmncVbCcTeBfl7FObLn9fk4MUrCnDupzVKis/OeFP4LrRcfHFJSfQ3Ty2Q0FalGFAeC7cDb8N7cYLGURyeBn20fgwdyTd62m/JRwb8ZgdDcotYyvFZVKjamSEvudTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+sAUm6hElQcmSmY4LiifzatQGEVWqUfR8UQuD7DIg80=;
 b=j0o2SMNUAFu5Y2nnvZb6liI3pv3ZJIfJFlNoRxzqvqCj/xB8LY7mpjmErhWgc5zAkBrV89S4gAFJoC3eluOTAkExlXR2dD+9Vwl7HXoim+ikz1DWwN7DZrq9239vnFRwavDezat5eV+dSw3B9pR0yINSct6nKyE4jJmyKa25JnAjPNo2qkcrImvTjjk98zI7mKZDxGgYlVqH4PDuzon37V1JeFX1URqlUm9ItR3OeS0yaEu1ZAOqztceE4x36MTEkOH54P6LjRyg988slN6sgSZouQ/I+OB2FDAz3hhbHihwoSivbtTsRILn9FosNzdeso7KyoQhVu4ltDe++GMcmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB9181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1e1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 14:18:44 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 14:18:44 +0000
Message-ID: <7e930321-c7c3-4b70-b181-2da58266f1fc@siemens.com>
Date: Mon, 11 Aug 2025 16:18:42 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 4.4.302-cip101 and
 6.12.41-cip6
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0059.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB9181:EE_
X-MS-Office365-Filtering-Correlation-Id: f4a1eed3-d03b-42a3-96a7-08ddd8e1fa9e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?M2lTb3lEWldqRzliTm9TdTJ3bU5wd2J0aUFmbFJkZXZuVzBISW5GV094MkFI?=
 =?utf-8?B?SmdhbW1TUzV0c0c5SFhJWDI3YTNlYlFxOXI1cVZtVStpNnJXWWxyWVN3bEUw?=
 =?utf-8?B?V2NaSlQxb1JOQ0xmMmJVN25jVlpnOWNzZlZBY2loaXI4WldodXFJWkQ5TURw?=
 =?utf-8?B?NHFPdVNxTjZEdlFlY2taSGtOYkpvTGZ0eDkyQmZFeDR2V0p3RHZlNXlGVkMy?=
 =?utf-8?B?TjE3QzdPQU4vTXBmK3puNGhyWE9YWGJPKzJIZU9oQ2Y1NzRSUzIyRitKb0VI?=
 =?utf-8?B?NjlyWkFMNXkvbXN6SDkybkI5Q3N3a1dvWStkSVNOaVh0V3VlcEJkOC9VRHZD?=
 =?utf-8?B?VkM3VHJnVE5oaXRpNHlJY0RaVExoRlRnS0FGMjFLUHVjL1RWdDNXR00wam4x?=
 =?utf-8?B?NG5mdHRCekhac2lWTC9yZ29MeC9wQmppd0UveHRjZmFhOG9iL2c0WmF2NC9U?=
 =?utf-8?B?UkVBQmdFOWJZS2ZTMzlzNlRMaWJTYWtEQUZGc3hsV3BMeTJ2VVFPVnIyUXJO?=
 =?utf-8?B?QW4xd01aZFh3cTRvQmVGK0V0ZEZvMit6WUFRMHR2N3AxdWZBeGsydE1pSEU5?=
 =?utf-8?B?ZDk5bmRZMmlpRkdVcHlTZ04vM2lVY1dqOW9VRnh4NHZLVVZDekZKNHcrQUpU?=
 =?utf-8?B?QlkvMzllSGlnZ3o5NFIzNk9QK1hud3VwTkJqK21ZaExaMzFweWxSZElsaUtk?=
 =?utf-8?B?dTh2cU5ScE9lblJSdXQrZUs5cHFZV0R4MERDZUFTVmVtbFhYbWFGc1FIOEdG?=
 =?utf-8?B?RTBpMElhb3RRQUFUVGdtdnZ2aFM0bGh1V0VHNFlBTC92VmpYOThFdW92a3BX?=
 =?utf-8?B?dCtrQTZ3SHBHMzB6M2hLSm1sYWpNemlxbFhWL2ttYUNSTjc3bTJWQkJ2Zkt4?=
 =?utf-8?B?VlkxQUZmLzNBbDFBZSt5Z1RoTnlaQ2wxaGVYWUFPWW5GcE5RZlRFcXRsTmd1?=
 =?utf-8?B?Zm9jeThpQXJOZ1BWMXBsZi9xK3g1Ykd2M1ZyVnB3OCt1eXZPTXZRY21HbHRy?=
 =?utf-8?B?WitHcXZkbVI0U3RpVU9NKzM5dHArZytQZUk4MjA0aWV6cFZaWnlEZ2IxMW5r?=
 =?utf-8?B?S09ZVnlodzRtcWU1VDlSNks1NlYrR2t1ZFVDNjBxYnpkeU5NWjExcmNRYy94?=
 =?utf-8?B?THN6b1prUFByU1paOHMyN1ZpeURXZjJJS0xIeEpKbnFFZTVYVkEyeGc2bjBC?=
 =?utf-8?B?ZlRoeTRBNjJzTU5zWEM3em9LZnJIcDU1a2V0dnNJajNzQjUrb1pIVUlkWFpa?=
 =?utf-8?B?VmNVbk1tVk1IeUN0VFNuUEl2QXEvbzNQZmk1WWxXMHcyZGwxT1hRNDBBT0ZK?=
 =?utf-8?B?ZWF5L1hNSDQyV1JMbk1tQXAwNHQ0SUJrU3FSdkJpVE92UTl0TjdJb1lyRnZP?=
 =?utf-8?B?WlEvbHVHeThvMFIzU1F3MVdpNUZ4MURJeWIzVkd2RktoUVpIVDcwUW0xK05u?=
 =?utf-8?B?MndvaDdCSUgyRGYvd1U0VzFRTkNXL0FUaVJkN3FjQVl4UmVBZUpzQjd3VW5B?=
 =?utf-8?B?U1N4d2dnQ2JET2JEdHdBSGlSWEZvb2k0WHJpYTI2aTl4MVd2L2hWMFg5aFFF?=
 =?utf-8?B?eHRqK1Fad1M0a1F0d3hWQ29Cb2FvTlNWdlVkRWdqUjQwcVJUVEsxSWFnMTZw?=
 =?utf-8?B?OEJqNy95cDNIV21pWVZncm01ckxsS0VrNDl1bUZ4Q2preWVHekZoVkdFR2d3?=
 =?utf-8?B?U0NRR0tQSmkwZlJWV2ZhMkhHZXI0Vms5aUpxaGt2SkxDOHJocHBuN0dMSGVr?=
 =?utf-8?B?QkpsMXZIeWdzeTVQWjBJS3pTOFdzL0hDNGRjNlRpOVU2cDl4b29hekhUUXVJ?=
 =?utf-8?B?OHIxazZiVE56UzhpT3A2emd5SUgySFphODJEMVpneE1YWHZnV3gvaFpFeDRL?=
 =?utf-8?B?UXlJMlFSMEdGSWxsd1JjYXl5TDFRM1RUOFJ4NnJBcXlqY1A1WTM2REI4ckhw?=
 =?utf-8?Q?eenz3M8sBgU=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Rmk2Z3h2eld1M2crZGlha2xid1pwcmRiSFNBcUNkR3EzTS9DZmR5MC9aZkg1?=
 =?utf-8?B?VUNEL0pEOFRlM3hlaWUxTVhSYktOOHZyOUM1aHJHREFMT1ZrUzhyQ280b0Iz?=
 =?utf-8?B?MVhmTERmdTM1eExQdFpMd0NBdHlJbjBrc0lFRlJEanJEeDFMQlQzL3FyT05l?=
 =?utf-8?B?ZnRyOGVUdXVOYjhxbmtlWU41NmsrTUE0MTVlV1lpeGd5N3NWZTlSNFV2R28r?=
 =?utf-8?B?SHlXd2Z5RisrczNjL3ZBdWxxMVFiQ0dGUmc2NzRub0pCenJaM1pWVkhmN20x?=
 =?utf-8?B?N040WXVteFZHT2hXb1BjeXJtcmtCK3BXbHI0d0RzaDlDSy84ME4zYW5kK050?=
 =?utf-8?B?RStOWHRYY2ZHUnYweU9ibks2N28zS0kxRVhwVnVCNmZVTXFZOFphanJJajVP?=
 =?utf-8?B?R2Y4Unl2eC81bkNkS1VBUkg4aE5LNnRwQUZQU3MvNzdMT2J0eUd0Vzh3MXdw?=
 =?utf-8?B?SU9URFVxM3BqbzRGY1RvcWdFWURBSzFTWmk5aVVmbnp1cCs4QmVmYlc4aXI1?=
 =?utf-8?B?L3FnbzBUZ09QRit2SUlpMytpa1VmejJDS0wrRkF2d0JGcWVVZ1NpQmdzd3NF?=
 =?utf-8?B?RnBOQXlRL3lPQU5MMFlXMmNIcDZabVpsMENIb1AzYzV5RWo3N215WnF3bmRk?=
 =?utf-8?B?cGZIZkVVS3I3WUFvL00vNzdXbUxITWlacVZDUTl3WXhQOWcwMTltMy9sUW9E?=
 =?utf-8?B?bWlZWDdNQXhOMjdMMkloMDFURUFGNWVrdmVkR3JQS1pGbFczQ09lMzRxajJZ?=
 =?utf-8?B?QW43cUViSSs4SktDNlJ1aUNORzR4YmFUc0tNU1lVemdPOUFYYU4zRE1tMmFi?=
 =?utf-8?B?NWl3Uk90OHJkdVFrUzBsYnQrWUJYNzhIcDA5Q2NDcmtPVDNwZkFHbVRUNFUw?=
 =?utf-8?B?dklIL0k2YTBFWlhBK05iSUhPbG1mN0dvMzZuZ0lDYmVrbW42VTlNRG1sQzBy?=
 =?utf-8?B?dS9kZnY2aGRVY0U0bWtLR2l4Nk1RYlQ1bXA4WllVb2EvOXhHN25zejlRbHY4?=
 =?utf-8?B?dWtDRnVGNk0wYVJGNTc5NXd5Z0VwZ2MyelI2UEk3NkUxeUwvU0U5Z3FmNXBr?=
 =?utf-8?B?SXNTWEc2NE9XMkJTSFBuMEtpdFVuNlNYVXlRYW5JTDkvOXBYU1kwOGtybWkr?=
 =?utf-8?B?VTJ3aVRrZEZ3T3loRFNIWmxhSXN0cXo4YWR0WFVqSkVWbTZCd2QyTXZTVmVU?=
 =?utf-8?B?SzlYNGxMSGZWVTArcU5IbTlBa09EaUhOZTFOVFkvMWRCT0VBNGZiZVVTbDlC?=
 =?utf-8?B?MzBINVdmQzJFOC81ZS8zNWZxN2c0ZU9LTE9WVmgwQXluM3BRTjRNdHNhUWd2?=
 =?utf-8?B?ejBEaWRsblFtVlVhdUlGNjJoVUphMEEyYzRXcmtSMW9PbUJPeFQ4ajhLUmYw?=
 =?utf-8?B?eTNYYkwvU2dnUno2U2ZCcURHSXJkUTZhelpzbU5tTllyaXJBQ1BlWXdRKzVv?=
 =?utf-8?B?MWVESExkNGFjL2lwcnlCWHpISzBMZ0pDdTZkb1pUOFlQL3FvS3F5bGRxczlY?=
 =?utf-8?B?MnB1V3l5cnlyelBjSHAyQ1YzRWN2cFQ2dlM1Ny9EcndWdDV6bmk5VkVENG9X?=
 =?utf-8?B?UXp4ek5UTmZlblRQRklaNThSK1c0RDRZVStuYllYd20xRGxFZi9oNzZiYUhT?=
 =?utf-8?B?b1VGMlhiSDY4MEdDVWJ6UC9RN1F4RjVsN01aZTdqTncwQ0JCZThwMlhrblhH?=
 =?utf-8?B?S3gwRGhNQWNCUkhPYTYyQlBCZGJqaGQ3SHpEQngxeHptWGJVWURGQlZlNTJy?=
 =?utf-8?B?bVlmUGdwT0JaQzBSaVpwOTM0MVN3U0RFUVA0TzhyK2V3TmxpNEhqY3RoaDg1?=
 =?utf-8?B?aHdzTlh6a1Q2L3BKNTJvUTJJdGdUc1Q2RVVMZXU5cENkQlllbjdEUU1aNVB2?=
 =?utf-8?B?VGJvU3hmUFRPU3d5elNhWmRKcjBkV3NJQXhncVVHVkRReVZLWlkzUnZiOWN6?=
 =?utf-8?B?elArazBBaHU2Q0JzVlRvbUQ3Y1lGYnpUdVg4ZW04Vyt6dThIRE5VZGhlMmNn?=
 =?utf-8?B?UmxHMDBYNkFnYkphb1JuUDVBYmlSc3VrN0x3Y2ZldFlaTnRRZmhTckZHWi9D?=
 =?utf-8?B?bnhVY3BYTFB3dFZMNk1DRnpZWjgrV1kxQWUyUSsyZVoyV2ZxOW13QmpraXpr?=
 =?utf-8?B?WTBlU3RxUjhBQUhwbU9FNHkrMnJ3cWRCQk5qSG1hYUhrUWxqblFiY1h6bTNl?=
 =?utf-8?B?MFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4a1eed3-d03b-42a3-96a7-08ddd8e1fa9e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 14:18:44.2131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Ua1/D3pz+XL6DrQvg2ahiXqzRz51dMipgUsCYohQxWCmKb8pEw6xuXVnOL8vB9IJiIDhXpr2Uf7ZXt9csdGvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB9181
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 11 Aug 2025 14:18:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19716

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-kernel/linux/linux-cip-rt_6.12.39-cip5.bb               | 1 -
 recipes-kernel/linux/linux-cip-rt_6.12.41-cip6.bb               | 1 +
 ...{linux-cip_4.4.302-cip100.bb => linux-cip_4.4.302-cip101.bb} | 2 +-
 .../{linux-cip_6.12.39-cip5.bb => linux-cip_6.12.41-cip6.bb}    | 2 +-
 4 files changed, 3 insertions(+), 3 deletions(-)
 delete mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.39-cip5.bb
 create mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.41-cip6.bb
 rename recipes-kernel/linux/{linux-cip_4.4.302-cip100.bb => linux-cip_4.4.302-cip101.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_6.12.39-cip5.bb => linux-cip_6.12.41-cip6.bb} (59%)

diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.39-cip5.bb b/recipes-kernel/linux/linux-cip-rt_6.12.39-cip5.bb
deleted file mode 120000
index 26a42aa2..00000000
--- a/recipes-kernel/linux/linux-cip-rt_6.12.39-cip5.bb
+++ /dev/null
@@ -1 +0,0 @@
-linux-cip_6.12.39-cip5.bb
\ No newline at end of file
diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.41-cip6.bb b/recipes-kernel/linux/linux-cip-rt_6.12.41-cip6.bb
new file mode 120000
index 00000000..f68d2686
--- /dev/null
+++ b/recipes-kernel/linux/linux-cip-rt_6.12.41-cip6.bb
@@ -0,0 +1 @@
+linux-cip_6.12.41-cip6.bb
\ No newline at end of file
diff --git a/recipes-kernel/linux/linux-cip_4.4.302-cip100.bb b/recipes-kernel/linux/linux-cip_4.4.302-cip101.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_4.4.302-cip100.bb
rename to recipes-kernel/linux/linux-cip_4.4.302-cip101.bb
index f2d2e99d..c1e0efd1 100644
--- a/recipes-kernel/linux/linux-cip_4.4.302-cip100.bb
+++ b/recipes-kernel/linux/linux-cip_4.4.302-cip101.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "7d130141f58db7124ab30527137986a4d789f7b952f43043ac26c085d3b07a78"
+SRC_URI[sha256sum] = "631eb00305c944e6f10d7f9227962d8d468d60c9bb83d9a78901074a05007a96"
diff --git a/recipes-kernel/linux/linux-cip_6.12.39-cip5.bb b/recipes-kernel/linux/linux-cip_6.12.41-cip6.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip_6.12.39-cip5.bb
rename to recipes-kernel/linux/linux-cip_6.12.41-cip6.bb
index 9b5dd9c1..c4f24657 100644
--- a/recipes-kernel/linux/linux-cip_6.12.39-cip5.bb
+++ b/recipes-kernel/linux/linux-cip_6.12.41-cip6.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "be863adb5fef55c4698a358e2be78dc16f567f394cfa1f56b4837b49dc1b3f0b"
+SRC_URI[sha256sum] = "c69287b8d28e0b740ea46441584cca19896fe887befc296743b4cc0a426508ba"
-- 
2.43.0


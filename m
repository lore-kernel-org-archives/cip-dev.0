Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15865C3ABBE
	for <webhook@archiver.kernel.org>; Thu,  8 May 2025 12:50:53 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.20])
 by mx.groups.io with SMTP id smtpd.web10.14566.1746708642552353862
 for <cip-dev@lists.cip-project.org>;
 Thu, 08 May 2025 05:50:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=xYCheZwk;
 spf=pass (domain: siemens.com, ip: 52.101.70.20, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mEc9aTZyp63j99jzQfoyWe6IaO4f/E/q/XoTLCipsyURYL/1ocCY0MAbKZyAfV17LJTSWI8yxsepObaKxLSbJubCzPOvh4hdX7ROr5r5h3k8QLcaRvKf/LxEaUqK8h7h0ClnO7Fndh+PDNSMSK8j3jXcUs7t9SPHO+uZelC21mNOMkTB7O7V5wvcWJ5PCCmGmF59WQhoGYUmIZnYl9LZh7UrGykGFNCBmWCrQxQannj4B7sTsCld6vxBf5ixw20zQN9FZojsG4mCPxzDNsOEL+CbEfG4wSZs8LAV3js6QnQ2sLh/TZygyODMIyC+1Pfe2LrJJXBDZircWyw5QE9b7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EnsnkmooO+ZDBdOa4Hs/cUjv5dSL9oX9gJFYSz5yWls=;
 b=Y79bRHVG0KRujnelovqOmsKRgV+ZToe+p1acWl01BqM8kPq5MiNOu4Z5HMFKdqB9amQHYSalu8NZrEc02mvw5HDWCMQf1oYrsWxLAglCB0zXwcGAE1oUNG1LfIDhTJiYm6TOTPlbKwoQqLHLSyjVaQBqbA80TDltLv5nhTz3Cy2bBTNDUvMHyafLmyg8Mdyf9noeibCkq/+JFRSPHXtzBHzrJRqKWM7XsXNs1FOOGwg684dnF9nkoiwbZ2ln9q4YzhqhZ25szrW7a8aq6T/QU0ZSlWXq/Dy3VTCY5t3C0o0M/cin0lbXiYzVr3MPtNsCuBMXUYGj1WzdAYXPPZ4aaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EnsnkmooO+ZDBdOa4Hs/cUjv5dSL9oX9gJFYSz5yWls=;
 b=xYCheZwkd1AtKOSjsmfl6A4pueJH6NTbM0R/QHkrHRWyXvhguIlfYwGFHqT3QEQm+pvb/FcSJmPfVw/Rt1ouyQtdVnUo6Wqp2ApJa201HT1vr4CThDUotO3i5X0EmAAakdoqEmODlNnVavVkLetItKdZ38uR1POdOM8SIxUT2u5Ef/CYq9R/rrE65DrjV2sA2vap8iL0r7SYVWIgzwMeIlBPKU/oStfBKMl7stVTDNwL+UeTaMrpjrGd5LKQWMFRqPTzEIjCzAXUFIi3UcSJM58vZjqUGDWzU5q5ibP54U5rOFHqSvtkKIWYkljZ7oVC//wjoMiMEEzU2adRtU4qUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB5670.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4f1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Thu, 8 May
 2025 12:50:37 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8699.026; Thu, 8 May 2025
 12:50:37 +0000
Message-ID: <55e6df06-df9c-486c-906b-f7d5bb8622e5@siemens.com>
Date: Thu, 8 May 2025 14:50:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v3 1/6] add factory-reset
 initramfs hook
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20250506120807.255675-2-Quirin.Gylstorff@siemens.com>
 <20250507081123.94511-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250507081123.94511-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0172.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB5670:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bb83005-7426-41d5-a2f1-08dd8e2eee64
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?dWxkV2wvd1h5bk0rMzBQNHczZnMwaFBsaFRBb0k3N3ptVkRmZGlWYzlyUk9S?=
 =?utf-8?B?dnRxMk4rbElsKytBL1lTbUV3cUpkSzRJWDl0eWRRVE5QbitTa085cmswZ3JW?=
 =?utf-8?B?bGl1TU5Ga1FyYXVzM1AvM240RU1pR2pkUkZ4SUlsRXgvMzdESFE0T2pvN3N0?=
 =?utf-8?B?K2RpRkJIbWkwbjBJb1FkdG9SVUlKaTk3emNJOGRGWVFtU1Q2YzNvTCtCeU5x?=
 =?utf-8?B?UUM0SktJTU1KaWRZb21BaTRTTTRIdDRsM3kwcTd6VGFVT2M5c0tqOWxWSExK?=
 =?utf-8?B?MVlnYU5PMmpkZWhRRDlxRjIxdUJrSW1ScENzeWJtWWpZaC85Z2h4dnIzUHlG?=
 =?utf-8?B?SmFPaTNQN0FKVVozUnFFa0pQM1dCU2E3K0xXUEZnbVgrbmQvL0FGdUxzSkxn?=
 =?utf-8?B?R25wZXpzRTVkZkoxQ2RJRWJoLzV3S2ZnTXFCdHA2VkUvV0xaWWpoZlhwWFBI?=
 =?utf-8?B?dE5JNTdMRHV6RTk1VVZhY1pYYVp3M0JYSVRqbTNsMTlqR2Zua1NNdWgxYU16?=
 =?utf-8?B?SzVJemJ0VTJDMFdsK1RBZXVpRTZUKzJDQllhS3NiUlNFQlVxTlVjc2NkRWhP?=
 =?utf-8?B?WWQ0bk41K0p6T2wxWlFkYXM2UElxOHJFMk1jRWxrUHBOOFBhazN4WGF1bjNs?=
 =?utf-8?B?dUZUTEhCY1NrY1UrUDM4MWFFYmNTSk4rbDFyUVZBbXJiVGZBZWhtWWhrb0cw?=
 =?utf-8?B?NUsyQnVoL0phYnRwUU1lVHNlNk9KUlhLQnhOUit5NDY4UjJ4a3Y1ajVzeWdy?=
 =?utf-8?B?bXFNVGt3ZS9wcTcrK3ZkajlLSkpRQUg4dXVQb1VXZlF3N1ZZd2ROcDlDL29y?=
 =?utf-8?B?alJGMDRuRXR4ZnM5OUxTZkwxUnNPdjIvaU1IZDhyMzF4MCswK1QvZWJXN1lX?=
 =?utf-8?B?QWNzU3JYVXlMNUJmUHo3dkFsdXpWVWdXQ0JxZy9KTHFZZWpFL2xZSStjSnNQ?=
 =?utf-8?B?bE9abGV6UmJHaGVza21zNGhRWEZ6TG5Zb2VXYVBtVmN6VjdCR1RHeWs5NllS?=
 =?utf-8?B?VE5ML2RrMEdDd1p5NXVUYk45V3N4dURCOC96SkVtYlMrQWlDTE0rcm5qajl5?=
 =?utf-8?B?WDRZQmV6VkM3TjQ5VkN0YVJpSE85Y2VxeWxZYlRkSmxhYkYwQVFMa293NEd4?=
 =?utf-8?B?RmpRbFByVG9oMnRQYjhLeGlRbUpWajhqWWRLY1BlS25MQlNLb00vSk0vZkRh?=
 =?utf-8?B?bUFGZFRwbzBzaE5RUGRob0xDUVdia3hiUDNEM0JQdXFOZFFFRVErVGUyUmcw?=
 =?utf-8?B?bEZxTHJ0VHZMeGtocUNPZkxkWk9YcXBDOFNvcitHS0w2YkQxVVZuL3pyK3dY?=
 =?utf-8?B?VDV3YVFJUWNmQlBSZmt3YzZmSUhoVDVFTkxxWGpqSmJvK0R5bkNwUy9JNi9Q?=
 =?utf-8?B?ajA5TmhkLy92bGlXR1RsblhjNVk4OEVZYnk1M3I2b0lmYUN6cnprNm5OMGM0?=
 =?utf-8?B?U2ZwYS84RVBZRHgxNEpVemtuMXhHYThCY0R5ZHNNOTRKS1Fpb0Npek9BVEF2?=
 =?utf-8?B?Rk1FVS9KVmUxcmNCWVFZNjhDNldtMSsvMlBPQlNCT2lhWFZ4bGsvRGUrOGdi?=
 =?utf-8?B?VjN6Zmk1ZStxVHNWbFZsZzA4VW5XSnBjMXV0YjYvd1NKSHdjMkY2QkFka1Vm?=
 =?utf-8?B?OVUrMnc0QmJiSXkwYTVyL3VHUUVwY2xybGhHTDRYTmxsTlRBS0F0MDhpUzVj?=
 =?utf-8?B?YlF4NFY5c21xWWRsWllJT0lsVmI4YzgyTjgzazVYd1ZET2hGcEJmN1BncVBX?=
 =?utf-8?B?WjRCK1RVL21meTloRXJZTFUwcjNEQktVT3l1ZlFkZ3BuTjZCZERoL0xtaytj?=
 =?utf-8?B?OHBiS0twbFJCVk1kOVc0MklnRFBXU29GZXlMZXduKzV2ODZmWElGMW0zakFI?=
 =?utf-8?B?eWxPbUlIRWNySFdSS3poeVBmWjlyb2pKNjBBeitxRUthU3lTNkRieTljM2Vj?=
 =?utf-8?Q?KuaZjLnSj8M=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?d0cvSVF4SWV3YlR5ZmhrSnU5YzllSjBlNjRDZFZzWWdpMUxtQk9sRXlJdWYx?=
 =?utf-8?B?ellSVVlZK0tIYVovek9YZnJRQ05ncnBtZlBNZytOWUpZc0dwSmFYWkcxdE1s?=
 =?utf-8?B?YlkyL3l5VlRQOVpMNDZDcjNtK2lERHlia0V0ZzhNeFZIMHNJRCtiRHpDeml5?=
 =?utf-8?B?c2ZsOFNiSjRFcldNSnZxUGR5aW9tbFREWHQra3NBczk2TVM4ZHBSdlE5UG9l?=
 =?utf-8?B?TURVQ0hwSm0zbWNuMFJOZVJtejl3Y0ZwRTBnWW80M0xjbkJHTDlRYS9yS2p1?=
 =?utf-8?B?eCt3Z01YaHVlTVIzRHNTU2ltSTN1Ulk0ZVM4NzVXa2VOMnhhSDR4NFZGTEpM?=
 =?utf-8?B?aU1zc0h6cnFyekVncm4rVStTWksrM2JkM0R4YW8xMHdwYkt2VFNxNlpzVVVa?=
 =?utf-8?B?dmV0RDcyRmZCRkRLcklNWEpTUDVQY1ljYzlLTS95WllJQzNlZGU5YURVRnhL?=
 =?utf-8?B?S2x4c2pncTN0ai8rYVJoWU85OW5xMk5ubzkvdUVTTjRLQXhvZy9ZV3VFMlh0?=
 =?utf-8?B?d2RaVTRJK1Y5Mmg0VWllL0JvZ0NyTHo4cW8xb3JmeW8vZENHSjBqeTk1U2l6?=
 =?utf-8?B?NFVBc0lZdXQ5eE5MVVNuYjhHWU83cDQySUo5bytEbGZPTnVlVVltcEZFU3NW?=
 =?utf-8?B?TlF5eXNPbk1QMU9WU3NMVVVheVFNa3BRQnNKSG1lVXRYOVpUMHFVVlJHc3ZK?=
 =?utf-8?B?K3BKWFBiQU5VQlI4aWkzUHhpb0sxVmVSQ29VTkxmQXBkZlFaMVY4bko1MWtp?=
 =?utf-8?B?MTBXeHF0OWhJZkErdi84UGE5WEJvU0pZZ0ZlVWVLbDBIVnZaU2gyNlBwUmg3?=
 =?utf-8?B?aEt3MWxmK21tYU80NHgrUWZQemFtOEJybVovelFmVW95RjNudHgvUjdzN1Ns?=
 =?utf-8?B?TG5vNSszT3BSa3c5dFFPaGlsSGVuTmUrTnhHOXZ1VVUwaWxCczVXNzA3Wm9p?=
 =?utf-8?B?MGpMclAyY3FBTjQ4QTJMVkxlT1liWHA3RGJXYmhqL3FmbVA4d1lqWUx1VWtq?=
 =?utf-8?B?MjR6d25uL1JuejNGSHBHZjM1NGR0UnQvMUEwSXg3SGVrYXRhRk5CVHg5OHhy?=
 =?utf-8?B?TXRiRnF1Y1kzc3NlN3pSN0dMMkphcGRkVlJEV1h0bkxncFVnZE1zV1JNWThN?=
 =?utf-8?B?R3E4TVVUY3ZobUtCYWZWVU9NVGlqdGxPUGxYcmd1bFdHWk5yMXVCV0ZMRWxs?=
 =?utf-8?B?WWFQQit6MFZyUE1zMHM1NzBrejhYRUJuVERaN1I2U3NjVko5TldsRnN4UGtF?=
 =?utf-8?B?eWFTb3kzejNENVF1OG9RNlB0QlFHVmE2MFUzVFhMSlQwNk9mancwbmlRbU42?=
 =?utf-8?B?SUF1WjhOd3R5eHpGZzIxbWMyRlY5Y2FxaXp2SlAxTmtOeThCNHh4MGJQN1VG?=
 =?utf-8?B?WWd4eEY3V1RlTnczeDJXVFVVMEpNQXdkbjhEMmRidGRUNFVRV0VSLzZ6NDNi?=
 =?utf-8?B?RUdmM2VhUTl2SzRIMnJnMGEwWVI5TW9XQ210UXhhMmJ4b2hxNjgvL05FUTlM?=
 =?utf-8?B?bnFOWWJBTTMzR1A2U3ZVWHhhOTF2aEVCQUI0Z09OV2kybnR4Z2xnZGg1amtu?=
 =?utf-8?B?MTR1Wmt3aUpMQTQzZUx1bFdQRlJVMVpFY0NSSzVNTzYzRGFaZkRubmN0eEdF?=
 =?utf-8?B?dnFWa2JFVUtqVC9kVnNzeXJpTFBNY1NoQmpJd0MyeTVkTmpKYjBhUHZRbFdT?=
 =?utf-8?B?RzN4OWpVb05RNnVNRVpCMnNvcEpZU0s3ZEdBTlh3Tnh0WGtOd3NrbDIxUVRE?=
 =?utf-8?B?SWQzYWFFUk9PNGpoaHBkVHlqb21MVjVaSko0STNycW5NblYyZ2JxbHlyMVJ2?=
 =?utf-8?B?YlZoelBFWDAzc0xyZGpDZDd6ZVVCRVl5dDExVVBjYlRkR3VPcG1HZEtFeW9S?=
 =?utf-8?B?b0FoOVBDVmZUSTYxQzlCekVMS3p0MUN5QkYvdCtXdHdLT0ZwS1BSdFJ1M3I5?=
 =?utf-8?B?ZmIyajhnRVB2Zmh4Tm5IZ0hGTE9ROTVNUzJ2aDRQK0grWXF3TkNkQWowZ2h3?=
 =?utf-8?B?eVNaZCswUFk0UTVkamZ6VDlFckNwWXpUQVIxbmpKd1BBT2UzeWlLUnk4K1FF?=
 =?utf-8?B?YXROR2laZjZkTGFXUU1KOW40dWRKTDl6b0lQNTdzVWNUa0RmaUdPZGduWW9p?=
 =?utf-8?B?cm1YcTdqbVdndWNjaVJWMHVRVnpqZi9sZXMxOVNkK3BLR1pEVGV0NjZjUmM4?=
 =?utf-8?B?eGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bb83005-7426-41d5-a2f1-08dd8e2eee64
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 12:50:37.7517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TtCgI21rV+NuHF/xS2pr2j5SZ5BP6kSvvnoLkKF2JLU6uLkspSC1e3KTgtSXF+jDyl7IFvvSCzODZbDO51eBig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5670
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 May 2025 12:50:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18781

On 07.05.25 10:10, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This allows to reset the device back to first boot by
> formatting the persistent partitions.
> 
> The reset occurs if a file defined by the variable
> INITRAMFS_FACTORY_RESET_MARKER
> exists in the device INITRAMFS_FACTORY_RESET_MARKER_DEVICE.
> 
> In case of disk encryption it will invalidate the keys
> stored in the TPM.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
> Changes v3:
>  - remove `set -x`
> 
>  .../files/detect-marker-file                  | 33 ++++++++++
>  .../initramfs-factory-reset-hook/files/hook   |  7 ++
>  .../files/local-top-complete                  | 66 +++++++++++++++++++
>  .../files/reset-env.tmpl                      |  4 ++
>  .../initramfs-factory-reset-hook_0.1.bb       | 52 +++++++++++++++
>  5 files changed, 162 insertions(+)
>  create mode 100644 recipes-initramfs/initramfs-factory-reset-hook/files/detect-marker-file
>  create mode 100644 recipes-initramfs/initramfs-factory-reset-hook/files/hook
>  create mode 100644 recipes-initramfs/initramfs-factory-reset-hook/files/local-top-complete
>  create mode 100644 recipes-initramfs/initramfs-factory-reset-hook/files/reset-env.tmpl
>  create mode 100644 recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.1.bb
> 
> diff --git a/recipes-initramfs/initramfs-factory-reset-hook/files/detect-marker-file b/recipes-initramfs/initramfs-factory-reset-hook/files/detect-marker-file
> new file mode 100644
> index 0000000..30e399e
> --- /dev/null
> +++ b/recipes-initramfs/initramfs-factory-reset-hook/files/detect-marker-file
> @@ -0,0 +1,33 @@
> +#!/bin/sh
> +# Copyright (C) Siemens AG, 2025
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +# This implementation check for the a existing file to trigger a
> +# factory reset. Prints 'true' in case the marker was found
> +
> +check_for_factory_reset() {
> +	marker="$(basename ${INITRAMFS_FACTORY_RESET_MARKER})"
> +	marker_storage_device="${INITRAMFS_FACTORY_RESET_MARKER_STORAGE_DEVICE}"
> +	storage_mnt="$(findmnt findmnt  --first-only --output TARGET --noheadings "${marker_storage_device}")"
> +	tmp_mount=$(mktemp -d)
> +	# check for marker
> +	if [ -z "${storage_mnt}" ]; then
> +		if ! mount -t "$(get_fstype "${marker_storage_device}")" \
> +			 "${marker_storage_device}" \
> +			 "${tmp_mount}"; then
> +			panic "Can't mount ${marker_storage_device}!"
> +		fi
> +		storage_mnt="$tmp_mount"
> +	fi
> +	if [ -e "${storage_mnt}/${marker}" ]; then
> +		echo "true"
> +		# delete marker
> +		rm "${storage_mnt}/${marker}"
> +	fi
> +	if mountpoint -q "$tmp_mount"; then
> +		umount "$tmp_mount"
> +	fi
> +	rmdir "$tmp_mount"
> +}
> +
> diff --git a/recipes-initramfs/initramfs-factory-reset-hook/files/hook b/recipes-initramfs/initramfs-factory-reset-hook/files/hook
> new file mode 100644
> index 0000000..4b4ff25
> --- /dev/null
> +++ b/recipes-initramfs/initramfs-factory-reset-hook/files/hook
> @@ -0,0 +1,7 @@
> +# Copyright (C) Siemens AG, 2025
> +#
> +# SPDX-License-Identifier: MIT
> +
> +copy_file library /usr/share/factory-reset/factory_reset_marker /usr/share/factory-reset/factory_reset_marker
> +copy_file library /usr/share/factory-reset/reset-env /usr/share/factory-reset/reset-env
> +
> diff --git a/recipes-initramfs/initramfs-factory-reset-hook/files/local-top-complete b/recipes-initramfs/initramfs-factory-reset-hook/files/local-top-complete
> new file mode 100644
> index 0000000..d8e06be
> --- /dev/null
> +++ b/recipes-initramfs/initramfs-factory-reset-hook/files/local-top-complete
> @@ -0,0 +1,66 @@
> +#!/bin/sh
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2025
> +#
> +# Authors:
> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +#
> +prereqs() {
> +	# no prereqs we want in front of crypt
> +	echo ""
> +}
> +case $1 in
> +prereqs)
> +	prereqs
> +	exit 0
> +	;;
> +esac
> +
> +
> +. /scripts/functions

If you do not need anything special here (at least I'm not seeing
anything), please switch by to auto-constructed local-top.

> +. /usr/share/factory-reset/reset-env
> +. /usr/share/factory-reset/factory_reset_marker

Do you plan to reuse that code outside of this local-top hook? If not,
why putting it into a separate script?

Naming is also a bit confusing - it's no the marker, it's the evaluation
logic for it.

Jan

> +
> +target_devices="${INITRAMFS_FACTORY_RESET_DEVICES}"
> +
> +if [ "$(check_for_factory_reset)" = "true" ]; then
> +	log_begin_msg "Factory Reset"
> +	for target in ${target_devices}; do
> +		log_begin_msg "Reset device: $target"
> +		fs_type=$(get_fstype ${target})
> +		case "$target" in
> +			*by-partlabel*)
> +				label="$(basename "${target}" )"
> +			;;
> +			*)
> +				label=$(blkid --match-tag LABEL "$target" | awk -F= '{gsub(/"/,"");print $2}' )
> +				if [ -z "${label}" ]; then
> +					log_warning_msg "Could not find any label  for target '$target'"
> +				fi
> +			;;
> +		esac
> +		if [ "$fs_type" = "luks" ]; then
> +			# after this the data on the encrypted partition
> +			# is inaccessible
> +			tpm2_clear
> +			# with encryption the original fs_type is hidden
> +			# use a variable from the reset-env to set it
> +			fs_type="$INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE"
> +		fi
> +		case ${fs_type} in
> +		ext*)
> +			/sbin/mke2fs -L "${label}" -F -t ext4 "${target}"
> +			;;
> +		btrfs)
> +			/sbin/mkfs.btrfs -L "${label}" --force "${target}"
> +			;;
> +		*)
> +			log_warning_msg "Unrecognized filesystem type ${fs_type} - could not format"
> +			;;
> +		esac
> +		log_end_msg "Reset device: $target"
> +	done
> +	log_end_msg "Factory Reset"
> +fi
> diff --git a/recipes-initramfs/initramfs-factory-reset-hook/files/reset-env.tmpl b/recipes-initramfs/initramfs-factory-reset-hook/files/reset-env.tmpl
> new file mode 100644
> index 0000000..ed68398
> --- /dev/null
> +++ b/recipes-initramfs/initramfs-factory-reset-hook/files/reset-env.tmpl
> @@ -0,0 +1,4 @@
> +INITRAMFS_FACTORY_RESET_MARKER="${INITRAMFS_FACTORY_RESET_MARKER}"
> +INITRAMFS_FACTORY_RESET_MARKER_STORAGE_DEVICE="${INITRAMFS_FACTORY_RESET_MARKER_STORAGE_DEVICE}"
> +INITRAMFS_FACTORY_RESET_DEVICES="${INITRAMFS_FACTORY_RESET_DEVICES}"
> +INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE="${INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE}"
> diff --git a/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.1.bb b/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.1.bb
> new file mode 100644
> index 0000000..9e765b9
> --- /dev/null
> +++ b/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.1.bb
> @@ -0,0 +1,52 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2025
> +#
> +# Authors:
> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +
> +require recipes-initramfs/initramfs-hook/hook.inc
> +DESCRIPTION = "Delete the content of the given Devices"
> +
> +# find the file defined by INITRAMFS_FACTORY_RESET_MARKER in
> +# INITRAMFS_FACTORY_RESET_MARKER_STORAGE_DEVICE. Important
> +# this function does not work with disk encryption.
> +FACTORY_RESET_DETECT_MARKER ?= "detect-marker-file"
> +
> +# if this file exists execute a factory reset for the given
> +# list of factory-reset targets.
> +INITRAMFS_FACTORY_RESET_MARKER ?= ".factory-reset"
> +# use labels as crypt setup replaces the label links if
> +# an partition is encrypted
> +INITRAMFS_FACTORY_RESET_MARKER_STORAGE_DEVICE ??= "/dev/disk/by-partlabel/var"
> +
> +# list of partitions by label
> +INITRAMFS_FACTORY_RESET_DEVICES ??= "/dev/disk/by-partlabel/var"
> +INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE ??= "ext4"
> +SRC_URI += " \
> +    file://reset-env.tmpl \
> +    file://local-top-complete \
> +    file://${FACTORY_RESET_DETECT_MARKER} \
> +    file://hook"
> +
> +TEMPLATE_FILES += "reset-env.tmpl"
> +TEMPLATE_VARS += " INITRAMFS_FACTORY_RESET_MARKER \
> +                   INITRAMFS_FACTORY_RESET_MARKER_STORAGE_DEVICE \
> +                   INITRAMFS_FACTORY_RESET_DEVICES \
> +                   INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE"
> +
> +DEBIAN_DEPENDS .= ", coreutils, util-linux, e2fsprogs, btrfs-progs, awk"
> +DEBIAN_DEPENDS:append:encrypt-partitions = ", tpm2-tools"
> +HOOK_COPY_EXECS = "mountpoint findmnt mktemp rmdir basename mke2fs mkfs.btrfs awk blkid rm"
> +HOOK_COPY_EXECS:append:encrypt-partitions = " tpm2_clear"
> +
> +do_install[cleandirs] += "${D}/usr/share/factory-reset/"
> +do_install:prepend() {
> +    install -m 0755 "${WORKDIR}/reset-env" \
> +        "${D}/usr/share/factory-reset/reset-env"
> +    install -m 0755 "${WORKDIR}/${FACTORY_RESET_DETECT_MARKER}" \
> +        "${D}/usr/share/factory-reset/factory_reset_marker"
> +}

-- 
Siemens AG, Foundational Technologies
Linux Expert Center


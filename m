Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B433CDB46F
	for <webhook@archiver.kernel.org>; Mon, 22 Jun 2026 09:49:35 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.39420.1782121767106876233
 for <cip-dev@lists.cip-project.org>;
 Mon, 22 Jun 2026 02:49:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Ezf7guRJ;
 spf=pass (domain: siemens.com, ip: 52.101.69.51, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u1Lr+/b0r2khHV5Zsi3Mua8MdAJ0JPonfQ+xVfmUX4/avqt5ZATK6seYCkWATKKKsX3AG+JSTrT49E0pn1PmkJxKoMQNjY9y8ApqXRLoZ8NUAB/oCmZ90r3MOl8UudeTvkP/X8PyKVWgdjYUrHp6BM4GbstWXwJr/Yw98teKh8UfIlfYKVaBynHIEhYAUaE5N9xS7EKXenpjASJvoS8Wl5PTeUOPZVjOt1tYIG5b222+e1c4yGuccQqcRaivz2ij7WaGqitgoOSYx5HpMHlc3svsuYD+2KfnKB7jEksjV27XSBV/Ju+6bi9wqvajTZAR/6ByypGknPNnxOhIuSookA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ktAdkB4e4LqCb8zlBboKpQFV54UMna9aGZ41Je5cOvU=;
 b=NlWzMQ5WHO+Ecj2mH+kw8sYgYnEo7DC+7zmei0t1HZIt6NTD75cF8zETQugHdmx6FS/g/UWzCINjeg9HFzCikOtw16BzYI88eFen3s0l13OrrnmsPy0N9LAU5ksZhl6ufq3z33s1HpE/l7SbEzOLA8EVg3ItHQLZ0/9wySUpb6TLqAi3o80wxq0EzZIiat7XvW6kSeEqqYC24g/7Vftip07BYBT2HVuAb+YDyPLOnnquMSEcPWLJbzk3aNRj5lP44NhecZTAagEDNycC/nYFs8eGoLAnG2dz4se43MKeehdCC2E0L71xW87oguyXzZEwNPXezYMQ1Wlv2QbgIZ6m4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ktAdkB4e4LqCb8zlBboKpQFV54UMna9aGZ41Je5cOvU=;
 b=Ezf7guRJ6bcMH8KTm5beQSVgzlwYzocIG8G7y9uAxLDcMtEF8H8m7YJ+oOecllQLJ5kUEOgv+dGpf1WzbO29eTId1dj/d/5xD8J0f2jn3uCL2QNdI6OWmCeIT370ULxRIs1l/zVmRyw9Ia1pzk52t3OHIraFVNgOTSFL0bvy/dQMMtYvCu6VCIwKa19T0VWYerhqcOX+P9nU/5G+ZPjeKVSD7HzCwzqqecYYKKASFIkXG1WRflPnW9greyCJ6lqAkIQ5G8H5poVXMdICKPG7lR9arKV2gd6hP4fn1YxdktL0ygazcRgV5/82CuTb4bv4tz4UxAQT1Zyksck08IoIrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAXSPRMB0001.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:230::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Mon, 22 Jun
 2026 09:49:21 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 09:49:21 +0000
Message-ID: <7e1c6ebb-d5d4-46d4-9e73-13d2d135ccac@siemens.com>
Date: Mon, 22 Jun 2026 11:49:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v2 2/2] Add crypt library packages for
 Debian sid version
To: Shivanand.Kunijadar@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: Adithya.Balakumar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
 kazuhiro.hayashi.f74@mail.toshiba
References: <20260616050628.3560536-1-Shivanand.Kunijadar@toshiba-tsip.com>
 <20260616050628.3560536-3-Shivanand.Kunijadar@toshiba-tsip.com>
 <32e2d89f-352f-403b-be31-79eb3331d14a@siemens.com>
 <TYWPR01MB11063A0DA32C5961F137E00ABC7EF2@TYWPR01MB11063.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <TYWPR01MB11063A0DA32C5961F137E00ABC7EF2@TYWPR01MB11063.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0220.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAXSPRMB0001:EE_
X-MS-Office365-Filtering-Correlation-Id: 93f38e05-1687-427d-4d74-08ded043891e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|11063799006|56012099006|6133799003|4143699003|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	XwSAKdd7UYEzeNnjLt4/C2Z+Um4BXRGGVgc6TQGSWWbTep/a5Qn+rxD/KTgJLF8oHbd+XdRizbHEsxlt3huDNqGSOtXB3Piv7H+JEGbn5uwgNBolISOBc/Q8+oY+gs+CRyza9nWVSSitzgtzF6+5x7NYZIb/WtRsv9yDO7D2Wl8o/73y/U0jFCblXdy57x2WoQ6F+Z6eehcHBfCLM1jEF0e2EvDeuD8sRwj5TXb6FUC8254T701G1Mp0tIigr/Y6BB2zpN6E1Gej19Jd3AaKU9UdZ6MPKOE9j0myfUmAPNfvqAfLKhvWCzHr76gW4RVANRSoxJ0ju9GJGr++pYSRLrwCL8nT7aO3YCBw4Zavf5gWempI3LEiNWPHs/FozUAAkjAYdhVK2m4Q5FzFBEWWtcJP8VLcbhtkKWi0WLKQRwEAR0X3Ht3lG8LvvnNY/kHJvwFzrDpr3mmOH25x9ALaa5OswXJHX1Aj/6/yOeB/mHekmjaYyfXdcWcAedNxCFyKIEP4kRjnwLv0dFWzxqe6WwWsosKBBRD9XfNmS3oQczAuNuvei0phpZoqeus3xoGMudet6zdjkoIeuJMJ5pHOeUHnH7y7gabsfB4NiLgTX4ISEa7eqWhGki8M+6UxSt5NljeE3QfpshIJ5OIkuGBoD6S8rgTLCuYz0fbyBAMH/c0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(11063799006)(56012099006)(6133799003)(4143699003)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MjNyTmxqSVFiMk1kaUNLU1hPWkZkcGVJa2lrSTFXTGxmUlhmMGVUT3I3NXN0?=
 =?utf-8?B?NlZpUHBqYlNaN2d5azljNDIwckRyQm9mZDJvQnVSQXUyTUd6SFJSeHlPUGZK?=
 =?utf-8?B?RW4vdThraE03Sk5DWTZzdW9vL2NmVEdSTHl4cysrcWhYZndHT3dSQXFlYnNX?=
 =?utf-8?B?bU45MzIwdnpBU2EyTmsweE1xb0hjT2tjTlZiV3ArRlZwbE5lWWhsM21IYUlz?=
 =?utf-8?B?N3ZPa3NSZ0hpd3NUS25PUGJqb2kxZ3dENWI1dXJyWUp3dGhIWG0vdHQ1RjNB?=
 =?utf-8?B?Ulk4aTZLaGttUjJiNWthTythbHlCeGlXaEV0UGtWZHByb1hTRDg3QXY4RG9z?=
 =?utf-8?B?RDZsMFhaZkZldFZIS0FDamJ4OThFdWxTNnloZDNvUERyQllSYTMwQWVmakZC?=
 =?utf-8?B?cG9QbkIwK0FnWUpTN2lrNjFJbDc4OWY1eXQxVEhjSGdQS2k1SENTRzd2Rmlo?=
 =?utf-8?B?MzNiWlpkckc0YThHNFpTbGlHM1lQNXNJY3ZRb1pyU1hXa3FLdnoyUkR2RDNZ?=
 =?utf-8?B?ZGlRc2JFNllBTVhtaWNwVlRmUkhOSk0zK253SGJLQ3FyR3F2TkxPRjZ2SXAx?=
 =?utf-8?B?bDg1WHhLVDZRMHBOaUNwVzJ1WktWMEJtU0o1MzNlYno3U2UvaldWZGtjUUp1?=
 =?utf-8?B?YUdZVXNvNGhGTHhVSU9sV0ZwVkdXWkdyWU9sQnpUK05UY29sT2NlMzhEL1h6?=
 =?utf-8?B?Z0ZWb3NFeHRHQTE0dlY4MXJUS2c2K29KS2hRc2FSSzdKdHFENHRUclRBcVNV?=
 =?utf-8?B?aXYrcm10WERlUDVkQTBVY2JBcWpDU0VnWFo2R2ZNVVp5c0VBU0I0dXJ4VmNk?=
 =?utf-8?B?Rnd1YmxEQjc1WmV3aFlEQXAyY0R5OEUvdGFEajNTMEZOV29DMmRmMXh2MVhS?=
 =?utf-8?B?Z1dodHpHcmJENzFhc2lOUDE2TEk4WklhTUNwdWE3dFpaVkZwRHo3NjlvY3dX?=
 =?utf-8?B?UHo5aWlZYWp5ajFqZ1lWRGRNKzNsZjFHT1VGSzBhWkIxcTZYZFd5RjJCWlhN?=
 =?utf-8?B?c0FSMmlFdTlXUUpTbFB5ZTRLVnl2RVUwbWZqTWkwQktqSnlheC80NzFoSmlY?=
 =?utf-8?B?WXQzUTRDZUNoa3QxQXlZTWdodWFNNlFTOHlkSGpiclpaUkg5a1RvWkd6L3k3?=
 =?utf-8?B?cXZpUjRJWHo5bE1TRXdJY3p1U2JtOG01TUx3RG9vcmJWbmtDWnpFMjJYN2do?=
 =?utf-8?B?R2UvOHZkaG5HVEVzaFNBTjRzc1FLMytPbnB4YUZTV2xXZzV2R2JMcEJxMVJH?=
 =?utf-8?B?ZW9LWTR0TVhjQUgvSDNuTi9QK0pzOU9oSmtGcVRRdDZzbW1DLytVeVRIakVL?=
 =?utf-8?B?dGNPSHVJL3J0Q2FNbEU5U1lvU3FYTkZlVzd4amFycTRYbG90anJRZXlsdEYv?=
 =?utf-8?B?RWNpT25wQ2xpN24xSmV3M2ZxWVBUdzhaWFJMYVNWUGhVK2FoSy9xSklnZlo5?=
 =?utf-8?B?S1RhanN0MmVKNGdLdHlqdjVmVnRzNzVrUkRKVC81MndBSlFzV3VnVUpQNFR2?=
 =?utf-8?B?cXlxQ1pXZjR0d0RaQmVQdVR3UlpYdTBGM0pXeTNvSDZaaEZVMlNaeGdkNGVx?=
 =?utf-8?B?UGYzeUFLVzJGMWlpaXhaSmlyR3R5YUdHYVpEL1dVYVBodWRsZFM5eUlGMkhq?=
 =?utf-8?B?ckxMNkMyZ0l4SEdSNkhFbStZYnNrMTBMZThFQWxLOWhMWlFYc3ptTTZXaVhh?=
 =?utf-8?B?RVgzRWJXUkMvSXVrREYrUXF6MERmbWFjWFdmWFhaWng4OGhVU2lnSVlEaG1i?=
 =?utf-8?B?ZnF0am90bFNGRWx6cnliZ0FzS3NabXdMK3h1M2cvbDN0ZzJzcVRxMkREQVE2?=
 =?utf-8?B?UUR2cnhYQzZ0d0xPMkdtMlE5NlZNM2tQWFMwQVJiK3luSHNSUlk1RjVEaXk3?=
 =?utf-8?B?SXhWUmlQYng3NEZPVjVJRUMydS9TbzlRVkJDUFBycCtjMjRsZXpPa1gyNlR0?=
 =?utf-8?B?cW5UeG15TkFkU3M3S1Q1MVNJRDY3bUprOHl4NlJEUGwxeDZtYzJaendkbTIw?=
 =?utf-8?B?TmhQOFF2NUk4SGcyUjZOb1RCNnlRU2hGNy8xVUM1TXlKM01YVGFqZXlUN3Yx?=
 =?utf-8?B?ZzRzY3c4T2w1aWpBMGwwUTZGM0FOeGl3TVMyb2x1cWZMaDBjd2RXVm0zcnJ6?=
 =?utf-8?B?QTZLd1Uyc2Z3L0oveGFHUWYrU0diUFRFSXg4Ymk5amh3d0UwTGRmUGROcGVC?=
 =?utf-8?B?WW03c05rRDlDb29Yc3VHKzM1dnNsUHFLbGtCVy9HQVhpSGNpRytLbVZDUmIr?=
 =?utf-8?B?b05KU0hwUitEdGJKMDZQT3hiWUU1QjRoWXlBNXErOXowdllFcnhlcExMcWRr?=
 =?utf-8?B?Z2R2MG50aTdWSnRoQlNtd05USktPRFZPTDVFc2pJdHBaRWJoTzFtSTArZG9h?=
 =?utf-8?Q?isPk+xdLvUaB++pg=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93f38e05-1687-427d-4d74-08ded043891e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 09:49:21.6893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zdeSxx/rUOkwC979IvzzPQgsn3vXo777UTylBgGhn9M0ASYwjH/RTGhhiq9lzGt7l1ojbKaSfGKIMIG/a3VMIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXSPRMB0001
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 22 Jun 2026 09:49:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23246

On 22.06.26 11:19, Shivanand.Kunijadar@toshiba-tsip.com wrote:
> Hi Jan, 
> 
> Thanks for the comment, 
> 
>> Please align indention here so that it is easier to see that package lists are identical between trixie and sid (right now).
> 
> Does this mean just add some space characters after sid to align with package list with trixie like below, 
> 
> DEBIAN_DEPENDS:append:trixie = ", libtss2-esys-3.0.2-0t64, libtss2-rc0t64, libtss2-mu-4.0.1-0t64"
> DEBIAN_DEPENDS:append:sid     = ", libtss2-esys-3.0.2-0t64, libtss2-rc0t64, libtss2-mu-4.0.1-0t64"
> 
> If yes, will update the same in the next patch series. 

Yes - but one space less than above :D

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center


Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00515C71131
	for <webhook@archiver.kernel.org>; Wed, 11 Jun 2025 14:53:21 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.41])
 by mx.groups.io with SMTP id smtpd.web10.129.1749653598844361624
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Jun 2025 07:53:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=K1Q+ORDE;
 spf=pass (domain: siemens.com, ip: 52.101.84.41, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oy0NggGW6+MRpbxiojdwrE/lJVcjH0lM23Oz2VCI4QxCXxONfBG6zZdgo+QjPYxw36z2x262GXklCseRLBw54SwCnatlxitxBwz6HEUDMFOtNW5h8jDscim+S+Knla9OQuWvecXdT7k1sMWyYxBZieNHb+gOZLy6EqwlNNMg9fLDRNUtkGPqh0pKagVsFOFlyMf3dqRhxDtQh/DkWVxuzivEkkaRtMsC9A4TU9KLWhg6YekurOXH1zrORScqxuUhLCGN86CeP9pceBmoTkssg+/unGkk73SyLcxJObqVYNJdxdVycmeRBN7n9QXH8ADTiHwdp3022La3o4TqcamBBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rU5MS2G076rHmlnD7osoO0n/qi7poyaHfVgv1ewCWmg=;
 b=jOfNsWDrcG50lbfS0svecuaLATUBWIvKiUxrGZyGlKF2ewZ4o8Pe0zXLiYbWKpuQbTlFQ9JwGbXqBVVd59JbmZx4+7dLjLYLBaxwym+YOEmY+NZF39doVvVNraWpK5763y9gr6NHtCkthlvBeZG/p3P259+oMgaTXoMYo/7x3G3UF/oLe1VUsxV8aJwA7DdH1/UIywQlIScfDlpQCEaoLjky/syzVR9m4sXHi099NmiQRHN6zebXJLsQWv7HGAgSpncwmDS7Bd5wglevsS/kg06GRrAi1thmg16ZgnSxg35UDo0B48cu4NGUkfKfqEwfssQYWYeoTQmg/LSXu/zVfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rU5MS2G076rHmlnD7osoO0n/qi7poyaHfVgv1ewCWmg=;
 b=K1Q+ORDEEbCNbPkNsepM1GXXbGgRicnQhBGWkgb7jRDF5gxo5f/hJ1jFnadah7BCLkiUhB86lGBq5mTfcfVhd+uTKgo6HVdXlllSxqd/8DOX5v6mFSpW9/S/91GOGGloLunyPZkpC7mbI/Xy2wpcke5RU1SCee5OO94pnIL80UYpXBgN5isCLwrY+lxNcJiVXFGCOUwtKf/0VI1SUC6cO+6dVa7QFR0QuKTUrobhrvyaMPAwVOoF/YSbBibuR7bqqNpY0Qt1ZikIVUn0xIHGUDtiwfZ4JbEY2XdFPitib3riSW57trDgdmP8S9HjLSKTT2sRhs5q+ZVOf7eOmSSDXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA1PR10MB8329.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:450::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.26; Wed, 11 Jun
 2025 14:53:16 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8813.024; Wed, 11 Jun 2025
 14:53:16 +0000
Message-ID: <83bd22ed-43ae-4497-8f8b-85f5d20fc6c6@siemens.com>
Date: Wed, 11 Jun 2025 16:53:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH] fix: overlay-hook: add missing
 dependency to e2fsprogs
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20250611132331.175158-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250611132331.175158-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0012.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA1PR10MB8329:EE_
X-MS-Office365-Filtering-Correlation-Id: 58aa151e-3e0f-42a4-1df6-08dda8f7b268
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?elcwNkVuRjFhWnRCSEVkWHdFV3pLOTdYYkszTUZGcWpOWHlKSXZDRkViRWlV?=
 =?utf-8?B?alRJSENpRmozWmhGTEExOWNuTmFDTmFKT0toeXdMUzNQb3J4ZUdPZDJtU3pj?=
 =?utf-8?B?eXdlUW1VWi9vd1NybWp0UWNCYjZjWTV0VURPMWJhSk9FUU1QeGhVMEN0blAz?=
 =?utf-8?B?Ky9kalR1U0liWnROZW1KcXp2ZXB5cUFIZzBicWFQOFF6SUlkanArUDlDRGFp?=
 =?utf-8?B?MVNwZkU4SDU0clkvTmFTK1VmUERmajJEYmlsRVBEeEF1UlA3VnVaK3J5cUl0?=
 =?utf-8?B?SlFzTjZGODFjblYxTVNXT1VDc1A3VDc5cWlsUi9kbDd0N0pWWUNiVDRHQkdy?=
 =?utf-8?B?cVpyWWNlUDIvWTFOQUNLY3V4Sk9FYkFZOG10ZCtua0NEVjN5a3VlQkJWUzRq?=
 =?utf-8?B?VUs3czNrUkJjcTNqcDVKZWRlUG5YQWtIYjlwT2hURzYweVhsc3diY2lEb3Za?=
 =?utf-8?B?SDVyV3VPaGVPY253dWh1eDByWE80U1diSVNDS0JSTGxqWCtrV0duZzgzOFJX?=
 =?utf-8?B?ZzFhVWhDSExFQnBKUHZYNklDN0d6NnZ5b2ZUcVphejVGVmE0VlpwbXo2OE4x?=
 =?utf-8?B?dW9kbjlqVFgvYldCN2lLVkl5bGxoSGhyU0pocE13V3JsZjJRRnJ0QXZkUE9r?=
 =?utf-8?B?dVVQMXFjV1d3aWFYSXl6K01sYkcxdkNqQVpDYi9OT0Z6QWVIYkdUbzh2ZFFX?=
 =?utf-8?B?eE4wcVE5UURqOVg4amNERU9kYllnYkpVYlYzQ1lyZ2RFbnJNaTdiOGQybnVz?=
 =?utf-8?B?NG5saUxjYTNyMVdLTXhicVRjR1k0YXpsVGhaMjJNRk5lYk9MNCt2U2I1QUxu?=
 =?utf-8?B?a2dNVWQ4Z21GdSt1K1Y0VisxcUlDUERTOFJNMmZ0bE9KNTBnRVZ5ZDVVdVRE?=
 =?utf-8?B?aW1MbXBISFA1aWcxaUgxVnZHMk9yQWFBR2YreU5Lb3BLZ0FUeWJhSERyMUgx?=
 =?utf-8?B?dmtkeEx3M0NCOUNtYkplT3AweWJsdHJGdmNHbjlJR1lVb3I5QzZMMkdNZ3gx?=
 =?utf-8?B?ckw1OGFPVDY3WXpzVnRsRzdNeTVEc2F0QVNHYUl6QW1lWWVkTzZKb3BiZmgv?=
 =?utf-8?B?VXh6UEVEeS9oeFNxKzA3MjBBc3E1WTNsM2dLNjl0R3pmeCtvR2FoL0t6bzY1?=
 =?utf-8?B?NUFMNmw1MkVXTE9CaCtkajZNOWtoLzArUEZaaFhVL1h0Vjd5cExzcWVNMS9H?=
 =?utf-8?B?Q3BBTldUZVR5bU1sUWQySW1QZzVXaHl4bmg4Uzdxa1hHSDZRNnVPK1VMT0ly?=
 =?utf-8?B?ZHQxRFVYVllKc3I3MCtBZWp2SDZ4bDBMT1hqbmpseG15OHNlVEw2U1hlMys5?=
 =?utf-8?B?NTMybjROSi9uNU9vME40d0ZTcUhXeEVOYnB6cXZuUWNucGZvdWFzb1c3VlRV?=
 =?utf-8?B?WU9reGdNWnAwT2Q0OXhVNHZCTXhic0xjbkMwQ3c0NzBEVkh1VFFCbThUSmtK?=
 =?utf-8?B?Snd3c1dnMnl3OXhoaXFsRyt0R1BPMGFKdXJCclc5RVg2a0M4TnhFdlA0bDN2?=
 =?utf-8?B?TkIzbTE0aUJPL0Rudk9hZTlXSHJJdjIyTTVwbGtrYVhpWXYvd2ZhTWx0M040?=
 =?utf-8?B?YVQxcnRjUng5dzFRbzlPOHk0eWhza0RhZ21WMWJPaVJjYnVXWmxIVnc3NHRQ?=
 =?utf-8?B?VHdhc1lyVENMUnA3aUZMSmZlaUo2V3hHSWRlMEx6R3RHblRYNUpJQjdkUGNW?=
 =?utf-8?B?MEJrOWFZM2g4S1lxd0l2WklVcDllc1BYUGF0YkVvN1l0dlREMTRvWi9mNGJK?=
 =?utf-8?B?VmVRRktjNFMzbnNjWHQrdG8xckhlYmlsb3plNXZGcHhCT1Y1cDhsNmd5dVdO?=
 =?utf-8?B?L0pOb1dhRUoydE5JZ3JkQ3ZwMHpadXBoNTY4cmRLREJpWCs3ZVRNUEVHeEFB?=
 =?utf-8?B?U3UwZUVEVEdvbWdxSE5iSzEzeHpJNHBmZDJ4VXRpOXZTUGlvTzF4aVU5U1Fk?=
 =?utf-8?Q?mbtom86tfps=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QkxSWjdIQmx6SnJ2M1VFN1duKzd3SzV1UWllK2RmVDJ0L1BEc1p3SjRDV1hV?=
 =?utf-8?B?enRMam1FZ1VzMGVYampwRW92V28xQy9OcDNWdnJCa25oM2Z5QThWTEY3QlFN?=
 =?utf-8?B?QS9qS2xKQktHU2J4Z1dSbDlwSjFhZXhST2tTREJ1R1dhT2xTbDdpNGhpank5?=
 =?utf-8?B?Y0pNUWVjcDRHUzBGVXpmaE9aNFcyMVl4RnRITkoraG5ycjNvbS8zaGRhcUdu?=
 =?utf-8?B?dzBaTjVOVEVJVm1GWFAwa2w2dTNDOCt5TlMwKzY3ZW9lcVNvUVk0bUd4Rk41?=
 =?utf-8?B?dm1IeTUzNEUzbjNBRWtGUkZKL2JiRkVCZHFHUU9EMFZJN1NVTXhQUGYrRUNF?=
 =?utf-8?B?Y05lTW9qcS9Hc1lnenJBSndLbFpnMkl1NUhSWEVEbnVUS3c4TGNxRFZFYWcx?=
 =?utf-8?B?S0Uyb0d5dEZUTG5qclhoWEJGNkk5aDUxVUVrZVZFR0N3ZkloRS90Z2hmek94?=
 =?utf-8?B?NTFueGxwYldFVmY0c3ZNZDRnbU1CRUZtRURxWjVqM3owaGpqWnJZVThBcnVI?=
 =?utf-8?B?a2NZVEQ2QnhrN1g1RVVNbjVXWWczVG81TjJCY0tURTlyQkNvMURzOGk1V2hO?=
 =?utf-8?B?dWwwRTcySHNndkFaSjRWZ2M5RFlKNk13LzBWVFRPR0NCUHE0WE1ST2xYR0lR?=
 =?utf-8?B?TFZTRjJYM29hWXhjUzlFY1g2Qm0zVTJiSnRIZXNJdFAyZjFHQVl6MTRjVjQ1?=
 =?utf-8?B?V0RrQVJaNURYQUlMVmhrWDlHQWxIMm1qbzNOMDhFaVFlM2xFNjdMWm1OUXp5?=
 =?utf-8?B?LzYzM3BtZXJveVgyajBQNGZnLzkyZ1lwZXVwMFBMdXhmdjBLQU15cTlnZzU5?=
 =?utf-8?B?RVZKTkNBRDQ4amF0UFBPNDRxaVY0WUZtZ2FrS0RQYi8zWFc5Vlp0NjdhZ3l5?=
 =?utf-8?B?bmdxUDhjelhpUGpvaWdtZ0hQczMvQzREcW4xRFpwTnJwQUo2dTFVeCttMVhW?=
 =?utf-8?B?c09YZWhQVmlFaGJKeGNwYnJkYUQvWVNlU3N1RWh2U2tPR3ljWGh3azBlbjlv?=
 =?utf-8?B?RjBFZk56VExjeVVxdXlIOHlBOUdOZTZiNXN6NkZSeVhXNDdnSmhGaENTRDJv?=
 =?utf-8?B?MjVzbW9UZTY2Nyt4SnVYOXFZeFV0WjExRUN0WWE5VHRxZkFOY1RMNUJmUkVD?=
 =?utf-8?B?VmUvWW5UR1BnQjY2bUV6cFk5ai9naUVhSjBBM2ovU1A2Mm41ZFB4Z214OEh3?=
 =?utf-8?B?b0QyOS9YV0l0UFBtdlRVd1AyalpUZlZjN2JGN0cyRGMxMDhnUlVzVlFpSzRo?=
 =?utf-8?B?UCtzWnZPY3NTT05oY2EzZzBLQzJ6RHFCaWtWc3FobEpXOThReE54NHRWOWJi?=
 =?utf-8?B?Zmp2Y2tibU5mREpvK1RUUE42UE5jcHlacUdxVGlKOFAyM0prcFkybm45OG1n?=
 =?utf-8?B?OVVXZ3Iyd24vTkpZb0czYjdFZDZLTTlJOWU1UlBSa1JzUzNPOU5TS1B5VThr?=
 =?utf-8?B?aGVXemlKc0JOZjJJMVJXdHNXWDJmZFdPUEI0a0YxbzJSRGdsaVNoek05Vm44?=
 =?utf-8?B?aDA0d3NoanRZK3VYcjBxZ2xFem9jUldTbTZDck5pcnZqNUhwTEtoMVlGL3JV?=
 =?utf-8?B?WnorV0pySGVLMEdac3JwYTF1ZGVxNWRGZXI1dlFDdkdWcmFtSHF4a3NGYXhH?=
 =?utf-8?B?aXBGMXo2YXZIc2Zic3NURkxEL3dCTlNoUHdkR0NrT01EZk9NM0ZLb29saHd5?=
 =?utf-8?B?Y0czRk9sVE9ZY3hKT0haZVE0ZURCRU16KzBzY2JwUUhlMHdwS1NRZWRHU3lV?=
 =?utf-8?B?Uk10V0crZy9iM29LdDRDeHF4NTdncU5jUytYeE9HMm85WDVTUlZ0bW5YTnlW?=
 =?utf-8?B?ZmRKa09vNFVqNVJra1I0SHorVnhuTnc1NmZzczJHZnFxU3pJbXVtbzQrZDRi?=
 =?utf-8?B?M1k3RlJsZE0zcWdwTVJ0eS9GQXJJRW1QcFh1c1VqNTVrbGhML1g1QmE3a1Q4?=
 =?utf-8?B?OXhObzU1ODFMOUlYMlBNSHh3NXhiV3N1ZEI5eVZQRXEzd212Y2ZjRkNEUUJN?=
 =?utf-8?B?bnRNTFRyVWZQVkMxSi9MRVIvRGJ6OGJ4clhITU5ObTVyQkxzNWczaHhkRUJ1?=
 =?utf-8?B?Vy9MMzM5Sk5TR0NhcEVkcUxMejNrYmJpckM1cEsrQkpNeE9WRk8yZVJqL3Bi?=
 =?utf-8?B?YlJQSlpPWGRaVytta3hQalhYejZGSFFIYzViOUFnbUI2ZVRXemVEcmE3M3VB?=
 =?utf-8?B?R3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58aa151e-3e0f-42a4-1df6-08dda8f7b268
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 14:53:16.1123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 28HYkchljbnwfLPahQappRsPoH0WMD7XRTm4fHUscHZTYYDbP4u36h1oaUOsYHkqeXtYUcAV2GBY1Z/jjmbQ7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8329
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Jun 2025 14:53:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19029

On 11.06.25 15:23, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> The overlay-hook uses the e2fsck and mke2fs but has no
> dependency to e2fsprogs.
> 
> This failed the qemu-riscv64 build.

Not tested so far, or did trixie refactor some packages / dependencies?

Should then likely also carry a "Fixes:" for 8644fb16dbc4.

Jan

> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  .../initramfs-overlay-hook/initramfs-overlay-hook_0.3.bb        | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.3.bb b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.3.bb
> index ec7f85b..a5b39d9 100644
> --- a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.3.bb
> +++ b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.3.bb
> @@ -42,7 +42,7 @@ TEMPLATE_VARS += " INITRAMFS_OVERLAY_STORAGE_PATH \
>      INITRAMFS_OVERLAY_MOUNT_OPTION \
>      INITRAMFS_OVERLAY_RECOVERY_SCRIPT"
>  
> -DEBIAN_DEPENDS .= ", awk, coreutils, util-linux"
> +DEBIAN_DEPENDS .= ", awk, coreutils, util-linux, e2fsprogs"
>  
>  HOOK_ADD_MODULES = "overlay"
>  HOOK_COPY_EXECS = "mountpoint awk e2fsck mke2fs"

-- 
Siemens AG, Foundational Technologies
Linux Expert Center


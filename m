Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E65D2C678DC
	for <webhook@archiver.kernel.org>; Wed, 11 Jun 2025 15:01:20 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.30])
 by mx.groups.io with SMTP id smtpd.web10.334.1749654079088901696
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Jun 2025 08:01:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=YIR5jt30;
 spf=pass (domain: siemens.com, ip: 40.107.159.30, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aWRaRmLEtkuzs2TnDbNtuozXpHePIU6wkbj9Ilfmbr95M/rNW2cdqiHWn4twPpyCT/gVf9FuM7xgoXlKlOo3OCq30Wuwau7qPKePyD3JrJJZobbMEGZ5A4JbNQdr9ZRrnpwDc+sgTO2+MY0xvLkVINJSwFb0SY7IOgxumH7Gy6dCJcAxpP+GWVUJwsx4BlGZVKVo8U5Aae6s0T/DnnXbE9HUkV1bSCvWaBPgXEPWTuhLL6kJV3I6rGUwAYyUmVkN8k7ntZvc+L2OD/2MZ6D0fTO4oD/TOXHdy8qcTrUul22nQ2BaKmovLhECg46v+zijd4pyIo619r0OViIqmIwUfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VHdkiZoCKT9tjzw7+yIPCoA2uvvfEE1toWzQVUzicFo=;
 b=gQOxb76r5I43nJ6P0ZCeFgt1sOuRklEJkwv/DXyowM1J9pq1R/nj905yFJ5NhXArocpFt3n0A2/JKNQXNO6TSpi96Y5wlVsmkzXM400yqRj2NInPy7Sx1rjNkDKMNmm6ugs0GA4oBiLteqVtrG7nwLtY0KuFvaMWpikRKGchMJIbDb1n/QorKtjwVaUbNejeiibZ5v20aanKUUeAs4phjLf+tgoI60DSRSB0HLKoMvU/38eUyrgSwBhZrFCsuTPheqBpHH483ZOv3KdHPsNXXvHUYJ12TQpJVb5GmzS/hrQzutpAZZe7sm6liJgfSiTUMvY8jYJSko2GVcqUnJ+Ywg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VHdkiZoCKT9tjzw7+yIPCoA2uvvfEE1toWzQVUzicFo=;
 b=YIR5jt30jgu7/lZn2vfQ7CtvnYJChgo7OFgwUk25ArchDEa9yFZ0SLIqb8qQM1SDPUSHLeAi3zzINeOUS14KnbYueX0buoT0BXAiJKus2LjYvI25XUX0xfgBGMBT222LYDXra21Cgw1DOWqGqEPhmSdLJtBwK4B6c06X9Y3g6OAO53euUYjENF8+e/t7ivu0Q72OtnsmPW4Nrcrklv3Cq94ol6NCzt41m+vQXlQq96bVzpnPmfiPm+opK0QxvbV3AgbIu5o5fuglFGjv6zSJYJy17o3MeLTkKWPdalGqxIkU0Lrgw0bpyxVFlxF8v/5Y5NjU6ZY4T9pOzqtJZODwFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by AM8PR10MB4002.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1e7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Wed, 11 Jun
 2025 15:01:15 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%7]) with mapi id 15.20.8835.018; Wed, 11 Jun 2025
 15:01:15 +0000
Message-ID: <fbdc861a-eb76-4c40-a186-6647c8b955e7@siemens.com>
Date: Wed, 11 Jun 2025 17:01:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH] fix: overlay-hook: add missing
 dependency to e2fsprogs
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
References: <20250611132331.175158-1-Quirin.Gylstorff@siemens.com>
 <83bd22ed-43ae-4497-8f8b-85f5d20fc6c6@siemens.com>
Content-Language: en-US
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
In-Reply-To: <83bd22ed-43ae-4497-8f8b-85f5d20fc6c6@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0120.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::8) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|AM8PR10MB4002:EE_
X-MS-Office365-Filtering-Correlation-Id: fe01b39b-1c21-4714-4e01-08dda8f8d042
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?UjBQRDB3aUtsSk1vQkowOHVFM1B0WDJyTkxLUEVxTjdDd2FLNks2TmRYUVA0?=
 =?utf-8?B?eWtmMjZwYVpzajMxQU82UkZIUWZibEhNa0NlbzVNeUJ5c1d4UTVZTS9aWmIx?=
 =?utf-8?B?RlhYVSthVkw5T1o0ZENESkc0eTFXRkJsUlBwbWJ6bTdCR1VMM1RZSmVUbkJq?=
 =?utf-8?B?eW9IdHJ2THNaRFl0dnp1YVRxOU9pYktHeDlSdFhxQzJiWklEOUZ0L1hhME9B?=
 =?utf-8?B?VTlndEtFZWJxWGZndG9ub2xzTWZuTVJWWjRQTmRFQ0FFTzZDVE81UGpXT2Ry?=
 =?utf-8?B?WE9nVnVkZFQvZGhheWFVRnBkYTM4TlFKQ0h3aUVZMVZxUnVjRk9Jemhvdjhs?=
 =?utf-8?B?UkdTOEhOTWhCNmZPOHc3cGNtZTZrUVJJVFdpMGdidXNWRldmSlUrME1ia0gz?=
 =?utf-8?B?QTJoeXk4ejFJbEMzOFVSdVlkVm96SEMyUkozZ3pFOU90NVl1Rnd0UUxDUDht?=
 =?utf-8?B?SnBZSmpKOHprWmlHQTI1Q29VNC91SnY5OTNhUzM1ZmxRTUJMNkl1R1BTVC9N?=
 =?utf-8?B?UjlBdkJpeXlBQUllcTl0YnptZU5uL2JNNktieDBVSGZlS3ErWUsxOExpUjAw?=
 =?utf-8?B?TlZsR2IrbExPbTBvbjFZY2RJRW1wY0gzd29hWkpBYlp6ZmtVeGMvbFZGOVdu?=
 =?utf-8?B?YVdqL1RZNU9nR3FxOUhCOC9UUkhaMlJDYzRkQjM0S3o4TTUxNmdBQlhQdHlq?=
 =?utf-8?B?OTJFY1NXTVdObUlBK0lmc2VROWFyTmhEMzFLcTE3OVAxOHRJMU5ySlNwNTRm?=
 =?utf-8?B?VTRrZkxMdk9ScWNxNVZSR3ZicUVLQ290dGs5L1pVVWMwcEU2ZGhUY0EwUC8z?=
 =?utf-8?B?NFkxdmdxbngxZENhYWRuY3hyWVkrK2V0QlgvMExNNkNoZ2xTa0hDWWtCK0hC?=
 =?utf-8?B?TzY5amgxM2ZkS0FDVG1TQ1dsS2JDbUkrZUFKN0FzK3p1YjdvMkxvQ2FnNk1o?=
 =?utf-8?B?N3F2Q1lyZ2ZCaHB5SU9SaE5UczlFNmx3VEdmQmhzdFY5eGFFdnZhYmUrZktz?=
 =?utf-8?B?QlNzY01IQUhlbEFqRjNmbHVkT2hVR25odDM2R1hoUytCcDc0TFdHNldZMW5O?=
 =?utf-8?B?YjVnK3h3TVlDaEVqdjJhem54R013WGNYZnoxWDRoaXlZckk3Tzh4UzlCaWxU?=
 =?utf-8?B?dGY1dFgwL09qdjdIWFd1dWhEdHNDOVZCcCtBaElta3RnME1XWGtUWFRFU25F?=
 =?utf-8?B?NFcrU3JqM0Vjdy9PTTZoOGI2dkVwSHYzVVErcHl4L0pjU2NyN1k4dnNJTHhP?=
 =?utf-8?B?NUN1TjNKcVp2NE9vcVpLWXpqeEFOT2lRM3NBWHJXdUtzYll5RnlJMjJsTlVF?=
 =?utf-8?B?T2lpZi8vU0JxRnl0ZU1JVmczRnJJK09RTERHRnZSeUp0ZlhIWXBLT0tNTklR?=
 =?utf-8?B?ZXhMUmRpYk0xSUhRbnJqdXBTVkJkTXZyUmdsbXZwNWNKdVZscE1rbDkrdnZn?=
 =?utf-8?B?OGpQMWljeG5MdGpNVVpJYjVYbnlCQ0pDM3kwVkdLeTNRQkdabXRjanAwSi94?=
 =?utf-8?B?djdudWtZd2F6SVZ5SmZFUmhJdllDRmhvdnM2eXptWTZoRHpjdDhISEt2TGdH?=
 =?utf-8?B?OER0aGZuZ25MZk5kbWhRZSt0WmxtRi9HOFRKVVl4Y01WWDNkUVZlbEU4cVFh?=
 =?utf-8?B?YWRHbUY5VWdDcHExVlhBc2R5aEVScHhza0h6VnF5RXRNTHlGcEJHMlIxRXp5?=
 =?utf-8?B?aTZycnRmUW9xYkZsMlV0WU41SWpybWxTZEtqUVdzYVNYNjA3V1lxWU1URml3?=
 =?utf-8?B?RGVqQy9EQmZxdHF6SHRzK3ZQNGJpdkZvRUg5bkNsQkx3RlQrazhUUzIzV0VL?=
 =?utf-8?B?azZ2VjhCRkszNnBSSXNzZEpwQjlIV1JnT0EzUFNFQmJDcHZkTXdHYzJ6dXpi?=
 =?utf-8?B?cDJiaVZhNlJodyt2YmhLY1loQThoRWVmN0dPSDdPSkJtaW5pNkFJNmpubU8z?=
 =?utf-8?Q?T00bTqE/M+Y=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?c2FONFYrNTJLZnJVZHhTRmVKQ0dHRVF1WTJ3bXFJTzdOVTM5MUxsS0ZPTDND?=
 =?utf-8?B?K0ZjOUFNZTljeS9lYXkwN3daLzNkN0VreU9GQXJTRVkwb2JQQTJUSkl5UWl0?=
 =?utf-8?B?emhkdDZvTGtvTjZZcWFIMk5Sa2FjUkVacUVxSWJleXBGejR3RXBFcFhtaXBR?=
 =?utf-8?B?VTJCKy9MMXVDYWRPTitFeCtRaTVuWlZ3aDFmOHh0QXZDY2IveVhpcFhFZk9U?=
 =?utf-8?B?WFYyTGxFSE9ZcndMdUJ3OEd6a3VmR3R0cHd6QTE3QWlRRFI4ZTNnOXpoRE0z?=
 =?utf-8?B?a2RNb0RVL3pPa2JXN2lZMG5yQjNKVFVTck03SHQ3ai9vdkhvQnZEY0dBblVo?=
 =?utf-8?B?eG5nckZJMWFXZUY4OHlRV3JWNlArQXlSeWNvTEtYZDU3ZDUxWHZrUUVMODA0?=
 =?utf-8?B?L3RrZE5mV2Z6NlEwN08vOVFoZGNFbXV4WTRSVTBTSjZYWmtCWkRmNjVWeFh4?=
 =?utf-8?B?M1Y3a2pMZkJCaTd1Mng4cVZsaFlzN3ZabVhSdUZuZ29FaVVuZTloOVdjcEQw?=
 =?utf-8?B?aU45cGZ2VU5zRDY0YWlFRUl2dElRU3RsVVR4N09HMXlzT1c0dzRab0tvV2hL?=
 =?utf-8?B?eGFIZklCN29DT3FCRkxCZXdPd0J3OThaOFVxSnV0azREajQ0bjA0QnNQVmVT?=
 =?utf-8?B?ekttSzJWZlRXT25TektvRWtFMzEybWxEZUZBR2Q4YUZ5OUtsQ1l5RkpNSFdL?=
 =?utf-8?B?ck5SY01ybzJ3VVR0VlBVengzcDNhNWFHU1ZDTXJoc2U5V2lOeDRRQzVZVFR0?=
 =?utf-8?B?RkZ5K3ZBSlZTbjdiN3lMMW1GRnpaaHJYN01Oc2VDUVNjUmFySmdacDZjN2Vp?=
 =?utf-8?B?eDRzL2lyZlVGVi9pL1lXMkNkdXY2SkNTWStGV0k3OE9zUlA4NWY2UEdGa211?=
 =?utf-8?B?elNXQ2V0RG1Xd3FyeUluWVZUeERpS1RMMTJKaVZOYWIxNDB2SndsUVZrb00r?=
 =?utf-8?B?M2l2NTNySmJLTkgwUkJWbTdyK2c2c3RMMnh3V0V3d05EUEtOUHpMRUxVNWQw?=
 =?utf-8?B?L1laMEx2SXM2c0NNMSsybHc2aWdYVFBMTEhYRUFzUlZZWGpSUzhoeEY1N29F?=
 =?utf-8?B?YWkyNkN4REJKMi95NHFHVXQ0UzJjUC9WZXk2QmVSa0pHRVl4bmxvREZoOFp4?=
 =?utf-8?B?aUpsM016RTJiR3kvbEJBcS9QeHE3OHlBM0g5cjZVVnB3RS8veXdPRDRTYWtY?=
 =?utf-8?B?SW9acEV3OG1obTByMkhQcXZHeUU1WnhNWGRCOTJWQmt1NTJtRkFycU9wU2hj?=
 =?utf-8?B?SW8waW81V203Mk1xN0tPQWNpZDhKdTdTWXdtYnl1ZTBoR1RVZzFxM2sxM05S?=
 =?utf-8?B?VGVzYS9Dd29udWtvazVYeHJpRHk5YnNzR3pkY1NHcnBZMk1KWmcvZUxHK2U3?=
 =?utf-8?B?ekhYMkVvV3dKdElHTVpQbnk2dlA2ajJiMGZQYzV1Uks5bVNSY2JuRHJmR2RJ?=
 =?utf-8?B?WjhKWHk5K1Y0eDZXWWwvdTRTaUcvcG5JRFZXNlF5V1BXekNNMjZ0MDQrcFIw?=
 =?utf-8?B?VG9uNFRmR2ZMb1JlUkNiRnpMMGhaQ1pUYTliZmR6Z0dUR1B1Z2lwbmQxdE5l?=
 =?utf-8?B?dW1MRDEveDVpTVMvYXQyYk1WS0I3V0hqQUFUWGNCbkJ2a3hHRkpVeWVSQ204?=
 =?utf-8?B?cTVhVkFUaEdLTG01R2puSFhGc0hFS29ta2ZsQitjQnBHK2hGL2dQV2ozSWph?=
 =?utf-8?B?dDFhV3ZWbnFqMVNLQmpNR0w2dHFWaFUrSTl2RlhvNW9lT2xKT1dmT1FHajEr?=
 =?utf-8?B?bmRqc0dRcW5VNTQrelNta05ZMlREVUN2MlhjbEV5aXRFZDMwMzJwcFJyNTlK?=
 =?utf-8?B?WXhvQ1I1SGVZay9UREpOelFhRWFNME1VZFhiczQrR3VUeDlGV0VDaTVhejlN?=
 =?utf-8?B?L050UjBmcUlnL3NWZHVnSkxUWGk1ZDNnU1Z5R1B3S3pxYnlJenZiOWFLbU5v?=
 =?utf-8?B?a1ZLOXYrMlhBU1dTdllKb0ZObmhuSko0TWx3TzV6aXJXY2NFWXZLNkE1TEtK?=
 =?utf-8?B?YlBNM0NPRGJnbVVMeUxscmNoY3k2QXhHNzcvUXJHU2tXQzE5SEN3NTFrb1Er?=
 =?utf-8?B?WjBGdDJ2WklFNGhVZFZ3OG1oMGtkSmFuVGlxTC9qSzMzaTg2d29CY3V2emtD?=
 =?utf-8?B?bjF2cG1sMzhMVmpPWUF4anJKd0NlbjFGU0lJU1J5VHUwWkt2TXBrV1NCckVu?=
 =?utf-8?B?SFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe01b39b-1c21-4714-4e01-08dda8f8d042
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 15:01:15.7807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I3cj/chj7UIGNZV2zlevvoG4ymTx6JRVnuC22g+nh40PDWtdwYMfyta2aXdPJcn0eB7xWI/AY00iwQeXLugjWnzTRJ/mSWT7Un2FDwODDVY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4002
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Jun 2025 15:01:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19032



On 6/11/25 16:53, Jan Kiszka wrote:
> On 11.06.25 15:23, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> The overlay-hook uses the e2fsck and mke2fs but has no
>> dependency to e2fsprogs.
>>
>> This failed the qemu-riscv64 build.
> 
> Not tested so far, or did trixie refactor some packages / dependencies?

Could be that some tooling was removed as the initramfs-tools in trixie 
use dracut-install to copy the binaries to the initrd, see [1].
> 
> Should then likely also carry a "Fixes:" for 8644fb16dbc4.
>
I will send a v2.


Quirin

[1]: 
https://salsa.debian.org/kernel-team/initramfs-tools/-/blob/debian/latest/hook-functions?ref_type=heads#L127.


> Jan
> 
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   .../initramfs-overlay-hook/initramfs-overlay-hook_0.3.bb        | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.3.bb b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.3.bb
>> index ec7f85b..a5b39d9 100644
>> --- a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.3.bb
>> +++ b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.3.bb
>> @@ -42,7 +42,7 @@ TEMPLATE_VARS += " INITRAMFS_OVERLAY_STORAGE_PATH \
>>       INITRAMFS_OVERLAY_MOUNT_OPTION \
>>       INITRAMFS_OVERLAY_RECOVERY_SCRIPT"
>>   
>> -DEBIAN_DEPENDS .= ", awk, coreutils, util-linux"
>> +DEBIAN_DEPENDS .= ", awk, coreutils, util-linux, e2fsprogs"
>>   
>>   HOOK_ADD_MODULES = "overlay"
>>   HOOK_COPY_EXECS = "mountpoint awk e2fsck mke2fs"
> 



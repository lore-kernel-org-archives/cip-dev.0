Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D2E0C021A4
	for <webhook@archiver.kernel.org>; Fri, 14 Feb 2025 12:38:59 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.53])
 by mx.groups.io with SMTP id smtpd.web11.20049.1739536735333694676
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Feb 2025 04:38:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=jf1eKjDm;
 spf=pass (domain: siemens.com, ip: 40.107.159.53, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u4BAGHJuKghP3OoXGyeUKJuPmaVqZFkPB9+ArZ5JxcWudLnHx7tucVjSR92kn7OBrCDAxK6R2QBFZKg/AHPZ7DbTkpM8xQzWie9ORy41K1cfPwdM5kwPqXlKB3+IsyKHZwFQMAH2zyFRUGOKibXXwHjmUpfJEZAKT4l9kyiSVWpGM9bKYSGcb/bzfWH4CTHYGKkY4s14uMucwI7oduZAoBC1xzC8Hcw4H1nHQFcv/8wnk4z3GHLnqmb6nvkDh77uST+lcSchON0ErWhFeI8bul/LdmuMSvCAoB5LHnM6Zk1tFDsdcbr2AD7BdoTTyQZHXeSbpabfRCwijCWwJqijbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BY4j5v8KDkVctph0PVaZdyg8z/x7QhM8egrpQIqFBiI=;
 b=TLgHKKY/SZBzkkQZcFK2F+U3dDzg1/qm4DEJLAl5sKTDg9rnFHcludCiMrUtFXnyRkxj6Cov6KBEbLw8Q6pF0sMjF74B/uAbSYbzWW4DY/Ymfyg/xcMCjEGl0d6jRhBKBo7l6Q810ujINisnXvRVwSFzkQbeLADr/dOLiVGZ7ctbEgaICo79V0QrStoUc5eH3kwEtOOSqKaYaLisqE7aFSdrPWyubUztvYLPM7RJFRhyj3fDITT7hNTCRdLx5Pgf7gWvVB1dRF7n7yrqG+CUFBRpkBP9avfLZJalhoQxwp4D++wTcYMFbSnlBYBh0bauORecwX8Gv6ehkjwKrsYudg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BY4j5v8KDkVctph0PVaZdyg8z/x7QhM8egrpQIqFBiI=;
 b=jf1eKjDmiEp+MU7dYojZnN6ZNaJ2J1GFjja02CJD30TdyQTL5h/6v6KaUFnKPJ3AgFVKLp/VUKfxD+JNnv4CatovRD+C1wD04NOELaV8nIAXiixgeziXc3PDq9w3gusnTTSviKRcmva9DWKeg/pJfyU21d2w5h4IT9ZttNy/fdKVVs6wrvUAvcAIS0OpHPHTR/LhJuZN7OM8t1tPAbAYcerD3zpjywt6C722cZBUT5moClMYOsVG3LB9g6QGekcJPq3sXqv4cQ0TalQd1AM99hqI3Jkz6Er2s2u86QDa1O9CPZh8bWcVVwRve0IaJ3GoYOazA83oUYgEHaIhrNhKEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by AS4PR10MB5418.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4bc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.5; Fri, 14 Feb
 2025 12:38:51 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%5]) with mapi id 15.20.8445.008; Fri, 14 Feb 2025
 12:38:51 +0000
Message-ID: <3131b774-543d-44d3-8f18-e7e10fd68156@siemens.com>
Date: Fri, 14 Feb 2025 13:38:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][RFC 3/4] add move-homedir-var package
To: "Nussel, Ludwig (SI E R&D IOT)" <ludwig.nussel@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 "Kiszka, Jan (FT RPD CED)" <jan.kiszka@siemens.com>,
 "Moessbauer, Felix (FT RPD CED OES-DE)" <felix.moessbauer@siemens.com>
References: <20250211085125.22154-1-Quirin.Gylstorff@siemens.com>
 <20250211085125.22154-4-Quirin.Gylstorff@siemens.com>
 <59220d65f1b3b4c9e1207d890f73cb25b9ab3bb3.camel@siemens.com>
Content-Language: en-US
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
In-Reply-To: <59220d65f1b3b4c9e1207d890f73cb25b9ab3bb3.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0230.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::17) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|AS4PR10MB5418:EE_
X-MS-Office365-Filtering-Correlation-Id: e593e74c-881e-43ee-8bae-08dd4cf48900
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?eTZSR0lLNlFBVHVwYkgrdHNnb1pVcEZ1OE9NVkoxUDUrK0ZaNVNDZUVlOEY4?=
 =?utf-8?B?U3psbmlGd0xGQlhlVTJlZ2pvdWhOOWlBYmZ3aVB6dnc1cjcwQjFRd1hKNFV0?=
 =?utf-8?B?cHV0QjhHQVlsTzNIYnlqNC9LSzdnM1JTYWtGZUVRUTlwN3FjKzltZ0psSWhZ?=
 =?utf-8?B?Y0czM3VJV1MyRGkxUUtEWUZwTFJKZ3VtMy9OaDMvcVhQczYvSVNXRDZuMkN5?=
 =?utf-8?B?SkoxN1ZIYnlwbk5rdUV4V1ZqTmdyanljajhMSnBHRkppeEp2RnpIM014T3N1?=
 =?utf-8?B?b1lad3FhV0s4NDZ6M3F3SzY0M3hQNDhVWjgzVCtFbWhCbTlKakl6bUtxNmJ6?=
 =?utf-8?B?a21mZHIwaWg5TXhwVW5vcU9obklMTk5PZGhmNHVGUTNGMVZlRDFiODBuUllS?=
 =?utf-8?B?ZVcxME42QVNEejJhR3BpOVZ4aTdoWk9PU01ZR3lIOGgyS29oUTByWkthTDE3?=
 =?utf-8?B?MXM0Znd4bm1uTk1kcnlqeXowaDNyaEJmR3VDZWRqL1pnWWQza1BCQzFMSWVO?=
 =?utf-8?B?Z1pKV05kY0tYUFNQUnE2QmpvMlN3MlZhZkJQcXZ0NWJNUkRJRldzKzk5aHJn?=
 =?utf-8?B?bWs2OEtZaURZdTEzT3JVNENQbHF0Z2VwdVUzVzFuWTcrb0NVNWJkVGw5bUx4?=
 =?utf-8?B?VjZNS2orVXhyWkQ0MnF4bTM0Mkhvc2tUaTF2eVl2b1lNcUJzK0l6NWlWM1A0?=
 =?utf-8?B?VU1UcFFpYVNJSFU1QzIrbEx0dzJMNDcvQ3dmVFExckpuL2Y5Rmg5MHIvYWdo?=
 =?utf-8?B?elMyMVBkS2NvcXIvelZzczhwRi9wSDJMeFRSUWtxZ2JnL0czTHpLN09iUlA3?=
 =?utf-8?B?NnZrSlZYOFhSVDUzZDdEUndKbmNnN2Zsa2xKTnh6WVFtMWhVUU9uZTJ6Vnl5?=
 =?utf-8?B?SUxhb3h3SVZkTWRORHFaRDB4Y0E5cWVjQnc5SEZVUGJpeHZ3K2RWeE5vaHpH?=
 =?utf-8?B?L2JLUmMweFB4djdSZzM0emF1V0tNN3ExMncrc1R2a3BTdHdCM1ozWERGN25M?=
 =?utf-8?B?bFI0aTROWTQrSzBUQzFaaFJ2ZDlyWmFMMEVQdjVDNnRUaE44VlYyVTlNYlVO?=
 =?utf-8?B?aHVBOEVXYVdUbDdDaXRlTkVURzcxMC9PWmdwcHVrNHFRV1d2ZTQwYTFHY3dI?=
 =?utf-8?B?YldSbmI3WThnWFVKWW9YdFpXdTNGVjd5VzhTeXFlK25TVENTaU9qTHhNc0hV?=
 =?utf-8?B?UTNvYmZxTlI3enAxaUM2Z0NWdUs0eStuVkRvVFJxNWJrdUk3WC9mOXVGdlA0?=
 =?utf-8?B?MGs0YUdndmoweXY5SmN1dHRCZ3hENThOMFErU25lb1FOUFVMY3hnOUlqWTJu?=
 =?utf-8?B?Q0xCMWN5aERDdFZKMXlzVXovdVArZlBrb0kxc1M4cE1CaDNpaENrUEVJZDlR?=
 =?utf-8?B?ZTZiYTN6Y0R2UjJ2TjJGUWpBbVRkaWV2eTQ4QWJOa1psTVFXZDZIWExzZkhz?=
 =?utf-8?B?dFdWSkwxSU5BMjF4SDB6TmtjWDVtQjFlZFRYMnpBN1EwTjFiZXE0blRyZVo0?=
 =?utf-8?B?L2lMREFhZ0UwMnBqMHY4cTJRMUVUVU9hVG1kOURCY1RnNW1qNC9XRmgrVCtx?=
 =?utf-8?B?WHhmZWtJeFdvZ1o4ZWFjdERFYzN6YlZjTUpoZXVHMDBZejNNSEg5VGRaZFBI?=
 =?utf-8?B?cGpVMHNLeWxLZHhNUWdFWWlnVlpiZnZuWDBzV3AwdVhueUtsdlZaT3JnaG43?=
 =?utf-8?B?cVJpaC93bTlZMWY2aHpha04rMTMvb0UxQmdxMDJHNHRzTHpvZUwyaDdxanlt?=
 =?utf-8?B?a1lnVW5ROTQreUo3OGlITFJQcC9jNjhxc3MvUThBZkcrd21OZXZQUUk0R1U0?=
 =?utf-8?B?RXN6L09qcXc2YVFTdktGR0xTZTZ1blBWaEdYWnF3VzB1VDE2MWY4YzhlMC8x?=
 =?utf-8?Q?BklszHmy9PfHG?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YUpTZ0lXTDloU0JNT1JzQWUybVNDdHVzNjJMazNqS1BmYWdXWGQyOUJXU2s0?=
 =?utf-8?B?RUtueHFXZXVBd2VFMkRiMGw0YkJXRStiTXB1RnZQR01pUSs1blhlYnhzeWtZ?=
 =?utf-8?B?MHNXQ242Q2luS0M0RzQ1UDBRRHJBYVlnRnIxWkRyenphUUdzTlFJK2s0aVJp?=
 =?utf-8?B?ckJocnpVR21mUXZzSFZqV29hVnd0YlhtUnFhZUJxNDh3ZUNaZGx0V2Z4OVVI?=
 =?utf-8?B?bFBPS2V6VUNTVENvVWhFSkxVNzZFWjRoTGZLZFpOdW1wdzdVZ3dKRVNwUnJK?=
 =?utf-8?B?QUswNDYrZVZPbGk1akptbXhjNFlzRkhyQVp5QXRaWEF6OVpXYTNLWXJ0clVs?=
 =?utf-8?B?KzFlWjhIKzFyUWVOVHZKb1NNZVQ3UWpFbDlJYngvbWNkcW1hbFFNVHpsbmQ2?=
 =?utf-8?B?U1ZuSFhUWW1nRGt3czB3Y25UUGZPMzhvVW45ZWVpNWVoRVhPa1U5L1RTV2po?=
 =?utf-8?B?amxqalRpc0U3aFBoQ2VtYUVYNkFCOWhobjBpcUE2YnlYaUhNV0lzSTIxbG9U?=
 =?utf-8?B?L2FqZTZ6ZG05NTdURWU3MmZGVDJCdzc4ZmZVTzRYRGY0S2lPQ2MrZ1d4YTdm?=
 =?utf-8?B?eFBxeVdRTFpnT29RVE1HOElEUmxUMHhDaFl3cVRwczRBRWF6eExoMXRPcVox?=
 =?utf-8?B?QUQ2ZGJ2cHFJc2hDOURNeHFhTlJVZWVMUmRUckNJNFIyYzl0YndJN1BaZFdy?=
 =?utf-8?B?dWczaHVXUi94bVQxT1p3bXJ2a0dQdUJPdVVMNnd2U1dtZzN5SHdlSnc0QWhv?=
 =?utf-8?B?MDJ1cnhLbWZLZnZjSVhnNE1xb0NpRkczSytjSXZ1UzEvQ3hHbXN0S200WHVu?=
 =?utf-8?B?VTFUSVVsUG10Uk9DR1VPTHZseVM3UUZYTjlYa1VObDdTUWNUR2IrRmswYnhr?=
 =?utf-8?B?em11UHVTNUkxVi9mZWwreHdDVjIxNDU3YmUzeXJVenJvQnFjTnlZUHdvNC9O?=
 =?utf-8?B?a3oxQ3BET3BlVERGYjhSUHBJUFdrVkpDbkJ5K3dhZzYyMS82K2lTVnV6REtV?=
 =?utf-8?B?dERxZEZjRFBNNG1Ma3FrL3VhWFpRMStIRy83QmFqd2pmVTZ4WW9sNjJPMi91?=
 =?utf-8?B?ZkRNbXNTbVFhd0k3SThYeFFRbHVMN25PdjFFQ1dQNW5zTUlFQ2xLeGlvTnpa?=
 =?utf-8?B?VlFSTHlITWdHL09MTHJIaE5ZcTZPR2xPMkNQMm5TUzBmam9BMUg1cExsTzFz?=
 =?utf-8?B?NGljaWlkcC9RMDU1cTNmWkV4Y1JNdTgxSVN3QW1YMm1hbTlISk50alZjWDRX?=
 =?utf-8?B?WWRxbU96TWVXTS94MVVDcDBZUDAyTFZlNXRxYU1VSVo5TERVanZPOVNEcFNz?=
 =?utf-8?B?cUdacHJTVHJrZjJtYnhMSnRzVjVEOXVsbHp0VWhFV3VkWjBlZ2pPNDRzc2xl?=
 =?utf-8?B?enZSVDY2amlVNWltVWxvWjNoV2liZXhFVmRaMk9KVDJ6SkNjZ2tkQy9BMFJW?=
 =?utf-8?B?TEV5S1FtUW9Wc2pFbXhiTW1JUk1odjlyTDhXVUpqK3NweTJKdmRPNlEvYWpt?=
 =?utf-8?B?TXdBYkpMays0b3I0SnhxblZCWTdvZjNFbHorYlVEbHR0UGZCZXViZW9SUm5m?=
 =?utf-8?B?Y2tHS2pMOTZWNmtTaVNpMmJFVmhuZkRBSlkzWXZlU2N4bGlMWmlRejFjUnAw?=
 =?utf-8?B?cENqbWY4SC9QS1RqTXhtYW5ydHVBVlJIdXVVUjcwclJOZi94aExaVUFPaEtQ?=
 =?utf-8?B?YUhwSnJadnBqK0xuUEFEYjB5RHdHQk15TjZqVkFiRnlVNGtJVWhJczlJMS9S?=
 =?utf-8?B?eTY5SUY0c1M5MS9kSUlpWlNHRFkyVGRwVzgzei9zMTF2bkJ4dk5qZWtOaWp1?=
 =?utf-8?B?dERYVWR6S2pjODR2ZlIzZW9nMXNJMW5ZWkg5NnN1S1FjaWtmWU9BSVNGd2Vh?=
 =?utf-8?B?ZVNJajM5amoybW9iL2Y1SWtqRHloa3RIZlZsNWxYZmk5RllLdS8xMXhGWU00?=
 =?utf-8?B?TERJRGVuNkFWMnJxNXRuV255WHV1c1FpamdRa2VMd090cFFnOTRKcEVOY0lJ?=
 =?utf-8?B?M2x2KzFkVEtFN3N5cDJNUmpHVkxiZzV5YjhMQy9ycU1RVjVkQ2dHUy94Sm1H?=
 =?utf-8?B?S1h1U3QwT2tSS0o4YmpsVzNQUmg0VzZiRU9Lc2FTQ0txajR2UkYzblM2dFYz?=
 =?utf-8?B?eGN5R1d6UzgvQlRNdXVYazFRaFkxRVY5WEtYTDlIZkxhQk00V3VSakMzQytW?=
 =?utf-8?B?bnc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e593e74c-881e-43ee-8bae-08dd4cf48900
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 12:38:51.3573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JelQldEkIv496z6DH161kQ7+pFRDFyuyOIqpV9u6e5LKu0vovH88d5RAMnYXBZ6dZA06jvfXHTqeA3GLAjypGlDIoQIaiO+7fTnBERFusTI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5418
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Feb 2025 12:38:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17843



On 2/12/25 16:10, Nussel, Ludwig (SI E R&D IOT) wrote:
> On Tue, 2025-02-11 at 09:49 +0100, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> This creates a tmpfiles to copy /usr/share/immutable-data/home to /var
>> Also the recipe moves /home to /var/home and creates a symbolic link
>> between them.
> 
> FWIW for this kind of stuff systemd uses /usr/share/factory/ by
> default.
Which systemd versions support that feature?
  Is anyone actually creating images with non-system users that
> have files in their home? Sounds like bad practice to me at least.

Agree, but I have seen that pattern so I can not assume it does not occur.

> 
> cu
> Ludwig
> 
Quirin



Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B393CED620
	for <webhook@archiver.kernel.org>; Tue, 18 Nov 2025 14:12:41 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.3])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13385.1763475148676171642
 for <cip-dev@lists.cip-project.org>;
 Tue, 18 Nov 2025 06:12:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=r12q5WpE;
 spf=temperror, err=temporary DNS error (domain: siemens.com, ip: 52.101.65.3, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gLLppqmGADbwBrYqAUAHoVy5ow7caSRrPDhCbtvUeokauGZVo5Qjgorsh6IVE5/qu+b+ltCO6UdzDDVg69pqtLdavrQC+Kd+ZRjbBNZ89XdWknPdLSc4pmmT1viZ8Kq+diIrPtiCgtOyhFvHsHC/4EYA9F7PNrwGb3GNtXqDvwgO45I0udre6VqSw+Zc7HHA56yhHABWPFIzfXKVd04M5I6RnZwILdlEi0M7vDA98SRu+RA01WbQR02sZkqeU7fR0cm1tYdHyDQDXnUM+MLdds/XcqZ8j3IB61H+UjGGIp7IVxD+kuBTM5EGcNaATpZvnJuRTAstwmswF5B0IWrauA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w3dsI6t8lLKQHT2aelRgxmbkxjwU5Ra+H03aTtWxSGk=;
 b=wOkvbV5pdohT0xzTjcv8HgxdgWddQhYLwcBvPGRbLxENHFMp0eNloYSLmBjPgiRobVV/KVLbyQfuMbbi10ScblLVFAKhKL8J3gJlJn+Mv34jLOqWcR554oke68KvcPomwsU9cZv959hJGQojuTKN8OaM8O8TBmMkh91SicWr2cVVyjRDC1WMtQjMjNQtnWfBzULujWzR1l5cL917eGYgwXrBhapK9+RMkH4ssVf9spQkJhH+JojZwvEc95lWCvJG6FREPxYkYy8g3oU8HMQJ3BVLZZBXgOusGX/wp1qUeoAd0S+B+lx6I6pGzKt9cox3GtBc0aF5uJKHUs+PT3QQCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w3dsI6t8lLKQHT2aelRgxmbkxjwU5Ra+H03aTtWxSGk=;
 b=r12q5WpEZLfWYPP1kvfJfu/47SeZLt1TUW5PWIPTCU/6LQX7x2ad809PRJ6tIkjaOqDZBD/1tyjoZDRluIT1zRImsXYBEu8JiM7J0dJx6hv4GI8Pkd27+KTCjJh+gQRFDen1VpI2xPokAPaq9zEckKBKOgni1yz43MUokNBFVxkFW4i1SKnpOk7jasVZ8yaGSNAYpYgRj4CQ3E4CwKda/AirLcjRf3Ji8WcBlf6Kvz3TNgaKjibkiQ1fTRj4qHRvDu0+5H5E5gu1CNbO5ZIb00Znfo1SXxdpKMBbDUgm7f6kVEdrHuExhEq3xf5z8Wm8jkhAErs/iXKmkV19uUFxkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6704.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:400::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.23; Tue, 18 Nov
 2025 14:12:25 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9320.018; Tue, 18 Nov 2025
 14:12:25 +0000
Message-ID: <c2a68a07-435e-4a70-af85-0e34a7884946@siemens.com>
Date: Tue, 18 Nov 2025 15:12:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: 6.12-cip RT testing
To: Chris Paterson <Chris.Paterson2@renesas.com>, Pavel Machek
 <pavel@denx.de>, cip-dev <cip-dev@lists.cip-project.org>,
 Arisu Tachibana <arisu.tachibana@miraclelinux.com>
References: <7f09f540-8d58-49bb-83f3-811eacc77a20@siemens.com>
 <TYYPR01MB15132251A0B56FB7ADB41CA1DB7D6A@TYYPR01MB15132.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <TYYPR01MB15132251A0B56FB7ADB41CA1DB7D6A@TYYPR01MB15132.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0065.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6704:EE_
X-MS-Office365-Filtering-Correlation-Id: 229f7bec-cd73-4ef6-e94a-08de26ac7f82
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SkVkR3RnTENmUWZMYVB2a3BBT0ZJTGwxMklZUFQrYjNwN09ZSlAwb1lRb2FW?=
 =?utf-8?B?VFBiY0N3ZUJxSEc2aUxzMXNOUm9PZWlST0xwUWs1MDZUeVRVY09BUlI3b1lW?=
 =?utf-8?B?V0g2QTZrSmxRUWNRYjFscTF6UVRYOE5idmdyOUFMZ0JFM0xqemRnYVhKS2xN?=
 =?utf-8?B?NlNRQ2ZaWHF5enZNRXJDK1NiV2xqSzczVHliek5BVjU5bnJ3NGVpTXQxb0dR?=
 =?utf-8?B?KzQ2Wm43QjRpU04rdmpqYmxXVDREdjQ2WUpPMFBoaG5sNlU5ckJFZ1VGcVkw?=
 =?utf-8?B?MUlISTVLRDZITHJkOG4xU3Jsck82OWR5NkhFT2hPZXg2VHZtNU54cTF1SFhm?=
 =?utf-8?B?d0EwOVNDaEE0NFpxVmlyUi95Y1BZdHV5OTRDZzg1R0xEbVZoY0ljRzY5bVUx?=
 =?utf-8?B?NVcwZDNqNS82M3YwT2NpM1phdThoRklMR3FXYzA5VG1pVWdneDBpdk1RUlFQ?=
 =?utf-8?B?SUZDQ3k1d2hJS2lneGdQd1BDVXltanhPcm1MeGdaZ0ZLcHdUenpRU0kwYklL?=
 =?utf-8?B?NDNnUk1wUXZCTnN5cjNkNVNxODFBWDl3NHM5Mlpsd1pLYjJQdFNLR3RxdW5h?=
 =?utf-8?B?a3RDY2pabzZ0WlZLVUM2RW15MkJlK081OG13c3oyNk1IVXBVWmJWeGljTmFQ?=
 =?utf-8?B?bnB3T3lpVkUwbGVVM0N5dkppRFY2aW1pd0E5RUhzUjN5dVF4TmRPUXFpT2M0?=
 =?utf-8?B?cjdXd2txZGpyMDlFaEx2UndZakRMbHM1WU40SERibXNycms3Zkxlb1ZpV01R?=
 =?utf-8?B?TTdIRi9ac2pzeWVqUTRXbGduZjd1Q2FCRGRIZ1U3dWJ4cTVWMzU4bFlDQW9G?=
 =?utf-8?B?RG9QL0ljVEthcjZYOWh5UEp1Q3BKbVFlZnl6dEk4NVY4RjNEb2wvYy9uTVVn?=
 =?utf-8?B?S0JYWlBJMFVTS0o1ajd5bUU2RmJqRklNQ1dxR05aWDBuZmc1NlZNTjlmTWVL?=
 =?utf-8?B?RVRKQkZITE5ZYWVya3VqMHhMSWNHZ0o3WXhLcVlZSWE3Qjk5WjkrZ1lUT2Zn?=
 =?utf-8?B?c0M2aHBURVZqRjVXOTdwZjNmOFp0WnBsVUpBcUVpd1JHY3c4WkhIaGR0cjlD?=
 =?utf-8?B?U1NURHA0N240ZkU4SVpXdUNkWUF2SG9zT3BTZXNWR3ozbm1qZ2FIUTQra3hl?=
 =?utf-8?B?NzNqQU90VUpuK2xIYzE5NGtEZ0pYTUJadERNVjFLVkt5TGlmckh6dnJscHdU?=
 =?utf-8?B?RGhtUUtiT2YvZ01CdWpaV3RiZTdqUW1JanVMeTJzM09jMmhDa3F5VGx0em9Y?=
 =?utf-8?B?ejlhdFBiR2NIS2IwUHdUcTc3dkIxanFIMU1Jc0hEWks4ZS8zMmpUSHVvVllN?=
 =?utf-8?B?b3pMNDBkQTZoYnJwMGNJb3p6dExMWHpWSHkvcWdwK0o3ZFBpVjZrd0FYWG1N?=
 =?utf-8?B?TytSci9wN0M4bFk4WnhHalZadWF0cHdDRWV3Sk9TN2JpNjdhcTFvMjAwUWx0?=
 =?utf-8?B?Skttb3UrRVNFTEo0SFFoaGY1RjBHbG9mV2JhaVZoSkxVa1dxVmZyS0t5Y3RW?=
 =?utf-8?B?RmtuWWhRWVZ1cmdHT3NaNXY0M1c1NkpXdm9oUFkvV1grTTB1QVdOTVBkdEE4?=
 =?utf-8?B?TzVML1RpbkNaY1RQUXhUdDJQUldrSEd1eTdQOHppckNPWXg0T3A0eHl4dzVB?=
 =?utf-8?B?OTRUejBZRit1S1JjRFI5bzlIS2lMc0pGUFFETnBLTWhIeEFxcUNJZFRWTk1C?=
 =?utf-8?B?QTZQSW5ROC9BZEZUVm9nRnlBY25FUWt5dTVDbUFxTDg3MWVDczRPYzB1Q0NM?=
 =?utf-8?B?MkpQMzhWc2JuN0VVTEcxTnp5dUprdHR1T0VOOWpOUXFxWlNrNm9iem9Sa0Jh?=
 =?utf-8?B?QWY5aFg1djhlU1VoamdMT1VxNkxKM2JZSTl1QTNZNlU5NG1SSWdqQ3dmMzZl?=
 =?utf-8?B?cXFnNkx3RytyWjc0dFRwdHByaUJic0ZzbnFyQ0pYR1BKcGFJTEk3dldOZHVK?=
 =?utf-8?B?dVBPUWVabE9PS01DZUVabzdzcEFkZVd0bUxlQVRRYTh5TXZJdi9HRURxQW9Y?=
 =?utf-8?B?QmJxL0tMb0pnPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?c0U5d0VPZUpNMzhOM2wwSnhiQUI3ZG5HczVwd0E4eXY4WHNyZzYzUkxaNzI4?=
 =?utf-8?B?WG1lOEJjQ2d3Z3p1ZTZJK2pDN0JUR3lCWko3bEhiVmZoUUt4dEhtVXNHeE50?=
 =?utf-8?B?QUtxNXUvVStiS3VKQU9MME5hbFlNbHBzZjdRaEZvTnhpTVJ2Mzk2K3JnOHhx?=
 =?utf-8?B?eVJuT0V6Y29CVVRyQit1aU5HcVBUUWdocmVRM0ZlYVA0NTlWMU1laE42ZFIz?=
 =?utf-8?B?VThGb3B0cHQwWDc0L0xhSDJDY1pkNXZsLzJKR1B5ekZ0UDBqVVB3bW1sTG9s?=
 =?utf-8?B?Z1YvKzZUQllKMXJwOXhuZUxHd1hrT2dsNzBESFd3TS9IRTdkMHBJZTAxa0s3?=
 =?utf-8?B?bzIvcTJtZWhFWjJpblgxdW56VGgrMDZRak5xMXIyc0NqUjFNbjRsWU52akpw?=
 =?utf-8?B?a2xCU3VJTzYxVU5tcTdOOTB3d2NHSmhRMDRybVlHYjhZQ3ZXSEhSVDRqSXFQ?=
 =?utf-8?B?ZDl3b2wyYmFYQTltcDlpRit4ZG5ENmNPRzdOTXdQYkpwNFBSajNoSGNZNzYv?=
 =?utf-8?B?a2JrYUZneUl2bnRTWkpUYVJieUtYVlJ1RWtiOUcyaGk2YkhZaUV1UVU3N1JQ?=
 =?utf-8?B?NkVLODl3dGFZVjlyRFg3UmlmZk5QeHBqYlZJNTUyKzlyQmh6VjVrOTFxM29F?=
 =?utf-8?B?dHJ4OHI0U2RhWjhIRy9EQXJSM3lXZ2JGczVGS2x3SUZ0TXFUaCtIMWcvaFlr?=
 =?utf-8?B?cGw4QXdOajJkTWtOUFZweUZEdlZSZElCNkdwYnRJSHYvVHJPL3gwNnFrUG1z?=
 =?utf-8?B?Y1F3Q1JwcnQwY1B3TnQ0RUdQdHIwSWNodDFlQ0h0N25MMS93TjA2Q2JhUUFl?=
 =?utf-8?B?VU5SeGFJQzlsU1U3Zlc3bEtmaDllOGRFQTQ0VDg5VGtPT0dncE5jUW0vWk1Y?=
 =?utf-8?B?eXFjYnlzNWcxQ0cvUkV2cGFib1NhYmxsNjgxdUlDMVk1cDBnQ2tlLzlFL2wr?=
 =?utf-8?B?VXlhQ2JvOVhGK1ViNXlrOGNWVEdib3ZzSDYyOFRJdnk1WWJOLzdUUnBnaEcr?=
 =?utf-8?B?K1JheVdvbTVtbUVTZ2hYaytBK0pTY0o3ZlQybmUwQi9pd2dNOGV3eHRoSHB5?=
 =?utf-8?B?NjVzLzdqdzVlWnNhVmVock1MZno3QmJPdzdSbEI2VUVNRHJnbmFhdkxHM29C?=
 =?utf-8?B?dmoyWUgrSEpkZ1BWM3pMalZITWZ0NFcyK3NidVBaZlJCczhFTm9nZkl3ZnpK?=
 =?utf-8?B?NUtqMHNhNUlaR1dLVE0xNGgzYkppakFCcm1oK3VsTkZpQlNPWGNkZytwNFly?=
 =?utf-8?B?R1FSMVVITzhTUGlUekRLUXdvRG80aVZ6WW5qSmRobDF2Z3ZSVnVIdWZjMVRk?=
 =?utf-8?B?YzNuYnZvdWk5SjB2MDU2VURST3ZSdS9PcjB6a0l3YXZ3VFJjV0ZNS1ZyVk1Y?=
 =?utf-8?B?RzVQTS9lNTB2V3paVGxaYnBHQzJoWWZEUWE5MjBuazNVTjFyRFRqbEwrZlh6?=
 =?utf-8?B?Q2svTStpdkQvK0xtckdCWXFwbDM3TVRBM3lDaTVuQ05ac2lwaUs0MkJiTkND?=
 =?utf-8?B?ZXFsRk44d2M3N2F5YVRTSXFnQk1jZUs1eU13dzA5SEJSMHhWdlRuVTBWeE9S?=
 =?utf-8?B?S1dBTnk3anU2R1VLcXlCZ2x2Njl5RWNQb2QwOXpDMDNGWlc4VlZ3YlB4MDRz?=
 =?utf-8?B?ajlES2prSG1Xa2owNDljR3JPdk1xdUxvdmE3c1BSaTRUWHdBRVhFcHVKd1Rs?=
 =?utf-8?B?RTU5TWE5MVFMaVBka1kveXN3VHc5TURCN1FBRkRnYm43ckp4MFNydGxYSGIx?=
 =?utf-8?B?VzQwZTVRZG42ellXTXIxVjV3MGFqa29KOEdkRXJTWHdBYjNqWGtwZWpENnUx?=
 =?utf-8?B?a3VCb3V6eHJhdCt0ME5zZ1I4NWhhT1pzekJ4NENrOGhoR2xZTjZmM0gzK2Q0?=
 =?utf-8?B?TUVZMWZ5QTZUSVdWS2k2bkxHMTNOOXFYNTRDdXpYbU5ML1dLNHQ3by81M2Zj?=
 =?utf-8?B?aTF2WWFRYVE5MGFRVHZZTjZqOVVOaDdjSzNTRGRzdVgreGNMNDhMREV0b0R6?=
 =?utf-8?B?THJqYjhPaHd5K1NnSy9YVVRnRDJFOTl0aTFvMFNORkJtaVhDcExoUllIbUVY?=
 =?utf-8?B?dHA1WGhUNHpWMGEyNCtzTUdLV1pvVnlZZGpQSXY1RWxkKzNnV1ZtV05vLzho?=
 =?utf-8?B?SnVaeElucjAzbkxpSTBQOEs5dHNqU0xlQXBiZlRUcFZZUTZkTWd1ank4MVFx?=
 =?utf-8?B?NUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 229f7bec-cd73-4ef6-e94a-08de26ac7f82
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 14:12:24.9855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Gn4O0jBurAyPDpftJZmYF+EmTra4Lrafs+YAoz7xxRb8nZ1d/+LZX980GeItert/Otqffvi3ld72QKP0qRbvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6704
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 18 Nov 2025 14:12:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20614

On 18.11.25 14:04, Chris Paterson wrote:
> Hello Jan,
> 
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>> Sent: 18 November 2025 05:45
>>
>> Hi all,
>>
>> lost track about this topic: Are we testing by now a kernel
>> configuration with PREEMPT_RT enabled on 6.12-cip? Initially, we didn't
>> IIRC.
> 
> Currently we're not testing RT on 6.12-cip.
> 
> I've just started investigating how to enable this in KernelCI for all CIP trees, but I'll start with 6.12.

Thanks in advance!

Can we add [1] to cip-kernel-config, maybe even migrate it over? We
already agreed on not trying to maintain separate configs for rt as that
is doomed to cause even more config-rotting that we already have.

Jan

[1]
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob/651c38c1c9d837331fb4c4a68a4a75c27163ced6/recipes-kernel/linux/files/preempt-rt.cfg

-- 
Siemens AG, Foundational Technologies
Linux Expert Center


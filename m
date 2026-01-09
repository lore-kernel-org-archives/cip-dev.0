Return-Path: <tobias.schaffner@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D06ED16812
	for <webhook@archiver.kernel.org>; Fri,  9 Jan 2026 11:09:07 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.63])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7930.1767956945619925008
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 Jan 2026 03:09:06 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=vfNF7oKg;
 spf=pass (domain: siemens.com, ip: 40.107.162.63, mailfrom: tobias.schaffner@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=chYajU6+ZfOv6REe6dE0Ks+hT2SIx+XzdEAMBxbWchz+HwJhWAyIXC3CGy42n6tgOlTgyrWXOVznrew+ujgQ9oBT1kka78m+iSrP2dxe+fvrTACvKNxL91El22GHen9dEqmv+Nt0dQLNmmvR9HRpgjR0LDdyCEC9ZyvRXOhDufIUhJFO4tLrcdZnjEwz16tMNUF2/RJBYCQTaIoVwP01V0C+PY3YPlbOQjkdL7rIhxuANQM3c3JXw18GCukHVFx7ZdMbXEvF01hg7KiGTBrPaVZR50jspWVJZL4YcxiaiJN/tr+TFzZX9H4+zk+4Rzxqu6axX7aFVW438ae8gNzb0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DpCM7JUV4fICGJgRUCMcawXMUHxE4hz2pzz/caimE7E=;
 b=wXrnEhbBLWWPpSuzO3CLAXzZ9hpXV6lB2LViHLYnbBUhB2owexNyjO3UVFVtz00uu4pDns3lRSU/siSHBP/vwf1/G1Xdklt0nWqcOzXAP7HVJgJbuCXdBFVHogvCPmVdPMD3MUMOBtQ07F5n7LadrjDO6rmUTVO5bnsiXPRsNxYVn24Ep859tvp8i8xTL8AKILZRzKK3tm8ZT03MaIa/+HpkI4viO/NPq4q+hG+Fy0vnovHc+Y4eiBPqrNJ7GgoLdHz61NZmzU6Ow5HnpWMQC/kdT1PCrWracs5T+kD1f/tRkkKzMlwhjv7C+TXNTLVUkObhBZ23bOk253BDUxEhVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DpCM7JUV4fICGJgRUCMcawXMUHxE4hz2pzz/caimE7E=;
 b=vfNF7oKg3TEM7nVA6uqYFs/Y0NBHe9qhNsF1DkVEJcf2VQ/b/V4LcqpZlAY+3utQzJ0dgy/kILCEHlogt/IV1yG3mP996anRME1Hvv/0Whyhg0dfvtsxJBrqlpCY61NAmE/mMntNfyXYssXMrQt2rY4I8bgih2cH7F2SMyjx2Bpu0m2l+4GDsRclErqomNZqoAsmPuwS7Jb+obj3Lf0uiGNkD0M7jdTduEwQ310K68oBU1SVV9dAWNu00dojwvM1lzOC86j+DzXJxUxW7DBmjI8NUQ8aIbzfGWjN3boBFNRsr3v2/AUuYXxEv6+3gst5T0C/hbFzdMc04xRcnT0Zew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by VI0PR10MB9218.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:2b8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Fri, 9 Jan
 2026 11:09:01 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3574:ee1c:94a0:7492]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3574:ee1c:94a0:7492%3]) with mapi id 15.20.9499.003; Fri, 9 Jan 2026
 11:09:01 +0000
Message-ID: <2f854acc-e08e-4405-b9fb-dfb71015a75f@siemens.com>
Date: Fri, 9 Jan 2026 12:08:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] preempt_rt on BeagleV-Fire
To: pavel@nabladev.com
CC: cip-dev@lists.cip-project.org, nobuhiro.iwamatsu.x90@mail.toshiba,
 Jan Kiszka <jan.kiszka@siemens.com>, Jan Altenberg <jan.altenberg@osadl.org>
References: <36dd7fca-98e9-49ab-8dca-14a3997d0c5f@siemens.com>
 <aWDRYgwxThmOyGPr@duo.ucw.cz>
From: Tobias Schaffner <tobias.schaffner@siemens.com>
Content-Language: en-US
In-Reply-To: <aWDRYgwxThmOyGPr@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0331.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::17) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|VI0PR10MB9218:EE_
X-MS-Office365-Filtering-Correlation-Id: 27e2711a-b6c2-4441-c2c5-08de4f6f7e72
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|4022899009|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bFhCa1Zzb0lLN2lmYjAvRGtmVzZDdlMyWjZwOG9hV1dpZm1pZHNnZ0pZQXox?=
 =?utf-8?B?NGtCclBwRTRvR2h3YzdlRis1UnZGdGxsUE9LaFRJWkdPVVdiY2dCaUVMS2Vq?=
 =?utf-8?B?VXZUNXFlb1dtN054RTFFRFdaVHFHMkRodGY0disxRFlsQXRFMTlGaWZ6MGsx?=
 =?utf-8?B?SmdaYUJyMG1zK2FFUHZDaFFTdU95aDNkYkc5TTZMMUl4UDVjUzcxeHo0Y3R3?=
 =?utf-8?B?RjFSc3VhLzVUZEJJVDhrTmNmWFNnQ291L3RhcDJndG9qZzVvRVVqb0Z4UnNq?=
 =?utf-8?B?czJvaW5tNUVGbS9NM2VuRFlrSFBoRElLWFFraVFCbXdzVmkyNzEzNlJ2Q29y?=
 =?utf-8?B?NlFUdWtjbW5ZdjRjVnVQVEpPMXZ5SWNlU01mTTJQTWFzdTVqSTM3UTNzVERq?=
 =?utf-8?B?Q2NqVlBMditPajBxZ1NOQUdhVGczcWhpckNkQlN0c29YV2t4ZzFpWjRKUS95?=
 =?utf-8?B?SVJRVC9WUWlsYmdlUVlta2dpZXRyNjkxWUNEY25HNVZBaU1ucmR1RTFnTTlK?=
 =?utf-8?B?N0NaUGh6OFlPOGtjejhWQk05dWoxWjYzeGJwNzZYY2pidWxSOXNsZCs5OUVZ?=
 =?utf-8?B?cjZDb0NDSktxNFk0UmZMS0xqL2lCQ0REZ214R1pvV2JoWUE3SzBHcHB3L2xJ?=
 =?utf-8?B?ODFMdGpBSU5CTkxudlFsUzcvN3JNOE0xYnROV2pMLzJudnZUZzJWWmtDQloz?=
 =?utf-8?B?MysxVU5WS3hlV3VuUFdGTk4zc051djhFOFprWVRTazIzQURQdVpXNFI4dlo4?=
 =?utf-8?B?WVpBSUsySnI1ZmUxcWpGSTBEZVNnUHV4SFNFQUhNcWZYaWFWWThGVkJXNW4z?=
 =?utf-8?B?WTVOeTlEaHBleGJ3aWpuNHloVTZETm9WU2x5NEpvcEFSSjBQQVZZM1dTQkZH?=
 =?utf-8?B?QklIM2lrU01MYXVGMnlIZVV2WWdsa2M4eUl5dlJyeEYyWEIzWVp5RE5BY05v?=
 =?utf-8?B?L1F3aE5iSW9nY09NZjdvNUtnT0ZhYkdmckNseitNMUduSDlPbXlmeDdGZ0Rw?=
 =?utf-8?B?dTBrSW9ESE5LQUFlNDQxaE5NNDduYldZTVBEaUw3NUZkL1pEV25Yb29IRVBa?=
 =?utf-8?B?a3N0QnA1MWxnQ1RRa0Fxc05tVi85NWJMSkFsMzlObVR6QXZKMUcyV1pZQ0Jj?=
 =?utf-8?B?RGhoTlhDSktyb1pxallYRXZyMzlRMXd4b2cvYW9YS1JMVWZENVVsYmtNcmI0?=
 =?utf-8?B?eXBpUnBQSzl2QWZhbk5teVNhdEJQODlUNW5ES0JhMHpVdUhrTTVybnNVTUM4?=
 =?utf-8?B?ejdPeFVhUmFFbHhQMzY0Mkg1K1hhWWVUNTNtaG1sbzZ1YnBkQ21aZGxRUmlp?=
 =?utf-8?B?QnVZamZ3N2U0MDZzdGZuUFEzSzJpeFU4T3N4STk5b1VBS1hhZksycFVvSkJ3?=
 =?utf-8?B?WUpyUGRjSmwrVnlqRVVhRTg1eFJQbmtXQTdTQzRSRTF4bHFFenlienI3T3hm?=
 =?utf-8?B?T3J3dVdVZVVhT3pZVDAzVjFKd0VwV3JWSkNXVU5Melk4ZytQcElvdmExczA0?=
 =?utf-8?B?VUh3UUZzc09NMWxwNkpqMWZ2N2lzNjRNTkUxWThHWEsrdnpNOEkrMmlDeDhK?=
 =?utf-8?B?SkV0bzUwdGo1R1RmNld1OTNUQWZoZ0NqcWtyS3JDUUhmd0R6QitSd1ZpdC9j?=
 =?utf-8?B?S3hpU0hPb1dyeDhLMkoyT1hiVy9LeHBFQS94MWltazVwZzZxbFBQREVLUFp1?=
 =?utf-8?B?eVJkZklsYlJCYkVzc0tlNUwvaUsrcElKQzVaam5wRlB3bXQ4Sm9NaGJMSjhm?=
 =?utf-8?B?b29mRk9MWlBXUTE0MW1HUTVaa1UweWJoMzhzdUZpYjRwZEJWS1ZEaVViV2R2?=
 =?utf-8?B?MW8zN0pDVllqaU9vS3VPc0g2L2YrdDAxTWhFSHNIVW15NU1oZmNIY0dBdFRt?=
 =?utf-8?B?NmRkVkRCU3VhUTNSNEs3N0VvLzRuY0xUUTFzUDBxcCt4V3c9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(4022899009)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2tlcERDUnRGejFId0lqRUR3dHZDRVNEMDN5WHFYWXhXbGU0SFUwRis5Nkxn?=
 =?utf-8?B?eFNaUnFWOWtXa01DNjd3TngvSHZ3T0p2S3NaVVc5ejlBUmdwUUZra2xuL2Q4?=
 =?utf-8?B?QncwUlhIOHk5aWV5YWtlaWtpaWx5M1lWUlhFK0RzS1ErV3ViWHFVYzlNc1dC?=
 =?utf-8?B?dnkzbkdNVFpEdS85QlFOQkJyZHJjZmc3dmYzbGhHc0tJa3gwY0VBTDFzODZ1?=
 =?utf-8?B?MklYakRETUJXa2tJMG5jenY1eGNEZWt4ckRnMDdDSFNvNGs3ci9GcFlwRlp6?=
 =?utf-8?B?MDNhUVJmVzNTMTA3K2p0NzlhSXBSWXVOMkVWbENUUGVLZ1NmL0Z4QXpLUHNF?=
 =?utf-8?B?NHhtdy85RDR2blNFd20vWU9BdGNSL2cweU9QODJaK2FtT2piS0N6SXVRNjVI?=
 =?utf-8?B?VWhscG9zSVdvTTlYZXF4K0t0b082eU13eFlIb2pJVCtreWR1eU1ZVFZTdWtU?=
 =?utf-8?B?SWorejkyeVVkblF6VkNlSVoyZkhrMlJFaStWQTF6TXE0dHQzeUN2NUpsTDdX?=
 =?utf-8?B?ZW9oalVNcDNkd3RrYWx0S3d2enB4SVQ3WThzZ0laaG5lU051d1UxejhpTWRG?=
 =?utf-8?B?Y3NkZlZJdXNHSHVIbTBiRDFCR09kQnEyNm91UmtYSU1ZV1dxbGxMT3ZrOXVQ?=
 =?utf-8?B?VWxXKzlmeHUyMWZjQnc4MHljNWR0R0lnTDI3bGorclE4Q0dPL21iRU5Lbk1V?=
 =?utf-8?B?ZkdtMHAyQ3I5QXN2RUxwVFJtaEJWUnNSV3NnWFBXWldJNGpIdFllZXJFTnBM?=
 =?utf-8?B?ei9LYW15ZlhMTlVjUkZiMVFybEg4OG1LYkpzYkhBOGNNSHBCS090b28zVEJH?=
 =?utf-8?B?aW5yeGNGdGtFcFJFY1BPUC9yTDViMmJSc29vRjVnajViejArT3ZRWnhGVjJt?=
 =?utf-8?B?ZXBPcmVMWThSTHRTaCtMNnh2blp5YU9lcFU0YWFXWWxqZm44MGVZaDdEMWJY?=
 =?utf-8?B?alJmajVTaEhWWUsrODB0ME5Ca3A2aTdWcGhYVVlLY3I0b1poQlh3VldLMEQ5?=
 =?utf-8?B?ZmEyY3FaMnRBV3pUL2RoOXpkVVllaktjVUxDY0ZDTzNPQlRxTUVJa00wUXpD?=
 =?utf-8?B?ZyszM24xbUJ1QUNmRUlEOUZqWXdyTVl0R0pFZkZPM1YrelkvbnJJeDhhNFh3?=
 =?utf-8?B?TDJXeW5NcXBDTmh0ODQ4dUVwZzN2cE1lSUNBdm9MZHJMVmhtajJJUzVxRVFV?=
 =?utf-8?B?aXh4ZDFHSGpuZUM4Z3A0amkvVHVTWW9BQlV4TTc5TVdnQjkrNDZ0YUdrb0Zr?=
 =?utf-8?B?NUJzdE44dFlWR3pVdWo4Q2s5K3h0QUxzZE9kMjJHSWhicXVMOVlsdm45VDJY?=
 =?utf-8?B?VW50M09VUGF6Nnc5MFNOZnMyMDB2TElRM1FTbE92SXZLQjZ3S3lyblQ2a2tm?=
 =?utf-8?B?SFA2RGQvZU0vb3Q5NmNaUDM0MlBOTGppNCs2MkI5Q0g1Mkw2d3NGSVA4bG0w?=
 =?utf-8?B?VDVyelZsWXZuSlE3TklORkNBVzdDa1Zjc3czTkJsdG5JOS90aXE2VVlzV2hZ?=
 =?utf-8?B?TUxNOFJ0Sk1iRVJxU2hIVUFyY1NRclBkWTRocys2RjFIUStscTBPZndaN1cv?=
 =?utf-8?B?c3JDUHAyekFZaU5pa2FWVW4yTUpxd2ZMR0ZvTmJCeC8reU1xd0pEUUZLeWdo?=
 =?utf-8?B?U0lvOGNkdkVaN252M085c1FMVkEzNGgyTWdoUlZmaTQzRFhZRzFXSXh6UGdi?=
 =?utf-8?B?VUViRnQ4L0dFYnJVWmpybzZnTHlTQXk5YlJrNFhHRXA5WENBWndSRURpZDJD?=
 =?utf-8?B?S0YzT3k0VXV1OW5PeUNEU3lKWGFCOTNFRlJ1Uk81SHBLRjJ3blNLaU1VajlN?=
 =?utf-8?B?czVPdS9FY0tOd0lkVDFVSFdYMUR4V3ZlTk1SakxmY1ZoeVI3dWhDR0R3dkpB?=
 =?utf-8?B?QmdTdzFCMTJtbTBoKzNianBTWHZXQWRoWnBLWU8rdGdXMTF4Tno5Y2ZyS1A0?=
 =?utf-8?B?dEpGRTZ5SEtTTUtZTjZuL2lBMUg3NmZXR3c0NjJ0OGV0ZTcwR3JqK0tqR1pB?=
 =?utf-8?B?VjRLaUVYV05nK2cxUCtnTkRxa0VyMHBUMnNZUXIxMStaZUJiR0s1b2J3Sklq?=
 =?utf-8?B?a1lvYUpKR2d1SVA0ZHhyU2krSU5aY1R5VzJHSG1VZmhmb0xtbWY4eFVJU0pm?=
 =?utf-8?B?Q0JiZzl4ZzhqUm8wZmV2c0NlN1ZnTVRubVVUY1FqRDB4UmZmaTJibWhtZFpx?=
 =?utf-8?B?QmFaRzRtbmIxc3ptN3pjVk5uaFhyTCtRLzFUL0V3NGhOMTRQdDJ1YllNblV4?=
 =?utf-8?B?VEhqRnJyWlh6UDMreWdzbWV5ME1UanJZMEpFamlwbk9QWm1FL0JnMWwvczVj?=
 =?utf-8?B?b3VjRmE1YzNYTzNncmJXeVdUMDgxOE5tUVpPK1BYUVBqU1kzbTZ0OVc2VThv?=
 =?utf-8?Q?HUDQBpCeHWKD1SDs=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27e2711a-b6c2-4441-c2c5-08de4f6f7e72
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 11:09:01.5822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jfXGMH7G92WmDjvH2V+P6/r1wLkmcPZZTjqucCy5FPcyHwMLLeEQxx/P0GArtNvUhF8rruTzN27GY2hhf8FI1tpNx9c0QX/6A8MayegPVx4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9218
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 Jan 2026 11:09:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21503

Hi Pavel,

On 1/9/26 10:58, Pavel Machek via lists.cip-project.org wrote:
> Hi!
>=20
>> has anyone already tested preempt_rt on the BeagleV-Fire?
>>
>> OSADL has evaluated preempt_rt on both the PolarFire Icicle Kit
>> (MPFS250T) and the PolarFire Discovery Kit (MPFS095T) and has reported
>> rather problematic latency results so far[1].
>>
>> Since the BeagleV-Fire is also based on a PolarFire SoC (MPFS025T), I
>> suspect we might run into similar issues. Any experiences, measurements,
>> or insights would be greatly appreciated.
>=20
> Those OSADL results actually look good to me :-).
>=20
> Ok, so let me explain. BeagleV-Fire seems to have slow CPUs. Like
> "Nokia N900" slow. That's TI OMAP 3430 SoC, 600 MHz ARM Cortex-A8 CPU
> from 2010 or so.
>=20
> It is certainly less than 10% of speed of Core i9-9900K, and that one
> reaches 100usec...
>=20
> https://www.osadl.org/Latency-plot-of-system-in-rack-0-slot.qa-latencyplo=
t-r0s5.0.html?latencies=3D&showno=3D&shadow=3D1&slider=3D360
>=20
> ...so 350usec is actually not that bad, AFAICT.

I cannot see any CPU isolation in the profile data for the Core=20
i9-9900K. Maybe they are using cgroups here, and this is not visible.

Comparing the isolated cores of the VisionFive2 @ 1500 MHz [1] to the=20
MPFS250T @ 600 MHz [2], it is more like 45 =C2=B5s to 250 =C2=B5s.

Your point is still valid. The gap may not be as large as it looks at=20
first glance, but I don=E2=80=99t think the difference in frequency explain=
s it=20
completely.

Best,
Tobias

[1]=20
https://www.osadl.org/Latency-plot-of-system-in-rack-3-slot.qa-latencyplot-=
r3s2.0.html?shadow=3D1
[2]=20
https://www.osadl.org/Latency-plot-of-system-in-rack-7-slot.qa-latencyplot-=
r7s2.0.html?shadow=3D1

> Not sure what our requirements are, sometimes people put the
> time-critical stuff into FPGA.
>=20
> Best regards,
> 								Pavel
>=20
>=20
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#21493): https://lists.cip-project.org/g/cip-dev/messa=
ge/21493
> Mute This Topic: https://lists.cip-project.org/mt/117149606/7247900
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/unsub [tobias.schaff=
ner@siemens.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>=20



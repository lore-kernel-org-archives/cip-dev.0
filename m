Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF7A9C0218A
	for <webhook@archiver.kernel.org>; Thu, 30 Jan 2025 09:20:48 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.66.13])
 by mx.groups.io with SMTP id smtpd.web11.11866.1738228840414217895
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 Jan 2025 01:20:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=QCZgeX3T;
 spf=pass (domain: siemens.com, ip: 52.101.66.13, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SS2hHbEZA3hjj+oDyupE8AcnvK8CPeuUM0i67mEsLdTei2eQUbsfwfP5HKpz0M9eQMXOz/q2tY3Gvt9rFvES/u1Edc0WFhS1bEldZYlO4O12raYTs6WbErlKb5NffK19oXYKKm+LuMlh9QmfWYPnuP27sfhkfemy0AFDaFs7lXB4tx1oY1qrRlw+Jb6+YyeBE7V1hzMaGKWw8gga0JLqD1/y/RP6b3zbTCXBKBkgeQYmXfor1sQ0f2mAI2bAMQWX1/9xta4Em/gvVavi69kOC2pnVcLLF4Ej8atFtWHQ3YVTQQyKuIjEQKwwkgKBHaS3z6enePktPtIAca390JZRXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R30x/vx+HY9asLGjPnaOmsawlKhiZmPFDkG6h34Su8c=;
 b=IfXqHNPKXt1w9Nmg4r182r1ganJHwPE8LDhHa9I4HagY/JuTSQiZVSNwQGUsAbxlAONgN1eoNHC3KbppjaH4ojhZvpnl8nprVW/IRhEvo4bDNWsHW/NUIqu7Hf6Fk7Yua+ALXTWFkfvMJ2Iyn51L1dqilg9oiIUcsxSfwd1vCi08XMweToodI2LDWDyy0wd2R3WFDpm4dkV6uM+jrgU+h4CTANDVsQ7LrDQqoSdkUvl/MYDX15tIZ0313pmbMMdFikwFVrIh/TS9rLDMPw1LWA1HD/e6qj/o+5F+sKja8UW2/mMRSmx2N4M61LO1+7s5MfL7l+/oeEAV6icixPGYAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R30x/vx+HY9asLGjPnaOmsawlKhiZmPFDkG6h34Su8c=;
 b=QCZgeX3Tlee5TGfRb1sKbpNaPXbx4r2gZufha7y6oe23ryf/kodzInPAK2dixSgARSuErHxLIeHOi/6jnDY30Dd1ilKC03IkGrf2tWHZrRLqj0AkuQ1No6rnd5AgZPrzCaf1hobqVZZ5XjTQrYRQfjJrwEDVGRKMYfgx2S51BTuGnN3yYxQxPYbqatqXFTtg5N4Fo94kZg9MlCHPN68B5VhxXJGb0Ltuw4FAdtWR6QnOg5UiAjzEN4FTAhakpPUHCu77ct1UWiHFmzb3KhbBDNSgHpvmgsq3IJHV0P53tlkxlFiwTL9iWNlcXzrDYl+a5hWFtN6PnkN40SJKPoeuFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6360.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:b7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.5; Thu, 30 Jan
 2025 09:20:34 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8422.005; Thu, 30 Jan 2025
 09:20:34 +0000
Message-ID: <13e252ee-f99b-451b-848e-ec918aeddd6d@siemens.com>
Date: Thu, 30 Jan 2025 10:20:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 1/3] build x86-uefi with secure
 boot
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 Sai.Sathujoda@toshiba-tsip.com, cip-dev@lists.cip-project.org
References: <20250124132246.64738-1-Quirin.Gylstorff@siemens.com>
 <20250124132246.64738-2-Quirin.Gylstorff@siemens.com>
 <38e3b2ea-9dad-4f14-8e73-9dc8f4c05f9d@siemens.com>
 <a57c6f8f-47ce-4202-9fb8-fab2c33fbe7c@siemens.com>
 <OS3PR01MB61030247E8AE7BCFBDA4ECDBC2E92@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <dc53e50c-3901-4051-9414-1a1c9067c519@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <dc53e50c-3901-4051-9414-1a1c9067c519@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0177.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6360:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b47eb7e-6530-46eb-1540-08dd410f5996
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?aHkxeldDRGhMVHpYc1JsdzQ0K3V4L2JpelNSb1VrcGh4QlZNZEVCTDVpRFdq?=
 =?utf-8?B?NTZ1N091YUdqL2tiL0t6SklGOHhPRjBLVkpZMWpIVzBlZStTWC9FQmhRMWpD?=
 =?utf-8?B?YjNEaG1qRHlUOC9keG1YYVRtZWJVdTQvdFZTQ1JGY0xKKzhlUDFwUmNkV3My?=
 =?utf-8?B?OXBRZXZMUlJhdFFudFpZNlpMaUxCaDU3VVRRZFNHM0pWTG01clR0OHBHSHlW?=
 =?utf-8?B?UDF2MXZvbURoRXNPUGdxMXN0MjhyZ0VUZ1JnTzd2cHd2b2kxUC80SWtDUVIw?=
 =?utf-8?B?NmxXVE9TekVPN1Nwa2RxTVU3ZENWbjBKdnBjSHB3dUpmYjNVMDVXRnl4WkdN?=
 =?utf-8?B?cXVuV29wa3hGeUl0YTNPQWhvZWdRajFrYi90dU1VYW1XK1lKTUVweU5XSW80?=
 =?utf-8?B?cG9uUzRFb1dJWGJBUFRSei9td2FBUDhvRHd1Qno5WFBOcXBTb1VSc2VLdDZs?=
 =?utf-8?B?NEpwbVNsd1pkVGpWRUZSV0lVRUNJUjdlQnJ4dXlhbG1sK1l4S2dzZDhCemds?=
 =?utf-8?B?Z1hLOGNHbjlwUlBQQlIrREdhUXlrMXFkVWwvazdkWC9uK1pRaW0zWTAvOWl1?=
 =?utf-8?B?eTRjMVRqejltclRmaS8wc3pobnpKdElLZUd6aEdsYUUyWkdBUGJuemFHV0Ex?=
 =?utf-8?B?NmNQTlFicE9oSnJQd3RQbHZqcFhXdFd2VGpRNERHY2gzL2VDYVg1b2orQ29H?=
 =?utf-8?B?SHRhc21BWmY0Tmo5cXgzc0psZW1MbURRTDJ6VUZNUVI2blJOejBNcm1qbTRV?=
 =?utf-8?B?THBpb3YrSGt1UjNBajEzTmhWdW5QamhEb25iaXhhUTkyQUcwMFAvMlRVK2FG?=
 =?utf-8?B?cmxpU283WTJqaUZ2VW9zenljUE5XWUMyZmRXeVNGN0tpcjdvcTRaVXBUbjFq?=
 =?utf-8?B?c09jWkdNU3VUSmlaZklQT0tDM0JCd0FhOXpFSjBOV09XWGV4SWFWbG5vdXl6?=
 =?utf-8?B?RGpkcDFyYkgyVldyNVVKTnlweGhONXk1V015UnQ3clVqeTlpeVZUS2ZFRURR?=
 =?utf-8?B?Q3Y0eUl5c2VDeFJwN3FUVWswSTBIN0VGSzhkZm8rcU1DRFZ0czk4NkMxSUR2?=
 =?utf-8?B?K2ErQWkzNGx5NEhJZ001TEZhR0s3WTFwSjdja25Yc24ySlNvQ0ZBbm8xTzBZ?=
 =?utf-8?B?R3pyMEVDbEhqUU1ERkxvdDRLd2g5dUd6VVFwV0RLUzZYUGsvRUFibjFOODVr?=
 =?utf-8?B?QUVEdEU3eStPZElGM3NwT2ZUSHQ3UzZuQis2NEhCVXVLYjNRZ2MyR2tLVkZM?=
 =?utf-8?B?VjFmMGN4OHR6VUlsYlFQMStseWh4bVpiNUxXbjJJdmQwK2RyR2Z3b3dmYkFO?=
 =?utf-8?B?NFlGeVQvd2ZYdUc1bGovdVl4U1RRTldZZktWVllnZENPRnpUOTNVaGVFYk5H?=
 =?utf-8?B?eDhJWjVnbXZjelhybk12T3luTEhVZUIxcnI5c2ZKczNOZGJ0ekdkazZydW9l?=
 =?utf-8?B?VEdzRE9nN1BGRDBBZFdFWUlPY1g4MWlMRE5RVlFFRitrRDJWd3Z0QnJlTkdV?=
 =?utf-8?B?Sld4V29RMmhtRXgzeEpxU1NSQUpEcjgvUXRsTndlMDF3TGtBeEcvTlhmdmgr?=
 =?utf-8?B?a2h2aUtndThSa21hNUNKL3U0RTZ4Q2VPU1JtYWxIZVFKNlNlYlpjNjg5TXdL?=
 =?utf-8?B?V1R4ZHJkV1g1NzdoZk1rT3JaQ2Z5SGNNaGozRFJzVlhXYTFSTGkxM1o5VWRL?=
 =?utf-8?B?cGJ0VnlSUGRaaDFwd3MxTzZUd3hFSnIySkxSTXA4SDkxSjhjeTRacjI3OE9u?=
 =?utf-8?B?VWs1WlNSZmc3aXR5ay9Fb21zRmVlZHllM1JWNnluSWdaNldFMCtvMzNkeGlN?=
 =?utf-8?B?b01jTytRYlFBcVorbUJ1c2ZxUlBEWEZHYVhyQ2o2aDlPK3NNaTlwMThRblRT?=
 =?utf-8?Q?gmnRR9rQXIh11?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QVFvZzFQMnlHS3liemhEeFNGREhBQmpVbE4vREtneU82SkNlSDN1aUROZkh5?=
 =?utf-8?B?dEUvMmtubkZXK01RZ3RvVW1GVlB3OEJ4SnduRE9YaDZoM2xONFlERWpTOXVt?=
 =?utf-8?B?amFJQkNsdHE5dTFqdXAvaWtPZXJOY2RtUzQ2WjdZczFKZ3ZlL1l2Z1dQZjdz?=
 =?utf-8?B?UXN5c0hPRUtHckpVOFMzZ3ZIN1JVYlpYNWxYOWhQMlVIcStkR0JZT0tEUTc4?=
 =?utf-8?B?Lzl2REZIelpmZVhySEh6NGI1VE44U01sU3EyRklRdmtVZGtNT2ppT29BMGFV?=
 =?utf-8?B?bHN0NkNMT2pxWjhpdkNVWUF6ZXk0YjR6VFh1aTZJaURFVUlwRWNQVHo4NGd2?=
 =?utf-8?B?MS9rSXY1S1NrZUxXUFZ2K2JSNVQzQk02TUxmdklHdER1TTRVMkEyYzVoMGc3?=
 =?utf-8?B?RE1DamozNXA3azhYdEd5NW5xQVFJM0I4YnZPRUN5blIycFYyR2ttZDRUWUhh?=
 =?utf-8?B?cXo0S0ZWU2ZISFk5VWJoNk9nTjBNWTBVSnRjS1B6LzN3ZmExbjFwM3plRDFK?=
 =?utf-8?B?UGpZcnp5a1lDSFNXNHczZW5pTkJUZU5pQnU1eGRQWCtQRlhOcFJqVC8xd3Rq?=
 =?utf-8?B?cWF5L0RaYkpYalJ5UjRhRVBCZ1hiYTNxSDZnMkJ5TnAzUjdmVm5BUGF3RmRw?=
 =?utf-8?B?SDd2bFRhbjQ3ZkNVUnFuWkpuMDFmK0UrNVlZTnhvcTlNeVUyeWNZcEhQZEs0?=
 =?utf-8?B?dVJ4OHJKdVpTR284WmllK1pyamltSDlxNlhXTmNhaWNTUUlVaUMyS2hVbGNl?=
 =?utf-8?B?NE9rQXZtT1BmWXhxeXgvdCtuMFZlNlY1V2lrVlVCQXR5TjNDaDNlNXhqQXhF?=
 =?utf-8?B?QnlrWjBBd0xWZlVrT0lXZjF3Y0NWbGd6aUZhQ1FCV1ltWXJkaEllNE11cnI0?=
 =?utf-8?B?dFpVb0VHWjVsNVJxV0NJNDNwUFVicUxSaUNiaEZVL0x0dmxxK0kyM2dCaVFH?=
 =?utf-8?B?TG9QNVlrcTlXU3owLzc5RlNHRWpsNE9HRlFlT29SUEdReWJpcVBpM1dhVUFJ?=
 =?utf-8?B?UGtFbWFFR2w4QVBvME1hTTRxMFgxeGdzT2YweXlEUThiZ21HQWxNcmVVRWhH?=
 =?utf-8?B?UGhhSGt0QUVqeUxjL3BuRE03SXJKV3N2YStSQ28zNlYwMExOR3psZUtydm16?=
 =?utf-8?B?Znp4Y3hycytQT0FldUR2SDJqRHhuQWQzR0V6dXFlVVVtVDUzUmxxa2dIY3ow?=
 =?utf-8?B?MWZ0Z29kY0lnZlRQbWtXKzlXcXhhVDlhUzVSSGN3aHpXRDdGd25PcExaUW9k?=
 =?utf-8?B?T3NoVnk3TGZ1WmErMmxTVE9sbEdPbVpGZkZ0Ync1QjdUdUFKZXlzRWp2N0pu?=
 =?utf-8?B?WTFGZml6Q1U4U0NXQnhBdCtLRHVGMTBxaHFMVXVvTW9GTWNjRUhwSFFMWXdQ?=
 =?utf-8?B?b0JWQmRVbTFRaVUwL3dNejhIYzZKckxmQzVZVlByTTB4bTgxRUNmYUVsRTVG?=
 =?utf-8?B?b0xXUDFsSXJ4NlNhKzhzMlREekRQZmI3QjRxeFlvUnoxTWJXRyswaGI5eEo4?=
 =?utf-8?B?RjEwV1VZVUdrTXlTdHhDdGVkM21MN3dOTmJVbitjVVFaVDVtV09IWTBSYXFy?=
 =?utf-8?B?dWZOQkpaZngxZ1VhdUxQQ3JLcGx2aFhwZm5QMWlnRVU0cHFILzNLN0ppRlBE?=
 =?utf-8?B?VGRDWmViaklieUFZNmx3dnB0c0kvV25tOWl2TTE5V0pFTXBhSmxpVE9Paytu?=
 =?utf-8?B?clBaS1p6U0NxWTVLVGR3V3BldkpTUGNCc3FKMGllbGkvaXpOQi8rb0tnREtl?=
 =?utf-8?B?bzJ5OWdoc2pCelBUZFIxY3lrd0hNKzZlYjJzWXhnaVZBV1Ztc05BSjRMbHpq?=
 =?utf-8?B?SkNLR0hmTkd3cjNtaXlvQXRESWN0bjQ1YmJaOHVEait4NHpZKzFHUkZScFZm?=
 =?utf-8?B?bXNUK0NIUnc0NVNXVW1WT0RVejNSdTRUVXROQWsyQ1Frb3FnM3FGNjNWNUhB?=
 =?utf-8?B?WmxrTS9GNUdzQXNKYmU5djJsMDZKaG43OGpBTHJpZk5abXJ2dVdsT0UySDcw?=
 =?utf-8?B?eFJGRW9kWmFCdGZMNlFIVlpkR3NnZkg3VVNXdHpUcGtVVlZBRFd6NFNTblhh?=
 =?utf-8?B?aW1BdVRzTXZ2MjZmWlhqMTlXQWdXa3AyZnJaUS9kNXQyL2gvUTZQV2tzWUp2?=
 =?utf-8?B?Y2NSNFY3SU9jMEVvNzFFQjNaQ2JxU2lQdk1vWFpWN2o1U3g2SUlPNEVLUk5J?=
 =?utf-8?B?T1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b47eb7e-6530-46eb-1540-08dd410f5996
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 09:20:34.2071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2FOFstGZ/OeyE9azjRwoZImG81g6xmrc/4Ca3n8BRruLgWW5o8GkP9IEP+dWzbjXxt/jmgFClgreC3xPgYt4lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6360
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 30 Jan 2025 09:20:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17694

On 30.01.25 10:01, Quirin Gylstorff wrote:
> 
> 
> On 1/30/25 09:45, Sai.Sathujoda@toshiba-tsip.com wrote:
>> Hello Quirin,
>>
>> I believe we can drop qemu-amd64-secure-boot-encrypt, as we are not
>> testing that image in LAVA.
>>
>> The target being tested in build:qemu-amd64-base, is very similar to
>> the prior one. The only difference is build:qemu-amd64-base
>> additionally has security packages.
> 
> Then we can drop
> 
> - build:qemu-amd64-secure-boot:
> - build:qemu-amd64-secure-boot-encrypt:
> - build:qemu-arm64-secure-boot:
> - build:qemu-arm-secure-boot:
> 
> because the all use the qemu-<arch>-base which enables secureboot and
> encryption.
> 

Confusing how "base" could become "full featured". I guess that happened
when we started to enable secure boot and encryption via the security
extension.

Looking forward to a cleanup! Please also consider if "base" is still
the right name then.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center


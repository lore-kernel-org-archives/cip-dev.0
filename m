Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83824D232F5
	for <webhook@archiver.kernel.org>; Fri,  9 Jan 2026 08:40:46 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.29])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6258.1767948039343761494
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 Jan 2026 00:40:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=syMYyLoH;
 spf=pass (domain: siemens.com, ip: 40.107.130.29, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kjhxu3feAQ+pUrUxylCf4RQ8VX3DG+345nrl6IfuSgyxeZf8M4oHW5l0KfK3EHuASpJTTJ5Tc4X9K4sbq7JLt1+of3rEQUc/5eYqf4kfPcZZoD7P2WcjiHBAHBiE6S+iS0NzO6noTGcaEnT+1eYbnpOuUKk7pd3Ns1DcyjKW4oHe0YZHGyVdaXYF9z1LHRdlQ++HOP/zwA2wJA8scT1W3HvxSSeqMzmyQ544W2iqKLImSGX6CHphdFkuMoEOX7sP+HJaGKp7s7EpcvttI6wQrbpzc1DeducWmIXxEBI8k9SAtx6cYS8y2iPKZmT6fOdtJtEqCVqjdN77N2uao+4pJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lktfUnkWUK1wASjl5IlYtSd62ilaLq86fi97TU/Rmaw=;
 b=A1Fusrt87yV0YjKVFQ2fyluDocErA8lpjVFzYwNeOpcFK0e1ZXu+JxUU5K5aQ0PK/CsLWwSWIrz89E3QdvFVTflJ99Xybps5JF6anJUEF1XHY58zkCDHLIoC1MBTYy6N49BLNAJXzZDtZFC82vWPlnC+3MXxSUUaWxoWlwhPU6hws9yebSEoafU3BvZWejh94erV1pM3ljWpizkICllTS4dczdDCVtqopkjtOHft7og5RgBrqSlmhRVS+UPd/NVRy0HYxkDvGhsBlKol4mtGU3AQ0eL/lPMpPxWD9GgFsVlLbeN7yC0Jf67kcsoWBr+gNyr5EVM2b1IPku5+TM3t9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lktfUnkWUK1wASjl5IlYtSd62ilaLq86fi97TU/Rmaw=;
 b=syMYyLoH8uxe3vbWNbD/EvCFCCzfzW2QSMGHO5k5WNG+3RfFte+9JJu1gjQpXvix4zYhB9DqA2EfW+KZO4BOI+BCGwGI9tiqZ5Dlotp5DGEzg5VWqih8WccVaLxH3PV3w7SMavTCqknWI+AKgx6UTHlbXnESOM1yyZFdRPQwhB7RW0Zmdkqrl/Al4eQXaPCq2+9cVHaqqRJqvn6wlTgjBYqjhZ+NHG++2Tg5VM+FzsU9DpRioFUNdDDGlV99OwH7wSapCmrRggTK1zZCBcT/70ur3HzNGpsDAnD9JwPlV0jgEpvkiORu8G9axNh7bPwGO6XOG6umnKcXDfSOsVJs/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5932.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:39c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Fri, 9 Jan
 2026 08:40:34 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9499.003; Fri, 9 Jan 2026
 08:40:34 +0000
Message-ID: <4dde8854-a474-4c59-ad12-0279bb239de5@siemens.com>
Date: Fri, 9 Jan 2026 09:40:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v3 5/7] Add swupdate-config to
 swupdate.inc
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 clara.kowalsky@siemens.com, benedikt.niedermayr@siemens.com,
 cip-dev@lists.cip-project.org
References: <20260108151650.124306-1-Quirin.Gylstorff@siemens.com>
 <20260108151650.124306-6-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260108151650.124306-6-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0063.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5932:EE_
X-MS-Office365-Filtering-Correlation-Id: 413170fb-1846-45d6-1408-08de4f5ac156
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Y01NZjVTUThzNFZYdzZpRit5eW1FS2VsS24zVlBERTBLejl3YmFOSG81VVNW?=
 =?utf-8?B?cEtQWGVtc042elJJMGJJS0tnYkc5MnFIaWpIc2oycy90cEJpUXVDcE1MMWJm?=
 =?utf-8?B?OEY0Z1NybURuMzFldFF1VDBNaHBSVlQzSkwyOHprVUNsNWZuNUZzeW1yd3JO?=
 =?utf-8?B?a2FqaTVJenl6akNGOHU5ZlR4TDVROVhVNnlNaVl1end2V1kvbHVJTU9vNmFk?=
 =?utf-8?B?VXVDM3piTUgvMlJCRUJRYnZkcnREYTZ3UHlpNk4zMmtHR0QrR2tRREo4ZjZN?=
 =?utf-8?B?TmhHdWFwbW1zQzZDOWZXd2taK3lrMm8rQlhqWG5CUEhWbG1KaHZUYlZhNVhm?=
 =?utf-8?B?a2RNSE9nUmZjcHhhRFJ5emNYWW1zTTEwRTlNNHlLMElKZTdHWjJPaCtwMkUw?=
 =?utf-8?B?d2hCWUN4dmtWcjd0TitWYy9GcXBRV1dVZnpHeXlETXhkQzNrUmdSanVDK3JH?=
 =?utf-8?B?YVJxaEFheFZDM1IrOU9ZVUVEcmdjVTBnaFdtc3RRUzd5YkFnakYwQWNzV0ZP?=
 =?utf-8?B?ZGpndnpqL05SdlBXRWF0V3NqejlINnIyUXVNdnNsa0pYMng5VCtwUTRGUHJa?=
 =?utf-8?B?NFpwQjd4bnVoTVRSMC9ZMlVwYlJQcVZKeTBjQk5FRUtacjlOeXd6T2ZsMmh3?=
 =?utf-8?B?YStoaS96VlVHS0xsZmRIRHlQNmlSRWUzMEEvZ04vNFRLWGsrd0FzWVVjcFFv?=
 =?utf-8?B?QVhYN1N0cTFRcDgzUlVOQXFnWWpQb3A1aWIvQXRIb2VmeDlaWFc3SVRBeS9S?=
 =?utf-8?B?VSt0QXROYnREWFg4Vms1MEZ1bnBDdVcveWg1SDMyK1hMUTM0TCs5QlMwa1JL?=
 =?utf-8?B?aVVjL3A5SjduelpZUm51MzhXODlJNUV5cWRCZVg3WW5YNUxVRThLS2MrbG44?=
 =?utf-8?B?eWNDclRBSjk0ZGpMM05vUlI1ME1tYjMwRXlVOTBiZ05qNzB5WWlSQ0JmRExL?=
 =?utf-8?B?U0dmbVlyNTFtNW14MkFCZDgreTlIK0I5cm9yNE5pR2gxVjNCR2ViL1ZCSFhs?=
 =?utf-8?B?WHVzTjh3MXlZcldyVERmNlMybEJRTWdSbDNlcFN2Kzl1cElyQ1orODV6VWdt?=
 =?utf-8?B?RWErdE5Fb092U3BWQjVNbG5iMmpsMjdMWG9yd1YySTZYdUpZMHIvbXl2VnhR?=
 =?utf-8?B?Mm5uSHMvdFNoYlFwcGVKd3dRdFNxaHdmKzZyZ0RvY2I0ZWRKUjhpeS9RUGxw?=
 =?utf-8?B?QnB5OHRXM0d3b1FhTmhoRVpSRmk3dUZPak1rekxWTUx4Tk5hbFlZTGF4UU4y?=
 =?utf-8?B?bjljMVpya09IZ2hSMDJNOC8wWndDSHZ5Uk0zbmhQcnQySHhmMmxxQTMxZ29v?=
 =?utf-8?B?eGV5ZGN6SWtKbndYM1BCa1hRRnRld2JqSU9MMHptSDdjUGE5QU85UHZsblU5?=
 =?utf-8?B?cWJwNjdQdDNlQ0k3bnhKcnMwM3J2YWNpZUVSd1V5OG04MndIazRhSFU4V3RR?=
 =?utf-8?B?NU1ZeHNvcHBLaEJ5V1JoTlZvSjRFV1NOVjhycHlqRm54dVVkdzI1Tk4rVTNO?=
 =?utf-8?B?ckRFcWpDUjZoRUdKNXdaL3lJSHQvVDgxRDlIU2pVOFZoRGRGWFZKODNsK0dp?=
 =?utf-8?B?QVNrMXlhazhkdVZESjdOUk8za3JNa2JTaHkydDZZV0IxdDVIWmpEeVM1Q1pr?=
 =?utf-8?B?Q1JhWDJUVUQ4cVdsQzdzeGFFQVNybHZSblF1SGxZQVJiaEpJd1ZXcE5tL0Nl?=
 =?utf-8?B?ZTljUDlJSVhEN1h1cWZXNjQyQXpBQVUxMjR4VkJDZ2pOVm5iU2Q2NVN2aWpH?=
 =?utf-8?B?WnZPVlFPSXBkS21VaUdGemsrVTVoeVJjL3JPVGRiRURxUTB4a1J4UDZPaXRq?=
 =?utf-8?B?Rkc5Q21lRGsrMGZBN2YzMEZSdDU3U2VwbjFQeTI5YkJRRmVaSTBNWER1V1NO?=
 =?utf-8?B?cFBTQytYWkpjMkdzY09YY2liZVhRTmlrQ21TVk1KNzBWSGN0VDFVdTl6Tzdn?=
 =?utf-8?Q?mrWPEN0/zFVImTR6a7A5YAbn93Uk32k2?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bTZFamZwQXZQVFRVOEZkRWNBNzNsa0NwUGxvU2tBR3JwREdnWXE4ZFVpNVA3?=
 =?utf-8?B?MDhZa3RLNW5ITzFjSThIZ09FMHhEbTFiOTJwcUpiUllGc3RPbGh1ZUFRSFdn?=
 =?utf-8?B?bDZyQmJMNzU1bm5YMEVNQXFtenFjM0FvMWtoNzNqemZyN1VGRnZld05RbytQ?=
 =?utf-8?B?Z0JXa1FhOFFiNmRFeTVZd0JQOVE3ZnQ1ODRYckQxV0lQVnhvb2FzSEVxbklH?=
 =?utf-8?B?ZnNRWW5oV3c2R2xvTGRXOSsvbmxhUmxVVVlIVW9BakZwN2JsSU92M21Xa2kw?=
 =?utf-8?B?aExwTmg4QVV4RVgzSFN4WE9WL0xtOU1uM0JkRmZmTHVYd210dGkrWUh5b2V1?=
 =?utf-8?B?ZGE1M3NDY3FvZ0UrekJVYmU0My9Sd3RNMXU5V01UVGNyc3ArUnhGT2ppVDhl?=
 =?utf-8?B?SENHZFVtbWdQU3E5c3FGR2NOVk5TcmVVNHVJVTBFMnFoQVJud3NiZWFvVFJM?=
 =?utf-8?B?YWxsSktzUjJ0Wit3UVNwNmRCTTdGcjFNTjZHU0tmSlFjZXgxR1B4RHN0bDFG?=
 =?utf-8?B?MXdYeG4rMm9keHFKNFJRMk0zdldQdjdDR21zNk13MDlTTmN6djBCakYyTVhE?=
 =?utf-8?B?L0FDS2Z3cnZMSnhYTWN6VVNmRHVmWkRxUnZKMUpsK1dwdWZuS0V1STJkempM?=
 =?utf-8?B?VllEUndLK3JGMG9DclpYd0d5TTBvT2ZJQzhxcmFGNDM0UWNrWFBlTzVJK2VU?=
 =?utf-8?B?RVZzMllueEZ0MC81UnVEaHUxanY3QmlTOFBLNmh1Q0dNcHlXMVMxTk96bm1C?=
 =?utf-8?B?TnZ1dlhCVzJydlZXc1luWXAvOUFZakJaYWZhYXkzd25uQXdBN29VUFgvWFB2?=
 =?utf-8?B?M0xzK3NtU2RGUTdWWDJJN2dvaXdhYXRUVXNCVjZldDgyY3lERlhrMFlMNC8x?=
 =?utf-8?B?QzFTMWM0cWltaXJnUU5NOTJGNjBkRSs1dnJUOGY2ZU9CYUdvRGVCa3pIamFw?=
 =?utf-8?B?UTdjb3NzMEZWZFJMN2h6SXRNQ2Rhd0xYb0I2R3NRWnpCZkFJU1lINHloSG5S?=
 =?utf-8?B?TVJ4V2dwSytYR2dsQTB2VFdPNmVld2NXUHdoY1FvMFJJSGJIR2hzZUNxTkdS?=
 =?utf-8?B?ZVgrM1I4VVFicG9jZUdKcXVTeDE1RDVaaEFHS1hjZHRxRHc4dXgyUEtWVVE5?=
 =?utf-8?B?NEJJZHNiMkJqUU83YzNNaVZIZE5YcGVSQW5xNUdqYXdZOW1jWFo1VCtnNlpG?=
 =?utf-8?B?MExaYTA3Sk1NZVZjS05qZ1J6d3d4K3crcnJsdWpKMU92T2tBSlNKWURQS3B1?=
 =?utf-8?B?UGNjM2ViMXhLdUM4NFovSS9mbG0vS1BJQzN5STBEa2tma1VnNmErK3BXa0sy?=
 =?utf-8?B?N2pJZktGU3RCYkdaQlVvcGVWVTdUQXlGTlRUcXBIeDNWcCtmRnVtMXpCcThL?=
 =?utf-8?B?MUNLQWNNZzdGY0FjREdteE5mWEVEbUt3K1NKbTR2Vy9waXU4ciswYlM1dkh4?=
 =?utf-8?B?UGNFamt2SUkzT1NUUURyNnd2VktKNi9NMXVrWkptMTdLSUZrbzlDQVJWV2JF?=
 =?utf-8?B?MUNDZTFLQ2xGNjVHcVJTaTAxdk1MRUNYeVUzY2lNWjNoNFlXRXF6QVFLS2J6?=
 =?utf-8?B?Z0VRbDFFYlVmbHVIZ3RTYmloZjB3RktNVWxwSXBYSGJReG1yUUxDUmZpWlJi?=
 =?utf-8?B?SnZtWkFlanBpeTBjSzRDYlFxcE83UWREWVE0MERSSnJGbHNsdTZMRVArZjVl?=
 =?utf-8?B?VWw4WnFzaHpDOFZvWmI0anR0N3AvUTBua0wxbnRBaEVNSnZ4dFA0TWF6NjUw?=
 =?utf-8?B?czZvcUdBWWVyc0NITzYyRWVyR3JYTWxNYk9KNW0yd1pZbDhUMmVjODJ3VXJr?=
 =?utf-8?B?eExjS0szZ3ZIc3hYcEVRTW91NExHc2ZJT1crcTFrZHJ5SzNETkRkZmtGNXBq?=
 =?utf-8?B?alNLdVB4ZE9xcHNMcW9ITmlGMkdOdkF6bnBuM0lFd3VOWkJ4UU9ObHI4cytQ?=
 =?utf-8?B?c0hTbmZMU3YzMnhhdUxGS2MvL085aVhBTTl6dmRqMHJ4b0ZKbUV2TUdZWW1p?=
 =?utf-8?B?SUIrSzUrbU1ERXZHN2tNTnhYakJLd1ovNldQMzhlVWRQaTdrMk5BLzNJZi9x?=
 =?utf-8?B?MkF3VFROVGY2ZGFWMDlZQkJKaHpoTi9NbXVoMVVrYkUyb2hUODZBb3hKL3c5?=
 =?utf-8?B?YUZnRiszYkVuQTc1VVhpV3FiZUZDaXJyTW1mSVNzR0dPdiswalNkYVc4Q2Fl?=
 =?utf-8?B?bG1wVmQ2Wm5CMGRkZU4vQUNjK2ptWXl4c1JQdVhFMGhyV2JtYWRuSDlRVERa?=
 =?utf-8?B?YzAzWXJaaWVIOW5OOEY1cUFaMTIyKzZmZ2dmQ0wwd3lrYkhacWRPMkkwWE5i?=
 =?utf-8?B?L0lmY2E0TUM2VC8xOGcwVkh4VkdyQTJGZTFEVUtyK3NPMkpRZjNzdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 413170fb-1846-45d6-1408-08de4f5ac156
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 08:40:34.4759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ed0K1QNdurBtOgmJIxlAZE9gkTm7PMS9rNDIXYy/GK3Rvb3cBN/kIcNPRvQk9LZwCri7PEoMVo9Yj80RtNH6mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5932
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 Jan 2026 08:40:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21491

On 08.01.26 16:16, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 

"There is always the need for an swupdate config. So, auto-include the
swupdate-config package. If downstream needs to modify the config, it
can bbappend the related recipe."

I'm adding this as explanation.

> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  recipes-core/customizations/common.inc | 4 +---
>  recipes-core/images/swupdate.inc       | 1 +
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/recipes-core/customizations/common.inc b/recipes-core/customizations/common.inc
> index 37872c1..c4d201f 100644
> --- a/recipes-core/customizations/common.inc
> +++ b/recipes-core/customizations/common.inc
> @@ -1,7 +1,7 @@
>  #
>  # CIP Core, generic profile
>  #
> -# Copyright (c) Siemens AG, 2019-2022
> +# Copyright (c) Siemens AG, 2019-2026
>  #
>  # Authors:
>  #  Jan Kiszka <jan.kiszka@siemens.com>
> @@ -27,14 +27,12 @@ TEMPLATE_FILES += "postinst.tmpl"
>  TEMPLATE_VARS += "CUSTOM_HOSTNAME"
>  
>  DEPENDS += "sshd-regen-keys change-root-homedir"
> -RDEPENDS:append:swupdate = " swupdate-config"
>  
>  DEBIAN_DEPENDS = " \
>      ifupdown, isc-dhcp-client, net-tools, iputils-ping, ssh, sshd-regen-keys, \
>      change-root-homedir \
>      ${@(', iw, wireless-regdb, ' + d.getVar('WIRELESS_FIRMWARE_PACKAGE')) \
>  	if d.getVar('INSTALL_WIRELESS_TOOLS') == '1' else ''}"
> -DEBIAN_DEPENDS:append:swupdate = ", swupdate-config"
>  
>  do_install() {
>  	install -v -d ${D}/etc/network/interfaces.d
> diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
> index b2fe4ac..7cd816a 100644
> --- a/recipes-core/images/swupdate.inc
> +++ b/recipes-core/images/swupdate.inc
> @@ -58,3 +58,4 @@ IMAGE_INSTALL:append = "${@' swupdate' if bb.utils.to_boolean(d.getVar('SWUPDATE
>  IMAGE_PREINSTALL:append = "${@'' if bb.utils.to_boolean(d.getVar('SWUPDATE_SELFBUILT')) else ' swupdate'}"
>  
>  IMAGE_INSTALL += " swupdate-handler-roundrobin"
> +IMAGE_INSTALL += " swupdate-config"

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center


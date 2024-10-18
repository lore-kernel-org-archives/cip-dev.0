Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC81D3F2B4
	for <webhook@archiver.kernel.org>; Fri, 18 Oct 2024 22:01:14 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.63])
 by mx.groups.io with SMTP id smtpd.web10.33429.1729288873745925896
 for <cip-dev@lists.cip-project.org>;
 Fri, 18 Oct 2024 15:01:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=RScsCO2u;
 spf=pass (domain: siemens.com, ip: 40.107.20.63, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XluhIkrKVALDfrnF++CpfEV6RimjODWezrDqMki2VPLmSfh/earsnIQhyYy/BFxD52rh2EV868m8Oqxg5UgefG0CjVRyDkONzAmDHFftDI5mhm1TyzBIS+/iQHM34VKBz8gyXRBmHsl1bHI134SuZlK7950rqVs/CNwimt+9Cv5TFgOKt5tHxG9ztalpCgRdtYtA3aQ11CekPJEMZkrnQfGVstYaUhIyfF427QNqt7mnDIHpJq2XJqZjOkBmngSeHjiXkZCtvsFdGwDlQZyyunzT3LYcigLoFSoSwekJFIxe5YuDgXaUbhWI/+UYbeMqKcYnlAR8VYBNtg88sMqNDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Ul3LD0vOWoeB/etp6T0mJRrm3MNWPyK66MtjLTDRa8=;
 b=p1c55I3SxpV9tgce4socd7BiX0VxgD4Q8X2PdT8qaItyfjdzG0tFvi1b6HqnHBuEvV9k1M0+EtUP4VcLVivCkWVCZ6zv2bZiycIgU9PSK+tYBrP35Fyhvp3n+PjVSL0vSYH2CyuqDo+ApzgyPqx5OIlttQM1HUDFYxD4nelVFKpGIH/DHIGcGVdUTQ6Jk2zDUCMzOFu9ju97/MZtueI6Dzg6xU8cai6XMqCu0J/jOfhxOE30tTM8vhM+lL92L5ZT6unjWJnHtn48+4Gj4ZrHyJOy/+V08wgeEONto3ftLjZB0dD0Hk49lFHmqU0D+6+Xn4khywF6RTQxmPqokQYasw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Ul3LD0vOWoeB/etp6T0mJRrm3MNWPyK66MtjLTDRa8=;
 b=RScsCO2uY69acE3ddRU9iXx48tOkT8+XIEMtieRxrV48tUvu8N6eN0/nojpMQcaiY0Q5eTiwfwAAMxt/FgIRFvzA+tjZCtkh8K83nsG5DH+ICPwqEDZtsaQDmDMuJjBCI3Iw3I6A6CLJV6KeQSXX2Z9ueMaHIU86zhiT0jTSS+2A9RuH07O+bX4r4swgE+hFhq7pfW6BD975i/7WWeTiNCPCORJTSEtP0wPaTOmaZDIdIG22BizBstRSbBhnpJFvYpmLzNgF5eoUFLJUo2gSW40mCYq5Qdju24e23ycBTaqH05P6j4XtZRSFUFgvaRbnIjqLFMMalkHiuml3/2j6TA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB9187.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.8; Fri, 18 Oct
 2024 22:01:09 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.8093.000; Fri, 18 Oct 2024
 22:01:09 +0000
Message-ID: <837fc259-5462-44ba-a9c3-90c4011b994d@siemens.com>
Date: Sat, 19 Oct 2024 00:01:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][PATCH] distro: add preliminary support
 for the upcoming Debian 13 (trixie)
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 cip-dev@lists.cip-project.org,
 Cedric Hombourger <cedric.hombourger@siemens.com>
References: <20241014155604.569003-1-cedric.hombourger@siemens.com>
 <d59b93d9-44a0-4adf-bb7a-c97d12e1c1b9@siemens.com>
 <739eeffd9c49aa0a138752eba0ff861702ce3907.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <739eeffd9c49aa0a138752eba0ff861702ce3907.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0303.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB9187:EE_
X-MS-Office365-Filtering-Correlation-Id: fe3b225d-5472-4a6d-52d3-08dcefc05f37
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?aFhQRGtaM1creDNENXdiSG1mUjBtZ3I4d2NaT0hxUnVmSmlBNkJvTmFVQVhv?=
 =?utf-8?B?TzdhRnh1d1M1QkcwM2dEb1JOTDEza2JGbHBCZWNyb1FGWHk3V2lENWlvOVRa?=
 =?utf-8?B?enBVT1NPYXpxQlM3bkg3ZHVLODZzc1N3VTN6WG0xOHErTlN4YS9MSTFuTnZ1?=
 =?utf-8?B?K1ZwUGl0Q3lFV3lmc1hMUGJJcTloNnJqZ2F5T3oxckJYNE9tUHMrVG8weG8r?=
 =?utf-8?B?TFNIQ0JyVVFYUCs4M080a0Z2S0JOWmVRVEJYMjM1K1RnbytqWlQvZTh2U0hE?=
 =?utf-8?B?UmV3UldnSEQxMy9LMHZhUExjS3FJNG4vUU0zcTQ2TWhsbFoxTm9qN3JpTDZZ?=
 =?utf-8?B?VzN2M2w0bFhwSktvZVkycU9QcWdCbjFkTWRIY1Yzam1PSk9uWmlMV1dndkNB?=
 =?utf-8?B?RmFSRkUxQ1p3SVU1ZW9BR2R6dTJka00zZUZQR25aVGFrRE5rTnFidDNWenE4?=
 =?utf-8?B?NlFhekwzOEdVRERoaGV3ektGazZpK2dSRzNtdjFjMGV6bEpLNVpJZmVUMEdS?=
 =?utf-8?B?eTRzKzB1dVBFL0FQdXUzSlBxd1NNbFNhV2NZUC9HaE9kV24wbkpqSHpGS2NW?=
 =?utf-8?B?L1IxSjVtN3lkdVRWVDdqZGVDY2tHcXhiMGxaWXZWS1NlSnhKTlBwWGFwR3Zp?=
 =?utf-8?B?Yi90Zk9ZZUxxQVlzTjYwTFFwSmJJU2svRzBpS0pLeEp2QWNaaGtxRmovY09z?=
 =?utf-8?B?eHZWYy9RNjRNcXFBb3BXZldjdHNKNHZhUHZPNnVveDFyVVVNYThlbWlJUWxp?=
 =?utf-8?B?NHM0eXlzdmRzdXlKMy9mK2c0RUFMckswdkVZY0xmYmUyVFJ1ME1xeXZEVnAv?=
 =?utf-8?B?ZTl3cFphV290dTIvREx2SWw3ampyajZ0WUxrT3RqNDkrK0NSd2ZCTG5jQjdJ?=
 =?utf-8?B?VVZqMWRiWjZZcTF5b0Y2Q3VNdFZWTkh6elJKRCt5NTVzV1MwKzBSMFpXUStu?=
 =?utf-8?B?dHhJQm5Wa0RCT3NsZ3loMTd4SGs2V0hpcDFqTWk1aGJQWjJmWERDVzFJV003?=
 =?utf-8?B?UzNJemJHMzgxNlJUZzMwb3JnYS8yT3VKZGVxbUoxQ3FEcXMxcE4weE11OGlL?=
 =?utf-8?B?ZFdMRlkwSkNrMDVZMWd2UHU0Wk10ZVdaV25NWFBtM21Qems0MnJVNVBnbUM0?=
 =?utf-8?B?bXV3N1NUZlBTbEF3Zm9TL3RFSDhMajQxNnFiMFNlUFozQXZYREZjdVl0MDdy?=
 =?utf-8?B?QWs4Ulg5WWlhQkdrelE1Y3BZWnhCZzlMWGpwNXJQbmZDR2ZkOEFzMlZCcEJh?=
 =?utf-8?B?bjVmMmtOa3F5U0x0L2JvMEhud2ZoRHNYZmgxcFpHUnVBWklUOGlBQnhkV256?=
 =?utf-8?B?U0U0NnFibWFnTG1Xd25KT3BRK0pzK1ZxNFd6MHkva0VvaDRaSEZyYWJpNllk?=
 =?utf-8?B?WnRwTXhiVUFsS2l0dlF1TzJaUkxrZHJta3kzNmo3OGsyZUo0dU1PbHlocVJM?=
 =?utf-8?B?ZkVKSnpJdUkzbUdiQkpXN1FWTDhUL0R5bjN1ZXN0L1V0ZkhUQzNYZ1IzQnh0?=
 =?utf-8?B?M3pQeW1RMmI1alkyYVF6cWRSS20ya3poNDRBNmNZK2lsNXBWbFAzeElGeS9H?=
 =?utf-8?B?dHJYaCtOUHdXT3pFQytSZzhYMjJvTnF5MUROeVpxWEZmam9HOHMxRUhWOVkr?=
 =?utf-8?B?dWtDelRZTjhYajEyM2dpL2Ztd1ljOEdQb2t2VDM0cHJGM0NWTjVocDNtRlBl?=
 =?utf-8?Q?pv1g2ZkuDvExqcg43Uop?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TENQTUNlZFB1djNRR0hwU0R1S2VMbFdzZ1cyc3lUNzlyTmV5TmRVSVpzOGpQ?=
 =?utf-8?B?WjliTCtJbFFOcytCd1ppTytwUFF6ZjkwcU1VZTZoMTlFNG5XenhwV3JHaWNV?=
 =?utf-8?B?aG9kYlBXSFdIa1lKUlhiN1FqTWJwZmw4YTNkaUdmZWtWaXBJRDFBa1l4Yjdk?=
 =?utf-8?B?SFlvSDFPK2JPZFZkK05VS3U5WUpxSVBJR3BVRmVENTJySm92bkhYUFlicHJX?=
 =?utf-8?B?dVRFcXNHL21ZdTR4K1RzRFVubDBmZ2MyQzlpY0RmangwQmlvUzFBUS83eGxj?=
 =?utf-8?B?S3c1N0U1NG13M0NHWEdqa2Z2VlU2RGFNb054TERSRS9qOGdzQW8wNnNzOVhZ?=
 =?utf-8?B?LzNhZmt1d1UxZ2REczh1Z1oyS3NQM3BMSklrWXVPSExiVis2Vm0wVWtFbGRE?=
 =?utf-8?B?c1F0RjR4K1lNOFMxK2NWVFpLRmtCMU54M1BpVldpMGxua0h0MFUrS25MOUhV?=
 =?utf-8?B?a2h2VXpKUEl2OVc1bStZcU5YancvK2h6MkdreUZnYi80cTBLaXFXL01hbHFW?=
 =?utf-8?B?aS9KS1F3ZWw1TDdHeU12dW5FQ2M1STJYU0JwZmpNZUtJL1hWek1XZDc0bUhO?=
 =?utf-8?B?TDd0Vkl6d21vZ0pULzI1WTJYaHBERUtKT2J2T0pQVkVzKzZpbFV6RXl6aGY5?=
 =?utf-8?B?MnpMTU5GWHp6SWJyQjVEUGQzMTZ1bzBvZ0QrQkt0dm5wMmFnVUxSU2prUG0v?=
 =?utf-8?B?YUU1R2NOZy9YQi9JUElER1lGb2NNS0N6WDE4dGd5WXRuVHNaTjIzRlAvbWZm?=
 =?utf-8?B?eUNVeFZQekVVVFpHN0dpVlRvTnhrdDFJTVBoQTJjdXVRZFVGajhReFI4YUlx?=
 =?utf-8?B?VnJ0S0YrM05tTkJmQ1Y2NHlnd2dGeGdLYjZWbVNVUkVTWDc0WWtDcjUrZGVh?=
 =?utf-8?B?My81dmNWM1VGV1RYQTg2V0VwR250cis2ZG01LzlJQU5CK3I4Zm5Rb1d5VjdL?=
 =?utf-8?B?UWtjd012VUNZQ2lRWUxDS3lER1JCMUZPUndOWXpKTFBmcy9ENWJCNzhNZGxi?=
 =?utf-8?B?MHN6clJZUFp5RS9OUEZ1djgvL1BhTklCRnlqOW82M05zcFpYTnE1L0NBdU5Z?=
 =?utf-8?B?Mnk2OWJOOEM1eEdzQXJjUzRwWmdaZllKb2xsQTN6aWJ5STY2RzdyeksxZnVr?=
 =?utf-8?B?NThVNVRqd0gwdjN5ZTZwQ1NSNmh6SFEvSklXWWVRVFMzQ3lNT0R5SkFnM0Ny?=
 =?utf-8?B?eTc1a0xsaGpUVFAwb3JZZTdWR0FyM3dMSHJXSXE4ZHlyR3lCRGRDWlp4V3Z3?=
 =?utf-8?B?eEx1RDlib25Ya3dkUTVsUGIrQnltekw0R1kxbmxxQkk0ek93MnduaTNYYlVL?=
 =?utf-8?B?d3N5ZjhLRFVSWmNjeDRWY1BwbElmNU1zekVPWkg4azlUN2tFMU1QLzVDQ0hK?=
 =?utf-8?B?Z1RZUUJrYkhWenArRkNETVVLam9KMXFyUmV2TVhCWGlsTDVQempDb3RnSitB?=
 =?utf-8?B?TWp1MS9HcVA4bDBMMjFnV0NDY2NwVW9hMjNMWVhhdEZSUUUvbit1NU54QStu?=
 =?utf-8?B?S2FhOXk2YldZRlczMHVzbldDOEJ2cWo1K0RERW4rZVArMGllWU5NWWRYSTZU?=
 =?utf-8?B?dUttNlkySU4wZ084UDIxaTZMaVJ5Qng3N1JBWDRjSFdZSUpScEt4TkxTU1BB?=
 =?utf-8?B?V2NJeXFxMHdFa1R5L3pXNjhGTklLME5YTUVNUnNRVXR5MTFrcWVQTG5vaEJM?=
 =?utf-8?B?TU5VazFLUVYzdmlDMDUyL0RjUmI5ZitDbjdBcCtKYzFyTkhCT3RIdSsxZkMw?=
 =?utf-8?B?Y1BUMGJZK2RtZmVDaTV2SUFaMnhpci82ZFNoZ3BrSVdrYmtQSkJmcENabWtN?=
 =?utf-8?B?S0ZWN2kxV1BsNzFsL0FKT3U0MHRiQnZ5RlJ5MHZ6eDlYSW9PckdjUmZNSlVt?=
 =?utf-8?B?NjBzNlJaUkc4K0tvM1FqTnYvYzF6N3RscklBMFBBS1NHdVc5WUtDV1N3bVh0?=
 =?utf-8?B?OVIyL2xNQWxCS0hMb1EzUm8rM3ROV2RneEd5cTF4bDZXTDRVeDRjRkE1RlJD?=
 =?utf-8?B?c3M4eU9nVUJEblo1UnVrWVo3azJjWkF0bWpWdVJHb0pWQ3Y1ZGtYTm12dVZ4?=
 =?utf-8?B?czJSOENpN0NJT3hsdVVVUzZmbXFyTWVsa040Ty9tM1pBbnZRSTdmNDNGRjdy?=
 =?utf-8?Q?uVZcNWt9bIITcdQ1Nap+yNc4k?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe3b225d-5472-4a6d-52d3-08dcefc05f37
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 22:01:09.1133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V9yS8mLZpeadwI/mGBcD6fyHo/KfEBqQdyk+/eu8DGBXiB8/skykKhBtFcqFt2zYeE1kkr+tzOSbA7oGFr3lig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB9187
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 18 Oct 2024 22:01:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17052

On 15.10.24 14:27, Florian Bezdeka wrote:
> On Tue, 2024-10-15 at 00:22 +0200, Jan Kiszka via lists.cip-project.org
> wrote:
>> On 14.10.24 17:56, Cedric Hombourger wrote:
>>> Debian will probably start freezing packages next year (first a soft freeze
>>> then a hard freeze). It is important that the CIP community starts testing
>>> Debian 13 to provide feedback upstream while we may still influence versions
>>> that the distribution will select for their new major version.
>>>
>>> Signed-off-by: Cedric Hombourger <cedric.hombourger@siemens.com>
>>> ---
>>>  Kconfig                                          |  5 +++++
>>>  conf/distro/cip-core-trixie.conf                 | 16 ++++++++++++++++
>>>  kas/opt/trixie.yml                               | 15 +++++++++++++++
>>>  .../secure-boot-secrets/files/trixie             |  1 +
>>>  .../swupdate-certificates/files/trixie           |  1 +
>>>  5 files changed, 38 insertions(+)
>>>  create mode 100644 conf/distro/cip-core-trixie.conf
>>>  create mode 100644 kas/opt/trixie.yml
>>>  create mode 120000 recipes-devtools/secure-boot-secrets/files/trixie
>>>  create mode 120000 recipes-devtools/swupdate-certificates/files/trixie
>>>
>>> diff --git a/Kconfig b/Kconfig
>>> index a70ce22..9b15c05 100644
>>> --- a/Kconfig
>>> +++ b/Kconfig
>>> @@ -136,6 +136,10 @@ config DEBIAN_BOOKWORM
>>>  	bool "bookworm (12)"
>>>  	depends on !ARCH_RISCV64
>>>  
>>> +config DEBIAN_TRIXIE
>>> +	bool "trixie (testing)"
>>> +	depends on !ARCH_RISCV64
>>
>> That is obsolete once trixie is stable enough. In fact, being able to
>> finally build RISC-V via trixie, rather than a sid snapshot, would be a
>> good indicator that it is worth to start regular testing.
>>
>>> +
>>>  config DEBIAN_SID
>>>  	bool "sid (unstable)"
>>>  	depends on ARCH_RISCV64
>>> @@ -147,6 +151,7 @@ config KAS_INCLUDE_DEBIAN
>>>  	default "kas/opt/buster.yml" if DEBIAN_BUSTER
>>>  	default "kas/opt/bullseye.yml" if DEBIAN_BULLSEYE
>>>  	default "kas/opt/bookworm.yml" if DEBIAN_BOOKWORM
>>> +	default "kas/opt/trixie.yml" if DEBIAN_TRIXIE
>>>  	default "kas/opt/sid.yml" if DEBIAN_SID
>>>  
>>>  comment "Image features"
>>> diff --git a/conf/distro/cip-core-trixie.conf b/conf/distro/cip-core-trixie.conf
>>> new file mode 100644
>>> index 0000000..58999d1
>>> --- /dev/null
>>> +++ b/conf/distro/cip-core-trixie.conf
>>> @@ -0,0 +1,16 @@
>>> +#
>>> +# CIP Core, generic profile
>>> +#
>>> +# Copyright (c) Siemens AG, 2024
>>> +#
>>> +# Authors:
>>> +#  Cedric Hombourger <cedric.hombourger@siemens.com>
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>> +
>>> +require conf/distro/debian-trixie.conf
>>> +require cip-core-common.inc
>>> +
>>> +PREFERRED_VERSION_linux-cip ?= "6.1.%"
>>> +PREFERRED_VERSION_linux-cip-rt ?= "6.1.%"
>>
>> That will likely change before the release but we indeed started with an
>> older kernel into bookworm as well.
>>
>>> diff --git a/kas/opt/trixie.yml b/kas/opt/trixie.yml
>>> new file mode 100644
>>> index 0000000..e9a76ef
>>> --- /dev/null
>>> +++ b/kas/opt/trixie.yml
>>> @@ -0,0 +1,15 @@
>>> +#
>>> +# CIP Core, generic profile
>>> +#
>>> +# Copyright (c) Siemens AG, 2024
>>> +#
>>> +# Authors:
>>> +#  Cedric Hombourger <cedric.hombourger@siemens.com>
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>> +
>>> +header:
>>> +  version: 14
>>> +
>>> +distro: cip-core-trixie
>>> diff --git a/recipes-devtools/secure-boot-secrets/files/trixie b/recipes-devtools/secure-boot-secrets/files/trixie
>>> new file mode 120000
>>> index 0000000..91bf492
>>> --- /dev/null
>>> +++ b/recipes-devtools/secure-boot-secrets/files/trixie
>>> @@ -0,0 +1 @@
>>> +bullseye
>>> \ No newline at end of file
>>> diff --git a/recipes-devtools/swupdate-certificates/files/trixie b/recipes-devtools/swupdate-certificates/files/trixie
>>> new file mode 120000
>>> index 0000000..3d633ae
>>> --- /dev/null
>>> +++ b/recipes-devtools/swupdate-certificates/files/trixie
>>> @@ -0,0 +1 @@
>>> +../../secure-boot-secrets/files/trixie
>>> \ No newline at end of file
>>
>> As Florian already mentioned, some minimal cross-compilation stability
>> is required as we cannot wait for hours on emulated native builds. There
>> is also [1] waiting for a fix so that our core features can be tested.
>> And there might be more.
> 
> Btw: Isn't that something that should go into isar directly? Why is
> Trixie support isar-cip-core specific?

It seems that there is some progress in Debian now, see [1].

Jan

[1]
https://patchwork.isar-build.org/project/isar/patch/6c4edb8f-ff3d-400c-8b3c-08601ef428b0@siemens.com/

-- 
Siemens AG, Technology
Linux Expert Center


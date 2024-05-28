Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 504B1C25B78
	for <webhook@archiver.kernel.org>; Tue, 28 May 2024 15:19:53 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.66])
 by mx.groups.io with SMTP id smtpd.web11.25207.1716909584489385393
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 May 2024 08:19:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=bm548/cb;
 spf=pass (domain: siemens.com, ip: 40.107.6.66, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZlsE4uCvwLkml7c8+WEzKD/IQrFX9VoJawL7Kmi73hnCSaMQ/sI5jjOk9gLcFgBEX57VW6YziSfFNQPU3Om/DQ8FAkBZ9xtlvyg+2Qs3wq965C2bCRo5DsvqdOyk6btYFIZUhC3LcgWD0JAReQQv0h1MnoJNf1ecvbHXufBkbwnE9fIdpqOEXIXokniEWw+SFHxb+MYgejg3N1K+I32GbN1q4OFwLFsb1iX5tYzAx5lShsR6ib9e0id4qyA/LmWURS8YOlur0yKEZstI6ZUGGY4Ux207HJ+Z/NMxIe94SzD34laYOCkK+2v+gQ4/82XlAUHOUBsONR7D2PFR5yIdyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i8eJn134jSd5ur8z/5yKLdcXtTckx5Tn3buAnBGlNEE=;
 b=SOdYgI/YztweNF5YM+n1N/+GaAa2c5ABXSBWZPzyq406bWZvcQdQWvFWD9fejXxoQMyDaOI1oXk0R3NtDqFxHnt6qHqpbfBqrRArKDGIT7GYM+xXWE91Yix90uIdKcfjY9GbDw74RDDta3Jg0V3HvpxgNzYFui0jagRx21wvamExskZaqgoSX3/pRutCYtwAOja+apNPdoa0Fs/Jb5XTkmEL2j4hoG+EZUnwN5N9jCEzBSJlKvtZYVnHuZW0lMphufctCwXtYa3EBmV+Q7uUnMYbVSyGPuraLYTvdXV/paLhqUueZODU9iiJtO3w+XSnFqMHUgM8Si37E0bJT3yCBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i8eJn134jSd5ur8z/5yKLdcXtTckx5Tn3buAnBGlNEE=;
 b=bm548/cb3VAq1vksQQGuRHuwweLtXWA4STSI7ucFrzCWI3jqwskCkDU/vBiG9Ty7VPO/kuaX+K97WYT8alUmanuPX0mjUWte7BzQ/HOi1MYQe0Rg2tpvAE5UTvXbz69wTkrip6nkXCJgbSlzwN7VZRVi93zSGbgkszrPlHHRk2zx7EFSC/u2MC3kBjl/+FDqwyfN8LYFTaG8I3YVGYYQsSlreE5btKfF//dPcj/kgDNgu2eWcePre23nc1kQAtVMLHnJKCo9/L/pVcl81FxCBE/LA3h+N6p1J3jF3EO9n1uaG9UCV8m0ZLl0EjseoQbMPsmJVbga64m4VjwVhnDfHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM9PR10MB4086.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 15:19:40 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 15:19:40 +0000
Message-ID: <50bf8690-7b61-4619-9a61-0c293ea26b63@siemens.com>
Date: Tue, 28 May 2024 17:19:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 1/2] linux-cip: Switch x86 targets to new
 cip_merged_defconfig
To: Gylstorff Quirin <quirin.gylstorff@siemens.com>,
 cip-dev <cip-dev@lists.cip-project.org>
References: <be7c406d-ee6c-4270-b9d7-52b6f24078c2@siemens.com>
 <fb9a3c40-cf83-478a-aa5c-6c53ea5c8ec4@siemens.com>
 <06c224f3-add7-487a-8f6a-c5e4d6b705bd@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <06c224f3-add7-487a-8f6a-c5e4d6b705bd@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0112.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM9PR10MB4086:EE_
X-MS-Office365-Filtering-Correlation-Id: 07ac14f8-943c-436f-ec29-08dc7f299851
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?cVFuSkZIdTBnVUcrdjVjdHZFdUR3eVBBU2ZZanFJajBQaTU1THRPdzdCelM3?=
 =?utf-8?B?S0o3NGdjM21ISHZQNjZLeFU0ZlNsMUxLWjRoVDdpVE5UdExJa3MwSll4eVAv?=
 =?utf-8?B?MGlxd0NxeURxeDJ4aW1tdFZtczNUTHo1dUp5TzdzaXpNY0dGdWZ5WFJ0dlhE?=
 =?utf-8?B?bVZBOWNGRkxDVzZFL2Y5emJZK1NUK1JqTnF5dFE2OFNreDVURXNUOWZkb1Ra?=
 =?utf-8?B?ZmoyaDZmeWZlQkh4YzlwdFhiVkV3Mmx6ZnE1VWlsaUtvMm9ucmpyTjJYMUVE?=
 =?utf-8?B?azFFNXI3V256ZlZFZnBaT0tHNDlndVdqZDZoOVk3SUszcjlqRlJPb1ROMzcw?=
 =?utf-8?B?SGpWcld4YlBLTzU3YnB1SjJYd1hrbW14NlJyOWVSbGxSWE1XUmZnNjc5blFo?=
 =?utf-8?B?Nm02VHJMa05LMUpncXZBcmhJMWFwUW5KTlRuTzVlTWREdmlRQkZETWtiN1Bx?=
 =?utf-8?B?VzdyYUxKenFvKzJ3bUdzNHN2QmRIUnl0NzVXVUJaSUNSeTFFUm0wR0FQYmxm?=
 =?utf-8?B?SFl3ckZCUThrOFQraDBwUTkxMFd2Y2F2UVBYMVBTWEhVVHZodXdGSXNoclE5?=
 =?utf-8?B?TnlxeHVKQ1hlT29sd2I0K2YwTVE5YmgraExoeGtLbHlNOXo1blVPc0xnQmpm?=
 =?utf-8?B?akwyUlJ6Z1JYRFhVa1pzdGJxNHlTYTVGdEF0QmUzMTRGS0RYdktmRlZYcGNL?=
 =?utf-8?B?UloxTytGbDZTL3loNm92ZnJURnRxemhaN3psWWd3L2d2V1MyOXRNWm1rdkZa?=
 =?utf-8?B?NXZvYStJUUJjZkR2M0ZVUndqWjZSN2JCQ2Z5M3JXVnA2OU83Y09KUG40aFBp?=
 =?utf-8?B?bzlkcmo4N1NqWXVhNjkwTUQ3RklmZHY3T2pMOUZoaExPZHN1V3l0VkRNbVh2?=
 =?utf-8?B?OUUzZlNBdEY5bmpraFpEYUV6MDVhVUZJaUUzQ0hwVHJUSVZ4WmZVZ1poNHlG?=
 =?utf-8?B?bktnRVh0N253UFdtc0FQb1BZN011QWx4N0FUaU8wamJFSkdwOWxpcm1wTnBl?=
 =?utf-8?B?cThnVDNTaXlBOTVDN2RQUDk2WkxCM2ZDSkN1RDNyOFdDOFRyTjBwWXhhUkQ1?=
 =?utf-8?B?bjJuTG16LzdWVmdkbnl5cXBXcHJ5RG40ZnpSa3lQdUk1em03eTQ4Nkw5c3Zr?=
 =?utf-8?B?ZW42WVdoeXVIcUI4M0E3NHBMdER0QkxsY2JncmQrb05veW1tUHZFekkrUC96?=
 =?utf-8?B?WUFRcjU0TXZ4WTk0K0J5M3FJemFNM3MvcEJDd010UktEZnJzdHpzbWhEWmdS?=
 =?utf-8?B?L1FSS0xZTS9kZStzYkh3dmxqYmtDZGZkZ0srYTVnK3lIMGhQNVZXNGcwSUxq?=
 =?utf-8?B?UlBoUENkUjVwV1VWMlBEbWxEMGEzaG1GTFRISEV0eGpsY0lNczZnVkNwUGdZ?=
 =?utf-8?B?SlpVTTFaNWd2SXUraXRYdlFteTU4czNPSGVWVTY5bzZqbzFxdXFiSDdaWE1p?=
 =?utf-8?B?VzZRYzE0QTZzSzg0dDk3cGsrK2ZNRzdBUXNJb3krZFkyckVRUE1OdHlaRFcw?=
 =?utf-8?B?akMweEN5bzA3aHppcWNza0FUMWpKcWlYS3Y2ck5yelJrb05QdkY0dVF3RGlR?=
 =?utf-8?B?NURaZnJuK0I1ZjhxbzhyeCsxZlEzVWc4eGxobmtVZENmK2lmcnZjaXFXTk1X?=
 =?utf-8?Q?bcSF4tBimYKvIbU1SKvSJyReFWm0sKqT2J7RNh/0LRIE=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WGJqMzZXWEtDd2IvNVVJU1E2UGVBSElVVU1CbGs4aG01eWxlM0ZhK3JzV1FX?=
 =?utf-8?B?NWdtN29XaEZxdjNsR2lLQTFYTkN4Z1l6V2NGbGFNVEtPa3R4clNxT3RCVVNu?=
 =?utf-8?B?enNIdFdvSEg1dTlEalFJbmtXc3lYazRvT09tZVZhZmprZFVhK0ZOT3pBd2x4?=
 =?utf-8?B?YXhDa2lST2t2MHRiTXExc1cyZ29CSlRtd2dCMkRqUDRVVnR2Q3c2VzB3anhr?=
 =?utf-8?B?OEhaUGV4dEdLSThLYy9aMDBCbHdsYTVBRFMxbk9uc285K0cyVkZSdGNMc2JX?=
 =?utf-8?B?UFZEVDRGSkVYV2dsWFRHVW8vcCtlcCtocThjd0tnLzJTUEJXM1I4TUYyUzFH?=
 =?utf-8?B?MUk3bUFsWlB6Sk1jRUZPam5wYkpObUp6YmtVVmUwU2xrQzljZUpMMGdnVGRh?=
 =?utf-8?B?d1hBV0RWeWhDd1oxMjliSWNDbkVacjZJeXJJSW9DR0kyVTMzRHJQZzJZN3Y2?=
 =?utf-8?B?ZFhOeEhCTkpHMDdkZ1E3ellZQ3luN1lTSXdoTm80Z3UwUGkvbU8zMmt5ZUVh?=
 =?utf-8?B?enFiR2lFZ1U4OTR6YlhKVUpDUUZMVDRpazkyd2pxYWk4cUYzOEZta3F6ZHVU?=
 =?utf-8?B?OUVNZlI2LzY1UGRHZE9EVW9jbnlNL3R5QURyRkpXc3JrMXNFWjZMcWwyQjIw?=
 =?utf-8?B?cm53MVhrVDJJbzBXRDZmcTh6bUZJeGUzdUxzZ245UnNwdmNaa1ZVZDFWSVF1?=
 =?utf-8?B?ZE9JSkx1SEFjdXRURkxFUEY5dVljVkxTODNRUmwxYjlvQStWZy9aL3VtYXhE?=
 =?utf-8?B?TVJ4N3A3enV0cFhuN1VyNEdYenQvNU0zbjd6WVJtb3RrOHdrR204WnFFZktO?=
 =?utf-8?B?R0J0bHdiZUFFNnJtY3ROd3dRcjBYMWQ1YkMrblkxRU10ZklxMjNKRzVTeml6?=
 =?utf-8?B?cjZMMVpkWERuQzVzZFJIQ05uYVptL2RvWnBWTWd2MWd0Ti9RcXc3SlkxVkt5?=
 =?utf-8?B?bEgxbkc0eDR2VzlkNm5wVWFjdTJxeEJJVUQ0cXlIWWJUcmdRV2VKNDJ0aG9V?=
 =?utf-8?B?cmZnTmhqaVY5MU0rUnFmNWVPcit4cysrTmpQNzgwMnZKVG5XbkVseE9NL2xP?=
 =?utf-8?B?YzNkenlVUVNneHNBeERyV0FGdk1MUVNPZXNya1FtWm5CWFRHZFZ6L3VCK0Rq?=
 =?utf-8?B?UUZtb1JDSUVCR2lKOXhMVTM1Tzh3NnFTTWZlai9ELzQ0aSswaHZ0RUZia1Nu?=
 =?utf-8?B?Q0lMdzZLdnFaSmpPc2lleVh3cjByMHcrT2M0Sm1YMmQ1VExrTFRTT0tzTTJ6?=
 =?utf-8?B?cXk5S0VVRkNzejQ3YmRPZEtVYmMwTXYyNjZ4ZVJ0d0UwYTREVVhHVlpEYVZr?=
 =?utf-8?B?U0VZN1ZSSURtMW82c29DQXJyaWNYVXgyNzNBUllIeW85SC9HOHhnd3BCb0RF?=
 =?utf-8?B?KytZN2VBTWJ5WWR2Qlk5RlczemU1NVdEeHRaUVQ0cXRkT1IvUWFMZzhBcGlR?=
 =?utf-8?B?Njh1T0psdFROTDB1VWNDaFJ5bXdqYWRKeTRCUGZtQStWQzBtY2hpQ2syelI4?=
 =?utf-8?B?K0g3aVIrNG5Gcy9RTFdNRy9hcGVNRHdhd1R3ZlpmWDZoWXhBNzNMYjUzMDRp?=
 =?utf-8?B?SUYvQ2ZqbFI5R1NlelNkdm1ZQVdUY2hTOTRmOHZpZlZaT0t5V3lRYXU1OTA4?=
 =?utf-8?B?RDVLMjdyNmVBK1phbXFIR1k0M255ODk3Y0N6TzNiM2xQSkw2bmxxWmo0QnU0?=
 =?utf-8?B?eStrajhVc3F2clJ6YWF1OUlHM2wxN0l5TVR1TFhFWE1GOG1CcU1heGxjNW5V?=
 =?utf-8?B?Zm8vaW9LWFZLR0JvUWEyclpkeXZUeWNib2lPemJuVW9xWjhUTDI2Z0NmeTJ0?=
 =?utf-8?B?cWloZkVFdE8vNzc5WklQdWEwYTkvVXFKSlJ1VTVIWmFoOG1wZUgyT0ZYQkNG?=
 =?utf-8?B?VnhIRlZNeXFsUU40WXdlMlBVTnExd240MVpyZUNNY3RMYXRHU3BwbXR5Y1RG?=
 =?utf-8?B?TjZWMld5YjVtVXMrcElvVXhGbVpGMjZCc2lLaDZreUdZc3U0TGxDY2h4bUpW?=
 =?utf-8?B?OXBoOUhFR2ozNFNJNWNYa21rWDMzblNGbVZwY25Jb1BvTGliOTBsMzN2Z3gx?=
 =?utf-8?B?ZHlTYWlHd0R6R0QrZ0duMXM0VGp2UzZRblRiZGs3cWRsVml5ZWYzWWJSUGxy?=
 =?utf-8?B?emxZemg2S0JjcHhKSWxqRFVhcWpqb0QwNXphY1dsOTRpcmtTUlF0YlVrdFVu?=
 =?utf-8?B?VFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07ac14f8-943c-436f-ec29-08dc7f299851
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 15:19:40.7038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: biiI853zlddx0EOLo8EHS1CYxXqTVAiqqUtSPcn6JEjMG9ndc5BHEJdcCXRjkidbhOrqIg4ab9j+13JsSUU7Iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4086
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 May 2024 15:19:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15968

On 28.05.24 16:47, Gylstorff Quirin wrote:
> 
> 
> On 5/24/24 10:25 PM, Jan Kiszka wrote:
>> On 24.05.24 12:50, Jan Kiszka wrote:
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>
>>> This also prepares for a generic x86 target.
>>>
>>
>> Found a config regression: qemu-amd64 lost its keyboard input in the
>> text console. Not a major problem, but it would be good to understand
>> how it happened.
> 
> It looks like this was disabled by plathome_obsvx2_defconfig and
> toshiba_atom_baytrail_cip_defconfig. All other config assumed the
> default of enabled for CONFIG_INPUT_KEYBOARD.
> 
> I posted a MR with a fix
> https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-/merge_requests/99.
> 

Thanks a lot! We will pick this revision up here once its merged.

Jan

-- 
Siemens AG, Technology
Linux Expert Center



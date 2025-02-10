Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63BF7C02198
	for <webhook@archiver.kernel.org>; Mon, 10 Feb 2025 17:12:31 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.66.36])
 by mx.groups.io with SMTP id smtpd.web11.57181.1739207547378980172
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Feb 2025 09:12:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=GN8B1MiY;
 spf=pass (domain: siemens.com, ip: 52.101.66.36, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h1A4rvSzCNF0orfen7plHp8BijPm6LD/1oTSCVCeyN3bgBv7Hg6h4ZlGu9m3R3BnKSQT0/I2U7gvzqAQ+EYUDb6wu2Wbjxv88vUo7/0XChNmo5iJ0CGUiI/LbEsL58Mr0mt/kPSyKddqCV0P+guLNa1BCSTcnKs+FEb9aYsG/CwCjUstBcZ2uto8Ett5yoEvulVDJqMGnIdN4jJ4Mus+MdLGJsQIMG7+4JCZALETqjoSFWW1llisRn3mQxB6RDveOitjeYNfFsXrzprG7VStMgR1V4l9vsrfkvDjjtXtV+irbk1iqimhWCkWKUO2feiP14CX1IdpKuz42DRg8ZQiFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZgbHa8AW6o9kFTJebH751Ixp4fmBBuQJN91YrD/q4js=;
 b=geeHJ9ByVF+ua1XQZn1IGbJKScL/GqRaLYMd5k+VPQKVY+YENHV9hFfaRpfdczlfAK6c73/KyJ2nUmv80tp1oSy8ce/oldSBhRG+wOXqBQSV9geb/CzXpWcn5jRrX+ldZ2T/QZNhqj+fKUyT2tbMzdUxfLjtUe3j01vSblEggIQxzqi7XL/H7QIKN/6Jk+3LPCNocmTbghYh3CAaiS3Pi5wOusLHuUS0kMBZEAyry76kQcLLecnmmrokSGxD/LOpBzLpJqNqK+q2Wmhx3isZgg6HyN5EYW93IF495WAKkOaXXro3kpWqJAB6bDztUYaRki6r9gBS8+raIqJFBe7KFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZgbHa8AW6o9kFTJebH751Ixp4fmBBuQJN91YrD/q4js=;
 b=GN8B1MiY2WUXPN550XDztMSU9rjzMOedi+ye4Xz4kHYxx1FtaKd9/2zDE5vJqchuTtXktSEs+rXElEDNAqSWqdr3JkPNMtjolPyR83+G/fq/ipmvz5mHDQWIPvX433WhCeznBSQj1sV+wRlyH8XNGILkbOEgszewv0E1uTqOI6IVWh80O7xZbfSne/FbUEoLZi1NyPwRi1AMrH4NVkfSXDFnXeHfMGMZRTKkfr1YY6+FB4q4tU0awBtZOhECHi5prhoMhrYL6ZTvx8rPEOhcp4xhWac7JW8a5gM+1Nd/acnPjd9gMNTG40nwh4dgiID8wANf1K0VD+rORjhB71TyeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by PAVPR10MB7259.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:31b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.9; Mon, 10 Feb
 2025 17:12:24 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%5]) with mapi id 15.20.8445.008; Mon, 10 Feb 2025
 17:12:24 +0000
Message-ID: <54823bd0-07dd-4fed-ad9f-5034b00027f5@siemens.com>
Date: Mon, 10 Feb 2025 18:12:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core v1 0/5] Automate CIP Core testing on M-COM x86 in
 LAVA
To: Jan Kiszka <jan.kiszka@siemens.com>, Sai.Sathujoda@toshiba-tsip.com,
 cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20250207150439.392479-1-Sai.Sathujoda@toshiba-tsip.com>
 <9be57472-a1e8-4142-a61a-32e6e7717c62@siemens.com>
Content-Language: en-US
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
In-Reply-To: <9be57472-a1e8-4142-a61a-32e6e7717c62@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0212.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::11) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|PAVPR10MB7259:EE_
X-MS-Office365-Filtering-Correlation-Id: defc297b-30a4-4d7b-957d-08dd49f6165e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?a1kreXllcmRuUjlCenZiVDVValFsa0hRUUtzYlJYcVNPNEhjRXMzUkgyRUxo?=
 =?utf-8?B?aTZ1aGxnTDloMHEzSWU1SWcrS1pQOHFBOGw2WjRQL2dvOTFOTGxaR2lhNjN0?=
 =?utf-8?B?SjlQWVdhd2ZKSU1EcWhDbEQ1bllWbmRqbTUvRHRWTjB1eDkzZCtlb3d2akdo?=
 =?utf-8?B?d2hldW9WYU5wU0NuUDUwbm9IeXVDa0xYVVdVelRmTmV5QlhnR0hldGx1MVhU?=
 =?utf-8?B?VU1RMzU0V3cyWGJOWjJqU3NnVmwwenlnYWhtRkRkRSsyNEJIMk1adG9IV3Bu?=
 =?utf-8?B?Mkw4SUc0cUZyWFlEbWNHcEcxdGUrZHM5V0JEc3g5WXZVRGdBcGdoWHg1VnF3?=
 =?utf-8?B?a0duVHU2ditnL1EwNHJwcmtMcVhydDZzWnR5WDEvaGo3UXRya0lDR1dYWk5G?=
 =?utf-8?B?ai9GekFXSG9lUElpRXlKUG42ZWc4RHQydGU3VU1LWW1ya0pwemE5b0Npdkg4?=
 =?utf-8?B?YXJJcTRLeU9QUzB0b1VkenVBbDJFcHFtVFd2eXVvdlVuZWNWc1AzSlhoeWw0?=
 =?utf-8?B?TDExb0ExT3M1ZVAzRGJIa0pBMWluc0FMMitoQ0c1Z1R3ZWdXMWZ4em1PaElk?=
 =?utf-8?B?ZC9JTTFjaW5jMjFOWjVqR1FVT1M0ejJBeHByMmFVSjNPcnFnanlRR0VtUjM3?=
 =?utf-8?B?cHVNb3J1VzdyY04vblJIS0Vnd25vZFMzQ3pTUjBhT2FmcVpRdkNiQ2hueG5n?=
 =?utf-8?B?VVprcFZRY2tCVGpnQXFpdVdhV1lmVFhtNUVrdXNWSld5TG15aHBRS1lZQVc0?=
 =?utf-8?B?Q0hkS3JlRVE0U21seTN3cTFKVlpIWXBoc0h2NlR5TW8rMHM0NHFiejM1UFdM?=
 =?utf-8?B?SDl1WXdGRUYwTUNONkM3UGVXT2c1MmhnUTJFOHd3eUNsZk0rMGdSQ3gxQy84?=
 =?utf-8?B?eWk3eE83YWZjMzl3MUZWazNwNHZ5UzB2WnVnaE1vajdjWHJyL2dJRXRweC85?=
 =?utf-8?B?aEcwR2tOaHZodXJBekQ3a3RENjZUWmxzNVUzUThUVElOaFU1UXR0MFhCK3dm?=
 =?utf-8?B?WjZzQ3JJZnlkeUg3M1cwaFdYdFlkVXhXUjZFTlFQdWQ2OC83RG9EenNrZVhZ?=
 =?utf-8?B?ZXVMYmJzSXdsUHF0SEw3Ty9NblRacGlQNWN4VnhqUlVFMG1RMUQrT0diZ2tS?=
 =?utf-8?B?S0NBdGRZRUFBNDcvT09aWE1icWpxN0lGTUVGZmtrK1BoOXVaeEZPV2RtRnBp?=
 =?utf-8?B?Q1BlT2thQmlRd3NhRTNZWlBUQmN5L1pFcGl1OFZhQ1F5dXBEd1JuWEhvS0Fk?=
 =?utf-8?B?RllySWEzelVJbDNlL2hDNkFFelNEQ0FGUW9hUWdHTzdQaDQvckxzaGRESkdS?=
 =?utf-8?B?eXdOQnVoei85cW92UHZnK2tTYnlJMzJSN08wajlkWjV5RnNDMGxzNnFJNFZC?=
 =?utf-8?B?bG1QSDgyTUphZzNiWlpaS0JpQ21rQ3hiWXZxMHZuU1FpZDBFM3RsbWt1T29n?=
 =?utf-8?B?OWNXYm9TcmErSVRDM0FvR2hBZEhGeFlhVnVpZmNXSHhpbmpEYU5RYTF6RW9T?=
 =?utf-8?B?V0U4QWNTai80VXlySHZGWXMrc3FNTDFlZEVtMnUzQ1pEeFhGNXJncVJPT0N4?=
 =?utf-8?B?Q3lld0hlcGMraVp1T0FLelk0dGd4UFRSZUM4S2FFTFcwYzdoTktIN0tjT0Jo?=
 =?utf-8?B?QjRObGxoYU9VK1Jsb2J0ekw3TVBQSmtYaktuQnk3cVk5dUJDRDhVNitLYlFX?=
 =?utf-8?B?cXAxeWIzSEJnS2JtSWpHVFZUeUYxY3UvUHVNc0tza0UzZ1VsY1NWbUhUZk1t?=
 =?utf-8?B?endJMXdGUldmSzZ1WmtXSmhLTkh4cldZeWRZUnBla3UvZmdKK0NXLzlHTVow?=
 =?utf-8?B?Z2tWeE0zVXp0QWFRWEdnZz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WUM3YXpoSVFOLzNaV0xDeWpGOERDRXBwcTZML2pKVm9NMUFrcFErWkJ1b3Bl?=
 =?utf-8?B?WVNMTXhsd2RPNTVTalpnMWNiU2t6L1d6UTd2K01nWFhEQ2xiMjN6ZUFCTXl5?=
 =?utf-8?B?RVV2TlcvdXZVbjVneEhDS1NJRyt0M2pSdlU2YStLNzZhNkZYa2hTTU9GL2Ur?=
 =?utf-8?B?U043S0d6ZURjVm95YkFhSTNPTUpqUnUvOEhFdlpYU08wT05iQkg0S1pUZHlj?=
 =?utf-8?B?SHFXcG9hdFhzdnd5TU1LUXRQVDlDMURvc0NLMWxNZjhYS25DRFJHcDgxMi9s?=
 =?utf-8?B?TTYvRmZlR25ONTRMZ0ZOdjBJdjNUMWhLSm9xeUdnYVlPNWJPeXdVemRvVTJX?=
 =?utf-8?B?VkZwTXBYRCtrYlFlL01GWXJnTlRRSXhWVFNzQnF5OC90SWdaWmVsU0IxZk9i?=
 =?utf-8?B?MTdWdE9ZMGQ2YldJbTZGeGxueTE3YlRpZk11K2hZN0hzc08xaWlya3lKMUtr?=
 =?utf-8?B?ZG8wMnNHRis2TTRXaFNSamdRU1dJVHd2ZUJFYjllTk93OGtzc1JuYmQ2eWlL?=
 =?utf-8?B?em1OY3ZFc3d2b1YyeTcyMFVLaEFGS2xnNC9pU0JPaGxpNWhmY0ZUbng4S09B?=
 =?utf-8?B?TnBiei93TmdPb0FncUtoZm1uWURFRUpYVmQwUytlNDNpUWF5UTM2L2JVUGdL?=
 =?utf-8?B?RnBsR2lqTE9aTW5QRE8wWDY2cjBYTjNEVDVSbGNERWt6ZzI2V3Y3M2xIL25H?=
 =?utf-8?B?N0gyTkV0d1V2Ums5RHN4MHpOcmVZR3lPbUU1S2dQUXlxNVpQcVFsOUU2c3Ja?=
 =?utf-8?B?WGFWeG9RdEFwK3NFVHBaY25WY013OHkrQ1JLWUE5cC8xcEY0NFE3UDQ0NFhp?=
 =?utf-8?B?dGxzZXRiMTZZanBQZjRGUzZ0dTVRQ0NZdSsyWmZ6cUFMQzk3aWN2SGYvNEk4?=
 =?utf-8?B?U3ZnTDA4UGlVT2VKa1hZRzVjSXpFWG55VDZYL3hQUUlaS2Yvd0ZJZUhTVXNz?=
 =?utf-8?B?b0p1b3lRM3BpVm55S0UyU05xN0NXdnpoUUVVdzZKbWQ5Wm1yWGN3TmVsaVUx?=
 =?utf-8?B?NVdTbUpVeDF3c1dLcmZjN2lZeERzM1RZTFc0ZnRkTDFhNlZrYiszWSs1N3ZV?=
 =?utf-8?B?aE1yODEyWCtZdld3dXpLRk44Z0RkWEVobVZoTmhaQzk4Qk40MEt4RHN1R1Uv?=
 =?utf-8?B?a0gwZTlBd0ZkeVRsSXVGaVVLQWNTd3FJSkVaQXVBSW5tcStEQkZmTml5YWpJ?=
 =?utf-8?B?UXU1Slc5bW5jbi9tdGQ4TS9YYmZEUDNNb0QwNG82bjdtdTc5L041WHJTNTIy?=
 =?utf-8?B?ZDlLZ2xJdjg3RHJtQ1hUQUFTTUorbElDS29QWCs2cW5HSnpPN3hWT1lxdnJn?=
 =?utf-8?B?TVhyZEhGUUVTVVdXNU9vS1h3MzZqL1JRL0ZqK2dQYnVLZlVxUVpOTmcxKzVx?=
 =?utf-8?B?Y2VXUVp1cFRqTktGclpBdG9vVko3b2o4a290UnlJMEc3UEJZVnMyRUdwbEVu?=
 =?utf-8?B?Mkl4VjJJcWRqMUtsZlZOczJmUEZNdTN4eHBBWEorVjVsUDhFS1ByMXZBc3NL?=
 =?utf-8?B?K05vMDRmaXVIaWc5UEUvNWFwd1YvSnF1Y29OcHB6R0xKNld1UE9KTlhFUUF3?=
 =?utf-8?B?Y2dBZ3VYOWJyMnVYaUZ2Tnc4TWM2RUdSVVU1RE9zeUNYSks0dmFaVlhVbEY0?=
 =?utf-8?B?NWFXbXdQVzNGOVZJbWtBTm0raDl4cXNQclpGdTFPWjFYYUVYMUkrSk16eEYx?=
 =?utf-8?B?QzdubEdKTy9PLzIzaENjY3VXVHVPcnVTclNCS2M1ZGhyeitZN1BlR1BlUnl4?=
 =?utf-8?B?aVF1TzBRbGZOZ0V4Z2c4aHZJalBDa1ZqVWw1Z3ZHT0ExLzdFajNCYWVMVGdW?=
 =?utf-8?B?VjYweW8xTDE3ZlVtRDJ5cU5aNEo5QWtWeDYzNS96d09zdGgwTEYwUE01NFMx?=
 =?utf-8?B?R1JpWFFQYmlleWxONG5laWw1akhsMEd5ZjZXczNvQzZsTHlBZWwxa1pvZmlY?=
 =?utf-8?B?cG5yYTBDNzVtN0YyV2xiRjk1QlBmWG9yQnNDY3NxVVpHeDNDWWxPdkpNNkxt?=
 =?utf-8?B?b2lYbDExbzA4MGEvajVESVhwQ0ljUzhFK0V0ZXpoZnBucHV0dFo3ZGhKTkZa?=
 =?utf-8?B?YlNUWWI4ZDNoU2daMktVbnJoM1hObXp0K3N0VW5RNFNUbHRiaDVrT3hkKzNV?=
 =?utf-8?B?MHJDWm5KdEI2elNFa2NpM2pQMjN3ejNxQTlWTFh4V01pZFJVQ3hsQVJlMUU1?=
 =?utf-8?B?eFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: defc297b-30a4-4d7b-957d-08dd49f6165e
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 17:12:24.4523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AO+XpzpCP+aWKGZrFJhkLW79vIxRe9HkYiCIP8z7wu2146/ncI517pezI4FIptZ+biWGd6D+fy0JN/nrb3cb4JkBpiR7ujXBfERpoRsl3LQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7259
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Feb 2025 17:12:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17799



On 2/10/25 08:00, Jan Kiszka wrote:
> On 07.02.25 16:04, Sai.Sathujoda@toshiba-tsip.com wrote:
>> From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
>>
>> This series of patches add template files and functionalities required to generate
>> jobs to test IEC layer, swupdate and secure boot features on M-COM x86 in LAVA
>> environment.
>>
>> sai ashrith sathujoda (5):
>>    swupdate_template.yml: Give different names to test actions
>>    tests/templates: Add template files required to generate M-COM job
>>      defintions
>>    submit_lava.sh: Include functionality to prepare M-COM job defintions
>>    .gitlab-ci.yml: Enable building v2 x86-uefi target to deploy its
>>      swupdate artifact
>>    .gitlab-ci.yml: Add test targets for M-COM x86
>>
>>   .gitlab-ci.yml                                | 25 +++++++++
>>   scripts/submit_lava.sh                        | 38 +++++++++++++-
>>   tests/templates/M-COM-x86.yml                 | 52 +++++++++++++++++++
>>   .../templates/swupdate-test-action-M-COM.yml  | 18 +++++++
>>   tests/templates/swupdate_template.yml         |  3 +-
>>   5 files changed, 133 insertions(+), 3 deletions(-)
>>   create mode 100644 tests/templates/M-COM-x86.yml
>>   create mode 100644 tests/templates/swupdate-test-action-M-COM.yml
>>
> 
> Is our lab now ready to run the tests? Or will the pipeline become red
> when I apply this? Just asking as I lost a bit track where we are standing.

The infrastructure is working - we had an issue with mtda in 
https://lava.ciplatform.org/scheduler/job/1243699 which I cannot reproduce.
Restarting the service fixed it.

Quirin
> 
> Jan
> 



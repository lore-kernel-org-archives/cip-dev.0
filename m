Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B75C27C53
	for <webhook@archiver.kernel.org>; Fri,  7 Jun 2024 16:17:02 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.40])
 by mx.groups.io with SMTP id smtpd.web11.46616.1717777016091773392
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Jun 2024 09:16:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=U1ZjmIFV;
 spf=pass (domain: siemens.com, ip: 40.107.104.40, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MGx2uZn1DUlI09B1qJBhgHQ+Iq12tC+CAuPFe+ItlC9Ohj3lXBY8LJHsbfDl8KJCFci8lGnaqO4cKLM141QVBW2u4dCnWyfRvntthMqgKJSlIyjojftm1dAqQeZKM1Cxtl4s01Tcdk40OwlValWUblgRcnpOnnkQyQqq2rNJNLyWnSkDCxCIipNAlimMBsYLN1GhhxVamwmZIjVfZKZEUGR1z958s58xjHq/JFfaTOZVwevkwyGEoCHIp5n/Gg7gsetoOxW/LV+i51rWSGebURe6PImRRaqUjwaOUx0F+owMxI76x1FfSTXAN56PpqdxVLoEZlvZFXj/eQWe2N9kGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=94VWTgmjUeGHiUwI49ukV6UijBr8aPwNA2V5jroSTmE=;
 b=R1S4050/sG5cIVd84pcvXIdauWkoJ3BslV8E9G5OTVy1eKDruIg0Lca7M5W9XGRay36pVjK2xtAAorX9GeFnPNgz90HKo8IE1tjoSltdWo2w0HwzI6e/qOvWdIn26/F/bKzLm5DwJe3FjSpW9iCWEnt2ysS0pEhojZ1tjrYpVOwBJHb/Ji31hSEPC4PTEd1Tz0MgTsj3MgmTjFSQ8lWOzPG3/ARqRavPg1VCvwAvXjo1r/NwipIs897XsebguT8KPGoY2CgiePvNb4FYBRRMqwGgHv756RHQvQZu9l/p+qUscDhsBh4ViS/ouVj0RXzd55KO1NnPxkFgStNPXZMKwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=94VWTgmjUeGHiUwI49ukV6UijBr8aPwNA2V5jroSTmE=;
 b=U1ZjmIFVeQArGFV0fRjOYh6tnAOxd5ZDFVKCsw95XKozLkJhtUvr/BmHge/ZrbaR6eQdRRxJBR5mDVkQ9ZhrpgRnxeuMSOdRm9sKeQ4BKyGFpiXklVCi2Q8tct3nNCqtb3RrJk27tkPZOurtCfiOWOHXtzaSzYrSc6c3b593HC9ZAzsAAdPuK4IYyASxqdIVoOzz2NtXYgYPgGrnCupBu5yU87LjCT+diGfMMPBtZcFBiEcVVEYwgqOZRTpUuqVoRapbMPFpkAVcdMQfQF8QbRV6KyaMgU5f3/8u7zTHcHUfBZzNHVd4zw/EWIwJs9SEcab+Sjx2FN70BM16iV7YtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5554.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:475::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 16:16:51 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 16:16:50 +0000
Message-ID: <bc0dba1d-d8ce-42ae-b0c6-cd0d1a1dbe0c@siemens.com>
Date: Fri, 7 Jun 2024 18:16:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core v3 0/4] Trigger CIP Core testing LAVA jobs
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Sai.Sathujoda@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20240607095229.490871-1-Sai.Sathujoda@toshiba-tsip.com>
 <54c18d2a-fd3a-4a6a-bcc6-aa3b1ad3338c@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <54c18d2a-fd3a-4a6a-bcc6-aa3b1ad3338c@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0195.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5554:EE_
X-MS-Office365-Filtering-Correlation-Id: 4be805c9-7c07-4db6-7426-08dc870d3cc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?YVZqRGVZZHN0UDgwY1ROWU9pTDdsSEVqZUROVkJ6WVdKMDZwclkxb2FXakUv?=
 =?utf-8?B?TWlOcTNYT25BZG41ZGd2ZzlIR2ZWeC9QZ3ZZQzRYRHV5bXYwNCtvcy9PYlZG?=
 =?utf-8?B?WVVTWmtXaXVUTWZMQ2VWdEthd01naHUyeG0yY1dXeVhTKzV0WiswNmE5cHM1?=
 =?utf-8?B?TWsvZk0wVitaWVNMQ1NHam04VUNZeWt0SFoxdE55aG4rUGxoNHVzUUxsVmw2?=
 =?utf-8?B?RVhZSTlzcVNWendyZlRvYkRXUEY4S2l2d2liK1kwWTFsQU5OenByblA1UDBY?=
 =?utf-8?B?b0FQNVRTdURiT1RFR2NTMkVLWktQZVo2aXpPK29tZUkrV041Z3I5R2JHSDhq?=
 =?utf-8?B?MjFoOTR2bFJ4c25US3RIT1hNN3BwTUVnN29CK0RyWldaVVVXdTJpR0dqSFkx?=
 =?utf-8?B?dmRuejhwZi9BcWJqbmdjWldkM2hFTzFQYWVpMkx2UzZSd2hHci9PMlVhYkR6?=
 =?utf-8?B?TFRseTMwNUpMOENnczYwaEVxS1BZZFF0UWQ4YjlzVmNhbnJ0V05WSUY4YndE?=
 =?utf-8?B?TjZtSmF5U0VYY2hnMjFzRW41WVcyQzNGanNjQlVyRTIxNVhNT29xcnl0MUVv?=
 =?utf-8?B?K0xpWEFnYk4wQVg2MWNGSlpoWGtvM0tPdElTd1JCV1JZMHBQb2pYTXhZQWhC?=
 =?utf-8?B?UUhsTmxyenkzMnBqMkJYdEw1N0NzRGZ0NTNVOTk4OURieFFsTm5DVHNibXBF?=
 =?utf-8?B?M1FrUnVhalJTSGRKMGpzaEdmYnN2K3ROZG9NUUhreFZiNExwZk1KQWFLZHUw?=
 =?utf-8?B?OVdQaFR4TFFlRStMNFl0R3QzYzM0N2dBK3RSSWJFSk5aTHhCRUZDNWZlOU05?=
 =?utf-8?B?b2M4L1FLQzJkRDlYOEtWbENDL2c5WXBZUW44NS9uRHVJYi8xTExWa1MxZWxE?=
 =?utf-8?B?MFkwYzZubmhDdHUxckJ3TGRvM0Qyenc0am1EbjBwOTVIbldHZWo4cGpYZWZR?=
 =?utf-8?B?U3pwQ0Q4b2JvelRoMnFiWFB1bDFIZjFNK2pzWVdydlB1Nm5ScXRwdFJoY1Z5?=
 =?utf-8?B?bW1SbkRZZDhLL0ZWVU9kMFBRczVEeHRoZjluUnIzQU1XaTNPcjY0WHljOXRL?=
 =?utf-8?B?N1FUenlRQlRabWEzbHQ3bk55M3lVWnJ4T0s1c2h0VjZObkhPaEVGRVRIUDUx?=
 =?utf-8?B?ZVVzTFhuYjF0UDBSM0dkR2x1eUdWd2lNVDFuZDVTeHR0cG5QUnFzV3FLTGpF?=
 =?utf-8?B?Y09nMi9pZ2NhUThiRWpnRndtWG16d241ZUh1b1BCVnNtNzE0WmpjWml6Tmh3?=
 =?utf-8?B?KzdrM09Sb1I2WVFrdzRiaUdLL2FCL0V3Vi9Cckd1dXJoY1pLTTRvSlN5cWFO?=
 =?utf-8?B?d2pQWUhJRzN4QTUwdWhaREJLQ0gwWUxQRGxxV0w4TTRESkpDbzcraG84djgw?=
 =?utf-8?B?T2wyQjRUZHNGN0FLeTcwVDNuZGZ3Qmo2cGYzWXU1V3lhdlNKZnJ6WkxvYkcy?=
 =?utf-8?B?SEI0SHp1eWhSamhnazRIUUE0T0s4dU1sbHExUHBkYmlRQVJaSU5FSmNLdzZP?=
 =?utf-8?B?YWdlNlNqR3pRVlo1eFRLMnlUdVJ3bUplam9XU3A2OWNrQ3Z0RlBmdWhhQkZC?=
 =?utf-8?B?RjVHNkdoWVhHL2daYlBKK3ZmSytDZ2w1WGdiUlVKblVRVE1RcXU2V1FVY3lJ?=
 =?utf-8?B?aE5oMGhzdUlSMEVGT0gwSjRvcDZPQ3JSb2pKbUV1RWRKTjRyenU5RnBwTHR6?=
 =?utf-8?Q?E0dQoMYWx8xDLFhJtlcm?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RlFKUy9OMXUrTWZ1THI4Sk5DYXlCb1B1WHNTOEZzNG9RZDBIV3llaExESWh6?=
 =?utf-8?B?dWRVZFJRL3pmODY1dkJwWWdOVVdrWFM1clZiMjNlTm1DVm1nSm03dnVMT1U5?=
 =?utf-8?B?MFRxVGs0OWk4SmRUa1p0OVFhcTBRRGxXOXY3NnpWclR4SnJMNnFoenFSZWxk?=
 =?utf-8?B?eEJFejc0YWN6dWY3Q1AvemU4VFI3Y3lwczBaLy96Y1NNaS9DcnRyNFpIZWdE?=
 =?utf-8?B?TDlnMDFmQkpZazFZYlB6VHZ3M1k1OGh5Z3BwZ3Z1QktJMHVZYXZGSFZxdk9Y?=
 =?utf-8?B?UTBVbHBGbFlLWDl5WVZ1Mml1VWZkeldHRXdJaEFMODRoTC8yK0tSM1ljV3cw?=
 =?utf-8?B?ZGJScUpHNGRnM1drNHZEWTY4L1BCVmNBK1ViLzlwMXd1QURtYndRdm9nWmFm?=
 =?utf-8?B?dk9vaFZNRkVaMGw1aXdsTHZ6TWRHUXo1VXFRcVhhUWNDMEl0ZFU2MVB6TmE0?=
 =?utf-8?B?ZW9rdlBSazB0MWJzK3htc1drbWZ1RGxhM2V1ZktGcFdEZnh3TzdCRlhLdm1W?=
 =?utf-8?B?RU50SmQ0S3hKeFFFd3RoV3FHMTZqT3dpdllMcVpSam9CRzg2SGNvNEI4NkFa?=
 =?utf-8?B?STE2QlJkR3psUURHYVQ5ZWdsS1lvWHBBSFVvbnExbmpBNW85UStUTzlXV1Rv?=
 =?utf-8?B?NHJxdGRhMml3U1lnbWFmbVhrdWhOK0VMbFZzdGUzSHg1Qk5HOXZucVhiNkg4?=
 =?utf-8?B?bXhYZUU2MkxaTlFqZHEyVFhPRFlpbjlmWXIydWxoYy9HVWZqOU91eDRSN3ds?=
 =?utf-8?B?c0p6MEZtQkhiaUpHUTBoS3NWTWtjNDdzMUZPZCtiT1dHaGYveVZjSndqd21r?=
 =?utf-8?B?dE90OEg5aVp5SDRWYmhFL21NZzFWdlNudzVKMUpUdFlIQ0NkaVgrZHh6WnBy?=
 =?utf-8?B?QnJXUmxtU2l3Nk1zL0JvZFF0T2U4dy9mZEFUWTZoWGRSVlptcXZ5ZUxuaWdI?=
 =?utf-8?B?dzFqYmJTMHVaRkREbjREdVZVemdZc3cxYkdhK0JlNlVNNVZ0SVFxbHpwNlRG?=
 =?utf-8?B?YXN3ZHVGVXFnOGtObnVuSWdQdlViK09hbzdadVU4ekRxUDBEN3BFdjJzejh4?=
 =?utf-8?B?Z0FkNlEzOXZINndxc3I4Y0h3WlovWldaV3pLQU5saDB5V3pFbXlVZDM2cVph?=
 =?utf-8?B?TWpyMmUxMUh1V1VoNXVNUHN0QXp0OGNHM0NhcFJNRDZhZ3hJNVdhZEh1dEVW?=
 =?utf-8?B?UnZnT3Q4elYwNDAxTEZKK0VTRjFDNy9ZMjVJZkRkd2tKSGpqQzgwT2svVjN0?=
 =?utf-8?B?dGpBUXJlckZqcTF5azRhclNjNExIZE0vcW4yT1FuRk5mTzExc2dQQWpheEtt?=
 =?utf-8?B?OXdsejExSkdPejZGL0kwR1RjM0x4bW1zbitKZ2IrVDFrOThwRmVtemRqcW9k?=
 =?utf-8?B?YkhGWUNWTzBuV0lmcDV3WVExajhpMy9QUkMyUksySFRzeFdqV0d4ZXdGNnNQ?=
 =?utf-8?B?TVhGT2Q0STRXM3oxNXpyNlYxQzFkM0kxMDhrTDkrK1pWVVNSTWg5RUlIZ0JV?=
 =?utf-8?B?WjlKTkt4Z2YrU0l2a0RxVVp2Q0dQVHB3T2dleUtBc1R0SG9saXdlTm8wTnRL?=
 =?utf-8?B?clhxVUVHUGdyQ3hPSnMyZDl2RjQ5YktuOVlsQjk1SmFrdTNIc3MvQW5iVjNG?=
 =?utf-8?B?b1o1Q0kvT29mUTRkSkNCZ3BmQUJuc3NXV1hlcjA4TFdoV0ZRVEZWbndrQU9v?=
 =?utf-8?B?VHBvN1llREFrZlpoM0FjQnhZc21GTDhHczdHYWtaakk1cjhKcXZuK2tzZ0lt?=
 =?utf-8?B?TzFkdDk0NWZYTFk2SERjZGF2Y096TXdMc1JIcUM3RTZUNjFsZ1U0V0FzVDdp?=
 =?utf-8?B?L1BiOWVOV1FLVmVkcG5qdXB0a25Nd0ZuZ0Q4RjVuS2RJUERwN1F2QXdFbVVH?=
 =?utf-8?B?eUdGWThWU1owdmdMY2M3YVFTaHV1NEVITmtjWDI4MkVUZm9GUFBYSzVJRlZ2?=
 =?utf-8?B?dlBZQWI1dUlmVkUraTRicGhKcmxUWmhxUDh5cHJ4eDU1Z3dxbFQ0Uk1VeU9o?=
 =?utf-8?B?TjBoRnFkNFo1ejhkQXduMXFTOHBjSzlNa0VtdlRKb0V2OEFPbGkyK3hkV213?=
 =?utf-8?B?ak9vQ09CNDFxNFdSRExjcHkwbms0TmZsbmpWZis1RUt3UVoxZ2h0RFNTL2xn?=
 =?utf-8?B?a3BhM0Iwa0FVNjZlRnBOSExpM1lJeHNMei8wa0VubDNCbUVsK2dtdFlFRjh1?=
 =?utf-8?B?QVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4be805c9-7c07-4db6-7426-08dc870d3cc4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 16:16:50.4346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0hXlR5UhhrLvIyqWtDY6RN0pxpLsjR8Zc6uhcd7q8kkINonDDNAdE0hgb8YDDATYjrmj5uhBbKwjzcASmbmvuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5554
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Jun 2024 16:17:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16180

On 07.06.24 15:14, Jan Kiszka wrote:
> On 07.06.24 11:52, Sai.Sathujoda@toshiba-tsip.com wrote:
>> From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
>>
>> This series of patches will trigger LAVA jobs which test swupdate, secure boot and IEC layer.
>>
>> Changes in v3:
>>
>> Corrected line difference in [v2 2/4] patch
>>
>> sai ashrith sathujoda (4):
>>   tests/templates: Include functionality based templates
>>   submit_lava.sh: Add script to submit the jobs prepared from templates
>>   .gitlab-ci.yml: Add test targets specific for CIP core functionalities
>>   doc/README.lava-testing.md: Add README to explain CIP Core testing
>>
>>  .gitlab-ci.yml                          |  33 ++
>>  doc/README.lava-testing.md              |  30 ++
>>  scripts/submit_lava.sh                  | 464 ++++++++++++++++++++++++
>>  tests/templates/IEC_template.yml        |  74 ++++
>>  tests/templates/secureboot_template.yml |  65 ++++
>>  tests/templates/swupdate_template.yml   | 125 +++++++
>>  6 files changed, 791 insertions(+)
>>  create mode 100644 doc/README.lava-testing.md
>>  create mode 100755 scripts/submit_lava.sh
>>  create mode 100644 tests/templates/IEC_template.yml
>>  create mode 100644 tests/templates/secureboot_template.yml
>>  create mode 100644 tests/templates/swupdate_template.yml
>>
> 
> Thanks, I have applied these patches to next, and the pipeline is
> apparently running fine:
> 
> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/pipelines/1322502481
> 
> Note, though, that there is cleanup if not fix-up potential: Please run
> shellcheck against the script and address the findings. This should be
> done on top.
> 

So, pipeline is green with the new tests, at least after kicking this
one off again:

https://lava.ciplatform.org/scheduler/job/1145401

Not sure if this is a LAVA issue or some worker problem. We should keep
an eye on such sporadic infrastructure issues as well so that we can
soon remove the "allow_failure: true".

Thanks,
Jan

-- 
Siemens AG, Technology
Linux Expert Center



Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A00DFC021AD
	for <webhook@archiver.kernel.org>; Thu, 20 Feb 2025 06:39:40 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.70])
 by mx.groups.io with SMTP id smtpd.web11.43967.1740033572577865585
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Feb 2025 22:39:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=eXJ9Zmoo;
 spf=pass (domain: siemens.com, ip: 40.107.104.70, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vlz1E98urrbFIleKDBcmSxWNc6BCvlMqU1uRTdq7966ozFWNoUBiZwI0kDd+JL8h9MVMBnY/y7NUyFc/AI6EyQBKfPRnfDyvkWEI1r7A/JyD4qXp3Q77mOQ2nRQAjTnroO1AC8QfswCuTjZkj3k8PbNrg3ickl55fet7L3Pd2r70jMNVN7XpQWdX/387nQBcVo/aCugdfBX6ZKapx/Z2dWg8jPGauw9+Q0Pb5BO2hjGorzsCd5pGEtvUi3aKjI93qROzOl8Wf0MiqIpVi7jYz1RWriXyAkn+idSx5IWupE7aiBq5AsJ20lJ6c2k1keEhJg/NpEgE9V1SaFMsuqvfLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aVwHmkl1v1mQx1s+UM7knIBfHaE5Nw7FZCHzWnqDlh4=;
 b=aqP1c/4yo3EBtHasUGHnVn7YCuY4ymUpuqjmPKCgjtNdgRX20bFsOB7r4zvgYckkHwJ4wQmoqvMiM/IDXV0ZlhLGefjIYMCDEimwoPNFW0SdJEhNLs/qMlA1MPQJfl+fvm99H/6NcMe5xCvMz2CrZmhq4N3YSBAFbtO3xsR8q38i5EuZ5B2R9MS+eBSKgNPHKgncTQtiSK/XKI1/i4TmZD7s5mSPSXrwG9YmETwBeSDm6JV2OiOai/0jO3hsppfjg28I9ZUVBtg9WVzLGcbyREL9WBaMaMmYFRWZcF2r2oJ2kK+dOfxWu+aT83xZvSMsWarxY++nCLJofgC12viPtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aVwHmkl1v1mQx1s+UM7knIBfHaE5Nw7FZCHzWnqDlh4=;
 b=eXJ9ZmoofjoK/0ll/l2W+iLOqGb1tXoVNlzb3R4Vngw+lVXjLG5QLmj+Gun+v5KZaHjwdNgGkdiuAZdiFcaUme3c5UdO8N11Z8a0rJOk+qHqnWcT3wktcQvbeMLHhb1THVcftuLYcvNM10yOBtA0pau5f8UMsjKUfswgo7WBeQ+0rRwvcm3hMgZecZptMW+GOUoWN5br8AOPTMI6rtB5R+tpyisXcfKNuIM/fg96H8j3mCxKV7TRaa0iRix8qphKeP7Y6/HTSf421LpPtws9Jfz4zFC2NM1/R/fY3BUttiJuZPMmhPD7wzXI+YXg2peoTuzg2EUXSo1R2m1r8MouSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAXPR10MB5278.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:28f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.12; Thu, 20 Feb
 2025 06:39:29 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8466.015; Thu, 20 Feb 2025
 06:39:27 +0000
Message-ID: <61a372e8-7173-4922-b8d9-1be316be4b35@siemens.com>
Date: Thu, 20 Feb 2025 07:39:25 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0158.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAXPR10MB5278:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ad9a7de-35f8-4585-7a4c-08dd5179523d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ckN5bFE0Zm1lVlVpZkRPcWpOSGkreklOMlIybVBtcXVFbTZjbmQ0c3pOMkJC?=
 =?utf-8?B?dXNONmZJQ0o0QTNnRFpzYldkN0QxaUMvUWhUZ1Q0OFRFWnl1ZVNqWHRxeDEv?=
 =?utf-8?B?UFRIcFcwdGRtTTUrVUs2Vzh4VHIzOXRwamdwVFdISnUxdjc3OGQxT0pOcVBz?=
 =?utf-8?B?NzQyNmEwdGc0M3liWFkyTXRDMkJiM1BQSFJyZmRXWUl2NFlJMjA3RHFlSXpD?=
 =?utf-8?B?S2NVRzRsWStKYkpNWEY0L1k2QXE1MUZyL1JUemdvYlRPZFN0YlNVTWdPS3Vl?=
 =?utf-8?B?RE1xWU9LS0lNT0xVTTIwUGw1SGtwcE5LTWdCbmRHRkVDWjFtd0U0VVFZdlV3?=
 =?utf-8?B?N1NpTUU0MmdKNThqc3pPa000T2NUeHJIWEN6cWN3THVFMTBpK2ZXNG8xei9O?=
 =?utf-8?B?SEQzMlNwQWV3RnZDZG9BVjYzVnF6Q2FZS1NiVVhZWllDTjhQc1ZyNElCK3o3?=
 =?utf-8?B?Mnd4WVZLRW5YUnZKaTR1bDYwQW9rQTJsa2EzYy8zTlEwYjkzSjhSR003QW5k?=
 =?utf-8?B?WGJvTzhkdXMzcGd2U1FuMDBJNzQ2RUN2cVJ1NHlBTElCTkNGRC9QS3lpcXBa?=
 =?utf-8?B?VkwxVzBZcHB0eE5seU1DTzhLeHpEMGRBV2cvN0tVemR0VnBvcjM0bzZVaVRH?=
 =?utf-8?B?amp3czN5Kzh4akoxdC9jUDkvbG9wZWtFWVFUcmtXU0RNdlVPelRvNEUrcmJE?=
 =?utf-8?B?TXdKR05qRWhMLzRwRDJEUEloam42amFmcEZjTkdEQ1JkdW53N3Jvc1ZVVG5M?=
 =?utf-8?B?aWNRZVI2bk44cnQ3cVBNWmNQMlFIbXBMM3g0QXRtZm54cXlWcWlMTmlncjFn?=
 =?utf-8?B?bm9hNFBXMEY5NGd6UUlhMk43SFdoU2U0Q2dJNHI0Rjl5WXo2YXlLem5VdVln?=
 =?utf-8?B?VmZ4Q1ZIbW54RmhMV0Y5clJDM0d5WlU4ZzNvcFZFT1Evcy96ZFlXcHlxTm4w?=
 =?utf-8?B?VmJkTGlKRE0wUGpWZmxMYjNQcWI0NUhIVmVkS25MVjBJQTlEcG14c2lkZjdm?=
 =?utf-8?B?c1hCZ2N5Qm0yYWJTM1RDcWp4RTcrbTFoQndBdDNOa0Z2c0tjclpqTDBPcXR3?=
 =?utf-8?B?ZGFPL1R6dE9CaGNpcnhBOGdVcGgxVlFBTDlVZmtKN2xSNWxLaUZMSDVPbm5T?=
 =?utf-8?B?YmFzbEcyQ3VWS3ZYOHZsRm5yeGxTZUIzL2JVdzNGamlRRll3VW1BQzRzVTB3?=
 =?utf-8?B?TmpNa1dEdWdjak04Ni9Od1hOanRnZ0dlQ2hhVmE4UHdqL0xaWjREaGxIeFVD?=
 =?utf-8?B?ZUZBaXBkZlZ5QzJGM2xZOWtBN0gyNEpaMHo0cU43VldFL0EvZGRmeUdFUGhz?=
 =?utf-8?B?eVlUdjVNZGFYQTVaaFBzU1hFUFJMcFdWY2JranBiNmlJODRuL2pEV3M1QWJz?=
 =?utf-8?B?SG9rbzlwYkRXN1dOMnhaaDFMZEVaNG8rb2pVeDBYUW1TbENuc0xEc3p4Z3lw?=
 =?utf-8?B?cmE5dmxEU3F6TjRwQUpHdHozZFBPMjBUa3E4SEVDVmV4TXR6TG9WWm1zc1Rn?=
 =?utf-8?B?akthQWUrNlB6bExtTURHS2llRkw2eUNGUTRpYVJteXFGOENLY3YxNlFqT01R?=
 =?utf-8?B?a3BVMDVJeTNsSTFUMXFqeEZjOXdpR1V6cXlZYTIzNVBjckVTUFh1T2VCUkdZ?=
 =?utf-8?B?eWNZRHhLZ1Z0VExDRTg1OTRueU9WdjRGUkpSNndqQmI5aGtOWVNua1ZYdmVO?=
 =?utf-8?B?bUtHREhKRVRWZDlSK1h4NXpyMTlqMlFLMXE2ZzhnZ2tUakVONklYNHhldkht?=
 =?utf-8?B?NXdFRnNHQTUrL3VJT0E5OWs3S3ZtWUxXQzlEVkpKU1laYXVzZUtnSG40ME1D?=
 =?utf-8?B?cmY0YUJZd3c4MjlLWWFzUT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RzJPRVN0R0M0d0p3WHF4b2Qvbk5qNHczSUVOQ2MrdEtXa1dmaG5lc2pYY0Rr?=
 =?utf-8?B?T0NXUWdDQWhrWHhHMjRud1lRWXVrT2t4NkJVbDFBajM4eDdGUGZTQ282RmF2?=
 =?utf-8?B?bGh3QWNsem4zMTJEVDFWVmQzTU0zNWxJTEt6SUpaQTZ3WjBHYmpJdi9QM0Rh?=
 =?utf-8?B?cHUydm9naXo3YS9NdDhQR2pKL3FrcElBQmJNcGZPNTNDb1NWeXRFOHk2dlkv?=
 =?utf-8?B?d1lhenIyengrTU5NRVlsb2lhUytza1oveVNRWHBETm5RSU1RdVdmNzRDT1lj?=
 =?utf-8?B?cTNEOFlBK3JveVdCVnorenJFalc0YktpVnNPWUFBdjNCaC9VdjNUUkFCRU13?=
 =?utf-8?B?bmlXS0V1dW8vWTEySHZEZW9HQVdMWnlZcndFQ1lCNS9nQ1czRnc2UUJkSDB5?=
 =?utf-8?B?RGtKK21zbmhTbGdGQlNwUGpyR0h4aXNncmV4K29iVTJRU1RJZnY3ZEFweTFa?=
 =?utf-8?B?eDZOZkxDTVB2YXlscitUR0Vqdmgzd24yYytPZlc2ckhkWVJLTjkvcnJ6ZGUx?=
 =?utf-8?B?cytVT0FkSHhEOFlic3ZEeVZIWjNXelREbDJMRUQ1TmsxL2tGYmlVN3g0K3ph?=
 =?utf-8?B?WTdKZW5TM3RoQmtiM1J2WFRRRmM0REpYSHBlV2ZrWUJ6ckI1R3RjRm44VGNw?=
 =?utf-8?B?SHVGZmlqbi82bXA3OW9QbFR2N3NwSVBWTUxhTmNKSGJaRUhaNXFOaFhLcEZ3?=
 =?utf-8?B?WEVPQ2p5dnZjZzgwWUh5RjIxK2tLc2VqYy9sa2lKbTNSM0d5RHJ0OTVITnJ1?=
 =?utf-8?B?L2FqNGZEQVRzSzI0bGcyQUFQUHh5Nnl6MTN3NVFyUFgrRlltcG9ENkhBRUs0?=
 =?utf-8?B?TXJZWVNQU0xPeE5VQUNHUWhBKzRkZlFiYnVCMCtHT0FzVkluR1N1QllhNDRV?=
 =?utf-8?B?cUR2dmYvWkNLY2lFcVE0WnlhcHdsUHNlRUlOYllHZkc0M2pHaUNHcUppZ3FR?=
 =?utf-8?B?ckYvOWVWTW1vYjNCZldlUUFUMXVYN0RuaWtOaHlqQUg5WlhmM3VDc3FHVk5t?=
 =?utf-8?B?UXNJUEgzeE1OeTBkSk1mRERkTTRyR1RCaEl6eGMvZ2k4Y1R4ZjZuTmI2TU1h?=
 =?utf-8?B?dTNHSVZqR0duUHRXbmZ5WVkzZUpMRDlDN29HUjlSWmhPeHROeTVhU28xWWpE?=
 =?utf-8?B?eVZxWFY2UTFPcmNVdXhtWHNiRzlhV1U3czg1Mk0vMG1LeHd1OGtCb2FNWUNH?=
 =?utf-8?B?ekMwUnpoT0RUN1lBN1N6SnFMYUxzMnhMUmI5SkpLN0RjaU9qQlVVclhRekdk?=
 =?utf-8?B?ZlhXLzdmSkRlVVJKQ0E4Q3ZWb2NIK1NNSXhHaExocGhSWEExVnZZamZEQkw0?=
 =?utf-8?B?bUJXdFlZMHBPUmsvazlCVGxRWVNsMU5CYjNaTUVUbFBSOWNia3V4Qll1ZkdJ?=
 =?utf-8?B?NlZvZGRIdkx1eitlZm1kVVpNNEpQMVBTZ0V3YldvNXpjRDVNTFFzT0ZrTnFr?=
 =?utf-8?B?aFhlL3BYWGRXdHVEN25iTHB2MCtHMlVlbUpoVlBaLzgyQWdkUWs2TWw0N09I?=
 =?utf-8?B?SHNmd1Fkc2FJL2dLcCtiSWFncWlReHZtcmUzSjNsSjF0dERVN2liNW14Mi9x?=
 =?utf-8?B?VitIWVhRVmx0MERBcFdtMkJVNzlUSkdvN0NMTjNYVnhKamZqbkE3ZFQrQkhD?=
 =?utf-8?B?R1J5dWZLZjRyTzJMWUt1YkhQNWV5NjF5aVRrL1V1RHc5c2MyMGJIbktjbzVK?=
 =?utf-8?B?OGs4YnhhcnlwOU5HQnUyZVNaWkY1VFhlcldNcVJOODMyUmtHMWZBR2VJTktQ?=
 =?utf-8?B?N1NUK0dwYXpPazJXeExML3QyME0vTlIrSmw1K3hUK2J6dVdsWFNneHNDR3VQ?=
 =?utf-8?B?SGtRZlNUakx6K3o3RU8rU1FVcGExNGNLV28yYlhmekdhMEpIVjREVno4QVdw?=
 =?utf-8?B?QTJhRWVTSG9yVFE5RmtHVmhnKzJpem8vL3c4amVSQXdWRVVpS3JOL1lhZWds?=
 =?utf-8?B?c2hLTjNnTjhhdFFWWVNacldYS2QvQ2VJZ2Y2dnp4VFJRZXNPeGhwRUxyelJN?=
 =?utf-8?B?enFsaTg5MXBLa09xbFo4MFR1ZlhRUnpmWFd2dDh0ajJXM1g3TWt1MlBpS3BI?=
 =?utf-8?B?K2JweUpsZFdTdnMvRWpDS2ZVSE9CYk9PZGFkbUlHZ2xSWjJaZ010VzJUdzA0?=
 =?utf-8?B?d1NzcGk2QVdTaHpMemFmc3h2VzFPU0krV1BiY2w0LzdrTk5OTDhiQTgrSTNO?=
 =?utf-8?B?VGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ad9a7de-35f8-4585-7a4c-08dd5179523d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 06:39:26.9958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J1wdZoPsCap+7MTJg1ErGAZc8KDRXnneqcUOMj39IYCV5a5Wii+exjZDV+NoCH9+lUevIfTUhL3uuymlBOFalA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5278
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Feb 2025 06:39:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17872

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2025&month=2&day=20&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     13:00     14:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2025/02/cip.2025-02-13-13.07.log.html

* Action items
* Kernel maintenance updates
   - heads-up for https://lore.kernel.org/stable-rt/CAMLffL-PTp+Y-rXsTFaC5cUJyMMiXk-Gjx59WiQvcTe46rXFrw@mail.gmail.com/T/#m67dce3408cac40318ae3dbe1c713b13621ac66c9 regarding 4.4 and 4.19
     (5.10 and 6.1 should come via stable-rt)
* Kernel release status [*]
* Kernel testing
   - RT testing (also in the light of backport gaps)
* AOB

Jan

[*]
linux-4.4.y-cip: interval 30 day
  latest version release date: Thu Feb 13 07:52:32 AM UTC 2025
  limit date: Sat Mar 15 07:52:32 AM UTC 2025
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Tue Feb 18 08:21:29 AM UTC 2025
  limit date: Sat Apr 19 08:21:29 AM UTC 2025
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version release date: Mon Feb 10 02:15:53 AM UTC 2025
  limit date: Wed Mar 12 02:15:53 AM UTC 2025
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Tue Jan 14 11:41:15 AM UTC 2025
  limit date: Sat Mar 15 11:41:15 AM UTC 2025
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version release date: Thu Feb 13 10:01:34 PM UTC 2025
  limit date: Sat Mar 15 10:01:34 PM UTC 2025
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Tue Jan 28 02:45:55 PM UTC 2025
  limit date: Sat Mar 29 02:45:55 PM UTC 2025
  Status: On track
linux-6.1.y-cip: interval 15 day
  latest version release date: Thu Feb 13 09:09:51 PM UTC 2025
  limit date: Fri Feb 28 09:09:51 PM UTC 2025
  Status: On track
linux-6.1.y-cip-rt: interval 30 day
  latest version release date: Fri Feb 14 05:24:30 PM UTC 2025
  limit date: Sun Mar 16 05:24:30 PM UTC 2025
  Status: On track


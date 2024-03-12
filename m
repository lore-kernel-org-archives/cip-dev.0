Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 075D5C54E5D
	for <webhook@archiver.kernel.org>; Tue, 12 Mar 2024 18:12:13 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.63])
 by mx.groups.io with SMTP id smtpd.web10.3714.1710267125749210649
 for <cip-dev@lists.cip-project.org>;
 Tue, 12 Mar 2024 11:12:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=XIq6DoyS;
 spf=pass (domain: siemens.com, ip: 40.107.104.63, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iebKxi4alDEg1/n8JGhBv7+EocxB1pmsfrQaRF70Sr8BSo+RsFKvRwHVbWZAR/6CJsUIxu5EV5EBCkd4PuWmgZ9+gnDuZB+cYdkAOukRxratVpZCtRy/ins2+X4/hPj7DnwqTetD6GAuMzMSvrC3SOzDj3u4izlghsOMmKVrO/XTNJ7RVKMU9w8b84g0qkrO2NyEtB/kL0WyXyof0QnpzhCiNS6sgga1M0NCokyAi2OeEewBo2XNuCRrlw+ZEURNNNUXcqAH1Xrw1pni28mA6N+FCPrdfPd4R5HvtB0PfXU49OFqs4IeqtYORUXyLL/T4Lq26RmohJrsKARNhYhl/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T5ZLOg9muzOrrVKbCgUcWxx4REHh5dFue0cEvQGEUNU=;
 b=NIAQbIwWkK6IJthK+oRa1/sjv2CcRAAVb0B5PYq/++lISp92YnfwJPTGAb0evd3zdX3KeGGttMDLoRKmBCVujne4JxqBxJbDjI6P7uNGHI4HV55e+pCMHNrXeIVls3dTZp6ZztZoCIWPgBdYgoo4KOPhUYS2LQQ1B/jeCEgCCwzoxlff36dMhyaYPyAXqW5r3RGZf0kOsr7n7tN3k21+O9BVMqka10hKlkw+G1p55FSRsN8s9LrTAQHBHcXGc1hrYziL9a8PC1en3sBMhlLttoMhdYTgSC6ajHJqCmAhrnuAr5kIs9uNV+2nDfcG09lH+V6CdVojkqVSSXaO93RlKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T5ZLOg9muzOrrVKbCgUcWxx4REHh5dFue0cEvQGEUNU=;
 b=XIq6DoyS8omFftDaRbZpnjqmxBVx/0cRXXCcIoNbTHYuwGXbZAS+FEMRcCKWElXlzGXF7LgxBGg76KQj8gWZff2zhfj/bgwb69JBGtoYWqILNktAkY8v5MZ36rYukQdk8AvVJRuO2LjF/HPZ17xEYn1KI/ahhs9LQ3dahYbaXfbWcs3tNflFcFLAzrlytJ1LrdaP2cLQhs6UX0y2RfbIWrE+Ms8DUXCCGUHZmus3lTMP6A30LY8KFRkDueXCjp+pg5snxN+U4Ao7Chjg29tXgXwt0ht7lv3Mm1yOR6r+Ey3Ux2Iij6aJeSea77Q6fRKfTboJfKBwa3es5+HyFryp5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by AS8PR10MB7970.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:568::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 12 Mar
 2024 18:12:02 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67a7:ac13:3db4:91cf]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67a7:ac13:3db4:91cf%7]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 18:12:02 +0000
Message-ID: <894ebcd6-aa83-4076-abea-2ba743536183@siemens.com>
Date: Tue, 12 Mar 2024 19:12:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v3 0/6] Make swupdate signing more
 robust
Content-Language: en-US, de-DE
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org,
 felix.moessbauer@siemens.com
References: <20240305161128.2777211-1-Quirin.Gylstorff@siemens.com>
 <66be0ad7-bcf9-4383-bddc-34bbbb000e60@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <66be0ad7-bcf9-4383-bddc-34bbbb000e60@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0027.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::7) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|AS8PR10MB7970:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ed12e27-b1cc-4769-bd51-08dc42bfead4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	SmzZJiQn3wZ3q0BbNUFTpt46GmbwNxlDxrChr8hr7NTimLx4A6XtpmAYPJS0gNPv8AQojC/dBrWiNJUi4N/AsN3lszW4Fo87IeafgjQdiWDXCtK7XhJ0ccwpz7A3LncIxJCDfYf9C+YRhR6jTF/zoojzgR42SrE5Kr9L4d5gBoR3+D4LxKjsGvKKksJd31l2qNrAbCf+6MblGc73jF5kmpu7fe9xpHQztpAM5Z/mgi2hghkuTZuUAv815Y7IjWRrPrPCOf6tAO1uSRDd7Ghax1M7Y40Bqpq1FbsnvswX9j0azBbPWxWJgdV4Fm6a40eVyE6Pa7V7y5D3nZFT9eM0Wf6ot1gcrWU8GXJuF9ru7cAumpvxD6/OIDEGwYAMqEljzJhy5gihysZqfmoL52HXmjvv2Fzp1qdKr3mRX7VtwiwBkPvhcUKxPIAmvESG4zGYI9zgYlyOIIP63U6w9M15YmRHHDW0CNGYRWUotWZ/ery89+PsPzJjftoLsfBXOF+gQxOPH1+9qXIpUF4MeL0VE6dky5QNIL63RsGo8axrGGOumOWqXrQ5U5+oTebgLVkIUHi7U3SBP0sYzT/FbTOlfM+5k6rDpf5n/kYqZ0SJoJv73YcrJDQ5Cax/Vx1Vqtv3960Nuc5hIUUwxYgfJlluWg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aE1JNGpOSy93QVFEZzFUa1NIL2pNbmtGQjBPZnRRaW5UNENHOUw1b0ZvMFdm?=
 =?utf-8?B?aDBERXl6NzYwU1pDTmlrVDFVS0t3VStkR0xaRjBYTUo4NDFzaG1hdjUxejJn?=
 =?utf-8?B?OWI4Z1ZNREQ3M25Cbyt2THRTTUxYcTI0SVdaejhGZ3VnTWNwOXpSSXRGWHV3?=
 =?utf-8?B?d3lyb1FPeVRTQVFTWGxoa1JIcGxNREdnN2tVSHYrWHFKUnFxbXJlYXZrUTRx?=
 =?utf-8?B?Ty9tdUswUks1SVdRdFJyclFpa0R0ZFJtamdPaHU5TnV4Und2Nmp6Y3JqT0s4?=
 =?utf-8?B?YUZqS2xCdFYwMXVHTFNsSmI3VTJ0R1lSNWxzQmlFWUZmaVg3K0VVb1k3a1Uw?=
 =?utf-8?B?MEpBMXVaV1ZFRm5WcWczdnNSdXdZdHFBL3d2a2orb3daZlNNVUNIR1JPSkNu?=
 =?utf-8?B?TzdxRTAzRDZ6cmY2L2JFQW5YemV3N292QjJ5S01ENkdxL3BaY3Rva3pZRTE5?=
 =?utf-8?B?K2xVTjhwY1g2VjRIZnlPelNQRDhLY1llT0N2T0g3d09IYTRLSHFsUFVqVFJN?=
 =?utf-8?B?ZG9oUE5lQ2txY3FXUnZ0ZngyNzZGMjBFZUdkdFlwMS9TNFJiMjY1ZUFDWVhM?=
 =?utf-8?B?Zk9YWU43T0o4ZXAvalFCeWlnV3ZuNzlRdS9mOTZwbm1XQnRrNE9VZ2FQenlr?=
 =?utf-8?B?M0RVeU40TUdaNXMyTWNkc1NOcE1SSllvRnpJbWhmUXpuWGVXUTh0a1dTZE5x?=
 =?utf-8?B?eG5GSmRxQTgwQWo4WklzRUJjLzF0Z3QvMnM4cW84cWVuWm5hV255ZzlJNEZL?=
 =?utf-8?B?R0lnRlBTdW53T1VxOUMyYnJIR2hTcThUOGZUb256d0U3VlJXYzN4VDZGOHdG?=
 =?utf-8?B?TjJhd0J1RG9SZ1BSazdqKzhLWDliS2tuVkRGT2JJNE8wSHBxdStPTnZueE1C?=
 =?utf-8?B?eDRqSFZzUmZVSnRadkdmeThMSXY5SXZUVWxxMmdlbHZnL2Nlci9hT05SVHlY?=
 =?utf-8?B?dGJIa2syOXZCbmpRcEdQd21XRE5zTjZtbmpTZEF3eTF1cU5MQXIyNURlRkZJ?=
 =?utf-8?B?dHMvOCs5U0ZDWGVzc0xmWHM1alRGZjI2RlBlTGxLOHZOWk9wV1A5RTRkNndQ?=
 =?utf-8?B?MDJVeE9ETEY4aEpmTlJWUGN0SGZCMnhWeThaWUcyN2Y4OHdaZGFhWk9qYTJM?=
 =?utf-8?B?Q0ZwM0s5REY2cG9WT1YwVkhrai9KVWxZTlZOVU5hR3lyaThPaHRyMUU3c3hx?=
 =?utf-8?B?WDhubHlzZkF2V3EvNmE2ZE8vc2JwekFtaXoyKzYzVU5jZ0hId2dQeFpkL094?=
 =?utf-8?B?azIzL0tONi9vZWJPUEdiYnd0UEU3TkdIaVNVL1Evalc0bFo0NFB0TGpvalVj?=
 =?utf-8?B?VWROSVYzT1NPdFpJMWxhVDExSExCam5iZlhMaUZXakpyWDFIbkdpM0hiM1Fi?=
 =?utf-8?B?SkpoK3lNM1FSU01QcjZKcVdtVEsweEU1SHFLekJLSEpkTzI0YjdJSWNXV2lG?=
 =?utf-8?B?RytLRXJaUTNLTlRmWEI4L2U1enpMSGxCR01yS3FxNU4rZG1TalJiT3laNjZT?=
 =?utf-8?B?Nm8wdEVNRXJQaFQvNjczVXhoQW1qa0gzakovc25RRTJabkw0K2NBb0FhZ09y?=
 =?utf-8?B?ampubXBZQkswTkNNSktheXlaTktEZlN3Z2xlRU1zWXdYWU9IcEZIOENtajZD?=
 =?utf-8?B?K2NCRVhXR2tzanZ3MVJHVUptd3BrVmV4a3BDbGVBUjlVU3J5VXRiclJXZlFy?=
 =?utf-8?B?VlFVcC84V1RwaGNOK2FLeGhlMzN6L3NVWFVqS1RmOU5nRFRicEl3WHd5eUwr?=
 =?utf-8?B?ZE5Uc1FDRkU4NWZKcXZsSkZ3WEZOYzFtaFRXWG1iaS9KcjBvZGVLdUc2Ny84?=
 =?utf-8?B?Z1ZpMnhLajVHL2xQUEtUQVB0dFNLRllYcFFpRDBqYkg2V2pHcE5rYVdlckN4?=
 =?utf-8?B?eG5JUGNPQ2lVUFRSSHp6QTVZMVYrN09wMGdMaHdzOVltdDV6YkhrQmxTNWxz?=
 =?utf-8?B?YkY2NGlSVHdWdGE3dTNZUlMzMnZRZDVGWEY2YkY1amlWSmV0YXNONDFtZVRs?=
 =?utf-8?B?MktxbHF5STZnbmh1b2l6Vm1FNFNDRzEzOEIyKzhsQlNESXNnZEk0MzJxaGV3?=
 =?utf-8?B?UTRqM0h6N3l2d2lUZjhTazVEblc0U1RtcGxNMU5NVDdJZTFhaGtOa29meVhI?=
 =?utf-8?B?NXNOemI1TFVsM1N6NHQ2cmhnNzJNZzgraEQ4TkxzWUNBY04vS2tyOHpzTS9a?=
 =?utf-8?B?aFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ed12e27-b1cc-4769-bd51-08dc42bfead4
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 18:12:02.7287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C9hW2oEoRhYjGV9KDNDFzlzZebnpCLaMPcNDPyW6XH8BapN9VOjiFCLAPzM5Q42CoSZpgPdbvMwpO4uyLzeyHLuR2Kl7FlLG47Ym+xkDTvM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7970
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 12 Mar 2024 18:12:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15280



On 3/12/24 9:40 AM, Jan Kiszka wrote:
> On 05.03.24 17:10, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> This patchset adds checks to validate the certificate and key before
>> used in the signing process.
>>
>> Add also adds the missing Documentation about swu signing in cip-core
>> and fixes two issues:
>>   - an error in the build logs of do_image_swu
>>   - Creating all existing image recipes by touching SRC_URI in a anonym
>>     python function.
>>
>> Changes v3:
>>   - rebase onto next(704353612238cb2ac1c16f29db6f314b60cd83b0)
>>   - use local variable to increase readability
>>   - add formatting patches
>>   - fix typo in commit message
>>
>> Changes v2:
>>    - Add information about cpio option in long form
>>    - replace cpio option `-H` with long form '--format='
>>
>>
>> Quirin Gylstorff (6):
>>    swupdate: check output of sign-swu
>>    sign-swu-cms: check if key and cert are valid
>>    doc: Add section about SWUpdate signing to README.swupdate.md
>>    fix do not add files to each image recipe
>>    format: classes/efibootguard fix spacing
>>    format: classes/swupdate fix parenthesis
>>
>>   classes/efibootguard.bbclass                  | 39 ++++----
>>   classes/swupdate.bbclass                      | 88 +++++++++++++------
>>   doc/README.swupdate.md                        | 21 +++++
>>   .../swupdate-certificates/files/sign-swu-cms  | 29 +++++-
>>   4 files changed, 127 insertions(+), 50 deletions(-)
>>
> 
> Thanks, applied.
There is a regression on next which was not there on my integration 
branch. Can you please revert.

Quirin


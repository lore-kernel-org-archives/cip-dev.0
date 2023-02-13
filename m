Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E10C636CC
	for <webhook@archiver.kernel.org>; Mon, 13 Feb 2023 16:21:29 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.80])
 by mx.groups.io with SMTP id smtpd.web10.18793.1676305278917467924
 for <cip-dev@lists.cip-project.org>;
 Mon, 13 Feb 2023 08:21:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Ln99K9Uy;
 spf=pass (domain: siemens.com, ip: 40.107.105.80, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jg8jwrca6FsHh8wRU8G4Doa4+/HFOYxD7+dyT/sXcJcZ7Hk32K4r1oedAsEnR6jhbwV/D+KvZi5ebV8vHi03Dh4gFzGPCvYRd0uKJTTXtVf+Ir5kyW2rZCJCdXi5HB4TTNCLDOcZabKcei4yTlHPzFZv+Nci3CYnXW754gNE7YQY3LL8QDtca7GMYYXTzDQys8gzCqzHOcdiKA5qlFQPUvFFY+C4jxIWCJYblPFCHUFoQUtYcr/4Qc4SubjpZ1zyqE9sSmx/ks+YYf3mtG6DnBl3ds2N8iS1pUXv88+dzLmKB10SWKx7Y8n14kY3nRBOXOmCRK2Sy7InD9tTewDoMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=apjgSQb7wdeBmB7v5igV8FhxxI193qILm7ytrHkqLOI=;
 b=kxjZ+I50UKZRPs5tAfpLuXBzDRhCz2BONxI3HJaH7RV8Sfhg9dYnUohPDIZd8Qnwf35W42GeIwHPzlKipA31iHIhGqFC8otUv+zlwzX86arBR/v9gHJWJghSw0vcMzT+vrE8AnNzrkD/qXnZpufgQN2YaKu8XlEC+UPw3cqWRi4l1AXpKGyN9fVvd/idTN6/1OotcrxwU5w1oZi0arofJ+JE0ItTEC7KGdxfDYA1Rwx9STIrSztz9JW3XfcCWws1O1imciLPmfrqJkZzfX282PLHbyh24sPOq5kUCvX/xmgIXh3bgmA+lZrKKpHJ+diH22mJryF3uu961HIN8jZ7VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=apjgSQb7wdeBmB7v5igV8FhxxI193qILm7ytrHkqLOI=;
 b=Ln99K9UyD7EdVeohSFfvWOo1VlcTBbce1Vo9/WWBSPzmHpqNYkri1mTbvUEB+keNDK++XAzVIVo9iz52W0J/9m278dfMw4X5kP9AVv3jQixUUk0Q6U8zyNYd8ZPY4j5OJpsWyKJU8SrPRsTsBkXqb/eWyEUElY+FP8W8v75qRt3u2iN4Pb2ogkfKIlXMuv8LVyyesPbJqU9EHAXNsBgx8SJCQNAym0PmVz6qhD23BQ1/S3FUbx0wKtceIc4sFQzQgVf4EahiYkUau156JGb30EYl9U441meKW2s6aK1+6k5NTFuif3vSnh61DCN6DkW+v/DYjd+MZQ73LERk9UNaCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7156.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:60c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Mon, 13 Feb
 2023 16:21:16 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%9]) with mapi id 15.20.6086.023; Mon, 13 Feb 2023
 16:21:15 +0000
Message-ID: <ae5644ca-b817-23c1-050e-01aa3f0eb171@siemens.com>
Date: Mon, 13 Feb 2023 17:21:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [isar-cip-core][PATCH 3/3] wic(ebg): add support for riscv64
Content-Language: en-US
To: "Moessbauer, Felix (T CED INW-CN)" <felix.moessbauer@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Cc: "Bovensiepen, Daniel (bovi) (T CED INW-CN)"
 <daniel.bovensiepen@siemens.com>
References: <20230213085741.1242658-1-felix.moessbauer@siemens.com>
 <20230213085741.1242658-3-felix.moessbauer@siemens.com>
 <938b99f4-a7c9-ed00-1005-0b2f0a489fbe@siemens.com>
 <679d812c0080ab414f9167b00abed1fc080e897b.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <679d812c0080ab414f9167b00abed1fc080e897b.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0102.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7156:EE_
X-MS-Office365-Filtering-Correlation-Id: a394ded7-7047-488e-e4d1-08db0dde54aa
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Dkg+55UT2w8estgYlOAoQeO6tXsxt/LAAb6o6CTlwLD8LoR5Mp+sCjIVDduUNxuetEoU0tyAiZy7BCxNs0EkJu4gKHZxX1I8RyrZcvQM0ucAPWXtAprDqDRvWSmZkg8LcOiAVeUZ/yMHURZk68eTYpVvyqYrZJ/BJTuejq7DdoszZ663dyMcmoTJqsC1mUs5+pdXdvDMjp1ycWMaPuCyJLWYIS9r55DhN/gQQkbstAEpsen1GINXnQR7y9sQAo/J4+cIay+A+YdN4P+ULpmhN6CfjtBsbq+txCcpLTISyEHThhaK6v3gdEOB1k41ZcnJgRyVWsl7XruEHnb4JrSxcNS2vDvNBtU2yL+UN+cdRHrh9ZZq4fco96vrzkL+2RPbTS5u2O8TxSBfQNVK4A2jI+YSgkEYvZfV6IC/6gd7M/3n8Xu3lrNsJSSgwSHhpJc1WZfMeD+ZObDl5Zeh1zKmiCl6soAFPbPi9U8VaVnPoVP4xSB4jIbCXVUfrSd++aKt96iktz/iT9pdqNngO/GCIkYHGf+CzzylhsMnSSYCzg4XESf6oMPGtyEJx/DK85lqBo0bwcetQPnumV+/aHKMXdnHbq/STCIMkAQqmoLZeIvwkdsfvZmtpxbj+wpO0e6wBYQNxjR6Sq3eXFPd7iBw9iKg+e3DjHM2P9+ihxSd8iO3bnxQsFXTTxEyQ2XHRSsuOUYPxfFH8azgRc2wBlisiCSrIeJLrOTTRKBHMneSRv8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(136003)(396003)(366004)(39860400002)(451199018)(6486002)(83380400001)(316002)(66946007)(8676002)(5660300002)(8936002)(66476007)(478600001)(4326008)(41300700001)(6506007)(110136005)(107886003)(66556008)(6512007)(53546011)(31696002)(2616005)(186003)(36756003)(2906002)(44832011)(38100700002)(82960400001)(26005)(31686004)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NlhjdWRpV0U2VGdlViswMnBxcEk1Zm84MDZveUZnREVZWFNzZDdmTlhhQnl0?=
 =?utf-8?B?OEwvd0lFRnl5Q3VXamFJWG92VElZVEI5a3JzRElEOEJtaFpuUmFxaE1LaTRW?=
 =?utf-8?B?K1FKODBrYllPdGc0cHNhT0dJbHFHazArUTJZWTRPYXJXbVJzRm5QRHFRM3VO?=
 =?utf-8?B?aXFvcHVlZzhlc0phOXE2c0dVb2pjY3RTRjJUMVlWVEs5UEI1alR0MWVwNmFy?=
 =?utf-8?B?WmhBRmVPRWo1dEwrYmN6T0gwWFVTdVdBdkV2SC9IWFhlbFR6UVRUMThNMmdQ?=
 =?utf-8?B?ZTZFSURSbFRCbnlvbExHdkRkUFUweEppUytxNGdYS3ZtQ1dNS01jS0tJVnkr?=
 =?utf-8?B?NDJ4UGJKampqV1d5TEwyMXdHTUZ0bzJUaUorNjBQUVplQ0V5NmRoeEkvOEcv?=
 =?utf-8?B?SXI4VHZWUEIxU1B0bVZiMXc3Nm85QXpXT0YzYzNzTDFiK0s2Y3YyU0tBOVZL?=
 =?utf-8?B?a1N1NVZqQlFKNkZVSTNtaVlhbFNQa0JuRVRlM3ZHUjgwQWhnSGk3T09BazVt?=
 =?utf-8?B?Qy9PcjZNcmNzUGhOQmpjZnZUYzBCa01KRThmemUvM0tEaUt2VkZVMDBBbklF?=
 =?utf-8?B?K2hJQmtPQTlSVWR2bGM0NEloai9RT3BudFBMOHh0dTNTZ0xSeDFjLzdvTnoy?=
 =?utf-8?B?OENOa1NBR21jWStIWlpSelZsRk5oU2R2R3dDaHBRenppcjFYMHlScnRyS09K?=
 =?utf-8?B?QXVZSlQxQXNqVGkreVFxbi9HZy9WOFhORFk2OU9ENnV5UTFLUHM4NXRkTGpW?=
 =?utf-8?B?Qi9Ea3dNRFlKYzNMbWJydm9iQU5YdzZ2Y1Y2VllxV2J0ZDNLa29XZEpWaW1Y?=
 =?utf-8?B?SlI3emtuUWI5SDJXaTRYOUQ3bDN3emNDRWx2YmhaT1ZaUDczSEV3USt0ak5E?=
 =?utf-8?B?L2c3Tzh0VWkwVVMzK0JNc1hLUDQ2QXVFUURiS1Z2ejNRWWpQZlhieGhKeW9P?=
 =?utf-8?B?ZVZDQ0EzeEVYeVZoc3VWMEErM0FWa0EzQWt6bEsxYnltQjlGK1BTUno2M3lr?=
 =?utf-8?B?ZEFMZkxJZGdSc1NaUlViRkNPVWZNRzBIaWdaS21HRVdOZ2xBU2R4cmQxeVVY?=
 =?utf-8?B?N2Y4ZEZsZmVWU2FLN0FOREZlQ1RjY0xvTHVxWHpacDVHN3M5R3hlcDZ2WTRC?=
 =?utf-8?B?YURnNDYrOUxDSzViNEtzNjE5MzZCeklkbGI4ZG1ueXBFWDNnUU5waEV4WW9L?=
 =?utf-8?B?aTVTbS9NdHY0czJweEU4Y3pzWlV6MFVBRTVNWXA4Y3V3MXlmU1ByL3prWFpP?=
 =?utf-8?B?bWVPVVN3N2pyaU1zcDNpNTRiM1Z0UDdmdmJlbW0wNFpXMWxIVm12Y2pMMjRa?=
 =?utf-8?B?WVh1MGJlbytLTjZDRnM4RHhsY1ZqZEJEY1BsckxMaFZwQkV6RlkwbjUyZ2Rw?=
 =?utf-8?B?NklmZzgwWEkzS09RM0xvRjdUWHVCVWVkUjhvQVkra28zUW5SRytoWGVHUSsw?=
 =?utf-8?B?Z0pxTVZIWG9zWDhtdUlOTUxWanIwNW1zbG9MUWsrMkR5MXdDZ2ZiaWM3Y25K?=
 =?utf-8?B?V0VnWWNQUzJUWE1XNW1JNjA1YkphZnc2bXRORGk0c29qdlp4d1F1Nm1QL3Rj?=
 =?utf-8?B?bkZScS9yaHVNNERYZzJXWHFRQWY2WkFMUkc2QXFBbU5PRnR2VVBRSjRiYlpv?=
 =?utf-8?B?SzNQem9WVzFoL2RuVEEyWjBleU5oMVVVYVQ3RWZlMDNDS0plaTQ1ZUEzWDBx?=
 =?utf-8?B?VWFEYjBIRWpmaGdRVjB1OW9rM0x4em0xZk5GWHlCQ2ZYVjEwK0t1T2tpV3l5?=
 =?utf-8?B?ZDZ0aHVQN0k2SThIZEtvWlkxTHVPQ2F0aUMwbHN0UXZlN2FvVlR3MjNmd081?=
 =?utf-8?B?ZzFoK2FQREptbkFFQjhQTkIybUNHZ3k5SFV0ZnRiQTRyNm51UXllZThlaUJI?=
 =?utf-8?B?NFk1a09ZYzhvOTg3ekVIUzVpeU9zZXBnWUc2ay9na3NCbTcvSGhvMitldC9S?=
 =?utf-8?B?Zjg3S3pHTlJ5VEJENFBobnBSdVlPUkVYQ01JcUk3azgxbWV4dnBtdlNKZmZW?=
 =?utf-8?B?SzFHQUljek5rUUpwdXpvdkg5bXQ4cTVKV3p2TGlMVlYrOWIwekVTVm96VVVH?=
 =?utf-8?B?Z3JQT2JNZ1d5aTZaQnJkMEtpay9jakQxaFdreHI4RFJkVzgzY09iWXB2SGRF?=
 =?utf-8?B?dFFDeXFSc0IzZE5LdDNCc0VlUzZicnFxRFUvTHY5SXpOT21CT2JEdXJJdnFZ?=
 =?utf-8?B?V1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a394ded7-7047-488e-e4d1-08db0dde54aa
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 16:21:15.8693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 21VAEo+ZDvX303MBxpfKNxdeeXdvSTcCNpyDMwhimYwMxOdiv9IposXJwcunJ+ZCjL3esMxEL+HmRt16wIb5BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7156
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 13 Feb 2023 16:21:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10685

On 13.02.23 16:15, Moessbauer, Felix (T CED INW-CN) wrote:
> On Mon, 2023-02-13 at 15:45 +0100, Jan Kiszka wrote:
>> On 13.02.23 09:57, Felix Moessbauer wrote:
>>> This patch adds the mapping between the efi architecture and the
>>> distro
>>> architecture for riscv64.
>>>
>>> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
>>> ---
>>>  scripts/lib/wic/plugins/source/efibootguard-boot.py | 6 ++++--
>>>  scripts/lib/wic/plugins/source/efibootguard-efi.py  | 6 ++++--
>>>  2 files changed, 8 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py
>>> b/scripts/lib/wic/plugins/source/efibootguard-boot.py
>>> index 3d6b2d7..0de28ca 100644
>>> --- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
>>> +++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
>>> @@ -185,13 +185,15 @@ class EfibootguardBootPlugin(SourcePlugin):
>>>              "amd64": "x64",
>>>              "arm64": "aa64",
>>>              "armhf": "arm",
>>> -            "i386": "ia32"
>>> +            "i386": "ia32",
>>> +            "riscv64" : "riscv64"
>>>          }
>>>          distro_to_lib_arch = {
>>>              "amd64": "x86_64-linux-gnu",
>>>              "arm64": "aarch64-linux-gnu",
>>>              "armhf": "arm-linux-gnueabihf",
>>> -            "i386": "i386-linux-gnu"
>>> +            "i386": "i386-linux-gnu",
>>> +            "riscv64": "riscv64-linux-gnu",
>>>          }
>>>          rootfs_path = rootfs_dir.get('ROOTFS_DIR')
>>>          distro_arch = get_bitbake_var("DISTRO_ARCH")
>>> diff --git a/scripts/lib/wic/plugins/source/efibootguard-efi.py
>>> b/scripts/lib/wic/plugins/source/efibootguard-efi.py
>>> index 2d16fe3..d6cdf0f 100644
>>> --- a/scripts/lib/wic/plugins/source/efibootguard-efi.py
>>> +++ b/scripts/lib/wic/plugins/source/efibootguard-efi.py
>>> @@ -56,14 +56,16 @@ class EfibootguardEFIPlugin(SourcePlugin):
>>>              "amd64": "x64",
>>>              "arm64": "aa64",
>>>              "armhf": "arm",
>>> -            "i386": "ia32"
>>> +            "i386": "ia32",
>>> +            "riscv64" : "riscv64"
>>>          }
>>>
>>>          distro_to_lib_arch = {
>>>              "amd64": "x86_64-linux-gnu",
>>>              "arm64": "aarch64-linux-gnu",
>>>              "armhf": "arm-linux-gnueabihf",
>>> -            "i386": "i386-linux-gnu"
>>> +            "i386": "i386-linux-gnu",
>>> +            "riscv64": "riscv64-linux-gnu",
>>>          }
>>>
>>>          distro_arch = get_bitbake_var("DISTRO_ARCH")
>>
>> Now, does the swupdate image work with that already? Can we enabled
>> it
>> in Kconfig then? Or are there more changes still needed?
> 
> Given that patch 2 of this series is also applied, this works.
> It has been tested on the StarFive VisionFive2 board.
> 

Great, then please add patch 4 as well ;)

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux



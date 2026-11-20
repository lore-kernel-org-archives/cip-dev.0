Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4309.1795175202769935272
 for <cip-dev@lists.cip-project.org>;
 Fri, 20 Nov 2026 03:46:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=oBnwQAwZ;
 spf=pass (domain: siemens.com, ip: 52.101.83.44, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OQNv1kzRWfBK5XFicV96b0VoQki6l0pzsGq4H/vaGrlW+rNwN7tkkt5YuTgKv3RBnahflOWPs9jvnAMmMYOVkiqjSVxffVUI85xeC4/XemRfS30zonXJoPHaOHacUcZDE3xpUBM9o8Cr9e+vGFBWIm6TW4uU/u3Rve0hU9vN78we9PwzMjNZFCdkeTyb/0uXsvv67jUHPN3B8cjYWcfIO8ITPjX5RN9K8uu7W6TY5iZDu2AnhH1QVib8w1omuufrmXWQkmjgloplSAf2EPU0xQj/ia04urSQfegIGsefSpF6pCfVlxCj9OBGw/9M129lWWLLTFxl0yOWKooEWkVO9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AWhxupiFh2Gv/8nd2/1sD3fFdovZgyiT2kvfa05VBP0=;
 b=KTm/OyQSpBVMP/QsnlseN9g4uGPEELT/BByQpFDMz5UBRRs2Au2t6Kv5qgrvKwFQU7ga1Mg+KFu+lutqDjj/XRvASbvfkAdmlOf7ZgkGY4hgWdoDThlPTE0NcmBkyIxIhFy96fnfb2Ieb8zMCVq8zB8A9PeM55JRGIo5zDNJ8ibSHrLdTXXM4SQO0L2fqRHyjI0rq41wlRzL7aa27+e5U25gXqAVXkNK4ROydC2B6KjObPzdA9gTWEblj+zcNC+zLeWAyXBL4Kp600eVfDjnXzLG8WWWYi2eA4egbumcAvfmZDJGZUpZYni16pEbev0BhEdp2mNVUL2ozxgYgTMnGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AWhxupiFh2Gv/8nd2/1sD3fFdovZgyiT2kvfa05VBP0=;
 b=oBnwQAwZam8XVoz3ZzGRchbY+MjSgVUQ8fu9ZSwxC8XVwjLg8evSXpwDgvuE6wmEHTEmrNt2IQ+W0UrK7dXUZig+iCAmeIhuCjNCyRQ50kJCpKyAKQn73mQwRKv+R5dAJqgzdUKF10WWlNumB6qqO47V7o5rjf18CJfBawdyoC+iIWPuScn1Gp+xHq86O245hKpvmL2enaH/VCA7Cpd84X9J3MOJRcBbbEgMD7dYY/JlcdfAm/dsL3Wu4ho9C7LNZTQLvUczXFFGGqjRLV/MhwpM0rLv5ME/u0+Z4QbZjfMTWxSKuq86zOhiaY1XKfjcDAhDSZzpJngLAj48/uAWsQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by PA1PR10MB9489.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:555::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.3; Fri, 20 Nov
 2026 11:46:38 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0662.001; Fri, 20 Nov 2026
 11:46:37 +0000
Message-ID: <7a2529a5-964e-4d64-ae22-aa5d19e1f1f1@siemens.com>
Date: Fri, 20 Nov 2026 12:46:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][RFC PATCH 1/8] scripts: use apt-get in
 run-cve-checks.sh
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
Cc: chris.paterson2@renesas.com, nobuhiro1.iwamatsu@toshiba.co.jp
References: <20261120082554.375548-1-quirin.gylstorff@siemens.com>
 <20261120082554.375548-2-quirin.gylstorff@siemens.com>
 <c1209a46-3a87-47ef-929e-33b77caef9a6@siemens.com>
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Language: en-US
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 Z2NBPBZUysw=
In-Reply-To: <c1209a46-3a87-47ef-929e-33b77caef9a6@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0212.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::11) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
Return-Path: quirin.gylstorff@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|PA1PR10MB9489:EE_
X-MS-Office365-Filtering-Correlation-Id: 062185f2-aa03-4fa5-8560-08df46fbef6c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|55112099003|4143699003|11063799006|56012099006|261021123027099003|261021121427099003|261009223027099003|261102123227099003|10067099003;
X-Microsoft-Antispam-Message-Info: iuSJPg46ibByPlqA8ERzHn3li0BsQiKhX1QjwxRVlLotShhTZ5T2D6lO6NaYnVTVKpuBOEJHr0Waq+OVxRjbPTPN9QxMJGZLKyKViPVGqPwiOme1KSSyrTywI/YifPmkDHETFM1wnUXaSMrr2YT6/2c23YcMiZOZzHdQC9Fz5NT80b8CCjlEA1M3cMBe7Rzlp3gYTswCyRc62nTm3M8pBjmkSAEuTV7zWWKTh9UThiyKG6zpTS/9yE//D98Rj3hP3kueqw4VgssLVNyPRJEE5zMfuQGckYnsFB4dhH7XLG/mwzRjrnCyoDZnUhRuWaMuF6iG8+tLIDkN/jBnkHcJWHC90Xvd5pUKTEn8p+q06ZzvPg3T9BeNZF34aCC1mfelFMOmF3Pd2nbx6F4FQf1KvbzTZP+d2kBRrAVr+eaCRj2JoWYwbKd8C4K4xxM3nPuOKXcHlN9bW6tJ7kSpgmFxfDQ3eQO/DOKkhsbuWrvCxrSuOtLL9CO6TLV9tjTZPYOppgq8fMuoMkCB8x9dHVGIu8BAJbs+ZiVRBc3iJ32tm5LQjHcYTglWIWhA4WYLaklFP1YW3XrvH+JLtJkCXFzK3fi2nods56/ZRyNRg+6pf0oRRN7uAgy3G6MEuBwfTiYviVV8TJXLH/QdOEnDAG1aEuIRRhvd2NHUdBcfc0GJNCI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(55112099003)(4143699003)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261009223027099003)(261102123227099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHhUWFBjYVRLcnlLR0ZZcGFjY0NTbmNDSmNMa2lvZzM2SkFzNzVSaTNzdGZp?=
 =?utf-8?B?bTlwYnRlRWtDc21rS1VXTEdsZDJ1N3Q5L2VZTG85VFllNUNrRTY0Um11blNh?=
 =?utf-8?B?L1hvbHhWNkl1QVJqK2xwQW5qQzB2c2NQd0lxK29VMnJLTGJvb0dicDZTVGF4?=
 =?utf-8?B?Q1pYRHZYUmxaT2xJNkFIY0FkZklneDFUblhWVUYxUWZUWFVBRitTb2traGhI?=
 =?utf-8?B?QkxDdHNjSHYxVmthTXBhTSt4UW1VeGVvaWVGemt5UjNPWUlBSlF6TGtWRzNG?=
 =?utf-8?B?bjdhV05RMFQ3TkxCMVBUclRQQTRwRVFrSTJVcFQ5aE5nOCtTM0Y0aTFscTlI?=
 =?utf-8?B?NStZcVorV1RRQktkZnJpQTE3SDlCaTE4S1E1SDQxQnFNd0o5VCtGQTlibkxX?=
 =?utf-8?B?MGJCK2VNRW1zUkJhTERDV3BYUjQ2QnNGOGh6TzNnd3B3MEtldjVhWWJ1S051?=
 =?utf-8?B?alFLSE9xR2dMalFhTlZpOWFTQkJaV01vNFZtNmNFV1pnRTEzSklsdlRHdGlh?=
 =?utf-8?B?WnZuQUdYbWdpalNLdllwVU9CdHlpU0xCNXBpM3crcHZDcHFGcG5mdFhzNHNh?=
 =?utf-8?B?MEhCSWhOb2Fib295RE44bENWWjFLSll1UlhBRE94WTFvbG5XcktMMERwWEI4?=
 =?utf-8?B?ZUJTRFlGUlR6aCtwN3pYZFF2Z2E3MjFWR3pjak9uU2lPLzl5b0VCQ085TnU3?=
 =?utf-8?B?UFk5Q1BDSmc1YjB1dldLM1FKbitTOUxpNUw3bGQ1aVEzL0o4aVhDNmJ2TmxZ?=
 =?utf-8?B?WitmSW4rNVp0S1JycnhCczZJOXBVejRGQTNsSlVZMUQ3Nk5kQWY2UEJ1Smhm?=
 =?utf-8?B?RzZQSmxxS3llWmNnMjQ2eVZqSTN3TURCeDN6M2QwSlBoekg4REFuWjIyZ3h1?=
 =?utf-8?B?S0h3WElLOWJTS0x2TzYzK2F1ZCtCam1nM3FmZlJKTDZ6bGtlYjVNVEVCM1Ir?=
 =?utf-8?B?ZWV1YjZlY21PM2lvenhtZjNTd1o0R3ZkVkt6R0RQb3hyVlJjcE85ZndPQTJu?=
 =?utf-8?B?cjRKMk9vZ3RDVnpBaGVVckdVL2tFVTEzWEROYS9RUzJWNTNvL1I0ZDBFN05k?=
 =?utf-8?B?akh0Mko1Z05OMjhNOWVyZjJoSEVtSWhQNkkrYVBZVFIvc2RLdVBNT0RwdnZm?=
 =?utf-8?B?QjJTOWJFS1hIVW9lSkVyb0JWVGVYTCt5cnlaNHQ4cUU4NE80ek5TZ3A4YmhE?=
 =?utf-8?B?QU1SSStLYkJHSVBBa1VMSDdmTk0rSnJaTHROMW43MnV1dGRRYnJqWkV2c1RF?=
 =?utf-8?B?U2RVbG1SS3RVVERvNXdIM0pNR1h2cnZ6Nlk4NGRpTjBrTTBmUHB6Z1RvaWEz?=
 =?utf-8?B?REFxSVM2ZXJVVmRZK1F5RFZ3QzQyWEc1REtPZFNySEdVSXk4c0JwTlJqOW9G?=
 =?utf-8?B?dXE5alBqd1hRRytEOUZKdHA4Vm1NUGRlNWRRZGFsRFd2YTcrd0J0WWh1UmJM?=
 =?utf-8?B?am5ZYWVGSy9zQ2JJRlQ2MVJRMW42dzlWcXUxSFBPdVBwd0F3YTNDNldFb1pX?=
 =?utf-8?B?cGxrUFI3V2dRUzBVSDhPVngxYURUWUhTT1ZVUnZFSDFjNHN4b3RYT0hGYWw2?=
 =?utf-8?B?cHVHN3pnRXFESTR2cjlDM0ZvVHRuRHZqRForZXg5Q0lBR0UwaERGTlE2MCs3?=
 =?utf-8?B?MHBaajJrWk9RajN4b2lGSktKS1BjTndaUG92RzdXcmdOVytKUTkyZkx3Q3E4?=
 =?utf-8?B?M3dsWkdlayt5djZqNFM5cHdEYUQxYWNsLzNUbTBIT2RqQjVDUW52MmdzZC9j?=
 =?utf-8?B?TUFDQ0JqYjhhaDkwU0hQbFF6VGlvRnpsdmpnOXVycFpjWDd1bHVPd2trTnJZ?=
 =?utf-8?B?WTdoRFV2SWJ3cXg2dGlxUThleU9IYmRPUFA1V0Y3SGdoVE9zdmppUHVpK2ly?=
 =?utf-8?B?T3FBVy9XY3BuVUZTbjQ1WVdRRTNXeWFRVE16SkZVM3hURExzVlBnRkFEd0xG?=
 =?utf-8?B?Q0hCNDFwTkZ4Q2w1RGxvUElSYnMva2pDeTkvQllFRG5MTTJBSk8yV1dUQ0p6?=
 =?utf-8?B?RlY0b2twZFFiYm12VlR4WlhIS2pYVWV2YmZVZzNNR25MbmIwWDNuN0t6c1Vp?=
 =?utf-8?B?dzJYMFlRZGJJcG1NeStKclFDcTRXTndCQTcvcUQwUE1MU20rdk9PQmlxL3o1?=
 =?utf-8?B?VDhLOEVkbTJISHR5RE1JTnJWc3owZU1UcEV4dWhoMDJUcUwxRmJmN2poSFZ1?=
 =?utf-8?B?UjQyYko4a3QxSFEwZnRIT1RoSTYxNUQ2Uko5VXlBVzhtMUlMNkhISnlOZjlj?=
 =?utf-8?B?YlMxdS9ITFpSMnljOWNMOTdOV21pZ1lPU25JczA4dkwzZklzRXN0SUl5Lzlx?=
 =?utf-8?B?ZWx1WE9oOWNaVnhod0Q3Z0R6SnZSaEx3ZFpyWGNrS1RtT3cyTit0NDZMeEJO?=
 =?utf-8?Q?YVtsCTr15re1WBW0=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 062185f2-aa03-4fa5-8560-08df46fbef6c
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 11:46:37.8729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C3niOnAUQtNQnzqWw3hUBa5r88h9ZhJ0sP5oEqumyVhr4bJEXmESbnMfZpiIZPwileNOEnbhVcY4FiZ0/0ZRTxivfcqumeYyCDcHYayS8Zk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB9489
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Fri, 20 Nov 2026 11:46:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25042



On 11/20/26 11:36 AM, Jan Kiszka wrote:
> On 20.11.26 09:25, Quirin Gylstorff wrote:
>> apt has no stable CLI interface for scripts. Use apt-get and install
>> both packages in one call.
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   scripts/run-cve-checks.sh | 5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/scripts/run-cve-checks.sh b/scripts/run-cve-checks.sh
>> index 12fd74ee..12efcace 100755
>> --- a/scripts/run-cve-checks.sh
>> +++ b/scripts/run-cve-checks.sh
>> @@ -20,9 +20,8 @@ set -e
>>   # Install AWS CLI
>>   if ! which aws >/dev/null 2>&1; then
>>   	echo "Installing awscli..."
>> -	apt update
>> -	apt install -y python3-wheel
>> -	apt install -y awscli
>> +	apt-get update
>> +	DEBIAN_FRONTEND=noninteractive apt-get install -y python3-wheel awscli
>>   fi
>>   
>>   # Retrieve the latest dpkg status files from AWS
> 
> If I recall correctly, this job is in phase-out anyway. No one ported it
> to trixie, and debsbom can generate something similar.

Ok it was a drive by fix as a saw at other points apt install scripts.

Then we should delete that script.

Quirin
> 
> Jan
> 


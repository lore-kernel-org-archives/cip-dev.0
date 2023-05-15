Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1538AC77B75
	for <webhook@archiver.kernel.org>; Mon, 15 May 2023 07:40:21 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.69])
 by mx.groups.io with SMTP id smtpd.web10.83272.1684136415600571101
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 May 2023 00:40:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=elqA7Sdf;
 spf=pass (domain: siemens.com, ip: 40.107.22.69, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CbGdg94mBkiFDZW2X8s0YVYz4yvNUTJq9/H9/E0IwOprXARy5NDXs4++ZoxCzE67RbhOEjHbSPRMAkedb8xUGQmPfSdTwdcxkiciC0GO/nCLlYrHPv7JC21Qyl6HWFjXf5rvJqK4PudyoHbXaS7/1r23BssgKvcIqZkiXxykGHU2iFGJSWMWFeaz2DfL5EMHHlxazemKTY7MtjD1hF+THUJw0GBE0X01Ko3NglV/5d8woHvqYfrg+AgBtMrBuIkVmDRl/YMI70OqTdqkIuOHjAjXsiOoBMYhsb6niLP49uEAFHuCIr33rlKzW0YyF+tl5hTFI1fDVBmi5Q3nLHF9nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wFBhWwTpzTfWIXamfsZk5L0bt4LA/LQas3zdLuWtF1o=;
 b=jpuqsk0Zw3r2vq04tBQ3maLhb75E8UcOo8c7NnQ98Ie502g/Ptdc9s2gpZr1N0Oyn6SrYIQpSV1ZOJSak8be9PclBnwoJkcPWg+SWgwefcSyexjBvG6MbqzAKITuX+dCXASPS4rBPbGTjude5PvFurRDAJarXFNNA1mOc4yZH75+24Do5swGCtUrs66tgCUT15GjWR2MQr1fmYaHsWbeIqtT0mttLmvcqds9nkGQsGyRhUGEPIKEB15WB14WezIrKLdIWqb7ziBJzCDzCzLxB1vrkKQRiODFUOeG19ZiZQwOqbDF7IAbWiN+oMxyKOG/qkqdtXqVSfyPzYaR/Q/FQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wFBhWwTpzTfWIXamfsZk5L0bt4LA/LQas3zdLuWtF1o=;
 b=elqA7SdfCuYyJK8+Hd1uyG9aZecLSvLIa9fu7MITg4UEKydOD4ce0KuM+TADvn8/gLsa9TwO+1sxaw+oZpp6GVSD13azF5e5qGSvxQWOOI+cR59ORYf1ugSgKGuAXVcbRkMBjozHFsvTQbutT94/1eEI5W6qAiWd6S5l7We6vbBzMDPvfKypKYj9SoyLXVm08eGKwLtTDZhA6LY3o303EsW7e3dlD4hgThcwZABxyHKbsjndi1H1X+tJtYaz3Z/lCQG7nTd7T3I5dsg0gcIsN6JfClOES3KYtugSh/I/PLTgfw1SUXHQBb2vgF3aN+71E5y2srgkVPPgsFA4XOGIew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by DB9PR10MB7292.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:460::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.27; Mon, 15 May
 2023 07:40:12 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f6d9:8120:2524:5b06]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f6d9:8120:2524:5b06%4]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 07:40:12 +0000
Message-ID: <079c6f40-f3e2-350c-c8bb-3e8abfab8c49@siemens.com>
Date: Mon, 15 May 2023 09:40:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [cip-dev][isar-cip-core][PATCH v2] swupdate: Add recipe for
 2022.12 for bullseye and buster
Content-Language: en-US, de-DE
To: Jan Kiszka <jan.kiszka@siemens.com>, felix.moessbauer@siemens.com,
 cip-dev@lists.cip-project.org
References: <20230511153938.860495-1-Quirin.Gylstorff@siemens.com>
 <c8aa853e-f207-10c8-405c-8c696ffa6e69@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
In-Reply-To: <c8aa853e-f207-10c8-405c-8c696ffa6e69@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR07CA0018.namprd07.prod.outlook.com
 (2603:10b6:610:20::31) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|DB9PR10MB7292:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c292925-1ea2-4376-19d1-08db55179db2
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	7jfwoAzpdpO4XmvuUgKC03DLCoXCxoEgyPqrHIvZv398qLAoNxV+o1ih1HEyaceF2wuZYIKn++G1/w+/YIWEsv7ufAF7qOnloy94DX9lOynhzBIZXyL0CCm7cyiXfv4tVenrytV7z1CqIP2HTfJUc/vk+dFJsFdtKQdjpWj9dcJAzpkpPrnsamHhbJxbI0TrWk0UYerAJueB/xqJ33iiH6nIkmnbCSIXPEy41pQ2XeFRr+/C3VbLvh2vo6tL/lrez0Gu9xM7OGEy4Yu0qasPbiSxszpETpKmLAGav4RPK5eSarsriAadlcqCRu0noMFFqF+DEbXK48BYSRNpFrpFFk8M5moCsqw6rmFhiXIQmMBtDgU2MiuAj8Y0dWTjvrn7M5qRExOeTcR7ONzwccWxL6+0H0ftvfzrFdJLIeyy8xF35sAIaxqAjWcAbbfhvdsjpR4QSzl0WtHbHFwVXpIuGs+h+f2N8YH2hVPj1fJ/qK/+ffCia0m5HdzYbhwwxZ0IldQuS59h16J7alhPJ3JVi39sHDULdHLZDkJeoPtZBqbWYnBCqtxGNRzUx4i9pgkGeAmr6QiBnazwqBBCodMUWYx1M221zDVyUXt9yVokOyLWXyan3mExZQTZRN5bFl85eKJYfS4pXSLgq8fmFS2kUw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(39860400002)(366004)(376002)(451199021)(31686004)(66899021)(86362001)(66946007)(66476007)(478600001)(66556008)(31696002)(316002)(36756003)(6486002)(83380400001)(26005)(53546011)(2616005)(6512007)(6506007)(186003)(8936002)(8676002)(5660300002)(41300700001)(6666004)(2906002)(82960400001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YnFZcktSYTFnR2JlWkFYcHp1WHpSQmZQWEVpMWtoMXI1VkJDVzZlY09MQmRB?=
 =?utf-8?B?Q2VuRjVnUlJzS0NSR0J3QloxSjNRaUxFWlk2TXFRdldwdzR0cEhhS1Vqcmly?=
 =?utf-8?B?OFdhVTNNbXFkNE12UXcwaWc4R2tJZ0ZueEtReERXWEZ1UFVNV25ST1lWSzhE?=
 =?utf-8?B?R0tBT3BoSW1QWmZ4QURVbkdIb0NMMEtPRDFCdDc3U25xSzRLQzNoZ3AwaXBa?=
 =?utf-8?B?OHJCZ1dQc2ZtNjg4TVdIUmxzRFZHU2hsNFE2bTljbWxVQThsMFJUcGVmdEtq?=
 =?utf-8?B?TVJDYTgrejV5TG5TRk8xODVRUmhiZUxZY3RWSFlIQmJPbjVzZU9DcW9McUxZ?=
 =?utf-8?B?RjJ3RUQ4YkJYUWtWOE5YQ1FuU0JUd1BZN2h2bm93eEE2VVFBM2Q5eU9MUU5T?=
 =?utf-8?B?cEhkOXl2cU85V3YzSk5RUElEMGtJYzFDYzdlQXU5NXNkRlRrMDZHckdIUTJQ?=
 =?utf-8?B?Z25WbGJYenY0a3VWYkxaSE1SbkdlRHQwdm16QlN1N1p0NW5HUkQyQ2g4SFA3?=
 =?utf-8?B?eXF1L0VHR1dzQ1g0YTBlMFM0czVwNnVtZEZKUjNPR0Y4Q1dKeFR0eTgvZklw?=
 =?utf-8?B?enNuR1dPZUFySm5uTit0N1AzSTROQnMxcUpRVWJtOEZoNWJiMmFxVU1zbGMr?=
 =?utf-8?B?VjIxeTBMUHNndUViUnh5THJPcGRtSGY5Z3FLaGVtZU05NjJVZkdFYlBOSEhj?=
 =?utf-8?B?ZGdCampXRjBhK3dSUFJtVVVyMy8yWlFETFoydzVpckdIVlVSZDlIRmxGVzVv?=
 =?utf-8?B?Y0FkVWZOYU51Yk04QkExU0Y4Q21vUHgyZXVRcW8xd01LRDFlVDlPaUR0MzNn?=
 =?utf-8?B?TDYxWlpQQ0EwS0pCSXlONFp2UTVINzZacnJ4eVFLRjBpbTlzRzNFc3dxU0ZC?=
 =?utf-8?B?a1NTWnYvYmJndHhZa3RTN3VKRko5YU9IYi9qY1U1SG5UUWZXVUpHZ2doZW1m?=
 =?utf-8?B?VUZLY0hFb0Nreml0alhJL2svZERSM3FOUnhUU1BBaEpKQnp0NldueXhBOG9l?=
 =?utf-8?B?NFI5QjM4bTRuQlY2SUt0MXN4SjQvNGpBLzc5UlBnM1JSUXVKZnNsSk9QNEFh?=
 =?utf-8?B?SnZTSEdjbmxKblkxQk1Ub05ISHBPeHRSU1pHSWdSb3JuZUR0aVF2b2Z5cEZa?=
 =?utf-8?B?SkMveW1UOFRkRFpZZWUwcHRJRTdvdTlGblB4Z1gvRWQvdUZLYVZYREw0c1J5?=
 =?utf-8?B?M0lMMGpVV2IrNWM2T3pBYlZ6RjhFNGdjelpmNXcwcDgzVURyZDUrVGFvaHRo?=
 =?utf-8?B?SXRRK1lKUW9ZRi9oeFQ3MkFTQ1JXSzRJc1ZyMXNHUDZPT0tjRi96UCt1N05C?=
 =?utf-8?B?THdHNkZNQnpIcE1Nc2dTbVZnMU1GQkhBWVR0cmFLaVV2YUc5alVvMmJJYmph?=
 =?utf-8?B?dEtDVlI2MWh2Z2F4Y2xma1Vsb200LyttVVEyRDcrelRGRmM1elo1TlhoUmUy?=
 =?utf-8?B?TFBoU0R5cGcxSnRpY09ndXV6N3kwTTFsYno5MU1nSUd4WVdYN3lRc2x6b3lG?=
 =?utf-8?B?SEY0SU1PK2FrZUUvTk1EcXMrc3JyUy9HNEJjc1FiZUdwYlU0VTZUejAyaTBh?=
 =?utf-8?B?ejVWQ21sTkRKa3plSnppSkozNVo2Slp4QmFKeXFsZS9zT1g2YjhmQWtVMjdZ?=
 =?utf-8?B?ci8rUmtuaFkyZ21ub2VjZXMwbkhoVlcyc3RjV1ExUE8rWXU5VTM3aU1EaTkw?=
 =?utf-8?B?b2l3RXZhRk8zM0U1WlJhVUVrbnZyZzBPS3dmRjd6aTJxTWx1V2JyTkQ2MkMw?=
 =?utf-8?B?d3FUOFJ0ZmhZTGdVY1N4UDFtREd3NDBWb2pYNXZNSWJSSmVuZjJwNy9aTVlv?=
 =?utf-8?B?UjRFK0dlM01hMlJ5eDV6V3pQVlZweGkvTWR0RS9jYU9tL1dIalBkbHhVemZT?=
 =?utf-8?B?bFhqdTB5T2xKVUM0L05lUjh1L1VkdEZjWlF2eHVRbVl0cDZXU3FxMFFwK3I5?=
 =?utf-8?B?U2xKQkJkSTI3Y3I0TXRSNTE5dmtaMVBVNm1VMFUvQlVRYU5RSjN2dHh5bDJY?=
 =?utf-8?B?REFvVkI5ZE91b0JpR0xPbW8yZDNpSGpsU3ZCa0U5bm42YTNaa2VnaW4rMFZ6?=
 =?utf-8?B?M00yMldYckp1SzA4d3hkeUZaZG02VDBLNk42YnlTUVBXYlJrWDFFQkhsY29R?=
 =?utf-8?B?VjJSbEFaeGtQUkE2cUk2YWVUaXdYQ05IclBCSlNKMnRuZG9sTVloTUQwK3RS?=
 =?utf-8?B?VVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c292925-1ea2-4376-19d1-08db55179db2
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 07:40:12.3677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vn3VB1RTy88edAzFp76PgHiGkyHxBFPaSXbK4hpvR/tk4/Oeii8pqjqlIunO4KBAYleW5pT5wxuxsi529Z6JjnAWy4K4tp2gCgZM5w+4FkE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7292
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 May 2023 07:40:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11444



On 5/14/23 12:54, Jan Kiszka wrote:
> On 11.05.23 17:39, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> This allows modified swupdate builds in cip-core. It also
>> adds the option to use suricatta-lua instead of the default
>> suricatta-hawkbit to communicate with a webserver.
>>
>> `suricatta-lua` is currently in use for internal projects. Some of these
>> projects are planned to be released as open source.
>>
>> To enable suricatta-lua add the following line to the local.conf:
>> ```
>> OVERRIDE .= " :suricatta-lua"
>> ```
> 
> I think, this is a bit overkill, given that only one switch needs to be
> flipped in an own swupdate_%.bbappend file.

Ok i will remove that option in a v3 but will add a comment into the 
swupdate recipe how to enable it.

> 
>> or add the following line to the swupdate recipe.
>> ```
>> DEB_BUILD_PROFILES += "pkg.swupdate.suricattalua"
>> ```
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>> Changes v2:
>>   - Add usage of `suricatta-lua` the to commit message
>>   - Add missing space to DEB_BUILD_PROFILES
>>
>>   conf/distro/cip-core-bookworm.conf            |  1 +
>>   conf/distro/cip-core-bullseye.conf            |  4 +++
>>   conf/distro/cip-core-buster.conf              |  1 +
>>   ...eferences.swupdate-bullseye-backports.conf |  3 ++
>>   kas/opt/swupdate.yml                          |  1 +
>>   ...d-rules-Add-option-for-suricatta_lua.patch | 30 ++++++++++++++++
>>   .../swupdate/swupdate_2022.12+dfsg-4-gbp.bb   | 35 +++++++++++++++++++
>>   7 files changed, 75 insertions(+)
>>   create mode 100644 conf/distro/preferences.swupdate-bullseye-backports.conf
>>   create mode 100644 recipes-core/swupdate/files/0001-d-rules-Add-option-for-suricatta_lua.patch
>>   create mode 100644 recipes-core/swupdate/swupdate_2022.12+dfsg-4-gbp.bb
>>
>> diff --git a/conf/distro/cip-core-bookworm.conf b/conf/distro/cip-core-bookworm.conf
>> index de2e435..f05d3d3 100644
>> --- a/conf/distro/cip-core-bookworm.conf
>> +++ b/conf/distro/cip-core-bookworm.conf
>> @@ -12,5 +12,6 @@
>>   require conf/distro/debian-bookworm.conf
>>   require cip-core-common.inc
>>   
>> +PREFERRED_VERSION_swupdate ?= "2022.12%"
>>   PREFERRED_VERSION_linux-cip ?= "5.10.%"
>>   PREFERRED_VERSION_linux-cip-rt ?= "5.10.%"
>> diff --git a/conf/distro/cip-core-bullseye.conf b/conf/distro/cip-core-bullseye.conf
>> index 3a0550c..9c83054 100644
>> --- a/conf/distro/cip-core-bullseye.conf
>> +++ b/conf/distro/cip-core-bullseye.conf
>> @@ -12,5 +12,9 @@
>>   require conf/distro/debian-bullseye.conf
>>   require cip-core-common.inc
>>   
>> +DISTRO_APT_SOURCES:append:swupdate = " conf/distro/debian-bullseye-backports.list"
>> +DISTRO_APT_PREFERENCES:append:swupdate = " conf/distro/preferences.swupdate-bullseye-backports.conf"
>> +
>> +PREFERRED_VERSION_swupdate ?= "2022.12%"
>>   PREFERRED_VERSION_linux-cip ?= "5.10.%"
>>   PREFERRED_VERSION_linux-cip-rt ?= "5.10.%"
>> diff --git a/conf/distro/cip-core-buster.conf b/conf/distro/cip-core-buster.conf
>> index c5cb39c..4e9a4a7 100644
>> --- a/conf/distro/cip-core-buster.conf
>> +++ b/conf/distro/cip-core-buster.conf
>> @@ -12,5 +12,6 @@
>>   require conf/distro/debian-buster.conf
>>   require cip-core-common.inc
>>   
>> +PREFERRED_VERSION_swupdate ?= "2021.11%"
> 
> Err, the subject says that buster is also using 2022.12. Confused.
> 
>>   PREFERRED_VERSION_linux-cip ?= "4.19.%"
>>   PREFERRED_VERSION_linux-cip-rt ?= "4.19.%"
>> diff --git a/conf/distro/preferences.swupdate-bullseye-backports.conf b/conf/distro/preferences.swupdate-bullseye-backports.conf
>> new file mode 100644
>> index 0000000..a2377bb
>> --- /dev/null
>> +++ b/conf/distro/preferences.swupdate-bullseye-backports.conf
>> @@ -0,0 +1,3 @@
>> +Package: dh-nodejs
>> +Pin: release n=bullseye-backports
>> +Pin-Priority: 801
>> diff --git a/kas/opt/swupdate.yml b/kas/opt/swupdate.yml
>> index 29b7dd6..1528b09 100644
>> --- a/kas/opt/swupdate.yml
>> +++ b/kas/opt/swupdate.yml
>> @@ -17,6 +17,7 @@ header:
>>   local_conf_header:
>>     image-option-swupdate: |
>>       CIP_IMAGE_OPTIONS:append = " swupdate.inc"
>> +    OVERRIDES .= ":swupdate"
>>   
>>     wic-swu: |
>>       IMAGE_TYPEDEP:wic += "squashfs"
>> diff --git a/recipes-core/swupdate/files/0001-d-rules-Add-option-for-suricatta_lua.patch b/recipes-core/swupdate/files/0001-d-rules-Add-option-for-suricatta_lua.patch
>> new file mode 100644
>> index 0000000..0be5a71
>> --- /dev/null
>> +++ b/recipes-core/swupdate/files/0001-d-rules-Add-option-for-suricatta_lua.patch
>> @@ -0,0 +1,30 @@
>> +From 00fc691802e671594cea1d0a5e880d255e04b7f0 Mon Sep 17 00:00:00 2001
>> +From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +Date: Wed, 3 May 2023 16:02:37 +0200
>> +Subject: [PATCH] d/rules: Add option for suricatta_lua
>> +
>> +This allows to use lua plugins as suricatta backends. It is optional
>> +as it overrides the default HAWKBIT backend.
>> +
>> +Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +---
>> + debian/rules | 3 +++
>> + 1 file changed, 3 insertions(+)
>> +
>> +diff --git a/debian/rules b/debian/rules
>> +index 57da4ca7..91106fbd 100755
>> +--- a/debian/rules
>> ++++ b/debian/rules
>> +@@ -56,6 +56,9 @@ endif
>> + ifneq (,$(filter pkg.swupdate.p11,$(DEB_BUILD_PROFILES)))
>> + 	echo CONFIG_PKCS11=y >> configs/debian_defconfig
>> + endif
>> ++ifneq (,$(filter pkg.swupdate.suricattalua,$(DEB_BUILD_PROFILES)))
>> ++	echo CONFIG_SURICATTA_LUA=y >> configs/debian_defconfig
>> ++endif
>> + ifneq (,$(LUA_VERSION))
>> + 	echo CONFIG_LUAPKG=\"lua$(LUA_VERSION)\" >> configs/debian_defconfig
>> + 	echo CONFIG_LUASCRIPTHANDLER=y           >> configs/debian_defconfig
>> +--
>> +2.39.2
>> +
>> diff --git a/recipes-core/swupdate/swupdate_2022.12+dfsg-4-gbp.bb b/recipes-core/swupdate/swupdate_2022.12+dfsg-4-gbp.bb
>> new file mode 100644
>> index 0000000..f5478a3
>> --- /dev/null
>> +++ b/recipes-core/swupdate/swupdate_2022.12+dfsg-4-gbp.bb
>> @@ -0,0 +1,35 @@
>> +#
>> +# CIP Core, generic profile
>> +#
>> +# Copyright (c) Siemens AG, 2023
>> +#
>> +# Authors:
>> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +
>> +inherit dpkg-gbp
>> +
>> +require swupdate.inc
>> +
>> +DEPENDS += "libebgenv-dev"
>> +
>> +DEB_BUILD_PROFILES += "nodoc"
>> +DEB_BUILD_OPTIONS += "nodoc"
>> +
>> +SRC_URI = "git://salsa.debian.org/debian/swupdate.git;protocol=https;branch=debian/master"
>> +SRCREV ="aa9edf070567fa5b3e942c270633a8feef49dad8"
>> +SRC_URI += "file://0001-d-rules-Add-option-for-suricatta_lua.patch"
>> +
>> +# deactivate signing and hardware compability for simple a/b rootfs update
>> +DEB_BUILD_PROFILES += "pkg.swupdate.nosigning"
>> +DEB_BUILD_PROFILES += "pkg.swupdate.nohwcompat"
>> +DEB_BUILD_PROFILES:append:suricatta-lua = " pkg.swupdate.suricattalua"
>> +
>> +# Disable cross for arm and arm64 on bullseye
>> +ISAR_CROSS_COMPILE:bullseye = "0"
> 
> Why that?

If I try to cross compile it we a have a unsatisfied dependency to 
dh-nodejs. I am look into it on ISAR if this is a reoccuring problem 
with cross-compile.

> 
>> +
>> +# add cross build and deactivate testing for arm based builds
> 
> Does this comment apply to both lines above?
> 
No it is only for the next comment.

>> +DEB_BUILD_PROFILES += "cross nocheck"
>> +DEB_BUILD_PROFILES:append:bullseye = " pkg.swupdate.bpo"
> 
> Or what does the last line?
This will use the backports option to build SWUpdate for Debian bullseye.

Quirin


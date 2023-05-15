Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6869C7EE22
	for <webhook@archiver.kernel.org>; Mon, 15 May 2023 07:08:50 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.58])
 by mx.groups.io with SMTP id smtpd.web10.82932.1684134524745846118
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 May 2023 00:08:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=tmL0RT/V;
 spf=pass (domain: siemens.com, ip: 40.107.8.58, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PWYU61gMawqeRTJIc99Uc79tATTlPnDkN4u+84lolu0muAyS81uxYDGSr1RlRfTXLENmz0YNp7Z01XRmXGWqe4QDM+IGz62BS9g7+2tPNVFbCxKPrsSLWUrmNwB9hpF5xIr+aowJwV1JGpBNtdhJhTs2jWaNB4YbWSoCobhf/no7cz5kp/0S8TfpXy1EN0qetIQ+6M/K0yqB6H3RVKp1wxx4ii/KR/j94e2MHZmyOkUGORi3Yzy7d6+5KDpjT7psnIS0iKSgc0nG70h1JxS07alIUWwRuinHLMKYMRfgfaYUC+0VCp54AVOGD011GNHevo8THK3Zdf6UnpJRf+a1wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p4kSnjbRMNkkDvGzRiRbyMsmKoxzVZytHF0dIAXZ4aM=;
 b=P1NBD4OROVfBlpGklrTt2AeRqCVO8Sq/Jd2YLmYaJUVLwCltF3NBbFVj6L4FtDzZnbGgzY2c9jxZGkCByUqgDf2oC/UOOphID/2LNcp7BEVF4mJ6yY6MAWtLFheL0iqVIESiYqsiCJmJvGRrvcRoykTjjlyHScovFF716inhm50xG+5nO+NbL5rwzlPcHQjkXlMfXVt1GnJiwp9k8J+EvIKNWEsTdVOPfhIHX3u+KEsq5NU+Dmndhbefs91PnPtboEhnLR/BpxxCtubijfBuO9XDhHV5UFR7NLFl7qnkznl4EW7q1y9yT4Rhjf7yN2dFCUVHrxqAP1zmjvflDLIYvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p4kSnjbRMNkkDvGzRiRbyMsmKoxzVZytHF0dIAXZ4aM=;
 b=tmL0RT/Vx+cZHPk+rO/E11wd7hsQx/6UkyZZtCNXLsgJQXdEGJx3zFqAjlGsyorc7Ag+TuFKDml5hQG+yA/sIQCn+ywt69DeYQKN/1R37f96K7OGphGKpZRlZr8PSE4fcMSvCKGX9I6NWS2JuJ4VSAb7NIOxlJqV2QrZhQvFsQFl1rBhCMp0EW5bSTAx72RVg1N/SFt5OtiMeBQ527mWPMC9SqdVTGojAl4Ur5uLNU20oxFbpVyGtikjtbL1hFVjryu5vhDi8UdjncREJDPtCrpWMpKJn75hZhGUdkq/T6eXavaX3emD/xxOjG+eEFGfEgGydBOA20vzlOz8FZ5ZOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by DU0PR10MB6033.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3c8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 07:08:39 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f6d9:8120:2524:5b06]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f6d9:8120:2524:5b06%4]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 07:08:39 +0000
Message-ID: <adde56ad-3afd-fd1b-b230-b619ba15401b@siemens.com>
Date: Mon, 15 May 2023 09:08:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [cip-dev][isar-cip-core][PATCH v2] swupdate: Add recipe for
 2022.12 for bullseye and buster
Content-Language: en-US, de-DE
To: "MOESSBAUER, Felix (T CED INW-CN)" <felix.moessbauer@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 "Kiszka, Jan (T CED)" <jan.kiszka@siemens.com>
References: <20230511153938.860495-1-Quirin.Gylstorff@siemens.com>
 <6d1ebc76c90a46268926d0eece0e43f176a1060f.camel@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
In-Reply-To: <6d1ebc76c90a46268926d0eece0e43f176a1060f.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0112.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::15) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|DU0PR10MB6033:EE_
X-MS-Office365-Filtering-Correlation-Id: b3bdcf25-f742-4a56-a3c3-08db55133557
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	b//qgOpwYrB0BDzbslTfRe5TfQqJJPuJwkFe8WzdxfKGZFC7S4dMv+qOFBA6/f5OrQ+VqqSr5PBtfpZZbgUSG3CIbqfu27tbikBZV8yrbrBiiYGqCLL0XMh5Q+IMhUUw8DREac3jXJaoOv3R9tk9YvRxskXRAXrOVpFx2DmiXQjQw+KIG7ndPPFNW9vt1igxAPvaiNm4VnYgWhwRyLXD42TeOTup6hNismGQiPGnRhGu8yRq51ye8dSvWwl0sE84lGyzQuY1lony4ab9uB4NB9Rg3wNsPlPhl7/kz/a6ErwW85/ru54NcN0s+4bJMrqWAkvMMwDkB66VpiL/VzM+oDnEEBLaeMkhqMPkizHhaBVYcLF3VoHGqEtHQ6nI7XVNgsgUsZ8gBbumG3/cAWPDbAzOl7oalOHICIPmQ1aOjSBWNtstnXyoeYdrfAfnXanrMQZkJI+cyQsVMyAlAcFITu7awcuCrQNf7aPy+AWgBGVDiW3tAM0G0TMeF8lVuvBoF6O+osxPq1WNlgbYywlbJ2QRKZ2lvcrpOkxgolhEhKz9nXHNHkMbD7WqqYHYJLRWcmo0aps4De+8y69+J0x7+1tTv2kbGBmhjYNOawyKsygMEr/0ohwpJ7jAbQNFbl37
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(396003)(366004)(136003)(451199021)(6636002)(6666004)(8936002)(8676002)(66476007)(82960400001)(66899021)(66556008)(316002)(41300700001)(66946007)(478600001)(110136005)(38100700002)(36756003)(186003)(2616005)(53546011)(6512007)(6506007)(26005)(2906002)(83380400001)(31686004)(86362001)(31696002)(966005)(5660300002)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?T3FZTjhab0xCbFJ3L05BV05Bdy9ZdlZ4TVdYNEozbURiTWUrVGFkWFdKbDF2?=
 =?utf-8?B?SUFwMTFoRjVROFdIMU5Nbkt0UGdLaHdxckg0Z0FLczBzbGZqb1VnR2tTY1Jo?=
 =?utf-8?B?czVtWjlPbFpDWWkrTFZkR0VnVm5sRDQ2UUtUVEdFdDFTSUFBZzhPR3QySklO?=
 =?utf-8?B?VTNHRmovQmV4NUE2RVUyay9sSTlFZU9zZU1hcHFsdXplU1docE5USWZXc0hX?=
 =?utf-8?B?UE1PalVEWWhycUt5bWJuWWJTV0Q2WnJzNVZoNExjWWRDSjlLUzJPV295UDZ2?=
 =?utf-8?B?S1hHMy9ISXhJR0xjYTI1TEZUMVprTzJYTUxMN2FtQzVoeCtiQjMwOE5qKzZi?=
 =?utf-8?B?M1BiWHJDU0c0R2ZidVNqQVAyMFVRWXFXQW91eGlPbGZGL0dtUGZxK0dBOHBu?=
 =?utf-8?B?bzI1ZjRnYTRJUVVDNzVGUHZ4ckFwOTFERzRSNWdkRFkrekE1Q3ViUmJNWFpK?=
 =?utf-8?B?SUhmbHB4VmhCNDRzUkYxaGF4MFdDRThlZ2FvN1dIdm1LZTlOckVtVWFURFBN?=
 =?utf-8?B?ZlZRUEJzYmhIVTRncHVkNVFZV3FBSHp6SHlkWUFnYndVVDQ2TkthU3RSZTRD?=
 =?utf-8?B?N0E1ZE1MN08xZkNGRklFYks2dkRDUXJTaTFwa29VLzVWYkJFY3huU2RoUzBr?=
 =?utf-8?B?eGNJcUF2ZlAxTWphOWRVOGtCSnU3R3M1dzlJVVA4ZkpwdnMwNVpVUit5Nk1L?=
 =?utf-8?B?VlhKM3JLRFdlUGtCRkl4SkdiZkEwRjMrTU9hS1Z6R2NIcndoeXU2cWxQZzQ4?=
 =?utf-8?B?N2R4L01mcWZmUlRMM1gwY1VVR0JXK3BzZ0t3bWtsVDQxMW1mQjRUVE9OWWxn?=
 =?utf-8?B?angxR1Fla3JwMTZuQ01OV01aaEh1QlZ4eG56a2FCTjlWTDVlZnFMV01ZblF3?=
 =?utf-8?B?NkNHUjhDK3VGWnV6TG9hR2UrVm1TZlB3RW9CUTh1NmNuRS8yOVl4L2owL0NG?=
 =?utf-8?B?Vm1EUEpERnVQUUxIN2Q3ejB4SG5HSHI0bzdpRlplUDZ2eE5yejlxUnNXTlpr?=
 =?utf-8?B?WmxZdnNjYndqMk9VanRXbk5TVXRUS254MnVweG5QdklEYlZCNUJZaE5Vajdt?=
 =?utf-8?B?NzZ5RWFlZ2t4VDYrYkZpK0UrV1pTbUdOalhrZHNPRXhYT0ZZQ3o4WXJrZUFK?=
 =?utf-8?B?SjF3aFhSTjJXbjZpMitaekQxK2tOZmloWnVLaHAvSGtRQloxaVVsL3JtMHk2?=
 =?utf-8?B?UllFU3NlandpT2ZQdC8rS3drZnZ5VCt6RmQ5K0JLSWQ4M0VXR0xlVkFXWGdE?=
 =?utf-8?B?N3ZnZGU1K084R1BlL1p3RFA4VWs2TVlydHIvdEVpeDllb1hFRzY2S29RTG5k?=
 =?utf-8?B?RWNueVV2UCt5ZVlQNkxMbEhHalgrYkt4VXVCWi9SV3dQT0VBOE5PUU9WNnhO?=
 =?utf-8?B?VEJLaHFpOXdRWkx5YzRUZHFYOW5UWUVreWNNL2ZhckhZa2VNTEh1cjB6cFJ0?=
 =?utf-8?B?U2FxN1l3SngyWGM2TnNqY0oxMDl0bElLT1lKdXE4MWZmOUdTUDJsRHFoTEZw?=
 =?utf-8?B?aTNpKzNXbjRsY1A5b1F4T0tyMnhqQmhFaG1yYTArd2FGbjBTM1hEMUxmRjR2?=
 =?utf-8?B?SG9RVTF0Qnc4V2NRY0RXV21sVll0MHowZXZsZnZTVVljMitkTGNRWllDcDBw?=
 =?utf-8?B?UkNTNG8xODFJeEhMK2F5QmlZd3hzR25nQ1FWMWF1a1c2dmZUVEx1K1UxeU0r?=
 =?utf-8?B?c0F4N1RXcUFzZVRWTWl3UUUwY2VkYnppbnBwdHVlUUxZaVk3RmlQaDNEUlhq?=
 =?utf-8?B?ejdmTmw0cFgxN1c4dkJxVnZoSjY1SkdCV0tzUzNZMkk0REtBS1FJcE1GYkVm?=
 =?utf-8?B?NEl4RWVxQVU0aDFvd2I2SzBZb29uVkxyOEp4b0R3VGtSRko2WlE1bFYyd0RV?=
 =?utf-8?B?K055WlBESENWU0tjZnh6ZG9WNlZtZWtlMlRaSHBBcU5ZTThSK28ra25QYUNP?=
 =?utf-8?B?bTFneWwyRVJYbjcwdkgwdXNiZ3BlZXE0ZkJRTHRFRVFwUG0wRWdHelAwS01E?=
 =?utf-8?B?amZBeUhzdXowb2F1NzQvRVNHYTk2ZEQ2SWxoNHBHQ25HckFHbWU1V085aHlr?=
 =?utf-8?B?b1cvYldBcXV0WDJST1dDTWVnd0p0d0VVSTlnNkQzSFJvaVcxTkVvMWhpMmF0?=
 =?utf-8?B?WTh2N3J0a280eDRONzYxM0UyOWRJRHJIc0dzeXUrY3FVRWhLSHFDME5jelVz?=
 =?utf-8?B?bUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3bdcf25-f742-4a56-a3c3-08db55133557
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 07:08:39.3612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ojBwRIBtLJlGQYfkpiA3ilNzyuhbCKsmPcWYrIql+Bao3zF1cuq5S/Crah1afZsH2qz3cLZ2nbhkjKcm1Zk5FEWmVNRJKc4hs9QME2mSw5o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6033
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 May 2023 07:08:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11442



On 5/15/23 04:29, MOESSBAUER, Felix (T CED INW-CN) wrote:
> On Thu, 2023-05-11 at 17:39 +0200, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> This allows modified swupdate builds in cip-core. It also
>> adds the option to use suricatta-lua instead of the default
>> suricatta-hawkbit to communicate with a webserver.
>>
>> `suricatta-lua` is currently in use for internal projects. Some of
>> these
>> projects are planned to be released as open source.
>>
>> To enable suricatta-lua add the following line to the local.conf:
>> ```
>> OVERRIDE .= " :suricatta-lua"
>> ```
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
>>   .../swupdate/swupdate_2022.12+dfsg-4-gbp.bb   | 35
>> +++++++++++++++++++
>>   7 files changed, 75 insertions(+)
>>   create mode 100644 conf/distro/preferences.swupdate-bullseye-
>> backports.conf
>>   create mode 100644 recipes-core/swupdate/files/0001-d-rules-Add-
>> option-for-suricatta_lua.patch
>>   create mode 100644 recipes-core/swupdate/swupdate_2022.12+dfsg-4-
>> gbp.bb
>>
>> diff --git a/conf/distro/cip-core-bookworm.conf b/conf/distro/cip-
>> core-bookworm.conf
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
>> diff --git a/conf/distro/cip-core-bullseye.conf b/conf/distro/cip-
>> core-bullseye.conf
>> index 3a0550c..9c83054 100644
>> --- a/conf/distro/cip-core-bullseye.conf
>> +++ b/conf/distro/cip-core-bullseye.conf
>> @@ -12,5 +12,9 @@
>>   require conf/distro/debian-bullseye.conf
>>   require cip-core-common.inc
>>
>> +DISTRO_APT_SOURCES:append:swupdate = " conf/distro/debian-bullseye-
>> backports.list"
>> +DISTRO_APT_PREFERENCES:append:swupdate = "
>> conf/distro/preferences.swupdate-bullseye-backports.conf"
>> +
>> +PREFERRED_VERSION_swupdate ?= "2022.12%"
>>   PREFERRED_VERSION_linux-cip ?= "5.10.%"
>>   PREFERRED_VERSION_linux-cip-rt ?= "5.10.%"
>> diff --git a/conf/distro/cip-core-buster.conf b/conf/distro/cip-core-
>> buster.conf
>> index c5cb39c..4e9a4a7 100644
>> --- a/conf/distro/cip-core-buster.conf
>> +++ b/conf/distro/cip-core-buster.conf
>> @@ -12,5 +12,6 @@
>>   require conf/distro/debian-buster.conf
>>   require cip-core-common.inc
>>
>> +PREFERRED_VERSION_swupdate ?= "2021.11%"
>>   PREFERRED_VERSION_linux-cip ?= "4.19.%"
>>   PREFERRED_VERSION_linux-cip-rt ?= "4.19.%"
>> diff --git a/conf/distro/preferences.swupdate-bullseye-backports.conf
>> b/conf/distro/preferences.swupdate-bullseye-backports.conf
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
>> diff --git a/recipes-core/swupdate/files/0001-d-rules-Add-option-for-
>> suricatta_lua.patch b/recipes-core/swupdate/files/0001-d-rules-Add-
>> option-for-suricatta_lua.patch
>> new file mode 100644
>> index 0000000..0be5a71
>> --- /dev/null
>> +++ b/recipes-core/swupdate/files/0001-d-rules-Add-option-for-
>> suricatta_lua.patch
>> @@ -0,0 +1,30 @@
>> +From 00fc691802e671594cea1d0a5e880d255e04b7f0 Mon Sep 17 00:00:00
>> 2001
>> +From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +Date: Wed, 3 May 2023 16:02:37 +0200
>> +Subject: [PATCH] d/rules: Add option for suricatta_lua
>> +
>> +This allows to use lua plugins as suricatta backends. It is optional
>> +as it overrides the default HAWKBIT backend.
> 
> Can't we fix that in upstream debian? The idea would be to have a
> multi-package build with different configurations? Then, we would not
> need the patching of the debian/rules file in cip-core. All these build
> profiles are problematic, as they generate different configurations of
> the same package, also with the same name.
> 
> Ideally, we could even fix that in swupdate itself by making these
> options runtime configurable.
> 
> Felix

Currently there is no upstream use case for suricatta-lua. Also a 
runtime option should be added with the next SWUpdate release[1].

[1]: https://groups.google.com/g/swupdate/c/qLHm6iIMdMQ

Quirin

> 
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
>> +       echo CONFIG_PKCS11=y >> configs/debian_defconfig
>> + endif
>> ++ifneq (,$(filter pkg.swupdate.suricattalua,$(DEB_BUILD_PROFILES)))
>> ++      echo CONFIG_SURICATTA_LUA=y >> configs/debian_defconfig
>> ++endif
>> + ifneq (,$(LUA_VERSION))
>> +       echo CONFIG_LUAPKG=\"lua$(LUA_VERSION)\" >>
>> configs/debian_defconfig
>> +       echo CONFIG_LUASCRIPTHANDLER=y           >>
>> configs/debian_defconfig
>> +--
>> +2.39.2
>> +
>> diff --git a/recipes-core/swupdate/swupdate_2022.12+dfsg-4-gbp.bb
>> b/recipes-core/swupdate/swupdate_2022.12+dfsg-4-gbp.bb
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
>> +SRC_URI =
>> "git://salsa.debian.org/debian/swupdate.git;protocol=https;branch=deb
>> ian/master"
>> +SRCREV ="aa9edf070567fa5b3e942c270633a8feef49dad8"
>> +SRC_URI += "file://0001-d-rules-Add-option-for-suricatta_lua.patch"
>> +
>> +# deactivate signing and hardware compability for simple a/b rootfs
>> update
>> +DEB_BUILD_PROFILES += "pkg.swupdate.nosigning"
>> +DEB_BUILD_PROFILES += "pkg.swupdate.nohwcompat"
>> +DEB_BUILD_PROFILES:append:suricatta-lua = "
>> pkg.swupdate.suricattalua"
>> +
>> +# Disable cross for arm and arm64 on bullseye
>> +ISAR_CROSS_COMPILE:bullseye = "0"
>> +
>> +# add cross build and deactivate testing for arm based builds
>> +DEB_BUILD_PROFILES += "cross nocheck"
>> +DEB_BUILD_PROFILES:append:bullseye = " pkg.swupdate.bpo"
>> +
> 


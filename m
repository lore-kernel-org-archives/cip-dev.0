Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA19EB64D7
	for <webhook@archiver.kernel.org>; Fri, 16 Jun 2023 17:14:59 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.85])
 by mx.groups.io with SMTP id smtpd.web10.4376.1686935694222721703
 for <cip-dev@lists.cip-project.org>;
 Fri, 16 Jun 2023 10:14:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=BAawokB9;
 spf=pass (domain: siemens.com, ip: 40.107.104.85, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=akU69P39aCdJYO5Ay0SJh2akAWhAGbEm0SqGMNlAdAfeoTvYh5IGXnybKDiimidUrvsG1+EUXzrEn+KqGcja+fj/dpIhG6iMStBqnXMKPPjd6w+Hx8tpzWpmNh2qnL63HGMLgsEAZ6J/NiIlIeJ/85n/AiI5vA5ZB+wxVSqEJZoZTpbxNI6dgRtnOAek2lwlphdnhqaEKz+hPnPoaZ9Tq5w3Ym+xHW/OogXOgfQrPjX8iEAyZ9hY4sAxsPfSOJImlw4mncHfCj9DJdfOhwF+23k0rHSG//uaO8iMYoCBGIOsaE0M9fPa2dGFqwAeL5cwdB42FmJ22km3aEPZbOPFkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P0YcetgFOso/5fng5z91mf44PYdE3ImFctlQcvNLtH4=;
 b=VRa3rCHJBXw5reZ22CG2qcflwMuFXUI6wF+TNIxZ4yvZk6jehcwI3vW7FINCTuHVZDZQrZSEmZvK02OJF8ga/y40poh2+A4miuNNfIkujcvkmYWbhvmBuzDhtCfmSHAy09z/5TY/MljoJEDWj+OWG8ZYIbxHHBMmP4FTGgBhwZjaJX+0KGulHWEeu6wffaJFM4s+A4buOVBIzl2WnHU7IK2NzzVtzSzdgMfSRYZes2cO/6/jX5XYlVX70Ut0+RtmnXHyy/1SGCPdYVq8WdRMgSEMlfBccCe3fofcFK3pNfS4C3g/ab4zL0O5+TC7dcD+jjgiJtrxrfka6+ATRp+zpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P0YcetgFOso/5fng5z91mf44PYdE3ImFctlQcvNLtH4=;
 b=BAawokB9mW7aKeqG0YiLRqih15mtBsCx1pzOyrD7hxqDo+0Vir/E5VDbs7mJICDQferhimJ1S0KfPxQQEBwGgQPcO5hJ1YGdEHvK9gF0xEPOxwvPDB93XgXWYY5N4RLVxoRD0Sq/rCskQYp9LM2Q8my82r20kPeIj5P2rQpe247qdZqL8/3np9jG2H6AO07q8qlWvPXwiop2AR0KAMVjPF5H++2y7gS+y6/8NXW9sXX/rP4u515Q2phzJjeRXLNFt9z3oveHZtBvOeg3wRjHTxjMK4d3DJe59VIU9YykYZknaV36zt7BowMo1FoWOaOgPzuKq09h1IN0qnMDd+lGzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by AS2PR10MB7046.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:596::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Fri, 16 Jun
 2023 17:14:51 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3e1d:7882:5390:f8d1]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3e1d:7882:5390:f8d1%4]) with mapi id 15.20.6500.029; Fri, 16 Jun 2023
 17:14:51 +0000
Message-ID: <c928cb7a-9d7f-9b5e-779a-cd6cfc30805f@siemens.com>
Date: Fri, 16 Jun 2023 19:14:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [cip-dev][isar-cip-core][PATCH] swupdate: Update to 2023.06 for
 wfx support
Content-Language: en-US, de-DE
To: Jan Kiszka <jan.kiszka@siemens.com>, christian.storm@siemens.com,
 cip-dev@lists.cip-project.org
References: <20230616164738.3895223-1-Quirin.Gylstorff@siemens.com>
 <f224ba10-ef4b-8ce6-a613-63bebae3c3a7@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
In-Reply-To: <f224ba10-ef4b-8ce6-a613-63bebae3c3a7@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0136.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::18) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|AS2PR10MB7046:EE_
X-MS-Office365-Filtering-Correlation-Id: f4d3a31c-af1f-48d5-c04e-08db6e8d31ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	LEQuOxFwXMp110N5YMXIkQAUNfptnchoXEShVeF9qxpUmX2Sbhf3598pQmuTLVZEtOkoxCwrPgHdETPdLeu/qlUxNIttNprZ6p9T42I64vDLB1fG8q8mOP6tuLX5+G9YudGrWSIWu2dM8ip3grGPvEc7L0v86MddpiA9R0IEE5vvXL64EqJq189cyL4NNdGFAZ37w47IBxfo5WMUnBrc4hYzHKpwvqUvNt1Psr/qxhG40E9SsFjBve6fZ3ZAKZ+RYHNA6r09SuTYbisIynR/XTanjAGngtXhVUTzHHBsaXS9pUrBlOCJt3PDZ3qWC4XSJgEww+gIQ2FUaIrsJZxuke+ev4cIBCMafM7FT4HZkukCFCJSVR2/MQGVjiHjAn3oat3bplhdy79XSkktzY/ZhV7KlYb/je4LFbyRGa2sA2Bf4wOWkV/AtEPwZ7gBOAlX+A0tXQlVxLdyFRIGBqNqFk6HmrKI/UV1E1I/3Ylf35NA6bI/fxuHay0mhVv1kRbRjtKJo7MBLk69ZIOcB0FA+xTfAcijm6qQpFgVPmlnVJlnwqWZlOPY0TUjXy4T0YIr/2rrD6+tSI8aJXypzrC5oe0wnH45Nr03NVPjOgkHLAw8NtI1RwrFGNFjUDuZX9RFQPy5QpW0I7NOrU4p9TSrvA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(366004)(39860400002)(136003)(451199021)(66899021)(2906002)(41300700001)(5660300002)(8676002)(8936002)(15650500001)(316002)(66476007)(66556008)(66946007)(36756003)(83380400001)(2616005)(26005)(186003)(53546011)(6506007)(6512007)(31696002)(82960400001)(38100700002)(31686004)(86362001)(478600001)(6486002)(966005)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VnNvTy9CS2dhTmk2aWxUM3pKTjEwU3QzOWtKc0pFK3ByWUNXaEtVREtmQ1BV?=
 =?utf-8?B?dHhUa0plY0xvZ3RJTXRQTFFQYWY4WC9TWUsrbG9TV0dVeUFpNHZCU3FUTmxW?=
 =?utf-8?B?Yjg4TnJXZjM3cXhUeGhRV09CdmZrWkc3M0phZEk1cFpueWRjUmErMDI0anBh?=
 =?utf-8?B?REY0NjVWMTVRTzNNalVHRVlIWFNzc3lzZ3VMSnNUWkRnMjBhTlFCODJiUncy?=
 =?utf-8?B?eE1JVVZ5RXJERCt4cCtCS0FiY1lxeU9qM2NxTFpETG4zbU52WmdrUlp5aURT?=
 =?utf-8?B?K3d6WVFMSEJGWjkxMnU0RUNHWjRVV1h3SG9DYkNqNVZPWGIyd2t2NEZBYjUw?=
 =?utf-8?B?dmpSOVZuYnY4VjVwQU0vVVd4K25uYWU4RkhTaTFuWmh0MGZQOU4yMW1jSzNk?=
 =?utf-8?B?OFQyTnJ4WHVza292a1FXQjRyTWZ5VWZrZE9XVi9SSThqRlNFdUV3K052WlMv?=
 =?utf-8?B?aVpOdmwvYTQzWWN6VXF4VWJaaHNRUXM5UU14VnVwTWM0R2pnOHQ5Y0g2Nkcx?=
 =?utf-8?B?NndGaHpSSU5uZlhrNG10b2FoV1dFN283ZEVuamxSMDFPdW5COGJMQUpEZmpR?=
 =?utf-8?B?UTRIRWJ6WjdVVUNUK3hhYTJRTGpIOWVKajBBMnVRTkhNN1BLdDRXcXBBMS9X?=
 =?utf-8?B?bzFFb2lKRzZLNi9yUGZqM09VY1pueC9qN0FjNW5vTnJTY3B1UUF1N0s2SG1N?=
 =?utf-8?B?Z1lOMjhWUU5tWnBiaGxReTJzOS9sZWNjTUUwb2hyYTgxTHRMeUpMSVFoNmI2?=
 =?utf-8?B?OTA1SlU3dm1OYmJqZ21tQmV1TCtrUXc1U3NlcG1FU25vVXh4S0pKb3pwT3Qw?=
 =?utf-8?B?a1B4Umdpem1kN0lyenVPbmpzK1A3SDJRZURQaHZEWEF1MHh2dlhoaTZ2V25O?=
 =?utf-8?B?eXhOZ1VrbVZsM1l3a2Z6ZG8wZk1RVHpkSi9hYXdmVllPeHJ6RURQeTdpVjRC?=
 =?utf-8?B?cWlMMnJjcWJyQ0pUcEw0MVNaVTVoSHNxRHNsNjI0ZEpJSUpqdFhaVSs5NitS?=
 =?utf-8?B?eGVibmVpT09CUnh5cUlqRFN5RFRtay9SK1lKTGR2K3JkTVA1MnBnWUtWWVky?=
 =?utf-8?B?MGlRTE5Tbk1aMkhDSk1pNldiNGFFNkt6a1p0MmZnOHkvR0J3dFAvbWo1MlB6?=
 =?utf-8?B?SU1CL1I1cld6OE9iN291dVlaaUMxSFI4YkpqeUo5UnUvQTVPbnh5RFAwL2Nj?=
 =?utf-8?B?dTBwMzNnbXVobm9ZR0dGT2wzcXM0S2x2djQ1QXVZOW4yUDVnckhNZGRjcnd1?=
 =?utf-8?B?UFhrMld3UGxmUklPdzhPYVY0V0xpYWpvV05wbExsYTFlTUlPMm5mSjFzaSty?=
 =?utf-8?B?bjBPMHR0eVlmOHRDcU16UXNUa08wWDY3ZmlxeXdsUldqQXpXK0t2K3RHOFZT?=
 =?utf-8?B?b3RLNWlSeTFwVkx6YjY2bkdtYXZQem9nYXhwbUpJRk4rajBTdTVUMEVid3RW?=
 =?utf-8?B?VlZkWis3MTRYMXFHSHZzblAreUxyZDBWaFJRdVlRY2Q4RkoreElTKzdEOXVC?=
 =?utf-8?B?VGxrTEUrcDdnRGNPbm9WSEJQUG91R25CNm5DY1dxK1hqNjNRQlVBbVFQRWhw?=
 =?utf-8?B?UkxPU0liRVAzSlEvVVFqYVdXTjk4SjNpb3hlVUlCNDFQNUxIZnRkaGQzajk0?=
 =?utf-8?B?K2xKb1EvUFkvNUlkUkc5aXd6SlR6VWxHK0o2NGNNbldQaklYNDRVekJaOThT?=
 =?utf-8?B?RDFmaldFTzgxOWYwUG1jT25JYllmTWYwaGppNVR6Q25lSVBmMjF6dXBaZnpt?=
 =?utf-8?B?N3JyU09QUGNPS2loN0pkZWJ1MGhTWWdsSEZuakpxWDA0Y0xRVWk3Vmtxdkhr?=
 =?utf-8?B?M3lNYyt0UzZjREsyVlgwcmx2NC9rS3lkcm1TT0JQM3M1MWJPV0NBY0NlZ29S?=
 =?utf-8?B?UUVVc0dpekFFRC9DR2JLTjZQRzVjVjRFazdFREtzRVRwT2IrcjNVS3ZGemEx?=
 =?utf-8?B?WGJiSDkzNzN4UUxRM2lGdEZzNVFRVytNc3NPTzhpaGhrTWlVUlorQ1lPajZp?=
 =?utf-8?B?bkl5VnhRN1pPQlpNQjZEODI0VHpIVkdFTFhBUFJZWmdtRG9haEhkVEZuOHJa?=
 =?utf-8?B?TUc2R3pDV1lPOWhuM01EaWVUQVZ5M290TTFVSzkvL285dXNhL0xlKzArdGdw?=
 =?utf-8?B?d05yREhrelNrcU9Sb0VFaFVqRHpKRytHYVFVZVRPQVJrSlcvY25zRkROeFhF?=
 =?utf-8?B?eEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4d3a31c-af1f-48d5-c04e-08db6e8d31ca
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 17:14:50.8859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GsKFe0Y4CjnnnlWl5MQ3GE1O20U8TljA/z+XaN6hT6Rvo+J6uOVDCcntJlqgLDWLEUFTk2EW1iLug2CDtR7NdduAg1B9OcXU3uFTFCe+qrM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7046
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 16 Jun 2023 17:14:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12069



On 6/16/23 18:58, Jan Kiszka wrote:
> On 16.06.23 18:47, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> This will update swupdate to c8ca55684c375937dbcdefb0563071a35137f4ba
>> (tools/swupdate-progress: Adapt for wfx) to add the wfx bindings.
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   conf/distro/cip-core-bookworm.conf            |  2 +-
>>   conf/distro/cip-core-bullseye.conf            |  2 +-
>>   conf/distro/cip-core-sid-ports.conf           |  1 +
>>   recipes-core/images/swupdate.inc              |  5 +-
>>   ...rate-build_profile-option-for-delta-.patch | 47 +++++++++++++++++++
>>   ...2.12+dfsg-4-gbp.bb => swupdate_2023.06.bb} | 21 +++++++--
>>   6 files changed, 67 insertions(+), 11 deletions(-)
>>   create mode 100644 recipes-core/swupdate/files/0001-d-rules-Add-seperate-build_profile-option-for-delta-.patch
>>   rename recipes-core/swupdate/{swupdate_2022.12+dfsg-4-gbp.bb => swupdate_2023.06.bb} (55%)
>>
>> diff --git a/conf/distro/cip-core-bookworm.conf b/conf/distro/cip-core-bookworm.conf
>> index f05d3d3..5563e49 100644
>> --- a/conf/distro/cip-core-bookworm.conf
>> +++ b/conf/distro/cip-core-bookworm.conf
>> @@ -12,6 +12,6 @@
>>   require conf/distro/debian-bookworm.conf
>>   require cip-core-common.inc
>>   
>> -PREFERRED_VERSION_swupdate ?= "2022.12%"
>> +PREFERRED_VERSION_swupdate ?= "2023.06%"
>>   PREFERRED_VERSION_linux-cip ?= "5.10.%"
>>   PREFERRED_VERSION_linux-cip-rt ?= "5.10.%"
>> diff --git a/conf/distro/cip-core-bullseye.conf b/conf/distro/cip-core-bullseye.conf
>> index 9c83054..604280d 100644
>> --- a/conf/distro/cip-core-bullseye.conf
>> +++ b/conf/distro/cip-core-bullseye.conf
>> @@ -15,6 +15,6 @@ require cip-core-common.inc
>>   DISTRO_APT_SOURCES:append:swupdate = " conf/distro/debian-bullseye-backports.list"
>>   DISTRO_APT_PREFERENCES:append:swupdate = " conf/distro/preferences.swupdate-bullseye-backports.conf"
>>   
>> -PREFERRED_VERSION_swupdate ?= "2022.12%"
>> +PREFERRED_VERSION_swupdate ?= "2023.06%"
>>   PREFERRED_VERSION_linux-cip ?= "5.10.%"
>>   PREFERRED_VERSION_linux-cip-rt ?= "5.10.%"
>> diff --git a/conf/distro/cip-core-sid-ports.conf b/conf/distro/cip-core-sid-ports.conf
>> index edd3c28..2f02367 100644
>> --- a/conf/distro/cip-core-sid-ports.conf
>> +++ b/conf/distro/cip-core-sid-ports.conf
>> @@ -14,6 +14,7 @@ require cip-core-common.inc
>>   
>>   PREFERRED_VERSION_linux-cip ?= "5.10.%"
>>   PREFERRED_VERSION_linux-cip-rt ?= "5.10.%"
>> +PREFERRED_VERSION_swupdate ?= "2023.06%"
>>   
>>   DISTRO_APT_SOURCES = "conf/distro/cip-debian-sid-ports-snapshot.list"
>>   HOST_DISTRO_APT_SOURCES = "conf/distro/cip-debian-sid-snapshot.list ${DISTRO_APT_SOURCES}"
>> diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
>> index ebc844a..6a01abb 100644
>> --- a/recipes-core/images/swupdate.inc
>> +++ b/recipes-core/images/swupdate.inc
>> @@ -12,9 +12,6 @@
>>   inherit image_uuid
>>   inherit read-only-rootfs
>>   
>> -IMAGE_INSTALL:append:buster = " swupdate"
>> -IMAGE_INSTALL:append:bullseye = " swupdate"
>> -IMAGE_PREINSTALL:append:bookworm = " swupdate"
>> -IMAGE_PREINSTALL:append:sid = " swupdate"
>> +IMAGE_INSTALL += " swupdate"
>>   
>>   IMAGE_INSTALL += " swupdate-handler-roundrobin"
>> diff --git a/recipes-core/swupdate/files/0001-d-rules-Add-seperate-build_profile-option-for-delta-.patch b/recipes-core/swupdate/files/0001-d-rules-Add-seperate-build_profile-option-for-delta-.patch
>> new file mode 100644
>> index 0000000..2a6f2e0
>> --- /dev/null
>> +++ b/recipes-core/swupdate/files/0001-d-rules-Add-seperate-build_profile-option-for-delta-.patch
>> @@ -0,0 +1,47 @@
>> +From 5e29e0929e37a6ab6aaad1b44280f1bb0d9a4fbe Mon Sep 17 00:00:00 2001
>> +From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +Date: Thu, 15 Jun 2023 18:48:25 +0200
>> +Subject: [PATCH] d/rules: Add seperate build_profile option for delta update
>> +
>> +Delta update need zchunk 1.3 to work on memory restricted
>> +devices. zchunk 1.3 is is not available in bullseye-backports
>> +and Debian bookworm(12).
>> +
>> +To enable delta updates add 'pkg.swupdate.delta' to
>> +DEB_BUILD_PROFILES.
> 
> So this will disable delta update for now - but it was subtly broken so
> far, right? Should be noted in the commit message.
> 
>> +
>> +Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +---
>> + debian/control | 2 +-
>> + debian/rules   | 2 +-
>> + 2 files changed, 2 insertions(+), 2 deletions(-)
>> +
>> +diff --git a/debian/control b/debian/control
>> +index e47c320c..d4b17972 100644
>> +--- a/debian/control
>> ++++ b/debian/control
>> +@@ -26,7 +26,7 @@ Build-Depends: debhelper-compat (= 13),
>> +                uuid-dev,
>> +                zlib1g-dev,
>> +                libzstd-dev,
>> +-               libzck-dev (>= 1.2) <!pkg.swupdate.bpo>,
>> ++               libzck-dev (>= 1.3) <pkg.swupdate.delta>,
>> +                libp11-kit-dev <pkg.swupdate.p11>,
>> +                libwolfssl-dev <pkg.swupdate.p11>,
>> +                libmtd-dev [linux-any],
>> +diff --git a/debian/rules b/debian/rules
>> +index 57da4ca7..1c8d12e4 100755
>> +--- a/debian/rules
>> ++++ b/debian/rules
>> +@@ -38,7 +38,7 @@ ifeq (linux,$(DEB_HOST_ARCH_OS))
>> + else
>> + 	echo "# CONFIG_MTD is not set"     >> configs/debian_defconfig
>> + endif
>> +-ifeq (,$(filter pkg.swupdate.bpo,$(DEB_BUILD_PROFILES)))
>> ++ifneq (,$(filter pkg.swupdate.delta,$(DEB_BUILD_PROFILES)))
>> + 	echo CONFIG_DELTA=y >> configs/debian_defconfig
>> + endif
>> + ifneq (,$(findstring $(DEB_HOST_ARCH),amd64 i386 arm64 armhf riscv64 ia64))
>> +--
>> +2.39.2
>> +
>> diff --git a/recipes-core/swupdate/swupdate_2022.12+dfsg-4-gbp.bb b/recipes-core/swupdate/swupdate_2023.06.bb
>> similarity index 55%
>> rename from recipes-core/swupdate/swupdate_2022.12+dfsg-4-gbp.bb
>> rename to recipes-core/swupdate/swupdate_2023.06.bb
>> index da44ae5..26aced4 100644
>> --- a/recipes-core/swupdate/swupdate_2022.12+dfsg-4-gbp.bb
>> +++ b/recipes-core/swupdate/swupdate_2023.06.bb
>> @@ -8,7 +8,7 @@
>>   #
>>   # SPDX-License-Identifier: MIT
>>   
>> -inherit dpkg-gbp
>> +inherit dpkg
>>   
>>   require swupdate.inc
>>   
>> @@ -17,16 +17,19 @@ DEPENDS += "libebgenv-dev"
>>   DEB_BUILD_PROFILES += "nodoc"
>>   DEB_BUILD_OPTIONS += "nodoc"
>>   
>> -SRC_URI = "git://salsa.debian.org/debian/swupdate.git;protocol=https;branch=debian/master"
>> -SRCREV ="aa9edf070567fa5b3e942c270633a8feef49dad8"
>> +SRC_URI += "git://github.com/sbabic/swupdate.git;protocol=https;branch=master;name=upstream;destsuffix=${P}"
>> +SRC_URI += "git://salsa.debian.org/debian/swupdate.git;protocol=https;branch=debian/master;name=debian;subpath=debian;destsuffix=${P}/debian"
>> +SRCREV_debian = "aa9edf070567fa5b3e942c270633a8feef49dad8"
>> +SRCREV_upstream = "c8ca55684c375937dbcdefb0563071a35137f4ba"
>>   SRC_URI += "file://0001-d-rules-Add-option-for-suricatta_lua.patch"
>> +SRC_URI += "file://0001-d-rules-Add-seperate-build_profile-option-for-delta-.patch"
>>   
>>   # deactivate signing and hardware compability for simple a/b rootfs update
>>   DEB_BUILD_PROFILES += "pkg.swupdate.nosigning"
>>   DEB_BUILD_PROFILES += "pkg.swupdate.nohwcompat"
>>   
>> -# use suricatta-lua instead of suricatta-hawkbit
>> -# DEB_BUILD_PROFILES = "pkg.swupdate.suricattalua"
>> +# Add suricattalua to support wfx
> 
> Maybe add ", disable to use suricatta-hawkbit"? Or did the logic change
> to support both?
> 
With 
https://github.com/sbabic/swupdate/commit/3be5e03246b3bb193cd802f3415fdd7b19f6867e 
( suricatta: Suricatta module run-time selection ) we can support both.


>> +DEB_BUILD_PROFILES += "pkg.swupdate.suricattalua"
>>   
>>   # Disable cross for arm and arm64 on bullseye
>>   # with cross compile we have a unsat-dependency to dh-nodejs on arm/arm64
>> @@ -37,3 +40,11 @@ DEB_BUILD_PROFILES += "cross nocheck"
>>   
>>   # use backport build profile for bullseye
>>   DEB_BUILD_PROFILES:append:bullseye = " pkg.swupdate.bpo"
>> +
>> +CHANGELOG_V ?= "${PV}-1+cip"
>> +
>> +do_prepare_build() {
>> +    deb_add_changelog
>> +    cd ${WORKDIR}
>> +    tar cJf ${PN}_${PV}.orig.tar.xz --exclude=.git --exclude=debian ${P}
>> +}
> 
> Which change fixes the missing version string in previous recipe?

Ah - that patch is missing.

Quirin


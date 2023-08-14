Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A9EC001B0
	for <webhook@archiver.kernel.org>; Mon, 14 Aug 2023 14:02:54 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.59])
 by mx.groups.io with SMTP id smtpd.web10.108366.1692021770280066163
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Aug 2023 07:02:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=H/TQlH5E;
 spf=pass (domain: siemens.com, ip: 40.107.20.59, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a7SK2dwJZCph50WgeMC8+IJZ//59el7S9QXN1rQPFnEzCq0cAEczR+b+ZGJ97pYjqlqz5cC+k9QSCgAsMQMrEyiPcg1Im6vwfu8Q3wSUJNvGAeD6NBKidUkEIbFxqu4lmvFLA0G7BRNilNGBxeddgz/uLINIjs3uYL3qsCbWHAmcG4RupK2Tkc+8cayfX+DFo4eSLKK61zARXUWkvi9FmBPFyRLOuYYd8u4BRHZLPcZ3zdo3uw4VvTGzmarcnZEOMH6hXT0eb2r/DBZw7qXTMSBeRMipMPwoip3IZUpJyiKE+61q9tJ7uVdSxj5xvtmxKR3PtlkLHWWua4+F9bcNUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CSwHhDqdLt9UZb6LSiB2Q/YJqunBkuRKuWA+r18W/Ac=;
 b=Gx1iTIKfCaT08gF8DNsgdtdX8s19chVMOSz0LFVC+/T9u9PVCGi0p4bq6BbaUu4oliOjzkSFt+PSdFcBKyrBx35a010b1x6kyPnlUaufpGW1Uw/sFZWvI3LXsA1gNQJWIk8WGLqreR3lQfJvKcXGHmJvH3GJtzhaaHnRu1KaJfNXwIJBUUhOAw3BeYMiyCfOvd+ETt+Q9gBjh1ZG+srWmIF1dnPWU97NoWQTFja8Hvo0+InP6Mwu/31LB2EeAI/yqUFR8HIHJAAUtjyvEpIZvFXBE2yI708mLHVgzIMR8ihCJ5VS47CjdJbbbjEDwJxxYU5kMIRQ5hjrxX2ffa9S1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CSwHhDqdLt9UZb6LSiB2Q/YJqunBkuRKuWA+r18W/Ac=;
 b=H/TQlH5EGibYG5TQQHvk/UTsq3/NZeQYBk+b6qZe7pElodl2icB1zdCYBAgoztri/xSm80ip2FlrJ8hK0NHtPnN+dwGgRzjzUgg67U7HJN9uXgs7eNdmEo2dT//L8Auy/RVSQBXcH22pJod/Bn03n2nqMc+V0/eHicXVISe2spNHTfDKdJcjIAyR/AUqFVFjzie5EQv/hsIWteZanEPBj8d0gn/y1AGoec1HkZOkpMSlK5hap6fXTKXBl69FHErQCKWxiFtJNgeFjQywQpNrbAGN06ec8CkywMn7NRxaRwV/78oDDC98IN3X2ZnTdaOsqOpdkZLNOJBPaXdyf9gpNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by DB8PR10MB3147.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:112::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.22; Mon, 14 Aug
 2023 14:02:47 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::90a8:2018:8363:8691]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::90a8:2018:8363:8691%7]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 14:02:47 +0000
Message-ID: <605994ca-7f89-7838-6234-33223a33c20c@siemens.com>
Date: Mon, 14 Aug 2023 16:02:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [cip-dev][isar-cip-core][RFC v2 1/3] recipe-devtools: Add recipe
 to sign SWUpdate update binaries
Content-Language: en-US, de-DE
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
References: <20230717105417.27761-1-Quirin.Gylstorff@siemens.com>
 <20230717105417.27761-2-Quirin.Gylstorff@siemens.com>
 <233ad9a5-9b54-41d9-89b5-2b629464d461@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
In-Reply-To: <233ad9a5-9b54-41d9-89b5-2b629464d461@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR20CA0009.namprd20.prod.outlook.com
 (2603:10b6:610:58::19) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|DB8PR10MB3147:EE_
X-MS-Office365-Filtering-Correlation-Id: ffb4b0b2-4671-4c7d-d79c-08db9ccf234d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	CJH1XAq7WcwcXuBU5jsY7z4IDZO19/fhCp3rBeJ4qWPGcY9clvAG2OMbc/HdMjvKtd2tMaDMDSghb6aYBfxL2TFqry5hk7dKMVhNCkn6vFw9fP7YCitLLkrooYOkVsln9nO8NkfM2yQv/kWhx9mFX4/QyTuBSd4EGsuXwj7MXSE4Bi6Lj5puGLWj7wCnELsNTiFQjcTswAduzz9r9yPOgTN3X+LnUUlUC4t7/7MDbgK6wXRe5/H1Y4VIPqheAf7/NlF1n42nFBY4WH39J5xiW3DQsxMIlYV51ZUltILk7Zbqo2T/ii0nXEl+5NV6AkVUxZuPI69BnKbp0ToC6g0K+WQ1iT9t1smA0rUA5eb5V/qIzmxNYxUx0jIcdiFStdOmsQqH0d7zoR8O/579YaWtjoo4kCC7vlE9LIQVWSWddZuiHrGdhtC5HfjxiSJBt4og2D1kr0nMjZVlHVKKU4LIAaKTs36SRmMoJHGVIAWC4uqwW6Yzo+Dlh2o1PpdkySyw1Kh4gHtBHoxArEzwRsiELkvR1JH0nBixcRG0kOB2l7hewM5KiQWABbTdRL2/+3M4F+3xcjMpYnCDH9CbDSjCzdh0f6Zl8fhgK4uWmvNoTkYap9OJ4U4IPfAFstprh41XLkC4l323PqHK69QAu0kWEg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(346002)(396003)(366004)(39860400002)(1800799006)(186006)(451199021)(38100700002)(82960400001)(36756003)(31696002)(86362001)(8936002)(8676002)(5660300002)(2616005)(2906002)(6512007)(15650500001)(83380400001)(30864003)(66556008)(66476007)(53546011)(478600001)(66946007)(26005)(41300700001)(966005)(6486002)(316002)(6506007)(31686004)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dDFUWlBWNVBwcjlaSTc0cjJVUVhCMzVEYTJrdWF5RS8wUGhRRFNKOWFzQXUv?=
 =?utf-8?B?WVZ0VTNLL0psVHhucThBVEVTVDZWbGpCdVVLRlhOMFFCLyttN09TbnI0WWJy?=
 =?utf-8?B?SXV0aDJwN1FYdGQrdFJyTGVkK3hYNk00MGtkQzBWV1g1em1ZMmQ0ZUZJdDdH?=
 =?utf-8?B?cUswVzJCR1Z4WG9TNmIzbWxtNmNzTklLcTR3ZGc0U1VTU0xkeXdkc1lzNy9j?=
 =?utf-8?B?L20zaHlMNFQ1YU5Id0FIaDlWb3g1UUVlK24yWEduOS8wWHNmZythQ3phN29j?=
 =?utf-8?B?Y1Zsd3Z2Rm9vNlZsQmVxV3gyd0krYjlzeUJxcHR2U2l1eFRoUDAyMlUwY0kv?=
 =?utf-8?B?Qkh1MmlGZDFTQ2dNLytxS0pBTlpDSFVHNXRMRWtXSDNCS0lMK3lvaWNZc2Fz?=
 =?utf-8?B?RXFGQ2lqTFFmbmVpZmhUSXZsNGdneGVwdVRoOWJIKzlrbmEwWCtzWEkzQlNh?=
 =?utf-8?B?dTl4YVFVdnhXemhURHUwV0FzVXNvSDhrMmpmNDlWNHI3allJTkttRU5yc0VE?=
 =?utf-8?B?NEplYXpOVDFCRURDWjlyWE1OT3VhMmtrU3FFNm0waGJQSHB3dU9yZ2UrTlRZ?=
 =?utf-8?B?aGhHcWxValhWWnNsb0Z5RFhkc1FjeGhSR0JuM3ZLTGRGcmFnQ2dTR1p2bTBZ?=
 =?utf-8?B?Q0ZqelFHRk00OEx6N015c29xWXVwYmkzb3pEdk5hRzZrUjhRTmduRnlYTThL?=
 =?utf-8?B?Uk5hRGhhVzlWci9XendBbW9nS1I0cHFWdzQraWFVVkhsZExhWVBCakxsSDhL?=
 =?utf-8?B?d2lKMHFUL3N1NWk1cVFSRFdJZ0txZXlpaElvajVsYkJ3V28yazl3OUY1cWdL?=
 =?utf-8?B?NHlpVWhxRDVSQ0s2NGJnZXdSNW5qeUNnVXljMkF5TVp4Sll1UVl1UE1oZGZZ?=
 =?utf-8?B?c0paaE5YZmlUd21DTm9iaGw4QUFjK1J1Nk5NTlZDTURMeHRPRWJmSStXSCsz?=
 =?utf-8?B?VWhoOFNDakdObmR3c1pJM0FpYnJlZ2s0VVRpR2QwQ2toVFl3a05xQ2I1Yi8w?=
 =?utf-8?B?RHhJNnhGVXFsQ0hNSDF6dVJPSWlmNnFGMU5FdmlsdWFUdmxrRmEvK3JhbUV5?=
 =?utf-8?B?M0JDV1MzaVRIQklhWnQrcFo0UVl2bUNtTTFvOWE0NGp0K2dQVWpnMTZ3NGNN?=
 =?utf-8?B?QUZiR1ZlcUM5bzgxKytQeVFYVk1tK0ZKamNoaHJxYjZXTEpNVWZ0K2RkaktI?=
 =?utf-8?B?dWVTQW5VdTFSeUVDVE5sKzYwRWxLdkN2a05WeDRXUXI5a3h3QURUMW1vT29H?=
 =?utf-8?B?YTdPci9zSUJ6eDZyeWxMUmFQWXI2VGZNRWYxRHJ1S3ZDeXdncGIweDFwYmVa?=
 =?utf-8?B?Z0tCVm1JYi9VaDhUdURkMmsxT0FSczBML3VxdlZPb3Z6d3hBVkV0SkpzbUJ4?=
 =?utf-8?B?cUFJZUZRRUh2MTlWaFB3ckdkbWhLUlN3UzlHbldPcndFeTlhTDRWRGErN2tw?=
 =?utf-8?B?aitma1pZc3ZJZEpTV1JHK3h1cTRpZzJHa1BLY2tGblVQOTN2V2RHNzBrK241?=
 =?utf-8?B?cGZoNytkNXNabWdoei9sWUtUcjRqRWRzWTcxSjNWWE5mZ3dRQXNIOHRwdU14?=
 =?utf-8?B?WlU1NnQ4M0VINDhQQU1rNjN2ckUvY0pSRFZ3YlNzYTRRUzFGOGtsMlp6K3NU?=
 =?utf-8?B?WkdocFlxeWFqbmJ6T1hjNmtkd05IVzlXMzRHZE9nK1pmdkxvMythZjJKYTNB?=
 =?utf-8?B?dnhReVZPMitBKzF4ZE9raXZHSmRBK2tZcE9zN2dFNGRkc05rdlVwS2k1Lzdr?=
 =?utf-8?B?WG95WWlHckhWYWlsRk5xS1Y5cVhFQUVndUQrUTJPWkN3MVRzNDVWR3ZDZ1B3?=
 =?utf-8?B?cUJYRFJETUIvUTIveEZKWjRGbzNmbGtucWlmQ3VBMUxxRFY5aTZldTYwNjJE?=
 =?utf-8?B?SEM2MEwvUk1hdUVpV04vVGRRSFZDRUEveWxXR0w4OEFGU2U5cUhtK1FCKy8w?=
 =?utf-8?B?RXdIRitqR0M2SGtwcjBXK2tPbHEzNGNRMUpyVnNUdVpDTy91Q3IxV0MwSUtW?=
 =?utf-8?B?VElpOW9QaDUwdkc1NzBYSGFEem1tb3hKNWFsWHl1UmtLUEw2NVV4T01nczk1?=
 =?utf-8?B?eG5TOVExbGtWdVgrMWEyc09IMkdMWnRkNXY5VkhrOTVSNC8vNSt0QnFuQU0z?=
 =?utf-8?B?VjdVcWtnaDU3Zk1SQS9sMXZZUFBNV1F3UmtPZXhaN2dHSWZ3VjJQQmx4d1hJ?=
 =?utf-8?B?dFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffb4b0b2-4671-4c7d-d79c-08db9ccf234d
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 14:02:46.9751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VC9xMX75rVByaXUepKrdEdqtKqYyU2jKQlqsKW+ZNgnAwpWXTWtTJ/ceBsu0/h/bYB3Gx2ikgkVtqPsPNkreBN88KwmraIapF6VhtgXXet0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3147
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Aug 2023 14:02:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12652



On 8/14/23 15:17, Jan Kiszka wrote:
> On 17.07.23 12:54, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> This also adds recipes with the Debian snakeoil key and
>> certificate to test signed updates.
>>
>> For in-production new keys and certificates must be created.
>> [1] descripes the creation of keys and certificates.
>>
>> To use non snakeoil certificates copy the certificates and keys to
>> recipes-devtools/swupdate-certificates/files/.
>>
>> The following settings are necessary:
>> ```
>> PREFERRED_PROVIDER_swupdate-certificates-key =
>> "swupdate-certificates-key"
>> PREFERRED_PROVIDER_swupdate-certificates =
>> "swupdate-certificates"
>> SWU_SIGN_KEY = "<name of the key file>"
>> SWU_SIGN_CERT = "<name of the certificate file>"
>> ```
>>
>> [1]: https://sbabic.github.io/swupdate/signed_images.html?highlight=signing#usage-with-certificates-and-cms
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   recipes-core/images/swupdate.inc              |  2 ++
>>   .../secure-boot-secrets/files/buster/bookworm |  1 +
>>   .../secure-boot-secrets/files/buster/bullseye |  1 +
>>   .../swupdate-certificates/files/bookworm      |  1 +
>>   .../swupdate-certificates/files/bullseye      |  1 +
>>   .../swupdate-certificates/files/buster        |  1 +
>>   .../swupdate-certificates-key-snakeoil_0.1.bb | 18 +++++++++++
>>   .../swupdate-certificates-key.inc             | 31 +++++++++++++++++++
>>   .../swupdate-certificates-key_0.1.bb          | 17 ++++++++++
>>   .../swupdate-certificates-snakeoil_0.1.bb     | 16 ++++++++++
>>   .../swupdate-certificates.inc                 | 31 +++++++++++++++++++
>>   .../swupdate-certificates_0.1.bb              | 14 +++++++++
>>   12 files changed, 134 insertions(+)
>>   create mode 120000 recipes-devtools/secure-boot-secrets/files/buster/bookworm
>>   create mode 120000 recipes-devtools/secure-boot-secrets/files/buster/bullseye
>>   create mode 120000 recipes-devtools/swupdate-certificates/files/bookworm
>>   create mode 120000 recipes-devtools/swupdate-certificates/files/bullseye
>>   create mode 120000 recipes-devtools/swupdate-certificates/files/buster
>>   create mode 100644 recipes-devtools/swupdate-certificates/swupdate-certificates-key-snakeoil_0.1.bb
>>   create mode 100644 recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
>>   create mode 100644 recipes-devtools/swupdate-certificates/swupdate-certificates-key_0.1.bb
>>   create mode 100644 recipes-devtools/swupdate-certificates/swupdate-certificates-snakeoil_0.1.bb
>>   create mode 100644 recipes-devtools/swupdate-certificates/swupdate-certificates.inc
>>   create mode 100644 recipes-devtools/swupdate-certificates/swupdate-certificates_0.1.bb
>>
>> diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
>> index 6a01abb..5d9cd58 100644
>> --- a/recipes-core/images/swupdate.inc
>> +++ b/recipes-core/images/swupdate.inc
>> @@ -12,6 +12,8 @@
>>   inherit image_uuid
>>   inherit read-only-rootfs
>>   
>> +SWU_SIGNED ?= "1"
>> +
>>   IMAGE_INSTALL += " swupdate"
>>   
>>   IMAGE_INSTALL += " swupdate-handler-roundrobin"
>> diff --git a/recipes-devtools/secure-boot-secrets/files/buster/bookworm b/recipes-devtools/secure-boot-secrets/files/buster/bookworm
>> new file mode 120000
>> index 0000000..b7dbeb4
>> --- /dev/null
>> +++ b/recipes-devtools/secure-boot-secrets/files/buster/bookworm
>> @@ -0,0 +1 @@
>> +../../secure-boot-secrets/files/bookworm
>> \ No newline at end of file
>> diff --git a/recipes-devtools/secure-boot-secrets/files/buster/bullseye b/recipes-devtools/secure-boot-secrets/files/buster/bullseye
>> new file mode 120000
>> index 0000000..3c7fe4f
>> --- /dev/null
>> +++ b/recipes-devtools/secure-boot-secrets/files/buster/bullseye
>> @@ -0,0 +1 @@
>> +../../secure-boot-secrets/files/bullseye
>> \ No newline at end of file
>> diff --git a/recipes-devtools/swupdate-certificates/files/bookworm b/recipes-devtools/swupdate-certificates/files/bookworm
>> new file mode 120000
>> index 0000000..b7dbeb4
>> --- /dev/null
>> +++ b/recipes-devtools/swupdate-certificates/files/bookworm
>> @@ -0,0 +1 @@
>> +../../secure-boot-secrets/files/bookworm
>> \ No newline at end of file
>> diff --git a/recipes-devtools/swupdate-certificates/files/bullseye b/recipes-devtools/swupdate-certificates/files/bullseye
>> new file mode 120000
>> index 0000000..3c7fe4f
>> --- /dev/null
>> +++ b/recipes-devtools/swupdate-certificates/files/bullseye
>> @@ -0,0 +1 @@
>> +../../secure-boot-secrets/files/bullseye
>> \ No newline at end of file
>> diff --git a/recipes-devtools/swupdate-certificates/files/buster b/recipes-devtools/swupdate-certificates/files/buster
>> new file mode 120000
>> index 0000000..67d1534
>> --- /dev/null
>> +++ b/recipes-devtools/swupdate-certificates/files/buster
>> @@ -0,0 +1 @@
>> +../../secure-boot-secrets/files/buster
>> \ No newline at end of file
>> diff --git a/recipes-devtools/swupdate-certificates/swupdate-certificates-key-snakeoil_0.1.bb b/recipes-devtools/swupdate-certificates/swupdate-certificates-key-snakeoil_0.1.bb
>> new file mode 100644
>> index 0000000..a0bbd50
>> --- /dev/null
>> +++ b/recipes-devtools/swupdate-certificates/swupdate-certificates-key-snakeoil_0.1.bb
>> @@ -0,0 +1,18 @@
>> +#
>> +# CIP Core, generic profile
>> +#
>> +# Copyright (c) Siemens AG, 2023
>> +#
>> +# Authors:
>> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +DEPENDS += "swupdate-certificates-snakeoil"
>> +DEBIAN_DEPENDS += "swupdate-certificates-snakeoil"
>> +
>> +require swupdate-certificates-key.inc
>> +
>> +SWU_SIGN_KEY = "${BASE_DISTRO_CODENAME}/PkKek-1-snakeoil.key"
> 
> We are missing artifacts for sid-port (riscv64) here. Can these be
> mapped (linked) on bookworm?
> 

Yes the can be mapped to bookworm.

Quirin

> Jan
> 
>> +
>> +DEBIAN_CONFLICTS = "swupdate-certificates-key"
>> diff --git a/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc b/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
>> new file mode 100644
>> index 0000000..1b6b6dd
>> --- /dev/null
>> +++ b/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
>> @@ -0,0 +1,31 @@
>> +#
>> +# CIP Core, generic profile
>> +#
>> +# Copyright (c) Siemens AG, 2023
>> +#
>> +# Authors:
>> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +inherit dpkg-raw
>> +
>> +PROVIDES += "swupdate-certificates-key"
>> +
>> +SWU_SIGN_KEY ??= ""
>> +
>> +SRC_URI:append = " ${@ "file://"+d.getVar('SWU_SIGN_KEY') if d.getVar('SWU_SIGN_KEY') else '' }"
>> +
>> +do_install() {
>> +    if [ -z ${SWU_SIGN_KEY} ] ]; then
>> +        bbfatal "You must set SWU_SIGN_KEY and provide the required file as artifacts to this recipe"
>> +    fi
>> +    TARGET=${D}/usr/share/swupdate-signing/
>> +    install -d -m 0700 ${TARGET}
>> +    install -m 0700 ${WORKDIR}/${SWU_SIGN_KEY} ${TARGET}/swupdate-sign.key
>> +}
>> +
>> +do_prepare_build:append() {
>> +    echo "Provides: swupdate-certificates-key" >> ${S}/debian/control
>> +}
>> diff --git a/recipes-devtools/swupdate-certificates/swupdate-certificates-key_0.1.bb b/recipes-devtools/swupdate-certificates/swupdate-certificates-key_0.1.bb
>> new file mode 100644
>> index 0000000..2e99617
>> --- /dev/null
>> +++ b/recipes-devtools/swupdate-certificates/swupdate-certificates-key_0.1.bb
>> @@ -0,0 +1,17 @@
>> +#
>> +# CIP Core, generic profile
>> +#
>> +# Copyright (c) Siemens AG, 2023
>> +#
>> +# Authors:
>> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +DEPENDS += "swupdate-certificates"
>> +DEBIAN_DEPENDS += "swupdate-certificates"
>> +
>> +require swupdate-certificates-key.inc
>> +
>> +DEBIAN_CONFLICTS = "swupdate-certificates-key-snakeoil"
>> diff --git a/recipes-devtools/swupdate-certificates/swupdate-certificates-snakeoil_0.1.bb b/recipes-devtools/swupdate-certificates/swupdate-certificates-snakeoil_0.1.bb
>> new file mode 100644
>> index 0000000..22c7ce2
>> --- /dev/null
>> +++ b/recipes-devtools/swupdate-certificates/swupdate-certificates-snakeoil_0.1.bb
>> @@ -0,0 +1,16 @@
>> +#
>> +# CIP Core, generic profile
>> +#
>> +# Copyright (c) Siemens AG, 2023
>> +#
>> +# Authors:
>> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +require swupdate-certificates.inc
>> +
>> +SWU_SIGN_CERT = "${BASE_DISTRO_CODENAME}/PkKek-1-snakeoil.pem"
>> +
>> +DEBIAN_CONFLICTS = "swupdate-certificates"
>> diff --git a/recipes-devtools/swupdate-certificates/swupdate-certificates.inc b/recipes-devtools/swupdate-certificates/swupdate-certificates.inc
>> new file mode 100644
>> index 0000000..0553c25
>> --- /dev/null
>> +++ b/recipes-devtools/swupdate-certificates/swupdate-certificates.inc
>> @@ -0,0 +1,31 @@
>> +#
>> +# CIP Core, generic profile
>> +#
>> +# Copyright (c) Siemens AG, 2023
>> +#
>> +# Authors:
>> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +inherit dpkg-raw
>> +
>> +PROVIDES += "swupdate-certificates"
>> +
>> +SWU_SIGN_CERT ??= ""
>> +
>> +SRC_URI:append = " ${@ "file://"+d.getVar('SWU_SIGN_CERT') if d.getVar('SWU_SIGN_CERT') else '' }"
>> +
>> +do_install() {
>> +    if [ -z ${SWU_SIGN_CERT} ] ]; then
>> +        bbfatal "You must set SWU_SIGN_CERT and provide the required file as artifacts to this recipe"
>> +    fi
>> +    TARGET=${D}/usr/share/swupdate-signing/
>> +    install -d -m 0700 ${TARGET}
>> +    install -m 0700 ${WORKDIR}/${SWU_SIGN_CERT} ${TARGET}/swupdate-sign.crt
>> +}
>> +
>> +do_prepare_build:append() {
>> +    echo "Provides: swupdate-certificates" >> ${S}/debian/control
>> +}
>> diff --git a/recipes-devtools/swupdate-certificates/swupdate-certificates_0.1.bb b/recipes-devtools/swupdate-certificates/swupdate-certificates_0.1.bb
>> new file mode 100644
>> index 0000000..2643aad
>> --- /dev/null
>> +++ b/recipes-devtools/swupdate-certificates/swupdate-certificates_0.1.bb
>> @@ -0,0 +1,14 @@
>> +#
>> +# CIP Core, generic profile
>> +#
>> +# Copyright (c) Siemens AG, 2023
>> +#
>> +# Authors:
>> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +require swupdate-certificates.inc
>> +
>> +DEBIAN_CONFLICTS = "swupdate-certificates-snakeoil"
> 


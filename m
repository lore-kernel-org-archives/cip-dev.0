Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB934C05027
	for <webhook@archiver.kernel.org>; Wed,  1 Feb 2023 15:36:52 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.75])
 by mx.groups.io with SMTP id smtpd.web10.26453.1675265802047350448
 for <cip-dev@lists.cip-project.org>;
 Wed, 01 Feb 2023 07:36:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=iawZC1fE;
 spf=pass (domain: siemens.com, ip: 40.107.7.75, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JN/EaBuyAIC7oQEt/TlZcQ5lkgXWSLJdAekm6FYyFANSApffvtloEmbln4VjMD0SJSLhXdnxjbZvQbzDjiAZcdTwWJP2IQ4dOwU2YjzW5bgYk3soSJ5KUt46aiPZzs2qEqUf1i4chAnLd9qlOnNlrWjNSb3Gnru9OR8LWoD2kMasnWzN2wkBHGPev7TpehQHTukNammsx0MW5ecfJEyXIMxH+oqlzBckBiM6znepVJoXRZNaK7kjZeZmV7a4vl+8kpK9NLeNJ4SPIIqBjx0J28J1vTIg2iAwOnBoYNpc1GHPrFUdpoPqe8TxYvTfmLXJ+rxUscjMNlMGMLfcCvV44w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jpxksDsx59XPxxw/XykP6KhF5f+aWAiJEPD8rprtN2o=;
 b=UeEzwSKcbjTrPUAMFc8onHF9drT7FwiOO4+s1x04lVk6NZyJxMyPzrnHG3CtTXuu6Ry6ddJhwxx14rVisqi+PQbfYyBibadr5byYpeFme/SGCQMsniROF6wITxau+U6RmZhNAqKl1KB8u+PMaXW/eY+0kf957wdA9tysSEPlw2TUPf3jpBQKZEwA5U80StY9EkyuiNR8bjj31H6+eXDyX9bspUY3ow2jQv3aTFSA2vtDT9GUCEiiBQCHhwUyxmaRZQUoX16cTWlErLylo8zrWCBtz/NHNLBwXLiqQ7RhI+GWYhAcNGj/mNs4MrZY+z8EV9O/Y1R0zfuBhbqIRfbtmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jpxksDsx59XPxxw/XykP6KhF5f+aWAiJEPD8rprtN2o=;
 b=iawZC1fEOGs5wI8XmJHXzyHIO2N96cSTcvxzaBFbI2id/hfMcJKLLnunI+CXks0EXu/8KOQCBsQv6jyQqdzAiZUjldfIyluUe2kHyLjPhsw2h3/InhLXqxiWP+xk5fBUpKciXEN0zwnwibz6ByRy3QAhBsQt5ji57ync8pyf9pcMO4w9HeLCdIOFAxmT/S/3Po9ZIHOZgoKKOaX0mo1t+NHSICwKLZHHKu0ZkPy749oVFq+YwU8ft5uqikJKm2401aP7l79tiqUqGDS6KWJb4LNGTgHIEeGWGp4YcfXtLwOpElvH7Z/ZpwGGNUK1rANcfJ1e10FW/g+jp4nbA9A33g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by DB5PR10MB7722.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4a8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.23; Wed, 1 Feb
 2023 15:36:38 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e22:9724:665f:8d94]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e22:9724:665f:8d94%7]) with mapi id 15.20.6064.022; Wed, 1 Feb 2023
 15:36:38 +0000
Message-ID: <82d96ec3-9381-bbad-d0b6-244a2610ce8c@siemens.com>
Date: Wed, 1 Feb 2023 16:36:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [cip-dev][isar-cip-core][PATCH] Add bookworm
Content-Language: en-US, de-DE
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 cip-dev@lists.cip-project.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>
References: <20230130113412.628646-1-Quirin.Gylstorff@siemens.com>
 <6fc061ea-a0b6-13f8-e1e8-50840d4c8622@siemens.com>
 <04ad45dd7d2d86046a77e4dfec13e4283a7622bb.camel@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
In-Reply-To: <04ad45dd7d2d86046a77e4dfec13e4283a7622bb.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0199.namprd03.prod.outlook.com
 (2603:10b6:610:e4::24) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|DB5PR10MB7722:EE_
X-MS-Office365-Filtering-Correlation-Id: d6493e99-f992-4bc5-a88e-08db046a1be2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	kNljDL50OYo3LqDQQ4Fv4cgnE+z2KUiPXkImk5VEZc0ueld9EOcXfr7Le6ohx1cThRG+9Fu6GZ8i1LbPU8JZLQ/Pm6uorpRDM0ggPkPEDSM/89poCh39wL8lZ77n16i5+676EBuQQ10dFKQaWpnvU8g/8Cuo0KZt0glIG2cWVk80MfVMZ1K4YK4bHvM4upsXEwI177eh1iOPdWWfW7Wntewf9yyD6bSFIOg+NvHdI5CNTNE9pwvdhPvUcml7WE1Z+jws8GhltMJ2uzwbO/8W86PFiasqpPpb8sXiIx2QYvgequASgkJI3OGJQFEDilpLt9th9YpVpSfm7eglpTkfwHoSw6kdAczuJbea/Lg76fcQH5EMgHgrUyaWZsWnfdVkjtub5jfmv5FRVjWrLrfEzMZadbT4NpiZjcQ2Hd+PSTRmMDJ862UP5J0N3A+A4dtLwDR1VhwmJAMBrddPiwCHLcu89KHH6/1zzkJJ3PC2zFqAE7y1+6K5JpYiRCo0ahF+c4QbFZfjAAUeZbQwZKZzIG5acbO6NHZJ5pGDWVxa8FvGmvViU1JKxyssrEro+sNzpK2sAUy4j55JAynleNAPpzWjHLS6k50QUFtIYyJ3qEItPsyCDFPajG54xNA11nqgYZSqVfwnHwsan/JFAl9CYMtmAJPLqUttrvgzTIzDwMONxpiho9uUdwbpjPPuT+VTXkmnw5NmrlwEt0jq5qQ+acabVvyUSiZGNnNFlcL0nE8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(366004)(376002)(136003)(39860400002)(451199018)(6666004)(107886003)(2616005)(83380400001)(66899018)(2906002)(6512007)(26005)(186003)(53546011)(6506007)(38100700002)(316002)(5660300002)(82960400001)(478600001)(31686004)(41300700001)(66476007)(8676002)(66946007)(8936002)(4326008)(66556008)(6486002)(86362001)(36756003)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Ulplb3hQZUtkSWR6Sis2NmhvOGkyNUU0RFozYnZlQkcxQi9USDdnMzdmYzNY?=
 =?utf-8?B?bG1zTmN1YXB2YW1XbEtnd0FUVHR6RlVXNzhIZXJaY01zZmVWSG9oTGhPZHpT?=
 =?utf-8?B?NWxOZnZOazU5YlpnMDRDZFRlTFVKNkpna3ZKUGxDVHFUb2NYbWVnWXRGdDlj?=
 =?utf-8?B?NUJXcmE5dnNGVVVvYStMQ2F2azV3anZ6OG9POFBsL2xwU0xUbis1WUZsOTU2?=
 =?utf-8?B?ZGZoL1BkZi9lSVRUNEx3UUxrOEF4M3N5bmplQU85Nk9UcGlwcmJMYkNvc0xw?=
 =?utf-8?B?T3lrUUJzZ0ozWHgvQm8xWmxxNWtIbE9xZHM5amxEQzlCKy9CdVpNdGRLT0cx?=
 =?utf-8?B?TWFsNVBON3ROUW9Xa211N0pLNHYvUFh4UXNQMCtXUjNHUWFQV1pWaStYR2Vk?=
 =?utf-8?B?K1dHS0tvSTk4ZG5ubjdWcDJrOE4rRGxuNGZjaGYxRlNmL3NYNjc1THFYQ3lo?=
 =?utf-8?B?ZDBDRlNGWlVaNU5KTi96L0c4Q1l5UmYzbFk2NWFjOFF5M3U3V2VwTEtvRXVB?=
 =?utf-8?B?MU92bS9JK0ozcXFhc3VvUmE5c2hJczRsdjNUNFhJOWVmS2NXNWlsMmxiMW10?=
 =?utf-8?B?VjhUeElMWWFWR2lhV2o5RmJNS2laQ2lKOUY2R25yMFBFa1B6QzNEcWN6TGxu?=
 =?utf-8?B?UmViWXl4V1E4OFF4eE14K1lFa1pRRFNmMHpaSDNFNHZuZXlBUTJYSnlPa1JO?=
 =?utf-8?B?OWhUUEYwVnhYYnp4b1NUYjVOMk9jL2xmbENzaFZNTjg2WGgydUJBOHN5dlda?=
 =?utf-8?B?ZWZnTVFEL09wRkF1VmJQTTdKVEFjaHB6OFlKMFhkOG1xTjI4VStrUit4Z3pR?=
 =?utf-8?B?MXFidlJ2MXE2UVU0RXBrTnlqZVd5SitWRlhMSE9DS2w4a3RsK3R5RTEzMG5U?=
 =?utf-8?B?MzhHRGVUMjBtb0lHT21zNWhtbUZTcmFZQW1yTXJiTjNON0FxZE9xRjlCUnVS?=
 =?utf-8?B?b2xuUlIxSU8rRnZkbUczUzUrcnlubGdGWWRvTVNYUGR3RHFwSmhTNlZ4S0dw?=
 =?utf-8?B?dUFsOG5lNU02YkpnRFFrUFlVZmYybFk2NFVGamgyQ2xCTFZmQXR2UFVuKzI0?=
 =?utf-8?B?dFJNcWVPRHB4cy9sVXN0UVExaG5ZS01Nc1B3OGV4cEhLZjNhQ2k5MWV0WDFa?=
 =?utf-8?B?dHg2M3o3clBNRVU4MU54djJ0Y2JQRm1FSGhQd0tZVFJoOWhnYVltSTh2ckNH?=
 =?utf-8?B?Sk0rLzNDcUVabUVZc1pIMzNadnFCN1BsV21uMEMxbWNkekQzUWtJWDF4aEZI?=
 =?utf-8?B?U3p2WE01SmtUOE4wcnZSTmFpNURvc2RxVndvM0lnTUlJUmtWTFFVUFUxRUc1?=
 =?utf-8?B?anQ5Njk1dC9qTkVva01lYmRiMmFIdmJTZEJkam9TL1JGRXlIRGYzRnFjNkdF?=
 =?utf-8?B?VEJ2YzE2UkZBSCtnV29hdzZKUGVEcTFSdDI5WVZZdXNqVVIySnM1Qi9Vc2xo?=
 =?utf-8?B?Ui9DRXYwa1IyNUVZdkxZVGMxVi95MFpnNjBxVjJieHduRDEvYmg1TDJ4SzRN?=
 =?utf-8?B?Y25FTVR6czBkWm81azE4RVFRWFlYTDUxSXI2RUZxNjQ5UWNzTnZCbEl2bEJi?=
 =?utf-8?B?SGNTN2pGN0o1ajRaOHZkL0cwbkdFNVJ6emRJbm92YUFxVnZtc2xzZjUwOWpU?=
 =?utf-8?B?dmpnUTFxTjFGaG9HYnVsUXpxOHNRZzEyUEZvcHVWVXo0Z3pWOURxeHc4ekxt?=
 =?utf-8?B?MEphTUZiRVNNMlNYRjdnTlBHcVJWbThEYWpqT25jYjNHelVOMFBlZ2dtUkVQ?=
 =?utf-8?B?c28yZEdmNXdwVUFSMmZyZ0FhZU91Qm9hUFZTUHg2bWthQ2Z3TWFOTTBzakpD?=
 =?utf-8?B?aGMydXlrNnNzUnhicFBydW56M3RzRWpQYmZaNUVwRnBmcDB4SXJwR2RhUGx1?=
 =?utf-8?B?M0tTMnBYZGtNSmE2R2RFYVdmSEFEblU0ZDdLQzJSVmkxa1ZUUEY5eXYydXlX?=
 =?utf-8?B?Zi9kOVFrc3RpTTdISnJVZEdpUzFXSXpuRzd5b3c5U0h4TGFvY09QRkRpK055?=
 =?utf-8?B?eGlyUzVHditEYURnc250aEUxSDNKRm94VzBVZk5QNTIvSjVYakticFFSZWdC?=
 =?utf-8?B?emc2M05ZRXVkRm1QU1RCUkJoYVAvazdLaWlCc0NFK20xZElEendBMzkrVUY2?=
 =?utf-8?B?RU55TDJaM1BqMTJleDZwQnJzK0FLOGhJYjM0Y2hHWThBaUZscHpnd1Nlbklw?=
 =?utf-8?Q?9ibvs9gOMr7ybVzwCTgoZ8g=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6493e99-f992-4bc5-a88e-08db046a1be2
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 15:36:38.6908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YYb3CmsSUSK8TmzyORv0WuVeIVPREnSmAAV2S4oDGBUbXREtR+6X9QsQOYtr6JX+t9kuxdXj5Wjc85HippMVO7do5ZJdDwGAqPgAX8skBho=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR10MB7722
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 01 Feb 2023 15:36:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10561



On 1/31/23 13:20, Florian Bezdeka wrote:
> On Tue, 2023-01-31 at 11:54 +0100, Jan Kiszka via lists.cip-project.org
> wrote:
>> On 30.01.23 12:34, Quirin Gylstorff wrote:
>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>
>>> This will add prelimitary support for the debian 12 aka bookworm.
> 
> I was triggered by the subject of this patch. Why do we re-add the
> bookworm distribution when it's already available in Isar itself?
> 
> Maybe rephrase to something like "enable tests for bookworm" or "enable
> building images based on bookworm"?
> 
>>>
>>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>> ---
>>>   .gitlab-ci.yml                       | 45 ++++++++++++++++++++++++++++
>>>   Kconfig                              |  5 ++++
>>>   conf/distro/cip-core-bookworm.conf   | 17 +++++++++++
>>>   kas/opt/bookworm.yml                 | 15 ++++++++++
>>>   recipes-core/images/efibootguard.inc |  6 ++--
>>>   recipes-core/images/swupdate.inc     |  6 +++-
>>>   6 files changed, 91 insertions(+), 3 deletions(-)
>>>   create mode 100644 conf/distro/cip-core-bookworm.conf
>>>   create mode 100644 kas/opt/bookworm.yml
>>>
>>> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
>>> index f7c8c88..2b9505d 100644
>>> --- a/.gitlab-ci.yml
>>> +++ b/.gitlab-ci.yml
>>> @@ -37,6 +37,7 @@ default:
>>>       - if [ "${targz}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/targz-img.yml"; fi
>>>       - if [ "${release}" = "buster" ]; then base_yaml="${base_yaml}:kas/opt/buster.yml"; fi
>>>       - if [ "${release}" = "bullseye" ]; then base_yaml="${base_yaml}:kas/opt/bullseye.yml"; fi
>>> +    - if [ "${release}" = "bookworm" ]; then base_yaml="${base_yaml}:kas/opt/bookworm.yml"; fi
>>>       - echo "Building ${base_yaml}"
>>>       - kas build ${base_yaml}
>>>       - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${dtb} ${CI_COMMIT_REF_SLUG}; fi
>>> @@ -281,3 +282,47 @@ build:qemu-amd64-secure-boot-buster:
>>>       use_rt: disable
>>>       wic_targz: disable
>>>       deploy: disable
>>> +
>>> +# bookworm images
>>> +build:simatic-ipc227e-bookworm:
>>> +  extends:
>>> +    - .build_base
>>> +  variables:
>>> +    target: simatic-ipc227e
>>> +    release: bookworm
>>> +
>>> +build:bbb-bookworm:
>>> +  extends:
>>> +    - .build_base
>>> +  variables:
>>> +    target: bbb
>>> +    dtb: am335x-boneblack.dtb
>>> +    release: bookworm
>>> +
>>> +build:iwg20m-bookworm:
>>> +  extends:
>>> +    - .build_base
>>> +  variables:
>>> +    target: iwg20m
>>> +    dtb: r8a7743-iwg20d-q7-dbcm-ca.dtb
>>> +    release: bookworm
>>> +
>>> +build:hihope-rzg2m-bookworm:
>>> +  extends:
>>> +    - .build_base
>>> +  variables:
>>> +    target: hihope-rzg2m
>>> +    dtb: r8a774a1-hihope-rzg2m-ex.dtb
>>> +    release: bookworm

Hihope is not building in bookworm as the package 
firmware-ti-connectivity is only in bullseye currently available.

I will remove it in v2.

Quirin


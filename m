Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C5FC6FA8E
	for <webhook@archiver.kernel.org>; Fri, 24 Feb 2023 17:33:22 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.44])
 by mx.groups.io with SMTP id smtpd.web10.24509.1677259993234845687
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Feb 2023 09:33:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=TkGSbIsh;
 spf=pass (domain: siemens.com, ip: 40.107.20.44, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XBfC4EVv+mJKykfC94/h59ertCD2TrRHBVenxw58g8CpKFbQmrqjg7rAQh76j7rRye/3l/Ya9l6OvhUcr9xd9qHLtktMP689BEq/nJtEUoSWFRkkSya2ktpaFy0ykTTigbDyChGT7ymwnPZXB7gQO7ogDsZr/kHCRvKDHe6ttsC4Rgy4KyTiXnQoNSq9GlsHqMYxu7ajyVKvuJ9zgZ1vT3qXgdI9/LxuYo8MtgXVJM0ALd9LqAAxeb8uHbX5R49vZ8NG6Qg3glBvPSaay70XSSNKvK8QkWEOwuD1y6czsESQC54e3CA1iW2dBF88dKIkNcQRwB5jv8oxRdRU2g1ekA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZqIP5lpwRzS72W1xNUvlC11GY39BWEIrPulrBlxvVUQ=;
 b=gsuSSqqhH+SI39ar2jbzOi4+UMmROM3CeJmOLF3aA0S1Xrcm7L3/KM2BCx4ZiATYfID7EoMSOGPHcquTjQ+Hpd2rxUjmv8BfX+LIntCSWPVURFYxOK14+rlDJKdESFDEuoIZ5zElh1I0ENmhYVcDmfP5Ivyd4cY1eqA2nbjFQQ3XBgbFIv6CRz9brHQnuEifCa0vWMyDJ/xe+9nBKNOCNxDVH0lChM0CuxZE0mXy1vl8CfUD9Nx8r5NRTpQINgS916jgkSJGDboXkNXSlM1hzYZ/g9WEk5E3XY6jU1u8LvlSVTgbrjS6ydMp8xHJcFJpQ037mwpRo6W0bfdHm5tEHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZqIP5lpwRzS72W1xNUvlC11GY39BWEIrPulrBlxvVUQ=;
 b=TkGSbIshMA3YxBGLre9Aw4wtBNg5QQV05nBFd+Sxg51SJriK+XSBqA4Hle8TdHQtpOvozbmNVGQOXfcABU0ba67c7CSaIMeEZFT5ouISadpiPfmiGIpbxSNF7BooYvpLkgMvzI+Bzzqu3zhYRUZfQldzvDXOu5rGMn1GaheCYF2xzQmJCzr6hKGtN6jI0iXqTacJ4EEjAwuTEeIiXvT4mkFEDlbvAfzplrpl0hNcV8sm+A2U+C4/wmwebzanYMEGBd7p6dppzxGsQxmqIEoFqg3rF70syjab5FHS0upyyRtsG/Gg82WdwOGiGYNEb0dZ6p6XLJYG+x05OMfsRRMn+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7321.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:607::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.24; Fri, 24 Feb
 2023 17:33:10 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%9]) with mapi id 15.20.6134.024; Fri, 24 Feb 2023
 17:33:10 +0000
Message-ID: <ed126894-0705-b0e7-531b-38f94c8c709c@siemens.com>
Date: Fri, 24 Feb 2023 18:33:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [cip-dev][isar-cip-core][PATCH 1/3] Enable Images based on Debian
 12 (bookworm)
Content-Language: en-US
To: "Moessbauer, Felix (T CED INW-CN)" <felix.moessbauer@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 "Gylstorff, Quirin (T CED SES-DE)" <quirin.gylstorff@siemens.com>
References: <20230217152556.516948-1-Quirin.Gylstorff@siemens.com>
 <20230217152556.516948-2-Quirin.Gylstorff@siemens.com>
 <fc752ed24f849690fdc2ca48b7ffd2211697c66b.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <fc752ed24f849690fdc2ca48b7ffd2211697c66b.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0046.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::26) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7321:EE_
X-MS-Office365-Filtering-Correlation-Id: c07c787b-9877-4ed9-c03b-08db168d3290
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	e1AA2GcE9izvb8VvhegAfnqsgxGLhPoMa+LMUB2mqg3cXt0xwW15/7A2a0araA++ijigWja/Xu7TLAMucPOfmt5Z0N7/I6FT6FXweCl8zAAKK5wmvN5Rn7GPbqCBrBKxgYJXGyY6nboRjE1edUvL+LFG6bvhDIi7wEjZeqQ1QJpGoA8vv557AI5rADtsQWC06dLZF7iXWkVZpk9XoXJiluqh58mSrJC0ZKEcrBXSibxWTwNSXppFbcFz8FN5R/kG9UtBiy9UyDyUq+03z1SBtKPrA3spZr2Htw6pF5gpH0P/BOtAnFbCe3v7pU31Z+yhp9DTKH80r0E/Y1ExQkCRiz5qSOkp8X1ZtSjvDbvJ+bvemHBvLYcaRRuZ+vScgEK4YRGvhHEVZJHUgbRQ/Uhjthj6NQpgGlGRzP1eIiLxFNnhM6PArmPzxeKo7En6rk9TVlYC/BxMhfoxG80phXvIXaTM1Fgfov7chJmPeq5L6u7wKPupICBWXEoSfkfqj0CY4T8ya6qbsiMy0IQoEguUNEUIgs2DvTzBgJCQUZTiZKbIziCYq3K6h7lGOitGIvFliuVtd3IlrNxvAdl6Hee3p4OnMQTmOm2hqXdspXPoGhFF0WF23L0Cji6x4RqsmK9V83mPWp54DqYXr049eHf+DPTrqBjhZ2EnjxQgOwna7zT58PzLmUCMFCo/SDV9iqlY3cbqk0XZokPM5/N+sGiFmKSTtlqdG0wiAl2ZP5oOhyQ=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(136003)(396003)(346002)(366004)(451199018)(66899018)(2616005)(83380400001)(6512007)(6506007)(26005)(6666004)(478600001)(53546011)(186003)(82960400001)(31686004)(86362001)(31696002)(38100700002)(8936002)(41300700001)(8676002)(44832011)(5660300002)(36756003)(2906002)(316002)(6636002)(6486002)(66476007)(66556008)(66946007)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UTlob2xzeWlwdWVwT2tCS2NjNFNLaXE3bittZ2N0czJLcU5uQWlwWjRKOWxk?=
 =?utf-8?B?TEhZcHZwQWFQV2t1YlVjNE45dS95cGhnTUpvdkUzU2NheTVNdkpSMkNDZ29a?=
 =?utf-8?B?RS9GTjFFaWpPVSt2c3U4S2tOb3NrdEZrYjl3WU91SHBIY1R4LzdkbTIrdU1o?=
 =?utf-8?B?WjIyUzVYWmgybnhmTVNjWXRUcXludVB1S2xFSFpmRm9QZnlraGpwcmJnK1Nk?=
 =?utf-8?B?RzI5NDB2a0dtbUh6TXhDS1ZjUndnTmxrM3ZTT05rYzhDNkdZWklDczBJVE9U?=
 =?utf-8?B?aTlUY2ZqSVhKOGhnWS9ha2gwMTVjY0tkYnJJV3BmVWVQbjhsODZFYXpkMmlT?=
 =?utf-8?B?ck9mK2hmajdJMkpaTFk0a3VIQkJFVENqSERjU1RJTk5vT1ZZYS8reEJDWTB5?=
 =?utf-8?B?YW85U2tJUlNUMmNKc1J4ZFFsb2gwbzhPamhTSVk1ZzJRc2I5czIvdkhOYWRO?=
 =?utf-8?B?dXJ6K0ZsQURNNmZCS1JjbURrMXQyd1pqNEFTMEFMVnF6dzVOVldHcTlrTmVp?=
 =?utf-8?B?anZuWnpzaHI4eGZ0a2IyRDl3bjFXdnhoWmFDTkxib2dXODhYU1gxc3oyNCtH?=
 =?utf-8?B?Zno3dnpaR0pQbUcvTE95c216NVU0WE42Y2VBS1IwTGVtMnZCLzJnTWNLM1ZJ?=
 =?utf-8?B?T3BCMFFsOEJaTlErQmxDNFBMVGZLWDlDN0lXa1Rxdm9NK29NWG82elp0dEVD?=
 =?utf-8?B?NEZHUEdHZGVGM1locWRBMHZSK09JWTBIUm1yU0pDQ2hRbmREdzdaN1FHY0FZ?=
 =?utf-8?B?bnBTY2ljM3o5V1N6N0ZTV09FbElQL0R4Z041RVBTUzNxd1l6RmNTNTFHQ2c0?=
 =?utf-8?B?SGFsNUtJSzV3VktENEo1dlEvdS85VDdHcFUrZFBFUjZzT2pMTlppSVdUSFlv?=
 =?utf-8?B?d3FYb05SdGw4YStvd3l3RTN2WE9vVWxJTzVkT083MktrYnFkUVI3RENxaEFj?=
 =?utf-8?B?U2tIVklwVSt2aGRqOWhjUm16NitGVmtEaTJua2lGMWV5ZlcyVmFiK29lcWs2?=
 =?utf-8?B?Z0huR2tYYWsxUnovNEl6Qy9zRExsWFpnUkNZbVJuelE2cHJPM21rUWhJV0VS?=
 =?utf-8?B?RDErRzNLMDltQlJ1Zmh2NUdhUlNWQXdmRVl0VDhPVytyR24vR3FUN3FjaTNU?=
 =?utf-8?B?Ri9ERVROTk1OU084RzdnMlZCek9tRm4xMmF4UlpsSTVDalVET3hkS2FZUUFr?=
 =?utf-8?B?WU5TTFg3dS9VU2g4WWlXZkozTm5XMnlnanNzSkNhUEVzNUpFTUN5cUNTWUl0?=
 =?utf-8?B?RDMxRVZBOTJWdEFxNkVpaE1wbC9lQnRJUFF6ZzMyQ2NRWEV0cTdsL3lUejNv?=
 =?utf-8?B?ZFp4OWtoN3RVM1IvNE4yWEQyVFV4VTR1V1VrZmZRTkpjMXprWkRjTldKcEhy?=
 =?utf-8?B?ZGNMa2tJL3RMK2RpUGE0OFM5d2E3R1JZTHpOS0srTFBiTXZ4U1UvZkJCOUd0?=
 =?utf-8?B?NWxmV0ROVWhMK0R1a09vK1NJTkZOclhFOW9WSzYvcVdYYmd1cmxjNHdBLzJk?=
 =?utf-8?B?aS9ZRVprR3RJYjNiUjRyaUZMc2ZPQUJEZnFselg3UkUxWTIyY2kzRlFkTDJ2?=
 =?utf-8?B?RXdyaFE4UXV4ejB3TDVDZmQwbUt2Um5TQU5QMitIRVVZWXQ4Tk1BU3IvQzdq?=
 =?utf-8?B?YWliS1I3R2tnV2FWQ0xmbEtkMCtsYXo5MlVBYUFzaTVwY2QrL1p0NEI2Nk1i?=
 =?utf-8?B?TVdxSW43NUxYVUp5V2wwV3hhVmRMYXhLZnczREUzUTdMZmZKNFJUWVE2VFBp?=
 =?utf-8?B?TEkxVElYQVJNRFNidzI4OFFhOUIyZWVrWjJyS0NWTXB4R3VjVFNXNnNBRU44?=
 =?utf-8?B?RFFqZFRCZFpmZ1NFd200MW82R0JYOGJkaUc5OXYwZ0VxSng5RDJRdGszcFJl?=
 =?utf-8?B?b0VrQU10b3NuZm1pWVQ2aW9TZVgwM0gzV3RxRTU3Y1BQNjY2aEp5bE1KT0Vo?=
 =?utf-8?B?aEdWRlBFcFBnakhNQmdvSU9KQVFjTU0wK0FSSlVIVHlQYWVGMHlMU0pxNmMw?=
 =?utf-8?B?c290YzVOeSt6WGl1RTVaeTk5S3RDcXlCd0hOUHR1QUR3N2tPU1p5ekNrMloy?=
 =?utf-8?B?eUJ4RWx5dk9vYm1xMVAvZUhQYThLeGxRK1l0blJNc0ZkWWx3SUUxOTZiUU1L?=
 =?utf-8?B?b044a1U1RWplUDIrc3Y3N1BmQ2dSSDkweVVoTUZJenBaNjNobHR4ckwrTDIw?=
 =?utf-8?B?Nmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c07c787b-9877-4ed9-c03b-08db168d3290
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 17:33:09.8697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8wSRthlaJSGgQD4tseLqOLbip0Hmh2T2tBYJ6Yi5YqvONciOByqPh78xx9Nevl5xNGC3A7ibWZejktD1rEXaGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7321
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Feb 2023 17:33:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10826

On 18.02.23 08:56, Moessbauer, Felix (T CED INW-CN) wrote:
> On Fri, 2023-02-17 at 16:25 +0100, Quirin Gylstorff via lists.cip-
> project.org wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> This will add prelimitary support for the debian 12 aka bookworm.
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>  .gitlab-ci.yml                       | 45
>> ++++++++++++++++++++++++++++
>>  Kconfig                              |  5 ++++
>>  conf/distro/cip-core-bookworm.conf   | 16 ++++++++++
>>  kas/opt/bookworm.yml                 | 15 ++++++++++
>>  recipes-core/images/efibootguard.inc |  4 +++
>>  recipes-core/images/swupdate.inc     |  6 +++-
>>  6 files changed, 90 insertions(+), 1 deletion(-)
>>  create mode 100644 conf/distro/cip-core-bookworm.conf
>>  create mode 100644 kas/opt/bookworm.yml
>>
>> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
>> index f7c8c88..311702f 100644
>> --- a/.gitlab-ci.yml
>> +++ b/.gitlab-ci.yml
>> @@ -37,6 +37,7 @@ default:
>>      - if [ "${targz}" = "enable" ]; then
>> base_yaml="${base_yaml}:kas/opt/targz-img.yml"; fi
>>      - if [ "${release}" = "buster" ]; then
>> base_yaml="${base_yaml}:kas/opt/buster.yml"; fi
>>      - if [ "${release}" = "bullseye" ]; then
>> base_yaml="${base_yaml}:kas/opt/bullseye.yml"; fi
>> +    - if [ "${release}" = "bookworm" ]; then
>> base_yaml="${base_yaml}:kas/opt/bookworm.yml"; fi
>>      - echo "Building ${base_yaml}"
>>      - kas build ${base_yaml}
>>      - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh
>> ${release} ${target} ${extension} ${dtb} ${CI_COMMIT_REF_SLUG}; fi
>> @@ -281,3 +282,47 @@ build:qemu-amd64-secure-boot-buster:
>>      use_rt: disable
>>      wic_targz: disable
>>      deploy: disable
>> +
>> +# bookworm images
>> +build:simatic-ipc227e-bookworm:
>> +  extends:
>> +    - .build_base
>> +  variables:
>> +    target: simatic-ipc227e
>> +    release: bookworm
>> +
>> +build:bbb-bookworm:
>> +  extends:
>> +    - .build_base
>> +  variables:
>> +    target: bbb
>> +    dtb: am335x-boneblack.dtb
>> +    release: bookworm
>> +
>> +build:iwg20m-bookworm:
>> +  extends:
>> +    - .build_base
>> +  variables:
>> +    target: iwg20m
>> +    dtb: r8a7743-iwg20d-q7-dbcm-ca.dtb
>> +    release: bookworm
>> +
>> +build:hihope-rzg2m-bookworm:
>> +  extends:
>> +    - .build_base
>> +  variables:
>> +    target: hihope-rzg2m
>> +    dtb: r8a774a1-hihope-rzg2m-ex.dtb
>> +    release: bookworm
>> +
>> +build:qemu-amd64-secure-boot-bookworm:
>> +  extends:
>> +    - .build_base
>> +  variables:
>> +    base_yaml: "kas-cip.yml:kas/board/${target}.yml"
>> +    release: bookworm
>> +    target: qemu-amd64
>> +    extension: ebg-secure-boot-snakeoil
>> +    use_rt: disable
>> +    wic_targz: disable
>> +    deploy: disable
>> diff --git a/Kconfig b/Kconfig
>> index cd24ce2..87056b9 100644
>> --- a/Kconfig
>> +++ b/Kconfig
>> @@ -128,6 +128,10 @@ config DEBIAN_BULLSEYE
>>         bool "bullseye (11)"
>>         depends on !ARCH_RISCV64
>>
>> +config DEBIAN_BOOKWORM
>> +       bool "bookworm (12)"
>> +       depends on !ARCH_RISCV64
>> +
>>  config DEBIAN_SID_PORTS
>>         bool "sid (unstable) with unofficial ports"
>>         depends on ARCH_RISCV64
>> @@ -138,6 +142,7 @@ config KAS_INCLUDE_DEBIAN
>>         string
>>         default "kas/opt/buster.yml" if DEBIAN_BUSTER
>>         default "kas/opt/bullseye.yml" if DEBIAN_BULLSEYE
>> +       default "kas/opt/bookworm.yml" if DEBIAN_BOOKWORM
>>         default "kas/opt/sid-ports.yml" if DEBIAN_SID_PORTS
>>
>>  comment "Image features"
>> diff --git a/conf/distro/cip-core-bookworm.conf b/conf/distro/cip-
>> core-bookworm.conf
>> new file mode 100644
>> index 0000000..de2e435
>> --- /dev/null
>> +++ b/conf/distro/cip-core-bookworm.conf
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
>> +require conf/distro/debian-bookworm.conf
>> +require cip-core-common.inc
>> +
>> +PREFERRED_VERSION_linux-cip ?= "5.10.%"
>> +PREFERRED_VERSION_linux-cip-rt ?= "5.10.%"
>> diff --git a/kas/opt/bookworm.yml b/kas/opt/bookworm.yml
>> new file mode 100644
>> index 0000000..8b4431b
>> --- /dev/null
>> +++ b/kas/opt/bookworm.yml
>> @@ -0,0 +1,15 @@
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
>> +header:
>> +  version: 12
>> +
>> +distro: cip-core-bookworm
>> diff --git a/recipes-core/images/efibootguard.inc b/recipes-
>> core/images/efibootguard.inc
>> index b3fe911..bb1aa1d 100644
>> --- a/recipes-core/images/efibootguard.inc
>> +++ b/recipes-core/images/efibootguard.inc
>> @@ -10,6 +10,10 @@
>>  #
>>
>>  IMAGE_INSTALL:append = " efibootguard"
>> +IMAGE_PREINSTALL:append:sid = " efibootguard"
>> +IMAGE_PREINSTALL:append:bookworm = " efibootguard"
>> +IMAGE_INSTALL:append:bullseye = " efibootguard"
>> +IMAGE_INSTALL:append:buster = " efibootguard"
> 
> This will have to be reworked once my riscv64 patch for EBG is
> included. By that, only bookworm would be left with a stock EBG and
> also that is probably just a matter of time. I prefer to always build
> this component and use PREFERRED_VERSIONs if required. This mixing of
> custom and upstream EBG versions is very hard to maintain.
> 

This looks also strange to me now. Won't we get IMAGE_INSTALL *and*
IMAGE_PREINSTALL set for sid and bookworm?

I will have a look if we can merge patch 3 already, to enable CI, and
then I will look into Felix' patches first.

> PS: the sender of this mail looks quite strange:
> Quirin Gylstorff via lists.cip-project.org
> <quirin.gylstorff=siemens.com@lists.cip-project.org>
> 
> Don't know if this is intentional. But it makes responding harder, as
> the sender is not included in the "To:" field.

This is caused by the required rewriting due to DMARC. Therefore,
"From:" also in the commit message. Interestingly, I'm not yet seeing it
here.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux



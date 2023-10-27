Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0019C25B47
	for <webhook@archiver.kernel.org>; Fri, 27 Oct 2023 13:43:46 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.86])
 by mx.groups.io with SMTP id smtpd.web10.7260.1698414223709522352
 for <cip-dev@lists.cip-project.org>;
 Fri, 27 Oct 2023 06:43:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=C8zmpBkh;
 spf=pass (domain: siemens.com, ip: 40.107.22.86, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IQDf3Am8S59KH/InADI8dACXPMwHht/uGRU6XGBN51tW7WVmZqY0gdtEE53wQF7Bp5awNRoQMeMi9rACqprjK/Kpy2z9FaoHVajZBH3LHidyADSqOBIrlb0oy4SQfYEY2GiuqmkfljmWmJaqpqOdylKVNZtaicHqX3w23qeY3zmAjgpmdNj3BEJ2/yEvAsyyng5TyKAK1dlkHt0m3Rnsni9j/7hqps2M8PXRxkOh5Sbua3QIFyCwy24oqWdi90Mvrtv41hgH/ZVSUOWcmdhQgZqt9B15qTwVqKMkVPSVTvhx+vKsYTe6jSCUAOutIZkb2GJDtj7d3iIfU4XMvHqUvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UT+5dzax+Np5uAiT5twLSNp0oZrFyMtoU6/M5q2tKc8=;
 b=hJvTveElgFPcRRAy0obGbcd+N18fDx7PvJ2O2OGoOyJqB51Ad5kFrhOOT/DiKRGxZ0jNtnqqlQzA9V4G0kcu1dNOJPnEbFcPYO2Ahq/yMWg2+OTIr2WxyG8CF5CFL8B5I0hcquJG92xrNuj9JP4ZFNG5wy0cvSBRPyD0ulc0Ql3m1026H3T5aNRMgkTxfmlaHd3TlBoPKkhFd11naxLPrsx0bM3ziYzh9boRJhSjVBZsWIMXhjCJ63/nEY/PjYefjSe04cIYvI6hRTVMQ0ciKBflNg+5iOnfzrfTx5xQ8lr68EOudK+eRnuvLr1HWCbnJxM8xY4JqS/byitswk1ezQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UT+5dzax+Np5uAiT5twLSNp0oZrFyMtoU6/M5q2tKc8=;
 b=C8zmpBkhjVD4vrCropRPjvRHGUu50p2rgftBm2MIsIu4N0TzJ1TpW4X+ZYe2nsr40cqNOV9CUezeGKkcEif13Crto3Y6q/vJcEgf9/3vYkByJ46/VXiDHn9Y6N8x+USAyunwHTCR39mIGmhUbxbICxdC3YCSDo8hDc/GC4yakJJuyDy/pSXrFMG3wZDibRYajC/eG5++b7/vJS/eMgO1x9LC4Hit37oO400hmYIob1WvfesCRhbDbuLwuqxTNDPoJ94GlUL1JBOxE6wDIqctcJVXpo6Kg5GNSkYj6MSyGZKPNtLTFwzQZBmKTRnKZYEoAVWw6og1YP9svv42e+hPTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB5942.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:51a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.23; Fri, 27 Oct
 2023 13:43:40 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ce06:5d24:9896:669c]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ce06:5d24:9896:669c%6]) with mapi id 15.20.6907.032; Fri, 27 Oct 2023
 13:43:39 +0000
Message-ID: <e522085f-7a17-49d3-b4d5-61a01c847ebf@siemens.com>
Date: Fri, 27 Oct 2023 15:43:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core v2 0/3] Enable swu file in repro tests
Content-Language: en-US
To: venkata.pyla@toshiba-tsip.com, cip-dev@lists.cip-project.org,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <92324ead-e15c-48fd-876c-41398d15a956@siemens.com>
 <20231026082959.16939-1-venkata.pyla@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20231026082959.16939-1-venkata.pyla@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0113.namprd03.prod.outlook.com
 (2603:10b6:610:cd::28) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB5942:EE_
X-MS-Office365-Filtering-Correlation-Id: 6df841bc-3e9c-41a4-1260-08dbd6f2ba21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	han6P4YUWLM7iCwCRlq5UkQLZdQlZMI8E1JzO7VMMycX1A5qyoZcRL/+fDpYux1pr0HgBJw8PtDikoZstb+Sz3mprD8vlvxmLW8Io84ddyfc4trRuoMnXgfJFH45GS4kZlBQvKO+Nb9hAiFPKIxCGo/x07u06NR1I6JMnpxSHjNj871kIa9z1DDe+6rnOV+45dXr14s0aEHjHYM+heOaBcu0xkI4qJzhKGfr2FdE5xqu9HFtwBsP7FX0aO8XGNyod9P7OcIXDtpaeyFvwY9aT6BTnKE0or0ugDWNg+eMiPlvkBMPkvVYuksloMbajTp4//t8Za1phQfZAvfFMImssoin9V2LoqOIUOGKCYX0+TSXi67Nv/Yz56fk34FK9nWppAbvcE00dTkCuodoXwXIg+NFxlwqCGhFIWsRPi/68F4NCAvmrHg0KYzrY/8+lI5qHaWOxbLiC3BC3gH0UqpZJjJBujkJR2AIXcFe0mIcR/reExtb04YzC5NfXFQEaQQ1TYx3A3A8OlA/0AbDzcWfqdkGxiiIxc2rY94iIUxy5/vhmbSbbLjXNmXyK8bqn6qkEMdboZG3jbTtDYV87Nsxihjn4cZecyYMA9DovoJSqjmdAwB64Ppn6AJn3Pbhlihub9AMAHhaP3s+eoyFtWm21g==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(346002)(366004)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(6666004)(66556008)(66476007)(66946007)(37006003)(316002)(6636002)(82960400001)(6506007)(53546011)(38100700002)(6512007)(4326008)(31696002)(6862004)(8936002)(8676002)(26005)(5660300002)(4744005)(6486002)(2906002)(478600001)(36756003)(86362001)(31686004)(83380400001)(2616005)(44832011)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QzF6NmpTZjNRbEtOYURPZm9qVWRGK1pybUVuQXlrRWw1TGVEYTVRbE9udUZN?=
 =?utf-8?B?N1ZLZ0lJbzJtUnM4dWVWNDlXdTEwQVFRc3Fqc2FWZ3F6b1ZtbnZyRHI4Tksw?=
 =?utf-8?B?a2hHanliZXFwQytGYTMyemlrL0x4ODRDR3kxYjlpK1J3UWl1eGpEK0xGVmdE?=
 =?utf-8?B?eTJ1aGsxakUwWSs2WW44NGhUeUdmYWtaUzhUY3FUbUdmSXBvSlRMNkp2eHZ5?=
 =?utf-8?B?dy9PcUZrTDVaRThUZ2llSDM0L2hnaXBJdjhwcVY3T1pvMEdpanFzakxFUWY5?=
 =?utf-8?B?Y0NUOFMwSzZZTVpScGtockl4eVQ2OVppKy9mb0xpampqZk1wd1gwWEtJb0dt?=
 =?utf-8?B?RXIxTzAzazdQTW4wQTR3VGoxRVMrbmFTaXFCeHRvK3BXZkJsa0h3OUZwVGNI?=
 =?utf-8?B?cWpEbjNTeUUzYnlwN2xHK2JmNU1QaVlyeEhXZTMvNmE4bmc1MHYycVNEM0s3?=
 =?utf-8?B?TkI1OXR3TXJwWG1tcGZEMmp6N1I5a0s4OGYvODJSUDhkM1c3aXlGRlBwVFVX?=
 =?utf-8?B?REV4bGtkejA3M1lJWmMxbEJoekc5Z2ljb0xJMlcwTUZMcFR1OWRJR1o5R0N6?=
 =?utf-8?B?QU9pOXQ1elBPUUpUdk5hVUZaYmVoSW5xbW5XdFM0WGN4ZnBZUVNYZ1psNzJM?=
 =?utf-8?B?UjBjRkRpMDdFUVJkQmQ4eTZyaTFkUE91cnNtWGYrUW1HbmltN3N4NytMbWZC?=
 =?utf-8?B?UWJNU21kVFBmdlU2VEVkTmNBUy9jWWJxNmxmM3VET1RoYUgrRktOMEdHVUxE?=
 =?utf-8?B?MHFIZm9leXZQRWRwN2o2Um9iVEhnRmdKKy80VXJ6NUZ6QUI0UkNRVVJ6UUF0?=
 =?utf-8?B?UVFybm9IbDNnOEJxd2pOUDVqanJYMlk3RW9BWkJZd3hZYUNwOHgwVmpERkdi?=
 =?utf-8?B?bTdKT3dlQjhtYUEzWUdvOVhOTGJJbWo1ZzY5R1h4Q3htNWN2Ui9RbktZck9D?=
 =?utf-8?B?Z0oraWFYQ05PTjVkU3NMOXFEVU9DS3k3TUtBUi8yaTI2ZjBSaXFIVG5jS1BH?=
 =?utf-8?B?and1RGlXRGFOWmNFaEEvMXZHeEFGV3FmRkR5MHN0RXBRTmRtWjcwdmh6clF2?=
 =?utf-8?B?MnViT2M0c1JoRzR5RlloMmV3NE45ekRvTDRCSXhKOXlacklWNlNzVzNJYXpu?=
 =?utf-8?B?cE9HTzhIT2tZUUY2Z0d3d3NxL0lvRlczNnBrS1FNYjRWS0tpT0Q4d2FJcUdV?=
 =?utf-8?B?T3drYTRtSzNSbC9vZnp1Nm1ON3Q4cjNxOWc1ZFV2Z2JLZysrMTR3SDBvRjJ4?=
 =?utf-8?B?VTZIUS84M0NvMjFKNjVLTlAxY0lZNGsyeDkyRjl0UThaaTJwNGk2VEVBVkxs?=
 =?utf-8?B?UXVheWpmOGx3Qy9GOVc3dE1CczJocWNqS3p4Ynh5WHNLdzBhcFFYelJJNm5Y?=
 =?utf-8?B?ZXlSZlloSjU4bnl2YXFraGcyeG9YVU9GUms2ZE0rSXZhYmhjUk5JYTZtMTBV?=
 =?utf-8?B?ckEwbnF6UlMxbnFvRGNkTlFwUlVLUGFDaWY4NXZmRTZLSm5kbFk4aGJyekIx?=
 =?utf-8?B?YjVXNXZ3OWVadUhacW9qQUN6TjJMY1FpSFFsWkM3dGQrQW9LaDJPSGV5cXlH?=
 =?utf-8?B?WWZ6Y2hiVWhCT1FaOHFBRk03VUhaYklicW9waGZyUkwrYkZEOTN6T1FwVTlE?=
 =?utf-8?B?b1RJM2dSZEFmQkdEbDhlQUdBd2F1WXVMeTZDYjlEckhMK1JtM2tTb25zWmtZ?=
 =?utf-8?B?OG1saXIyRVZ4bjNnbVpRV3NiQUplY0E2aEY5UU9oWmFXTjNRUjJKWTRhWlJR?=
 =?utf-8?B?SXpHR3Ezd3RKYVl4djV6Q0k3dDhWbkVJK1IyRW5ZMGoyOUJUbHR6VVBmbEZN?=
 =?utf-8?B?WFhlOGxvSUJ5cVREbElNZ3BQMVE0MHNnVlg4RnY5Uk1Vdkc2YWdqTWt2aVZG?=
 =?utf-8?B?emxXd2xKM1VKZFBrendPbzF1ZGJtWERYQzNPOS8wSU45MGZ2cDBHdXE4cXFq?=
 =?utf-8?B?eWhFdE16SmlNcXVJN3A0RjFNYW9NVFFLd1F6MStHY29xSThzcjN6bUszeDdo?=
 =?utf-8?B?anQzRTB0OWNUZThLSGtZOUpYcnlUWHB6WWNDOGQxUHVKSkZGNWdMeWt5eXRs?=
 =?utf-8?B?Mm9ZdXR4TFduUGJZQVV6ZzM5SGtFRlkveEhHc3NSZEh3TkdoY09pdkhlS1Yy?=
 =?utf-8?B?T2dsVGZHODhxeTIwT3hqdThZOEZYeEhmYUZuUzJuWVpFTEt3bEhXSUcxT00v?=
 =?utf-8?B?ZXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6df841bc-3e9c-41a4-1260-08dbd6f2ba21
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 13:43:39.9080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: efQNvTTGbrax/x8AAAESbyhngfKRSDc9ydXbpJaTvjxGP6CEmLuRa3rEHHkprbJh8fnReTR6tUHibTwmLQgjWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5942
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 27 Oct 2023 13:43:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13480

On 26.10.23 10:29, venkata.pyla@toshiba-tsip.com wrote:
> From: venkata pyla <venkata.pyla@toshiba-tsip.com>
> 
> Hi,
> 
> The following path series enables SWU file in repro tests and fixes
> repro problems in swu file.
> 
> repro problems in swu file:
>  - signatures in swu file is not reproducible #80
>  - linux.efi file in swu file is not reproducible due to file timestamps
>    are not matching.
> 
> venkata pyla (3):
>   reproducible-check-ci: Include swu files in reproducible tests
>   swupdate.bbclass: make signed swupdate file reproducible
>   swupdate.bbclass: Use root privileges when creating swu file
> 
>  .reproducible-check-ci.yml | 1 +
>  classes/swupdate.bbclass   | 4 ++--
>  scripts/repro-tests.sh     | 1 +
>  3 files changed, 4 insertions(+), 2 deletions(-)
> 

Looks consistent to me. Quirin?

Jan

-- 
Siemens AG, Technology
Linux Expert Center



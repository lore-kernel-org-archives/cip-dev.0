Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24449C61D97
	for <webhook@archiver.kernel.org>; Fri, 24 Nov 2023 07:16:25 +0000 (UTC)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (EUR01-DB5-obe.outbound.protection.outlook.com [40.107.15.54])
 by mx.groups.io with SMTP id smtpd.web10.130764.1700810175040459992
 for <cip-dev@lists.cip-project.org>;
 Thu, 23 Nov 2023 23:16:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Y9rTldQV;
 spf=pass (domain: siemens.com, ip: 40.107.15.54, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KQQo96PLJXGFbYTjPvfpnC+ugex4po2YHR1S58ROHBKVY1/qWYcHIazRu+F8p0Ej1F+CuoRWMAQcVYZPyn5SQBaBzTmvWzoH1PLKRUOszxbVou1YgIMdf4efhrNcFKZh27eQtwluTxcQe3S2qsxFPcyCNDfXlmUX4537o5KLzO2hzYvHdEJdNSWwQdqd/mY9Nm0LUvE70/ApHBWxvXkZIrxCLSALDgPKKUm1zYRf8sMtNydWD+w3MxX4SeTclj402RdrQQ0fAfDYGbmgyTcgdjS5Bf6pBBrh9UWcwkLT77SkC+agbWdA79xiZknkTnwCJgXt+9n+j5d4c0x0jswL4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XxH1kgAOk8dktrE2ecsNmAzK5BkVxxGrP36Ji9tJnWc=;
 b=bqZnbLK2sKdjC637OdggPJCBSme1KsuLjaQlDDOMzTUERam92HW/jVjdPhNQ6rdj3g1d9ajVGh4/ggBOEM9DGWT62sKHzqw1jC6QXvoTBPWId8GgRPmCk8HeyOQOnsNWx0ZNGiH4Q7CU9YW5KDGJiIOXoC7i51v9UrNlYQuy82dZivfkwl3G5dVf0MQABk2kjaNT2oYMl8XEIlfjRqNL8FbjGNm9x2uthdIvIwCRhnJgUW8ADvn3Y+YwqkllzPcKbXsq2yvwD4acXbwiHZJVRKlU6xz3W3lBoNxdAdNUTZdydrcFNypZ5+fx0gEMv3i1Zi5bjQd9ieFzon1UX4L4OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XxH1kgAOk8dktrE2ecsNmAzK5BkVxxGrP36Ji9tJnWc=;
 b=Y9rTldQVGpUQYIkO5rn869b2dH+Gmi7XUshlE/2Dyqcr+E7PAG+0tXEp41Up54MYZgXFPFk2ny5cGps2oMRC7np1Y0HMSGU0lzhx8WwLtsIpS2Rf6QeH/WMX8XqMNrYblzAKvHBWxheGFXz+B4r543LRc/b17fnpqq4ftdDF7IYcoSc9IDgA9VI8RqtWfeX+LNZ1/Qisac9IZsWzcKSpCcjJsDTCgwMxPVvKD2wRDFIKacz1n/439og0PR8QieR+86Fn3X4JtPa2DtwTvaK2vriyROFTt5Gxl0jZ5tlIj74A2pZR1MO7eOgUPoVo4PTDqA10EAtOyx8VLvh3d066TQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7135.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:61d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.21; Fri, 24 Nov
 2023 07:16:11 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7025.021; Fri, 24 Nov 2023
 07:16:11 +0000
Message-ID: <2eb2c44b-01b8-4f30-aa2e-2d66e889a421@siemens.com>
Date: Fri, 24 Nov 2023 15:16:04 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core v1 0/3] Enable CVE check in isar-cip-core CI
Content-Language: en-US
To: Sai.Sathujoda@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20231122070121.326276-1-Sai.Sathujoda@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20231122070121.326276-1-Sai.Sathujoda@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0129.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::33) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7135:EE_
X-MS-Office365-Filtering-Correlation-Id: ccfa5cb2-c452-4bf1-f7e9-08dbecbd3ca2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	c1YEp5GpuQqY25yFVNwOyPY3423sG8MIpP9kHXrFPuY6YUzMFqmPfIhRsUGjgb8yrzfT/9MkR7YNVdeYWboEJxrc5psHpI1P9Tf0Po79Az4OBzWhJ6L3zSZ9CgTme1dsU9aWZZOPOcaWIEaHeU+rrABfAHmRbY40xg9fZas29ssX8vNk1++fB1jw/L0Q/xQX+ki/0oECt2kRE3bOmDmKsgaWIyu6K5s5CaTG+FS1EXpEXcEuyWTkr6N+sNF4HsJqv6fEQ6y7l5TIUe9EUaYs6mBSbhLqhlrQZAmmJD6bOVF0xes1w1D3h57mQO3q8XCC2JNe4lxYJYHIv+abwFMp5SgDeNJCON1DpEAVRP5Mc9rYQLUG5KVE9/762dRvbMKzMK3/udja0Evf18Zc2BJLQB3gDfRfcjuMOU02ywmk0ID/rd3kH7Ro0hw+oiqSNYW036KKM1ER8r45tr9VYem8zMg01Th+7EcIPN09uuNxpxzPcQn3YzjJnkhNdXMiHhrJ3s9ZyB1a8r2+SSdNS3rOaUn5EXfalvWQje3c+qUbzHCzx8DB6v+/QYxyfTutZDpo1ikhJEl0hySlcrcv6Zt7SFbkjgsNG7GhZ77PJWENOFyOHpSTbgWAsCFmyJfWJhwyJyiUVQTUcANI15g6Nkd8lg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(39860400002)(366004)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(2906002)(5660300002)(26005)(2616005)(4744005)(66946007)(6666004)(66556008)(36756003)(66476007)(6506007)(86362001)(6512007)(83380400001)(4326008)(316002)(53546011)(8676002)(8936002)(31696002)(41300700001)(478600001)(38100700002)(6486002)(31686004)(82960400001)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZlNka1podmpLOU43YVB5UE94TGF6ZkFweHhrelNYOVpwdXVNTkw1UEl5eThS?=
 =?utf-8?B?aTZYeDhEc0tqMHJrRVlMM0RBSUZBTFgzTjU1MWg2UkM5YnBCUjRtdnUwVXk3?=
 =?utf-8?B?SDdqaCtCNmo1OVpYbUJzeVg4VGlwVG5YNGwvMTFHQmhDQ2hWclpHZ29OUGhi?=
 =?utf-8?B?dGE2U29aOGRHQ0FaMiswM3ZNTEhiM0dmMktHMjJuTlZyWW1UTFJvQ3hzNVVD?=
 =?utf-8?B?L3pYdzVFVjJSWWNIOVJGeS8yekRqV2FVeE0rQnpWR0JEYU11NENlZzVCSy83?=
 =?utf-8?B?YktZWGlTWmNZV0t4SmJxYzZqNEsxaDc3a3lHVEh3WDlDWVN0aTg0OTI0bERi?=
 =?utf-8?B?RnRUYjFtNjFOc3Q5VXJRZXFvUjFkRkJNRnE5MkVxN25YV0h0aUVJdjF5bHFx?=
 =?utf-8?B?RGUzSGdtdGEyMzdxZ2pCcUI4QitCcWFWZ0dkUTc1clBBdjNUdmdCN3UvK3BC?=
 =?utf-8?B?WU1qYnR6WWxmenFWUE9pWFIxMWhUTVJCTHpnU1RwOXZCY3RobDlRMDRTN0gz?=
 =?utf-8?B?R3dWa01OYjlkbWVXMTdNSGNhUkFKTFBVQ3NWa3JkZmhVVmx4MVNEYjlEODcz?=
 =?utf-8?B?aXpPKzFyZ0QzcW1kUlkwamtveFlHL3BaU0VkVGJXa3dZL1U3QkJweDNjSVlQ?=
 =?utf-8?B?UUFSZk1FandmdFlaMG4ya29CQ3Nqc2cxWHlDbVdBdnppaVJ5ZFlvamlQRkJx?=
 =?utf-8?B?L1JYRFNiYUtyZW5xSkNKZ3p2MXhOdlYvMFdXblpsZ1EvaVRsb2xaY2xpK2J0?=
 =?utf-8?B?djdvOThvSUJKNi95VWR2bHJnc2lYREY0QlBWaUowOFNML0xtYUlPUEs3UEVT?=
 =?utf-8?B?YVN1c25EczVETnZQcytpN0lCdEdQUEdid0pPQUtYeFJrSlIycGp4L2VLNlk3?=
 =?utf-8?B?Qnp1ZHM2UG5wS2VTK3VMdlRFZU9kalNFRC9FQnVZWVJYdEpUelRubVV5eHoy?=
 =?utf-8?B?V2l5RU9TTzVpV3pNRnZ2bVk0d28xYUpBeEJMRGFSM2k2T3hNQmpPdHdVMWJE?=
 =?utf-8?B?M0VyZStqZFZJak1KZEY2MUl2dFpuTXlYUDlBb1czRFluL3NiNnZEV3N0S05p?=
 =?utf-8?B?NVJrT28wOXVVaVRaaFM5VFZQNDg1QmdTOE4vSzJ2WGJPYUZhNHJIenM4N0dr?=
 =?utf-8?B?RDFVUXFoTmV5WkM3WGRxM05aQlU0WXhXOFhBVEFRUzFXYkdnSXFma3M1TmIr?=
 =?utf-8?B?QkMvOGl1T0pweENKak1xeG1LU0V3R2o1MUVzamJNZE1uYUNBYjFEb3N4L3NZ?=
 =?utf-8?B?NmtSaGptek5QRUpMamFVOEt1dXIxOUZRaUJDRkg3KzJMQXpjY3V6OURwV1dQ?=
 =?utf-8?B?K2pTV3BJKzBaTnk5ZVRxbDAwTVdmcUVDT3h1YnN3ZkZETmZPaVgrUklrZ1dP?=
 =?utf-8?B?SE5PVlFydW9rdG14eUZadi9VKzlIakUxdFNBZ20rSDRVUFZRdSswVjBmcm5Y?=
 =?utf-8?B?YjZQcXhrYzJNeHBTQ1dMNFBXMDBLN1RJWnBOSTlnQlUycEhCWWhmc0FnTmNr?=
 =?utf-8?B?d3RMR0JNVDJNR2swTUx2NzA0dkZQTFdURjlPb0hRSk9qTWNRbzlTQnlBZWJF?=
 =?utf-8?B?aklJZldmekdZT1R3RGZlelZsMG04WlJNcXlMZVhNclNZc3E0NHpkL3l2NFNw?=
 =?utf-8?B?QjJsdGlXN3Q5ck9aMlAvcXJNbTNOMWo4SDB2RVFlYVhHbWJ6NDg5R1hQSGQ2?=
 =?utf-8?B?OUxYRU5iSXliak5ac1BRVS9FYVZ0VklBaFVWZW92Tjg0V2U5WDBRaFhOSElw?=
 =?utf-8?B?WDJ4VWRHQzFBeW5QMC9ZTEFEZHlvVTk5Wllpa1J3RXZCNHBhOVJHeE16a0tt?=
 =?utf-8?B?WSt5bXFYYTA3d0kxazZSSkJYZjlzTUhTWVRVUGFYekxkZ3JMem5BTTB1c2Q4?=
 =?utf-8?B?cGZxQnlkeXlGaStuMzlpODdSSVJrUHgyb21NZ2tQcjFXc1lCaFdlT2s5UllD?=
 =?utf-8?B?T0tzbktxdHVQUDVuNmtnVTZ1YVljY1hzbG5xT2p5dktaNFBHN3VFZ21LRFl2?=
 =?utf-8?B?SW9YY0hXZUIwK2tZRW1yY1VMZTlER3hxZ2p0T0xmejlZZldxZmk2aHdJVHd2?=
 =?utf-8?B?RmVCZ2orT29TTVhYNWhlNk1DYnl0QThPSWhiaWFYeWs2SEtxR3RkU2ZROE1I?=
 =?utf-8?B?U0pDWnlNWCt3R0V1LzFacU90THppSjJwWkx1UFZ6bHd1TlAydUFBelhHZkN6?=
 =?utf-8?B?Q3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccfa5cb2-c452-4bf1-f7e9-08dbecbd3ca2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2023 07:16:11.4354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: btdDQWMIqCpl8lMkvVWjUJ2APRTyKprfdW6nHwUTQnhnfr4urv1GMPPMu2AOsiGWzO6SIqSK+JG/A837UIDg9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7135
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Nov 2023 07:16:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13711

On 22.11.23 15:01, Sai.Sathujoda@toshiba-tsip.com wrote:
> From: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>
> 
> This series of patches enables CVE check in isar-cip-core CI by extracting
> the latest dpkg-status files of deployed targets in aws s3 bucket. A weekly
> scheduled pipeline runs a cve-checks job which generates CVE reports of respective
> targets by using the cve_checker.py script in debian-cve-checker repository [1].
> 

I understand the scripts and that they can be useful at the point where
you are actually instantiating an image. However, I'm not yet sure I'm
getting the idea behind doing that test for more or less random snapshot
every weekend. Can you elaborate on that?

BTW, patch ordering is then wrong because patch 1 uses scripts that are
only introduced by later patches.

Thanks,
Jan

-- 
Siemens AG, Technology
Linux Expert Center



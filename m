Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E011C77B61
	for <webhook@archiver.kernel.org>; Mon, 24 Apr 2023 08:32:10 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.41])
 by mx.groups.io with SMTP id smtpd.web10.46159.1682325125106291083
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Apr 2023 01:32:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=A3Ava3TI;
 spf=pass (domain: siemens.com, ip: 40.107.20.41, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KSvx70B8bieK0Yti4sxhJMKxIa+ZjjlnjyTmEPE7LmoA5APOMtdO15JYXLrBb6pw2EGtUQJLFqH02ABCdcDSU06LoUfZVXTdvEsKfOgBMQOsAanIsNT+GlMTizTgthpfWmurodMRwh/eeSjZDpGG+6BWt6gXN1r4vyA34gyV/RsxRDPfgd6KfOObJEXer5DPKyif7vlZUr6nz3WyRAjFq4YSrprsLnCy0/Be0g83gGQsAMuC86kb62OLqKPnCAOafcXtncml4R4ldBZ42kg7TP19RucZyfk0Fs3vQrBiYT//ZpI9jGYZiHpTcfS0C6xDY7AxWVySBpBpHOMkLR06lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CmIu/ysEN4n1C/c4a0Pbo9HmJ/geXURHQFyMPqooOBk=;
 b=hkBmqCgu7Y+qwZbObsfHj8GAC24XmmNqMl8JIMcYGFN7o7RGLlOgzD2gDdZeuxGy2hkL4QAu/pzVG7+ltFTs7tUn7YIbGKAsOyiNKTgRNavSPcPLq/RnGGYORyh8OVFABgPguNMz0YyEab/YezzEwKMQ8T29m/ihOKnkX5Wv5GfnPEUMONhv/5QBxfu5NIv6IucPDFCgWuMpyelAaPYVuX0YRTkcGha94bw0XmtvoXv6q1gOYi+GLn0UAKpbtMubNe74BRSGEEiAq8VxJsoji593xhaQD2H1lVDr2wXYw0RWRxqgyfYEfflqkjFvu8IyG9AU+lRZlCltPHqoGUKxQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CmIu/ysEN4n1C/c4a0Pbo9HmJ/geXURHQFyMPqooOBk=;
 b=A3Ava3TIS2gf+ops9rpWoj0uBdFUMiPHCTdHt2vQptqy0VjrvvkDeocto15+6IfwxPUtme+ROhdteKj2BYizX90On9+Zv4tQLO2iXBUpEfK2r8E9F/FWAE18I+/pQX8UDR8JDHOuV0k3+s5TDdlXN9rGv4wB+joUbvSy7zYZepkJuttY62pKEw1Lf+SHttC1YgpN4ODObEBPJVJh+3erX370DwIWWNzx51V0WkRPro52OtlCj1buoPNWsGumAYLNPjeZfnp9bp+p0Oc3gNUO8KQ4vphztBs7Y9WPEqCRu53wX0+HWtIQfVpvMyo5nGillgE/v1eSwK7VyvgMUasvtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by AS4PR10MB7942.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4f9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.11; Mon, 24 Apr
 2023 08:32:01 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e08b:7f4f:a8a5:586d]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e08b:7f4f:a8a5:586d%3]) with mapi id 15.20.6340.018; Mon, 24 Apr 2023
 08:32:01 +0000
Message-ID: <cb6b51f2-be45-d758-e718-c18fdd37c4de@siemens.com>
Date: Mon, 24 Apr 2023 10:31:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [cip-dev][isar-cip-core][PATCH v4] efibootguard: use debian
 folder from salsa
Content-Language: en-US, de-DE
To: Jan Kiszka <jan.kiszka@siemens.com>, felix.moessbauer@siemens.com,
 cip-dev@lists.cip-project.org
References: <20230421141330.3905234-1-Quirin.Gylstorff@siemens.com>
 <f4ec927f-5d19-48e3-84ec-b8dea9b5c13e@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
In-Reply-To: <f4ec927f-5d19-48e3-84ec-b8dea9b5c13e@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0062.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::20) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|AS4PR10MB7942:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d1f0736-24a1-4bc3-7984-08db449e5fc2
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	j9XzJ+k0mWtfsuIhTkUO12ZorH87xBD/2BvWM14IUoMA7IggOl5bjClNsEgAR6uIuRaj91Ec79BFQISOe+IzQmSCYY90nRNPuX2d5Bg2IXXIoAlR8DEOAwYIuwIaq/zhyZwEA8BPiDDUHPoVLfR2vu2J3FRZfWg/ZVz6OZsmidbHw1LKblEI/K3GH1IfDYVHrgGJhuzMbXgz0ENvWjza/bZIT8AIk1nhVR9M0dknAV0qugf5S5PYDWlCWMjKe8aj87G5m65IYzvgjIkEFnVdrK9KsAjnCIfSP5Cgv83A0UqhFjXBYGQay+UoPNlq2lf7NP50CEB0dKm5kX+iwh1V3FG4UQdchKggNJtE9ktN74KacL7OF9ajczuqQ9TvU8/DOFC3MfNxlrECgy1gk+zOXKwOpD5akxAei/HyFb+OgYwtKZ2n5Ol5jPikfCQmk9eReclG4P/DYq3JR97pvxh87wdwq5iytoo9wCOCz6RyL0O8Vbp9QlIROSx+LO+4lot5SOeFg6Md8CMJhkcCpQ0QoiCQHuMAuhABGbsNlSjmp93y2og9ovg7BjM/R1NgChreqoifpB4+yGNfpGWMUTH3F5ZLQejndMF0yF2ZELKw1dDaoLsO0n/Bv0XY6s8uQCdXHYmYBiYCtoXgo4j5QT7lIQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(366004)(396003)(346002)(451199021)(966005)(6486002)(6666004)(86362001)(8936002)(53546011)(2616005)(38100700002)(36756003)(82960400001)(31696002)(8676002)(6512007)(26005)(186003)(31686004)(6506007)(41300700001)(316002)(66476007)(2906002)(4744005)(66556008)(66946007)(478600001)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YTlKOXc2Zkt5ZEdrQTY3eG1iSlhsTVZjTS9uS1JLV2dtR054RFdPVjFxZDJ5?=
 =?utf-8?B?VTgxcjV0N2JIUDhvdC9VUXVEVytlT2xYQjN0NWxFaG9zRXNlSm1SeTZHUDVi?=
 =?utf-8?B?RkxLZDZzeUJ5bXNMMjFRUGNQT1RqUGJrQUgzZDljMCs4Ti8zVzhGY1JJdFRR?=
 =?utf-8?B?RlZnSTNNd3BwMVA0WEN5a0dKMEd1MWJWSkFyYkRXK3hBV1IwV2hINlhDVnBO?=
 =?utf-8?B?RytVc25OWGcyQnZaWWVrK1ViQzJkdWMxa3VVSmRuY25sRFA0K3dobnd2WDFa?=
 =?utf-8?B?d3Arb3Bsa05XOWZTNGZhVWd5Q1BDN3hpQWRXTjBKRVlYam5zdXg5MzVmKzc2?=
 =?utf-8?B?SGZWV3BQR1FDK1RSYUtScWhsVjBaQ0FnTlBYSmF0dk9oemxrNDBpUHl3bFJm?=
 =?utf-8?B?SURLcUI2bk1FWDEwUFNOMm1BTVFFU1IzcGMvcytZVlRDWXFiek03N21IOFk1?=
 =?utf-8?B?eDJaS0ZtbmZEVmpUeVJYaTkwTnpmZ1FMZzJXdVRrZ1NhRWwvVHhBRFRwUUhK?=
 =?utf-8?B?SEJRK0l0YSs0dHVsMEREWGd2MVFHUGF1NVZGcElZeExTV1ZWVnovTXpEd2t2?=
 =?utf-8?B?WVpGb1Q4WUVadEMrcEUvNkJNbVhQaDVqZ2xueDhkaE5RRUZ1M2c3MnJZNWth?=
 =?utf-8?B?QjZKVm1qbFhjM0FzNnhFTkpxV2kwTldXZ0NYOHJPYTI0eWYrdXViejNoV2VP?=
 =?utf-8?B?MnN5S0JhR2NMSGw2bVBsNSsyZTRtSktsNnY3aUFNU2ZBdWZQOE5NZVNzQnJi?=
 =?utf-8?B?elNrLzFyTmVpOWhLU0RJeUgyU3gyYnk2RW1lbERPTW5WN3dxQ3ErSjE5OG9M?=
 =?utf-8?B?OWh5eG8zRmNFcG41UE1xZWdzTW9KY05PN1lwWVZGeVNqeFJ3RmFRUVZpZXJy?=
 =?utf-8?B?WldQdTYyZ3B4TkxoWVJaQnRrdWIvM0NUNDNQdFdTQkJ1UlNPOEpubGdCTUVU?=
 =?utf-8?B?NElNekt5S3djVU9mZG80ZkcyUk9RdUZySkxoOFdsN2RDQ3ErTFA4TVdUcmdG?=
 =?utf-8?B?M21VSDFRTHRwSGVjalJrYWowK1M3NDZMUnNhc2xFd294c09KbmxDaEM3NnlQ?=
 =?utf-8?B?eGlPMDJ2cW5sR21mZTJpdjNRdysrZW9ML0M1aU9pOExLcHV5YVBVUmdYcmpx?=
 =?utf-8?B?bWsrOEo0bDNsOEdpQ3lxRzZqcmNxNXQ3SmMxR3FOMVkxOERGMGp6VG9mOG5Y?=
 =?utf-8?B?bHBjdHVYWjIrRDllSWwzUTJqY0tya2lzNHRIaEV6Rkx3dEg2QjMxQmdPbFE1?=
 =?utf-8?B?a0IyOEZYTXZwWTQ2U3BqeGNKc1dpcmVMUFR4RDZZa2lvNjhmSEl0Y2FJeUxS?=
 =?utf-8?B?S1dzSit2ZGpkYzRBRnRVSGZEeGFuUUpFVnVjNzBPQ1h3SE5zTGs2NllYZk1z?=
 =?utf-8?B?Y2RWWGF4bkEzY3dkeGoyV3RjcFVnU3FpU045SXNpUGtlN0JzSk81MUlSU0hy?=
 =?utf-8?B?VkNMd0I5VXgzV1B4Qmt0NzFUam5SZnVjZy80ZmlPeFdtbFh5M1YyUzk3cWVS?=
 =?utf-8?B?WTJEZ2pHTnB4OEZmZ2EvdWppcmRLRHk4ZkdwT0FjQ2ZZcy9tTExNbm44aEpP?=
 =?utf-8?B?SEwvYWlYSnZHS0phLzA0MnYyU2RaQ0hnRlFwUFpJZlN5MlZnVTI0QTFKU2Nt?=
 =?utf-8?B?WkVxYXd2YWdwb0VnK0hxbnhqNGYrVWd1UDN2K01UbnBKZ1EvbzZ5RmRGKzdh?=
 =?utf-8?B?a21qQzZYTG5acjJQLzc5VEdjM1hReXU2aWJmQ0VGczhtNnZOTEJSTTNrQW5w?=
 =?utf-8?B?Q3l2a3FWZFFQVkhFbXRiM2lhdncySTdYNlJ0M3FBdWNwTmpFNE8xNmE3TWor?=
 =?utf-8?B?QVNzcjBueDdIMi96eHVsNS9NQitMZWE4akpOaFhuaTViRElKc3VJMmtmeEtr?=
 =?utf-8?B?ZHM5MUIrQ3VKNEkvb3NDSlA0Vk9qVVNrWldJN0FEd1FsQUFTeXUzNVpwZ3ZP?=
 =?utf-8?B?ZTRsUTdJNTlib0REMlRGTW5IWEFxWmhTTERYK1AwNWN2dWMzR0NVSFQ3YWts?=
 =?utf-8?B?WG1XbTlFNUJjVTZ1OFVaekZHME1DMlpGemVDTWMxMVoxL01FWW1lS0g1NWlY?=
 =?utf-8?B?QWQwK3NnRzVEalhlMis2OVc2R3R4RDNhM3pwZnJVNmtZQ0lyRGdRMVg0ajRI?=
 =?utf-8?B?c0pEakI1OC83TjJpYzd1bjh4b3MrcUdwRkp4RklnK2w3NkRkalJCaFA1d2xZ?=
 =?utf-8?B?Wmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d1f0736-24a1-4bc3-7984-08db449e5fc2
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 08:32:01.5924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 37AGz3VrvUB0bkjNSXtLqsRsyi5oNYgz2P+8z4Cmiy0w8z5gV0tcct89hlh2ZWkhYw1KHte466boIcvKBtn+wYHswcvfUR4sb0zQKBoMilM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB7942
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 24 Apr 2023 08:32:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11331



On 4/21/23 19:56, Jan Kiszka wrote:
> On 21.04.23 16:13, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> To avoid package name conflicts between cip-core and Debian upstream
>> use the debian folder from upstream to build efibootguard.
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>> Changes v4:
>>   - readd patch 0002-d-control-remove-native-from-python3-shtab.patch to
>>     allow build for qemu-arm64 and qemu-arm. see https://gitlab.com/cip-project/cip-core/isar-cip-core/-/pipelines/844580247
> 
> Is that patch also upstream relevant? Or is that only needed for older

This looks like a conflict with crossbuilding the package in ISAR. The 
error does not occur on upstream as upstream builds the package native. 
I need to test if the patch is necessary for bookworm.

Quirin

> bullseye/buster?
> 
> Jan
> 


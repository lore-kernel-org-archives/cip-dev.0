Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A05B0C636CC
	for <webhook@archiver.kernel.org>; Fri,  3 Feb 2023 08:06:58 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.59])
 by mx.groups.io with SMTP id smtpd.web10.5928.1675411614310262497
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Feb 2023 00:06:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=xaw6m12v;
 spf=pass (domain: siemens.com, ip: 40.107.8.59, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wi5NLE3Ytr/Jlt94Hm0KmUN7cAhLC6NQwUyFYd70K0Q0UkMQGIic8LZVlWGc2zxBhUSRWH8qgDNLF6jedL+4whb9h+idho8ZbIIw3zhG+yJEuw4x3P49I9SVLVdiwzPQs15BRGb1sQDEWlBPqEgLDbdCZDZXWMj3Qjr94IzYu++/bkdv1YUSlGQppM9s4j0ZPGufKxf7DKEWdxKRmkf958kCLDXy78HlE/VcZCtPrqrx/SpmuoU6t7Vh03Z3IQZ2Imu/t768J5q4ZZiueQbkFKHEI+O21b3LWKCPVfhhlW+4q39nzoU7o0m5c1TkrH5xJ4SVJnnw4r2cO6Ba0KQCwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JJzwO/zMs2lFbymUNO3FCdbeWFKVtiZGYoGl514HIH4=;
 b=Lo7t7Cvy95wO79oBu2k36mhmjJ1GSp8L9IoPEdprjqQjaRY3VFH067/620lAu8wzDqQhJOhzn5fA+xIAa3sD5BtVmgO0W9VfMnvDuzNnDjqY3BW2KiAZcB2TvTR6UrNs8LBLMlabfDqa0Sw9B7/Qavkdhg3zey3gWCblL/MoeDGAXwsvNl1edvW19T2ZEoeELI3PEkbJTgPfsxKwbD07nFoSG4DE2v0I+McK/UOX7WxaJthatQmJQKGaOztsR+7HW6Ewal/DKkTr4hvIqMXU4CvvnuZpk6FWn84Hs0wweasAjYsdYS2AcVH+SE6ue0mYai6nX4F5YeOMq1FWqXB0wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJzwO/zMs2lFbymUNO3FCdbeWFKVtiZGYoGl514HIH4=;
 b=xaw6m12vxGvQsaoU8vJHnWSEx/5r2M0TpckD+9FlY+hV3e5ViJdi3zbZM6rB9MXYLl2Er4ZsclAimGOY7mGZibJab9OqigK3RSWZsLtXrNJ33Y/ajESrQPbZtvpKviwl1rxyQ3/eCPanz0RLDlkZLZvg9nWHczhquxUwS28zHIb09waqpmCfbhUmgqLpdA4CzIjqOazEuo5+gp6sK/tsHT7tW4cWX2oXLzmrkdctucRtMhYXsRbMY1B8w9Ll0FgGLc/Xw/SF8Z9IKK+7xaYfBMwdEwSLtLSSBWPMJH18LylJfyHz972Qb6hHrAkm90Pm9IWo/GuvfBfR4+OqlOohPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by AS2PR10MB6640.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:55f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.25; Fri, 3 Feb
 2023 08:06:50 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e22:9724:665f:8d94]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e22:9724:665f:8d94%8]) with mapi id 15.20.6064.031; Fri, 3 Feb 2023
 08:06:50 +0000
Message-ID: <bb5d0f60-2959-17fe-64d0-94fc2e898636@siemens.com>
Date: Fri, 3 Feb 2023 09:06:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [cip-dev][isar-cip-core][PATCH] conf/distro: Use cip prefix and
 snapshot postfix for sid lists
Content-Language: en-US, de-DE
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org,
 felix.moessbauer@siemens.com
References: <20230202150607.824537-1-Quirin.Gylstorff@siemens.com>
 <952c30a3-dd95-8ff0-3617-3a6eed0464d0@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
In-Reply-To: <952c30a3-dd95-8ff0-3617-3a6eed0464d0@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR04CA0001.namprd04.prod.outlook.com
 (2603:10b6:610:52::11) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|AS2PR10MB6640:EE_
X-MS-Office365-Filtering-Correlation-Id: 3de83871-15f9-449e-c12f-08db05bd9aaa
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	hce2kj6uy+WHYevlSpgh8tXLBP0WiF8r+jJBcl+tK+6vBxk6SsACGsiUUcMpzcXSD9zmJXekJyIxP+QmJjddk5Qo1vMCta2RsNnmp0/xcmMX5hC8JU/XVMCscWrYXICGrNfZ6WNW4sOrs75tAB92e0ybs1cg0IvK2+M/3CmuY8iRcFazGpjcLvapUkAbXFEFJY313xBAhSq2Vg6osM25Atr+CyFWfaQJfhVc0XRsdag4E317qjaPZSbgpx8T7bkDP4pSKM8nLQ3u0z9yj/pt1br9VVehlPnZMu12W3UN4cAjadb2d6p5ZO9osN8gKWhTlXu5HiuxKvflUZMsEdgbeFrAJcqtkasdMFqZQafNuOubwh2T/9dRM14n2aRBICqoX5ezODM2p1teT0+4YXR4k7U2dUr2Hb+/iUaB5sHrgG/f5RWG9d2cO6iDsJKcpyD1VSzB0GGsqnCx08pj0L+20ciDtk2xaxpg5lXnA69zPP6yOHlCvffYN64fG5amG2xkyodbXJpqT1WVel8DwZKihL03TSRhFUuQhf7JJJHfi+CEmawb0DHCE7EXZy8RZ3Bh6yF/sm+bivb9W7O1CkbYSeLTssW83TwT4qSRpWil0eq4h2G33jUZkS3FgrkWWUkyO/l49a92/IvoXUYD9CtSN8y1nVtyyGyZP+FuuQoIDhFGadENAVC70nrdGUd/wuFyhLIT8UQfrqfRFBW0MMfsjY/fuqaVyqq+Je8b72/zwTDTFwPFeP/Tn1VRtDbyMegwLr/Hogizb5cJXFp2i+CEhQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(346002)(366004)(39860400002)(136003)(451199018)(6666004)(186003)(6512007)(83380400001)(53546011)(2616005)(8676002)(66556008)(6506007)(26005)(66946007)(66476007)(31686004)(38100700002)(5660300002)(6636002)(478600001)(86362001)(36756003)(41300700001)(2906002)(82960400001)(8936002)(31696002)(316002)(966005)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?emtsTy8zZWhYdE43cEF0ZDJ3Rk1KUDNuV08walMvMENsd01JL1NsaXUxNFg4?=
 =?utf-8?B?cDU3OUFrVys1TjVDMjdjR3RhOWNPR3Y0UXptVEthMGJ6K3pLZ1hLSkVSNUh5?=
 =?utf-8?B?SzF6OC9HV2NUaTQzV2VCcndYL21hZ1hSdkRqNHNPdmVjak9yT2ZjZkpjb3FR?=
 =?utf-8?B?MGI3YW1WRnV2ZzBGazh5dmt2UWhNYlE0RU5IaDBlWHdyRVExUGVUek1TTEFM?=
 =?utf-8?B?ZVdZbjU5dkFSR3h4cjNuRTdvenEyN01GVyt3NWhMa090VnY4MlhkWmdQRGlu?=
 =?utf-8?B?T2I2TXdxaVNrYjloTi9XL2krQkRVcXdIcmJxOElwWlJ1d0w4aDkraVQxa09h?=
 =?utf-8?B?U2M1c1BPUWdCZnlVYlVzblh1TnFBQ0liRzZQb3FCbWIrcHBsNTlSTUlVQ2hr?=
 =?utf-8?B?UGIxaWlBbktrN2tKOG4vOGhsN3hYbjVSUGZTTXppSEVUZnViZzhtcnR4cEph?=
 =?utf-8?B?RkR2R09keUpwd0tBL0N2NC94OW1sSVRoS1NTY0Y0SVArVC9ibjBQOHJXUTdY?=
 =?utf-8?B?ejA4K3UxOVZ3cEF2RlNlWFhpZzBjYVp6eWJIQ2Q4YTFPUzVMVEljWG01d1Bo?=
 =?utf-8?B?UWs2QXVERGhnL1N0WEpIaksyUzdaWllOMHVkZXdncTkxVGtvNWhyejZIaWc2?=
 =?utf-8?B?TGI1eGZhZEZkb2gvL3NYeEF5bGNGU2didjBFL2ZXUm4yRE94LzIvRWRGUy9o?=
 =?utf-8?B?WGRmM05tOFZ2cERGOEpNZHVsUzlJYW5RMEFaeDcxN2xmS3pFR3V1TTNNRFlz?=
 =?utf-8?B?bnl0NEh1UG1xYU5qaUJRTGIraWJrdXYxdXZZVko0WEFvcWlIK3JLenBhM25r?=
 =?utf-8?B?N3JVaVV3VGR1U1d5cDVDUHcyaTZzMnZMaHBLVTVUNDhmNCsyUVRyNXJ6UXhx?=
 =?utf-8?B?SkFRTzlyd3F0VFpaa280NGpxZENZdUE1aitYUzZWTWVudGxrY25qcU5pL25E?=
 =?utf-8?B?T3RDRWx4TTNldlpCU2ZnbVlVbjhEVXVBSm9EbkZYdzhVZnBrZitRZENVRmcw?=
 =?utf-8?B?YmJKU0ZQZDN5WGdpa0pZeXI1UUpXcXNjaitMbEVVem5hZytWcGtIbENxRVd6?=
 =?utf-8?B?Lzg2RWNNK3p4eTNPN0dBSTBkbjVlalZLVGJJRjZSS1A1VlVSaFE1VWU0ckdX?=
 =?utf-8?B?SEorWWthbFp4V0R4bFVOUTYvM0IxM04xUFlSV0JsRlFBRTZYSmdXVFZYV0Vq?=
 =?utf-8?B?NEQwWFNXa1l4bGNoL1VpT0JwZXhJZ1JmbFRhM1NSd2dVY1NKU29zNlpPRE55?=
 =?utf-8?B?VlVDYXN2ZjgrVWFBRFhrU3BkT3hSY05rS0hGNko2MzZnejlPNUNYazV0cEZh?=
 =?utf-8?B?Rmk4Z3lhM0FwbWNhb016UnJSQVpnWXBPbmRCNlRpYVVrbVAyeEZUOWZ2WTVN?=
 =?utf-8?B?aytVQWZFSjFRK1E4elUwbDN0a2xZc2xYeG5VbUJCTU52MTRhV3FLdHQzOERn?=
 =?utf-8?B?ZlcwQkJ2NnI4eEU3bXY5SS9ka0p2RzlwWmszRms1UkhFS0FDVElFUUFLdlhW?=
 =?utf-8?B?Wlp4aXRVcm02Q1pUL05NMGF3Zm9iUEwvNnBQWUgxc0g4b2xIRjdBWkpHeWZx?=
 =?utf-8?B?cDRZdis3S29aZklqUlRzVVdTbjloTENJT1FGQXc2S3BMdVJjZnNsZWxXQTlt?=
 =?utf-8?B?cERoYThTZUd2ZmZOUlZMUlJTajluTG42S21uSVdEdk1tY1pMRzlqb0tOZmR4?=
 =?utf-8?B?ZGk5SnpXS3ZWVHM1SS94VldYb0xIVzRGWUNwYlJZbkVqVXVvSlloZHloWEZJ?=
 =?utf-8?B?S1N6N2hFam5XVDJTNXEvM01mYVRjTzdqbHl2R3hDNDU4RzlLNUduZmFJcE5r?=
 =?utf-8?B?cEp2NzBBcTF2L1N3TnB6SjZ2Y2E3dHlXTjZuOGxTc3dVekU1dXhqYUlRNk04?=
 =?utf-8?B?L0RwSU5EVS9jc050a2VTMGxQMWY3SldYVC9oVUg4Z2JHT0JUUC9OZDJ1WWxH?=
 =?utf-8?B?Y042Rkh5NzdZUExheGtvVXJHYUJiaGdxUXhOUjR5L09XcmZiK1ZHMC9hY1Bh?=
 =?utf-8?B?UTYxL1Y5RHlxQng0RUJvcFV1b01qTnBXSlM3dnJ3Q2F5UlZyUks0Qno3Wi9J?=
 =?utf-8?B?OVljRlpEcWE0eG1Oa3BseWo2ZlFUWnd1NkFNWWl0ME1xSnZyUGE3VXV3Nitr?=
 =?utf-8?B?NjB0a3dHSVNJbnFicytOdG1lS1F1U0pZQmw3eFdBTzJMVEZlSWdFanZPY2tR?=
 =?utf-8?B?dkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3de83871-15f9-449e-c12f-08db05bd9aaa
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 08:06:50.7633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q/VGR5lZixrHSal/UYoCashI45SO2hLn2QQqU8/yWMjhQN2sc9xUnNtggdwf2IRJ9RMK6bVZu26uAICTenmsxCPKK609DSEKEjR6ti66aec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6640
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Feb 2023 08:06:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10578



On 2/2/23 20:52, Jan Kiszka wrote:
> On 02.02.23 16:06, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> This is done to avoid infecting other layers with the snapshot version.
>>
>> Reported-by: Felix Moessbauer <felix.moessbauer@siemens.com>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   conf/distro/cip-core-sid-ports.conf                             | 1 +
>>   .../{debian-sid.list => cip-debian-sid-ports-snapshot.list}     | 0
>>   .../{debian-sid-ports.list => cip-debian-sid-snapshot.list}     | 2 +-
>>   3 files changed, 2 insertions(+), 1 deletion(-)
>>   rename conf/distro/{debian-sid.list => cip-debian-sid-ports-snapshot.list} (100%)
>>   rename conf/distro/{debian-sid-ports.list => cip-debian-sid-snapshot.list} (81%)
>>
>> diff --git a/conf/distro/cip-core-sid-ports.conf b/conf/distro/cip-core-sid-ports.conf
>> index 0b369bb..5f41bfb 100644
>> --- a/conf/distro/cip-core-sid-ports.conf
>> +++ b/conf/distro/cip-core-sid-ports.conf
>> @@ -14,3 +14,4 @@ require cip-core-common.inc
>>   
>>   PREFERRED_VERSION_linux-cip ?= "5.10.%"
>>   PREFERRED_VERSION_linux-cip-rt ?= "5.10.%"
> 
> Blank line here.
> 
>> +DISTRO_APT_SOURCES = "conf/distro/cip-debian-${BASE_DISTRO_CODENAME}-ports-snapshot.list"
>> diff --git a/conf/distro/debian-sid.list b/conf/distro/cip-debian-sid-ports-snapshot.list
>> similarity index 100%
>> rename from conf/distro/debian-sid.list
>> rename to conf/distro/cip-debian-sid-ports-snapshot.list
>> diff --git a/conf/distro/debian-sid-ports.list b/conf/distro/cip-debian-sid-snapshot.list
>> similarity index 81%
>> rename from conf/distro/debian-sid-ports.list
>> rename to conf/distro/cip-debian-sid-snapshot.list
>> index bf0f7a2..46d34d7 100644
>> --- a/conf/distro/debian-sid-ports.list
>> +++ b/conf/distro/cip-debian-sid-snapshot.list
>> @@ -1,2 +1,2 @@
>> -deb	[check-valid-until=no] https://snapshot.debian.org/archive/debian-ports/20220925T001806Z sid main
>> +deb	[check-valid-until=no] https://snapshot.debian.org/archive/debian/20220925T001806Z sid main
> 
> Is that related or a separate fix - or even incorrect?

I look into it git has switched up the changes. Any idea to fix it as 
these two files have almost the same content and file name.

Quirin
> 
>>   deb-src	[check-valid-until=no] https://snapshot.debian.org/archive/debian/20220925T001806Z sid main
> 
> Jan
> 


Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F1EC636CC
	for <webhook@archiver.kernel.org>; Fri,  3 Feb 2023 09:53:29 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.44])
 by mx.groups.io with SMTP id smtpd.web11.7264.1675418000756150247
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Feb 2023 01:53:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=diMQZmVl;
 spf=pass (domain: siemens.com, ip: 40.107.8.44, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KOmyssDt9gH7vB+mveXsETd6aKwHqSxDgL7Kh9fj6eQGuVX1EIZwySGpiEN16LhT8PCBUHZs7baUhV+Ea1709/7wkEUeQWWRDVU+Xd4blmE7ctEgPu72L5XGfJbQ0jh/kckjUQVubs7+eypH1SLMQiE2Ih8qe4DIdDVWXrnISwnvdPjNotGxDmEQrNHc9CVOd9tZl9RDpHvTTL+KN0OpSPfJzPxSP1QCZx4ESPSI7PtnpL76thuswvc53bWv9toQthbHTRawSfHmB+oL60OdwJH8u1asbfXZSmd7j9v2g5m6jOb/Kiz9LUDMQi9IRISJdpsXkuSe0P8IeY64CkLx2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W2MMNTLH1hbN5lbhEIBQzbXyvMUrQUbQN3Ww1Nm6WLI=;
 b=ON2JNtS/51XsqMyZR35xasd5GQamK0ffir7F09BCkaYEf5aGdn1hnULxZgiOEqeQXQn++QeODhpG1ESQIaHk6vEkY+2EoQQ3p2BBfHvncgP/X0v30IfPRIgjhVH1RKWq5VfPskOXnnOhd4uxtRTDjLaQezgDLRml7hCet3YBMg3C3qt7pEgpYbPH+H4mv4QYrUZ2Fwpoypj+8iIbEItf3NIWVTdGX25uO6t0nlc08ecq9506P5VK8pLFW2G2u881eeO+sCJE618IH6Mg9tTjRXQV/OHDoAue3DYP04gz5zphDqdU/cX3RaeWqdMdBJdrJ5HVnxXEgzLuC1k529mfCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W2MMNTLH1hbN5lbhEIBQzbXyvMUrQUbQN3Ww1Nm6WLI=;
 b=diMQZmVlkWpY0u/pVdjalfTWwRXTkEDOYeSI2sPb0fAjO+Xj2/xaUNhVnjNI05BgXsVBb+w/+HbbjzOH6vfUgTcRs+YYjIzqYnK7GxbqF/lift3jyJcgWaMiCmxsHVXVBK+CjJA8YFLPDkiigIIE7drdqwYfltqd65Js8+WMwObV7ItYwesg/4BJj/d2GW3RP1DB4NIsykD9qf+4PfPKNrUVEVJ7c/LFvZzpaB5yyxgXf8RHJhJ9f/IulxfQl1NpbhXqwKmbS1fWotUfjcEhbh7M7IfWZJLLdSf7FbMX9RDVXTz3r9r2iYLalaTs8VXz4c3XOin7mSE5ak+JH15LEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by PAWPR10MB7789.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:365::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Fri, 3 Feb
 2023 09:53:17 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e22:9724:665f:8d94]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e22:9724:665f:8d94%8]) with mapi id 15.20.6064.031; Fri, 3 Feb 2023
 09:53:17 +0000
Message-ID: <021136b7-fc6b-19e2-7288-d02268f0f0d6@siemens.com>
Date: Fri, 3 Feb 2023 10:53:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 2/2] conf/distro: Rename
 debian-sid.list to cip-debian-sid-snapshot.list
Content-Language: en-US, de-DE
To: Jan Kiszka <jan.kiszka@siemens.com>, felix.moessbauer@siemens.com,
 cip-dev@lists.cip-project.org
References: <20230203082516.27690-1-Quirin.Gylstorff@siemens.com>
 <20230203082516.27690-3-Quirin.Gylstorff@siemens.com>
 <19c2419e-7a18-7c86-558e-7813d5000b9b@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
In-Reply-To: <19c2419e-7a18-7c86-558e-7813d5000b9b@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB6PR0601CA0009.eurprd06.prod.outlook.com
 (2603:10a6:4:7b::19) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|PAWPR10MB7789:EE_
X-MS-Office365-Filtering-Correlation-Id: cf540794-3f42-446f-9f4e-08db05cc799d
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	jutpiS0k6W0MHrcS9whQNHrEzsdQbZY3ePu16foUwyIASMaRfpqQou+wp2SONvXKbYWVzfEH+AtFdai4JqUqjmCbNLnHnkm8ZTaMZN6hCAwwhFYkpX5+uQBO80MuqxHp03zGBNg3ffStxalY4IbUg4jEvBESzXonPWO8hm4CcEmRtX6m+TQsJmSmWeOk/4ozjwgjzFFbDkiTWebTBM0zP5Eb/koU/LsNIh6UCKqJ6+yAgsprzoDNXdqi7P9A8K26/jORX0mZtzMBvymcoM3PHszcGGeLcoq+Lq6Ybq77edoTKwDoILaZCj9dMWbaBnvq1ZPLSw7IR2QhGrkG8q06V+xhhdQwWhgsmnMtCx/0nmR5P0IrEgo1ZoCprcHM9sKnMdQ4WTduNX0wkK+HEu2GBl/d774hLNrVNEZFSloAVhocd97A3MmrFCZPvv6cBjqj2sGgFJS6yf6+JnXbrdpi64hYdxfhFL5C8q/Oup06F5Y4+RynSpAyhQmxXaHq1tFmvdEPxwK4g93dSLGtCZsTWDevf704jQR/Ymsve7tNIjFAfiyRP+WK737wu0PdaCCN+J3PkP7/yUwO+Ez+6sLCepgD4A0keXbsJZV1SXf7s4Tq3Rq9Ez/471AGA/g0zkDeUaRmYaunMLtYXPjuHTOWFMAcsQF2DsfZGQlJYpF2V084iXUhX+YV/sBqRVysK0BTIkvc47RAJoMKnhP1/ueiMcAf/0tby/wY434AcFudq9o=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(39860400002)(346002)(376002)(396003)(451199018)(31686004)(2906002)(478600001)(82960400001)(36756003)(26005)(186003)(6666004)(53546011)(6512007)(6486002)(6506007)(4744005)(2616005)(31696002)(8936002)(86362001)(5660300002)(41300700001)(83380400001)(8676002)(66946007)(38100700002)(66476007)(66556008)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Wm9zSG1FWmJOZjhhQnBmTWxKdGg4OWFsK2xtcnkyM09ZeXUzUVpUOXFzbFJP?=
 =?utf-8?B?VWNrM0FCYy9iWDM1TkEvNTAzM0l5cStxYlpJMTZoV2FxbUJvTHVEbXlmUGVj?=
 =?utf-8?B?ZUVVQmFBY0VCZ3c2K0xDazdHWjZGLy9OckRqaVhkampORlZRem02d0kyWURm?=
 =?utf-8?B?cEtEUmF1ZHFpN0JYTDQ0b1F0YVdLM21yRUdmY2NNemt6MlpUNjV5bFM2VW9r?=
 =?utf-8?B?dkprWGd2NVM2aUdubFBpZGtveVg1d0FJVktsc1Y4YmxMb0dpOHE2bUxzN3po?=
 =?utf-8?B?UFh3YnUwd3hEandNdFlKZFhDVW1GZXdGeWtmZTJTSkllQXRySjRURmZna3BI?=
 =?utf-8?B?QXVHVXFKdHFMWXJ4dmNCOUJKNlNZQjdCT2hWbzlPNkIrdDlldGE0bVJIL21T?=
 =?utf-8?B?V2JTem82Z3VldU1maC9jdEhYNFpCMnhqdXZ5dkl2SGJnRndjL0NTYXZjYWkv?=
 =?utf-8?B?K2U4ajhVVG43a1Z4TnMyWXpzY1JYblBKa3RZU29pekFQOERhQUhETDhLT0VL?=
 =?utf-8?B?LzFyOXNoNEE0ZGlQQkhscEV2SVFKWVpwR1JmRE1zVHpKb01JY3F0amdJYS9C?=
 =?utf-8?B?dys0ZHk3YmpmeklOc25TSzlXNXdoWVk5Vy93VjRvQUYvSGRQaVhRSys2QXEw?=
 =?utf-8?B?MWZNckZ2UkR0NzdGUVJnTHRKMmRRZFJ0Y0dSb1NjTEMzV0IxUzVRRXZqZ0ZM?=
 =?utf-8?B?RU01TDhxVlhlQi9oSVpBR2NKZjRlVVNZVS9EWGRXYzVBeWQvS1RWYnRLZVc3?=
 =?utf-8?B?ekRTYW5UR0ZvNTlpY2hWQmJCOXZZSTFkUVhpaGdkWG5aZ2dXTFlJbENUSngw?=
 =?utf-8?B?WWFPaDloang2ZTcvVzAvRmc5QWxDeHZTS3JlNW0wcGFTWlUvVlA4MjF0OGd4?=
 =?utf-8?B?OHdmaTcvWDROMXpmNzFYVkV0U1ZFZ0Zuc2p2aVdSblkxbG9Cd0Y5NUFoajdP?=
 =?utf-8?B?dmo0ZFJIRmRLQS9OZ2ZoazBFLzE4RDZlcC8xNzMvYXpLUUMzdWJRM2t1Y3l3?=
 =?utf-8?B?bkIrYmpJS2RNQWJNeHdCWUdRN0EzbWRJamwzbS9XMFpkcGlOQWpkaTZqdEFM?=
 =?utf-8?B?ajhndkd4M2VGek1YbkY4a1JBeUU0U2Y0ZUxuak1Ba0pieTJkeU56TmZlS1VV?=
 =?utf-8?B?SDVHb3VQT09lSmpZblBJRFYvVnJ2a0ZYdWxkeHdKcG9Edk9VSWRKL0hiZXpk?=
 =?utf-8?B?UFo3TFJDQVUxYmhhVzM2a2tSaSsxalA1NUFaTFdLTmhXQ01kay9uMVBXN1VS?=
 =?utf-8?B?R3ltRk03Q2ZVUjhGWE5tRlRGSlJDWlBXak91WDhkRTNTeVI3RmE0V3ZmbzFO?=
 =?utf-8?B?VzJYZy9MQzJ6TXVMUGtnbUdvYTNoNEhiVWw4WUtKTmpuN3NGWC9iNXcwYnFP?=
 =?utf-8?B?SEFUWTMzdklhb0lwbVNITUpXTGdIOEMyakhzM0dybXlaMGF1Q1hkblY0MWZ3?=
 =?utf-8?B?MDlQRjNJSXFnaFN3NzMyNXdBd1hKNHdZYVIrN1VSZ0tVaXVaYmpUWVBHblIr?=
 =?utf-8?B?elFGMkYrRG5LeFA1Y2NJYytTNmRmQjBrcHNXV0RLZlY2N0dqeG5DcXN4YWFu?=
 =?utf-8?B?MXhtNU1ySXFnWllRQUpVdEhFRUxOaU56dHE4aUQvMGkyZUl6cTZ4ODloTVRE?=
 =?utf-8?B?T0FjNFl1MVR6YWE0VFE3RWwzUmVqUzg1UUlyMXlSWG9JWHpWM2VNK2VqY1N3?=
 =?utf-8?B?bVBqdHhIMXpEdEtOR2ZIZWRFeG0wZStmT0hxNlhodklzVzFnRUI2S2xua2pk?=
 =?utf-8?B?WGVKSGRuNjRJcVRsaUZyVjZTTXhJNytZT3dhcy9nYzNiZEs4U2F3R2JuR3Uy?=
 =?utf-8?B?dHdQSW5sdUtGVWxsdVlMZHVZNDE1Yi9LUTRXS1EyaHo5WmpPRCtGdkE4Zk50?=
 =?utf-8?B?L2hmekprcGVLSVc2a0JsY3FIRWJtSEdraEUwNUJtSWRTR0wzekJnNFVLWWdj?=
 =?utf-8?B?ME1kN1BMRnhWbmk3NDl2ZTNoRGI3clpCWW10cmFpU25jU0Q4Zy95QXVrWWdz?=
 =?utf-8?B?RWJaSnU2RTduVnhaWDRyWXRzTVlia0diV29sYnU1bGoweTZnN0tXR3lFcHRO?=
 =?utf-8?B?VjlUNkt1V01xYnFCTmp1aWRtWDRkdTFML1htZU9lQmlXK1BEZ2toYzdJQmQ5?=
 =?utf-8?B?SmY2ZEhtUWRqNU1ieXUyUUZ4RmVBa1ppQmt3Y3RNRDg4cEdJVWxJYzJ1dFFr?=
 =?utf-8?B?anc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf540794-3f42-446f-9f4e-08db05cc799d
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 09:53:17.7553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KrFAwkCEQYBdWs6M+6P2EOTtErvNFe0pF4NfiEkLN87qpQ85leeWtWsu72lGKOCARwXREMiJWphrKdkAgnALZGqW9KBDgEqo0OMmIDhAQrM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7789
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Feb 2023 09:53:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10583



On 2/3/23 10:22, Jan Kiszka wrote:
> On 03.02.23 09:25, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> This is done to avoid infecting other layers with the snapshot version.
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   conf/distro/{debian-sid.list => cip-debian-sid-snapshot.list} | 0
>>   1 file changed, 0 insertions(+), 0 deletions(-)
>>   rename conf/distro/{debian-sid.list => cip-debian-sid-snapshot.list} (100%)
>>
>> diff --git a/conf/distro/debian-sid.list b/conf/distro/cip-debian-sid-snapshot.list
>> similarity index 100%
>> rename from conf/distro/debian-sid.list
>> rename to conf/distro/cip-debian-sid-snapshot.list
> 
> And who is now using this?

I did not find any - will delete in v3.

Quirin
> 
> Jan
> 


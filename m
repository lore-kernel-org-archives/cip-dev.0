Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD692C4332F
	for <webhook@archiver.kernel.org>; Tue, 13 Dec 2022 13:01:17 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.74])
 by mx.groups.io with SMTP id smtpd.web10.72446.1670936474319422091
 for <cip-dev@lists.cip-project.org>;
 Tue, 13 Dec 2022 05:01:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=q/43Rw++;
 spf=pass (domain: siemens.com, ip: 40.107.104.74, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gf46+v35ErWkq7o8PbLotcNyIrxHg5ss24mWpqgC4zaEqv3LKVYYErI/GjV0QoWRWtQe8Pq/0GbPUF9k1hI70yjWcTFdZzonYEHlItz0USOEGEpLXGhrcxNlMGcYDfAoNQQs+RzzLlqNPvrb7Ys0GHuROAdCnowB17lj8CK0Su2+iTNlnTJQaT/84Bhy1zkr+Y7tRMoDiu+wKQRtttWvFMitDeCmYOYNrkwO2HyBNEmM2QfmsJ09ZB5//KKAFXDP4iXBKOW0I70kdMHqKW3mvxNh6P91Vsko1PQCEmNYk/G/38Li+1/oYVKme/q/EECPD+iDxBn3ZAS84PGWzO5ixA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qMJCjIv2+rFlGEIoHaHv50e9yXhXUtDoq+xCYqhAcBA=;
 b=hAhWyQFkV5D3MjpZW2E4vOYFwBQEIWpWQQRMqNs0nLp6NcBcwMNvuiMX36MyZUuqfu8EUaI3DlklPL6rHDRvqylQgp73XXWA3VP0OoF8JlfNyxPZhDwZ1nNctnu5f5IWTsLMl3ZR4KAJttSb7MkQqU5LvTbz9M0riGc3BD9FRt90Obi8Ine/EQ4Vhtq3vJI1zW/Y/OuBGAISuaUhbdyoP6zUtZrdK6Q/ASNibBnEqZsG27jOxkfax668qfor6hQUNF7NZmiCf69BLpEX0GqTaWiivS46Fqlh/oGpbMAUP/pAQJehH5QKgmEGmpVoIgh44qMHK87rDoJrqW+B++MnkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMJCjIv2+rFlGEIoHaHv50e9yXhXUtDoq+xCYqhAcBA=;
 b=q/43Rw++xy1DTjHrLiLvhW6mMcg1nUozWiQtitrREkbftiWgL5j8dBbR3j0B82LG8eSQyS3ugemGlFMm/ELiznZXoAtpEMV7RSbPbvUr330+vDsFrILjKc488dvcEU067oankaWIgJcpgaEzqIIFiolflvyh/nramZ8BlE1mzzdCivIwgpOYJtpzWE0B5dzUd+yYdTAb72Io+jinttspV08nYcimt8IC8YbuL7TBBkF+GA5G/OceyVa1DIaCakCe5d8QEi54sSSkD2jbJhDBsRNBuG/TEXOH1vGaCUJIMR8YlpGZDD+0XAMBjEcKITyg316xYLdX4TcSF7KMrJA0wg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3143.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:103::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 13:01:11 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a%8]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 13:01:11 +0000
Message-ID: <d393c362-f5b6-b940-d6f6-8158bf807cbd@siemens.com>
Date: Tue, 13 Dec 2022 14:01:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 2/4]
 swupdate-handler-roundrobin: Increase revision for configfilecheck
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, felix.moessbauer@siemens.com
References: <20221209145827.1309521-1-Quirin.Gylstorff@siemens.com>
 <20221209145827.1309521-3-Quirin.Gylstorff@siemens.com>
 <7404ca3f-0457-3a22-38cb-73596b5b98e3@siemens.com>
In-Reply-To: <7404ca3f-0457-3a22-38cb-73596b5b98e3@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0089.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3143:EE_
X-MS-Office365-Filtering-Correlation-Id: 76c5a547-f5e3-477c-3d02-08dadd0a1bf2
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	3S83hiddF+i/QhIgMDP9jaEOFsVNDOOxxtRtZfSHpp4DRrU/Gp39OVV8dkEGaxe6ZAuYNls690wtgRNMRRHq5L4ddq1wREN+BC3Gv/3Y+qqoHhd2fgpAI9+GDLVu5uG2z8gQaZAGSv1gSGHrei6OOEhQgj4WHuPWcPkQPWxylRIA0KM1xnaficsv/GP+iFmPJeDbJwcj/zJMxjtaVlJyZMlP7c8V4I/7AE/Y525psPKcmo7Nf1/6rXMIbPypejahvAJmS4GHHerV9jfWDGDR0HhzmL4Xub0P2r7SC0e4JPNQReHetfIi8wSgbJJVsE/zHEj1sd1hh5EUKart4DHWY12SUgFuth+5I6db0NeGFSTr64HukRbGuyM1Z2ntnmQzeXjKtLSwekCcCF6RySkBQbxkUOEhunClHpcL8ywLazIFh31Ze5xw0QI21J5QuNLSwLd279uJQ6AC8vSGsfv0/yGzFTEFAc6OLD5riJ+7/WfLDaQEHHG/f58VGAo2RuH1IWx1HjbyOhplqvlM2aPF0QDS2ALozNusGHWe2cYyPUZFAz5/HvReCxq2XHmf/0GoPGDe//+Dw86JvLgkc5GQvDqYdL7VHhq0Vzp7me+6MpH9/cpTzMWw2jKRPTH5RlrSDOQaXmUYsOTDaWEJ6aXbvtVwEmMTQs8ZwdKUL0MNtJNPgyH80SEiDN30niJv7XZAixKl3TZXv60b1vWYTTzJwjFeMypTCIDM2T+c8Smd9NA=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(376002)(39860400002)(346002)(136003)(451199015)(8936002)(8676002)(316002)(36756003)(6636002)(66476007)(66946007)(82960400001)(38100700002)(6512007)(31696002)(186003)(2616005)(86362001)(66556008)(478600001)(6486002)(6506007)(26005)(6666004)(53546011)(83380400001)(44832011)(41300700001)(31686004)(2906002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NHNWbEtFWHRyU3FLaDhLMUJYWXVGY0VtUWxRZGM0cUZHVEJSZVFXYTlpQnc5?=
 =?utf-8?B?T2dwaUM1Vm5oT2NGdC9RWVNLMW50WWo4amsxY3BycEoxNVdsTGVzZjF0TVJr?=
 =?utf-8?B?SmZZWXd5cllVKytUYlo0RDdrdVJGdExLaFJtbU10S3Boei9XL0V0L3FoZU42?=
 =?utf-8?B?cU43azBwT3Y3RGVJV29xR3BjZEcreE9EeTNQNEVTeVZIeXN0YS9CS0Nyb1Js?=
 =?utf-8?B?eGswT0M2OU1wWmxRMkxibUhLSVdWc0VQYnVMUjFwLzF4MnJyaGNDYVZFOUcw?=
 =?utf-8?B?WnliV3BKbFlZTHBTSWRkUnRlOHBrZk5Rc2YzeTY2K3VRZFltcWpzSExUU3By?=
 =?utf-8?B?VjBXZ1dLMW0rajNGN1ViaEhTRWFKSmNINlRZNy80SU1ac2cyMi9ZRGM4UUFN?=
 =?utf-8?B?MEdQSUVmVWRtM0RVc2dlMXZQbjFTd0pZZ0dBZ1FlTzRBLzVZS3BMaXFyWFFV?=
 =?utf-8?B?ajc2eUFYL0loN1JPUkk4K0dvanI3bThwdWczL1UzNW42UE9SeUppRUJYbEZj?=
 =?utf-8?B?VEtvU21ueSs5YXVZV2ZJWWFBQzBscENoVXp5Y3d1ZUhndmpUNndYamx1eEM0?=
 =?utf-8?B?WFlrYzZ6Vnd4UVArNER2QzJLeFZJbS9mV1AwSmIzbm9PaGNyUDAzcHZ3dEg2?=
 =?utf-8?B?b3JKWk9VYXFiazNhWUIxcHBBQUxKRHB3OW8wWnNjMzRqTVNyblMydkRWTkts?=
 =?utf-8?B?L3lneHRWbndMTktrU3VhVVprSHBrUTNsZTdkRnQxK095VkFSRW5RT09IQXBv?=
 =?utf-8?B?Q2VFc1BqSmE2T1FtWFp3V0RZVmdwV3hvWFU5L2hQVnVrTlp4MXZiU3ZPL2Qy?=
 =?utf-8?B?RmNweWZZdmpnUUFoWUMwcXFnczBzb1VFeWdUbEFvV1c4T1l0TDV6UDJpTURU?=
 =?utf-8?B?c2o0aC9jdTNKZ2pleVhjYnRlY2dEbGYwL05XZXNyQ1ZtTEdxbHlQSERmcGMy?=
 =?utf-8?B?Ni95S291UHhuMzMrSHRVUEg3MFVqbDJSY0ptRldycVlIZkZBa09EdVVVMVVN?=
 =?utf-8?B?Zk13aTBFT3haMlRycW85K2pDTFJuYm5vT3lLQ3NidWVraGxVN0E4a1JFK2Rv?=
 =?utf-8?B?Vzl6K013U0JFZTdwNnVNWkVHWi9QQWxTemNMZ1ZXVjU5ajZYVWtvL1hmd3pZ?=
 =?utf-8?B?NGJNN2duWnlEamZkZFdiN0pZb0dpZERvMytzTUR6RFpGd05KS3hXUm50cEZh?=
 =?utf-8?B?ODd6cTk2b2M4d2V6UGF5SGV2Wlc4bWZqUFRiNkFLYVBVcUtic2tOa3RsS1hS?=
 =?utf-8?B?YzBjVTdVa1I1dHpSdXEyUndnRG5CanFlREh6c2lLSDQ5MElZbE5pVlNlSnhh?=
 =?utf-8?B?cGV5RWhMYk9NUFF2SFcxdzFkWElUNzQrbnFDdWthdXdhVjBnU3U5dHg2cHVo?=
 =?utf-8?B?bXU2eitHczhlUStxWWdjSExuYWM3Z3FyWWFuNmc2bEM4dUYwMVhOeDNxWlAr?=
 =?utf-8?B?RlB1VHVlY2hlSVptWW9laEdPZHJyYXU4STJQNlBHV3h4SWl2NVJaZlc5dXRZ?=
 =?utf-8?B?Z0JlbzMrYzF4TGtyUUdNRDlzaGU0Znd3ekRxaHdOZWZsNFdSaEZoSXRqUko1?=
 =?utf-8?B?Z3pRRE91ZTRjWnRXZ1ZQTFdCQXNHNGwrZjVXRHl1OExUNGQwdlQrdjJIQzlh?=
 =?utf-8?B?dkZYYTFuSisvaTA5NWttZVBNZ1Uvd21Vb2ZqWXZLakRTb0dSTWJlb1I3ZzU2?=
 =?utf-8?B?SXJqMTQrY0NXZnl1NHl5WWZKWXpSK3pkL1g3QWlPSUxUZkVoeFdQS2pmTEFU?=
 =?utf-8?B?bVdKVWErdTBJa2xibGRCZkJOUk1EYURJR3lkOXJ1LzRZaGVGd0JDTmh4ZGRi?=
 =?utf-8?B?MkhyWDN4YnRUNFVYdEIweCtZRTJhVUUxemg2RmJXMW82UVkvM3NGUFVXUGdh?=
 =?utf-8?B?WWtLQUFxZmxJNGI5WmVrVXFTWHpGTXV6VzF4OEQyNUxCbWNVZmgxN0pZVUlr?=
 =?utf-8?B?bWdJQlZDWUpPbDFRUHFYRm1wREkvK3dUM0QweHFTYTVwQndRREVINnV4aEU5?=
 =?utf-8?B?ZnUyMmFZZWVKU3VtTktFZ292UExhZWF4Nm8rSU1na0g0VVc0ZGJKNFJtaDM3?=
 =?utf-8?B?Mk1UMmcrNFp4a1RsVHEyRFhFZmRVLy92aVZ0dDNkKzNlSWt6SVBaRDRpUjhm?=
 =?utf-8?B?cjc0d0QxQnV3aDBZNnN5N3FtaTFpMTREYUExYWc2c2dDNm96WnQyT3V0bzVm?=
 =?utf-8?B?QVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76c5a547-f5e3-477c-3d02-08dadd0a1bf2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2022 13:01:11.5867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BT3Inp8+ZAw01AO8FcirM8eOcQcq1bsXO01ISAh1lXVJUGvtOa5ZB3IqyByRKvG+xEhOp9pp8SLIG/ZxHamY1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3143
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 13 Dec 2022 13:01:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10214

On 13.12.22 13:49, Jan Kiszka wrote:
> On 09.12.22 15:58, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> This new revision allows use to check if an update is already installed.
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>  .../swupdate-handler-roundrobin_0.1.bb                          | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
>> index 5801113..b39278e 100644
>> --- a/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
>> +++ b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
>> @@ -13,7 +13,7 @@ inherit dpkg-raw
>>  PROVIDES = "swupdate-handlers"
>>  
>>  SRC_URI += "git://gitlab.com/cip-project/cip-sw-updates/swupdate-handler-roundrobin.git;protocol=https;destsuffix=swupdate-handler-roundrobin;name=swupdate-handler-roundrobin;nobranch=1"
>> -SRCREV_swupdate-handler-roundrobin ?= "bf73f04b1eec0b8714d3a1b56bfcd1431c58ba10"
>> +SRCREV_swupdate-handler-roundrobin ?= "bb35127231ec08a67f79a7584ccfc0cada88cc4e"
>>  
>>  SWUPDATE_LUASCRIPT = "swupdate-handler-roundrobin/swupdate_handlers_roundrobin.lua"
>>  
> 
> Should we also bump the recipe version, even if there are no
> corresponding upstream releases?
> 

On second thought, not critical in the given context as we should not
expect anyone doing packet-based updating for a target that does
image-based updates. And I hope this separate recipe is gone soon if we
get the code into swupdate directly.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux



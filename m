Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5219CC4332F
	for <webhook@archiver.kernel.org>; Thu, 10 Nov 2022 14:06:21 +0000 (UTC)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (EUR01-DB5-obe.outbound.protection.outlook.com [40.107.15.42])
 by mx.groups.io with SMTP id smtpd.web11.7909.1668089173029631491
 for <cip-dev@lists.cip-project.org>;
 Thu, 10 Nov 2022 06:06:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=vG/JqZgs;
 spf=pass (domain: siemens.com, ip: 40.107.15.42, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZGY4r5vnnlxvDRjAyMBvPcOoxVCTsuAwsq3jdMzj9mbcC49dh7yuaoREkXwl8JG+TR9TXLaKyc/fQllisSx7Yh7ja4w3lpH1Aa1p6WwLWtVSI0OkUGfQlbA6eKNzu7R3r7SJ6b5+VpeF5oDHKT0vZc/+9my1F0zTqy4S30ujGSKoIYrCRcp8W1mWDY3FLq2iO7lMtx80bmaXFVPuSbpjaI5Spm2FkbDOroZz32L+9khCTUu6Ctwzw6LTNJg6tEIHH0bYTzlNHIp8srL5eYxkNuwJv/oxKO8C5tjvP86+MEGADuSPK4U3tO5A602/A7CCIEqRXNMVuJMK7Kgizzu0qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lyMA8Cxh4dMqhofIWn5gRVepbr4vOP8vOJwyQ4CJRWk=;
 b=BdEVjj8T6Tyb61Eu/AmulsxEVrM3NWddKgKQcKt1WWFwBeWXQ+f8CC/zBcgm8UdO3TVTxPY/0Vkklyc+xVOBMEU1ZgrEUPNH2OLCJUeuusfl3q4nwACrX2TatEBscmkjOof3Hw2Js2oIfcTtASE5qUxlF6YKHbxTOa9LoK+qVR5IQOUH11v2hEmf1GztD+EQpmV7QQ2PnvXUJRxvESYJdWbWTLhPHgYPLNyr45xZvDcIMZSfU+O3fEt+4lC9jYnfBORhIzC8LLqV6s/o8Gk9mRWxYe0ztKrvk2wTTbciPnuW8d9CSebULHUGxqpKU7MLk55sh0Gd3Ac6kdHKuDcvZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lyMA8Cxh4dMqhofIWn5gRVepbr4vOP8vOJwyQ4CJRWk=;
 b=vG/JqZgsTq+rsoywVs8iMspTegJ/1Ff6OYznrOcm1GMpQU8TriWg89PWbdtwS+BDwo4taV5qD2KANnJCOR7TS04Nc8guir4ElrQGRPrYCdHAivUwnTuYJcNuNThTf06jk6co0LgUjHEyuzK7j+Npu+ISIOmLfIOiBmkAyBQzbg36RteZHaxqMPzeFQgiK+uq8sefnR4LM5+y/bnCSELtLc0fW8TpMrpaJ/A4fZ1UzRd13ZSN5Ffq2lcSrB/TLOOKufNmJSRf4eu+z6PDIMZZEWB3auJ//8gR5qvqztljBBmp2F88AQ0LYzukI9eTWsz4egfi3Dz8aUJ3Z+pp/CKmJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PR3PR10MB4096.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a5::7)
 by AS2PR10MB6711.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:55f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Thu, 10 Nov
 2022 14:06:10 +0000
Received: from PR3PR10MB4096.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::943f:70f7:47f7:be5d]) by PR3PR10MB4096.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::943f:70f7:47f7:be5d%3]) with mapi id 15.20.5813.013; Thu, 10 Nov 2022
 14:06:10 +0000
Message-ID: <1bfe0c98-28c7-8984-e9a1-e128a0d86d8f@siemens.com>
Date: Thu, 10 Nov 2022 15:05:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [cip-dev][isar-cip-core][RFC 3/5] swupdate-handler-roundrobin:
 add uuidcheck patch
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org,
 felix.moessbauer@siemens.com, christian.storm@siemens.com
References: <20221110124503.274124-1-Quirin.Gylstorff@siemens.com>
 <20221110124503.274124-4-Quirin.Gylstorff@siemens.com>
 <a175683d-f5a3-34ba-fab7-5014d019dc21@siemens.com>
Content-Language: en-US, de-DE
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Organization: Siemens
In-Reply-To: <a175683d-f5a3-34ba-fab7-5014d019dc21@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR10CA0009.namprd10.prod.outlook.com
 (2603:10b6:610:4c::19) To PR3PR10MB4096.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:a5::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR3PR10MB4096:EE_|AS2PR10MB6711:EE_
X-MS-Office365-Filtering-Correlation-Id: f07cb5bf-f924-477a-2c8f-08dac324b845
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	bpmSpuxYvTUlCPTOT6wVylxzpK6rs5y9PIKeA2cms8WCVadQgFvke/bTFTY43P1TOX+UW/wvt8mNX1/zaWlehRr1zF6kdd3QB6KsgDAIP5lYbbHuPPY/q6awk3QNiPZwsYZGqfvQDcaktyqtXYkvwzAk3BTEqb62g+aUpDjvKhDhZNzaBqlqdfgX8/NUSna1VnBNaPSUQ0eDM5V+rJ9y9s0+8ESEYVtolJfj3NhWTeaMbMmFsqkyn00nGwMoEmiBnhDyVfAPTS7bqBn+QZQx6mfdhvARMXtIdMl8VLoiDlzEFfLEeKsmtIUle6SlZAdQcGMKKvnDvc+DL/ekua0XKBTFUbGNXYLtIJ28iReb9/6xP9kwBtW64RFHybm95GxWMsue94/RUAv/QBXxm6clBMe0zawGgSqsTl+hyGxgHUb3lbqNCaR1C0utPz7X8WjDCunBpzeL6gQtijm+bcN4dqHHSJa3qFSw613O9DRkaw8zqXK51qQcLHhZHBewixgPqOJE0qjbsxmAcYvnEqVcKoJSs7SeMUNNZRyzCPWsxCckZvaqnY0eOiEXxqaGFDPith982oBslMgHraj+VLbR0fE6Ee0JpoUrwS2OIFmE13fOzLHQYd0O4dAoIEfuqhv7fO9xCzpmLcM3nU4TrEd7RbF5l2w8MMv2NSVQxkF2poRyhUWfufWR01KAM6TB8a/RU15V2n7CHozyJ6FRsLqtGPZdcX90O8A3+IF/j7kk8/P4Mk3oBYBzAAzxv8EnOZguJBJdJFVAXkHUApjHte7CSlSHzQ6uTZIU1HkVyRQlYtU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR10MB4096.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(376002)(346002)(39860400002)(396003)(451199015)(6512007)(186003)(2616005)(31686004)(6506007)(53546011)(6636002)(36756003)(83380400001)(8936002)(8676002)(6666004)(66946007)(66476007)(316002)(66556008)(82960400001)(41300700001)(478600001)(38100700002)(6486002)(2906002)(36916002)(31696002)(5660300002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WEkzNWhqbks4YUNuWkU5cGZRUVQ3TFh6M2laTlJhVzZaWHd6YkJEYWl3Yitm?=
 =?utf-8?B?QjE5YWxDQjZkS0JBT1AyRUh4S2d1VW1NSDdvM05Xd2NSTmlHU2VBUkFKd0Jj?=
 =?utf-8?B?SEZuV3hwUi9ZNHVTYklUYnN3bEd5MlJMcTFEYmNpcnl4SHRpcTBNOWNmS00x?=
 =?utf-8?B?dlp2QlRTMFgzRHhXTHJYYnk3bzZhQ1IyWVVJd1JUSnFUUU91TzZFS29lN2Zz?=
 =?utf-8?B?NGY0MHdWMkF4M0hMNVBPWTBXdGlLNlpXYTJwMVQ2a1NmZEpHZ0FOMm53R0ZD?=
 =?utf-8?B?STlMbXBmQ25sUDJ1Z0p2eUFIUG9LTWs5YWpnVVZXcEJwaHkzY2lwdms3NEFr?=
 =?utf-8?B?amxCZVlkRXhsQlJrbXlseWlXQVBIKzYxY2ZOL1ZPWnZ1QlJnaDRNRTZ6ak4y?=
 =?utf-8?B?bFZhY1EwWEk4YmI5ZzNMZERCcVMwS0t0cElvNmZnTnAxZ2xUVS9OWm1CeXlP?=
 =?utf-8?B?MGdSVUp5NFpNNlJPT0tYU0xtQU9Ed3hicUV5N0lDZ3RxVGc1S2ozQVhpOTZC?=
 =?utf-8?B?NzdlU1hYclNHY0NYU0x6TWFyZzdQa2poSTFSdm15eUdXdEdKL08xSGVUNG1X?=
 =?utf-8?B?TUVGRWhTeTZIUVpYOU50SHpsdzBwNlVZVHZSMzVBZk9qVW1VTEg2WW80MVN0?=
 =?utf-8?B?WTFRWjVYM0doRnRGR1oxcmlJcHduWmxJc0Z6Ujd2Y2VadUxOMU1zSWYxUVc0?=
 =?utf-8?B?ckhGTUZ5emJFakI0UDlhenMyQVE4UHRudE52bUMyQmpJN1JXVkRVQ2kraStD?=
 =?utf-8?B?Z3BYck1xanZINlRxdzk3cUxXMVJGMlVxK3FhOHJ5bkZ3Vis4eDh5QjRYTmhW?=
 =?utf-8?B?NXN2TVM0Z0F3Q2dQZnBkeEgwemhsaWh0OEhSa2dRcDNhRkJCb1NsaE5xOXBC?=
 =?utf-8?B?eUJKNEU0OFhCaFNxSzU5NlExL3pna0U4d3o1d3ZVRXROS29TUEhZNnM1ZjRZ?=
 =?utf-8?B?eVU0N3JaV3d6UklzTnlFWjRUZWVsV1VTNExNdTY2d0F6U2FNNlVtdzFJREg1?=
 =?utf-8?B?Vzkrb1VxeDIyYVR6ektrMXRtS0ZjUUU4NjhOL0dsZVFhd2ZPcmhBeTR0RXVJ?=
 =?utf-8?B?Z1ZzSXVRQ3RDM2M0bXAxYS9LejNFdnI2U2JpRVRSZGpxOEVqSjEyemtCQk9p?=
 =?utf-8?B?MWNhRWwwMjhCL0pCd0J0eXBKN2hYOTRhTTE0a29QRjJKVHp1V25ON0JTcVlD?=
 =?utf-8?B?TDVWWUtQeWM5aThGVmZPNjJWVEZLekJjRjlIWmxIMlpKMTF2NGNrcmVmdFZw?=
 =?utf-8?B?cEtOdmtleUgybHlYeHFxMTcydTk1b2JWSUd3SjRRS2sxdktRdFZrTnJPcys3?=
 =?utf-8?B?L0tVYzlTdmNYSWw3YjhNZkl0VzVBa3VJelVKYThIb290RDhFdi82SHUyL2lp?=
 =?utf-8?B?dmRFSHdDbGdubXRjWWFERzBZbGs1S0FNNEd6TFNua0Z0Zmd4UVRMaWZNa25i?=
 =?utf-8?B?RWdwMnRudnljRTVNM0tyNWhtZ0pIOUEvNU01UmlmelYra2xHN2RGdEg1R0FZ?=
 =?utf-8?B?U2dKalVNLy92enhZMTlEbVlPaWxjd3BPS0l0RUpHMnZGUW5oYW5EME5ZNXpP?=
 =?utf-8?B?dDNMU1ZHZmVDL01CY01wRGxzTGc0ZjEzV2h2d3pnaC9Qc09EYU9zY3VKYnlr?=
 =?utf-8?B?ZXFoanoyVXpjVTFmZGlTODNpMks4Q3d3cFF6S3JueGpJKytOM1dKeG5mL0do?=
 =?utf-8?B?VEptQ2hoUjJDUWtsLzI4aDB6NlhFYmZPZTZsdlVDSUxNRjBDYUl1TU40d1pv?=
 =?utf-8?B?Ri9KQTdnR3htZ1E0aWJrQThpcTBTQVM0bDZwTDRxekkyUVRGaGQySERoenNk?=
 =?utf-8?B?dG1pcXNNNks2akorQmJiSXUwVkNJekdIK1RDK1d5MnNLWlpXQ2JQQXFIUVVZ?=
 =?utf-8?B?WTBxZ0dFZHZFRGlUWHRWWHpVU0N5eHlPUGxjdVl3blAwc3IwT3F3enFKVWph?=
 =?utf-8?B?YVkyMmkwY1dmbGo4bWdZSGJ4YmRkRzAvMXk2V0tXeWNYb1lxSFVXOCtPVUkw?=
 =?utf-8?B?TkdDbjlYckE3bnpRazIxR1Z0ZzNsaW0zWWltK2xpZE8vc1FDMnJnbmxpaElR?=
 =?utf-8?B?enlWUjYwRW4vSmlVQ3ZjQWV0VWZ0czVETzZkOXB6dURPemtWMXNPd1hOSldj?=
 =?utf-8?B?ZmR4Qjc0KzljY2xZYXZWeUd4ZEduUjdwWGk4aXhEbEtsai9HN2ZuTjRjTUdH?=
 =?utf-8?B?MU1aMVZObUNSQWcvcUNiTWxpQU85WWlNVTNOSXY5R1lIcnlLSTR2Umt0MWF0?=
 =?utf-8?Q?+jsR1NDmhLjOcBq2BCIQ1SaFH65RLNdeIh2Q5ipW0o=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f07cb5bf-f924-477a-2c8f-08dac324b845
X-MS-Exchange-CrossTenant-AuthSource: PR3PR10MB4096.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 14:06:10.6313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zje4ldudfQgxsRmY0SPTXA5NrNSB3P3aBEcP9t93pUmok8MKi1x2HUM1O8jJLXhKBKobxieZQnp9Lk7lciWVRI5Vd8EQ9oxzv+Wg0hqXPxI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6711
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 10 Nov 2022 14:06:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10009



On 11/10/22 14:52, Jan Kiszka wrote:
> On 10.11.22 13:45, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> This patch adds a pre/post function to the swupdate-handler
>> roundrobin to compare the uuid parameter from the sw-description
>> with the uuid of the current system to avoid a updating with
>> the same image and breaking the update cycle.
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   ...-add-uuidcheck-to-roundrobin-handler.patch | 43 +++++++++++++++++++
>>   .../swupdate-handler-roundrobin_0.1.bb        |  3 ++
>>   2 files changed, 46 insertions(+)
>>   create mode 100644 recipes-core/swupdate-handler-roundrobin/files/0001-add-uuidcheck-to-roundrobin-handler.patch
>>
>> diff --git a/recipes-core/swupdate-handler-roundrobin/files/0001-add-uuidcheck-to-roundrobin-handler.patch b/recipes-core/swupdate-handler-roundrobin/files/0001-add-uuidcheck-to-roundrobin-handler.patch
>> new file mode 100644
>> index 0000000..f2392f4
>> --- /dev/null
>> +++ b/recipes-core/swupdate-handler-roundrobin/files/0001-add-uuidcheck-to-roundrobin-handler.patch
>> @@ -0,0 +1,43 @@
>> +From f093a3a097e518ef9f74ff88eafa9259ba50626f Mon Sep 17 00:00:00 2001
>> +From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +Date: Tue, 8 Nov 2022 16:08:25 +0100
>> +Subject: [PATCH] add uuidcheck to roundrobin handler
>> +
>> +Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +---
>> + swupdate_handlers_roundrobin.lua | 22 ++++++++++++++++++++++
>> + 1 file changed, 22 insertions(+)
>> +
>> +diff --git a/swupdate_handlers_roundrobin.lua b/swupdate_handlers_roundrobin.lua
>> +index bf9c997..bb24fc7 100644
>> +--- a/swupdate_handlers_roundrobin.lua
>> ++++ b/swupdate_handlers_roundrobin.lua
>> +@@ -726,3 +726,25 @@ function pp_mmclock(when, device, image)
>> +     swupdate.info("%s: %s MMC device %s", logprefix, when == WHEN.PRE and "Unlocked" or "Locked", device)
>> +     return true
>> + end
>> ++
>> ++function pp_uuidcheck(when, uuid, image)
>> ++    local filename = "/etc/os-release"
>> ++    local filehandle = io.open(filename, "rb")
>> ++    if not filehandle then
>> ++      swupdate.error("%s: Cannot open file %s", logprefix, filename)
>> ++      return false
>> ++    end
>> ++    osrelease = filehandle:read("*a")
>> ++    filehandle:close()
>> ++    image_uuid = string.match(osrelease, "IMAGE_UUID.*")
>> ++    if not image_uuid then
>> ++      swupdate.error("%s: Cannot find IMAGE_UUID in %s", logprefix, filename)
>> ++      return false
>> ++    end
>> ++    swupdate.debug("%s: %s", logprefix, image_uuid, uuid)
>> ++    if string.find(image_uuid, uuid, 1, true) then
>> ++      swupdate.error("%s: Update already installed.", logprefix)
>> ++      return false
>> ++    end
>> ++    return true
>> ++end
>> +--
>> +2.35.1
>> +
>> diff --git a/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
>> index 65cd652..447a093 100644
>> --- a/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
>> +++ b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
>> @@ -13,8 +13,11 @@ inherit dpkg-raw
>>   PROVIDES = "swupdate-handlers"
>>   
>>   SRC_URI += "git://gitlab.com/cip-project/cip-sw-updates/swupdate-handler-roundrobin.git;protocol=https;destsuffix=swupdate-handler-roundrobin;name=swupdate-handler-roundrobin;nobranch=1"
>> +SRC_URI += "file://0001-add-uuidcheck-to-roundrobin-handler.patch"
> 
> Can we upstream that directly? It's a CIP sub-project - should be doable. ;)

I will do that soon.
> 
>>   SRCREV_swupdate-handler-roundrobin ?= "fbc8d8a7e4ae8c381198cab81ae3fb13398a028e"
>>   
>> +S="${WORKDIR}/${PN}"
> 
> Unrelated or even unneeded change?

It is necessary for the quilt patching as without it the patch is 
applied wrong.

> 
>> +
>>   SWUPDATE_LUASCRIPT = "swupdate-handler-roundrobin/swupdate_handlers_roundrobin.lua"
>>   
>>   SWUPDATE_ROUND_ROBIN_HANDLER_CONFIG ?= "swupdate.handler.${SWUPDATE_BOOTLOADER}.ini"
> 
> Jan
> 

Quirin


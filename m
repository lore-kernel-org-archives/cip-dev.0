Return-Path: <florian.bezdeka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2281C433F5
	for <webhook@archiver.kernel.org>; Tue, 11 Oct 2022 18:51:22 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.79])
 by mx.groups.io with SMTP id smtpd.web12.11486.1665514277827671318
 for <cip-dev@lists.cip-project.org>;
 Tue, 11 Oct 2022 11:51:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=WZR0r2t+;
 spf=pass (domain: siemens.com, ip: 40.107.104.79,
 mailfrom: florian.bezdeka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nxoRPlvQeyRKkaduVTvPV1B4GUM7rKgw8nNkhWJy6W9T9RSfIU/6Sd0xGvK/fZ9IAr/I+r+cN/XMjdTRBlRM3CW8cCEn2NYL5Yc/hftpdbxS0yE5nNmbAht4VCk2kelDFadqRt8cdckPlAKGxcUkBt38hWxktwuJkIkCy7o0Ykzjm4k+huIpzvUxQx/wFKWKETYT/DT9QcHDWoV+Smce3hJWaPYA8SbRH6cY+kPspiNm8jJ/pM31djf6geno08VtmkMV9+oA3vrhGFzslVwQg140fJhjvQAmQ19MLL5XTb3GeTj/gkMqPK6JdhPIeaM23uKmrAjJypiVY/rHHhmlWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PU6wGeHDm0HFZZdxp+wbh4mgE3YUlHB3JtIsoZ740Z0=;
 b=n7b42fAJWHcUbfDjYDaWuh7icXng/6KpDoHgvWE3YS3BWbRnzyjo1wwRiltpuCCOqLsXdC4+xwi7R9GXb6Xp6ghgBZxLYiSmr+szTydrRsEDVl3fcYSl8v7vDZ/YcvEAlHds15GXbmdnhOPzVAPuZoQ+q9j1Bat7JQ8kznpGJcuYi+vxdYM7787w7uaBcwVi+Nqj9Z7mcImre5uJthd3pzRpf/gETO7zvb2waiP1fus7bQdTsVQ4JpIbCMDJKYsLY9x0x0hOPKZCj0FVJg9wIhTBxt8EJQ7WL+4bZyBhVvf0LOz5BhzVUYq4ChI6SPnjlCgvc6mfbGgSx/GpgKSg4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PU6wGeHDm0HFZZdxp+wbh4mgE3YUlHB3JtIsoZ740Z0=;
 b=WZR0r2t+18gh1w2qOzx8gVC26OToT2UYdI1/pdyE8cE05sLh0k66NKzAcSkPyAI4WF9yUIM0f6sN5MG1Gi/6J3ZW11kjeJobDZ8k/uM1DOrQEJm6qmDCZo/3fogcr3q0kq5rf9JTPtFjTFHX3zvrR/FUytWQb9mA39s6Z2TDcceQYZYvw/Ue4jI0Snwh+u8techBa0bsf5hmdWAXn9TEue7mnSmaUZTFDZkxGTSNpJ3xXabqL4+WlE6HY9nF11xMAO4JZHdxiSesZTiz59wpt9HkuDao9nL4CvFGU1a9nUps/jKjPT4SMUG8UlO5lW5ObSRCfdBuZU8MwcrWXQbtxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by DU0PR10MB7434.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:422::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.19; Tue, 11 Oct
 2022 18:51:15 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6416:1d68:9fe:76ab]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6416:1d68:9fe:76ab%3]) with mapi id 15.20.5709.019; Tue, 11 Oct 2022
 18:51:14 +0000
Message-ID: <af98d87b-b1cb-9123-fd61-c0e06004b7c4@siemens.com>
Date: Tue, 11 Oct 2022 20:51:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [cip-dev] ldconfig segfault on RZ/Five was Re: Preparing
 isar-cip-core for RZ/Five
To: cip-dev@lists.cip-project.org, Jan Kiszka <jan.kiszka@siemens.com>,
 Chris Paterson <Chris.Paterson2@renesas.com>,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Hung Tran <hung.tran.jy@renesas.com>
Cc: Pavel Machek <pavel@denx.de>
References: <38ce5ead-f7b8-e8f0-52a3-dff81f0f5045@siemens.com>
 <964bc8ff-9118-77b9-118f-6b979cedbb8b@siemens.com>
 <b6504b75-d609-d46b-55fb-3fd2b00780c7@siemens.com>
 <20221005182151.GA16437@duo.ucw.cz>
 <d9228cb9-e1de-dbdf-930a-ec35fbae4d3f@siemens.com>
 <20221006114326.GA21855@duo.ucw.cz>
 <4d6db8d8-3d96-6969-f551-baa94f865fa3@siemens.com>
 <20221006220740.GA7670@duo.ucw.cz> <20221006223251.GB7670@duo.ucw.cz>
 <95aed7d4-b775-7273-9478-b0d9ca77938c@siemens.com>
 <20221007101932.GB25429@duo.ucw.cz>
 <66be9e25-7b51-14f1-6a48-352eb748f689@siemens.com>
 <8492e784-1af5-5584-1109-63c9aee53cab@siemens.com>
 <OS0PR01MB59228F2E10391C505F8C8CB586219@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <d0ace49c-29a7-baf8-ba7b-bc385df68492@siemens.com>
 <OS0PR01MB59225BD41E0A32CBD136C68386239@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: Florian Bezdeka <florian.bezdeka@siemens.com>
In-Reply-To: 
 <OS0PR01MB59225BD41E0A32CBD136C68386239@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0149.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::42) To PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:248::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB5712:EE_|DU0PR10MB7434:EE_
X-MS-Office365-Filtering-Correlation-Id: 6871bfcc-80c8-460d-48c1-08daabb99265
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	CMMwwKnA+KatvatCTUS+uvM9yXQ5PDBxjyQzL3C15135kPG4TBqRQHi+7j7groD4tVn+g4h71XQ2c6g+Stbgm4HBihle3FpBndoIpmTfA7CEnkdrpo1DpxieQPh1wDJPFjVmgYfCD5M54od7qRynB/ms0DHSAQ8LTnDBrEcx95kAA2/dA4JQ4veYXrNr+og/rHUpgiY9cu7uhazB7Re7zfkDoILGawBy0zQyvXeJ3PL77uLCr3OqDyQZMh+0LUWbRCtsXBCXBU+8UfZmPQ4Yo3w+hqyue179vpOrP3ah7WyeI9Xi239kJRBz89eXP2MCWuvbvTq+WS4gNzqpusvd4j+lBsTPdAVMimbQOHXNamqAWB95q9iGuonIXgfUqFqwMmvH7rBbfhBtKJX3XAjT4BuQZAupAZNeRlmps5NkJNuYmigJ7Te/NemEO9/iBXuH6UxiewN6ZeGUToO4VgoQPCvlawOIyJBmPXDmYDVdMB46owxsmxRUlQbG/Nfi86/iMnzURfcwaJVos8OIuSiZhSl3NqUSKYTN1tWP7foi3dZtwGNMPJXYR+i08UkCYc0aeVQW0Y0pKyljOLU4Bgr7mlsYgfwTq3rPVisksnXODLWy7OdxzxxaKylEU5eWNctWakFtvoPzld9HMGy20SDdPS4ZgcEBYCQEA1VihgK0c+phGR01Wdle43SQ+i/HHs86KyiUFngDHdh3JC38B2P90TGDQGwEW2N0QxWi3o7AZDp1xyHlqUXbVAXB7Mw25IE/lbA7LAJUNke3krIuFEF6bfbfXPOEADeIiggGG2QQFkPVB0OMN5cAgl0jxv320CxKduEl7023cP4FePalVw1UIw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(396003)(376002)(346002)(366004)(451199015)(66899015)(6512007)(31686004)(316002)(38100700002)(6486002)(8676002)(110136005)(82960400001)(36756003)(31696002)(83380400001)(6506007)(2616005)(6666004)(186003)(53546011)(478600001)(966005)(86362001)(5660300002)(44832011)(2906002)(8936002)(41300700001)(66946007)(4326008)(66476007)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?R0o1cnFYYkZ1VHgwejRZc0hrMTd3SmE2WkxNQjB6RmRkQkVIbmRDY0FuSGRw?=
 =?utf-8?B?YThEREV5cko0N3U4b3hydy84Si8yUE94RDZnQ0ZGVnBwTEdkNTlPU1k3SWtz?=
 =?utf-8?B?angxakdhYTVGaWdaclZ3ZzJzNlAxcUpROTZIZEZzWGxFbHA5RDdYeXczc3Jy?=
 =?utf-8?B?MHEwcjkxMWNCUjg5OForblFKNkZRM0Z2OW5ld0lZTmo5U1JtdTArN216WE5z?=
 =?utf-8?B?TDErcm1IT0R3ckNhUWdLT2xGL015QWdsK0VyM3B4dXRTUFNnbm1xNjFPamVk?=
 =?utf-8?B?b1crd2pkUzEzbm5mbGRxQllRZGRjZzZ1OFc5a0ErR09vUlFtMWpoQnY3cEdG?=
 =?utf-8?B?bEZPWUFNVFdBR0xYSGJmNHBJQ1g5WWdNR0JRbTRWdTkveHRJejJhb0JzK1do?=
 =?utf-8?B?Ty9JMUxmT2g3V25QUUszVEZtS1pvSXRZNDV6c1ZRVzJZajcwS3BpVC83WXgx?=
 =?utf-8?B?SXBKZHd5NmRsUjVMYm53NTlvYUY2NjZWcE92WkV0ZzVRSisxVnFjbjdNQzU1?=
 =?utf-8?B?RnlvaWhJaVRQSFpuaC9XKzNnVSt6UVVEQXNmMEQrd2dzSklGN3BuVHB3ek90?=
 =?utf-8?B?M29JbVdxaVpTbm1XVitESElQbUhIOUlzY0ZLN0w3NmM0NG5rNEk3Q3NidUVy?=
 =?utf-8?B?d05BYWV4Y0pmdUFHWkpxeHlLNGtTTXorMFh6VjQ2VkhWUE9EWmNDeGNmUGZp?=
 =?utf-8?B?QlRPVnhmZi85YW9RTkY5emxmVTdRV3VZN3BjVjlYY09mejRheC9SQXFWdHdK?=
 =?utf-8?B?bW9TNDJ6WXEwV1pLM2RUSjVIVkRxa0Z3cXVaVzVJbStPR08vZzB4c0JSNmJE?=
 =?utf-8?B?Y2JpSEY2THJnTVdiVEQ2NzhFaFFUTXZZczZvNDd3cDd3K0VBaHVhZzNwcDBF?=
 =?utf-8?B?dU1ieWU5OFZVRDdUdWJDK3ZoRnRFYllQSEkxQ2tlRmd0d0RJOWFCTlREWk5T?=
 =?utf-8?B?ZjlCZTA5ZVJERGU1UElWNm9UR2lqbUh1YmdCYVZBM3Vlc0ppRFp2a1FJK2U3?=
 =?utf-8?B?QnlEZU95Y01tZnJiMm1KMnFnSGJWVHR5bklRMXZSSlZMRktTd080SGtPdXIr?=
 =?utf-8?B?eldyZU10bkNjWWhNYXRTZUE2bkNNVVlrc2lVbnJHa092Z0FQWHZOdmFleGIr?=
 =?utf-8?B?L0tnM3R6ZGhrV1hHdEtqT0FiVXpNSTRPYUJwcnhjZVMrKzI3RTZxcis4ZWFX?=
 =?utf-8?B?UFFJYS81Y01EdXJJOW9mTm5zYUpPWWpDN25CbkY4VjFuNHdxY0VCYWlnb0Qx?=
 =?utf-8?B?cmJyT1hxSiszM3RodHlPYUJnZytPQkk1OEtBVFNONTNFWlY0WXFuNDBnS0tw?=
 =?utf-8?B?L1c4MnJwZUhBUDBqMy9jLzVtVmVjU29mV3NnbnZSdmNiNkk2Uk9GZGhLUVFk?=
 =?utf-8?B?ckZQT2dOU0Q2bklCaGxrRmdBVmpFTVBQRG5HUUk3TWRvL0x2dkhzaHBpOHE0?=
 =?utf-8?B?amVtRGpkQlJaUjZ0Z0dOSHpWdTZpS1g2bUJYeFBIVkU2eVZLSjRXaGNtVkh2?=
 =?utf-8?B?WFBlSUhYcW9jRVFCRW1RWXVOYkY2eDZlZG9Cell4bW10dVhzMXdUZVRVVWlE?=
 =?utf-8?B?OWljNXhwVkYzOXltREF5YktrbWllMmZDRFNjOGQ0WURzSm9wTkJBS0FVY3A1?=
 =?utf-8?B?UCtHYU9IbjJFdVFZTU51QnIxKzhSZlp3bm5Ib2YyUUdReGpDUXY0Z1BjMFBo?=
 =?utf-8?B?Z2hLYll2S24zTjRUM0pKeFEzaGUwT0ZobTR4blNMN0UyTXRSeGh2OHh6RG8y?=
 =?utf-8?B?K2kxUEdBY0xQMGwvMFlYb1dHckNVN2RnVHl2VDEzMWxnYk11WGFVWG1jc1VS?=
 =?utf-8?B?SmRZQ2NDUURhdmUrbm94NS9vOERKRHJwSlNXR1dzS1pSRm9DMTVFZW8vbXlD?=
 =?utf-8?B?Mkt6MzMvVkUxUENuMEV1NHljeUR4bTNNcXFzZXRkL1dud05nR2NvOWdhUTJQ?=
 =?utf-8?B?dlJKckZxZ0t3VHBjcE5NMUZsMWE3TlZ0T296d29GZ2xkTTh0QXViTWVMUjVP?=
 =?utf-8?B?R1NqWUtQeDRCNHBVUXM1dHpIbkRsdkwzd0kyb25BSm9Nd2NuOHl6czNlVi9k?=
 =?utf-8?B?OE5xS21FUi81Ump2Q3NUZFYyVy81aWY2VUNZQXE5MUllMS9qVnJnMTdBbzFF?=
 =?utf-8?B?cWVYbzVYVkVUclloS2dnVUM1TEtkWEVPOVhPQmR4V2E2eHMvZmxrWEd2TmJv?=
 =?utf-8?B?cktjU1dhY3UrUE9jSVRyM0VBaUNqcjRRRDdSK0ppUUdsWW5zSW41NjNLa0M4?=
 =?utf-8?B?VUUxMlNBaldtWWpvN2FEaEw4VHpBPT0=?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 6871bfcc-80c8-460d-48c1-08daabb99265
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 18:51:14.8193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 87DyMG4cg69hm9/EwQG9aaDW1a+93G0xqNMY6a/kWsPbUi1/AeIV5VWkBKgBk7DeyJT1IAcAdvOjEYC2S3d7t98OF8ezhpYlbDVyGIM3BPE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7434
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Oct 2022 18:51:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9730

On 11.10.22 12:34, Biju Das via lists.cip-project.org wrote:
>> Subject: Re: RE: [cip-dev] ldconfig segfault on RZ/Five was Re:
>> Preparing isar-cip-core for RZ/Five
>>
>> On 09.10.22 10:42, Biju Das wrote:
>>>> Subject: Re: [cip-dev] ldconfig segfault on RZ/Five was Re:
>> Preparing
>>>> isar-cip-core for RZ/Five
>>>>
>>>> On 08.10.22 10:27, Jan Kiszka wrote:
>>>>> On 07.10.22 12:19, Pavel Machek wrote:
>>>>>> Hi!
>>>>>>
>>>>>>>>>> I tried, but installation fails - illegal instruction.
>>>>>>>>>
>>>>>>>>> Yeah, ldconfig is needed for installation. But I get a
>>>> segfaulting
>>>>>>>>> gcc binary.
>>>>>>>>
>>>>>>>> It crashes rather soon after startup, so I was able to trace
>>>>>>>> complete path.
>>>>>>>>
>>>>>>>>> But I do have slightly different results then you (I think;
>> I'm
>>>>>>>>> far from risc-v expert). I did a breakpoint:
>>>>>>>>>
>>>>>>>>> Breakpoint 1, 0x00000000000385d4 in ?? ()
>>>>>>>>
>>>>>>>> I believe it should not end at 0x00000000000385d4 at all. The
>>>>>>>> 0x000000000001537e jal instruction should end up calling
>> 0x3806a
>>>>>>>> AFAICT, but it calls 0x385d4 instead. It happens during
>>>>>>>> single-stepping, so it should not be anything subtle.
>>>>>>>>
>>>>>>>> (gdb) disassemble $pc,+0x20
>>>>>>>> Dump of assembler code from 0x1537c to 0x1539c:
>>>>>>>> => 0x000000000001537c:  mv      a0,a4
>>>>>>>>    0x000000000001537e:  jal     ra,0x3806a
>>>>>>>>    0x0000000000015382:  auipc   a5,0x8a
>>>>>>>>    0x0000000000015386:  addi    a5,a5,1342 # 0x9f8c0
>>>>>>>>    0x000000000001538a:  ld      a4,0(a5)
>>>>>>>>    0x000000000001538c:  beqz    a4,0x153f0
>>>>>>>>    0x000000000001538e:  jal     ra,0x38abe
>>>>>>>>    0x0000000000015392:  ld      a0,0(s6)
>>>>>>>>    0x0000000000015396:  auipc   s7,0x85
>>>>>>>>    0x000000000001539a:  ld      s7,-406(s7) # 0x9a200
>>>>>>>> End of assembler dump.
>>>>>>>> (gdb)
>>>>>>>> (gdb) stepi
>>>>>>>> 0x000000000001537e in ?? ()
>>>>>>>> (gdb)
>>>>>>>>
>>>>>>>> Program received signal SIGILL, Illegal instruction.
>>>>>>>> 0x00000000000385d4 in ?? ()
>>>>>>>> (gdb)
>>>>>>>
>>>>>>> Did you try to compare the call trace to QEMU, where we divert?
>>>>>>
>>>>>> Yes, that's possible way forward, but it will require some
>>>>>> considerable setup on my side.
>>>>>>
>>>>>> If you have QEMU ready... objdump tells you ldconfig's
>> entrypoint,
>>>>>> from that point you can just stepi. In less than 200 steps, you
>>>>>> should have sigill... and complete steps that lead to it.
>>>>>>
>>>>>
>>>>> I've updated sid-ports (dropped the snapshot pinning), and now I'm
>>>>> getting a page fault on the instruction before the one that was
>>>>> causing SIGILL before:

In case the requested page is a page with PROT_WRITE only (no PROT_READ) 
it might be related to
https://lore.kernel.org/linux-riscv/20220915193702.2201018-1-abrestic@rivosinc.com/

AFAIR all stable branches have that problem currently.

>>>>>
>>>>> [  558.490689] CPU: 0 PID: 3212 Comm: ldconfig Not tainted
>>>>> 5.10.83-cip1-riscv-renesas #1 [  558.490697] epc: 00000000000380c6
>>>> ra
>>>>> : 0000000000015382 sp : 0000003fff9e3c10 [  558.490703]  gp :
>>>>> 0000000000099da8 tp : 0000003fe9c3c800 t0 : 0000003fe9c427c0 [
>>>>> 558.490710]  t1 : 0000003fe9cd059c t2 : 0000002acb8f2c00 s0 :
>>>>> 0000002b079e9510 [  558.490716]  s1 : 0000000000000001 a0 :
>>>>> 0000003fff9e3d18 a1 : 0000000000000001 [  558.490722]  a2 :
>>>>> 0000003fff9e3c88 a3 : 0000000000000000 a4 : 0000003fff9e3d18 [
>>>>> 558.490728]  a5 : 000000000009736e a6 : 0000003fff9e3c80 a7 :
>>>>> 00000000000000dd [  558.490734]  s2 : 0000003fff9e3c88 s3 :
>>>>> 0000000000000000 s4 : 0000000000000000 [  558.490740]  s5 :
>>>>> 00000000000105a4 s6 : 000000000009e670 s7 : 0000002b079c8ab0 [
>>>>> 558.490746]  s8 : 0000002b079e91c0 s9 : 0000000000000000 s10:
>>>>> 0000002acb8fc9b0 [  558.490752]  s11: 0000002acb8fc920 t3 :
>>>>> 0000002acb80f5d8 t4 : 000000000009259c [  558.490758]  t5 :
>>>>> 0000000000000004 t6 : 0000002b0799c010 [  558.490764] status:
>>>>> 0000000200004020 badaddr: 00000000000000e1 cause: 000000000000000f
>>>>>
>>>>> (gdb) disassemble 0x00000000000380c6,+0x10 Dump of assembler code
>>>> from
>>>>> 0x380c6 to 0x380d6:
>>>>>    0x00000000000380c6:  addi    sp,sp,-416
>>>>>    0x00000000000380c8:  auipc   a2,0x66
>>>>>    0x00000000000380cc:  addi    a2,a2,2000 # 0x9e898
>>>>>    0x00000000000380d0:  sd      a0,0(a2)
>>>>>    0x00000000000380d2:  mv      a5,sp
>>>>>    0x00000000000380d4:  addi    a4,sp,416
>>>>> End of assembler dump.
>>>>>
>>>>> I've stepped this through under qemu as well, and the control flow
>>>> is
>>>>> identical. Registers are almost the same, except for some
>>>> temporaries:
>>>>>
>>>>> --- regs-qemu
>>>>> +++ regs-rzfive
>>>>> @@ -2,9 +2,9 @@
>>>>>  ra             0x15382  0x15382
>>>>>  sp             0x3ffffffbe0     0x3ffffffbe0
>>>>>  gp             0x99da8  0x99da8
>>>>> -tp             0x3ff7e77800     0x3ff7e77800
>>>>> -t0             0x3ff7e7d7c0     274742106048
>>>>> -t1             0x3ff7f0b59c     274742687132
>>>>> +tp             0x3ff7e78800     0x3ff7e78800
>>>>> +t0             0x3ff7e7e7c0     274742110144
>>>>> +t1             0x3ff7f0c59c     274742691228
>>>>>  t2             0x2aaab92c00     183252888576
>>>>>  fp             0x2aaabaee00     0x2aaabaee00
>>>>>  s1             0x1      1
>>>>>
>>>>> No idea if that is normal (different machines, different memory
>>>> sizes
>>>>> and layouts) or a symptom of the problem.
>>>>>
>>>>
>>>> ...
>>>> OpenEmbedded nodistro.0 smarc-rzfive ttySC0
>>>>
>>>>
>>>> [   12.829622] audit: type=1006 audit(1653987107.735:2): pid=156
>> uid=0
>>>> old-auid=4294967295 auid=0 tty=(none) old-ses=4294967295 ses=1
>> res=1
>>>> root@smarc-rzfive:~# ldconfig
>>>> [   22.278868] ldconfig[166]: unhandled signal 11 code 0x1 at
>>>> 0x0000000000000088 in ldconfig[10000+68000]
>>>> [   22.290244] CPU: 0 PID: 166 Comm: ldconfig Not tainted 5.10.83-
>>>> cip1-riscv-renesas #1
>>>> [   22.298954] epc: 0000000000030eea ra : 00000000000145a0 sp :
>>>> 0000003fff9f8aa0
>>>> [   22.306906]  gp : 000000000007fe48 tp : 0000003fd958b720 t0 :
>>>> 0000000000000000
>>>> [   22.314973]  t1 : 0000002adf9c3bbc t2 : 00000000000003ff s0 :
>>>> 0000003fff9f8c90
>>>> [   22.322986]  s1 : 0000000000014b0e a0 : 0000003fff9f8c98 a1 :
>>>> 0000000000000000
>>>> [   22.330967]  a2 : 0000003fff9f8be8 a3 : 0000000000014a86 a4 :
>>>> 000000000007e576
>>>> [   22.338936]  a5 : 0000000000000000 a6 : 0000003fff9f8be0 a7 :
>>>> 0000000000000000
>>>> [   22.346897]  s2 : 0000000000000000 s3 : 0000003fd96df918 s4 :
>>>> ffffffffffffffff
>>>> [   22.354905]  s5 : 0000002b01953f70 s6 : 0000002b01953c60 s7 :
>>>> 0000002b019539b0
>>>> [   22.362875]  s8 : 0000002b01953b50 s9 : 0000000000000000 s10:
>>>> 0000002adfa74584
>>>> [   22.370884]  s11: 0000000000000000 t3 : 0000003fd960ee18 t4 :
>>>> 000000000000000f
>>>> [   22.378945]  t5 : 000000000000000f t6 : 0000000000000000
>>>> [   22.385051] status: 8000000200004020 badaddr: 0000000000000088
>>>> cause: 000000000000000d
>>>> [   22.393860] audit: type=1701 audit(1653987117.299:3):
>>>> auid=4294967295 uid=0 gid=0 ses=4294967295 pid=166 comm="ldconfig"
>>>> exe="/sbin/ldconfig" sig=11 res=1
>>>> Segmentation fault
>>>>
>>>>
>>>> That was the version I found on eMMC.
>>>>
>>>> I think you have some real homework now...
>>>
>>> What is your conclusion? Is it tool chain related issue? Or cache
>> related issue?
>>>
>>> Or
>>>
>>> Something else ?
>>>
>>
>> I have no idea and still only limited knowledge about the arch and
>> this SoC. We can just rule out by now that the issue is Debian-
>> exclusive.
> 
> Thanks for your feedback.
> 
> Cheers,
> Biju
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#9710): https://lists.cip-project.org/g/cip-dev/message/9710
> Mute This Topic: https://lists.cip-project.org/mt/94168382/5792637
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/9882880/5792637/2090341516/xyzzy [florian.bezdeka@siemens.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 



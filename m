Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B0B5C4332F
	for <webhook@archiver.kernel.org>; Wed,  4 Jan 2023 07:47:00 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.44])
 by mx.groups.io with SMTP id smtpd.web10.7026.1672818415439427968
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Jan 2023 23:46:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=sf7gxAP2;
 spf=pass (domain: siemens.com, ip: 40.107.21.44, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EC5AvXcOr1m9Wlj1RG6vD8lIqkd9IhYFb/o011z84ra7QSiSaieZT2k/0KajAv1mM4tArY/Hpjzp/Gq4gG8BAz+zu/H92F5j0V8F8dYjSDfBAaFIsBKpU0nHFwzwkEynIkJXcpsUkDUVnLGxkoEj8VyqcxBSdc5vYwEpsEoFJJoqbxdR39PLvYviaf0Gm9KRr9dcvH2MLiyCB2AYHrZTFGVwwVZdf/I0VES2Y+87ROW/O/JHF65bT7jAKvHLP1jZhFLQXtmpGCwSs7SrN0I3uPw1/XHgDapHeO/kax/E0y/cDG+xFGCXXTDeyviSP66dqSOEu6GngF6eYRMPbK3QfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1cLHWJS9JQLN3LWO8iRy5YIOsyv1i+PPCQSQL65W5BY=;
 b=II+Bl/EGrIcTrtANGzv/f6B+iGzRqLdobMgT1AUsjdvUmETecNlXrdnNgtr2JWIwSZg1HsG8nnm04cUGSGiSCyrWNANfQA5ocxYRiwdWfdWl8IoqJDp0qfuIPdD7TsEgcKoSmvXvsjcmWNL9FEB5GpTDkmRaToz7AkF/eaWh0ewYqvZG2SveJfSf1u+dXXOl2lXAsHLeY1+B6S4GJjeEV30fl+9A7brCh0L8n/NQUBF815sfXBbD3Q/NtQEbJD4ArzNrwhOIt6PqlWE6w3bggeKlTIuKHYIeFTUoNepugXiUQ77ZvfBhe6mYYEdRLBD6pzlOWgioIzTzaw/sv0CDhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1cLHWJS9JQLN3LWO8iRy5YIOsyv1i+PPCQSQL65W5BY=;
 b=sf7gxAP2BVfTZWyWnNufOQ3rSX35tin9q6+hRueRgbWbe5mkxAQlvu9T2t7o/fi5aQobx7krwlMcI7vG+9+gq4J2vANzlQsYvZ4BI9A3gXFsxMwxGHCAUyJyT2OZB8zGw+PXv311bHRXTe62yBtjw7ou7CsCouuJUgDVgpvPNBeT7feS1yi5GgHx25KEvUcGAjylmv1IvVlrSTm9OSI4F90bwRV/DNiqsLFiOc7RXZwrYu6cR1DseBBHsNUWMkpGmEo+YjGAnJitdJRYi4mEOschio9/CNhvyLXAa2XMbqKNIYZLPlwRNe2DVW8RSkWsl+SLA0yGvoirT8AB4bkGJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7166.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:44e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 07:46:51 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a%9]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 07:46:51 +0000
Message-ID: <192ab2ed-d727-0232-9e9f-41ec3c14d573@siemens.com>
Date: Wed, 4 Jan 2023 08:46:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [isar-cip-core][PATCH 4/6] kas: set clear text root password
Content-Language: en-US
To: Henning Schild <henning.schild@siemens.com>,
 venkata pyla <venkata.pyla@toshiba-tsip.com>
Cc: cip-dev@lists.cip-project.org, Wang Jing <wangjing@siemens.com>
References: <20230102170818.17689-1-henning.schild@siemens.com>
 <20230102170818.17689-5-henning.schild@siemens.com>
 <56ac1818-f754-ae13-ba5b-203d0a13725b@siemens.com>
 <20230103200854.79dbe287@md1za8fc.ad001.siemens.net>
 <20230103211812.1c3941f1@md1za8fc.ad001.siemens.net>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230103211812.1c3941f1@md1za8fc.ad001.siemens.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0241.namprd03.prod.outlook.com
 (2603:10b6:610:e5::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7166:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ccc636e-71fb-4701-50f1-08daee27d700
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	eOWiuvYvd7W40XRVDcbGTcAVaQJaAWp9xS50LRGw4fAPwe1fD/iJPWlQPQ/0HG96iEChrQ0+JH5O9Flfp0lRZDW+InwTS3LKRyKw8z+SkbXUfrNwR9fjNMP8tc/fNTSPF9v5IzSb0Vv4Ftp9Vw7UJQN00kheVRP2U0SkheS30cyw2zFlIuhsw0i2XTNr5yDnYrzkMzrQnpAetzzqqTlsycF47kOcbHAWY2H7EqU3tQDQL2W0ZCyNXkPDyiAuolz8uOaU+G/C4xveu4hJWSjdP/Dgd5u23ZEVPf4GGmxcJPK504gJ0Y0FlVDPho6Jnn0p6sCPD78pk/epOAsfPVCDp3tDjz0ovNhK/pQKvVuTR4+oqDtQb49cq7L75CJS/N+lHZvL2H1MiDCxjCUdDz+2DgMBDPVoDgcLmxaVSf1Tj2SRZLTSmHdznEO3gt7RUqrrPx4VnSAX5mAVAShcbwy0jBbquHGPrIfhKJKuoEfDr96M6JUm1W7W41RU0P8VRUNmwJ5SEvgOoTjBKNIp4rIZuqS0CEztn4wUi0meVRh6irluCxFKCuLERTUSQWCvag2vOS1DJnm3SBY+p+S0eGAapi+a4BTFqqF8txQw7RdRY5o/ltvxhPox88M4pwGwjwadRZCSWYWcuPiPk0QkjDh3nd/rIgHigqlWYiLVrxGgLQFPCenyMDCYZSyHs3uWCOqLBAuzHV0TLdpge/r5DkimfYgHVh2JBUD7EERf1K9I/+Ee+/HH3Y1gcKLCJZ4dTBelYrr7mztKTizi0s/2cxLmL7X5f9oMV0shNdlyOFB3rqxoj+wzTHd69XIPH+xBdc6H
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(39860400002)(346002)(136003)(396003)(451199015)(186003)(2616005)(26005)(6512007)(53546011)(38100700002)(82960400001)(86362001)(31696002)(83380400001)(44832011)(36756003)(31686004)(316002)(41300700001)(8936002)(4326008)(5660300002)(8676002)(6666004)(107886003)(66946007)(66476007)(66556008)(6486002)(966005)(6506007)(478600001)(110136005)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NVV4dHRNTlMxbGtDd2hwZjN1cHhScXI0YXZJNnAzY1ZPVHBVQ3hqUGZFUGZP?=
 =?utf-8?B?cnZtNC9yb04xMnNhSXJxbCt2QVZGNHl5cURNWCtFZTYrUHdLZTljaDRMTFF1?=
 =?utf-8?B?eU0wSzMxRGFZT3ZKeTk2M3hidW1aSzNBV296UWF4eTgrdEMxN2t3RlQrOU5x?=
 =?utf-8?B?NmhXUU45UHgxVUM4blZHdXdWYlg0STZvcUNzK0pDblNvaWZ3aWVIMkxNeG1i?=
 =?utf-8?B?c3VGOERZekg4dGRFbEpPODR4czdUbjZQanNFeE51VGtuRHNLUm1kcGk5THFL?=
 =?utf-8?B?UVpyNGt4UlpQbEloWGppQU1VMjQrM3p4Q3ZUM2N0L1NkNzY5UzA0Y0tuMHNx?=
 =?utf-8?B?R3J4Z1VyeFVsSzM4Tzg2Rlh4dEFFNi8zMmhmaG02QTBsT1dmMmt1dENMa0w4?=
 =?utf-8?B?bWVtY2xPb3FtZnNpQWZMMmFnM1ZDR2ttNXp1bHlNSCtzRFBXMDd5UU5ndmZZ?=
 =?utf-8?B?WGd4UlovUzJMRzk3eGh0Y09HWFhZNDBYWEdRUVA5bU9zQkt2QmFrM3A3OUhF?=
 =?utf-8?B?TmQ4UExUR0pYcnRIZ0lqK2VnT3hZN0puYjJ5Mm0xWFU3UE1INVdKWXJVSldF?=
 =?utf-8?B?NTJQTXB1NGhCQUljdUhkeWlja3oyMllrT2lWN0Z2YTlaN2ZzTkNmd3FuYUJD?=
 =?utf-8?B?K29FOW9EVlJkUTI4SGNkbWE5blFSdUVFRHU1clViempEdVIrOHN5aWVRQzV5?=
 =?utf-8?B?U3Zwd1Y5ZFdIVy8zZXBONVVUN3VrcDJ2K0ptYk5jbUtLdVd2Mk5GeUM3ZWoz?=
 =?utf-8?B?ZXhTS3BuQlhTZDVMR2pmbkR4cS9Kd2YvbW9XdmY5ZXdYWUd1Q252d2lQOEk3?=
 =?utf-8?B?WFFvNVA3dklzOU5sVHBVeHZxTHd1ZCtXcEF6aFBEOXhQclNCbitqaGkwYWc0?=
 =?utf-8?B?KzlYYXdVSDBMY09LaXhmeXQxUG02OHhJRzhGaVZXT05tZUhtUGJ6dVVMZThR?=
 =?utf-8?B?c1ZtWmowUktVUnhqTklqSGNEVVJaVlZhV21LdHk5dmJzQjU0U3Y2dTdLV1o0?=
 =?utf-8?B?VDhFRGJNZjVza0V4Y01ldUczdVVXdUFyanpEd3lzR1ZHWDM0eTVidHA2cHVV?=
 =?utf-8?B?dGlsRVhDSGJjYlNPUm9kdkI0UXI4ZTBqNEx3RnY0eEtHeTVTVE10Wi9xUDlG?=
 =?utf-8?B?VkFzSXlsaHgxZXlSMHFPUHNENnNWVHY3YmlRNXUzcmVOYmhsVGNyZnhzTHVI?=
 =?utf-8?B?MjZqci81UHk2R2xwRUpRTDRabzV4ZGMxZGR3dndGZmJFQk95OEZzeFl5bkFv?=
 =?utf-8?B?RUsreTFDUGRaMmJ2UWVYVlc2Y1FPSnFMeGhVN3NPNmNWVTRqTVpmSFA0UWJ1?=
 =?utf-8?B?ejdIczVnWGVQU1ZvMmpkZngySUpWcDN2eG54MTV3WUEzZkU3NmZSc2FjSFh5?=
 =?utf-8?B?Q015NFZTU05tNzRKNnRkODRPZ0ZVY0tNd0tKRUd6R1hpMXJMa05CMHZEaXY5?=
 =?utf-8?B?OUhrYldZVVpRQWRQVEE5K0VTbkVvcGp6OHFWL2h5VzhHZ1FaR3B2b1lMUTMx?=
 =?utf-8?B?NFc5M1A1WU03RlJodk41ZVROdmNWYzNrUXdaVkx5cUhWaUZ6Rk1aeVk4T0VJ?=
 =?utf-8?B?YzEyUjltNXk3YXE4VjRuTWtNYlUzYkVCMnE3MUlydGFPcG9VVXdWM05VT2o3?=
 =?utf-8?B?dXR0N2U1aVZtT2ZnWmw5VGdhdHIrWlVPek1RVVIyaStJbUc0TEVJZFduWnN2?=
 =?utf-8?B?US9XeDN0RUZCQTJnRlM1ak5hbkhZaWhNQnpmMkk2WHZYSXY5NXg4U3VWOGxx?=
 =?utf-8?B?akZQanRHVllCL0RnUVdyTEZSOTFtMmpPeHg2V0lHMDNZUVRCalpPN0hMN1R3?=
 =?utf-8?B?RjJjRndLSE01YUVsR1hqMzhVRElCcXhpTER3eHE2N01aeWZsUXh2eUc1YVpx?=
 =?utf-8?B?YVQ1MWYrTWhvcnlRck4xQTVUVllGK2piSnZ3S01lbFBuNVUzTWYvMkIzd09U?=
 =?utf-8?B?WTlENzArZ2ZzWm11aDRUM3RFem93aUxiYzREWmNBVDh4blJ2Yy9FY1NXL1kv?=
 =?utf-8?B?cTRYeEhVcmt1dXNjTXBGWnQrbGJscXFtWmI2ZUdRU1AvVENIak8vMDdFUXg2?=
 =?utf-8?B?cTJGOTdpSnJwR29RYzAycVd1TGlvcjlGY1d5R1dSTERCNmdFS0JYMnZTMWU3?=
 =?utf-8?B?K3ArQnF6YTRwWU1oUWNzalNKQnFGVWlwZXVnZ1MzbWtvWnNxNmU0TVg4UmVM?=
 =?utf-8?B?aGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ccc636e-71fb-4701-50f1-08daee27d700
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 07:46:50.5697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zCXZDSPS2Rryoydopj9q1FONo3yZIY9hycnfBTU4VmcoVjVb12syD2j7IcVSwFT/Q0pgfhYtk3sW7npJH2V+RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7166
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 04 Jan 2023 07:47:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10294

On 03.01.23 21:18, Henning Schild wrote:
> Am Tue, 3 Jan 2023 20:08:54 +0100
> schrieb Henning Schild <henning.schild@siemens.com>:
> 
>> Am Tue, 3 Jan 2023 19:03:13 +0100
>> schrieb Jan Kiszka <jan.kiszka@siemens.com>:
>>
>>> On 02.01.23 18:08, Henning Schild wrote:  
>>>> The comment above the hash looks weird. Might as well write it
>>>> human readable.
>>>>
>>>> Signed-off-by: Henning Schild <henning.schild@siemens.com>
>>>> ---
>>>>  kas-cip.yml | 4 ++--
>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/kas-cip.yml b/kas-cip.yml
>>>> index 10f4594334d6..b970f39ccb13 100644
>>>> --- a/kas-cip.yml
>>>> +++ b/kas-cip.yml
>>>> @@ -37,8 +37,8 @@ local_conf_header:
>>>>      ISAR_CROSS_COMPILE = "1"
>>>>    root_password: |
>>>>      USERS += "root"
>>>> -    # 'root'
>>>> -    USER_root[password] = "oC3wEGl799tZU"
>>>> +    USER_root[password] = "root"
>>>> +    USER_root[flags] = "clear-text-password"
>>>>  
>>>>  env:
>>>>    DISTRO_APT_PREMIRRORS: ""    
>>>
>>> Seems we have some conflict now with settings of the security image:
>>>
>>> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/3548200620
>>>  
>>
>> Lol. It is not too important after all. Not sure which component there
>> causes the issue. But if it needs to be tricked to accept a hashed
>> short password ... keep the hash.
> 
> So please remove from next, we do not need this one.
> 

I would prefer to understand the technical reason and then decide if the
current breakage is desirable, also from Isar perspective, or if we
should change something maybe even in Isar to account for this.

I suppose the conflict comes from something in
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob/master/recipes-core/security-customizations/files/postinst.
Adding also Venkata.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux



Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86848C77B7A
	for <webhook@archiver.kernel.org>; Tue,  6 Jun 2023 07:09:59 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.79])
 by mx.groups.io with SMTP id smtpd.web11.3156.1686035395944016968
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jun 2023 00:09:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=pHUFfIFq;
 spf=pass (domain: siemens.com, ip: 40.107.6.79, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ont7RkmCyVqFlL1IhQ0dPYxKd89YDhxKxhWNZiCcEzvPN9wcZXiskucihy15BcQlruv1eclmYZYNdTPW0Yqo8N22fpfHPin/ah5ErR6YfqRRBbWB7uzUJgCpt6aGd09PrtpOaN82xo7XUJQCGjtVM/iiVMT3zZY5MP6gb4ub9aTU85pRlsvxtIK4wIX5qui1NEmcx/irOdQ7KrwGPP2twdj1JfqwNf2PUTI2U+izbsujvOKDqYe2dEyitnkYzofALWMAGV4vyoCPsOcsQgDzWbtg6QV7M6PoeBCAnOuI3m65SttsbWNLmbU/LA60ZRLcFjJzkOWljMqKPdloO5hhWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iqrjBtSvUwGuRQIuR62lHA9FsLzhZVrax8z+mxaPVHM=;
 b=ITy06znNypbq8ZWFYySReThaG/1g0TG9OPAYL24ATaRCXMkN5GMkFIhfLcYXMY6mxYq3ZGC0FhyraQH8iTJI9KEK9If9H6UXl5w5xntKZdl0dnIY7Gsb7ImbBm0khleZiyNHWwyq1QUngsPqQXt7cQuhTgk5w1fndnCcBHxhENzHsRrZQYBUrO70b7vGAZIRRBTgZQh9b0C93dvAxl71cbJkjpLaNAuirrXmMc3WEb6L+MgUAeXbK/y1CoXpal/sEdqwfy/BmwU88sFJlByjidZo+yIV9zLOKh/YLaPQLcZkqFCXKUE8P34rnyaxzYsjReVsKSOO9/gZKpjQHdUWVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iqrjBtSvUwGuRQIuR62lHA9FsLzhZVrax8z+mxaPVHM=;
 b=pHUFfIFqzuNLS12y5qiUxcT5BJZPHnN1u57dLRPNT+Qexv17gaAuqt632Q4B07938RKTl5dxBduWKC7jMhBlPkYueRnSlFZRXbfyKQS7v5zJ3dRMmRG7JlM5/eMT4XGZHcdayxOe51ACX0L2n5AddoUuxIFX4nzBo/aC8to6/I7E7lClC1QRaEhyWyppd88C0gPJti7Vb2hhtfL0LlYE1EQ8QeiQrkyv6+dc+ESBgNHhD0/qMlzUxykQg8NfN6bgKO1g27WCpLu4GHOsByCpt91To2IwP+v9zp9roCw9Z+V4UwRlpCPAkm0lQ5gV1MEpxhKU+SuIzPwTwkXDvYfX8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3793.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:176::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 07:09:53 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2ecd:9a8a:5601:47e4]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2ecd:9a8a:5601:47e4%6]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 07:09:52 +0000
Message-ID: <86438485-f93d-5457-cfd2-7021a0b2916d@siemens.com>
Date: Tue, 6 Jun 2023 09:09:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [isar-cip-core][PATCH] IMAGE_TYPEDEP:swu: Don't depend on wic
Content-Language: en-US
To: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>,
 Uladzimir Bely <ubely@ilbers.de>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 "Gylstorff, Quirin" <quirin.gylstorff@siemens.com>
References: <20230516085018.26436-1-ubely@ilbers.de>
 <cb62ac04-f64e-192e-7d00-e411f4422cea@siemens.com>
 <0fc8aa184fe24a549be85f87a69a0edb@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <0fc8aa184fe24a549be85f87a69a0edb@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0067.namprd04.prod.outlook.com
 (2603:10b6:610:74::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3793:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bb8d2ec-0e75-4bb1-bb9e-08db665d0594
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	mwjc8gqvic7NUlDz2EIq5mR0ICqn4oPWeARbzpCY7oI4w4riJppLjWhJ+pmtTxsDVpgcd/LitpcwzqufSUwBJyf7wuN2GohDVru0fzZaUvf7UyK33fDaTdiSP9B/mdZDoZvBJKpR9+FQ7qYfsKxMMPqChNuTAxqAshuAhC2BcmoglhmMTWMzUnJ85zXXUWcM6vvDEGHj4X3ubpH6ytLsNkFkl8t3fQZctuy55zOGAJiNnwaanAVfVEk4UUTXeVOagX9qATJYCEf6oGilSjcxXmspoaBILL3zp9xDIs4AFodg5W2sJ11lW/E6/ZzGzwjztaXV+ni7T8/2lsKj1PGrdcsgDi/4MMPsFkwFq5Byej09zk16/XocH8yqZTE02UOvpT4I/EnqgWkDDeXZ9N258VzZawzSFhEv3zsBGzbNrRRBlRudiq9DcZ4RD5Hl3uEdQVW55FmrlIUyg/yWF4fkuQarfqBLzHAaa8ftu4Mxr0Ctw8Bs6bLlwGUACeFkHnqEbcdt+0Ar0lgGJsCHJKsffDSmqhUvsXB0l0CtzBVfNzUEcgCnsk9y9GnZdnodtI19Y/cNWIVzWE/HFyElRoiQb9yNGkY5aGX9XtBH9fU+9CK4q0jwoRqnThV4tGt0kH2FjuLJCSIqzzpdtebLREvqLA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(376002)(136003)(346002)(396003)(451199021)(478600001)(6666004)(6486002)(110136005)(186003)(2616005)(6512007)(26005)(6506007)(53546011)(36756003)(2906002)(83380400001)(6636002)(44832011)(38100700002)(66556008)(66476007)(66946007)(8936002)(8676002)(82960400001)(31696002)(5660300002)(86362001)(316002)(41300700001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SnJjbGhRaHl1R2pGekJCNXJmU1gzTEpXL0dhOXZJRHdDYjRhTk5UaG9EK3pr?=
 =?utf-8?B?VHVUbGxUaXNBWmo5Z290UzRKWkhQams3MlpMQUwyZ3R2QmExekJ3N01sU0ln?=
 =?utf-8?B?VkI2TnRFcEtnV1BuU3liUkRlaVVYRVFqWjJoK09BZWNycUp0QkhVaHd3OFBk?=
 =?utf-8?B?dnR5bUZLWURseWpCQWlKbS9ybUw4YjRzMUIxN2JWM2FXZlhhYlk0aW1XMkNr?=
 =?utf-8?B?UmpWL0txNmRYY3hMWmxMMG8vdDgvU1AyU3R1b2xWcG11UWVDTzg0ZXExTW9o?=
 =?utf-8?B?UC9TTU4vQkRYZ25KZHdkeDlmT0VrTjFYQWRic0pDM3VQT1J2aEJUdzMxQU13?=
 =?utf-8?B?QXNzSlpFQ21nWHFZZDE3a3BCM1I2Y3hqSkFRbzFWalNFVmtXUGlaNk15YjE2?=
 =?utf-8?B?WnUzbjMwZzlHM2IrNkNlYkRaYS9ldnBaMDlpUCtCM1hKUnV5T1VURU5RcXgw?=
 =?utf-8?B?WEUvb2Erb1lCRmFqaU1odTBLNGNBY1NWS29nSEtRdnc0YTAzaThBNlVKSHRO?=
 =?utf-8?B?dlo2dTRZWVlxY1M2RkFueVltUzFMU3ZuRzRpOWRCbm9lT0xpZUdHbVo1OXNm?=
 =?utf-8?B?Q0ZPUHM0K0t3enhFZG4zRGhDaC9hckdzeGR0QXlhdnMxVmhHbUFtMFVZeEZn?=
 =?utf-8?B?ditKTUVZQ0pCaU1hZzZxR3lNUERWZitXYmZjQXJoMWtadmt6cGIzcFE0QWtR?=
 =?utf-8?B?R016Vk8yMWo2ek5DSEJvMys2NE5nTHl5bEtwL1g1a0s5cGpVWGtWVDhMdXV5?=
 =?utf-8?B?SWZJTnBDTnRzYzVldEcrbW1FNHU3REJHbW9CRzhEWW5jaDlHREN3V0N5aW96?=
 =?utf-8?B?T1NtMzJkK0J0Vk1CSUF3NDRvN0xuSktLS0VCSTVvQ2dvWEZuNnZmRmdvaS9o?=
 =?utf-8?B?L3E1MkVKckVKcFVEL2V4dGJ2SVRSdjNHUUNlRktiMVJjdk1VVVEzZDc3L3Yr?=
 =?utf-8?B?c0pVY000a1V6dVFoT083SUtlNTdFVzcvZ3B1bUNZSzNveG1hcEMzbHZjaUtW?=
 =?utf-8?B?TUswZHM0T0ZSUkhHRDNwclJGN0dWVVRMRzQ1Y0l2ZkQ0bkh5RE9DTjRRSFNm?=
 =?utf-8?B?V3hUQXNaOVc5d3czL0UrTHA5VXJVc0tObmZhTGMyQXpWajIxUTV4S3U4bktM?=
 =?utf-8?B?TmJBR1lSalRCQWNhQTRZcTREdmM3MWRzbmhiUGY1NDJ4QWJqanVmUjV3cFdo?=
 =?utf-8?B?bCtUd1dWb3RscEJuejF3ZmI5dTRrbzZPY291Tk1wdlI0dGFkR1VNaCs5d09E?=
 =?utf-8?B?d1JDdkpDUUJWaE52WDQyenlqYTl6NGl3UkYwWVBOTUVHM251WTFhMDdKQmZB?=
 =?utf-8?B?U3FFWnRKcm5pcS8vQzBqeW5ab05Dd0VhcWdqdHE4bnFIUkRMUDRqTnozS3BR?=
 =?utf-8?B?NFZDSHp3aFdib0Y3TWUwVjJxZGpPSWVMZ0xrMFhYQm83WXZLWVpINnNhMmdH?=
 =?utf-8?B?dkJqZDN6OFJWU2J3MU00WnJRVm9UcU8zS1VLWFM5aHVWSVppZEgyUGwxWkZP?=
 =?utf-8?B?M1hpclZXQUduZ2hGMk1GVU5LalJxY05Yd2xkdTAwYnh1MWtweXhkbXN6czVm?=
 =?utf-8?B?YUVPb2pONDhlQUQvcHFLZEQ1KzhETkNlanhpRGY3Z1dzSDJhV2l1bFdoMXdw?=
 =?utf-8?B?S1dXeWxJOXZXVjlySklzOG1nSWRlVmVqV0Y1M2NZN1RldEtpSkFoMVFTZ0lq?=
 =?utf-8?B?NjNiY0tLK1luS0R5VTBnWllIbzNhL3J5bUp6MC9HMUVWbHBEMkR2cXB6c04z?=
 =?utf-8?B?M3NvQWV5Mk1iQldDS0JJbHNqcC9wVnlsNERiUHdmdGRDSytNVzRXOG9vekNC?=
 =?utf-8?B?UjlUTnhyY1hmZlFKek1tZG9CdWVlSFN0RVNBYWFOQkdXZG5kdFQyQ0h5cUlE?=
 =?utf-8?B?T2NpcFhOVUYwYXlOV1Zaek81eXJ4VkNsTU8xaTA2R2pUbm43blZ5Mnd5ak1M?=
 =?utf-8?B?dVpJeUZGeFlUOXJVZkVFSlpDOGtwbXVZVXhLYzZvaStsK0FLbUZWRWhaN1JJ?=
 =?utf-8?B?TXRtZnI1c2h5MkxCSTEzUndOaU5rL2gxeUpUTTJ6TFd5aUpNMFB3K0hxdXF0?=
 =?utf-8?B?NVhGVFp2TVBEMUxnV1pyUUVXOEZYVmR1RDJtNGdxVkNpVndQU3N0SXEzQXhF?=
 =?utf-8?B?QzVsUzJOTXhWZ3VHMEdJd2tYbnJzNTcydE1naUQ3cVlrMmprdXlwWFpHZk9B?=
 =?utf-8?B?V1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bb8d2ec-0e75-4bb1-bb9e-08db665d0594
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 07:09:51.7643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GZ+yAP6aYaVviq5LtYyc2OzTYmeO5yI4L6G9QyG2p4IUH/fM8PKFB0FxbO7pJ1tjhLhCzDYHUaAQKHDbCDbyqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3793
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jun 2023 07:09:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11839

On 05.06.23 09:13, MOESSBAUER, Felix wrote:
>> On 16.05.23 10:50, Uladzimir Bely wrote:
>>> Settings IMAGE_FSTYPE to something like "ext4 swu" or "wic.xz swu"
>>> causes uncompressed '.wic' image left non-removed after the build 
>>> finished. This is caused by indirect dependency on "wic" in swupdate 
>>> bbclass that can't be overriden by the user in local.conf.
>>>
>>> This patch removes this depencency. If the user want to use some wic 
>>> partitions to be packed into .swu bundle, they could simply add 
>>> directly add "wic" or "wic.xz" to IMAGE_FSTYPE.
>>>
>>> Signed-off-by: Uladzimir Bely <ubely@ilbers.de>
>>> ---
>>>  classes/swupdate.bbclass | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass index 
>>> 9a4d509..6f034c1 100644
>>> --- a/classes/swupdate.bbclass
>>> +++ b/classes/swupdate.bbclass
>>> @@ -31,7 +31,7 @@ SWU_SIGNATURE_TYPE ?= "rsa"
>>>  
>>>  SWU_BUILDCHROOT_IMAGE_FILE ?= "${PP_DEPLOY}/${@os.path.basename(d.getVar('SWU_IMAGE_FILE'))}"
>>>  
>>> -IMAGE_TYPEDEP:swu = "wic ${SWU_ROOTFS_TYPE}${@get_swu_compression_type(d)}"
>>> +IMAGE_TYPEDEP:swu = "${SWU_ROOTFS_TYPE}${@get_swu_compression_type(d)}"
>>>  IMAGER_INSTALL:swu += "cpio ${@'openssl' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
>>>  
>>>  IMAGE_SRC_URI:swu = "file://${SWU_DESCRIPTION_FILE}.tmpl"
>>
>> Oops, this almost fell through the cracks.
>>
>> I'm indeed not seeing anything in this class referencing wic, so this removal seems logical to me. I'm just concerned if we have downstream users relying on >it and then seeing a hard to understand error. Any thoughts?
> 
> Downstream layers need to adapt to the new interface anyways (if they don't use the plain version provided by CIP).
> The .wic is not needed and should be removed.
> 
> Acked!
> 

Thanks, applied now.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux



Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A94B5EB64DC
	for <webhook@archiver.kernel.org>; Mon, 17 Jul 2023 11:30:06 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.60])
 by mx.groups.io with SMTP id smtpd.web11.5908.1689593399965425213
 for <cip-dev@lists.cip-project.org>;
 Mon, 17 Jul 2023 04:30:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ORiOJWHP;
 spf=pass (domain: siemens.com, ip: 40.107.22.60, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IoXua+r5GZQrrWvW+pQ/q7SnAHm5X2mh8Qptazx+Gev9IdxICry/Kn6oeHd3StJiVL+2j675tbXZhQaguoMxHRg//Y9PjLwoH9duLxq8jaIlcwtaZG/QFzptJDnXqC9KoRRD4H1kiEMWIzqN7YA9m/ARoIqf2uK2ec1reyafDQzXMaaMogoWgUXou3M29Y1aUHhvv3In66J+Ra+4HyOQdSAy+yNFGNimowXPJXKglaMgF5Rbzr0+yD61QWbM1rWQ+f2uxYqYW8oEx3BZP5V0S53TPEyrc68JZe412C7ycUnfG0L0qFFqjbd1TVt/p8eRN/krdaCWRUU49EsuBegBIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=meEWgg48t1B7AVRsk+RVq3H2R1kWXd/5Az0uFDOdZCM=;
 b=QiFsijr+7Xj3IQGAyxO6rf//kV8WEAEYtD/Usn7JK8+ax+0VSB/9603WEHVmX4N7RWwJ/FFhz6yJlJ6X4snd90M/b4HeeH6F8mk/UVxXQzj8bM04j8iz17iNFgzefIUtHiUwI6y+DDo2cBRIJZfZa1f/srZwsJyTIxKbn9qKPQfD2pMAROU//5gX6dbdkZfyJVcchmcEJQtD5PGK0PbPpCols67pAZ1Fbh899M1Uayh0lvzUBw7WvavpJ1onWT9rEOCmelXZJ8KoBspwjlvBn2CRGTAy06VkIQj6qjlRHohOImwBeDJPNSHBKcQngpErIQ17ZzGSIQT/jBY4v22yfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=meEWgg48t1B7AVRsk+RVq3H2R1kWXd/5Az0uFDOdZCM=;
 b=ORiOJWHPn13ClvLayuzjaP1GjSXpv7rcm2oRBsXuI3M7SVN9owHmWsSaZiTT0nV4dF587Q3xyd2jcSBgFvMqNDT2pkIGHarN03oJfZQr3ScUSfI8PUDpaU/TAOcGWewskS4V6PU+94qnRjED4dM4C1rw2FOSk0aekFINXRW6EJ9etmTDN2fmTr2QHodIXQIi0KC9+8hSafey0o0vbN0kC5CKIavkaUzPlZFGLL0qgZPxZIReXRQ0IZM92QolsuF0/yn5IjAGZ5LlFDITAQa9zG9/+5h85O2xoMrXbb53/ZB2OGXdqs3wnxWHljITtaZvWUuut9bNSXzjHSCbznROuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB8114.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:389::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.28; Mon, 17 Jul
 2023 11:29:56 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::77d2:3a68:9741:67cf]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::77d2:3a68:9741:67cf%4]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 11:29:56 +0000
Message-ID: <6d2d0898-33ff-b4d2-fa71-7be495cb6026@siemens.com>
Date: Mon, 17 Jul 2023 13:29:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Debian Buster support in Isar
Content-Language: en-US
To: Henning Schild <henning.schild@siemens.com>,
 Anton Mikanovich <amikan@ilbers.de>
Cc: "isar-users@googlegroups.com" <isar-users@googlegroups.com>,
 cip-dev <cip-dev@lists.cip-project.org>
References: <8964b68d-9cd5-f4e5-f97f-eb87814cfd8f@ilbers.de>
 <20230717132131.4b579430@md1za8fc.ad001.siemens.net>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230717132131.4b579430@md1za8fc.ad001.siemens.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0070.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB8114:EE_
X-MS-Office365-Filtering-Correlation-Id: 769285f4-0c21-4b36-a54e-08db86b925ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	qwr3RNMPV3LVkdv3QF2ktnZJR6a31/X15RNeYRU/mbV/pE6ob8ngNaXyF7+fqaQicimWLjhVMzPRfvGet584Mnkz86CvtQ6hiB095+8dwTxe0X3p7Iyg4kieTQZ1iXdNf0o2KBmt/ZmXxcfr+tVKmRb+wqHmiY4TxRqYVim8V/+adSB4oxNrJRayQB5jpeTWLdTvmIgM+PpgxLDFEZLGAAt+l8QPdspkfA7dUq53g5NcesvjagbDzokE0xYozuLPDhA+fsj8WPdqPg9KKk5EBHJc0TK4gu5LA5hYps2xdge2Oie7m/EHXLQm5awdIvxOuI5SxSWONnTcIOU3PxYyVZYn8fXVhrxu2XfqtdZOwWjs6hjTL7VSjbtJlzEDdSyiw+4ZfTbFIRcGoULZ95/yK05KYrScru5S5SeZ4M4GTFwuYrAopyWL2eEnfBPFSXPy9+CBM7zr82Z3A3jAwH70wLz8fVX9KCxwJuXI4U6nONFQk6p9v+iY2GPeUM8MTcq1jNJVue2JwmQbgHEwy53WiwoqASiS0QNIgqfxddmAwyaXQvj65UqTXyEdK7OCCNM6KoEjxwrDAcetVPwwRcjV0TLXfYms+rmP45Gegq6HjZT877hdQ6vI1K44KSXS3gbWhsAoYkiUHLp736iHecF2kw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(366004)(39860400002)(136003)(376002)(451199021)(54906003)(110136005)(82960400001)(6486002)(41300700001)(5660300002)(8676002)(478600001)(8936002)(66946007)(4326008)(66476007)(316002)(38100700002)(2616005)(66556008)(186003)(6512007)(26005)(53546011)(6506007)(86362001)(31696002)(36756003)(44832011)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?T09UUzZqWWd6MytvU1RWVW42N3RWS1pWUGswTlo2VS9KK3MyZHk4SVFqdEs0?=
 =?utf-8?B?N3BQdzBMNmZ1bDMzcXRzZDFGckNsNmxwdURQVnVhWklydEJnOENHVUYvYTZD?=
 =?utf-8?B?bTB0MkZoOGJGT1FEYXY4MWhpRG1MWTN4UUpnZnBUWmNpY3VGcXhLRm1DeHZZ?=
 =?utf-8?B?RFZKZis1NCtFVVJOeWhCeEk2SFlUNG9XRFB3QWpmSGc3cXhkejJiWFJzV2g5?=
 =?utf-8?B?SUQ4QmJjUUNKaHZzVm1YUFVnTWpZMWVUbDlzY1p3R3VRZ05vRm9zZjhNTWpR?=
 =?utf-8?B?ekhTSEtYU1JIbm9Qb1ovM1UzWkdtY3lhZVY2Qlc0KzQ0bmt3c3VSajV5L1VS?=
 =?utf-8?B?eGM0R3hRY3ZqUS9MWlBsclhHN21yTGhodE4vd29RSVR0TzlzclkzSjN1NTlG?=
 =?utf-8?B?TkthaHN5d25mN0p2VGdPcjFDemxIVGtKdGxUdzUxdVh5eTlZbmlNc2ZnSjhE?=
 =?utf-8?B?L3JiUGprb2NRM1lSTzBqNGE4dngwdnR0d1lLMHIzSFQwZmdGZE8rSzQwc0k0?=
 =?utf-8?B?UTBkZ3NnWEZidWFtSDFNckxiMXlEZ0Z3MXlqQ2RlTnQ4U0MzeFZsNUpROWpp?=
 =?utf-8?B?OENFUTZseFhsdmVzeDNUbnlZQWYzYWRWNktrSXFRNzU5TWlMazBLN0c3V0Fw?=
 =?utf-8?B?RFpIL0N5c21vRk9uc3JjVTdYYytYNEVXWWk2TXVTWUlPNzR0Vjd6V3YwbWFS?=
 =?utf-8?B?b2wrTWl0NllMTkVwZUlSU25uZVNqbEJvaU01bUZNN2ZCSm1vSFdFcnNhdGJP?=
 =?utf-8?B?RmEwY1B6QTlvQU5Mam8wREJrR2poVUx3andQR3g3THRRNGU5VEJvSHhxQUt1?=
 =?utf-8?B?K2tPcmYyOXNxT0hQRVo5MnZEOVo1WjZkVkd4OFo5QTFlR1pncDdONllvT0d6?=
 =?utf-8?B?djZpQ29wT0o2a1JNNXZqSXY1NXBYOXlxbzVTVTQ4dVBDZFlEUzRHSlI5bUVh?=
 =?utf-8?B?MmovNy9hSXVjZ1BNRjQ4TWZwRFhKUXUrZkk1eWZ5NmFPRDkzUW5WamZ6RHFX?=
 =?utf-8?B?enlwaHVaTUlDTDAwNU9wUnpHL3lVR1hCb3BrT0NldStMUDR1YWRZQUgrVVN1?=
 =?utf-8?B?aUVCeGdQbVV1WkVlSVBodjRGWHJkNnp0eHNVbkNIT1dvbzhSMTU3THJsdVBX?=
 =?utf-8?B?OWwrWHBHRE50T05wbmF6U3h1a0pWTFZZbWtWN2RramFtUWlDcUI3WlRXYjVy?=
 =?utf-8?B?eXQ5ay90SmZHc0czbnNxaEJuNUVZSDF6WkR6Vlp3cFZISFpGckFvM0NyTW0x?=
 =?utf-8?B?a2RGV1NIUGpGcWp5ZDVFYXhweEUxVU4xVnZyNVQrOFIvWXUvVEp3cDJ6bjRZ?=
 =?utf-8?B?c1VsT1JNWWkyMlpOVzM1SXUybkdqTEs0a21UeVZZQ0NPYk9zNzlXNWdGMzQy?=
 =?utf-8?B?MEpFMjRNRzNVUEgxcERjcW8xdFRIc1RwRTR3V3FweFMwbk5udnhPcnY2blNu?=
 =?utf-8?B?UWpIemliOUl0a1JZZ1d6K2J1R2tGVVNudGFCTCtueG9YTkI3RW1EVno0aXdj?=
 =?utf-8?B?Rnl0RFIwTkxhZ2xQNVNrV2hFOWR1OGRUaXpQZU13ZXpKdjkwWHhKU1lieUdL?=
 =?utf-8?B?OTFXclJudlB2MkMvWG0yRUtabXJhVHpUTGplZndFMnZUaUZMM1daeTFIN2Fm?=
 =?utf-8?B?dENyb25vM3VibUhwR2ZiaDBjRERCa0tndkdwWXZWSVQyN3Q4WGdxNlN1Nytk?=
 =?utf-8?B?dWhiVzF3clNsNEZGdWZMeVkxdmJFWFJzdWRMUFZQZkxrS3hZeFl6Q2RXV0dR?=
 =?utf-8?B?Q0pvRzJJMVdpSjhJQTV4RlpTYTdwMWJ4TC82TVl2WXhmWmhOeFlLVElpQXJ6?=
 =?utf-8?B?cnpjYVRzdm1HcHB2M1NVY0xvbEo5alkvS0duRzAxL2c3MkxlbkZ5M1ltUDRZ?=
 =?utf-8?B?Uko0T2xNRkk2UUM1ZEhDT3ZjTkdSWkpRL0pNSDE4VHNsY2dZUmZDRWJ4dGVp?=
 =?utf-8?B?K2t1N3Z3VUdqcjlRZEl0c3FxQ3o3Z0ZoMk9yRGtUWCtxTGc2akc1VXhneVQr?=
 =?utf-8?B?djVRWWU0bDJaY3Jyc1F4em5wMWNTdm5SRmZqN1FaL3hQNklsbnc5MHlXTFEw?=
 =?utf-8?B?OUxDbWY1T0VHb0J2VnEzdHluQjlINTJrR1FJZnBjR2IyTnA1bkgzZjNGS3dm?=
 =?utf-8?B?d1NlMGZDR0huQWVVaVRrdk1CalNxYmpwU1QwWkpZVHZyeXpHTzJ6ejc2NUxs?=
 =?utf-8?B?WUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 769285f4-0c21-4b36-a54e-08db86b925ee
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 11:29:56.7606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: izO7gGu/nFd9yW+4SgOUN+jxJymX5nHkJUo2QD8tbsyMi5Na0z1/CJ5lh6ygg44JOIovDsC8OHVeT1L5qsWegA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB8114
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 17 Jul 2023 11:30:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12370

On 17.07.23 13:21, 'Henning Schild' via isar-users wrote:
> Am Thu, 13 Jul 2023 18:06:17 +0300
> schrieb Anton Mikanovich <amikan@ilbers.de>:
> 
>> Hi all,
>>
>> Debian Buster will become End of life this September, and it already
>> started feeling like something needs to be separately care about,
>> just like we had previously with a lot of Debian Stretch hacks.
>> We already experience cross-building issues on qemumipsel-buster and
>> dropped stm32mp15x-buster due to optee compatibility issues.
>>
>> Did anyone use Isar with Debian Buster targets in downstreams
>> currently?
> 
> In Siemens we still have a demand for Buster, not to underestimate in
> size/number of layers. We should for sure support it in Isar at least
> until its EndOfLife.
> 
> But probably not much longer, people still using it might be on an
> older Isar anyhow.

Exactly. I suspect we have not too much overlap here with "latest Isar"
and "oldoldstable Debian".

The biggest issue will more likely be around isar-cip-core where we try
to address with one layer multiple Debian versions. We may have to scope
down or also drop buster support there.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux



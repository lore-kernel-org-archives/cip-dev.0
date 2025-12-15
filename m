Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6040D5B16E
	for <webhook@archiver.kernel.org>; Mon, 15 Dec 2025 13:39:15 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.71])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.48771.1765805949783367817
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Dec 2025 05:39:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=fWYRxG8O;
 spf=pass (domain: siemens.com, ip: 52.101.70.71, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pjufPl5+ynG9FWyFXm1zJ2KrGbA0q4OVdfw04Wq1fDpMW+zBCS/O9wG9WJaM7EgSGKhoLNkQtZXMEBJhAZSbZh/8MxBdKokODdCn7h0eWsRRi5VKWCGGxmyeCpgw4KBIxrgtmRHLv/xt9jrOeYdJIHFJ69IW9w6zfd8t1syq8Bnx9C3nr29Eu5Hre4J1yLdY6GCCaLwIUIRNBeI8HMmBXfT5jrLGKlqOpwbu6rtEOssMMVm0CFW68D1vRjPGpah82fE7QmpPkSC47UN6XUvrg5uowlEmvY0C+8148jgUIXd/M502/OOOaepPz0GiVfSvcR3C5A/2B4KnpXu03VZA7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T9YGh8mxQcqluSMTfVtgo9Gk/MM1y4mRQRGnc0j0lWw=;
 b=izoluXQfP7yjGNmqiog24VguyzKfC5MWFIe7VyTWwRN0rpWezYjD7Lerw4WnpLalYNGVc/Di2E+usXPSs7NGL87a+1uRAC/BcKzr+UId9BVNo0VAVoU4I6X59HbI/RgcTrsgyfAl0VDEd/uijB6V7c94bGCtqv8ND6Qiv+pMWMb1mxirhnQx4NVsy4GnLcdbcrdIzoq1hyAnvYhanWtZgMYWmNjT8Kl2AiKK2f9T/0BGc56vowFYonocRjly6qB8Zd0FGSA4M5RzZ9m/DJcor/f03kJ1JDSKOrvn6SN0UUCz4yuxP3Q0/EL6gaKxl4tacsNDQ0VrUmAqXNDzm9kvHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T9YGh8mxQcqluSMTfVtgo9Gk/MM1y4mRQRGnc0j0lWw=;
 b=fWYRxG8OD4tYrhxrpyNLHtm9v2gT3jd5P3uawxSFIhimMJ9ulcDsHBisqBvAfBAUZxA/GxjHg1u+gUk+GW+wUf5JqTAPLq4cw37V0Kzq+Zn6AFxFowc0PH92r+ZeJlbGHFCd0PYjPuIyG9mhvXBZ/7Nz793FGHuTqNc4r0jigRUvfk3BpS4S1RdwZUI1L7/5zL6+HUfPP+qZtyOSf7jcRLf5YqS7oSMVcoqfZh36fSNeR6Y9kvQAAYKa/ndO2MzlY1/R0OKlxdYTP0Qy+akHVIVrs4mLjbCixKt1owsDIjLk4pIx6+mq2gmCWjuJwpVsU5DTg1nNL4+12L9fJnWpJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:89::19)
 by VI0PR10MB9029.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:219::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 13:39:05 +0000
Received: from VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ec8c:43f1:36b1:3314]) by VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ec8c:43f1:36b1:3314%4]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 13:39:05 +0000
Message-ID: <2168c857-bae8-4523-ad55-6d5c06b20de6@siemens.com>
Date: Mon, 15 Dec 2025 14:39:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH 2/3] fix: ensure that the
 partitions are available
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
References: <20251215093719.323668-1-Quirin.Gylstorff@siemens.com>
 <20251215093719.323668-3-Quirin.Gylstorff@siemens.com>
 <103d8690-317f-41f4-ac5f-1ef30624aae6@siemens.com>
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Language: en-US
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 Z2NBPBZUysw=
In-Reply-To: <103d8690-317f-41f4-ac5f-1ef30624aae6@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0200.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::9) To VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:89::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR10MB2319:EE_|VI0PR10MB9029:EE_
X-MS-Office365-Filtering-Correlation-Id: 8be3b1ba-8a19-44b8-d783-08de3bdf5100
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?elM3bG41QXJsbVpPdWNERVVjMWZuL2JmQUtFMVEzZ3lZN1gwZTBnZVdhYVlZ?=
 =?utf-8?B?eTd1MEZuUHQ0SkRySXBGMTVJK0E2NS9QbDdNRlZXUXFlcEw1dHZXUnY2dkJj?=
 =?utf-8?B?YlVQUEdISW93QUFSVGFUSHN1SC9KOFUrZ08waUVGQVd1UlI3SVVkVi9Xd1Ns?=
 =?utf-8?B?a3dxNVJ6enlmRTNwbkVmU3dxZGJMWGpJQ2doSzFLM05KUE9LaUc4S0tpQXBU?=
 =?utf-8?B?SUhVYllmcW1RbG1ZeFptREUrV3Fwa3pFa1dOdEYwZGpHZHMyeE5xNFdsdmtD?=
 =?utf-8?B?amRVVENVK2ZsSklmbXhyb2pYdkR4eVlrREZWRDBxMHdVVDViWDBIMklPUWhC?=
 =?utf-8?B?VHRjM3hxQ3BxWm1saFRiM0tFcG8xd051ZW1SRzgxd29rNTJva0xDZmlaVE01?=
 =?utf-8?B?SVdUbGFQK0lsM3lSK3d3UnJTUVRPM1ZMQ0VEUjh1TFJud3ltVEN2b0NBU2Vq?=
 =?utf-8?B?ZG44bjhoMmg2cHpndE5qS1lnTW1ZaEVremNhOXc3UnpWOTRRcTIvcThUK0h1?=
 =?utf-8?B?VFoxWUhtUE5XSTlqRDlvR2pHbjFZbW94UVk0OGt1UEJ2MWVNOFl3M0M3Z1hJ?=
 =?utf-8?B?bUpLWE1PWEk4MUxjUmhucHRIZnpWeEYzTmxwck5QWEViVENOV1RqSnlLWjlt?=
 =?utf-8?B?dU9YWGswVGhjblNnRGtoR1FBZEJlUUR6TGxNbHEzcllkU1FkeHBuN0tjOFpH?=
 =?utf-8?B?OXlSTWJaODdOZDJrQXVxUTI4eVQvU1k3cHBWUXg1OGt3d2J0dkNPMzJZTGo0?=
 =?utf-8?B?T1dsejNjMUVGVjRyTW5ZWi8vbXlubk5RRWUyL2RxdkZJU2RVamRwV2hqYldD?=
 =?utf-8?B?Sk5ZZEVlaldodzBLY2kwNlBkSG1aTkwyaTI0ZUl3MGRuck5taTcxOHRMckhn?=
 =?utf-8?B?QkxhTjZydCtBazN2b2EweVZIZWxkR2c0b1dyRndNK3U5ZE50UjhZcnlGZEhs?=
 =?utf-8?B?V0lhWWRtOEx2dXV2U1RRQk12VkFUMWErN0JvTzZuZTUyMTRmdHdzOE15ZWV0?=
 =?utf-8?B?Nk9iOTFjWTZudTBFTXB3OThlN244d2crZkpndG10VDJDVE12UEZrYXRjQjVl?=
 =?utf-8?B?aUNDdStzNXJnY2hhYU9raHNHbmJpTTBpMGlIeXkxc0Z4WjVORXpCd0k5akt4?=
 =?utf-8?B?ZUxDbWR0elc4eVZsdjVPR2lEclpISURxcUovZVd6VU9hWVdGWHQxUnpadzlC?=
 =?utf-8?B?WTI3SEM4WCtNNFpDcHdHUlFtV2Z4RjBJTS9RQnpHbnZ5TFY1WFdrTGJ1SmJS?=
 =?utf-8?B?RmVWWkRFRW5velkybzFqd3hvQ3AwUlA0UHBFTFlVdXpsWmxlVXdXVk45clB4?=
 =?utf-8?B?VDhLZTRyU3FReHZqOVdjZmJvMkNrSFp6ZFNnbmR0NTJ6dFRtTnhZcThPL2hw?=
 =?utf-8?B?MDg3MjJTNUhJRnFiRDduZzNTeFZicjhjaDNZekVmQ1R5NTFrTGlOU2EzSWpK?=
 =?utf-8?B?RElmTSt5dVc2Mys0NWp6VXJEWGVrMlRDdWZwcG00WmlKZkxCL3lTbUpFVSty?=
 =?utf-8?B?enE3NVdEaGJ2WTBuZ3gzeG9DdGNNdGFtUlBsTENvT05MQUhQVklZODF4ZExy?=
 =?utf-8?B?Uzl1MG9oakhXVDlRVnRjUGFrMUNsb0FlRStGeUpIcWZCcUx0QWJXWlFLYS9s?=
 =?utf-8?B?K0Mra1NuTmdINGVpZkZXcWJnRXo3SjhzSHU0VzU5QWNrTGwyUkdYSXJPdTc3?=
 =?utf-8?B?eUNZUGNZSDhNOTNGM3BPRmtTcWphRjV1SnpDTVk3UW9wUUl1WHh4V2NpQVBk?=
 =?utf-8?B?Zk1zUHhlaTVVODdxeFJlalBuSUtZUlpMNThHUEtobGVtOUZ2OTZDTFhiRkh3?=
 =?utf-8?B?QUpQb2JidTMrVmFhNUl6cWZjZDUrb1Iya050eHRKVHdRcm9tVXFML3FpSGta?=
 =?utf-8?B?b0hkSDE5aVIxeElOVE5wdUxJUG9ERDZvOGYrNUpWaGx0bXV3bkRWRC8wZ1JX?=
 =?utf-8?B?TnZrRldldWNrUjBBRWtxWTNyejFxbXptZ2NOTzlzYXlDOXZUTXV1cnA1Y0NH?=
 =?utf-8?B?eVBxK3g5K1N3PT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VGgwZFZmdlBISmdHcmhWUUdheG9lZmxWaEdkbDBkNHhac0NCV3Q3em1mR3JT?=
 =?utf-8?B?b2VvZUpUS1oycVJiVVk2TW5tM3h3bWhpTmlYWmJLeVJDR1BpRkM3UEhjYUJh?=
 =?utf-8?B?OGwwbjJPcWhkMlcyKzJ6M1JIdEpNek4rVDhhVW9uODlnbk5jNklxN0hvSSts?=
 =?utf-8?B?ZHBmclVOa1gzQlo0RXhGbVM5T1RPaU5qeFhMWmVGNlEzOWlBRnRBQmhBUEZz?=
 =?utf-8?B?ZSt2d2xoOXRRbC9leDFzS2ltNExDaVpEaDc1K3ZYaVVNZEwwNTFtMDlFbDhK?=
 =?utf-8?B?YWoxc0FsUC81eitFVUVXSmJFT3BtdzZOZGZLYitGbFJzRkRIbFdCMThJbk95?=
 =?utf-8?B?Y0lsMlpQSGhJTzJNSTlBdkhVODFYM0FidkdJcW1WVTF0QjVPZGVoZmxzMVZM?=
 =?utf-8?B?N2U3blRuVm1VS3pYS2RzYk5qa0V5L0gyOHFUenZER285UnhueEdKa2NCeks0?=
 =?utf-8?B?dGJLc1p4bEpjTVR3TWE0eE5uOU9wdXFlYSt6TC9BVXUveWtuR0xhdkRuOWhY?=
 =?utf-8?B?eXJ2azZtRGRNYy9qczNDaTFROGNSN1lZM0V0cDF3K0RvSlBwOHlOVlZhSWlu?=
 =?utf-8?B?YXprTXVOSzk0QkVyUjRBY2NEK09PNG8zUGhGMkFqa1ozekZDWnl2cmhzcXQz?=
 =?utf-8?B?Nll3TU80bGFwTmh6VGdick4xbjRwTy81R3VVb3BXRmtkT1JrRjkyWTh3WHcv?=
 =?utf-8?B?OGpOQ1FWZTVTNzdQbTF4Ykd6U0VQMVdKaWZTRkhTTDg0NDN4UjRUQ2U2eFg3?=
 =?utf-8?B?OW9MR05wNGw4b1RycFJIVmFYNGFGZXpoWnowWW94VkJsdUNwRmtPSCtCZXBp?=
 =?utf-8?B?WTFVZWFVbzVXaURWMnFETm9aYnN6ajg2VUw4RDRQeGpMbTBwQndYd3MwV1U2?=
 =?utf-8?B?ZnU3b1d1bmp4WHFaWWoyLzZSbVEwa2hwRmwzSWpnSUw1cjNKYjE3WUQxWkg0?=
 =?utf-8?B?OFBBRVY4bkhQbW93U2lrd1gxYS96TVc4bzlnUm90OWpNNTNqMGxTeHNyVG1a?=
 =?utf-8?B?TElDYUs4cmNxYVUxc1cxT3BYMWhDVHlpa1R1Rm0zRDdzdC9INHNwTGp0ZFc1?=
 =?utf-8?B?SGZ5NTg2cXVhdkJWSmtUR1hoZENkdGJLWkRvNlN5WHV2cmFGVWhVWE9RQnNh?=
 =?utf-8?B?eFdFb0tXZkRqdEI3Y2c4anBsd2RhQ2VaOElSL3EyM0dhS2RJUnREc3pQMXRw?=
 =?utf-8?B?aS8zVlJoWU1MajRJZWw4UG5MV1VCVC9YUmxseVBuenJyYmREaEpkT0JEejNL?=
 =?utf-8?B?THYxVVBWVVRKZXFmWjM0dDN4SXNVdTlSOTdXdGQvU2dmeHQyZmVOMjJ1dEZl?=
 =?utf-8?B?cVVxSkRZK3RpUi9iK0FpSXJvVFVFVll5ZlFheW5DRmFZNFFGMUViQ3BpbCs5?=
 =?utf-8?B?K1FnSVhMMWdYdSt4UURMZ3dvWTVqRHIxOVY2Qmh5UG1DbkVvcXdEY3JzYUpW?=
 =?utf-8?B?bnJUbW14ZmlZempwYW4zZUF2czJJTkJ3Mlk0cHcvNU8yRWh0RllGTE1oZVpO?=
 =?utf-8?B?b3FQckw1L3BKQkxpdXBUVktWeHM0ZytlR3VVNmJKTjhBckh3bjFmQWlFTjFm?=
 =?utf-8?B?Q2JGM2hMRUVVaTgyU2w1NmJYMzI2NHFBYzZobTB0RGJkckRvQm8rS0JnaEts?=
 =?utf-8?B?VC82dzlvZDJrQlN2NFgzQ0JORlA5THhMMktnLys5SWwxVTd1MTFQMDNPZ1ln?=
 =?utf-8?B?Sm91RUJzSlRWNzhycGpNSEkxdFJ0aFNUWnN2N1h1WEhuZ3ZERVoxcnNwN0Er?=
 =?utf-8?B?S2NuSjdsM0pUUFI0cHRoOThmeHY3WnNlMGo2RHBXTTRkamo0YzlDVHNOdVBW?=
 =?utf-8?B?cmtRZktjK0hZUEprVUlwMWZqZENoUStUcjBVRmp6NytNVU40ZjhaaTltdjVF?=
 =?utf-8?B?dzhlVFBZcHYrMWU3NDQ1dkZyc2NHaTNOT0dUV05QNFV1azJ1U2dwc1RpWXYy?=
 =?utf-8?B?ZDhheE1nd2hPQ1RZOVJWREtZekVxcksvMG1ZOThvLzhqZ2VQNUxTUG5XdkVh?=
 =?utf-8?B?Z1crOTAzNjhLR1BMRnRuZzhGenM0b3diclk1NzNNVzhGR2F4YnlpNEpEWkp5?=
 =?utf-8?B?aHNxR3J6cFlsc0JvblFxbWJvUGVNODRNWEJZNlRHMUx2NWV0b0pqd2E0U2Qz?=
 =?utf-8?B?bUZHQ0JYSVhsSXovWU0xblVXd1ZseUg0T0RQTjFxK2NTdUcvUFdySXRBaEtT?=
 =?utf-8?B?YXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8be3b1ba-8a19-44b8-d783-08de3bdf5100
X-MS-Exchange-CrossTenant-AuthSource: VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 13:39:05.7766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gdRFwT45sw5WSBNX6L4C2qezEV3i5CLis6v0kM9ULAKuY9VJ0af3VSr/+ovnYBcHEJ4q5U0Kd8hgbFAREbSuf1AehUvyNB7dj43Yea/tbBA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9029
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Dec 2025 13:39:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21063



On 12/15/25 14:14, Jan Kiszka wrote:
> On 15.12.25 10:35, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> Check if all factory-reset partitions are available. This fixes an issue
>> on Debian Trixie where the factory-reset cannot find any partition to
>> reset.
>>
>> Fixes
>> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/145.
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   .../files/factory-reset-script.tmpl            | 18 ++++++++++++++++++
>>   .../initramfs-factory-reset-hook_0.3.bb        |  7 +++++--
>>   2 files changed, 23 insertions(+), 2 deletions(-)
>>
>> diff --git a/recipes-initramfs/initramfs-factory-reset-hook/files/factory-reset-script.tmpl b/recipes-initramfs/initramfs-factory-reset-hook/files/factory-reset-script.tmpl
>> index a6c622f..f0ad40c 100644
>> --- a/recipes-initramfs/initramfs-factory-reset-hook/files/factory-reset-script.tmpl
>> +++ b/recipes-initramfs/initramfs-factory-reset-hook/files/factory-reset-script.tmpl
>> @@ -9,8 +9,26 @@
>>   #
>>   . /usr/share/factory-reset/reset-env
>>   
>> +. /scripts/cip-initramfs-functions
>> +
>> +check_partitions()
>> +{
>> +    found=0
>> +    for partition in ${INITRAMFS_FACTORY_RESET_DEVICES}; do
>> +        if blkid | grep -q "$(basename $partition)"; then
>> +            found=$((found + 1))
>> +        fi
>> +    done
>> +    if [ "$found" -eq "$(awk -v var="${INITRAMFS_FACTORY_RESET_DEVICES}" 'BEGIN{n=split(var,a," "); print n}')" ]; then
>> +        return 0
>> +    fi
>> +    return 1
>> +}
>> +
>>   target_devices="${INITRAMFS_FACTORY_RESET_DEVICES}"
>>   
>> +wait_30sec_for_condition check_partitions
>> +
>>   if /usr/sbin/get-factory-reset.sh --delete | grep -q "factory-reset"; then
>>       log_begin_msg "Factory Reset"
>>       for target in ${target_devices}; do
>> diff --git a/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.3.bb b/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.3.bb
>> index 16784d8..95fff71 100644
>> --- a/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.3.bb
>> +++ b/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.3.bb
>> @@ -30,8 +30,11 @@ TEMPLATE_VARS += " INITRAMFS_FACTORY_RESET_DEVICES \
>>                      INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE \
>>                      INITRAMFS_FACTORY_RESET_CLEAR_TPM"
>>   
>> -RDEPENDS = "factory-reset-helper"
>> -DEBIAN_DEPENDS .= ", coreutils, util-linux, e2fsprogs, btrfs-progs, awk, factory-reset-helper, findutils"
>> +RDEPENDS = "factory-reset-helper \
>> +            initramfs-cip-functions"
>> +
>> +DEBIAN_DEPENDS .= ", coreutils, util-linux, e2fsprogs, btrfs-progs, awk, \
>> +                    factory-reset-helper, findutils, initramfs-cip-functions"
>>   DEBIAN_DEPENDS:append:encrypt-partitions = ", tpm2-tools"
>>   HOOK_COPY_EXECS = "mountpoint findmnt mktemp rmdir basename \
>>                      mke2fs mkfs.btrfs awk blkid rm get-factory-reset.sh \
> 
> With now (almost) every script testing if some partition is there or
> not, I wonder how much time we waste in script running later on and
> re-testing this. They will not wait but may still iterate over partition
> lists and call various binaries. Not necessarily a matter of this fix,
> just an observation / wish for optimization (if needed).

As an optimization We could create a local-top hook for that and add it 
as dependency to all recipes. I have not measured how much we loose.

Quirin


> 
> Jan
> 



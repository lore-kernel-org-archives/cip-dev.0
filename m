Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01FD0C021B8
	for <webhook@archiver.kernel.org>; Tue,  4 Mar 2025 15:03:46 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.65.41])
 by mx.groups.io with SMTP id smtpd.web11.23844.1741100622816098705
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Mar 2025 07:03:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=BwWMnIKg;
 spf=pass (domain: siemens.com, ip: 52.101.65.41, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GtUR7pX7q7+HzpLorhsQdhvbWbDPLVPdnzJU3HR0Ag4U1CSHA05Z6J+2+wVLOufAQLtMJrjVlZCa+QHKpUAjKf4HZITgckg2wofa0yZchoYN3D3pG8Xap1zHnljeJifjwsJfYeWAr7fvPqcQ328KEavJqtN5P4bzcvm4skgV3dIOzb0GY5cQLh9jbAMGpCDQyUlOU2AaMdJYv2H8HR3kuuKr81iUO1Yw1oBy6KivdpAaTeqL4KsRSKNOhjqFoUOlwlK4fPx080KjNq4ghn1Hw7cmwS9xvLdB7d6TxNLCZU0kZUZYJWws9tl2PGb2SfpcI5CVLMMMQOXo6VKaB/S7tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KgDv2/sR59wnquzkVi5/9XNXVqI1WfvwkT/vSahvz6E=;
 b=a1hwwFjgovanCj/3DfRc4R96/F1Lt0cUr7h2ihxM8Gq5pGBHstVNHosZFjQsp6jZN9ExLneBYKbOwgIV/9t/x/Fh3K5sM2Yvu8ELj4N6eReqX0zrfvnDiPzh3mNQJBCTFfzDeTa4zejOWVmxTMg2Fj05w9OwdxTpjYxVDuVSVWRTMbjA3Tb+JDpXVzcsTaj5gSQ1ibjCaa37HXjV6RBUqHljD0udauT2qtTo7foONiMRI1RuM0w2uCgm5ELKI7MaThB7o9LRHDDm2rdxObD25lX06PseN1dlqX2q1lhLQXsLYuPK/UNTzsKVKxrVYYzQZv+LkprxMZdgzaeVmDm6sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KgDv2/sR59wnquzkVi5/9XNXVqI1WfvwkT/vSahvz6E=;
 b=BwWMnIKg/vPz0fB7oGfksEdkLzzyX9f7yOl94B8Kf93fQ0U9UUBXE6L8VaO1/XQQx7tXFSeqJb9MDdXdvioHlK57qOnM5UhUEn4/jD7db76mVK+m1/bYasa5RVtaGasdPxfGrXFySK5qSMTg/kzXf+PMsZuoiTuCdoJHvp/R9zL89UClL/Rs0kAvrUcnsPB8m+EuQBdlkC94ylS+TJwu/Ha80etwsUXs5QyFs9tDJk3AKOz8WVRRqgz3sTk2wlTMZh4TgkG5Nim9/tAfp/xSDG2CMQnumTezhORMPVL/qcr8SSYgAKgbDywoYlOJSRNgiCvVTNYY/T5VmuZDMnBsQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5220.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:348::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Tue, 4 Mar
 2025 15:03:38 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8511.015; Tue, 4 Mar 2025
 15:03:37 +0000
Message-ID: <c8408752-0b2b-4606-a36b-fbf564e8c1d5@siemens.com>
Date: Tue, 4 Mar 2025 16:03:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] initramfs-crypt-hook: add 'format-if-empty'
 feature
To: Claudius Heine <ch@denx.de>, cip-dev@lists.cip-project.org,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>
References: <20250304130743.2812183-1-ch@denx.de>
 <20250304130743.2812183-4-ch@denx.de>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250304130743.2812183-4-ch@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0199.namprd03.prod.outlook.com
 (2603:10b6:610:e4::24) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5220:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b5c5aaf-2524-4db8-3b0f-08dd5b2dbdf9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?cGFRaUZHZWloMGMxMU1WSEVNZDlBVXNmV091NXMrWTVFRklWSTZQbnp6K1ht?=
 =?utf-8?B?ODBqOTFzL244M0MwSHpHWEI1RkNIaHV4VzNLSjBGV2ZGNlpkNG5ON0xhRTRF?=
 =?utf-8?B?Y2szU2tkOWViK2JtQklRQURnYVlSS1NJSmhseVRISTVqamhOSDczRi9ENGUv?=
 =?utf-8?B?NlJ4QlpJNVRnNmd0SjdQM1pWN0o4c1dqNmNzTEY3OHlLazJYOTYrSWRwa3Aw?=
 =?utf-8?B?akpJcXpqQk5rcS9LOVE3ZUNtdGJZdFBUNmlpajZnQ0ptZ0U3SFJXamR0Z2tG?=
 =?utf-8?B?cFBmSVkvWDhkT2RGTnVvNGRtdlhIUDMrb1RyYmQ5cVp6VkxTVVVkWlV6THQ0?=
 =?utf-8?B?MFFkWHZhZllyemJtU3N3TDRudWZEWXdwYngzb3AwVlR1NDdvMVR0L1ZQSjFo?=
 =?utf-8?B?MkFPNWd3NlNNSFNvY0lReG5OTzRvYkhQck43YXBsS1hiNGd6S1ViVjI0Q0xx?=
 =?utf-8?B?TXN1UmNIWFpLWEVPMzNGQmIyS3NxcUY2YmxkaE50cVhKb1I2eTNQeXZ3dUR4?=
 =?utf-8?B?djdPQ2orZktVV2gyMy9zM1JsbVJZRDNuKzhHTDdoRlI1Skp0U3RzNXZqRytz?=
 =?utf-8?B?R2NBZ2hqa2p3OVdPY3k5eGNJK0RCWGhVSUtqYWFwOU0yUHJBc0dNVzhUakZ2?=
 =?utf-8?B?akppRU9HeXppNnJ0QzJCNkhkK3BnMHgwbUxzODh1U3Y0U1V1YkpKOTRBMnR4?=
 =?utf-8?B?M3VwSEdpYTJDc0NlQmtiYXFwQjhHK0VzR2dIdVdOVVVuZGwxTnBrOFgrc1Uv?=
 =?utf-8?B?aG9tZnRQY2puMkpIcEpBMjVIbVFCa3dFNGtGU1dJdHNCQmtuUEJKeFowWlg3?=
 =?utf-8?B?akxXMzN6TTlvUHpyN2lkQnNKSTRlbUEyNVBzNVNxbWFTcjB4cCt5cllMSW1p?=
 =?utf-8?B?MXQxQ01WblJFUHNnTG9JaWJqbnZmMW9LNkFBTEZHVHRlMEJiY2lPOThCWkJB?=
 =?utf-8?B?VXZ3UVZCSEVBNVZTa2J5UzVhMGNVM0tJUVRZcW56NWZWNXkxbVhmQk81NmVl?=
 =?utf-8?B?MTlYdVorKy9nU2N2N2hlQWludlZHMlJPZGs1L25sSmtsREQ1TVJGVmg5NDkv?=
 =?utf-8?B?aU1kTWlVZDh1dkdGL2tkZk9TWVVOUk9NN3lCcjhGWlBjK1NNT2toN2tqZUlk?=
 =?utf-8?B?SzNtMXNiS1dQRU5wY05IdHNJQzY1QzJQWllwN3I4QjhMNTJiYUVFRk5sTjNa?=
 =?utf-8?B?UEk3VmZJUHkzZnJtZVJVZzRmZkhoNm1WNEI2cHpmSHFJcVpTR25UdXpWdERl?=
 =?utf-8?B?d2FJR0dlaktZNzBUVlNJQWxNQTZjc3ltblpXRU1neE55L2hBZHpTV3pZWkt1?=
 =?utf-8?B?S0NBZTRmbjl5cXVERXJqb01selJkdGsvakJMY3hINVBPVWpiaFpjdHZnU250?=
 =?utf-8?B?VU5INmF0MDFCMjlqVm84eTJtMWx2YlBFZVhHSncyTVUzWktPUVJSeWtKVEs3?=
 =?utf-8?B?ZFFaZ29GdzBSRnM0Y1Nqa3ltUkJLZnpBVmxZbVdjektuOXJ3UDBJV2E2YjA1?=
 =?utf-8?B?b2M5ZjFDRkx0UzVPQmNDMHpwNlZEcmFFSFVueU5aRUxqN0ZKMkR3TUQ0cWFI?=
 =?utf-8?B?SWVlMzlQdmpmaEwxNW4xNjhTL09CWURHL1RtckxyMWlBWjk1RUY4UFU1aXVS?=
 =?utf-8?B?cG1BUW5KaUlocFNUV1BGNTcycEJmcXZKZ2V4dXF5ZHd6NmxjelRzTHR2QVZY?=
 =?utf-8?B?V09KOExqUVF6SUw4SkVEdkw5NEtMTmZWTzB1SllRODJlZDM0Q1FGUkxHd1ZY?=
 =?utf-8?B?TWkxRENLdXV1VjJONEhYa1RLZlpWc0VPQkhraFUxVXYya0JQS0h3UFFlK1Nm?=
 =?utf-8?B?R1oxRElvYlhoOEpLTjBMd1U3bTJLaEJ0MFQ3MG1FcXRwMDFTYTUyUE1FMnpW?=
 =?utf-8?Q?XYwojZPx0v4J6?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WTJTVFdDS3JsTmhHcHdmeFFMcnZ3alJSeWo0N3piL09PNHJlUmI0UHhSYldq?=
 =?utf-8?B?eUtFVkRZdXo3THdlNTVWc3hVK3ppOHc4UldvUXVIWWdnc1d0TkZ0M0tzV1RZ?=
 =?utf-8?B?cVpEaEFUSHoycmdhcHJERHhmbGU2MVVGOGYySXB4aXJjYzZ6SExOMDVEVGdh?=
 =?utf-8?B?RkRQYXhQcnNVTGdPbFdNcTQ1RU1rWm5VV2REdEdXUy9FQ3Jkd3FnREo3cEY5?=
 =?utf-8?B?WkJlUFM4OGc2a05ZUU5VSUdpdXovZ0owelI5QVBINzRON2VOTkR4WTZqT2t6?=
 =?utf-8?B?aHBORzhmZ3p5cytXSitGekZTL3ZvR3BiZG5OREFHbmZMNkhOYVowaDA2cHNR?=
 =?utf-8?B?Y2RTb0hUTDFhMlFjUTBYUHhKR2VBY0dtemlCUWhLK0t4Tkw5Q0VaVVhvVVdT?=
 =?utf-8?B?T2V4c2JMNEdpcjVmZFNMUHVQQ3BKTzcxaXVNK1VXVWdwdUxkZHpYMEVTamx6?=
 =?utf-8?B?Q1JWRGFUTHJwTEc4aHdFbkV4UElvNlVYWEtPQlcrZncxNmRUMzAzdkNabUFh?=
 =?utf-8?B?b3JXMVFCQWwzRFQwcFhjOWNkN096Ri95d3QvOWk3UEJZNmt6ZmxpZDdSbFJ4?=
 =?utf-8?B?djdGNTNWeEdsd0ROdEZTK2NEQW81YW5URzlKWEw0RmRxN0RUcjh5V2Y0VnJV?=
 =?utf-8?B?ZXZ2OXdROWFNaTBvZ3NDbDZuNFZWYWM2MWs5d3g0UktzSXk3azhkWEM5bHpy?=
 =?utf-8?B?YlRwN1lMY3VST2g0cGt1WSs1c0NCTThFeTRjUERBS0ZEb0pLUnRRUzhoeHUw?=
 =?utf-8?B?NVIzMTRZek1MSnV0UDgwTDRyVGhnZElwRitJbDFuei9BRGxweEsvejkrT1gv?=
 =?utf-8?B?aVF6a2psUlgwWFRyYW94b2lzbmFTMWw2SjhlenQ0cWhadGdXMUJXTzM5L0pJ?=
 =?utf-8?B?WmZTWldycVNhQ0tWZTZVenFlbnJVbStPQ2dyRDA2U3FJd0dCQU1icjE3V0g0?=
 =?utf-8?B?ejdnQ1ZvRE9qUlZNRkRwQmMzbGVVZUNYL2RPT2xvYm1yV3FVWW9US0d6Uzdl?=
 =?utf-8?B?bUlhcTFFWlJDeXlQOWMya3VxZXBjTzZhTTZmYko0MnprRkZ2WDNZVTFrMVBH?=
 =?utf-8?B?QkFQWTZXU2o1Zmw4M2txSnpWZzBjNVNwSHhtMmtVekxhOTY4YVQxS05mSG93?=
 =?utf-8?B?a3lEWkZ6cFpGaVY4UXVBaEdvUldqMVpWZDkySVF3WFRDNGtLSklTUEptSnVk?=
 =?utf-8?B?aUYyU1lLMTlLc3ZFVmxzQmNwL3Zhbno5eTBnWU12VmJ0Q0RKUXZNZWh3U1N3?=
 =?utf-8?B?eGI0bm1tcHpnZTZUSk1EOFRCdHIrK245a0ZPcWZsYit1YVR4cnMzdDZkYjFD?=
 =?utf-8?B?dFBpalRtWDBTZVA3UGdGaW5MWi9VVytGbk1HTjYzTTE0NGRabHdZMHhjZWF1?=
 =?utf-8?B?djBhczNROWZXVzViTVhGQTdkVkNzMFovSjJEYWVqbHA2cUVSS3FsTVp4RjY3?=
 =?utf-8?B?c1RJNlZJaE1RdktweFNpMkpVTzJXamxUaUZKZk9xNk1YUUc1RmQ2TXd6YzYx?=
 =?utf-8?B?UnZQSlVnL2k4N3ZtdmFBZklUSHdtbnhNdzV5WmlMQUZHOWhvTWRHQURyQ2dH?=
 =?utf-8?B?TEVkNjdZaEFhSE5sQ2xENUhwc2tCSlZJQUROSThqd2tweU9jaHZaVXZ3dzZH?=
 =?utf-8?B?dGVQQ3pnVVFxSSthZitVdTltZnlkRFU3S1IrOWxweHNEQkdwaTVVZEdLalRs?=
 =?utf-8?B?WWN5WEdzUE9xWnM1ZlZyZ3hoWWhJN0t2d1cvRW0rTHF3MTQzN3NXRmpMTTNM?=
 =?utf-8?B?cWF3RDdhTzV6WHMrcnQ4L2NJc0hEK3dKSXZQVkhoR0hNWGR4enJLbFFhR3RN?=
 =?utf-8?B?Y2UvWmFrcGs2WDdMTnAzZDNOa0ZkMVZvWXJnakNnWUtCelNzREE2aXRkSWdH?=
 =?utf-8?B?Mm03RHhrd1VZUVZZUnM2ZGhRdWM4aHd3RFZKRmxRK3p5Q3JoYWdBamFZanF1?=
 =?utf-8?B?M2pnM09PS3FrdnZTRlluQk5Tb2UwQmlQRXV6U0xzZlR0RmZHUzUxa2VpVzJK?=
 =?utf-8?B?NHYwRnZDTzQyU3lYVExXSWZSYXFqNStpOWxMblRHdTduNjBFUXBtcGJYYVBQ?=
 =?utf-8?B?a0RZWVZobmY1K0M3UHZZcEtNeWV2ZmRLWUJmVDVnejEvT0ptN3MyUEpjeitX?=
 =?utf-8?B?cjFJMHpWVk1IV1RJRVlLeHlIWTBQZXNlWnh0aWNZa2o4NEt3TUdDa2ZVMDFz?=
 =?utf-8?B?bUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b5c5aaf-2524-4db8-3b0f-08dd5b2dbdf9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 15:03:37.8056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SUvuLG7KPGp7NS5kM9uZpENKThrUgaORDP+9TzBn+8QaGTEx7Wn8NKkOxKqub6D4r6s14sU2fYqSFiFmrZxZLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5220
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Mar 2025 15:03:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18021

On 04.03.25 14:07, Claudius Heine wrote:
> When encryption is enabled from one update to the next there is a
> difference between flashing a fresh factory image to a empty storage
> device, which contains an empty fallback partition set and updating it,
> where the fallback partition contains the actual fallback partitions.
> 
> In the update case, the update case, the fallback system should be left
> alone and unencrypted.

Please re-read the sentence and fix it.

So, we are talking about encrypting the a/b rootfs partitions here,
right? Then please also explain WHY we should not start encrypting both
partitions. What is the difference to having to continue with encrypting
the single data partition after a rollback?

I guess encrypting both would be against our principle to not touch the
working partition set on an a/b update. Please make that clear. If there
is more, please write it up.

> 
> When doing a factory flash, the fallback partitions can be encrypted.
> 
> The best marker on in which case the system is booted is, if the

Please re-read the sentence and fix it.

> partition is empty or not. The 'format-if-empty' option will format the
> partition with a luks format in case the first 10MiB are empty.
> 
> Signed-off-by: Claudius Heine <ch@denx.de>
> ---
>  doc/README.tpm2.encryption.md                    |  3 ++-
>  .../files/local-top-complete                     | 16 ++++++++++++++++
>  .../initramfs-crypt-hook_0.6.bb                  |  2 +-
>  3 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/doc/README.tpm2.encryption.md b/doc/README.tpm2.encryption.md
> index a97425c..84e6cfe 100644
> --- a/doc/README.tpm2.encryption.md
> +++ b/doc/README.tpm2.encryption.md
> @@ -42,12 +42,13 @@ The initramfs-crypt-hook recipe has the following variables which can be overwri
>  ### CRYPT_PARTITIONS
>  
>  The variable `CRYPT_PARTITIONS` contains the information which partition shall be encrypted where to mount it.
> -Each entry uses the schema `<partition-identifier>:<mountpoint>:<reencrypt | format | noencrypt>`.
> +Each entry uses the schema `<partition-identifier>:<mountpoint>:<reencrypt | format | noencrypt | format-if-empty>`.
>  - The `partition-idenitifer` is used to identify the partition on the disk, it can contain a partition label, partition UUID or absolute path to the partition device, e.g. `/dev/sda`.
>  - The `mountpoint` is used mount the decrypted partition in the root file system
>  - `reencrypt` uses `cryptsetup reencrypt` to encrypt the exiting content of the partition. This reduces the partition by 32MB and the file system by a similar amount
>  - `format` creates a empty LUKS partition and creates a file system defined with the shell command given in `CRYPT_CREATE_FILE_SYSTEM_CMD`
>  - `noencrypt` will not try to encrypt the partition, if it isn't encrypted already, but will open it if it is. See the section [Encrypting the shared partition via an update](#### Encrypting the shared partition via an update) for more information
> +- `format-if-empty` will create a empty LUKS partition and formats it, like the `format` option, but only if the first 10MiB are empty (contain only 0x00). This makes it possible to differentiate if a partition is empty and can be encrypted, because it was freshly flashed via a factory image, or if it might contain an unencrypted fallback system and should be left alone.
>  
>  #### Encrypted root file system
>  
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> index 1ef784d..47533b5 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> @@ -294,6 +294,22 @@ for partition_set in $partition_sets; do
>  			eval "${create_file_system_cmd} ${decrypted_part}"
>  			log_end_msg
>  		;;
> +		"format-if-empty")
> +			# Check if first 10MiB contain only zeros
> +			if cmp -s -n "$(( 10 * 1024 * 1024 ))" "${part_device}" /dev/zero
> +			then

if ...; then

> +				log_begin_msg "Encryption of ${part_device}"
> +				/usr/sbin/cryptsetup luksFormat --batch-mode \
> +					 --type luks2 "$part_device" < "$tmp_key"
> +				enroll_tpm2_token "$part_device" "$tmp_key" "$tpm_device" "$tpm_key_algorithm" "$pcr_bank_hash_type"

Please re-wrap that line into two, it's getting too long.

> +				open_tpm2_partition "$part_device" "$crypt_mount_name" "$tpm_device"
> +				eval "${create_file_system_cmd} ${decrypted_part}"
> +				log_end_msg
> +			else
> +				# If not empty, leave it alone.
> +				continue
> +			fi
> +		;;
>  		*)
>  			panic "Unknown value ${partition_format}. Cannot create a encrypted partition !"
>  		;;
> diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.6.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.6.bb
> index df335c9..c9a7f89 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.6.bb
> +++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.6.bb
> @@ -41,7 +41,7 @@ HOOK_ADD_MODULES = " \
>  
>  HOOK_COPY_EXECS = " \
>      openssl mke2fs grep awk expr seq sleep basename uuidparse mountpoint \
> -    e2fsck resize2fs cryptsetup \
> +    e2fsck resize2fs cryptsetup cmp \
>      tpm2_pcrread tpm2_testparms tpm2_flushcontext \
>      /usr/lib/*/libgcc_s.so.1"
>  

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center


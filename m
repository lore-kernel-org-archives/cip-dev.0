Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CDBBC83030
	for <webhook@archiver.kernel.org>; Thu,  3 Jul 2025 05:47:34 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.64])
 by mx.groups.io with SMTP id smtpd.web10.15911.1751521651052991156
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Jul 2025 22:47:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=iiJrh6t/;
 spf=pass (domain: siemens.com, ip: 52.101.70.64, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t7j3PR9OwcbZ2//2TAwCNklv+Z62z+GFbBdPh/h4a0WvvAr7305GPSI8aCYeZaPrIRg3qbu/3QyoTc3jPxvhul2cAZjLt7x71KEUjkDHgPK4RPMu/x+cLttDoYhc6ILDvgtS0GubIE8ouCCmW1dSKcRy6wEm34bfGvmrVOiH0WA2hB6bW8MgZhp8FOlgf/dpS7rQ769I/l/i8hMPEhhNNB8vQAKLgm9aTf09IX5dXJH0q8aEcJ4m3+HnE3TC8nfcHrXjV9kpQukffv/1f722RodmCwBpFRe4HUCITwDmqpfJIGiCNzfJZFi6Bz+Pj/GrFZDQeUbA2agdACDHQSysBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5urYOx+IF5tdeBczIv+WBUOPzmy1BXcuzFGq/V8sbqQ=;
 b=ogynQSZ+2X5jWHJ9cLIZl+zhpEIMNw0q1tGxgTL7l3Z5sSIDH2h/FLIIaN9UR3krxjhlpFiECXDzT1qDANvf+4RaTLWo6IxM4JcjpXO9sU+4yH0PX7DcMDtnohOwIRJf2RIuVWlEr/q/f8IFbDOAgE2mbmG5htvE6+OfxLUMNMkrHWk033wUCaGGq5jOuW0pyYEPPG7k7dBU9kLHidAM0gEQhVcZOLSf5LpGBY/58O+WQaUmVzdzhOMG163b8yw0kOrekbtMidZ4uI06Iby5B1sdrkcBtGRkSN2CxjZDZltd9lYVJpgAkknoAxUQGLX8qeQveTLAbkzHgL4oJxwHJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5urYOx+IF5tdeBczIv+WBUOPzmy1BXcuzFGq/V8sbqQ=;
 b=iiJrh6t/hqh4zgQw9AD2JcjuOjBdlAbQkTc4mgiyMjwagCdCU/4q/3qOlV0NPY18wDlVztC6jV34akN0vrHTX9CW4V11iPNXTPRNtbsygUvlNUT+okJNjn3DgbU+Gu2E7TgIUKxAIvWwj/pD+MyADLIN/pfs5Zh0OkZKqAGAyoSVDlFsk6i862waF2PixYjkKvMOv8JBvXkG16zRNlxsx4eoWyFnz1w9i9W1yCcuHm6gy+/OMKKbK/fPH5AWnF02V351OExewBCGUVMy1IDD1AqgLPk7mk9yPa/N+3gDb3dadJigP7sWpeODGNSI13SdZgNt1HL4D3MFJZ11PmVePA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3661.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:137::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Thu, 3 Jul
 2025 05:47:25 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.8901.018; Thu, 3 Jul 2025
 05:47:25 +0000
Message-ID: <76b6b1fe-3e34-4089-aaf5-237ecacf9dd6@siemens.com>
Date: Thu, 3 Jul 2025 07:47:24 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0024.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3661:EE_
X-MS-Office365-Filtering-Correlation-Id: bc6d1fba-405e-486e-83a7-08ddb9f5168c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Tnkxa3dKVnZqUFk0VlVlTk9Dc0hBMFNaeXpHaElxOWxCVDYrWjloSE1IRFdC?=
 =?utf-8?B?K21RVUFsKzh3aFJsQ0V4bzBFZUpmMnMybnZjMk5EaHhwcy9uVW04TlRmTUZl?=
 =?utf-8?B?WkQvTkdxakRnMk1OeVV6MWNxSmprQnBVOWYxdjdZUjBtQjR2bFdYRTRTbndO?=
 =?utf-8?B?TktFYVVjcWlIWnAyRHBFMmZSVXFGL3NPcnh5RHJWcWpNNmhyUm11OFhESENk?=
 =?utf-8?B?ZFdWdytjL0o4VCtnUlcvUy9VTFVxbXcxUE1rMnM2bGwwMWl2cjBHT3JMTDgr?=
 =?utf-8?B?V1ZpTXpIKzBJWURhZlB6NjFscjIvVG5INkR5ekFqbW5aSGxldm5BUU5HcWJu?=
 =?utf-8?B?VERjZ0pPSnNLczdjeFk5cDIxWldPcHJsWDNxOUFRMmc3TVE2RlhIRXdEQWlS?=
 =?utf-8?B?WVF2U1NOakRHSHNQc0ovRUtrem1FK2NrT0p2RHUvbW5LRWZ4amV4Lzhkajl5?=
 =?utf-8?B?QkduNFk0dUFndURVV0pHYmdJYUNxWk9SRURvcVVqRFo3ckoya3djeHFsL3lS?=
 =?utf-8?B?TDVKejZzNGlFNjdObFd5ZVZRUmU5L20weUQ0SUZJTkFsS3k3RGxmTlBNYzFY?=
 =?utf-8?B?STQvNkxpSUZqaHc5cEljeTRqdUUvbXBTVUhGVWN0UXhDOEFHaXRuM0Nqc3NK?=
 =?utf-8?B?ckpYYXNPOC9YdmZhRE5NSVZndHJKSjhhK3E4RHlRVFlPa3JpQVFNOFFCOXpZ?=
 =?utf-8?B?ZnQzeGJuZVpmU2h3R3Z2dVpFbks2R0xXZ2xRcXZEZ0FQemJLeXFrMHM4THpn?=
 =?utf-8?B?WXMzT01wS3dCZ0tYaXVNZ0ZrMmd3UkFlQmI3V3B4Zk5EUXV3dVkrTVJwVCt5?=
 =?utf-8?B?Uy9XZXpwN1prWGxjSEtyMFA1dG5INEJieGMyZUx2SmJ3R3M4S3ZraGxyeG01?=
 =?utf-8?B?YXJsWGJZdzZibVhJcjBoRFc2QzByRk1qSTh0Y3ZLM2ZtMkJvS3FBeGZKanB1?=
 =?utf-8?B?YURUQm56azIwMXFDZlVCK25IK2lpSkV0b1lGalMxYTVFQVE0b0NWZFhhdlJ4?=
 =?utf-8?B?QkpwQW9tVURNbEE3V2JGWDZnNjI4TWlIZ1F5U01oZDBYRk9WdjZhNEpKanhZ?=
 =?utf-8?B?SzRwQmZvSWs1YXI3N3MycHlicXdEbFBDNVVDWDViMElncXFlWm5nWEdTZ3hl?=
 =?utf-8?B?Y2c3RzBIZ0ZsNnRSTmVCQ0tvdXNydU5VSllFKzJPOVlWWFZoRno5NGh1cUw4?=
 =?utf-8?B?RFRqZUVtdEppeVdZSGMrMkNUNHozS004ZFl3NFBMeFV1dUhHdTMwRTUrMlFu?=
 =?utf-8?B?STgzQlFHQktwMkFGaGs3dXJndUlZejlEVEpOQWY5cFlzT2FudEdSVDRvcVF1?=
 =?utf-8?B?Q2ZaZS80SUNGZDhKQkxLbjFNM1J2Q3I4MlFJVXVWNnBIeWZXdWltVXpIRG1Z?=
 =?utf-8?B?MjFadlVBY2t2MnNZT2tEL0o1Z2pFQmlrYVlTTWxxcG1nMytkM1dGbVVhU3Fz?=
 =?utf-8?B?QkpYU2FuUUhGaXF3MkJqcWJMbGVJQ3kxRk5MWDNaRTYrS0JRTFlwVFlPdlMv?=
 =?utf-8?B?QWdMWEFZZGlva3FzWHZjRUZPdFN1cjc4cVNuOEcvRmxRcjhhRzZCbk9YRGll?=
 =?utf-8?B?ekpUaCtjQUdabm1NR2JUUzFub1BiemxOTUlkZ0x6YTRIMkZnbFF0cXZUdWpx?=
 =?utf-8?B?eFloUzRiVUZnempJak8wemZEbXM4QTAwZDZNbzJHTXVTSy9XVWZDZ25VSnNp?=
 =?utf-8?B?ei9RRzJqRTc2cGI5U1VEYnpOTDQ4UjFqeEVjdzdGbnlhR3FEM282UzIrMVRs?=
 =?utf-8?B?MlpacmJqSmNnTHFLWVZCeWVxWlhLMElrU0w1Z05lTjlVZDhsSWVPR0VDLzVL?=
 =?utf-8?Q?vJlNXPtmNJgsmGLeOgnwXlEQPbdUKD9lWG/Q4=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MlBST2FFVlkzajlWaDlZR3RBajF6V0hpT3dFTWIvOGVOaUVSemRPemR2WGhv?=
 =?utf-8?B?Sm5XV3AxZHFpS0txQ3U3YXpxYjROTFUvN0FqbHhCWUkzOGJiRUFJY0YrSHFx?=
 =?utf-8?B?RlBYdlJQcGtoeWplUDFJaHpZdWVjaDVGNXNMdmRySElUTGlSMHZVSXZmUUdl?=
 =?utf-8?B?ZXhENi9oTDdJcFN1emR3TnhJVjhvYVR2SGhDYmJFYUttM3BsajJtS0NuSDFR?=
 =?utf-8?B?SzZ1c2lCcFBwOEt0cDZnVHN6NnFqSXpuTGs4NmVUTWlsRDJmNWlvTWJLaGtM?=
 =?utf-8?B?QmdzMXo0M0F5czBhOENEcGdjM3UvbVVzbWxUWUVxSGZQV0VEKzdyM3NpYmpS?=
 =?utf-8?B?eDduczVuWDh3MDRRaFllK0NuMkFzZmkvb3VORzdhRk5vbU9ubFhva3hDQTA1?=
 =?utf-8?B?K0xMNGdtVXZ3NWlzR0VuK3pkK1l3Yi9KL3h5TmJlSHhoMnZldjRud3JyREY4?=
 =?utf-8?B?bGJ3TjdsR2x1RjFpSXM1c1Q5QnlWWHpnd2FjWmNNVExOb3lsYWhkTXptVE1D?=
 =?utf-8?B?eTNoM0NwQ1ljVm1mbUZWcmpTRE1ENFppOFNkL2duTE1QaDBPMFJ2dUkwWGo1?=
 =?utf-8?B?WkZGTER4alNObWwydEx6empqd2hsSjNsczR2cGkxNnR6RytId2krcHVRc21U?=
 =?utf-8?B?OHhKdjVKQXIydDgrMXhhQnhOck1ZU2YxS0VtVndCNlpsR291K0xsRWttUklz?=
 =?utf-8?B?YXJDV2x5MjByM1QxS3Q3RHVXbnBYU1VTYnhjcG15MTBFQ1ZycW9CVS9SY2gx?=
 =?utf-8?B?a1VjZE9yOXBrQkx3di8rd0RLSFMyeStlZk1kQjdCSTRoVERITVZHUzNmbVdt?=
 =?utf-8?B?NUIvY0tMNkJITWVJekhxUzZVYVdZVjhCbEFkNStVZDJmUTk0VVk4WWtZU0g1?=
 =?utf-8?B?L0tlNi84eS9kQWlRSUJ4dmY5Q1J5dzdBSmtjTkljYXlMRUlGZi9DaTlmN3dp?=
 =?utf-8?B?akJTZklrOGtSM2pUNFVONUtxREU2SnFwYjVCTzhsaVBtbllyVzgzNWxhaVo5?=
 =?utf-8?B?QnRybHcvRHk1emZlYzNHNWcwNExqQzFYRFVqNERqczlKM2YrVGY5eWlOcWFw?=
 =?utf-8?B?UmZPb0Ewc2hBL2xkcEo2a25nRmQ2aUxxcVN1ZlZxM1dkalZmbnp4S09QMUlu?=
 =?utf-8?B?akZRaVllMWIzQlVLZjZEbmxScFp2dWxWNFQyQ21UOVp1NWYreGhaKzdXZ2xw?=
 =?utf-8?B?NXRxVEtRb21nSEtmTWtieWlzay9uUVh0UTBrRVIvQnBETUxWQWRoTllIN3I3?=
 =?utf-8?B?Rnk1aldXTkpDYjh1c1RZdkoxdTZMZnRWeEZNenR4NkZjT2pkK0s1YXhuMWRY?=
 =?utf-8?B?a1ZDbFdhY2QwT2pRQzhTV3FhTHdxY0wxZjNTSVJTTHlTSFoyVjZDVjBmYXgx?=
 =?utf-8?B?ZmxwamJrYWhyNFBWRk9ZUzNqMEN3ejNmamFUeFRJVDJacGpUNjJKOWR5RkJB?=
 =?utf-8?B?bkZHODFUMXZpY3hzV0pRNjJOeUtaN0pRaHVHWkMyMk4xRXo0K2swbFFQNkxp?=
 =?utf-8?B?dlpZT2V4V1Z0RmJCWUFzcVcvQ1AyVVRPWThVOWZ4N20vUnRkYm1MYUJRYUpQ?=
 =?utf-8?B?SDUrMTR4WUswenZXNzVGNVpkZ2lDeXR2RnJ1bDQ0dVVrTWV4bWN6WU9IQmIr?=
 =?utf-8?B?NXlSbEZLQWtMZW80U0ZUZnZzZEpXRnMyZGNoYm51bXFXZkJpM1cyQ3hSdnhS?=
 =?utf-8?B?ZmhEUEZoazg3L3FiQ2ZLQzg4VXlpWG1yRi94Rm9ZeUxTY0pQVmNxOFhMU3Z3?=
 =?utf-8?B?RXFUN2FpV1ZxaTJycS9XVGg4a1puaFE4WGs5cjRQWHVnaHNQTWw2QU1mTTcr?=
 =?utf-8?B?NjFIVVQ4S2tCbkttenVRQS9GaWhWczIwQlRMQStMMnl6OWpnTGtYNmU2RTNI?=
 =?utf-8?B?dzlScEpPN1NSc3ZmWGpRQmtuV1lES3FsNkc0MVN4ZE5tVlloRWhrUWE4cWdm?=
 =?utf-8?B?WldPZk5SVUpBUUVkTlg5Y0FuVUFYbHRmNk9WOTdqd0FlSTgzOW90VWlaRG96?=
 =?utf-8?B?UkEvYmdyZGMvNUxSVG1mb0VYdDB6Zk16dEo2NnhNd0hQL2F2MzlzZ3FRRDNF?=
 =?utf-8?B?ZktHM0JNMGFTekJMV091TUcrU0JCVUFUUDB1Mmdad0QxVGJwN3h6WVl1UDY2?=
 =?utf-8?B?THNRaTRtQ3pLd3BTYmkvWDlURG5TUFNmLzdYYU1Zczlia0xOaDZrRFBLZjRp?=
 =?utf-8?B?Mnc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc6d1fba-405e-486e-83a7-08ddb9f5168c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 05:47:25.4891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fQjqYG3tJWG9oCXcW9UdgzJGNXGN6ILqKFrmVW+ubNraF4GJMrLUoApW699W/taG/+GAPlJy5dBlnjmgAk4f7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3661
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 03 Jul 2025 05:47:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19321

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2025&month=7&day=3&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     14:00     15:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2025/06/cip.2025-06-26-13.01.log.html

* Action items
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB

I'm sitting in longer meeting in parallel today. If all goes wrong (not 
very likely, though), I may not be able to start this meeting in time. 
If so, someone should take over, please.

Jan

[*]
Date the data is created: Thu Jul  3 05:44:11 AM UTC 2025
linux-4.4.y-cip: interval 30 day
  latest version release date: Wed Jun 18 08:46:56 AM UTC 2025
  limit date: Fri Jul 18 08:46:56 AM UTC 2025
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Tue Apr 29 11:30:23 AM UTC 2025
  limit date: Sat Jun 28 11:30:23 AM UTC 2025
  Status: *Late*
linux-4.19.y-cip: interval 30 day
  latest version release date: Wed Jun 11 08:39:43 AM UTC 2025
  limit date: Fri Jul 11 08:39:43 AM UTC 2025
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Wed May 21 07:22:16 PM UTC 2025
  limit date: Sun Jul 20 07:22:16 PM UTC 2025
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version release date: Mon Jun 16 10:52:06 PM UTC 2025
  limit date: Wed Jul 16 10:52:06 PM UTC 2025
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Thu May 15 12:41:24 PM UTC 2025
  limit date: Mon Jul 14 12:41:24 PM UTC 2025
  Status: On track
linux-6.1.y-cip: interval 30 day
  latest version release date: Wed Jun 11 02:12:44 AM UTC 2025
  limit date: Fri Jul 11 02:12:44 AM UTC 2025
  Status: On track
linux-6.1.y-cip-rt: interval 60 day
  latest version release date: Mon May  5 07:36:59 AM UTC 2025
  limit date: Fri Jul  4 07:36:59 AM UTC 2025
  Status: On track
linux-6.12.y-cip: interval 15 day
  latest version release date: Wed Jun 25 04:54:15 AM UTC 2025
  limit date: Thu Jul 10 04:54:15 AM UTC 2025
  Status: On track


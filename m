Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D54FCD98ED
	for <webhook@archiver.kernel.org>; Thu, 18 Jun 2026 05:05:01 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.68])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12723.1781759092504228794
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Jun 2026 22:04:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=UzexoR/W;
 spf=pass (domain: siemens.com, ip: 52.101.72.68, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yWSQSuODeiZeHLJw2tASzbC8waKCKC+sW4ypKyGjFL9Zgcb4ybx2TD44hwVRaJkVRKTMPlehTDjz6kWhIBQHPF9EGEXW3pl7CMbTsMP7ZbXDGvPNIfc24S83/0q0PLle9hGLanrEKTe5D9Gfjj6t+x5oiNO+hd964P1KhCS6r82YRK9qYvsenE4gwgx8dtM4iZqSpi0Bk+jmJ5+ewKJxhQQQ3THInd82/VUCtPdxX01LkHyXuwkeIP6Ad1r6+E6KJ5rZH0e69GmYHuCncAHdbx0Z/1pffMR2i4Hc4Mv6ZRGUbT82TSshWlopTvB7xAJGDBmEoUPr3AxFk0u5eRs5Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qg+u0XoawpSZQeENRnup4y+G0kfhVAQ5q4O2AZOKlTg=;
 b=TJlYNmCeVor6WAwMdnuNyEadL7KkToo0DvuT9lY2GXSnYRipyn0MHV2ViEosnQfCPYYPiWc+cggpKwtn1URHF2Xr1xE89sIanPseP1pdoK8jAru/Wy0PXe1aruJiR5y3p5OoD7pg9QiUyx0jaxSygf7fkO69AjmaUvR2EpJsiuhXG93I182eTaay6P8ZVijC8NGbQFBpQSLHY01lcS7/lTRxY4SV02le9quVOBvh/y0jM54FmwyxZQUtbYYmAhvUTzDeisHP27LO3yFQILyamG+q0RKCN+erDh7Xmstqto9L60t1b2Ytzse4eYcKY9Rp9v3Kwypcyjq1du/pQCFgbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qg+u0XoawpSZQeENRnup4y+G0kfhVAQ5q4O2AZOKlTg=;
 b=UzexoR/WazhmS8TcHX1E4FuhyisGVhxEHRQuZxo4jRb5T7OrSyUK48h4++zWXReVRxE4b1AzxJtown4Jprfn74cdjgNvE6TgTrztQCtjQAqJM0ehWkBi/mF55Zi38c8sZOTW49XCIyrCYoLovX1kI6X+n9XM2qnxxArHdtDImNOt+qcTH9qN9KUdYS0mb9pKlZD2t7HUXs5OD2xDL6bMdxdGaY5Ohcd0/MIIitbLXtEFoxyT5YvVlyJ1CSF6rwtgdXPqvteUp90jkGRbQb5EKPecyvUGMjHcXX+fuyjMlJqvXJk/nQoLv3BCpJLd3qo8AtAGu7CK583K2fiMrpgvPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU4PR10MB8921.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:55a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.13; Thu, 18 Jun
 2026 05:04:48 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0139.009; Thu, 18 Jun 2026
 05:04:48 +0000
Message-ID: <ec961ebc-6887-42a4-a3af-c79ab2735ae0@siemens.com>
Date: Thu, 18 Jun 2026 07:04:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v2 0/2] Enable Debian sid support
To: Shivanand.Kunijadar@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: Adithya.Balakumar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
 kazuhiro.hayashi.f74@mail.toshiba
References: <20260616050628.3560536-1-Shivanand.Kunijadar@toshiba-tsip.com>
 <34c18027-b049-41a7-b43b-fb200bde4abc@siemens.com>
 <TY3PR01MB110757AA7CAC37C32CF6E444CC7E52@TY3PR01MB11075.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <TY3PR01MB110757AA7CAC37C32CF6E444CC7E52@TY3PR01MB11075.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0038.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU4PR10MB8921:EE_
X-MS-Office365-Filtering-Correlation-Id: b45bff02-1491-4dcd-c800-08deccf71f2a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|55112099003|22082099003|18002099003|11063799006|56012099006|6133799003|4143699003;
X-Microsoft-Antispam-Message-Info: 
	rzXczsNEDqvpiwEuJXroi3U6jVmmeY0ubL6/JyAf68xEMzdITxOnZS+JvaXDQc5Gu9B4eJSfbZEs2mA5msygVVrYtkJxP9edaPw277Se8mdVbXK+y2KgfglH9jTr8pB/Qs7kmLubE3dVuDPUvCXlWCszWixCCFoNFWLh1X7VerOquYUowJaxfPWX5nw6yjOwb6+Mjk1aqiEhdbLW9qP73i0G6+BM0l1+SQsogK0aM8yxaMPkvhBEGjPrGbxUcfROw3PjuyW//Tg7+hXLKCnS5bXvh975/1/VfVYqlQS5ARPpGGeGDs4Xf3HlF6AxTJXpbDdoHa1dUvimS0K8dsea1dLcs6T48xE5maOZuBqcE5yw6YHLNHFXAd8Xj5R+FGI7VDv6rFydB0C0Q39tbAF5cdkK7118GAyExefMuedxbrTDaFayVmqld+AcGJ4iOvtIztQUFMqqeWzM6IqqsjLDSZY82iymSIzheGAVlQSfYb+NWktmkQ81Oj7VSRcKb5WLxeXjoHBhYlEvWdCCIfc0cNo7QNpNFtujG+qqEcxlMlCYTR0QrMxoGvaunk1CITZ2hC1pB9uY6mOrFTliYiKgS5h1fSe2ZMeT9r2NcaXodWqwN8ZFYaMJC6+qiwDViiw9QspUX1QBrSwne0AR9mj7S9UXCuTb2clfUCWhZQar6i4uynu1yryU/fp1Z0jedoan
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(55112099003)(22082099003)(18002099003)(11063799006)(56012099006)(6133799003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cENIeGRWWVh1Z1dWTFRtWllXMmhqZjFUZktobTNEZjZ6dG5CcHJnQ3JqeDR1?=
 =?utf-8?B?Z3RWWWdwbnRkQVRULzFTSHBITDQ5SkdRQ1ZYSzJNS2c4b1BUTmM3TGdDNk5n?=
 =?utf-8?B?QnlVYk91MlRrdkU2Z0k1cUt3U0lMeDg4NENwSzd5TWozUnhhMVNkdDRjQk00?=
 =?utf-8?B?WU9VUUZzMVV6K1ZLNVcwYzBTZERWNWI0V3pYUE8rN2ZVeStjcVpLKytlYVMz?=
 =?utf-8?B?aStRYkl0RUlkWUNLSXBneDhHd0lIRUc1RkVldXdaQkFhczBpanhGUitJQXFT?=
 =?utf-8?B?K21QQlEyZkgzTDFsTnM1VEtQMVNCRmdvbFMyQXR6TXRJQWFXT2lVSVd2clV1?=
 =?utf-8?B?WS9Cd3dWSEhWb2VxUG5CYXlNcTdmK3BtQyszV1BSYjJBZkxwQkwwZGhYSXJU?=
 =?utf-8?B?cndIdWpZbjNKRU82QkcrSS9mcVRKUnU5OGV1d1Z5RWM3cjQvWVNVZnVlMS9U?=
 =?utf-8?B?UHQrVzJrQnBmYWNML3B3S001b1JBODNTeWhPdW1NcDJ2MWsyM01BQjJFSzQ0?=
 =?utf-8?B?cmNzNHJVRWdTcEhMdnRwL2w1dCtvaUtpUTRaUFBjVmwyV2lrbG1MV3dnZVRZ?=
 =?utf-8?B?REF2MSttb0wwNFZNR284V3ZrRmRrdjdvSUExQ2w0b0JHNUFYMzFFRHRxVWdW?=
 =?utf-8?B?aFBmcGtuajl1U0VSaTQ4WkZkbGNEcjNib2ZQWEZmTFRJZ3VuMkJ2MTc1S3pu?=
 =?utf-8?B?WXNPQWRWbW4vNzNBakVtWWRna1M5MVd0eDR4bFBqQTc2dW5TbVVtbWNlUWh3?=
 =?utf-8?B?RHJ0dUJ0NHpvNndzcjZtajVFOUpqYm5JeGdUOWZoeG80R0VHb0pnSFF4WjIr?=
 =?utf-8?B?VENvdnd4ZGtWa0hFUk1RZDFXSnRhaWp0VHlURXFvQ3IxUEpmdDh6elpCRVVa?=
 =?utf-8?B?M0FpeHdNMEwvTHVBYUc3NmcrS0t0S2d5endUb3pBWnNiUGdseTRjYWN3OHZQ?=
 =?utf-8?B?SG40aDUwTjA3RmJOT0p1ZVJQZmVHQ1FWS0RlRTlqVGN2SUZSM3k2Z2hEZEUw?=
 =?utf-8?B?S3dxS0E4VFZJd3NMRlVSRXp6aGRYUkNBOGgzQVl4Vyt1Sy8vZ3pyV01mcjZV?=
 =?utf-8?B?R1I5SHRwbk4rRWsrUnhmQ0UzNW1id2dyKzNqWkpsQmlVclh6djNuVHcxQ3da?=
 =?utf-8?B?RVZ3eHNpTFZka0UrT0hhNUtRQ1BsVUJXTjB6MnJ2QnRqMHhYUUpXbGFpeVl4?=
 =?utf-8?B?c1hUMkRCVUMwUjVFV2dEUnpQblUrU28vRWZDdkJXYmZVam5EdVFtZy83Vm4y?=
 =?utf-8?B?TkFEUWNPaDNPMDVPSTZpRitEbnlabkxVM2haWUhBR1dMeVVKWWVGaGFNTks4?=
 =?utf-8?B?YWdYRWQ5QlJiUEwvaVhpeVdqTlp2b2NJSU1hZUxzSVJtbFBTanlyUHNocjRy?=
 =?utf-8?B?QVFHcVdJSnN5TFpkeC9ZK0F5Vi81QzVVc21ERHVoVlB5NUlzdkVkQlpIbFAz?=
 =?utf-8?B?a243OVRVUzRvaEsrTkc0UDFxekNNekJhSUJnMlg2a29XR0dJc2JKbjk1YU9q?=
 =?utf-8?B?K0toVjR3Sit2UEFHZXNLaVN3T0lRS1VLRlFlUmhjYkttdFd3UHU2b0RiN09o?=
 =?utf-8?B?dm9EU0tUYVVuZitzS0ZJa28vNTBKM2xidGlNVDlKVm9BTW5NWEJVK0RXSDdG?=
 =?utf-8?B?bWVCR2FEdms0WHhvMHl0N01zZEJybDRlc09nd29FUjhjU01RS3l6Q3hIM09z?=
 =?utf-8?B?U2JiRmFGZlRFRVF5Y3RaT2xuRlo2VXl5RHFpc29hbXoxUUQ5TjN6RG9MQ3Vy?=
 =?utf-8?B?ZldGZTlFSkV5VmVEY1JRUlJlOUxsS0tvc3BzTlNmWDVuYUxrL21RWnk1SDgx?=
 =?utf-8?B?c3VqYTFWRmRhenhXbHBUb2w2ZXZoblVyNUorN1EyQys3QUdSM2psS2FPajBG?=
 =?utf-8?B?OHhGOTQweUJSYnlqcGU5WFU2ait6bEdiVGNydlU2RVlPTjlCUXU1RXc5aFVJ?=
 =?utf-8?B?M1NPa1ByK1BsTE9TNmNsb2duYjAyeFBvS1ZGckoxVmV6a0Rta1F0N1hMa1RN?=
 =?utf-8?B?ZzZTdUM2bjBLV3E0RmlzOW9uTnBDbm44M2QydEVCZjdYUnBNYXRkUzFkR0pq?=
 =?utf-8?B?VGsyQVhnT2NEcXR4dEM1T1hoVkNsRHovZ3ZpR3lwOFp3bDVFZE9aQkNOY1J2?=
 =?utf-8?B?TGVEQ1Z4NVc5WC9qVVh2bEtOZEFLL2lHTVQ5bGQydUhhaXFEejB2dDA5VW5Q?=
 =?utf-8?B?VTJVY2tpMDY4T1F1Z3dYaXNZNDd4VkV4cUpjZHBDVEcxTTZrWEdiM0x4VTU1?=
 =?utf-8?B?UVI4QWJjYnovY0hjcCsyM09TcUdsQk5tSVBQc2JDaDA0M3Y4TDlqazQ0UjhK?=
 =?utf-8?B?Mkl0ek9iOERiMFVNQnMwZlhPZmhtN3dFSUJBYmVicDRDN1orem95QT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b45bff02-1491-4dcd-c800-08deccf71f2a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 05:04:48.6522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0P/Zo+qIXaiirN7FuxVy5I11VWj9I3Cs5837i+LRABNW1Tuij/4koCKG2ah2NmLhANYolWTyIp9YqAg+93lKKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8921
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Jun 2026 05:05:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23219

On 16.06.26 11:40, Shivanand.Kunijadar@toshiba-tsip.com wrote:
> Hi Jan, 
> 
>> Should we also provide a forky target?
> 
> Yes, we can enable the support for forky as well, would like to send a separate patch series for it later. 
> 

Would be possible to do that this week still? I'd like to close for the
1.12 release soon.

>> And another question would be if we want to have a CI pipeline job as well, though one that is allowed to fail. 
> 
> I believe enabling the base image build in CI for Sid is sufficient at the moment. what do you think?
> 

The whole point is stressing that configuration somehow to get early
feedback whether we (or Debian) has issues with the upcoming changes. CI
alone will not give that by itself because it will still need someone to
look at the results (if they are red). But having only build options and
no one trying them out and also running our tests, will not make it better.

How about performing such CI runs on a weekly basis instead, not as part
of regular builds?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center


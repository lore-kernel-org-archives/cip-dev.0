Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB272C369A4
	for <webhook@archiver.kernel.org>; Thu, 10 Apr 2025 07:18:48 +0000 (UTC)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (EUR03-VI1-obe.outbound.protection.outlook.com [40.107.103.87])
 by mx.groups.io with SMTP id smtpd.web11.28854.1744269523515916964
 for <cip-dev@lists.cip-project.org>;
 Thu, 10 Apr 2025 00:18:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=hKmMqrUH;
 spf=pass (domain: siemens.com, ip: 40.107.103.87, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n0BA9Wx/QqXKmaMP04bJCeNOL37C0YisaEV/mtxCzMbHnBaxRiknnfcib7YsAzMMf6KV0yba/DRSX1CU5nIY3CaRZnKwvcQp5XYwoErPk/9quBkcqD4n36h7jAkJ5lNx71IJYUuTcbxV8Ii2c2ZZu6yQYnzJ5yRT3QHjMbRZ+3EzyVDWvi68m9FB4+i5w8X0Ffv8kaZCvZo/WnSY8/qx/kFUs8FgnYHvnjTEy2H6DzKu7vFWO38jxDGYsSHEk1ysOrJroEolMXbIzToWK5QyVjKq2g+S+AUGv8+3SfYx8DQmY+zAhyqrVWb7+qF6A6UIC91DllQqZP4I8GgP3iGCsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yVEGkMszxsmMr2OHlSBce5P1hhtN5btVmiIOA5Ap8A4=;
 b=VQtcYzABLYDRlfDvrArXw0PY38Bz8dV+zbLoofDfgK/P+cVbc7l2Ue2BRBMRZgUJWh+X4o1569pGMP+aDCuQ3S1TCSeKSygKMybtxn1JurSjB3bFi+a2oYcnR7JOsn46IzghhjzeDnUEMSauE9q9T4uo8pVk0dpeWwmJD+CcGkjyCyAefYqE8kDqc0LR8XQ9W1PDu2GZKL9amw6SEFuHkbYff+ge1SmEeuZyytyWjcXkxatUPDvT2mxqXWqcP3VtJtVXGAYX+OmgWHvJrDCQdXMTnfsYku8uZjLpaRrYbmHE3Q/zJwmUkHW0a2mz6jcfBwF/lorXwsXwcPrTsqpAmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yVEGkMszxsmMr2OHlSBce5P1hhtN5btVmiIOA5Ap8A4=;
 b=hKmMqrUH70Wolg9SwPEhAFCnof3ROiIGGJIFEEM+CcXx4DjflWD0+xr/BNB5jn41yfGqCxDAZeS3yfuVN7HM0Zax7SxsftUZdC57tUjppkuXNQoOulwk26szEd41Ov5OSVLZ08GL2560KKpaqVMJTkvKGSnA3VEf69nlD0VEw0gtTN+prEPsjqesdxY/ivUCadEtzfJdLstPkxN0CMKJQuKdAt3ZxLD6k5NuAGskTRC6kenmdm10gXzw+7adYXDbAKYQ+3LQvNYrKDqc0BN/aBvK+yO9DLxefumKwhfsgc0NweMVnHkZRM9UvOXrq4pyw+24UvukjrfUiv1dka0gbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB5988.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:5f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.38; Thu, 10 Apr
 2025 07:18:39 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8606.029; Thu, 10 Apr 2025
 07:18:39 +0000
Message-ID: <86a473af-2a06-4018-9ef0-ba22bbed5ec9@siemens.com>
Date: Thu, 10 Apr 2025 09:18:37 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0067.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB5988:EE_
X-MS-Office365-Filtering-Correlation-Id: b0e77f47-0eaa-4493-4a6f-08dd77ffea4b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?TUdEZjhVSXNlV0VFVlFub01GUHVpS3VrZzBFR2N2WEZaU1ZRcVIrY1ZobkRT?=
 =?utf-8?B?a2JYVk9MbHBsK1dZbk14Z0xua09oUFhOem9Yell3ZXJ6Wjh4UnJUY0x3azlq?=
 =?utf-8?B?b29MbFRBdmpKeVI0aWZSU3hwSC9FY054ZHEvbnhWa3BBVm1iMVNZazdTOEJ6?=
 =?utf-8?B?cHYyMkNNakhqSmJSZU5IazZ0RVFkS3J1dEYvZ2ptM0wvT1hxL1RHS2NCa25y?=
 =?utf-8?B?bkNjeVlIcTNuMVZ5dWt3SWdKQU8rZHo0VjFockd2UVBJRzhQdXBTa0UyL0RG?=
 =?utf-8?B?WGlOdFhzM3NyY3BwdW0xcWtpeXhmd0N4TFhQYWNVdGRnYUV0RkRXNDUyK3hT?=
 =?utf-8?B?Wkk2UTRPbnliZEZCMUgrSkNVTTh5SVF4dmJwamxxYUtsUXozVWtGU291cy9w?=
 =?utf-8?B?WUUyZUFpMHhSM25BaUV2dXdTQlZMVXJ2Z25ESGZIVlBRZGo0K2NORmw5YzlQ?=
 =?utf-8?B?bDVMbzBKYXFSVTk1TklvNEdBU2tYcDhlL3BRSUxWajJHMEN1MlZWUGlWQ2dF?=
 =?utf-8?B?NnNEUUFORzlJRGxjM3VmRDFwQjBTRHpVampJK3hrUkVCREZYS0pTQXAvOU12?=
 =?utf-8?B?dERMRjBFN3ZJZXMrVjdLRTdxS2xJRGVoQURDYktVNFUxSU5EL0ljTTM3c1ph?=
 =?utf-8?B?RWo5bWR2SlRoTXJUNnBBd2FtUld5L2tIQkdEMWlNM1BkVTRvTWtwOTdXbVRS?=
 =?utf-8?B?bmZQMzBhNVZZWWhsNnBndnpSZ2N1ekdGdFhJTlE2bzEzeEtqdm5sK3ZFejJW?=
 =?utf-8?B?cWxaYmlCdHRpeGdIc1ZQeVF3cW9oVUdKMFVpNHFiaXNJRmR2M2t6elViQXY4?=
 =?utf-8?B?d25IN0w5V2owVWxmcDlwR1BTSDJvM1dteDhSVThNQ3RXY2JEREVyOTFYMUZv?=
 =?utf-8?B?YVZhUTJQeGx4bjY3ZDVwd3JzdVdWT0hBSWdlRFZEN0tlUUZzYUFTelBheXR6?=
 =?utf-8?B?VXZFV21vL3RhSW12Qk9VWDEvZmFINC8vQU9PUFhqb201bjdoMkV1ZFI1REds?=
 =?utf-8?B?Lzh3N0Zoc1BVRm9QTU8xWER2QU1oQ0U4K3RxZUtuVWpMRDB5OGtkVG5PZldN?=
 =?utf-8?B?VmR3MmVjek5tNXEyRnNUK244Q0h3ZUpxRTIzUjQyZGgvRkZMT1ZacFpsWUF4?=
 =?utf-8?B?SUtnYkR5OGI4RzU1R3MzRmI3WERUNGVnaHhUZ2trNCtjQ0tOd0NrUm5JSit6?=
 =?utf-8?B?SU5qckVzbXhhU096QVE0VEpCQS9QOE4wcEZrd1RoZVVPV0pHQmdmeVNWZFMz?=
 =?utf-8?B?a2UxSHFVZUl2V2JzMzIrZm1KTDNZdzJQTUFxdGpaWlZhVW5mT3Zxd0VZaEUv?=
 =?utf-8?B?WDFaTExHVHVTWVljVjM1K1VNWGNyOG9GdnhDU1hBVWlzalE4NU5pWGRZWGhL?=
 =?utf-8?B?RXp0aFZOekhlK0V6YUNCdUp5enBQQWxYbHBGRnVVZWVrOG1ISDhnSUF5bHgz?=
 =?utf-8?B?MFYyZFJKUGtVMkppL1VFbk9pZ0h5cHpOR1JNdkV2Rm1QU2lYZVJ1c3gzNHpI?=
 =?utf-8?B?bVJzWTZ1OFpNSzN0aEdJdmhLRVh4NHBmeUdJWmJETlZuU2l3YUlxQ3VQZ21t?=
 =?utf-8?B?b1lSN2hvNkVYd0IyU1QyYi9YVjI5a0JoZm5DMm5pR2k1T3RGR0JDWTh5ekZF?=
 =?utf-8?B?aVErYklOa0syWjZwVElHZ3VETmROcUprUkFDSE1UaERQeVo0Z2d0OWJ2OXIv?=
 =?utf-8?B?UkhiR3RsVG1kYXhWOXB6MFVwSWUvd3A1djYyTUwrOURHeE5QUittZzAzUW5n?=
 =?utf-8?B?eklBemVQZWQxMkg2THJaaENFdzZET2ZEbzhQT2cvVm53alNjK0tjQTBBR1Bk?=
 =?utf-8?B?WkdiVXFvQTBXWXlhVGlFQT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cjdPcG14WG1yckdTUWorR0tES3ZvZjJxcEFUbWF2bFYwbjNpUnk4aUR4K1VS?=
 =?utf-8?B?NnRXNzdFWDUvaEZBdW9BaWRvWFlTMzNxZnZ3VHpOS3JOMEZJUnJXeUJiZFYr?=
 =?utf-8?B?TmVUaER3aHFRYlg2MHVhNkZrUkUzYVAxOG44VmVaZGVVY1dBUkVOOHNGSzFB?=
 =?utf-8?B?TjBFQVFLeWhlcGNiRHBjbjY0d1VDTG4yeU5BNVU0V0RFN1g3UXZ2Nm85YUZP?=
 =?utf-8?B?WXJJb0F4N1VKNVZubTV2SHFVZjhyMVYrNFFOOVBlSDhmZFRpaEF3d2o5cVFn?=
 =?utf-8?B?eXN4VVhKK1ZGQm1OZ2VLUFJiQ3hiMmRMdHdMLzN6NURZN3hFN0cxZC9DOEl5?=
 =?utf-8?B?NkFVMEUxeHZkdHR4elBJYW5iSmwyMyt6aytRVVFvemVJTzFBbk9ON2NQWUdS?=
 =?utf-8?B?clUxMTlSYzdvS2wvS1BHdWpTVWl0VkViRGZzdklJUUxXakVBZHNnbVZwam9I?=
 =?utf-8?B?VldTSlpiYVU2MkRvVEtTY1FTYUtBRVpFaGNJZURTVGxvY1U2WjhWMW1LUlR2?=
 =?utf-8?B?Z0FyTTdnb2NEdTJFSnBENEhqT0h1R1BpNGlrRkFyRWdOU1ZPRDRKdmYva1BZ?=
 =?utf-8?B?Wlk0U09WSkorelFWVkttTy9seEVUcHlhQmtibFErNVJwVWkvWkR0TmYrN2Fy?=
 =?utf-8?B?SXZ0Qk8raUJzZ1lLd3FqZ2ttUENyQVRUM1piNFR6ci9lRlplSG9BVXlkS1hG?=
 =?utf-8?B?QzF1d2RBb21GU2VkZGl2bjhIaXBiZFFEa1FUcTN6UVRkNnZpZUNzNmJNSUlH?=
 =?utf-8?B?ZkRrdUw4WFdibmpxRHB1d1lLc0xBSmFmWFV5RUFabkhFMmIrQUVxQWdJQmhF?=
 =?utf-8?B?cDJrcFRBTjduT2RYa2ZxZkQzOXhtNEl6Z29WNlUyTjFzVDBvQ2xFVy9qVUx4?=
 =?utf-8?B?eTZ3VnVnanVyNWpjd1ZDaUZUTVFhNHoyNE5ZbSswaXpLcVFpSCtuaVlRYzNB?=
 =?utf-8?B?MWJFREtjTHR2NDFNNHcrMkRxZXh0QXFwRS9SUVFLUksvdzR4T2xsVnJjK1Yy?=
 =?utf-8?B?UnNydlZYbkt2YTNuQnZrQWY4L25BZUREeWlXRzZWRml5YStGUEdlVGoxdk9o?=
 =?utf-8?B?VHhOelUyeHFWVHdGRE5ON2xTL1g0SzJORUw5OG5oZHFySTF6NUxBSVFYcU9a?=
 =?utf-8?B?V2tkOElXNG9IbjJVMHBpSmZFSWRheEVidHZ6eVRQcUNPdDk2OExTaW1HUXEy?=
 =?utf-8?B?dlBTR3VNMmx1N1VtVUs4OEkvYnRTY1lZOERFVDd3VG9FV202eDI5QzZSeXdS?=
 =?utf-8?B?TEJhQ3JvOW1zWDFjRHZqUGU4UlU4aTFUQUc4M29DeEI0c1ZXc2c1NTlBdFZr?=
 =?utf-8?B?SWIrcnVpZ3B3bmZWWHN3RU9LaHQzYy9PL29FWGQwZVRzMGY1UWJ2RlIrLytz?=
 =?utf-8?B?UWNWTDl6Mmt4cUJUQWxnVTU4ejh3SXg2K09tVXF2RWJrdngvRW5VRHZCZ0VE?=
 =?utf-8?B?QVBCTTdweUJNQ2ppMHgySEkwRldlUWFQSWhkRWx0cDY3UEdrQU9VWUFBQStT?=
 =?utf-8?B?bHhneXdHdkxHdjU4NFlkTVBYTFZJVDFpL2JqTHhFTG16YU43cUlCZWRUZUxE?=
 =?utf-8?B?bGlpZzNZazE2bFJmUlQza0ZpZmJHTERISkJtZGw3VVV4NzhHQWtBSW42MG1h?=
 =?utf-8?B?M2Y2OXJzZEJsTUtPdnEvT21Ib2h3c0Y2UkdGSEhNV3NIWVlRWklzVm85ZlpK?=
 =?utf-8?B?NXlFZU9DbkUzQlZCWmdsMmxUSE9DTWRFMWRRcGNacHYrdXVWNm85YTRVUWVq?=
 =?utf-8?B?ZjNqWlpvQThCT2RMaG5UMkczZ1Z3NUh4TkJURG1yQlNrSHFiY1diVW1udHBv?=
 =?utf-8?B?ajBGOGt1RnRGQkZNYVNWb3BHeExhd3BtUmlPVENOYjNscmhDZWhsQjVKNWZo?=
 =?utf-8?B?VisxZjJYNnV3ajhKQU5leFdWamtKK1p1VURNUlpqeFlPSGl4K0FmclBLSlBq?=
 =?utf-8?B?QnpuTGpyMUxCM3Y3d0NoYW5qOFlESXVwcTRlVFRWOHlURXFaSVdQRWkweE1C?=
 =?utf-8?B?T1RoNzFnZjNiQitvVzJSaFRWeDdVUUp6WFNEY0NiL2kyNjRPNWNJTHVYZ3hu?=
 =?utf-8?B?amlxQUQ5cEx4UnZ1OWxNQm9CMmNtVzg4NUluN1FIMk5scEFxR2tEeTlpU3dj?=
 =?utf-8?Q?hXNnbmjO2b1eeede2OW/HxBfP?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0e77f47-0eaa-4493-4a6f-08dd77ffea4b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 07:18:38.9645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /RgYUuL8FCYdBRkgcmYZ+XIHZarr2AnDBAwY/blH3FU1CgdK4A7BrWiPL5XQ6jECG7c6sMNq0nIVxpzWgObrHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB5988
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 10 Apr 2025 07:18:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18501

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2025&month=4&day=10&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     14:00     15:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2025/04/cip.2025-04-03-13.01.log.html

* Action items
  - share release scripts/procedures [iwamatsu-san]
  - ask for adjusting reply-to setting on CIP MLs [jan]
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB
  - roadmap for first 6.12 release

Jan

[*]
linux-4.4.y-cip: interval 30 day
  latest version release date: Tue Mar 18 02:02:02 PM UTC 2025
  limit date: Thu Apr 17 02:02:02 PM UTC 2025
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Tue Feb 18 08:21:29 AM UTC 2025
  limit date: Sat Apr 19 08:21:29 AM UTC 2025
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version release date: Mon Apr  7 12:49:49 PM UTC 2025
  limit date: Wed May  7 12:49:49 PM UTC 2025
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Wed Mar 19 01:02:44 PM UTC 2025
  limit date: Sun May 18 01:02:44 PM UTC 2025
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version release date: Tue Mar 18 09:47:53 PM UTC 2025
  limit date: Thu Apr 17 09:47:53 PM UTC 2025
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Mon Mar 17 09:54:04 PM UTC 2025
  limit date: Fri May 16 09:54:04 PM UTC 2025
  Status: On track
linux-6.1.y-cip: interval 15 day
  latest version release date: Thu Apr  3 10:12:44 AM UTC 2025
  limit date: Fri Apr 18 10:12:44 AM UTC 2025
  Status: On track
linux-6.1.y-cip-rt: interval 30 day
  latest version release date: Thu Apr  3 11:32:00 AM UTC 2025
  limit date: Sat May  3 11:32:00 AM UTC 2025
  Status: On track


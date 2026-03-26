Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84DFB109E558
	for <webhook@archiver.kernel.org>; Thu, 26 Mar 2026 06:11:19 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.11])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.42060.1774505470292861701
 for <cip-dev@lists.cip-project.org>;
 Wed, 25 Mar 2026 23:11:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=BaLDuSe+;
 spf=pass (domain: siemens.com, ip: 52.101.72.11, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GGJJIZyjTcEFFv1XhwBtl0dJV4LyqD9GuIm+sOF04lW4yVBF+zzY14owDt9CY5jq01H58mjkTJEqHWhlVSPaIdhLBd/3tIWkzhd+/+nySC6Zt1x5Na54ilhlLPkWKLCPfMbuzJt9a8heaGfemNjspP6YPF2fzvAf3Cx1I0PGxTqtbjguXkUp4ONt/zPfsqzoc+IuqE5RTNwHaEcKU/OrUo1V7p+6A/42Qj9hGc1RH2jh3LEXX2rrjqn/CeKMqYGvEfuR01j9wdnohyobmSe7XF1UOtau4OhFtUksq6az6INGSZmqnLwGHLoawDm87VG2vMAqvd5llC3LuMMOWxMmkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BgTFcYEQHupoOPgL7ndn0FZxZLfxOXZMGpnzd5LDmF8=;
 b=vqBdPuCNjN3Pfs5/S1mGPcS3Uo3rlsuHhY82m2VY/3+bghASJEK/t026JU2FXGO+sUtJIDRTM9hyoxkLz+FCz5G+OxXL5WWc+8M1fzhgz7PdZswN07SznKSX0jmpm+H604k8GgaY96IKchbkxExwfejxkKiH4ro+Q3nep4tJ78iTzUVZvB71tmJQ3tEbEXFChSFsJJa9WKGsrVK1Sysp205VfSio4jEDyOrpFdlc9a1paJwKnemMPp681atlPRzyaXPafhXc0hZhhkEgVNjv9IPNYJ4Qi0j56ZjzT196NFwke2/393XhqFmEHhPFWtqbPB8hItulFnNfO0tjgXwG8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BgTFcYEQHupoOPgL7ndn0FZxZLfxOXZMGpnzd5LDmF8=;
 b=BaLDuSe+orH9J7QLw8FVOgKvWlHfjxkqxvMHOJUMyohK95FDxtkmazcTOxw0oCuugV82xOmUYLtvL7NVBglh05vIYu10uXPGFMfRBxnInZXsGQTyBZsKbXaYE6n49+zmP70hsOmOxlyaRokpGEUZUCxIXnF/e9sGCz6G9lkrCdvPj7OWPpMMRjLqADHmD46Wtt81b6cCKnDhXbJXlxlHc8yfO7lnPds2k98XOOdWd677GesNYyZ6f+BfHu4X+krGDZ25XmJH9Wt38TSWQxW3vDpnc6oZLVeiF4jrfaxraCGpNV0H8hvTpgAixRhg/WKiiJKWRC8F0PNfC1BUujeYqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB8518.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1cf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Thu, 26 Mar
 2026 06:11:06 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 06:11:06 +0000
Message-ID: <61c8373e-d1c4-4c12-b63f-321f61796da8@siemens.com>
Date: Thu, 26 Mar 2026 07:11:04 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CWLP123CA0196.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:19c::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB8518:EE_
X-MS-Office365-Filtering-Correlation-Id: deb55ba1-9430-429a-8064-08de8afe7754
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|55112099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 
	epx/gnjarq8+R49bpMrr8Op0Juy6t9znNCofFkB4Cgx2n4V6wnG1hnfTDS5n7FSsPZ1/MUXaYR0tibZpTHNSv8Mu0Ul2eGwKYZXmgDfXLDapttdRby86iurVXWCIvDbnvzle/MCvXEks7TIWsh7PGaUXm38C7W41YxwzINEHQjRwcC8Q9q/1etvsLxcHRxoTeRmQfCpXYm/usHX/KV2J3AUchl6bQRGP4GoVPMBx5Eiwi0TLsbUcoe6zkPzToxt/VFjIZTTOJDrO5egELIXVR7XhYlcGpu6hCX9BuUi7acRpoCUscAHy7cz9hrUseWhQCDPYNdcUSMzHPu5tZTz6cXFfkuS28M1lmaVac8a2yMRe0i13Z7uEF93F6qew10lqs68V27XrjT4kBrhZEUv479aPA1EQjTi2hpunJ+sdENL/so690ddzWTMtVx6uKCaKum5mJLku53UgyVMKE6vdQxlAfdH60FK7oph4KSv8JUt6kqiUnp7mzoFTIkyy1RA7VVu1Q4hkBpqZ4TNgdeT4q9WaLD0dIMjhtpWMgZF4oDDZTkyGqDTKWGkS18rxmpoTwslMmdPRQU6JcxVyAQYASqUnY7I7TAeJky+NfHMNNA/xFqYBlCZ7lm34TDgZ5HB2LUEsr3zJCDBkHPWYR+G6u6EDTJdlMAWea9zzXVjWbIWJgtoWo2oJsNH2V+aO4ec0
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(55112099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Y2R2ZVVUQ2JaZElNRUdrSXNHNVpaWFI3d1ZWT2tSL1RzUWpySDR5VnRwaHdy?=
 =?utf-8?B?Nmc5aHIwWkExK2d2U0FIcXNXRndVOVhqU1BpdVlrcXRKR0Q5anBpTG1vUzRQ?=
 =?utf-8?B?cHZpUnFhSGFZYkpmbmJSWjhpTHVTU3A1RkduTHA3SUZuYUdNWjd0QjV5ZTVu?=
 =?utf-8?B?dDIwTU1ZcGVRcEpGUTZrVWpPVDhUMTRyUXo4TG92ZFI0dDhDMFpKdHk1Smxm?=
 =?utf-8?B?SGMxRTl2NU1tY0R2SjFPOFNTaUI3Q2tyMVlnZWFsb1lwdlk2Yy85OHpDMXBh?=
 =?utf-8?B?VXprWkhnd290UWpZNXIxVmRCREF0cUxEMVNRdjMzTVJVbDhwMURoNGY4MTRJ?=
 =?utf-8?B?MkFCQzdrQnMzMFY5ek5Ka3pYZEUzYWwzRWllOU54aENrYnc2d29VSHptektS?=
 =?utf-8?B?UjVVVEtMNThCNFF6a3ZsUWRFaHcrYzVYa0Z6MTNtTnhVbVVQeUdBZlRhayt2?=
 =?utf-8?B?emJGUFBIU3hoeGh4U3JQVFRKVFBxVjEyb3V2Uy9TdlRiUDR1UnpkaUhxcDJM?=
 =?utf-8?B?Vk56SFBWWkMxdW4reHZQWUxtU25SOGhsemRYVHIzZVdTMGdGUUZuWE1OaFZP?=
 =?utf-8?B?ZEF4NW9qUDBuamNLZ2ZqNmpaS3d1TnJUc3NUMlQrVU1JVnZsZFpGYTJSM1pN?=
 =?utf-8?B?ZGtXOHl3ZVlHRVF4TUxnalAxY25xUytnNEoyTENkNzlRdU1ndGdZczNxeURI?=
 =?utf-8?B?ZTAzVS85SlVuN1VOWmpIb3ZSN2VwaXZQVmJMMXhseWlzKzU1K0JMTm1SK0Jr?=
 =?utf-8?B?Y2RWY0pHRVdLOW9nZnlXT29jT240OG5FbmQ4MXM2ZUZpN3MvU3pNRUZoQW1K?=
 =?utf-8?B?d2Z4cFgzK2N0ZHJvcDZyaVFSK1JuazhabmMvQ1BHRTJiS2NQMGg1Mm9DTGpl?=
 =?utf-8?B?SEpScDJSR0NZOS9IaEhoTUplT0JncHdPbnMyNDBqRmlJQWd2VlpHK2V5eFJy?=
 =?utf-8?B?ZHA4MGtWRzJTUCs0ZnA3WTQxbWRXbGp3TEtSVWRzeEtLZ3FtMWl3c0NoTzND?=
 =?utf-8?B?VlJyTDJlUHUvQkd0MUZBU3RkVlMyTjlIVWprbUVwSnF3alFpeGc0Q1B0aXYy?=
 =?utf-8?B?M1pEclpUQm1UVkQ1RGsxSktzdjFJcjd5M2hqMXh5djVrZnREWDdZT1V2VUFV?=
 =?utf-8?B?aXY5MmN4cnJWM1lsdWpHZVdwU2p4S0owWHA3TTYxd01KN1lDUHhlRzRtbXk0?=
 =?utf-8?B?bzIrZXl4RTdlOTRPNERWTFl5V2ZqVUx4L2x3YXdVOExpekdpekovenM5bXZv?=
 =?utf-8?B?bWE2WUQ3aktKM2N4cVFFR3F0RE44aDVSODZFMXdyNzlBUk1reE50UHhRMWRm?=
 =?utf-8?B?NnJVOGErcTZwNVV4UTVTUjltVkxsL0pDTjdCb2V0YnZIOVdMYlVubWNQTnor?=
 =?utf-8?B?U2taT0FoQi9BeVBkNGYzdG8xdDdWeUJCVktHWG55N1dCaEhnaFJ6YjNGY1FQ?=
 =?utf-8?B?TXA2TEtYeS80dThvZFBiNFhnWk9BSkR1Vm00YWNiM1VFb29OUzBpeW8xL0d2?=
 =?utf-8?B?VDdUa1hMV0hGRm9KRFBjNzFacC91MUIrMnhtSTlVRFlGNFFxWEdUV25rZ3M4?=
 =?utf-8?B?ODRheGNuYjNRYVB5VGVkWTR3NEVnQ25RNjBDQUFzWjRxVEphVlhYN2lrMmlI?=
 =?utf-8?B?S1NqK1k0aUlLajQwaExtQTNRd2o1K1k3M1RKTjlGMWcxTnk3cG5QTUNLRmFx?=
 =?utf-8?B?VE44cjloRStPWDVsWHZDL2pvZjY1UzViV21BUTF6c2RXR21JWkxERjU1cWdh?=
 =?utf-8?B?VnRiR01lUlRqMG50djRiZ0pLQ0NGMTUxbVliREtNRFYra1BXNGQ0TmdtNlVs?=
 =?utf-8?B?ZllNalVDVmQrYnUzUEJOZURKQ0FlVDJpSlN4SlZDYXlqMjV4bGtCRVRqVU9l?=
 =?utf-8?B?MWJrdzR4eVNKcEV0VkFpWW90aC9la2VJSzBpM1ZXTGVuc0pLczFEdm9HSzFC?=
 =?utf-8?B?a1hBamswU0dZSWNaWTY3OUNoejZtVW5Bc2FqaGtOd0RsWFNTa1g3Q1NLQm5l?=
 =?utf-8?B?Zk5vSUM2ek5oeG9lRzZ4L1ZEY2kwTzV0NU9ESDdKWUR3cEk5bDJKYUJjNkxv?=
 =?utf-8?B?a0tOWjRYa0JPemZkVVM5OUFtb2ZUbTRmRnp2TVVCUmtPR0JHd0pjcjBBNGgx?=
 =?utf-8?B?amhTSkRZT3ZGYTJpQ2V2bFh1T3ZNekhaMGFhRXhRWkhQN01OVE5SbzcxTlg4?=
 =?utf-8?B?bWh2cjZhbDZyMlZNa0xlaFZkeUc5U3p0RjVXblBBTzI4Yy9STHBuUGp1UGlx?=
 =?utf-8?B?NEZNbCtUQ3QzMlMvMzZmYk5OSjlMNndpMkdKd0YyZjVUZ1o1RUx0TnJJQ21q?=
 =?utf-8?B?UU9sYUxQenhORkMzWWd6ME1qT1dqelhVUVVqMmRyS081MEN6ZDJudz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: deb55ba1-9430-429a-8064-08de8afe7754
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 06:11:06.3295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bz95BSoJPociRtIvwoMlxc2WYESSL/M9jALH0Czbr4ywb29evTna2nXfnp59Lfxvmc3JgDanofcsHqyY8/utbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8518
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 26 Mar 2026 06:11:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22575

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6697/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2026&month=3&day=26&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     12:00     13:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2026/03/cip.2026-03-19-12.00.log.html

* Action items
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB
  - /me absent next week

Jan

[*]
Date the data is created: Thu Mar 26 06:10:29 AM UTC 2026
linux-4.4.y-cip: interval 30 day
  latest version release date: Wed Mar 11 03:13:57 AM UTC 2026
  limit date: Fri Apr 10 03:13:57 AM UTC 2026
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Mon Mar 16 09:03:44 AM UTC 2026
  limit date: Fri May 15 09:03:44 AM UTC 2026
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version release date: Wed Mar 11 03:05:13 AM UTC 2026
  limit date: Fri Apr 10 03:05:13 AM UTC 2026
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Wed Feb  4 10:41:33 AM UTC 2026
  limit date: Sun Apr  5 10:41:33 AM UTC 2026
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version release date: Fri Mar 13 12:18:31 AM UTC 2026
  limit date: Sun Apr 12 12:18:31 AM UTC 2026
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Sat Mar 14 07:04:13 PM UTC 2026
  limit date: Wed May 13 07:04:13 PM UTC 2026
  Status: On track
linux-6.1.y-cip: interval 30 day
  latest version release date: Tue Feb 24 08:55:46 AM UTC 2026
  limit date: Thu Mar 26 08:55:46 AM UTC 2026
  Status: On track
linux-6.1.y-cip-rt: interval 60 day
  latest version release date: Tue Feb 24 11:47:33 AM UTC 2026
  limit date: Sat Apr 25 11:47:33 AM UTC 2026
  Status: On track
linux-6.12.y-cip: interval 15 day
  latest version release date: Mon Mar  9 07:35:00 AM UTC 2026
  limit date: Tue Mar 24 07:35:00 AM UTC 2026
  Status: *Late*


Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6964C71159
	for <webhook@archiver.kernel.org>; Thu, 19 Jun 2025 07:19:42 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.44])
 by mx.groups.io with SMTP id smtpd.web11.8964.1750317578621507326
 for <cip-dev@lists.cip-project.org>;
 Thu, 19 Jun 2025 00:19:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=kwpnlN26;
 spf=pass (domain: siemens.com, ip: 40.107.159.44, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hV9rNdawLk9G5qsF6Dmpbusc4hiTo/ZhWbUIjBqVwt7dQm5H6WHC7AvE5jQEl0i/2VJ4KMMrXuwUNC6FPcNm72bGj+FoGHYQNR2GrrOgT/HUpw7Za03u20iugWxIrHLI2BuqoLnFJXRcCEaZAdbG+zyyCeHtlWJiEArQx+8QSLwqdECGAXAT+Ybs0ny1WYv5qEXSZ3vHvYnYFmxB3SpM0yVoHGmiunfYdmbTmJ+EilQUxtlSl6PwNMnEu8V3t1BgT9KpJs+wyTXh3fHbhGVhwsqB9YjiMXMPaLnQ3KCIUkU1en/LH4B/01HTKJlWhpttR5sXl5lKGmx+EoT+SmcodA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qEGACTEjdZXvTBGb48uQB6k+eY8bjcnM3YRPpzu1dzw=;
 b=h2pzB/H8w30WIHbIhM+qMIU79Ox8gW+ua9BEQw0JFYHc7vAAE63WPf6bLvkaNNeKmEGe9EoLGrZhK3GP4ZQQoB19ZYJ79jCMJ5pC4Pm89JVwkQaLAxxtVK/Zxz+8LbcKyMhONBRIcsd0UCaCoSa4AActe+JhbeIx0EzUkxIUJydcQiYlOx42NKRd8xI6wACW8Mrm0O6mPks7vLqsTZTeB9221SFTdxJYjNkRttt+iI/rpyMFq4YjtaBgnY9xHDEQBEsV2EjRdOb+HCOgz2sEG74Ba1A2BjxWaOGlW31olDGXAsrIHLs/WF2u+xCzd46Es+eRKQtxF91Ag4zA93edLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qEGACTEjdZXvTBGb48uQB6k+eY8bjcnM3YRPpzu1dzw=;
 b=kwpnlN26Z8nIL86b9Rl1HF2tjPmkHCFc64xObrNz7AlgUhwqVJrw7WTN25W5DNLV+y/SUbtp4nAeNRpONQfM6v+TkCa8BJN4N+zG9WHwwBOisbM3SaooZ4wdjt8kSCMFNM+QxZ+TL0hninegYhb1jyIGMmwb54bZj7hp++amFyWz0PQ/DHf9yh0Uz9UFkg1+JbER5hWPnBg0TY3W710UXx1CMv4HXtLwLKw7C88JJFtV0pSdoeame/uuOvWKitk3u90xbvOnJg4xyt0ozhxXnq7GbQpbmpf4W0446APHHUMM3tVXjuj6PoOn3BokBA54dFHoBbfigOOh4e+F5VSCwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3607.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:137::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Thu, 19 Jun
 2025 07:19:35 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8835.027; Thu, 19 Jun 2025
 07:19:34 +0000
Message-ID: <eb65c033-3b54-42d2-bccf-a5365caa84db@siemens.com>
Date: Thu, 19 Jun 2025 09:19:33 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0122.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3607:EE_
X-MS-Office365-Filtering-Correlation-Id: 5143cb12-fc60-4c93-d3db-08ddaf01a486
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?WGo4WW5EVU9GQ3l4MkFHQkxEeDQ3MFJLenBPeUtSVlpuNXd5Wjl2MUZ1WFBm?=
 =?utf-8?B?NnhHVEZWa0tIL2pYYklXcjdCTzhhcnd0WEhPcGdNSFgwa2htQjRyQWVKTGhV?=
 =?utf-8?B?dEpEK3g0cXY4NEVoMFF4SWZxMGhXaTFJWXVYblgzbUsrc0ovVTFCNnNScHdo?=
 =?utf-8?B?dGVMczd3RVpnbXl1dXcxR3FoV2k3RWdORnR3UUtsR2lKOFZodG5QcmJqSlhW?=
 =?utf-8?B?aUFPcWRTL0RTMTFHKy9LcTJ2MkNveXJpcVlxS2NkWnhtMExHQnVUY1NEZ3M5?=
 =?utf-8?B?ZTg4Z3kwZUpHdG80Y05pV3d3MWZ4S1Y0UFBBK3lnT0lqOU50eTgzSEFidVlH?=
 =?utf-8?B?aThTMzFJUHN5dUYrRWllZmNWQmU4MmNDSmVIT2NtSWtBb2xXOFVmQ3UyWmw3?=
 =?utf-8?B?Zm5VSWh4YkpMUHJGbzRvTEswcitjQ0tFZzExK3BLREtxbG1hV1VnMGM0Z0Fh?=
 =?utf-8?B?L01zcGpiQXZ5eDJHVm11Qk5EMVNHaXAvUGJPaS93NGF4blR4WlRSMHpsdWN1?=
 =?utf-8?B?Q2VxdVBjTWI4a3N4SlJJUGRhRkxralRpREs3NEpOc25mNk1kTHVqZ1dQeXBr?=
 =?utf-8?B?VndhYkhuZVJvWkptQlJXR3Q3K0tJZUtDZkZ5RFFPL1RGUS9iOXFFNWlXN2pr?=
 =?utf-8?B?dFIrME5OOU1xQk9YY0FxSUZtZHVBbFB5RUFLM0ZpcS9xcGFKc2huWkNJUlFT?=
 =?utf-8?B?dmZYSlJROTNLeEozeW0wekNITkdyVGVpK08vUE0rc2MrTkFiMUFIN09icVYw?=
 =?utf-8?B?b1Z2NUZ2MG1pWUlnZGxrclpCa0w4ejlXSFBCRXpTdVBxL1hpUmE2OEkwMWN5?=
 =?utf-8?B?TUMxUlpxbzhNZEhxMTdYSUhEZmd4aHBCbjNYWUkrcHFBT01hUFpRRzExQWRv?=
 =?utf-8?B?SnR5d1A3TTNKTG1LdXZpRFp4dG9ZYUJZanBYVmRKOHNheExPdTRHUGloQ25H?=
 =?utf-8?B?RVNGK21jbTQwYlJzeFBOOFJ4UlQ5dGVETFh3L3lZbTZzNmh6ZEFrRjBCYzFl?=
 =?utf-8?B?dmh0eUtYREswcXlUc2tvelNpU0FyNkVIZE5KaXZwQmJOTGNmTE9PNUp1b3lz?=
 =?utf-8?B?TXl5N3NrazRsWGR4MVBnQVB6QlNjUjdWU1ZPZytSZVp6ZTE0WllxdHplOGxJ?=
 =?utf-8?B?Z2hhTGo2aVNuUWFSN1pIZVVBVXFVSmhpUUhudkVMTlZtM202UVB1WkNSekp4?=
 =?utf-8?B?cmo5bVdPTkZHSlBSdnplZVdWWkNrTTFRZXh6YnY0c2lac2dKYmdGT1ZIOWVV?=
 =?utf-8?B?UFd3ZkhCeDArcFpCSnk1REVBcFVoQVl5Rk9OWEZ5L1JjNjRSanRhbkNEVEpG?=
 =?utf-8?B?bzJnSWlSYm9ZWE1QYTQ0WkZ0ZzNzNFBoa0xKSHA2bXBGRXE1OFRnbEZDQktE?=
 =?utf-8?B?UkpVRnkwN1VRY0JIdTg2SENUTTV4ejFaSmRkR2hhZlFzMXE2OFRFVUpqbk5a?=
 =?utf-8?B?KzFTcXRZSHNsNjJGYmJkOU1QUlVtcWlldHJ1dFBBbGpleURNSUJ0eVM4WE1U?=
 =?utf-8?B?aWE4dzIrdUVleE1qK3VKdk92ZGlNaElFakg2dWt5WFM1NVB4bGFmbWtLSVJz?=
 =?utf-8?B?ZXhzbTZoODdKbmNzNG1SQzFib2xFNzR0bkVhbEpsY3dDa202OHFDazd4ak9W?=
 =?utf-8?B?Qk5ZVmw2dVdXdUlXVDA1dDNXU253NTQxbTlON0p0aSswZFY0RHBmTytsNTJj?=
 =?utf-8?B?UTZhTHVYNE51MkJrVkdNbEVXYU52TnM0SkdWTGVqaUNwSkpud0JpUTI1dFoy?=
 =?utf-8?B?bjgrQlMxRlhkQXE4VVRta1NuK1BFWlg2MzJjQjd1SFZFWWhWMCt5SC8wNDV2?=
 =?utf-8?Q?gUh2hQuZa7gS2fY2QooccmYS6AvGikIi88jHY=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZVpjVlAzTmt1WnFic01VYVRIL1NSUStadEZwMXZnUkJsRHNza0JYU0RwTFAr?=
 =?utf-8?B?dHp5Y0FrdGxjMWxha3VpRVo4VWRRT1RuNFZxOGs2R2IxQVdpbHVjemRXd1Uz?=
 =?utf-8?B?bk9kV09xWWVua3ErOWJWT0tDVTI5R0ovZkJRNitMemJmSFpVS1dNSkN2eG8w?=
 =?utf-8?B?Wk9CTFpMdUlGR1FhQlhhVUFyUW1qd2hjNG00aWpyNEtReG8vVTVxWUFtWlla?=
 =?utf-8?B?dzhlOEZlRXFWd2xJaVkxZnZkb3FBN0VPMkVFdVdnaFI4cXQxZnEzS0doOEt0?=
 =?utf-8?B?UU0rTlM0QTR2elRqWWd0dW1qTUVianByNDQyZ3hONy9xdVE0Y2dNOXp1Y3Jr?=
 =?utf-8?B?RVVqaVgrOVJGbFRSMEdZV2FxQzVKbWxJM0RSSEpOditRbk1nT3RUWmdYa1VQ?=
 =?utf-8?B?L1RBVUwwNktCSS92TG5VQjR6cm9MVnJlWm5GaUtpNU5IQ3JoUXZneDRDQVUr?=
 =?utf-8?B?VDZRWmg4QWx0Zk00V1FhZ3duRFNqajNqMXYrOHNybGFpMXVNQ3NPRTdNN1J6?=
 =?utf-8?B?Q2psemp3UHRONDFRYlc2QUNHNHlzUUxjWkx3dkNPcS9ud0Y1d3dzSE14bnlj?=
 =?utf-8?B?WUd6NmR6ZGZHak9tNzQ2K3kyNStEcjRnZjZxOXRMM21iSzg2VjFReEs5TXFL?=
 =?utf-8?B?dmpUWEZ6QS9Lb2Y4cnh1NHlEZDFpaVAwcnloNm9uamt5dHRzcURUUFNVU1pC?=
 =?utf-8?B?WHE1dHk3Y2VMWURqRllJaWlYVnovKzIwZFlOQ0FNQk0yZDZyU0hSMzlZa0ox?=
 =?utf-8?B?UGxUakVLb1YvTEErRHZ1cThlTjhGaEJ0Y0FIMjJFZHdxajlnVUdIVzBubGhz?=
 =?utf-8?B?bjNFMDlCdG5YODBWWE5yZHlRMWxCZitjSXZjVzl1L01jblFFWG01K0NZdEp0?=
 =?utf-8?B?Wk5jVHRlNHJiOVRMVUM4QmdTWmhRUTRTV3ZjSk5TUXFmdjY0TTQ2TTFiRXhR?=
 =?utf-8?B?MnhjY1NidjNsNzBiUnJrbUhmWEIxbFg0UXFYQW54ZXc5VThWY2I0QlkxUlpl?=
 =?utf-8?B?R2IyMFl0YUM5Y2V5N3BHbHk2T0FDMGNrRGJ5NGVMOEEzL21KN3JrVWFMNzhR?=
 =?utf-8?B?M1dKVWduUTJxOGNVMWgxMW5Bdy9RNWQwT0QzbzJPOGd0d3ZIeEdnU2pGbG5w?=
 =?utf-8?B?VXNjMENCTVFXTEZWbUVaUGxVUDQwa0xRZzJPQ3RQeWZEdE1NUm9XZ09iQ3BB?=
 =?utf-8?B?Vm5nTk5sZVBuWmx6RUwya2xSRjZmZUgweTYvTFAxWm1SZVc2K2Q2TXR5Uy9a?=
 =?utf-8?B?Y2JiYXZHdnR0S1BOMjlzSmxoVFY3dVJzdmlEVnRjVFJMOS9tdENsbDNDWHBn?=
 =?utf-8?B?V3JHa1E1b2hvKzhFWnBoSy9oYVNuVW5uVTZWS0FDMzhDQlJJVmozSXlzRisw?=
 =?utf-8?B?M2lvWENKSzdhVXhyWngycytkUGk1RzNwbjhuVS8wUkpKRGw0OEVTcDJzVWE1?=
 =?utf-8?B?blRiVFBTQm1jcDJpbWZRbk91MnA2QzFjWE9hbVU5YXVVS01wb0J3YUdXa3N0?=
 =?utf-8?B?S0p0U1RDU0syWlc2R09DUk9qOTltcG5HSEUxUTVVUXFWeXp0V3JGMUxDbHRN?=
 =?utf-8?B?c0hVcGpnUERqaHpGeXRnTkpvY2k0TVB2aFB4Wks0RVE2b0N6Mjl6ckNweWs3?=
 =?utf-8?B?ZjlLblpZTTlWQ3pjRXRxc1BBR2ltWisva1FsenZCYVVqY3J2TElaZ1pYamc3?=
 =?utf-8?B?MFB1dk9qM09CR0VOdmphYm1RQ2pSU3djWllOSTU3am5vNDlWcG1MN3dERUtT?=
 =?utf-8?B?d24rU1NpZW9XdkFFN29sT2JnTWlWd1ZZTjBoaG44OUV1d0VFVHJaK1BWcDlN?=
 =?utf-8?B?WW93Z1dJQTBTcEoyU21WMlBDeWNvUFJjUkJtR3pvTFRnaThocVBSSGxWU3Jv?=
 =?utf-8?B?Z0dCQTVBK09ZY3k0alhsbHlkOXBQZXgrRXo2Tm5GRG9PYWlWcWpCWHc3cFlB?=
 =?utf-8?B?RjFuQnhhbHNLRHM4dTJibHY2ZXhkQ1dwdTFCc3JSZkJ1SWFmSzhFeE02K3o2?=
 =?utf-8?B?R2RRWnpWYmNQMFV5YVRWYlBFb1VQSUV4NlFBWkhvNG05YVJ3L1hsM0c3cDlN?=
 =?utf-8?B?NVNwd2dsNDJJdTZpSVRJZERpTnhaVlhjWjN6Q3RRMFpYYkRCVFBTUUxGVjhU?=
 =?utf-8?Q?e5taXw5vDzLdR5s15RNBXXRfE?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5143cb12-fc60-4c93-d3db-08ddaf01a486
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 07:19:34.9055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UbYAUAd5o+bhlMYzdV4CoJgy08+kvs6TWPbRWreWWCX1JB2CZvMKlaYJv4vTLJllJT6uNJKGX6y1V1x2EN03mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3607
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 19 Jun 2025 07:19:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19137

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2025&month=6&day=19&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     14:00     15:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2025/06/cip.2025-06-12-13.01.log.html

* Action items
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB

Jan

[*]
Date the data is created: Thu Jun 19 07:18:29 AM UTC 2025
linux-4.4.y-cip: interval 30 day
  latest version release date: Wed Jun 18 08:46:56 AM UTC 2025
  limit date: Fri Jul 18 08:46:56 AM UTC 2025
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Tue Apr 29 11:30:23 AM UTC 2025
  limit date: Sat Jun 28 11:30:23 AM UTC 2025
  Status: On track
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
  latest version release date: Thu Jun  5 02:14:36 AM UTC 2025
  limit date: Fri Jun 20 02:14:36 AM UTC 2025
  Status: On track


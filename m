Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF68BCD3427
	for <webhook@archiver.kernel.org>; Thu,  7 May 2026 06:06:22 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.65])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5843.1778133979257139808
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 May 2026 23:06:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=KtDYEa5f;
 spf=pass (domain: siemens.com, ip: 52.101.66.65, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GmRfYqbC8xLO+LpjPR5kLRkD69YPX+D/u1/5VWN73+dra6TRCAeF7DW0Os/Qlxf0u5IAln6yr9dtIwHpZ+RuDsEIAPZfXqdJ0fBO6WXKNqY1tZs4WLJmj0VBPAlg6U+YkBW+dCfaUMFHxpKAY1/8Uctee6iaF5McsX0uHaaC5PBdb1UJ02kA5PMZmjVIr+NXtMeoNe9CKN1eyOUD78nJj32YG7n0QWIQFe21SCfqAx91fKcynp4i12DU4SSqG7ayBWHGpnqGPwLFzhm7yuteCdIG6feAcJyvZ2c5TWLqnHUQMKfDao+92QOLPO8YqYC7dWIIqgAzHXpB4NlQJnyxTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/h5LaDALadEXVuG7vo0p+O+xflJXVD4A7rGy3ek6z4k=;
 b=YG23cGoi+V38fwGisdzYmkvulqx3fncEfBwZMuqbYg4nUPcwjkTzNROohXRlSTApdONxPBsb9q4YVJasVU/6aVWv8Rr6K038tycw7WBhOZD4nYWKNJGX2kCR9071N/WPOTspRzW/UuNRdUXsieCoqmefUHrMpKeD+AKRzwJfvu03LAlISSjlHnTBzPepNYaWeH+ybJGuFI8ILdCL0fQ9nwam729XDmbO1YENxiiRywDjQgZ+ZUgH8SELmXnnULYs/y0xx4dMfBV/FdQNvlqg8DHo6N/2ZOnX5kp4KvMHRhjombkNQjVErSMfxDFYJAd4mJjS1bBEeGzB62JMJKq3MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/h5LaDALadEXVuG7vo0p+O+xflJXVD4A7rGy3ek6z4k=;
 b=KtDYEa5fcW9cMS8UAUrpAyJU4Rf7ZuOhWYLd5QcMCRu6SEb4oaJcvA3LPZZQg7u2OUf0rKhsBQgVrDQRcI/7SL7ysgSV1k03YHSwNQIiXqlJ/MqQa+b+wR82ST+iFTOMMHVddrMcd8Fw3fwmMgPYuxYiYPYJlTTAME0lRc2NBmS3WnOhPMCm0H7uQZMzI44V+UybSDrH9l/1Cc1aJE+HJAK6DVtEAY4ozVZQMYPGbIpVpydD8FfHO5VvC9c5QEgXIefkrZEkboeO06BrV7a0UQg4J8ZRz6sM+inZVKkHvhjBMq6rXlZLcPK5lr+RJCS+/1SC+Kd93bRmI6n+rMZG/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB5889.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:55::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Thu, 7 May
 2026 06:06:12 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9870.023; Thu, 7 May 2026
 06:06:12 +0000
Message-ID: <91059c44-aa54-4918-87e5-2d76dde2331a@siemens.com>
Date: Thu, 7 May 2026 08:06:11 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0371.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB5889:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fb0222b-e4c8-4a1e-87a1-08deabfebd6a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|56012099003|55112099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	mxh094imuejc4xRKQVB46cJzHYlSNZL8+t9g+TWm2qgxyaZWZCEJqFnrx9W668YlPzZQeaMt4G4dudBPoBLG9+MBks+pgxRl4Y5WwflFR4izYH8hwUAydddPg6rj3CEluF3Eg+zx3P4oLpW4kNZfa/i8Ls/9Fqx/H7h8DfJSrNlQYGbgc/iBej8jQAPV7dGvwuObPbGWovmxEwOWtUNu8R1b/YtZc1ilQ1vsjpJ54PN2V+yy6zObBPxYF5UppcjkqGfkik+HMk2dk9YYsVUWDuLgimvKcrMiGUGO5nsawK9lzooiYuzRf+7Es79ViKJtEJC0k75XOmtRrzvLAZu8NDRkbRcQh3JRzy0Jgc0ayP5uk8tYtvqw0suYTR5F3gnYtd4q0AnE/AsYfqN1fSwep2kxy2rVDU3Y2207tO8IFiZ4N+yaCn2ac/CLLIz24T3PdmFBZCW3XkpFV8HtuLHBO0WyUxGSTrdd9SmJI7qS9901BsxmanN/aNGP+KgDcaHdWXghj143iMxE3KA2pa/tEvRzCiXDV0RpMwmBO708Yf/1MBHs4jBu0Gwjl/mFWDRcecogdqbMRWUyopO9RB30JfTYeOXkV+zS41jweE/r4IFBa2AFnKgB0FNIEV1LUFqUt19DtB2UQYIPhdJSvYK+og==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(55112099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Yi8zSHAycXk2clVYeDg2ODNLVkM4TkNHaEwxeU1MdkdncUFobjB3eFZpRU9U?=
 =?utf-8?B?TkpjTCtqVFAyNCszNWpYYU9xRUpFeHRJZFJuMHZMeHp3OGErV2pzQWxPU0F2?=
 =?utf-8?B?S2Z5Nm9oM2pXcUc0eWdtWUw0SlZ3WFZaSjEva2dweU1VVHdvM3REazM4S25m?=
 =?utf-8?B?S0lKUXRVbG55REVVS2dBWmJjV3ZiSFpsNVpmQi9McHJuUjJNUVU4VXo3YnZn?=
 =?utf-8?B?cnhpaXpLakhybEZzNElQbW1MYm9TOHNkVGgxaGdiSmdTUHB3Wjl2RU9WRThZ?=
 =?utf-8?B?QWVxbW5ET2oxVUhVSUZzaE5xOGJOd1VOTVRxaDFqZ1MzSGJNTW1iaWMxSFE4?=
 =?utf-8?B?Yk5Uc0w1UHdJNHhib1VtcGNnc1ZJSEZBYkRUeHUzLzl2dnREaTBOdnVFV0Q0?=
 =?utf-8?B?Y1MyMUw3SFd3NmNYKy9mL3V3dEF3NU9TWDI1Z21zWU11MkJVNWpqeXJkU3Mz?=
 =?utf-8?B?bXpKNVN0U1BrWnpRTWpkYkQ4NGdnNmExNmtyVjJQRWlUWXB4eFdyVW9yRENW?=
 =?utf-8?B?VVlIT2NiNllHdEszZWRocVdUTzdwMnhhR3AwU2NKYStnWlNNdVNMNittRmlm?=
 =?utf-8?B?QmtQWnZzdmdnUzhMM2VYcVFRcEYvWlNyTzRGMEdRanhWcldzam00Qis4cU5h?=
 =?utf-8?B?S1doN2pjT3E4bEI5ZWtKNDZOYjBGMG5ML2syUFNxK01Sekt1R0hPdC91dUUv?=
 =?utf-8?B?MzBDZFVMcTdXZmpJMmxMNmV1YnNjSk05KzZQV0h2akU2RERtbEFBMlNFN0pF?=
 =?utf-8?B?T1p4STVDMU5HMVhqVXVkd0VhMVh5K1M1U0xrUE5NdHhXd2tCU3locHZxZlZ3?=
 =?utf-8?B?WjZ0SGZZSU1FK09GYlJVK3Q0L1hjbmM3VzFuMkpHS2svTWYreWdGNTFwYmp3?=
 =?utf-8?B?ZzVZcHo0VGYyWXJHOHZXam5pai9JbGgwMFJEbEJiaHZ3S0t2OHN1OVR4cWtk?=
 =?utf-8?B?WUFaSTlwTFdERC9UYzRGTU9wYjlmWDhDcWl2WG1NSVZFZDBZK2V2Z28zOEVk?=
 =?utf-8?B?WldZUXJhL2dtdjJrSWhXcWZ3ZFhJRkRVVWZZYitnSkhmZDNFTDNwMVBWK25r?=
 =?utf-8?B?U0Fkb1N1Wms3Y0VmY3FFajhFT2Z4MGZMMmkwQWZQYjU1T082WlF0L0JRRTIr?=
 =?utf-8?B?Qml2Z3YvR0pDQjRJQWE1VGI3MCtTdktTb0V0WmgyNmtoL0dtN2Q5OEx3RVVJ?=
 =?utf-8?B?QVl5NUo4KzZWUEdMV0J5dnNESk92bEt3RnR6ay9nL3ZEYnVoZnc1R0kyUDVD?=
 =?utf-8?B?UlJYcEZtRGYxVTZibk1pQW9uOTM2d1YyV0dDRGZHblMxMitoWHl0dHNhMlF2?=
 =?utf-8?B?by9kWmM4Y1FuR2ZTOHB4RFlTcFZaZ1ZZVXR3c1ZWZFBkOWRpRzV3YlV3TUNi?=
 =?utf-8?B?Z0phLzJQelJuSzJnWHF3SVRoOWpKNVcyby9iZkVjUXRXZXlmaUlXZENaZzc2?=
 =?utf-8?B?NDA3S2RRQzhOWk94ZU9oSkhjQ3pnL2ZRaEZWSHN2UUJCVVlIc3lQaytRcUt5?=
 =?utf-8?B?YlBVcWRyMkJKY0E5N2FjelZGa0hOV2gvbnZUeGJjT2hqUXUrUTZ0QWFEUHYw?=
 =?utf-8?B?bGloWE11N3JZSTBGL2phZ2RhblBoMlE5WS92aXk1MTRKZGx4R0c3VkVpNzVB?=
 =?utf-8?B?NU1jbWowQlpVYnpRZCtOcVVKaVZHWkptQVhYbk5DSmh5T1plL1FmZkplNG1C?=
 =?utf-8?B?Z21meUZ6S2ZaUndSd3JCN1UyNmxYc0QvRStYZ2N1ZGIwRW55YXdkVE82WTRO?=
 =?utf-8?B?a0s5OWY1MVorTUVmUVd4cHNtOXVxVW9HRjhiM2RCOTNKN0xHb0g1NHl6QWJZ?=
 =?utf-8?B?TzVNR2YwZEh4R3h3UXEzUmFnSDVWQWRFTHRLM24yc2Q1Y3Q5K0E2NnAzcTJ4?=
 =?utf-8?B?b1g4Z2t3YmxGZXVINGs0c3dJbSs2U0xubjhHdTUrOE9PWkNiSFRseHp3R1Ir?=
 =?utf-8?B?bHJwK0taNFJZYnY3MEhVNDdVRWdsOXdMM2ZHU2w5YWZ0eFE1bGxQbmxQZ3pL?=
 =?utf-8?B?QXZCcXphRUl0RlBVd3Y2ZEFLV2ZFUXVBZFJTNm9pcFhyOXh1MGR0ei9QcE9P?=
 =?utf-8?B?aEU0M2FrOWhCaTErVnI0Zkk4SUhiWlJTWE9WbzJTbFdyQ3l6SUVjeWNrSXd1?=
 =?utf-8?B?aXlJN3hKUEtTeU01UGpDV1Q4VDVyNTlKK2lsUDFldk8xUmZselVkcWo1Ymdh?=
 =?utf-8?B?ZmJRZlpUMm5mMGVISFhoSjBlSzVHdmtKSTkwbmJGNUJCM0IzSEJyRmh6Slcw?=
 =?utf-8?B?Y0hYQXBxZkN5RWtaZTJ3K1EzaGFvNnQyZUFhOUw3NHVHV2JKZ0ozNklBWEJR?=
 =?utf-8?B?YUhvb25WdUJYWC92RERURDNPdlcrczRJZkJmMk9mbzlqT0FrQmFwUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fb0222b-e4c8-4a1e-87a1-08deabfebd6a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 06:06:12.3233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BL+MRC33l3kX2QFCdJ22ypzpwFwntKjl/lTspGQJ/gMS8vWy8ym5l2R73EQPGBBuFU3/ihoYi4fSD5eMW7jXDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB5889
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 May 2026 06:06:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22896

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6697/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2026&month=5&day=7&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2026/04/cip.2026-04-30-12.00.log.html

* Action items
* Kernel maintenance updates
* Kernel release status [*]
   - state of 4.19 copy-fail release
* Kernel testing
* AOB
   - ARM 32-bit RT backport (if not sufficiently covered during E-TSC)

Jan

[*]
Date the data is created: Thu May  7 06:01:39 AM UTC 2026
linux-4.4.y-cip: interval 30 day
  latest version release date: Fri Apr 24 06:54:09 AM UTC 2026
  limit date: Sun May 24 06:54:09 AM UTC 2026
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Mon Mar 16 09:03:44 AM UTC 2026
  limit date: Fri May 15 09:03:44 AM UTC 2026
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version release date: Sun Apr 12 05:58:25 AM UTC 2026
  limit date: Tue May 12 05:58:25 AM UTC 2026
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Thu Apr  9 08:04:37 AM UTC 2026
  limit date: Mon Jun  8 08:04:37 AM UTC 2026
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version release date: Sun May  3 01:17:37 AM UTC 2026
  limit date: Tue Jun  2 01:17:37 AM UTC 2026
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Mon May  4 10:49:51 AM UTC 2026
  limit date: Fri Jul  3 10:49:51 AM UTC 2026
  Status: On track
linux-6.1.y-cip: interval 30 day
  latest version release date: Fri May  1 12:45:01 AM UTC 2026
  limit date: Sun May 31 12:45:01 AM UTC 2026
  Status: On track
linux-6.1.y-cip-rt: interval 60 day
  latest version release date: Mon Apr 13 11:43:31 AM UTC 2026
  limit date: Fri Jun 12 11:43:31 AM UTC 2026
  Status: On track
linux-6.12.y-cip: interval 15 day
  latest version release date: Thu Apr 30 01:36:52 PM UTC 2026
  limit date: Fri May 15 01:36:52 PM UTC 2026
  Status: On track


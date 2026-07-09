Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF8EC44503
	for <webhook@archiver.kernel.org>; Thu,  9 Jul 2026 06:26:41 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.21])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3077.1783578391339806788
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Jul 2026 23:26:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=g1RfWwA3;
 spf=pass (domain: siemens.com, ip: 52.101.66.21, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x39+/6snd32BcWO6tkBzEN5DwuKePXO25Fthz/x/gr2VZTDflhAb/kE2ZUEl//wmPd2Y33vnRxWY0CE4YvazWtJUa6uFB7h7BHoVCgBXSLnDRsQj9qi3lZRHXgKPdcpdPfv7M8nf4aDDZDzjo4zbOEqNlTPNK6VFK9rQfCjSOrlsINOizCl4TMytp8Jf8bILg048GYWWW0V75u7iX+YHi8UAVElvMRXJFyY5VHTyArfi1UC+Lonp50qY0Ecvlkdrs/JBdWyl9rjDj3m7aXplcRVHtTBhLTsoTBnXSpNGTn8Y5QXMmB+z03xD/5nWeJhaeWoPzDIP2zAJD0rVrj195A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JXGIe0eQ+DU+v7QtLdIMgPD6EeMNmDwdfVQvTRwPvLg=;
 b=ugl30xTjD7/vuYIkkVul/92L5dz1o/C/td9iVOiIR160oskCsXQJOFP3qqBtgBsRZorPUtQI5UNY+71mzZ/CLb2JiTXy8cqnJlKFS3XSb+sK/ZsTdCZ1QMFEky9Uy8Gg2eOIDNu5N7mP9JqtvJ0noayApOaGeWJCkByQyK4xlmEYEV/Rf8fRXQ/g0/ezmpxueXDaG9YqE11ULO1bpfZGpgaZWmTXSfuleXtwCHOuJMwNYamzmi1XUrbKZ4zFFyC3rseF8b5AC6KYnZ3Zr3KDRotQwMYG/nqhiJ3oVwOnw27UfpCt7y0J5tZnoajV27SJO4/Qzts+gMpIZ6MavrtFxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JXGIe0eQ+DU+v7QtLdIMgPD6EeMNmDwdfVQvTRwPvLg=;
 b=g1RfWwA3MPcliUIRAjNI8ORpW6GD2WfTsfxxYjj+W0mdkJQ7htiyvvifN5vuQU+pmZwrxDcbDlKi+4DYUSJUwzgJs3ioHglnP/yB5xujeO7SigGM4aCO2BSv6EE/uwbJpjoXTHySrT5Q8X1IhRzku11tPxR3uVfNHMY8UtSibtjloFgtxvOLFwWrP9C1K5fdRmH2Dt7vCzgoQw6rBP7uyabN2T5XFoVfcL+9SPLjIih/1hbEAhlQkjtw3CeWs2Ks1G0lFrQn6h4iOA7W8yZKlTEJxobKo0LhrjhikziB+60YN5LbVqGCn7YQUYgKLVl/pjRz2cz5yLydy4jx90ZI3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3485.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:13f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 06:26:27 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0181.010; Thu, 9 Jul 2026
 06:26:27 +0000
Message-ID: <105b3b23-0aac-4c23-afed-047a556f96a1@siemens.com>
Date: Thu, 9 Jul 2026 08:26:25 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0034.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3485:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a1614ed-890d-4936-bf52-08dedd83018c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|55112099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 
	JokYs8uZT80bVXWnKTa1lruItbw1Cc0FIGFVZ7mq5PA8g6+CXmekbjdK4g4/cc2cAZuXXp0QZ6jFNZ9l5YIVYHNoylSl3P8vOFS1s7H270m1fJRKqoVm+B2GADlaxVw7dhSqSvLqJwOihGH6Y44CpBxb3V3numQwZlY5xwUm0suVwUUOZBPnCvDGgkr8y2B7Rqw7ox44cGBZ5bLxlCv7exD0OtXtKhjpbkHeNsi1jdg8aW3U07WM63h3VlE66+2yDD6KuFK8K/HjAx+mxNfYqoQs5KMpyT88GvURbvqprSB2stUTO+CugC4A9J+fnWNBL78MxmH10/sOqJdnpG7gBFtNx8GH31TfuRVxrTaSBD0pBdFfOv/TM2G4bir3MMG2r4VQlywSfmvfmZMDRNVrQMIpREbkCNLtJYW5Rv/7huTfwasEkMLv+beFZuAa2WFVAYNsvFT+EyAElkGx0vi5QjK3etoQdHF+IdkLELgtpuRT0uYypmu9tstgfMNWOnImwiCuztyoRJcYdtf+YPkCQVOVHD73BJEqyFauBmMZzHl3PX7I2KFYpb0ZwYfCWONfrt+tpuc1NPhTiDMnYEu2vk/b6Age+vdQyUzRXiaI9dFTnAzi6z7gCma7FyfpuWPc
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(55112099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?T2NZYUhmOXJ6ZGtmQ3lUNGlTWWpZZG43VnlXZ2JWc0k3YUg1RUZReE4ya1R0?=
 =?utf-8?B?RDdCSjRmQVJSVjgvV293ZzdYcXFNNGordVdneTdNbnBCUXEzOGJTZklKeVk0?=
 =?utf-8?B?aFk2M3l5LzNhYVNpSXpLMitja2RlMXBNR0JrdXlXejJ6R1BER1cxdmd0N3V3?=
 =?utf-8?B?MkxTdEt6NklITkxOMUo1L2dTU0Z1OWNaR1BpK0NFdkt3eDBDU0JNdldkSnln?=
 =?utf-8?B?WDRzY2R1L1UxZzRiS3p1UG1wTFBQczRpY1diR293SFZIaG5mcDBxeUVyazNI?=
 =?utf-8?B?LzNNOEdOVy81RkhrazVJdGo5NWUwNmRibktLNGEyNGk0VXV5bkN2REFQVWdM?=
 =?utf-8?B?Tlg2MXU5VjdUakxsVnJxZ04wa2FNc2oxdldHMG02bXZCMmpVYkR6QVluSlA5?=
 =?utf-8?B?aGl5Q1UwVnNKVnlXekw1TlU3b28vVWRWVzd6SU5td1lTNVAxWkplb0ZHRm1u?=
 =?utf-8?B?NUNFa3d3ZWJicE14TGkzY1FpdGc3WTMvMnRwT1BQUDY3eUdZUDRjaVU3ODJt?=
 =?utf-8?B?NFhMYVJjajFoSnFrazZqb1VnRkhLU095WlZ1NFQrNXkrK2t1U1MzNllBeVNo?=
 =?utf-8?B?TVVLWjQzWFg0d2lvWWJieTdWTHZ0ZHFJUVBNVjNwb3NTNzNORW5uU2p0S1kz?=
 =?utf-8?B?RDQvOHB1dTJsVS9qcy9UZkZ0R3E5NmlnR2huaktGRlNYMnRPVTVDY2dhVWVU?=
 =?utf-8?B?bzdjT09IekJoNWFVVlVLQzJWN1pLdlZEOWFIc2xiNnVtY3E3M0hSbnNtYmtZ?=
 =?utf-8?B?VDZCdkJLWC9Sa21yUk9PNlZGZEM4VTA1OHlRNzdCUkh4UUlRZmViWDMwSEk1?=
 =?utf-8?B?Y3RNenBZZEcyTkxFQlFJOUo2QTdFYlI4bDlibWtrekNXWkVkaG5pemtPaW9v?=
 =?utf-8?B?NWhZQWhoOUdPRXdDaGM4blVpVEFhVHE0MVRML2o4cmJBUEVjekZPejRlc25u?=
 =?utf-8?B?clR3SzNtQUZDZnczN1E3K0JYNlk4dnZ5NTFZYm1wOFhRbTFCaElKa1M0dDNU?=
 =?utf-8?B?RmZyRmUvVUdCcGFyK3B1Y2x0RGVhYnluZU9Vbnp2eGNTakdmMlQ5dnlRaThJ?=
 =?utf-8?B?bXZ2d3JmQUs2ZmwrYk9RUEpPaTgvTUp4NVFycm9nZkh0a1N5TjdlWGpRbHdT?=
 =?utf-8?B?ajBhYzJjRmVacU5QNng5b1RnKzRMMkdxUE5BYTJZemc4bzJrM3lMWFEweERp?=
 =?utf-8?B?UDkyaGE2THdJRXJCK2x3elg5bEx6WUlSR0l6MmRTZmZSLzAyMHhkazk4Ty94?=
 =?utf-8?B?VlE3eXNJMnRQNkpzOTlGUE9Rd0VkUEJydmNoYW5MbW5zZlJ6SFZyUVJFckM2?=
 =?utf-8?B?Z1k5S3I4SjRNWU1jSTBDUjNGVmlxdVl2RWt4cFZiZWpFK3orelFUUWZ6YnAz?=
 =?utf-8?B?akNpaDBCaEZOTFl2UzJCVGx0ckhpWXhUYkQ3YWhkNUVCb1NqSUpTVVZzVDha?=
 =?utf-8?B?TzJ4NUJlRThFMmFnSXVFT3NBb3BURXRPUlNpdnFEeTdBM1dxbFpZOFUvbytI?=
 =?utf-8?B?cEJIRUZmdkgvWkdmcldkRnlhQWZDNVlJMlhZTjZtZTJJQnNtdEVzampGQXd3?=
 =?utf-8?B?cHZuOFh1L3lkWG5aWVZoNW96Vy9jUW0rSHFwUGcwSFZwRFkrZ1FQYUF6c0pO?=
 =?utf-8?B?MTROK2llMTBVN3ZvcDRCQ3Nidm9aRy82NzBVdlkzZHcyZGpnd1JpWktFZmNr?=
 =?utf-8?B?ZmgxcGwwRzgyREVUUEV1MzVIQStrdExmK3NGNlZiZFBkSkRiM3RvNXA1OTFI?=
 =?utf-8?B?UytucG1UUWhZODdXWlRQdTlDYTBkYm9uNXRTSGZZUExkZ3N3alZjekFOc2VX?=
 =?utf-8?B?WUJVZWV2MjJIZW1xSmVVQnVENDRHdWV3T0thR0NkdUttRmh5NnR2VWMrckd1?=
 =?utf-8?B?aldqUDBWV3B2d2hzT1JPcndZY2FVU0I1STBxZ0dtOUhjM3M1aXVLWUNuNHVp?=
 =?utf-8?B?SURHbk93TmdobUZIUHdvc2Z5Zi9IUS91K0M4ZnNQT3oxbVJQQWJuUEVENWg0?=
 =?utf-8?B?bi90cThjOTd1clRVdkZMWG53OHZwWFFRbkZEelJnOE55K2xMNGF3c0dSVFFz?=
 =?utf-8?B?UExxREo1RG1YL2xWY2Rud2NoME13OEVPNTJlSTVGV3hIdGdWMDZ6K3RqUGdX?=
 =?utf-8?B?Q3J0d09WZzZHRFBJUEFOcGx0cW5JMGx0V3g0a3doZUtYbkJERW00TExEdjFu?=
 =?utf-8?B?OXh1NG5YR3daZGIzeFBqeTljck5UTHB6Z2VUajYvQWtNVGpjMERxU0R5cjhw?=
 =?utf-8?B?dG1aSmRoSUlGeTNaT0JNN3E1cnljNlkrVHN5aWtHVW9KdXQzOERTSUI2eUpZ?=
 =?utf-8?B?UDd6ZDFzS0F6NHFocEMvUFFDWTM0RGpEVUpFY0toQUp1c1Z2SUtnZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a1614ed-890d-4936-bf52-08dedd83018c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 06:26:27.3748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ul99QGvBfxpviRJzH9l5AQmGQU7gPoGKsRzhjdYFcXibDj6isuNlseBGnv2JPHNBubed8HE4KbGMfr7pLiep7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3485
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 09 Jul 2026 06:26:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23554

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6697/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2026&month=7&day=9&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2026/07/cip.2026-07-02-12.00.log.html

* Action items
   - start blogpost draft [iwamatsu-san]
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB
   - status update AI-based backport review setup

Jan

[*]
Date the data is created: Thu Jul  9 06:25:07 AM UTC 2026
linux-4.4.y-cip: interval 30 day
  latest version release date: Thu Jun 11 08:34:12 AM UTC 2026
  limit date: Sat Jul 11 08:34:12 AM UTC 2026
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Mon May 25 11:40:18 AM UTC 2026
  limit date: Fri Jul 24 11:40:18 AM UTC 2026
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version release date: Mon Jun 29 09:22:22 AM UTC 2026
  limit date: Wed Jul 29 09:22:22 AM UTC 2026
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Tue May 12 11:56:37 AM UTC 2026
  limit date: Sat Jul 11 11:56:37 AM UTC 2026
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version release date: Tue Jun 16 12:38:40 PM UTC 2026
  limit date: Thu Jul 16 12:38:40 PM UTC 2026
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Mon May  4 10:49:51 AM UTC 2026
  limit date: Fri Jul  3 10:49:51 AM UTC 2026
  Status: *Late*
linux-6.1.y-cip: interval 30 day
  latest version release date: Tue Jun 16 08:11:47 AM UTC 2026
  limit date: Thu Jul 16 08:11:47 AM UTC 2026
  Status: On track
linux-6.1.y-cip-rt: interval 60 day
  latest version release date: Tue Jun 16 12:51:56 PM UTC 2026
  limit date: Sat Aug 15 12:51:56 PM UTC 2026
  Status: On track
linux-6.12.y-cip: interval 15 day
  latest version release date: Sun Jun 28 11:06:06 PM UTC 2026
  limit date: Mon Jul 13 11:06:06 PM UTC 2026
  Status: On track


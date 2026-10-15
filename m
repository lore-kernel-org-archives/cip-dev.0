Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78FDBCC6B34
	for <webhook@archiver.kernel.org>; Thu, 15 Oct 2026 07:08:51 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.35])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.34068.1792048128228032840
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Oct 2026 00:08:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=kLx0LHcX;
 spf=pass (domain: siemens.com, ip: 52.101.65.35, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b5wxW4s/cmAgLynr2AeTpyIByaOmlsqXpguNPWPjQjeGk29eLWTDsuObye0y7As1h8JxEx8QrIFkwPa+Q9301IsJuFyR4NNWJypDlNtA9pOgPHDqiNS287ZekqhDXohzv0Lqa/Od7OJOJNbc0JJjJ4Rr0OAzAEME/iVoCGllEai7Xb8/VftGjdDObskxSknv32XfJDuf9qdY3xCxaW4TpzbroljaofGBV+dyUdS1eEiqgq87jgG9E2hpGUxbULXbouhqxSfFdLRYqXBe64YEBshch9UyeoyOyUhau4DK1GsCIJVsjHcpgf+bBdS0RCXxIJlPfH7UoHC5AxVoLgMkqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AfK8Uk9aHE8U8NlpLNQfqFhAXtdW8gm7y56IAt4iQho=;
 b=GQYotB0lyl9EwwCTttlKzq3PqdlOkjFxB9wgmWx9S+8hrTj+ft2y9cCRTsfHNfPkIXxLhL3cB/eEYQp4lxow9DCsZpas9FuQ+GrzaRW+h3DegP/pM7stTdhQJhjzi/gpvHsTuX4/uw39Pb0RcjfTpz4T+ZFK6EHKF5/sX8Udd4jQ1dHWDrpYGnoYxqBKFMhrVlA06mTJFDaemtYD9Y3jmA93M/SmK7gEyzBP+0V/35n/ZwbottU7qbQcbrrimG74lxDo/XxKsu75napv2wc/2eToD+9aKbYmCrR6At0IOjwehJJpaKZR0RJLsoup4Wm72tUBLl0WlM8JZZLlb7tmKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AfK8Uk9aHE8U8NlpLNQfqFhAXtdW8gm7y56IAt4iQho=;
 b=kLx0LHcXRdn/y21IFSh2FMHImixI5y2mK8FwdkTa6kD6+2Ct+RuUsS85+Ty4x1E8uAJjFVu1pspW0x53/NqTWRtlXGlEcIFtll/yaGKiMvaMcBni4Wx9Ju//xFjsJ9aU10FvzYtZTxMjVYx/o4z8VKGfhNliFVpyax/uBRK76+bJBIwpN71+ySm8Q6vdmf9Ai1sR/3KBa8tS8dQKjVvCHLRLKwT9im+EvR44id+VsGw1ou+GN9F0QxAawzCxltY40/I7WeP1xmHedd+Yw050W9OHH0fOGFR5rCSxrsFgxv+nt22OaD7iO7TJkr7hr9eslCMw3r8m+4VWKydEeTNQsQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by DB4PR10MB7495.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:3cd::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 07:08:44 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0522.013; Thu, 15 Oct 2026
 07:08:42 +0000
Message-ID: <76b4f5f4-8e5f-49dd-b5fd-0c35f36a5740@siemens.com>
Date: Thu, 15 Oct 2026 09:08:41 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0065.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::11) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|DB4PR10MB7495:EE_
X-MS-Office365-Filtering-Correlation-Id: 2512d47c-b508-4ce6-6926-08df2a8b254d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|56012099006|11063799006|261009223027099003|18002099003|55112099003|10067099003;
X-Microsoft-Antispam-Message-Info: 
	rCB99595OymUfUP/hPrDZA8/OMs9PqDjYudBO/fVW82Dq6EJuhvGWyph+0kZyJB66dV+p7gdv2XEOWbqpTkTxjS+LDgbRkJmz7EE/1KvN3B1Ce/A+p2o9H2CBXKMOljQm8BV2roN7/gs169l80s02vjy/yHEJqPYiHQE2my/zQPEQmotixZFtsAJKZK7ojmPZ+JzOF3gw4w4i1aAdH/nmiNM1Wk0F/EPs1FNtkT/ihCVBxUrUG5OGM1I/sLLYgP5F5ulhPvG9Key5Uck/6CGhkM/tV5CWfVOfMG+vGBi8FXnUzYDQXHnSC58B3hGeZ7S3GP83ew4vBU/9znnFL921DiaCuqxeQEAEcqtarRvmDUzT+NlA7uXNnMQferdegVhz6gEKGuTWT4ciOs4pBLcPBK9V90EO+PPEkyzZiAF8rkkYJuaACOzeShIq44b0dx0JeMkxEfSlBIo17hwSxWtL0NMu45nvK1m646lakMNeX0mNzpdCvzYuisp4t0I2qTANZq7H9s/Vdx/Z/xdRQzVWgIZ0lGPagF9qJQMg5fqV5a0kbAp/Z6SyTGKLo9v2ioH0EtWtxUMwqUmXOJsE5r+AZ+oTsw8yADh15ttbwT6Hb8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(56012099006)(11063799006)(261009223027099003)(18002099003)(55112099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Mm82M3BmSkdQVFBqQkFxS0JhWmdFVnNXY3ZPZEVLaVM5NlJXL2orZFpKdkZL?=
 =?utf-8?B?T21hZ2xhUWRPckgxd3JtVjJ5WjNsNEJGRVZERWMrSzJabmlvcXI5Tk5VNUJB?=
 =?utf-8?B?Z2RuZkZycVVzRDNCMFVZMlpIVXV6ZU1zOG9TMlRBUFFzcFpGa1c3T2ZOZnV2?=
 =?utf-8?B?RTVTZE1Ma0RzbjRQU1hPdUtINlRxLy8zM2w1eUM4bm9zREk5UWhmZkdwT0NJ?=
 =?utf-8?B?M2NoUEJiMTRBb0N1V1F4aUJ3NzhqWkV2OFhiTnBKWk92Qi9yZHpjU0xqbXhv?=
 =?utf-8?B?bVo3WlFHOUxJd2pxc0Rhb0Z3ak1NWFNteE1WL2tYWDVVVDJLS283QUxpVUVp?=
 =?utf-8?B?Y0dDd0hyRWhaQ21FazFTTDZIU2xZKzhwVDBwelVoN3ZDVE5yRWRLdzA1bWN5?=
 =?utf-8?B?NjVGUG9Rd01kT1VucVdaL2RiRkc0Mk92VjZ5NHJXekJBTVYweWFaTHlxbkpL?=
 =?utf-8?B?MS9KTks2OVFGL3l2S0NndE1MSVZWVXM0MlZCb1BoaDVlWUdIMmkrVWltdVZ2?=
 =?utf-8?B?OFlPbjMzNkhHOHJJRTBGMmlqZG1tbEg4elRtOXdMUzd2TWhMMlF4TmVVS2Mw?=
 =?utf-8?B?cVVFUUZCMXVselN1RmphZUtzdjJvZWtFcDRNUlJvWDNNcWVVMVRiMEFJcFBN?=
 =?utf-8?B?KzNIc1IvZ0JzU0tOSHM5cHNlV2dTZ3RiWGRTSmNmOHhKZExaVVd0b1N5WHBh?=
 =?utf-8?B?T3hpNUhNMksxTzhJaThRVU1PQ3BhWEswbUtJNGxSZjZoZG10Zlc5cWQ1V1ZH?=
 =?utf-8?B?Y3RVN3AxYXN6M3FQc3BzeWk4OUM4K0czS2MzY2traHBsTitpa3UzV0xQSTk1?=
 =?utf-8?B?TEZWUGJ0VFNiT0lxVDJOQm5acVFwRy8za3hFb3ovWjZ4ZlFTMmNZQUQwVDdE?=
 =?utf-8?B?VmJFeWJKU2VPRWVINEJvKzg0Y0wvRy9NVTdWZzE1SVU2dzBOYzJXRVE0bHZJ?=
 =?utf-8?B?MTRSUHVnSFQ2Um5URURNUmszN3o0SHpTcXFyeStzaU13bE5xaVRQTUZpY1RU?=
 =?utf-8?B?R3BPNGFIdlNYL3ZZdEs0bVJpYlZtVnBiZzhtMGJVd21sYnkrWUZQdnNydlBm?=
 =?utf-8?B?Ky9yVTBlWjc4WVhsSUxNQnp6a0tWQURrT1RIT1FMNHlTbjNWdVNEMy9xTmpG?=
 =?utf-8?B?SUF4d2ZUNDMweThxMXhGTWRQU3RKUE1KVHg1Q2ZkMlRXQjFJaDE4aC85MGRM?=
 =?utf-8?B?WVdId051VHI3aXVlZ29mS0hJb2dkdVFUdlRpNEdHZVRaaGlZdi96NFFMNDg2?=
 =?utf-8?B?QUNCWWJpVGhpR1o5ckJuVjJ4UnlibmphSG5EbWl2Rm1PV2RUQU11bkpjY0lS?=
 =?utf-8?B?Q1VDU3UwVEUzS3pMdklJbmlGVEo0Y1M3cm5Ba2FlVjhYVEJuTXZ1UExSN3Ru?=
 =?utf-8?B?UkhIYVpDc25vU3U4a3NwakwxSllJa0JFNzlzYWxEU0htVWpQMWduditpVHh0?=
 =?utf-8?B?b2txSW5zdnFTQm1reS9LbVNzTWFzMmZjNnhJcWdiYlkvRDNRNmdzUytPc3cy?=
 =?utf-8?B?RCtkNW1PakRNa2szL2FhclcvZnJGdHR2SGJSZ2ZGelBuQ3pPN3NRNEthUDJO?=
 =?utf-8?B?bXZHWnFYL2ZlT0RONHZiUmpLb2NJd1ArY1BnUk5Ya2ViQXR1ZmJmVm1tMjBC?=
 =?utf-8?B?SE4yaGJycUtsbElvaFk2ZWhsZG94UktYRndJQ1RIajdZaVJFaUVDelVzdXln?=
 =?utf-8?B?ckN2a0R6WkJsMWVVQU1lTENDTGs2VWxhc3RMS0I5clpqNXo3TGk3cklHNkdq?=
 =?utf-8?B?MW96aERLOFlvN1NKQkRLQlJ4aHZEQ25TM0tmcXZ5d1JuUWZ0OFNHakVmSHpM?=
 =?utf-8?B?WCtRS0sxSnd6bWZYL0NLenRXM3lxK0g0Y0dCdjVzWmJzU3JLa2N2UTFzUU5o?=
 =?utf-8?B?aGJsSHJFdEdOUmhvb1ZoMi9ESHU3YXc1a0Q4NXQ3aVNQMStXU3dpWUh6VEsz?=
 =?utf-8?B?em53NWZtMVZjU2hIQXVZdnhRL2o1c01XU1A0WU1jSTdNUWZ4UHpUdWh4RHZB?=
 =?utf-8?B?WnRYdkgxV0dmbXdVS0o4T3Jub3JCSmpZbkh0VGRDeEt1L20wZGtGNDFYSmYy?=
 =?utf-8?B?UnhHb3BFMGthNklCMlEzQXpNMGIyNDZObW0xa0xCbUovSkNwOVYrR2k5dTc3?=
 =?utf-8?B?OXlsb2hFQ3FNdFNKRVR6QlVxWEVSV2dFRHRUM3RSeTNMU0NzK2p1dXRzcm8r?=
 =?utf-8?B?V0J0SWxYMDdZYnkrS1RKU2E0UWcrRXpsaWc1c0dwME1iYlhLMHIya2RLemJ1?=
 =?utf-8?B?ei92MVQrOU0vMS9JSW5pSXVURjNzSzVrR1pYaHQ4dUhkcm1tNTJ3NVVJN1hM?=
 =?utf-8?B?cDRiWk5vb1BEQnJlQmZrR0ZQeml5SWpSczdVbktSTndHeWF5dGNjZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2512d47c-b508-4ce6-6926-08df2a8b254d
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 07:08:42.5204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yWwS7AI6IM8YHLic8GpTyC4pETYip/fQaaR9NSPmSmkf5DmsnXN7xv9oh4I8NAWUiwnBLF9AGjsM7+f6LE6O7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB7495
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Oct 2026 07:08:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24471

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6697/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2026&month=10&day=15&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2026/10/cip.2026-10-01-12.00.log.html

* Action items
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB
  - /me absent next two weeks

Jan

[*]
Date the data is created: Thu Oct 15 07:08:28 AM UTC 2026
linux-4.4.y-cip: interval 30 day
  latest version: v4.4.302-cip115
  latest version release date: Mon Oct  5 10:29:52 AM UTC 2026
  limit date: Wed Nov  4 10:29:52 AM UTC 2026
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version: v4.4.302-cip115-rt63
  latest version release date: Mon Oct  5 07:16:38 PM UTC 2026
  limit date: Fri Dec  4 07:16:38 PM UTC 2026
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version: v4.19.325-cip136
  latest version release date: Fri Sep 11 08:53:07 AM UTC 2026
  limit date: Sun Oct 11 08:53:07 AM UTC 2026
  Status: *Late*
linux-4.19.y-cip-rt: interval 60 day
  latest version: v4.19.325-cip136-rt50
  latest version release date: Wed Sep 16 09:32:17 PM UTC 2026
  limit date: Sun Nov 15 09:32:17 PM UTC 2026
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version: v5.10.271-cip78
  latest version release date: Wed Oct 14 09:30:59 PM UTC 2026
  limit date: Fri Nov 13 09:30:59 PM UTC 2026
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version: v5.10.268-cip77-rt34
  latest version release date: Thu Sep 17 09:59:47 AM UTC 2026
  limit date: Mon Nov 16 09:59:47 AM UTC 2026
  Status: On track
linux-6.1.y-cip: interval 30 day
  latest version: v6.1.189-cip61
  latest version release date: Wed Oct 14 07:07:26 AM UTC 2026
  limit date: Fri Nov 13 07:07:26 AM UTC 2026
  Status: On track
linux-6.1.y-cip-rt: interval 60 day
  latest version: v6.1.182-cip59-rt31
  latest version release date: Wed Aug 19 06:16:01 PM UTC 2026
  limit date: Sun Oct 18 06:16:01 PM UTC 2026
  Status: On track
linux-6.12.y-cip: interval 15 day
  latest version: v6.12.111-cip32
  latest version release date: Mon Sep 28 09:54:38 PM UTC 2026
  limit date: Tue Oct 13 09:54:38 PM UTC 2026
  Status: *Late*


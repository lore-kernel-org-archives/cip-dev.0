Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC33CD6E4A
	for <webhook@archiver.kernel.org>; Thu,  4 Jun 2026 06:07:25 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5189.1780553235779430926
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Jun 2026 23:07:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=j/I/qFaJ;
 spf=pass (domain: siemens.com, ip: 40.107.130.46, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uSR1YCPS90oo1E5LeXgk7YM2zG04VKQkjbZbN6PsZQny6oYNahEYxjxS49I/cNhYjAadaSdFzIXcWe3mTXIk3qR/j0aXuWanaBFZAhHcgrzgydAj+YAIle434zZ0roE0PmqUvuThzjJFRFVWi39VfRxUZi6SCnbDBUyD7wi1ldRm9CpwI3v299Sc9B/jaYP1kXjH8naSvPfzUbMPIzl7Pd7zwyAz3v581EPFEGKBj1sSeIjNwpjwmXZ7PnUD7aiU+QMSOpAQnoGdPYMXwBGPv6gbmmmU0bHJzaMURgV7+L4H6NirHdhspgmBysZ/b2v3K/4gGelWsUJtsFcfRINzHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dLkW+8Ock9KYQIXwwhLn/4n5moWE+H5gGyJVdTFd3YI=;
 b=jvnaSt4gj3vGGC3BjaPa9K3shog+xVGWLAQujryJObFDkx79vcxadLKIFTbcGi8InKYgNP7fN5q4S/z/UQqkq4KpPWLnb2mEzMxSTtOdLXq4wfWMUwiOgfn8DlYZPkp7TiL/qWB2oDeQpF5eB+gMqoE454CAhTH6NIQ7GX5lvFVuSqliz6ENO2AFA1LgaIrELoyCbnVk8b2j0sv7H+c3DDZvqFImHsBQIOWw1oLfEU/2T/KaakqgEiNBZsYU7f/bUjpiCUEtCYioKW8nLP1ulzVRWDCYaReNKrfjPgEzQSIWqIPhPH7zxWFxyCGa8friITjyK4FI3UGrVS32ZTyGyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dLkW+8Ock9KYQIXwwhLn/4n5moWE+H5gGyJVdTFd3YI=;
 b=j/I/qFaJaIz2jfMkDJWZ92HaRzcHaJuKdh43We6Mq8+jTN2fGRPEECzOFHA5xVoyfZ70lOAdMuvVET94J63hwemYdYEOpbr4dXogbo2NXUgc6+NNNNdUXQhme+OqjELuTABOOokwaPHauX6SVkYlZMWtCTVyJpEIhgrHSX5KiuTLbft/0Knbcsqyx2zi9SLkUmJGV2OZGX9kWcXsBK3UmlJdCfeNXllZ+S+56X9ju8VhVpWYhWQOhyGso78g+7GvbYPe7c5ZXCZTog0wbTyFseuldJm4nYrOZ/YqGQUYywk5mtvTFt5Bq9/rB6YP7xBiw/tGuR5dHWua5KT1KUP8rg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB5911.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 06:07:09 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 06:07:09 +0000
Message-ID: <a81cb153-e5fd-4eec-ab43-6fcf8d9f47f3@siemens.com>
Date: Thu, 4 Jun 2026 08:07:08 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0248.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB5911:EE_
X-MS-Office365-Filtering-Correlation-Id: 64f58833-70e1-4161-1c6b-08dec1ff8318
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|55112099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	CPwHQPBC9Cg6raKTcXXhWPxCa5ktrd2WspdYEsz+3ZSBi7pWlriNvF0/Ev0IyvTdb0mq7JSuhAi4SpwGoLWYhHoryyCAfd8mCPigrQkE0vYWGM9AeVBhfSqNaqHMIxCbbDdmLoZ896as9a4xR74rUfYduFvxmUz77KPne/m1Cemby1/jHJWpGOIfP5xEHgY4VQecBBUVX/yfMYL3SDIj3rLMEvzcsgEvzo1NSnnaLjwBdIzYA79oH90T9KbPrgvh470wuo3iiWOuFSiGvk7C6YoztGFQDLDvsxOZqwM8PUTHnHiANPLQMR4jiaCTJFg44WyfwKv/TmfF3LDe42eoHcln+iWpJShVQ42upcTw2aO/M4+rYnlEGEKifRbamrPspaXcGdI5g9fVVp6/hXLS4wJste9Zx0hKZDpt1+MyS/1c3dDePaIkOPebTrg+S70DzUNNqdNt+tbRzINESGzinnsbNy0D1v40CeVkakYevWpas8JQQJHnIMUofUESYJIzkUa4PrG0ZnNpgZlOdhxSWN6riu6fjTzhoS0y+R49UtZHGnMVScPdj8DVGTBa3tnpRU4HoYgyF41+IRRkfi/IyDfJcicJ+keRc3D6W8kZjf3lGAlWUWGYJIIJ6aorwjV+9BMFPaacBXxKyXkMOkkXLg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(55112099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Q2diVnJJYTNFT0NDam0wZzAwZGoyOGxDdTZSMjJoR0hnVUZUY0Y1N3hmQnlm?=
 =?utf-8?B?WTlwN01BKzFWSStGUG4zdmgzd1NTblVWRjYzS3dUTXQySFdVVlg5cUZrK0pt?=
 =?utf-8?B?QThtU3VGL2pZSnBTWDVnVFFFOXRDQmpsc0g5bWpvcVJoK0dvNVhCd2c5L3Zv?=
 =?utf-8?B?dzM1cjlDWTlmMWt1WVM2YU5xT3FwUlNic0tneEY2OVgxZmxyMnJEUjZZTnpy?=
 =?utf-8?B?S3NUcHhjRWErZGVvdDZVZW0wcUlLTlVDM29jVW50cXVhZTRqbnZhd3B0ekZO?=
 =?utf-8?B?ckJNMkluMTdSSWVobmlCMWpJbWY0Vkx5NWxFd2Qrd3ZLK1h1cHpPQXJoNWZu?=
 =?utf-8?B?M25ZQlF4Nm9yQ0NKWHFKUkpnR3pUNGRsVXl2MnFvOENQaVpwd2k0UjZBdU9I?=
 =?utf-8?B?dFF3SGFBTUw3dm9telBzWCtvK3JBUG1mTTl1WFlnbitwODNkY2tqQjFrY3Bq?=
 =?utf-8?B?S0t1eUwzQ1FBSHI5L0Z2UWpZNWRzUnloemVhdEJNRmNmTW9MbkxwdTJrTVRm?=
 =?utf-8?B?ZG84UzMzWTdlbm5KajRLcGhwQ1U1VUZpeXMvOCs3TG1WODhESHg4SEY5NkRt?=
 =?utf-8?B?L2JrZmtpR3lNeG85NGhGWXN2NjB4b2VlMmpQVnpPYWQyV013ajVVcU1oNTY3?=
 =?utf-8?B?SnFTQkNRQWQyNVpYdUtZanRPSkUrRHZWRFRieXJZR2o3YzJxMWk3Z2xHSWdi?=
 =?utf-8?B?cFErWnJpV0xwNmNJRzVkU3grSDhkQ25PSDJyTUtpUEtrd01DSzhteTVNdFJu?=
 =?utf-8?B?VDhsSlBVTnhlTWtTUm45d0Zzc3JXRHpLbVhRSzVzVGxwN0ZaLzQ4ZGdIcmY1?=
 =?utf-8?B?clNxUlRJT0lmZTBlalJsN00wVk1adW1Cc25iUGtoOU9nSlpIZGJRV0szclNZ?=
 =?utf-8?B?VEljRlJ0RUI1M01tNDM4M2t0d3RveDB0MERxRzUrSG5VU3NCWnkySEFKeDRZ?=
 =?utf-8?B?OFd4QytxZzZWWnFGSVVVdmlHZHFRYXNReVlDVWpHR293M25UY1Y2YmthOSt1?=
 =?utf-8?B?aUFsdmxCTUo0MTZYMStIWWY3SGw4Zmd5d0s1Nm1TNEdTZEx6SFdERXA0RWtH?=
 =?utf-8?B?M1NSb200VDF4WjVWKzc4bkpPUWZuWUk0OExQMUdLZ1hsMnFWMUNWTDdwdkE2?=
 =?utf-8?B?dGNUNnU2Q1RXNFNZS0NGT1dzLzJodTdRazBVdVZUVlFVZVlSb0x4MGtLNkFZ?=
 =?utf-8?B?UEhhajRURFNYR285MzNPL0NyV2lHQXhYeFFNN3lQQzR5K3c3VXV3MGQwL2dB?=
 =?utf-8?B?OHllaU50RnQ2WkJ0d2lEMUVWVWZ1MkRIakxUSFAwUTRaY3YzWjdtUzZySUhL?=
 =?utf-8?B?VFJnTDF1R3ZvVFVnOVprTE5PSlpRcFRKTit4dE53bTlHYm1IUWdBcjI1OFdQ?=
 =?utf-8?B?bTdRdVM2K0o2dHFPVERVWm5DUlRkMEhzU2xHTFc2STNBTzlMTnVzWkptNnUv?=
 =?utf-8?B?cjYvRkpkS2xLeHJqYnZsR0xGT3NHb2hFdms3T1dpRW9UREt0cExnbHNaSjAr?=
 =?utf-8?B?OHd0R045dEpjRkI2c0dGWnBkY3U2YVF0OENPUUM3MlAxeVNwbitHMFh4Tzcy?=
 =?utf-8?B?UlI2NDQ5dEpRc3RlWEhYU3NtbmU1WjQxc05qbVVHVy9rZnh1enUxVmdLMHRN?=
 =?utf-8?B?NmtjbiswUUhITGJHUVNzMzUvWi9JWE5DcFF5dkxJTVJDODFzYWs2UTFNd3JF?=
 =?utf-8?B?SGl0MnVMblZyYldUMEl4OXVJSVMzZXRpQWpkdXplRTV4ZGlYLzA3V1NhVkxS?=
 =?utf-8?B?QVdWUlRZR1FzcG9kM2pLNFNibTArY3cxdjVjSS9tMUIyVzQvMjBQcTJ4TWJm?=
 =?utf-8?B?M25KanlBNTBhRkwrMEJFMEpWYTFSTE4zWXNmSVJkWXlDQUxTUEs0Uzdiek5u?=
 =?utf-8?B?QjBFTVVoS3VZbVIvOE0zTnVvMnNaNnVoZVl0WG9CN2NhZVZxRmEzMCt6UERw?=
 =?utf-8?B?TGdMQ3hkQlAwSFFDZjBRLy9hU2NCVjQ4WlhDWGlEaUFjUmc5a0ZId2tpbWN4?=
 =?utf-8?B?eEtlMm03NExjdDVWSHI3TnpGd0hwWW9LRnh1cjNXM1U3eTM2ZnlWaDc5aCs4?=
 =?utf-8?B?bUZFRlFXYjZmckE0bmEyMmFqa3lMMnFEYWwvWUp4MmcwdjdpYVg0V0g3VG1X?=
 =?utf-8?B?akVRS0dOMkR1YzYzaHNFUktSUEp3QW1MbDV0Nm5WdElENW5wYUxMREVOSG96?=
 =?utf-8?B?YmV4ZDc4NUtZVmlnVHNGNHhrWmRiZGVVZWRYZUh2Y255OUlpYm5JcXBacmlV?=
 =?utf-8?B?NzRHMDNtQ0NtVTBCd3JIMkozQ3BBTHlMM1F4WitVTFVsemx3WXJkYlBGc1o0?=
 =?utf-8?B?dGw3djhDc0tseUsxUUtDb3Qra3F1QzhZV25BZ0p1ZFZnRWFmQ0VNZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64f58833-70e1-4161-1c6b-08dec1ff8318
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 06:07:09.5492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JXg9iMvO3LH+EyEEO8EWSEtEpnZUun9dNnqRuLz0o5m4ans8HYWrjbz88Jk+WLRrIKQlQVaWC6l5baN0fCIvOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB5911
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Jun 2026 06:07:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23042

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6697/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2026&month=6&day=4&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2026/05/cip.2026-05-28-12.01.log.html

* Action items
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB
   - AI-assisted backport reviews, state & approaches

Jan

[*]
Date the data is created: Thu Jun  4 06:03:45 AM UTC 2026
linux-4.4.y-cip: interval 30 day
  latest version release date: Tue May 19 02:53:20 PM UTC 2026
  limit date: Thu Jun 18 02:53:20 PM UTC 2026
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Mon May 25 11:40:18 AM UTC 2026
  limit date: Fri Jul 24 11:40:18 AM UTC 2026
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version release date: Thu May 28 07:36:48 AM UTC 2026
  limit date: Sat Jun 27 07:36:48 AM UTC 2026
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Tue May 12 11:56:37 AM UTC 2026
  limit date: Sat Jul 11 11:56:37 AM UTC 2026
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version release date: Fri May 15 10:25:33 PM UTC 2026
  limit date: Sun Jun 14 10:25:33 PM UTC 2026
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Mon May  4 10:49:51 AM UTC 2026
  limit date: Fri Jul  3 10:49:51 AM UTC 2026
  Status: On track
linux-6.1.y-cip: interval 30 day
  latest version release date: Fri May 15 10:28:23 PM UTC 2026
  limit date: Sun Jun 14 10:28:23 PM UTC 2026
  Status: On track
linux-6.1.y-cip-rt: interval 60 day
  latest version release date: Mon Apr 13 11:43:31 AM UTC 2026
  limit date: Fri Jun 12 11:43:31 AM UTC 2026
  Status: On track
linux-6.12.y-cip: interval 15 day
  latest version release date: Thu May 21 11:47:46 PM UTC 2026
  limit date: Fri Jun  5 11:47:46 PM UTC 2026
  Status: On track


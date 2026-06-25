Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3578CDB47F
	for <webhook@archiver.kernel.org>; Thu, 25 Jun 2026 05:46:54 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.62])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5247.1782366410859976516
 for <cip-dev@lists.cip-project.org>;
 Wed, 24 Jun 2026 22:46:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=cPulmMTs;
 spf=pass (domain: siemens.com, ip: 40.107.162.62, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zg9A0jsdE24tWrow6fxQ1192FxBLmXNmVUq1yWoa0S7o2alHMiM3TkbuxTpB3PIQXqI7cTIo0Ipp0YBomZGbS+uvdkFtPlrqbzhYk7cPYvRoN+gVGGOPvKhMWJ3zibjD2ra9Sst0Mun7nTmMZ9LpFUc8LmOsxuu4kkxOuSWAtw8eGppmtyNLSUhxCZHPZbWpgsnNbewJ4Oeqpx23gsPJKe9iRDxvYUBegDkV3iB3IinRxUftPMAYoq4YnmGkrNg9RGR+tayubISz2TIqQB+uYWai6KvSE4vOjzbR0OLr+PzvWNTLG2qD6CiZ8MTEC/Yt5BDhl8+NXvyyaBr5T5S5/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ti6W74y4MN71owybECAzteaS5b1fe78UTXD00ShC2Jk=;
 b=o/jLi9JWoFgJN3OovBhJQkN/EWW4tIRyCOtH7p+EXO+bMJvcPgTRUgYilQh2VtZdgoTXJj1j1V4g0Gv/PBlKHeXlGSRE0pZEqODf+qhvywvjV4Oj/yV2riJ/t/FHZXMMMOnGTuE4lNF9p2cFw+o+4gMbIy7o7gQ+D841tLn9BjwVIzltX8JDDIh+HjBR7kSAUvjw8Up1dZP52JwAbabwCODEYFbO5+9YKfSEOqM8iAzTIZfkwQ6rxfLyLfeU/3erF/OfgW0Pg1uOivg8gZAUa58kYJs8Q6gsb3qMbG9AR+/W0l/BCIZHRSjLaZj4x7MJKoAB9QmvTOVOh+YwpTYuCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ti6W74y4MN71owybECAzteaS5b1fe78UTXD00ShC2Jk=;
 b=cPulmMTsLHOKyKzkQEhJyelgO93RJ+k72+c6sLQdNmccyN0rRcQzUEuiCF4K2t5O9ZThgz8JPEVkBgkGkbECHIPc7oFoFkEXgmCKma+2ToUJkkDX56IroGKKQLYrNp/Vyxrag2ei83uA3qMfqXNAeKYawn8mIiQNeq5ILOmS3Y+qgjcHDXSscycPizuQawxrDkxKrK7qgRA91wFtz50haTRRqMlpMUtVsDyPEr4efO7KVjDoG99gK6BBGvi1kPG5cQcQNuNEQuIX3yaJGNRii56CfOr7okxSaVDaPCVZzjaCevNjUqAL146j9IgPteoOqc68IutubBJThl6s2U0pkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB7782.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1be::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Thu, 25 Jun
 2026 05:46:46 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0159.015; Thu, 25 Jun 2026
 05:46:46 +0000
Message-ID: <e4998e17-d3d3-49e0-9ab0-9c35d12342ab@siemens.com>
Date: Thu, 25 Jun 2026 07:46:45 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0107.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB7782:EE_
X-MS-Office365-Filtering-Correlation-Id: e8d0819b-0c60-4818-96d8-08ded27d246a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|55112099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: 
	/FBP5lnogATroQklaBTBCRLN8WItq9rQwHTjPpWl1xfLT2rx9FLr09xXmwG3zvm+y6ARrjB0tRP81DLWcePMUmeRTcBReZlEZ+vLKtl6Xwy1ZodIUpHa23MfyGyzE/jLhzqXnXGDtgE4XJZqEXMF+4XA490rSEj4TvucI1at44gp4CJNjZFXwSAELH5nZ2Q53gAryqJcskZNUS+ehK9lGG8OPmIZibcyIp8Zj2uBzEHRkieLFCdAU0PeOUiqH1HCMlBLvU2Y3W6fT7nqXvR0T7Y1BAR8dqfUV8ANPmZ8bMkbDznk7nqwGgnFTDYOib+bhswZYkQSmYZOyFTRVorc4EUtK4TMiGgn0WB782f8qCq1Vkvwmf9//DxuefeKHxxBqoKFq9Z5hazfR5sK0MOtBrDgPp0BbAKd9N4xFftSn5nrItJKE/8Sa6cvRBld9F9isIMH8/cADd26Er6h94lAfAfyJkD2WTuZbXPAqDfXkKHGgmjHSuotaZCQj6NZYVSrBAtXiDriDeIbfr7edU6pPK1E7/clfYwGSbhbIaampTZE/JC31ibxyf9pv/VsM0+P6KqFSi76wJEflPw6JMWVNRtcPzIg4zT9xpWYLl1pyKWqURcQDMvfwm9qLmw7QInZ
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(55112099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TnpKTUZjL240OElKdU9PNGlLd1lFcEhjTWhiRWVTUEdoWjAyeWtzbTQ1ekh0?=
 =?utf-8?B?ZXp0dDlWdm4wR0hUUHpBelppdDUvY3ZyK01mVVlBN2RLbU45Nzd1ZDhvd1JI?=
 =?utf-8?B?ZW9EOHp5MGo2L2lQMlg3andHRFpGbWJvb0ZSOXQ0TU9QM0dmUlVUdi8ydjdE?=
 =?utf-8?B?RHVBUVRQa3VHeVFlenlOUzBwRTQ5QTBxaGxJdDF6YzkzNGxsVGhqSFVUWlJL?=
 =?utf-8?B?WDNzNkZIMFYyUWZwWUxteWJZSzZEN2JVd3pNUUd2YVlBdndvU3gyeVNMdCt1?=
 =?utf-8?B?Z1dEOEJyYXYyZ05IajBBV0hVUEVKQ2pxbmZUenlNaHVFQlh2RlVMck9OK250?=
 =?utf-8?B?eGtOOS8xNjRZbFcxVFQ1ZENSVVljZm1OOTFZdytVRkRFYjJYSmRucG5QNWIr?=
 =?utf-8?B?MkVxbGRIZi9RNGVua3UxWm1tTjVNai8yMGswUlZsRkMzMCs1alV4bnRkQXph?=
 =?utf-8?B?aEliOWFqZW45b2FxQnFrRHhWK3VJVVIvSUZxTUZtd0JlU2NJU3dEbEM5eEo5?=
 =?utf-8?B?VjhaZE1vN2hVSGU1Z1lRYUwrYXJKZG1yMnZjVmk0R0REMEpYT0pYdjFUVHdB?=
 =?utf-8?B?Z2ltV0xRM0YwZzlneFR1bGc3Y3hFYkZLaVBJT2M2L3kwNTZxcjRtNlQ5cWZF?=
 =?utf-8?B?NVdkUTBLTFVRcTJwaTBWL1ZNWFZCaytwZ0ltZCtmRXJuUUtBaFk4SmFrbVNZ?=
 =?utf-8?B?dTZoQmRGZWFUWVdKTWZ5T252UnJ4M3FZZ2NOcXMydlhFVllwK0Y1VldKc2xH?=
 =?utf-8?B?UnlHT3FLeTVZeFdXUGdBNUI5TDlOb0ZNc00zSWIxN3dGakQ4QlVDeWpqanlU?=
 =?utf-8?B?dGUyUjAxUDJDcmJQRll1eFVUVWxkRVc2b3lHNi9WVU9vWUZUMmhXcWVqMUYv?=
 =?utf-8?B?Vnd3WERTb3RMQWh4ekJmZ1psT2Zud1BLR0IxRklra1RFWkRPM1FyOUp1VTd3?=
 =?utf-8?B?cXlGNzZFcHdjTGc5N1BIMmt4Qnk0bHdFd3RvM1hIOTFqWGpMMzd2RGNMSS91?=
 =?utf-8?B?SW95ZEtLY205T3A2RmZqcVVCNWVtWUhyMWVUSUdTZ1R0T0QvYmUrQmF6ZWds?=
 =?utf-8?B?TTJrMGJqbFZSZ3hJUWhJczl1ejBHL2k5VmpBWFhDUXJpT1RzeTQzcUpmODdT?=
 =?utf-8?B?akF3T2gyREZsWjhRejlEUEJjK3ZzdkZITDVkb2ZETnV3RFdhNmowdFJQNnIr?=
 =?utf-8?B?ZFU1UlNLQWdnZHBnTGxmdDNZUVNuaHV2c1EwSFhzaVRZb3ZHREg3T2hjTTI1?=
 =?utf-8?B?byt0enZwRnVIcXhwKzZiK2RtWlZqUUR2TTc5dmFKY0M4bHZrSVorSElka0xs?=
 =?utf-8?B?Z1dXOW5HNktoa2V3QmxzUzZ1QU5HUGFQMVNlejNTMnFyL3FpNzFUYktFdjls?=
 =?utf-8?B?Yk0waFdETS9CaStCQ1pjS3NmU0srY1NGUS9xaVA4U2hJcFdBTk4xYTk4VWE0?=
 =?utf-8?B?S214UDNKNkxUclFyNXJ1d0djMnFqS1V6a1NQQWhWeU1lVnVsN2wxWGpOUC9o?=
 =?utf-8?B?Nk8xYmRla3NTTVh0dmFUWU9NU1BlMEtTeWhnQzBraE9LeTVaeUh0NkVGTDlF?=
 =?utf-8?B?ODBYYVpaV1U3VlNST0lVbVNJakl1TUV0T0pDVWZsaXlKVjZSWEZuamtXcnhJ?=
 =?utf-8?B?QzBVUjhGaWwwanBxNFBtYmsyTjI3d3I3cnkzWG8rbTV5b3NWd0NpNmhrM3ZP?=
 =?utf-8?B?WFExQnpPTVdZcjBJb2tYUFY0eGpCcUQyMlNmSm9DbHFBclBKSzQrT2gyMnRr?=
 =?utf-8?B?RGxKRkVhendacTIzVytmYnpiTmI2eTRpdS96dHpjT1laREtCQVN6K28zTWNG?=
 =?utf-8?B?b0p2d0hBSDlrZlU5MkZwbWlkQkNpc2oyS25uU0JjaHNJeXdrV0x2bll4TGFk?=
 =?utf-8?B?VXRXeW5LaWJjOXo1Qmx1c3UxM0pIWVdMck1ueHdTa1ljQWlOcU5RNWJPM1A3?=
 =?utf-8?B?b3pYTHVLTUxXUGtST0N0SG8yUHNpbndzRVlVc2lRWlBCdDJBaFo0WnVOMEFT?=
 =?utf-8?B?R0VnaERnMkpVM0pPS3d0cHhFTlJVTi9yNEZxckdBRms4YWdjb1hGaHE1MS93?=
 =?utf-8?B?bFl1Q2lJd0E1VFkxa2RySTVnMWdnNmhaVFJlNysvSXRlVExweERXTWdUVmZN?=
 =?utf-8?B?YjkwU1h5UGR3VUZDblJYK1BHdmN5Y003Z21CZ0hTK2NrNjJyMXprQm5BdGJF?=
 =?utf-8?B?aFF1ZVhiMnkxTS91bjFiYkRwMDRWU210OTNZcW9CMThSSEliUXJ0dXh4VW94?=
 =?utf-8?B?aFZPOFJOT3VKWVlUdVA1bVk5all3eU8rMlViUGtCdWtZQytIS00wbjAyRHdq?=
 =?utf-8?B?aEVVR2tXa0tZVkVhTVN6RnFYTk56UnROMW1ORzN3TjRVUVJnZzRDUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8d0819b-0c60-4818-96d8-08ded27d246a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 05:46:45.9751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MpLCP0e7stFpKgfxhPV7jOb7XINnsl3zGn8P7WEuXf/dWqy8+HmDoqdc9DG1wFf4kqROyChLjY7HXsMQAz+taw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7782
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 25 Jun 2026 05:46:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23278

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6697/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2026&month=6&day=25&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2026/06/cip.2026-06-18-12.01.log.html

* Action items
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB
   - status AI extra budget
   - Codex Security & kernel topics

Jan

[*]
Date the data is created: Thu Jun 25 05:44:21 AM UTC 2026
linux-4.4.y-cip: interval 30 day
  latest version release date: Thu Jun 11 08:34:12 AM UTC 2026
  limit date: Sat Jul 11 08:34:12 AM UTC 2026
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
  latest version release date: Tue Jun 16 12:38:40 PM UTC 2026
  limit date: Thu Jul 16 12:38:40 PM UTC 2026
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Mon May  4 10:49:51 AM UTC 2026
  limit date: Fri Jul  3 10:49:51 AM UTC 2026
  Status: On track
linux-6.1.y-cip: interval 30 day
  latest version release date: Tue Jun 16 08:11:47 AM UTC 2026
  limit date: Thu Jul 16 08:11:47 AM UTC 2026
  Status: On track
linux-6.1.y-cip-rt: interval 60 day
  latest version release date: Tue Jun 16 12:51:56 PM UTC 2026
  limit date: Sat Aug 15 12:51:56 PM UTC 2026
  Status: On track
linux-6.12.y-cip: interval 15 day
  latest version release date: Tue Jun  9 12:04:00 AM UTC 2026
  limit date: Wed Jun 24 12:04:00 AM UTC 2026
  Status: *Late*


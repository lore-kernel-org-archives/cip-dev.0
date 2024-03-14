Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C64C54E5D
	for <webhook@archiver.kernel.org>; Thu, 14 Mar 2024 07:21:34 +0000 (UTC)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (EUR01-DB5-obe.outbound.protection.outlook.com [40.107.15.73])
 by mx.groups.io with SMTP id smtpd.web10.6716.1710400886586918405
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 Mar 2024 00:21:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=R9ZL+Gl/;
 spf=pass (domain: siemens.com, ip: 40.107.15.73, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LUfpCinHCyE/4FrnWBpAI9wyZUvtytbsvidMgh6giAKfxDdT8/gOKTrXtmpAMu3NIK1EwlvM+Sa4YxyESSlF/BMgEFsDZiNfm4csKVYT265Xbn6lR6z1YPdnSehlvFmKwHm8Hiv2qxbk4hQG/mLfUB9xD6vQtG4bLkFvosdHSpgWWddr4V6tBdOBhVZLvbyFWM3yPbgMJHI0vteQ44l9d52KMzwbQMSqWx4R5Qp8WKmBz1ObWmgpkKx1T5HO/URJ0MPY5NI9SBkqrQRU1sNVlBzQG5DP3pmVVLMV66ltS/p/sJLnEACCUkf4GPBZaNso8fBt1ehWCetwZVhNXKI8lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z9mtAM90RG0jSdXQTcylKU8xVDFAbvCM4Ti1Z6AFI4E=;
 b=hJdubfVaHh3fhBp0QubY+2OOxiCeIMox1MTvoXtTbaN9eFv0WXkcd0DwnAdxTOERq4/Qso6hoT/Y4VCWPWnLedo4Jd2QO6FJJ6Wxyo6gkhSNW0xtN5G0AZzUs74Y/8bcc1P2i3RSYpcGBxiJkG1VNWkoEscRIdGIj8gGp9mumUqnq1pPgyIStnsruT5EkK/YGlDIBwe9TqTt932WgF1LFmwsoxqI2U18imNaiC8bW41fd+Cf+jGfqn5hJuZH+CCoilYhVPXDjjZb4cMbmDJ36Llq7JgDhHnV0GaoMgs69BbBRukv1HPDsWBMmHvM50ZY/u/h819RTBnOtan/uH20hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z9mtAM90RG0jSdXQTcylKU8xVDFAbvCM4Ti1Z6AFI4E=;
 b=R9ZL+Gl/fkf3j87m4b5HCGsfe/01sim/E0BZYDWl1MBs24eylLvNuGaFKlLohLOTBxlpZkwvgkr2x66NzJu+uIZ+n/3uDvXj3pUGqrf0eYcAJ7UZ2eHURIW08BzCRP1zCVXsuF9+c3Y7YHPwyN0eCv7NW9GWVpnRGJnp6n4MUY7aAAD2TCja25hxLGU7BkykCmHZZbuGfQ9bEsYRPLTYJ3x3fs9jVRGbMmVJXST9O+N4UsOjd6IM1Sm4poKIMKQH2MMp35zcwAi7mmLxTkcaDwd6Krl3k+l09k19xTzu6GQe3apD2u7oPY7kKF0hu4G9L7wQX1NIGnuvplfCOHR5kA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB6641.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3d3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.21; Thu, 14 Mar
 2024 07:21:13 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9%4]) with mapi id 15.20.7386.020; Thu, 14 Mar 2024
 07:21:13 +0000
Message-ID: <3aeb685a-1b36-428b-9258-c46b66817adb@siemens.com>
Date: Thu, 14 Mar 2024 08:21:11 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0336.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB6641:EE_
X-MS-Office365-Filtering-Correlation-Id: fe71ae1b-6819-4ac3-b753-08dc43f75479
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	W1W1uN/FfX9Ro3D/D+Mz030YtfN1usz0NYP6oMa6Yo+y8nnrOTMqkVeDDnsrZ7QrGGF4Cx+g0bhyzylC5PIYpiP/y+l3Z4+ec0GuxG24Rka2RoBQ1l7qtXAAYnn2Lyez0ZwoSqRDwHMW0r4IKpQ2oOR2PlLwA0jugyo1UfOzXsXAK6eBezYXdJJeSlOVjzBXq519ZS7dIgOLwyXWnv83+WeDOVTJ+iNG/tkZ073hKw+GVJ5KEyv3u7xtgN1J3AqPR1rAocNjZqLrXh42bVTw5RlpzA1ERjCoGafrp5Rx3pSYXiqInLiyCjp8Vnb4SLwl7EwjMWtEshoC04O/d58hRSIyqeSxiWU0fEo83wll74r03xAV35A6Mu5AK123tDq5DjuQ7fDiN9+Ydh+8S28Y0/1NxJYa15OxR0eD1YyaixPA6a6EPl/jOWytXqL+/iSMxRLU0XufFG/VTRhsdy+sU9h9FcHfIYSBP5Y2EtlUDooPcLHuAcDjOaUgXuE4FBv8rblFxNTEMqtYV7vGk+RccfZzWjcLSWxXejQHBhnS9TViS2K/0i0y14SmnSMdExDLIlHF3I8j01sQ6Z2eWRTcB0QyQZ4pzNdEV1zcuhnKcLI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dStMMzkrdTh2U3FsdSs1UWhMNjBPanhoblhFL1BuTmJ1bXFUOHpKbXZTU0J5?=
 =?utf-8?B?LzRBRFgwK2xjNXZISUNvblgyNzlMMzRONEdBdlcrTjFuWkVGQjU3bnZOc0dX?=
 =?utf-8?B?SGdDeWw1UVpBWEFlN09nd2dRZys2UXB1ZEhhVVFJeVFKeWVVejEyc3kwZ1BG?=
 =?utf-8?B?WW1lSXAwQkJYM25RRWRsWVBNbjRXREdVaXhlWC90cjlTNmJ4akZDSDkxVS81?=
 =?utf-8?B?WVRwc1V3Zjh2WTBBS2psNldhQ21QSGExUWFQTTlyR2srcDdIMFNVbnBXaG1Z?=
 =?utf-8?B?V2lLNXBHS3lFYjJyY0Fsd3g5UmhseDVVQlNNSzN1ekE3UmFabllBVXdjQXA0?=
 =?utf-8?B?Zkt4SkxlN2o3Ti9NVHR6NUc2ekt5akNPVjkvb3ZlcFVGV2tEMHdkOFpTb05L?=
 =?utf-8?B?YlhtY01oZEFzM04zWEdObkliTE5CRTIzdUh5NWEyTDBkblM1UmhNdkF2Tmty?=
 =?utf-8?B?VnpKWk9DaE9NWWJoVjFzaTRrbENYQVk0U3hIbUJ1Uzh6MGtkS3FSZWVKYm5U?=
 =?utf-8?B?Y2xYdXU1eGxwMkZHNUwzWWxhNytDaG9uZE5tU2FPVHFSVjBnV3BZcE9tYmcr?=
 =?utf-8?B?bU5PL2QxbVU4TVFSdFk4YTlaKzJNKzdoNTlFMERscGJta1Y1eU13MTJKak5q?=
 =?utf-8?B?Sk5LZ3JlT1Y1K0MwMlZRT2kwZjcvakQyU09rdnMzejZleTZySlUyVGtneWZa?=
 =?utf-8?B?NEQ1MGJWeFNhUWsyOEw2QWVZRG4rYXV4aWdlU2hrVUhyZzR4eXFnZ0tpWFBs?=
 =?utf-8?B?RjYzN21MNmZ0VHJuQVpJdFpEU0pGQXBUcDZiYisxdkpKL1htcTJSNXRBTm5I?=
 =?utf-8?B?aUhuUmo5cFZpZjJoN0ttWDhxc1BvU0w1OGkyQWZ3aTMrT2FSbkZhNlUwQnY2?=
 =?utf-8?B?VzFLcldPMkRQTkh6d005K2dPMGhiekphdnVVbWcvVDJKb0JROWZ0SEFqS0ZE?=
 =?utf-8?B?ajF5Z2F6UVBnaFpzdU9zdzVqbk40Nld6ZHhnOVZHcUZRM242ckJSNVMzZXNv?=
 =?utf-8?B?bE9LaFRQUUVtQzFNRmFCZjJXelI3SWZDMTYzYWtQSHRyTGl0UlpOWjBCcjhD?=
 =?utf-8?B?ZWZhMUg0TG5GdldJZnJ5SlVjQk1nQzhWY3plUEFOTDlFYytRMlI2QUtxU2NK?=
 =?utf-8?B?Y0JWMDZ6TTFCUUVydHB5YzZaVW1uNjRWVExJWG9RUXo2bmxTa1hHRTJIV2lz?=
 =?utf-8?B?bjN5M2IrOXJwM0VKYWJ3ekNpdTcrY0xzaGxuMEx1WDhzWW84bzZ2b3VWcXg5?=
 =?utf-8?B?QVMvSlNyV1pkRTNKRXF0SThhQUpwYjVXSCtER2R5a09YQk1rNzg0d1pvNG9N?=
 =?utf-8?B?K0k4QlVJcFRrYitNdUhTR1BrSVYwdm9wRExYYWEvNE5HU1hnMUpOaDVDaFNv?=
 =?utf-8?B?WjJoUGFnQ3dPTGt1RWw4ZEYvbDBYSURTZ09mZjhPU24wUTBxVUx6SzdPZmZF?=
 =?utf-8?B?MVNvWTZOcVBxVWxtaVdmTTVxV1MzSDJZaTE4bGFVV0syVnZSTExycXZGMmMr?=
 =?utf-8?B?VU5ZNno5N2lVZ0hOQzJVUFJzWFFXMG9QYVd4WDBVRWhoQXM0ckpWZ3NKRmov?=
 =?utf-8?B?NGwyMWY4N0d4c2VRb3NFQ2s3YzJZbmNwYmsvemNUNHF0ZEtaalVheDc1NC9M?=
 =?utf-8?B?Rlh5bU1UL3U3dklSRXFqS0RrZ2E4azEwMklMY2NZekJ0ckJDbWhqL2Y4ZThO?=
 =?utf-8?B?YWlQVkk5aFExcmtsMXFqY1UvN3YzSjloNEk1OVdFV291cmlUVUdsUDFQWGQ4?=
 =?utf-8?B?ZVpBR1htL1ZlL1JVZGJ4UU53S0RpMzlZK3pEclV2TjZsclFzUGVIQlFkMlNL?=
 =?utf-8?B?anRJY25wVDVoOEFPc2lFWDFUUXh4QlNKVmVTeU0rd05QWjcxdzluTDRlbU4y?=
 =?utf-8?B?SjdUajltUFduYUpWZ2lPU2hzbVJybEl2Ynk3emxReUQ3bTc1TDYzbVZNWGFZ?=
 =?utf-8?B?clVJNXRSUEo0c0wwRVl5dGJmZDZublhyVm5vakxpdUhKYStFQWM0YUtyYkdn?=
 =?utf-8?B?ZEdtOXZ3dnBKTkk3U1ROclpOZ0xIMFk0QjdMUjJSY1NTMWk1Mm1SVDlGM2ZD?=
 =?utf-8?B?U0dOdlRmQkZuQVdPS0VwTW5yRUEyTjNKUXlXK0hhSXYyQytHK1NkMmI1ZGxU?=
 =?utf-8?B?N3JIVmgrK2dhL0VCZ04xQnc2bGVPQ0xKQjFvdmUzUGJYVHJaOFhGeTlOYzVE?=
 =?utf-8?B?ZkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe71ae1b-6819-4ac3-b753-08dc43f75479
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 07:21:13.3897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xCjMQ3dqA9gtbY0PF5fewVTiQrS7b03oFJ9bmhz5LuAGti6eSDuC9mSVNNaxjeARznDdhcQgyoXa9KKkIVHf7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6641
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Mar 2024 07:21:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15298

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2024&month=3&day=14&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     13:00     14:00     21:00     22:00

(NOTE the DST changes in US!)

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2024/03/cip.2024-03-07-13.01.log.html

* Action items
  - prepare blog entry on SLTS kernel state and challenges [Jan]
  - migrate kernelci bot reports away from cip-dev [Chris]
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB

[*]
Date the data is created: Thu 14 Mar 2024 07:20:37 AM UTC
linux-4.4.y-cip: interval 30 day
  latest version release date: Tue 12 Mar 2024 11:03:54 AM UTC
  limit date: Thu 11 Apr 2024 11:03:54 AM UTC
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Wed 03 Jan 2024 10:54:06 AM UTC
  limit date: Sun 03 Mar 2024 10:54:06 AM UTC
  Status: late
linux-4.19.y-cip: interval 30 day
  latest version release date: Thu 15 Feb 2024 09:08:09 AM UTC
  limit date: Sat 16 Mar 2024 09:08:09 AM UTC
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Fri 01 Mar 2024 08:49:23 PM UTC
  limit date: Tue 30 Apr 2024 08:49:23 PM UTC
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version release date: Mon 11 Mar 2024 06:10:02 AM UTC
  limit date: Wed 10 Apr 2024 06:10:02 AM UTC
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Mon 05 Feb 2024 05:21:45 PM UTC
  limit date: Fri 05 Apr 2024 05:21:45 PM UTC
  Status: On track
linux-6.1.y-cip: interval 15 day
  latest version release date: Sat 02 Mar 2024 09:15:14 PM UTC
  limit date: Sun 17 Mar 2024 09:15:14 PM UTC
  Status: On track
linux-6.1.y-cip-rt: interval 30 day
  latest version release date: Sun 03 Mar 2024 05:34:51 PM UTC
  limit date: Tue 02 Apr 2024 05:34:51 PM UTC
  Status: On track


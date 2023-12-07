Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A12A1C4167B
	for <webhook@archiver.kernel.org>; Thu,  7 Dec 2023 03:51:03 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.77])
 by mx.groups.io with SMTP id smtpd.web11.75628.1701921057444383605
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Dec 2023 19:50:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=sDo9HMHB;
 spf=pass (domain: siemens.com, ip: 40.107.104.77, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TJ/w6TdGzIRZkz9tP7sUvMm7ZcxosYWBz3fh/TotNRXik3aFm7iXwPwxlubYCAAV1HP3BLfg0ZCesm4UFqmlo3zGdDCVcoGSF1FHp51ri9LanU/p8rBnCyZnnZ4BqFkiQgZlYdZd2oJbuwJi3LmhfxxmrrcMviNuewZbT/4vq983QIpUVbtfNzVtP4dOsSzaLPPkAJ18G15p5h2sEk07atFo/DnqmBz1YDNIWr/O1FDMu2ktLxOfW46ph27X7miJs9l30NaBqdgZnAcwdcvNNUtb4V0AWP9sCq2/y9IiBMKr2SsyyIdHB02PYkqPgMRiKVwx1jQ8mlaicxrJMJ37zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Yt42lFcOMnaowvkr1y/smUwzQDuQf8IFDCi4Mf1Dak=;
 b=UwXM7Aa8apzs9NaP5bGM/WlnAYRPLc7KhCUYVay20jwD8MfypcVR612DVg54vtLY/9NfOzzIvyG4qlqt388YF1Zcld7KLNIOd8KDAdgWxl1/xgJa/JSaUHkQJzUnXqR3pH7oDwWnHqi52S+UeZP3oJwXQmhtwyL6eA+AwqaPEGLU2KEHum3YVhNsqFh9OprS3T0bo2kfz2U9IHvMl4OB3NjuzJkmUI/R1/xRGNfcpWvpFYGqXs2fz2b/EFygPmNaYH9qg3R0GaVg2qYwZT6oz3Y9lyou8FmP+CcGNu3lDOsZjIE63KrAXkMTMdkPFs5sPzWogGuCOLAR0z8GQwrqPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Yt42lFcOMnaowvkr1y/smUwzQDuQf8IFDCi4Mf1Dak=;
 b=sDo9HMHB79l0XPpzmF92SKraYogrdoRbcc2Db2IJoPpRaZV5kqrZbdc/HR1zb5mfBflYCCNGaf1UiMp3IFFrsBAXYmh6jfI6rqg5rJe2F0/CQUowc4UBuw8uyeM694HFbbRcsW1NDqr38F95grgzHjI2zRpZsb8bTkFSVrcehmyNqm4OUh8mYPSR/HR7b1AnYHyv3AgHtyEXZryMdur1d1m7uidmLHKWO8r04mzq8HXIKin4bMcIyq8w/BmMN4gU/ZcXr48sVEbEolVkpbSMMsOIlp2elwGVSgKIO1PzEoxp3li17DA1bodJvlm+aA5gjt4R2gpKpFWmpjYNHo8Azw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3615.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:139::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.26; Thu, 7 Dec
 2023 03:50:53 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7068.027; Thu, 7 Dec 2023
 03:50:53 +0000
Message-ID: <2df11e62-6cb3-413e-b72d-3a2f6b3332ec@siemens.com>
Date: Thu, 7 Dec 2023 04:50:32 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0302CA0010.eurprd03.prod.outlook.com
 (2603:10a6:205:2::23) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3615:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d5727a6-09b4-4d14-3e63-08dbf6d7b5c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	iMSN6KKRsJ2bzqCRAHQwYMWYdVlbsDDitFUJlkxWBlzfuIpviQlsvqgdBBZff0kWVT4kTg37s4b88BbXP8SMULCfm1agRo1klG7an5y3czuLobYQr4hZwZOFa3quT3i9lowLsgtz7DqlFBY2IwQBJJwvFOyWHJVRDj/msTxyCqJpJZqhUsw1Gg0WnxAsuNrLUAuKyRd0oqFHZ+Nmfh57F9HKdp0q7Etp5p45NgHiJkQoXT032gPXVLZTULqlCpSZW8X9/DNyF63ieDBtsVgMZNvk43bIvqNq3wZHouqbwCkMUWEIGMSlRdjVE0WqWCh/kU+8GprRi87A30mBuj8TMgVpwDZYyRa/4kXgAlK/ig5MrdAiauuYjZpq7VmuHhHnrRjfVraXTeozW76IXF+tUbptHFQiVCoP4lSKouyZVBWulU1FgnxekSqZXaKfJ4PxadK7jeWsMscLnU3Fz7/HsNGygc9jkvjeXmjAGykFuMX6+zyK9MarRSpEt0q6Vch41gd3vSXYWjqaLAAhcfExhHYwKbkte+7AAQlxsUIgHoNDDrK22Dr76A0NrutDghrepG7Cm3VCxDZq503+Iobuq7H8Jc9lMKBEboUGSqa/PGS+WSgqRyy1c46H/U53plzdgDePPEg3ykUoC29jhqRJtA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(39860400002)(366004)(376002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(66556008)(66476007)(66946007)(8676002)(478600001)(6486002)(966005)(31686004)(8936002)(82960400001)(26005)(6506007)(6916009)(2616005)(44832011)(316002)(6666004)(6512007)(86362001)(5660300002)(4001150100001)(4744005)(2906002)(31696002)(38100700002)(83380400001)(41300700001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TEtHR3VHT1BqY0lGM3NPaFdmN3VYaVV2RGxPZXl2ZzFzZzl4LzZFb0JsZEtw?=
 =?utf-8?B?SXFEeFI0TFJpZUkrRkpLQnFQZEc0ekR2cTE1b0ltRExrVlJKNnNmWlJ5SWkz?=
 =?utf-8?B?MUhmdDZLS1B3Q0ZNSFFtYUUyTUhMUGJlNU5uckdPZTVkQ3N1ZjkwNUN3MEdO?=
 =?utf-8?B?ZWRYWklSZUl0a0wvY2JYSVVlOGkzbkRHUElQdm1UcnpGSnFSb1ExazEwMW90?=
 =?utf-8?B?TUZDNnUrNktmY3pKbGdndUZLb051aXlNVTM1TnpGelBBZjFBV1FjK0l6N2dv?=
 =?utf-8?B?bHZrZTlkZEd3VmluR2s0TEZnaWJuWWFRSVZMRVA2OWJmNWkrUXZvUG9jQkk1?=
 =?utf-8?B?b0RZaVRKb2N6Y0xyRXNnWk1rRkxWL2RzWU5aZFd3aHY1K08xTXhEcytzZlk2?=
 =?utf-8?B?cWVNNkdEd3ZRQ04rd3h2ZTR5NDBkZzBZamF2eGF1VzZ0d2MvMGNJVU1Ed3VL?=
 =?utf-8?B?VVdFYkNBdGFwTXZzRlhERGExWWVCWDJPNEd6ZXZqaUIyK05HMjBEU1ZVWWQw?=
 =?utf-8?B?R1NENHhSVTNxSnZJL015L25XU0tMYkh5RW1Eend4NXJlTm1lQXdVbTlrM0xD?=
 =?utf-8?B?ekRseEtRakR3aVdLVFNxM0VkQ1pjOVRCZWFlQzYyTkZ6T3dhSHRMYjFCL01w?=
 =?utf-8?B?R1NLa1J3TVJNdWRoQkMzU2VQOEErZGorYlRWZ1BveWM3ek1ZZ3JCd0FKNGNz?=
 =?utf-8?B?dnZXM3orMHJCck9TN0xlMGduWXU0K1hET1RkaGJGTjZJb2s0ZW9xMGlyNGFn?=
 =?utf-8?B?RVMvemM1NnhNWEdXOUxVOHlhNTJjY1ZiWjlYbkRsNFcrZ1VzN0JjY3NzSWF2?=
 =?utf-8?B?b3dSdGxTNnVpOWlRaFlaNEo0VWxnM0ltR3hjNklaNGxzVnlyeEhERmtTV1BV?=
 =?utf-8?B?dVF6MXlmWmQxZ2cwWnVVZ0loVEtQbzQ3NVF6SG1CRzJRUmx4OEpWV2cvQTQ5?=
 =?utf-8?B?Skg1bXgzeFM2YVlqVU16MFdTdFVzYnFRRE0wRXZCTGlSVzZrT051R0hmOVFv?=
 =?utf-8?B?ZmMwcy83b0hmbHF3WnpTMG1KYnpLQllHU3VtelZNMFdFZVpHTUxkZEh6RExU?=
 =?utf-8?B?bFFtWCswYXZxK0JHNG1yNzBVR0JsMmRRSm11THJ2NldCaTIwVkttUi8yQ0kz?=
 =?utf-8?B?d0pQaUFENk1ybERuQjhWdjZHTmpNQWZaR1ZCcDc0elZ0UWNZSit0Y2Q2K1hk?=
 =?utf-8?B?TzV2QzFsTFhYRFB0NEZKWWpZWmxzRnBOWmRCakZjcGk0ellseGJHT0pBMDFB?=
 =?utf-8?B?S0hpRDlNcFFWeC9kSWMwWTlqVU1uaXRlQmh1dGl2NlRvSmFyUFh5NmdxQkN3?=
 =?utf-8?B?VTVDRUhWZE1ZSm40SzhCZTJKWVRkckJJYmN6K1dQVlVRNHRld1Z1SlBia3hY?=
 =?utf-8?B?RzU5bjNTQ0VCRlMrRU9hU3ZmbllKRUNFM1hoTGpSVzhpS0ZqZDhvZXpaTy83?=
 =?utf-8?B?WmtESml3S3NDZkgzRXZ5Tk9CRzBUeTNYbHZtdTc3UW0vbm5FdUkvemxnNHcx?=
 =?utf-8?B?Unk1YmR4YS9qVHhqSXpUc0RmWENCL3QrSVljNnNkTG9HZE0vdUpvL2NuR09u?=
 =?utf-8?B?d3lFbTQ2cnc1VS8yRk0xQW9lOThKTnhQVk1oZjc2VHFVZnYvcnVDOXdIOERF?=
 =?utf-8?B?YnU4cXY4Z2JYSjFPZlc1VmlYbjRCeU54ei9HczBLZ2FxZWRsWExuU0hwclhh?=
 =?utf-8?B?T2M0VDJTVTFTZmVvSmtIekhQTW1XUHFDaWwrdTFFTEt4NElGODcrWU9qbmpw?=
 =?utf-8?B?UWJyd2hQSEVPcGF6aWZWN2k1TW1wTldEMkY0QmFpcG9uS0syUFQ3S1BFOUt3?=
 =?utf-8?B?T1ROcUE0cDVXMEoxMmFkQk1FWWk5K1VHZm4yQnI0ZGVsZXp6TnhrbHJ6Yktn?=
 =?utf-8?B?LzdmbTIwY1pGYTFtWHQvRU1mTzBhR21vOHFtNjZvenNHeVVVVU4yUHExcDA5?=
 =?utf-8?B?Y1Fnd3ZtRjYzRjNYOVplR1JQTi9iVFFaNTQySEtGWjcrRnN2disxeXNYcnRn?=
 =?utf-8?B?dHNGTHhFYk1od0g4NWV6bUNSc2RtQ3RQOWpCY1h1cllGRXdnSHRwWmNNZXlD?=
 =?utf-8?B?Q1p5YWJTNWo4eTNDeGdiMFZGelZJOC84bSsvaFpBUVkvdzVnZ1BOd2J4UVha?=
 =?utf-8?B?eVBNTWRYSlNKVHdmYXJCV0hqWTQyUy9XMW9PQjc2OVFTTmxkL1dFa1lRS2dM?=
 =?utf-8?B?U1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d5727a6-09b4-4d14-3e63-08dbf6d7b5c8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 03:50:53.4704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xlAGgnrQ64Wq9HEIz0i4f9njdWHw+xXnhOLObB02VTIe9U7DKXsvUAxP8qMgS8uXFFIyo6WdU2rGxt41G23PuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3615
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Dec 2023 03:51:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13804

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2023&month=12&day=7&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2023/11/cip.2023-11-30-13.04.log.html

* Action items
* Kernel maintenance updates
* Kernel release status
  - 4.4
  - 4.19
  - 5.10
  - 6.1
* Kernel testing
* AOB

NOTE: Do not wait for me if I'm not online on time. I'm flying home and 
may have some uplink gaps.

Jan


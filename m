Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA92B107760A
	for <webhook@archiver.kernel.org>; Thu, 19 Mar 2026 06:03:33 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.61])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4916.1773900209917148699
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Mar 2026 23:03:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=wH6rklnw;
 spf=pass (domain: siemens.com, ip: 52.101.69.61, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rQiMWmR0EnH2MH2d642VovVMsfjYG90fdgIUU07TCA14YqQns6mKOC7KaOZtrgzI/LRaBA43MbIyaJWS7ABN2o2U4bBDw0oix59tmsarbanDP8lxi6agrNpnbg86+4QQ2+XT9zx5Q03XjgQ6FCTbNAWhPxCo5oNHPiMlpz46skCrXyUuSUeZUvxUDf0JK+CU6veMZPs80dPP69BJkqdz5xJDzXOlAqcKF0zDHIhhUVDnkM1Fjv7ymVBvsL30u7afLnWftUlFusRvC5viMPijAFAotLqCMHJ5IEwViV89Jwe/qLx/6qMs0ET/TwV8MqO6TxoxptfKCAb8YkdlI4W+kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=svX9LW4b+aCaFI9pgF7py3fbQ16tXgiVsTsic0LQKKw=;
 b=VtwNh6e2F+2x9GgwCUZYPJ7+6Ipx/TbBwZd0cbNPZd007v3GF5DRS3hKjUv6suC08pu+JVh+JSQbCzHAt8aqquOHg2XNcg+0FKsl11isMUl322y0NoecYeZjId08DSX7HOIxPYHJjkFz3FvYf8dfJoV4Xejqv4f8sXhsgcO2W8IWeDC+U15/A4mYq/OBgGe/Y1QjgHRgLTeDovUQQOKGuPs2cg6VnUmGvPPZMTRtF818WrvbO5yGCMYMyAkUKxSvjd84miF1ksndIU5nFkvyfuwXmaQOQe9ie7yXqthnx1NY+/eofQmEZHysIDlbj9aFmBlqnyBLaLvV7wReq1qxJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=svX9LW4b+aCaFI9pgF7py3fbQ16tXgiVsTsic0LQKKw=;
 b=wH6rklnw2TofNXLFneZ4a5g2lVtBLSdUQ8MnHq1DDaTCCx4peLEJbi3F6rmI0xckq6H/A98w1Ahm7Ep4n10t7ZjsnpzO/lpPMTNfGOBaEkondncrtgcnaiLyrClBWpB1OH8DkaFJE8EciTz3iWFMx+WBRiwT6Z3bOamM2mhFeM2qeqs1KLxgOcqAMAlmWOURwetDqOixUsS98UkfaN+QmxGM1e6fr0OHkl4MSG7Nr8qyBXqO9tAJDn7E8/ZDunQkiRCKpf49cKMmsA10QHiCEMNCsuAwHJB2SWXJvdYkVHkkCuwpu6ngHgfXD6WsK5mlzZQfWB9Jv/Z7pgiCe7X/lg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5238.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 06:03:25 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 06:03:25 +0000
Message-ID: <0e9496b0-7cf4-4351-a830-841966d172ec@siemens.com>
Date: Thu, 19 Mar 2026 07:03:24 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0084.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5238:EE_
X-MS-Office365-Filtering-Correlation-Id: 2923af36-1f97-41a7-731f-08de857d3ba7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|1800799024|55112099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	weveEB2TIyZy883DBkDQxxKy4fXvNptZUsGCwA/MObrUKyvzFSgjOZlCOXlhN6LStNXgfpkFBij7ncmqfX3kFvVITLfkq9BsOsTlHvl0N6rhXT7aEzNYwxK3QkOywa49rZjlANjxqYogv707z2cOH7wgY+E9zIG393voY/iah6IVJ1pZphiaiVyX/rUx9c4op8ZeJ+oYNtRfxQSmlcnaP01r3GSzaIMIEVKKsXubpT7R07WPkKv8G+sTnEswkW7HUZ0Ckfv61jGexynlVfy6vvLoxxG5sUva8sJB579PlMF1cQReUlptMhEchMy4KiDV14gNTyBwfpET1pwb8rIEtLxhHZmxj22XHdBf5yFwpI2D1IjK7aO4pCDEZ+Ukaq/gyaQuiVQ7Jw8Uf7/Utc5VN9WI15j0dignKvp8Me+d9FzeBpmx6ZVek2eOeIhnKNqjON6b10cBsn2y7TmtRcAOAQa/Ct+xg4l2SqG98/VlSTuvRAVdUil0zQmQWAlR73TP2F98VVRSVbXgXvsgcIcRy7NJ/QTcd8Cr6N9/rJlnwKtJKYplQgQdZh12up+Em0v6pkrax5eKZXNTOyIurpoFqF2h73WDNkk/3++uZ6lbMyY4T8/ZeIvi/njiHwOOaTtmKFrV3BslqbhDxudEZ1EeLBQHRvFYlmauwHHKdeA08EJBQdjh+lzWepPMPP/vMj5n
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(55112099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aldJVm9EMWRISmk2aG5BMmllQlNDVlZuZGR2UG91cFRNU21WMDYyalZCU3BV?=
 =?utf-8?B?eWI2cUxQOTM0NkVTZ0xUbEh0TkI2amxUekN2QnhBa2FNa3RaMkxQTk5lUzZk?=
 =?utf-8?B?cjRSbFZrb2NoaHE0Wng4Vmx5NWJVUytmaTl1eEN2MEZCMEMzSzAzRGtOdkpw?=
 =?utf-8?B?czhXbmMvekNZU2hhSVZOSkFBOXZYYmw0QUEvQmpCeVZNcDJhMGF3SlI4OTNJ?=
 =?utf-8?B?Vi94cW1UeFF6bXhkclNhVXk2VS9xdHNMeWdUOHA1V2xHc0dlcUNGc21DdFQx?=
 =?utf-8?B?cFA0WDZManlXMVo3UzFxblJ6OExLZUtKVVR2LzNvVWJmYXpReVZQYmVDOGJG?=
 =?utf-8?B?UXFaVWNUQnVnWjY3VWJvdGFwU1ovQUtaMUVMOVRITUtjTzZKc0ZLaFN5Z2JK?=
 =?utf-8?B?c0lXb0JXSVJHODBGWStaYklZZjRsMExxeEpTTFJIc0g1MlZlUmV3SXRhYlFj?=
 =?utf-8?B?WWhOcUt4c3poWXpsUE9YcTRWOFNVVE03SWZiWmNERk5uQ0duRWFsZ21Bb3hp?=
 =?utf-8?B?Z3lqaWlBQW1mbUVjYUJvM0oraVd4Y1YvMlk3WlV1U0l2Qnk4dkR5Q09XdHBZ?=
 =?utf-8?B?VENoTE1wOTJuNnpoNHBvV2ZtRklZTkhkbGNzdkxRdWlIRGJsQ1VZSFpUc2tZ?=
 =?utf-8?B?SDhoSG03a2lVSjMyYnYveUl3ZTNuT2duRWhZcmFhL25KQ0RJeTZ2MjMvSE1Y?=
 =?utf-8?B?eVJNSVdnYkV4R3FDVjdqNGlPL0x2cU1kOEYvN2tzd2JNWVVqbm5GS2hYVEdq?=
 =?utf-8?B?a2o1ekhnVVozVTZDUXRNb09sSVhleUh2djQ0S25jVnY2L1FpYm9lT3NydXIy?=
 =?utf-8?B?K1dNVXV3eE9SUFpYaW8zZ05FelhYaFpTTldyMDRGbDlOY09CRTJ2Nk40T0tP?=
 =?utf-8?B?TUJ0cTJNckpocUpvT3RzK21oNnhLVDJHRThtRkhtNjZyMEdhSGczSS9XSm1L?=
 =?utf-8?B?UUpnaEw5a3IxQmdnckRzNy9lNEQ1WC9mWU1ndXRCU2xYenY0OXgyb1lJbXNX?=
 =?utf-8?B?dkJZdXRjTTVoSHp3VHpCN1B5TGZydXRqd3J0WFgxZFhBOC9lS1hiMERESlJZ?=
 =?utf-8?B?Vmc0THZXd2dFTTJCZThYbytRd0pLWjhESWdCdVdjdkQzeHVscCtCOXBDallJ?=
 =?utf-8?B?d3YvcElvWTYvOFk4c3ZPaXVERXg5d2NwR0NicDJKdjM3dlpYNmlIR004V0cv?=
 =?utf-8?B?ZFRGVjFrcHliWXJoUVJJOFk4RDJZVXREdTgvcmUzcjJvSDRNQmttUUNTdTM0?=
 =?utf-8?B?cmJhSUhNWGZuT2pJWmhUOGtHYlYxZXo3Z2MvU01KNkF6cHEwYzB5ZTVhZXpy?=
 =?utf-8?B?SzBsRit5QjRjSy8vNm5LZmFVZE9QQXJQNG9YZ0QxYnVFVjB3ZFpPZXg3UTg5?=
 =?utf-8?B?WFU2Q3g2N2JqTEtPaWR2Zk91V2hXcDJHV1RjOTY4YXZGc2lYcXdUbEFPaFpr?=
 =?utf-8?B?Rk9vRTBHdkRTcURzdHRpU0N4VUEvblh0ZDU4Wlh5Z3pKT1hiMXBOeVFOODNr?=
 =?utf-8?B?STI4cUsrNlRLQ3RRYkN6ZlVKcjZRZFA3YVFIVllqUkNtbXlON2NzTURVMTdw?=
 =?utf-8?B?endVRm14NFFSelhuSjBpaUd2cEE0WjV2aHArT0NEUFltemovbUJXenVlNGZH?=
 =?utf-8?B?MjF0Y3EvR2s2YUlpRm5Nd3dJeXpJQzJpV0UwTi9LUzNrRmZwcGNBOU52VHZu?=
 =?utf-8?B?eDkvTDdacWdBbVMwK01kM052OUx1ZzBmM2Uxa3AwYk95SEhybVZ6S3pBVEt4?=
 =?utf-8?B?cEd0WjhUUHM3ak9Xa2Z1RWVwMkNKd1FrZ1hUMksvbUMzbWF2S2FMN0lxdHRp?=
 =?utf-8?B?NXRManJ6LzZqQnVqV1AvRms2dktIODlJSXoxMWppWVpuS2dSRW4wdVJPWEk5?=
 =?utf-8?B?aWh2K21ObjhkTkdnOGxaZVRPc2YyM085bWxDWEt6YjVHL2FYdTV5VFJlZEpN?=
 =?utf-8?B?Z0lVdG02Z0hoNHNKTklBN3BjK1hmNERkNGdHR3NWbUdzOG5OalY2Y2tVWnVz?=
 =?utf-8?B?WHI5emU3ampGbnZ4THl1SHFsbEtndHdJV1Q5SDRyQWZuTHhueTBHWmlGWkE1?=
 =?utf-8?B?MmpiQkQwajFQNkNacXNreCtmcnU1cithRzFXb2dmVUlkODR6OHhGcGMzenRv?=
 =?utf-8?B?Ui9LV0p1OE9lcmt0SG90MzRVSlpwNmV1Z1c0V0xqQzdSb2J3TjB4d1duN2ti?=
 =?utf-8?B?dWhvVVlKSkNwNlhuanFtUVlYY0dMa1o2di8zVVpzTDQ0Z2xOUEpoaitaMS9x?=
 =?utf-8?B?YlhqQ0NBSVNsWmhPUTJzdW9CV05mOUhMVVVraEpzSi9CSjNTZHgrR1V2Ym81?=
 =?utf-8?B?bldpZmV5UkY5c09IeFZNK0RjMDM3TSs3NUFKOW9ZS0FxUmsyNXNqZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2923af36-1f97-41a7-731f-08de857d3ba7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 06:03:25.2669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Odns2/TGX71h638IO7H9A+8iBlTGo26CN4Vva/lmosRPLJQ6rmE75JAGq9YPvnxYxygCPkK19jbGpRC304X5Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5238
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 19 Mar 2026 06:03:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22507

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2026&month=3&day=19&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     12:00     13:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2026/03/cip.2026-03-12-12.09.log.html

* Action items
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB

Jan

[*]
Date the data is created: Thu Mar 19 06:03:05 AM UTC 2026
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
  Status: On track


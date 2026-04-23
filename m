Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B2AF94CBF
	for <webhook@archiver.kernel.org>; Thu, 23 Apr 2026 06:44:48 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.30])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13945.1776926679001317974
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Apr 2026 23:44:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Mb1suLVg;
 spf=pass (domain: siemens.com, ip: 52.101.83.30, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gNPbNIpGC717iUDEfItbiShnNGyrJaP4gW7gFZQQCA38jZC3Frhin3k024gIc/WOmdGSXDLWzPR1Dv2K13ov3CK77vhAFiJaM7oU7nQdgrtTyzAmzK61YBrSHjpRPZe8wnbMI5f1BOkjvn2dcgUmQNxEzZr/IP2/HeI2eZnokfK6/CYRIgoZtqi7grXGhAQAoUNfwsiXIe6KQK1QT9wV8R/5KLSa0sJVmEZQmt8aaFRDYFnIJ8DWIuK9qLMnsiAgmudvLl7VaXHdTE0QkjwB3fYGtg/OkDRJSyi3YJf1NEVNfKW0HFUhoru2kIneodqJ7iYUbVoz1hJi6hxxulWgCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=igkoM7Dzh6VSx5L4jlvNBA4SHMgFLtIEtBPAPnkJmDU=;
 b=Bbv0bACzb0g5jvOaXcy6js25Q4WcO1Hh3b2S1QrOrEL9AWPMZxTWMwkwZ+E83Nx8huWSK1evp3k3FvvnP2Sb5N5/1nJXVmu7cKdyc9mIQ6r4g/WK7l96sxqa9O10krmtPT+nomU2ElA4DaeaXU8GLM2VuazK9XtTlkMXiAXI2Awr+s3KU0Bi7msgCIrTNcUMtjdbV1Vj7M4g7c1ZSFi2/ZMwvxaGrTQDUAELCsNZY82XVKgTeWiTxDpjkvlmzXHT38WcVQ3JuBUYja1WRRBskDHnovTEN154hirxn+9PClCdMVf+B92sYA8bbY2j0RpNI8mvgve49d7tExdvbWglBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=igkoM7Dzh6VSx5L4jlvNBA4SHMgFLtIEtBPAPnkJmDU=;
 b=Mb1suLVgmjiFPAi5+new31ANPQ61HfyoT3u7bKnx/e5hDkHNfRerQk0BUh6pnJDNp54Y8DAA/0ZZnISuUBypk17UibOKv9JuswJ/NY/JfYh/5m8XNaiT63V9npvl+22QI1Sxf5iXpsCWbfJeN+0jkOESOmVYhWpAqD3eHALF0SpdP732Yk35dFDczfgs9cJAmrhH10vm+jwsPI+43DrNScFZXJ1ub79CjL9J0WmTGScmYIXEfH8Phwhiv9gQ4CIaojWjK2Or/mUpIPbCBpi/tnUgfUY8x54tsutEIDcVkI5qHDTZwb+BKrE1tMC1b39ZkxLbmO2LkVIc5ursFmdRsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7852.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:642::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Thu, 23 Apr
 2026 06:44:34 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9846.021; Thu, 23 Apr 2026
 06:44:33 +0000
Message-ID: <82723b47-dc6c-4fcf-94cd-75c430a09450@siemens.com>
Date: Thu, 23 Apr 2026 08:44:32 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0080.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7852:EE_
X-MS-Office365-Filtering-Correlation-Id: d1d21052-1906-45e3-8818-08dea103c78c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|55112099003|56012099003;
X-Microsoft-Antispam-Message-Info: 
	+nE+RtHDkB3PhY4h3FKEptklkU1FKb7qUJecA4A92dY2M/Jtj/eVdd8Np5CJcx3yXc2TCQH9dewEL+df65Ag7hH+tdQxA6FtuPW9m4Hhl4lXVdsFN9LbbptgwrUJrbQPQv8g6KbxBRY+Qstnww1zrMaOCAW+39GldFUgkUgXMIN7IFc69BzObu5cUIWRT6ecMg9WlS4Do0EbJ6qliGQijWziBe72r+gvw7205Wy5JsPKAxDp0YAE3/HzcpuUUx7SzhqH6FdeNAEQDvxBOdDfUhtEpD3cOZzw5FP/gTt5597+SeeSF0SSSh6an3xD0W13egLGF/S4SSVMLcTsSpFGaIsDKq8HVuK983uajJ+ftOvB+z2qOnNx2KXvuG1MNW80DHkKyab19FATTUV6faiW9gAerIoAJ5u+gurs6y546Z2wJ0AipN5p993u9T65YdtAipSpvhz3ocDMhRmz8jI2lUGcOhOy2g93chsPBqnC1SFfAOgQe2Iy0mRwrkBMiPWP2Yl+N//Bqa/6g7AmZuZzd3QqV3wYDMv+wbeT2l5UsZu0ei/fxKaXp+0JRiORO/jm3G73ixa9HjYfL4xtAJyxS2nFfYWLU3uu/CA8c19g7PTu7KE9p2wH+t17IyoUlskMZFQNN2nNlA5StYB74I4pMblGTcARb2dARLg0hSVUE7m/t1V28s5AS6a7qPWuCADk
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(55112099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YXl5cEpxL2tTcm5iTVhOOUxUc0U0ZzVzT3gwbVNHbDRYbUxoMjB3UlVweklK?=
 =?utf-8?B?VE02OVgwV0c0NEJNSFZxRlgzNWFkaEVVWlVSNmFoYkNXWWNtRzJSNWVuSTRX?=
 =?utf-8?B?V1VZL29nZ3NRN0hRNVI5LzA5NnlTbkV5eXZibU4xb2FuaTI2ZTFFNEp0SGYv?=
 =?utf-8?B?cHd6aUVRYmJhQTNJQUN2UFZIWW9temtFNnFGR2JURDRlSkJuWGM2VURXTkJI?=
 =?utf-8?B?UHA4MjQvcG55enJxMExYTXk3eUVMQWNxRWVIOXd5VDc1Y1VWT0RkYVlMQllL?=
 =?utf-8?B?OGFMTHgva3FraURsRHVCWFJ5YWVBc1VOQTVNYWtJeEJWYXVxMVZkVnZ5RDlI?=
 =?utf-8?B?dCszSS9QS1crSGJoN2x3Z3Q4T3FWZnI4ZUY0dktZS01BZlZMZnVjNUpMeTEv?=
 =?utf-8?B?eURUQm80MzhscXJLZjlZSkV1a2I1RXRWS1lmV3BJZ2RUTnpBN2ZQaUZNQkZx?=
 =?utf-8?B?akJDTzdXckgwdzdLMlNpUnlTYTRsOGFiN0Q1b3lvOGRYdzBXNk1Ec1RjWExy?=
 =?utf-8?B?RVBqZXhhd0dwK1pRYTZxd1pNR04rR20zdGMzeG1NWTBmU0YwS3BVNXN2Ny8v?=
 =?utf-8?B?MnEwS2drc250TXpLMklJdk9DcllXRHI5QWNsVU9ZSlpuM0RMZC9FVEVzekhZ?=
 =?utf-8?B?MGI1dG9McUxyaEQ5cHNIdmp0TjlkWVlNMWpYdlhNSVpzQVFEM1RXUU1tbEZK?=
 =?utf-8?B?eFhnN1VZSjVVWVp2VE5zb2hGenorbkZ5TzFoYVd6bnBPNEZPTUJoTHVkb0Vy?=
 =?utf-8?B?ZG5NN0UrWHEzanpNWHhHSDRVN3pzd2tTRmQyL3B2eHFweUZPRW84RnFQbjlZ?=
 =?utf-8?B?S1dyUVVVQldKdjE1TC9raFZlaGdCNkZxK0c1TFAyOXBFS2puSVZZaDIzSGQw?=
 =?utf-8?B?UVNxa3BSQ2YyUXllU01DRmltNEM0c2dJMzBMUUJQbUFDaGFjbDhWTE5ndHdv?=
 =?utf-8?B?RWtPVGdHdWUzaSswVVlMVHI4MW40WjhSSjhxeUhTKzMzUWorMi82VnhtRG1y?=
 =?utf-8?B?Q25SUElFdkxVWDdTOE9hbEozbklNdG1FWDUwYUNTZ0orekZuMm9iYzdRZkha?=
 =?utf-8?B?Z3hGaUhZditIakNIWUJIbTAyYXJUNVo3Sy9HQnhUc0ZYSW56bmJuTnA4d1E1?=
 =?utf-8?B?REdNdXdQYXNseUF1RUNRN1QwYnlyWFkwZ283d3BQWU92Smk2VUg1T09DOG5N?=
 =?utf-8?B?WGg3dlRkUCt6NlRmM3MvYjlNcnhGZUp3ZUh6TzFWWGJkK1RzanZVS3JuOEF4?=
 =?utf-8?B?eVA1N3M1SUk2K1RhYVBtNXVNenI4SzEzS0V1c0J4MC9qbTVsMm9wVnpLQ0FU?=
 =?utf-8?B?ZSt5U25RQzYyQWVWUXBPYmxnU3F4aC9mNVFILzIrOWVKZk5JQ1ZieE9NYlEr?=
 =?utf-8?B?dDlqWFNuS3ZkUlVrTTVCMGovbXBiU1dtU21oS1EyeElBQkcrajh1SGgzdE9E?=
 =?utf-8?B?azJldExGNmozcVZYL0h5OEZxcmg2dTRrN3B2WVgxenkyWWFra2orYlJhaVpI?=
 =?utf-8?B?bUtvanhSeE1sNU1FNk1BMUdwcVNLY0tmQllobjZGNWIwTVU1b1Voc3lQNENq?=
 =?utf-8?B?dTlwWFRvRG81OWFuS2ZGUU5WTXBpMDBFOGpmTnlqTVZUT2ZaY1owZndOZDZm?=
 =?utf-8?B?SGZXcUk3eVVmU2lIODBNVW44SGNSblZlQkZtcWJuNFJDbjlQV096ZENCYjhl?=
 =?utf-8?B?ZjhIMmdtTUVLUTNzclpuYi9sSjlLenF3T1dYT1ltUk1aTlZmWFFoaGJsd29C?=
 =?utf-8?B?TmlhQkFSYXRPeXA2YWJwRk9DbC9Pdi9CcW1VeFFHdFRIOGhhZjhSWm1Zb01u?=
 =?utf-8?B?Sm1oUjh0YlVqN2k4T21iUFUxMEFvV1FqVXBqOStkT1lrbUUxSkprakxzc1ZX?=
 =?utf-8?B?dzFSNjlXM1JaeDhoT3E0ZFhHbXNBVzhkdzlwTlVjbkczZC93U1c0T3ZMa1gv?=
 =?utf-8?B?SmJBS0VuVDl2dUVZTFdRcDJPZ01NZElvcVQwYk1oSnBkdC9JbWw0ZTl3TDNP?=
 =?utf-8?B?YjBjaks4LzQzbS8xTlNhVkQ5b3AwWUNWLzNLNGU5RWZhOU03eVFENEN0cnNC?=
 =?utf-8?B?Nm1wcXRwM1QrV3VzQTJDWlNxNldHbHo2WFRNZUsyVWg4WnJaR3AycFd0Ymtr?=
 =?utf-8?B?ZFVPdlNKTFc5NzBub3dwQklpdEFhZmo1dnNGbmp0ZUFPbzdQMlpRZWRqWmhn?=
 =?utf-8?B?SlBsN0ZkZ09aYllwQy9WbHZkNU9wOEllWEVOMGhIbWU0L1dkMTh6VFF3WUNE?=
 =?utf-8?B?T09ZM0FCb09IQis0R2ZIbTg4R2ZVRHV1eEJmUXZROTVhbGQrbndkc2pOVHVY?=
 =?utf-8?B?VkQ1VEEvUXU2NUpJWTVaYkxobVN5a2dxM1N0aXY1MGpHWGhoV0pQUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1d21052-1906-45e3-8818-08dea103c78c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 06:44:33.9354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XUiAjPtCEcIXoB2ZyOAvywLVdGT8Xw0+touqF9HtaeolNwP7s6h+5EZowWVJFYiN3C2VpT90PNjWqH12Vd/0rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7852
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 23 Apr 2026 06:44:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22790

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6697/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2026&month=4&day=23&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2026/04/cip.2026-04-16-12.02.log.html

* Action items
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB
   - Glasswing topics

Jan

[*]
Date the data is created: Thu Apr 23 06:33:52 AM UTC 2026
linux-4.4.y-cip: interval 30 day
  latest version release date: Wed Mar 11 03:13:57 AM UTC 2026
  limit date: Fri Apr 10 03:13:57 AM UTC 2026
  Status: *Late*
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
  latest version release date: Mon Apr 13 07:54:47 AM UTC 2026
  limit date: Wed May 13 07:54:47 AM UTC 2026
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Sat Mar 14 07:04:13 PM UTC 2026
  limit date: Wed May 13 07:04:13 PM UTC 2026
  Status: On track
linux-6.1.y-cip: interval 30 day
  latest version release date: Sun Mar 29 11:55:46 PM UTC 2026
  limit date: Tue Apr 28 11:55:46 PM UTC 2026
  Status: On track
linux-6.1.y-cip-rt: interval 60 day
  latest version release date: Mon Apr 13 11:43:31 AM UTC 2026
  limit date: Fri Jun 12 11:43:31 AM UTC 2026
  Status: On track
linux-6.12.y-cip: interval 15 day
  latest version release date: Fri Apr 10 06:29:21 AM UTC 2026
  limit date: Sat Apr 25 06:29:21 AM UTC 2026
  Status: On track


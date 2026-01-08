Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51488D148B3
	for <webhook@archiver.kernel.org>; Thu,  8 Jan 2026 07:02:49 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.3])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1273.1767855763472565913
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 Jan 2026 23:02:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=wofMhqFN;
 spf=pass (domain: siemens.com, ip: 52.101.83.3, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MHRR2taAN3uk0Dd6QSj9g36pgbv/K+HzxPYw8E8n/9EX6s+CoXPI8RXla6skBjPY/oVwKVcwzyNPnvExWXd1HbtcFBTbeztpZjBushKtLOpK9Fd3l+pKbZZNwSEAGUlrAobarDtSrljhrVDJUTC5Gg0JHTZNj7goldTqmMUUhhtUM79YutHAtHglAr9U71MWccUmda7Nr3vLayYwJJRutd8lvi31cmS3us5Ze8QKOJuwP1own6XN6MRDPgc6dvSh+1+mPMBeDMag8dYl1exX2WstHVsR5XWS4W6oi06B6xoBCqCuSkCA4UiE1pQ9aunz7+UgHvY9aXmlVIq27bXFtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2MOqw+ONlSVLFUV9/aaNx84c7dLKX6sh7RZGH0BBmEI=;
 b=Fk2cOA0Vo19TnPXaOGfT5QDc3Aabyd0Rdm2XXAZs6MGSSNVa5f6VymoJrkr616+FW2dVNryXOtypDYNtLTkEJk4ndW9LbZjODPzyih8T0aa6ECfQ2NAjKg/xgz2hlNGv021U1xeY+yJcXWUdoP91/dKKGvLLfPcUKoqnQfa06mCvKDi8YmKOp3zlC/U3cUS8M58zmIZ6PDm987SHcglX2ik0HjAR+BNDP7wgp66Qy0oF7MgiMgQ1SIESgou16FzPem8sMrHnjZaLUNBmdx1d0ZkGkcY0HdJWqgp5Zca7eiWXH+yJUX4vtIpSB9w6ti9RWBmcj7Ku8UmEt4im/5K83g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2MOqw+ONlSVLFUV9/aaNx84c7dLKX6sh7RZGH0BBmEI=;
 b=wofMhqFNJMeb7YzYyY7jiAJr+2yllkQGC2uj+42kVuyAqvLzPllU3+0gE6MVtXsBlj03aR/BuQGEljUCrywVpHI5YUuKWmWoZscMkN8wwNbquYBTnt9u1EdwpdHhjQTo+dqt6dp/mIvq7i494d6VChmfgCFmFrMPVLOhuCjvUSjw29BEZ8M02Wvh0ZIETWe2NYpdsZB9knkKEQyB+MrmUeWR83qDKwmQGzYjGPn4Io3z+mZh9obQYE8CCMOhfbhJ39mDdq8MPPUMfvI0k2cEILSYrhc+lcB+ckSEbxSYKtMHapYDwV9X0iiAJwlz2NAjsZi+fZwSVkiaslPkcCM47w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI0PR10MB9012.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:233::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 07:02:39 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9478.004; Thu, 8 Jan 2026
 07:02:39 +0000
Message-ID: <bbf71485-0d01-4462-a132-ffee4f76854f@siemens.com>
Date: Thu, 8 Jan 2026 08:02:38 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0302.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI0PR10MB9012:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c774ff8-9518-496b-2f0a-08de4e83e8f2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?djFGczZjM212L3B4QmdONkZVdmJoaEZydjlyWGYxWmVOaGt3YzZOb1NEeW9m?=
 =?utf-8?B?NHZLR29raForajMrWnNoc2ZHdXZ2WG95bTE5K1dlSktscXZ1UzMydmsya2c0?=
 =?utf-8?B?RFJNYlBjQXlGOUoyT3Y3SlA5ZEwzbzlESExkcm41YVlJUVE5OTNxbE1MN3E0?=
 =?utf-8?B?NElXM2NoUnVWQjVnMEhWZFdzNVpRbkIzS25Tc3ZlV1c5TlI2NzB6c2FCaFVK?=
 =?utf-8?B?Q3hKM1hDVnpmZndQQVZaL0ZtYmJWNGZ5NHBIc3V0NjU2ck83Zmt6QlZ5dTJ1?=
 =?utf-8?B?aVlPOTkrRzRwQi8ySGRYWWE4TnJMWmFITTBrU0hpY1l3clhpSERvZG1KZUsw?=
 =?utf-8?B?bzhQYzNJd1h5cGRDZGhWanhxbEtKWnNzNmRSMDAwUXpwcHF1VzhMSnNPbEI5?=
 =?utf-8?B?dTBMeldjem41d2pIa0NoZzBBVTdiU1FqWmdtNjlxQ0treGZjZ3JJTlVGelI4?=
 =?utf-8?B?dUE2dXoxSFByZHdMc21uQno2UHQwNzNFcFI1eFVlVC9yTG5mcFBMRmwzTzd2?=
 =?utf-8?B?SjVLdHJSbWZkNTVYUTVNazBFblFSWGRzTVlnbVM1b0pISjZvNHlvNzd3Mytu?=
 =?utf-8?B?aEg4ekxCV1llVVFrNG1aRWxNVjlWOXkwK2g1cjhuL29IOEl0RExoU1ZUUi9w?=
 =?utf-8?B?M3V6U3VqYnRqUEpIeDZGWlBlUm9JUVlPZWRqZUVQR25RUm5rVkNFdm9ZaGNr?=
 =?utf-8?B?czNnQVUyYzIyRnJSRXBRZTR3UkJTbTJ0YmVrOW5QdDMzamRzZERnM3VKcmpR?=
 =?utf-8?B?Mk83cXlqNUtudjFlLytpRWFmRkFaUzlCSlBQL2JvNVlVK0VsV0UzMmo3RkRE?=
 =?utf-8?B?dGVidzZ0THcrWEN6U05lVkcxRzRvUWJQZ2tkTmtxY0luVnRjMXlvQzJVNDF4?=
 =?utf-8?B?N3ZRMzlwMUFIeHp5U09qNTNXUEFBOUdiRXB5d0F0akZoNGxjS0JPR0tPTElR?=
 =?utf-8?B?R0Fxck9oN29LTDhVZEMrdm84a0xQS3lSWVd5QVZlSzFjcHU4SHdLcUQwS1lZ?=
 =?utf-8?B?c1EyNGN4a2R3d3BoM01kbCtobTA2djYraHA2Zjk5RzhSQjlsejZmdkdSdXoy?=
 =?utf-8?B?bnN5dXR4S3k2M2ZKMGhqZjFWcGhWTncrelpNSWYzaFJUekFWNzUxaUpVdHpK?=
 =?utf-8?B?aDNkeXdCV0Vrd20vK0d2VmQ2dkt1dm93MnNJdFpOQzFKbFRoa0hUdlFPaWds?=
 =?utf-8?B?aTcwUXBHTHVUS1REb1ArZU5zWGtSb0VGc0NYbit1ZDBVdVVvWjBoL25QMlB0?=
 =?utf-8?B?dGtBdFpkV3ZvT3FMcE5yb2M4blZIakcrayt0WXVPbG5PaG1lM1ByV0FORjRY?=
 =?utf-8?B?M1BjZ3d4dUtJeTlxS3ExZXprYmZ6STdxRzhJWWJPOEJqdjVhR3BkeCtDNGdH?=
 =?utf-8?B?RWRrTUNPcmQ3eERBaXlCYXA2cGxkeWpPZTVKampjM1BiTmxCUVB4WS82Qngw?=
 =?utf-8?B?YmowQlo5VXFvTUZHKysvQ3o2TkxoYkF5cHNheERjMGNDUExzczFnVzRkM2g2?=
 =?utf-8?B?ZDF0NE1EVllYOE8xcVU0ekRrSG83RU9oem51Yk00Mk1RQ3pIOUhOa3g4ZUZC?=
 =?utf-8?B?Y3RuSVozUnpjMS90eXk1K3pRa1NWUWpvZjYrRkZvZy9xWTdmU3lLLzZGN3ZO?=
 =?utf-8?B?N1B2QmlpbDZqMWg0Q0tmaUhnTEhrVVpsNDhKTEZXdm5JTk1SdHplSS9ML3JU?=
 =?utf-8?B?K0N4OHc4R1FSWUk5RjRHUjBoQ08weW5PSStYcEMrK3dWZXFjQXRrT0RsNk1i?=
 =?utf-8?B?SjJlbnBrVmJETmFPRnUzZUlseXVqNTJOM1ExRENFSExuUC9GaVpxOTF5azVF?=
 =?utf-8?B?RXVZV2M5U1pTVlM0RTVYeTdweGV2NEhXMlhhbVNGUXpGdDUzWFVzSXZQMkxh?=
 =?utf-8?B?bVFHWiszMXB5QTRSeDFrZHh5Mm93ZGg3M2lQekVjeXRUMHc9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SmlKN3ZvTWpHVG1sZitpaWF2T1d5T3RGekpZenhhRW9PMSthZUtnbCs5U1NN?=
 =?utf-8?B?bk1NcW1TRDRTMkl4N2k2SFRxa0dzUkwwVE1ETk92K0xOWW4rV2V6b1UvNlJZ?=
 =?utf-8?B?MGhxTlJnTFJTWjdKRk9EMmxMWGxLRk1aTDBQbDkwdDc5SUM3eHFGTTc3alFD?=
 =?utf-8?B?SzArTXRzaEMrMUxYMnNhMU51aStmUUtaWkdQVFVQZHlyZWtvK0N5VitRTU5q?=
 =?utf-8?B?ZzVDY0xsWDlJUXVIakhBdGl2cmFZRlY0dytDbHpCNlZpYno4TlZPZlJUa1Rt?=
 =?utf-8?B?N1IxSFhUOVU0VzdwakN5RzlGTW9wbThnN2EzdHoweEMzaVNjZ1BIbnM3a052?=
 =?utf-8?B?L1JhRHRsNW5QTlRRTlhrR3k1eHkxZDN1a05wVUFqcUxNakYyZjhPRXp3TWxW?=
 =?utf-8?B?QjZKMXk1Vys3UndTa3crSURoK1YreGJBVDZyRk9tV0lSMElGdXB1TXl4TkFz?=
 =?utf-8?B?U3lvakI2V2pzZGNLSHk1U1pndTNQSFZxS0N4RzM1eG9rekJWUnMrSVM2LzJr?=
 =?utf-8?B?NDZuYjJzM0FHYmtHbU83cExzNG0vRVJEeWtWZ21WbXJ2ZXNuUzZucitQcVov?=
 =?utf-8?B?UWRsUXo1Z3M4T3pzdmlLWXB2WUpVQmNoT2NlTnZYOWpWcm9QUTlIejFkOG1V?=
 =?utf-8?B?MXNDclJKOUdwckNJTHN3Sjl6alNyeWFmd1ZSNVdGNUUwMGxqcDV6b1FxOHl6?=
 =?utf-8?B?dUJMK2k3dnJUZ21rdUkreXU3TnczdlVtVnYyRUwxVHlsV2R4RkNFbWp1dXg4?=
 =?utf-8?B?bDhwMVdwWE92Und3QXFlYVhXQWlCOFRuL3dUZWYxYkJISjZ4R3FxOC96cnVK?=
 =?utf-8?B?SGo3bFQyU1BRN0l4YkxkdE1DUjhXeEVkNTN6T2VKYks4cXJxSkNnNi9ydHhV?=
 =?utf-8?B?cCtmUHhtanFXM3pnSW50am9DYndudVFEOU1sdkE2RFk5TTgrbUFqcWkwMXEr?=
 =?utf-8?B?MVBHdVhXQmJOeHIvMjJyRnNrOU8wRnE0aERkMmVOUnNtK1N0SngyaHhJbDFk?=
 =?utf-8?B?RDVNS0YxVWltbGJPR2tXTDRFMjhhT2hBMUpGRnA2VDVEK2JsSzNCcm1CVEFI?=
 =?utf-8?B?LzVOKzBMRTlhRUZwb2lVNERmMGpnK3NPMXd3dGc0TGdUbFFzK3VnVVZSd0Zh?=
 =?utf-8?B?ZjhCNWJhL1h6N1NVdjV2ZHN1cEFrQTZ4QW82aVNudUh2U01VakwyL3Nxbm1E?=
 =?utf-8?B?VGx6ekhidWhUR0h2Vk9vYk85c2tXdDdSc1h6UjJ2WUJHK0FwMS9veXRjdTZO?=
 =?utf-8?B?UG1BTDVzMHc2b1VTdElSaTgyblNpQVE0RDl1M3NjcU45R2dZY3NLR3hLZmJm?=
 =?utf-8?B?ek1yTmpmTXUrdzJFdGlHZTk1NWZNdTlIanFrM3hsWGVubUJJdkNPVFpnbGVh?=
 =?utf-8?B?WXUza3Q2VFVKbXFlTkNKbkVyN3BWZ3hSSjUyeDRzSm1pMElRTHBldCtNM1kr?=
 =?utf-8?B?aHROa245Zjd0UDA1WGZDY1ZtbmExZnJwV3d6bHd2RitKMGlZaWhJS0VMWmVo?=
 =?utf-8?B?Y2g1WUpMSmwrVnJ0TFVLYVVzUzJYTVhCUWxscFd5ZlNPS1hvT0xkMC9XTUNB?=
 =?utf-8?B?am52Ky9raUJ1clVXMWdvQXk4bDdGeG44eml2ZkZxcGtqcEFnY2ZiTXN1dlNj?=
 =?utf-8?B?d01BaVhPb3FTeUtVYlA3NEszQmdGWS81T2l1V0hkQnd4YW1YdHl2VFdZZEVH?=
 =?utf-8?B?ME45OG11bmF5eENVT0dsUWMyQWpzVGQvamFxMEdlcWhDNTZyMk55TmV2ZW50?=
 =?utf-8?B?YzdkSXhqTGRNYkJyaThoUlI4TkRDYmlUTTh2eFpUdEVUZWllS21tVVZOQ0xN?=
 =?utf-8?B?L0JFOTE5OWhsWnBmNkFiWFZHTE5FaFpVRDZlaU9RWWwwY2FUc0dzdjREMitk?=
 =?utf-8?B?VkhnODRoeDdDek5xRFF4WUw0dzNzUmFpL0kxSUorL3lEV042dEs5Slh2dStU?=
 =?utf-8?B?dHV2aFVNTnpvYWdJb2crMm5MbnpjUDlNbk80SUpDNHlKRm1STG8zMDV2NFk1?=
 =?utf-8?B?dnFvYk9WS0hnQXVxbUx1UmtJbzA1eEJrcENOYlQ4bUVYM2t3ZVNQSnkrQ3Ju?=
 =?utf-8?B?Y3I2RGJxWjVNM1JablQ4MlNRYWJhdThqV1NheGF0MmFoei9IMTh3L1BDMURz?=
 =?utf-8?B?YktpTjhsZUt1cmMwdHk5NHh5cWpnNy9sdWgybjhxWVVDT0xYWGxEZjBMd04x?=
 =?utf-8?B?dWEydTNnUXFJZHpYc0RMeiszM0tzRHdYK0YvT2U5ZmpOdlZwYWFxeEgza091?=
 =?utf-8?B?Z1BhZmJ2NExiZ3IvUFUwM1c4bGxBYmR3OW9yOWJOOUtKdVVYWXAva0RTM0Nk?=
 =?utf-8?B?TGIyTlhLS1VTeis3eTdBdVpVd2ZmZVVoMDhOZ1Q3TmNmbTIzSTMxQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c774ff8-9518-496b-2f0a-08de4e83e8f2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 07:02:39.0875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G5TYEnu8FjbkRr4DQmN74S6ksbNxomnCDwPXFDFSl3YCZmVGad1JTKy9aJWYrQlrV9BgGbWUFNoQFNg1VAaumQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9012
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 Jan 2026 07:02:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21433

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2026&month=1&day=8&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
04:00     07:00     12:00     13:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2025/12/cip.2025-12-18-12.00.log.html

* Action items
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB

Jan

[*]
Date the data is created: Thu Jan  8 07:01:35 AM UTC 2026
linux-4.4.y-cip: interval 30 day
  latest version release date: Thu Jan  8 02:18:47 AM UTC 2026
  limit date: Sat Feb  7 02:18:47 AM UTC 2026
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Wed Nov  5 10:07:00 AM UTC 2025
  limit date: Sun Jan  4 10:07:00 AM UTC 2026
  Status: *Late*
linux-4.19.y-cip: interval 30 day
  latest version release date: Wed Jan  7 03:16:59 AM UTC 2026
  limit date: Fri Feb  6 03:16:59 AM UTC 2026
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Thu Dec 18 11:41:27 AM UTC 2025
  limit date: Mon Feb 16 11:41:27 AM UTC 2026
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version release date: Wed Dec 10 10:14:17 PM UTC 2025
  limit date: Fri Jan  9 10:14:17 PM UTC 2026
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Fri Nov  7 09:45:57 AM UTC 2025
  limit date: Tue Jan  6 09:45:57 AM UTC 2026
  Status: *Late*
linux-6.1.y-cip: interval 30 day
  latest version release date: Tue Dec  9 09:48:21 PM UTC 2025
  limit date: Thu Jan  8 09:48:21 PM UTC 2026
  Status: On track
linux-6.1.y-cip-rt: interval 60 day
  latest version release date: Wed Nov  5 06:50:13 PM UTC 2025
  limit date: Sun Jan  4 06:50:13 PM UTC 2026
  Status: *Late*
linux-6.12.y-cip: interval 15 day
  latest version release date: Tue Jan  6 02:25:59 AM UTC 2026
  limit date: Wed Jan 21 02:25:59 AM UTC 2026
  Status: On track


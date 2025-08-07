Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B1A3C87FD2
	for <webhook@archiver.kernel.org>; Thu,  7 Aug 2025 05:59:08 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.37])
 by mx.groups.io with SMTP id smtpd.web11.44467.1754546339760033528
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Aug 2025 22:59:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=QeO+iqu8;
 spf=pass (domain: siemens.com, ip: 40.107.130.37, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xBf8J+yUj2ENWt2GkvKDz7W9F0lJ/4xBscoZKeg3Rc2byqjj0bmk9ZZcI1dKxInmdCo/X3ACxrjp3u/oKSnB8R4tUpkKZSruPBt/+U9Qpdmk7J8X1IwAVxFrWHDFmO5AYxQZmZ0QKE3Vc7r/JegbbT04cm+SwItR8IxtNqazEHwPUMMouUlGgBf4APDuTumkA04xZEGI3/bYZm+E3YEdQGt+U2cCbr635gLsI6F3MGOrwK5xC956sm0J8nTWWlS4IbtA7kWq0FnhaJsao6BqN25MRtb+0QAXcFZIjOqFfr6kohVDhd9OTjNr8OSr9FqU1iREA6Sp/Ho0s12wHhKbFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m6F7HF8A59QsdB+O1sFp+cfmzSNDtChVp/4aJ5wzrt4=;
 b=mv4q3ECVtjB7UqDIdhxi03peU8h3ZfJhhBlkgzt/RDxOUJa0lqNhT4sn5Ni1szupiqz4sy1K1GkgfI81HnCEYHg4IfETz4vG9TnRLa/vVfNWDuzVJ6FME6TDpy2HuMVPivn450l+Fsgn2bkcdLh9S7r0rfN8Re33Zo2zvHZX5c/wtpoUh/irs/hy7AbHSvqgIjb5uKdKuONPfL8CzoRTvW/1hGdU9sUiydIxWYgON8IOVhynkV25saw+9z5oDlYzQflZNoHfB+Zgptk+o4S0Y3+N7KY79z6Xm+mvuWkqb1QK4hcaP7dx1kCgkowjlBnbucjpJTwnj825uFfPktHcnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m6F7HF8A59QsdB+O1sFp+cfmzSNDtChVp/4aJ5wzrt4=;
 b=QeO+iqu8mMEphM/7ygUEtUjgNbTwQDyPqDTOORTrCVb+K8SaUeG1YoDJEkU4AVfUXVrBsyBQ+ptHPl+Mg2uompS0ACLTIToInIT1Gq1jkjntZg466iq1x3XEXvVfUnfntG1Oluz1Fj5ANzSSPABB3P/8nUx6f4YX2FUyOxcUaUd7W8zHrDfW18YLr65VaReGVcR7lklX/U8PdVvTLa6Fr5DYqMSDJKVef0P5nSQpfPdyI3law/kXdoP7QLEXw+mukLhZBey7rcK0N5lKN0fgqxUAvBbcO6Hd8sdOkGrLONOYb4QQ0PrzAYSpwZ0x9eQtO/xS7FK6w/maMnRDJeBr3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6035.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3ca::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Thu, 7 Aug
 2025 05:58:53 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 05:58:53 +0000
Message-ID: <05a1ea97-c990-4d01-939d-72a14eba7334@siemens.com>
Date: Thu, 7 Aug 2025 07:58:51 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0014.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::24) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6035:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cd52b3d-e7d2-4a4c-b0d3-08ddd5777d38
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ZDhSTEhuNUdtbXZYbzloY0pBSExSbTZVWkxsSllTKzR2K0VJMzN5QnF1OE1l?=
 =?utf-8?B?MmVqZkYwWCtQMjdDK1Y0dGRkeHFwYXVIbm54dkR1MWpKbUdabytwR0FiTVF1?=
 =?utf-8?B?eUd5S1JqdVk3S3JvRjIxNWFXMHhRNHFZWVlLc3N5S0duSnpnN1dLMmc1S1dV?=
 =?utf-8?B?Y3l1N0JQZzJJaW0vd295NE11SUJ3M05IUHloOEJUQXc4anhkRFpvcGdNS1Bx?=
 =?utf-8?B?V1dTU3RldU1LVVJuOUpHSnROdnVtYVkvYjU3QnM3dDllRXNtQzQ1VnRxQkZB?=
 =?utf-8?B?NC9SU3E2QnJackhnSXNVcmVxRHJYaUh2Ym9vUHNNcUNyOWdiRzdSZnZEVjNr?=
 =?utf-8?B?cWdtRlNyclNXMUFMYXdjVXZPOGdIZ1QrOW5OdVlENi8vdjY4ZEVNcjdEYmRG?=
 =?utf-8?B?UEZTS2xCbktmRmNONkplMHFEa1JqNlNhS0p6NXJ5RXVRUUxLbzA1clN4QVpq?=
 =?utf-8?B?YVg2cnY2NHh4Q2NLZUFpZVVYVUtSRThua284SjR5N2RtWm1RVjJNVGVtZHZD?=
 =?utf-8?B?ZmpjVVFOcU94TnorT0cvTmdIcU9kVi9FYy9UMlRzKytmcGt4dXdLL0lTdTRs?=
 =?utf-8?B?U1hzTUlPL2I1dEQ0ZEwySTA2YjBrM214eGs2bXVhalZ1WHVBazFBNE1aMEs5?=
 =?utf-8?B?MWJ4Wko0T3UyY2QrQnQ0WWU1aE9SVmxnVmkybHZYWGd0U1FndUlVVllDaUVS?=
 =?utf-8?B?S2g3Z2MwcFpOUGM5Wm5aejRGb2I1endJTkxlam44ck1xR2tXR3p6ZFhCaVZU?=
 =?utf-8?B?alBiMVgzV3JWbzd1Umo1aHNPNkIzVzNCK0NVRmZnaDZpa3NoaitnUG53R1hZ?=
 =?utf-8?B?b3hJTG9vcFIyRzJUWnQ1YmRhK3pwS0dBWklacElLbnNkRHZscTZnWVZ4QzVU?=
 =?utf-8?B?eWVmSkdDNnZMYzl3NnRyOGs2REtndVlLWko0ZEVUOGdPekIyNmZsM0hoZDdQ?=
 =?utf-8?B?OXFQa0lJVHZLZlFhNC85d2thdytsRWs3NVFQRjN3SW1BZkluaEtseGYyVUli?=
 =?utf-8?B?SHkrV05TaHFINE9MR25uNjhBZXJmQXhVYyt6WENoWGZjREdMKzVrUGRqeWxM?=
 =?utf-8?B?QlJSRnMwQWk2NXBONS9ha3YyYytaYnF1U2lUK2d4eldqZUVINDlxZFNWdjV3?=
 =?utf-8?B?dGQ5c1NDZDYwNXZGbTRaTGpZL1BDZVh3OHp2ek5CMXNPcVphdklOcFhRSTN6?=
 =?utf-8?B?aEpIejRJNjFmT0xLUzlmdWlkdXljOURmRDBqTVlaci9vTG5lWStzYVE5eDVq?=
 =?utf-8?B?OStEazZnS29JRENJbVRDd053b1VSVHdQLzk5NFpGK25XU3FLZzBMMldqTitK?=
 =?utf-8?B?eXZWRUowRlhoam0rdllkYWR3QlZ0dnl1WUlLc3dxM2FMZWFRN25CVEp2SjVx?=
 =?utf-8?B?UE1uK3ZDSFpNUUlZeEVaaTl0UzN3VGNVYkV4dG1VZzB2YTlDWnA0OUxLWHV3?=
 =?utf-8?B?Q2NTa2x4TTJCRWdOaHoxbFprTUpLVFJZVjUvMXh1NUNsc1p6dEh5anc3bXA2?=
 =?utf-8?B?WW03YmNWamdoQ0J3SGJDTXYwRjZrUzhwN2hjazFHbU1pRlRNTjMvWDVuVTdT?=
 =?utf-8?B?MFI1YjB3Mkgrd1BJMjN0NzJHUkI5ZGMrZWsvQ2hHZWhBMk9JdDB2T3o3eDZq?=
 =?utf-8?B?emZTQnMzOVdyc1ZtN2h1dXVJcTZXdTlrSjFSTFgzaG1aMVQzdHR4RzNEbjMy?=
 =?utf-8?B?R0pOYWkxWW1PVkdEZkNIMVVPRGF5S25peXJ4RW0xa1BRdkpsdUgwbG5xV3Jn?=
 =?utf-8?B?YU4zQjc3bFVNS1ArbnV3c1p5S2kyT3dzaGpiY3AweHYwTDJzRHJNTmxQcDNX?=
 =?utf-8?Q?18yOX9ptBL1xwZmAx0bJWYhGlMSwm+72PmjV4=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZUFJUExOclRjemxSVkFBMldCT0cxVEw3N0FGb2xocXk0UDJVL0NQd05PRGFu?=
 =?utf-8?B?K0lDSEc2MTkxUDEvcEozTjhTVXdJOTBCVG1hT0lCVXRFNjBaNWhQMXV4bFJU?=
 =?utf-8?B?MlZnUWJKNGhFMXhNbVh3akFyOWZlbXVONi9tVFpVdGwramlFZ0tYdlFEWllp?=
 =?utf-8?B?M0Q2U2l3QmtTYXk2TmJRaWZTSXJ2UmlEQzhmdmpJVE5VWmtHa0VESTdFRkpG?=
 =?utf-8?B?WGVFYVdEanpWaGUyMysxZ2ExSStYM0VZU0p5ZHAyUVZ1QVh6T0FUd0xocjk3?=
 =?utf-8?B?bFZYUFJQdnJTL2ptblpjR1pKUlNpSmRlbFljSFhkdUNjVWRHSVBrc3Ivclox?=
 =?utf-8?B?RU14cXJNL3VkbG5pSWkvOWUrUkRmc0pycXhiVlM0cTF6T3BUNWl4V28vWG5W?=
 =?utf-8?B?aHlHZnZzOUNFSFJqTCs5RnRUN2FEanN3bENYd3I5aEs2eWR1cFlMNjFhMUZF?=
 =?utf-8?B?WmtBbHU3VXpCNFpRUlF2SFJJUEIrYm0rZkNvUWNJSHlraldCcUxyeCtRVWtS?=
 =?utf-8?B?aUpMN3dPRmNub3AzK1pmZGFoUFZ0RVR0NWJRTkpZTU1zOEdIMkpQSzJlV0tz?=
 =?utf-8?B?SWlTQWRUdWRTU1ZkanlNYjJyTFlmT3lHVVNyVFJhUkVoQ05kVkh4bTJVaHFi?=
 =?utf-8?B?Yk5GemNvNDFFaTEvcHZEMDBBSXNUWkRxdE92U2tGUHAxZk5iWFpacXhKU1A0?=
 =?utf-8?B?S2U1cDNaRFBVcVFMYWgybzRuQmQwMm5GWU0wdXkwZGFndHUvY3RPL29QUHpV?=
 =?utf-8?B?KzA0STBSOG9EZ1NsWFo5a2pJUHkyWnFSOVFHcVAzWlgwUVpmakhkZkhQWDFE?=
 =?utf-8?B?NGZYdmtFVlVQYVpEL2Z3eDM5am9tWDhzWU10RjVub202SmxxNUF3ZXBZS1Y5?=
 =?utf-8?B?UWlmUHBKa2F5YVN1YlNUQ3VuQVZUcFFscGdUYnRyb3EyQVQrTjNHS0JxQnk3?=
 =?utf-8?B?L1VEeEMzT25PTXJkdG10VmI5RFBEQjQ3eFM4eTdNNDlHaU1sZ1hwbEttMmc0?=
 =?utf-8?B?cmtLSDJaLzViNnpDL0ViTGozSEhqMmRUZVNiVjUyZDJNY3pPaTcvMUx4cWY2?=
 =?utf-8?B?QWVEQjBoSWg0Q2NpTklVWUxDS3E1Q3ppUUJUTlBSaDQwVXk2dzlPOUhRRnpL?=
 =?utf-8?B?R0dSaWpRYjUrSXRZMmp5RUhJVjN2N2Z2TndnU1daTFBtRmYwbXlXb0pVS2NV?=
 =?utf-8?B?a1RNNC8yOU5NU0w5Y1M1UFJQaGl5a2U3YkRnRVloeFVZUmt2NUdrQkw3R3B2?=
 =?utf-8?B?U1I3c3paSTJyVHlCbFc4d2ZBWmFubGx4K1dFTnRkV1E5MUtpR1h3WE1uT1ZN?=
 =?utf-8?B?OG1DNWpsZ2lTNGpnNWtoLzBSSGdXN25MZXpuaGhIZEFUbjBYV0o1R0JnN1V1?=
 =?utf-8?B?SzArL2VPZTR5M0tLTGk5WDNVWTR1MUp5QjZ2MHVFb0ZIak8vU2R2djBrejVv?=
 =?utf-8?B?d294UGNSZ1c2bnJCbkE3R2dmc0paQ3ZxQlphcUJlVkFBdXpFZ3lZTzFXaXk0?=
 =?utf-8?B?STE0VlF2c3U1Y29sZEhPQVZSeFgvVHdIdE14QWV0K3pac1NOTGh6bm8zS29r?=
 =?utf-8?B?M0lQZGl0R2Q0aFJDNE9KZHFOME1nWWxlVVdEQTRzYVo5RzBHVHFhazBZSjNq?=
 =?utf-8?B?RVNrcEpxK3g1MXBxdHBEcnBwM0xKaG9mcHFUakt2OUI3RVI5OCtwbVhwaWhu?=
 =?utf-8?B?aGQ5RWVFT29naVFIS2hHRGMveWFyWS9mcENZcUFhN0hUS0t0ZVNoc1NhS25P?=
 =?utf-8?B?ZXdrbTVoT2VJOE9EZGNPdmhBU2ZvZWhNTm1UYWROajZ2bndtV3lxOTFZa2ZG?=
 =?utf-8?B?WUQzZHdrWlNjNm92clNBWTB5dERCeXcwV0QxSVFzMU9ueDRVb3M3UEpHVDl6?=
 =?utf-8?B?LzFici9Hc3NZWlVHWHR1M3l3ZW5BZFpFdUpnV0xGdTNuSTg1bTc4QUJyTUtK?=
 =?utf-8?B?VVlVc2FtVitYN0Z0VVFzMGNudjNTZkVJekIraVNtSGszSTdwTzlKRG1UOWUz?=
 =?utf-8?B?WmtZQkJLRWpnckljTnlYUzRYZkJmS1dxTFBqcEtxaW80VTJsbmtNckRnOTVn?=
 =?utf-8?B?dVAxTlNSOHMxNnRrYlhFRTdSQXVOQjE4SlljVE84UEJtblFXcHZ6amwrVDVr?=
 =?utf-8?B?eE9XVHVtTENXd0VZOEJjODRaOWlYN0d5QjVvZ21DMVRMK01BcXhyL1ZOUjJu?=
 =?utf-8?B?YVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cd52b3d-e7d2-4a4c-b0d3-08ddd5777d38
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 05:58:53.7657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k1XDKBbO/7RQND8pmc7It66Ija/kNXFy84dOia9TY6yVaBN4fHpFQwBp8WbseQsYKXR/KFRkuVO/e9LAhNwpQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6035
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Aug 2025 05:59:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19703

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2025&month=8&day=7&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     14:00     15:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2025/07/cip.2025-07-31-13.03.log.html

* Action items
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB

Jan

[*]
Date the data is created: Thu Aug  7 05:57:37 AM UTC 2025
linux-4.4.y-cip: interval 30 day
  latest version release date: Wed Jul 30 11:27:27 AM UTC 2025
  limit date: Fri Aug 29 11:27:27 AM UTC 2025
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Thu Jul  3 11:41:37 AM UTC 2025
  limit date: Mon Sep  1 11:41:37 AM UTC 2025
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version release date: Thu Jul 17 08:30:58 AM UTC 2025
  limit date: Sat Aug 16 08:30:58 AM UTC 2025
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Mon Jul 28 11:47:40 AM UTC 2025
  limit date: Fri Sep 26 11:47:40 AM UTC 2025
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version release date: Wed Jul 16 05:30:11 AM UTC 2025
  limit date: Fri Aug 15 05:30:11 AM UTC 2025
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Fri Jul 18 08:16:28 AM UTC 2025
  limit date: Tue Sep 16 08:16:28 AM UTC 2025
  Status: On track
linux-6.1.y-cip: interval 30 day
  latest version release date: Tue Jul 15 04:51:02 AM UTC 2025
  limit date: Thu Aug 14 04:51:02 AM UTC 2025
  Status: On track
linux-6.1.y-cip-rt: interval 60 day
  latest version release date: Thu Jul 10 07:45:38 PM UTC 2025
  limit date: Mon Sep  8 07:45:38 PM UTC 2025
  Status: On track
linux-6.12.y-cip: interval 15 day
  latest version release date: Fri Jul 25 07:26:07 AM UTC 2025
  limit date: Sat Aug  9 07:26:07 AM UTC 2025
  Status: On track


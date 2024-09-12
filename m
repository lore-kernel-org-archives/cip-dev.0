Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00036EED604
	for <webhook@archiver.kernel.org>; Thu, 12 Sep 2024 13:17:22 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.81])
 by mx.groups.io with SMTP id smtpd.web10.47577.1726147035105659538
 for <cip-dev@lists.cip-project.org>;
 Thu, 12 Sep 2024 06:17:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=jfYCcb+v;
 spf=pass (domain: siemens.com, ip: 40.107.104.81, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=id+L5/7762DtHCKTIYsRa+l8rF9nm/9L/sFpLe8SBcZ6X3xxOeyq6z1kHtCdGwN8RPr3Kil79jbBZAgNTE+4s5Z8alniC9HH+Trdj2zy+7uZInVmsJr0NiyWL9ynBXkp9uOeVd/fkiSAkxBiOzHTiUzgGYdyKq/nVV/XN7Iwj7nYTKuq++hn8k/Up1DQRUBSwZt2nxR/Vcyux50tQKsBPy0FR/qVDyrm9DK9xOV6Y4Bmd3OjM7jhbWPFdPlA7HW5eGnkS/ioIoaz208rhpP+fBP7OKyZ+5TGNVIQawTgzzallWjaeA1lh6NhxnSC1ZXMmbxHFgrSmycJtrHKQZwB0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wOlivVs1uMJV2tUeHCK81nMa3stvkAK2b/EH8y5zNdc=;
 b=rh+he39uGeuOhQg/D8LlSLXcu11eaAMYg7meLYpj5zMZmvcjxd22tYlBt59Ofc+RwE2OarIXUKXUX7WebQwip8DKuAVg7X2boyssYMy2PEFS3YCK/GCv8GTNAv39jt8CbaWctQulUFGmvqV/vq1jkHmGY1bISx1ybZ8Jwt8FdMUDZPt7aKfhKT0iPbKh2qUZQjwH7odYVPS7tDVtMx1qtMssZABr6k9WgA9eTKriG49KHHKM08Ij2mKm+1kt4FznPQf4LEfHo61scmwQ+Dyzk+vTATS8GQQ3EDAkw028+vKSVxFiyCJkjBZapVfJmx7N/L1mfdo3LLIcKAXsEIqCjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wOlivVs1uMJV2tUeHCK81nMa3stvkAK2b/EH8y5zNdc=;
 b=jfYCcb+vc2dRyeD7bGdZtX18fVVeGxkwp4Eqv7GKGxhQFOS/x10E32uEfJX4LFHP8bghu51ccAUs6YjAzIJdwwxb3+R4lBv3alj4eOPfNGh4Dnj4o2mcqszbptDLhgmH+htStCksESdXUraackPbkan5isxDZqhcTK8Msj6UztJz8kvBMYz6GTKCZ1GUuB6nUiGF5ANBN+9ULVFozV+xRq/glZqzq+KR+X1s9nEK7yZtpAqfMEjzTEt3vM05/5oVcCAw3b58awzr62XBymoYQacYhgKEAoMKJnCANwo4Vus5QpADF8PTF+pG+9Ck6LJsSuR7l6ZcnWvR/xfI77yy4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB7224.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2e6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Thu, 12 Sep
 2024 13:17:07 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.7962.016; Thu, 12 Sep 2024
 13:17:07 +0000
Message-ID: <fcbf9a38-c3e8-4ba2-add4-16c860c49dde@siemens.com>
Date: Thu, 12 Sep 2024 15:17:05 +0200
User-Agent: Mozilla Thunderbird
X-Mozilla-News-Host: news://nntp.lore.kernel.org:119
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: Kernel WG meet-up at OSS
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0219.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB7224:EE_
X-MS-Office365-Filtering-Correlation-Id: a0d6ffb3-87f5-4969-ecc5-08dcd32d33c4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?dHYrL09RdXVkYnBWMHpXOENoWXBPMVphR25qNWlnSzRoeHZyV2JISUNnM1VR?=
 =?utf-8?B?cGtLWXFTVm8yOVV0b1o4T3c1REQ4aHFZcW9pdSs4NTA0SXpzR3FSelJwZk9U?=
 =?utf-8?B?am1FSk00N3Q1NkFPT2NzYnBrVDE0YXVzSGtub2ZjSXNCYzAyUGhJOER0R3ND?=
 =?utf-8?B?VXduQk5tcmMvY05JQjNqQ1pHMmdPSTNtWFBMUnBUTi9JcjZtRHN4dWw3MFBX?=
 =?utf-8?B?Y3A2YS9JSk8wdzNSTDh5bTNnZWVJR0hRVXJ6cC85Yitxb2l5QlduOUNBa2I1?=
 =?utf-8?B?TDJlSGxHWUVGK1pCR1E5Z0NDSUxDeTNySVNubDZBaGFpM3phaFlXUGUyejNR?=
 =?utf-8?B?ajRFTmxXQnphd2UzSjNnejVXN1diNFpjSDdGZEhQK2dxU20zRldTNkZXSjNB?=
 =?utf-8?B?VGxzOVUvV3JFQzljd1ZGS3RFTG5VV0hUT2tKdStHRUF0VGNCMmQ4eDg0ZUZk?=
 =?utf-8?B?UU84amtISlhoYjJJRG1PR0IvMlhtejRDc3RUQVRmdTRQaWlwdWRDcWpySjhE?=
 =?utf-8?B?VFJ0Tk8wYXV5KzhKVmJoWGt1djJLeFJkbC9HQlpEWWRRSEYrbUt0Y1BTOVdy?=
 =?utf-8?B?akd2aTg5WVl0YWp5dUpSeU5YT21nRVc1V2l0a2VyVWVMY3BlQ2J6UVpHRjdN?=
 =?utf-8?B?eXE5K1VFSGpMcGNVczBlNVlUZjRXdmhJZWpaSUNzK24wWUNVTThodGovRlNT?=
 =?utf-8?B?QWpkaURQb2M1OVBTV1k5RlcxN1JVb0w2cmxXblFmMXVOZ2FwclhoOUkwdi92?=
 =?utf-8?B?Wi9jeTJrd3hJbnJNQ0V5dWdFSHBSR09maHl4a2FoeU9wN0xFUmc0eVdKUDZw?=
 =?utf-8?B?VURTcTJUTVFpU2d6bHlKNmlieDFlMTE3d1BPTDAxcFl2QitxQUZZSHJJUFo5?=
 =?utf-8?B?Y2VpUzhwVWZhYWV2aUhMeGQza0E0YXBQOHk4ci9GYWtWTzBBUmpKT2t6S2hi?=
 =?utf-8?B?TmkvRnBLTkVZbWtWcDh2Y2JQSVU4UXdBSzNuRnd4U0F1YXAxUXBnZUpFMWI0?=
 =?utf-8?B?TFY4eXBmL3d0aWQwdGMvMDdzMXF5MHZNRWFBZXlXa2FHNVNzNFdLSGdmclZR?=
 =?utf-8?B?dVExeWJjZVpQMVhzakdOVG1kY2N5MVBNTzU0WXd6VDRUckQvNFdRZGVuZU9W?=
 =?utf-8?B?RHBtbk9IU2U2YVIzMmZwcUNzMFNUZHZQbTdhYy9YK0Y3eHlyVmRpd2JBOEFG?=
 =?utf-8?B?dlcrbU9rTEVKM3VNTStDYklsZmZ1a2h6dFh6eFNuSURUWHNwR2hSZDlTOTlW?=
 =?utf-8?B?S2dzNStEaHlkYmRMNzc2dU40Uk94VzRCMXJQMHlUdkN2cVlyMkJtOHVoMHBJ?=
 =?utf-8?B?VEJQRnRuc0pxeWFKL3hoWlhpUVNPNzN5T1doWFpna0F1U3VacUZIeG9tR2Zz?=
 =?utf-8?B?ME5iUGxsRXd5b0dTZ2ZvUnZOTklGWnd4MWFzSUpvV2tEQVhCYUV0bHBwdTF1?=
 =?utf-8?B?Q2dLamRqTVpnZzFkRVBvM0lIVk5ZcmdxTEJWYys4eFZrYTRkcm9POElMQmMr?=
 =?utf-8?B?R3BWMzdyT3NaL1l0U3g2TUI4TTQxVG41NGRodjMzMFlFZUtKbzFtcTZDbHla?=
 =?utf-8?B?b1JUbnBMWG5YUGZBdWZOMno2N1c3TmhaVDBLeGh5QW9mKzUvalcwNE1rREVj?=
 =?utf-8?B?b2JSanJidS9kK3pvcVQ5NStnZ3h2aTJnN2VTUXdXb0w2U0MrU1F6U25jQVI1?=
 =?utf-8?B?RlB0SURvMUorUWNjek9CWjhLQStNNU9qRVMyWkJoR2o3emFyV2VWZlhyOENN?=
 =?utf-8?B?TVVqbHJCeHZiMjM2WVU0dks0dzl5OTk4QzNXVitmYkFlWUMyV2plSWZFb25a?=
 =?utf-8?B?VXhDTkw4WnVleTVJSjBpUT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?S3V4L3lYU3dHTy82cDllTXREUUhGSDN5SGVnZ1hnWUZJRGk2cG44OC9QK1dj?=
 =?utf-8?B?VGV6ZFRBOS9laSswZEZ1eGovcFdyblQ4aStrVWJ6cmxMT3p1ci9zUzB5ODhn?=
 =?utf-8?B?UXdHNkdPWFdxdkRnOUI5bTRiOWVUWjAxOXo4V2cvMGZ3SFZucXNBTUFydzMy?=
 =?utf-8?B?c1RVNzRlUjNpVWNBaGQyWFhHSGFhOGY5bFN2SVJTNU8xVk5laisyYUErbEM0?=
 =?utf-8?B?M0RVakRNQXhKREwyZW9VZnlXUVVWeldSd1JhNjY3KzFObUoralFDYkZ1Mk4z?=
 =?utf-8?B?cXBZWnJZamx1ZW9zMjN3d1I1Ky81emQ3YU9VWGYrVC9FODZqYUFUSk9tV2ww?=
 =?utf-8?B?SnJiTmZYWDIzY09USnA5SDhrRDhvQ3ZyTXRMaGI1NWRZMjRjL3hSSGpWbDB6?=
 =?utf-8?B?YUVVa1cwSzlJNC9NWlBtQVpMdVorZG0rdUVQUUlwNjRreU90MG9DRXBlSzU4?=
 =?utf-8?B?S051TlJ6Z1pzVUFxWnhNclRzeUZHZjV6REdvaGpmY1VMalFSb21Vdnl4Si9k?=
 =?utf-8?B?NS9xUlpKRDM3RlR6cWFXWU8ra3IycCtpMWk0V2ZVVEdkd21MNTdxZk95NHdF?=
 =?utf-8?B?R2Y2MW5GNk9ncndWODBWSFBIY0xiRUVsc0IwVG16NGxwdmFLcE5SUm5wOVIz?=
 =?utf-8?B?YzM4dVV5bGhoRm93WFN3Z2N5akszSllFSUVnYUtkcmlFRnVYNzhHVm9GVVhY?=
 =?utf-8?B?SW90L1Q0T1dXNThqZVJUOWR2MEVqVjVTa0IySEFxS1EzN0IvLzcvdkJUWTUw?=
 =?utf-8?B?Wkl4TlZZNFh3MGIyQWgxemxiVVRyNzNNcFg3bUVqYnQwcVFod1JtZTR0a0tO?=
 =?utf-8?B?ZlpZNTAyVkFuV2tYU0RKNWk4ZDlyZE9vSEF6amVRcGw1eUZMdEtVdWk2VVAr?=
 =?utf-8?B?SHhsVnNCUjBxRnZURGw4OTlIRW4xdjUvWVU3cGt5OVhpTEZWK3FDWDBka3dQ?=
 =?utf-8?B?REpubzRaM2w3UTcrQ2V0bmR0N0RKSUtiZEZUa0IvUXpiTlg5Z0dBWUhFdDRM?=
 =?utf-8?B?VElpOFUwRTdHWElFT2p4SGpEdDFrSmtBMXZZTWFiU21NK3VOTjhUQnlheUg5?=
 =?utf-8?B?eUdBbjh0dEQ0M2VQV0I3T3N6MVFoaGxEUitwVTBOU0R3T0ZkMTh3c3dyajYx?=
 =?utf-8?B?V2VDYmJWa1A2QUEvRFlyMFliVmxTcmQ2MVRTbTBrVm5ETmIwNWk5STRVNjhv?=
 =?utf-8?B?TFF0QW9OalBXSXNmZ2ZjWWdyaW9nR0hWamJtNFhIR1ErUFBDbkFHamxKVTZO?=
 =?utf-8?B?aU5Ld2VvTG1ZYm1GSE9PUGl0UmpTSWhXK2d1c05LQkdkSWpucmIrOEFueElw?=
 =?utf-8?B?M05IRlM2OWY0dlVPaENDNWxXQ09uQThYazA1U0lKbnpGcVRyWExJQzlkaHE5?=
 =?utf-8?B?ZVlCS2pkQ21hQ2xFd0c0US9RNmhBemlpSHJQd0FkRSsxakhUeXRFYmFVeTc5?=
 =?utf-8?B?YnU3Y3JEaHUzQXUwQkxEYjRxZVUrWURnVjVFNGVtWnNnUTZJOHZFSXNSdnpk?=
 =?utf-8?B?em5hVFFDSnpqT2JKVDlGODRYUHRLYVpPTnJIMXZCeTBZOXpWQTcrclpQSzZN?=
 =?utf-8?B?SThTZzFvUVp3aTMzWnI0dzBEdWgvZ2ZmcDBrL2duSDJUZGNncWp5cDlxMWxt?=
 =?utf-8?B?VU9yNVpZaERsdCszQ01jQ210QjFURE0vbE1SVFRtNXhkaWdnWTkxSTRaamZp?=
 =?utf-8?B?eC9iNWRYWjNvcUVUamhXWXhBRU5ITjJMSEo5QXRzUkIzMlJwTVBxQTV4Z3Jk?=
 =?utf-8?B?L3RHNkl3SmFvRUhxVVlBdTZ6OEdjMlJPUTBob001QkkyTU13VjhsZUdscXMy?=
 =?utf-8?B?ekZ5b21YVWdDem9kSXRoeE9ULzJQMkNyVUlGMExHK3JXK2tnQWJZSURPQzVw?=
 =?utf-8?B?bSs0SGJXaXZ2c3RidTlMSFVwSUI2NDNRTSticWdKK0RXSVF3Zllnc1VpNUhU?=
 =?utf-8?B?M21QeCt2ZVdwNkJMTXUwQkpsaVdQUzNKbWk1d0hJZFRsSUhUdWNCOU4rY0sv?=
 =?utf-8?B?c0FNSVA0dTBOVEVEaFNYS1g4Wkw2ZW9taGZ2RjdOMnM0TW9WOU91Q2loMTIy?=
 =?utf-8?B?aDZzcUJFdEJRWFVGcUwwaWlZU1BOdVNBSWNjcksvSWkzaEo5RHdWa2FVOWVz?=
 =?utf-8?Q?5/vf+MK/OtmL+v9Xx18BFyw33?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0d6ffb3-87f5-4969-ecc5-08dcd32d33c4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 13:17:07.6578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qNCa8+KQwirZz9Ud9Cx0X7wxnSvZTYBSzFkL6LFhsKk2qwEV63Pi8GzD4lfiOT0zrKSpv/gTHXZOH2ssCpZIpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7224
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 12 Sep 2024 13:17:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16896

Hi all,

the kernel WG plans to have a face-to-face meeting during Open Source
Summit next week in Vienna. We will gather for lunch on Tuesday, Sep 17,
around 12:30. Meeting point is TBD and will be shared next week. Drop by
if you want to listen or have questions.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


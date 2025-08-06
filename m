Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9037FC87FCA
	for <webhook@archiver.kernel.org>; Wed,  6 Aug 2025 07:03:50 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.71])
 by mx.groups.io with SMTP id smtpd.web11.19371.1754463826189355965
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Aug 2025 00:03:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=wyiq7QjC;
 spf=pass (domain: siemens.com, ip: 52.101.70.71, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=icZ4KmvcPElYosm3QYHCjEh6ybPof1vI5fnkWNldoRoh6YKDlIAPIWEgyTC7+FLs3FRN6G0J51SDZCCtEYbfHZUsDFt4BwhTr7RQLK2kBEcD5W1PkuzRbrKEHgfNKj3FWtnm5WuzEdumHQER9XJAvpN7vW3U7oST9gxmGbKzcTSTlnyS4W3gpnS8ofMUfAKS31NsTqqL7MZd//XDBDFJHVIHS0YNFvqtz0LAOM/15u/Gfv3YVXK0GwPaGGAcRkUhljQ+aKOpwefQzbzounodoBNX8dooVEMG1k714TEIpBuYWvy5Y4LExhw/QFf7iM0zt93YnsMiWWg0NaDXvddWIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pqKAvs4rrm5XthAUYdrPgw5kDMI/CNYg29sF3qACm0A=;
 b=LucvN3yLKlJZWkic/6qpsj+hA9np2VZxXIc4Txy1ZezTFmwUC48r6d7qCGRC0d2pJkZpD1lgrP2mMHpNkbzAR8fJCBJ16u0e2bR3B2o91zINcQ3qq8Ztwy8Zas/ahksVqL/TyHqIAzqTBJuo7ZAul8Pmf2j60jwbtUuKddXUMQfWOdUbAv0mZLSp6vhSCOtIKWjnLLxOTlQ/cFf9LM8haTfY86Y1iChBC/vdB5659VxpYS8mnxcqSTBhHleDxYOf4BX2JRVkpIqLpsfjbGOuEuU6Lfk53DTT5JcLkpli3plkqqecDUQ02gkpX3k2eo2HDHyqWs6qdNybPnrqSzEvqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pqKAvs4rrm5XthAUYdrPgw5kDMI/CNYg29sF3qACm0A=;
 b=wyiq7QjClZOd1bKftpYs76IJPkTcxe27ZI/pTFZSqNy9yhrlaGImtPp4aS6eRwWkZvRiKHbBO5zCIy3USDoB0ZvgW6RbpcuI9TVCzKczD3a1Zg58TqWSaD0EJUJAwVoOMsmi8Eg7CtO6exit32xkbpqWTtd9YBptbz6FMBCpGQ4FHmN+brDs0xIGuObYZrrRCaxRZXWDE9xUmqFGoCJAsTfZSNOi+NXMjN8DuK/QZWN1V5HOjkzYSyI+p9qqZBpd6D6KCKEOwbNXFSYkXnFXZk5l8J8ZrC4NPAt8255Goi0A/QYO9jmgb5E+QmO1X5xw2wQttBCy8oFv/z5315AR0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA2PR10MB8874.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:421::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Wed, 6 Aug
 2025 07:03:42 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 07:03:42 +0000
Message-ID: <207d4c00-8e53-4a3e-94e5-adb1e9b0b7b5@siemens.com>
Date: Wed, 6 Aug 2025 09:03:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] edk2-standalonemm-rpmb: Bump to 202505 and
 refresh crypto dependencies
To: huaqian.li@siemens.com, cip-dev@lists.cip-project.org
Cc: baocheng.su@siemens.com
References: <caf3732b-c31d-4cd0-b479-7a55d56973ef@siemens.com>
 <20250806065505.1524960-1-huaqian.li@siemens.com>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250806065505.1524960-1-huaqian.li@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0155.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA2PR10MB8874:EE_
X-MS-Office365-Filtering-Correlation-Id: 99c53a13-985d-46e2-46c5-08ddd4b76080
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SnpkRWdteFhxSkVRNnJnQTVFTWQ0TzVBUFFoeThVMC9NeXVteTQwTWRmVFYy?=
 =?utf-8?B?N3F2dG5MRDVYQ1BVbXpuR0ZwV2VQQWlCWnVEKzJxZGEzRWZqY1YwMFQvTTIx?=
 =?utf-8?B?NTdwQW9DS0M5SS8rUTlpdzNBVVFwbko4WWVCYUJkd1VjcHgxWVhqR3BDeFl1?=
 =?utf-8?B?bGZRYjdWc1dqTmdUcERoTjRVTTY5bEFJSHVESXhSc05aMHRPNURROW5MaVZL?=
 =?utf-8?B?bkY4SlRlYlduOWxvSWtuSDNaeFZqMkZ5bGNZSFBxUlBCRk9NUmhjVnJTTmQ2?=
 =?utf-8?B?RllwYXJiLy83ekt4dXZwVm5KblBZdGpaRFh4eGRtMEk3NVZaQzNqeXJNLzFX?=
 =?utf-8?B?bHdvdHFwdmllVzBKOHF5dlRwc0JNbkhQNnVSMXNWYUFsWWFNZkVqeHNxNmVn?=
 =?utf-8?B?cEdvN1p5UVhWdzBXZnQ2OTl6ZG1TU1Z4RWRzZ1Vub2xFN2RISG9Ib1RuVlB1?=
 =?utf-8?B?VEJmQzljbzNRaGJleGdpY1FmcDJLZ3ZkL1pkM3F1bXNzaE5xalVKcUlielA3?=
 =?utf-8?B?RUdxT000YlZ0Y2l3NU90NDZDWmdmZnNvcHhkaTFEK2hva0hvRDBXeFBGN3ZP?=
 =?utf-8?B?NGoydEQyZ1U1QXBVVUZSd1VyWkthSjY0TlBmMVRoRWpuNXNLVjRYM1ZzZktP?=
 =?utf-8?B?a0R6Y0k5WkY1WE9CT09DRTZRdDMwdHFyYi9wNEFFMFBaV01jbGFsaGptUzZV?=
 =?utf-8?B?aTRnWklWbkhTRmQ3RTRvVFlOZWtBV0lpZTVHQjYrRzVVbXFoMnAwZWFIU2xU?=
 =?utf-8?B?ZWpuSVY3bVVuMlY0MU9JanRXOFg1cWhMeDcrQTc1d0l6blJFOERSVTZvWWtC?=
 =?utf-8?B?YTdhNi9GYmtTTTFtZW5GQVFsWWo3TGo2YTgxOWxjYktmRlhZcUVuYmkvZVlB?=
 =?utf-8?B?SjZ1bkFuMG5ORG5zcWQzeVYyTi80M3V2WWVMRjluTXBTNkV2TGU2bGZsWkYv?=
 =?utf-8?B?VTVRTVI1Z0VaUFdPa3hlZllmR3B4YnBucEV3dDZRY2s5cGhxTHB1VTlqV3Fr?=
 =?utf-8?B?eWJQb0lDL3h4alYrbnNjTHFEbTVRWFoyRS9BS3U5bTBrQlNlRjNYY3dkZnZY?=
 =?utf-8?B?cU5PTEVuZmFqQWdzd2V2Uk9nU21LZW9tOHI4VnorR05kYWZrQXdQeUNxYmJj?=
 =?utf-8?B?OXRPa2h0Skd5TWlrK2tJMGtqSjB6S1FWMnpxVHRpb293dUE0VmMvaC9lWk9R?=
 =?utf-8?B?WkpQMVRQNVoza3dlaEZhUS83b1I3NU9DdE1vREd6alRXZ01VQXQwbi9uMC8x?=
 =?utf-8?B?eWs3M1pjWFZtNUlLMjU0RlFrZHZqb0JZc3ZWRUdNeWtUeXMwc2NoeXBaRUwx?=
 =?utf-8?B?ditVMjVZZ0ZCUUFzY2hZM3QrVjVPZ2s1emlFWE1URGpKMlZXd2Z2TmNXTTF1?=
 =?utf-8?B?OXFHcUJLekRYRjZzYnQyVm1iL1RPbkswZzFNdFRGN3NNZnJaclVLNUR1cDB4?=
 =?utf-8?B?WGlqcUNtTU44b3VzWjFQYjFWTmVGbVJ3SlB0UU9FdVB2ZGFtYkNJa1QzaDh1?=
 =?utf-8?B?N01Uam9oaHVYenRHMmhlellYL0EzOVQ0c0tFT0k4ZDdodmZYdkk0ZEhzMklv?=
 =?utf-8?B?QTdlM1lPOWNDNEphajgyWnNVWk5qNi9SeVNwMWVTR21UYUkzWHBxenEwOEhl?=
 =?utf-8?B?UHJYYjRxZS9mV29Dcm1UeWd2dWgxR0lLajhnYTdxa0lSWFpxNE84L2pBdzc1?=
 =?utf-8?B?NzNxWDVOWDl5dXZqY1oxc2oyOG52eFVpM3FFTklFVzg3VnovbkhJVEJyWEtD?=
 =?utf-8?B?NU9RK1hBcTdCQklOQUJySTVPcFZoQ0JxdHAySXVyWDAwS25JeHlBQnkzNThE?=
 =?utf-8?B?K2N3U3U4ckt6MDNISHppWTlOOFpEWHVEUzkwZENBUm9xb2hNYVowQXhHV010?=
 =?utf-8?B?SEV4ekNsTlhheWN6dDZOR285RnI5SDAxVWU5YjZlL09CVFZTaVhWRHJQOGZn?=
 =?utf-8?Q?zB7796kCkw8=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ajFNcDRrUzFKRmM1ZDJFMDcvbXkxYy9IWFZ4WW5EeEdEL2hlOWlwYkRHMkZI?=
 =?utf-8?B?ZWgvcHdKdm0yNUpESGxNYk1VT3BXRFJZTm9ndGcwanp0M2VpNWZVSHNjc0tK?=
 =?utf-8?B?Sjk1N3lESmpLL29rK21qODVYYitTN2dMcVRlUHZxVmp3SENDeHIrQ3pYUDlX?=
 =?utf-8?B?WU92S2Fmd1lBVTh3eXRaeGRPK3VGTk9Ic0JDQUc0YUZuMnJKeTZPS0w0M0lw?=
 =?utf-8?B?TVc1bFV1emdYMDRBSDdUK2VZRU4xWG5ONDUzSStncDJnY0t0N3ZsVWkwYVFQ?=
 =?utf-8?B?MkJyZE9BeFY5UEozVDVOdjN2TisxOGJFRXdBVGIzL3dqNlVDQU1oQXBEZmtT?=
 =?utf-8?B?RFpOeFY0R09JRGY3REdXOTUzWmlPd2RIMXppTkh1U0c0ZXRQRE5Yc2JEN0I4?=
 =?utf-8?B?aW8ybTlkNDJTai91blFGc2J2WVZVNWJBdTA5Z2hKZ0hWQURXbzU4NGtiVy85?=
 =?utf-8?B?MTFkNWx0M0V0Zkd3WkhRajR2SVlyK3BOWVlPZUk0WDMzS2RKdXhWamQxWVNL?=
 =?utf-8?B?WWFhUDhwWFJ0UG02VnBkMWJENzBmd3JjQnlNUlZlSUJwSEdFdkluaWNzalc4?=
 =?utf-8?B?OFBjSDMvclJ2ZzNkM2dSZk5EQXNuUnhMWjVid1ZhT2VIekdwK01NS3RwOWxa?=
 =?utf-8?B?SGMyMVhES1ROZ3pFcEoxRWRKeHNVRGJ3cFhHZnhrSVhxUWZKS20rb0NIbjcy?=
 =?utf-8?B?d2MyZ1RkdzVRTVN5RWp5elB2akFXUW92L1VGZFVFRyttOFFWNzltcDZsbm9U?=
 =?utf-8?B?RTBhQjRMRUN0Q1g2WE1oZHRLYzBvaE9pQVJRYVR1MHUwdFY1emp0VjZYa0tu?=
 =?utf-8?B?WmkrRGJCUE1nbkd5czk4cEJocHhqWE9XN3BkSlVXQ1grVXd0YmUrdjArOHk3?=
 =?utf-8?B?M09ISzdVSGppNUkvNGQ1UFozclIzQ0dmcXZuQzgyamxjaFFIS0Q4U2FRdVBo?=
 =?utf-8?B?RlQ3d1B5Y01sMVAzNjlhbUdBa0YwdmZqOGpRQWliSHU3bm1KZU0wK0NaQTFi?=
 =?utf-8?B?Y0FVanBuQW92L1NjWDd2a2h5YThMbXNqSnE1bVpDeWkwSlB1cHAvOGJTL0sy?=
 =?utf-8?B?bkNxNExaTGxWUTA1cDFRdmlIamwwVWw5b0dCV0lvYy9JTkhCUXJkc3NpMmo3?=
 =?utf-8?B?RC9KcFJsR1JsM0U5eUJDdmxyL3kwYUtNVkY1K0hNemdUdVphc1EyUEVjSE4z?=
 =?utf-8?B?czN2ZHRCZThOWHdCTnlCQVgvMFdJUDhLSEpLekYxUkdSNi83WCtmWlJlWTdL?=
 =?utf-8?B?dDBhdUpzMGVNWXJlRWhFczk4QTZRZHRUYUU0VVlrWmFDQmNkUGcwd2hPcGYz?=
 =?utf-8?B?MEpnZUo2aGgwaDJFT2t4MlFRVEZyQUNIUmJwTGFIWUhIVDlhZkY3UmdvOG9Q?=
 =?utf-8?B?czVLNTJ1MzhvU0E2R3o4WmorM0ErZ2JlRzEwWEdvOFBtR2s5M296SzlLemR0?=
 =?utf-8?B?bWE5WTk0UmhSbExzOVZPbG9PSzI1R0d1UXFSWVRrOWhCQ2VyMzE5eDJZbWlz?=
 =?utf-8?B?OGg0bU9tK1RNWDFXRGVKVC9QVVBHQi90Q1NxeXF3RTIydXBBUlJoejdoWE5W?=
 =?utf-8?B?Q3FCcTRud29NRHhJNWF0QjNtbkNtZWpqMElLK3Uyc3o1Rk9YaTJGSEpZSlZN?=
 =?utf-8?B?UGRUT2VFd2xUdlVBV2QxaXhxU1BZK3IwbmdyeHVFMFloY1BrdHJEekFFSkJN?=
 =?utf-8?B?WGhxYllrZnN5WnIySm45VmRZSGxsNjkxeE1jWldYYUsxRlU0MElUVUtMWHdk?=
 =?utf-8?B?OENCaXpVWm5sY05iVHFyQnVHNDREZGwxTlU5T0tLRW5qbHd1TEdhL2NEVi9h?=
 =?utf-8?B?YlozV2wrSnRhb21ZZWdqYkxEU1I2MDlwZ2U3cUN3YXhnKzRWNStPazU3Ykp6?=
 =?utf-8?B?WVFrOTNaNmg3QmwySGo3OXF4bWpCWmZzZVhJbE9KQ1NkSG5lM2E5M2RyZzBC?=
 =?utf-8?B?Q3lUL2xoV2JUZDd0Qm1iT3ZSMVZKVE1aUjI1VVBMWDdqRDVZdVlMUGtPWnkw?=
 =?utf-8?B?RFp3M3lwUnEyNWhzMnAvektiWS91QzNoTWtSeW5HYWJWL1BwYktudlN1cWsz?=
 =?utf-8?B?cStaSDBwSUhGNFBlSVRqN3J6SGUxbHdxd2tqZ0hzTnNzc0REYVhiK2M5eFpi?=
 =?utf-8?Q?ciOCqUoAAfSpu5b269JlR5x4T?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99c53a13-985d-46e2-46c5-08ddd4b76080
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 07:03:42.1172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WaCphOHxSSo05Inm6OvBx5PyBpdCn45hDT93kkXWmF/Mpsda0QBbsbU8pg4XCZNUuSJbJ10Lnk/kv1IOCn/Tsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8874
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Aug 2025 07:03:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19683

On 06.08.25 08:55, huaqian.li@siemens.com wrote:
> Hi Jan, 
> 
> You are correct. I have conducted the test, and also confirmed the persistent data on the RPMB.
> One of the test cases was to verify the UEFI keys and the UEFI Secure Boot functionality after the upgrade.
> 

Perfect. I've applied the patch now.

Thanks,
Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center


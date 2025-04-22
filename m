Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E23C369D3
	for <webhook@archiver.kernel.org>; Tue, 22 Apr 2025 14:49:36 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.66.10])
 by mx.groups.io with SMTP id smtpd.web10.41899.1745333369263228710
 for <cip-dev@lists.cip-project.org>;
 Tue, 22 Apr 2025 07:49:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=AZ/2G+0S;
 spf=pass (domain: siemens.com, ip: 52.101.66.10, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UHjn1hpSLYiNZa2zpHDlrfxf5ZqsIO3NFaGCCiW/EPsNnzmHVOjBOCnJ4eJz8oQpaNBMgDiv6Ll/f3m7W0HXAD8BdZuIWsUzKtrqhA8aLj/bR5tfJefhp86CIAvW6vSGOlwqvx314J6tIHSIzt6t/8seqsCI9HJwkaJnxx4nrJS39yJvevHuA1vcJM6rAk62ouMjITt7IsMuM+/R9oqRnubMMA35yoGs5jhMeyxX1WWvd0scI3ROS9Urc1hRMyzm5BbFdTJyHiSs3M3hkAndcr/T8hjVeuNpVZh7iDhUKGtT5xL8CYJrweGpVGmBvlgP0CB59lnh0+l4i8RV6UOuig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tx97HT9aFktZNtkfKbrfD6+W9So6HevICCVrBEhwD1w=;
 b=x0Xe8qy5EPxHedwSaV+IVZNoVHYYWHbsVO5ezXoMFqXRLACMT4jJOVQdLBqggEoH/VGqeauc+I0BaOGaUI3qJxqp/cCoQPrIkfUbxX705X16qDDWfqUjd7TSvqMEqng433u9zZmtqWNfmydlwUrDhHPYSv63L5XZIYEcF7WTcm3zhpcHDHaCyDATArt+limaKHJtqvejug44G6VPsOMwbH5C4k2Zfaj5BsH6U/3+hCHcXklqlBxV2yXaviWnLNyKPs3uK75NJwv3T+Biun8HZs66EdepuJbpzrRiiyv0sK4o5RW50LSFX7WY3FtLiiQ3GolL2evjsOsssRzRJm2P4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tx97HT9aFktZNtkfKbrfD6+W9So6HevICCVrBEhwD1w=;
 b=AZ/2G+0SKHAx7vW5OTQOwWAIDlB7K6lSHjE5067EF4/kFF0Ztr/W4ugI7sG60BTkazWgyzpYkV6MR8XGG8K+bWkzg1Gvv8cZ2uqIZH2eNaqNlSAQl39klC+j4En8BDpZxcd8QHTpz8dC/AGO0sX0D3vmklJVqYK50jBit4g3SOdaKrDYx8PiRnE4qgMsrxVBt2lvQHtiBCheurXnM+AFDS+hYNM8H3oP3p6aIgZXWGf91d7WaSabr11aTXUhNPJusMjL8LRSaHf5y+Zl8IIZJNgCJ9HLwV0mqY9NxEvwkwM2qd+VD27Cr877U8wUslrQkrjXD6eb4ZbSaD/qloOmNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by PA1PR10MB9102.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:446::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Tue, 22 Apr
 2025 14:49:26 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%2]) with mapi id 15.20.8606.033; Tue, 22 Apr 2025
 14:49:26 +0000
Message-ID: <12eeff84-dc39-4e8d-b51b-20aaa1b8a802@siemens.com>
Date: Tue, 22 Apr 2025 16:49:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][RFC] Handling UIDs/GIDs on Updates
To: Jan Kiszka <jan.kiszka@siemens.com>,
 "Heinisch, Alexander (FT RPD CED SES-AT)" <alexander.heinisch@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Cc: "Moessbauer, Felix (FT RPD CED OES-DE)" <felix.moessbauer@siemens.com>
References: <AM7PR10MB3320024DB860319B2C1E8D9786BB2@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
 <93fade38-1791-40e1-a759-46a969f1c28e@siemens.com>
Content-Language: en-US
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
In-Reply-To: <93fade38-1791-40e1-a759-46a969f1c28e@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0437.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::7) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|PA1PR10MB9102:EE_
X-MS-Office365-Filtering-Correlation-Id: f3fb88a9-5407-4aea-a5fb-08dd81ace0c9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Q2xZNm9BRElBMjA5TFlrK1puZmhIUG1XbTg0akNHQUtjcXJMN0JFS2d0enVU?=
 =?utf-8?B?STZFWkJiVDl4YW5OWDlnVmNtcmMxUmZSbnZzZ2dBQjFnQTdiMWtTQUxuM21P?=
 =?utf-8?B?QndiNU44SjlReWgrdWtrMERGR09tQldBcEFGbzFwQ3pTZzc0ckpqSnVpRTVJ?=
 =?utf-8?B?azhOaXhuSjVNS1k1dWJEQTNZSExXVmpsTW5GaEJjY0Z6SDZ5Wkx4T2JVUkNl?=
 =?utf-8?B?YW5WUHJqZWhNMnJWb3BWa1BMaFRUUFFuM2VDYVRKTTJuM2RYRFlVYldTdzU3?=
 =?utf-8?B?WSsrTTkyOGdQQTlNTjBiWmpEVUFBWjBHM0RPdVV2Q2ZmQ1R2MS96c25McEN5?=
 =?utf-8?B?OWYvZE5lS09aWFFtM2oxZVBTRXF3WkVmYWI3Nm8vWit2RWd1NFU4ejVWWjBS?=
 =?utf-8?B?ZUpiZ2RXNDNXdFZNWjByc05say9iQmdQTXhBblFHUVJMNWNyNDNHNVZQUWlG?=
 =?utf-8?B?cGd3YmhUMkh2ck4wYnZpZEVLVUlrNnF4VXFPY2E2M1ltUFVoVksrVm9wU1Ew?=
 =?utf-8?B?T0g4aDhsQ1ZHMFFRbDNNVXN1YkxDakVRdHZlZFJZQkh5akxVNnFqczBwT3po?=
 =?utf-8?B?ZHB5S1JoUGJ1VXdvZ0NXckw0Y3FnbGRLdDRGZ3lxREZoZ1l4Y05tVVJJdGNQ?=
 =?utf-8?B?SXV2QlV1M1NzR1ppTGY4elgvUjlTR0xUZ1l0QzNTd0xtMVdBNmNERkNyYmhz?=
 =?utf-8?B?QVI1YVptU1JMVndmczhyT09KUHRuaHpyUnVQV1YxQnRqUlpEN2tLTG9DNkJO?=
 =?utf-8?B?SGZwTlEvNmhTby9pTS9Cd1dQSjVOTnJ6aHNWcmdyN3l4VERDeGZVTUk2MXdm?=
 =?utf-8?B?Zy95T0ZFUmVBOXZPRTBxaFk3WFFHL3VVZjBRU0hLTmJxcWprM3Rsdy8yeVNM?=
 =?utf-8?B?MUF0NTV3d2FjZnlPQkdSWS82b2x1T0ZER3puYXVBNS9iWUxPUkJtTnpBRmNJ?=
 =?utf-8?B?N3BSbkdMVnRPSmlydkVsVkR3cTJaS0xGRit0YXZQQVAyMWZCcHJGbnpKcVpM?=
 =?utf-8?B?NGtLSGJkeGozL1ZDWFV6TitmeU5pb2NQNjFkRTdnOUpIUE0xWFRMTGJjdThh?=
 =?utf-8?B?QU5LTE9wSU00U0V5ZGJRdHlPVmkwRFU2VkZSZU00MCs4YlgzTml1SmNveU5B?=
 =?utf-8?B?c0EwMU9RNTZ4RHZLdFdFVGNPTVAwbnhobjZrbTJQeURtQ05Db25ka2Zsa2xT?=
 =?utf-8?B?Z0diQ3o0aXgxQk16RlZwSUg0bUN6N3dRREtDSkRrZy9Lak9OS2c5LzMwc0g1?=
 =?utf-8?B?V3R2Tmh2TDNIMmVESmp2U1hoUUVOL0wwVXcvMGFOWHlhc3RiSUZ4UzRWNlBE?=
 =?utf-8?B?YzU3VzE5RWwyTlg3SHY4OS9rQ3JsdU1VVGF6UTlHMU5ObS9rMytVL2Z2RnRL?=
 =?utf-8?B?d3l6Q2dEM0o4bFFpbFU4ejFvSEY0d05RVDZveStSOWNmRjJyUDZ5Q0hQUzE3?=
 =?utf-8?B?NWxETEIwd2phQnNEcFR5MFRxTDZ4dGxNdkFOODQrRmk2UEZxclFkbUNkdVdN?=
 =?utf-8?B?ZkFtcnJITkhrRC85WEVqb0NyQ2REaXdDb3MydFZZZWVtckU1SlFNQ3BWRmhJ?=
 =?utf-8?B?VmhqWTVodGtxZU9Jd0Z2R1lyU0ExSXBLc0RsM3I0VjU0SWl5eUcwZWRjQXNz?=
 =?utf-8?B?b0M4V0ROZGoyeVV3MmxFcnVCT21QMHB2RzBtZzFsRFR1a1BpcmthbzdjZjd6?=
 =?utf-8?B?L3g1NUJybW1JbzNTS2FaOERNcUJDZEpTakRIUXczcEdIeHdLcHZyZGFmRzdm?=
 =?utf-8?B?SDhmS01Ob0RHQ20yeTlma1lWYWxkdFVOYlc4SFExSjZzb0VOMUxmSW0xdXFW?=
 =?utf-8?B?NWhJcGR1R2dBc2R1SHBuWlJTYzRvSHVVT3B4bUttRE0zeTl4dyt1S2NUWGoz?=
 =?utf-8?Q?8b08Wus1O4aMM?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QkozVFJlc3RuK0I5VzB6dnNpckU5WXBjcW1sM0E5SVM1VVVDQ1ZYVVY3NkRJ?=
 =?utf-8?B?M0FXU2VETEk0RHFqV2hkbXRCY2xseFQ3NlpyVnFLTllwK0Z6aDJmdWVxKzFF?=
 =?utf-8?B?L0FleGMwVUZaZFRGZkJxVHZJYkd5L29Dc0E0VVMrM0d0Ti9pQ200SFVheUpP?=
 =?utf-8?B?bGpnc001YklJR0liUDZ1OWkrTHA2alM1RE9xTGhoQ3dyR1NqTTNrTE9haGlt?=
 =?utf-8?B?TEhTeEl2YzMyYitjK1JUZE9DUktlR2I1N1ZVN1l1UE92TzZPOC82VEVudlFo?=
 =?utf-8?B?aURkTjUrdXNZcTFoWFZXZDlPOWtyVFBMU0dwdG1Kc0sybUNxY1pjcFZYNFF4?=
 =?utf-8?B?UUUwWTk4aXUrM0xRSmJCMmprOGtYSFQyZlFwOFhaajVYSnVSRGR5QUlLbGUz?=
 =?utf-8?B?TjR3MFFFdkxhSDdnMWpKR2tvMmJKN09hemcybUFDVkM2TGI4OXRrQVFYTTc2?=
 =?utf-8?B?NkRSYkhTNk5sa0xBb2hManVEUjNjN3hDb3BmUEJTNlJaZmF0UlVGc3VLZGMx?=
 =?utf-8?B?T05naVlaVmNyVGJFb3YxQ0pXZjFBaTVXT1VMbXJUa2UrWk91MVVxRHpZbjVw?=
 =?utf-8?B?UWVHblA4ZWVaMGg1TzZpY25kWDNqT0x6VzdYMFEvWWozV2xjTklJaHF4STQr?=
 =?utf-8?B?bmg1dnlNdXRBK1NCajZsSEJPMyszNU9kV05sOHQ0NEtZeGV1TytJaFViVEEv?=
 =?utf-8?B?VEZpUE9yalZOTWNNTTIxZFVYOWpHRnNDdVo5U255RXJ4UDVURXlCaGdyNUov?=
 =?utf-8?B?MFNXWjA3a1BZaEdwSVNsRktnZVUrK2NTY3ByeHp1aVBhNXVsdnhtV3JuVldW?=
 =?utf-8?B?QUVyZzBYVmRCSytlYUNQc0NCSDZyM3BDRGdwV1VZVTlmSDRybXA1OTVraktn?=
 =?utf-8?B?NzRZd2VuanFSVWllUTJxa2x4K2xURG5qTWQwM1lZUExyWkNxemJUZzVhTzFC?=
 =?utf-8?B?RkpTMWFNQmhabEUxSEJqOEowdDE2VnFlNlZHT0hsQXpuYkNJVnhMdW9kSEQv?=
 =?utf-8?B?MTZrUFN2TjdJQzVhSzBid0NnNmE2enlHY1VsZlBpNWdqOXoyQWtUdjk5eXFm?=
 =?utf-8?B?czFZbmRXSldlNkhxc2IrNDVlWnVHZVdOcDUweFJiWlhOVnFGSjdKMUtTbG14?=
 =?utf-8?B?Qm1GVGZoVzgrMnBrdTl1YzhrbEtzT2pGVGczRkVWdEdGaTg3S2g5U3Zab092?=
 =?utf-8?B?aWpZbS9BeFNvTUN2WXdQTER1WWlhYXZ2czJ3aEIwaVhiY1ZxWWVxSEROQWYz?=
 =?utf-8?B?aHhYVjdsckhHLy9FbHZYNUNaTkxhUmEzRnR2b2I0WXVoTkV3UERiM2hQeERF?=
 =?utf-8?B?TjVVeFVrVDdpUkIvb1dvNHlTaHFMT1B4djJrZlVqanVDTllmT2pVREJtNWtX?=
 =?utf-8?B?Qmt3NDFJekpBVXhUWTJrRHpYMWQyalV1czhVbUI4aW9ldFVVeGdVOVNHbDNZ?=
 =?utf-8?B?K0NnbWR4ckV4L0U4YWorRVN6QlM1Qjc1NEcwd2V4VmwzVjBoVENzVkszaDBs?=
 =?utf-8?B?L1Y2azg5RlVPbzYyWko5bUE4b1M0Tys0SzAzL3E0Mlk1TEJtNktEeHZVRzlS?=
 =?utf-8?B?RzlCYWxRYlVUWHI0Z3d0QmV3N1hEWVQwOWZlR25pUXNGWnhReGdOcTAxM3Y1?=
 =?utf-8?B?ODZyeHR5bkM2cjdHbS9vVC9RQndvQzd2Y041OWl6S2VRaHhXQy9RL0xwYUtY?=
 =?utf-8?B?c2JqTis3S3p2MWpsbDI1OE5ubTBnSEVIMFBkTTNaNVZwTkJUTWtNQzJBRTM3?=
 =?utf-8?B?R0dpZS9oeFBzVWhkWnV5UmRVYzcxY1lLUzZZWW1nNlhDaVRLWkphZStjSUVs?=
 =?utf-8?B?L1lXSVVPbXBXTk9EZk91MGNNcmhLYXoxT3p6N2dXUlVodjA4NzVCK2RNVkJp?=
 =?utf-8?B?RkZRb2dHeS9kb2hGZnM3MXhwcXZ2dGhuUTBMK3dCRWZJS1JYNjRldzlOOStE?=
 =?utf-8?B?N0VPN0h3dUxxVTZ3UHpvZDU0enJuUm00SW5rMGQ3djMxQjJ4Zlp2RzFnaDJV?=
 =?utf-8?B?aHRkVTU2dHpCbG9HZ3FRSEpIZ21MOFRERnloU2FnMDBSSnVWSGlIUlBiRkhS?=
 =?utf-8?B?ZU5RVjk5L3YxK2t3QWxIYUhDWHRqMnp0dVpaTTE3OU5lMFZ6M1Y2YytxK003?=
 =?utf-8?B?alRpdXhtSW5hdVZrVGZ6SzNkTDl0VHlEbGduRkNrcW4va1kza2RCU0VHTElY?=
 =?utf-8?B?TXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3fb88a9-5407-4aea-a5fb-08dd81ace0c9
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 14:49:26.3944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jH/NQDAMH2nnqHyrLPRABzHXFT0BaC3699zLzb07v+cLMA/i1N1HrYoe4lkNfzj8GFX+10o4N96D2nJoTP7EbX/eSXz3AiFhOEoxEJADWs4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB9102
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 22 Apr 2025 14:49:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18556

On 4/22/25 11:09, Jan Kiszka wrote:
> On 22.04.25 10:51, Heinisch, Alexander (FT RPD CED SES-AT) wrote:
>> Hi cip-dev community,
>>
>> Following RFC is not specific to isar-cip-core, but to the upgrade method we are using. So, maybe some of you are facing similar issues...
>>
>> The default update strategy updates the immutable partitions in an A/B scheme. Typically, the persistent data is kept as is (at least in the majority of use cases).
>> Some exceptions exist where minor changes (of small parts of /var) are supported by packages linking data from /var to the immutable partitions using tempfile.d aso.
>>
>> That leads to the following problem:
>>
>> Once we added users to the image with data on the persistent partition /var the UIDs/GIDs must remain consistent forever.
>> In case package order changes, or new user accounts get created in between, this could potentially results in a shift of those ids.
>> Since we only upgrade the immutable parts of the system data on /var remains with privileges for owners and groups as they were before the update.
>> Thus, resulting in a privilege mixup on /var after upgrades.
>>
>> To (partially) fix that problem multiple options exist:
>>

Debian developer rules on that topic
https://www.debian.org/doc/debian-policy/ch-opersys.html#introduction.

Here is the list of reserved uid/gids

https://salsa.debian.org/debian/base-passwd


>> 1. Define fixed UID/GID sets for our users.
>> While this helps with our own packages, it keeps the problem when using unmodified upstream packages not using static ids for uid and gid (e.g. wfx)
>>
Most uid/gid from Debian are generated by the alphabetic installation 
order so this will be the case if you change that order.

>> 2. Use tmpfile.d to modify ownerships on /var accordingly.
>> While this also fixes issues with upstream packages, it requires additional tooling / automation to keep it consistent with the ongoing image development.
>> e.g. ROOTFS_POSTPROCESS_COMMAND or similar.
>>
>> 3. Use a static predefined /etc/passwd file like in base-passwd.
>> Unfortunately, this does not scale very well, so we need to know all possible user accounts in advance.
>> And further, we have to ensure, that we never change UIDs GIDs (unintentionally) in that file as well.
>>
>> Any recommendations how to mitigate that issue?
>>
> 
> First quick thought: Can't we automate this, at least partly? After
> version 0 build of an image, extract the user&group lists with IDs and
> use that at base (like in option 3) for succeeding builds? If version 1
> adds another user, that would update the base list for version 2, and so on.
> 
 > Jan>

Quirin



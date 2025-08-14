Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD705CA0EDC
	for <webhook@archiver.kernel.org>; Thu, 14 Aug 2025 10:08:41 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.44])
 by mx.groups.io with SMTP id smtpd.web11.19043.1755166112788611759
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 Aug 2025 03:08:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=f7dqb7rY;
 spf=pass (domain: siemens.com, ip: 52.101.84.44, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cqtIRJc0UJsZvac5WnUfAhITTUA1k6Q+luYEm4hZGfD/hkDtx77MBStXkCwm9jIeELEklHRdCUjxl/lmXSE+remKTrptJckuANPq2MUiDjOOxH90TdhBjIxYBRBg2wezVTrDnfKAGF5/JRzXctuDI3j4eLkEe6EiX3SadLTJjhw6FKdoUWahSWZLNr4/iycnLr908qK+PvxUVkfepeJBwKZ92EFgR1SXR+dCZng+rmwVuS3MBH+NrjD3AIyCgBBlNLnuHRgpzzr43jlAZ/+mf1dLJt2Y2GOqBogk4PAIK2W37jpXkGTMRuyW49ZW7VZRT9vJH2RFrGtbouJD4Zjm2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dGhWlbRkZ7niaxqFs+SJdfXKjIyMptgVmSqdcmKwyOg=;
 b=zN7JLlOUTM/ni58L/FOT1Kv9IUJc7fYJrnp0D7rWzE6dH2ZOYjDcHfhOmcxHAqhu8hTak5XIeXGSwN1VVK1UGNk8ZjnlCdqNSaKSS+4ZtD8jYn2jJyIsLw3cs1RSpff+R+9NdRACM2jOUf9yRNPxVdGswq0YoCi2nHcQaDjb0sC/+EYIKrkftazxmjUoDBVMRNuoL70s4+sX5xz9Z5qm/BMEcB9D7lWftgXuJX1FKOCcqMP0zMyh/9sBQYpV16s8Tj9+VPyjDp5xBzKlTJ4vuC3F43OyP0PMkKLcyT612B9vdn8ypUYXWwIaT8or0KftAAfldG72xm/CfHoOiC9hag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dGhWlbRkZ7niaxqFs+SJdfXKjIyMptgVmSqdcmKwyOg=;
 b=f7dqb7rYzdEqocEDMXHQUw0R7JBEAOojnelqNSyG7IaXSo5RdHr//8PL5bqXFZFSnOw13Y5JMbjCYfqfqjX1fnuKMiNG7cnv4CHTDpWroxRibeZDfPCJ8ZrGQYT7Ja3g7acXDTLNKCH49BXwtvRVYN2r0VrBD2NZug19VebbU1LEnNReN+a044JTS6taW/S3aZ2fOMh+u9QCXN/88KueY6+jejmHP/06Pz8NBGI2uX29Ekh8nrQW0YDq7od/ukfKK8j3FPen69VMFcOh7won/9Q0hf+zk+4mFj3MVQR3nxMFe3Yz5D/TrzkSeVa8dwJY1L3osz01CyyXZs5EHTR1Ew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA2PR10MB8326.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:417::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Thu, 14 Aug
 2025 10:08:30 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 10:08:30 +0000
Message-ID: <2deb944f-b367-43cc-9493-8ab58a31afa2@siemens.com>
Date: Thu, 14 Aug 2025 12:08:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v1 2/5] Add delta update support for kernel
 binary update using rdiff_file handler
To: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>,
 cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20250813134630.3943194-1-Shivanand.Kunijadar@toshiba-tsip.com>
 <20250813134630.3943194-3-Shivanand.Kunijadar@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250813134630.3943194-3-Shivanand.Kunijadar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:610:b0::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA2PR10MB8326:EE_
X-MS-Office365-Filtering-Correlation-Id: 5761f0f7-e45c-46d0-b663-08dddb1a84b8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?bmF0U1N0V3Q2aWJGMC8zVDNMcU1NV0VlbEg5T1FmYm42UzcvTUtxd0NpOHZr?=
 =?utf-8?B?MnFsaklOWDQvOURHL2JJKzJkcHFBRmVWMjJDZlg5WC9NVVVaZlE3NkZkNkJt?=
 =?utf-8?B?bkVVRWhuT0FGMlhYbEZwY2ZSaWlwdnNlN2tzOE54dnp5MTg4MUE4VDBnVzZX?=
 =?utf-8?B?RjduWTM3SENRWFdqMUhkb1BqdmFKTlJhV1MwU1ZNb21qaGNkRjM1cXp6eGYy?=
 =?utf-8?B?M1hhNWFVaS9TMmdyRmV5U1FzZTNmMmpncVY1dGFhb2tVRVVLd0dQbzlBSy9p?=
 =?utf-8?B?QkJnMHpaQlk2aU5QaURCQ3NHclc2cmtwU3JBU1dYV2pxQWc4UHRrY25TbDhJ?=
 =?utf-8?B?OEg2eXhrd01VUmRHQ1R2dDJ3dFV5Z2p1M1V0ZGtCdTVKTzV5RVU1MENjSEdl?=
 =?utf-8?B?RmRMWGxRM0dxY2ZNU3ZYdGxCdDZ4TjBpYW1lZUFwLzNlNWtOTGZVMlI3bDUr?=
 =?utf-8?B?ZWNoYzZQQ2tYMkQwU1VQSFhTamlGajhEVmtwYUJjdytYM2l4d2tLRUdNanRW?=
 =?utf-8?B?d1lBaXNwM3dmVTdQNFR1ZndOa2tpUTJ6bDdvT0dZSmxiaHA0OGhZZU1GcDV4?=
 =?utf-8?B?TWtZbms0YWxTZHRBQ3pHWStJY3JIbFRoUVRPTTBxVnRMSFdabnJPb1pFRFlJ?=
 =?utf-8?B?VmFPQ1FCR0lOOUFWdWh3MmxzMUF4RTdYQkh1ZWJuZmVQYlJVbHhSN0t2RzB4?=
 =?utf-8?B?ZTNXMWdscFM3dFRVVkp3RFBoTjJDNTNveDkvQkw1c3MwdHRtVHJNa1pzekRk?=
 =?utf-8?B?Z2laVEQ2TWYwYVRvRDUrek9vWGRIYlM1cXBQeUZZc0I2S0QzNG1HeGEzWXpi?=
 =?utf-8?B?OXVpWVl6Y3pNaHhDdTE5aVhaci8ydThrMllaRTd3Tmw2Q0hsSmJYeDllVSs2?=
 =?utf-8?B?QXZXcDlGUUR1SlJOK3RvcW54aDkxSytRcXdRSDg3NjZRakdZakdjN0JXQWJ1?=
 =?utf-8?B?WGR3MHJnNVRUTHdQYkFHZTdHZWdRZ09lcWNWdGVIMzZYaGg1dWp0THBqS21x?=
 =?utf-8?B?bTdWMnhKS25uK2p3T3FiTHJRYWtLQkxSbHZ0Y0pXV3dXSVlQRVA3VlpWUDZv?=
 =?utf-8?B?bnRZS1k2Y3hyRkpabDY2bm5abGpjQWNrb1FMWWdNUzcwMkc4OEIwQWRSbHU3?=
 =?utf-8?B?NHpMUThZUDZHb2FKSVhDQ3p0NjhTUld6dU9TcUNWMGplWmZyZzV5V3I1TzBi?=
 =?utf-8?B?V2xxczdod0pERHlYa3BVWks4Y292U2J0d3I5cjgrNWxLdGRZMkJ5NnNONTZs?=
 =?utf-8?B?L2lJS1pmem5zK3BEV2xmdEVPbGpIT3d1ZWFDeWxUaE50ME5vOHJMcHh3RFdO?=
 =?utf-8?B?V0JldWowYi9QUmdVN29yNWoyMk1rdVQ5TnNUSFV4TlVLQklUWjhKRDNwMy9n?=
 =?utf-8?B?TVNqNERWRWpJOFltcTlac2tSY3FydUlPY0xsa25JVXo4UUVmaXZXTVZVaXRj?=
 =?utf-8?B?WHlXMThUNnZXUjBQNHN4K2krMzlWaDIybk5RTzU1WWpFVFhlSnVaU2NpVmF6?=
 =?utf-8?B?QzdOenhxTnlmcXg4ajhoR0VqMGFSZUcvR240SmlxM21vaThBT3UrbDMvZUhX?=
 =?utf-8?B?MzVIQm5VOXppUjgwbjRXNVFYYmdnWEYzU1c4bTBKeDdtenJkSFArc0h3cGNQ?=
 =?utf-8?B?UFV6ZktmekJ1aE1Ic3o3T3MrZWw0U0JyeGlxUGdlQnlacGluR0FkMFZVNnFM?=
 =?utf-8?B?N1JhRll3VEo5N256Z0FlMHhTKzdnSlkwTHFWUkcwRGpuYW9iZHlpSXJrdCtS?=
 =?utf-8?B?VjlWOG1hc3pQQlVuNUh2cCtTOE8yVmNCcHRmQURoT0I3S2hGL2VBNGczN3N3?=
 =?utf-8?B?bGdLbnVRZkpBbEVLVHNWNk43bHlqOXNWSWVzbk9ZQXFHVTZBc2wyNTZZWkN1?=
 =?utf-8?B?Wnc5WnozR3FHT0xFa1RKSkNmemhEZVN2TDBkKy91OXE0dDZyeTZsc0VWUXFM?=
 =?utf-8?Q?qO+obahrZ0Q=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QXViaHRBSEdRU1RBOFRQZXN2Y0dJWjF5WGo3eXIrajFrMjFwNlJYTTFmMWZk?=
 =?utf-8?B?d2dQOERxTUh0enI2VmhDWVNNUEZ5bDEyNmptUzBKK0w5NlhIOVVEYndoZHdI?=
 =?utf-8?B?a0NCYUg3M0RKWnFlazc2ZW9hZ2I1NHNiWW1VeUJ6ZlJZakM4cUZUdHBaaDFC?=
 =?utf-8?B?TmlFYXdnM3ExbDY2Y2hRUkE2WENiaTlvTE1FTVBiUkMvTll1ejQ4UjJ2Umla?=
 =?utf-8?B?NWFIcjdkcWhJQ2FOcWJkdytDbHVJK3c1MGRoTGdMWjhKWmVPK1lQSGVpRktB?=
 =?utf-8?B?SWtIZkVkaUpGUk5wYVQyM3lRVjdKeHlqVllJY2pMTnVSVFNSTmVSVFFNN1hW?=
 =?utf-8?B?ZjArdnhPRndGT2FqWVBPQ0JabG1JeC9ib0QvSnorejhTYVN0a2dQRWl0MVR5?=
 =?utf-8?B?NG1aQWJjNDdsOFdFaVdPZEw2Zzl0QUliK2NEOFZScnZMTzNqVmZ3MjdkMW5F?=
 =?utf-8?B?cnN4dHYzbnRqSDVvODJmaFJOeGlEL1YySTRKRDRSemRsQ3FTWHVkdktydFl6?=
 =?utf-8?B?d0pieTR5c1F0azczcUxzVytQUkkrcmliWWpjVUJHRWFmUHo5M2lqL3hGV3Zm?=
 =?utf-8?B?MXdGbEJPcjJhVThkSzRPbjFRb1g1K3puSkI0a1hYWXpyTVM3UWxZK2VYSDlS?=
 =?utf-8?B?UCtEWVBKcnlZanM4SnhGdEx1Y0FZNnNpai9EMFA2VHR5MzFpbDc3RkxZMUc2?=
 =?utf-8?B?bXM1R3drVFRYTXNwd2FOSVBaVm5kc0prWUpDZm5lWTdzcmtHUHp2SnpHUkwv?=
 =?utf-8?B?VG55Q1BFTDZURlR2alMySXdMdEtJdDFoT1ZUMUhRek9Qb1AvazBXaUZwK2hq?=
 =?utf-8?B?bFJqQjRLakx6N3pNeE54Z1IvZTVIVFZUak9nOUFEeTF0RnRmNCtmc0lTcWpa?=
 =?utf-8?B?bE5kZ1BzY1FLUTVvZ05GZTR4dnMzQVBVNE0wTVlWVkhhRTloUUsweGZLL1Za?=
 =?utf-8?B?V3B3UE9lNFRnYUZrMTVhMjU0Mnp4bE5oTndvU0J6aFJud3RQUkdNQVJwV3o5?=
 =?utf-8?B?bFJCZ0cwZWcrRkdjc3RVMnkrZ2R1aUhQT00rcFVRQ0lENXllRUJaZkN4amx3?=
 =?utf-8?B?djRyOFVyRHdPSG1YVkRPR1FjSGRMS0w3a0U1WTY0dDQ2TEgvL0VoK0NidEFa?=
 =?utf-8?B?cUhqM1I4ZisrT2U5cG13WEY3MlIvcDBBclYzN0RiT0R0KzFrOXRYVVZoM0Mr?=
 =?utf-8?B?Vm5RTEk3d2lYajBiQ2pwOUcxWFdtVWgxWVZXMnRSUWJnTndTNmlaNWc2eThs?=
 =?utf-8?B?TEtsWkdrWm1BRUhYQWF3Y0dyRHZ2cERwUHVORDlzK2xtOVlzNFkvNUFRdkRu?=
 =?utf-8?B?WXA1dTZtSmNkTlE3eDdJems2czNLNzZMVGRUbWdzUEZwL2psNEpkTExJdVBl?=
 =?utf-8?B?TDRaeWVWdnlSVWt6QU16TGJjNkZuWlRycnFseXdRb2Y4VHpxd2h3TUwzSXp0?=
 =?utf-8?B?YUFmU1pZSS9ndWhVdlBzVXpCcmRIY3d1USswVVpGTUpwNmRzaHE3MUgyUWtn?=
 =?utf-8?B?WFVQQnlDWGpBeUFTdHFBZlZJcVJRVHJPS082ZlVEQXl2QkJJWFJGWktuRUNG?=
 =?utf-8?B?RkNIZ2MyQ2R0eHkvK1BGdUFXK1ArNExoZlNjSTM1L1JPdDFlRnZXVjJSNGJN?=
 =?utf-8?B?NnZsMzJvZVppL3d5OEVKdzBZNVFBTnFQNXlzNnFCMFdXUjlMcWJWSFJsOSsw?=
 =?utf-8?B?OXZwc3MvcVRiUDV3YzArdTQyNjdFbUtEZks2MW1JeGJlQ01iNW1MQi9odDhC?=
 =?utf-8?B?WHphNndQdFNYR1B3L3dtSnByQzRNMUdsYjNmMlVTVzVWWVNyZDJVMTJqMzla?=
 =?utf-8?B?dGhOVk9rK1owdWk1ckp1K2hnTGlwbXV0V1ZvYUluZVR4MUV3TGRlRjMzTjJk?=
 =?utf-8?B?ZU4rd0FHMEJSMTBJN1NIUFFSdTNhMXpHVGV6anMycTlxK3RRSkptTUR4TjRl?=
 =?utf-8?B?REg4WjFUY3VEcmphSkJPYkEyQzFmVzVONkZ6cUdtRW9iMjZ2ckwzRnVkSWRh?=
 =?utf-8?B?R2hGVTlIbFdLUmUrM0lyUU1TOFZDbWpsdXM4ZDlUTmtoNW96d21yMnMzUzFq?=
 =?utf-8?B?aTE5MTZTUUhxUFV4RjZQaG9SaUJpTS84VjgrbXRnbmtZZ0dSek1HcEZGWDNH?=
 =?utf-8?B?NnhPMlFJWElrSytFOG1OQ0l3d0Z1RnB3VmlaZ2crWjBEMktLb05Jd1Y2cUdl?=
 =?utf-8?B?eXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5761f0f7-e45c-46d0-b663-08dddb1a84b8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 10:08:30.0343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RpW+l8zGKMhE8MtnXSmk1fCyLcMFKwDQRkn2DtMurb7DeFIWNneqjD++/Px8YfYCUqif+ByGGweHvpwhSbVp+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8326
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Aug 2025 10:08:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19740

Don't you need to update the handler first (patch 4)? It's unclear to me
from reading the changes below what will happen when the old hander is
used. Please reorder or clarify here via a commit message.

On 13.08.25 15:46, Shivanand Kunijadar wrote:
> Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
> ---
>  classes/delta-update.bbclass                | 33 +++++++++++++++------
>  classes/swupdate.bbclass                    | 24 +++++++++++----
>  recipes-core/images/swu/sw-description.tmpl |  7 +++--
>  3 files changed, 46 insertions(+), 18 deletions(-)
> 
> diff --git a/classes/delta-update.bbclass b/classes/delta-update.bbclass
> index ab11be5..d033df0 100644
> --- a/classes/delta-update.bbclass
> +++ b/classes/delta-update.bbclass
> @@ -15,6 +15,7 @@ FILESEXTRAPATHS:prepend = "${TOPDIR}/previous-image:"
>  
>  DELTA_UPDATE_TYPE ??= ""
>  DELTA_RDIFF_REF_IMAGE ??= ""
> +DELTA_RDIFF_REF_KERNEL_IMAGE ??= ""
>  DELTA_ZCK_URL ??= ""
>  DELTA_PREV_IMAGE_PATH ??= "${TOPDIR}/previous-image"
>  
> @@ -24,8 +25,8 @@ def disable_delta_update_tasks (d):
>  
>  python () {
>      if d.getVar("DELTA_UPDATE_TYPE") == "rdiff":
> -        if d.getVar("DELTA_RDIFF_REF_IMAGE") == "":
> -            bb.fatal("You must set DELTA_RDIFF_REF_IMAGE and provide the required files as artifacts to this recipe")
> +        if d.getVar("DELTA_RDIFF_REF_IMAGE") == "" or d.getVar("DELTA_RDIFF_REF_KERNEL_IMAGE") == "":
> +            bb.fatal("You must set DELTA_RDIFF_REF_IMAGE and DELTA_RDIFF_REF_KERNEL_IMAGE and also provide the required files as artifacts to this recipe")
>      elif d.getVar("DELTA_UPDATE_TYPE") == "zchunk":
>          if d.getVar("BASE_DISTRO_CODENAME") != "trixie":
>              bb.fatal("Zchunk based delta update is only supported from trixie onward")
> @@ -35,11 +36,13 @@ python () {
>  
>  python do_fetch_delta_rdiff_ref_image () {
>      if d.getVar("DELTA_UPDATE_TYPE") == "rdiff":
> -        path = d.getVar("DELTA_PREV_IMAGE_PATH") + "/" + d.getVar("DELTA_RDIFF_REF_IMAGE")
> -        if not os.path.isfile(path):
> -            bb.fatal("No such file found: "+ path + ". Provide the required files at "+ d.getVar("DELTA_PREV_IMAGE_PATH") + " for rdiff based delta update")
> +        rootfs_path = d.getVar("DELTA_PREV_IMAGE_PATH") + "/" + d.getVar("DELTA_RDIFF_REF_IMAGE")
> +        kernel_path = d.getVar("DELTA_PREV_IMAGE_PATH") + "/" + d.getVar("DELTA_RDIFF_REF_KERNEL_IMAGE")
> +        if not os.path.isfile(rootfs_path) or not os.path.isfile(kernel_path):
> +            bb.fatal("No such files found: "+ rootfs_path + "," + kernel_path + ". Provide the required files at "+ d.getVar("DELTA_PREV_IMAGE_PATH") + " for rdiff based delta update")
>          else:
>              d.appendVar("SRC_URI", " file://" + d.getVar("DELTA_RDIFF_REF_IMAGE"))
> +            d.appendVar("SRC_URI", " file://" + d.getVar("DELTA_RDIFF_REF_KERNEL_IMAGE"))
>  }
>  
>  do_fetch[prefuncs] += "do_fetch_delta_rdiff_ref_image"
> @@ -47,18 +50,30 @@ do_unpack[prefuncs] += "do_fetch_delta_rdiff_ref_image"
>  
>  create_rdiff_delta_artifact() {
>      rm -f ${DEPLOY_DIR_IMAGE}/${IMAGE_FULLNAME}.delta
> -    # create signature file with rdiff
> +    # create signature file with rdiff for rootfs
>      ${SUDO_CHROOT} /usr/bin/rdiff signature ${WORKDIR}/${DELTA_RDIFF_REF_IMAGE} \
>          ${WORKDIR}/delta_interim_artifacts/old-image-rootfs.sig
>  
> -    # create delta file with the signature file
> +    # create delta file with the signature file for rootfs
>      ${SUDO_CHROOT} /usr/bin/rdiff delta ${WORKDIR}/delta_interim_artifacts/old-image-rootfs.sig \
>          ${PP_DEPLOY}/${IMAGE_FULLNAME}.${SWU_ROOTFS_TYPE} ${PP_DEPLOY}/${IMAGE_FULLNAME}.delta
>  
> -    DELTA_ARTIFACT_SWU=${IMAGE_FULLNAME}.delta
> +    DELTA_ARTIFACT_ROOTFS_SWU=${IMAGE_FULLNAME}.delta
>  
>      # create a symbolic link as IMAGE_CMD expects a *.delta_update file in deploy image directory
> -    ln -sf ${DELTA_ARTIFACT_SWU} ${DEPLOY_DIR_IMAGE}/${IMAGE_FULLNAME}.delta_update
> +    ln -sf ${DELTA_ARTIFACT_ROOTFS_SWU} ${DEPLOY_DIR_IMAGE}/${IMAGE_FULLNAME}.delta_update
> +
> +    rm -f ${DEPLOY_DIR_IMAGE}/linux.efi.delta
> +
> +    # create signature file with rdiff for kernel
> +    ${SUDO_CHROOT} /usr/bin/rdiff signature ${WORKDIR}/${DELTA_RDIFF_REF_KERNEL_IMAGE} \
> +        ${WORKDIR}/delta_interim_artifacts/old-linux.efi.sig
> +
> +    # create delta file with the signature file for kernel
> +    ${SUDO_CHROOT} /usr/bin/rdiff delta ${WORKDIR}/delta_interim_artifacts/old-linux.efi.sig \
> +        ${PP_DEPLOY}/linux.efi ${PP_DEPLOY}/linux.efi.delta
> +
> +    ln -sf linux.efi.delta ${DEPLOY_DIR_IMAGE}/linux.efi.delta_update
>  }
>  
>  create_zchunk_delta_artifact() {
> diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
> index b0b05d5..c18aaa9 100644
> --- a/classes/swupdate.bbclass
> +++ b/classes/swupdate.bbclass
> @@ -15,6 +15,7 @@ inherit template
>  RO_ROOTFS_TYPE ??= "squashfs"
>  SWU_ROOTFS_TYPE ?= "${RO_ROOTFS_TYPE}"
>  SWU_ROOTFS_NAME ?= "${IMAGE_FULLNAME}"
> +SWU_KERNEL_NAME ?= "linux.efi"
>  # compression type as defined by swupdate (zlib or zstd). Set to empty string to disable compression
>  SWU_COMPRESSION_TYPE ?= "zlib"
>  SWU_ROOTFS_PARTITION_NAME ?= "${SWU_ROOTFS_NAME}.${SWU_ROOTFS_TYPE}${@get_swu_compression_type(d)}"
> @@ -32,9 +33,14 @@ SWU_ROOTFS_ARTIFACT_NAME = "${@ '${SWU_DELTA_UPDATE_ARTIFACT}' \
>      if d.getVar('DELTA_UPDATE_TYPE') == "rdiff" or d.getVar('DELTA_UPDATE_TYPE') == "zchunk" \
>      else '${SWU_ROOTFS_PARTITION_NAME}'}"
>  
> +SWU_DELTA_UPDATE_KERNEL_ARTIFACT = "${SWU_KERNEL_NAME}.delta_update"
> +SWU_KERNEL_ARTIFACT_NAME = "${@ '${SWU_DELTA_UPDATE_KERNEL_ARTIFACT}' \
> +    if d.getVar('DELTA_UPDATE_TYPE') == "rdiff" \
> +    else '${SWU_KERNEL_NAME}'}"
> +
>  SWU_IMAGE_FILE ?= "${IMAGE_FULLNAME}"
>  SWU_DESCRIPTION_FILE ?= "sw-description"
> -SWU_ADDITIONAL_FILES ?= "linux.efi ${SWU_ROOTFS_ARTIFACT_NAME}"
> +SWU_ADDITIONAL_FILES ?= "${SWU_KERNEL_ARTIFACT_NAME} ${SWU_ROOTFS_ARTIFACT_NAME}"
>  SWU_SIGNED ??= ""
>  SWU_SIGNATURE_EXT ?= "sig"
>  SWU_SIGNATURE_TYPE ?= "cms"
> @@ -58,6 +64,7 @@ IMAGE_TEMPLATE_FILES:swu += "${SWU_DESCRIPITION_FILE_BOOTLOADER}.tmpl"
>  IMAGE_TEMPLATE_VARS:swu = " \
>      RO_ROOTFS_TYPE \
>      SWU_ROOTFS_ARTIFACT_NAME \
> +    SWU_KERNEL_ARTIFACT_NAME \
>      TARGET_IMAGE_UUID \
>      ABROOTFS_PART_UUID_A \
>      ABROOTFS_PART_UUID_B \
> @@ -68,7 +75,8 @@ IMAGE_TEMPLATE_VARS:swu = " \
>      SWU_FILE_NODES \
>      SWU_BOOTLOADER_FILE_NODE \
>      SWU_SCRIPTS_NODE \
> -    SWU_DELTA_UPDATE_PROPERTIES \
> +    SWU_DELTA_UPDATE_ROOTFS_PROPERTIES \
> +    SWU_DELTA_UPDATE_KERNEL_PROPERTIES \
>      "
>  
>  # TARGET_IMAGE_UUID needs to be generated before completing the template
> @@ -163,17 +171,21 @@ python add_scripts_node() {
>  SWU_EXTEND_SW_DESCRIPTION += "add_swu_delta_update_properties"
>  python add_swu_delta_update_properties() {
>      delta_type = d.getVar('DELTA_UPDATE_TYPE')
> -    swu_delta_update_properties = ""
> +    swu_delta_update_rootfs_properties = ""
> +    swu_delta_update_kernel_properties = ""
>      if delta_type == "rdiff":
> -        swu_delta_update_properties =  'chainhandler = "rdiff_image";'
> +        swu_delta_update_rootfs_properties =  'chainhandler = "rdiff_image";'
> +        swu_delta_update_kernel_properties =  'chainhandler = "rdiff_file";'
>      elif delta_type == "zchunk":
>          zck_url = d.getVar('DELTA_ZCK_URL')
> -        swu_delta_update_properties = f"""
> +        swu_delta_update_rootfs_properties = f"""
>                          chainhandler = "delta";
>                          url = "{zck_url}";
>                          zckloglevel = "error";
>          """
> -    d.setVar('SWU_DELTA_UPDATE_PROPERTIES', swu_delta_update_properties)
> +    d.setVar('SWU_DELTA_UPDATE_ROOTFS_PROPERTIES', swu_delta_update_rootfs_properties)
> +    d.setVar('SWU_DELTA_UPDATE_KERNEL_PROPERTIES', swu_delta_update_kernel_properties)
> +
>  }
>  
>  # convert between swupdate compressor name and imagetype extension
> diff --git a/recipes-core/images/swu/sw-description.tmpl b/recipes-core/images/swu/sw-description.tmpl
> index eeb8fc2..3d7898c 100644
> --- a/recipes-core/images/swu/sw-description.tmpl
> +++ b/recipes-core/images/swu/sw-description.tmpl
> @@ -21,20 +21,21 @@ software =
>              properties: {
>                          subtype = "image";
>                          configfilecheck = "/etc/os-release@not_match@IMAGE_UUID=${TARGET_IMAGE_UUID}";
> -                        ${SWU_DELTA_UPDATE_PROPERTIES}
> +                        ${SWU_DELTA_UPDATE_ROOTFS_PROPERTIES}
>              };
>              sha256 = "${SWU_ROOTFS_ARTIFACT_NAME}-sha256";
>      });
>      files: ({
> -            filename = "linux.efi";
> +            filename = "${SWU_KERNEL_ARTIFACT_NAME}";
>              path = "linux.efi";
>              type = "roundrobin";
>              device = "C:BOOT0:linux.efi->BOOT0,C:BOOT1:linux.efi->BOOT1";
>              filesystem = "vfat";
>              properties: {
>                          subtype = "kernel";
> +                        ${SWU_DELTA_UPDATE_KERNEL_PROPERTIES}
>              };
> -            sha256 = "linux.efi-sha256";
> +            sha256 = "${SWU_KERNEL_ARTIFACT_NAME}-sha256";
>      }${SWU_FILE_NODES});
>      ${SWU_SCRIPTS_NODE}
>  }

Looks good otherwise.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center


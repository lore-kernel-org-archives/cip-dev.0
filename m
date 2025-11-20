Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692DCCF9C7F
	for <webhook@archiver.kernel.org>; Thu, 20 Nov 2025 18:54:37 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.16])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2109.1763664869764997373
 for <cip-dev@lists.cip-project.org>;
 Thu, 20 Nov 2025 10:54:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=zbZQg91v;
 spf=temperror, err=temporary DNS error (domain: siemens.com, ip: 52.101.83.16, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l8oxJdmmQm9g10L92vIbseKaX7Rjoi9n4i3AkWkaLTvq83r/S+HvfoZCVXpNfaZksx30fkiSeU7UJrV5Sdvi4DtjQJYsJD20/ek23NX8h7pB4wIPpipXX84rsjHuLCJC4PIKZ2LusEnzSk5wuT1VEQYAlNMJLTZF9giVHHiR4SG1MIQdmVuy5yN9dEmH5quYYUsLqhzyErR/SJjN3Opyw4Vtv0wK4ybpBgtvM94Q4J5ris1Yip79XdpotNM9vPpVmSY67WFJ/GOKvY/GQRZft1QCqNVAbodmUuMPmzVJTIUIuOqtWWcfNs1fGgMNKmhNQYHh1qD03cJWjWiRdcO+Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bVNYDAVhKq0Yj6jDM2YtAOrgvcJLHyxXunu9dOlBNBY=;
 b=FltdtVWEN/N2ghBL3o7uEtKU7UEzkXQTNAPW1mxCkZJTfvcOxSSVcer4b5+54CJv6r370pxQB/EYK8W1qXfKBx1XVCrL7u/Rxe1/zzsVKcIrW6+QQeSHB+aChEZq8ur1aoScdiIl+GNDXisaDyNIX0wYBAXMhtm9HObZsHrzalVpOId+LYAtEldBbDk7yUyQMEequ0BEhrME+Sthyhy2gbuvMpnrSDwyN9IOkagFR9zbu59oJhC1qI579GXff5YsfwO+kttJNGGN1SbpKDWRBRCR+iOnncIvGqB2l4tP+Zqw3Ox1dyxFp0KfK5AcPrr/1MJFI9UG5CYMLop8hMtT3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bVNYDAVhKq0Yj6jDM2YtAOrgvcJLHyxXunu9dOlBNBY=;
 b=zbZQg91vaNYMyBw3fzHdPipx7z9qWGqrCzGIHA2EFbGy734MfME5V1D45ORvvZbJV2Dz7pPBo3Ez+TrJlcCrsjBC5uXDqZ3SSgjJlXlVLz0I9ruDgK0Ey9w0kz0F8hCMvUnsS4aBFsKqQBgEuVGVKpJcH3sSiI8JabeeZNxuBb05tDCXOdkDGVcxlfVpG2uiliKUAb0Vu45XDcNzypY3f+XTFnnucIOx1nFlhBKJLOKk7y5BD7/LsvzS8eNO5sjmlQjWLM7NQEEILHDlpX4yi2seMaeZt4m5u1P0wqpvxKK15oxMDv/J8Ac0bMIYoaofujZdwxvJE4nvDt80RZKQ/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6364.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:56e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 18:54:25 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 18:54:25 +0000
Message-ID: <ec7999e4-8ab1-4691-8dce-3fb35226d0b4@siemens.com>
Date: Thu, 20 Nov 2025 19:54:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v1] IEC_template.yml: Update IEC layer
 tests revision
To: Adithya.Balakumar@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: shivanand.kunijadar@toshiba-tsip.com, sai.sathujoda@toshiba-tsip.com,
 dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20251120050313.973859-1-Adithya.Balakumar@toshiba-tsip.com>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20251120050313.973859-1-Adithya.Balakumar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0291.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6364:EE_
X-MS-Office365-Filtering-Correlation-Id: db5141c2-c64c-44bb-3654-08de286639fa
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Smw4UWN3bm9YcTNlbk1uQnlNa1A1OUpVeTZNR0RVTFdsV25sSmQ1MG0zdWVD?=
 =?utf-8?B?cEg0bG4rdEJlaG9RZ3BVNkhvRkFnQ0NWbVZ4enkydTZXQVFhMVRsYW5SWlFJ?=
 =?utf-8?B?VnB6TXNHVVFKck9FeXRtVUQ3R3Z6QlBZVVdmbFkvRGV3L1lmNW11NGRXWVpO?=
 =?utf-8?B?VFcyTlZVNFRmNGVVempYd2VLU2ZPdW9JQ0pKNUdKMC84WWx3UmNrRTBMdlNm?=
 =?utf-8?B?d1IzbFgwUnJOSVpwSmNPTW0vUTB1UkpxbFZGUFBNRlB3VlV5VytXMEZIN2Jx?=
 =?utf-8?B?S3RVK3dXZ1BZbXY2OXJleHhpRjVMeU14SjA5dGVTcWVmbW5zK2hSL2I2bnRs?=
 =?utf-8?B?M3E1bVBtZ1pFT1RrbWhSNkpYZDhsOWVlUWFrMTJyT3RDemVtSGJlK0FrL2Uw?=
 =?utf-8?B?MTQwSDRRaUlJc0dNV1BnWnBVbjlzQjB5NEcveklZSTZ6WExRMW04by9DUDRo?=
 =?utf-8?B?MFRDcTIrbGJxbFV3WFAyQ0VZcC8waXRaeWR6anN0NWFJTjJ1MUlESVNzTHBD?=
 =?utf-8?B?Z0ZTWnIrRkQ5Uk9IdWZJMG5henkxR2ZwNWFQRm1VUXpmbXVZcFhpZ01yb0ZD?=
 =?utf-8?B?ZG1ncDJrZm9Zd1lSUC9SR01OdmlXS0twbzBVM055R3NyK3R3Snh3U29SOE1L?=
 =?utf-8?B?N2tscDQzU0lWZXBFZnJNQ1NFOG16cWk5d2hmdk5VTXBsU2hPVHpKSjJrSGhE?=
 =?utf-8?B?ZXNqTnQ0MnB3TGE0TmtVUmZiVExwSHZhL0JhQTdORTVjd1RCMFpnWVpKcEJo?=
 =?utf-8?B?ZTRQbGVkWWErSmxrUVE1Sk1HNi9RSWxtaEQwWndXMWpWVE1yWlMwYUNiTGNZ?=
 =?utf-8?B?WkRFVXQ5bS9veWZaTXE3cWNhTzU3Y09ta3Rza3Q3SE83NU5jVzJUbWZiRkta?=
 =?utf-8?B?NHc3L1hVY1hjbVFYb2p6NVRpVERzaEFvT0ljcVN5bTlIWmtrK1lhRFozOStQ?=
 =?utf-8?B?YU9veCt1WEhuRjBzZHVFQnlMbjRwVUdqMTYrM08wU1pjRE1pQ1dqckwvelBh?=
 =?utf-8?B?WWlVUDRxdFpNY0J5V2dLRGVSbFN3ZVdJMU95cytTRktyVHprTzd3KzBuMXUz?=
 =?utf-8?B?cnB1OXljcWlZK1VuREZLTnhUa0tobml0LzZwMTRnMFBINGc0bGo4OE9qYzg1?=
 =?utf-8?B?MitQb210K09Sc1ZnOVB6WlV2RHJLQTdrY2VnVmtIc2I2emZlRmRQUzdhd282?=
 =?utf-8?B?eWt4YXVZMWxST3k0eHFHaDVNUVpmbjBaZCtJS0hTdmREWTBMR3M5TFQ3QkVw?=
 =?utf-8?B?SFRpSlZJWFliNm8zR1hUYnFiVWFjYUowY0VzK1NIbThuVDNtRWJua3RHeFF6?=
 =?utf-8?B?OENrT3BRUjJmeUY0WXZLNWw5UnhVWXJ2YUUrYytYYWNrUzA3ZXhmaGx0UG5E?=
 =?utf-8?B?RTJEZnFTSldUSExpaFlTK0FYWEMzRFRVMDM3WTI0UVhyaFp1YnRHcXBSTW1X?=
 =?utf-8?B?QVJuVFNoYUdnVFBWN3ZMNXdyNmhJbVA3NGM0c01BYURSNEpWNE0yOE5kSjRy?=
 =?utf-8?B?VlRvSktuai9jMVpQc3N0VWdWb0xGTTRySFYxcEdmY1Y0NXRUNkZ0YkFBbGd1?=
 =?utf-8?B?KzFocENackQxaFV6eWhKVk5CVWtCMGt0Y3l4MllZdC9RbkRYb1lQTmNSaUp2?=
 =?utf-8?B?dDYxMHo0MWtZaGJGSlF3aE9FU2lCNlpkeFpEaTdCZ3RmRlJ2Y2NUbjB4bWJq?=
 =?utf-8?B?TER4T25zeWJzT1ptZDV2b3dxNUlQd29wOFkzTE85Rk1QWGNZTjBMOWJ0cSt0?=
 =?utf-8?B?UmpUWmRsOVFSVlBub05UYlZTL3VoUXZxQUdvSlAwQUxudm9UZ2JOeUNxSU5t?=
 =?utf-8?B?VURKcjR5SDA3V21iM2w5VHEwMzJLd3hYQ2Jpd3AwNXRheGxaMHd3dHpQMXVN?=
 =?utf-8?B?cm5mRzRwam54R1B5MThEbXRQK3EwWWFlWVlYUEgrbFhqc3BsYVNJMG1YUWNp?=
 =?utf-8?Q?PYf/5qU8gdNb77jrUpc+TtFoT3Cr0pjZ?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Y0FkUkNSeENYcTJCSllWZlJ5ZXQyaUFqNTV3RVE5amw0SG1NZFk0RVk4ekFa?=
 =?utf-8?B?aXFDcHN6bGo3cFpJNmxSV1RYY1kzb3F1NXNua3d2ZzlqeHhHSHNReVBJeHkv?=
 =?utf-8?B?V051ZEpNV0NQWkczeU5JcDhCdDNnbUdkZFA4aTBJS2FpWWFzR0c2c0JsSm1m?=
 =?utf-8?B?YUVUYkdFZGxucFVjOWZ1VGpGYmNQL21zTDJld1p6bXcrOXV1MHk3YlN1WE9m?=
 =?utf-8?B?V0t4YjFKUWhndWRZVCtTZU0zOXNxRk96R0t0NnhDV2h6V2pVZVZZV3h3MGk4?=
 =?utf-8?B?dC95MjVMUHFNK0paZGlGbDJIQXNkd2tqaURvdVJqYmtRdXBYbERocFgvc2Fn?=
 =?utf-8?B?V1J1Zms1YnFCaVdFZ3N1dDV0UEFFVmZkUGp5Z09kMU9iVzB3UGdRT01FVEJV?=
 =?utf-8?B?dlF3eU8wTGpRUXU4V3RBZnU4Z1A5Z1hBaWF0Uzhsdm1BN29PMTQ4YzFOWVRR?=
 =?utf-8?B?c0RoNFNzSGlvQVkrUEhFMGVxUTlGN2VaMExiNmFTUmtmWmtvL1V3L3Z3OWx4?=
 =?utf-8?B?VWxrNzVKMnlvMlpCVnI5Q0VqemxKQ2gvT05xdStQbHo2cWNEeU9wVlc1eU9r?=
 =?utf-8?B?S1RmdEMwN3A4bVp2YkxRZFZiQ2JoZ1dHbW84dGlncklyQXU3RkNwUTQzYVVu?=
 =?utf-8?B?bGZwNDB2UXpXS3pDbXlnR3lxS3kvWWhVdlcycDllL0s3S05zV1lWOThWRTg1?=
 =?utf-8?B?NDRtNUtqK1Z6WmFmZGFiUmFGQkt3MndmQmtzVTFQUUs2YXBVKzloYXBDbm9Q?=
 =?utf-8?B?OUZMREZPY3AxNmlsS2d6VlhEaW9SM0NKVS95alBxRnJYbjJ5OHNGYjAzYVJC?=
 =?utf-8?B?bGNlVi9wRkUvWUJqWHlrNEpYeGZGQm1oK2w5eXFwUU1vNGpQbEl0cE1xUHVP?=
 =?utf-8?B?MnZpYVh2YnVnNFpzWmY2MHgwNlVFUnNvdmZ0aUNFbGZ2Y2RVaGtxcFEwc2dF?=
 =?utf-8?B?QTlSRHltTHJJWEFYb0w3cXNHWXowcUw4aXQ4aGJGenpnTldWL2c4TUVZMzBJ?=
 =?utf-8?B?WjkwNDdwR0lreHpKK2hVb1RsSTVsblVrMDBFU1FyM0dzZERka3JQYzFXeXdE?=
 =?utf-8?B?em0waXBRZnFVYU9QVzQrVGs3MmlBelJGQkJXTE1rbXdnTzZ4dU45VG1FY2or?=
 =?utf-8?B?NjMrZmVpZUFycmdRWitwMHlLaUF6S21yUVcwWDltc2g3WkFZRElBbDlsYjRU?=
 =?utf-8?B?STRQZ2J3aC9TUkFkNmFkK2lyQVJjaXFzSzZ3dVRTdG5wVENaNjVKSURSdGRL?=
 =?utf-8?B?MmhvNFhPSnMxY0E0VVJUQlVzeUlKMmRPczAzbU1OcHR0TTAyTC9yZ1h1cUFp?=
 =?utf-8?B?V0Z4KzRpN2xBWVphVjdLZEFoLzRIQ2gwS2diVUtRU05ORTRPa2ZaMW1JbStw?=
 =?utf-8?B?UG94b0QzeFltd2pPUWRoWjY1VkxEZTlxU0Y0QS90cloybFVhaU1vVFVhVTlX?=
 =?utf-8?B?ZnM5ZEhUemFTT0NBRGNoUHE4R2NPY1FyR3pNRm4wSTFESkpqbmFIeC85UWVy?=
 =?utf-8?B?cFdYOGRydHVtRWdCZmxLZmhCVW9GdGRuWjQ5SHo2Nml5cUZGRXBlNGs1eWFH?=
 =?utf-8?B?bng0dUk1bll4MUFkVzRiUUlWcHo4SDhaYzI2eml5NVhkWFJsVllmMW9hL0tU?=
 =?utf-8?B?QVdWUERneXh5bkl0Snl0aGY5THNsWDRKempEYW9oVEJBQk8wNkMySFJyNnZM?=
 =?utf-8?B?OWxEenQ3M1Y2RWo5VjJMUDNudjJ4bHFYNENEcGQ2WW1EZHJaeTNXcldxZUxT?=
 =?utf-8?B?blp6RjNkZm9LRkh0dmtFOUZ5c2VjT25MUHRMRlZVbUxySjgzTTZCSTV5cU44?=
 =?utf-8?B?SHhCY1lyeEZBMlBtMHliek9wRUordlFRMGJ5MWM5MGorTFBlY2U0TzR2eVZz?=
 =?utf-8?B?bHN5S1YyOFJMNE1WMFBXTmhZampHeEdrY3hWeHZpSmFmMUpNUUcvTzVpS3hJ?=
 =?utf-8?B?QjFIbFZnakUyc1VOQldBZ040UDA4QlBVWkVYWVRabTQzc1RjNjhkMVV4ek02?=
 =?utf-8?B?SnhTQ0pFSkpHdUFuQUFxR25hakhEQlFDaVp2dTh3eEI4MXdSV0FnZTRGMHVu?=
 =?utf-8?B?L1VlZklLNW12WiszY2x3K1lFRWVmbC9HdS80dlEyLzNaNi9UYkI0d2lJU2V3?=
 =?utf-8?B?UGg2NUtNNm8xdDlCSndaOTBhVVRGUXpkNlNxOWhlN2VoclJLaFFqYUNieU5t?=
 =?utf-8?B?S2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db5141c2-c64c-44bb-3654-08de286639fa
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 18:54:25.9024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hWkUh7veU7BY+zuGhbO2YRzKKzuFmJ10Vr+WPkZjiT4fG1zkDn+0oNTj4yHHJuloIjQStOqAaRhju9ypn+5Flw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6364
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Nov 2025 18:54:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20658

On 20.11.25 06:03, Adithya.Balakumar@toshiba-tsip.com wrote:
> From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
> 
> This revision update fixes the inconsistency with the IEC CR 7.1 test.
> 
> Currently the rate limit using nftables is set to 3 requests/second and
> the ping flood transmits a packet every 0.3 seconds i.e 3.3 packets / second
> 
> Although this is theoretically over the rate limit and should drop packets,
> but the rate limit set and the ping requests interval is too close and some
> iterations can lead to no packets being dropped and thereby the test failing.
> 
> The fix increase the frequency in the ping flood attack which would lead to
> more packets being dropped by the kernel.
> 
> Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
> ---
>  tests/templates/IEC_template.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/templates/IEC_template.yml b/tests/templates/IEC_template.yml
> index fe4132d..fba7544 100644
> --- a/tests/templates/IEC_template.yml
> +++ b/tests/templates/IEC_template.yml
> @@ -64,7 +64,7 @@ actions:
>       definitions:
>       - repository: https://gitlab.com/cip-project/cip-testing/cip-security-tests.git
>         from: git
> -       revision: dee76c8b6612439ac648fd18709088ec8fea7e40
> +       revision: deec0428624e827a9d762eccc99b55ee05b440fd
>         path: iec-security-tests/Singlenode-TestDefinition.yaml
>         name: Security-Testcases
>  

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center


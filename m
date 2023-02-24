Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB74C7EE23
	for <webhook@archiver.kernel.org>; Fri, 24 Feb 2023 17:14:21 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (EUR01-HE1-obe.outbound.protection.outlook.com [40.107.13.74])
 by mx.groups.io with SMTP id smtpd.web10.23919.1677258854687871477
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Feb 2023 09:14:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=pma47pXu;
 spf=pass (domain: siemens.com, ip: 40.107.13.74, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EhtPfrTxGOWATQRxOvdD2wZgfQD9YjZjxreYywiS4Ztv88uzo4GVNQ8/MwdD1XWMIxrxAhtaaqX2zkxohoYGoPpeOVjGiAcCKG1eyfpvbuwN2OqdTdCAOlM6zlPW/IV1IR7jozeaW5JKtv0NgRY0PEZQ/rrDK5K/QSutKI1J2Kd3d0WCn+n501KtkitsKqcDYFuQhy9GZ4rir6umGbpBVNBK4l1Z+X/W28VHV8ewRqnDAHgTCZqn3M3HM7OuuCQHr08PwUDBKkv+uIqCU0PslHaXbcWMT5UP4LR0GOtbCWlQSVagZGjErd9XPvDNNyWrGOnMc8sY8hMvRFf3gzJVAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mrvZQ1SBfnbXOwrbnURiHjWtNMEnAzO1uyC8FUJ3oTA=;
 b=ihTH1vl+WFVdxY0X06SaAQSQKzK4xYly2aQ+A4UNNscRrLcjHOmKdGwnL+6olwDV5iRCO4TW+XKDJbs2TPJz69Y/kRq+t8gz3mUCC2twQeKy3NABSUCrfJQqMvCKx/iTgMnsbiHL9CsOki2R/95p0zfwb57O+JB/zpE41A+mqHcOcKYFvoALeCZBli71dkCsULtxggK7GsK10F573EXPGNFkJ+Yrhh2HL4IDXgK7i3W+A3MS9Gjb4WXnzAqk30QDg43KMtNNGtLtSYw5IY9c81lPk6rNrqB5vIZRLy3iP09K7s8J+e4N/k5BR8Nl/TZ2He7XwuFGuuGUpxM6+1Bs3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mrvZQ1SBfnbXOwrbnURiHjWtNMEnAzO1uyC8FUJ3oTA=;
 b=pma47pXuGt2/H2h/6/o13Ap8rHFMxG+fSrua4Jv3T5fb8Fv/CkJ6ISaIUnAq5L964MNddfABkzatL0AE3VTDDwPs6MvHONhwiiAEiy6oIVfXEIsz/46LYbzkV6VqQRAuAt3Ws06g4xagA5AFf/2Zbq53dPlcpEWM5ptgUUjsK1VvVkij1W/bvS1iizY2Ra24T/BK0tOmn1tb2ZsNmtAadEmHOqGXNvDj7jmeUN098r4PgRV37chxotOeqddTLPvlpjMtYEVfkTpOW2A/oNLvAyITSVvINBR6MTH+I3mzQkLW7YySklkkYmnZju25P3TmiQKWg9r25frQxPKwZPisTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3473.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:151::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.24; Fri, 24 Feb
 2023 17:14:11 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%9]) with mapi id 15.20.6134.024; Fri, 24 Feb 2023
 17:14:11 +0000
Message-ID: <2dd4be26-4bd6-5459-af83-c857b63d4719@siemens.com>
Date: Fri, 24 Feb 2023 18:14:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [isar-cip-core v3 0/2] ci for reproducible build check
Content-Language: en-US
To: venkata.pyla@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <2e6c36f78e3873f0627fa5c3912108fe1283438e.camel@siemens.com>
 <20230222114408.32155-1-venkata.pyla@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230222114408.32155-1-venkata.pyla@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0101CA0059.eurprd01.prod.exchangelabs.com
 (2603:10a6:800:1f::27) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3473:EE_
X-MS-Office365-Filtering-Correlation-Id: 979be188-8eb4-450c-ad85-08db168a8c2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	fsFmYWClkbk2FTVVGlm6qv6yozTuIXbQa239YqQF3NwdX6dtn9XIuNXprW5B4zzNi395sv4PbMGZg4wnjrLDmK+dsZTSMwM8lboiX2pMtvLYPcu9sXRlReoZDFageXMz2K7nuZp0n1lrSdq6KWv+xUJxidzgWo85/IcXHbd7460LkhJR6ZXvF2slf/RJCYwi04ap76aa/hMXN2J5Nbj43W6wQvYRIX8plG8bXUgwTX11ZpQiSjqYIqmm1Hc5NfRwfJz0fC4CZyzh/nB7SAsevZV2BPF3kkBZkK6ttf7IDSw42p6jwveQl6XWf/nDr695bUIP5jbPojjMgp/Mre9/vL/FwK2/gh5ulXGvx0Ft9sYa/7CZr3HigoSxb5er9oQhOSRqMF/mb/ajTLWQ2auCvnF3CC2+eU03pFtMDpxtD6qqhkhicgnFGmx4EG1rsqkOyKF8m7/J31x2o/Vp5z1nL8MDhlc7E4b4s8Y1h4AEaZX5M8RMFtPinzu0pmePGCU32Hdm6YNa+qTSJVRMS2cJA+VyMuxDvOwT9LVHH57SdbKSO6450+tyzoJYp5fUk54vj6wH+dwflkSnzaEfO0nEvbOkVcYn4IQ/iKSSMH5PidPt9nzIYhcUqdFmEqBjrJ8+Qt+jN3B3aKPs1Bk5eqgZ2T/mcMSvCY30S9b4Ljbq+DnQjQ5YARHeuchHF4ewtvh6ZmZ84pIiYi7zVnCEFVOk0EDyQ9inl9ecS56fcERF3eo=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(39860400002)(346002)(376002)(366004)(451199018)(26005)(36756003)(6512007)(6506007)(186003)(6666004)(53546011)(41300700001)(2906002)(66476007)(8676002)(66556008)(38100700002)(4744005)(5660300002)(66946007)(82960400001)(44832011)(8936002)(478600001)(2616005)(4326008)(31696002)(86362001)(316002)(31686004)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?U29OK1dlRU5PNDhJTUlMT3JQQjJlOENhU2dMNnh1cVZSaHBVQ0Jna2VXc2Q4?=
 =?utf-8?B?bVEzQko5WVY5UUhZanQyK3dRRzRYSTdhcUNxYjFETTFSTmJzRU1OMVdETnNR?=
 =?utf-8?B?OUxUcDNxdS8xamEwWUE5YksyYTZTNWNDZzJ5Ung4QkJuUzVsVXNML0pkQWlI?=
 =?utf-8?B?WGQ4Um1BYllQKzQrK0NORGZQZ1N3TEROdkdmQUlIQzBCdDczRnIwK2hzcmd3?=
 =?utf-8?B?UTFCYzJib0F4bUkrUVpsM2twMFFlREo0U0NUQk9OWWVkT1pEVnZPUDFJYkww?=
 =?utf-8?B?S1hQMklmdXVVTUhXRktvaUtORStKdnVHb21LcHlGVm53YWpaMWhsdlJxLzl5?=
 =?utf-8?B?bWhWRGU0d3Z1VlAxcnBpSk9qUDdib0o2Q09HWWx5L2N1endROHpwaDhLUUp0?=
 =?utf-8?B?L1N3Tk1WTGJtd2YwaEpxYjVVbWVHYlBKRzhlWG1VL0M1QjVUTmNYdE9Ddi9Z?=
 =?utf-8?B?MEFibWRjdEF4eEQ0a3Y4Wnh0QmRWYWVma3hUb2N5RDNYbHZKd3FDaFFtZmpj?=
 =?utf-8?B?TFNkNXdWMUh1Sk1KL0EzaGFVcGpJUFp0WmVzQjhLMmhvcGRHTEo0VUU5Ui9z?=
 =?utf-8?B?Q0doYlNMYm16czhEMi90amhHQVNwU0xqOTk1UGdNTk1sM1k3T0loRGxxYW5C?=
 =?utf-8?B?Mlo2WWd2a1A1ZGtrYXIycTcwdnBJYlo5VEZaZVoxdDBsN043MUpxRmRac0d0?=
 =?utf-8?B?a2VOd0NhbWFaQS9PeSs5YjBnMkFhOXBZNnR1dDlrM0p5b3NPYUFXVHQ0alNu?=
 =?utf-8?B?eGlwY3M4ekRoU2g2ZDZVT1JhTHFlZjZZQVltaVJGZUxERFMxSHdCTmVHcW1r?=
 =?utf-8?B?RU9tTGl3RStYaVo2TTF3Z0xDazhLb0J0T1k2K2pCenREWkpYY09FOWY4TmpJ?=
 =?utf-8?B?VEpYWHcrcnh5SUlsdEdVM1ExT1NyZE8zWVlZRmNPVWNCVmZkVXFBUUJENGxk?=
 =?utf-8?B?Zml4SFQxTUF0YlJiTWkyNkRMb2NKdVNRVXA4bDVHQWs4cGlsTUh0b3Y5UEwv?=
 =?utf-8?B?UzNIOXVQR2w5cVU0cGNvM0xNN0o2c08rOEJmdzc5S21DbG9ydytWK2NvNHJE?=
 =?utf-8?B?dFlUWGZyQnhnSjBYdkZsd3dONjR6SHdKVjJ1ZFp6QjBkTjN2WnhBdmVrZ1dm?=
 =?utf-8?B?MWZqcmJFU0xMeDlRUGVReGZ5SGVEOUxNanp5cTQ5QVR5VE9SUTNYeFdjaW9Z?=
 =?utf-8?B?MGV6NjdhOFNxdnNzUGF6T3p4LzdBRTdyZFgxU3g5UVpRS2tqQXhJZ1FwK1hn?=
 =?utf-8?B?TlU2L0oyaWRta3Vld2JKVENuckZXdmszd1I4Yjl1ZnQwYTdaZ2xiMmQrVTg5?=
 =?utf-8?B?VzVJcEYycDNnMWdRN3dZWFZlWXNob3VtTWwzdGRQak52WnNrRnZzYzZZeXkx?=
 =?utf-8?B?N1BsTWIybkltM3ZPOEt2UnpHNTFMd3oyR0pCanhjZ3ZtcERKTzk4bGpEQ3ZE?=
 =?utf-8?B?NlNiTWhlK2N2L2FreGVPWHpSaXRadGV6a1d3OUtQOS80dHV0OFZidWN0K3dJ?=
 =?utf-8?B?YmdOMzJ3MlVyK0tVT1ZRem42cUdrSVBmdXhkOW1sY2dEZ3g2QkNMMzE1ekpu?=
 =?utf-8?B?amtKYzExLzk0ZjZJM0tLc1IrNGpUSE1SM2YyMy9QTXVLZys3TFVnOE8rak1j?=
 =?utf-8?B?Q3RNd1YrUGc0SHQ5SFZjU0J4SXozeDcrSGRxRlBTcUd2WTV2c2lHNkN5WDQr?=
 =?utf-8?B?L2hNUWpXM0ZPNnZjNmhSZjRWSXo0cmlaZ21URXdxWktrNVpCaDdYbXkzNUh1?=
 =?utf-8?B?WHh3dU1QTjZybUxlQ3EzMWJaWFRWRUZBZXpxWjBNT1daYXhIV1JiQzc2dDBi?=
 =?utf-8?B?WTcvY09uVG5NZFVlRlNUaEFITGhBbzhrRy9SWmttdjIyMEpzU00yL25VY0xY?=
 =?utf-8?B?QTJwOE1RZUNBWGhldFpYYXhnb1dSemJxSVdWTnB0bFl6aHJGVFU4dnVLVGdG?=
 =?utf-8?B?bFoyM3duRmJMNWd1UkVuNEkrcjFuNGt6REdCL1hNelZIT05ad3U0WThFTCtD?=
 =?utf-8?B?V2hzOXBsQktHYzJGNFFPa3ZXMWNSSmphVXlVQmRrKzVjbTdqZzZYenJ5VzNR?=
 =?utf-8?B?NkZJRWMvaGhZTUFCQW9EdzZxNG9uWkRsZXEyQmlOTnhSKzNSVTJGdk51SDhr?=
 =?utf-8?B?bjMra2FTcjBpbG53THBwQ1ZTczRpT3ZYMWRrMlNzYTNvN3gyZTY0UUVySEtJ?=
 =?utf-8?B?QUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 979be188-8eb4-450c-ad85-08db168a8c2a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 17:14:11.7224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +wgzbl7fGYLXRM4eoXNqi+E9iOhkWWcH1OuSbpfYE2QcP0mPbRZOdomfLwRoPgKdzqMHGobnIQS6fBLpnxmUvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3473
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Feb 2023 17:14:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10825

On 22.02.23 12:44, venkata.pyla@toshiba-tsip.com wrote:
> From: venkata pyla <venkata.pyla@toshiba-tsip.com>
> 
> Hi,
> 
> The following patches add reproducible build check in ci.
> 
> Please review and provide your feedback
> 
> v3:
>  - use immediate assignment for variable SOURCE_DATE_EPOCH
> 
> v2:
>  - split gitlab-ci and add reproducible check ci jobs to another file
>    '.reproducible-check-ci.yml'
> 
> venkata pyla (2):
>   kas/opt/reproducible.yml: Add kas file for reproducible builds target
>   .reproducible-check-ci.yml: Add ci for reproducible build checks
> 
>  .gitlab-ci.yml             |  5 +++
>  .reproducible-check-ci.yml | 91 ++++++++++++++++++++++++++++++++++++++
>  kas/opt/reproducible.yml   | 17 +++++++
>  3 files changed, 113 insertions(+)
>  create mode 100644 .reproducible-check-ci.yml
>  create mode 100644 kas/opt/reproducible.yml
> 

Thanks, applied with minor adjustments.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux



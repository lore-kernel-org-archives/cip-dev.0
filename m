Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D8B1C43458
	for <webhook@archiver.kernel.org>; Mon,  6 Jul 2026 09:16:46 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.8])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.146235.1783329400759038809
 for <cip-dev@lists.cip-project.org>;
 Mon, 06 Jul 2026 02:16:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=W7PwxhK/;
 spf=pass (domain: siemens.com, ip: 52.101.70.8, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cxjxcosr3E6njiNtT8APlCZLpNxqPxYIC+dRAxANW9orELGCbNKMaLzqDKQ5NYlkof14gopB6GAKYjsKbX7m3bWeVedETx/HbDosdCwTGUvKfod4GJ6JKGfUHN/cvxH9JRE0tTXKW3cNStz/e800vPf1gcCLLf+I6IH+pm4+peQ9J9aqjtP98YWDpaUt6bfj7B51EJmrZ3QPSJRNVtDMrQB7QArrAkFlxX1uqIimFzhhRirqDYIbo6Bz27G4Z26NEgJkjXcWFlWAI1v7VnRIzhi3avjKoyQr6/vkGMqrCohNmK68HcJRAYeBA0tB97FoRjN7l9XI8ecGU5iF5Qhnhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Rlk43Ov3E67j5TeYx0hcGH3alrmeqUjE/cHroWT4i4=;
 b=LNNA9xPpfzTtREzse1vpeA/fAaGMkfZgnqFupotN431ePGA95JmWyag9V1XghpsWorZ/Sh+mziooxBbHiSPQ6LzJn7RKbGMLdxfT6nDx9ogUrNaQE6tdHOtaQTPS9FJxOocdSTy7wr4JiwkvTL9jC5D0zgoLqBjqdsVoGhfs2zL/6gAkPONfpvvMESvdPGi8vnTCDciWcPbuZ3loCTg0CekvU+g2YX9ZuFLD77GrodtUtPoKTErkbsjWvFAqcBzJToT8LI1GpRHZFXNY0vtpGAgC78QrjUebkO2WH9zSjeQP6BWluSdtT838r7baCxgGkI90VCPN5W0ZY/MEvVHsaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Rlk43Ov3E67j5TeYx0hcGH3alrmeqUjE/cHroWT4i4=;
 b=W7PwxhK/d+yBixSyLZw63KKn4ENAfED1xcYsHImh+TZJglKhwOVG0oH2Ewz2fbCS5MlCqc0RFXdA8Tl50EVUj46lsb4bYjJif4aFQIHdH4SETl9lOX9EH1bm1AhevWxb3WcsDQ6qJZAvDsgHXvJ4r0fUUC0Xo9SvlOq2jmWpWjwlHOspAR4pj7m1EiGrX0kmIyprPLgyke5G2Hx9ag+YTRePrWfksLRJri7oh/uZMXc/9QXr8TGiReO0JYqL3pbFcuEp80Z/S/jZ+Xikon7nJa1wzICAkaafceCgWW3nfjF+5X/PyaAFFUQXDqe2IBRI0iJZdQnxu3aW8OpiBcjeug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB4PR10MB6920.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3fc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 09:16:33 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0181.010; Mon, 6 Jul 2026
 09:16:33 +0000
Message-ID: <21a1c0f1-9107-4dfd-bce4-cf67ad6c164b@siemens.com>
Date: Mon, 6 Jul 2026 11:16:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] swupdate-handler-roundrobin: Update
 revision to latest master
To: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>,
 cip-dev@lists.cip-project.org
Cc: Adithya.Balakumar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
 kazuhiro3.hayashi@toshiba.co.jp
References: <20260629085730.416650-1-Shivanand.Kunijadar@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260629085730.416650-1-Shivanand.Kunijadar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB4PR10MB6920:EE_
X-MS-Office365-Filtering-Correlation-Id: a2c7b602-6236-4c18-ad42-08dedb3f45a5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|55112099003|22082099003|18002099003|11063799006|56012099006|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: 
	5iU4k0ROQcHO9Y1Yk4bTy/++W7SD5GVR1ztvDmIhKYjCjnPsZHJPa6lKUuIBb6Rt7bav1czx+QhRV93L/wv7qM5L0B/0/PypB4XbXQDCcNnhPjIT039NJa09DcSuxOFfAVOC9rmHhtVvdvtgPJU0SYSWlFLCdhjES+JsyMc5D8ZuvkK5HNOs/mKbwEYcMnLVX4486O/FSJ1yXaQ/FecE6fhj9F7yaxlHm9d0HRL+4YwyE1rDMrUQ1xu2Ff5o+n+R+xCqIPveNCjTzdw3Uqdq0Yz17+3dkUxy586EZmi9PQMDp0JQhd7XZf9z/Pddr0lKlTXOo25tMWZJHPFU78PfFIl5SLEZAoUD1qvh2Yxa3VtDEj6Cz5YcKamJyXk4jermEZsCukZlB3zwvFIa0I+4PFDvgYewLXgqe7Wk76nlp3QtZiOQ1sWBj1AoLzkJQlu+UAaiIQA16nt6Nryda3pmggdwinhyA9HyO6KNhSYARyEWims+wJdcuKk9ITAozGCCnOSbAqn969UJatJDSswNXwdBwCvH5QKAEF0voIT4qqdBFtX9il+6YFy+1xTdv1mDSNuPaT/jQHIxqZEHEYIQ4YzVTYtYsomWiXhvKT+fC4v8m90MvVPuij9pHpxP8w6LPq7pJh5XBEhwgpYdQHY89kFAnAoknv16s5t7PpCC4iY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(55112099003)(22082099003)(18002099003)(11063799006)(56012099006)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YTUwTlVDYlQ0YkF3YmNkd0pqOTgvdHhsQkZEY0k5Ujg3a2hBTHhSbG9sanJF?=
 =?utf-8?B?d3dQYkIzR3NBeXREQW83eTdxUkJSUzFVQ1RWTHJCTEJWTHkyRE9XU2E5MGpT?=
 =?utf-8?B?NERGb3M4THFRNzA0ZkpVVFFvS1Y4K04wWGJKYnFxYlhSaHY0c0hqbmxhaEhQ?=
 =?utf-8?B?eTdGSWhJeDdmbnozUVk1OE5jaVJjaFBFbTFmamk2WXJCS3M0SDNYYTgrb0Ix?=
 =?utf-8?B?YUFvc3F6YnJzaEZ5U3BtUTdYRjZENThlTjY1NHlnSzRQYnVVMmhNbVZ6MVND?=
 =?utf-8?B?d2FqSEdJWnBhUWlhNDdLTWFNN2orRDBJRTJHdzdxUTM3MWRvQ0s2ckhwWStw?=
 =?utf-8?B?eHNKTzRJRkdPZjUwMHFYbUp1SHJKZ0hDSFlBZFZxTWR1cm9VQVFadXhHOFhx?=
 =?utf-8?B?cWhaRGZUOWdQVlVaUFRtUUpETVVRWVlnYkUyZnpQM1pzdWdqY0tCM3B6UnUy?=
 =?utf-8?B?V2tHcGVERzFKZGxTenRVUWU1VmtqTWVqYTBGOU5yd2MyTE40TUtackN1Z2dt?=
 =?utf-8?B?UUhtNTRkSTdLT1NOTkFwWEdrR0ZXVEVCcnkrdFFrUVRIZjBiUmk1RXhKcm9h?=
 =?utf-8?B?bDhrRzF5UTR5dlpVTFcwME0rNC9QQk4zaGtTRi9WWDVLVWZiNWJPYVMxT1gr?=
 =?utf-8?B?SGxSZklNY1Y3UUdOSWpWTlFkRWVNOVlVM0s4ZmR2SlZYRDFBb3pVelovaytM?=
 =?utf-8?B?eDQzZnA2NGc3cnFjZUVSUmR2Q1dJaGJxbVlSaTlBK09ia05WcjJBVWxOUXVF?=
 =?utf-8?B?K292clhCQ3VMNnB1RC9Mb3ZXZVAydjI1bXNwKzJyd25yYXVXdnc4V1hUT25k?=
 =?utf-8?B?YWUzcWhtbmtvV2lRR0R5YnlyNC84WERQdUJ2cU1EM3o4SGdOdnJ4d1Vwbkpu?=
 =?utf-8?B?RWdPM3RJcFBPNGJ3bno2YXgvaTVFRUVxY2wyRXFCZ3czOEZtOTYrTTVtaGxE?=
 =?utf-8?B?SkhwbGFSWCtDUGR6UnhkTFBDK3hCSUV1K1ltZ2NVRE5iYzAraFo0R05KSEND?=
 =?utf-8?B?aGZCM2E1SWFueXZVTDJZayt1MnVwQ24wS3hKcVMvMG8wQnEyUEEyZURhQTdi?=
 =?utf-8?B?QXgwZm0vZHBjS2JnREdldzlzTEtGTWNiZ3c5U3JzTjdVb1VaTVpKWlBUN2xV?=
 =?utf-8?B?VXNiUlZvUFBhenlUZEpLanVVWi9IMXNJL05JamlqdjA0eFdBQkxGSm9rNFZ3?=
 =?utf-8?B?YmJucmYxRWVNV0lYajJBWld1YXVYc1BqRmhGODlrOFJGSzF2T1V0LzdtVHV2?=
 =?utf-8?B?OFdoNzZrSTEyRVgwc2p4WUIxWDl5M2hIOVAyQTJyNU00cktyR0I4K3BURWxt?=
 =?utf-8?B?d2pOaWFvWjcvOTY4L0krMFNTdXNZc0Rxem5ER0phTzlybzFWaEJVUmZIZlZY?=
 =?utf-8?B?MlBXakxxWjZXNmZ0Q0hNWnh6SW5hS3YzWFJCZHlsWHhsdmFMSXBnam9jZllh?=
 =?utf-8?B?d2xNOXZEMU9DS2xMZGcyS0xaTWJ6UU9BNlU5MEwrWXpCOHJ4eEs4Y1owaU1v?=
 =?utf-8?B?dzR3UWlGLzhHR0tpNXArcS85QVA2ZVAyMi9vaVY1YW9ySXlYbkRqOEtQbHk4?=
 =?utf-8?B?MnVOVEhoaTdvYURPaU9OTmJoVi83aUdpMmR0d1U3VHRncHVGa0YxTkI1YXRU?=
 =?utf-8?B?cnZ1ZkhESGsyenRmTWxDYmltWk5pNWZuTE1QdmJuRUVzRlJmWXRmVE5zdEZk?=
 =?utf-8?B?M0pQZW16d1h4bktrUk5wT3Q2QVNjZkdoQ2wxNEVMRmtMY1kyVWNLOHNma214?=
 =?utf-8?B?LytOQmhFTEZFVm9QU01OWWxCRUFsdjEwTXBHN2FjV2dISVFOUDdwd1lLVzVu?=
 =?utf-8?B?WHhqc2hMYWI0ck5sanV1YXhwZHg4RE5RR0tuckIrdVFteXYvcGtnNE9Randx?=
 =?utf-8?B?UXZhMkZQR1FyZEpFcEozRTB2THA0bklic1FpeHRKaGZpem10dVZGZXVyem5X?=
 =?utf-8?B?TENMd1lqODVVRWlIVVlKWXduS1pVQkxTczZhcUNQU1RsaHArWTNFNGdwUEZy?=
 =?utf-8?B?b1A1VVYrSkFyOHpac2wvd2tsOWZCRDBZQ1lHNXFxYTVVNXV0Q3BtZERscU55?=
 =?utf-8?B?d1BWRGRZbzRPS1JhU2dwcFJkV2IzQWRtZnB0UlkvOHVCOVhHeXRHWnJTVWdv?=
 =?utf-8?B?M2d2WVZ2Ujc2M2NoSEdWYllxTDZGWXBmQ01qT2Z0NW5xUzVubUNKbmx1V2E3?=
 =?utf-8?B?ZUlJbUJ0SXF2djJmZVMvSzV4bnZGVElockIwOFNwWDR6TlNmVkU3ZjNPcFhy?=
 =?utf-8?B?MnZFYjkydEJkUDd5N0NVSFNXdDd6SUViYmtOTzg5Y1pydjlNSHpMdm9TSGFy?=
 =?utf-8?B?OWFjTkQxNWY5TXozdEIxeEhla0diQm5uVDhlQ1NqMkcxNnNRNWIramc1M29W?=
 =?utf-8?Q?nGKrLyz+gPELF/Tk=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2c7b602-6236-4c18-ad42-08dedb3f45a5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 09:16:33.3120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wIYn2l3/Hzt80Gg3JkD8dCcLPN5uqH+sf18ChoZah8Fj5c07hZDQocDuEHIL9iofss7EHD/ymujV+3hIt68sNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6920
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 06 Jul 2026 09:16:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23458

On 29.06.26 10:57, Shivanand Kunijadar wrote:
> The round robin handler is updated to support Debian sid by making minor
> changes required for Lua 5.5 version.
> 
> Closes #160
> 
> Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
> ---
>  .../swupdate-handler-roundrobin_0.1.bb                         | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
> index 2ba192c..9d9f6d7 100644
> --- a/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
> +++ b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
> @@ -15,8 +15,7 @@ MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
>  PROVIDES = "swupdate-handlers"
>  
>  SRC_URI += "git://gitlab.com/cip-project/cip-sw-updates/swupdate-handler-roundrobin.git;protocol=https;destsuffix=swupdate-handler-roundrobin;name=swupdate-handler-roundrobin;nobranch=1"
> -SRCREV_swupdate-handler-roundrobin ?= "5deb75df5469c5a66cdd727eb72af83ce0784054"
> -
> +SRCREV_swupdate-handler-roundrobin ?= "105ba14dca6fbf168292a1182e8c1e18a728bcd4"
>  SWUPDATE_LUASCRIPT = "swupdate-handler-roundrobin/swupdate_handlers_roundrobin.lua"
>  
>  SWUPDATE_BOOTLOADER ??= "efibootguard"

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center


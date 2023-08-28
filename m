Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32BDFC83F11
	for <webhook@archiver.kernel.org>; Mon, 28 Aug 2023 12:45:09 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.46])
 by mx.groups.io with SMTP id smtpd.web10.12540.1693226706539646761
 for <cip-dev@lists.cip-project.org>;
 Mon, 28 Aug 2023 05:45:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=n3OxKJjA;
 spf=pass (domain: siemens.com, ip: 40.107.249.46, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QjNAjHK7+bpnlyuRZ6ydN8+CUPmq3FgnRUt9QY4QGY0IqORnKXBHoy9K9w4IPHIhwL/AGJtzDxZFSUDqP571ybWD/ldvuzhrSQ/K9mOVVFUfCT/ZFxvd4vro0PMKSiW7hp9eBdoAwqoaVKwRMVFgLZ1RhZDLYIgnqMUs4+8FilaQLMy6mi0Ozp3Ca5A8sG7VfNrlnG8H1zq34iZx21eOisLqZaOgnb1iGFSI2gau1E4UoDDPMriZQWsQfi8m66w6NtmIEIYMuI4WkhOQnlGS6zdk3lp7iDaBeZsW/0s1cO+nXhAIv9bV8f0stuEa7eVtWR1pZMPBpRjsGTNazCPoEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kKoklf+TFUB+fResBjXY8FRyrb2qxbvZcGV7oSKb7p4=;
 b=W6e2RlYIzkfRFuFc59WjtNCd86IZz8N4kplpVo6bw1TVbzaPQ86dd9yQ4rLwlHrFmjhtAPYgquhEYpHrkv4aA+Q09ZBuYY7f6m2LR17W1Ni+wydDu6ybKSkmuG8X3SiwZAxFAk1pYoAj2aN5EnrsILx4dkUigWNIom2kNJUUa/Bl4xJH3Yd4wC1rB0CEO7jW8OXxgJxQ8nPHO4Hva2d6w/Y6fBGoDTxIGZCR0veC6slKBRW8YPvKCdWOEycVpmNf7kkf+2sw0SZxuwoiQB4GXNWuUb/uPcaGCOBeo7fV/uB5RPMEiAshZO/fKbqKbW+jNLWb6Lewe4Snoc7OoNTiWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kKoklf+TFUB+fResBjXY8FRyrb2qxbvZcGV7oSKb7p4=;
 b=n3OxKJjA58umNKU6Y2Rk+9Jn8xnP/Qfvu8Ttet1U5tx/Q/bLpEpIJMOsgl6akqqKvvNdsXmT314XwnzUZLKO0hTE0j4hS4U/yd7ZuRnWAY9w2QrHwf3qIIlBb/uBibgBKvBfTqwSZFrXLCyNCkCg98y/AGFmXwx7MgxBAyhSZfGUaVBkNuwTzen327fn+HxTktXBjApJNdAEY9UBvWHfoqCThffUXlUVyhfv/99S8BYBPR0EsZJxGGuErxJya9/1SlwJbeds0M0W0RJEh4b8JfxuxZoXi8IxU5cxa4rGERzimVb692G5uqEB+OcNrXojUt35LiG3VCbEaweo4Au34w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB6329.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:504::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 12:45:03 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 12:45:03 +0000
Message-ID: <bfcdf1ab-f22f-432e-b232-36733465dced@siemens.com>
Date: Mon, 28 Aug 2023 14:45:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Enable secured boot for BBB
Content-Language: en-US
To: tho1.nguyendat@toshiba.co.jp, cip-dev@lists.cip-project.org
Cc: kazuhiro3.hayashi@toshiba.co.jp
References: <20230828104315.466393-1-tho1.nguyendat@toshiba.co.jp>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230828104315.466393-1-tho1.nguyendat@toshiba.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0167.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB6329:EE_
X-MS-Office365-Filtering-Correlation-Id: d81e28c3-ef14-4dc0-32b6-08dba7c499a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	rFK10Sb19VlCQOvvJqturPlpCnaqfEPMOtyMLA+z0cdNBVsx1YOrZu/gWfoiuBumRdRYZNmFR6w2vP0sZWYnLH2urPgs3Z+TsqsJCPLIv3lf/0YWTiGW3Yuq6wQY9vVul90IQdvUvQJYpVkl4VYOcgzKxhaR8kMtFEeC760x2xkq31EfqxBvY2+rbVzWj/wmh1gIJNj/VZtGd3iT7Ci7WLC6ColRz2lvE3s4razxaf4OJttLasiwUbxGm+QiRcqDwt6AEtvf7wMpM//H3agFCmG81b74eYt/9XQpavRm211Nah/3By3/LXdV+q+5L91SInf3OvWgJ9wPtpnQ605UThBIzIa+NQFVwgJrZKQw8ajfwVR8H9d4jmxUKdkDtn3OKzgqwygvgYwivLDDiNwkFYGbQDVmGiHGwkVG5hPHGQr/1bv283hjw2dzOqdESbE+V57DPquk/91zL3k00OGC+1b2lv4VkI2o1AdtXDwpkbgdZupPt21sgeIgfcSJ3AsbmbMOln07q2lLDj3ZZ/UphOSG0MT7C3kVoD0yK0Ai/5z79d3ITY4eBEI3ccahKE+dOi6UoNKJaU1XYloIj3EUhXLiJEUEi7mFgV+b4SjoA3bQoUIKuF1snIVQq0wR2y6ZLxhPC+lhyt+Z1d+4Id3v5g==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(136003)(396003)(346002)(186009)(1800799009)(451199024)(6512007)(53546011)(6506007)(2616005)(6486002)(2906002)(5660300002)(31696002)(86362001)(66946007)(44832011)(8936002)(4326008)(82960400001)(66556008)(36756003)(38100700002)(41300700001)(8676002)(66476007)(316002)(478600001)(83380400001)(31686004)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bVd1OE4vSTZNODRYTVVwcXI2SmZjbkZReVNoMmZ5azNsNWNwbVJBelF1ZFFV?=
 =?utf-8?B?bEtaR29ZLzM5T253bG5pRHpHbm1ZTmlzMThUdEFSd00vWi9tQmh0eHRxc0xX?=
 =?utf-8?B?WjRLRGRXYTg2b01pSE56ditJN0VhY3VvMlVacEtwV0hSQk81bThZT0hudm94?=
 =?utf-8?B?cHBDaUFkZFo0SXJTdk1hOTJKaXRlcFJOazM3Z2UzSVcxODNPcjVDWUpTZU14?=
 =?utf-8?B?a0RtNU5OVHNvMzNUaUpMQzArSThJYWJDUmhnMXprNXhXMm9kdVEwVWwvd1Nq?=
 =?utf-8?B?amZ3TE5lWjJJTmVrWTZMWWIzS0xKdXU4bkNOeXBaTnNQUGRPeTh5Tno3aUVp?=
 =?utf-8?B?WmVWTlo3Qit3OE54Wmh6N0xNOGVwN0NLencrN0JhQk9udTdKSkdaMUs5ekNU?=
 =?utf-8?B?WmFRUFR3V0RkdzYxZ09DQnNPaklaYTVFY2N1S3lqMWgxQVNudXpwMFh2OVlh?=
 =?utf-8?B?S2ZQOEhISm5BcTlIVmlqZVg0NTE3Nnc0QWNhRHVrTG9RaGZsSWhQd1N6eFZj?=
 =?utf-8?B?TTBIcnRUMzNZcGlqc0RKbmZjSzR6Sk5nUW81dVVydE5ZUlpjWVYyYVlqTmhz?=
 =?utf-8?B?U2wwdkhnZTh5S1dpUTQzdDIyb0VZTEVGUzNDaGI5cE1KeWJ1cy9ia3lrUUUv?=
 =?utf-8?B?TWlZQzM0a3Z1R1dtL3Uxa0pITXBYWlZKOWQ3YmR4UGFWYW9ta0ZFT09MVE1E?=
 =?utf-8?B?U2h6ajlHbHRqVENoY0g4RTV3Vi9sL295VVVlQTF4RksrOUMzMW9sWkNoT1Fj?=
 =?utf-8?B?dStQNjVRSXVQTVEwcThtMVlCalVJSGErZnZDQU5jWmNKRlh3WVd1WERuZVI3?=
 =?utf-8?B?alFmcEg0RXFUdENJN1IyRW5QM3ltc1BrelEwQTVyd1oza29OSHVjajhkKzlM?=
 =?utf-8?B?TTRNM1oyYUp0aFh0eSt1dUFpbGNPUjlseGJ3Uk00TVQzL0o0S1NQaWxEaXBL?=
 =?utf-8?B?Qm8wMlh0TmlTRDZtS2hGMmswcjlXN0I1TG94UzlYaXdORE5WajlDOEhhcGdn?=
 =?utf-8?B?dEo0WWJSaWluOVdhMUpnTC9taSsyQXFhRWVPSlNrRkkySjhrYUJybTNRZ0Jy?=
 =?utf-8?B?Uk1Uam9jUG9FSlZ5TWlsTHUxNWw3K0QvdWx1MG15MTZLS3VkbEt4MFF6aXd6?=
 =?utf-8?B?Q2ZuU2tEamZHWEZENEQzYWlxbFIydkVSQ1BFNXdaVnFlcGEwV1FQNVhVbnNJ?=
 =?utf-8?B?NjBsSUNiZ0hDRHdaaVJQOCthVkI3eUxMZmlzM2hVS0hBSWpIanJKMDBBOTh4?=
 =?utf-8?B?YjZ6bDE0RGY2TmNnNlBKa054R3lBR2ducnZ5b2g4QVBpSGtxZzNUUFhaVnli?=
 =?utf-8?B?aUlmYWVTdFhlV0tpWmpXRXI5czBLcmRnY2VJM01TQUw5YklHRzRuODV4N25C?=
 =?utf-8?B?alMzcXlVYjBpbHo1SHczTmJYdXpDYk5KOHIvTXd2aEo0cEYyeXpUd09JTFo0?=
 =?utf-8?B?WmNTYXpSaFFCVWdYQ2pBNXJBeGpWK08wRG9FR1dkMWJpNk9jSDJGOW9MVFlI?=
 =?utf-8?B?MzBGcE5EUjltSkppQ2tOY1B5Qnl1TlJPQ1BNdFExR09KZkJwZjE0TEo5Y3l4?=
 =?utf-8?B?ZDFEZU4wbGp2WUlRaE1iT0M4SE8ySDkrNzFlZnNUVWFlRUpaaEZCYWF3MU9S?=
 =?utf-8?B?RDFpOU0zeUlrRWxOaWtCL0hQZXZOQXl1WURsUlh3ejVRcStMSHd2bi9Bbjho?=
 =?utf-8?B?MEQwbkJZL3NYZ3c0MU9KWW8wd3V0K1c4QVJ0WHRQTXcyUFZvbjUwcTdrK0Fh?=
 =?utf-8?B?YWNmZ1pxV2lSRWVNVm8vTjB6bXU4WCs1YVFrWmwxRjE3QVdOOU0xQ25KaFNi?=
 =?utf-8?B?a3JvUEkxNG01RDJ1TUhKWEtxZEZHMXlSN01oREN5WDZzU2Myd0FDTG1wZ3hX?=
 =?utf-8?B?TDVhY0Q0VjM3OUhMdTVVY1JqSG52UE5tK2dUZXhaZThGbjVOaURPSGxjWXZk?=
 =?utf-8?B?Mll5d0Z6OEQ5ZTJST20yMHkwUVRubTZ1NDRpT3VYUk1UdjgxTDNLUDdORHlD?=
 =?utf-8?B?MlFFS3IwUVBNSTNhWjBsUlVOeWp0VDRqUkNoaTIrTzUwTHc3cE5tdEdLak1F?=
 =?utf-8?B?QWxUNjloMDJqSGNidUxTZ29FRjJ1WktRQkpNdE1UVnR3c3ZkZENxSGhCSG9T?=
 =?utf-8?B?Z1F4VWlRVldrMDFFUERGVEM0N05XVGZoOWRoaVEwaHpyemxrdGJrVEdjSDZu?=
 =?utf-8?B?ZVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d81e28c3-ef14-4dc0-32b6-08dba7c499a0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 12:45:03.6867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ePPh/jqb0R99/u/zWWXyCuQdQZmtcYQxzEBpqb6r/NHd75/MjJFUkv74UkSNbgdq+hdyKrcFhUZtTf3E4NRNCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6329
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Aug 2023 12:45:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12886

On 28.08.23 12:43, tho1.nguyendat@toshiba.co.jp wrote:
> From: Tho Nguyen <tho1.nguyendat@toshiba.co.jp>
> 
> Hi,
> 
> The following patch series enables secured boot for Beaglebone Black, please help me review them and give your feedback.
> 
> Nguyen Dat Tho (3):
>   linux/cip-kernel-config: Use latest commit
>   bbb: Enable secured boot
>   u-boot: Add EFI secure boot dependency
> 
>  Kconfig                                       |  2 +-
>  recipes-bsp/u-boot/files/secure-boot.cfg.tmpl |  1 +
>  recipes-kernel/linux/cip-kernel-config.inc    |  2 +-
>  wic/bbb-efibootguard-secureboot.wks.in        | 13 +++++++++++++
>  4 files changed, 16 insertions(+), 2 deletions(-)
>  create mode 100644 wic/bbb-efibootguard-secureboot.wks.in
> 

Thanks, patch 1 and 3 are already in next (I assume you didn't change
them in this round, did you?).

Patch 2 now makes we wonder about more fundamental things: I'm sure we
can boot securely via UEFI onward - provided we can store the image keys
somewhere. How did you address that? Did you test that you cannot boot a
manipulated rootfs? I'm not seeing anything that enables secure storage.
What we would need is some secure storage so that we can write the UEFI
keys into it.

The alternative would be a static chain with (public) image keys
hard-coded into the firmware. But that would be only ok if there is
nothing to store securely during runtime (CONFIG_IMAGE_DATA_ENCRYPTION).

Jan

-- 
Siemens AG, Technology
Linux Expert Center



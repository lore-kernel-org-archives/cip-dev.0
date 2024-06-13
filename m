Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E35AC27C4F
	for <webhook@archiver.kernel.org>; Thu, 13 Jun 2024 16:47:15 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.64])
 by mx.groups.io with SMTP id smtpd.web11.13706.1718297228650584704
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Jun 2024 09:47:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=sh1nQI8M;
 spf=pass (domain: siemens.com, ip: 40.107.7.64, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eRPvtXMR9fnQBmBg7zuz5OGSnfA993LpKBPnSAJEu4Ob4NykXzuSr6WVcS9TUjQR9OtoZMxKNVahiNlFs5y7MGzm1jHQtbHRJ0QB2y6WmC7QE2rgkMdWp76CONhmueYmcNgRA2M8k5w1+T6WEiSZjUyokVnlOtakstj5euZSKkPOJ+A2viHOPud4hytCFuvdD+8eVcSX4RsTNWbPa+AvVBsxE+K4LRNnRm+PXWszvvlQGxMSOohFEL0cvY1WJ1g4AWqqgPUHLeTEZSkyPkoRc3h18I/iWjgGQOhcD5a4DtSqPuwx0tdabB6Fajzcji9NDI+bz9X6Zkxp+93y024bzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OFXtD/fOJ88Gg4TY6xob80f1CpyB8kO8fj3evU9dqx0=;
 b=YwJRoZIpwULqTL4B4l7v+n35t8wltYN3fqZ8LdRXSX4946juOsIfTMmin0KLtZRopeuXhl2kq9Wh4rNpe1e39FNCryEyfen5vtNea8DaLgK3Or4VbPjktI2xxJ2DtIqumrHtbsaJ8TcxvMp8iJ84t2o9eBn9J87A/QPBxknXVaLKj50iarQWDc4JN7sKX7zLp5IQGFkm8Ifji9SHdvJCV343JZH5CwVSjuYY8F4EUV1lIUVqrxuzEDkRJqw3+NIiVOhYk6vjlGFiA/WQish7rPQJE4WFVh4gsiHPZJu2u61aQ/hH/tPJeaNW71By6JB/jZfnND0Td5FOTKC+wr+FxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OFXtD/fOJ88Gg4TY6xob80f1CpyB8kO8fj3evU9dqx0=;
 b=sh1nQI8MJs+l+3jUArQZxshNCZvmhHABS0C9tU5hVFpNu0uhNisDmKIrbMko3wD95A4GidZi7cWDfV7TlzxG96vA4NBu7cl304YqjKw7oOt/FBbYnnQl7wyswTTzJ3CIkj3duQPDa72Szj/rSAlKNpXiznRkxa+uY29xyEd3m7qs0uVitcHtXNyfuVlx/rQCikdxg2WUEmUQVS4otqNHXglbthasXHGK/tG5R94/h3HpFjbM4rqUyiG2t1DVfxDOOd+L/ykBeQHMUFh9T7GOIy/Uqctg4g/l9rqK41YZE4FCswBRV66v93nxt0LSKC92Rpa6Bm8Bp3URPAFNZpIILw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6747.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5bf::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Thu, 13 Jun
 2024 16:47:05 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7633.037; Thu, 13 Jun 2024
 16:47:05 +0000
Message-ID: <23148188-750c-43e5-9516-bccdb1e779ed@siemens.com>
Date: Thu, 13 Jun 2024 18:47:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v1] doc/README.swupdate.md: Minor updates
 to verification steps and additional information on usage of zchunk handler
To: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>,
 cip-dev@lists.cip-project.org
Cc: shivanand.kunijadar@toshiba-tsip.com, sai.sathujoda@toshiba-tsip.com,
 dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20240613092857.354965-1-Adithya.Balakumar@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240613092857.354965-1-Adithya.Balakumar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0117.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6747:EE_
X-MS-Office365-Filtering-Correlation-Id: 023e47ac-02ea-41f1-0ee1-08dc8bc87546
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|376009|1800799019|366011;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?elVsWG0xV3E5MGcxTUlNdkN6b21JMXppOHdRSUVsSXZSWFBxbm5WM3FQelJs?=
 =?utf-8?B?UHFtbGljazMwVDVKUmdEM1MzM3Y2aFFpcGQvWHhRbitDYmRZeWR1aWgwaFV5?=
 =?utf-8?B?STVaQzI5L2RFT0p4TCtQdmdsUVRVV3ZFcExmdkYzZFpMTWtmNE9tUE5ZMEhQ?=
 =?utf-8?B?dHlyUHRNb0t1akdzeWlyVG0rR2dVNnBMOTVQbDgrdkF4YTZvbjhXUzQ1OGky?=
 =?utf-8?B?WUQzT2c0djlqKzFRZnpnZWlYODYvbld4enIreURBbjcvQnM0MXNlcERkZEU5?=
 =?utf-8?B?RjBKMjJuTWY3SHV5QVhvU2J4czNMUEU0a25IemU4NUJXWmkvSXRPem9TR3Nv?=
 =?utf-8?B?U3R3cnpTVFFzc281d2hWZWpPYjV1VEVQdEN5YTNPdGJuaGlQb0c4OUZScFdR?=
 =?utf-8?B?Y0hqRUpkQlN6d3dLbDhUaXN2MEg4a3JveUh0aHpCWGZZQVp3Snh4TUoyMkFH?=
 =?utf-8?B?UzBid095REVKbnZvbVVFMG9Uc2xQQlN3SzlKWHE5VUlHN1A5KzlhQjQ4ZDk1?=
 =?utf-8?B?bGJ2bkV2L0hWV1FwYTVmQUpuYVpCTlpQT00xQzhFTjNjaVdnQzFvZ1V0QmlI?=
 =?utf-8?B?NXEzWm9IMzFPREorbG1UQzZSb3JsYS9iYUxBRUNCdk1nVTBqeWhFaWdSLzUz?=
 =?utf-8?B?RWR0SGNsODhkYlc4K2E0aHMvSnZORDNSelNwL1d5WVltNkRpZi93Qm1EMVBi?=
 =?utf-8?B?Tlk3c1pQYWd1SWp4aG9MWm16cDJra1I0T3RaRVA4bHNya0RYcjk0NDQrTEJC?=
 =?utf-8?B?SWtEOE9wY1MrSWk4VXNXVy9SVXhNRFl4UndwT3dvQXFtazIxemZ0TkNOeWdQ?=
 =?utf-8?B?MFVpZG9KN05ITVVBMGM1dGtrWkF5MDk3Q3BVMXhxWFhaZUJIbkpTTVZFcWZM?=
 =?utf-8?B?Z29DTzNJSHNGR0syNm80TDRweWszY3pFN2ZiaUc0TFp4c21rRVl2ejNCV1Fu?=
 =?utf-8?B?NDNMMHdZeFhzSmU4bmN3bEhJS2Zyb0ZrdGNKZUZ0cnBoZzdxRUp0Z3B6VWQw?=
 =?utf-8?B?M0wvZDNObUNzcDlFSzZzZFlPM1laWllPNzVyS3VyZnE3NXlGM05INkswU3B5?=
 =?utf-8?B?cThMbVFLNHFabE9IYlN3L3dhY1VydkZzaHd0T2crSFhJRlZ0czE4NFhYZzNl?=
 =?utf-8?B?R2ZiSnlnQ3pSLzZJeXFRU09Id1JOcXBtTnNsQ000dmFKc3VSWVFQK2IzV3Rl?=
 =?utf-8?B?Y1dwS2ZzTXNWS0VpVFhSeDJRS0FDNXh6UUpJeFE0Zi9UN1pGeVVHbEQzUmE1?=
 =?utf-8?B?RVZ3a1lPc0xabkI3QzN4YmdOdlF3NHJZaitETjFSZWVBUnlYMTJtRmo5YVNh?=
 =?utf-8?B?d3JHZ3FiSjQ1T1VMNFBNOVFQL2NVV3F2NGE2bGNmeFJqMlRjYnhESWVSME4x?=
 =?utf-8?B?TWR1bEdoQUZkN1NlSlRBSkNoUnh5TGxmTmdnRjA5aVh4Wm9kVmgzVTc0dmt5?=
 =?utf-8?B?WnBNQUgzaFpGY3kyVFlmODhiZVBNVFNtL1Z6dGJ5S0lNbmwxa244SkY3R2M0?=
 =?utf-8?B?VkVYM3VPTzAxUlVFVlUrVlFRVm9qaTZmdVJHL3NXS1gySHh5c3JXWHVpVkxj?=
 =?utf-8?B?WmxTTVBJOFlhSGVBcFN6V2QvVElUSmo3bC9CbS9NcGw3Yk1WS0I2a2pGUlV6?=
 =?utf-8?B?ejVtMjBBb1BoYkNyVGxYUEllelJ2VHg4NnBrek1hUmJYMkRZQUhrWFN4bDhv?=
 =?utf-8?Q?tcehO8G0nKCw/ymgeV1c?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230035)(376009)(1800799019)(366011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UC95dDFEWjVGRXpxNnRrbWlqZFVWNjI5VFhHY0t1bXFxS2NzMWxvaE9BSy9N?=
 =?utf-8?B?OVQzM3gyekZxMkxYUVlDdFJHdUxDWFN3Ti9lTHFHUFlWSDJFVWVYREYwczFX?=
 =?utf-8?B?ZmIza050R3V0aHQzVEdTOTFNMC8ySTZnNjhESnhDd1RKa2l2RHhHbEtzNmVZ?=
 =?utf-8?B?ZVBlUU9SeExEdHZ3dUo5U2ZLR0E1VVd1RUtkNWxOVEpMT1Q1a0xpK0d5Ri9O?=
 =?utf-8?B?WXY0MFZnRE5KL2czRXhOYjdUNmcvQkxncFpabStqSUh3YS9Nb3BYZXBsS1hm?=
 =?utf-8?B?MzI3QzYvQm5EV2ZNMWNUN25PdTdkMERVbTRIVDBiMXRJdWV4TllTVzEvOVdO?=
 =?utf-8?B?bWZqQncyWFcwRjBFQ095eDlSSGZhM1JIVDUvQkpFSWtpZURKcEtSUG1iVEsw?=
 =?utf-8?B?SHp0Sy9VcTNpVmRUaFBSbGZwbmUwc3MzSTV5V1hKQSs5UDNMQUtwZGFDRkps?=
 =?utf-8?B?T1lKZXBXb2xiYVpXem5VME03M3dIc2hDU0JycVdjRUVic2NNWk9lQ013Q1lJ?=
 =?utf-8?B?Z1ZuellvK2NPTGpxaG42UEcrY0dIZ3l2YXBSamM5WGFTTVJQaGN4Y0k4MS9N?=
 =?utf-8?B?aDBXUjF6NmhHOGhrdlJpQnVISC9mQ0hXWDV3eStiZWFLcVBmbWJ0bEhyemF0?=
 =?utf-8?B?K25sckhScXFVcTZTV1gveWFpMFdRMmNDVitSY2MyUG0zMlRlU1NJQit5VTJG?=
 =?utf-8?B?U2ZPRWd1U3FZeDBVTktta2diTWN6WUM2N1VkUTdRYmxwUjFocXdFNVRjcGNo?=
 =?utf-8?B?dE1McEJpOWk0eDk0TFNMY2Jnd3N2RDZBU3RGdTRLQXVtbjJNVnNQbFNLRE93?=
 =?utf-8?B?QVJ6VHhDaTVHR1dORzVrcll3M0RRbEt2Qkp0QXhSN3k5Y3BVU2VqNnY1Qkwy?=
 =?utf-8?B?dTBwVURYOVBWbUNHd1JqT0l1cU1xUUt6US9tQnlHampleW1KNDIvdVFzbG5O?=
 =?utf-8?B?VHBJV3N4WXgweHdsWW5rdm9nd2N5N1dKcndQaERmL2VJQ2ZjaU9YMkdOZ21i?=
 =?utf-8?B?UE44NEFGV1FOeW8xSzhjZmNORS9qcERFR2IxdHhETWsrTFJXT1E5NitVNVpZ?=
 =?utf-8?B?QUhubzk1d2VNU2xxMUN5RGxoNThpY1J0L3N6dDVPeDg0cFR4NTN0Rm4wWmV3?=
 =?utf-8?B?N0R2UUZFMlJhL200ai9oTEIyUTUzZlJxdkI4NStvdkRHSGlrNmw0b2JZVnJi?=
 =?utf-8?B?NlIrNnN2emxZU2VTOHlVVE45ZnhITXhVanFoTGJmbDlyckROSXpzNE1wTUNQ?=
 =?utf-8?B?WDJ5d1RhcHF0MUo0c3FzOXFtS2lEYnJXZ1ltdy85NVdvQVplbjVMN3RUYmFB?=
 =?utf-8?B?c29hb1JwZUxid0tyOHlNWE93NXVkUHY5L2JuNlpDcWk2NnQzUTFzNFNzMmRZ?=
 =?utf-8?B?bXNZNGYvVVd1VFhMWjVjTW9FWVM2c2VOVEx2d3NJL09LbGxGRlh5dnlzMUZF?=
 =?utf-8?B?c3lPM0o3V0I4WTFSd2xqdVh1blpLZHhDMVYyVERINVptZWUwN1oybG5QYkJK?=
 =?utf-8?B?cnVrTGlIV0J0VmcyUkcveU9wckZHTTZlOFdrOGh3ZlNxSjdEdXlWbDFRQ3N0?=
 =?utf-8?B?eWVtMUUwakpNam5pdjJ3RVRSZ2lhWFpPUC9CdllmNmkxM2ZpV3pQVFJ5MjZZ?=
 =?utf-8?B?Nm5rTzV6UWIrN09LS2xvOEdhMGtKZC9Gc0xrejBGYTJ5cm15b1NhTjBWdjBu?=
 =?utf-8?B?TEhLOU9tQjZBUkhYbkhZRnpxaytxYTNPbFNLTTladW1tOVYvVVJYclN5cTBR?=
 =?utf-8?B?QkJTZ0ZaaWg1enFkeTFuYlRheEZQSytvT3UzUU5GcUpteVE2WEo5ODFpNXh4?=
 =?utf-8?B?L0NRWEduQ29nV1RlMWZoRkJBdHFXMjZxL3VsSHRDUmJHZ3FDZVh3Z21kcHFy?=
 =?utf-8?B?dzlONllaL01DdnlUUHJOS3YrQnZpbWlhOTJiMEhVRE5xOEE5NldncHBYUlFO?=
 =?utf-8?B?WVBxRkNkdnd1U3dwVVd1dzhiakt4VU5hNU1Xbm8rVFVnamdFSk1LbS9BTmRp?=
 =?utf-8?B?aW5UdUt5UEc2S1BEMVp0RHovM2czVXVHQnlxOXYwM204ODB0d2tMekdnQU1N?=
 =?utf-8?B?d3lIN1VnZGlINld2d25hdFJhbkU2VkZ2V1VkVHVKS2lNd3EyNXFQOUxFMmpq?=
 =?utf-8?B?bTNaM3U2NDlmdkludi9pMVR0OGx0OVkwdXpsd1JFQ3dxSmdueEhjeUVFbmIw?=
 =?utf-8?B?R0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 023e47ac-02ea-41f1-0ee1-08dc8bc87546
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 16:47:05.8092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dxsq4he4OD8YXxvamaXgxMlnAHcKq3A3qs09v+rUK2/hSiRoIk3xHPU7Lbnk3OkiqhR/GM+ijIu1IbQUSgwP5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6747
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Jun 2024 16:47:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16223

On 13.06.24 11:28, Adithya Balakumar wrote:
> This change includes some additional information regarding delta(zchunk)
> handler in swupdate. Also removed command "cat /sys/kernel/realtime" in the
> rt-kernel section since its no longer available in current rt-kernel image.
> 
> This resolves most of the remarks mentioned in #106
> 
> Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
> ---
>  doc/README.swupdate.md | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/doc/README.swupdate.md b/doc/README.swupdate.md
> index 8b03422..a5fbab9 100644
> --- a/doc/README.swupdate.md
> +++ b/doc/README.swupdate.md
> @@ -208,8 +208,6 @@ root@demo:~# uname -a
>  Linux demo 4.19.233-cip69-rt24 #1 SMP PREEMPT RT Tue Apr 12 09:23:51 UTC 2022 x86_64 GNU/Linux
>  root@demo:~# ls /lib/modules
>  4.19.233-cip69-rt24
> -root@demo:~# cat /sys/kernel/realtime
> -1
>  ```
>  
>  Now apply swupdate and reboot
> @@ -217,6 +215,7 @@ Now apply swupdate and reboot
>  root@demo:~# swupdate -i cip-core-image-cip-core-bullseye-qemu-amd64.swu
>  root@demo:~# reboot
>  ```
> +Use the `-v` flag when running swupdate for verbose logs of any errors.
>  
>  Check which partition is booted, e.g. with lsblk and the rootfs should have changed
>  ```
> @@ -384,7 +383,7 @@ First build an image using the following command:
>  ```
>  host$ ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml:kas/opt/rt.yml
>  ```
> -The above image will be used as the base image to which the update is applied.
> +The image is built with the RT kernel just so that there are some differences between the two images used. The above image will be used as the base image to which the update is applied.
>  
>  ## Delta Software Update using rdiff_image handler
>  
> @@ -413,7 +412,10 @@ host$ scp -P 22222 ./cip-core-image-cip-core-bookworm-qemu-amd64.swu root@localh
>  
>  ## Delta Software Update using zchunk handler
>  
> -Currently zchunk based delta updates are supported only in Sid images. Make sure to build the first image with Sid as the distribution (use `sid.yml` file as part of the build command).
> +Currently zchunk based delta updates are supported only in Sid images. Make sure to build the first image with Sid as the distribution with the following command:
> +```
> +host$ ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml:kas/opt/sid.yml
> +```
>  For Delta update with zchunk, set the variable `DELTA_ZCK_URL` with the URL of the zck file that is hosted in a http server and set the `DELTA_UPDATE_TYPE` to `zchunk` in `delta-update.yml` file.
>  
>  Build the second image with the modification as shown above with the following command:
> @@ -430,6 +432,7 @@ host$ cd build-v2/tmp/deploy/images/qemu-amd64/
>  host$ scp -P 22222 ./cip-core-image-cip-core-sid-qemu-amd64.swu root@localhost:
>  ```
>  The `cip-core-image-cip-core-sid-qemu-amd64.zck` file must be hosted in a http server.
> +Any http server (service) can be used to host the .zck file as long as the http server supports http range requests. Copy the `build-v2/tmp/deploy/images/qemu-amd64/cip-core-image-cip-core-sid-qemu-amd64.zck` to the server directory. For more information on the integration of zchunk handler in swupdate, refer the [documentation](https://sbabic.github.io/swupdate/delta-update.html#integration-in-swupdate-the-delta-handler)
>  
>  ## Delta Software Update Verification
>  

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Linux Expert Center



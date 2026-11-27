Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.19])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16970.1795790557846746899
 for <cip-dev@lists.cip-project.org>;
 Fri, 27 Nov 2026 06:42:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=YxMn47+D;
 spf=pass (domain: siemens.com, ip: 52.101.72.19, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Raxa99TWH9ciEdFfvwV9K+0S4zoJblfq/8PRa4M6hiEqcw+vuXIbsxHpnCXtyn7/+9ln6t1VH8JBgWPF8XFEEldTOPTh71zwiE9wm+ANlMAWKvcGLMw70Yh39+oDeZBWJ/BhilxChc2v4jReuZp5Lctfd6oXsQcSUYedcO4spNRdDAOUonESQ/jqUiUH+BLoQ64vfPkVpjl+IsBGPhJjg69K0BBS1TYK46Eg/htlGZG57kNn8AZdJxpyFk9mHqRim2NyKiiKiG3UimUh0v2AumokZmbaAe3XKqhaNbADoh433J7m+V87NTfVpGtXQtwDWf7lyRQbWt9gh7GP9T6ayw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/4+d3bSGHPRnoUUJvh3KbkWSKA6h/qViDnApHLkXXGM=;
 b=cNqqL7Q5wPh6fXbLrysQa77xo3GQ3qPgK36nZOyqA69pZ0XOi56eHBdePIqaYDsrrDM86E/xIfAjG4vZwBesYSF2WhBRDkEoJqNgswNY00tL4bvfMAFf4N2L0WMo9zY27uPepTDI7UhkNVEwpqUwqU/enz/Iz5ykWUw9UoMF/FDkZuoyaFrkAbRskytqR+E8y/14q/9jUcDRDWJByyS6/s9PspUaPfxdKl9BFVRwKAO/3jcPnktWX8VIWJ9tbSVgxQ+2iy2h7X1KPPglmq349mW8n8ZojQaeBcemS6sP5S7Ztsi+5xYRezyuQuxZlG/TBcXxtf2ZTWrWlW+90lG93g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/4+d3bSGHPRnoUUJvh3KbkWSKA6h/qViDnApHLkXXGM=;
 b=YxMn47+D75bkdZLwnhZLD37LDra7OTs3oc/Zc078AON5iyF5GeX/qoC9XRSW4/iLrDptbNzpjG+DxlkXHeu+JwCXj390hiac/x70zbAoSrFGx56p1IWQJk0x8wSx7VrI45wcCGTXYPDer/dK8Zf8MNky83HjNBgeZHaFxrTQIajJmXvV/iTxFMCUraNBb47N8nOFajH9Nrgl/3es8p/ns0qXJjv5WJDv1KnalF7cHzx1qboWYXwcFedln30gO99tiIiOYNdfO51gAPguKiTBQRJ4oE4qapJ/6cAe4MbWFQnyzvNRLfUIwTo9JAbfdwLQPjk7Jb5oqxwHTimfCiIRNg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by AS8PR10MB6553.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:568::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Fri, 27 Nov
 2026 14:42:34 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0662.001; Fri, 27 Nov 2026
 14:42:33 +0000
Message-ID: <77e39003-07dd-4d28-b0f3-a8961f45d149@siemens.com>
Date: Fri, 27 Nov 2026 15:42:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] factory-reset: Fix unconditional
 stop_watchdog() invocation
To: shivanand.kunijadar.v45@mail.toshiba, cip-dev@lists.cip-project.org
Cc: kumar.dinesh.h95@mail.toshiba, kazuhiro.hayashi.f74@mail.toshiba
References: <20261127133941.368623-1-shivanand.kunijadar.v45@mail.toshiba>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20261127133941.368623-1-shivanand.kunijadar.v45@mail.toshiba>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0343.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::12) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
Return-Path: jan.kiszka@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|AS8PR10MB6553:EE_
X-MS-Office365-Filtering-Correlation-Id: b64aa349-1d61-4adb-d64c-08df4c94ac35
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|261102123227099003|11063799006|56012099006|5023799004|261022105027099003|261026140227099003|261028144727099003|10067099003|261021123027099003|261021121427099003|261026121527099003|261009223027099003|55112099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: AXaDjbvHSGS8oyoBh3cidY8nbotvRSrSnlB39wQIWGQq+XmccPvgF5s/tiS7lxIvF1+l+s/De2Z6j58xz77+ku7TJcZMjll1AYUycn4XnhvoPXBWIJmCHthr/XQIaGn0BxF0EjW7kmNaYQAu+fp27pP3nn5ycTJaKYJLEQMoxEGqzOkpebXlrQouzQBTRSaL+dHhwnjMO0HULwoEwh10yjnTdXTgfQ1qkOPcu7+oIXwpBV2JjxOxXU76KZrEwstNMAG1z2nyBO5gj38mjkZyOUmRcU8LpYoLuRHbTyLDFM1chDEVZNLUAfOgW/HDNVlvgenebo2AnGahr5mYrebx4K4IuyWOjxaDJmyOZHrtAPeKGKlPqjerczhKe+pC7nQGFNEOpKO/DAYVDM4AXlEvizJms426rWoLSRqXRWcsCBMql8rC0Vo5zNJxMRq5h/oeawDrk1gcYTCb8smB0Uw9oXFuZ1wiVUGez/+yjvB1vbFidSE30El9VZg8MKpDB3mB0FGcFtOlS+wsQ3lUz27uYM5hAMTTp6hZTh37gAKnK8wn/Xp7ekoJbrPIJlt7DSdD3GrJ0s4hsWsG2NU4zCrhzAYSwUK15i6Qs4GbW1g4GrLvpeFn3jaVR+Y5E5VwjtPsgF/SIONdEAura2Wgh+dmAu3dt5Ny04I+X5DdyJbVL7o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(261102123227099003)(11063799006)(56012099006)(5023799004)(261022105027099003)(261026140227099003)(261028144727099003)(10067099003)(261021123027099003)(261021121427099003)(261026121527099003)(261009223027099003)(55112099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajQ0TkNyeGNsWEMvWGwvRXc1VGpRQU9CNkxBbnVOK3hJcFpWZTVrLzNuQmFH?=
 =?utf-8?B?UlZwOTdhVlhTQ2psY0x2ZmhPVGFUVnUvK3R3N1ZKTE14MFYycmt0bUFrbmYy?=
 =?utf-8?B?TUhwL1Y3V0hQbHZNR05KUnNpdVpMMVp5c2d1YWpNV0RhVXBxc1NKRkl5YjlY?=
 =?utf-8?B?cUNtMTZMSGJpRkdXY1ZDVmRuNzlBVHlZZnlVVGZCOGpld2k2eDJzakNZWXhR?=
 =?utf-8?B?SGw0T0tvU1Fka1dFcTRyZFZySDNNR3loT1pDRGZNMUtsUGpFSDZhWkw5blU5?=
 =?utf-8?B?dnh1SG52M3k0Y01QMWpnbFBDZkhORWxKOG44MHFxa0VsaEM3ajNWdVkyVjJD?=
 =?utf-8?B?ekl6RkN2M0NRMmRJSHpTN29FRE04MWtvQjI5MnFYRlRHREc5QW12NlNxR3dN?=
 =?utf-8?B?VDN1QmJPWW1zMmRqSVBwbjN3SXBBaDJQczNxQk9HNXZ2Q1RKSWxGNVE0RHJx?=
 =?utf-8?B?Z1lzQlh3dEE3WlJxT0FQUG9QK3FUNzJoOXE0dUVqMEFFdXdmU0p5amM1N3ZY?=
 =?utf-8?B?d0V0bGUwd3pDNzR2eXUzdndYRW1TcHFyQjE2ajUwUlJlZEZmck5kanA5Ukk2?=
 =?utf-8?B?ZUdXdmJ0VnZIUUlCbXVFZ0NvdzFqYVc1ZkNULzlwOEFNQmNvbWhWZ1kySmpY?=
 =?utf-8?B?Yk1Pb29QRzlyY3N0THpiVnhnRUtmK1VuVTBZYmJRUHVSdU1yU0RiM29lSTdL?=
 =?utf-8?B?L0xrb3FJakhmZThNOEFOV0w2NHVacU9QSUFXN2ZDTnhZV1NLTzhBL0ltclZG?=
 =?utf-8?B?clhYY010TjkzTjlKbU9hSThwS0pFbk5hREJHVGJIVVQwT2UrcHVxV01US2kx?=
 =?utf-8?B?SmdSWVI0NGhVNmRYcDVTbHlrMy9YZStTVENDbjJEOEdSR3EvaXdrbndKa0R3?=
 =?utf-8?B?S3VaUzdpekJlQVJ4SXZQNldKMFFNclJrQkp5Rll6aFIvU2M1bTgxREJXM0xH?=
 =?utf-8?B?Y1FqcU1RSEhvcFFKYmRIV09OMHBQNGhSNUlZVU51alVvWnhBRFdDVVZGTFJJ?=
 =?utf-8?B?YWtyaU1qQ2VVZ2t2aCt1ZCtqek8rOFlob05sdWFvOFhSb2FuOHBqSytNNVh0?=
 =?utf-8?B?aVdrWWFEY1cvOCtGYkRhclpjTFZXWGNnZUVJcExaUXZUeXNWN1ptdnpueUdS?=
 =?utf-8?B?YS9DOVdybjliaEwyNDBTU00rUnJHODRVdmRjZVZHMU9iblpDTXJzUXNNMnNE?=
 =?utf-8?B?djRCdDRHaU56QVIrL3U5cVRCUjhnSUg5SVROZ29lUnlobzV1N05sUkUvT2tz?=
 =?utf-8?B?Ui91RDBiL2VFWVJqbkl4bUNnT3B5UVphMm5ubFBJYTVmSzFPZXdvcDN0bm9i?=
 =?utf-8?B?NWZVZ1k5V0h4SzVDYkxETmNGR0cvSmdNR21JSVNtRGtzM2NJazFmaWo2eTBW?=
 =?utf-8?B?Qjg0b2hZZGlIelpTaldQR1h6L2ZNUlNCc2M1djRiODRrZHVsRkFkZlhiVXhE?=
 =?utf-8?B?bzRrcWRpZVhsVkpNYzlIU1FhKzQyRVVUdC8rM0dsUEI0eDg1TThCcG9TS0dR?=
 =?utf-8?B?dGhFbGR2RTI2T2NBWTNyU0J2MHZERWI4REdjdzFxOHVGalY0dHRmMm1RNTRv?=
 =?utf-8?B?SWVxUUU2MFdYWWJSVUYySEpWSmtHbm43MGhWQko5M3Qwd0ZjYjQ1MURvb01Y?=
 =?utf-8?B?U2tPNzJuTVZWalR5N0hMb01oZmZHUG1lVkVlVTcwWWs3YmZGelJsRUtCemp0?=
 =?utf-8?B?cEg0UGpjcy9FaTJDNkpTQ3pacUwyMHJYT2hENE1CdkRlUldtSlRwT0pJeXhV?=
 =?utf-8?B?eWc5WlV1NGh3N25LKzExSEtIdVl4MEVSemYzVVRaUDhDRzJxZkJYMlNocGJz?=
 =?utf-8?B?TTRSSytxM1ZvQTUwelluUWc4QTUvYTRVRE5qNzJ1RERHM0RwWlhPWWVjNFlM?=
 =?utf-8?B?cVZZQlZZei9yZUdJZkVNNTBoTzF2YWlDc1pRWlVSUkZORTNGcHJxRWxMdHNS?=
 =?utf-8?B?ZWNTcmNvNFF5Y25pUmNtYzdWNVZUNURscWNpd0VtcDdNMzJYYkc3cHc5WXl1?=
 =?utf-8?B?Q29PUUFsMFFSaXM5c0x5SWJMQTFIa1Y3UmMrVUdxbzJrWXNLM1k1c3RTZGN0?=
 =?utf-8?B?RnorSEd5M0wrWk8rRVFHdkQvR24vMDkwNDlNL09odjBZVytHWlFCelhrNXFt?=
 =?utf-8?B?cGpLV1VKM3h0MzR5OWE4UmNMc1lFWEVUK1pvTldHZGNSTU5HMksyOWNKNW9j?=
 =?utf-8?B?Zjc0S0czcmpXVENZSmMrbk1QenBlWXdwSW9EZWo3ejFWOHVBYk5Xd2VqOERu?=
 =?utf-8?B?WmRFY1pDMVIvb3g5ODRZaFlPMlc1U1ZQR0ZUOHorWGl0MFZUK1liNTBCSlZq?=
 =?utf-8?B?L2lBUXZ5VXN1VjFJOVRkV0VSR0tod3p0dnNFVm9kWTZsUTEwbUVndz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b64aa349-1d61-4adb-d64c-08df4c94ac35
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 14:42:33.8743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +y5qQaTVYWeErZzgb0DmA41ZvQxl+RkHGp4drfcppzwynIbm01nTH2hib0F+8A3AfunZyNQQyr8WsHpmtkc3tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6553
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Fri, 27 Nov 2026 14:42:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25230

On 27.11.26 14:39, shivanand.kunijadar.v45@mail.toshiba wrote:
> From: Shivanand Kunijadar <shivanand.kunijadar.v45@mail.toshiba>
> 
> Invoke stop_watchdog() only when start_watchdog() has been called previously.
> Prevent unnecessary stop_watchdog() execution when the watchdog is inactive or
> when a factory reset has not been triggered.
> 

Valid point, but then I would not call this a "fix". It's an
optimization, no? stop_watchdog is a nop in case start_watchdog was not
invoked before.

How about "Avoid unconditional stop_watchdog invocation"?

Jan

> Signed-off-by: Shivanand Kunijadar <shivanand.kunijadar.v45@mail.toshiba>
> ---
>  .../files/factory-reset-script.tmpl                             | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/recipes-initramfs/initramfs-factory-reset-hook/files/factory-reset-script.tmpl b/recipes-initramfs/initramfs-factory-reset-hook/files/factory-reset-script.tmpl
> index 3216dc9..e9c76d9 100644
> --- a/recipes-initramfs/initramfs-factory-reset-hook/files/factory-reset-script.tmpl
> +++ b/recipes-initramfs/initramfs-factory-reset-hook/files/factory-reset-script.tmpl
> @@ -93,6 +93,6 @@ if /usr/sbin/get-factory-reset.sh --delete | grep -q "factory-reset"; then
>          esac
>          log_end_msg "Reset device: $target_device"
>      done
> +    stop_watchdog
>      log_end_msg "Factory Reset"
>  fi
> -stop_watchdog


-- 
Siemens AG, Foundational Technologies
Linux Expert Center

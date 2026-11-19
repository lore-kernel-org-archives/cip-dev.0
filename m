Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.24])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11210.1795080888951140111
 for <cip-dev@lists.cip-project.org>;
 Thu, 19 Nov 2026 01:34:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=BmwcO2Zr;
 spf=pass (domain: siemens.com, ip: 52.101.70.24, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F7s9BMF9VEW7B7ZPdZkpTgYitHpTOberHK8shGAhdnCMQOybdye5n6z8htE5jb4A1UUKCXzI+5x5UtiTQsZ204mtlPY+sINjXfLl3rwO2DgzpCr83KhS77swfYUnVrm/ZHdJjMaMW7Rco7pzLKFiZNC2YRn54UluKD1KonGppvuNTr2EPX/NeVxKTDQdOmzT81b6Hc2cWYJ8a8mpM22yc2PVG8ePc44IT6CTUJ2hZiJ6wOr0btuh+MH6KLW/0CBERySd0vn/IzXVQ9uEyCCQPtEukk012k+/SyYI6uv2leFvNOmGT0aj1KnGbz1XE6/xg7xa9u3bFNdF/pqEL/vGqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eTHSo0hZ1kJAu/vJ6yOxvUVd7qRSO6SDrdhBscceuPo=;
 b=gxQRBggjFWZPceT4nTXK5gTsDkgJf4gqsvtLLY5hSBNLOHcuU5vpujcXcLZDIeVfutb1noyRNEM0dvOrPE69q7UJaqfcSGb/f6KmQS3+kCwLMjnUiTvtv/YVIL04OZ20fIrsK9snedjp0kz7xbuifXK1mJS0HVWGOTDwnFYFLi0lQ5twjkPOV/lFeyHbKlAkMgj5Xe4+6L0JRmrzYisK2oYWhAhgVaA7FJq2b1Ylv9lEPWmWGpzxc8Ry+7Jio+ObXXZf5STJrm+u8qh0jC0AGfkgauzCzrryrsYoum4cUyE1NLcjcGg8QDpNtJEou+2otLV3/V9EM4a8zgADeuqp9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eTHSo0hZ1kJAu/vJ6yOxvUVd7qRSO6SDrdhBscceuPo=;
 b=BmwcO2ZrYMKk5BFGOsoqtnxxC3aRHsMWyDrPUH9doCTRi3kg3gBt6MT+3ZqZs2oSzMq7O2ZFGfvLGtIlFRkkneNmnU7aOjg7wM0B4Tn0V6pmIJPbfe79I3+vUHYN4S0wi0n980uE5F0fkinmG0mIGmWP8Od7GpK2UwxDBJe6kw5aOaslF2Ry/BarkW+TyJuHewDCdpaD73tSpvKr6aS3EVM4Vd0h1WjzBA14sbzAbJa8ArQQXVj3cADVgSAOrDJbxw+bX3uMA3XnecMa5LzwMQnRc9Z1mAKbSXIJITeX/8Wvz7PuZi8KgAM34Ek7NvQRK882XJPB/NUi1AEG/10UNg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by ZR6PR10MB992207.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:910:d1::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.1; Thu, 19 Nov
 2026 09:34:42 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0639.006; Thu, 19 Nov 2026
 09:34:42 +0000
Message-ID: <9a83ac4c-bcc0-4111-b71f-cefdee886728@siemens.com>
Date: Thu, 19 Nov 2026 10:34:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v3 02/19] Fix expand-on-first-boot with
 separate home
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
Cc: felix.moessbauer@siemens.com
References: <20261117112833.316234-1-quirin.gylstorff@siemens.com>
 <20261117112833.316234-3-quirin.gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20261117112833.316234-3-quirin.gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0168.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::20) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
Return-Path: jan.kiszka@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|ZR6PR10MB992207:EE_
X-MS-Office365-Filtering-Correlation-Id: ac94dc46-07c8-4696-ce06-08df462056f8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|10067099003|11063799006|4143699003|56012099006|261021123027099003|261021121427099003|261009223027099003|261102123227099003|55112099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: FwZZIs+2fPa2sl5ZU0UN75kHEcKXeyY4o1+zA+4LMvLW7b5Ub7KRKC691n12cpdlpaDgTHG45PHGdbR6FFhpMJ6JQoDLPTEqqYliFH1YAhf58yGaStec3rzqPd8cmuQfoCtJz1O1SJC/jsLSUjwcruGQicqY4Xdo4V6PSHIQTB4Rha8QCVpi+c83TcWNxPVbYQ0mEoeyq6xGofXz4u2nCbEq4acCy8JwyZnDPcatUZPiZC+DoxEMx17wd3HuOfMwHhgYkErIOwvLXnSCDz0YVKy5wH4vjDUfPokKKfD69H6wPufAAAsxgwYyfG39bZW9dSLYfb1xAI6edh/Lj5zuJJmPIBTj8mvAEunBKTq3+fxuGMBujlh/EIR0uKUQ2Xnn3nTLSUqKzM10Sl7Dt7Y+oQD8Whjx9SzAAvAS7QMrupJ38t0oEMKsAk/T+GnjmWs72qEEj2qQn+GDotztqwtRv6C0MQmcTDeEXVnp2BtB+k5XO2SQ11oOprK8JmNKJ4/HfiRZSY9FcjIR7Bw8Bpi1BfZA1U1lsNrtwVn5toAzGYPmPGnfACvzLcyURIP6FA2iuPWshOTBn18I3AT6r7Rxn9+XxiGNoU0v19de92hGKFpEAf4EY6cxoOQynL1Q7YU20DDneLtX04Ou8sZWpDd1dp9BUIWNLY2hwy/im7QGkwY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(10067099003)(11063799006)(4143699003)(56012099006)(261021123027099003)(261021121427099003)(261009223027099003)(261102123227099003)(55112099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cEpxNEV2Qllna0cvZllpNThsVWtJQ0pzZU5KNTV6U1kzbVBSbktBWEd0Qmhw?=
 =?utf-8?B?Y09weG16T2dzWU96RjdGK2I0UUJpbG9kdFlYUjEzRWRwamlJdmovNk1UOWtR?=
 =?utf-8?B?WUZGWUZ3U1YvZ2g1eFlUL0lqaDlPU3JHWGhzdk1CSzBycGRzSU12Q0RObVBT?=
 =?utf-8?B?bzg5bjQzTGpUOHRiSzgvVnFzUEdoaHVOZ0RCS1VTNjFuSVhuM0hpbHJadHht?=
 =?utf-8?B?cUNzVlJ1bU9ManB4L050YjFMbG5HWU8rMngxb2ZrVCtpckhyQ2JFQ1hjbnNr?=
 =?utf-8?B?L1dMSytjK3hSV0VIdXAxWVk3d25jZTl4dDRBSGpqZ3grRlE5VjN3dmZIZGc4?=
 =?utf-8?B?L1M4djRaMFlOMDd3d0d0dWNuNkEyUnYvazJ3NzMvdnVEWW1Fa3FTUFRwMW9W?=
 =?utf-8?B?TnE1Y2NiNkNEZm1XMldIMU1ZaU9IaWx3S0dxdENJS3A3Ti92TEZZQ2FoRzRo?=
 =?utf-8?B?RU9uUVNXVVRTL3RQWWxjTC9IWTRXMHZwTjhkMERaYmNKVVMzeVlUczRENXNr?=
 =?utf-8?B?YWkrUlZGY0VldERsSkcwZFovWEMxdng1b2VKaXRPVFNldGZYOGk3eHlHUnNG?=
 =?utf-8?B?K01VQ1l6N2Y1cXFRSnNJRXgvYkxrMVZhQnZjcmNtMzg0V2NuUXJrQUpXSTRR?=
 =?utf-8?B?OFpkS0lkOWlCZFptYklCajRlZDJ6TnV6bU1hWU9jeFdDWHhtaXJIeG84SCs2?=
 =?utf-8?B?bHBQNmc0WmtxYnpXSGNyV1RIVitHNXpnelY5ZWhhRVE3YTFpTGhtUHdoTzVq?=
 =?utf-8?B?N2EvN2Z4NHhtaVB2cmRzb0tQWnRiTGdwRDY2ZkNJWGszamZITlhXNmU1MzVt?=
 =?utf-8?B?Y2xOdzRSd2JLVjY0MnVVaWZ4Q0o4bnlLRE4xT2I2RU8vQ3h0dzJkei82V1NJ?=
 =?utf-8?B?YXZHUGpoSVVjZVRwWXAwWDhrL0JLL2J4SzJ2aTlDek80SE5WR0RlSkdrajY5?=
 =?utf-8?B?WDdXU1d6eVVRYjUxemJKRzFQV1RMQkpIMFYzaHFDV2J4WlNoNi8vMWtNRUZj?=
 =?utf-8?B?ZEJEbzVwRld1Rjd0d05HUmRaWjZ6QkFSdXNoZ0pmeTFBQzc4WHBkQTRIazJW?=
 =?utf-8?B?T2pNU1lMclZwY3RKSUNyc3J1TCtvY2R5STNlSFhNb2F0STRkZXo0bzFLelhD?=
 =?utf-8?B?WnpkZThPQ3c5MGZ2S0ZRUll4N24wTnNQaFVXaHhPdGx1eEI4cEdTZXFabFdl?=
 =?utf-8?B?U0l0c1E0aFJaZE43T2Nzc0RWUlhMMlhMZjkwQUlsOFd2RzZ3OThPS1k4cmJQ?=
 =?utf-8?B?UlJTWUYrU3VOVitFSkU1M25jUmEvMnRvd1hPaGtaZE9rZ0tVYks2NCtNZGhE?=
 =?utf-8?B?ZTdPdlNGSUhXY1Jxek56S05NNE9uUi9iTCtYUmxnUlRQaVlJQk40U2Jwa1dp?=
 =?utf-8?B?UEk4eDFIZS9xK280N1NIQXFsVERPUFN0ak1QcFJpci9IdW53SVR0UDh2ME9q?=
 =?utf-8?B?dHNHMzRwc0dSTTV5YnZpUThhQ2kwQ0tmcmx3Q3pLNzhqQ1pjUk1GeG5KaUZR?=
 =?utf-8?B?UXU2VnV3b3h3WW53bTVOV3NyVTF6M1pLclZKNlBaeXQwU08ycVFjRS9abDQ2?=
 =?utf-8?B?bndYU092dG1DTExWQjQ5Uit0TytVR2FiR3Y1SHZmbzlaRFR3Mm1TU1RVN0ZV?=
 =?utf-8?B?U2g1SFRYMFZqRUk3WFNYTXpaNkdiNDhVU1FQckVHNS8xdTdCbCt0Q01QRHBE?=
 =?utf-8?B?WVdTcTVydnJ2TWVCKzZPSkRDeFhxUU1yTDNwKy8wK1dmUUhNUXNGYTg1SUNs?=
 =?utf-8?B?OHBkdm5lelY1dFlYKzNsUWd2cnAvMFVMK2I3VDdsUllTSVB5SjRxbzVseDJ1?=
 =?utf-8?B?Qk5IeFN3amM2c1BOVWgxUXFwWUFYRisrU3daWjA3bFkzbzQ5QlI1dEk2SlF5?=
 =?utf-8?B?MTlhd0liQWhiOWN0MmZsdThTWk1FSGxFYkRtWTk2NjYxVDZLS0FlekZCZXVV?=
 =?utf-8?B?RE9vQjBKZi9tb3AwRkNuV1pDeTVDVjJKYzAxZmpQWnFlVTNyWjQyQ1FhelB5?=
 =?utf-8?B?YzlxMnNYa25WWXhpWVNlelhXcmZOSDBIMUhBL1hhb3paSmp6NG91UktqZDQ0?=
 =?utf-8?B?ZDVIWVg1enB3Uy9OKzM1SzFDaUM1ZHhXbGpPalZ2UTFNc0o0dDRnbEdWZkJE?=
 =?utf-8?B?aGplK0IxZm9YaGN3SnRia1ZiaGpnWTlNZXVRRTBRVGM1Tzd0M01PbXVnMXh4?=
 =?utf-8?B?QkxrdWFMeHVoNEVkU2o1bnM0TThsczdjZlZsTmpEdzRSSVUrZ2EyL1FWWUEv?=
 =?utf-8?B?cThVUTRuYUtCVER0K0ZSVzIzVzQyd0FSTHUzQ045NGNvbG84ZXJRZnZRS09k?=
 =?utf-8?B?ZXJpWHJibk95dHUrZlRwNFZ5RFJTdy9QZ0ZkWnU4SGYyZFVjaUNsZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac94dc46-07c8-4696-ce06-08df462056f8
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 09:34:42.3247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v0Ydxuk51zgW3Jppybo86e6bI9lkvfRDxvI8stC6nfxqI/TuAL3vUemvTkLo1TFhn/OdyxLbzkqNSz0GLvY2uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR6PR10MB992207
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 19 Nov 2026 09:34:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25010

On 17.11.26 12:28, Quirin Gylstorff wrote:
> With separate home enabled, the home partition is appended to
> CRYPT_PARTITIONS, so the ":expand" option is added to home. home is
> not the last partition in the wic layout, so it cannot be expanded.
> 
> Prepend the home partition instead, so var stays last and receives
> ":expand".
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  kas/opt/separate-home-partition.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kas/opt/separate-home-partition.yml b/kas/opt/separate-home-partition.yml
> index 16fe2cb7..ed415c4d 100644
> --- a/kas/opt/separate-home-partition.yml
> +++ b/kas/opt/separate-home-partition.yml
> @@ -18,6 +18,6 @@ local_conf_header:
>    separate-home-partition: |
>      OVERRIDES .= ":separate-home-part"
>    add-home-partition-to-crypt: |
> -    CRYPT_PARTITIONS:append:separate-home-part = " home:/home:reencrypt"
> +    CRYPT_PARTITIONS:prepend:separate-home-part = " home:/home:reencrypt "
>    add-home-partition-to-factory-reset: |
>      INITRAMFS_FACTORY_RESET_DEVICES:append:separate-home-part = " /dev/disk/by-partlabel/home"

This fix can go in already, though.

Thanks, merged.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

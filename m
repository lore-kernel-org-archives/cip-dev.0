Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E75C9830B
	for <webhook@archiver.kernel.org>; Wed, 23 Sep 2026 17:08:06 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.14])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.479.1790183277599582410
 for <cip-dev@lists.cip-project.org>;
 Wed, 23 Sep 2026 10:07:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=h+8sNzCi;
 spf=pass (domain: siemens.com, ip: 52.101.84.14, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZyiVmAwsYSXXrMGbhR37ukr/5kuxyBtogbm95l2FvCPeplv+ehXGRSmZFluhS0C0I2tJpExbNMY6NUNm1IS/7Fhe/pYehNx1jSFEqXTKqC+uFS1iALq+rf9WLcP5i4iv5inSLKgBb2RQtAtoK388o6fPXVqd1OZXjpBDP3YstN2I0ai4oETwatGM/QRNpV0Sp3E0ba852S54z0ZDkt9kOppX1SI9lDPo7sz2z+G4YyCEkON+M12lwD3I3LrdOpe4LnhcT8TxeXOe34Pq8qOmciwfPbOvL7lT1gs7k7Exo/FDKcHOpnIHgr0cHf0V6Briirh2JkHIPfl2jdYIWYUMGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UQGEI+qXKcqEYqAN1VeUu8Ew2Vry5H8MNy+eiiEOoNo=;
 b=n98M60A76wIRI7NVaGksojIdUH6kVoRw/o4kTcIHFGNmK3gPDjgGWWRQc4rTB5Iqbp/iAtAS07AXy3zG4LmN4apr9KEFYCX7xm69of18yvJ/iGaavG9DXHRLiPGRZYm+Ug3xV99Vf6wgHnfWUzYt8ToZa0aFOTB9lDH1+hzL+hCe+3yam//HuQU1F11BtsKVhhKyJRSlZX9cCHooJWJaC6yQZKTmu37aHapq1PpVbunlBsDdRhF/c7NYhnvSfVrDh6/Czcmcku9mV7sKk2f6+MpD7SnRDUw7aRtNYP6m6k+ySi9ckfDaMDLW4Z77YCmvSgeSsYCmk2KIczUOX79zYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UQGEI+qXKcqEYqAN1VeUu8Ew2Vry5H8MNy+eiiEOoNo=;
 b=h+8sNzCiLvBEc+JxpxNfwTXLva3CazbYJke2E73m+JBw2DJWzQIKi13zat/AoSx1e9O1XsRI9LvyiAN00W6E1uatrH/hrJB58BcV4rcG7VQdYwEINnTfbuLFdAOuwSzBAkXrEAm+2h5UjPI/6PNDFheK4smFH9kNCDAf/i/+14ISRePfp2+dfmDyJAcQqJcQErB+DZXZ+PakY2j7bQqaDwRCQwCkmSzCCLu3wqpNtBnT3/RS62RLY2o1iFOkingcC7yuYWZuKurrEV/I2eg8u1rKn/vi3fq0TO87fzRrFmCcta8QwEP9v2JuQq2u6s7tw21+DRbD6CKowAvSLAzu0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by FRWPR10MB9508.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:d10:1af::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Wed, 23 Sep
 2026 17:07:53 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9%6]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 17:07:53 +0000
Message-ID: <d0866737-79c1-4c09-9659-d65c2193f123@siemens.com>
Date: Wed, 23 Sep 2026 19:07:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v3 2/2] Fix file timestamps are not
 reproducible for EFI certificates
To: Felix Moessbauer <felix.moessbauer@siemens.com>,
 cip-dev@lists.cip-project.org
Cc: Shivanand.Kunijadar@toshiba-tsip.com, kazuhiro.hayashi.f74@mail.toshiba,
 kumar.dinesh.h95@mail.toshiba
References: <20260923113003.259191-1-felix.moessbauer@siemens.com>
 <20260923113003.259191-2-felix.moessbauer@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260923113003.259191-2-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0048.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::16) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|FRWPR10MB9508:EE_
X-MS-Office365-Filtering-Correlation-Id: 457b5d6f-408a-440c-bdf8-08df19953440
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|10067099003|4143699003|56012099006|11063799006|18002099003|22082099003|55112099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: 
	Tmq298wTehWxEOE8g4w9C5+dFqpK68LL4tKBdmBXmMrPlgCqbLkxs2Hz9mOKZxxPqTkBEmN9cIa3EYtyGf12pQKbk9iCChkhy0r3lQz/leAgvdyaz0JBwDNXqWr2uBsQSa+WbWwl1Ri0clxFRosIoKvA68anq3z5TKmWOCLoca8cIoH7Jhs00v9gkexDvG0j7CcF1+UTUoNKsaB9rAgQcmr5BhgiTELjmia8g6tBl4aDDL9d/KoxIzZ1N2zGUiZfAGATrDmmD6uPH4Cbf7xbvIZ8vk3z+IMtZCQU9JqDUzsVnv9kAK5jQRjJYAMtU6MDDkri3erjsd013sP50jGerFyIdLtQ/+jCXbDf+rRg5n9LKRal3NYK+yUGrsJ67mDqWkjDY9UCfNu0IPXw5e7Y2Rcvrzt5rieHOXZ4Zg2Mik0Id8XxdbFMlfRDgxaBMz1vHcqRolo9PdnDNXHYfHi+WsVN3uLGVwZA6RyLCOVw+nT2Qy0XxcIpivQXwb9707VVoBqz1vNt7rmoadAQAt2+xSLiAJRy8Tm4WxFOYVsRecn8Xrai3v3UR+yBs7UUuCDUETkF42FonlzTphTHIEdQodkKxp1X4hwYuqXN3v3KGkou89hN57lP0bj5srPblt6l
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003)(55112099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eXcyUE42NjhVc0VZdmlNMTVNOWlkcm8yZzRKUUZLZXk5bUU3SXhQckZBRldw?=
 =?utf-8?B?VGE2WEgrSFhSVUJmTVpBOUFreWdqUklZK2VLcElCRmdsWFFtQjNleE9tUG1V?=
 =?utf-8?B?Zk1LZEdKZGRFRmNOTS9lWmV0dXpHb2ZrdXdJek9wQzd3S0l2ZnczT1IyeWFH?=
 =?utf-8?B?NnY1TFFhTXZuajRrREk1YldZanh4RTB1ZWpQUzVyOEI2eG4rL3hzUXJHaXJ5?=
 =?utf-8?B?THhVTkFrWGhLVlFFcTJLcG0wQVFWSGZaYTgrWjVYNGFHY3I2SGc5eWlTUWJa?=
 =?utf-8?B?UU5rcFp4N24zQklSZ1ZsVmpuNmFNeW9BQnltZUkyRVBsZ3dVZGhaVG40U3FF?=
 =?utf-8?B?TElVUU1Qak9CdmlEVDJhd0xJeld6Sk56dk9RYVBmZGFmWUMzSXVUamxKaHph?=
 =?utf-8?B?NWg2cVhqa3lYaUp0ckV1c0M2SGZEYXMvTFJIR2FScU1Pc1hCcVpUTWNYSDV1?=
 =?utf-8?B?bzk2NDA1OEhycGF0NDFRY3Vpa3Vjamg4NFNvcWp0RHc2VUNMeWV4eGt4NjVv?=
 =?utf-8?B?NzNNQVl1MGw3ejJQRDZBQXNkRFZxbVhCTm1WUDk4VUV0WFptTks1TFVlWUZk?=
 =?utf-8?B?RmJSZTVLdjdzZEF6dXRtUEwxOWNVc0RTZTgwS0V0aFREZmNXTU9lWGYxOEQ3?=
 =?utf-8?B?dXl3SXhxQ1ArWXdXc3h0ZVlvQ0ZCNm5NKy9iRVNJOG85emtmS0MzVjZDQ2FL?=
 =?utf-8?B?WDB3dmRYWFQwY0picFQyM2Y3Tk1WbnBTeVg3cDFBc1FzVzd2R0ZpNUpJT25P?=
 =?utf-8?B?UDdUZExhS2YzcVo2MFowTHBLS3dnZlBzMit3cVlrWVl3WEFtYWhyWTZ4UVRh?=
 =?utf-8?B?Z1VReU82eWhnaCtnWmJsanNlcHBFOHJJdVdOa0VGcXo1NHB0ZFpsN0FocTBQ?=
 =?utf-8?B?LytPdUp5eWxUYkZkbUhsTW5SVVc5T1RVRUIzUHV2Nmt3ZGJYWlplM1hGT1px?=
 =?utf-8?B?c1duUjYyUlY3Rm42bWk3MHpYc28raHB3M1RXZm9ZaWdiRjlRSVVsbkFaWjhM?=
 =?utf-8?B?ZWhESUVZTVdaT3pIUjFXVGs0ZFpaaW5USjE2R2Q0d0xkQm1qYUIxMTI2U2lZ?=
 =?utf-8?B?U1FkSGNyNTlaTTNvb1ZPQ1dsVWJXL3hEc2V5dmFuRFpwMDI0TTdWQ215eTU5?=
 =?utf-8?B?anpVMWdoOEk3R3Y2alZ5ZUhzTy9sM3U1RWU4b1Z1cUdmWktnWFBkU3VLdGZm?=
 =?utf-8?B?cHBBRXZEZXY0UUVxc0JOUWxLY2FHUFFWb3lvTUNsSUI0emFjL0ZGdThoYlpO?=
 =?utf-8?B?VFQ4cklXbENDT1NoZlgxRHZUWjVXOEVZNzArNm16VGxXUkZCMnNPUWdFdUhh?=
 =?utf-8?B?ZHhGTlh4V1k3eTI2enBaMUhRSjhUN2U3cHdRWTdNMm4reE9QdUlrVDFjMTBG?=
 =?utf-8?B?Vy9BNXlrMDRuZVZUZU1oNmdqWEJXZ1RsZ1V4bFZqdENDeC9zSkVSd0NaSjJn?=
 =?utf-8?B?ZC81dzJRRWJ3WTNkTVpFUkgzdXl2aFlOZWt1SnBUa2N6M1cvZFp0R0EwcmRG?=
 =?utf-8?B?L29nNmRFeHhLMkJ5ZmtnbXlFaWJNSDMwZy9WcllDUVNjYkhTUm1SU2p5K25P?=
 =?utf-8?B?My9URmlKNmlEUGFickF3QiszT255Nzg3Zis2S1VtcG1oUW1kSmpCQVVrNWtH?=
 =?utf-8?B?L2dXRFBsN0MrdTRUYmRnSW9pcHV4WnVuU2Z2aWh2dnIrUEl2WUhVSzkvVjRX?=
 =?utf-8?B?WXhqZDJVclo2UlZNeGFGblRWOXFQNXZ6Ym53dEMrOFI0ZzlvbkRjdWlwaHcw?=
 =?utf-8?B?UDFxWGRsaDRhOEcxT3p1bGJvbi82cnBvWE01RHZHSzVQbU0vY01WeUtlWXlQ?=
 =?utf-8?B?WXd2bmN6QnAyOVZrSDlwRVlHMGZsR0gra1JjQTRSSnV5S3NyRXJqbTVYcHZW?=
 =?utf-8?B?Zy9KeVF5dDVjLzJpNFB2bUlQMVVaZ2tZMlJuSjkyYW5YYWl0emFwMGpEeDJE?=
 =?utf-8?B?MmY2SVNqTEl6aHphK2UzYjl1UDhMdFkwc01xTG5xNE5saVE2TytOWTV5cGRQ?=
 =?utf-8?B?c1ZLZWRNb2ZRdkU0dllON0hoVGFidnRsTUJqVXhJVTlWNG9BMTJpUStsaTZn?=
 =?utf-8?B?WkthaElyUEJVY3I1Z3JkbmQ4TS9TcTFTZHdEbk04RE90blBoRld1d0cyK2Rk?=
 =?utf-8?B?dkRWY1M1RFBTRC9NaGFUdy9kcU5rMEVRcUZWdVFzWkY0bWtSK1VoSEdoMEtM?=
 =?utf-8?B?UWFRc2tTNENtVDEwcjBicFUvQzNqcjhNUitlNlpHcS9JU2d3L0tCcGEveTVu?=
 =?utf-8?B?L2ZBeWNxdTlnbS9HUGY4M0pGdzZvRklmT3BQZjdYNzJ0aXJmekFDYlBzOExC?=
 =?utf-8?B?VUFNU2lYZWkxNSt2OU9iL2doL0dibG5pQWNNdmNMQlQ0V1NzR2F6QT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 457b5d6f-408a-440c-bdf8-08df19953440
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 17:07:52.9486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RfnpFMIvmsyBwUDENNkWrFl2D4FUu9XoWXtdbp6dT9tmkl27Td3JeiiWdjNOQd4RX1yrm1MOKlUWVxLLTYqs2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR10MB9508
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 23 Sep 2026 17:08:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24280

On 23.09.26 13:30, Felix Moessbauer wrote:
> From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
> 
> Closes https://gitlab.com/cip-project/cip-core/isar-cip-core/-/work_items/162
> 
> [Felix: let dch timestamp depend on SDE, pin timezone to UTC when
> signing, pass timestamp in correct format to sign-efi-sig-list]
> 
> Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> ---
> Changes since v2.2:
> 
> - replace :next commit a7b96bb
> - fix double issue of computation and issuing of note
> 
>  .../secure-boot-efi-certs/single-key-to-efi-certs_0.1.bb      | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/recipes-devtools/secure-boot-efi-certs/single-key-to-efi-certs_0.1.bb b/recipes-devtools/secure-boot-efi-certs/single-key-to-efi-certs_0.1.bb
> index 263f794..75927ec 100644
> --- a/recipes-devtools/secure-boot-efi-certs/single-key-to-efi-certs_0.1.bb
> +++ b/recipes-devtools/secure-boot-efi-certs/single-key-to-efi-certs_0.1.bb
> @@ -22,6 +22,8 @@ DEBIAN_BUILD_DEPENDS .= ", secure-boot-secrets, efitools"
>  
>  DPKG_ARCH = "all"
>  
> +inherit secure-boot-timestamp
> +
>  do_prepare_build() {
>      deb_debianize
>  
> @@ -35,7 +37,7 @@ EOF
>  
>  override_dh_auto_build:
>  	cert-to-efi-sig-list /usr/share/secure-boot-secrets/secure-boot.pem PK.esl
> -	sign-efi-sig-list -k /usr/share/secure-boot-secrets/secure-boot.key \
> +	TZ=UTC sign-efi-sig-list -t '${SECURE_BOOT_TIMESTAMP}' -k /usr/share/secure-boot-secrets/secure-boot.key \
>  	    -c /usr/share/secure-boot-secrets/secure-boot.pem PK PK.esl PK.auth
>  	cp PK.auth KEK.auth
>  	cp PK.auth db.auth

Thanks, both applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center


Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B5061088E6E
	for <webhook@archiver.kernel.org>; Fri, 20 Mar 2026 09:21:27 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.64])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8806.1773998476582347697
 for <cip-dev@lists.cip-project.org>;
 Fri, 20 Mar 2026 02:21:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=xhqIymT0;
 spf=pass (domain: siemens.com, ip: 52.101.70.64, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ulkmoW3qkNU3+gFvMr0fXHJ7qtvqgU8UX519J/IizLniDX2qTmbLUT3Tg7e2bBMZu0LfUJ/BxT5dRpKxsFgbwKBfOj81053ij95RCXhuvk2CgwqFptv9taDsQfpnb4kmy0LiQmU3sZAXx3/l8cN4OeoJVJPL+B/wX8w/S7WCX4BLoRTh7u/XicQA7D3JxmuXhwHKUwAT4HSkWnieTGK0bawWBK2cX9D79ji49JSOO4KALSkaT1pQt8cc+lN6ILBhIUFpH8NLizup7vHqsM7v7bAjPri2aDOM3jd1xvzjquU1ZCUPoE4z58gEJk9H3b9+sNK0qHN/X1tDC+dTb77W1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jQCdoi4Fa3xbaAwcqaJK4PxyRpu8Hv+ppLtnrTGlu6E=;
 b=rlHnNTqPi1RN/3Xa9EhkF1EuQ5BLwD162+KW+SzOjT3f8O1e42Gbs565uxDcZu1A+y2l1A6QTzf3brNHYgbZxylL0Ux/JcC6ag009/9dd2p2ULTb6Pt5INhsr/ujkWFd4k6eUGHiqO082gGks9HnzcRPqo8BVXIG7LrFSBnpiK/X+qBeOSv0MbrCBGUqxGFaqG5P7a9s7sv7KQn/PqIAGRmiCDrQeNvEuZX+2ahYLO0JNjBa2asZuyKypgHbpVGrTkaymNYN0iGtfMRWmH1+EUzrXhzrgnSXlq/onhdY3mFpqMHSaVTQOW+i4dnaYNFipM3uK8L4x7FjRWSZ42X/uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jQCdoi4Fa3xbaAwcqaJK4PxyRpu8Hv+ppLtnrTGlu6E=;
 b=xhqIymT0HA6wU6kmCRTMoAPg3n2/RJfsq2J18BedVZY++Ul21EzGLdy4PHlafXxRGuaZWmBwblMx53g11vDp17wQhIGoY/YAP+PE1WwfQ4WOjHA7Ct5p+t9lWiOYrb+t3LVIlMPQ0RsLzia3SaeO/Hfk7qAzMT4F8Ca75KQ62EB23ci5Un6eqAr1YIL2vTaL39pT/KMvzoyZqyJ9ti7SV/PUdo440mcsAk/e4PUpraA8I63F9D2VN4KzhFtUcL6CRMcWEcYF9W2ysfUpnwvOg1MVNISf1gDJInTtUqgLXSHZBZ0780WHEcAaRP2uUWUMHmza7cE1v7eBqry7yAqEhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7457.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:422::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Fri, 20 Mar
 2026 09:21:12 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9723.019; Fri, 20 Mar 2026
 09:21:11 +0000
Message-ID: <2308ee0b-8bb3-4ad4-bc9d-07cfb04a4751@siemens.com>
Date: Fri, 20 Mar 2026 10:21:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2] swupdate.bbclass: Set owner
 for reproducible swus
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 felix.moessbauer@siemens.com, cip-dev@lists.cip-project.org
References: <20260320075546.2535828-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260320075546.2535828-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0097.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7457:EE_
X-MS-Office365-Filtering-Correlation-Id: df743cd7-27e0-4eaf-e174-08de8662069d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|1800799024|22082099003|56012099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	uPc4ZYqUspO0wLVvbVNUyJMLerPx+ZeSuGqnNvWIdfilhAUDlOo1KVM52Ha1ZtTS4BtAgnVAjtimeO41Do5KW/XvxXWWPcnEaKqDYsny0xhUNuE0n2cxKmkqOSIdQj19HyX50HxBV3nDbd4HLDi3u3KlRd2f9ZqtZgALl8xcyoml7kDJBSACkJt8AzQcjdBQ+Lwb+5NpZIkQa5ODMmRoEj2jUk1uhd72eDW6LlTB3Dui8d7mMeGO13EBsMiB9WUGxTuJclh97foXZitTyqx/TF2yQnHE1tprqJGdlI6+Uqzzh7AdcOQOrEZ0pjpZsZl4gRWDEfzj568+oRdN6s6eX7Lm0XmuYLhAJK+jzLx6nxtN6skJI+MFRsC6MziIM25QPxuAQ/ARHF57R/uo0oLG8khhMneCkHiSZigtx43t2M5UVB9HwmAFcQS+0HUPFw0e/uYpA6W3ajNc2y0RzG+IE6+09C7ENyubtNBNprHU7MoFKQgupwqQ9B1LF8G/XC9rWx9jKhCpLw/bR5RM2Aa3AR8kcRMToG2vzmQ5kuEBWFtNEI8Z5VX39e3xPVgCwpOiPkL9TUnpnPltoShtTu3udXAC9+QkPttRuS4FeWhodbfU0/YRPDwUVpgG24ghJ0t0iSbYQMMpgjhmJueXSF+T4bCR7QoiDskujawAFb64bkRzlsgFWyZawdheu2hqBsyk03AIaEvocri8Nbgbsmgz0G3qQfFU4Y9hMWlWzcoQ9do=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(56012099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bU9TcDFaQjdCN0lNczdObzRiYzVIL1FqeWZyV2ZtUnpFM2poWk91ZWgvZEhD?=
 =?utf-8?B?cWpCd0pWOGowZ3V0UGVjb0VybWNUeFRCMHhyeGlxSmRzTXA5eUx4QnNRZk5D?=
 =?utf-8?B?cDVlR1hETVhBM0U3NEpIQ1hkZVYzdDk4c3hFRGFzQllHandHYmdmMUtSZW41?=
 =?utf-8?B?a1lkWHpycUZNK3AwZ29kcEtnQm1FL2xxMENEU3VqamJqUTRLUEdKcDdYNUU0?=
 =?utf-8?B?ZjhLdkJTM2QycHFjcVlGVG9zSi9vbnduYjdMRFIzVVd4MlVnTnp0aWhHVkVU?=
 =?utf-8?B?V2ZtOGhRTGJQMVlmeEkxelJOTHlOUlNBSy9xbk80eWRVdUNFczJ4SDlVbGVm?=
 =?utf-8?B?djZ6SS9uQ0dMdU1mYnhmMUJSWVIwamhkR1dOWXYzeWFpalFLTEc1STJVa250?=
 =?utf-8?B?d0FzdVByenJGY1NOK1IwelhJNzdUcE9wVzVMVEQ2Zk03YkRmam1CM3hyMnZ1?=
 =?utf-8?B?bjh4Qk91Nk1Qbk1sK0g3OEcxSk12b2VPUU1NbEZFUzVUN3JlMlVkUVNreXpu?=
 =?utf-8?B?WVJmZGtpOStHb0N3dFhRWEZsbm8xcUxRZTJxcXBzblBrajlMeWdodTFMeGhP?=
 =?utf-8?B?SVdZL1JvY0lkcktQbUdSK2NBc0RWODZGb1ZZZkZqMXd5U2poWkNJQ01CYm9x?=
 =?utf-8?B?RmJyaEJKZkpkWHR5NE44clpXQzc0NU05K1p2VU5sdVI3RlF4a1RvNGFqY2NB?=
 =?utf-8?B?Z2JRVHd0eXFaVndkVXNuMDVQTnQ2TnZzNzdMZFk5aU1FcHhVbjR1Qm5YZUE3?=
 =?utf-8?B?cDhlaU1jM20yQ1hJN2t3dzcxd1QreWhKSzlwR2RJSUdpT0dvTVVWK09mVDBS?=
 =?utf-8?B?SVdIVGFHK2g5U0lOZk85ZE42c1hlTjFHa2ZUSEtEY2huYURyTFc4MmZVcStj?=
 =?utf-8?B?UThHZTBoT0JLOGdEWjdCazBML3JHSmRGWHlpOGRTRm9ObTluajlxY1UrNUxM?=
 =?utf-8?B?SVVhWXF3eFN5OUhJdURVa29xbEtJUzl2L1JKbUFsOGZwa0sxUEo5ME5qYUh5?=
 =?utf-8?B?eG1WT2UrdEwwdmtuZ3JZMFg5bDRSZXZDazhuTDZIcmRwY05yektnM0g4SUVZ?=
 =?utf-8?B?SHNuTmd1d0tqVjdBWFRhblBHcXBOUlAwYVlhVEQ3dENOUGVBRFNCSUFpWmlZ?=
 =?utf-8?B?b1FzMzBPVkNMVDNZM2RQUEtzS29HQnk2Vnh0VVZXamF5eHppK0VYOWRWa3NY?=
 =?utf-8?B?YmVzMFZIdngrNUxBbkd3V2RIekw2c0pUejZ6MUR0RjRVbWtqdmdCOUVseXFM?=
 =?utf-8?B?c3ZCbm1sK2RLekQ1aHg4Q0Zyc3RpMDMwUGJnNGFyc0tHWFEwWm8zVXYvckxU?=
 =?utf-8?B?eEYxUzNUVHdBbklzTkIxT2x4cTFXVjdKaXBqMWxVby9POC9NRXJxakFTWnNK?=
 =?utf-8?B?THBVd2NCZ3BRd29tNHNscERTaEhNQ1R6M2tLK2FsNDkzYVpXM2ZtVEhOTHpp?=
 =?utf-8?B?Ym5hbkd1bGtJME1JbDFSRjN6TTRvTXpablNmZUpNTnFyVGw2L1d0S2s1K2hn?=
 =?utf-8?B?bENqak1zMjVKTmxzYXgrUWlZd1JQTlNlTU43UkZ4b1RzdHo1cXhZRjRob2U4?=
 =?utf-8?B?T3VpZ1kxYlE4LzVlRkxUc1M2bzdSNC9xOTZrMXZwQ08zNVE3akw5aXNZdTRM?=
 =?utf-8?B?VjkrRzM2c09OS0U3RDlPMTEzcGhNbzRwNlo2ZzRNRGNHNDlRYWdxWGE0U09n?=
 =?utf-8?B?UEViSDRKdmFIQWFISk9FWW1JeEM1dkdPdkhUNXNOT2gwM2Z1ZzdHa1huZCtm?=
 =?utf-8?B?eGhZQjZhOWhhRE8xRFQ2WjJaeC9rZkp5RzloUDNNSUZIYU52OVpydHR4MXhL?=
 =?utf-8?B?OGR0UVdpN3FsZ3h0UDZicDhySlJ2ZFpNOFNIeWg2N1FkOGlJSm5zSWdZTlpm?=
 =?utf-8?B?UEUvQkNaZVZQZW9YRnpBWGUvenAzamFWQXZ1UHdwb0dkT0FtaFEyd1lCak9r?=
 =?utf-8?B?UXhOMnFGUFkxNnNhY2Y4cWovUmtTS2NER0o2aTFjRnFYNGN0Ym12VXhSdzh5?=
 =?utf-8?B?bHZmZHNOU2RjMW1ZdXNJbmR0U3pQSFo3ZGwrdHJyVGhFeGdyQXh5dmQwWTFm?=
 =?utf-8?B?eEYyUURCdk13MHR6S05qQkd3REJLQk1LbkhCNExsVHVkN2xxTlB5aElxR05R?=
 =?utf-8?B?U2N4SERzb3d5SmZMTlIycGVCRHJhWVNLU0NUMUJvUEFkVkhYRmpLZENtNk5Y?=
 =?utf-8?B?dndVUEdGMUhPRldzb2JsQWhPcmZqMEpvRjVzVzIxNVRMbWZSY1BFWW1nT0xM?=
 =?utf-8?B?K2JlWElYZUExL2dHaFRjTXVDR2pSQ0ZKcEV1UDIyM0VXWEQ0bk1Pd0xvSm01?=
 =?utf-8?B?OGJvemxHYWNkZ0NPYThlaDlCb0Q2L1J0S0RBRXIzYS9XZGg1SnBCUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df743cd7-27e0-4eaf-e174-08de8662069d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 09:21:11.0604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KQJk6UUko5fDbTDuYRVN/xbah3AJPu6aV82ya6eSICnRM2g0XQBV7NlNNICRmQSM8oTSnTJcMAmOyo3djLW7gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7457
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 20 Mar 2026 09:21:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22515

On 20.03.26 08:55, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This avoids leaking of build information and allows to reproduce the
> swu on multiple machines.
> 
> As the code is execute in the context of 'imager_run' the owner is always
> 0:0.
> 
> Reported-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
> 
> Changes v2:
>  - use 0:0 directly without id to simplify. No impact as due to
>    run_image the owner is always root.
> 
>  classes-recipe/swupdate.bbclass | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/classes-recipe/swupdate.bbclass b/classes-recipe/swupdate.bbclass
> index d92d55f..b5b5273 100644
> --- a/classes-recipe/swupdate.bbclass
> +++ b/classes-recipe/swupdate.bbclass
> @@ -292,7 +292,7 @@ IMAGE_CMD:swu() {
>                      esac
>                  fi
>              done | cpio \
> -                --verbose --dereference --create --reproducible --format=crc \
> +                --verbose --owner 0:0 --dereference --create --reproducible --format=crc \
>                  > "${PP_DEPLOY}/${SWU_IMAGE_FILE}$swu_file_extension.swu"
>  EOIMAGER
>      done

Thanks, applied this instead of v1 now.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center


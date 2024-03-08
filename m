Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB537C5475B
	for <webhook@archiver.kernel.org>; Fri,  8 Mar 2024 11:35:56 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.46])
 by mx.groups.io with SMTP id smtpd.web10.19809.1709897750985546921
 for <cip-dev@lists.cip-project.org>;
 Fri, 08 Mar 2024 03:35:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=wuPbq7oD;
 spf=pass (domain: siemens.com, ip: 40.107.6.46, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AYjQwtTRXHcXSWUglEGHqhDSVMAyAqJfNCwlOffM3RZeBjdlA/nKGXKbiSE6XhEVi/8xylHd+4f9DNKwMZWvj6b7gEgV29oTYhTSBjq9CFmaLhQr4IfVJJn8bukf7e3tQ8HORHy41jscK0GDuMWNNDprwoScnMVEej1tri6kzkm/8F/U/3jm9tPRwiuLR3xzXKZzwB1WF3LBeplPL0Acid5Bf79dk1nYJqLmBjIYeF26hCH1SviR1Y17lhlrbDNCIUwPLwls/PmVKrgv1upHQAyqV1x9rtye1/MY9groqh//BBcn2e7ie2U7WT3H1lLYPGscyGFhn/ygmm2TQwu2Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xqFN2bgyUfk/OUeZ8mFFSoTgjOaUA6wWz0G0+CC60qA=;
 b=jUjvzKILMSt9W7bYu7Dy3YnwDXsULCLwTj7G1SdYmKPdkznQnw2iDFGWuZLGEG16FZSDuiXmBlZvC23OYrz6UP7gU6A064JS3MM4nvX3pVgcPR7bppdNGdXqZ2VNrYGOOR8ZfLpPpjSeMlhKXhhW4i4X74Qti5l/iQoW3K6KHR/KNWqQBDF4829sRFG7J9OWzxiyEJsb3+XBB5qUUumnluCDH3L1fbE19xiQ0PKFXsQnTGa5C2fP+c32QBudfZL8FFKC+iE/VvYCz6/riSwr1KlxS2NjzLQZb5633IUYX8/Ni7+MR+wnEoTtbQQ7CcSGkxFRkrfS71mycOHdtMtyQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xqFN2bgyUfk/OUeZ8mFFSoTgjOaUA6wWz0G0+CC60qA=;
 b=wuPbq7oDhWWhvXfnSuWnknxc10hKq+i947fo1W1QH4uMs05JWd/+FQT5NG3YQrfeQ98Ahib4cd54zqnDUH1rZxgNyKegrHblbzsNl21+tQARyaEFGgzPA+C21qj0OB+hjIcG7E0m+e3hNClDX+OX/kUT4yC4D3NQpkPfQ6HYtnfL9KW655frVUukZj+jL26GSIOb6VMoYOGJuVe+D1mcUrI8zYjjLIvnrozDQf/KbrJmYz6Hyg657Ch7U4Waj27Z35KZN0qPX3vzVwhGge4EeGv4VAyib+lFm7S58s9Y+1bXZsnqDnulPN7lCiz/ebT6hqzIN9zgvPXrmTcHTdOEeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB7536.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:d4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Fri, 8 Mar
 2024 11:35:48 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 11:35:48 +0000
Message-ID: <7a8e08bb-0d82-49c2-be8c-03ecb9511304@siemens.com>
Date: Fri, 8 Mar 2024 12:35:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][RFC v1 1/6] conf: Use bookworm backports for
 enabling delta handler in swupdate
Content-Language: en-US
To: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>,
 cip-dev@lists.cip-project.org
Cc: shivanand.kunijadar@toshiba-tsip.com, sai.sathujoda@toshiba-tsip.com,
 dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20240307074612.1996609-1-Adithya.Balakumar@toshiba-tsip.com>
 <20240307074612.1996609-2-Adithya.Balakumar@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240307074612.1996609-2-Adithya.Balakumar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0007.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB7536:EE_
X-MS-Office365-Filtering-Correlation-Id: dd4e4c2a-5e33-4daf-19fa-08dc3f63e660
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	SLY73XEbVXNF5Gy2ghyo3071CYyKeVCVAbTAnD82Ki7xgmOkOFcV1oDzPFuUr0bP6rPnlTU38Fh4nEl7eobjPtvEp3aqjqjqeHL5fwpiN9vvl2c53lnsng+FdOkpADDGp74/wmMZqbAb68UFy11wuMimB+aT7h0SChYCe9BXl8VZ5oBYysp3nUGr1NRCryB+GXyP9WSITmNm9EI2oxpdVIoKZHC38zU18rDNzXozI32QZt0pfQqKRE+D7BRDWCXP6hsnSfMBcqr8BrmWzDjY+ydXpqI1FmDsEYecGUr+iiH35RfDp75u6lKPcTtPDXpiukWHqyR/ZmqhiqL9PVxq804/CyK0/e70vpdeMvS/qneTmpSUhr+b1EvN866d1RdJlSyVjLWbE1kZXaOeVajMpxBajKuJ8xPbXMss4ZbpURFsTIX0ObgwZZ+Ll3EXDfRJV19vCVAj6wzX9ijHq4ZhwigcmY9FfWTQ5p7gVp38l7ihqnU6R5oVsurcWOl+lZXN0tT+CgiaRriCnrATC9tVm0obiUcacJ7G6ifRSS7CudpOU72V6axU9m5hzYc/kJ+J9E1GXYtEp2e6O6C39lQqvNCPBZnBfV7JIc54xozaRcI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TXZoaDVkbmFkb1REeFJhTmppd0JVS0x4TFZncE8xVDFXdFB3TEhNcithYTUz?=
 =?utf-8?B?dmVreVFMcU03SEpTdEtmd1ZxdWN3cVRQWTd6eU5UblV5Rk83NDVWRDNCSU9T?=
 =?utf-8?B?dURDQ2VGS0Fkdkx4c1pQdzZEZ25DczNsQ2lXdW8xei9jQTNDSGh0elc5N0x2?=
 =?utf-8?B?RTVsbThoRkNMRW84czdqNC9ITzBhOTRvN2ZmU0xZSW9SUDEzTnFZQWtDbHBq?=
 =?utf-8?B?cUROSVNyRzNLQnU1d2ZwMC8yRXNZcGlqS2h2Yk5QeTdZR1RCRXlWa3lzNWQv?=
 =?utf-8?B?dTh3K2kvamdpNGJ4R3puUzY1bGZJMDNtN25RQ0hObkNWYTlJRFpxelMrcTha?=
 =?utf-8?B?OTBUby9RQ1cyZjRwVE5VNmE4eWltMVZhTHBCSmhaTmZkb2hGVTFFZ0FLSUhk?=
 =?utf-8?B?OE5lRlVxdDViWk9XdzBPMEIxLy8rWkdRL2N3UmJQM200cUkrdFhiUHlpS0sv?=
 =?utf-8?B?YTZVQWFQNkRZVFQ1UlJreFZ1TzkxRG00akIra29kS1N1Zkd0bG94M1crUUMw?=
 =?utf-8?B?RHg2WThnV0x5dndIa0ZySk55dTZCYUVVcFNjRXhqTVl1N2JaYi9BakFxUmlN?=
 =?utf-8?B?MGdDRmJyU3paU1RYejB5VGlrL1RWOWtTclZxODR2NzkrOE9YMEJDTDN0Mmcz?=
 =?utf-8?B?cUt6S2RGUFJHSWtVV0hxN0dJbVArek5HMFBpWEhmL1UwTktPemZlNTI4T2po?=
 =?utf-8?B?cFJxWERvMDZLZ0srbmQ0MCtsQktDTWc4bG5qMnRPQm1ZK2M2OE9BZThNODUr?=
 =?utf-8?B?QTVSd01ndDNWWWpsYXppNUtLdTluemJwa1IwbzFFMDJuaHk2SkJueWNzNHJj?=
 =?utf-8?B?R3hsdTVvNmgrNE1Wa0IvSVpYY0lVandMZWpRUXBlQVNNTlFHL1JFSzZvanh0?=
 =?utf-8?B?OUlWRmpyWjRUaWFvQ1Y1M2JRN3VQeDlsbkljSmRScUZhUm9BQXJML3BMRlVl?=
 =?utf-8?B?NkhuQWRIS0xHMzRYOUZhZytweEtIc0t5bzZScUFEc3ZKMlZxWlA2M0d5VlE2?=
 =?utf-8?B?UDdqR0w0dUoyOHRBMzg4blMyR09nQmUxcmk5d1Bld3JPT1B1NmdaY004YVkw?=
 =?utf-8?B?V0czcDl1Y0QrckwyQyttQzRUekFTUENGUlB6TWdUNHhVNER6KzM1dzUwQ1Yy?=
 =?utf-8?B?b3g0Q2N1RncvK0NpZFNxMi9sNk56WmRFQlZDZ3Iyb2ljM3plZERWeTAxbUJa?=
 =?utf-8?B?WURJN05sOVpJWW5xNkpLTkc4aDMxRnBFbmp0SjQ0czVIR0kxZXNLMlhDZElO?=
 =?utf-8?B?S2t1WDQ2QUV1K1ZodnBmbzlGbE5wdExKZzFrL3BMakZ5MGRkbTR4RFVsQXgz?=
 =?utf-8?B?Rlh0SXRBbms0TEJKNk5rNldUYi9WdmYrTGsxWUxTTVVuRW84S1VOcklhS1F6?=
 =?utf-8?B?ZlVlTHdKM1huVEFrZXoxZFVZOHROOUxab0NqYVo4K3BacnBjZGFJNXZGWm9K?=
 =?utf-8?B?TVc1S1ZuV3FEcFFSbHJCeWRxczk2eTYxZ2llTEtmRWh2TEVtR29wMy9wWkNs?=
 =?utf-8?B?aDRpU29UamttaHpiaXBhUTB4c2EwRFFEaXArVzByT0ZIT1UveVoyM1pkVWlp?=
 =?utf-8?B?Z1hUNTAyRGlmR0FPTkVnWEZIVGt3M1UvL3d0N1hlOW13S2dGV3R4ZTB0MlFl?=
 =?utf-8?B?aERJblF2S0VFQWdQK2R1eXpsK1Uwck5lUXFrNHhoOWdwcytCallzdGN4YXlK?=
 =?utf-8?B?RGt0OExSME1BZ21mcklMUTZ1SitQZ3Z0R20xWmowYzRPSVIveEdjWkErUTRF?=
 =?utf-8?B?enVXNEJFeTk3aDNvNmQ3Vmd1K0psYS9OMHdpaHB4RUNNYnZUbStFMDQ3cSti?=
 =?utf-8?B?bUZkZWlmV2FxVUVWbmZzZ0V1bFJNOWhFeXl1cVA3Y1Fhanh0RXRxQ3BycXVN?=
 =?utf-8?B?WkFiUi9KLzdOWmo4YlpJRmpyaVpEZGE5RDh6bHpZVEVvRWVaK0RKREpFS3N2?=
 =?utf-8?B?dEp3TTUzREcrU2hEMi8zQWlJRys3UTI1OEZWcmxSbkxsRVZLUklxQ3Q1MkVp?=
 =?utf-8?B?eFJOcXNyOGx5Z2ZaWVU3VlpwMWo4bEFjOENKMkZuUXNXeG5xY1FCWmVrRTZo?=
 =?utf-8?B?TTErOFo2V1FKNGlNWlBvNDV4bXdJMmRzbWxhVkcwTXViNEhXT0hzZXdneEFq?=
 =?utf-8?B?SWtvZ2hjL1EvbExUTmtMTHgxb2E5SlhxdUhqajdXRmM1L1hZaHNidzhOeC9l?=
 =?utf-8?B?anc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd4e4c2a-5e33-4daf-19fa-08dc3f63e660
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 11:35:48.0548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lC8L96s9k0Him/+QYXleSRmtOvTalBf1y2mgQA7tSvGInvOEG0LJYXJHDMC2TmBMbEW5l+1laIA/VsDFO4E4HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB7536
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 08 Mar 2024 11:35:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15264

On 07.03.24 08:46, Adithya Balakumar wrote:
> Delta handler requires zchunk > 1.3, but the required version is only
> available in bookworm backports
> 
> Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
> ---
>  conf/distro/cip-core-bookworm.conf                   |  3 +++
>  conf/distro/debian-bookworm-backports.list           |  1 +
>  .../preferences.swupdate-bookworm-backports.conf     | 12 ++++++++++++
>  3 files changed, 16 insertions(+)
>  create mode 100644 conf/distro/debian-bookworm-backports.list
>  create mode 100644 conf/distro/preferences.swupdate-bookworm-backports.conf
> 
> diff --git a/conf/distro/cip-core-bookworm.conf b/conf/distro/cip-core-bookworm.conf
> index 9bcf559..e0a4f7f 100644
> --- a/conf/distro/cip-core-bookworm.conf
> +++ b/conf/distro/cip-core-bookworm.conf
> @@ -12,6 +12,9 @@
>  require conf/distro/debian-bookworm.conf
>  require cip-core-common.inc
>  
> +DISTRO_APT_SOURCES:append:swupdate = " conf/distro/debian-bookworm-backports.list"
> +DISTRO_APT_PREFERENCES:append:swupdate = " conf/distro/preferences.swupdate-bookworm-backports.conf"
> +
>  PREFERRED_VERSION_swupdate ?= "2023.05%"
>  PREFERRED_VERSION_linux-cip ?= "6.1.%"
>  PREFERRED_VERSION_linux-cip-rt ?= "6.1.%"
> diff --git a/conf/distro/debian-bookworm-backports.list b/conf/distro/debian-bookworm-backports.list
> new file mode 100644
> index 0000000..c4873b4
> --- /dev/null
> +++ b/conf/distro/debian-bookworm-backports.list
> @@ -0,0 +1 @@
> +deb http://deb.debian.org/debian bookworm-backports main contrib non-free
> diff --git a/conf/distro/preferences.swupdate-bookworm-backports.conf b/conf/distro/preferences.swupdate-bookworm-backports.conf
> new file mode 100644
> index 0000000..b6efffc
> --- /dev/null
> +++ b/conf/distro/preferences.swupdate-bookworm-backports.conf
> @@ -0,0 +1,12 @@
> +Package: libzck-dev
> +Pin: release n=bookworm-backports
> +Pin-Priority: 801
> +
> +Package: libzck1
> +Pin: release n=bookworm-backports
> +Pin-Priority: 801
> +
> +Package: zchunk
> +Pin: release n=bookworm-backports
> +Pin-Priority: 801
> +

Backports are bad when it comes to use in production (they receive
best-effort updates only). It this the only options?

Jan

-- 
Siemens AG, Technology
Linux Expert Center



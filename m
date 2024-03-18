Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F95CC54E58
	for <webhook@archiver.kernel.org>; Mon, 18 Mar 2024 11:26:24 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.82])
 by mx.groups.io with SMTP id smtpd.web10.41003.1710761182429620520
 for <cip-dev@lists.cip-project.org>;
 Mon, 18 Mar 2024 04:26:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Ljbki9wQ;
 spf=pass (domain: siemens.com, ip: 40.107.20.82, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AKyPiTv8p3nJZdtntjEk6WS7FR46SsjEDW7fhIu8eBbknHHdRKM9+NGNZ7+M+b2pN7ic9m4wATyAPw8t1R2URixNyDpyzddhhKcD10ZmZOT8peY9tGyXwec1JlCRf5h4deswMmdVgk9puE93vOPTeRzCweOY8itQNwcDOwcaWMAKDQ93nWnTTztNNKiafATPcVl5jFPnGXcXsgRrgm8yxw0JbvWePhjbJsMeeMRemosxcjVlQ3uw/xamVJILbZIrMOhnlqO9bKoIBTMtNs2OpA2a7w/pcVXO2QcOWPF6Rya9+OLfs7QXRgBzAwCm2aQJeMpvx7Yc1Gv2cBph9TkVXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r4/ticjYzQLR60Jvr3FPjNGF6lwSqwpKimBltyuxlLE=;
 b=Z64659PUa7r6O7XAlZEJ++zo0ZSJAH1m0uoYPb5KxiJQI1As48DL4AlTNmZb7XmEDHeFsS0Q2oLDqEbpoVHJaTFZ+psjnWYSq1BHhB2ukbSB7+m/WSRO49+yk/0cKFbo76xbPMj+h/nisqeb2JCPQ1L+hcl71psg4u0J8e7XmfSYmB7JPPZHNZxa0j9CwVhtA62970jhUayJaA7ulIzQcKufmENHwU9dvXAD1QONaYWX025m5Ltyj0ePhY64+lcWGoOG+TJm2DEZWsyd5EisDjHNo/nuVs+0Xk95/Tk1H6F9oBBhboBIHhAGAiqZYCHCjgfDKUDSkb6ZXtV5ladaLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r4/ticjYzQLR60Jvr3FPjNGF6lwSqwpKimBltyuxlLE=;
 b=Ljbki9wQKtxewyQGSpQ9ZloIV2vIUsN86Is9PVhfLGFyUDQe99muV6gxylRVyp33JJYpj2KhZiNWcX3zEFAXiushhN5EWk4FxoUxxkndk36jxTS1wUpWg+KqC1fkEVjmcHYNMLKsCzBvpTyqTPOl6NNkRXT/ywWdjml1fY6FeXHsV6eq3XiYbOc5RLU/9U3DfFWwxaFWjc0vryEsbV8hYEaOd34PRu15UBu3e+2SuAQy55SQ4ZiXBU78uUQiV4ea9GLJP3tDFpIO0Oonkgjl5zLzTOPlOKpG7uyzhz0tLqh+LfvLXBRVdcHGZuzsslJaQLOOun77kjFbp4RzBPhktg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAXPR10MB5206.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:276::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 11:26:19 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9%4]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 11:26:19 +0000
Message-ID: <979fdb73-5e41-4fc9-8dd1-7fb5f9eab9a5@siemens.com>
Date: Mon, 18 Mar 2024 12:26:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][isar-cip-core] recipes-initramfs/initramfs-crypt-hook:
 remove unwanted directory
Content-Language: en-US
To: srinuvasan.a@siemens.com, cip-dev@lists.cip-project.org
References: <20240315095246.275065-1-srinuvasan.a@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240315095246.275065-1-srinuvasan.a@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0100.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAXPR10MB5206:EE_
X-MS-Office365-Filtering-Correlation-Id: 70f46017-6fa9-4c69-26fc-08dc473e3bc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	sL/002nCY9SwN8RWe0Ei+kph1rx1QWj19Y49U2LzvvONwnrbfpF5Xso+Cba206zn/jDvTeGWC+zNmlGncxuobamc39gSB7YtgwawTLW9IoN2Kczgt5MA7WkTIeAFkF99XzAJ+tMZMoZe+iidzk4DdQHoFUf6O3tlXet1PQtJDmNaPv6PkmR1nbucU/ZUonOrK7y/mgpfaS8V8nsevsBtdgUP9gwLmSMk+EKVhSLVs7jCDoYLOmJ2kv+yLDYVsbsItyqml6K8jTBR+sb3FRpdfZlGrT60nNrOAK78AXYe1Vb/6l533BE4hPlFP0DOHyrCL3vHLlGFPlAyoMXuIt9OaKMRdXmsxB0meLFs4gv4rgW78PtI9SDTaUwxM/kl4UcqAO/9He5i+VqcFj7QI0t+POteDgxqOn3al3yCV+Od2clJLFkjeT39al055H+VYhDcbUzaUktkHA4GRvqIwyeJrNCJSo18CexOA3irvdmHtWEY1Vm4ROKpRi7Nmw/7XRO/ZvSq0yKmeBHj1TiNWbB1FD0JY4Aq3nERBah1t/WPB6jKQHvpQL9vHUaX9Uo8QQjlgNd0jxXEkkbZjbDJ6lA/OddFmkzg6GYF2Q9KA+KXg1/+ZrpQiIxjKkeUoSDzOxUSR6Lw0R+xw0/ErJwTib3e3AV49GcAGEkCsnjLhyz+jcg=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RHF1YU5KdFUyalYwZWEzbWU5dmRxTXdSd3NaelhJck5GRVM0VkVqdGlXeDdk?=
 =?utf-8?B?RWhYUzRrNFpmeDV3YnVKYndwMk9ScVF3NlVKdWxWNUx4eU0zMHJ6RXhhK3pq?=
 =?utf-8?B?RXl6S2gzM1RybW1VZHNZNSt2elJKdmdhMW9HNjRubTFaU25CdEllMytZN1g5?=
 =?utf-8?B?QUpKajRDQTNHQmxIUE1LUWVVZXNmTUJiSEF3T2pIR2pJWS9jbU9hQTg0a0dV?=
 =?utf-8?B?SDVCM3ZzdWFlS1h5VitsSzhvZHpsSXFaVUIwNTNabFNWNWhFR28zenByT3h2?=
 =?utf-8?B?K3hlbnRxdENBaGN1dWdkOWZ6MDA4bVh5U215QkNhYkN2T2lIMlkrb1lDcC9q?=
 =?utf-8?B?WUFmZjVXSmhjUXVyZXAvWlcreDIzVjlVdkVMS2VVZ0piYmtPTDhIeWx0SUE5?=
 =?utf-8?B?QWtJRC9vNG1FMDhGY2xzbGo0Mm9MTG94enV6d05uYjF6NHdaK3JOSldCUnlo?=
 =?utf-8?B?UzlRM1pmN1hTLzVZVkErZ0d5S2oreXI0M1dYT2NWMTVnRnROODU4T0pRTkVY?=
 =?utf-8?B?MjhucS9VQ2E0VkE5QlV1YnE0MUxnNStsVXQrc0xJajl2MTFCT1BGckc5Und6?=
 =?utf-8?B?a2N0Q2lkcmpFNEg3RUVrU05pM2V4SFRGdFNpZ0g0QklVTXlMVTRzUUdkT0Rr?=
 =?utf-8?B?ZHM4SVZOdU1ReWR0SjM3REo1d0FzdjZ5SmNXV1MxVnNucFM2NzBEQjZWK2xR?=
 =?utf-8?B?K2Y5TEVoTncycFFzSXcvWUk3WjB0dkxXcStNVlVyZ1FnSlpDRjMzYVZvK0Jo?=
 =?utf-8?B?MEF6V1g5R1BQcXBnSjJFbVRTSnI0MFR5M0t2d3ArazhlMEF4WktPQUkwVkxS?=
 =?utf-8?B?eEE5TE9LN3EzK0s5SXpJdnFjK2lrMmRsc1BLd1dFbktXam4rNk1nMXhoeHNK?=
 =?utf-8?B?UkdSZlJ2SkdpTHl6RDhGTW55TUlZbXFZWFJ5cTZnbktTZDJINFlab2t5RXJs?=
 =?utf-8?B?eEFoMkcrVWRsV21SMk5Bdy9jbHVHbmQyUkZwanBybVh6bkhQTlo4dFNIcUhF?=
 =?utf-8?B?TUd4UVM0UGRwcThXbjlWem5aeFJqdXZiaFdIelUxeGlTek43UjdGaEl3clky?=
 =?utf-8?B?N2tQWHhaWWxhMUZTUVdxSk05a2xNZUk3Z0pXajJDbWZ5bmhlYlNyMlJBMjAz?=
 =?utf-8?B?bE12ODM1V1JNMjNaLzR5aUp3NFVnTXk4VGJQaDRVa054TFlmckNMZXV3TmRY?=
 =?utf-8?B?dDRRMlE4Q05ZcC9xeFJLcEoxTGVDZ0h2T2x0bDIyMkFrM2lvL1dtaWZUMHp3?=
 =?utf-8?B?YjZWaTNQSzZwck0yQWVGbitscmZ6YzBpUFN0ZHgrd25uNjBhM1RHWUVmQzhz?=
 =?utf-8?B?ZFZLMnVUbnd4bmVXR3IvS3p3eWRNTGhoaUt2U3lOUy83RWVVRVozeFJyVWpy?=
 =?utf-8?B?a3ZDVVNpZlkxRCt2K0ltN2xEY1lFTC82Q2F3ZUF3aU45d2xrLzQ0VWNhR1hr?=
 =?utf-8?B?SnRPM2pydkxrZXBVZ0hmZG1OMXhUR3NyemVWRUtaSHgrbEd4SWdqZFBPSkpZ?=
 =?utf-8?B?MG5WT2tNb2hCTXJweXg1VkpRVVhpWVA2anhGNk9XUkk5MG02TW0vdkg3RG9V?=
 =?utf-8?B?SE1sNHZsYitUR21XQlFNeUk3VStDV2ZvUnZGQ05maE40eUQrUE1yZ3hhWjgr?=
 =?utf-8?B?WDl0QlkzR1AwZ3ZKaFcrMXJPTDJEbkNUdkRKeGNCdVAydHpldjRJang0M3Np?=
 =?utf-8?B?OG1GYlQ0SnoyY2ZlN3p0anhFM1ZERGJLaDlwVGxNMTNxQVlzRWFaTm9RdXB2?=
 =?utf-8?B?ZUkvcHR3LzZicWNicHVoT1RzSlFXMVhuaG9WMjR1YXJwWnFVakU3RUdHcmhJ?=
 =?utf-8?B?dkdJaEZVNG0wTVFvSU5YVnlZd3AyUCtJMDUyRmh0UFR5VHdxb2xJU25qVGEv?=
 =?utf-8?B?dzJWajFDN3pMMU1TNGVBbFZXVkFPMEtSMTFEYktjZ0ZKVnk1TitJYXBKdjcx?=
 =?utf-8?B?UUR4SmpLQWNaSk5PNlIyVkZqTW5XWXk2TFovdHJwVXN1d0pMT0dlZlRuTXY2?=
 =?utf-8?B?RXVPOE9nU0RobGI5SUlPRVlISmxFOVNGamRWamFrYUdSMTdJU3hyM1N0QU13?=
 =?utf-8?B?aTFrY0x4dHZnbWJBRTZqVU44Y0RZa1FDNDQ3SEVEY21keUtCK1pubFEyT21Q?=
 =?utf-8?Q?n9uBGJfr/JYhiFW+UbmX03Uom?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70f46017-6fa9-4c69-26fc-08dc473e3bc8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 11:26:19.7390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fsf/77rjszZttFZxYN2el3AkoLE8Qh0nRF132JSJYDuTsYX6D9KiKdskGVnfqo+XPMVpCPn+Pv8rHlwMzNB6pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5206
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 18 Mar 2024 11:26:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15340

On 15.03.24 10:52, srinuvasan.a@siemens.com wrote:
> From: Srinuvasan A <srinuvasan.a@siemens.com>
> 
> We are not installing any file under "${D}/usr/lib/encrypt_partition",
> hence removed from the do_install[cleandirs] part.
> 
> Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
> ---
>  .../initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb          | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
> index 3b2e6fa..b275c0f 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
> +++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
> @@ -48,8 +48,8 @@ TEMPLATE_FILES = "encrypt_partition.env.tmpl"
>  do_install[cleandirs] += " \
>      ${D}/usr/share/initramfs-tools/hooks \
>      ${D}/usr/share/encrypt_partition \
> -    ${D}/usr/share/initramfs-tools/scripts/local-bottom \
> -    ${D}/usr/lib/encrypt_partition"
> +    ${D}/usr/share/initramfs-tools/scripts/local-bottom"
> +
>  do_install() {
>      install -m 0600 "${WORKDIR}/encrypt_partition.env" "${D}/usr/share/encrypt_partition/encrypt_partition.env"
>      install -m 0755 "${WORKDIR}/encrypt_partition.${CRYPT_BACKEND}.script" \

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Linux Expert Center



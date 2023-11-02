Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDC0C4332F
	for <webhook@archiver.kernel.org>; Thu,  2 Nov 2023 06:10:35 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.51])
 by mx.groups.io with SMTP id smtpd.web10.25124.1698905431275242795
 for <cip-dev@lists.cip-project.org>;
 Wed, 01 Nov 2023 23:10:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=adDOdqmJ;
 spf=pass (domain: siemens.com, ip: 40.107.21.51, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ALpHbszztvz5btdjg3130zA/YFzOzFFOctYvVK/ha+qwLLIZqiMpGKznF91l/f3pBy1esFhC7/dTLUFF7ZEyjI9Jo7quU6u6/pkg10JscQYoP2zXU39OhpdFdccBUvS3GWlDPjWO2TBPfj0g+Xw7tRZvUrMtvdITjPvt+Bf3oPYLjsdpvOuuWoDjUdBFwe1mCvKqcYmZW8TlRvaI/cOqcbwbsnUgrC1uITAmVjEXKZegevF5YOyrjFEuGOC2Iga2FB9eK+6N6Pr25bfv93QMaRHX+WNFe96vevdd8ECwHhSPVmviDr1/KAZvK9yFp/scmsEERf+ibxZXkxmlaBgKFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=euMdMOXYvPeRIpLyCja2ObGZwPUF23AD7HerZZgUM28=;
 b=QljXml8QuqFvQ8fktNvPpgaDRjcXw+z+vBDAwvnsFWaiVrW+X3LVKc32h27NLQmDcriHZvYi47FLnyqX/AoKcKSbfFSM5qbOtOEZ6/lAun1RJ2fPprNMObzAWeHbHBvlJOw/coX6P1UbjXWlRH3XTQm8wTSUFdlqXtMnp982YLAKtFlh/TnHr6qs7XX+McyYeqFNG7tVamUUKrg3hNkqQXhVrwhIoOPPjF/h4NSnQyKiwnduBpWQKPdsGAxGDweMLazabuEAlak3B49bJRKA/VWRxrB2J0bEKcaP0erYGmYPHG+e0yxigNOoqKXU46ynfY4xYNB+8VcWtc3sPFDQ+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=euMdMOXYvPeRIpLyCja2ObGZwPUF23AD7HerZZgUM28=;
 b=adDOdqmJUgCSDWdO9grXqNYuZIXdJDiTtPZbPk90KRjpmk7wfWAjc1P72aCtGSiydw6ul0Hm+Py1P1CzeCrlZ2Bwo4/QNLDg5g68Q0OGf3I6qggHa560wNNpMt8Qm649I7T7AcaGVxpert1aGHWNCbtIWYDd9g9WPoglazQFZDQ32leHudTLGOnqiNRuVkKFHKpzjAFyZ9TbPMHU62mF7MykeGYgKIRjvJujmsw6nzIvF9/tO1h2QQ4sxDFRGRCPoXO7fjoyomKHMudUUb0Kx4MTIiXgtYSwzxhS7ILgAa6JZHcIafvkuYL9GBBdRpiwl8YUtOsMfUDpNcZuINCb0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAVPR10MB7489.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2f4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29; Thu, 2 Nov
 2023 06:10:28 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8496:a3a3:d7a8:b24d]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8496:a3a3:d7a8:b24d%4]) with mapi id 15.20.6954.020; Thu, 2 Nov 2023
 06:10:28 +0000
Message-ID: <f1a52e61-3404-41df-85fc-7453be0d4be7@siemens.com>
Date: Thu, 2 Nov 2023 07:10:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] added pcr_bank for clevis
Content-Language: en-US
To: "Sari, Sercan (ADV D EU TR C&E)" <sari.sercan@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>
References: <DU0PR10MB6898A9738AF1110D653D5DE5F0A7A@DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <DU0PR10MB6898A9738AF1110D653D5DE5F0A7A@DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0177.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAVPR10MB7489:EE_
X-MS-Office365-Filtering-Correlation-Id: 827bddf5-bad6-41df-3d1c-08dbdb6a6902
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	TozZkFhTTHUkBpaq7iHx40dIOoG0FsD44e2U+pE0BilIBIQ0nzs8PXf4DHpW2Xyc5NRhaf9yuQI4ebMUcj94VOx8y6okNZQomczZ5IrPevZOrkf2eP4ed+AjMjM24gvlQ1waH/RNgKgYf8Njh8bu0Rpx9PfcpzOoJnIH0uzLHkEQqafTB69zkk3EPNA2Q04limQ/7WKf+Wu+oyazVPKGyDtswhgYcmi1EYN152VwzB2gmiFCFF97dzXExH3v2CMmO/WAh4bOwy8a+Ct5794uzM010ACRJx7ZULlgwlGXcJ4GiITq/dS6jrzuP0S0HaQGkkeTFCUnIjd+VvFBh39Jtu7AYa70dQa4fkqlujmZ2ocmj4JWQEy82m/iEmr3ORkG6wOK54FoEx2QVkL/Z57bXvOMEn+CqWDehjLlTLD6/Mrk8yV8HcmW7j4HW3pqOxsT7hr79gsf+yLjfARB+UbDV6+a2e+1paCPs7jJTJW1cxH0ctGXmMKdXYiQ+bmSP7Zgt6fc5c6z7b83PcyIjKVe9ve8KD21LdTMS8chD7L39l/FHSaiCsRloZ2fWlL76yq/DPTCWLGv+xTILsQGLzAYP9aIM3FpSgDyRBiPdyz0BIEY9xeyBoc7bB5sVN1nLh/FelFzYVr0TeaxC2gBIjeTgg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(136003)(346002)(39860400002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(6486002)(6506007)(478600001)(53546011)(6512007)(31686004)(6666004)(2616005)(26005)(316002)(6636002)(66946007)(66556008)(110136005)(66476007)(82960400001)(86362001)(38100700002)(83380400001)(8676002)(31696002)(8936002)(41300700001)(44832011)(36756003)(2906002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VmRVY0laSVFsZHBmeWRPNEViMzFEOURQb2xkRGd1cUFQdDU4Vjh1ejZwVnVh?=
 =?utf-8?B?SFBpcW1jb2NBYmswZzJLbitGbFp6VHd0UUxZaTFKU25GVFdBV213bGtWRUhK?=
 =?utf-8?B?MU5VYm5LOE90aHVRVC8wWDlxMnJLWThPMGttSjdOdDZRT25tVW1BZllPR1Mz?=
 =?utf-8?B?NGVRTjlzeTVKTFRESW56ZHhiUUdNNkI0bm51UlNYaVdHbzczbk9EbmZ5c0pn?=
 =?utf-8?B?ZHJCcjI1cm56c1hzU1g4YzVMMDNKTFNHcE9OTFh0Vy9ieHpJb0RNQVIwMUU5?=
 =?utf-8?B?ZlBkVXVhMmxLRXhadVZJQTRzNkduMmRWb0dsbUFyVDJ3THZhbUxTQkJWcHpz?=
 =?utf-8?B?aGFCb25PdGlrdUlheTdVOTRFNWpyL3JzT24xNFd6S1k2aVBtZzl2SmJwek9M?=
 =?utf-8?B?UkhPZEZnT1JtbVNLL0JDUkpSTTNNQzlDOHN6azlVU3RVVzhpa0NEV2RWRUgy?=
 =?utf-8?B?U3BPY0hvdGpUZzFxWUcvUlpob1ZXbS92QytZRDMvRFk0NytmRnhkZEhvNkZo?=
 =?utf-8?B?dkJaVW1sK1gxY0RrbTVCa0xVT2psVUdETWdySmNhUmlDNEthTjhKQkk2QXQ1?=
 =?utf-8?B?dXFxajNsS0MvcjBZMWlDWThuaGN2UlQ3WE0reHZTdXNpdjZVV0NlUXRrTG9k?=
 =?utf-8?B?UDdwNUVlZ3ZtajQzdk11aEl5bm9RN3c3MUZOVkZFdXdEVXA1S0lVcnViUUdC?=
 =?utf-8?B?elhUdmtKcDlQZGlxOVRYZmlMcWJJKzNjbTFzazdvTHFIMWVyRG1YQTZ3Tklz?=
 =?utf-8?B?dEl4cVc3Tm9ya1IrOTNNMmVRMzcySmEwQ3JHaXUzTWd5QjBCM3NxTUY1bE1W?=
 =?utf-8?B?OThkMC9mSGR4RmhDQWErZXZjaGZOUVhXYVhneXhsMkRieGdaaUkwMHd5Q25r?=
 =?utf-8?B?RUw0UlFXYnZNSGkyYTRsS0lZbW82QnUwS01ESXZzaG1VdXpqZmx5RXlIdnJJ?=
 =?utf-8?B?VG9NQkpaZ1c3Y1NqUnpWcFlnMndHc3JFZTlDeFFyaGFHV0RQVVVGd25CN3px?=
 =?utf-8?B?aU5MK2I3dlJTUDIySWFyc3dvbGxnL2hlVzFSaHAyYldHTEJZWmY1WmpkWG5m?=
 =?utf-8?B?aVJ1VTk5Mjdkb0tjaTlUaUx3aWV3VGtZdnlCNG82TnYyeGZsMmc2dng5SlhU?=
 =?utf-8?B?UUZ2Mk15a0hoNGRack9SNTNHcUNBNUJMakxBY2FHMkl6QUc4R2xqdmFrbFJN?=
 =?utf-8?B?NUQyUjhiR2JWbUxvaXFVRUw5cWNOL2FGWjBMVFJOTUdwVUR1USthSmI4VDVT?=
 =?utf-8?B?Rkw2c0FHbGlkUG9kZkRPS0xydnJJZExDN0xueU5HQzE0SHhIbWJMWERsNzhk?=
 =?utf-8?B?Q1V2S2FocGpOL3M4QndBMFEyK28yNkh1bXdoSVB4eFdkMU91cnpnR2NSTHZi?=
 =?utf-8?B?T3dSZVJCbjZQa1hEdEVtT2tFMU5TK3VnNksyRWc5eGU2cElhc3lCY0c0WDht?=
 =?utf-8?B?SFV1dy9QRlhoT29tZkk5MVV2TEFnbFJIUG5Wd2M2QTBHTTJCZFlTbnBIVGkr?=
 =?utf-8?B?dU5oSHFjbHR3MzBBUTc1NFc0OGJ6SEJ6SDlMWDZmVi9rS2xpaHN1UzlUTTJT?=
 =?utf-8?B?S1NaMSt0Rm5HUUlIMDJqK1RzMFZubkE4b1F0YWhrYjZCa09zTDFKZ3dKM0Mv?=
 =?utf-8?B?dXpLS2hlT0R6TGNPVXB0ZGJKWHU5cCsxRi9URFkwNDI2Y3BkWnh1WTZET2t5?=
 =?utf-8?B?MXJsbW83OFJPVkxGUVNPSTAyVTc2cjV4cmpvY2FnUFBlTmplaEVGbTVvcnQ5?=
 =?utf-8?B?cWsrUU5qTU1nbjNKZUxxM202bjBUK09EdnQzZmdpVitQTitlM09XUDhONkly?=
 =?utf-8?B?Vm1DNGVSOExpZTI0MXRNSFZnM1YrOVBaTnZVNm9jeHUra1UycndocXFBeFVC?=
 =?utf-8?B?SGMySnNCc0NTVTRjNXhJeG9tM29RZHZDcllZMndSS3V5VXYxdzZ5UUppMEdm?=
 =?utf-8?B?Z0ZmdENBNGZFV1M0aXc5OXNBdEYyZzlsTUJvcmhFRnJUMnZwU0pUQkdBZnZW?=
 =?utf-8?B?T1BlWGt4SndPODRXOHJaU3FVZzFJVkpPbWx4dHZkTzhpNDErYkN0L1kwbC9r?=
 =?utf-8?B?bC9zRHQwK0cvcjl3dWZySkZsdytxUXR2cEVBMVBSNXVUQ1BVWWJSa3BaSHVa?=
 =?utf-8?Q?I2XDJ7zeMoGYEqw2LMhUUnIrF?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 827bddf5-bad6-41df-3d1c-08dbdb6a6902
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 06:10:27.9264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JXMFZQiRyZ9lJA4L0m3jVSmwzyYy2RkWB2VTfkfrnHH8HFQDgjd+O+UMCs++W0qeNwyqrjadUIiYx1TuzavdIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7489
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 Nov 2023 06:10:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13509

On 01.11.23 18:17, Sari, Sercan (ADV D EU TR C&E) wrote:
> 
> clevis will fail to encrypt data when the TPM has multiple banks, such as SHA1 and SHA256, adding the pcr_bank information resolves this issue.
> 
> Signed-off-by: Sercan Sari <sari.sercan@siemens.com>
> ---
>  .../initramfs-crypt-hook/files/encrypt_partition.clevis.script  | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
> index 899f20e..957a3fd 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
> @@ -61,7 +61,7 @@ open_tpm2_partition() {
>  
>  enroll_tpm2_token() {
>  	if [ -x /usr/bin/clevis ]; then
> -		 clevis luks bind -d "$1" tpm2 '{"pcr_ids":"7"}' < "$2"
> +		clevis luks bind -d "$1" tpm2 '{"pcr_bank":"sha256", "pcr_ids":"7"}' < "$2"
>  	else
>  		panic "clevis not available cannot enroll tpm2 key!"
>  	fi

Is sha265 the only reasonable setting here? Just asking as we are
hard-coding.

Quirin, any remarks?

Jan

-- 
Siemens AG, Technology
Linux Expert Center



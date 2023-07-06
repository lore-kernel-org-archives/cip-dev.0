Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03455EB64D9
	for <webhook@archiver.kernel.org>; Thu,  6 Jul 2023 07:59:09 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.40])
 by mx.groups.io with SMTP id smtpd.web10.16549.1688630342823099748
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Jul 2023 00:59:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=fDR8EcHQ;
 spf=pass (domain: siemens.com, ip: 40.107.22.40, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M9KNQtQzWVEF6/bVa3Xoat4OZEySHF5t480K0GdGTQiytNls1w3LWM2L4qgbySF5IIX1/CZvodRllX44+W3piodDwd19698A4k+5HHUXaNb4O+4tZvpR1ls/hBGtMe29NTIX51dGgQmH7cgdgMGr0w251XakIlr5SoS2qQCQBXSunGbKEwbaHyOEFO4gvp3INaNd2WZYf/Qqkxq0jyCHJiCGdyAMXYieQdaZ8yNMruLpez+7yjd3AIOyK6zNvThlFylBrWhJDm02c99serZS//OvzG1lDeour41lQwcmFyB0TYAy19tOTsttkub7HKM+NTCBsGlcXs0ODl3F7DX7Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TEWf242ZkjbZfHMrAxlzu3iP+PgyMFRrDwwN8cSoLVk=;
 b=ahKVkUTdvvgr75u56hdvyUmMLp7uh3LYzAPYblJ10VzCyRy+q1nv/f6fDB+iAZW+R/hS+4uXR2aD8SpjLtuf7FKlmIKpR1t2ych7dYnz1GChc2jO2++4oMDtd5IwcYKgM+l3rFbVVO2YWIQYAJQf7ZsaCgrNm8fQO1UXDSh7xgSOOhN0+9cuRB/CU2zyRWUD7DeVHo2cS+pyJ/xBu4nOFa8L6EVJZKYmq567/LwYLWKnrg1hZAfTtRNFeGKIvSPtWcW0L9S5UlGyeo11+cyNLrTZCSEshsLx2bxDgpyScuTg33XCU6n8A+rLbRITlUtPdpPTaMGlsjDF8sGL+XiF9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TEWf242ZkjbZfHMrAxlzu3iP+PgyMFRrDwwN8cSoLVk=;
 b=fDR8EcHQjkU1Wj6C9sZyYcK4bvoBzrHfLjExSFSDDlIchZyZpcD+FtevzBB36MEnJjLtdaa9M0rcidhcpumvoykvyi4kUWnocQfc45t8YLPvKht/x63+qak1wCJkQcoM2UBde2insfwzCvMfSm22xoNBvR8TvJG1t9u13k5q/16t+CszZ/vaP7Pz0VvtLaawqDNue85W1p4efVfS/VrFPMt4/tX0oMGxka/aSPpGLjhgv5e9paFCqDM5t/I36mU02c/3XF9gjdW5jYocHPKIqyFCSxWlq6KuV7HXXj6BPrO6ZDv8+6SZb/QjWlqJM4YHCgYRnOV0Cj9UBRIWTDSXqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB8261.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4c8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Thu, 6 Jul
 2023 07:58:59 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94%3]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 07:58:59 +0000
Message-ID: <ff2d9272-a5e9-ddca-5211-0fb71c494e2b@siemens.com>
Date: Thu, 6 Jul 2023 09:58:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [isar-cip-core][PATCH] fixed function names
Content-Language: en-US
To: "Sari, Sercan (ADV D EU TR C&E)" <sari.sercan@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <DU0PR10MB6898BCFC06EEB45756106C26F02CA@DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM>
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <DU0PR10MB6898BCFC06EEB45756106C26F02CA@DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0015.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB8261:EE_
X-MS-Office365-Filtering-Correlation-Id: 11729ecf-1d19-4107-f6c1-08db7df6db26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	QCUvB7Dix/7hwJass2XUExkQiaJjMdis4FhXlaiCkMWoO1kREmUTjFEEw4XlZ+GnkNojm2x3CJyky/tCBFV6UkYKHvcFXJ2Ajm8Sxjd5V7B6HZPBKg//Ba0jDEaa5c7qMPP1vCErGgHsDXbVnY3D8q5GhXZAFaT3jNs7ZkQy8ezO13e9yPgPQD7sk1HEsGjnmUJ04Ls1Chn9O1JobHPbNTjPttzXiZrclO112M2x1NJdjvYNt5URFh20paBm623FgHmW9pFlFdMgS+82hn2mi1m8AYQm4viYPj0ebPgcPfD4RhOCzrB80Fc3XhbxiVLA8O16jImqjwFB7ZgRo/wSEPtj8LkLvu2owA6zLjKmTPMWcK8IbmlFiXqq/MX0kG9GHgRsJzPJeC74zAkaSTAM3sodqOM63uR+mguBHh3D2VLsEhMxw0ZpznhSgtOfhugAKA51pt1iA4mqGvUpv2rMfys62h+rgZDyI7JIxJSmZr1IT3l+6YFbQ38UjXCIiAHF2IZcQIpkp5lhQm7KvMspxD6REkNP9wADilGsG8NEh7gvyPK6HVIypf4xmMuV4Hk5OTpXUM5mIpM3cBTdba6ZTlqT8FxU/SrI3Mf8p82reGVc/VCNUXtNf4YhWwwnsKJJYcFrL4o+EC+JBhMk26LlRA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(376002)(346002)(39860400002)(451199021)(31686004)(478600001)(4326008)(110136005)(5660300002)(8936002)(8676002)(36756003)(107886003)(6486002)(66946007)(66556008)(66476007)(316002)(41300700001)(6512007)(53546011)(38100700002)(82960400001)(83380400001)(2616005)(186003)(44832011)(26005)(6506007)(31696002)(86362001)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZmZBZTdxUXFzSGJtRXZCcDRmcjE5eTY1c3BhS3g0aVdJZk5zUmlqSmZWRDEr?=
 =?utf-8?B?cXBCWVgydzZ4SFJNYmVkRnEwMWd6MmF1VXZ3WnZCc3hJRGQ1b2pJaCtWU1JM?=
 =?utf-8?B?M21jY2lMamppRms4cGFTQ3A1QUd5SUcrVkgzc2ErcDRweWRYc2ZNSHZpTXlt?=
 =?utf-8?B?RHpUeGRzVXVlOXVPckZINW5iUkRWWXJuMXVDNkhSdVI2dUswSDRwWjMzZHFy?=
 =?utf-8?B?YXV0WWVFNUJsZ0xORkhhNm9lcE84aGFVY1ZHU24ycFFOSzBKN1BKQW53ZzBE?=
 =?utf-8?B?c3ZHdUg3bXBZandRbjc0aUxyc2FGNUpzV3BNSTJ3UExHR1dTRXY3SlozaDNw?=
 =?utf-8?B?TVRjcWsvVzVnK1VFbnpHSzBRSG81cDl6dnJ3WXhqZGFqV0R4eTBib0FxZUQ1?=
 =?utf-8?B?ME0wQXFrMTZHRE9WSDMvRW1iMTFzUExPVGNZQ2ZXby91UmU3SHFUYlI1MTh4?=
 =?utf-8?B?RTMrOWFpTm1JN21IRGU4NlhCam5SZGl3MncvT1BDamptaG9Qa0J0VExvZnBW?=
 =?utf-8?B?NmMySkJNNDZuNVF3QzdrWGpqcTRFMEZsYldFRUd1dGczMnBxdEJnUENZeW5o?=
 =?utf-8?B?S2tyUW1QakVLU2xzaGo0U0JsOHZjcFZMem4rVzdIMmJlZnZJSkQ2TEUwekNP?=
 =?utf-8?B?YTJQRkFCbFRBL29sM2lNbzJPdmI1ZGdkWFZLMkJUek0zVGJnMWFhRTNGaEIr?=
 =?utf-8?B?L2JNUkMyR05HZkxrQmRpQ1dJYk41R1QxVGNJYUt5Wk01MEt2cmNxbjB2Tlc1?=
 =?utf-8?B?cVBVai9vTjc2S1lVUWR5VGsrMTFBeWFFSlRWcUd3T0tlU1F4ZVVqNVIrMHBE?=
 =?utf-8?B?STR6dEpJV3lTRzZXU0hOc2JGV2UyNVNGSDdiVk05djlaT0R5N0N0a3k0YzZ2?=
 =?utf-8?B?Y3BxU1ZSdzVpa1V5aDJXM0VpR2ozWjB1V08vWjFxQmRXOWphZTFEaCtndnFP?=
 =?utf-8?B?OGt1aUFPc1IvYkh3aE9vS2tlVUEwKzdyZVVRNHNQNVFKN1lzc2xxUmVNZUo4?=
 =?utf-8?B?Q3dRTmE4VmdQeEpCNm9jSjRpZTZJdjFiRWFSU3p4THhOWTVIWWh1RmdPbGlM?=
 =?utf-8?B?NGZ0dGV4THJ0bEZraFlJTUtJYktYNGFBMGpwTzFCbTc5aG5tc2xDM1R5alQ3?=
 =?utf-8?B?ZFBzNWhFL0pJam5adkhJTkk3RHFpZ1hlQlk5T3Z2d2ppejdWT21FMjVza25P?=
 =?utf-8?B?TTkzVUZxOWNsVDRCYmVoaE1EMUpJSWUyNVJlWnlOcm02UTZtZVRLS1RQOXUw?=
 =?utf-8?B?U1ozMkJ3NCtLYnZzSGoxRlRnQmRoL3pMMXZvYTU1dmxVdFAwOCtzMlV6TFly?=
 =?utf-8?B?ZWd1VXlCeFJZN0dYMVIwK1VVZXVpQVEwOXJQVlg2L01HbUJuaHVXV2g2Wk9r?=
 =?utf-8?B?WW16c0lBcUl3VnZCeU1YbGZrR3pTamVRMnR6cW1DY2pBRjdUczV6V2pSaWY4?=
 =?utf-8?B?dktLdW5rRUJVTnZHSE8rRi9yWU1pOG03ZkoyTStPZFluWm1tSklsYlFhSG1k?=
 =?utf-8?B?L1NNWE1NaU11QjMxYVkzUGlmdHVYSjg4Z3lKd29ub01pTEJwMGc1OXcxU2l3?=
 =?utf-8?B?UU9jaUF4MTdKZSs5U0hXc2hGSCtqTkNOak5kank3VzNBOWdqOXppVURodkJl?=
 =?utf-8?B?aGp0TnFhL3pNK1d4RUZyc0NBZFpXNUN5L2Rtd0NNdHYwNlR3b244K1lDc0Ux?=
 =?utf-8?B?NlFJY1QzYktCWXNIb2tBcU42OSt1aGVBb2VUc2tEK3lYUjlud1NJVHg4MlJK?=
 =?utf-8?B?ZGswQzRmUHVKS2gvZzBGUm1jWEQzdk52YUhMTU9COVZDN1pUQ3FVSjVMcUFE?=
 =?utf-8?B?TXRTKzJMMDhwSDAwZjlhTmR5YXBENlpYMUdqdnZIa0JSVHptSTMwYk9RSWhC?=
 =?utf-8?B?aEw4cThrM1ZhS3Q0S2J3NFpFU082UGthLzJ0MmpnbHg3UzdqK3hoeHJuYmth?=
 =?utf-8?B?dFU4ZjlMZ3JFdStkN09kRlN4UXNzK3pReTNnS0tkZXlJaUQ0L0V3TEZnTW9D?=
 =?utf-8?B?aWg2bUN0VUJZSzQ1SFRvR2x4T25oR3VWQmJRYjFYVDF4c3pBdng2S1Z5ZUJD?=
 =?utf-8?B?djhVM3gwUDlXSDBkS1ZkM2s2SmVJTnZiaDJTV0gydG90SzFsU2JQRHBKdFVD?=
 =?utf-8?B?TENKN2taMDBGVEhNVkZ2Szl4OUNKQnhUQVQvbWRHNU5iRkJKeDRkOG5CS1B4?=
 =?utf-8?B?VWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11729ecf-1d19-4107-f6c1-08db7df6db26
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 07:58:59.6415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wHFufsJb1Gj1cltAoeoSbSkqt2BoIkDH81JhTlBIGDQ6qVyRrzkLyDymu+K2g+pbzWJLX9fLQ8RcDlg/VD49Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB8261
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Jul 2023 07:59:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12253

On 06.07.23 09:55, Sari, Sercan (ADV D EU TR C&E) wrote:
> Fixed typo for the function name open_tpm2_partition, in encrypt_partition.clevis.script and encrypt_partition.systemd.script.
> 
> Signed-off-by: Sercan Sari <sari.sercan@siemens.com>
> ---
>  .../initramfs-crypt-hook/files/encrypt_partition.clevis.script  | 2 +-
>  .../initramfs-crypt-hook/files/encrypt_partition.systemd.script | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
> index bcb5a04..5d7124d 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
> @@ -120,7 +120,7 @@ for partition_set in $partition_sets; do
>  			/usr/sbin/cryptsetup luksFormat --batch-mode \
>  				 --type luks2 "$partition" < "$tmp_key"
>  			enroll_tpm2_token "$part_device" "$tmp_key"
> -			open_tpm2_partition_tpm2_partition "$part_device"
> +			open_tpm2_partition "$part_device"
>  			eval "${create_file_system_cmd} ${decrypted_part}"
>  		;;
>  		*)
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
> index 927184c..75e3272 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
> @@ -126,7 +126,7 @@ for partition_set in $partition_sets; do
>  			/usr/sbin/cryptsetup luksFormat --batch-mode \
>  				 --type luks2 "$partition" < "$tmp_key"
>  			enroll_tpm2_token "$partition" "$tmp_key"
> -			open_tpm2_partition_tpm2_partition "$partition"
> +			open_tpm2_partition "$partition"
>  			eval "${create_file_system_cmd} ${decrypted_part}"
>  		;;
>  		*)

Thanks applied.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux



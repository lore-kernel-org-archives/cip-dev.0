Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 680A6CD37B0
	for <webhook@archiver.kernel.org>; Mon, 18 Sep 2023 07:42:12 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.50])
 by mx.groups.io with SMTP id smtpd.web10.46357.1695022922692606123
 for <cip-dev@lists.cip-project.org>;
 Mon, 18 Sep 2023 00:42:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=iLuoKKof;
 spf=pass (domain: siemens.com, ip: 40.107.247.50, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TC//1iGO9+YerayJuX1IVItaJLL4IIoZzs497AyY2mA5DMEVoy2EwwcgyPzJXoOXQ7Fd7LLO4yYqMfJp4Ts8iSZ9QZ2VIuwf02UiBf9IzTVsZEa69XjR9BpswykyO4yzDohaj+4Ii8uZJvU3V875dyoDjEA6wp4mGcQGUmPiU5fRxMCYZ+mVYiSy2G1V4ZIdsNbo6HCP7nfL6XmikJCochewLhPPt6m34EJen0r5ELBUZdoE2oJ/9pyf+4NDrUouvka5tU6lS3AvUe4L+JA4f2/8kwZLvLsyPULLNip88xDk/3dAMJElL1hyCKoyvg3jM/mW8ib0A5AYHp0/aBxrZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tpwpmYUJ6r4eHDU07ZgVa9x3QNH4ztjeaPJTUdsyPFU=;
 b=ZICzkN9v9Uf5em0GdpBmg6yvPBNi7FlXYfXM0tdDTJYxqU9y/Rf1KpUDovGU4C/8bAghpsWA7bbAZ4GsmDjHvjtDcFNMGVs2Pakc3+yT1M8h/KggyP0fyVc6WoxEqEOBHIVLIZfD3SFM8rX6FGXC5UPTiCeYQhVcPdZd/Xul9i/m742+dAp/ZwFQ5x1XmGcNNaJnQ0/5/pFBLGD8xU36B/IEOfK/PEFFZqwRMP0x7TPE/6Lnc/x7VjbPRbogQV6PF25ylkDZQntBAB6+QXrBv5Hw8gNIK6vmM+JyQXz0nRVtlCkdhJHzpyw0rC8TRsU3hFp2gQCleCmxUwj0AyjS3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tpwpmYUJ6r4eHDU07ZgVa9x3QNH4ztjeaPJTUdsyPFU=;
 b=iLuoKKof1x5KxOPakpcZ+/uvMb5mRHl7WPzkk3MhBAvl99BDsnHMV+miQMxAuWL1OfkO2+w2+3c5V5lK4Y4gx0gtj0yla8OGlyeqEVRB3Pd/xoMSIwxJ9ynZNXICOW7Q8fB9A5kDdk0BroTWFN+qKLaHGVqxG1AERUC+xrYzzrFTq22Emn4bZwd+O6e00B41PgWMjgT6QBE9pKTPHVYTpJVyULigy1LK8KbkbnwTYGqvlPAAEChEniWahINT8QKfoMQ7b1LSf46ZdANn3xGZ1ILSjhL3tVy5LgF6+zbKxGcKz1UU0BFM8NxednDCLcC8Z+tgWAdxj/JBEABxdjJ2vQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB8031.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3d5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.24; Mon, 18 Sep
 2023 07:41:59 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6792.021; Mon, 18 Sep 2023
 07:41:59 +0000
Message-ID: <ac53654c-c18d-43f7-a052-419e074b06aa@siemens.com>
Date: Mon, 18 Sep 2023 09:41:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][RFC v2] classes/verity: Set salt and
 uuid for reproducible builds
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, felix.moessbauer@siemens.com,
 adriaan.schmidt@siemens.com, venkata <venkata.pyla@toshiba-tsip.com>
References: <7fce798e-8ac1-40f4-83c6-4fc4ccb9b304@siemens.com>
 <20230915073426.1558460-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230915073426.1558460-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0031.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB8031:EE_
X-MS-Office365-Filtering-Correlation-Id: 162adc61-dddc-4937-eaa0-08dbb81abd52
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	YlTZWDwKkAxOFu8G8m1jxaq4l1yJ34DJNnlI2w+QGPhUCTt9RYi5w5Y7AXDIjqyo6+P/D5XvEUImc3AfxbMQ1DRpZodD7XT/IM3JvA6FhfBXU+yy2m0SW6JQNmVgYFzv2Ni60ciRw/yN6LQGZJOymqKZiOjjRVwrTTpR/4vAiW1KCIQImuLwWjDaSvoMPdeRG/pdKyLsmGveRs8hCYgkuI0Eo0QNvxN5A5vxd+iittJ2iH0WP577YHQRWMWbrEcQh6pfIg2W7ktvLzdzvLqyZkxP1dBKwJ/zfk/iuNaCpr2Esvh33EHGcFA+3wUUBsnBkp6ocgTpL5Rb0cevu5gezu1vRR9cZjVGXKEAu4K3agQiT6gcfYvDojTnLhOXdTvrGr/hUwFeXHpjV4wydGxgc6Xmk+2IzyTQG8g6rqk6HOkz4cnIlaB0N5UvXC8dGSomDBKNY1idkWzm+/SHRZEmGt+Jhqe1o/JUx6PiMWeM5s3auJdSySxqR0lPNv2d3dxOA3VijgbMlB9jIsxhldURsdvcKeOt6d3qS3T8QT5l/Ei0lLQ7GybUIpvK+0A1hAgrJChSrOFJ/34DJJwgrdbrQK1BIGJQdMoLPQF8xDYA0fgCHTnfdT1tbPWPhIXXUcp7EIaqCFScTP89ygCfH4nYGRVbW5bDFLFB5ihAqtBGpnI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(346002)(136003)(39860400002)(451199024)(1800799009)(186009)(66556008)(36756003)(31686004)(26005)(2616005)(38100700002)(2906002)(82960400001)(44832011)(5660300002)(86362001)(31696002)(8676002)(8936002)(316002)(41300700001)(66946007)(66476007)(478600001)(6666004)(83380400001)(110136005)(966005)(53546011)(6486002)(6506007)(6512007)(403724002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MUxLZjRpNjFnMXJJWUlQQ3NkbDA0TEdUUGFwcHpPWHByZkVvaDZrbUIxQU9t?=
 =?utf-8?B?L3NoYmdRdjNzTWpRZzRYYjdNeVNOa1h3cVJlYXVvaGVQaGx0bEtod2NnaFN6?=
 =?utf-8?B?T0FneEdrZDhRSUZoc25aSHFUNHVKMTFIdmhyL0hCTXYwblJvRG5GclFpbWFI?=
 =?utf-8?B?aVlJTVIrcDNmK1l0UDlsUExxZTVBNWw1TkJuYThFRnRFeTQyejJ6WnpFSzgv?=
 =?utf-8?B?UWhZRC8wV2JQN2hZVGtnenFXZU5DZEVIVUpzVDdzalZPMFZ4Qk82SGdKL0Vs?=
 =?utf-8?B?QlVQWlFhQlVISkVUdEM1U2VXL1hZb1lHVjJkRnFWWmR3TGI0MVNqSy8wT3BT?=
 =?utf-8?B?MDRhUzZrT0RYVFNGd0lQeWppQ2pJd0VRazlYTUhOV2hyN1FreU8ySGdtcFpi?=
 =?utf-8?B?andlcFlZQkNKSFpIczVWdWxCUnFhNTZHV1JZb2pVZlM0S3lDS281c3huRHNy?=
 =?utf-8?B?NDhvU3pnQ240bE80R2dwZmx5dEp0Zk40UCtUMFI3akpWdnhaRVJ4a2xJRVFt?=
 =?utf-8?B?YU9RQ2tqTkxqWnhqNG5zT2xzdlFlZGU1V3lQOTBtMGNyNzFCV0d0RkljcUh5?=
 =?utf-8?B?b08zN201THFUUGJVQ2JOK2NodUNrcU1ZTmYydFppS3hvbzdkRjA3dWNsZS9J?=
 =?utf-8?B?anEvWkJScmd2dEl6TWNIaEZpUlVsalEyTUw0dkhORGlVRCt2T3pJTUM5MjQw?=
 =?utf-8?B?VTVyYnZmdE9WMlBtcWZmZ2FQS2VTT1NnNHFWbVJOQlUvNkwyNU9Cb0cvd3Ez?=
 =?utf-8?B?QWpQWTI4SzBlTVBtdFl2UXN6QkNpVFhBVVI1cHhRZWxHZDlvZnNEcDU3ekpz?=
 =?utf-8?B?SE9MNEJodmN0RHRTNGRGbjhzL2ZwdDArSjZlcEU2akpBYWw4UGxsa0VNelh4?=
 =?utf-8?B?SUkrTHZuTjRyZ0N6TEVjV3NkVDJJZEVPS0RYdjIxcGxobDNzSm12UDhHTEhs?=
 =?utf-8?B?bVBub2lMZ05yQkRTREdyZnRIUnZsWWRueVRBV0FRWmZ6SDNQSndKQ1VzVWVi?=
 =?utf-8?B?UC9qazlVbmpVNUtsN01ENnI5dWErZDU5VURoR2c0MFg4SG12UC9IYlQ0Rkg3?=
 =?utf-8?B?eVRmYVQxZWRxY2FvQTN3QTlwaW1GRlVpU3YyY3VyYzZhS2gyWEpGajM0M0Uw?=
 =?utf-8?B?R2NMbDdtbEp5VytCdU5NWGlWdUFNZmdrWWJtUDBjL3Bla2RScm4zT3lkSkkz?=
 =?utf-8?B?LzZMWTJ6WEFVMy9HRTI0YmpTZ2d4M2ZCckN2Y2t6RjEzV25JVXpoS2FXdUpS?=
 =?utf-8?B?cE1Ha096T2Fvak5XdVYreUlEUmVxcm1UYkRxSkczV0pRbWVmcVFTOW0yWjNi?=
 =?utf-8?B?SEdSbk0zS1BhdkpJUVVIQUlQTDlTbXpiUUhrODNJYW9yVDB0Z1c3VVpFdXNw?=
 =?utf-8?B?ZUlsa1JOOEkvMlFlTXNhaXVyRzh3ZFlVNjMyM3RxaCtORXRPOFdBMlRpV3Uz?=
 =?utf-8?B?RHY2bTk3eWZreHV0eWxNazBqVnE2K0ZONVJaanJ2aXh6eE0za3ZLUk5KOElW?=
 =?utf-8?B?NU9vVVQ2MVlvM2NvUU43V0VFZXovOXd0V0V2cVlkOHZEWmt2Z21oOTQzYTg1?=
 =?utf-8?B?VEIxWFJ3OGpyVFZLR0RFMXVJV0sza1lNYUJyODJtQjNCNDlHTlVZVG41bFNh?=
 =?utf-8?B?eEY3SVNqWDU5YUREazF0NmRvY2M0Rnh3eEg1Tm5qb2JFb2cvYmF4UVhDdEF0?=
 =?utf-8?B?MExrM3F5MU14QWpIa1J1SE9JQ0hFOERiR0JDUHAzWDJYVHhGUWI0TDcrYUZu?=
 =?utf-8?B?dkpKcU9RMVRHWlBGYnFIU252cWluWUZwZlk5NVNiSGwvUERPVi9SYTNBWGlW?=
 =?utf-8?B?c1ZTNnVGWllJNVNOVkFKL3h3VTUzOWxKQU45OFBURUpqbHlPVTZKZ2I1Qzlh?=
 =?utf-8?B?T3lFZ3hPNHFQcEdPZVduVnc5YjNXejZnK1V3QzBVTkNTUzZ0dGg4UVByTHhI?=
 =?utf-8?B?cXR1Q2FWNjIxQ0cwZ1pCNHVWa3pDTStFTWNCeDc2UUdWeDBpTEF2eGdUUitm?=
 =?utf-8?B?WDJhOXd5OS8zYzVvVEl6by9HMHczWFFlOWVOTmlqbUJFWTFmc0hoVmR6R2JK?=
 =?utf-8?B?VjlPMmtWdkN1RkZoK2xLc0IvcWIyK0dQZVY0czJGS050dWIyRVFPcnJjVS83?=
 =?utf-8?Q?OVTfdLItX3drkXp+J30F3ODIR?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 162adc61-dddc-4937-eaa0-08dbb81abd52
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 07:41:58.9659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IU29NSHPsq+afJ9DvGHc7Mt30SI8+Ftq/Jioxh7j8jQhFnLcvukYXcpQ3bdMPTFsXMbjp5kSAM9W1k9dK6ZXVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB8031
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 18 Sep 2023 07:42:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13139

On 15.09.23 09:34, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Currently veritysetup generates a random salt and uuid for the
> verity file system. This leads to a changed root hash which makes
> the verity image no longer reproducible and bootable.
> 
> This also fixes together with the option `kas/opt/reproducible.yml`
> the issue that after a sstate build the image can no longer be
> booted.
> 
> This introduces the following variables:
>  - VERITY_IMAGE_SALT: set the verity salt the value of variable. If
>    VERITY_IMAGE_SALT is not set the salt is derived from IMAGE_UUID
>  - VERITY_IMAGE_UUID: set the verity UUID to the value of the variable.
>    If VERITY_IMAGE_UUID is not set the UUID is set to the IMAGE_UUID
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
> Can we set the option in `kas/opt/reproducible.yml` as default or are
> there still issues open?

Venkata, even if there are other issues, I think the rootfs should be
fine already, thus also a dm-verity version of its squashfs, no? Then we
should set static salt and UUID, I would say.

> 
> This patch superseeds `[cip-dev][isar-cip-core][PATCH] initramfs-verity-hook:
> Ensure sync on rebuild`[1].
> 
> [1]: https://lore.kernel.org/all/595d5791-a08d-f08f-5dee-6f9ed5d472e0@siemens.com/T/
> 
>  classes/verity.bbclass | 37 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 36 insertions(+), 1 deletion(-)
> 
> diff --git a/classes/verity.bbclass b/classes/verity.bbclass
> index 747a7ae..bacf592 100644
> --- a/classes/verity.bbclass
> +++ b/classes/verity.bbclass
> @@ -19,6 +19,37 @@ VERITY_IMAGE_METADATA = "${VERITY_OUTPUT_IMAGE}.metadata"
>  VERITY_HASH_BLOCK_SIZE ?= "1024"
>  VERITY_DATA_BLOCK_SIZE ?= "1024"
>  
> +# Set the salt used to generate a verity image to a fixed value
> +# if not set it is derived from TARGET_IMAGE_UUID
> +VERITY_IMAGE_SALT ?= ""
> +
> +# Set the UUID used to generate a verity image to a fixed value
> +# if not set it is set to TARGET_IMAGE_UUID
> +VERITY_IMAGE_UUID ?= ""
> +
> +python derive_verity_salt_and_uuid() {
> +    import hashlib
> +
> +    verity_salt = d.getVar("VERITY_IMAGE_SALT")
> +    verity_uuid = d.getVar("VERITY_IMAGE_UUID")
> +    target_uuid = d.getVar("TARGET_IMAGE_UUID")
> +
> +    if not verity_salt:
> +        if target_uuid:
> +            verity_salt = hashlib.sha256(target_uuid.encode()).hexdigest()
> +        else:
> +            bb.error("TARGET_IMAGE_UUID and VERITY_IMAGE_SALT are empty. Could not set VERITY_SALT.")
> +
> +    if not verity_uuid:
> +        if target_uuid:
> +            verity_uuid = target_uuid
> +        else:
> +            bb.error("TARGET_IMAGE_UUID and VERITY_IMAGE_UUID are empty. Could not set VERITY_UUID.")
> +
> +    d.setVar("VERITY_IMAGE_SALT_OPTION", "--salt=" + str(verity_salt))
> +    d.setVar("VERITY_IMAGE_UUID_OPTION", "--uuid=" + str(verity_uuid))
> +}
> +
>  create_verity_env_file() {
>  
>      local ENV="${DEPLOY_DIR_IMAGE}/${IMAGE_FULLNAME}.verity.env"
> @@ -49,8 +80,9 @@ python calculate_verity_data_blocks() {
>      d.setVar("VERITY_DATA_BLOCKS", str(size // data_block_size))
>  }
>  
> +do_image_verity[vardeps] += "VERITY_IMAGE_UUID VERITY_IMAGE_SALT"
>  do_image_verity[cleandirs] = "${WORKDIR}/verity"
> -do_image_verity[prefuncs] = "calculate_verity_data_blocks"
> +do_image_verity[prefuncs] = "calculate_verity_data_blocks derive_verity_salt_and_uuid"
>  IMAGE_CMD:verity() {
>      rm -f ${DEPLOY_DIR_IMAGE}/${VERITY_OUTPUT_IMAGE}
>      rm -f ${WORKDIR}/${VERITY_IMAGE_METADATA}
> @@ -62,6 +94,8 @@ IMAGE_CMD:verity() {
>          --data-block-size "${VERITY_DATA_BLOCK_SIZE}"  \
>          --data-blocks "${VERITY_DATA_BLOCKS}" \
>          --hash-offset "${VERITY_INPUT_IMAGE_SIZE}" \
> +        "${VERITY_IMAGE_SALT_OPTION}" \
> +        "${VERITY_IMAGE_UUID_OPTION}" \
>          "${PP_DEPLOY}/${VERITY_OUTPUT_IMAGE}" \
>          "${PP_DEPLOY}/${VERITY_OUTPUT_IMAGE}" \
>          >"${WORKDIR}/${VERITY_IMAGE_METADATA}"
> @@ -70,3 +104,4 @@ IMAGE_CMD:verity() {
>          >>"${WORKDIR}/${VERITY_IMAGE_METADATA}"
>      create_verity_env_file
>  }
> +addtask do_image_verity after do_generate_image_uuid

Looks good to me. Anyone any other comments on this?

Jan

-- 
Siemens AG, Technology
Linux Expert Center



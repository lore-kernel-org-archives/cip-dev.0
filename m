Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D195CD54AF
	for <webhook@archiver.kernel.org>; Tue, 19 Sep 2023 10:13:51 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.81])
 by mx.groups.io with SMTP id smtpd.web10.4949.1695118420328038623
 for <cip-dev@lists.cip-project.org>;
 Tue, 19 Sep 2023 03:13:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=iCNUPriK;
 spf=pass (domain: siemens.com, ip: 40.107.8.81, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mTd2KGxFjPYrF3wDlzu3GyhTqBlUA19aap7GdA7gYu4VfFL5lOfFkBFLkAizO6GeVUBxx3XnhdyaIHz6o7ddBAb/wdGlQa4CmhucrSQlTDKbUnV97/kPKJqD9JWaI5FoGMnaZDgRgsNV9iU0WM6T8wK+TTvWdp90dBBsGukgks+cDB1Tky2AdSU1atytJFfgxptiqdCxp5RGSaSndvmxEIeu+i7/gdoEede3r5t5b1dmcAjxtgX0H4iQz3KKOL6MeOhPfk59qDInRSlwR9OZDv1U0Tbb6vbO4RUBJqeItPu9ExBbLRbk7nM2q+rge6bS/X23J4OvUOsqWbfPmmGLVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T8FrCAmpfP8CMiS1zvCWBAA7elvkiWwxSknJpoxw7S4=;
 b=VXQ6tfHxYkf6Hdo4lD4UOu/XA8ICLk4nWCqhiU5Uv7R6EVxPfxTHCDg/BAyWlRxulgTmauNwP9WrreV5/sWx9nZJk9mJo1rX+NYYloBR5c7I4hZXh2CSUaqs/vxaVIbnsV/cEDT7YZZZa8JM/A2R4bdFThEIFKYPNQprTfJ5+KL8qCO8f5KlyfkSEFoe7zJQt7RJsQIzw28XIlce7pKJ5PJbGaCEA8Iib/caz0QaEUyL78wn7vgE5Tzomep62SU7PIom9pdmkQLTxKC1Ep1ifYwL1jLGQdhzde8SCQPdOFPPZNK8yiymrGm50lHa+dP29ajF8vPzBEjrdPX+3ko07Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T8FrCAmpfP8CMiS1zvCWBAA7elvkiWwxSknJpoxw7S4=;
 b=iCNUPriKzXpQHOCPLXTfRmlYLIrdUrvhWqoxoWTXJJBO9PHpzX9Ks4Eq3dL4JzRI7RR+a3v822AeJctMaX66ELHWUiZeQ6/4vIUvebako6/Fuv9bQsDhKvSFfCA+IOn7qnpYHOZ6VA5FAMjZ486NnB7PvVPJfTvBzhAE2uMnokJkvuTuyTo6zaaFnw94VD4uxpXroE1NndAchgsRVU7tnHA4xnT2wAYHEFkXywpldVdI4yKTP0mrkOResLq/6fAH/iHGAZUIgCwAgEmQmz5m67v8Z4oDeCqltpYHGZ5hiLoSfyrvzTjXyFmf4KRdq87/QcEMcxI9b+68/JZbYhCooQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB8210.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:386::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Tue, 19 Sep
 2023 10:13:36 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6792.021; Tue, 19 Sep 2023
 10:13:36 +0000
Message-ID: <a3513b6c-2c1b-4c5a-b02e-e3eceeaee53d@siemens.com>
Date: Tue, 19 Sep 2023 12:13:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][RFC v2] classes/verity: Set salt and
 uuid for reproducible builds
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, felix.moessbauer@siemens.com,
 adriaan.schmidt@siemens.com
References: <7fce798e-8ac1-40f4-83c6-4fc4ccb9b304@siemens.com>
 <20230915073426.1558460-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230915073426.1558460-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0009.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::19)
 To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB8210:EE_
X-MS-Office365-Filtering-Correlation-Id: 9715b74d-b04c-4779-ef61-08dbb8f91636
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	gfuYErpT5uzwWNN27FqTlyrq4HL09sd3K86D9QCrr85GSf7oZHDKf+uRJ3YAPkPkyqVfsyBVh9za/1+ooy3HiC5oBQawpUEEjPpmQtyq/FAQrzEEYtArxaDVvcJFPpGkttoO6sYl99mhruCGIwtdpf645iScb82luRlX7HoA5D92muNbY3V8a3btADiD98PAIEJta2sbXKMmcabuhU9yJNDPXQ+oLhJ/FJU8hOd/JI2VV/EZHwZkP3aAyrT3KitXPnY/YU2Oqz2w5ImvMJ2ZcOeIwevJ5Rty/tPm+PmFxr8ovPj2G9m6YFemtxIsvi/JGOTBeRTtie9ZQnxZu4YVxl9+/oeEfrgT5HcvwpBKaHItJs3LCOIFh0Dt7bXRdWNKxAT8yeeQZm50gG7811kEzAqYEsqcrKJdJKTLOUHCpDa1aIVhJy0NqotrISFRNCNWYj5L1c0Sx3uAzqtDMpaMBdFPFOl4lmzWlYjiNx9CJrcN3Rwe2vFpt0erEL90cGUBw9+17V3c1GcFRXpdmw9FCE3P4cgynxOxn9E6PLz2DFsYxLlsFERf4glZ++IRbcQfNRpgIEJh503PdVry5zOx7DMN6Zey7CINe9WnV+i4AWot2vjJa/SbZceKpyoWLc3/RsBCeZQ7WFOR6BTGdnHk67snCl8HoJqxG3oS7jKgmOU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39860400002)(346002)(376002)(396003)(451199024)(186009)(1800799009)(41300700001)(31686004)(8676002)(8936002)(2616005)(82960400001)(38100700002)(66946007)(66556008)(66476007)(6636002)(316002)(6512007)(966005)(83380400001)(478600001)(44832011)(5660300002)(26005)(53546011)(6486002)(6506007)(2906002)(86362001)(31696002)(36756003)(403724002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UW1hNGVKUitVRTIzSjdBTGQzeDBodDk3ZFhJcVpibzFhY3ZpekFWZTNORWIv?=
 =?utf-8?B?L2xGdUFOd0JLTDZIZGV6T0tpL1MyYzdLSHl6SDcvc3RaS3hFdTR6aS9sQnRk?=
 =?utf-8?B?c09FaDVrWld4bTNVZitnVDlGQ25mLzZIR1RDS0FFcVBGK2t0QlEvU2RCRlVC?=
 =?utf-8?B?NWxzN0ZrV1FwNGZKQi9Dd25rUnFvczlZKzV0ZWk0d3hjOHh4UEtSbW1MZTN2?=
 =?utf-8?B?U1hPdU1FeFhoTXQveWpQU1hJV0V0bW9JUDlnTXJjQkIyQXpiVGxOOGtSSlNG?=
 =?utf-8?B?ZEV5bmJtMmI3ZFdBQkVET2c1L3FNVnoyMEVwUUNEYlpxajl4Wk9Ja1BNR29Z?=
 =?utf-8?B?eTRVcHpHZ1N1KzhWR2hmQkVsTXNBN1MvZHdmL1NXakJaVysvOFNheFdiS0lt?=
 =?utf-8?B?VEc4ZlZFQ2JJWVVOekRwenlWSWZnaHhVbUhnOXNpMDcxb0M3djRDNTBFbXly?=
 =?utf-8?B?ZlJwVW1tSjhVOWJpY0c1TUZGdGdZT045dFJ2STJJMXFEVWxkVFdadXpOTmZn?=
 =?utf-8?B?bkcxcTFCNDI0UXNhWnlVZnZONk1rckRpYjRHU2VnR2FYdklmdmxRdnJoWGtI?=
 =?utf-8?B?UDBqMnhaa0FSelB2M3paTjlta2NlZVRaSmJjeGtyK1JJWW9JQlRSbmNxaVlq?=
 =?utf-8?B?czJPUnpNVUJIVFZzQVB4MVAwQjBFeHVJcEc2bVJoTDFwVGdaRmhkWEIyODVN?=
 =?utf-8?B?NFpGcXkwVVpTczN3ckhyY05DbkQyTkttUFY1K2hhMjNQd0s3bkRkNkYwTFlW?=
 =?utf-8?B?UTY4NUVjRjJrY3kvanVKQ21wVHBHWXJ4MmRNVkgrY2QvNG5XbHFwaGY0OXRE?=
 =?utf-8?B?TkRuVCtwZXFHbWlPOVhNem8xL2UwUndSTFBtckV4WXoyaDZ1bEwrN1Q2Y0tz?=
 =?utf-8?B?KzRwZDJKOWRRUDhpWmNhdGwzTkZlRWd2bU5aQnZ2ZHRMbDY2OEUzSU9FakFq?=
 =?utf-8?B?Z25CdzluRWdDZ3FNNWZpK3p0QVYwVnk4dDlGc3puUkQzVzVtamcrUEVRcVFD?=
 =?utf-8?B?dXNwUkZkcTJxSXl5bE0xdXhqQXljTWR1QmFSVjFlUXpuLzE5RkNnR0VhZ2VZ?=
 =?utf-8?B?L1VCWVl3Z3NIVWFvNHZOOERoZXB3S0FxU0FlTDBZVndpeVhydktyZUlWTTFU?=
 =?utf-8?B?VjIvOHBXZUdzVlYydk8wYy9aQ2F0RWk5V1pkL0d5Ky8yT0EwV1h2ckt2blQr?=
 =?utf-8?B?bHdYRzdVK3FhTS8xUDZmVTJ4WEUrOURpeUdabXZ1ZEhhNmtQQURtdmJVb3Yy?=
 =?utf-8?B?eE0zOWd6VlAzNmhSbXROOEhoUFhjUUpzZmtycFAvQTRSdlpiSGNRZDVaV1hq?=
 =?utf-8?B?ajlncmZvRVc2dzFUdXREa2hvUmI5NTF2cGZLM1NqS3h4VGZQVnIwelZkdUJj?=
 =?utf-8?B?Z3Jnb0t3Mm5NRGJhQk9sVE43eUdQSTd0WGU4WDVkb3JBb2lhbGtzUDdhOTF0?=
 =?utf-8?B?eHU0U0czd2xTaWdqeVZOZ1oyS3BMSk5nSytMWm0ySnA1TmoyMVpJcUtGTkpl?=
 =?utf-8?B?RmdITURWcWlGSW1idXpQTHViR2sveDJzU1czRzg0NllGTnRhRitrejFWVmFj?=
 =?utf-8?B?QlIxT2NuU2M2WFBEd0JoRHp6ZHh5ZHN3NzNjSnJ6TnQxZzRHT1Zwem1jMGx5?=
 =?utf-8?B?Vm9uT21NWnRpaE4za1k4SlR6U0JQOHAxRUhUdjdtZU9CUzlwQnV6ZkxuOHNF?=
 =?utf-8?B?TFoxRTIvMFlRajM1ZzI2RkRoYlZnOTJCdUdwQ1JvTkJZalRqQU5MSjk1bU5T?=
 =?utf-8?B?SllWNWVPaXZUOFYwTDRIY01oK2tHTkQ2UnYxMHZubVFKR1djN1Z1M2VXcE51?=
 =?utf-8?B?T1owbzN6M01ZT083QTY4SmI4SlBZWnB6U0RlNUhGTTJLWmZOa2ZXVVpQdXp4?=
 =?utf-8?B?dFUyNW45R2hXcmoxNE8rMmphSkZVbWdteUJXU0ZnVzhseHdtbUZmVG05RE5J?=
 =?utf-8?B?UUl3T05FTndxdTI1RU1zdUY1MGVTMjlXZU5lWWxLOFQxazNJTUdNNTVCMUFM?=
 =?utf-8?B?VXRUTGhEWFBaV1Y5T1gxQVo5VlYrY0Q5ZGlNSlZjdk03RmVvYUwxMGVmZDdS?=
 =?utf-8?B?RmFkUkFCSThwMC9HRTc2eGdFZmo0T3FoblZ4K2VWUVI2d2J3Q2ZQWDV3OUdD?=
 =?utf-8?B?Q1lkaVJZa0luQTllcGllOGdRMzh4UGpKMXB4VTB4YS9mQUNNeXZLK0JZNDlP?=
 =?utf-8?B?NGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9715b74d-b04c-4779-ef61-08dbb8f91636
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 10:13:36.3751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ZYeKB5I8zPYbYFplGR7wIHPJhr00IkODgrkRTmec34cA3qo1DsagLfiBzUlhjBmFIYlSSrq5AP8IHKChBo6yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB8210
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 19 Sep 2023 10:13:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13142

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

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Linux Expert Center



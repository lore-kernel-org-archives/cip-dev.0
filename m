Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB8FC54798
	for <webhook@archiver.kernel.org>; Tue,  5 Mar 2024 13:51:04 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.57])
 by mx.groups.io with SMTP id smtpd.web10.22983.1709646657864013073
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Mar 2024 05:50:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ogmbL6FA;
 spf=pass (domain: siemens.com, ip: 40.107.105.57, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B2UmiJSmFCVZpMsrnQmVfwvytiOYYHqBJxl456VxgWPVhaXbpVQlBJvYQvyBpEoSmvDo9ee6ifAH488q8vxRFaVVH9UbEWrBVN1wCgr9GQJEDnL29al9Vt4WAyaEXvzKyiP7KqhQbI3TXwYwVfFbAX2ajhgsiitKn7GQhqYBXSzHOlg6Oa8RY60pk5FfUGSK6r8UFtYDPOgCso1RIJTh6KjUlH52si1wBU6cdsCcufnpZZnsFiN6TpQPHTjHOXzKXc5vjTzNKPvRB6dA1dWgf5kahQVPQhu9NqkGWx8PGsTgLC6bs5egNkw1HwceB3Um+Mm3JR7APFC+8g5OX62gXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aWYag3nNbmdeDpelsGkZZ8WyuCtHs2PMHAbscPqLAio=;
 b=EDkokSowROBqpVFlt4dtfAHNEHATQm1rP/67pgGBRuuIrooKZ9LbU1pRXHR1MRBWmOQZhKARCjaz+wq6fM6AyxS88+xo0ckjwLkG3NSR7gyzuzpHUcF/IX6D4anUtDTgZFiJShRQ0z2/FOWLGmvxHuLvUZJsYqrOdCRK/AvMnsI4RemOMmCu/WRBBttOS3MMx7qyIOdUGNyuzMJdr0Fy5FReiWVg4Rr7A3NqgIeofGUbrNkt8/DiEXbpap/PjEXsdYugyMgAiAwKfyICWXETjbs2VXxJhrhMUtOJWWB4JCQgbby49eBXoks2zQSeE0A2HMBCDBfLpDPjPndY8aYVWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aWYag3nNbmdeDpelsGkZZ8WyuCtHs2PMHAbscPqLAio=;
 b=ogmbL6FAq7RRw+pVeLKCo9fnpFZXxt6z1n1/z8S/ZfMzGnUdiyjvX6y+KcEh8ImYZr/b63HpkaGlYdI7CZKCkC9A+p5fIbrTerjA+kioiO9nybSswQooKuEKXo2xeIILdZVCfYsb3QI9+wTmq0goPFrwz/Q/IuBweCIrbzY3JT5wwZ+GPkgSFF9y0opNfQLENKqQVg6JxEbI8bbUCm8WsqI/azXo9QN8Ly7ysdPjUv9FfNWoPWGE/mRYEwRT0qnTqJ8AJwMXBtpqhBIeuXr34UV/sE/WD6zda9OuzaFz1t3GpMWLbvs0C7P9LIRDep4BgyT5/0E7SNUcx7+177GsIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6275.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3ee::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Tue, 5 Mar
 2024 13:50:54 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 13:50:54 +0000
Message-ID: <9b294320-d609-4b93-9675-627d26f69b46@siemens.com>
Date: Tue, 5 Mar 2024 14:50:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 1/4] swupdate: check output of
 sign-swu
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, felix.moessbauer@siemens.com
References: <20240305110311.2073425-1-Quirin.Gylstorff@siemens.com>
 <20240305110311.2073425-2-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240305110311.2073425-2-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0178.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6275:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bc4346f-f70f-4bb0-d8b3-08dc3d1b46a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ijeWe3d1UpQuyL2tjG4HVVtdaMsZU138PSVIqOch0sgnBlucrAO11pCtpoYIeJwAztXqW8zfbwwYmgqSMGwWceKLXSymXO3hxtbHMd/T8CHijlO24rh72jeJCHXWTZ4ZEpCN/GR8qgtgL0vDVKwwsjt/VmshKIdzeSz1ro4e/6cnZEmay9QBP5xmCoMweUQ5oqoP4gxdkXXj47moBCQkZ+RkMceZMaZ/UR2+63qt+1PbCFLa2F4v3ayD8b8spywOGrl/QcNq2LdHJdyZEzkCshELGxBKWAMOBY3VA4zgbXDQfGQfYYb2NgXDqEUD8c3NCzwtC4KUeYVmqSYe3UctoTDwRYgSIyUC55TV0cck58uasZUdtbRQ+SVtmqq5rP2LZgGsBT5vRaShCkYddC0yg/xlZAf1JodEhUSYBOLPIpMulH4Hl2joBvr853+vA9q/6I1hvvriGGgxlt/oQORi6rXHXen8no0LkN8JpGc96fRTOoxs44zSnpdpMeGLLRL0Q/dXZDGEg9BBiBL6iK0a9ah9kMDXXlKkvnXLxeApktW1PCYSLwZ1CEMR2NIVZS7tLMerpPUQwgs27pRNY5WeApgZBwJvHtMeo58ZzWeOWY7IKi1Mbn+ewOrPgr979UcpIxcqViQeTh6t3e0/VVx57DLEjUExMqSeGlXn20KKFgI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZGM0bFZGN2Q5RE1PRHl2ZUNmQ1Rlb00yZzkwM1hKMHJCQllHc0FiVmRrVFNl?=
 =?utf-8?B?djdMNTU2TGRyelUrMitrN1NBRDZkbjduQjhIbkdjbHBaamxWNEFMaUJpRzJh?=
 =?utf-8?B?YXMxeFRIZE8wRWovd04wdytNNHJML3dFbC9MM0Ezbnk0bDhHVnJaVTNBc0or?=
 =?utf-8?B?YzZ2bUdSMU5PdGs0YUdleWxXQzRraHhnNm43WFpPSVhvNEM1ZEh4RjQ4L3lj?=
 =?utf-8?B?YUM3VFVjeXFpekVVOTdxd1F4OFN3WU5aaGhacjRISGk2ME1lN0lERVBmY01P?=
 =?utf-8?B?VUloNVdVb0tGbnVpVEwyNWtQSG5qdEt6M2Y0c1hrSXlDOE4wa3BxaXNnYXMv?=
 =?utf-8?B?eFlobnBFRUd2Nldwem0xS2swZnRpQkRwVlVNb1N5SFRrcFNEcWhBbUErUlZo?=
 =?utf-8?B?ajljb2YvOFN2bGdyelhOcHpvaTFmLzFXZzR1ZVBtNWxad3FOQSs5NU52Slda?=
 =?utf-8?B?QTRKZXhMNUxtUURPVFNhUHk2TTl5MkpIdjZyZVNDNGFOK2JNYkFpVjZ4TkZx?=
 =?utf-8?B?WlRSRTdFNlFhWG5QQzNNNXZDQ29YNk9pQ2RTOUNPYjNnYWtPa1BiU0xBbTJm?=
 =?utf-8?B?RXRCQjZVd2tQRTkvMFp3ZHl1TW41cXo2SVc3VlQ1N2k3VXZZM0czbXEwOEdW?=
 =?utf-8?B?SUhoVEJZalNTWERMVTQ4N3doZWtDellWZkpOK1ZyTHVVU3F6MUsxRlU5YlNJ?=
 =?utf-8?B?cnF1SUNBR3EwaUk3YXNhQjYvQXVlZFlPcEpIbWg5TW9SR3FaQm81bksyNFR4?=
 =?utf-8?B?c0N5WnlWUHoxS0xWZCtBTnpyQS9aSTRPamVEREpiZXdGZWRWNEt6MEJGdSt2?=
 =?utf-8?B?dlc0bzZtSm4xRTJZcGxGdEg5MVZERVpueDFzbVc2T3hwYlp0NGZobWg2MlF3?=
 =?utf-8?B?VUg2WTVySWRyUnhWRy9JY3BScmYwWTlrQWRjVVc4bFVwQnRQOHE1T1FNc1Zs?=
 =?utf-8?B?M0l3YUx1eXU0bGJITW5LUEVLRzVsSXZocHV5Q29Xd2MrdWJZV2lhVEo3WmdM?=
 =?utf-8?B?bCtnMWNTTHM1Q2ZvOFA4cyt6eFFlL0x5QkRrUWN6K05LMFhXZTJhaDF3bVNa?=
 =?utf-8?B?bmM1TVphNFJXdyswMGZhdndzYzQ5Q3F6T012ck1JTDRmdjM3VUsxNUQvMWlJ?=
 =?utf-8?B?VmtJZFdXdE81MVZ4c3pmQXB2TXRYMHVkaTVsUjBkbEVXdFdiajJLbkFFallj?=
 =?utf-8?B?Z1E4d0VSTUlsK29vUGxlKzZ6eVpDUzRWSmoxVDhkaWIzRVE0bWVVaFdPT3hz?=
 =?utf-8?B?SUNydGthWmJ3THlGd0I0amwxSkZLWkJOT3JEdllEYUZsU1RQUnowMjdaZm1R?=
 =?utf-8?B?dVQ0VjZsVHZHb3hZWnZBR0RSTHdITTJ1SzRhdEkvOCtUYmZJUmpSdmtvYXdQ?=
 =?utf-8?B?SHl2amo4bDFmWWFTbTc5TEc2WGhJQVdSZGozTmk4MnhHMzR3RHFLQ05hQnRu?=
 =?utf-8?B?L3JpakJ3RWZrcTR1ZU5yRm9FZFhsa1VYRWhZdURSb0UxSEh0Mm05SEV4citw?=
 =?utf-8?B?cHR2TW4xYjhZcVpxS2RGdGphV1pvVDhnd3BtMnVhWDJSOWd5azNVUnIyVE9z?=
 =?utf-8?B?bnhUKzhJM01YemVVL292bXFwL29mVXRQbS8zUXFKSHRTc0Q5WVUreVhCOUFD?=
 =?utf-8?B?VTA3RW5ETkpvZ0tRTnhuV1pkb2VicndJYkk4V05hdzRRS1BnQmVJaTh4d1R1?=
 =?utf-8?B?dm9oZFd5aW4yYURyazh2Y01lUzd2OERIYXZ3bWpKc3dqVVpiY3NhQ2lwTVRw?=
 =?utf-8?B?N1ViMUhQWGlLNDJXd3UvN005SVhwUlNESkM2b2JFZDZNOERzK05CUHBDaEVP?=
 =?utf-8?B?Y0sySFZYOTR5ZmswVjdZcCtJSDJ4MDdXU2pMaTA1RzFiblBrV3MwSWt6ODdu?=
 =?utf-8?B?Wm9tSHlqemVDMmlLeTNzMEw2QldHai9pNFpWTEVkRlZHVm1uSEFUTk02T3NT?=
 =?utf-8?B?SjMyc01mQ09jeXJtT0diWk5ZUkRaUlByQ0szRmI3c0Z4aktKNFFIa2VLMDdl?=
 =?utf-8?B?Z3hua1EzRXEyZUVuR3FMTEs0dHBncFZqMjh4MnlwRHJMQnpQN280VVlJNmg2?=
 =?utf-8?B?WHZURnR6ZW5kcVJiTHJ2VFNyb0MvTUg3S05DaHg5aUFMV1pRS2pPdWRUanZD?=
 =?utf-8?B?Qk9rS1JSQVF6ZGNXbEtCV3c0RXZZOXA1S2xpSU1WTm5WZ0l4WW9ZaEZ0MVQx?=
 =?utf-8?B?aFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bc4346f-f70f-4bb0-d8b3-08dc3d1b46a0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 13:50:53.9231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EAYDUYv7YTHvm+7DvFDJT5m/NzUGbS76rd5Jo0UbSMXF5nrURb/zduzP3zjn/jPj0ha/eNZhTP1dP+Y/k4mI7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6275
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Mar 2024 13:51:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15225

On 05.03.24 12:02, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Check for signing errors to avoid an unusable swu file.
> 
> This also moves the siging out of the loop to generate
> the cpio archive *.swu as the Messages from the signing
> can lead to errors in the archive generation. The cpio
> options are no longer using the short form.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  classes/swupdate.bbclass | 43 ++++++++++++++++++++++++++++------------
>  1 file changed, 30 insertions(+), 13 deletions(-)
> 
> diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
> index aaff072..c62f43f 100644
> --- a/classes/swupdate.bbclass
> +++ b/classes/swupdate.bbclass
> @@ -191,24 +191,41 @@ IMAGE_CMD:swu() {
>                      "${PP_WORK}/$swu_file_base/${SWU_DESCRIPTION_FILE}"
>              done
>              cd "${PP_WORK}/$swu_file_base"
> -            for file in "${SWU_DESCRIPTION_FILE}" ${SWU_ADDITIONAL_FILES}; do
> -                if [ "$file" = "${SWU_DESCRIPTION_FILE}" ] || \
> -                    grep -q "$file" "${PP_WORK}/$swu_file_base/${SWU_DESCRIPTION_FILE}"; then
> +            cpio_files="${SWU_DESCRIPTION_FILE}"
> +
> +            if [ -n "$sign" ]; then
> +                if ! /usr/bin/sign-swu \
> +                    "${SWU_DESCRIPTION_FILE}" "${SWU_DESCRIPTION_FILE}.${SWU_SIGNATURE_EXT}" \
> +                    > /dev/null 2>&1 || \
> +                    [ ! -f "${SWU_DESCRIPTION_FILE}.${SWU_SIGNATURE_EXT}" ]; then
> +                    echo "Could not create swupdate signature file '${SWU_DESCRIPTION_FILE}.${SWU_SIGNATURE_EXT}'" 1>&2
> +                    exit 1
> +                fi
> +                cpio_files="$cpio_files ${SWU_DESCRIPTION_FILE}.${SWU_SIGNATURE_EXT}"

Can we use a local short-hand variable for
"${SWU_DESCRIPTION_FILE}.${SWU_SIGNATURE_EXT}"? One that makes the lines
shorter and more readable?

> +            fi
> +
> +            # sw-description must be first file in *.swu
> +            for cpio_file in $cpio_files ${SWU_ADDITIONAL_FILES}; do
> +                if [ -f "$cpio_file" ]; then
>                      # Set file timestamps for reproducible builds
>                      if [ -n "${SOURCE_DATE_EPOCH}" ]; then
>                          touch -d@"${SOURCE_DATE_EPOCH}" "$file"
>                      fi
> -                    echo "$file"
> -                    if [ -n "$sign" -a "${SWU_DESCRIPTION_FILE}" = "$file" ]; then
> -                        sign-swu "$file" "$file.${SWU_SIGNATURE_EXT}"
> -                        # Set file timestamps for reproducible builds
> -                        if [ -n "${SOURCE_DATE_EPOCH}" ]; then
> -                            touch -d@"${SOURCE_DATE_EPOCH}" "$file.${SWU_SIGNATURE_EXT}"
> -                        fi

Why is this timestamp tuning no longer needed with the new approach?

> -                        echo "$file.${SWU_SIGNATURE_EXT}"
> -                    fi
> +                    case "$cpio_file" in
> +                        sw-description*)
> +                            echo "$cpio_file"
> +                            ;;
> +                        *)
> +                            if grep -q "$cpio_file" \
> +                                "${WORKDIR}/$swu_file_base/${SWU_DESCRIPTION_FILE}"; then
> +                                echo "$cpio_file"
> +                            fi
> +                            ;;
> +                    esac
>                  fi
> -            done | cpio -ovL --reproducible -H crc > "${PP_DEPLOY}/${SWU_IMAGE_FILE}$swu_file_extension.swu"
> +            done | cpio \
> +                --verbose --dereference --create --reproducible --format=crc \
> +                > "${PP_DEPLOY}/${SWU_IMAGE_FILE}$swu_file_extension.swu"
>  EOIMAGER
>      done
>  }

Jan

-- 
Siemens AG, Technology
Linux Expert Center



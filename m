Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 479CDC77B7A
	for <webhook@archiver.kernel.org>; Tue, 30 May 2023 06:32:30 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.55])
 by mx.groups.io with SMTP id smtpd.web11.3979.1685428343246436291
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 May 2023 23:32:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=j60SzoVT;
 spf=pass (domain: siemens.com, ip: 40.107.7.55, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QIufnJS8jDMGq4NmjMk3wPZ3G/dWGS3klDeRex7xs4+68HdkOwknWpUJACnmtaZqKN7eWdH9IKvxKpWUlGONk2mQvK+7B9vqGbQ6CfOpwEexVaw85Aq54IDB4GXKDjMQx2MKeToSDNLhix+knIlO2r5VH1EuMMSsx8nR5TXO59EuaTXerLLffy8w7yaVtFmqgDMpl/hehxCaK7OPQr1ENXqr9C1wHc052hPj+d/05e2q/L0/ntfqGMK1WL7cG5tAx/ejvh/Eetc4DuVLft50xzLWgeHDeQusvES9zSO+7goYZerHx0uG8P14PNdnqXrAKiWyutr3WGLskERQvmHvvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YA8gZpkpvfzBzYegviDOhj4Nh3wDh+HRtYCIpj/xr9c=;
 b=k6oEx8AecDkwuC5on8P0NB4go2cZP7t3kpnanxrFFRJeTV79IXshTS9d6/m1iBnw2Xb/GKCyiQvbUA0vqf8KyUvkGmG+HtdHbGdk/S1TawVt5IGgYnZcHr3hSKA8ZIClrkSM6s3qR6SOYVURIUI1tmjmtDvt6DTJH9qrhkNeUPBo2fcnLwPRX0R6QtwAOHHnmd2yx2+RIGSmljXslr0shgUb75dR37YzA9lvjfljZ5Ag1xoiq4fwoJ87qhALnp6n9fX3Bbd0ECVlEdhfDSotyZAectrfxhjOA8lkOA5OpH3+vAYyj0xXh/BQb+zKVXJUPwBpB25ES1et1bzh9T5IRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YA8gZpkpvfzBzYegviDOhj4Nh3wDh+HRtYCIpj/xr9c=;
 b=j60SzoVTOV4pryk7/hXbIUu2PZzkbGU391eT6+o79ijc+p/jtU5W4Jx8JpA5PKotUQPHWeyAygDin/CprDy+9AAXqDaGFjlLhNF8BQF28EJuF91N3dqDd1gqEnfbGm25VeY8Tneh4IiLTlCYVRup5+6YuZxYANeVpMQSVqclvvj0wWHAhiInUSQhS7Qk7fNl9VH5ZMOsgtxQdzObcQZA98t9WFUsS+AJ/GvvAYdYxZW+C198BgwMUYAy52pd8NV8Rgrv8cRQGIFFj5LshqpE5M4R5m1f386+ICOzoAhk7IkeJGXHCaHvx6FbGvCJEFCL9kLZak+YzMHCSDfp8cLi/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3151.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:135::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 06:32:19 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d638:8333:21fb:5f18]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d638:8333:21fb:5f18%7]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 06:32:19 +0000
Message-ID: <b6f59587-21c1-bcdf-c657-dbf5f206cc27@siemens.com>
Date: Tue, 30 May 2023 08:32:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [isar-cip-core][PATCH] kas-container: update kas to 3.2.3
Content-Language: en-US
To: Srinuvasan Arjunan <srinuvasan_a@mentor.com>,
 cip-dev@lists.cip-project.org
Cc: Srinuvasan A <srinuvasan.a@siemens.com>
References: <20230529063356.2292070-1-srinuvasan_a@mentor.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230529063356.2292070-1-srinuvasan_a@mentor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0240.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3151:EE_
X-MS-Office365-Filtering-Correlation-Id: d63afffb-a507-4ac7-a830-08db60d79e4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	kkbHwk4txxlcfKdOSqRJ63JvDx0eKjCynTfV+yqlI3xaV4bjJOgwwXSgooSFXpWngdrW/iSw9YZ/G18wlLaEHRJa/KP3jGFu0VeZzQms1S+iPxS2LSbVP4PUg2X/e/RZ0PRjaSeZty1o8rSZZhlaympRpY1jep57dzP7K6Iwd2ILq7r6jHPoYVfi0jEGuHduGoGbBgO+zSTWr183bTpIHKWHONhdwoiG8qmJNA3fX/muD4cXuKrTwb/oVXwu/J+eI3Dv0otRKZXvZPTfrsGxRI/BII9xgCVDu50Ibc1Ryinjytqcy5G2coVWhdVRdtxZuMkLRFUQcfy9eVeQJ8OWZWBVpoKU861TLtmMfS/NQBkN1VjJUW7jzgiLH6esWLpz0YY290K1pWrLTt9unxBuiTYEDkmJ02mCXjnpFXjiZVlNMrqSl4wuTnP1/JK+b4wtqTg4LrXTpRmuo25lsr9CXWi4uY4sVweAOfxcrJUVR0v4daxjlRAjdop1MF2ORjMqFzkG+MRp/B9SAdz10MC8Xs1YqOBiv6JbMimEtOcoriSSG4fC8cR6tqaQepfJxAUzFN04AbLRS3WUxR6BP3pkniK8f7r5djzpurMcg5EFi4lwjjxWPltVZRwePpBfOYuQBodBiadzzf0JdAiujq74/8LZnorhuaoevzw7hY9Ln9PAkIp2q0j9pyji6ZVey/nC
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(366004)(136003)(396003)(451199021)(31686004)(84970400001)(478600001)(66946007)(66556008)(66476007)(4326008)(316002)(31696002)(36756003)(86362001)(83380400001)(53546011)(6512007)(6506007)(26005)(186003)(107886003)(5660300002)(41300700001)(8936002)(8676002)(44832011)(15650500001)(2906002)(6486002)(38100700002)(82960400001)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QnhVbllGeUlKRThsR1MxMVE0Q2JidFpDZXNqUFpNczZEU2V5eDkxbUsxTkcx?=
 =?utf-8?B?NUJUTUcxNEJiUDhqaExGN2MrVzRFcTloMkcybEprMHlqMUxJK0Q3cm53SUxX?=
 =?utf-8?B?L2NaZXdxVTFYYXpudkFqaTFKTEJjVERRelU0UHNRcmExd3U5SDJXTmZyUnpM?=
 =?utf-8?B?VjBBT0dZSWpWQ0tORTZUMXFnS0wwaUNzOGl4QUJIY0NUemhhR0VjbHVteGR5?=
 =?utf-8?B?bCtvL3pwRVp4dzVkYkJ3NmFhWXdpcDE3RmdoUVlWeWw4ZC9Wc0lrR0NSZU9y?=
 =?utf-8?B?Mm03dkUxK2lPT1N0eDl3dXI0aVhvTTNWT2c0K0VBMkM4NXJyL0pGN1g4Q1pa?=
 =?utf-8?B?cytmV2o2WkVyR0tFT3FMdVlwUitONGFuTGNkVXYyWmxZNWtQTUYweHVYYTVW?=
 =?utf-8?B?bW12aUJqbGd6VGJWQkc1bVhOaFlwQUx4TzNoWUwrQklkZzFnNUhWeVN1Um1x?=
 =?utf-8?B?Qkt2U0tiQmJrOHpGSTc2bDRJRU1ERmFnZ1ZjVjE4TVRaVnA0akoyTHlycDBs?=
 =?utf-8?B?amJaRTRGUWZSaGdJUzBXbWJVVXlIUE9CR00rVHhKUDMvVGtjbjFWY3ArVG82?=
 =?utf-8?B?N2l0YjBTb1ZlY3k0QXZ2UHhKVU1qdnlROWpCdTkvYTBTZTFHcVFHeklRenVK?=
 =?utf-8?B?L1p2S2VocVdxLzhUank3M1I5cW56dWV4ZlliRU1lS2lhN1hMbDh4WXFFUVBB?=
 =?utf-8?B?WlkzcVdCejhzS2dtSG12dFJNM0VXMVhHd205TVBMcGVTR3cybGlicTFORjNI?=
 =?utf-8?B?RmhJYUxtRXFWamM5eWVZK3JJeVBUaktwWTJtM2ZTU1kxaFB1ZVp5cnl4ZWpC?=
 =?utf-8?B?bkUwOTB4WDlwOUxZNXhPNXFQdGhJMytleFRia2tUa0J1RExqZUNmTU5nUnFw?=
 =?utf-8?B?STEzODI3d0VwQ0RWZ0RtM0tsT3RYSUNpbjl1d2VRWlJodnpVMXYrVHh2WkxW?=
 =?utf-8?B?dmZQUlUxWlpPUkNqZVlFMitCdGNTdzJKMnQxMmQvcy9oL2VXcnV1VWd6RXY1?=
 =?utf-8?B?ak8yM0k0VStjVGEwK0hJbjJPTnB0dFlTaE4vUXdXUnA3TWNrd25PUUJNVDFm?=
 =?utf-8?B?VGRUenlnSzNlMWgrTVh1cGcwemNKb3FwNFBya0lURmxFSGdaN0liOHNxME52?=
 =?utf-8?B?N1cwSFViQ1FzTS9BSHlvZDVFRzJQVExHZUlWeEJ6azJkZjlDYlUyS2pmN01z?=
 =?utf-8?B?SmZNTW9qSCs5RzBhZDQrSVJjRW9vQVVwVjZrRWJCQ05pMkZDbWZGZFoxUXRS?=
 =?utf-8?B?Q0pIRk15eXM1RHNxdllia3A1b25rdStKNUM0WEVnMXZ0MzNaeHN5S2txUkdk?=
 =?utf-8?B?SjVycVRVb2c1cGo4bENVM1kwSGxwVnVGNSs4cW52Lytpa3prKzVGQnV2Vm9R?=
 =?utf-8?B?Y1QydUhYOS9sV2pyTDFrWEVJRGtXeXg1UkFtUFlJbHg2K2diYmRjNVRPSXA4?=
 =?utf-8?B?M2hyTXhJcm0renJ0YW9sTXBjS0tLOWg0YUpNN25KbDM5bVJhenRtc3ZlT0dT?=
 =?utf-8?B?citDUlAxZkFIcEk3WU52UjJoSk1IUUI5RjRFVGtuSVhTeVp0N3VLOGUzTG5Z?=
 =?utf-8?B?YXVPbEpWV0krNFVuQzBTNXdQelVGeFVFT0hDdUtVWGJUSTZMVjlDNmpRVS9j?=
 =?utf-8?B?eTZpaUxBN2wwektWNDVEUEdwUFhkUklWY1c4dU5sU0Z6a3ZvWDJrbytoV0p6?=
 =?utf-8?B?MjJ5bzV2ZGp4WStxUG14VlUvREErWVFmaE1EWjdGc2I1dk9wUjJTNFlQTmk0?=
 =?utf-8?B?WFdRT0pmQzkwVjFRQmw3NTNIQ0tLWkRMaTRpY3cvdkJVN0I0RmtVU1R6aFlH?=
 =?utf-8?B?d1piYVY2V3NUQUxNdGlIUXhVdUx5YWFYUFNKd3A2NkpDQ0Vsa1U0d3UzSnZt?=
 =?utf-8?B?dDZpdkpVZ1JvVmREVU15Q2N5Z3ZUQTVPd2RGVUpScVhhL3lkODhoQ293eWlu?=
 =?utf-8?B?WEtVSjMrRDZ4bHFRaG1nYjB6ODlvSUxYcFluTmg2UzJZczhreVhWYVF2ajVz?=
 =?utf-8?B?bkI5a1dYUjVxZGpoWkllQTU3c3ZmYzNicnNYZUlvV25WcmpRMkg0czgrRXdH?=
 =?utf-8?B?Q3NVOXU2czdtcGRtZVZBUjFqSkU0MUhIOXNFYWFpYzJ2dEE5a2pHR2N1Y2RW?=
 =?utf-8?B?bEkrV1lPM2dvY1VPSTMyZjgrL1hLSHFqWWtyVis0VEc0a2c2L2thdTd5YTZ1?=
 =?utf-8?B?TEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d63afffb-a507-4ac7-a830-08db60d79e4a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 06:32:19.4593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lxc/M5kk66xSVrjjoTUtjEAByWS7EtLZuWDEAjpNiOB8JvCJCzCEB0sbtLTpNukyAkb96cquGHnXCDSTOPzlSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3151
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 May 2023 06:32:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11700

On 29.05.23 08:33, Srinuvasan Arjunan wrote:
> From: Srinuvasan A <srinuvasan.a@siemens.com>
> 
> Update kas-container to latest one.
> 
> Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
> ---
>  .gitlab-ci.yml |  2 +-
>  kas-container  | 20 ++++++++++----------
>  2 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 6c82bb7..892ba92 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -12,7 +12,7 @@
>  # SPDX-License-Identifier: MIT
>  #
>  
> -image: ghcr.io/siemens/kas/kas-isar:3.2.2
> +image: ghcr.io/siemens/kas/kas-isar:3.2.3
>  
>  variables:
>    GIT_STRATEGY: clone
> diff --git a/kas-container b/kas-container
> index cad4290..123198c 100755
> --- a/kas-container
> +++ b/kas-container
> @@ -134,7 +134,7 @@ run_clean() {
>  	fi
>  }
>  
> -KAS_IMAGE_VERSION_DEFAULT="3.2.2"
> +KAS_IMAGE_VERSION_DEFAULT="3.2.3"
>  KAS_CONTAINER_IMAGE_PATH_DEFAULT="ghcr.io/siemens/kas"
>  KAS_CONTAINER_IMAGE_NAME_DEFAULT="kas"
>  
> @@ -411,7 +411,7 @@ if [ -n "${KAS_SSH_DIR}" ] ; then
>  		echo "Passed KAS_SSH_DIR '${KAS_SSH_DIR}' is not a directory"
>  		exit 1
>  	fi
> -	set -- "$@" -v "$(readlink -f "${KAS_SSH_DIR}")":/etc/skel/.ssh:ro
> +	set -- "$@" -v "$(readlink -f "${KAS_SSH_DIR}")":/var/kas/userdata/.ssh:ro
>  fi
>  
>  if [ -n "${KAS_SSH_AUTH_SOCK}" ]; then
> @@ -428,9 +428,9 @@ if [ -n "${KAS_AWS_DIR}" ] ; then
>  		echo "Passed KAS_AWS_DIR '${KAS_AWS_DIR}' is not a directory"
>  		exit 1
>  	fi
> -	set -- "$@" -v "$(readlink -f "${KAS_AWS_DIR}")":/etc/skel/.aws:ro \
> -		-e AWS_CONFIG_FILE="${AWS_CONFIG_FILE:-/etc/skel/.aws/config}" \
> -		-e AWS_SHARED_CREDENTIALS_FILE="${AWS_SHARED_CREDENTIALS_FILE:-/etc/skel/.aws/credentials}"
> +	set -- "$@" -v "$(readlink -f "${KAS_AWS_DIR}")":/var/kas/userdata/.aws:ro \
> +		-e AWS_CONFIG_FILE="${AWS_CONFIG_FILE:-/var/kas/userdata/.aws/config}" \
> +		-e AWS_SHARED_CREDENTIALS_FILE="${AWS_SHARED_CREDENTIALS_FILE:-/var/kas/userdata/.aws/credentials}"
>  fi
>  
>  KAS_GIT_CREDENTIAL_HELPER_DEFAULT=""
> @@ -440,8 +440,8 @@ if [ -n "${KAS_GIT_CREDENTIAL_STORE}" ] ; then
>  		echo "Passed KAS_GIT_CREDENTIAL_STORE '${KAS_GIT_CREDENTIAL_STORE}' is not a file"
>  		exit 1
>  	fi
> -	KAS_GIT_CREDENTIAL_HELPER_DEFAULT="store --file=/etc/skel/.git-credentials"
> -	set -- "$@" -v "$(readlink -f "${KAS_GIT_CREDENTIAL_STORE}")":/etc/skel/.git-credentials:ro
> +	KAS_GIT_CREDENTIAL_HELPER_DEFAULT="store --file=/var/kas/userdata/.git-credentials"
> +	set -- "$@" -v "$(readlink -f "${KAS_GIT_CREDENTIAL_STORE}")":/var/kas/userdata/.git-credentials:ro
>  fi
>  
>  GIT_CREDENTIAL_HELPER="${GIT_CREDENTIAL_HELPER:-${KAS_GIT_CREDENTIAL_HELPER_DEFAULT}}"
> @@ -451,8 +451,8 @@ if [ -n "${GIT_CREDENTIAL_HELPER}" ] ; then
>  fi
>  
>  if [ -f "${NETRC_FILE}" ]; then
> -	set -- "$@" -v "$(readlink -f "${NETRC_FILE}")":/etc/skel/.netrc:ro \
> -		-e NETRC_FILE="/etc/skel/.netrc"
> +	set -- "$@" -v "$(readlink -f "${NETRC_FILE}")":/var/kas/userdata/.netrc:ro \
> +		-e NETRC_FILE="/var/kas/userdata/.netrc"
>  fi
>  
>  if [ -t 1 ]; then
> @@ -479,7 +479,7 @@ if [ -n "${KAS_REPO_REF_DIR}" ]; then
>  		exit 1
>  	fi
>  	set -- "$@" \
> -		-v "$(readlink -f "${KAS_REPO_REF_DIR}")":/repo-ref:ro \
> +		-v "$(readlink -f "${KAS_REPO_REF_DIR}")":/repo-ref:rw \
>  		-e KAS_REPO_REF_DIR=/repo-ref
>  fi
>  

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux



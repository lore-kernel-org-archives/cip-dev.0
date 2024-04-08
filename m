Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A9BCD128A
	for <webhook@archiver.kernel.org>; Mon,  8 Apr 2024 12:54:42 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.137])
 by mx.groups.io with SMTP id smtpd.web10.105474.1712580874967897391
 for <cip-dev@lists.cip-project.org>;
 Mon, 08 Apr 2024 05:54:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=GZJsMasw;
 spf=pass (domain: siemens.com, ip: 40.107.6.137, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nwDMg7xdfrXTgiOUbL4Bzy+UtegOEPGkMZwa0EZh98wS34B8z3SzArVg12EPZaV+8zPxXeHaTTO1ei08Eieb6EsfiTChxQJ86z1nBilIIJxe9aaiqHOrbNaAJhxrpj/gwpYP0BhInFlvNiXigqZU8e0McJ7mnRernmtXKjs4dbeG65YaupkIkIsr1YhOiAOdlOIyrBsQS+iWsLrJRDvd3TMMDUSTXHUJJr6o4jNL/8G6z4Ki2U1IEPvEG5gTIUabR7Ax1ayEQpkt87t0x5cVdTK4VH6vx3/KKYZF0JWrjgB6wVL3VXzj3J+MqkmVY8lwujEqZ1M3hv7ZqU5LuR7sKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s7h+NoHM6kYvwaIV0ay1XKnreJBRiFKVbAJUEKjzwGY=;
 b=BhMcqx6pNiceUOC4T1HbfInW5NEWkhZ70/eoYbOQEBYmj7CIDj7WwkgVCFi7YEwg9pRr2KJqEDtrKQMGhOv9KMYUaZShvg8QOJxUU/Zl54hAi01H8eO5TncP+CeEo9sa2RBcY25ZVS+84WFXjJrtvHUYqgoxIKRXHCwhfEaaKDRQpRY65YlOBIDBvkXLyNArN5m8YV3dR4sN6ShTxXk7aGc1lncqx0GSg2+hLqtH9FpPjTvE/QHgUWpfrjbO9Zb9bdwFQXnYnJTOeEIqiezrU6qWWwj0kpnsCCAK/v8OEQ36R8vz6NtZ6y7hDZj6Bc70znGQTs+cyY/rbqsfDRScaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s7h+NoHM6kYvwaIV0ay1XKnreJBRiFKVbAJUEKjzwGY=;
 b=GZJsMaswZCDvIq1ppToQvAyYuKpO4DyAH1JcEl5vGhilGjxcKvDMFyZ7DxtWcMPvCagXwVOIxGhIwiCj8vmUMmY8qvnLaBETINthzCspPLoNQ1NLC+lCIrLr/MeAhlx4Qq8H0wEBUIXwku4zcdKX9L1YTZYexmK/sgW1TLaxDCpqDvIgBES5osKGq/iU+3ycHA+cNU6lh2ald7W9kHNjaYLSwhygnWyNeEmQUTaj7iBanl7vbY+S8l3wpEwVeJcIRb9r29nBqup8ROBXw9GfkQcwx8Q0NeGtGqqDUqQUMqL71TwqAThLGPsJEWdu2vEMsHMfksMYggIAUWtMq5aeQQ==
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by PA1PR10MB8392.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:448::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 8 Apr
 2024 12:54:32 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67a7:ac13:3db4:91cf]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67a7:ac13:3db4:91cf%7]) with mapi id 15.20.7409.042; Mon, 8 Apr 2024
 12:54:32 +0000
Message-ID: <ed0c8463-e04a-4a70-9954-54640fdac205@siemens.com>
Date: Mon, 8 Apr 2024 14:54:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][RFC v2 2/4] Add Delta update support
 with rdiff_image and delta handler
Content-Language: en-US, de-DE
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: shivanand.kunijadar@toshiba-tsip.com, sai.sathujoda@toshiba-tsip.com,
 dinesh.kumar@toshiba-tsip.com, adithya.balakumar@toshiba-tsip.com,
 kazuhiro3.hayashi@toshiba.co.jp
References: <20240320103229.1078738-1-Adithya.Balakumar@toshiba-tsip.com>
 <20240320103229.1078738-3-Adithya.Balakumar@toshiba-tsip.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <20240320103229.1078738-3-Adithya.Balakumar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0068.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::15) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|PA1PR10MB8392:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	zXxtOJZ4ZCJNKOriAHXf82FVqMAnOu3u5M03kK1imRPhUzJfkHe/Q3fhfOQEZWv6eaWxmt1ZRTkXtCm8coup4mlMV1ORrpdSLd2bWYd+oPxx16cOjr/ftUyAiTIXLwtUiB6bNAGLIQo/gbZkglRC76LEB+Pnx548pcuYjOWeoFPYGqxXuXVlz4sYGZKZWQhgqT9dB3VjtRVzfkHTKYKILpAHP4IRJUin3xM6OujLjG5hVEB/Cd9i1LIIvzZ3zXOlX6XVFzOpesGBe/i+hcvyTQz6wWAlGZgzkopSmBjd/7TgMBGX/6a92gdwOMTX3MD56mFB/JnXQI3JcopaM79fg6qJMoI64Q6dWLSVPoNE4BRwYH3VwWuKHf7QIdxI5/rWfZ3cHxEXpLS35uw33VxfnmiwXTISmD3P5LNaVA5ZZGhvd2pTtoBzvBWTCXXpRcrNY5f2QinYgxr4jsEqZk2CqcbF2Dy86EB/2Zf3G5GGJmvGrHSvxLfUcoKGbVrfaT/HhTudIh7Bw68CCSPYDoR0n+Pb0gJ+JUiDh5yW2tmxVY0K0BVq24N8SwPMxcpWiFAAf8yHOzGO2l4nU9H2ah5dxGzEwgVJP2l8pd1SgFB8OnI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WDNkY3NoVlYyd3JVVG1xTzdodWc1MXRDN0tWVUwyMUlIc1gxaU1kdDJKYTBp?=
 =?utf-8?B?WVFUQmhuRnZLbGRzK3FudmRYVmR2NDNIOC9Md2E4eTExM0JPaGZVNmVNSkRK?=
 =?utf-8?B?YXphWENJS3NvcU9odWc2Q052T0E3WXhjRGdKOUJ2Z2JlNElsK1JMUy9MTmJL?=
 =?utf-8?B?MXRQbGFmUjBqSkZLYklyc0VjTWNPTjVncldjMGEvVnVpenBRZ2xSR05ZNFcv?=
 =?utf-8?B?aHNzSE9Oa3BCVFRpalVTTm1SK29qUVdHd1dwNm9TV3hla1ErRWd3ZXRtTTRV?=
 =?utf-8?B?VHdYYXN3eGo2NGZSamJWSTdnOWtSSnJpRlZjZ0x6R1UwUTNDa1JJWGNDc2pH?=
 =?utf-8?B?R0dycm01eEF1RXR1ZGlkaFpWamRET2FBZFBoRWNJbG1DNXJQRkRBUldNRFFO?=
 =?utf-8?B?RVA2TS9sSGFlNUFJc3Z6N1l1VlVKRSs2MWFoeGZzRXptOXhiRXR1SVpQd0xE?=
 =?utf-8?B?WFlTMEFnR1JOSXdBUXRhSTRVMlBxRG9NZDVXS1pDMEJXU3dhbWlqVlRocFVx?=
 =?utf-8?B?YkJ4Y0VLaUJ0dklUckRmdEdpUnZicXd5cXFGWHlDSE5aeGFpdXVDQk1wdjdr?=
 =?utf-8?B?bEhQNE54MXVudkNKeVV0Z0oxSk5CbUkrWWlJSS9qeVFBbTEzd2dwejFOV0Zq?=
 =?utf-8?B?UDlCUkZBSUpaRFdGUFduajBIck9Ob20rTTZ2U2NvVGc5RHJ6UGVFZUdSRjNH?=
 =?utf-8?B?UGdzZER1aUlxa2Y2dUFla3kxRlhLQUpUNFJGQUdTZnkvMU9YTWd3SEtFY2pk?=
 =?utf-8?B?TWUwZGJBdGRpSitYY2RrZHBqaGpaR2YxbFhsZDJLT3JuUUpHZFpiMzNOSFB2?=
 =?utf-8?B?a2o0S09YVVNGcFhhUXo4WWdXcElGclFESk1hUGxDZ05mb093V2cvdHhhQVZO?=
 =?utf-8?B?ZlBnUUU3Rm1tWWx2dlpaa1hSN0swOWFTcmJaSkJ0Ri9mQUtoU2paanhMRi8x?=
 =?utf-8?B?OWUxdnNtQzJwZVBaOHAwdEpBSi8zTWVpTEd0QndEV2psMjN4ZUlycTdydW9s?=
 =?utf-8?B?QjI2VXV6SnFSSGljNmRPU0pmZzczdVcyUDNzTHI2QWZkOHFnN2tEbHkxcFYv?=
 =?utf-8?B?aDVWTHRjeVgrWjVzN0NZQ3AzbXczN01JRGNUcEhkbnZaT2RuVmdHSjNlZFJF?=
 =?utf-8?B?clp1NUtTcjNPbkhYMmJwT05ROHRjbk9MTnV3a1BXRkozU0dBL0RLNVZFbm5O?=
 =?utf-8?B?bHpTY3dyUGRKdEJlWHBhUjJJS2UzWlFIOFd4ZXpGNklxckR6UEZwL0tMakRT?=
 =?utf-8?B?QnQyOTU2WWlFT2pYT0lhTnZJVUJ0OGJkM0Jsb1pFUVJvVTBUOUROd2hwcHpp?=
 =?utf-8?B?MEkvTkQyazVFcmFOMTZiZXUzQUNqSVJjbU5SRmR6VlIrOC85cmZPbmdhOTN5?=
 =?utf-8?B?OHJIUFp1bVhHSDFNZ0tLbDNSaStFYTVXOHZrM0FVZElibVdVU3FuTDB5Y3Q3?=
 =?utf-8?B?M3BzUkdEZVpHcEV2cDUrb3k0UDlvTStiS0VnZlhFaFozakxhUm9QSUY5MzZz?=
 =?utf-8?B?MHVJOXoyOStCT2xUTWYyWStNWW9nRUdsZHZQQ1F1ekhYVFRwbmhHUEhXQ3dv?=
 =?utf-8?B?TjZUakZ3VFNjNXRKdmZWM3NLMkxoTWNVbkhHYUJuSG1MSmp2MWQxQWhJUTZy?=
 =?utf-8?B?ejRxSEppaDBobWhjTVJIbGRRT3F4dWtRMVZ5L09wdkJtOWRmb0VyNUVtUmVy?=
 =?utf-8?B?ZHk1d3VoSnJDRWNIK2JyNXN2U09NVUxiSjFmd3dxSkpHbXp6RkpkU1FkUzNY?=
 =?utf-8?B?MkwwdWpBcjE4VFdyTUJWN1B2dXFmL1cxUER4aG94MmY5ZVlvOE8xMWx6b2hs?=
 =?utf-8?B?Yzl2cnliRVN4RDQvZFBIb3FDUWthT1F0K0hvK2RGNFhlWktSMXZxTDRSY2d4?=
 =?utf-8?B?azRPL2lvYUErMzNPb0R6Sy9kSjlkV2ZXS1h2bHVuOXZuSUZ4VHlvSUlCczJx?=
 =?utf-8?B?b2Zmc1ZoSVIrRVM4Y0k2RnlkSzBiWHlRVkswZGF6WmhVOStjcDkzcVRkNXRi?=
 =?utf-8?B?cCtCUG52S3RmU0J2YzdyZmpwSWo0MVVEYjhrYTZVZjhIbTR4VUo1cDlwK25x?=
 =?utf-8?B?Tkc1ckMyZ3NhUUlxcjZTSHoxOWVZd1UyekZ0RDBCVmR6SDRtdkFuTVowYWVM?=
 =?utf-8?B?VkdnZXRNQVVJUEVSNDdTcVJ4bFE2RlVyTFVBYzJqaXNTRHZSNkZib1c2bk1j?=
 =?utf-8?B?U0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ab3a95c-22da-479c-b718-08dc57cb0917
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 12:54:32.3825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q/hqtbV5rUZ+eEvkTINUrNwzr5J5ZGWLg595oFBI+XN3HXY7VSggmGLHEUgb9gWSmpmuL0KQa6N5HZ+IaWVpVkohXYJ1rcQ8Kzvt/K5IfSA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8392
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 08 Apr 2024 12:54:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15501



On 3/20/24 11:32 AM, Adithya Balakumar via lists.cip-project.org wrote:
> swupdate supports delta updates with rdiff_image and delta(zchunk)
> handler. This change adds support to use either of the handler
> for creating delta update artifacts. zchunk based updates are supported
> only for sid.
> 
> DELTA_UPDATE_TYPE, DELTA_RDIFF_REF_IMAGE and DELTA_ZCK_URL variables can
> be modified based on the update type in the swupdate.yml file.
> 
> Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
> ---
>   classes/delta-update.bbclass | 107 +++++++++++++++++++++++++++++++++++
>   conf/layer.conf              |   2 +-
>   kas/opt/swupdate.yml         |   5 ++
>   3 files changed, 113 insertions(+), 1 deletion(-)
>   create mode 100644 classes/delta-update.bbclass
> 
> diff --git a/classes/delta-update.bbclass b/classes/delta-update.bbclass
> new file mode 100644
> index 0000000..8443f35
> --- /dev/null
> +++ b/classes/delta-update.bbclass
> @@ -0,0 +1,107 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Toshiba Corporation 2024
> +#
> +# Authors:
> +#  Adithya Balakumar <adithya.balakumar@toshiba-tsip.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +IMAGER_INSTALL:delta_update .= "fdisk zchunk rdiff"
> +
> +FILESEXTRAPATHS:append = ":${LAYERDIR_cip-core}"
> +do_image_delta_update[cleandirs] += "${WORKDIR}/delta_interim_artifacts"
> +
> +DELTA_UPDATE_TYPE ??= "rdiff"
> +DELTA_RDIFF_REF_IMAGE ??= "image-v1/${IMAGE_FULLNAME}.${SWU_ROOTFS_TYPE}"
> +DELTA_ZCK_URL ??= ""
> +
> +def disable_delta_update_tasks(d):
> +    d.appendVarFlag("do_image_delta_update", "noexec", "1")
> +    d.appendVarFlag("do_delta_rdiff_ref_image_fetch", "noexec", "1")
> +    d.setVar("DELTA_UPDATE_TYPE", "")
> +
> +python () {
> +    import os
> +    path = d.getVar("LAYERDIR_cip-core") + "/" + d.getVar("DELTA_RDIFF_REF_IMAGE")
I would suggest to remove LAYERDIR_cip-core or replace it with a 
variable as it makes it unusable in downstream layers. This class should 
not contain any cip-core specific elements.

> +    if d.getVar("DELTA_UPDATE_TYPE") == "rdiff":
> +        if not os.path.isfile(path):
> +            disable_delta_update_tasks(d)
> +    elif d.getVar("DELTA_UPDATE_TYPE") == "zchunk":
> +        if d.getVar("DISTRO") != "cip-core-sid":
> +            disable_delta_update_tasks(d)
> +    else:
> +        disable_delta_update_tasks(d)
> +}
> +
> +python do_delta_rdiff_ref_image_fetch () {
> +    import bb
> +    import os
> +    path = d.getVar("LAYERDIR_cip-core") + "/" + d.getVar("DELTA_RDIFF_REF_IMAGE")
Same here remove the LAYERDIR_cip-core
> +    if d.getVar("DELTA_UPDATE_TYPE") == "rdiff":
> +        if os.path.isfile(path):
> +            artifact_uri = "file://" + (d.getVar('DELTA_RDIFF_REF_IMAGE') or "")
> +            artifact_uri_list = artifact_uri.split()
> +            fetcher = bb.fetch2.Fetch(artifact_uri_list, d)
> +            fetcher.download()
> +            fetcher.unpack(d.getVar('WORKDIR'))
> +}
> +addtask do_delta_rdiff_ref_image_fetch before do_transform_template
> +
> +create_rdiff_delta_artifact() {
> +    if [ -z "${DELTA_RDIFF_REF_IMAGE}" ]; then
> +        bbfatal "You must set DELTA_RDIFF_REF_IMAGE and provide the required files as artifacts to this recipe"
> +    fi
> +
> +    rm -f ${DEPLOY_DIR_IMAGE}/${IMAGE_FULLNAME}.delta
> +    # create signature file with rdiff
> +    ${SUDO_CHROOT} /usr/bin/rdiff signature ${WORKDIR}/${DELTA_RDIFF_REF_IMAGE} \
> +        ${WORKDIR}/delta_interim_artifacts/old-image-rootfs.sig
> +
> +    # create delta file with the signature file
> +    ${SUDO_CHROOT} /usr/bin/rdiff delta ${WORKDIR}/delta_interim_artifacts/old-image-rootfs.sig \
> +        ${PP_DEPLOY}/${IMAGE_FULLNAME}.${SWU_ROOTFS_TYPE} ${PP_DEPLOY}/${IMAGE_FULLNAME}.delta
> +
> +    DELTA_ARTIFACT_SWU=${IMAGE_FULLNAME}.delta
> +
> +    # create a symbolic link as IMAGE_CMD expects a *.delta_update file in deploy image directory
> +    ln -sf ${DELTA_ARTIFACT_SWU} ${DEPLOY_DIR_IMAGE}/${IMAGE_FULLNAME}.delta_update
> +}
> +
> +create_zchunk_delta_artifact() {
> +    # Create .zck file
> +    ${SUDO_CHROOT} /bin/zck \
> +        --output ${PP_DEPLOY}/${IMAGE_FULLNAME}.zck \
> +        -u --chunk-hash-type sha256 \
> +        ${PP_DEPLOY}/${IMAGE_FULLNAME}.${SWU_ROOTFS_TYPE}
> +
> +    # Calculate size of zck header
> +    HSIZE="$(${SUDO_CHROOT} /bin/zck_read_header -v ${PP_DEPLOY}/${IMAGE_FULLNAME}.zck | grep "Header size" | cut -d ':' -f 2)"
> +
> +    # Extract the zck header
> +    ${SUDO_CHROOT} /bin/dd if="${PP_DEPLOY}/${IMAGE_FULLNAME}".zck of="${PP_DEPLOY}/${IMAGE_FULLNAME}".zck.header bs=1 count="$HSIZE" status=none
> +
> +    DELTA_ARTIFACT_SWU=${IMAGE_FULLNAME}.zck.header
> +
> +    # create a symbolic link as IMAGE_CMD expects a *.delta_update file in deploy image directory
> +    ln -sf ${DELTA_ARTIFACT_SWU} ${DEPLOY_DIR_IMAGE}/${IMAGE_FULLNAME}.delta_update
> +}
> +
> +do_image_delta_update[depends] += "${PN}:do_transform_template"
> +IMAGE_CMD:delta_update() {
> +    case "${DELTA_UPDATE_TYPE}" in
> +    "rdiff")
> +        create_rdiff_delta_artifact
> +        ;;
> +    "zchunk")
> +        create_zchunk_delta_artifact
> +        ;;
> +    *)
> +        bbfatal "You must set a valid DELTA_UPDATE_TYPE (rdiff/zchunk)"
> +        ;;
> +    esac
> +}
> +
> +addtask do_image_delta_update before do_image_swu after do_image_wic
> diff --git a/conf/layer.conf b/conf/layer.conf
> index 82b4084..d4c87a6 100644
> --- a/conf/layer.conf
> +++ b/conf/layer.conf
> @@ -23,6 +23,6 @@ LAYERSERIES_COMPAT_cip-core = "next"
>   LAYERDIR_cip-core = "${LAYERDIR}"
>   LAYERDIR_cip-core[vardepvalue] = "isar-cip-core"
>   
> -IMAGE_CLASSES += "squashfs verity swupdate"
> +IMAGE_CLASSES += "squashfs verity swupdate delta-update"
>   
>   SOURCE_DATE_EPOCH := "${@bb.process.run("git -C ${LAYERDIR_cip-core} log -1 --pretty=%ct | tr -d '\n'")[0]}"
> diff --git a/kas/opt/swupdate.yml b/kas/opt/swupdate.yml
> index ef61e4e..50ded36 100644
> --- a/kas/opt/swupdate.yml
> +++ b/kas/opt/swupdate.yml
> @@ -30,3 +30,8 @@ local_conf_header:
>       ABROOTFS_PART_UUID_B ?= "fedcba98-7654-3210-cafe-5e0710000002"
>       PREFERRED_PROVIDER_swupdate-certificates-key ??= "swupdate-certificates-key-snakeoil"
>       PREFERRED_PROVIDER_swupdate-certificates ??= "swupdate-certificates-snakeoil"
> +    # delta update specific variables"
> +    IMAGE_FSTYPES:append = " delta_update"
> +    DELTA_UPDATE_TYPE = "rdiff"
> +    DELTA_RDIFF_REF_IMAGE = "image-v1/${IMAGE_FULLNAME}.${SWU_ROOTFS_TYPE}"
> +    DELTA_ZCK_URL = ""
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15381): https://lists.cip-project.org/g/cip-dev/message/15381
> Mute This Topic: https://lists.cip-project.org/mt/105041876/1753640
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129121/1753640/1405269326/xyzzy [quirin.gylstorff@siemens.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 


Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFEC5C5475B
	for <webhook@archiver.kernel.org>; Fri,  8 Mar 2024 11:44:56 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.84])
 by mx.groups.io with SMTP id smtpd.web10.19943.1709898294059760645
 for <cip-dev@lists.cip-project.org>;
 Fri, 08 Mar 2024 03:44:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=tr02fLM7;
 spf=pass (domain: siemens.com, ip: 40.107.21.84, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KFl1sRCq2zBrXHCUeqQlwi4/s3snpmg2/JP7tkw3tFtTlZMn8Zg15L9HThYAIm+wYXfNuh0wYdhqff6XaFGSQj8cYVG+Az79oqzDvMYGU2Dg4rkOTQW83jxU+ELNAuQKvAdlE2/PpakqGopgWXjc6WxPApATS36Ye9ogktZnmqmb0qDEExf6qSArxhl8n2ZoXlWysvUcK+y1JfSH1sQiiuYRqGGyGrwiMlpURpq5FseEPOooXbZzW2f2L1RgTR5aVbwK946+WxFnd+ViaFqHX8OMTz44HpOBbMUf8ErRYpEAV2kncJnGiOTJnDlo4MFBlPW+xYEXaFjEaKBWNKTrqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lhbt6r0LSSBWnQLJMRzA5jXLkHuQFze7bDW3ptO42BI=;
 b=g5NBDC3cU4PReg7aBCOVnkGlnkzzzSAKPeIpDZk17Rmq66oE9GimY1lw1CLdwvvs/U9fKXww7mtbCRH6xfTlnpCjgiIwVWfp4DHdVn4NJfqUXsFePiNnpA5TdOOjtfPlw22ek6GQGCh9Bjvd4h+hQKcMCjLhVfweLLM2g2HyxcEUXs/R4PJes+X9yA+fYMMChp0pMMRn7f1gnbzkVOHJwV3vPnIugDmATq2E0CNNkLnlDIFbcNU+NPt8BpCGe2yRLGkHWYqIL2CvfdJ3mFIxDe7bGI2G0DhjM08jT2pwxPMmqNOTQ6XCAFzzzsPt5vf9f8/qnpwevzqJEh9uUdnowg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lhbt6r0LSSBWnQLJMRzA5jXLkHuQFze7bDW3ptO42BI=;
 b=tr02fLM765aV0nVHrbfaTOAChWaf7IF4hE2H4CCWm2tpoludLpWqbUQZnJlq1U98Z8pvyU8lV2PqU9b1ybIdmF2ZY0eicxHqY1tGHTh+0YQpH+qj7Pm1ntX9skGWn6MCetgi5NFrvMQzgnSGhVEsIedJ1M3YWICBjxI0Etunpf5nQkX/Ioc0FaWm7aVGCkw7sgnbqgRmKB+UFMCzfVtX/gpD1KbQkXl7MpqQS8HiL2F5wPma9LUI/QVlXOshgQUOUtBITwEbR9drGO5YwBxGg50ygtY4WYbHD4N7g4jq9dgreJAZb7/58s+qFRMAWmraU3Ui5dy6t6XDvhd6P0Gcyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3564.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:136::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Fri, 8 Mar
 2024 11:44:50 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 11:44:50 +0000
Message-ID: <31bf9be7-30c7-4717-a34a-9d0477607f55@siemens.com>
Date: Fri, 8 Mar 2024 12:44:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][RFC v1 4/6] Add Delta update support with
 rdiff_image and delta handler
Content-Language: en-US
To: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>,
 cip-dev@lists.cip-project.org
Cc: shivanand.kunijadar@toshiba-tsip.com, sai.sathujoda@toshiba-tsip.com,
 dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20240307074612.1996609-1-Adithya.Balakumar@toshiba-tsip.com>
 <20240307074612.1996609-5-Adithya.Balakumar@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240307074612.1996609-5-Adithya.Balakumar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0143.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3564:EE_
X-MS-Office365-Filtering-Correlation-Id: 1340ef4f-a6c4-4c2f-ddfd-08dc3f6529aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	s6YGp5Hbajj2u0Q+tInM8ZXPfTDB9i5F+fc2zwpp86cyrUIs6PUVPLfGYacp5cM7OdlfIsm7qctgYF8Spzpx2mN2KfB3r2kdUsbUmaiMIHOWogobgEC7PUMUOoTTlt5cid9gWuXkOjuiNJmAcTBEM0bEFUATxIue+dJCohWY1buTxGuEnpRsR5aoadT98w3xqq+jawtem8jZEXwz6AY6mxjr4w9+9QklT1yQQ8dkyCWDckp6iba06hZkZNxa851FdCGOtsxcPrEgrhdU919j2yynDpXxSalYITOASzZsB5lIRZL+ic/0RmyIJVkfdNX/zSlI7lWhRXrhNQSkteV7GaV5a96OUgMhWzJ8FG75koAEniQHVANZoaXRJsu1dezA7kebfOnkqnz6DQxq29mgO77QiyL8octN1OIDfnoXiWCi/qA2d6z5rvqwLGilsP7exIPxkoU2ryhCcEsSQN+mtUNdLJxQi85MVDen2Sz6lPqdy8rbPmWahhfHFFJpMBJbokfBMQuvWkp9zIlU+awzLirwvWAO/rqvHWtu6swsZMkdGXDhNtKBEX4Zu9SIJ75BsMydnTVzf7ppefsuvl517e1M+V2CZHaBHfTJdbjrvLjlMP2doHWHo8LQTcd1PCngdTjB+b7gRNpuAeb82oQKpqgQlu4gdSj90tKqEkNFnxk=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Q1pHazdHV1o1REhJN3ppV1drVWJrcTZaNm1jNDAydWhqZ1AxR0c4TW9qc1Y0?=
 =?utf-8?B?RmtEQTl2b1E5TGU4cnBBYmN2RGZ1NHBDZkhVWE43ck94UTQwdENseDUxWkJP?=
 =?utf-8?B?bFdvc1VIVnFxYTJmdmc2RDNuM0NGMGY5Tzd4RHRSeXNHU3ZSNG9oR3d6Sllz?=
 =?utf-8?B?dnNSV2ZUVklaS1BrdzVzNVo0TUN0WHdBYjNZTjR4WW9ZSW9TSDdueGNoOVNS?=
 =?utf-8?B?Yk4vemJLZFVjWDRLS200blFud3ZtMUNTenZzRmxPcE8xckVvdFdMOWdkSjR0?=
 =?utf-8?B?YzZwNzVSbUNEbU04QXprWjg2TXpIbThDanVXUSs0WGh2S1Y2VTdrR3pCUGhK?=
 =?utf-8?B?UFMvbjg2Mm1CM2E1U2RvWnUvS0p3S3MvVWtXVzBCVXdEbTBwQ0dsN0w4bEE2?=
 =?utf-8?B?Z2lwWThIYmtrSlZZa1dmTytlQ0swR21uU0tvaU94ektFT1B4ZE1yN212MDc2?=
 =?utf-8?B?eUJhR3lndCs3M2RPU2RYS2JDazhqSHozNmE0eTNQQko2Nlp0UEl3V1BkaFcy?=
 =?utf-8?B?c1dhZzBnNnR3TnFjS0lQRFJhMGJOOUgrdzkvTmhYNzNnWVQ4c2dHWDNjSDZP?=
 =?utf-8?B?ZWRpVDlWNWVmNXBQUWlXNmEzbUdpWEQwcHFpTnJIMm13ZGRaOVlNMDcwVlZV?=
 =?utf-8?B?UHBERDROamdEVDR2MDVrREhZdHZ5dWFkeFd2UHRrSHMvNUpHV2ljZ2RmSSsx?=
 =?utf-8?B?REsxeXN2cnV5cHBTOGlQYzVkVlR1amwrVjNsL1N6bUVobCtKNXR5R3dLMk94?=
 =?utf-8?B?NFg5cTh4Kys5NktDR2V2WDVWODdlRzZ2REQxN0RLcFMxSkRhSnUyMTl2TXF0?=
 =?utf-8?B?VjlsNlZzeXVmOEZSeWR1cVBUMW12NGxwZ1RPbUx4bVBBTGNVYXdTWlRZbU82?=
 =?utf-8?B?Ym9RZCtidUNqdWFEenVrdnJLL1c1Mk8zdzlLTlVqN3JNd3dLVG1JazdaNG9S?=
 =?utf-8?B?NXdPemJ4TEpFMmdteFpjQzlubEVXbUo2Ylo3M0FBOE1ST2EwUXRHM001TThM?=
 =?utf-8?B?eWxqWExkWUN6VFZpQ05XT2t4elVOaUlNRkFLbDVYd0E3alFxcmJvNUVuUFcr?=
 =?utf-8?B?ZE85R3IxTkxSanlDR01jcFJQNlFVeStiSk1OdmJ6d28zbzc1cTNNOTlCa3Ax?=
 =?utf-8?B?OWV3dEtQQzdhRVdxVll0cGVkR0Vpc1lmWUJvVGViTFgrRms0MzBwb3FEeXJh?=
 =?utf-8?B?bStndGZ4cGl6YXRiSnNzVlArMGhOV2Ridk15emhOUWhXc3g1ZCtHOGYzdldv?=
 =?utf-8?B?bFA5K0hIRkg4VFo0d0YwaDVxYkF4Wkp6UWoreG41TndCNTQ1ay9GQldWWCt0?=
 =?utf-8?B?ZGRmMnAwMlk4UEgyanVndXdvUmRiZktCWWo4WWpzelFOb1Q1RUsvaUt2bE9h?=
 =?utf-8?B?ZHNveVNkNS9yb0loOWZ2bkpLNXkyZFlReXFEZy9ybVl4RWszUUNQejVSUzZt?=
 =?utf-8?B?QStuTVdSa2tmZHVXclh2L3p1dkVWZlRCMVBrNFc1U2VlRUxXT2RwRjVuY0xY?=
 =?utf-8?B?RjJFYUFLNGlpTjdpcWdySURDNVNFbWI2TkNvS3k3Z1I0R1RRUk5sMjhjaXYy?=
 =?utf-8?B?dStBSXcrUGZaSnlUTzl4eTFmVm4yOHVnNjZ5WkFWYmZKNDJZK0NvNlh2TnVl?=
 =?utf-8?B?NnN4RmZsanpTcVhmM083ZEJxSXpBY1NXdUZid0gvWVRrdmg2d0RJdVNVYmE0?=
 =?utf-8?B?QUdESFdnWmtMSzN2UWU2dnBGSlY1Ym9MRURxd1pjamEvYmwxbTlJTWE3Y290?=
 =?utf-8?B?c3VlQU9RS3ppdlluU0h0RUhoa29YbE1NVlJmT3ZsN21QMHdCSWQvWmFCbEJN?=
 =?utf-8?B?eGhxczJrS0k4MGhmRTR4ZlROd1A2V20vQ2ZPOC85U3ZiL2V3SllBT0pYRVo1?=
 =?utf-8?B?YWZxdHl4N3d1MTB3UXByTWJ4Q2JFaUQ3dmRhWEN2cmhsWGdUSGQzN2M0SFZr?=
 =?utf-8?B?M012OHZOZ2lPdmsvL0VJYS9tVDFFU2lBNUQrT0NIWjJVMUlaeFF5UDdQUXVT?=
 =?utf-8?B?SXBoVklPaHVDbkMrcXIxdWdyRjcybDNKNnpvanVDTjlRN0hCOFIzNDNWaHc1?=
 =?utf-8?B?elQ4clk0L3FIYlR0RHNXRUk0UXhjQm0yRHE0ckcrYWRuQ2VUZkRIT3cyYWRk?=
 =?utf-8?B?aFcwZlN2T2Q3Q1NzRUJYdW45bFZWWTNPcCtDalRZeXFTT09ORkE2RlpISmk0?=
 =?utf-8?B?aVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1340ef4f-a6c4-4c2f-ddfd-08dc3f6529aa
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 11:44:50.4065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BhphQdRhu+sTlnxH1D2ByCvOKWI+AcxYLmZwFbIO9/yFgq1oNBixoCIUhmKEoYj2GWVTznSBXbM5Q100gsIhYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3564
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 08 Mar 2024 11:44:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15266

On 07.03.24 08:46, Adithya Balakumar wrote:
> swupdate supports delta updates with rdiff_image and delta(zchunk)
> handler. This change adds support to use either of the handler
> for creating delta update artifacts. The type of handler can be set
> in the delta-update.yml file along with additional variables needed
> for the chosen handler.
> 
> Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
> ---
>  classes/delta_update.bbclass | 90 ++++++++++++++++++++++++++++++++++++
>  kas/opt/delta-update.yml     | 21 +++++++++
>  2 files changed, 111 insertions(+)
>  create mode 100644 classes/delta_update.bbclass
>  create mode 100644 kas/opt/delta-update.yml
> 
> diff --git a/classes/delta_update.bbclass b/classes/delta_update.bbclass
> new file mode 100644
> index 0000000..8d47081
> --- /dev/null
> +++ b/classes/delta_update.bbclass
> @@ -0,0 +1,90 @@
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
> +IMAGER_INSTALL:delta_update += "fdisk zchunk rdiff"
> +
> +FILESEXTRAPATHS:append = ":${LAYERDIR_cip-core}"
> +IMAGE_SRC_URI:delta_update += " ${@ "file://"+d.getVar('DELTA_RDIFF_REF_IMAGE') if d.getVar('DELTA_UPDATE_TYPE') == 'rdiff' and d.getVar('DELTA_RDIFF_REF_IMAGE') else '' }"
> +
> +do_image_delta_update[cleandirs] += "${WORKDIR}/delta_interim_artifacts"
> +
> +extract_root_fs() {
> +    INPUT_ARTIFACT=$1
> +    OUTPUT_ARTIFACT=$2
> +    SECTOR_SIZE=512
> +    ROOTFS_LABEL="primary"
> +    ROOTFS_START_SECTOR=$(${SUDO_CHROOT} /sbin/fdisk -l -o Name,Start "${INPUT_ARTIFACT}" | awk -v name="${ROOTFS_LABEL}" '$0 ~ name {print $2}' | head -n 1)
> +    SKIP_VALUE="$(expr $(expr $ROOTFS_START_SECTOR \* $SECTOR_SIZE) / $(expr 1024 \* 1024))"
> +    ${SUDO_CHROOT} /bin/dd if=${INPUT_ARTIFACT} bs=1M skip=$SKIP_VALUE count=1024 of=${OUTPUT_ARTIFACT} status=none
> +}
> +
> +do_delta_update_sw_description_template() {
> +   # Since the sw-description file for delta update would not be very different from that of a 
> +   # normal update, copy sw-description.tmpl as sw-description-delta.tmpl and add delta update 
> +   # specific properties
> +   SWU_DESCRIPTION_DELTA_UPDATE="sw-description-delta"
> +   cp "${WORKDIR}/${SWU_DESCRIPTION_FILE}".tmpl "${WORKDIR}/${SWU_DESCRIPTION_DELTA_UPDATE}".tmpl
> +   sed -i 's/\SWU_ROOTFS_PARTITION_NAME/SWU_DELTA_UPDATE_ARTIFACT/g' ${WORKDIR}/${SWU_DESCRIPTION_DELTA_UPDATE}.tmpl
> +   sed -i '/configfilecheck =/a \                      \'$'{SWU_DELTA_UPDATE_ADDITIONAL_PROPERTIES}' ${WORKDIR}/${SWU_DESCRIPTION_DELTA_UPDATE}.tmpl
> +}
> +addtask do_delta_update_sw_description_template before do_transform_template after do_generate_image_uuid
> +
> +IMAGE_CMD:delta_update() {
> +    if [ "${DELTA_UPDATE_TYPE}" != "zchunk" ] && [ "${DELTA_UPDATE_TYPE}" != "rdiff" ]; then
> +        bbfatal "You must set a valid DELTA_UPDATE_TYPE (rdiff/zchunk)"
> +    fi
> +    
> +    DELTA_ARTIFACT_SWU=""
> +
> +    if [ "${DELTA_UPDATE_TYPE}" = "zchunk" ]; then 
> +	extract_root_fs "${PP_DEPLOY}/${IMAGE_FULLNAME}.wic" "${WORKDIR}/delta_interim_artifacts/${IMAGE_FULLNAME}.raw"
> +
> +    	# Create .zck file
> +    	${SUDO_CHROOT} /bin/zck \
> +		--output ${PP_DEPLOY}/${IMAGE_FULLNAME}.zck \
> +		-u --chunk-hash-type sha256 \
> +		${WORKDIR}/delta_interim_artifacts/${IMAGE_FULLNAME}.raw
> +
> +    	# Calculate size of zck header
> +    	HSIZE="$(${SUDO_CHROOT} /bin/zck_read_header -v ${PP_DEPLOY}/${IMAGE_FULLNAME}.zck | grep "Header size" | cut -d ':' -f 2)"
> +    
> +    	# Extract the zck header
> +    	${SUDO_CHROOT} /bin/dd if="${PP_DEPLOY}/${IMAGE_FULLNAME}".zck of="${PP_DEPLOY}/${IMAGE_FULLNAME}".zck.header bs=1 count="$HSIZE" status=none
> +
> +        DELTA_ARTIFACT_SWU=${IMAGE_FULLNAME}.zck.header
> +
> +    elif [ "${DELTA_UPDATE_TYPE}" = "rdiff" ]; then
> +        if [ -z "${DELTA_RDIFF_REF_IMAGE}" ]; then
> +            bbfatal "You must set DELTA_RDIFF_REF_IMAGE and provide the required files as artifacts to this recipe"
> +        fi
> +
> +	# Extracting root partition from image1
> +	extract_root_fs "${WORKDIR}/${DELTA_RDIFF_REF_IMAGE}"  "${WORKDIR}/delta_interim_artifacts/old-image-rootfs.raw"
> +	
> +	# Extracting root partition from image2
> +	extract_root_fs "${PP_DEPLOY}/${IMAGE_FULLNAME}.wic"  "${WORKDIR}/delta_interim_artifacts/new-image-rootfs.raw"	
> +
> +	rm -f ${DEPLOY_DIR_IMAGE}/${IMAGE_FULLNAME}.delta
> +	# create signature file with rdiff
> +	${SUDO_CHROOT} /usr/bin/rdiff signature ${WORKDIR}/delta_interim_artifacts/old-image-rootfs.raw \
> +		${WORKDIR}/delta_interim_artifacts/old-image-rootfs.sig
> +
> +        # create delta file with the signature file
> +	${SUDO_CHROOT} /usr/bin/rdiff delta ${WORKDIR}/delta_interim_artifacts/old-image-rootfs.sig \
> +		${WORKDIR}/delta_interim_artifacts/new-image-rootfs.raw ${PP_DEPLOY}/${IMAGE_FULLNAME}.delta
> +
> +	DELTA_ARTIFACT_SWU=${IMAGE_FULLNAME}.delta
> +    fi
> +        # create a symbolic link as IMAGE_CMD expects a *.delta_update file in deploy image directory
> +        ln -sf ${DELTA_ARTIFACT_SWU} ${DEPLOY_DIR_IMAGE}/${IMAGE_FULLNAME}.delta_update
> +}
> +
> +addtask do_image_delta_update before do_image_swu after do_image_wic
> diff --git a/kas/opt/delta-update.yml b/kas/opt/delta-update.yml
> new file mode 100644
> index 0000000..c7a3893
> --- /dev/null
> +++ b/kas/opt/delta-update.yml
> @@ -0,0 +1,21 @@
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
> +header:
> +  version: 14
> +
> +local_conf_header:
> +  delta-update: |
> +    IMAGE_CLASSES:append = " delta_update"
> +    IMAGE_FSTYPES:append = " delta_update"
> +    DELTA_UPDATE_TYPE = ""
> +    DELTA_ZCK_URL = ""
> +    DELTA_RDIFF_REF_IMAGE = "" 

What prevents making this the default for generating update images?
People could still add their own options or local configs if they want
to deviate. Would also simplify patch 6 further.

Jan

-- 
Siemens AG, Technology
Linux Expert Center



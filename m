Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E4EC54E41
	for <webhook@archiver.kernel.org>; Tue,  5 Mar 2024 14:17:44 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.88])
 by mx.groups.io with SMTP id smtpd.web11.24111.1709648256074283364
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Mar 2024 06:17:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=gkYgCetp;
 spf=pass (domain: siemens.com, ip: 40.107.20.88, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NNnT/9u9Evy/V7OkJwAdGS4r0vawBidHjePdQrHFxiAx/w4IeyeOdISOwCQt9N3F99X9LfAgUbNMV5McV7rvM+NUrNlPGo6JRXLrBXiGYhhoMNX+78KhvoPpyBeT1t7EndTtBMVOEfIkGog8Ywx9zalCAA32nCx2VdAol4nEgaWVjHcBig0fEENsJtFyoo8e4sqpwTGf+gw645KwILbfL4LeEURzk8w8qLifganFyWPmBodgrkysE6L/A3ipwHmKX1NvHGDBoPjgZ9F7lBobLeoJXNChsDnnUNhry0eJPU726ckwrALQVn66mTALzHKX0fFwiJ/A5A/C6HkWWLjd5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Mn753CBDwThWnEk/6WcFk+qggyXwuo51ft48bgLR8k=;
 b=NOhrxX14O5GiFajCOl6SrzAEUluMSxQPuGJso349RhWLQgx5+gcaCg0mtGICQ7OLoccvyY9pr674HZUDERIkUt7KIkdMvAVzBRqYAEn2wizfE9dSptlkQCkZVzCP54SKqGav/jFcCVF0adMwL2kbAM2kndutFH9xlLCje3C5rQJ/Ou6JWxCF0hHmAqUx4NiYyhb4TEs3K2rtObC4dXcl0YXL+/uNT8fYaO17KFKa+Tfcrzu2wBsu58vDclIMH8jxdOGt01tTKp7lsvsNl0EDij6vQuu5s3HRizBa2dk7rlAF4t7ThyXwt+yEeImg3afsuSmJjKJcNb1kdxwEnQq/Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Mn753CBDwThWnEk/6WcFk+qggyXwuo51ft48bgLR8k=;
 b=gkYgCetpPw2/2twitNBsABexCKeZcLNC5YY5l9IsGjma3Jojh1c+v78cN2aYTBKLNYRezjx5YwVoQT68BgfgccnsdoXx8enZncBC4AVHn2RXVrBsoqxa2T4KxxSlXgCkeILqfS8MuZ9M9fFLecEdva0ji+FYwHWlnK5EKXjP0gqLO6dRvUuvApwgMYh9wk7mAGZTIQ+9iljpp1sFujK+FOtSwmHVrHh0RJu/9cAG9TxFAfgR6cWXhoIuT38GamKoXLFdrbfAmJfuW0AovN/bUO5e/kmWQPcJwARLIGisLc6insYTZp1rsdPI8TC7fES/E2Eh1/NZjGinafcJQeHbVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3489.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:15c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Tue, 5 Mar
 2024 14:17:33 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 14:17:33 +0000
Message-ID: <13f6bab4-0b95-429a-b6e5-b4859a111bc2@siemens.com>
Date: Tue, 5 Mar 2024 15:17:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 4/4] fix do not add files to
 each image recipe
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, felix.moessbauer@siemens.com
References: <20240305110311.2073425-1-Quirin.Gylstorff@siemens.com>
 <20240305110311.2073425-5-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240305110311.2073425-5-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR12CA0008.namprd12.prod.outlook.com
 (2603:10b6:610:57::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3489:EE_
X-MS-Office365-Filtering-Correlation-Id: cc3a5971-d769-4dda-0824-08dc3d1effff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ixqIgeEr8mJ5vG56ve7r1uKWbgrF+eEUKyTdVYL3iJ3olufyv3OGft+Ph4cTd4YNKaMRtmEh25MODhEe9EOKyGcn5uoV07CGIIbT3a2CqAH8tdvRmrPhtj6s15G8zqoGzUeZzR4jOH8TSwaikw3l7O6xx1B9gEzJKJKF0C4a3aRIwvhOMSz2KVlJaUnC92HKyx/220AfWqwYbU1TyWAieQlaKxk+hWI3HrkzohRSNJfyif16v1dER3dk6+W+FiQVHj6/MyvHszVuiNONbK142jSg+87aaLV2tD6Dn+P1t8AYc19l6ebadccmyUVru/s67izObQNG+TcMSZOw5ObIENR7Rs3lSxiS4v/z4XLF9cS2ZRz8Wp1KkAHaMhSSRKlwdS1vfuk7X6nCjG8JWiWKM4aRYxD8HtBMQMxbdxOYP1fB05UmZFTEjWOETsoU9PA4eGUJYPWs8rvgUGmJefxSnHXroWaoaqGn9R0k35RIhlYhG/nOvyz5PLI8guzpsl0LOz/toJMVMFMoqWWEAS780qrx0X0aeWXH68Cx1lMmpaG7ihrRybI+10b/F3MQq7KMpFDSTllfiHnm5v3AcP2Dpk0SiNxPecGVpYr37IJ4FtHK7Im8eXT2tPDx4tJqGwSJy7ZWdtkzwRYZuE1/5Q8+7/2p2hiHwlTeQsMVazDCG3Q=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eHQydXY1VXEwZXpMdzlwNkxHNkNJY3hJbzU3aS9oUW42ZFZ6MTFtUFROWUd0?=
 =?utf-8?B?aWZpL1h6ekJGalZkQ2dCUGJNZEpaQmlYNHlxdTJFVzlvbml3OGpwT3U2YTFZ?=
 =?utf-8?B?a0dNZlg5NUc5ZEswRklmUkY3YmRoZk0vc29rWCs2Q0dabmpNOTFHT2JKZ1B0?=
 =?utf-8?B?VTYrWnp1RFlqMEJtam0xOS9BbWNXRzN5dXdBK3E1RFJMcE1BR3pMczNBM0Q4?=
 =?utf-8?B?cGJTbHZmeWtncnVsS0Z0MDdrUGhWQWpLemtNNTd0clhmSWtlUkxyYXR5djV6?=
 =?utf-8?B?UUxxcW9IK0dia3BGUHcrYldUWmp4aTdKTm9FV0xzTVhVVFFyb2hMdEROcU84?=
 =?utf-8?B?TGNZczdCMVBTbWRKR0ZDc3FQdFgrVjI5Z3N2M0RURDhHMU1zdUlKUks5Vkgx?=
 =?utf-8?B?cVhsRk1UaDN3a0J2WWpHZ2MvVWJsWGNzLzZpQy9hY3N0NU1ERGJqOUozaTY4?=
 =?utf-8?B?MU1QYWVkWFZNWjJZRVZrNDFGMmJsVEVIc0MwRU1CeEZBV29SOWl3YXRYZmE0?=
 =?utf-8?B?eVdheUpucStCWWd4S0p6UHZUTm1xeS9uQUJ6MHJZVzQ3WmN3RnlnVG53ajYy?=
 =?utf-8?B?Zjc2TG9qT1hQdWNZdFRlQUFGWjlETDZnZFA5Z0FtU1BPb3ZpTjkrOVlwcE9I?=
 =?utf-8?B?QURmaWhVSEpxVGljUUdBcHlDTllpTlJYOEFZTXZBTmRpYnRlWUFIVXZBWGQ4?=
 =?utf-8?B?WURGcmN1MUdmQ0JBMmhBRWJlTzBIR0M5ZHFZaEhRVmp4S2F3TzROY0lOOUFF?=
 =?utf-8?B?VFNucy84OG1idlBuNUNRbTR3TnVDekp6L0tmNldrSXFhMWFnd0dZQ0hVL3Bq?=
 =?utf-8?B?ZHQzRFJBNC9YR3BzRHlrUUgzNDg4RnZoN3JTZmpPbDlVWklUd29RYmdRNTFB?=
 =?utf-8?B?Rzlvc0dBSTRONXR0elp4YTlpYXlpdjlIcG5CNWRlT0JqLzQyTFBnNlFRaU1v?=
 =?utf-8?B?Y2p5Zm1yQWUyZTlHVU9mczhCUVhzQWtEZ1NyMUpNNEVTSVhlU2hVZ0dUNi9D?=
 =?utf-8?B?Mzh2Ynd5VmlKQXI0ZklHalA1Q3RqUVpzQWRTbGUwenFjUmFZcVFFV3N2Wkl2?=
 =?utf-8?B?cUo1aDAvUFlVazNZWkRNdUw1K1dJT2tGc1JQVVhtdDFjMWU1VGY0U3V2Q2Ju?=
 =?utf-8?B?ZlFEQ3l5VFBCc1pELyt5S2JQc3MwOWxOYXFUZCtuNEJVUld4akdrS2MxQUcz?=
 =?utf-8?B?dFpvWWlFVndsRGNZb1V4WFZ4L0w2MXBGOC93R21jQ0pQUDRNMG5FTWJLNlFI?=
 =?utf-8?B?SGQ1WEtYbUUxR2orbjNtZzd2TzMyQjUxZzQyZFBVcDBJTjNFY3grY2trZHJE?=
 =?utf-8?B?RWVmbUUrbzdUZlFiOXJmQTVxNEVoRVhVQ3M3YXRjWEVzcEFmVkNaMmhRek41?=
 =?utf-8?B?QjRINkRzcm5hM2ZabFZDMkpHOVQ2V3pHTU9hbnQzR010djkrcUFRbDJubEto?=
 =?utf-8?B?RmJEZkgyVEpDLzVIdW4yNktjNXZVeEhZSldVM2hTYjZkMzZ4MVd1WTZJaVlh?=
 =?utf-8?B?NDVEbHFNSjNtcUlsU1p1dDhmcHExamdkdnRGNldlT3ZZbGZlbGszVkdFU1N3?=
 =?utf-8?B?d1ZRcFI1UjRRS0FFVUhIc1dLYUxQODBBQ3ZiVUFzME9JM1NhNWZDNjJLZEpr?=
 =?utf-8?B?VmZqalVwNWVtZkFlY0E0NG4zd2x3ektQUDNSWFZuZ25sSm1DNUhHSTBxYXVL?=
 =?utf-8?B?SWFhWVVBRnY0dXV0M2NmcW9HRWoyeHBIbkNhMzRwd3pUNnhKK2QxdFR4dFcz?=
 =?utf-8?B?ZGFRUzJjcENiS1BlSmRhcTJDUE1pbERXVXhEYzYveTVzaXVrQlR3YjN1OTJF?=
 =?utf-8?B?dVNXQytBT0drT0lMdytEWWlpVzN5WGJSd0c1NGdPMlJXSUo5MlZkYm9aK0Fi?=
 =?utf-8?B?S3hmbGw5V2VETmxCV29mNmNXdVpGM05XejMzK3Q4Z1l4dGY0M3JrWDBnVXh4?=
 =?utf-8?B?NkFYK2I5QWRyV0s0RFhKU2haaU5Manh5SGlUUVdTOGtzSy8yOXJxZS9IaFdG?=
 =?utf-8?B?ei8vWlAwb0xkMVZxRTdNM2ZzNWg3SGRMdFRTQ1lFQVYxc0IrQURpWTl0dWZQ?=
 =?utf-8?B?Tld0bk5vak9aQ09kWTRUZlkyZ0FIVkNsZ2xBTEkwSUIyVUpWQS9FNnpDYUMr?=
 =?utf-8?B?TTJHNTZiSVo5M1ZkNlErSzNXWXhicXRWVXVkZlFjaXdLQUVGTWZJeUR5K24v?=
 =?utf-8?B?Snc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc3a5971-d769-4dda-0824-08dc3d1effff
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 14:17:33.4599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yd2vrxQ2hi2yGAeah5coEgDMloyXNiGNXia1HVJJSreJMLtCDmjuPJ3tzNdX97gf9Df1RSs1Vzb7OCFn712hOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3489
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Mar 2024 14:17:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15227

On 05.03.24 12:02, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Due to the use of an anonym python function each image recipe was

anonymous

> partial build even if not requested.

built

> To avoid this remove the anonym image function by adding

anonymous

> it as an prefunc to do_image_swu and do_transform_template.
> 
> The SRC_URI is appended with a function.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  classes/efibootguard.bbclass |  1 -
>  classes/swupdate.bbclass     | 42 ++++++++++++++++++++++++------------
>  2 files changed, 28 insertions(+), 15 deletions(-)
> 
> diff --git a/classes/efibootguard.bbclass b/classes/efibootguard.bbclass
> index 31fcdcc..2b4f09e 100644
> --- a/classes/efibootguard.bbclass
> +++ b/classes/efibootguard.bbclass
> @@ -67,5 +67,4 @@ python add_ebg_update(){
>     ebg_update = d.getVar('SWU_EBG_UPDATE') or ""
>     if ebg_update:
>       d.appendVar('SWU_FILE_NODES', "," + swu_ebg_update_node)

Indention looks fishy, but that is nothing this patch caused.

> -   d.appendVar('SWU_ADDITIONAL_FILES', " " + efi_boot_loader_file)
>  }
> diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
> index c62f43f..c82d20c 100644
> --- a/classes/swupdate.bbclass
> +++ b/classes/swupdate.bbclass
> @@ -63,7 +63,7 @@ IMAGE_TEMPLATE_VARS:swu = " \
>  # TARGET_IMAGE_UUID needs to be generated before completing the template
>  addtask do_transform_template after do_generate_image_uuid
>  
> -python(){
> +python do_extend_sw_description(){

() {

>      cmds = d.getVar("SWU_EXTEND_SW_DESCRIPTION")
>      if cmds is None or not cmds.strip():
>          return
> @@ -71,6 +71,7 @@ python(){
>      for cmd in cmds:
>          bb.build.exec_func(cmd, d)
>  }
> +do_transform_template[prefuncs] += "do_extend_sw_description"
>  
>  SWU_EXTEND_SW_DESCRIPTION += "add_swu_hw_compat"
>  python add_swu_hw_compat(){
> @@ -94,9 +95,22 @@ python add_swu_compression(){
>          d.setVar('SWU_COMPRESSION_NODE', '')
>  }
>  
> +def add_scripts_to_src_uri(d):
> +    swu_scripts = d.getVar('SWU_SCRIPTS')
> +    if not swu_scripts:
> +        return ""
> +    swu_script_entries = swu_scripts.split()
> +    script_file_list = []
> +    for entry in swu_script_entries:
> +        script_entry = f"SWU_SCRIPT_{entry}"
> +        script_file = d.getVarFlag(script_entry, "file")
> +        script_file_list.append(f" file://{script_file}")
> +    return ' '.join([n for n in script_file_list])
>  
> -SWU_EXTEND_SW_DESCRIPTION += "add_scripts"
> -python add_scripts(){
> +SRC_URI += "${@add_scripts_to_src_uri(d)}"
> +
> +SWU_EXTEND_SW_DESCRIPTION += "add_scripts_node"
> +python add_scripts_node(){
>      swu_scripts = d.getVar('SWU_SCRIPTS')
>      if not swu_scripts:
>          return
> @@ -129,8 +143,6 @@ python add_scripts(){
>            sha256 = "{script_file}-sha256";
>          }}"""
>          script_node_list.append(node)
> -        d.appendVar('SWU_ADDITIONAL_FILES', " " + script_file)
> -        d.appendVar('SRC_URI', f" file://{script_file}")
>  
>      swu_scripts_node = "scripts: (" + ','.join([n for n in script_node_list]) + ");"
>      d.appendVar('SWU_SCRIPTS_NODE', swu_scripts_node)
> @@ -155,6 +167,7 @@ FILESEXTRAPATHS:append = ":${LAYERDIR_cip-core}/recipes-core/images/swu"
>  do_image_swu[depends] += "${PN}:do_transform_template"
>  do_image_swu[stamp-extra-info] = "${DISTRO}-${MACHINE}"
>  do_image_swu[cleandirs] += "${WORKDIR}/swu ${WORKDIR}/swu-${SWU_BOOTLOADER}"
> +do_image_swu[prefuncs] = "do_extend_sw_description"
>  IMAGE_CMD:swu() {
>      rm -f '${DEPLOY_DIR_IMAGE}/${SWU_IMAGE_FILE}'*.swu
>      cp '${WORKDIR}/${SWU_DESCRIPTION_FILE}' '${WORKDIR}/swu/${SWU_DESCRIPTION_FILE}'
> @@ -165,13 +178,14 @@ IMAGE_CMD:swu() {
>      for swu_file in "${WORKDIR}"/swu*; do
>          swu_file_base=$(basename $swu_file)
>          # Create symlinks for files used in the update image
> -        for file in ${SWU_ADDITIONAL_FILES}; do
> -            if grep -q "$file" "${WORKDIR}/$swu_file_base/${SWU_DESCRIPTION_FILE}"; then
> -                if [ -e "${WORKDIR}/$file" ]; then
> -                    ln -s "${PP_WORK}/$file" "${WORKDIR}/$swu_file_base/$file"
> -                else
> -                    ln -s "${PP_DEPLOY}/$file" "${WORKDIR}/$swu_file_base/$file"
> -                fi
> +        swu_files=$(awk '$1=="filename"{gsub(/[",;]/, "", $3); print $3}' \
> +            "${WORKDIR}/$swu_file_base/${SWU_DESCRIPTION_FILE}")
> +        export swu_files
> +        for file in $swu_files; do
> +            if [ -e "${WORKDIR}/$file" ]; then
> +                ln -s "${PP_WORK}/$file" "${WORKDIR}/$swu_file_base/$file"
> +            else
> +                ln -s "${PP_DEPLOY}/$file" "${WORKDIR}/$swu_file_base/$file"
>              fi
>          done
>  
> @@ -186,7 +200,7 @@ IMAGE_CMD:swu() {
>          export swu_file_extension
>          imager_run -p -d ${PP_WORK} -u root <<'EOIMAGER'
>              # Fill in file check sums
> -            for file in ${SWU_ADDITIONAL_FILES}; do
> +            for file in $swu_files; do
>                  sed -i "s:$file-sha256:$(sha256sum "${PP_WORK}/$swu_file_base/"$file | cut -f 1 -d " "):g" \
>                      "${PP_WORK}/$swu_file_base/${SWU_DESCRIPTION_FILE}"
>              done
> @@ -205,7 +219,7 @@ IMAGE_CMD:swu() {
>              fi
>  
>              # sw-description must be first file in *.swu
> -            for cpio_file in $cpio_files ${SWU_ADDITIONAL_FILES}; do
> +            for cpio_file in $cpio_files $swu_files; do
>                  if [ -f "$cpio_file" ]; then
>                      # Set file timestamps for reproducible builds
>                      if [ -n "${SOURCE_DATE_EPOCH}" ]; then

Jan

-- 
Siemens AG, Technology
Linux Expert Center



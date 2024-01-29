Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5501FC47422
	for <webhook@archiver.kernel.org>; Mon, 29 Jan 2024 12:31:06 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.86])
 by mx.groups.io with SMTP id smtpd.web10.13583.1706531459482020521
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Jan 2024 04:31:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=SRmP4HpM;
 spf=pass (domain: siemens.com, ip: 40.107.21.86, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U/gHl0LohJ/PMX83MFfSbT8VRVYKrHv8+ZQPyC7OkHyLlqXNc0+zQma64GSirkodRs43atTVSiFngLyuQvAYL3JaJMhEBzk95ho0Y9H64KNkiu510TF9lie88w3piBrMWAkF+dhBohBcifisaVpVDlLKJN1t6FAiivOPi1AJG0z2wHaNxgzlSXrLHiG6xj1AUGfuaFFByPLRGGRn2wurnv3R2sUdT2SOt66PKYJ3cjiWsA6DOK73OyDjx9K8sNkSImjWbtnV+T1Fj7n/9JP2arZxblCa7yIpOFVru1wsJUtH2mUSgSyukCfXs3wl9xpLBXmozymV0UltobcjIMGAzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZQGcz8lNwMdln0kJ7TAI77buT4FYYLqGDBG6wlW2ei8=;
 b=QmoLxMQcSkpj2hkQzfXvM0jLx67Kl6jnoLuD36APuB6rFietbyPUfuj/0pMd60lV/Ks6h6BPvOCVo0ODhAF8/YzCm2+zEWM1Gn4MR3doUfmgMRpgYCs8E33O5856WyUxYgaIbas3WRgmNunAIBcL2BP68/ck8amqPp2sz7LDlGJ/ivx8lyXJpWPH9XdG6SGlbnscHgTTTp6eUdh62gMfY9NlTXWgxXQBlrJ9pIaf2SDKq0hTQhq2+S6SMg7Mwu4RpeA8qTIXdlHP3hYWOPaTOcc8L2m8lHgGDOAzNsGS5G40GmBhuSi5VwpwEepqSNKrITJ1Ktf2HQGeOeXRajX++w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQGcz8lNwMdln0kJ7TAI77buT4FYYLqGDBG6wlW2ei8=;
 b=SRmP4HpMErp7og83ZohfHanH28fz+mj8qm7ASJTG3M7SBUN8J92WSh7xySdIOr3LIhZed4yJ4Q07W6d4bO4JN002j2VkB6W+rrSiVJ6hfg/vU/cQO6hm2ps4aCYu7AfDYIbzRxbGaaivVg19AE5FFg9YHVoTkZgPKf+MbQGS/KLfMFYrvKeUBSUmGVd5zvnnWePyk83QGrwCn9txlzaAmE4+zZWcpFSMxC5KRnDo44TtR/qSBOePMyu11/O/8t3ZQnK26lx/Xy047D/I6cWzKz67GhQK59N/fHH2gqKM7CiLyRiJZwldnXKP0Gnb+BHfcTJTr/0n+Xk/7FMEi1MX9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5701.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:319::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 12:30:56 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 12:30:56 +0000
Message-ID: <03a41361-fab8-4516-874e-a57198c8bb96@siemens.com>
Date: Mon, 29 Jan 2024 13:30:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2] swupdate.bbclass: Move
 ebg_update to efibootguard.bbclass
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 felix.moessbauer@siemens.com, cip-dev@lists.cip-project.org
References: <20240126172011.1590119-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240126172011.1590119-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR14CA0026.namprd14.prod.outlook.com
 (2603:10b6:610:60::36) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5701:EE_
X-MS-Office365-Filtering-Correlation-Id: 515548d2-f8b4-4c1c-aa5a-08dc20c623f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Amzunv3AvUnslSGSzthDVAFhuvjiSty/G/z7PKBRzgudx1fsiMm/NfI9KAkDSfd2GhyCut8DrNCz/1gWf4ejbYsNyK6WAHtpLIZLPlvgH6TK7lXVtRWktpjeIJyMXSUJ8ocG7zPUJU01nKUJR9d9JxSOYgVA7Y6mhLvbOm7Jrn8BkGLpueWjm40l3KugdPtim2UbxmPWGBnolwtUHud1JtHl2Vm780GkQvnH13EpjidmMflC73BKX1uPJMikNIWT/6645V0sg//Abwo3VZNrkBnu+KpDLHNt6cndq5un9EVXyT+rSSWsTAjzNsaVk77SnOqUuD9ZUMey2pu9mhoV/dngTopg+jOwqXKPdQNyGPulTQvgTk2fd5I5FlyMQlR3ZCJA3VVLM/G4djnE/QHS7+97sBSLzMm25lHgbfqnkXpoTJxGGq8h8y/nhIYhve2DIBBTsTKMb32CZGwGAvj9JJkFG/h/bz+kZo5nG97NvdwpQQGMcPu81if0MKPgCEJMMtN1pg7gLbLJEjTAFrj6agh+HOpdKN47+w/cxl7NchSPdoupHbfLkEIO2RuOAMRe+GoxS3fMLMDAmLtgF3+fK0qGjsBXxk63tP21kvWfRcx2Gt7Ck6ybDzamL2HNQqa5hrJx6FYAFBOGlGqy7tEER8mDFravfUUUrwWCJdCmpFX2an+2TT2f4xKpJ1ME8CS9
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(346002)(39860400002)(366004)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(41300700001)(31696002)(478600001)(82960400001)(2616005)(6506007)(53546011)(6512007)(6486002)(86362001)(38100700002)(44832011)(5660300002)(2906002)(66946007)(66476007)(66556008)(8936002)(8676002)(316002)(31686004)(83380400001)(26005)(36756003)(403724002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Q3dUZElXaWZpNTdNZ3JyZklYWWJhWWVGaUs0YTVnbUxsY2pZTm9JNm0rNkVC?=
 =?utf-8?B?QUFsU1U4VlNSbUE4STRiSE1BSjRjd1hmVHo1YmRvMlhFRkw0dmJVYXp4djRT?=
 =?utf-8?B?bzRRalBFSncwWDdNa0pQMHVrRnRwcFQrSDNjb01yVU5UeDNwWFlRODhxSENw?=
 =?utf-8?B?b1c5Qllpa3hRdklmbExpWEI0OXlXSXIwcnlQSEE3cFNITEpvZXRjNkh0Q0hL?=
 =?utf-8?B?aWZtVjlveDJKY0QrSXNTL1A5d0RhYmVIcEFjTmJtQW16VTUyT3JjcU5rRmlt?=
 =?utf-8?B?ZFl1TVhuSnV5WFpEaG15TkRlRHpGcnprTlo1V0IrVE5aQm9oVmNXa3M1Z3BQ?=
 =?utf-8?B?TzhoVGd1Q2pDSGszamtXQWxIQWk0cG5ON3V1cXBQbDRwWmFxQktsQnB6K3Ir?=
 =?utf-8?B?N0VkRys1cGJWODhFaVN0cCt0YlRXT2JLa01wSjlYWHJFQnRCb0FESUt6eFho?=
 =?utf-8?B?aDBBZWZRK1NDMVAyQ2lOb3BPRHN3Zk5URndIdXNiTW03MnpSbXR5TVJmanN3?=
 =?utf-8?B?M3BGVVkyTzVKUzRVVDZ2cXd3ZjJQdnpTTFI5MDVrMlF2ZnNTOW5QaUlVeWd0?=
 =?utf-8?B?bVo5MWlldE55YzlVZkdiSGY0Q1VlNDB2QXZMWGUrbitOV0RDandhVG44U2pn?=
 =?utf-8?B?SzJoeUtwSDdVWUo5ZC93RTBnSVZoVk02MGhDWUlBYVRuZXR1TThNajVrQXhU?=
 =?utf-8?B?MXY0YjF6NE5QaXd5T2pZdmN1aW1GdFNlMVVDbnozaHdkRDVuSVdodXlJcTVW?=
 =?utf-8?B?Z1g0S0hBSnJzMU9iMzdad1hNcFE0SDdRTmxVZkYrdWViRmZGWkR3QjA1WmJv?=
 =?utf-8?B?ZnUwS1cxbWF6ODhac1dsV3liUFRsVldJbWlmMkNhdmN6MjdTcVdRc0hYd0lI?=
 =?utf-8?B?SmtOS1hpSHZqT2N4THZ3c1pldm9VYzR1SHVFbEJhYnAvMlpWQ21UYU12ZXQx?=
 =?utf-8?B?Z1YrMXdaNTlQSFFjMk1BNFNIc29qRm9HMXkzOW01RThBSENHTS9INFp6NWxX?=
 =?utf-8?B?ekdmR0JqM1RqVVZNWXAwd3V0NkhUc0FLNTE0OEJvT1dFV2xVYkZXaEdNa2Ur?=
 =?utf-8?B?UEVGcmFERHhmYjFrazZDYkVwclF3OFpUVjNMSVVQRnFJam1rU29UWDJ6Mk1L?=
 =?utf-8?B?VXN3VUZzZkxlM3hLOEVYL1Bqc01qZUpUSFdkVGZ6bjBDUkFJME1JclAzcS85?=
 =?utf-8?B?L1IvVnI1TVh2QWZ2aVUyREFBSkhlNlhJNTRDWWp3QWd1T0JVY2kvMFMvK01h?=
 =?utf-8?B?dGp5TXhlNUxMdTJQZDlROExKZUgvdVdTM2VmcCtpK1R0UWdmMXFSVEN4RENu?=
 =?utf-8?B?eDU1L3pDTmVMbmZoZXJEK1o0SGF6YTlDRytTTVc5cGJvU3hOYXI5SisvS0k4?=
 =?utf-8?B?dHVNNGcvWSs0Vmw1ekx4NTFTZTBTam4xWnVPbGtsbVRUdXAxMDlRU0VyUG1h?=
 =?utf-8?B?SHVLdEJ6NHl6N0U4eUx1RDhQRS85Um9adFludlE2WFE0YlI1NDM0QkFEenQ2?=
 =?utf-8?B?V3pvWU5ESm1LdUpHNmY1cmVqWWFKaHBvUTFnUTRocGVDUTBDVTNaMFNjOE56?=
 =?utf-8?B?dWZES2dKc3U3NjF0YjA3MDU2cklTREE5RnZxMG9DU2J3SVFOekYwRDU2SHRk?=
 =?utf-8?B?YVkvMm84WC96T3hFcjdTMkp3UE1RVU1xQmNQZjVWdUh3ckNKUGxmd3JpVFdx?=
 =?utf-8?B?d3BBTzBGQ3hiY3IxcFZMYXk1TkhndTFWa3RWbklhdHJ2NGdTanA4UmdXTllx?=
 =?utf-8?B?UGhoMHQ5OFFodmRpR0ZlVFpLZ1FSdHRZeTUyb09ydldkU01WbHdyUXhlMFRq?=
 =?utf-8?B?UXJINmMwaW5McUNaOTJwSUM1SFVxL0gxZmliNXNUWVRCMFpCWTNtOCszQmhN?=
 =?utf-8?B?U1lrL0oyVytXUEpzM1AyWUEwUHdUSGNVNkhhK05wckh0eWFlbjZ1L1JUVVJz?=
 =?utf-8?B?TW8xOG14S2d2T0toNWNrWE1IRFc5TXo5K3FoN014Ukt5Wk5HWjNJVWZ1SFkw?=
 =?utf-8?B?bFo2RjhRUlQyWGFOU3h2RHNOODUwaGg2Mm5ZbzZqaUJjLzBuRjhNOGdWQVRH?=
 =?utf-8?B?RkhEQ0ptQmE4UVpkUE5NdTRUN2wwZzZRTjBLK093Z1RQVjNnWWl2aTFlSmRC?=
 =?utf-8?B?cjJVMmh4YVZZY1hJRjNOc2JZOTgrb1hRdVphT1VoOWVQV1JqR3pXRXNMNENQ?=
 =?utf-8?B?S1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 515548d2-f8b4-4c1c-aa5a-08dc20c623f0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 12:30:56.0300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9bKRocSLewthHWW1ZU4XU8MtKGaS8mxud3eVRsNjGWn6dAQ4cZk0aMM11m9HOFweShm6ilY0aStRph0BQS24uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5701
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Jan 2024 12:31:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14480

On 26.01.24 18:19, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This avoids a transient inclusion of efibootguard to all images due
> to `swupdate` added as a FSTYPE in the layer.conf.
> 
> Reported-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> Tested-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
> Changes v2:
>   - Fix subject
>   - add Reported and Tested-by
> 
>  classes/efibootguard.bbclass | 29 +++++++++++++++++++++++++++++
>  classes/swupdate.bbclass     | 30 ------------------------------
>  2 files changed, 29 insertions(+), 30 deletions(-)
> 
> diff --git a/classes/efibootguard.bbclass b/classes/efibootguard.bbclass
> index 26291b7..31fcdcc 100644
> --- a/classes/efibootguard.bbclass
> +++ b/classes/efibootguard.bbclass
> @@ -40,3 +40,32 @@ def distro_to_lib_arch(d):
>      return DISTRO_TO_LIB_ARCH[distro_arch]
>  
>  EFI_LIB_ARCH := "${@distro_to_lib_arch(d)}"
> +
> +# Add the bootloader file
> +def efi_bootloader_name(d):
> +    efi_arch = distro_to_efi_arch(d)
> +    return "boot{}.efi".format(efi_arch)
> +
> +SWU_EXTEND_SW_DESCRIPTION += "add_ebg_update"
> +python add_ebg_update(){
> +   efi_boot_loader_file = efi_bootloader_name(d)
> +   efi_boot_device = d.getVar('SWU_EFI_BOOT_DEVICE')
> +   swu_ebg_update_node = f"""
> +   {{
> +          filename = "{efi_boot_loader_file}";
> +          path = "EFI/BOOT/{efi_boot_loader_file}";
> +          device = "{efi_boot_device}";
> +          filesystem = "vfat";
> +          sha256 = "{efi_boot_loader_file}-sha256";
> +          properties: {{
> +               atomic-install = "true";
> +          }};
> +   }}
> +   """
> +
> +   d.setVar('SWU_BOOTLOADER_FILE_NODE', swu_ebg_update_node)
> +   ebg_update = d.getVar('SWU_EBG_UPDATE') or ""
> +   if ebg_update:
> +     d.appendVar('SWU_FILE_NODES', "," + swu_ebg_update_node)
> +   d.appendVar('SWU_ADDITIONAL_FILES', " " + efi_boot_loader_file)
> +}
> diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
> index 8f1215d..403bdef 100644
> --- a/classes/swupdate.bbclass
> +++ b/classes/swupdate.bbclass
> @@ -11,7 +11,6 @@
>  # SPDX-License-Identifier: MIT
>  
>  inherit template
> -inherit efibootguard
>  
>  SWU_ROOTFS_TYPE ?= "squashfs"
>  SWU_ROOTFS_NAME ?= "${IMAGE_FULLNAME}"
> @@ -60,11 +59,6 @@ IMAGE_TEMPLATE_VARS:swu = " \
>      SWU_BOOTLOADER_FILE_NODE \
>      "
>  
> -# Add the bootloader file
> -def efi_bootloader_name(d):
> -    efi_arch = distro_to_efi_arch(d)
> -    return "boot{}.efi".format(efi_arch)
> -
>  # TARGET_IMAGE_UUID needs to be generated before completing the template
>  addtask do_transform_template after do_generate_image_uuid
>  
> @@ -99,30 +93,6 @@ python add_swu_compression(){
>          d.setVar('SWU_COMPRESSION_NODE', '')
>  }
>  
> -SWU_EXTEND_SW_DESCRIPTION += "add_ebg_update"
> -python add_ebg_update(){
> -   efi_boot_loader_file = efi_bootloader_name(d)
> -   efi_boot_device = d.getVar('SWU_EFI_BOOT_DEVICE')
> -   swu_ebg_update_node = f"""
> -   {{
> -          filename = "{efi_boot_loader_file}";
> -          path = "EFI/BOOT/{efi_boot_loader_file}";
> -          device = "{efi_boot_device}";
> -          filesystem = "vfat";
> -          sha256 = "{efi_boot_loader_file}-sha256";
> -          properties: {{
> -               atomic-install = "true";
> -          }};
> -   }}
> -   """
> -
> -   d.setVar('SWU_BOOTLOADER_FILE_NODE', swu_ebg_update_node)
> -   ebg_update = d.getVar('SWU_EBG_UPDATE') or ""
> -   if ebg_update:
> -     d.appendVar('SWU_FILE_NODES', "," + swu_ebg_update_node)
> -   d.appendVar('SWU_ADDITIONAL_FILES', " " + efi_boot_loader_file)
> -}
> -
>  # convert between swupdate compressor name and imagetype extension
>  def get_swu_compression_type(d):
>      swu_ct = d.getVar('SWU_COMPRESSION_TYPE')

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Linux Expert Center



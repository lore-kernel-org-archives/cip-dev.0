Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E807BC54E41
	for <webhook@archiver.kernel.org>; Tue,  5 Mar 2024 14:34:34 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.41])
 by mx.groups.io with SMTP id smtpd.web11.24591.1709649269536029925
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Mar 2024 06:34:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=gP2u1v2S;
 spf=pass (domain: siemens.com, ip: 40.107.7.41, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nelmoOrxdeG24gnyDapzafx4YddNGnxKVS4P9/BDdII5D5zCW4kHC24j/k8MosVfHiknfNYGl9gMYEbnZPuTVeeQHC+YPR4wKZm1clLdPHjGwJXwYJDDiffFeKKganK5AS9omZ3qVmGkj3HD2Ul57kmv11+rhK5rhvigFpZG2t4dG9Pw8lSOZMgl0HhXtmvRdMy/Um9GjdH2+wGMBbaYQk34BzTtsu7K9xsv11CqRwVkH0WMSGP8IsKWStw5+JlmF/gySjArzqrXxXJrjc5SuogZMRJGiCJYHBt+zBzK81M6LbwJ2/ECdiKmlUXPCRuvbIWW9zlS2dJO17VqJyCGgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZYUW2vc7qx02ycI5EiQPsm4U9c7Eig+aVihVGT+W5JA=;
 b=TBLqMlpVx7ksayplENggMOw75AagP8N0p780oVoP4jJafF5jWXJs+LYLtuF9Fo08cj3uE174eJ6lMI9rE0uXumWIoHPVw4uS78nRn0i/dC+Qd8peYsyAM0KExDg3/dfdNV3OOL+kZozkwOfjCH+aU6UVpWRQoCBh4bGVpfhrJeXKkFuyFEGyBxKnwJz0kW9misBRzhqP70qAZtsdOjhCbT6yddLky0oPkSfaNKwmH+lWBrngjg4wUN1A+yVBsItXly9vPOC9wS0fM8p1Hr5WOoU7KhdogxmREUH9ed/ChtwlslyYar21v2eGCkK5+3OvkkdROO7NXdWdLxvroohAXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZYUW2vc7qx02ycI5EiQPsm4U9c7Eig+aVihVGT+W5JA=;
 b=gP2u1v2SqX0LdsLlpVmCa59SlzIcwG5DwdHTXD+6t5raFHlrNhoreG9A2xrwae5Cg+btRL37hkrSeXlNGqBqERIJ5lplQG2PLEw8PvRE51ROyoZkoGbbyX3Pw8Mv3eukou6L0hReEsyjPofHoeZp5uKg8JQT7PILH5rQR18URYZ33z89ZKFlt8y2AAvg7PfqhKV+1P3i5Lwth1nY/mWe2FMiatYE76dJEDWfnsfpdS0fivWs4HRBFPl2Guilpb5+3/Nc/CfQIjMe6dZm15qggaWLIk6qzQi5aZQXQH5wqdOfxqoPFTVFyKmwD5MhJYfx1L1NlpisZi/uoL9anESTTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by PR3PR10MB4109.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.37; Tue, 5 Mar
 2024 14:34:26 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67a7:ac13:3db4:91cf]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67a7:ac13:3db4:91cf%7]) with mapi id 15.20.7339.033; Tue, 5 Mar 2024
 14:34:26 +0000
Message-ID: <2f0ac283-22c2-4c06-a90c-d874a803139b@siemens.com>
Date: Tue, 5 Mar 2024 15:34:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 4/4] fix do not add files to
 each image recipe
Content-Language: en-US, de-DE
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org,
 felix.moessbauer@siemens.com
References: <20240305110311.2073425-1-Quirin.Gylstorff@siemens.com>
 <20240305110311.2073425-5-Quirin.Gylstorff@siemens.com>
 <13f6bab4-0b95-429a-b6e5-b4859a111bc2@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <13f6bab4-0b95-429a-b6e5-b4859a111bc2@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0194.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::10) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|PR3PR10MB4109:EE_
X-MS-Office365-Filtering-Correlation-Id: 46d2d9a5-0374-4e6d-38b4-08dc3d215bac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	yUgrYB1WXYe3+y3LBzGesIJEXhu4Yyc8RKgspqQ65Tr6mrEaoaANJ8e3D2d9fC5f1l7YX+A564ayGhu36OrC0mI5MsntxtaleQe3wCilaU0Q9ngLgm6hHil1qVHkLGEp1VHBd2ns71Ts4tNQVrXPrEbL08NyCnEod95KApNIBY/aRkB0CtIcpREmLm8Om248ylAuTVdGx39L9wdnXTOP8hT8XQDaROV29320kqWtnVDtNzRQ1lhsGVK5G+E07HbIpWENsKGFcRWTBQUgSDiuNGz+BQxx5cfGjc8GEbY2BX6eRSNKWITJGyyoXlRzZUvnNWmXOD3v/lU48uRudDBfSRswoknQYVd0pKkv4fUQeMRARH1JCxLAhzyjvAc7mOhBHjBgXe2VRS5r8ubnp7ir9tOPZEpob14ISUQEpF/l8VWhMiZR3dM+lFpj8frooCRToGmLHJVhJ1rjQicJ49nE0OGRbQ3iXAEq9Y/6kwoneHW8nLE47vYY5OxXSOkkeOeaEZP2v8j51EBYWo8a8V+lhlpeuZr24TC78lObSY+jbqkiF454Nq5MqrwHPAEAvAEVLnh2YBChPKq5qazwfKbrU1ixXdW2I4GnpK9rUSSVIeuqgWjSuEX/bOEOmzWj8lWvQBYmPBfmIksJYCGI21I31nzZWlEEZWND1+XJkQgyQoI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QVJHejE5RVRvUkNxcmFmY0wvdHRVUGtiK3NZQ3cyVjJKZU14UWZRTWZnY3Br?=
 =?utf-8?B?czdqRlczdktYcVdZQkg5NUNWMUNRd1UvVzhsRlFTamFjelNwSzByL20rcWJY?=
 =?utf-8?B?UFlEMlIzcjF1eGtuWExlRzNpTXlTOE0vMlZPNWhlYTNnTWxYZHYzYmoxdTlq?=
 =?utf-8?B?SVJxUVpJWDFXS2krZVJnc0tJY3RLdHpOVmQyRklHZVhEZmFCQ0lTMExBaEpI?=
 =?utf-8?B?R3crNEpGME9ISE5TZGhXWjlmZG9MNEtrK2hjSXo3K0JQOVI3WlZBOWhJSGhS?=
 =?utf-8?B?ZURKeVppKytvUXBhNS8yTHRSbGxsem1jblJNbTFpMTBVajRQQkZicEF6VmVE?=
 =?utf-8?B?SkFORVJBZkNEcjhhb294QVF2V3RYYjh6WHNiL2dvM0FQWVpaeHJhL0FyeFE0?=
 =?utf-8?B?WktjK1dQamlucW1Nd2RtMWhQVW85WjJmWjc5QlArY3UvMUNpUGtmYTRFWFBW?=
 =?utf-8?B?TjlIdi8yL2p5WWZtUk42eG1jejcrd0YxMUNnTFh3ZEVNQjFHZ1ZMR0lVMVI1?=
 =?utf-8?B?VzlwdDcxRXA1aGtYbDhPKzFRTUIwYTBFYlZkZFRRSjcya3JlZTJ0K25DbUdX?=
 =?utf-8?B?L21nS0s3ZlBUQ2dKdGdUc1JMV1FqeWJVYmtkU2FWeTFVSHIwN3BSc1BqNE02?=
 =?utf-8?B?TEJUdkNlbDdVMytjL3VqMGQwMnIrMUx4MU1WTzE0WGZmR1c1OTluZW04RCtM?=
 =?utf-8?B?NytBaTF4UVcxVUpKWEZISlRGUUVZdzdnTlE2QmlyVk1CZFVCS1NGODFnTWha?=
 =?utf-8?B?YXhpY3NhLy9SOFZTOWxIS0JCQnF1MWl0Y1VLUXh4SjB2VlFmQWNNeEdFelF3?=
 =?utf-8?B?ckZrTkpTbkdNYm5iaGFSMmdVeExxbW9mOFc2Mm1hZ3kwZ3lGRytxVEgwdGlj?=
 =?utf-8?B?elJUcW1PMU9qQnpDb1hCY296bWVTU2lEa0FOdnZ4ZU1MSmVtaFNSVmszaHhC?=
 =?utf-8?B?Tm14dmVQVHhVckFnVUJZUytZNWlJbVZReVJ2UmRxMHFHTW1NNnJwSGZkNFdL?=
 =?utf-8?B?Q1BLWkM0TE5YbHdaVXZ4V3ZyQzBjOWpkdkcwL0o5N3h5eWFUays1LzVOYWhH?=
 =?utf-8?B?ZHlwMFp5NEl2MU9xSkphdldsSzFrUUlXNWg2b2RyRU5RRmwyNnp6WHpsMk5T?=
 =?utf-8?B?NTJ2LytnY0ltalJ4NUlueVlKMURrd29XVmhMTk8zSHlSMzNCSU81SDFjVzdv?=
 =?utf-8?B?L2dVSlBmRXBxK0NJSU9oeWJRUzIzZmgyN2M1U0h1RERiMXNhNGV2MnFtU0p3?=
 =?utf-8?B?Q3Q5M2g3eVlhTlE5LytCd2xMbmJScVRNZ2o4UEx3R2d5WHlWVmdIU0F1RVFH?=
 =?utf-8?B?Rk1kSjV6ZDV3cXVTNVNOWlVUZkFpOWNBOEV5eWI4SDdYaXg0R3MwendQWVNu?=
 =?utf-8?B?VUh2RWVPeUt2eXR3NmJaMFV0VnlpNkVpekc5ZmE5Qm01MExDRjB0VHhqK1pk?=
 =?utf-8?B?cVdaMG5xNlhTeWVmZWtvZ3JjTkxnakNRWFA5ZUdzaDVMS01jSnBCb2JFT0pM?=
 =?utf-8?B?cXpSTW1qTjRtYmxMZ2UvTDlKL3IwY1htVE9ydU54VjdNU1kzQnFheUM4NmZy?=
 =?utf-8?B?Nm45NGhpY2pjeUhlcVJyb3NObzVva1lCbElsblBGWkZrRlBYeTlTazZvenJh?=
 =?utf-8?B?M215anVtZ01abFpDM3dkWXBOdDNZWk1rRnV4ZmxSQWxLYnp0a2R3N1Bzc0JZ?=
 =?utf-8?B?aUJaZ25DR1hLa01LaUNWT0hQNGtxSmtGL0ZkdXI0YnpiUTAwK2NHbHZxOHNw?=
 =?utf-8?B?MVcraDdmcWlURVVVd2dhdngwTENINk5SZHlzNVN1QjIyZE45YTNsbnBxajVm?=
 =?utf-8?B?dDFSTm9CSUkxUFVrbG9XMytiQjVqV2pybExpMHNDTGRqZzJkVEVFQWxYYTBW?=
 =?utf-8?B?eXE5MlhTSG9WbHBVRzdGelNxVHBldXpyMlZEblo5R3hDakVpcmZDYnpWVkZw?=
 =?utf-8?B?ditaMHBvMjJtT09VMGNKMCsxck9WQmFiQjFIZG5uZjQxaWNCa20xdE9raldO?=
 =?utf-8?B?aU4wYSsvdnNxUWtkOWdUdkpPTnlxcnd0MFFvcmcyRStYNjFUR3o4MSsvWVN4?=
 =?utf-8?B?a0RtcVpPa2hjKzdwWHRRNkVaTEROdkZOQ3ZqcHZPSEZETWhsbzNYYXRwZzVM?=
 =?utf-8?B?bXRZemhHVnlnRStRcW1GdUMwUkNXVzdjTEFFdUoxa242Nkw1UjlSUDhpbkIv?=
 =?utf-8?B?eHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46d2d9a5-0374-4e6d-38b4-08dc3d215bac
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 14:34:26.1826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h39PBSQZgHXm2E5s1ZOzkgT/bMTOZQBfpsvjMqhshAapIt7dS5T0uv/6ZnNjrGikWNidYsqhubVH+V6/x3GZ9mB7qjztsfBoh8aonsSDmSc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4109
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Mar 2024 14:34:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15229



On 3/5/24 3:17 PM, Jan Kiszka wrote:
> On 05.03.24 12:02, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> Due to the use of an anonym python function each image recipe was
> 
> anonymous
> 
>> partial build even if not requested.
> 
> built
> 
>> To avoid this remove the anonym image function by adding
> 
> anonymous
> 
>> it as an prefunc to do_image_swu and do_transform_template.
>>
>> The SRC_URI is appended with a function.
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   classes/efibootguard.bbclass |  1 -
>>   classes/swupdate.bbclass     | 42 ++++++++++++++++++++++++------------
>>   2 files changed, 28 insertions(+), 15 deletions(-)
>>
>> diff --git a/classes/efibootguard.bbclass b/classes/efibootguard.bbclass
>> index 31fcdcc..2b4f09e 100644
>> --- a/classes/efibootguard.bbclass
>> +++ b/classes/efibootguard.bbclass
>> @@ -67,5 +67,4 @@ python add_ebg_update(){
>>      ebg_update = d.getVar('SWU_EBG_UPDATE') or ""
>>      if ebg_update:
>>        d.appendVar('SWU_FILE_NODES', "," + swu_ebg_update_node)
> 
> Indention looks fishy, but that is nothing this patch caused.

I will fix it in a separate patch.

Quirin
> 
>> -   d.appendVar('SWU_ADDITIONAL_FILES', " " + efi_boot_loader_file)
>>   }
>> diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
>> index c62f43f..c82d20c 100644
>> --- a/classes/swupdate.bbclass
>> +++ b/classes/swupdate.bbclass
>> @@ -63,7 +63,7 @@ IMAGE_TEMPLATE_VARS:swu = " \
>>   # TARGET_IMAGE_UUID needs to be generated before completing the template
>>   addtask do_transform_template after do_generate_image_uuid
>>   
>> -python(){
>> +python do_extend_sw_description(){
> 
> () {
> 
>>       cmds = d.getVar("SWU_EXTEND_SW_DESCRIPTION")
>>       if cmds is None or not cmds.strip():
>>           return
>> @@ -71,6 +71,7 @@ python(){
>>       for cmd in cmds:
>>           bb.build.exec_func(cmd, d)
>>   }
>> +do_transform_template[prefuncs] += "do_extend_sw_description"
>>   
>>   SWU_EXTEND_SW_DESCRIPTION += "add_swu_hw_compat"
>>   python add_swu_hw_compat(){
>> @@ -94,9 +95,22 @@ python add_swu_compression(){
>>           d.setVar('SWU_COMPRESSION_NODE', '')
>>   }
>>   
>> +def add_scripts_to_src_uri(d):
>> +    swu_scripts = d.getVar('SWU_SCRIPTS')
>> +    if not swu_scripts:
>> +        return ""
>> +    swu_script_entries = swu_scripts.split()
>> +    script_file_list = []
>> +    for entry in swu_script_entries:
>> +        script_entry = f"SWU_SCRIPT_{entry}"
>> +        script_file = d.getVarFlag(script_entry, "file")
>> +        script_file_list.append(f" file://{script_file}")
>> +    return ' '.join([n for n in script_file_list])
>>   
>> -SWU_EXTEND_SW_DESCRIPTION += "add_scripts"
>> -python add_scripts(){
>> +SRC_URI += "${@add_scripts_to_src_uri(d)}"
>> +
>> +SWU_EXTEND_SW_DESCRIPTION += "add_scripts_node"
>> +python add_scripts_node(){
>>       swu_scripts = d.getVar('SWU_SCRIPTS')
>>       if not swu_scripts:
>>           return
>> @@ -129,8 +143,6 @@ python add_scripts(){
>>             sha256 = "{script_file}-sha256";
>>           }}"""
>>           script_node_list.append(node)
>> -        d.appendVar('SWU_ADDITIONAL_FILES', " " + script_file)
>> -        d.appendVar('SRC_URI', f" file://{script_file}")
>>   
>>       swu_scripts_node = "scripts: (" + ','.join([n for n in script_node_list]) + ");"
>>       d.appendVar('SWU_SCRIPTS_NODE', swu_scripts_node)
>> @@ -155,6 +167,7 @@ FILESEXTRAPATHS:append = ":${LAYERDIR_cip-core}/recipes-core/images/swu"
>>   do_image_swu[depends] += "${PN}:do_transform_template"
>>   do_image_swu[stamp-extra-info] = "${DISTRO}-${MACHINE}"
>>   do_image_swu[cleandirs] += "${WORKDIR}/swu ${WORKDIR}/swu-${SWU_BOOTLOADER}"
>> +do_image_swu[prefuncs] = "do_extend_sw_description"
>>   IMAGE_CMD:swu() {
>>       rm -f '${DEPLOY_DIR_IMAGE}/${SWU_IMAGE_FILE}'*.swu
>>       cp '${WORKDIR}/${SWU_DESCRIPTION_FILE}' '${WORKDIR}/swu/${SWU_DESCRIPTION_FILE}'
>> @@ -165,13 +178,14 @@ IMAGE_CMD:swu() {
>>       for swu_file in "${WORKDIR}"/swu*; do
>>           swu_file_base=$(basename $swu_file)
>>           # Create symlinks for files used in the update image
>> -        for file in ${SWU_ADDITIONAL_FILES}; do
>> -            if grep -q "$file" "${WORKDIR}/$swu_file_base/${SWU_DESCRIPTION_FILE}"; then
>> -                if [ -e "${WORKDIR}/$file" ]; then
>> -                    ln -s "${PP_WORK}/$file" "${WORKDIR}/$swu_file_base/$file"
>> -                else
>> -                    ln -s "${PP_DEPLOY}/$file" "${WORKDIR}/$swu_file_base/$file"
>> -                fi
>> +        swu_files=$(awk '$1=="filename"{gsub(/[",;]/, "", $3); print $3}' \
>> +            "${WORKDIR}/$swu_file_base/${SWU_DESCRIPTION_FILE}")
>> +        export swu_files
>> +        for file in $swu_files; do
>> +            if [ -e "${WORKDIR}/$file" ]; then
>> +                ln -s "${PP_WORK}/$file" "${WORKDIR}/$swu_file_base/$file"
>> +            else
>> +                ln -s "${PP_DEPLOY}/$file" "${WORKDIR}/$swu_file_base/$file"
>>               fi
>>           done
>>   
>> @@ -186,7 +200,7 @@ IMAGE_CMD:swu() {
>>           export swu_file_extension
>>           imager_run -p -d ${PP_WORK} -u root <<'EOIMAGER'
>>               # Fill in file check sums
>> -            for file in ${SWU_ADDITIONAL_FILES}; do
>> +            for file in $swu_files; do
>>                   sed -i "s:$file-sha256:$(sha256sum "${PP_WORK}/$swu_file_base/"$file | cut -f 1 -d " "):g" \
>>                       "${PP_WORK}/$swu_file_base/${SWU_DESCRIPTION_FILE}"
>>               done
>> @@ -205,7 +219,7 @@ IMAGE_CMD:swu() {
>>               fi
>>   
>>               # sw-description must be first file in *.swu
>> -            for cpio_file in $cpio_files ${SWU_ADDITIONAL_FILES}; do
>> +            for cpio_file in $cpio_files $swu_files; do
>>                   if [ -f "$cpio_file" ]; then
>>                       # Set file timestamps for reproducible builds
>>                       if [ -n "${SOURCE_DATE_EPOCH}" ]; then
> 
> Jan
> 


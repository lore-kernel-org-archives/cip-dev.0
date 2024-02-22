Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 898D4C54788
	for <webhook@archiver.kernel.org>; Thu, 22 Feb 2024 12:52:57 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.76])
 by mx.groups.io with SMTP id smtpd.web10.11957.1708606368539463549
 for <cip-dev@lists.cip-project.org>;
 Thu, 22 Feb 2024 04:52:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=QrMg4f2S;
 spf=pass (domain: siemens.com, ip: 40.107.21.76, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iObpcb07tLZheqAH0ZkFpjaLlnE1dcUcOPI0A3jXYmf8byATuYC+ZlET/Yn5vVfMmNEVSnkF2uIlFKd53AG+Lwf7OJhTO/pug+G7ZAVyVnMmevdBUWHZPlIb8Q/NQ+udu0SpcOlmxFyz5TQecGPUzSWvN24e9HcstnAPGS0No3SOHmlOxEXTgyUdnaWMFiQ9VismgFpQkoflN88+X/p/TFHjau+h4aFLf4QMlOLJf4IvkkUXAO0C/6DdO5rtc+1GKnbX+DqYkqEqBr/6i7RcpflUFyYycxLUl9Q+XK1/LwO5GYK2InhsOq6NRXKqAJ6czVCC4Sz5C1GhcQEUtoZl7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ytFdDvIqG37+CYNjoEfjztjBuxaZr0MnhFLeJimAH2c=;
 b=jrRWXih54fM/DU0yRcgvKZqB//Txt1S65Zr2zxvMMtpqXJlWO0+3ESIrGh6IC1GfBEaAhUopNVXKTeeEkWDGbTZOj4ssNW9zbldsDvSxfyyY6P1kr0E7Q/jozYS5RlM3/mz5w5P0PUI+QQkfdom+oRKkc4FpNtuUIMvLxY82KD9PQMVFFXgzQCOijzt3NoIEbSuM64hOThARPtwtAOH95Ja6UgDbXNJ8XMx2f7RMkaDNUHPdJg/L+0/voD6cXFv3/fs2TBvPawfWI6s0gt/mv3qJn0DCNpUjhd3aPhG8HIgp1MAX/EhSqoO9hyjILPNf52sCMjy3iEZPjNH8In7rvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ytFdDvIqG37+CYNjoEfjztjBuxaZr0MnhFLeJimAH2c=;
 b=QrMg4f2S/dCwiwCpYgE+fN00I+khIWeD0j7+K+ZFcSb0pXSw1GN0xMs+1qs3akqDA7YcVPMiWoxTKOBi0JFBTH0RsTzUqELhTOelVvkEt858iCuyteJIvQma5P9+KlV1UT97kXE7gpgI2Vr2LIDKr6w1MLOtA3zV5jhayZSZNrUIzhtRQXaJKvqReWcqeb1ELxIBkDR/c0LlyJF3UDoK5dQh7rwet45XgNexljU1cbjEWYevMG+UoSXPjOwpgsQbTJEUkg89AvAAsjmkSEy3n/49xwaydQcrb/UoE+Us4FF/bLS4oDHR3yju2gftoh21LKy1EpEAFTkCvyHuFCdNoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3271.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:10d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.23; Thu, 22 Feb
 2024 12:52:45 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7292.036; Thu, 22 Feb 2024
 12:52:45 +0000
Message-ID: <570931d1-b382-4e16-8a38-f9f88e8d6b71@siemens.com>
Date: Thu, 22 Feb 2024 13:52:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v6] swupdate.bbclass: add scripts
 section to the swu file
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, felix.moessbauer@siemens.com
References: <20240222124840.1228807-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240222124840.1228807-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0361.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3271:EE_
X-MS-Office365-Filtering-Correlation-Id: 72f20491-a15d-458c-cab7-08dc33a52a2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	STLqkbKo+HWkSnDcR+cJf5c6bX4IqePe0vCU65leo9hqse1+IlUMkH+8sZszUCRKUjl1apA7HyUkKyfdZydSnfNNfiL7jrjhbvO35xo+vaGphn3paRbUuquRXPQAzfiZN6qYuTFWXeH/QR2oFkdGO0M9gcPodZWYZ+qkqqjnyMW0Uwlzb78M025QuifFl2NiAhcybRGLUfRt4bdk8MlTb/V0ckT7RbJLrTRl0HZg2fsS+Hb3IV8LDb2M2ovY6nlnQQrmGpP6/iG2Xf7NCW92/DpWCzy9pT6fstGegJXI8+MRRqmtgWGiSu0EKx7ihmkoaPt0oZL4tejELs8CvS9YA2+7f3zDbgEp+gHCT/REX1XKR9xYluX2BQ3VkV5vsb2YJWbgpfQhNQG+FOdHVQOP4lyQ/Qn05iOGhPrO4euawa5TgLKMMV/m13VkWadIj6Z9ct1aVy7kg5ivjb0GLezYwMuMSit/K+JnNwYWVjAe/Iv3Lewb8STFBBCLMZao4VrTKUwRYNqbGeNSn25qRILfYXoK1Hj9ifP0+gFzjgl4jtg=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(230273577357003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?amtzbm5ONlFuVDA0c3V3MTVkdHVxY3R6aGsrSzJPVjh4ZVRkRDFEQWQ4eldE?=
 =?utf-8?B?UFRBWkJqZlJMNlpybkZxSWxKVk9XQ3doQ2QwZmo0SFIvS0tBYXE3QnNXcm1T?=
 =?utf-8?B?d2lKYUNHRlhJcXcxQWRCd0xpMGJSd0JYd1F1T3RPN1poUVVGREk1MGRRRGVh?=
 =?utf-8?B?NjEzWVNoditJSTRiTmhTalVTWW1UYk5TVEJlUkJQSUlwMXVJVHp0dWZKa20y?=
 =?utf-8?B?a1lubWFXSXo0ZUhLdW8vMkJTbi9CbkxJOUovQjQ2QkIxYXlHZFhzOFk2U0xu?=
 =?utf-8?B?NW9DWXdTQ0tNcjBReGtkTGV1UWZmY0pQUVA3MUwweFZnMENMUjByVjBDam1z?=
 =?utf-8?B?TStMMkE4SFk5QUNqUHlQVTE3WitsZFErdDIxWmExeGkyTFZOZzljREhxTUI0?=
 =?utf-8?B?WDVISHliaXJRSHM5SnlEakprTWgvcDdGS0tIQ3hxeEIrVEd0Z0d1RzdWaWYv?=
 =?utf-8?B?SjI0YkNzL0UyQ1VrNHAyc2F3T2VNWFpnM2hKLzlmRG1MNEp0MXhybFZzbWdO?=
 =?utf-8?B?TXZkZTRMSVhNNTlRNk50Zm1HRDJHS0NwN3ptUW5CS1BIcWxBYzhDZ1JwOGNY?=
 =?utf-8?B?dTBDcEpsUFgvUitWUlVKM3NGWFVoTmN4ajlXb2o0VjV5am8yRjFPU2dOSndS?=
 =?utf-8?B?aDdWUlUrWDYvbjdQSG5meWlkWCtEeHJ4KzE0bnZHc3U2ejNDWmxhUGZFY2tI?=
 =?utf-8?B?bnFKYkdHeWhVU01tNGo2ZkhjM0d6VEpDS24zU001M0s5bmhNOTdmK0pVV3dM?=
 =?utf-8?B?ZGRFa3grd2hnRVZpQnZDK2pISENtNW1NM0VNcTNUTWFoTm9KZzJYTGVXdzJZ?=
 =?utf-8?B?N0JCa2ttSk1wbFJUUGxtT1hSWURPdHA0ak9aaXBJM20yQjlmWjJpMmw4VUQz?=
 =?utf-8?B?a1Q4OUdMc1daOWtIQlNlMVhZTURYanhvVjZ4ZXhwYkh2eEx1K09yZzdHQ2Mx?=
 =?utf-8?B?SnNsYVdDMUtiNmt0ZWYxS3VIZWV0NnJwaFM4YnFyZnFoSU5DVFd4VHpqSmhT?=
 =?utf-8?B?aDZlaVpsZExnQ25HM091aVBaQ2xMUHlRUnQ3U2lnQUtpUThOdzNxdGtHeUc4?=
 =?utf-8?B?Sy9naEppeW9KY2xsUHNGRWtuTFpxcDJvMVVaNUpHQkJkL2dsN2V3d1BRaFlB?=
 =?utf-8?B?S1RTaDZoeXczZEMvS1BlV21GMCsrWVgvRHY1NFgyU3oyNWJYelp3MVVvMnFR?=
 =?utf-8?B?K1VGQU1HVUMvYU5DL05ycWR0c3F2R2sxK25kNFFxSkVQcVBkK0RnOThHTnZr?=
 =?utf-8?B?YWdHR3hkWXNoS3JCeXFmQ3VGSmg1QjVhaXZ5UnVqZENiVFA1SHRvbWZGZXpx?=
 =?utf-8?B?K0M0T3FZVWUwSUhmaWpURlNGeGxyV0I2eXNoV3RReWVSVVE2N0xXWGlIVnJW?=
 =?utf-8?B?OE1VbW94ME96TGp6ZWFqdVF5L0NNb2pOR2Nkakt4RVN0aHVqa2NRTFRncXVO?=
 =?utf-8?B?d05jRHhjZHRmcGMrNTcvUG9pRE1ycVNZRXd6Wkw0SVB4QlVOWVJqeEtFS20w?=
 =?utf-8?B?OXoxSHFPd1JEbUJkc0pwUnA0a01MWmdrNkFPM0NDTmJoN3pFZWFlMDd3ZWxM?=
 =?utf-8?B?a2dCMmFMVys4RElvZ2JmYlZreVdrU3hpUUpZWTRLNTRjN2ZTMWtIQVRzSmdQ?=
 =?utf-8?B?aHRhLzhvcWNPTmU2ZG9WaVVsVUV2bTRoSThzWmQwSCthNG5SM0h1WEQwTExi?=
 =?utf-8?B?NGJ4Q3JqcFd5eDVVYXpISVcrSGVaYm4yNXV0UGQxakZ4OXRKV0tReEN5Q25R?=
 =?utf-8?B?aklqWW5ubkZHMmRMSWNkc2czV1kzRzBzTjFERHNYZGo5cWRoc0lVVVVUWmE5?=
 =?utf-8?B?K0ZlRVU4RHB4M0RJQzN2Y0w4SDVMcXFGK2NyQTVLTnV1LzRpZlZsY29tenNa?=
 =?utf-8?B?c1p2MzdGV0xGdkFrOEFxamkvVytlUyt5b2xpaWFWK3RwY0lhblBPbTB0SkNQ?=
 =?utf-8?B?cTdMZmk0VWE0ckJDMGVseWlZVDU1S2QzdHlmMUVCNDljbUlnRnl6c0pTM0U1?=
 =?utf-8?B?UjRVQ2k3M2NDUk90OTFONzRxbWZpblVwTmE1UTRpcmN5bVAwTjNVRVRtWUt6?=
 =?utf-8?B?Z1dSd1NvWUZ0THNKS09pNndJMXRSa2NIRXpiRHdWRHRWRnRaMVBpNzFjN0Fx?=
 =?utf-8?B?RkNqcTlQc2M1TGlEUDZmQURydFhCTTZXV3hlWmtWUDdROGxHWjZoeEc4M0RR?=
 =?utf-8?B?bGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72f20491-a15d-458c-cab7-08dc33a52a2e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 12:52:45.1212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9WoWI7Ntaz6R2Ufm8DK7OnNfi4KqiwX+t60wxAZrbYeeq1jCIuE7RZJ3rNGHDaVTmePu1IpJlo/E7rb/nmuR0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3271
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 22 Feb 2024 12:52:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15062

On 22.02.24 13:48, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This allows the user to add scripts[1] to the swu file by
> setting the variable `SWU_SCRIPTS`. Scripts can be used to
> prepare the system for an update.
> 
> ```
> SWU_SCRIPTS = "postinstall"
> SWU_SCRIPT_postinstall[file] = "postinstall.sh"
> SWU_SCRIPT_postinstall[type] = "postinstall"
> ```
> An optional data element is possible with
> 
> ```
> SWU_SCRIPT_postinstall[data]= "some_data"
> ```
> 
> This will add  `file://<script_file_name>` to the variable `SRC_URI` and
> `<script_file_name>` to `SWU_ADDTIONAL_FILES`. The sw-description will contain
> the following section:
> ```
>     scripts: (
>         {
>           filename = "<script_file_name>";
>           type = "<script_type>";
>           data = "<script_data>";
>           sha256 = "<automatically added sha256 of script_file_name>";
>         },):
> ```
> 
> [1]: https://sbabic.github.io/swupdate/sw-description.html?#scripts
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
> Changes v6:
>  - rebase onto next
>  - if type is not set still generate the script section
>  - print info if type is not set
> 
> Changes v5:
>  - use variable flags
> 
> Changes v4:
>  - rebase onto next
> Changes v3:
>  - fix message
>  - add luascript example to README
> 
> Changes v2:
>  - change seperator from `:` to `@` as it already used for the
>    configfilecheck
>  - add optional data entry
>  - add warning if less then 2 parameters are given for entry
> 
> 
>  classes/swupdate.bbclass                    | 46 +++++++++++
>  doc/README.swupdate.md                      | 86 +++++++++++++++++++++
>  recipes-core/images/swu/sw-description.tmpl |  1 +
>  3 files changed, 133 insertions(+)
> 
> diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
> index 403bdef..450248b 100644
> --- a/classes/swupdate.bbclass
> +++ b/classes/swupdate.bbclass
> @@ -57,6 +57,7 @@ IMAGE_TEMPLATE_VARS:swu = " \
>      SWU_NAME \
>      SWU_FILE_NODES \
>      SWU_BOOTLOADER_FILE_NODE \
> +    SWU_SCRIPTS_NODE \
>      "
>  
>  # TARGET_IMAGE_UUID needs to be generated before completing the template
> @@ -93,6 +94,51 @@ python add_swu_compression(){
>          d.setVar('SWU_COMPRESSION_NODE', '')
>  }
>  
> +
> +SWU_EXTEND_SW_DESCRIPTION += "add_scripts"
> +python add_scripts(){
> +    swu_scripts = d.getVar('SWU_SCRIPTS')
> +    if not swu_scripts:
> +        return
> +    swu_script_entries = swu_scripts.split()
> +    script_node_list = []
> +    for entry in swu_script_entries:
> +        script_entry = f"SWU_SCRIPT_{entry}"
> +
> +        script_file = d.getVarFlag(script_entry, "file")
> +        if not script_file:
> +            bb.warn(f"flag 'file' is empty for {script_entry} ")
> +            continue
> +
> +        script_type = d.getVarFlag(script_entry, "type") or None
> +        if not script_type:
> +            bb.info(f"flag 'type' is empty for {script_entry} use default(lua).")

This is mostly noise. Please document this default consistently and
leave out the message. SWUpdate is doing the same.

> +
> +        allowed_script_types = [None, "lua", "shellscript", "preinstall", "postinstall"]
> +        if script_type not in allowed_script_types:
> +            bb.warn(f"flag 'type' is not of value {allowed_script_types} ")
> +            continue
> +
> +        script_data = d.getVarFlag(script_entry, "data")
> +        node = f"""
> +        {{
> +          filename = "{script_file}";
> +        """
> +        if script_type:
> +            node += f"""  type = "{script_type}";"""
> +        if script_data:
> +            node += f"""  data = "{script_data}";"""
> +        node += f"""
> +          sha256 = "{script_file}-sha256";
> +        }}"""
> +        script_node_list.append(node)
> +        d.appendVar('SWU_ADDITIONAL_FILES', " " + script_file)
> +        d.appendVar('SRC_URI', f" file://{script_file}")
> +
> +    swu_scripts_node = "scripts: (" + ','.join([n for n in script_node_list]) + ");"
> +    d.appendVar('SWU_SCRIPTS_NODE', swu_scripts_node)
> +}
> +
>  # convert between swupdate compressor name and imagetype extension
>  def get_swu_compression_type(d):
>      swu_ct = d.getVar('SWU_COMPRESSION_TYPE')
> diff --git a/doc/README.swupdate.md b/doc/README.swupdate.md
> index 1c94699..88faf23 100644
> --- a/doc/README.swupdate.md
> +++ b/doc/README.swupdate.md
> @@ -21,6 +21,92 @@ window is still possible.
>  If the variable `SWU_EBG_UPDATE` is set to `"1"` the update is also stored in
>  the `*.swu` file.
>  
> +## SWUpdate scripts
> +
> +It is possible to add [scripts](https://sbabic.github.io/swupdate/sw-description.html?#scripts) to a swu file.
> +
> +To add a script entry in isar-cip-core set the variable `SWU_SCRIPTS`.
> +The content of the variable has the following pattern:
> +`script_name`
> +
> +For each `script_name` the following flags need to be set:
> +
> +```
> +SWU_SCRIPT_script_name[file] = "<script_file_name>"
> +SWU_SCRIPT_script_name[type] = "<script_type>"
> +```
> +
> +The optional flag `data` can be used as an script argument:
> +
> +```
> +SWU_SCRIPT_script_name[data] = "<script argument>"
> +```
> +
> +The file referenced by `<script_file_name>` is added to the variables `SRC_URI`
> +and `SWU_ADDITIONAL_FILES`. Therefore, it needs to be safed in a `FILESPATH`
> +location.
> +
> +The mandatory element `script_type` can have the following values:
> +- [lua](https://sbabic.github.io/swupdate/sw-description.html#lua)
> +- [shellscript](https://sbabic.github.io/swupdate/sw-description.html#shellscript)
> +- [preinstall](https://sbabic.github.io/swupdate/sw-description.html#preinstall)
> +- [postinstall](https://sbabic.github.io/swupdate/sw-description.html#postinstall)
> +
> +### Example: postinstall.sh
> +
> +```
> +SWU_SCRIPTS = "postinstall"
> +SWU_SCRIPT_postinstall[file] = "postinstall.sh"
> +SWU_SCRIPT_postinstall[type] = "postinstall"
> +SWU_SCRIPT_postinstall[data] = "some_data"
> +```
> +
> +This will add  `file://postinstall.sh` to the variable `SRC_URI` and
> +`postinstall.sh` to `SWU_ADDTIONAL_FILES`. The sw-description will contain
> +the following section:
> +```
> +    scripts: (
> +        {
> +          filename = "postinstall.sh";
> +          type = "postinstall";
> +          data = "some_data"
> +          sha256 = "<sha256 of postinstall.sh>";
> +        }):
> +```
> +### Example: Luascript
> +The simplest lua script has the following content:
> +```lua
> +function preinst()
> +	local message = "preinst called\n"
> +	local success = true
> +	return success, message
> +end
> +function postinst()
> +	local message = "postinst called\n"
> +	local success = true
> +	return success, message
> +end
> +```
> +and is added:
> +
> +```
> +SWU_SCRIPTS = "luascript"
> +SWU_SCRIPT_luascript[file] = "luascript.lua"
> +SWU_SCRIPT_luascript[type] = "luascript"
> +SWU_SCRIPT_luascript[data] = "some_data"
> +```
> +
> +The sw-description will contain the following section:
> +```
> +    scripts: (
> +        {
> +          filename = "luascript.lua";
> +          type = "lua";

And then this is a too verbose example because "lua" is default and not
needed here.

Jan

> +          data = "some_data"
> +          sha256 = "<sha256 of luascript.lua>";
> +        }):
> +```
> +
>  # Building and testing the CIP Core image
>  
>  Set up `kas-container` as described in the [top-level README](../README.md).
> diff --git a/recipes-core/images/swu/sw-description.tmpl b/recipes-core/images/swu/sw-description.tmpl
> index c52372c..88cb475 100644
> --- a/recipes-core/images/swu/sw-description.tmpl
> +++ b/recipes-core/images/swu/sw-description.tmpl
> @@ -35,4 +35,5 @@ software =
>              };
>              sha256 = "linux.efi-sha256";
>      }${SWU_FILE_NODES});
> +    ${SWU_SCRIPTS_NODE}
>  }

-- 
Siemens AG, Technology
Linux Expert Center



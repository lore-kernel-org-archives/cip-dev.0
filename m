Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C09AC48BC3
	for <webhook@archiver.kernel.org>; Mon, 19 Feb 2024 12:01:11 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.78])
 by mx.groups.io with SMTP id smtpd.web11.39853.1708344065733655278
 for <cip-dev@lists.cip-project.org>;
 Mon, 19 Feb 2024 04:01:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=a15t5DbR;
 spf=pass (domain: siemens.com, ip: 40.107.21.78, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GDh24vkWLvy8DZHZGGcGPEA4DgdE4ddalOcNqdAj0DJgAxezYyNfcENwQAnmiw/82+LqzbVXFNqM6vyrIvzkkkQ9KU/OLpy8ibRn5XNd6AGZqZvye8swXpRlQ/O/Rl2pCXR6uXhHAuK6b4c8LNHcU/C4jPmfZv8taSaDJGxFFOck7s/F0tV4VuZLvZA9osdj2IKkZuttbFucxhusUUfHyc9q7YTmfneJ7stNFNNaMh8nivBmsdbAMo0lElOiz68KpPpSxMPKnH26x42lHJEb6/4qFNBfIdHsW5RMcKHqPz5z4fBgwAjr4Rz5F3hP+Bs5sa5sFGBqJVA4KEsvr2qaLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a9pI65AhGtY0UE0nAltoMq7yRCGBNXk5K3aIdtyk0IM=;
 b=YfUbsILvBShd7YE1TGucZOQtQDcRaCk071GWAV0Ih0YXYlrYyw/RLzxHxec1BDaUZ1iL68/0GudQsliDnFm9MgyqAphtLcG7n/EYEhh9cdaA/qlbWUib5K56env1LAXCdJScY6mFzOfRYk5zW1eWtjmxXqasHZmoKAPwcbk7WJAtIzva2lN7BQ5H/tEEhwjM4I7LK8lqm+9YbkPCmfkDwa+nxzc7ooSghJMaN8eTiG6XGcwHvaShhs3Pe197Ecz0bcQzVwQnHfynRmRB7xL5bdWMNYoSZLhDDiiJzx5DI3u/3kVabbLWwUHyLEyQP+AwYHJPi4aIwIP0rn6V0zNnOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a9pI65AhGtY0UE0nAltoMq7yRCGBNXk5K3aIdtyk0IM=;
 b=a15t5DbRvxrcfK8LmP/QTfQOE4Aq49HskA+oDN9jLdm9VYhYxvVKevf6KmM8QT8+qL5mzWjW49h/f7nGJRsN4fTZqXTt9kAkaDJDNropE3pzwr5nxs1WWIjUD35ntuDIg62eRWxJdTGrcg+AbPN/DIEBsYqB2Y1RLz3EEAnqetk8gNhoKlSGC3LdUY7RsL+4qOpuSEGU+wSL4ZyievDiXYz/O66QX3p6ekZEHGkapIrc9dnNd0qdKJ4Oxklbxbko3PjHUx3k5hTGfp0E+nbPoZIqCXLbLR5P8goWRZmaAjpBOb8tm7Z1c+/Bcpx1RvII9MXKBJ+g5CXbp62k1GHGug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3643.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:139::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Mon, 19 Feb
 2024 12:01:02 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7292.033; Mon, 19 Feb 2024
 12:01:02 +0000
Message-ID: <c289979e-c222-4464-8ee8-b7b1f2e71aa5@siemens.com>
Date: Mon, 19 Feb 2024 13:01:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v5] swupdate.bbclass: add scripts
 section to the swu file
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20240216172348.313789-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240216172348.313789-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0119.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3643:EE_
X-MS-Office365-Filtering-Correlation-Id: dce7cc35-3fbe-4120-9ba6-08dc31427175
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	WHAHtMCdHtjevsfps1EFeS7OKoYKbO3o85zmCSRLn4stmqi1a6c4x5MQKoi9SQuStRHToOVSZADlpVakGe5TE0zeRerMRZrpdyKA7xStW8ovEC77N1pi2D4bw6RTkp5z0e3alUi2/WwXMaFk4rGZLEtcGo4dzBE6q0Yi8ojufPjxyzYPGMFnhTVAaHF/LcAxvIg2oW/7oOjKTZpcMN3FGM14Ry0jl3SRq74azUDLkn+E5SEZHlBk5tz/V95RLsak8Oj/UOsjsP9tXwHHym/dQ/6Psi6o97egS/sfl6NFoLi7TmGljU1mxAA08ux+09GFcOC6FQ1gTuxwIhBv165I0luG3NFAc62SrE9S2U7ftmacwOFb+9KEl5LaFDj3Vindpsmqsfhyf2hfnRlo9p+ZVFu5giSMMEY0FZLwCYJBmqhbhQZKnDONjKQ03eEtrhlwdsCTL5cGud5KwltGxkFM7mg2PXoVypi8JH4/OvV2ZRDktA+RKnKeWP6Fvv1mIxriAamv742RWuFrDLUxvrr9qw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cThDMlU1ZG9CRU54UnlId0F1QitGaU1td2Jzc1hCYzdYQm10c0lYR2JON1Jp?=
 =?utf-8?B?TXdUdGdkSXlzUWJJMC9hdVRTWU56MmhSVlhKTTB2VzNUWmVEQzRucngxa0hR?=
 =?utf-8?B?TGdKektwc1I2enNwRy8waW1Ob2g1WGtMdVJMaXRPNnBVLzljYXlBWTJTZk4w?=
 =?utf-8?B?eHBnQjV2dUt6alNFVE5GZUx4MU1BcThsOUM2Skt5WWJjUDRKNTIyNXpvcU1x?=
 =?utf-8?B?V0NQL1BHOGRCRDd3bHNnR213anJXQUl4Q2txdDVRZ3BtODVpVEJuWnBXa0FN?=
 =?utf-8?B?anZzQ051MUJqODRlR3huZ082NGZlck1WMng3bXdia0hCVlpNbU5QQjAvbGda?=
 =?utf-8?B?cmhzRTg4QkprL25zeTRPWUdDRmVjMXArSTdYYmhya1k4THNUaW8zMXZZRDAx?=
 =?utf-8?B?dnAvYjJ5Q2pZb3h3WGNBSDI0SzRYTldWczArZ2xCQVdRaGxMajQxeTJOTUpW?=
 =?utf-8?B?ZDlDZEloa2tpZHFqS21lRU9qa1YrazZ3STRib0RiL24yNy9PQng0THRENTdK?=
 =?utf-8?B?WlU3MTRuVW5ERW5OVk84V2lsV1l1RTliSHVBa3ZPOE5ENUhVK0RYR0dxY0w1?=
 =?utf-8?B?dWI5RDRsRTB6dVNzWEx0Vzk0OFBydEQrRHY4dEFnbW9UUW9Qd1MxVmJXbm9B?=
 =?utf-8?B?TENkeW5JYkxEaTdtVXgzd0lWSjlUcTdCVmtSd3hBM1pSVmpUVHZHcnpkMnBs?=
 =?utf-8?B?aHB2YTh6NTJmQjVEdW16bUc3UFFjZHl5VjJwZkpvMTVEYTVKbmpDSGx1TlU4?=
 =?utf-8?B?TGRpdk53RmFMTVBZeUNBZWlMNC9mTEh5TFlaV3habzdjaWYyR1AveWpmdk0y?=
 =?utf-8?B?NC9ZZ3F5ZVE1Z29BQ1FZUWw1RGFCRS92cjVmYTI3VnphRWFlRUt4RWpaUXRH?=
 =?utf-8?B?K1YvcXArVXEzeTRFOU5wNE5BdC9rSGJ5Y3ZxUU4rdFNuSTlJdExKMVBvV3R1?=
 =?utf-8?B?MlE5WEtOZVNoK0NlUW5xZ3V2TW5TOXEwMkxTRUxwTkdQdDhKZnRNYVNUQytq?=
 =?utf-8?B?d21COWhkVFRWS1RTMkczZmNIc1hzQ1RUdkF4bFVPUXNIUzB1T2dOaCtkOVhO?=
 =?utf-8?B?T0dmdlFLTjFUWEkwUVJpbExzbElsZmlRQStmU2VkdFNZMlNZRENDMkVvckdr?=
 =?utf-8?B?ckF5cHZYUEVmTzB4Nmt6TURSbXI0R2hYd2xwdkkySVRGZ2tVNWp1d2tXWFlZ?=
 =?utf-8?B?NDJrY0p0N3dIZWtWaDZFZmZ6eDhTSTRUOENvYzZPVk85NVRKZEhvQzYxb2Jh?=
 =?utf-8?B?ZjdYT3MvZ2xFcGcwa3ppblVUMEZZKzZNTS9TQ1R2S1lmUTJrQlpLU3BuSnNj?=
 =?utf-8?B?ZEs0SER3UE9qa1l0ZW9rSmlIbEhDaWY4SUNPN2UycTNkMWRFaDJUK05Cb1U1?=
 =?utf-8?B?WHo5R3JzcVROc3RKQUpJWnI5UGtKbnpHcVc1bE81YjdVTVdtQ0VhVlN1aS9Z?=
 =?utf-8?B?bWc2ZWNRWlNZci96TWh4YTBpRExsa3VxUzRwcm9LVXJtYi90SllueWEwUmVN?=
 =?utf-8?B?ODhrMDYxWXRLSFo2SmV2TnlxOTMyNnVpRUlCdy8yVDViSFU5RWJqeDVsd0Z6?=
 =?utf-8?B?Z3UyUE5ybGQ4TWMyUlZDendhWlNyaUVDb1dQNDg2MzdvcTZ0Wi9IdlRpbHlT?=
 =?utf-8?B?QVdBWlJVaDc3WUN6OUw1bkdjVFc4MVQvTlFTREtsU0laNHdYeGhrOFZ2MUtP?=
 =?utf-8?B?QU9VYXFrSFIrZlUxMGRRbVBodFhvRDBNWkdiNXVxK1lCVlhrYk82NnVPMG5O?=
 =?utf-8?B?VGxSNDdvdTZKM1E1bURpQVowZ0M5TGdTV3ROMmlWWGcrS0J4UzE1T0lkV2pa?=
 =?utf-8?B?aGcvbGxISGNzSUJvcmloU2s3MFdmNlp3Y0hQTjJSYWx5ZC8vbnlMeWF4MTFY?=
 =?utf-8?B?WVNlTStwNExzMmFEa2w0YmZFV2VFNjUyNkNiNVFJYXUwcXZSa3dTQm94Yllx?=
 =?utf-8?B?Q0NzOWdIcm9DUko0RWpibDdzV0xhdFpUTlA5eHhNNXZYWWNvbHpMUEF0cXpT?=
 =?utf-8?B?THpES0FUZEI5dnhKeUtUbDJJdTQ0VDlXS1lXU0FveTNoVENIb2thKzNINUQr?=
 =?utf-8?B?amg2UTNzQm85SG1VdytNc2xGYnhQSTJPWmNyZG5JZDdicm9adDhKMllzR3V3?=
 =?utf-8?B?Mms1WjRQTFBFKzRlaHdCWWh2NGtpNW1MZTZnNm44dzZ3Z1VZTkJRbWNLdlhu?=
 =?utf-8?B?d0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dce7cc35-3fbe-4120-9ba6-08dc31427175
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 12:01:02.2116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F26D1yPYPNyKEtcfSbuSzWOhYEp3wqyeyJlHwbBtYgjBDlOH7WCGfnUTqVjAA7xeiK0gVU4t8c7uLqgW42+sMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3643
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 19 Feb 2024 12:01:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15032

On 16.02.24 18:23, Quirin Gylstorff wrote:
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
>  classes/swupdate.bbclass                    | 46 +++++++++++
>  doc/README.swupdate.md                      | 86 +++++++++++++++++++++
>  recipes-core/images/swu/sw-description.tmpl |  1 +
>  3 files changed, 133 insertions(+)
> 
> diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
> index 403bdef..75a421d 100644
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

Can't we default to lua, just like SWUpdate?

> +
> +        script_type = d.getVarFlag(script_entry, "type")
> +        if not script_type:
> +            bb.warn(f"flag 'type' is empty for {script_entry} ")
> +            continue
> +
> +        allowed_script_types = ["lua", "shellscript", "preinstall", "postinstall"]
> +        if script_type not in allowed_script_types:
> +            bb.warn(f"flag 'type' is not of value {allowed_script_types} ")
> +            continue
> +
> +        script_data = d.getVarFlag(script_entry, "data")
> +        node = f"""
> +        {{
> +          filename = "{script_file}";
> +          type = "{script_type}";
> +        """
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

Looks good now otherwise.

Jan

-- 
Siemens AG, Technology
Linux Expert Center



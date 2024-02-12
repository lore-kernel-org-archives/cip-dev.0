Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D25AAC4829E
	for <webhook@archiver.kernel.org>; Mon, 12 Feb 2024 18:35:40 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.56])
 by mx.groups.io with SMTP id smtpd.web10.14320.1707762934840860332
 for <cip-dev@lists.cip-project.org>;
 Mon, 12 Feb 2024 10:35:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=GZeBxGhq;
 spf=pass (domain: siemens.com, ip: 40.107.21.56, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RPCGWJbb9xH5yLokphYx+c/VFyUPWZKnJrukLO4PfwjwFC9aJcU5UyDaBo8QVcfIHat1re1zeeKP17Km/BJGGan1t3QJqAh3LgWIoT9aAAWjWKss3U+patFtyaA7VDpSdr+Vv3sRk6kZjo6iTAnTx2vcgyUcuh2LnvSAizklAZ75rnl5pQgZ/TEvK8WKauBuhO+v/1ef2ykeGOliEJz5NQDWNLP2Y5roIBOoAPdt7xpZfpWKYF2jpGXsOUV3eIZhQRKLWgHjgbT1bZBizaF647XOW6lv+kuSCYe5SyCAI9O32l+hDqjXT971eGivFPVmbpAaRtbM6L8ov3Lh93YaMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c+e4Wfi3P/eWWDHd1LqrnHG221DsQcTfQHvPApBQLI8=;
 b=mwInHcMzJdYNeKq6LZx1Tau+uYdgK6+Ya3ArbvoGwbMqSjzUaT4GbqKCiA6nXJPajI/F0Gb3/G/72wCvXtrXxlC4hUoirem714x1VLXJEvojshD1s1dzYxNrZTcJAOUTnGeYYUQPMUyEDTwUq6pWVM6FqQOfQ0i2tVzpBeCS3DFpj+NhM8q82SkCKCZzlJi7+9Kd/TXuH2ehDqjJTHKUuPuThuJLBDtHCuS8GfHySBJqIg55BqpzmCMUNc7M2pWUjw3qehl1Sl9b+3iQCVSmBxESDbxnonnKJ38YVyse5eo03yz8509JWMAkIxPTLJN8NYe481XF71XBWfpyEi3G4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+e4Wfi3P/eWWDHd1LqrnHG221DsQcTfQHvPApBQLI8=;
 b=GZeBxGhqaJPATyW0zxrfdK8AvZlYq7tnkDm44QVpvjr9WSz6KBcymjDh6OY1OXcjlPaeepVBw4o8QOBxqEZRdzh/1QVKMJmUm0ZzAxxmUEw8SdfnJp7r8qBn3SMb++Ab+DbAClQZsn/zRwT0TUBP7TIt+lbGpKkdbr6xZjOwDH8XQztsyZHlDjDN75qmsmPaYznMKwo+ryYVPHx4+ajJbrBUmHcB2dWbCmKW2KCSSnjrkPDyHNGey0I6Qyvifzpz7anfSho8E+W9abVD3OZfd5/qA1uCxH17MUcAR3VDPzU4az5HWjc+iJCkk6jMBe0XAExjRJO2ery/TUcHkQDXSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB6848.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5f7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Mon, 12 Feb
 2024 18:35:31 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7270.028; Mon, 12 Feb 2024
 18:35:31 +0000
Message-ID: <b3e14112-8d6e-4280-8463-3ea109286b7c@siemens.com>
Date: Mon, 12 Feb 2024 19:35:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v4] swupdate.bbclass: add scripts
 section to the swu file
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, felix.moessbauer@siemens.com
References: <20240208104550.170816-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240208104550.170816-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0089.namprd03.prod.outlook.com
 (2603:10b6:610:cc::34) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB6848:EE_
X-MS-Office365-Filtering-Correlation-Id: 65c4fe9b-9f69-4a64-7843-08dc2bf9643e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	oQB8J57Yb1WvWDBRGAGW7K593Ot8thLM/w6GdSDJ8ocSxuBQ/4v9fEg2TEeWV+AjjZJBcpDzbfYIjeodf88DMTYffK0lrxY8+nW/lGeCaIKdm/2XCcRj8+XrHdDEA9k9/In2OBYNkRmzY9aTb2vEg+RSH7HAmVGxqtLXIwqAMcoHv4n/pxMXndy94SYwOwyccU5edNv2INFez9Exv4BGDqiwHArc8pYZZHvKiXPRTPpNYZfC069durDC2+r4Xihu2jmHu/MCMDFOxarR+owYVj7QHHxcc5lkVGUCfs9ZP3Qb6FaGqqvx3KM/KrpsvfG2ADbQpC05b3VfeWpad5sckFPPdJak36AII4W6qkZ1BpRe6bCWrleTkiEunNR5oa6cvV7HCbea0hpjxRUYJcGm+TjK7zlO2Tmaqe38Fr+gLN72IddjkkvZIqpQQY52TR8ERNzMKmUTfhbGhK16G9U5Sn95vAydPhb9TfY0dL3gT7NRTpJeGC/A8gO+hSAcri6PVgOapz135aCyxMg/ZNyKsBGyXLRHXAvvuoM+FDzlzwI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(396003)(376002)(39860400002)(230922051799003)(230273577357003)(1800799012)(451199024)(64100799003)(186009)(2906002)(5660300002)(6666004)(36756003)(2616005)(53546011)(6512007)(6506007)(6486002)(966005)(478600001)(82960400001)(38100700002)(86362001)(83380400001)(26005)(31696002)(8936002)(8676002)(44832011)(316002)(66946007)(66556008)(66476007)(6636002)(31686004)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?N1I4U1AvcVRDUSt4ZWFQY1orWGZoREFlSUdNdHY3S0xZWUdHLzNEcXRsa1Bk?=
 =?utf-8?B?Q2Q5VVNBaGVhaXFDNENGSHlibjlZcDJHVFVxU2FYeHJlbG9NSzY5RnVFdTZz?=
 =?utf-8?B?RmtXaXBZT2tIcGE0RE9jQXoxVGhEWGhiUDhYVEh1MWlwSy8weS80eUQxMjhF?=
 =?utf-8?B?dnhldEFlaUQ3eUZGbmdqVWJXcVBmOE56T3cyQnUzS3dDakVpV2lMUzdiaVJZ?=
 =?utf-8?B?NUZabDQyQm9XaER1c0tnazJlZk4reWlCQzNndjFQQ01RR2hOempmUGh5b0U1?=
 =?utf-8?B?cExncHRCcXNzUWI5US8wY2o0d1c2OE9IR3UvVGE4NWVTWStEUGxreUVMM0Uw?=
 =?utf-8?B?TkVsemhkTkZBeFRLTUR0WHRzakRuLzViL0RhUGZ1bW5iVGxaNDJiV0hwU05s?=
 =?utf-8?B?c3BLVm40L2RTYXpLQnRoVVlLMmoxOUlGWGdqVjVEeml6VDhTc05tRUtGNGtI?=
 =?utf-8?B?TU4vVnZnOHdHdGNwNm9oaWZtbG5mQ2pjbFJjVDZzSHU5TXVKZy9SYTA2MXZ4?=
 =?utf-8?B?bnc4aTJnZCt6di81dHR2bTF1RHpJSXBVOGhyeTFmVjdUdXZzOFlPQnpSOHF0?=
 =?utf-8?B?RmJOUURTTHBrRW1abUp2WVh0bWdva2lRaWlCb1hMWXJSc1hBZlB2enRUWmpz?=
 =?utf-8?B?ZjdzS2MvdnprQ2lzREZNYUlxRkkxRVROOEZtR08ydmRLUlJCK3BmVDR1TlFU?=
 =?utf-8?B?OS9zY0JLN0UxNTlpdHBkamxEZktqSm5GcEo4Vmc5NFp1YTgyUW1IcG92SGRq?=
 =?utf-8?B?amZuSFpKSWphZmdJOTY1MEdjU3BCUTk3TEthK0hVTVRjWWwxRGRkNDZWOVRG?=
 =?utf-8?B?OGFoZjg4VG4rbGxsb1REbExTT29JY2ZDaVBWL0dPUjhBM1FaVTNpeWxCTmFS?=
 =?utf-8?B?NHVrN2JubUNaeGk4VVlpRi9wNjZvanV4Wkszc0NQM0dRMGR3NnpJMTBPODhk?=
 =?utf-8?B?aWhSQ3NJenYrQlp1VU9xRmFZZWhHQ1Z0cjdmYXNDbUVBUWI5WDYwL0NtR1cv?=
 =?utf-8?B?a3JhYUg5YXlYRXZuNjRQVzllOTBpckxJSVRabUVhc1pTelcrNUFQZlBZbmdC?=
 =?utf-8?B?L0tNMTFncjNmUitnZXlqTHhxRUYzUlB5MThiZjNDUkMwMFVvRGhUcm9pdFg0?=
 =?utf-8?B?Zlk2UTBWRzUzSlJ3OUV3R29UWER5aEdyM3Z0WWlQcExlR1ZENm00SXlLUmor?=
 =?utf-8?B?YkZrUDdlV1lrOXFnUGgxaUFTeEZXaGFLMDg5NkRzaVdzRTdIOFRTMVhnbllO?=
 =?utf-8?B?OXVucG4yUndCWncwSHBpUTRFOEw4ZG16ejNiSmUya25NY25HYkRUVEk3WWFP?=
 =?utf-8?B?T1hjWUsyQ1lnWmNjczJEQU5Ic3QyNnBFdkg4M1hLZXRCN3ZqK2dEcXlJbVhi?=
 =?utf-8?B?Z3l2emdWdWkvV1haR3hBTG9tREZqQWgvVE5OMlpXc0lCclR2L1ZaMXBBNW1S?=
 =?utf-8?B?cE92SUhvRGQwbUhybnY4YXF1VTVSUnBaRGMzRW9tNjEwajlUK2lyWllUUDBz?=
 =?utf-8?B?eDBHeW5iNjhKOEhQRjNXajNxQ0NwUU5icUhlQmJ5b2d6aWl6OERvMG9tN2xy?=
 =?utf-8?B?a1k3T1hSTndFVElwMFlISEc1cEM3WHFRQnROMmJodEFwbDYyMmJCc2ExMngy?=
 =?utf-8?B?TVpOa3BPSVdnbzE0NUJTejlRMXlXNGF6bmxsWmcremVTQXFteExrb1BCVTN2?=
 =?utf-8?B?R2owVjBIaHU1VDQ2Nk10elFVUWdFSWRnalQxNWZsb3J5OFdZVWJtZVYxUjBt?=
 =?utf-8?B?SWFvRGt0VlpkSEVRQktnS2todkZXQUVUTEVVU05LVGpiM25QejNBTDhFYm92?=
 =?utf-8?B?VVZTbkJpNmlNMjd3THBzWGg5MDN5Z1BaemprKzU4T2l0aENOOG1Td2Z3NFg5?=
 =?utf-8?B?T3FkN2FqeWtBNDhBR1VZVktNTWtJaGJEc2ZpeWVzQ2ZhMFBwTDIvaDJGY001?=
 =?utf-8?B?clRoZVJXbHFDY1RiNENmQnZZMS9hdjcyK1p3V3RMTGx4ZTBiV0ZNVnpDeTE1?=
 =?utf-8?B?NTNuQk5IV0JrK1RYbU11Z09SMnhuN2g2dWsvWjh5S0Z2aDNkWjJrWXhqL082?=
 =?utf-8?B?cVFUd2FDaDBCQTlqTDltMkpzNnVqNSswUjUySnFOTzdnem10Z1ROWHRoUzBj?=
 =?utf-8?B?YmRuVWV6blBiZnk2aXd6enlLTU12ZW50ZTJDbWtZWmJFL29paE1jbUVmbVd0?=
 =?utf-8?B?UXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65c4fe9b-9f69-4a64-7843-08dc2bf9643e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 18:35:31.0480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JyXAod8XwDEGaZrEydloCamfZtrH5nlVhgW6rh1+9nhn00hqbtcyVvskCiPj1/w7CTV70R24Yvy2FzrdB+Vt8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6848
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 12 Feb 2024 18:35:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14926

On 08.02.24 11:45, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This allows the user to add scripts[1] to the swu file by
> setting the variable `SWU_SCRIPTS`. Scripts can be used to
> prepare the system for an update.
> 
> ```
> SWU_SCRIPTS = "<script_file_name>@<script_type>@<optional_data>"
> ```
> This will add  `file://<script_file_name>` to the variable `SRC_URI` and
> `<script_file_name>` to `SWU_ADDTIONAL_FILES`. The sw-description will contain
> the following section:
> ```
>     scripts: (
>         {
>           filename = "<script_file_name>";
>           type = "<script_type>";
>           data = "<optional_data>";
>           sha256 = "<automatically added sha256 of script_file_name>";
>         },):
> ```
> 
> [1]: https://sbabic.github.io/swupdate/sw-description.html?#scripts
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
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
> 
>  classes/swupdate.bbclass                    | 38 +++++++++++
>  doc/README.swupdate.md                      | 71 +++++++++++++++++++++
>  recipes-core/images/swu/sw-description.tmpl |  1 +
>  3 files changed, 110 insertions(+)
> 
> diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
> index 403bdef..0c451cc 100644
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
> @@ -93,6 +94,43 @@ python add_swu_compression(){
>          d.setVar('SWU_COMPRESSION_NODE', '')
>  }
>  
> +
> +SWU_EXTEND_SW_DESCRIPTION += "add_scripts"
> +python add_scripts(){
> +    swu_scripts = d.getVar('SWU_SCRIPTS')
> +    if not swu_scripts:
> +        return
> +    swu_script_entries = [ s for s in swu_scripts.split() ]
> +    script_node_list = []
> +    for entry in swu_script_entries:
> +        script_elems = entry.split('@')
> +        if len(script_elems) < 2:
> +            bb.warn(f"SWU_SCRIPTS entry:'{entry}' is missing elements.")
> +            continue
> +
> +        script_file = script_elems[0]
> +        script_type = script_elems[1]
> +        script_data = None
> +        if len(script_elems) > 2:
> +            script_data = script_elems[2]
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
> index 1c94699..1a7fa0f 100644
> --- a/doc/README.swupdate.md
> +++ b/doc/README.swupdate.md
> @@ -21,6 +21,77 @@ window is still possible.
>  If the variable `SWU_EBG_UPDATE` is set to `"1"` the update is also stored in
>  the `*.swu` file.
>  
> +## SWUpdate scripts
> +
> +It is possible to add [scripts](https://sbabic.github.io/swupdate/sw-description.html?#scripts) to a swu file.
> +
> +To add a script entry in isar-cip-core set the variable `SWU_SCRIPTS`.
> +The content of the variable has the following pattern:
> +`<script_file_name>@<script_type>@<optional_data>`

Is that "@" separator sufficient to separate all types of information?
What is "optional_data", and what do I do when it needs to contain
blanks? What if I don't need it?

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

Err, that is not in line with code and description above. It is more
readable.

If there weren't that 'data' field, SWU_SCRIPTS_<type> = "script1
script2" etc. would be very convenient and self-explanatory. I do not
like the other format, just visually.

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
> +        },):
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
> +SWU_SCRIPTS = "luascript.lua@lua@some_data"
> +
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
> +        },):
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

Jan

-- 
Siemens AG, Technology
Linux Expert Center



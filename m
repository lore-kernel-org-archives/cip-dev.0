Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8610C48BF8
	for <webhook@archiver.kernel.org>; Thu, 22 Feb 2024 16:31:38 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.66])
 by mx.groups.io with SMTP id smtpd.web10.17331.1708619489592837725
 for <cip-dev@lists.cip-project.org>;
 Thu, 22 Feb 2024 08:31:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=K2zERsyd;
 spf=pass (domain: siemens.com, ip: 40.107.20.66, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gnCrkIA0/PlHrIQXwFPWOhawfbO+GRb3GiaG4hZQBuDBU+ssOSDixNt+TtmiRB29W1wWdc6ZGQCmGEkfBAwOE9DB8NL9fethJPbQFFeJ+fcJIJCsSXTJEmoNNkdEN7UKsdWZQlYcFhht6zmJCBNaeorpWY2lvy53e4qi++8IDkwTjjt9H1QuAct2X37A3P/pKZsyTNftvt9XLSq+2PzrROg8UQ77HjcsNZ93BEnNiUegJjkx7cdBMni5wcmAyYf7tXsgmmxXXzuJY8qH6YYEND6lod7ickegDUXbhxoJiwFnVy77ypo3IGOGNsTUtfjBOQcHTjycAg4TEPPZlXXpPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZlVrWxPNO4HvuVmgakKMqk+7vyw+iMC1XIamkwygGvs=;
 b=krlpA9H0WXdwniSJZaae+Nu7ZxuiNxv+OavKwdPw/EqgYWXghxnL8jRDiViQKkWCaM3AOBwEYHf0RSkMeqy84VA+rHMlQLzVVoP1vr1w37GjJIZIGYYUXCKgZed7AQo/DdSmKjiJILbdhoij6kvsHZh/ZFZY0RfDKQNCQry6+MM/aYIR6TxVP3Gybko/RNIsSIvZGs9Q/X5adUvy8yw5u7MrPsw3s7NHWk8Vh3H6OitfEHP1PuLkH8+UwnNaNuMTAvklMegXw7qZRD6HNg9eCM7p11g6N4p+O+KpFIBz4NNq4fHfYmGTH0lCW3XMzQfnT8+ULiNWUcodNwXgVJvduQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZlVrWxPNO4HvuVmgakKMqk+7vyw+iMC1XIamkwygGvs=;
 b=K2zERsydk+QVX1zmQ+Rkk4JqmjoXNNUS26TwgjuL/QeTwqQfUPzh6MIeE8B+JudlVnCiSE1SzjR7T4t5X8k4AkT8TfAZAzJdM0IJbdp7OnhXNcN7Jzh7gphVgAvF5Kcw7jPcKozqtxT9X5RdRIJuxFXuK78g/fa70xVyKB7kMIvwa96O0Dyq5b4FTKEdvV1sgeTj1C9moSUyHDHNixDT0qOAlX/Frd9wkuYiK9hiFeLrkUKViDuzqg66lKQmzH3os2KAWQ+4/+RPTaSmzm64siN7a8Ojw5g5vXHOLAbVaCmilFQSESZ0V/DXAA6O5UXqarFqEU80Icr4SrEerJZ6Jg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3157.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:105::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Thu, 22 Feb
 2024 16:31:26 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7292.036; Thu, 22 Feb 2024
 16:31:26 +0000
Message-ID: <425d6ed0-66c4-4bdf-9707-eb03481fce4a@siemens.com>
Date: Thu, 22 Feb 2024 17:31:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v7] swupdate.bbclass: add scripts
 section to the swu file
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, felix.moessbauer@siemens.com
References: <20240222141526.1431859-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240222141526.1431859-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR08CA0009.namprd08.prod.outlook.com
 (2603:10b6:610:5a::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3157:EE_
X-MS-Office365-Filtering-Correlation-Id: 1392af30-2c1e-42a2-de04-08dc33c3b6e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	7E1OX8E0hI6q4zup/CgoTKux20jw/cQoM2FN3lPp46osQHsGuIBISGFQ28a84Fw6yjvgEVGPcfeBAt3Wi9vvVLnQFUt4fTipA1Z8QjhG5yrrJYnlibSKfgq78SwhkZDJBsuzq35KwPvDKnFJ4WhYOp2n9vyklvEhYMi03PtCUcmcLd1jNogKuz2lzg/TuH8orhEo1C3F24/V+clTFTOBsui3ZlfTuSNpag3O173tqHYJapKQ0i7rrQfUFbmjq8ZoOA2vRrOW6eEWGzY3JtKsudf/4b0i1kPGyGXj71xknHxYtxXkc+8UDKC6cKDjz9ih17VXug9R3ibgdBNpiZbF75ub7X9dRgVPGE5XCwq0IRwxsCeOwqgDYfNVHP3LAQsZb2NwF0kFIGeE2zK1pxp3Qrcvu+rQTvQccMglDt5ZGH/Mmuwd7BrwStofJt6/0NAxXTaJxYFS1MjQRgm3bfIhHeucF1dYg25HG63Wk9/s+rhdQZSzZepxYiY+Ab3/xMhHT+raVWJDkUEkS1JwUQkDLGcabA5snLmhqVO4C13L6mA=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(230273577357003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WURRV0dGdlNIcXN3SWYwQTJmWDlkK2RVeHptWHhObktEcE8xdkFuTkw1dUdD?=
 =?utf-8?B?NjAxQXVIUVV5YzlGUkpKbmRpQUMxWFlnZkNSQ3BXRFNHT3VCTkt1d1ZBYWJI?=
 =?utf-8?B?V09ya3hrckRaR3VjSGVXcjVUZWFxVHJoMDU1WThLcG9KUGlnSnZYRXF4cGxF?=
 =?utf-8?B?dU5Fckt1KzVDeW5BQk03WEVQZE4wNjdCOTZtZDM0cHY1NzhPSVM3QzZsY05E?=
 =?utf-8?B?bEVmeDdQMXRQR2dCMHZtMlFma2hJc09YNG9Tb1JuK1BBR2pFNVV2UmxGcis2?=
 =?utf-8?B?N2p0Q1dVc0FYaldVSXViTlM3alJVcUd3T1VkbzNNcXVrU2JBdTNGelFQU0ow?=
 =?utf-8?B?K2pIOEtRTDVNWjhzdG5MT29Pa21lZ3BnK2UwQXVndm5mOExiRy9hTVhlVUI0?=
 =?utf-8?B?aGtaa2RCZmZzR1dWMEQ5MEVoa1hYdGYveVgyeGVGb0kvK3ZUSnFTM0FDR01U?=
 =?utf-8?B?eVV0WlNyTmNMc1NXNU9Xa1owZDdrZnF3aVVac1JseC95Z1IxZjNjOGRzNUU1?=
 =?utf-8?B?aWRhckliOFY5dVpXWTB6QTZpL2VydnY4RFprQlk4SXYwVEREMkU0UTNnZEtJ?=
 =?utf-8?B?YXhaRy96cHZWelI5cEhuVSt2YThNVVdDUnNtRFoyVWgwOHhqQ0h3Tk1vbDJh?=
 =?utf-8?B?ZnBCaHZSdUZ1OEtaYk1Vc0ozYndLQnFXVXlqYW1VZ0c5OWx1VDhRU29BKzRi?=
 =?utf-8?B?WXFNMHdxdEp5ZnNwUnNaYnd6UXo5bm5BRitUbFFpR3QvWXpzZ3g4ZFlOZXYz?=
 =?utf-8?B?SVhubTUzOFRzMWp2cTRPVjE4TmV5YkRQdDUyeXIxc3U1R3R1U1FBcVFsUVha?=
 =?utf-8?B?SW1vWEZDdTJ1T3FCZ1p1T0Y0NWsvUDk2TWtIUGlhTmRDSGlRd3dOQ3FGREhI?=
 =?utf-8?B?U3lJS3Q1WGZUYWg3OVZmdStHT1ZQZ2xBZUx0bjY1TVZoVmxZYWxxc0djQXlp?=
 =?utf-8?B?VURqdmo4WDhGMDN2OW5tS0VwZ1ExRERmbXpOOVpLQlhxSndqbFBSUTFUY3l3?=
 =?utf-8?B?SVhHelU2NHEwNlhaemg4U1pJS2g3eDRtRy9pUWprWFZCbWVIcFJqWkVBYStl?=
 =?utf-8?B?aUxMRUhzS0w3RGJyMDYyTE5Cc0xFTnNXMHowY0JCQ3ZsMStYMVVwbnBKVzYx?=
 =?utf-8?B?ZmxwNW10dnE0Sk4xZS90bWNtNzFTUmtvMnVQYzlISXF1VzR1Q3pjaGJSZkJN?=
 =?utf-8?B?Q25PSWVxd1BsZ2UwcTlqclFTbTVtUDF4MS9uZGFkQmNpbXRtcEJTUWRXMXow?=
 =?utf-8?B?aGRvZTZnS1RZcERJclN3Y2xsaElMeUY4YUtaYk9CRWZXY3JmUC9HdzkwSVRL?=
 =?utf-8?B?ZS9VcGdmTjBVZVlwRlkyQTFGdEFkbkJzL2E5YWNYQkp6TTJNYjRNZFA5UFBi?=
 =?utf-8?B?VDR0M0R5L250TGRoeUVWUkxnc3VtTW5GS0V4L1Y1ZUxFb1l0R21xcTIyNllF?=
 =?utf-8?B?ZTN5bEtmdm43ZC91bGNWeC92ZVdnQ1lnQ0VlRlVJNjBqNm55SzNmaWlqa05D?=
 =?utf-8?B?a25QelI2RjR6WWV2eGFWdlZzNnR2QmN5U2QvRE9mQjZRcjcrdnU1RmM3R3hq?=
 =?utf-8?B?eWhhS1BuL0Q5ZEZiOEdxWWo1UVhSTGV1TDA2b3RuYnZ0YmlWVFB2OEc3eklp?=
 =?utf-8?B?d3hRaWdONGNMWnNiOU5wMGhCMmVJOWlOS09JZnRDa3hLN21RZ2dQaHhaeTJR?=
 =?utf-8?B?NnhJS0xuM3IybU1pdDZqQjN4QjY4ME5ENWtuRUxDVkRvYUEzajM3NmZpTVFn?=
 =?utf-8?B?L01qVEEwR3dXSWtsZnczL04xOFhGOVVnSVRTTHpjU2M0cVBvM0ZUclhUU3Qy?=
 =?utf-8?B?N08rekpxVWZqVDlKN2NNbUNQaENmNDZONkxSTnh6RHd4WkZXZGJRS0M4RVNl?=
 =?utf-8?B?eFRjN3JCb0FHVmU5UHBVb2o3ZndUS1J4b2J6QURKR2xUVnd4Y1ZybUQ2MW1E?=
 =?utf-8?B?aS83S3E3KzNkNHBlMTBFd1RXb0tsOUZhNEZPRDBQTllaeVlaU3A4dHRsdGJZ?=
 =?utf-8?B?MTlFSlp3MmJPdXF0eXZFYTVCd1VIUkFsZUs4NzZLWnpoT3p2b1BwVnJVcm9G?=
 =?utf-8?B?Zy94emZlT2dUeVpnbUM0akV3MTFvNThYTHNNdlRoRUlPMU0veWRiSmRXTklJ?=
 =?utf-8?B?aTA4K2RrVWNtamYzOWp4SnQ4SUppbVZHZEFMaTc4aHM5MHVLWk94UzZ1MHFU?=
 =?utf-8?B?YVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1392af30-2c1e-42a2-de04-08dc33c3b6e6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 16:31:26.0906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 95D2WAJU4BQLwMrea7fn08Fqu6Kjm7kX6JiIA7ptiziH+abrHs+nr7US8VC2lRiLP6j1rotrFPNJeq0Z4fEzLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3157
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 22 Feb 2024 16:31:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15065

On 22.02.24 15:14, Quirin Gylstorff wrote:
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
> Changes v7:
>  - remove message in case of missing type
>  - change documentation for flag type
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
> 
> 
>  classes/swupdate.bbclass                    | 43 ++++++++++
>  doc/README.swupdate.md                      | 90 +++++++++++++++++++++
>  recipes-core/images/swu/sw-description.tmpl |  1 +
>  3 files changed, 134 insertions(+)
> 
> diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
> index 403bdef..2c69892 100644
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
> @@ -93,6 +94,48 @@ python add_swu_compression(){
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
> index 1c94699..cf1bcfb 100644
> --- a/doc/README.swupdate.md
> +++ b/doc/README.swupdate.md
> @@ -21,6 +21,96 @@ window is still possible.
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
> +```
> +
> +The optional flag `type` can be used to set one of the following script types:
> + - [lua](https://sbabic.github.io/swupdate/sw-description.html#lua)
> + - [shellscript](https://sbabic.github.io/swupdate/sw-description.html#shellscript)
> + - [preinstall](https://sbabic.github.io/swupdate/sw-description.html#preinstall)
> + - [postinstall](https://sbabic.github.io/swupdate/sw-description.html#postinstall)
> +
> +If no type is given SWUpdate defaults to "lua".
> +```
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
> +and `SWU_ADDITIONAL_FILES`. Therefore, it needs to be saved in a `FILESPATH`
> +location.
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

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Linux Expert Center



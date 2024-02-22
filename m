Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59857C48BEB
	for <webhook@archiver.kernel.org>; Thu, 22 Feb 2024 11:47:47 +0000 (UTC)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (EUR01-DB5-obe.outbound.protection.outlook.com [40.107.15.83])
 by mx.groups.io with SMTP id smtpd.web10.10981.1708602459361047070
 for <cip-dev@lists.cip-project.org>;
 Thu, 22 Feb 2024 03:47:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=bkj+YCiT;
 spf=pass (domain: siemens.com, ip: 40.107.15.83, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jammCFRa+sfUZScA3Qd4chGsiQ3naxr8YnF6lu38t95JpUDKvMMCEDxhUADL2gERo256ZArSwZTEU6g00UPV+2ZkDd49p/yjN6ErWblkgD8KVd00LyYsmEWQDWx5mhQv+kEHULsyVaOmSUGu0cXEP9jy/d0sxjsoh1OFYHFk7dP88LRNonQMF9pHUCXZu3JRLrtxVp9WPrR/vCgqKEUlWbFMAGipGdsrf6C6srHjNEv/ji8REsw+I8GM5mfPVafDHdrzF1prp6EPgiDxbFujd6S0B3BImUXD6h0B0ntclKptCYv4l4LVYqKjUMMLieSCD7CU6auVkT4zOnMlMz9uOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PI/LjsiohZ4QIIE4RtCUsPFIws+BASyZX+5kZQ/WWM8=;
 b=RQbFnWpN8yonVNA0hNd30zo/iZNLDa579IlLIz5iSQqc5IfyzWxmCAuhxHy3s9Sernc7HRJzauPyAD8eJJJZtabfJIzTCWNwi/t4IcsBvCATDDTjJia9z3CD2xWTKcZ/K/ca1oYa0I9F6C4mwIN1waM3Dg9sFeJD/eaAE07eYbcKpmPgym05Jzt+oj+JPZ7PMZAVmAnR9Q3M6iCXtUYDr1VMcN2CnyBzLE1388MNqR8wAUJ04JzS1uQzVzR9f9bXsWJO9K04m7ehb5Ed2hLhP+9Txax8Q9sYxTC4hawW5OH5LRA6VYPjdJzWTS4xLPp21XohI091ycE1yWsFTe9+ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PI/LjsiohZ4QIIE4RtCUsPFIws+BASyZX+5kZQ/WWM8=;
 b=bkj+YCiTBuLgzkahNqaoKjGnDCxy7B8MG41OqX42lEjWxS+a3aQ2cR2dzeoWH1NrBbuLje+5d3gmsC8O0M8mlSPzVb//mGxm6zPHQZY+inFMkjuBhngjy6bIDq3x//VEIki8NeoiKJ+i7xisF4ktuish+hkFIvkyBUpTvw5vzrWHuIFJM6IqcevLCNEFflkmWhlMqFerXB61lnZGptGAgs9ZqesbcJJPHP6zdD9+vII/hXnxGrHatwI8nTb3BT3WDnNxc5xDQlPwb060YOiSLF6K725uIi1TEbMutpyrln8wZQdg6WaD8MBDpLf+8xyTp+1YCPggV3JrGqDnnutchw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PR3PR10MB4096.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a5::7)
 by AM0PR10MB3475.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:15d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Thu, 22 Feb
 2024 11:47:36 +0000
Received: from PR3PR10MB4096.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9863:3df9:1e58:24c3]) by PR3PR10MB4096.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9863:3df9:1e58:24c3%4]) with mapi id 15.20.7292.029; Thu, 22 Feb 2024
 11:47:36 +0000
Message-ID: <9e23bdf2-a914-4498-aac9-3324baf000ef@siemens.com>
Date: Thu, 22 Feb 2024 12:47:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v5] swupdate.bbclass: add scripts
 section to the swu file
Content-Language: en-US, de-DE
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
References: <20240216172348.313789-1-Quirin.Gylstorff@siemens.com>
 <c289979e-c222-4464-8ee8-b7b1f2e71aa5@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <c289979e-c222-4464-8ee8-b7b1f2e71aa5@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0116.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::16) To PR3PR10MB4096.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:a5::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR3PR10MB4096:EE_|AM0PR10MB3475:EE_
X-MS-Office365-Filtering-Correlation-Id: a7c4bae8-23b1-4433-6187-08dc339c1077
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	64nTQvTVPKMfpiLq3qfQuPVd5THRBSocegJL3Bkkv0T6XgW0CyT46cchrlj4A2sR1LpBiSLG9EAIeU+Pqb1z5WCAof+jdisqWSkWiEVQ4+Q0MrouvHDHrIDcXq60mnsQQDuz6grAk6gLh9ET/97fr7Uapviic4Tsk1HRorIow79bCWmV/onv3u7rx4wSZhd4ynB8aUiKreAxZDvvE9P2pTGBb2StRV9YCLQbuVDC5sLKpCqeqIBwiFZEy9Lokp5umvG4hS6teBfJWqHM/IYzgtzz03c2JUKIqPaEUz+5aiBOONjpbL5+wk2s7gQrIPDE+JsStqYW0YVD7gTcoH9dMaPn9NjkJa+izZGpQd45fjWIKK2eR6/i8UjlW/9TlW9KpGLn/4s4yoJRkx/zEeCbiol4R/mmAClLC810+JgpfQhb2kDqbzeJ729ZPylSfIJMUWemw1El9jsNXWOB8vPEjkMrZ1TWM1qoetMtV/BIeYIKnpUcj2lewCxmt/tAzF+czlUrtnEdtic1bLl0+QrZs2fukoWdVGmrsxEcPoeq850=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR10MB4096.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(230273577357003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VCtIOFZPNUtmUktJcHhJdkQvenRCOGVSSWZFZVFGaWtKRDJVUUFoTjhkOGYr?=
 =?utf-8?B?RlNrdHdVTzlTdTlzV1FrVEVCRkpyT2psR1FwOVNYWjdsVXNxd1MxTmZ1Qm5n?=
 =?utf-8?B?Q3NaK1g3UmFQTGc3NzcvNXpvTWZkbXdsWEVkMXJIVU5rVlE2dGxxcllGSFFF?=
 =?utf-8?B?RVNZY2EzNklhZ3FiZDcrWGpGUkprTytFSVE4Y0p2bVB5R2dLNEVZbkZlR0ZO?=
 =?utf-8?B?WHNkMUtqcVE3OHZtTXE0Q25yL1A4NWY0cHg0NnhxdGtkTk9nY2ZKSDhkejR0?=
 =?utf-8?B?QVpISGpiUG9NT3h3VHFGZldmRjdUN2x3UEpyMlAwV0VMOFdrVnZPSnIxT0Vx?=
 =?utf-8?B?WVJEUUdPOUdhTE51aGpYdEI4SkViSFdoU1lJaWdzUkhDOEt1WFBaeE01V1V4?=
 =?utf-8?B?WGpyQlBvZXZmRkFnYWhWZFhsVWNtZU5zZHY3a3djV1hWdFpubVpsSGVVZ0No?=
 =?utf-8?B?c1F0bFpYWlFldFV0YW85SDVWeXp5M1dsK05zZ3pLeWpsTldzb1djVmk0ZVhF?=
 =?utf-8?B?dXNjSTMveGJCSnhZUkplbVlFRlFiT0YwUmEyYS8yVGhDNllhdSsvRnphUzA2?=
 =?utf-8?B?ck9qUWlWWk9vK1Z2MHlkSmR0b3pNNWFaOWgrWHJZd3ptSTUxTktCWjRLY1BM?=
 =?utf-8?B?RWowc2x1NElrWnYva3huNVZkeFJIL2o3RHlaWGlHb3FhN0paTjRQZE1Ic1VI?=
 =?utf-8?B?aWE4TWFsano1THFQckhUdnphY1VKODFPVzRpS1hCODF1R2JUZFNHUzlpZndT?=
 =?utf-8?B?bnV5RXNyVVRyY0RBZXhHV01UMFdyYloveDdwU3RPV3VocStNQml5NkdhTUYy?=
 =?utf-8?B?WmpPbFFpbHprTDVtL1Y4V0tSZ2pkMEJXbVFSb1M3RC9LNnFWbnpZV0w3Rk85?=
 =?utf-8?B?TG5pYWZGY1pZR0F6L3pCLzloNUdkQXFMU0tVd2Q0Q04zeTdUSFFZa1FGUzZW?=
 =?utf-8?B?N1hqR1djK096NnlTalZ0a1AzTWxWYlRLeWNPaTFIaU5TbnJ1Z3hlNTAwVitw?=
 =?utf-8?B?cm5yd1M5MmhsM3FkcE91ZW9EV1cvS1JvcFRyMmhkU0V6eFZlWWZtSGVCdHNY?=
 =?utf-8?B?MmlRdzlkaFFqT2xwRGgzdFVBZi9zNlAzT3lHVUYyYXJmU2ltalIvYzhnMzJL?=
 =?utf-8?B?anA3OFRuaDlBQ1NzeG9XcWtnNXp5dDRQU25vSktldVBDcVVKSGovdENsa09z?=
 =?utf-8?B?V2pxOW9MVHJqUnNVbDVoVEd4d2liT2xRM0Uyakp4TkVxMHl4T2pYbkJKN3ho?=
 =?utf-8?B?WGxTSjZkK1Z2L1NtMmlXUlhSQkxYUnNXZU0wUXRzbzdwaTNCYWpMc1MwVnNB?=
 =?utf-8?B?VXFlR20rVCt3d3dPbUtzNGw0ZitXd0wyYStwbzVTQkFrZ1pnbWNHTmxrbmRE?=
 =?utf-8?B?N25oYzhTb3EwR2JMUnYxNXlRYnZuQldxVFFXZDRvNUQ3cjR1RVRLKzNSSG4z?=
 =?utf-8?B?akJBS3dXYjVnM01icXgvTHdhZE9sS3RyNFdYRXBnTWxxZy93bUxQbUt6a0ta?=
 =?utf-8?B?QzlBamZWZVRDSURGekloeGNjRlNyZkcxVnFXVFNSRVpXTy9VcVppWCtMZjhB?=
 =?utf-8?B?UnZpWmhYUVZKMWdqOFlTT3hucE85SXhDZWRGZVl2cGdYcEYrK0pxTVlLaFdj?=
 =?utf-8?B?OGdnWWx0STFiTTRBSlBKNHJNZlZPSTZycDVQWlFLSWJKOHlSWGk0UU81TzEz?=
 =?utf-8?B?ZkJ2WWxGWGdXSjNTN2Erc3l0TVcrZzNIU0d2amg0aWVuMUFJYnFYUEdOOG5U?=
 =?utf-8?B?L2VNNUZlOVZHSDNhdFZTOExGcWNZd3lMTHRkODNkdlRHc21ScEpPQTBjaTY2?=
 =?utf-8?B?K0hBdWEraU5CQ2hBd2JkODN5eC9VSnpody94NGtVUUg5emtwYmM2MlZEUk1i?=
 =?utf-8?B?dys5ZWhKTGlTazVGY0pJWWlKUVRIVC9NbnVqUTViQlUvVDJSWWZBdjRiS252?=
 =?utf-8?B?Z1FFTEp6Zkk2MWFrKzk4UmRyeEFEZFI3OVJySUswRDFJbnkrWThDaWtmVVZ1?=
 =?utf-8?B?YzVCYytyaUxmV0xWd094TWlyOUdJd3pYR255dDZ3UEdackxJcEVJTDhlNGEy?=
 =?utf-8?B?Und3dzVla20xSmVyVGRocXBDYnRqRFlUVURyL3lMZS9KSnNMZ3Y3S1B6NU9E?=
 =?utf-8?B?eTIzRDluRHBFQ0xYeFZHeTdOcnZja2pnZWUzY3dpbmREc2w4RUNhclVUdkhP?=
 =?utf-8?B?c2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7c4bae8-23b1-4433-6187-08dc339c1077
X-MS-Exchange-CrossTenant-AuthSource: PR3PR10MB4096.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 11:47:36.5123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3jvZi7cbuOS4zrFvIjimgSicCO1JyzT7r42YDayDYpu2UY4/iTFe3wXe57LR8ZS8AxlzivGC73epGZ044rinY3JJXzo4o8Rn2BTnqUbr3oo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3475
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 22 Feb 2024 11:47:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15059



On 2/19/24 13:01, Jan Kiszka wrote:
> On 16.02.24 18:23, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> This allows the user to add scripts[1] to the swu file by
>> setting the variable `SWU_SCRIPTS`. Scripts can be used to
>> prepare the system for an update.
>>
>> ```
>> SWU_SCRIPTS = "postinstall"
>> SWU_SCRIPT_postinstall[file] = "postinstall.sh"
>> SWU_SCRIPT_postinstall[type] = "postinstall"
>> ```
>> An optional data element is possible with
>>
>> ```
>> SWU_SCRIPT_postinstall[data]= "some_data"
>> ```
>>
>> This will add  `file://<script_file_name>` to the variable `SRC_URI` and
>> `<script_file_name>` to `SWU_ADDTIONAL_FILES`. The sw-description will contain
>> the following section:
>> ```
>>      scripts: (
>>          {
>>            filename = "<script_file_name>";
>>            type = "<script_type>";
>>            data = "<script_data>";
>>            sha256 = "<automatically added sha256 of script_file_name>";
>>          },):
>> ```
>>
>> [1]: https://sbabic.github.io/swupdate/sw-description.html?#scripts
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   classes/swupdate.bbclass                    | 46 +++++++++++
>>   doc/README.swupdate.md                      | 86 +++++++++++++++++++++
>>   recipes-core/images/swu/sw-description.tmpl |  1 +
>>   3 files changed, 133 insertions(+)
>>
>> diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
>> index 403bdef..75a421d 100644
>> --- a/classes/swupdate.bbclass
>> +++ b/classes/swupdate.bbclass
>> @@ -57,6 +57,7 @@ IMAGE_TEMPLATE_VARS:swu = " \
>>       SWU_NAME \
>>       SWU_FILE_NODES \
>>       SWU_BOOTLOADER_FILE_NODE \
>> +    SWU_SCRIPTS_NODE \
>>       "
>>   
>>   # TARGET_IMAGE_UUID needs to be generated before completing the template
>> @@ -93,6 +94,51 @@ python add_swu_compression(){
>>           d.setVar('SWU_COMPRESSION_NODE', '')
>>   }
>>   
>> +
>> +SWU_EXTEND_SW_DESCRIPTION += "add_scripts"
>> +python add_scripts(){
>> +    swu_scripts = d.getVar('SWU_SCRIPTS')
>> +    if not swu_scripts:
>> +        return
>> +    swu_script_entries = swu_scripts.split()
>> +    script_node_list = []
>> +    for entry in swu_script_entries:
>> +        script_entry = f"SWU_SCRIPT_{entry}"
>> +
>> +        script_file = d.getVarFlag(script_entry, "file")
>> +        if not script_file:
>> +            bb.warn(f"flag 'file' is empty for {script_entry} ")
>> +            continue
> 
> Can't we default to lua, just like SWUpdate?

You mean the script type. Sure I will send a v6. The script name needs 
unfortunately set  ;-)

I will change the warning to info in that case.

Quirin

> 
>> +
>> +        script_type = d.getVarFlag(script_entry, "type")
>> +        if not script_type:
>> +            bb.warn(f"flag 'type' is empty for {script_entry} ")
>> +            continue
>> +
>> +        allowed_script_types = ["lua", "shellscript", "preinstall", "postinstall"]
>> +        if script_type not in allowed_script_types:
>> +            bb.warn(f"flag 'type' is not of value {allowed_script_types} ")
>> +            continue
>> +
>> +        script_data = d.getVarFlag(script_entry, "data")
>> +        node = f"""
>> +        {{
>> +          filename = "{script_file}";
>> +          type = "{script_type}";
>> +        """
>> +        if script_data:
>> +            node += f"""  data = "{script_data}";"""
>> +        node += f"""
>> +          sha256 = "{script_file}-sha256";
>> +        }}"""
>> +        script_node_list.append(node)
>> +        d.appendVar('SWU_ADDITIONAL_FILES', " " + script_file)
>> +        d.appendVar('SRC_URI', f" file://{script_file}")
>> +
>> +    swu_scripts_node = "scripts: (" + ','.join([n for n in script_node_list]) + ");"
>> +    d.appendVar('SWU_SCRIPTS_NODE', swu_scripts_node)
>> +}
>> +
>>   # convert between swupdate compressor name and imagetype extension
>>   def get_swu_compression_type(d):
>>       swu_ct = d.getVar('SWU_COMPRESSION_TYPE')
>> diff --git a/doc/README.swupdate.md b/doc/README.swupdate.md
>> index 1c94699..88faf23 100644
>> --- a/doc/README.swupdate.md
>> +++ b/doc/README.swupdate.md
>> @@ -21,6 +21,92 @@ window is still possible.
>>   If the variable `SWU_EBG_UPDATE` is set to `"1"` the update is also stored in
>>   the `*.swu` file.
>>   
>> +## SWUpdate scripts
>> +
>> +It is possible to add [scripts](https://sbabic.github.io/swupdate/sw-description.html?#scripts) to a swu file.
>> +
>> +To add a script entry in isar-cip-core set the variable `SWU_SCRIPTS`.
>> +The content of the variable has the following pattern:
>> +`script_name`
>> +
>> +For each `script_name` the following flags need to be set:
>> +
>> +```
>> +SWU_SCRIPT_script_name[file] = "<script_file_name>"
>> +SWU_SCRIPT_script_name[type] = "<script_type>"
>> +```
>> +
>> +The optional flag `data` can be used as an script argument:
>> +
>> +```
>> +SWU_SCRIPT_script_name[data] = "<script argument>"
>> +```
>> +
>> +The file referenced by `<script_file_name>` is added to the variables `SRC_URI`
>> +and `SWU_ADDITIONAL_FILES`. Therefore, it needs to be safed in a `FILESPATH`
>> +location.
>> +
>> +The mandatory element `script_type` can have the following values:
>> +- [lua](https://sbabic.github.io/swupdate/sw-description.html#lua)
>> +- [shellscript](https://sbabic.github.io/swupdate/sw-description.html#shellscript)
>> +- [preinstall](https://sbabic.github.io/swupdate/sw-description.html#preinstall)
>> +- [postinstall](https://sbabic.github.io/swupdate/sw-description.html#postinstall)
>> +
>> +### Example: postinstall.sh
>> +
>> +```
>> +SWU_SCRIPTS = "postinstall"
>> +SWU_SCRIPT_postinstall[file] = "postinstall.sh"
>> +SWU_SCRIPT_postinstall[type] = "postinstall"
>> +SWU_SCRIPT_postinstall[data] = "some_data"
>> +```
>> +
>> +This will add  `file://postinstall.sh` to the variable `SRC_URI` and
>> +`postinstall.sh` to `SWU_ADDTIONAL_FILES`. The sw-description will contain
>> +the following section:
>> +```
>> +    scripts: (
>> +        {
>> +          filename = "postinstall.sh";
>> +          type = "postinstall";
>> +          data = "some_data"
>> +          sha256 = "<sha256 of postinstall.sh>";
>> +        }):
>> +```
>> +### Example: Luascript
>> +The simplest lua script has the following content:
>> +```lua
>> +function preinst()
>> +	local message = "preinst called\n"
>> +	local success = true
>> +	return success, message
>> +end
>> +function postinst()
>> +	local message = "postinst called\n"
>> +	local success = true
>> +	return success, message
>> +end
>> +```
>> +and is added:
>> +
>> +```
>> +SWU_SCRIPTS = "luascript"
>> +SWU_SCRIPT_luascript[file] = "luascript.lua"
>> +SWU_SCRIPT_luascript[type] = "luascript"
>> +SWU_SCRIPT_luascript[data] = "some_data"
>> +```
>> +
>> +The sw-description will contain the following section:
>> +```
>> +    scripts: (
>> +        {
>> +          filename = "luascript.lua";
>> +          type = "lua";
>> +          data = "some_data"
>> +          sha256 = "<sha256 of luascript.lua>";
>> +        }):
>> +```
>> +
>>   # Building and testing the CIP Core image
>>   
>>   Set up `kas-container` as described in the [top-level README](../README.md).
>> diff --git a/recipes-core/images/swu/sw-description.tmpl b/recipes-core/images/swu/sw-description.tmpl
>> index c52372c..88cb475 100644
>> --- a/recipes-core/images/swu/sw-description.tmpl
>> +++ b/recipes-core/images/swu/sw-description.tmpl
>> @@ -35,4 +35,5 @@ software =
>>               };
>>               sha256 = "linux.efi-sha256";
>>       }${SWU_FILE_NODES});
>> +    ${SWU_SCRIPTS_NODE}
>>   }
> 
> Looks good now otherwise.
> 
> Jan
> 


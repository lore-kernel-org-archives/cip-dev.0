Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD14AC0032E
	for <webhook@archiver.kernel.org>; Wed, 25 Oct 2023 16:28:49 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.64])
 by mx.groups.io with SMTP id smtpd.web10.178108.1698251326758427851
 for <cip-dev@lists.cip-project.org>;
 Wed, 25 Oct 2023 09:28:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=G1uskjsl;
 spf=pass (domain: siemens.com, ip: 40.107.104.64, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJdKq6R3WNd7SWVyr0zZVw3zJB9F2ut/PKlO89vSBos1YTymgIF4p+ypVrAyqaG/CIBlq+FU9j9FexKL86wjw62knumqttFHMKHu87XklxXFB/lmFF7gmrwDrSiVOX8YCV/j7QGVoFeYoQbS9RN/ogzd5D+mp/b5nMsBpfRVchXtYaX9b1JoeKitIW0oCPQmJygtkuyYJ5Yngdhwegnp8ZZUF8LoBs98K8yXNO6icRWElObMQ+uQUCzvVN13EvxHxYeMeZnD74SxMcf9KF9cQUi7ViYZQiJHMQ9ZjqPDcRPCN2XKGPlbdkT1j3RfPZIx76ogNrIoY5dBr/Rd1tdhoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RVtQV9PgT1+hw89ALui1XfSx9PElKE62Gf8lgl8PlG4=;
 b=c2wlJfspfhwRBuKYOgcyGOvhauHoRVbMCmvlh2CQ6S4+HsbXivf0CQuc9QNZkNDmkCVsBVbbs4cG+7ObNYK54Rk2hol07PXxIw3oM2ZYbNe85GzKbWvL/k/LZ6Ksq42AaOz5SWXqu80UEdqr0ZxjJAyIWg/eCoBicNBx8gvjI9UV0niH4WF9AF0oLCamsBLiEMR2p7vMeZvmyiG95HGWaKzbHjZlgRwKxJEy1/NWaomclcWwDOvTJzSF/aDKVZi+kDgml/Sgw1VaZlC5av0KWKE7Mtw6N03cqwIa7fSRYmWt8xbldhko32T8C3bObUonBWEjciLAr5amHW5eyFJaYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RVtQV9PgT1+hw89ALui1XfSx9PElKE62Gf8lgl8PlG4=;
 b=G1uskjslMyajSgT7U93BngO71l9tNocwq3KH4mdI1yJ1JISLmNlc203Pgk1mp0+DH8NSEYkoywm77E0bXRLJIdSQfu7aTrki8gy3zyn/N7/OKzJqffhVcoXLe6JQeK4YQdqED31aW2VogF0MNxWDr08osxs1N9W03OfE9IOjAFGXMNvFqSJHfyuYJN+AQDkIH8Z5ch0ULKTsA5ZQ3xFX0eE/OLushHHkJJo4pIAAZmK22Ja4tA71YrKpFKyMYcEDnk9qeD1hInqj4w0MdUBtXSvSEaOfKynPoQSGROhKw+SN+lgbH3ASW5qUpMdAIXASgaaYuS0qjBeC58BGac30nQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB6566.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:55d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Wed, 25 Oct
 2023 16:28:44 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ce06:5d24:9896:669c]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ce06:5d24:9896:669c%6]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 16:28:43 +0000
Message-ID: <fd0a04b2-f8bb-4c70-84ae-0f1c3e8c5f0d@siemens.com>
Date: Wed, 25 Oct 2023 18:28:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][RFC 1/9] scripts/deploy-kernelci: Format
 python code and remove unused import
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, venkata.pyla@toshiba-tsip.com,
 dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20231023150243.3990309-1-Quirin.Gylstorff@siemens.com>
 <20231023150243.3990309-2-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20231023150243.3990309-2-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0197.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB6566:EE_
X-MS-Office365-Filtering-Correlation-Id: 718db14d-f184-402c-ae24-08dbd5777499
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	T8lBlSb3nEYHEngTYxPc9S0RsR4gtv2+y2/4GU1s3x2m//yUp1Yb+bpyhUUUqDcuQA31F2fhiZBFEC8Ofub1jF+MlciRQuBiU7haRqWDzeiLeTKKrLHTd6d8cYan9c+tmJXE/ojWh5n646A3Ma0vzIzR1uoA5jBkz/x1Oz9fv3sDJ4wa7l/vAw/beUeOSBFMP7SYocmPrsUrQGneI0ZQme4R/wrtwBwfa0NbGt8Di2SfKLUf/wHrtAUZJKhEzKzzFycC8W3L03fIJyu9G5ss31ZwE39NcjfZQO+LmazlWH0t6YwWRcoKEEdulikc1XJ5ix/jkM+R1GUt1xzTvdEsEKmp3vfMllsQJw6D+MdQFVHZK0L7iFh+GrmlZggGCkjLX3mydEqu437WLBsYU7kHZOcbOl3PJg5nZlTkdTLcc8NDrHJrN3cGWpyU9tA3ueXQ1DLeZoEzC3WtapMFsC01OJ5mnYYPw9o3Z/dG3uF0cLxRIvWy7DPz2xFB0xBdoEFGx/aES001wmijn2EqeZotmVbgO6Al+0gU0YXusFdOP81/2NfrkSRYbxbrIr0yMeBbn6cFskbJc2sYKyo1vGLVyV3bTAGb1WlYdpWoGsDb+Sh/w1LzGtyI8T90fCCwDcqcMBFEzvPsnfTWBQdu+n0hTg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(136003)(396003)(346002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(26005)(478600001)(6512007)(86362001)(6506007)(316002)(66476007)(66946007)(66556008)(36756003)(38100700002)(2616005)(6486002)(2906002)(8676002)(83380400001)(8936002)(44832011)(82960400001)(31686004)(5660300002)(41300700001)(53546011)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cHBXaE9LaHZjS25zdFBQZWdMOGFVUm1sZU9PMllFWXdQWDNkS3RwTXpnaXhv?=
 =?utf-8?B?YXZCeUlXZVNoVW1NQ2E0S2hjTm1HVnVDUkg3STVLbGFtV25JcFZQY3JRQ1l4?=
 =?utf-8?B?bDZKcXhXc3hsYXprL3EvTFU0ZjNaMGRxZks3OXA2ZGwzWHdTQ2pVN0pwTmJ0?=
 =?utf-8?B?MTNLWkRHWVBGUVJKckVHanNRTXhITUZmeFhqSUx1USs0eEpUWGxNdFVORm9U?=
 =?utf-8?B?bHNNemdtNnkxT1dKQzFSekRsQ3ZJbVpwME1sQ0M1WU1lRCtzQUVTS2RGcVBO?=
 =?utf-8?B?d2Z2VnpiZG1lWTI3TWhxdjJEVFlGbnQ1NTR6cFBpdVB0WGRkbUhUMXBmVlox?=
 =?utf-8?B?cGNyMkVEVE1EMzlPalFzRnRkL05hZUd3S2dwK1Q5dXhUcGRTQjJ3SUM0V1E3?=
 =?utf-8?B?VEtxMDAwQ2ZuQkRwbGkvRnIyaGtOOVV0c0dzUm1xaVYwVFZ5SW5ZN2d5OXR0?=
 =?utf-8?B?K0thVnNpNFJUV0ZyR0tTdEI4TTB4cVJDNXlQK0w1US8zSjdqbFZOcW8rNHNV?=
 =?utf-8?B?cWNvVW16K21SZkJPRVo5WXorVmNKSnBRS21MVTdIcjNJY3NVOElyc0s0cGNQ?=
 =?utf-8?B?Y1RRRTY2TTV1cmt4eFoySmM4Um1kQXIva3V5SEd4a2xsMzdKR1NKTHpTM09p?=
 =?utf-8?B?SkJOQ0JoNUI3N2FpeXVBbmJXeG8waXlaOXVaQldFNEFWU3VBZ0JQeXZNTUFX?=
 =?utf-8?B?RG9GaGovd2ppSkg0VmxOR2QwUVlwSGhIZmJEZnhhdzVkK2FDQkUvUS9XSUpL?=
 =?utf-8?B?Q21xejZ6ZXRJN05EUXFzYkFwZXZVQTh0UUhHenZRbjBMWlV1Ym12OWpKR0VO?=
 =?utf-8?B?Qi96SHNDcUQyZDc1dlkvbDRISnhxTCtjazlmSStTY3Vpalp2ZGdDOWFnZVNE?=
 =?utf-8?B?Nk9KR1RkTHBzR25PODgvcEk5SFhuTStmU1MrNDdwRFdRTE9TSEtiY2VSR0Mr?=
 =?utf-8?B?QXhEa2cvVTNsVisycHUyRjBscUpwSndmSkQyQTVRUU51d21wL3UrWE9vNllZ?=
 =?utf-8?B?OWNTODhoZ2xUckdBYWF3b2JEVDY0RFNQZHdzMU5GL2FmdThPaHpiSzNMN3Zm?=
 =?utf-8?B?bFFTTEF6QUdUY0hiazBrelBnMzVXWXlTRVByWGdMeTFGT0cxb24yNHJiTUlI?=
 =?utf-8?B?aWgyVlo2elN5ejJ0L1RIaG02ZCtRWGxvMnNCcjhxdUIzTUxmVDJ1ODM1dnpJ?=
 =?utf-8?B?aFZNc29FOUpRakNCUWg3bkt5Tlo2ZDMwQnhVRjg5cFd1UCs3NEQwOGtOTU9K?=
 =?utf-8?B?R1N3QUZIMGJzSjFrd1ZCTnVwSi8zSng4SGwxZzBBbktDbWVsYmt0RUFNWGN2?=
 =?utf-8?B?Z2tvQXBiYUp0KzlCdW9heHg5ZnBHZHVqb1JjYmF2ZkExQlZ4OGM3OW9nMEdK?=
 =?utf-8?B?TG1STGZlRVRoWlUrSnVnb3U1WmNPNjI1VkkxZGdPMElEajBLbE1sckF3SDVn?=
 =?utf-8?B?d2pVak5XRDVpaUFQQmhvNnhRR2UxQUtvMURPMTRuNlpqZkdyRXl5a3g2NlBp?=
 =?utf-8?B?djBzZ0IyOVNvakZ6V1ZtbXVTZDVvOEZmM1VVS3pZWjhRT0UzVmw1VlVyaUE2?=
 =?utf-8?B?Y3JxUnYrVWJCOWREallnY0IvZjhOWlFOek9LSUlFSmc1cWRWNU1TKzBaVlI4?=
 =?utf-8?B?WVRETGlGZ0NpaFQ5U29IRTRqTGtSeWNLRFZVV1JCTml0YTFsM1hRWlUvd21F?=
 =?utf-8?B?MWNWQWpXYnFKUzJ6ZW1KMkYxSmk2NnRDcElaN2dHbGVnd3BIOHExUzQ4TS85?=
 =?utf-8?B?RExrVEE4cEkzN0VmbVZ4UVNDRERiaHEvTFNxQVpwK3R4bGRaR2o1N1FnM29T?=
 =?utf-8?B?NjVnM1J3V2ZUNnJ3RHp4R3JLbWRlZEptUm05ckVUYWJyV0tLMzAyWWJlNTE1?=
 =?utf-8?B?dkxKc1RKTlRaK0d0aFArYklCV1BLdk5ITUFFODcySVpaUjNEcUVCL0kwTm1q?=
 =?utf-8?B?aFpJQ1A0bXF6TXhVZTV5MENvRWs2SnlIRmZKaVFOOXFHN09rTStPdnlBQWpU?=
 =?utf-8?B?YnBnZW5WVGhMK0hHRUlsay9JNkpqMTFVQUM0TmprL3pwSngvN2xPRnFhUDhJ?=
 =?utf-8?B?VWhGbUE2WTc2dUZaWVJ6ZVBLVVU3UmVpUnRLdlM2TnFrYStiRjZIcnp1cUZQ?=
 =?utf-8?Q?sME8z1cBkdoaJdL6pvpGojpEv?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 718db14d-f184-402c-ae24-08dbd5777499
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 16:28:43.9084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KHTJdCPO5dAaBnVWb0NDWm0ViCfI/T467LaVtRY5BtfJgdByFihQ5TeN9l2Fz1pSqJsPVjqW9qw8C6Zg7Z5JPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6566
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 25 Oct 2023 16:28:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13446

On 23.10.23 16:59, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 

Which style check did you use exactly?

> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  scripts/deploy-kernelci.py | 31 ++++++++++++++++---------------
>  1 file changed, 16 insertions(+), 15 deletions(-)
> 
> diff --git a/scripts/deploy-kernelci.py b/scripts/deploy-kernelci.py
> index 5a8adca..62f3f01 100755
> --- a/scripts/deploy-kernelci.py
> +++ b/scripts/deploy-kernelci.py
> @@ -1,30 +1,30 @@
>  #!/usr/bin/env python3
>  # -*- coding: utf-8 -*-
>  
> -import subprocess
>  import requests
>  import os
>  import sys
>  import time
>  from urllib.parse import urljoin
>  
> -cdate=time.strftime("%Y%m%d")
> -api="https://api.kernelci.org/upload"
> -token=os.getenv("KERNELCI_TOKEN")
> +cdate = time.strftime("%Y%m%d")
> +api = "https://api.kernelci.org/upload"
> +token = os.getenv("KERNELCI_TOKEN")
>  
> -release=sys.argv[1]
> -target=sys.argv[2]
> -extension=sys.argv[3]
> +release = sys.argv[1]
> +target = sys.argv[2]
> +extension = sys.argv[3]
>  
> -rootfs_filename="cip-core-image-kernelci-cip-core-"+release+"-"+target+".tar.gz"
> -initrd_filename="cip-core-image-kernelci-cip-core-"+release+"-"+target+"-initrd.img"
> -initrd_gz_filename="cip-core-image-kernelci-cip-core-"+release+"-"+target+"-initrd.img.gz"
> +rootfs_filename = "cip-core-image-kernelci-cip-core-"+release+"-"+target+".tar.gz"
> +initrd_filename = "cip-core-image-kernelci-cip-core-"+release+"-"+target+"-initrd.img"
> +initrd_gz_filename = "cip-core-image-kernelci-cip-core-"+release+"-"+target+"-initrd.img.gz"
> +
> +input_dir = "build/tmp/deploy/images/"+target
> +upload_path = "/images/rootfs/cip/"+cdate+"/"+target+"/"
> +upload_path_latest = "/images/rootfs/cip/latest/"+target+"/"
> +rootfs = input_dir+"/"+rootfs_filename
> +initrd = input_dir+"/"+initrd_filename
>  
> -input_dir="build/tmp/deploy/images/"+target
> -upload_path="/images/rootfs/cip/"+cdate+"/"+target+"/"
> -upload_path_latest="/images/rootfs/cip/latest/"+target+"/"
> -rootfs=input_dir+"/"+rootfs_filename
> -initrd=input_dir+"/"+initrd_filename
>  
>  def upload_file(api, token, path, input_file, input_filename):
>      headers = {
> @@ -40,6 +40,7 @@ def upload_file(api, token, path, input_file, input_filename):
>      resp = requests.post(url, headers=headers, data=data, files=files)
>      resp.raise_for_status()
>  
> +
>  if os.path.exists(rootfs) and os.path.exists(initrd):
>      print("uploading rootfs to KernelCI")
>      upload_file(api, token, upload_path, rootfs, rootfs_filename)

-- 
Siemens AG, Technology
Linux Expert Center



Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D40EC25B47
	for <webhook@archiver.kernel.org>; Fri, 27 Oct 2023 15:02:17 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.70])
 by mx.groups.io with SMTP id smtpd.web11.9124.1698418926498547037
 for <cip-dev@lists.cip-project.org>;
 Fri, 27 Oct 2023 08:02:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=vILKO8aI;
 spf=pass (domain: siemens.com, ip: 40.107.247.70, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HTlvYcQ0Gvyfa2a0JL5JrdEbO4jk5Ur5SR30tlVQ5Up+6HHpydBtL056N/Iw/ygwnuTzvXxtxb1L08pSfIMfSIfwPSNVt4EpZndwvZttHIBGK9E4oT/mX4Peu3E1NazREMvfqBCzuA41D+1OdByF7bt6e2qV+A90U1IiMCnUQUk9sKY3iqnY/xsKwC7UFWKPUzUr6zEj+QTFTli4rrMKkNQbc2GKONs1OvnZfdPZiiB7IqKpiKuZB4kL/kzNPYZOq7QKY3Bo2/WrD/NVcgveKHUpX+HLvr4kvGiFWlaOhJPv16cCg8rGBzl6ZU2bsGUx6BmjOd/8RmgUJx4KP8/+/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YDeWqo3PvK/kD3MEFQ6QE+/11c/RN+jiseVGNG8PHd4=;
 b=oPX7e2AkJw30gYuIWjX01cFrPmCraQWfnUCsgSZog59/xKNhnNUHLBQL7X5sPZedHjVdTkJj74/lH2IMv+vGbIffF1wIEbYRkcciBBO9qvO1nwJSqwrpHMtbysW9PWVWib/Gwyk9SW1nM16mqMKOUbWxTZ1+btDRbykgkb2fIs4IYyzHgGNGZmGs4fynBTyYRLHoE6Q0JOrMOmfE72p2eFUcLYmtAj+50N7+sPGnU8Vw3AN2PvjGnmP+1MkpgFE/+bMj+5EN3pW/TwrB9BlmYmri+jrAC1z33pHkFjZUdhwM6vlVB6HzibscxiEr2xQtb9X8xAdHYo2Llhs2lw+JIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YDeWqo3PvK/kD3MEFQ6QE+/11c/RN+jiseVGNG8PHd4=;
 b=vILKO8aIiMxb/+0npLWPYvLxii/M0avpM3wTyJDQS2Alj35AxArTQcx/XzMFG0dDY4kpeqKhde25m+rPL7vSTpi398aals8IZXkw+OTBrcSDP+GpWK7eLwAEed1NE2jCO63NF2aDbZkcr3lwXo1NuQfIHU3DKfXuFbct44CWe8Kjxoc5UmtWJ4cpqCKjWLxfvkYKVr0TrEznlcJJcbumkCyucUj/w32c+SWOHQO98xUOAIi3gytbFVtWUAIPN92ajxrRB6utrLRM2hFaq3TaBgcMTW+TIRGqWtL/b7RekCUesBUbAzqvPPx/mYmYBJUy6PDqc8tYGPleRU9R6O9qcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by DB9PR10MB6403.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3dc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.24; Fri, 27 Oct
 2023 15:02:03 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5d28:13c2:1583:fabc]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5d28:13c2:1583:fabc%6]) with mapi id 15.20.6933.019; Fri, 27 Oct 2023
 15:02:03 +0000
Message-ID: <77a2e3bf-d45a-472c-b62c-ee9bdc2e9d59@siemens.com>
Date: Fri, 27 Oct 2023 17:01:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][RFC 1/9] scripts/deploy-kernelci: Format
 python code and remove unused import
Content-Language: en-US, de-DE
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org,
 venkata.pyla@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
 kazuhiro3.hayashi@toshiba.co.jp
References: <20231023150243.3990309-1-Quirin.Gylstorff@siemens.com>
 <20231023150243.3990309-2-Quirin.Gylstorff@siemens.com>
 <fd0a04b2-f8bb-4c70-84ae-0f1c3e8c5f0d@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <fd0a04b2-f8bb-4c70-84ae-0f1c3e8c5f0d@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5PR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:610:1f1::28) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|DB9PR10MB6403:EE_
X-MS-Office365-Filtering-Correlation-Id: d2de2988-e0ce-478e-6674-08dbd6fdad9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	xX9/vK5+4y69bk4QE0H8UfyucjctyPRvDdS+Xs5/qJ4xiJ2rOk6oklcg6HPdk4KLHYFeqr1SpFPYBIcKwoICf/zkx67qH/xwt7XlYSCegKedFNod+gEqVGss3jrl5e/kcVUGnY7KkBLG8+2eN4XN0nfzjl+ojJ2hPzaEonq2fXEdJqqn9nOBtLlqfd1/2Z77P5Tz0LR5j3WcW5jxDhb/Xhl0qQW1gswKKxIGiYJoecZ9ypelrfH6s4ijJfCuf0gcMMV11sq7JKZj6xaNVVhOajiMiB+gD/3YhZpEoskNrdSpW6gbyfWM2/H0jHGGVnN2Xy75gmpl2cwJ21FsHTAv8RFVMp0X0RSudGyq2sFFN1hk1ghuxi6Fwgwf5Y6fGMEum07zn2AzvCYzyGITNu7u69MZC4Tay0w/+9CT43ggFKVyvQyZBeYb9/LYvtkEzrp0E+86IhG/m5NKJ6of2Yw8F3ViJBkAtXzjSCmVzRuGmwApmfnLCUvfq+d2hWo5vsIqHWS4ox4cvNLXQgHfLu/8H9iQZ+A1v70NiTde6O4ujxTKT31uZjqfSL2iVlEAVlL6DfjoKgZ7fDiEsmmjM5nqOHgKANHn0jj5cg+6cA1nAxRPq9peUNAGa5UmhxM2C6grhE5FT6wxxSpUzTazchhGpg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(39860400002)(136003)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(31686004)(38100700002)(86362001)(31696002)(36756003)(8936002)(8676002)(82960400001)(478600001)(6486002)(83380400001)(2616005)(6506007)(53546011)(6666004)(6512007)(66476007)(66946007)(66556008)(316002)(26005)(41300700001)(2906002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?V0MrYXJVUFNNN0hucFpDYVpPQVVJVUlVOUUvbzlhRER6Tzk2ZHJ6Unh4VEto?=
 =?utf-8?B?KzdKeDZqV2UwZzJ0MkRUVjZSb0lCeHVnRzVKSTRPNkhkbFpoOGd6OVRPQWhD?=
 =?utf-8?B?Zk05SVM0ejBrSC9iamh3MkNLZTJ6SGRmV1lNcXhaQzA3Q1BWM1dOdHRjSko1?=
 =?utf-8?B?azhkZVlTY1B3WkV0S0JGUzgvNmh0cWovUWlBTkl0Zm11eW9BZU5jNUJ2cHQz?=
 =?utf-8?B?RkcycDdJL0tCM2VrWll6aUltSzNiLzZrUjRjZkxwVW9HaUlNYzRNRDJHVTd0?=
 =?utf-8?B?NmRyT0o0cE40OWtwQUsvNHNzcXJpbHBsYmpBWEVzR2RzMW9kQ09EclNOOFV5?=
 =?utf-8?B?MmhHakprYTFYZmhQZGdoVG9lUDJUaTU0ME5oZHlzK0l0N0NJYkpwYUZ0aEE1?=
 =?utf-8?B?OG9FQ1VJVVllVzdvVVl6NW1xSGZidEdFeld0OEVZL2IvUnV0NVF1R1RCWlRs?=
 =?utf-8?B?RDkwWkxaMml3MWk5UlBsb0RjTmdrS1hOK0VsRjNSSjBJUTRzM3EyNGFablV2?=
 =?utf-8?B?QlZyZ3h4cHVWTDQzVHFOcmxjU3c4aGZXNmdKRGh3Y2pWSTVVUmlGYXJoVTFJ?=
 =?utf-8?B?Q3hkZWhlYXJ5cG5uWTd6QVcrOVQ2TktIR09pNDlQS3BLbGFwZXM1YVZscDF4?=
 =?utf-8?B?eW9Da3hJcXRtRllSOGphS0FIOGxtbVpTV1hpcUY1UFlKV21LVjQ1ZWF4Ykp3?=
 =?utf-8?B?a0xxTFlXMGRRMEtnNzMxTE9meU9ad1lQVGdVYTczR0FXMEFsUm5Hd3QweS9S?=
 =?utf-8?B?RDBFdldQOEhpUzFDMGxlZ3F6bTBoQVJKeEltWE4xdlhmR05HYWFsTjgvNkdH?=
 =?utf-8?B?blhlajNLSVVrazgzSEN6a1NVZ3RuSTdXdVdhSlJaRG5wc2x6R3V5Zy9CZTB5?=
 =?utf-8?B?Q2pJWENqYmlOTC9NTERaZlZkbWdESkcwR1hCczlzUExMaVZzQXRqM2lubXNm?=
 =?utf-8?B?aDU2RnNOWmxNYVBlczFxQk5ObmZKYUQ0ZXc2MFlsMG9sbzV3eTdPallZVG5m?=
 =?utf-8?B?TlROallEbUFzM00xenp4bjFFYlBOdHhOS0VjNTlmWlNuTHI1K1p4L215d0J2?=
 =?utf-8?B?Q0J3VzZWUHd0bFJKWDlNZkRSck0rNGluaVdTSkhWVW5ZamVuMFY3SHlTdUI4?=
 =?utf-8?B?aGFqSmJSVnVoYzdlVUxjMVJHMm5mMGVvZHN2dDB4ekgrSE91MjRRelRPcTl2?=
 =?utf-8?B?bG9kVm5Fc29SVHgvb21WeS9SN3EreXFwZ0k0TTBzNnNRRDRWYU1nSk4vSVhx?=
 =?utf-8?B?TCtycWlHdHZ1Z1pJVVBBS2lDZFlBOWxUVHQrdnlybFNVSE5PUks0Z0RyWCt0?=
 =?utf-8?B?WGU0cHVYdVB6QWxmOTkzNFYxZGtHdnVUSzByWVdpT05idWZiblVOdk5oQTNQ?=
 =?utf-8?B?bHhMaG9LR3dYZ0FYSU1DZWxNVEc5SjJ6MG02ZWQvWUZWaGNQYTV4VHNuZ1Ix?=
 =?utf-8?B?UU9uSUFzRWhQOEE2VjhuaHZEL1hQYmVvaEZna2t0aDJ5YTZzNlI1YUJxLzVx?=
 =?utf-8?B?SkNRSHR5RDg4MUM2aFcyUFphNi8xTjJBajFiNWhYMFJkdmRSZDJRUjJKTFZt?=
 =?utf-8?B?bktFaG9rR200dlY4SlRmRFhQZ3I0YlZPdWxYYngyUExyRzdMRmo4aWZ1WGk5?=
 =?utf-8?B?U3lTWEpUaVIya3VqWlc3OWd2UmkrU3BERTVLNlhTVkpQcmtESmxMUlNkalZo?=
 =?utf-8?B?UGNCVUREUDFjekZucms5Rkxib0JQbnFMaCtjSWswZGpTdGlXUk5SU2MvbU1s?=
 =?utf-8?B?eVphQnNmQTBCUDd5MXc4dXFJYXYvZTVkN3V1b1BnNGlMNDNDM1VSTjZzeFlT?=
 =?utf-8?B?TlVaQmJwNFM4ZC9Jd0R2S0duUWhHbmJNMVRnWnZNaEY2L2dIWWpoMkpLZE9H?=
 =?utf-8?B?NlJRWWVZcWpDVWhjL0t4RVlaaTFPc2lZM2FuZXFPRnRPSE13U056TjVMSGZ0?=
 =?utf-8?B?K29BMGNvTlZQd05wS0tWVS9uTmdpYUZCZWNNRC92WTVGZmR1ckhsUEtIV09O?=
 =?utf-8?B?aUV0MStJWGVXeTVUMXdkRlFYYVBKQy9ONlJoUXRVeFdYcXo1dzJwYlhsemsx?=
 =?utf-8?B?K1FtSEc0ME93eDRZUVNiTmo0TTBJNHQ1SDJoUTdxS1hlQkNCWkU5dWI3SWtN?=
 =?utf-8?B?eE9BaTFZN3pzc21sazFFbTJ6TVNEY053bXBlVmwzN2ZNVzdNcVpqc3RYMnRQ?=
 =?utf-8?B?RHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2de2988-e0ce-478e-6674-08dbd6fdad9b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 15:02:03.1870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sKa4gUIxWYCHNmnxaGook4NbIw6lnBMpcUxl+ZKPGMsw6LXDMpCP0RIACXtUMOWKL3+xuQfL7MsgebSK3pfTFVtR/h6l2Ss8i6aKrKTaNjc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6403
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 27 Oct 2023 15:02:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13483



On 10/25/23 18:28, Jan Kiszka wrote:
> On 23.10.23 16:59, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
> 
> Which style check did you use exactly?
> I used flake8 for this.
black rewrites much more.

Quirin

>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   scripts/deploy-kernelci.py | 31 ++++++++++++++++---------------
>>   1 file changed, 16 insertions(+), 15 deletions(-)
>>
>> diff --git a/scripts/deploy-kernelci.py b/scripts/deploy-kernelci.py
>> index 5a8adca..62f3f01 100755
>> --- a/scripts/deploy-kernelci.py
>> +++ b/scripts/deploy-kernelci.py
>> @@ -1,30 +1,30 @@
>>   #!/usr/bin/env python3
>>   # -*- coding: utf-8 -*-
>>   
>> -import subprocess
>>   import requests
>>   import os
>>   import sys
>>   import time
>>   from urllib.parse import urljoin
>>   
>> -cdate=time.strftime("%Y%m%d")
>> -api="https://api.kernelci.org/upload"
>> -token=os.getenv("KERNELCI_TOKEN")
>> +cdate = time.strftime("%Y%m%d")
>> +api = "https://api.kernelci.org/upload"
>> +token = os.getenv("KERNELCI_TOKEN")
>>   
>> -release=sys.argv[1]
>> -target=sys.argv[2]
>> -extension=sys.argv[3]
>> +release = sys.argv[1]
>> +target = sys.argv[2]
>> +extension = sys.argv[3]
>>   
>> -rootfs_filename="cip-core-image-kernelci-cip-core-"+release+"-"+target+".tar.gz"
>> -initrd_filename="cip-core-image-kernelci-cip-core-"+release+"-"+target+"-initrd.img"
>> -initrd_gz_filename="cip-core-image-kernelci-cip-core-"+release+"-"+target+"-initrd.img.gz"
>> +rootfs_filename = "cip-core-image-kernelci-cip-core-"+release+"-"+target+".tar.gz"
>> +initrd_filename = "cip-core-image-kernelci-cip-core-"+release+"-"+target+"-initrd.img"
>> +initrd_gz_filename = "cip-core-image-kernelci-cip-core-"+release+"-"+target+"-initrd.img.gz"
>> +
>> +input_dir = "build/tmp/deploy/images/"+target
>> +upload_path = "/images/rootfs/cip/"+cdate+"/"+target+"/"
>> +upload_path_latest = "/images/rootfs/cip/latest/"+target+"/"
>> +rootfs = input_dir+"/"+rootfs_filename
>> +initrd = input_dir+"/"+initrd_filename
>>   
>> -input_dir="build/tmp/deploy/images/"+target
>> -upload_path="/images/rootfs/cip/"+cdate+"/"+target+"/"
>> -upload_path_latest="/images/rootfs/cip/latest/"+target+"/"
>> -rootfs=input_dir+"/"+rootfs_filename
>> -initrd=input_dir+"/"+initrd_filename
>>   
>>   def upload_file(api, token, path, input_file, input_filename):
>>       headers = {
>> @@ -40,6 +40,7 @@ def upload_file(api, token, path, input_file, input_filename):
>>       resp = requests.post(url, headers=headers, data=data, files=files)
>>       resp.raise_for_status()
>>   
>> +
>>   if os.path.exists(rootfs) and os.path.exists(initrd):
>>       print("uploading rootfs to KernelCI")
>>       upload_file(api, token, upload_path, rootfs, rootfs_filename)
> 


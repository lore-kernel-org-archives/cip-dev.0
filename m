Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED068EE3F06
	for <webhook@archiver.kernel.org>; Fri, 15 Sep 2023 06:10:39 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.62])
 by mx.groups.io with SMTP id smtpd.web10.15056.1694758232976960769
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 Sep 2023 23:10:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=FyKA0vnQ;
 spf=pass (domain: siemens.com, ip: 40.107.249.62, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NbVPbZuyZeaSqB1vcNO8nYzD+sZtnFCdXQefX4qKVDxwH8uJeDG9g4lvPHwc3pPN4QMixxbXI5fkxe0vFrwh6RQh4IkrX2o02vlDmhBFpcLbhj7G/NwmNyipA5x+gNul67KNLEGwsbNWaWLTBFY8pcrGLFtTRLaXdEDaNRylSERHAMEWoHL4OMQakjGPNexEhcS0g6YLOUx8YkIa60D4nsijgh96c/ZzC9W+0q7C4eJVpXWQBw8iwWYzjr+DqST72RTa9WuA3+zX7MIMWFGhmCM7EVA0n+1+gj49b4kPLek6ONynsP/hx8MI3rFzCwIVXj2RzIOyj3NKTvyMDidLDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ox12y+3a6szTio1YMNwWhcQbIVTihCCap3cSlFny/u4=;
 b=bsy4/qsSbJR6J3vbDmXrGPAkKl+rbmJqvS2Rts0BWv4oDNfsnNJUbUh4IIbJMOOVXIlMbURBhRPHcc97YpC10OdODom3zuf5RH2ZJ8DaPOqdYIFX5mXgLicD/01Ak76EQJjg2frRyn2zWUqW04SQRiWsBYKKukdKYjjuSaEI6MZ4Szakb/N+cAtsAYVMiI+RTLMLxNeidxPieq2JYgL2gVGIlpiNMLdKZEtOUipQr8YcsEW7bQ5FldeISkOKy5DqPDqpFd2SjcFGMl11K7jmlbxv4u2m9i1mrNafclfLrrmZM8xV8vQbdS0Drrw/TY3E72oJT6EBjn7wI8OPVGY2hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ox12y+3a6szTio1YMNwWhcQbIVTihCCap3cSlFny/u4=;
 b=FyKA0vnQAMzJ/3mMlckuMPBNoN5AxwKK5NHxM+kFXKZM0yoIJBursIX4vTjPRkPe2k5jBv4o15oOHx0vh5yryNz1dghj/EP6A1hWAllTYL/WJlwvvFlSRY5ApMTQkBXGTlVhIt7be+TjYYbYvv6umwAYMB/QrSzbUjMHw4kXG7HJjdmD1f6mr+zW2Oj5m/iMSIw9GgLWM5rTyqVdg8OYKruetlV3LgLoN07GcOvydxSTVVSiNIybqNdpKFJRU+7x2SdvZ0n7bIeQOfJKLlGdCYGn0sMcaAgB1zQePkEXmBT/lJENGT5L7kDjNKoDFTSXsqbDLt86ldt1ZCvsPXlH3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6979.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:417::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Fri, 15 Sep
 2023 06:10:30 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 06:10:30 +0000
Message-ID: <7fce798e-8ac1-40f4-83c6-4fc4ccb9b304@siemens.com>
Date: Fri, 15 Sep 2023 11:40:19 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][RFC 1/1] classes/verity: Set salt and
 uuid for reproducible builds
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, felix.moessbauer@siemens.com,
 adriaan.schmidt@siemens.com
References: <20230914185102.1451907-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230914185102.1451907-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0045.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6979:EE_
X-MS-Office365-Filtering-Correlation-Id: 40882c45-dee6-4a29-67b7-08dbb5b2768d
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	FcJRSeN2bchIflTMHf7fHSTPo1lh/KJs/ju77oO6q+zL1v3Dj2BEnEvLHjA5FBEtqs/FIPsj4DhsUHLBKn+LTfEZQIwD2GLec0BrSxkbVPlKRvBwVE4Kloo0xlR9vJlVjnv7BGFw6fHkSMC+JsBrRqAl0NLJDLB6TwM3YP+D8oQBZMBZuZdhdTw6IOkk3bHcPHyawVT4NgnYDa3kitF+/HCz3kwwwnJkKPS9gH/3CA4iiUgAsLs2L5CwQHrEeTeDoSDALVAP5lQApDK+RUdngu+Q4wEqTH3UIaqJyFpu4PdSwN9h4o5Sm77ylSG2gkr2pA55k2AbwlCyz+BZeqlYktyiJE2p6zqzabTyEPtngD5oCxJAlEDPZy9xHGeUR6359YANWbhABaT32OvgkSsKoMHa47jcjhptIo//AEpFk947WETLZJStjog2uh3443sL1+QD+P2s8WMNVAZCcqugJLut9WIOAdGR1rYfoxfA2Mu8R98JbCVQMEMuUQvWaHf7jCZU7TnuZqXlqxAw1ilfF/3yLS5u7JAWC3yTSWj6wyCfE2OtgejIzKmj6eDqRyE+dyu0CPE/NEI2Hi1FtrQBa2ot57olXaAasziLn0v+HkrIXofNce9L66IR8gmaiA+n3v3eKfOhue3dQphvW9VP4CWuZ4Awsp9fAOK/gFPj9Jo=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(366004)(136003)(396003)(186009)(451199024)(1800799009)(6486002)(6506007)(53546011)(6666004)(966005)(6512007)(478600001)(31696002)(83380400001)(26005)(2616005)(2906002)(44832011)(66476007)(66556008)(66946007)(316002)(6636002)(5660300002)(41300700001)(8676002)(8936002)(36756003)(38100700002)(82960400001)(86362001)(31686004)(403724002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VVRyWFpoRjF4K2JZVmVFc0RXNlY4UEUrQTdoNEVEb0hMNkdRSHJRcG1Id1BZ?=
 =?utf-8?B?M2NTNEF2cjU2aytGcXgveXVhTndwaFhiWGhCT3NYNnpyRXpvdSthdjRyQTRy?=
 =?utf-8?B?NG90Tm50SEZmNTlkYk1ORC9TeEhpRkJ1d2lyRDRwMEgyNHRiR3pLZVF2SEJh?=
 =?utf-8?B?cXhiMDdHT3htczYzeGhqQW82T3l3TDMyRWxKUzltQ1E5ZXNVc2xKTmhzRllo?=
 =?utf-8?B?U3p4OTdZNjRjeWkwS3lobWx4Uy9icjFYbFZMcVRjWlJvK2JNQmMwdVRtTUNm?=
 =?utf-8?B?SHRVd2ZKZTA1V1ZpWHJ0WURCQ0hxdUJQSGlMZjFobjAyY1VzSGtqWmJYMVB2?=
 =?utf-8?B?Z3p0NURlZE93cVNTdFBqNm9qRGl0aEtFek92TTI5T0U5bXJReGtvdnJUdUFG?=
 =?utf-8?B?RXZGalluck9yQk04VHpabXZqVko3dUM0UjlUZ0VSTlR2U2xhL2dGQkFBWHZB?=
 =?utf-8?B?MERqYlU4aXZTMXgyeDRjMFlodkV2aGFodnlBRWQ2bTdmVjRrVUJka2JFV2Js?=
 =?utf-8?B?VmwvUGlwTUJHeENkMnp0ZUxOTWs2Z05RYTVUcFNkVzA4MFV5eXJIMXZteFd1?=
 =?utf-8?B?WEREV0FMYUo5QnhuYkJHbXFDZTJMQjhIWUJ5dVdpNE1lclM3djRVTSt6RUls?=
 =?utf-8?B?a094VGJ3UjAwdWhwQnN0YjM1OUNKS1Z3SXRGdU8zSzVDWGJUcUkxS1ZUOUJp?=
 =?utf-8?B?MTFmdlJMUFB6b2NycmtWaXFtNk9qQVQ3aDFnd05QSEVJUGgyejJYZk93Ukth?=
 =?utf-8?B?V2ppVGM5SE91d21DRXRIOU81SGtKRTNJNUNzcE1Tc1pDMDNvbVJURngwRFdE?=
 =?utf-8?B?NmpwbGpRaHhqTGdtU1RBUE1IdHc3S0NVTm1mSEdqcFRMNFdsY0Flcm1GTFJw?=
 =?utf-8?B?TE9WbDRDUldEWllMT2s5WXRIa1lPeGUwM1E1S2R0K2o1U094UHhyL0FyNVVK?=
 =?utf-8?B?bUVkbWhYSU9jU3BCNTRheWFqS3hxa1VnWlJUTjVaSTVlSGFTMWp1MnJVSmVm?=
 =?utf-8?B?QzZwNENIc1FFQndwaXpHNnRmelhBdmROb1poZG41cCthUnc0cjNhZVowaU5R?=
 =?utf-8?B?b1lxT3J0WVFYTGlpenVHek1VZXlSYWcxWnRFNzlLQ3NiVmIwSjRzOGRZUXk3?=
 =?utf-8?B?QlRjb0lRdFZoTjE1MHZMc2Y5SytlaGdPbk1DSnNKM2JIb2VNL2V1eGlnVits?=
 =?utf-8?B?eVhkbHYxRDBsSXZ1bmw4VmtUTkhqeTBEMUdkSlo5ZHd4eXN3aE5MVFRlN1M4?=
 =?utf-8?B?c0FIOVhDeVl2d2lEZFhrVk9Ob09MRk15ak44MlhyNFVLSkVwY3pQdXZScWd5?=
 =?utf-8?B?cDRmVkd4SnZuMG1EOEFFUG9iK3g3L1lHTmtlaG1XdUppK1A1NHVrMmptSVFv?=
 =?utf-8?B?TmI2bGRKd3diMkQxczNaNlpFUXlzQk9GbklqSWM3RXJSbFJlTWRKV29YalZl?=
 =?utf-8?B?d2p3VEpGdXpFd3pxdVg5RnF3Z0dteVJrZ2pMaUQwUVhrT3hyREpUSDJHdFJV?=
 =?utf-8?B?WDZoa0hoL1R1M3dVWHVNUkhJMlN5R2hTVjF0WEdpNk1hak9GdkJzUHlzQTkr?=
 =?utf-8?B?OEJYZ2FBd0pUN0xRVnJ3K3BVMzlmRDZwRTluWjN1WndTRXp2N1MwemVhMzJY?=
 =?utf-8?B?bUxQWTQ2ZVE2VE5PZEppbGdVOXdCWUVWRFFuOHN6bEY4bU5HMWt4RFFDU01J?=
 =?utf-8?B?QVh1Q0ZQQjFRa2hzcFdJazhzM2p3eTJOT05zT1pHbkQ5M1NuQUtLM2d5K0Vs?=
 =?utf-8?B?MjVuMEJuOXlSNDcreUhoc1lzWlo4NkRFVFZpTm5ocWk3dmlVQjRoZmlHekxh?=
 =?utf-8?B?YkJQdUo3b2I1TGNIako0UG5ndVpBK0tZMU1zdG16cEg2UW4zM2pLMEQwS1FR?=
 =?utf-8?B?M3pIYkZBaTB4OE0zcG04cml6WUlLOXFHY01ROTdybVQxbzg1NXNNSGlvdUlY?=
 =?utf-8?B?Q0JaNWJGYkFOMG1vNDhXdElKcjZ5M0R5eXdaTHF1TU1IcTJCa1hlT05zd2hk?=
 =?utf-8?B?YjQwTGsrb2xUU1VKa045YmhYWnNkc2cwN0lQNldiRzdZZk1CYmw1ZEJzd0Qw?=
 =?utf-8?B?UXdscldsY0ZSTjlkVWV4SWg5UHJ6MnQxVE5WaFdiNCs2WHpZbEpCTWFUY1pa?=
 =?utf-8?B?TEIyZFJwZUVIRnV1Y1p4cjlzOHVUNmlkb05wdStFZGd0aFpLd21oLzRDMTZo?=
 =?utf-8?B?S1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40882c45-dee6-4a29-67b7-08dbb5b2768d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 06:10:30.1907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pYJ1akORvr/ObxSiYfUKeVxeJH1lgwpkNtd79tji/bOkr+3bjbEs1uYosw4VhAfFhZaPjDHvwPqrr17na7XP3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6979
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 15 Sep 2023 06:10:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13135

On 15.09.23 00:21, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Currently veritysetup generates a random salt and uuid for the
> verity file system. This leads to a changed root hash which makes
> the verity image no longer reproducible and bootable.
> 
> This also fixes together with the option `kas/opt/reproducible.yml`
> the issue that after a sstate build the image can no longer be
> booted.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
> Can we set the option in `kas/opt/reproducible.yml` as default or are
> there still issues open?
> 
> This patch superseeds `[cip-dev][isar-cip-core][PATCH] initramfs-verity-hook:
> Ensure sync on rebuild`[1].
> 
> [1]: https://lore.kernel.org/all/595d5791-a08d-f08f-5dee-6f9ed5d472e0@siemens.com/T/
> 
> 
> 
>  classes/verity.bbclass | 34 +++++++++++++++++++++++++++++++++-
>  1 file changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/classes/verity.bbclass b/classes/verity.bbclass
> index 747a7ae..2cfeb28 100644
> --- a/classes/verity.bbclass
> +++ b/classes/verity.bbclass
> @@ -18,6 +18,34 @@ VERITY_OUTPUT_IMAGE ?= "${IMAGE_FULLNAME}.verity"
>  VERITY_IMAGE_METADATA = "${VERITY_OUTPUT_IMAGE}.metadata"
>  VERITY_HASH_BLOCK_SIZE ?= "1024"
>  VERITY_DATA_BLOCK_SIZE ?= "1024"
> +VERITY_IMAGE_SALT ?= ""
> +VERITY_IMAGE_UUID ?= ""
> +VERITY_IMAGE_SEED ?= ""

So, how do I use these three variables now?

> +# TODO split if working

What does this mean?

> +python derive_verity_salt_and_uuid() {
> +    import hashlib
> +    seed = d.getVar("VERITY_IMAGE_SEED")
> +    verity_salt = d.getVar("VERITY_IMAGE_SALT")
> +    verity_uuid = d.getVar("VERITY_IMAGE_UUID")
> +    target_uuid = d.getVar("TARGET_IMAGE_UUID")
> +
> +    if not verity_salt:
> +        if seed:
> +            verity_salt = hashlib.sha256(seed.encode()).hexdigest()
> +        elif target_uuid:
> +            verity_salt = hashlib.sha256(target_uuid.encode()).hexdigest()
> +        else:
> +            bb.error("TARGET_IMAGE_UUID and VERITY_IMAGE_SEED are empty. Could not derive verity_salt.")
> +
> +    if not verity_uuid:
> +        if target_uuid:
> +            verity_uuid = target_uuid
> +        else:
> +            bb.error("TARGET_IMAGE_UUID and VERITY_IMAGE_UUID are empty. Could not set VERITY_UUID.")
> +
> +    d.setVar("VERITY_IMAGE_SALT_OPTION", "--salt=" + str(verity_salt))
> +    d.setVar("VERITY_IMAGE_UUID_OPTION", "--uuid=" + str(verity_uuid))
> +}
>  
>  create_verity_env_file() {
>  
> @@ -49,8 +77,9 @@ python calculate_verity_data_blocks() {
>      d.setVar("VERITY_DATA_BLOCKS", str(size // data_block_size))
>  }
>  
> +do_image_verity[vardeps] += "VERITY_IMAGE_UUID VERITY_IMAGE_SALT"

Why is VERITY_IMAGE_SEED not part of this list? Likely relates to my
question above.

>  do_image_verity[cleandirs] = "${WORKDIR}/verity"
> -do_image_verity[prefuncs] = "calculate_verity_data_blocks"
> +do_image_verity[prefuncs] = "calculate_verity_data_blocks derive_verity_salt_and_uuid"
>  IMAGE_CMD:verity() {
>      rm -f ${DEPLOY_DIR_IMAGE}/${VERITY_OUTPUT_IMAGE}
>      rm -f ${WORKDIR}/${VERITY_IMAGE_METADATA}
> @@ -62,6 +91,8 @@ IMAGE_CMD:verity() {
>          --data-block-size "${VERITY_DATA_BLOCK_SIZE}"  \
>          --data-blocks "${VERITY_DATA_BLOCKS}" \
>          --hash-offset "${VERITY_INPUT_IMAGE_SIZE}" \
> +        "${VERITY_IMAGE_SALT_OPTION}" \
> +        "${VERITY_IMAGE_UUID_OPTION}" \
>          "${PP_DEPLOY}/${VERITY_OUTPUT_IMAGE}" \
>          "${PP_DEPLOY}/${VERITY_OUTPUT_IMAGE}" \
>          >"${WORKDIR}/${VERITY_IMAGE_METADATA}"
> @@ -70,3 +101,4 @@ IMAGE_CMD:verity() {
>          >>"${WORKDIR}/${VERITY_IMAGE_METADATA}"
>      create_verity_env_file
>  }
> +addtask do_image_verity after do_generate_image_uuid

Jan

-- 
Siemens AG, Technology
Linux Expert Center



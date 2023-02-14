Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4898C05027
	for <webhook@archiver.kernel.org>; Tue, 14 Feb 2023 07:19:02 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.62])
 by mx.groups.io with SMTP id smtpd.web10.1421.1676359132674108595
 for <cip-dev@lists.cip-project.org>;
 Mon, 13 Feb 2023 23:18:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Fxll+qqp;
 spf=pass (domain: siemens.com, ip: 40.107.21.62, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=byJfgt311d6e9b2JcCAJfS0yDh5ucfjW0nBtRB1yoU5vzdJMy83IE+R1xQq/ZUkDpZJMRCyF1FUkBnuwvqNuxuElHuP7Mh5xPKmdZpAuB4Zdz/NCcYDP43baW1VjDu4Tav/qfHh321BwBiAVZbJg/0WbTR/9YYn++nIhCx+QKplaH/HNC34iRhKEGah/MCJuadRANSAmE6ODvx22cgMXtUaHp6/2M1GJeYEvI15Uj9xGeain98MjpldIZPTmSlmfAUs/8/NGy9CBiwMuDnNUmE4SvlpED2/BIYEjP1Z4tQmoBdA6yFpMH1k+MTWGxnfkXsXet3mqdQWCSEHJ53doDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ayLR38Alu4Xnt3iWKCpi0d+JzHgSYSA9lWJKx+j3+w=;
 b=ZTCJUGPjBYrUEn2W5YThQVKwat7qb4UAR3k4dpmouzZlr4MwO2tlJM+WcaG6gaRzKwF9cS0X7YDTrkJK6pTVLFIIHZP1ZSw8hSdPuJ7Bgo58Wrs79vuKRqydOeq7s15LHtRMWUqz8lBAtS2+0RyhGLNQpH+dlbtuowGBiUBwL3ro/V9ZqH88eV4EUrHc531XvXcWbyWWF9uYnRempibA3FuBtvCKnjn2R/pixNMPngLbDRU7/+0eRJpPeTWf5t9h1lkjsXBod3TZUkJDMvxFTu9wJLw4sDrXjD7wD8CI5RVUE/3uRBhUFullb0Fld/4fJyVTl6sjlOGtoElzWf9bFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ayLR38Alu4Xnt3iWKCpi0d+JzHgSYSA9lWJKx+j3+w=;
 b=Fxll+qqpWDtBF7/fLu059gP4TeGU+QfqKdOf5JFtUduLpcbOxVDDQIlv50kSG3HSqUkUM0Fy/pmB/RUbWyi9KRV2nmfFzLVtvSlYPNZO71XHJGH65srxCxw5ldPZ7O6ANes6tWG1z1GtmoI/7j9ugupjxMgvbo4cBywBpO9ffsIK2xxsxqXAOP2qILn3ybW0qs0tsw/3KVlN5yuBId/2bxGTAc/+MLcVrt3Snip5nEMeQ9vhfkotGOVLckXq3SQ+Xs8QMSgfadAtntYw85L5ouEkpeVrNK7lKypcxmoG+a2zMeCNV0ur6UpV4bvJiVcuJ9h3dwcsgezl7OmR3ljFiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3228.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:112::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 14 Feb
 2023 07:18:49 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%9]) with mapi id 15.20.6086.024; Tue, 14 Feb 2023
 07:18:48 +0000
Message-ID: <49e13754-7e50-7bd3-e2a0-c19f6bf31bfc@siemens.com>
Date: Tue, 14 Feb 2023 08:18:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [isar-cip-core][PATCH v4 2/8] refactor: use imagetypes for swu
 generation
Content-Language: en-US
To: "Moessbauer, Felix (T CED INW-CN)" <felix.moessbauer@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Cc: "Schmidt, Adriaan (T CED SES-DE)" <adriaan.schmidt@siemens.com>,
 "Gylstorff, Quirin (T CED SES-DE)" <quirin.gylstorff@siemens.com>
References: <20230212082758.1166262-1-felix.moessbauer@siemens.com>
 <20230212082758.1166262-3-felix.moessbauer@siemens.com>
 <3dbb9c71-f5bf-56e4-6f9c-66e6d42f9049@siemens.com>
 <e06cb90bf0652ea1035149cbf8d30c7dcbaba314.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <e06cb90bf0652ea1035149cbf8d30c7dcbaba314.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0092.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3228:EE_
X-MS-Office365-Filtering-Correlation-Id: fee3d9b6-474c-47c8-8770-08db0e5bb78c
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	utKaIfsKR5rqk7U0z4N9OZPbio+ngC8wzQSCt7ux5j+Rno0GqYcGQ8l1L47zkWzFyheKu6FGAw4EUpI6htQdCzv8hU8/EzW9YrrO6q/6mEvIf3rmWSpRnfnS67v27LMv/KSWz/ExokhciB7NluSMjcdtrdl/tPaYbN+CDe+mLVNbiJnHom8QW2WvfKTR1cV2Uh0isckRDWkbuh/vkM9xmFiwLl9NhqBAvLrPRGPfx/EpVurEdnJzutyTNKq8U0WTuDu2DBAuz5Mzw4k7HyoIZLtnIx/9ZAEejAeeIBMu+G6GJdzDgGsB0oow9o4MnOZHd4OA77nlef2XptTGux0KCUMKHowRtn8BnrbhB/nGdWkGdTQdBP86Z4Ne9FonNNq+Ts8/LJJNgfl5O1oZY1BozT2CiLlQEFhwZzdDYPS4X88uzICxQecmzNSQDwPuu1wuyUTCbq0wLxCn2ECS8RbIoquZEXiz9g+g8rGNIIMehnmOiyXHlR6I5yL+Z7VFFFl4Sgsm7u/zUM5U0DC1Ud/qpFFzGJkFiDJQmI1Zvl9A62mzU5rxE7A9UptNp2I0M9Ecw8siJRAjunjghAooVo2XjbJ8GwhPq3sg/zT+eLz+vugkN3yCL+3gWgz78tAIh3rtL87ovCStVWU9d1tNT69x2kM+yVtz319VR6xFPHEUVZpPdc078XjUuulbwwSHnCaG3j4eBNv2zcMnKmR3X3lPU3ixtw12tqJyUZKiRCw7XeLrYubsxy82HsnJd+5nImWWRVlGndbE+3cNR8WnaDrH4A==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(39860400002)(366004)(396003)(136003)(451199018)(31696002)(36756003)(86362001)(54906003)(316002)(66946007)(4326008)(110136005)(8676002)(478600001)(2906002)(6486002)(66476007)(44832011)(41300700001)(8936002)(5660300002)(82960400001)(66556008)(6506007)(26005)(186003)(53546011)(38100700002)(6512007)(2616005)(83380400001)(107886003)(31686004)(403724002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Y3pVYmFEZUFoY1hoYTRyRW5iQy9mMm16NDRuczh1NndmcEpZZVg5K3dYVkFp?=
 =?utf-8?B?R2lQS0pBUjZTUDhVUHR4cTV4ZC9WMzNuU2UxcVlidXQ2eUZqTVRHZDE4azFz?=
 =?utf-8?B?TDBiRW90R2YxSzdjTURzMk9ZTjNGb1AzT3RmaW5jMVVlcFJwMXdoeHhRcDY0?=
 =?utf-8?B?YzI3b0lDS3BQRk1IWEpLWTNzQk01alNyN0pFaTQrK2Zod1hTRE9HRHY4Wkw0?=
 =?utf-8?B?Q1VNb09FMlNnQXh3ZW4xOUF3elo2RnBReUZ4MXFWcjU3OVkweTNTUURNREND?=
 =?utf-8?B?ODBhdzF1QWl6OUE1MnRMbEFTMHVrTUR3endlc2ZSVlUwcDlHQ1h1S2Z5MWhR?=
 =?utf-8?B?VU5IWENPeWg0b09WNXNGSm8zbE4rck5CcnY4QUNib1lPMGNGNGsxQjI0K1hv?=
 =?utf-8?B?MXUrUks0VUt3bGdYQnVzR2JJYW5TMnhtZVpzV2luTlE3b1Fkc0NXZnlUTjcz?=
 =?utf-8?B?OEJGb25jWW9kWUZBMS9QVTZwTEo1QUdQNlVUMENjeDVIUFlZc1VFN2VhR1Jm?=
 =?utf-8?B?YzZ1aVNFTnZyWWVPa0llb1FxTG9ITEVMbVRVelZQZWllY2pFVXRGQWlnYklT?=
 =?utf-8?B?cFlFeCtraFBvMFNrNnlnUHhkQmlybzJYQWV0YlRaK2RpczJJeTZYSjRucldl?=
 =?utf-8?B?eFdOeVBlalpMNGlTYm0wb0g5RlNNbFBOTmNmUC9VR04wQUJBeGxiWXV6a1V6?=
 =?utf-8?B?ekZXMWpxdEE3UC9IaEtWREZiSERBRDFWdmRJWCttVk00dVRkWkZONXJRNmFS?=
 =?utf-8?B?dnJhNUpUdlhMSU51YmxwUHduSkRqb1h3Q0tpajFnNHQ4QWkzS2JNMmlwaXB4?=
 =?utf-8?B?eVdWVGZmOVZ1N0RrMlo4SXk3NmpwUlg2QWdPd3BtM2NSRGZYdEM3bFhhUisz?=
 =?utf-8?B?dERrNVRIeFk1NmRGUnVkSTIzMi9xUzhkZ0p6RkR4MEtyZTlua3liRzJ0TlNX?=
 =?utf-8?B?cEI4TkVLQmJmTEMzL0p5R3gzQnJzNUE2WDUyWmpPN015QVEwWGRISFhadjRL?=
 =?utf-8?B?WVdmQVJiT0ROSllpcG1OZU93NTk3eDFJZUNRN25teFFudEZCVCsvOFdCNzdX?=
 =?utf-8?B?VWMyK3R0V1F4aVliTnNQN0FMMElscXVRQ0Nhc0F1TmJ0eTFtaUZ4VWF3Vmg3?=
 =?utf-8?B?bEdlUnEyY2w3TXFWTGtoYmtBa1N1RExIT2VIUUtXdS9yYTJQa29OTk95RWhm?=
 =?utf-8?B?cXdBZVZjTE1FR0FVM3JNdmhEbUFQVHB3T0tJbldGc3gwaThmS2pGU296SDZN?=
 =?utf-8?B?ZHp0NkFkTHJ1SVdtdnBnc09ieGV1blAya2NmOXdPdGVLVTBtTEZzSCtFdXY1?=
 =?utf-8?B?VllTZDJFNXEvRlF1TiszNGY5S1lpSWhpS1YzOFN1TVozVW9KdHh1RE5kVzVo?=
 =?utf-8?B?c1dQRGVmeHVxcStyMkdPTUJQcUc5aWltZkM3OFh5RVpFL21WdzFrenFlcktL?=
 =?utf-8?B?OGJ6T0ZmYjdEWENuWEMyMVlsdm9iRFJvRnpKS2NpMGd6ODJPMU9zRGJSNG4x?=
 =?utf-8?B?dkZ5ZnU1T2R3MkoyY1ovUzZHRDEra3dDSkYzQmZYc01pWkh6dTdmSG03YXNS?=
 =?utf-8?B?SWdvb2JHSWJaSXFKaDhvTjh1WU9nOXZVTi8xSk1rS0NxOUVqSVRPL1lBV29N?=
 =?utf-8?B?SDFaODlUbkFkNVk3UVlIbk5qU2h2ekg5eGVQbzFTNWFuNmY5RFhyeHpDNHov?=
 =?utf-8?B?czdkZTBPZ2cvdGFwYW1Vd3VJTGYvMGI3eGlKZ3FNaUdhV29QMzQ5TVcrbFh1?=
 =?utf-8?B?Y1JjeXg0L1k1VEJWKzZkMTlkSGxmVkFqOGpPOU1RSDVsRFhVM3hYY0drVzRu?=
 =?utf-8?B?UnhoM3M1OG8rKyt1NE9wSU5HZXNGUFBzcDlLM24xZkRCNkdRdGMwdkZjMEt4?=
 =?utf-8?B?am9oTjRqSzZJdFVEdU1FMWVpeXBZRnpJa3BjbktIcXJYTmQzQ044bUdEbTFn?=
 =?utf-8?B?SmdkRjdQV1RDdFVNVE9NWGVJdjR5UVVPZHJBR0kyMm8wKzg3Sm4xQlc0RlJq?=
 =?utf-8?B?c3FKeXlXSW9Pci9vQnl5eDVZMVB1Mzl5VUZEUnpYN3JxQ2YrSjdxeHlCT25x?=
 =?utf-8?B?UkxUMDgvZE51bmZENHZKdkFRbzFibUZZVUk5R2l6NlY0Qk1yZmJxd21pNG5l?=
 =?utf-8?B?clAwZHpHNlVDYnB2c0pOem9DeG9saFdNQ2t1YUErL2s0d3orcW8xSDdyV281?=
 =?utf-8?B?Wnc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fee3d9b6-474c-47c8-8770-08db0e5bb78c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 07:18:48.8403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MBLsP+Uq5qNlZ8TXLm55kdWxTq8it0SeeAbc68A9hZT8HE/Jy5BxQxpZG25S75GCaweC29E3NTqdfSOzmI72ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3228
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 14 Feb 2023 07:19:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10694

On 14.02.23 03:10, Moessbauer, Felix (T CED INW-CN) wrote:
> On Mon, 2023-02-13 at 16:28 +0100, Jan Kiszka wrote:
>> On 12.02.23 09:27, Felix Moessbauer wrote:
>>> This patch reworks the implementation of the swupdate type.
>>> All generic aspects are moved from the swupdate.inc file into the
>>> swupdate class and made conditional on the swu type.
>>> The sw-description file is now referenced using the image-type
>>> infrastructure, which avoids manual additions to FILESEXTRAPATHS
>>> and
>>> accidental overwrites of SRC_URI. The templating logic is moved
>>> into the
>>> generic one provided by imagetypes.
>>>
>>> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
>>> ---
>>>  classes/swupdate.bbclass                      | 26 ++++++++++++---
>>> ----
>>>  kas/opt/swupdate.yml                          |  5 +---
>>>  .../images/{files => swu}/sw-description.tmpl |  0
>>>  recipes-core/images/swupdate.inc              | 15 -----------
>>>  4 files changed, 18 insertions(+), 28 deletions(-)
>>>  rename recipes-core/images/{files => swu}/sw-description.tmpl
>>> (100%)
>>>
>>> diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
>>> index 5eb4936..966f7c0 100644
>>> --- a/classes/swupdate.bbclass
>>> +++ b/classes/swupdate.bbclass
>>> @@ -8,23 +8,33 @@
>>>  #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>  #
>>>  # SPDX-License-Identifier: MIT
>>> +ROOTFS_PARTITION_NAME ?= "${IMAGE_FULLNAME}.wic.p4.gz"
>>>
>>>  SWU_IMAGE_FILE ?= "${DEPLOY_DIR_IMAGE}/${PN}-${DISTRO}-
>>> ${MACHINE}.swu"
>>>  SWU_DESCRIPTION_FILE ?= "sw-description"
>>> -SWU_ADDITIONAL_FILES ?= ""
>>> +SWU_ADDITIONAL_FILES ?= "linux.efi ${ROOTFS_PARTITION_NAME}"
>>>  SWU_SIGNED ?= ""
>>>  SWU_SIGNATURE_EXT ?= "sig"
>>>  SWU_SIGNATURE_TYPE ?= "rsa"
>>>
>>>  BUILDCHROOT_IMAGE_FILE ?=
>>> "${PP_DEPLOY}/${@os.path.basename(d.getVar('SWU_IMAGE_FILE'))}"
>>>
>>> -IMAGER_INSTALL += "cpio"
>>> -IMAGER_INSTALL += "${@'openssl' if
>>> bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
>>> +IMAGE_TYPEDEP:wic += "squashfs"
>>> +IMAGE_TYPEDEP:swu = "wic"
>>> +IMAGER_INSTALL:swu += "cpio ${@'openssl' if
>>> bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
>>>
>>> -do_swupdate_binary[stamp-extra-info] = "${DISTRO}-${MACHINE}"
>>> -do_swupdate_binary[cleandirs] += "${WORKDIR}/swu"
>>> -do_swupdate_binary[network] = "${TASK_USE_SUDO}"
>>> -do_swupdate_binary() {
>>> +IMAGE_SRC_URI:swu = "file://${SWU_DESCRIPTION_FILE}.tmpl"
>>> +IMAGE_TEMPLATE_FILES:swu = "${SWU_DESCRIPTION_FILE}.tmpl"
>>> +IMAGE_TEMPLATE_VARS:swu = "ROOTFS_PARTITION_NAME TARGET_IMAGE_UUID
>>> ABROOTFS_PART_UUID_A ABROOTFS_PART_UUID_B"
>>> +
>>> +# This imagetype is neither machine nor distro specific. Hence, we
>>> cannot
>>> +# use paths in FILESOVERRIDES. Manual modifications of this
>>> variable are
>>> +# discouradged and hard to implement. Instead, we register this
>>> path explicitly
>>> +FILESEXTRAPATHS:prepend = "${LAYERDIR_cip-core}/recipes-
>>> core/images/swu:"
>>
>> This means downstream layers wanting to overload the sw-
>> description.tmpl
>> now need to register their own FILESEXTRAPATHS? That at least
>> requires
>> documentation. Or can we also drop LAYERDIR_cip-core here, and it
>> would
>> still work?
> 
> That is exactly as it always has been. But downstream layer have to add
> it only if they override the SWU_DESCRIPTION_FILE. IMHO this is
> reasonable. I highly vote for keeping it like that, as these kind of
> things bite us again and again with each bitbake update.
> 

If I write

[my-image.bb]
inherit swupdate

and place an own sw-description.tmpl in my own files/ folder, will that
be picked (as to be naturally expected) or the one from cip-core?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux



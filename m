Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E6B9E95A8E
	for <webhook@archiver.kernel.org>; Mon,  9 Oct 2023 05:56:07 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.43])
 by mx.groups.io with SMTP id smtpd.web10.55180.1696830963155022274
 for <cip-dev@lists.cip-project.org>;
 Sun, 08 Oct 2023 22:56:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=TMyV+Izg;
 spf=pass (domain: siemens.com, ip: 40.107.104.43, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hWRN4KtALaRBjhe4SgOCrnQuCdoYZnYHewsBrHyovB8FA6gRLBh8thjHmvTQ58JtGi9t6/kNVHNjE0meNuNZBit6g2owCG0q8LBvot+g9/mHvmM1WvxFZLwciNLr5pr3fKT6VZHjGhGEdRr9aKEfKoXCHUprIwF6t42OxqejOzpwvpJaiuFwfWtYCQi9Jc2/PZEMnmN6Pzddalfj0QZYnXoztluP0WYWCND+HMHSPZewjPXmE4PqO8lwLx0o/GD4Mo1XcyW1yXRZIXH51WvbYBnLrVFPlTrK3xd5ckVg8fUluhIJVho7zib8pwVOhum821oVARrU+XM6OfJpx92mIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E61FCJB8K0rebcMq6Ou0fNbZc0sXEOy9BtMphIzxLlE=;
 b=fzTJfvvtx8m2G6zjcymazG6cWFjdMkIQ/Wb1rWrfzEBEJf42Ry9rybP5l3xEYdYzf8MCuH/4QYVzTL/r3PL3Buuokpw6gMpAyOThVzMoKFoS7TEU1mKrYESs9ZPoN/5ohiDwfFPmH0rx9Jey9CIzV9DO9ElpHAmqioJzM10ZrFGGbSEC1SkPgJZ6YXmlFcsUon1BOstaCCHvJq7RrSZgixSNKHbPb66+2edFNco95PaBgyCSnn75kvQlwHB0cIdw1VuD/A9ez9D0HelRBJv/SSV7bve7Kc9Hx6YwRKJoPi7hcpytkbsSwskNUKceida5CAv6ocX51drdYwy5r+bPMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E61FCJB8K0rebcMq6Ou0fNbZc0sXEOy9BtMphIzxLlE=;
 b=TMyV+IzgjLW8ndamPP+4ig1dHmmsOBk+PHqMwT8QXXwzOpUPAH0J7KbzCmvVHZLFyBWsV/VPQGBHb3yOhGiR/dhkQqL3bA+yRMu6MoHv8uQm0Wwj95LxPC2Mmzb9Nisvfc836UaJnIqP+2SPLejY2Amnm5Bv5Pf8q/01IjQrrfJg5fS+toucfooAU6EQ7bfN/3OoavwEV1TAHAJ7CdmsxoctkiTEQHDA6+l7GdhSL18PsnvrGBd7t4PMAXTPrgqRfbXoQ5qDa+5bbdQZP5n6EMMaCDJndrkbTu0Klt9yHk/pO/nhNImcil473P8TVUydVNrb6Eq2+GORK5o6fUsBPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5432.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:32b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Mon, 9 Oct
 2023 05:55:59 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6838.033; Mon, 9 Oct 2023
 05:55:58 +0000
Message-ID: <1398609a-9314-4da6-8111-0854db5c40c6@siemens.com>
Date: Mon, 9 Oct 2023 07:55:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 1/4] make deploy-ovmf compatible with
 schroot imaging
Content-Language: en-US
To: "MOESSBAUER, Felix (T CED INW-CN)" <felix.moessbauer@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Cc: "Gylstorff, Quirin (T CED SES-DE)" <quirin.gylstorff@siemens.com>
References: <20231008031529.1338834-1-felix.moessbauer@siemens.com>
 <20231008031529.1338834-2-felix.moessbauer@siemens.com>
 <7941a31b-121d-4f44-b815-2f494294ff9d@siemens.com>
 <590f96d1b12c661e87f5d077c49e43707f0598c3.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <590f96d1b12c661e87f5d077c49e43707f0598c3.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0171.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5432:EE_
X-MS-Office365-Filtering-Correlation-Id: bcc2d3f1-be89-4a74-07af-08dbc88c691e
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	95PJWnP1z2mofoQwkt4lx+DV8eg7/TUVfZo7x9ZlhuAbls9ZhFpvDxsfIzKLaWgQvLi0N0Zx40y3vv0dxk57nQdwwGHAHbD1AE9aUO3X+tub9Cai0LmT8PFalUljJeR0xLqgZ7eQigeVe/xn/Oq+Ep2hwRzAwxTxPAxtOAG26//G0d5JcobshulBs3hOpg/KtB6oCdrIjEEUmfr8ZVDEQZsklrYwgvHWAaMga6uMKGQuaDWiFxyjBRnOBQvKU6bnkSptO1vuB9UxlKL1r67LT1/UIaY2Ql6RhFbxktCeerq19B5kr7ycCdit+1nlLHBA75now0FN4lfUG7K/gLPmpA26LX9X1IKQbTDhVY2i3MWtYkbrvA95nvoJeyt6/S0hhSNaD1tb1dhZ7fkZdgZbUP3TAzCCE1r19e7/QjFQfRWLnA5nPML1mCFG8JDrrqqgSKaiy56N5pds9Nw9BExxd5bfXJY9vcDVvk1W3F47CxDEIwtWt7ZWH6WlWuft3RH9fZAik3tGIuygHxOImoF9bp6ung2ZUWkk071NtQhZySHbypZYkYpDViQQ/YaSPRxFAsOrhWkAFlNSir5U7jT4kRSYlY5x3skjV7mL5W/BCFWzDYkKb7wYOjSqbIBDKILDBFaALrB+8AWE1gLgbSxf2A==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(346002)(396003)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(31686004)(66899024)(82960400001)(2616005)(26005)(53546011)(36756003)(31696002)(86362001)(38100700002)(107886003)(83380400001)(8676002)(8936002)(4326008)(2906002)(6506007)(478600001)(6512007)(41300700001)(44832011)(6486002)(316002)(5660300002)(66556008)(66476007)(66946007)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dGZFbmI5VnRKNUZlWkVZM3ZHVFI1QXhwMnc1Z2JZR3cyREcrdlE5T3dvM3Ey?=
 =?utf-8?B?bzd2dmVYNGx5Ym8wVEk1NFE3TitZNjBMNWU3d1pOcU84TFlnWnNCQ0V1b2Yr?=
 =?utf-8?B?YjZmdzNmK3pGZGhmOEhuc1RHMG9UWnVjVnZpb2d2ZkVXbnQrZzFvZjNPSnVV?=
 =?utf-8?B?WjEvejN0dHZ0eWJWUzNOdmw5dzZLQXlFWUhqMGJhRGhtL0RHdzhUbUFLTHRV?=
 =?utf-8?B?c284dzk4VUFtajJuSExDaFZZOXFKQ3pDSzQ1UFFwazFFUDJ1OFg4QUlpYlo3?=
 =?utf-8?B?SWlsT2xSWnF0NDZTS1VrUUdESkZ3MW4wWUFkQzVKZ05XSTFvNFhLaHptWmNT?=
 =?utf-8?B?UjhjbjRUclNRNjlnS2t5eEl1VEd4eEZHR2UyRmZVWTZBY0loTEtHb2VXdWly?=
 =?utf-8?B?eGw5TFNpbEF3VDIxZThMMXRLcXY5R3NFNXVNUWNpRnFBdEpwL2xTNGF0aU1K?=
 =?utf-8?B?RE1XMnJWaFlidEV2NlBkNXU2cExKbXBLaDJ6OXh3dXJnTlg5SzREb0M4QmxJ?=
 =?utf-8?B?TjAvWVExVUFxeXlmcG1BellRdllsMVl0bWhpUjdEQ2plUnpQVEFxQ1U2bGIz?=
 =?utf-8?B?L1VVd2N0ZXd4WlVmYXJlQzRIamcwb0lyQmpBb21uWkwwM2pMWFVQeFVROXM4?=
 =?utf-8?B?anpCMWsvR2Y2VW9tcDZMSEJhOFNnMHM0YlBQUEFxUi9OdHpHeE5IVklKNVJt?=
 =?utf-8?B?OWMzY0FEVWVHSmR4cGZLWWZiSUpsamhoNkg1WnVqWUNES2RCNEpFcGxSa2po?=
 =?utf-8?B?ZlAzWmxLUUxSUW85VE5PYmZrcTNyckFzVFAyNnNueml2cWUrUjJnMmlTZll1?=
 =?utf-8?B?S00rbit1WDZnaHJTSXdGZGt4T2c5OUVXVUJkdUxoYzU1aVZHTW9PWTluMXMy?=
 =?utf-8?B?Szg2Z0FIV2tLZUxQdENEdjliV1ZzRitGZ1lEekRKU3c4b3MyNjA2M1RMSVlV?=
 =?utf-8?B?YmJLL2cwaFd3b0pHUWh2OE4xd3VDcUJFWGVSc0FjOEgyZlE3N3FOc0dBaW4r?=
 =?utf-8?B?Z1hsSHpxQzgwdTI4QlVHRDdvZGJ4MHhsUTZDTFFGcHlhNHNzSGlVSGVNVkl0?=
 =?utf-8?B?bGd4VWI1SW9EMjBuOUhnZ1hZUldxN2o2WVl0eFpXTzJrc1I0aW9wS004WGcv?=
 =?utf-8?B?U0ZMU05pUVpKcThHZFczTGY5OGUrNTRGOTZtWXZFQ3luS2d2VndVbHVSZDRX?=
 =?utf-8?B?NzB6MytHVGE3eDlaci9DcFVWZHd1QnNzOWpiSnhFOXVON3NESHlqZWJzR3o2?=
 =?utf-8?B?emhlMkx2UkdxWGd3aHEvRkI0eDYrUW5jMVFhUGpoZ081aWovSlgwbncyUGVw?=
 =?utf-8?B?YVBFSjZQSVpZRHZZWSt3SldTei9DWkZndGd4M1NjMEFOUDdQSEZhcmJZR2ty?=
 =?utf-8?B?cUg5WGtud3hYdVFGNUtIVERRZG1hYXlXdzZjRGFCd0xFcU1vbHNwQTZRMys2?=
 =?utf-8?B?QXV2V3lZUFV3QnhoL0Z0N2Q4S1J3L0xZTHo1b0wwc2I3MDcxaE9YdGZiV3FO?=
 =?utf-8?B?eU9iQTZsaEo3Q3g2UHR1a0NwbkZBQS9USytjU1lNSVZUQTU1OUMrQkl6VGVD?=
 =?utf-8?B?ZngyVmx3d3l5dmpOSGpnZEdaMEt3TTQyY1I0aXJQLzFBNmVoMlJFVnJRSktx?=
 =?utf-8?B?dUJJay9hU2Z4OVJDTytkV3cxai9wcXAxak1oTU1aakEwY09KRExtM0tCSVl3?=
 =?utf-8?B?TEpPMWFPZ3MzZ05XMlZNSjloK09VQVd0MlFhUUk1clJKQlg4SXZrSmdMMjJK?=
 =?utf-8?B?WVJTWlZjeFpFRGZab2dxY0pkWEQyOUFZZG5hUGhQUWd5MTFYY1FPSVJCQjN6?=
 =?utf-8?B?eVduOU02S0xuZ0hXd2hQMGdxVEJ1MmJMemV2SXczN0ZVUWZCZGlvRUdmckhh?=
 =?utf-8?B?bFlsdE1acjNVTlUzUS9OaXh0d0VNNHduQ2pPZUJSd21GVUFqSVVtaXM0SWxQ?=
 =?utf-8?B?WTZ4TlVzZXkzMWV1a0tiSCs0TnJvd0xEUUV2LzBGSklUVDB3K3JmZTBPRlds?=
 =?utf-8?B?QzRBRTRHNmJ0QzJ4a1FXVDd4Y2dtOUR2a1RDRzNFRGlxU2ZQb2x1WjhYUi8v?=
 =?utf-8?B?ZmxvR0VXc3lwUjMrL3BvSElOWkVjK2ZQRDhadkhGeExoZTdhRUhSb0hBUTR3?=
 =?utf-8?Q?RFlUWawj0+8txLio5vfZf8AC0?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcc2d3f1-be89-4a74-07af-08dbc88c691e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 05:55:58.9137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A6Qn7v5mbSOvR2+tVDjdae2ca2Fl5DCDzqoExz9vQLwf8SCLmXA2xN28yLgGScUnt77/MDF/YdQCngvj+OKsHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5432
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 Oct 2023 05:56:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13313

On 08.10.23 12:19, MOESSBAUER, Felix (T CED INW-CN) wrote:
> On Sun, 2023-10-08 at 12:18 +0200, Jan Kiszka wrote:
>> On 08.10.23 05:15, Felix Moessbauer wrote:
>>> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
>>> ---
>>>  recipes-core/images/deploy-ovmf.inc | 10 +++++++---
>>>  1 file changed, 7 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/recipes-core/images/deploy-ovmf.inc b/recipes-
>>> core/images/deploy-ovmf.inc
>>> index 0ec8762..cdab118 100644
>>> --- a/recipes-core/images/deploy-ovmf.inc
>>> +++ b/recipes-core/images/deploy-ovmf.inc
>>> @@ -11,11 +11,15 @@
>>>  # This recipe deploys the OVMF binaries to run the image in QEMU
>>>  # Note: x86 only
>>>
>>> -IMAGER_INSTALL += "ovmf"
>>> +INSTALL_deploy_ovmf_binaries += "ovmf"
>>>
>>> +do_deploy_ovmf_binaries[network] += "${TASK_USE_SUDO}"
>>>  do_deploy_ovmf_binaries[cleandirs] += "${DEPLOY_DIR_IMAGE}/OVMF"
>>> +do_deploy_ovmf_binaries[depends] += "${SCHROOT_DEP}"
>>>  do_deploy_ovmf_binaries() {
>>> -    cp -v ${BUILDCHROOT_DIR}/usr/share/OVMF/*.fd
>>> ${DEPLOY_DIR_IMAGE}/OVMF
>>> +    imager_run -p -d ${PP_WORK} -- <<'EOIMAGER'
>>> +        cp -v /usr/share/OVMF/*.fd ${PP_DEPLOY}/OVMF/
>>> +EOIMAGER
>>
>> Single command, no need for the EOIMAGER trick here.
> 
> Looks like, but it uses shell globbing. By that we either do it like
> this, or we surround it with /bin/bash -c ''.
> 

Yep, still nicer to read IMHO.

> Felix
> 
>>
>>>  }
>>> +addtask deploy_ovmf_binaries before do_image
>>>
>>> -addtask deploy_ovmf_binaries after do_install_imager_deps before
>>> do_image

This is incorrect:

Log data follows:
| DEBUG: Executing shell function do_deploy_ovmf_binaries
| E: 10mount: mount: /run/schroot/mount/isar-builder-0af4fb00-967f-4225-bb40-24080d20a499-118-a5246ca0-55cc-4a6b-8768-5c03a82eb3d8/home/builder/cip-core-image-qemu-amd64/rootfs: special device /build/tmp/work/cip-core-bookworm-amd64/cip-core-image-qemu-amd64/1.0-r0/rootfs does not exist.
| E: 10mount:        dmesg(1) may have more information after failed mount system call.
| WARNING: exit code 1 from a shell command.
ERROR: Task (/build/../repo/recipes-core/images/cip-core-image.bb:do_deploy_ovmf_binaries) failed with exit code '1'

Must be something like

addtask deploy_ovmf_binaries after do_rootfs_install before do_build

because schroot mounting expects a target rootfs.

Did you test this?

Jan

-- 
Siemens AG, Technology
Linux Expert Center



Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A75DEB64DC
	for <webhook@archiver.kernel.org>; Tue, 11 Jul 2023 06:26:27 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.53])
 by mx.groups.io with SMTP id smtpd.web11.1644.1689056776546076750
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Jul 2023 23:26:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=TtAaTJOx;
 spf=pass (domain: siemens.com, ip: 40.107.8.53, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sk1/k/LkJ66/1JuNmUdYsGVQPg+qZ7J/x4+/7RJsl0YIn9Hd6IVog5//nQi/eydwMu78hQTCRUGNBvbDcTEV3bR5F9XnDRWP/PNqGQFWCkxb2GWc1J0cV6kqG3FTxwmDv00D2x+IfQvsTLgVKpO13EGvPWleeO0M2b4CeFTFKxQxGJlxVEqzzBPSB40mVTsQtIPs08H/JR3BtBW9eBKlRSdX2XvXwseNf9STT4XCqUnHTNWBq5mBV+2Kb9iL38XCmzri55an3iqfJWOpv51E1t0/86E1xdR9Llpj2ma0xgnF09yWUpCa9KTAppxoODlMuoU3N5RFgIaXAmGkWOEEdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9p3LmQ6lYzirL3pORIu7QxrqTVR4vVPIES8aP4ke/po=;
 b=EzCfC0+1NqD+JRtnJEz+qOOaF2jWNE9T338kGj9JeN65Pag+yFA+9GtA1CeJmR0MhWnMuBCV/6lp9G5pjYCbLDkETQ+icXiCXZL187WAfR9zv/OAMM/rI3KrztdCXVfNXZf2DN63viWTd1iyhep/R2T1Vl9svKOxBpw42MBO33plv2uOpaLPagK2L3Xvblj+XJT+JinW/ZL+XQZsTYGkXuegUsg/BoW+xswqkjmSkK9EqyfdOwkMFSsL9bAJFXa647teuifDP/Nj2T/DP8k4zxhUUKmgHibAJxX/ArS1EFsNcj0P3vgf0vvMHPCBnO1pzh6F6JBO0GBEEUjw55IKTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9p3LmQ6lYzirL3pORIu7QxrqTVR4vVPIES8aP4ke/po=;
 b=TtAaTJOxNq81GLmsy44woBU9wYSYICSXRjVhimPPJjltg+hgug2l+BBIA5GZRelTO6QzVZ6lLhPvAKBqSj7jmKLioMZRU9pkhWDcneb4zSOjXjxH8dgLGuf8dZjXJMx9JaKT5rhPXtZySqQsf4z16Z9aEtWEpVBeXQ/iEiWttS//Rw6TutwWmlS/8LoDkT3dId//aLhbWR7yNlhaEAfhC+IQj6v2G3Aonym9Wl/bHuEX7msmTnqhUdtHHko3jkJMP/c2KEFsL3Z7Mr5fH3f+YlhXq/SlqhPn/o0ubTyFTkTL35s3eqIW6GjyttjcWdwawEJaXZWo/wMgIR5gcE9O/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAXPR10MB5639.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:245::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Tue, 11 Jul
 2023 06:26:13 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f964:e0e9:199:9246]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f964:e0e9:199:9246%6]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 06:26:13 +0000
Message-ID: <31336704-74c3-ece3-f053-1fac95ae7746@siemens.com>
Date: Tue, 11 Jul 2023 08:26:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [ANNOUNCE] isar-cip-core v1.1-rc1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0024.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAXPR10MB5639:EE_
X-MS-Office365-Filtering-Correlation-Id: 614c9def-f427-41f4-a107-08db81d7b95d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	JBup1qZx7yj9sq8CCxp2a6XjnTLwoSbNY6ea9veGtOqMqD6lT+kjV6tXyw4OT/abs4YW+ghG9Lwo3vNKbG40/hmW5P4IvkCTuEeek6RnceaWXfYXUI00kzdPB7EeaVNOfHx/fRBUcgcj1eCCjo4gxK+ZGBVZocZXcBYwKZGtVVNCQpYsB7L1DS5ZAQNYwoAD33tERPW9o8poaCVKu/2JqS3DECBeWMoF5ueAjnlfiXOC0LBjqQoAnR00xWa4oRE8mGn1DTf3lS/Q2vZPeGDMpWDAybXbwoDjf2GpNIZ6+KGL9kbIT53tcYVhEl+tLDJUlqt7db1IQs1eKMpZ4oQrhnqXRE4s/3X7BAllBebt0dSkHNJPL2/Vv7llpuk7WeqrykqS6y58U9lteLcqRFI07V2iM3qsgAU5oxsPmOMk2MbJHSq3G2ksewGzZs1ocrNUUQhxFw3CuYcApDUEE0bl1aHWLmqSTGZJO8UDpLgucRwlxOaTmLaeRN4yociR12YtsIhmOM7g6/bWyzqrL0O60sFtnZ9vTOekJOzw/3/PuSacHnh5ppQGWVu1Z75QKNyGJbgXnzHFrdX1FWscxe5jBlqEBlk/+23UTEQqx+DJeOnabDatVpV7vu9q0ZlcCALRY2SqvsCuZEGHReMmHLEsfzY/NgjzHkBF1qV1A+fsgjk=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(366004)(346002)(39860400002)(451199021)(38100700002)(82960400001)(31696002)(86362001)(31686004)(36756003)(6486002)(66946007)(2616005)(26005)(6506007)(186003)(966005)(6512007)(44832011)(5660300002)(2906002)(66476007)(478600001)(66556008)(8676002)(8936002)(4744005)(316002)(6916009)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZCs2VmJFdmlVUHFSY2FadjZoUDFseGVKdUIvSTJ1T3dBSk9lRlhLeXI2MUtE?=
 =?utf-8?B?ejJqQkp3Vm8wT2V1NTh4c09uNUxhejhQTTk1VStXZWtyenhsNjlYMEhqbDdi?=
 =?utf-8?B?MFh0RnpZQXJSaTJUR0R6c0VLbktTcUVOb1hZNVRqQkRqYStLbkdtc1V0aFZK?=
 =?utf-8?B?djhHZjJsTy8wTjV0aDV2dTJscXIzZCtZQVE3am5JR3JYQjdBZkpkTEs5UXh5?=
 =?utf-8?B?S1QxNjJScncvYTNIOExzRzdBakFTMUZ6amJhL3FIQzJ4SFZrd0ticCs1WDlI?=
 =?utf-8?B?YkxlK2FkazJPQWFvL0xlbFhNU2V1ajdTQ29mcWEzUGpncXdqdHdMSXRmQkhC?=
 =?utf-8?B?ZmtEMWUrWEV2T1Q3M2FhWTFNR2U0akFieGZzNmJzblZITW01WlBKQm5SUHNs?=
 =?utf-8?B?T2w3M1dWRVpyQ09pejB6WjZSUy9RZkRRb1BQS09yamhFYUZWS09PRTl3M1VQ?=
 =?utf-8?B?TWd2MmNSWDd5dGk0WWpkc3FjcU5NcU9YWEsvT0Z3NzdWZVZ1NnJGQitHbExO?=
 =?utf-8?B?eWhXKzhmUzFNcmI2eEk0ZzNXK2MyWEQ2QWNzcllFRVlYd0hxaXFycW1qd2Rz?=
 =?utf-8?B?cy9aYU5rUHcvbTI0L21TUWpJTllGanJhV2JNTDRsaWo2bnlGY0lKQzQ0YTh5?=
 =?utf-8?B?NlNvb0ltazZhaXlxWGpWVEtOM0tvYkpoK2piV0JMcEkzSkIvV1lYT2hzWWlh?=
 =?utf-8?B?bE9CM1JweTJJcURudHpXYUxORk9yZHVPTWlHQi9RVE1VY1pzY1FjalBJNWF4?=
 =?utf-8?B?LzNlcFo1dG45Q0IzY29yRkJzVnhrYWY0TjlNNFk1dE5lWklsZkczdUQrSnAz?=
 =?utf-8?B?RWE5T1hya0ozTUd4bU5DeFJHcC95R3NQcEllaHM1M2YvMGw2TCtsZnFLY3VJ?=
 =?utf-8?B?ZU1kQUJxZXorRnNQczBTWmhzUnhnbkp1cFM4aUhkWnlKQ3F4RmQrNlR3dWtI?=
 =?utf-8?B?OUxHTmhLQWFXTm4wY1cyWlF6blVPc042cWZ4Q1o4UEQyMHQrdzFwOURjRDd5?=
 =?utf-8?B?UGpzSVkxR3ZIa1lJanlweHV1U096RkM4cGtNR29jZzUwUE50bHZhdW1hMnI2?=
 =?utf-8?B?NjVQU2ZkampKZGpqWmRIU2p1N3pkMC9pL2hWWVdSVDgwclVoSTBxZ1ZYQ2h1?=
 =?utf-8?B?SEtIT3kzVWJMR1cxc1ltSjhES3l3K0dZQXNBZjY0VHdMWkE5VTZmY2VROVVl?=
 =?utf-8?B?Qkc5M1lnY2RWVHpxS1lEa0VQTmpMR3VhMTNyUHZDdVN1K2RveFFQWC96QjAr?=
 =?utf-8?B?WklTbzFaWjk5eERDUytLYSt5Q0pxQ3R5MHZOcGZRMkNqOUttcGtyZHROZVR5?=
 =?utf-8?B?cWVHVTZ4RVcwV1p2eVlobGdLeWZhZzlsTnJ5ZnIwYmRFSDNoNlNmdVFpVzN2?=
 =?utf-8?B?VzVMcWt4bUJlVitsOS9qZHlEc3JDYUJiSzZrRWpNR1kwV2tHZ3JvWTNWQlBV?=
 =?utf-8?B?R3JWdHhGZmszWjcyZjB3UklTRXVzaFROdDVlWndkK0VWTVplTXBORTZEVjFB?=
 =?utf-8?B?TWNlODM4OHo5S3VOempoTS9jZHE0UVpFOWQ5OXA4VWtaM3laNjY0bmtxNzYx?=
 =?utf-8?B?Y1l1WHFuMDhlUy9FVUVvRmpmL0lJeXMwM3JpdG5OeEFucUdDSzRjK0Q4RVV1?=
 =?utf-8?B?dmxwR3ZHZ1dIZHB0V2dNeitiSGdabzFudHZydWNrbGJEaHN1TDExOVFSaTMx?=
 =?utf-8?B?K0h1dXVoMC82L0JZTUNXenczamZicXhJTlVFcHZIandXNzdhK2MxaGlVaWpS?=
 =?utf-8?B?U0VVSmh4M3ltSE1PaUNIYVN6RGpveWhKZGp3L1lYYjdZT1Y0ZU1qSUYyQThE?=
 =?utf-8?B?TllEMnJhWW1CaXZieGdtMGN6d09UU2x4T3VabXUvU3JTcGhqUlRCQSs5Q1Vw?=
 =?utf-8?B?YzNvV0JuUGNZdU1MdDBzNlhocU1Zc0loOUpKK2VlbHdEWElmN2RabHZSTnJt?=
 =?utf-8?B?bU4xc0gzZHhSOWxqSitWOGwzS3gwcXhURnNUVGJSMC8zdzJwZGpQSkQ3VDVh?=
 =?utf-8?B?Z3JnRHBoYklkQ2IwaVdWTkxXVS9TajJCci9PVXZjNndDSzJYQW5RNWcxeGJ6?=
 =?utf-8?B?OVAzNGZGMjg0QWlvVEhDd3ptbUcvZTh3VHJQQ2tyNzNONjE0Mk9OVmhITURu?=
 =?utf-8?B?UE9wSjRiQWcwTWdPeisrUlBscnN4UUQ2QkY0dWl1MVZCRjJwdUNkdjEvVXM4?=
 =?utf-8?B?emc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 614c9def-f427-41f4-a107-08db81d7b95d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 06:26:13.1926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zGexzthmMX+904XWtRBqOoOBWVF8PwaFrPqVuZqBQCOuOKNhFORLXi6hTyQBx+KN2FbxVGNfamwZdwn1UTVelA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5639
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Jul 2023 06:26:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12300

Hi all,

this is the first release candidate for v1.1 release of isar-cip-core, 
the Isar layer which allows to build CIP Debian images according to the 
generic profile.

https://gitlab.com/cip-project/cip-core/isar-cip-core/-/archive/v1.1-rc1/isar-cip-core-v1.1-rc1.tar.bz2
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commits/v1.1-rc1?ref_type=tags

Please test and make sure we identify and resolve any remaining bugs
before the release! If all goes well, I plan to release early in CW29.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


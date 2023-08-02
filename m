Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA5CC001DB
	for <webhook@archiver.kernel.org>; Thu,  3 Aug 2023 22:00:23 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.42])
 by mx.groups.io with SMTP id smtpd.web11.11356.1690973878517304731
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Aug 2023 03:57:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=xgWo+Utd;
 spf=pass (domain: siemens.com, ip: 40.107.8.42, mailfrom: michael.adler@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rt7oGNFlYGU5cxFCGkyzx3kAueLB8uVs4HA26s2vtQRKoQOOvQATK1Sr6tA/aOThvTetnAuwpIh6uBLEV2ZE6TV4RB3TUgDaYg705mvVHedlRXNEtNf9ZIhfMlC2oAmJJ99bTwNEVkb4WLjQFxCdCTG9mM49s9xUS9rqo1sT77E6BX9tLGV4xSOfim1Ua1UjQ7ixiGRvjeVR2xHWDeBi3tkyI55b+t3j4nQVUgBHYg9Muva+YvnnLBNoG33ULZZi3zDyZzG4o7/Ye66BUFlXblmO75eYNr3uDdzKXa3KbOftx99CCbW5u9m+/DZkC2hMuF4GVWx4r6Hc7oN4Li/w7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DHSwhdfvJcvTV+D6XAdhd8x6lWmJQJ/7InQyeNrj3YY=;
 b=g+B701rxPBiUsHxcdyfg5QkCg1vfPsXVlfN3WcZ6iI5PkaTWiwY4RUHyEnoAbU4QTvzVSlt+I10N4JxT2aelRq2amiRc6lJSfRY6SDSkvK5Vvv8b2T/h5czy/qR4sl8Gnv1rocloLscAVXW01WIJOk3cjvv7kZv9nssHOCu09RYUhBjJUOIoIVPaAYGYZz3qyBlA1doZ3QKh8Vh6AwnQR7NzLgkGHQVeAjkzSuiUBBd/VCo840xVFRDPwK1XncBAN/kwu2k5KrsavS8tOWaCdHxwtoinxTXxE6vLMip0lpz69GoQA8WlO/SXm4SxEpcYeUxPoe1sAEolWe7K7HcIVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DHSwhdfvJcvTV+D6XAdhd8x6lWmJQJ/7InQyeNrj3YY=;
 b=xgWo+Utd21JG/a77/YW6Q16M9QVT1MRMFx/HwMY3ZsQCGn+W0UFxcoWBXGRF/OxyPpu+kcHHYM9hLkFHCWULs3ylFWZJNnkFnFs+Kjc5gAKoEuII53DuiouLOi0v32H7uzbPrnMKa1yOH/ePUVHlBVw2qGRCBWR9t98AVXPSvarSxQXW4woypbAZy8vqKMw6OaTtXHpIwjEWkfGV4niVA7HR8GFsazdTQCFA96eLBu0LXCXw0YEM+81jnJ/e/2v+1pi7aa9P5GwepAZ0ySPwB4XuzeX8d9F2ovLGnBh34IaUypcOM/kgziW8Z0abRZ0HheQXFjjFntSAZwio+UH+YA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PRAPR10MB5155.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:27b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 10:57:55 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9505:a6cb:9759:b1df]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9505:a6cb:9759:b1df%3]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 10:57:55 +0000
Date: Wed, 2 Aug 2023 12:57:53 +0200
From: Michael Adler <michael.adler@siemens.com>
To: Chris Paterson <Chris.Paterson2@renesas.com>
Cc: Pavel Machek <pavel@denx.de>, "cip-dev@lists.cip-project.org"
 <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] stable-rc-ci tests failing
Message-ID: <20230802125753.4d2e6225@backstein>
In-Reply-To: <TY2PR01MB37881707081B7D70710B10BAB70BA@TY2PR01MB3788.jpnprd01.prod.outlook.com>
References: <ZMoaWmwWiLQz+vNU@duo.ucw.cz>
	<17778648DB0D91E2.2497@lists.cip-project.org>
	<TY2PR01MB37881707081B7D70710B10BAB70BA@TY2PR01MB3788.jpnprd01.prod.outlook.com>
X-ClientProxiedBy: FR0P281CA0176.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::15) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB4734:EE_|PRAPR10MB5155:EE_
X-MS-Office365-Filtering-Correlation-Id: c4ef7ebe-9169-4faf-bb7e-08db93475323
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	r/yt47X6Dwz0id1lDPF14eaHNhLwgnspsEaqtZKEy5yVTPiWdcOR69uUMoMDJDQs0or6/ljU/eqc0ejK/fOOKtGzlIrzjZMv4s3sYJB15jvDeIQmE7hPVuPk6i8ahIeKpqHmamkkhS8TEPFpO5VL6wEn1cs22GFP2HT8giO7ZYdXR4pZ/Y1ovbmria0knPYy2dnbYeOJYHjz7aIIc28lp5WLZ30brVfgRZ5SpAU0P0fISrnDJXsK7XZAMUFaU6sLe6cnnq/Hw5lPm6oJTldZAL2luTP2gJCPoxFUdaMmb6U2HajYTOD0Jp/rRdewlMN4o3FSZchDJs65v+GLDErC7EBh/jQOxmnjPbv+Ziqw6bK6YeGplUV3I5i+Znj4t4xglRknkbMJvwdPaKHOwOSK3I+eALk781lEImqpFPeh5F7npRfQXftuisWQF31UxuRR+bnOI/WZuJWbNXBu6GHJ01FtMo1sT3Fnj/hsAiwuiD6lHQOpywiGKalUrvsL1LudYLH/wRD0BD25Uqp7C6M4jowoPrHbtu/07pt9yJItlsmoi7a/CcU8APiLAHlHB/ot
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(346002)(39860400002)(366004)(136003)(396003)(376002)(451199021)(1076003)(6506007)(26005)(38100700002)(82960400001)(186003)(83380400001)(2906002)(5660300002)(44832011)(478600001)(8936002)(8676002)(54906003)(86362001)(6512007)(41300700001)(6486002)(316002)(33716001)(9686003)(6916009)(66476007)(4326008)(66946007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?gupe+ugLP+FEpYAEery7aMzFY6gRARQn+UCx+L4HaP0cCHLepJM8rXI5Cab3?=
 =?us-ascii?Q?ZsUN+eo17hZON/bC/Md44zqSwKK13r1BHH+oR0IK+XWujKlb1lUKrU0//gcJ?=
 =?us-ascii?Q?t+W65H+m8OiNeC0gpXU2YV2q3wrBkWzBf5+D31N2fufFOPqzQg7HT9ZgJ5u9?=
 =?us-ascii?Q?SmLPmlN/WqJV5UZC6x2WPpoWAjVFZDYv+ZlgVjdu9dAf+jJgXRNW4si6xFIw?=
 =?us-ascii?Q?oN6DuHsQR//5YeUXToxxg8FdWzONGWj9ooBI/YTQK6uN+JBQ8tpWM9pUN39u?=
 =?us-ascii?Q?OsWqlIsdyd/3nZyle6yHl5gaeY5D4k1LQ+wY2VZNpH89w2xrZJhYFY8wdP9u?=
 =?us-ascii?Q?TjiaKPyf4PtCkEBf7bcRuDxdyUvrfcoM5M0op5Y3iLbMrzy+D/R9kDbL1VJF?=
 =?us-ascii?Q?lPzFF+EMOWvyb+DIbnDnW8KCQBZUq26SPY94bEy3tNtJ+JjQjyDRa0klvHOM?=
 =?us-ascii?Q?Q7SbBgy6J7hf+jY4vyIrfgf5cIpUytA0IDJi6Sg/OG2MPpGJ90ZrRrajJHXd?=
 =?us-ascii?Q?2GCXQ+RzY/FeeR9zCXqhEv+l6n9RzDyV1KGdyRTRMlGjo1eKuZxix7fAJoVX?=
 =?us-ascii?Q?KE5EkHftwAniiK7jKnje/jyRTZJsBY88QEcuQAaQ4t7cEUuZj14rsNT+Alul?=
 =?us-ascii?Q?1+UcZ/BypOAyxhm4jnOuXdHC+agYaWX5JJjqxK5q+tQKZ+rIyRBSnOSx9orF?=
 =?us-ascii?Q?5/hMhMDf1uwO9g6XdWfE1FYH0B/lfS5ATHfbLRp6AurGjOn1M6JnGiAaUkUc?=
 =?us-ascii?Q?07tZ+fhKsSdQiarSNx8X0Kdi/MVRZPFAywfoozb3KXZtcWLzCAIJsl0rUeW4?=
 =?us-ascii?Q?mo1u6rM6yTglv2roS4Hz7RDXuQz1ZotN6mYwblMOw5OMgVJ5V1gICjQPRxBT?=
 =?us-ascii?Q?fsJWdc2IwKNmwil9eIE9MHuTUK6BUvKscJo/vjNn76cp5lTr3KlrVzXesS+n?=
 =?us-ascii?Q?jR+C/kp7wxjG7rJvPXTxe1G16H9JFq92hoqO3v4cbwIDx1/5jeck03X/f3ET?=
 =?us-ascii?Q?/+akynP4KCxqbpR8e5CNZLbd3jS767nS4nIFM8B6ZIcrxZd/zX286i783Uhk?=
 =?us-ascii?Q?5aTkBhDI+ncdsZ0am8/P1p7/onps1YPkq4OiXyFkXFWK73oE9y2SdDv7IXf9?=
 =?us-ascii?Q?kOtUYrmR9npxTjDxgBL3DxbvEwIhBeAMGsZ4Y6s+oOQh3NOQTWtK+9+fMBfu?=
 =?us-ascii?Q?s5E7bf6SJbvJSNMYFoTOlvTQlX2UKB68Lmt+OfkxP50LqCYpDXT9uN5etNmH?=
 =?us-ascii?Q?fUwY2MX0sdkw53t3PseYfow+JDrXZLHGOt++celzF1BIPTkQttAhtAp9BBOR?=
 =?us-ascii?Q?EExvuQ/pu/hszAmd1CePQZAzkPoqiBdPTik6yxYtp6lbveClvZMDDKsisS8l?=
 =?us-ascii?Q?okTPmo+XelN7iirtax0c+aK3uj28WmTRHiW0r5TQmT7+VuIHPwg3C8uPvpsD?=
 =?us-ascii?Q?GbmMYr+SOiSHA1rrb05c9MD/FsPWQW9XkS9paDgGBp2O8085dkZi4VlX6BnG?=
 =?us-ascii?Q?vF+kYi0VUqKwpslRNJOKcVycHIGkRc11n86qj0jJRJ6i/9TAep/bgDaapNmq?=
 =?us-ascii?Q?lvGoIaDi6M5B3Xu6U5KeKxeQL1VAbr2btYdsSjpCVh1P16Y6gzbG6utv4p5v?=
 =?us-ascii?Q?EA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4ef7ebe-9169-4faf-bb7e-08db93475323
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 10:57:55.0984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o92FhxJIWTOTQoBqBjfAuf4y5Gtn8IQREhZjnKhhdqF/INVq7k7EUNqtqX2TU/OUh/yz+ps0Xwx0ezFd4B2Dv0bC+AMbOvZM5493AzL3yos=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAPR10MB5155
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 03 Aug 2023 22:00:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12550


Hi,

it looks like AWS has got some problems. From the logs:

"We currently do not have sufficient t3a.small capacity in the
Availability Zone you requested (eu-central-1a). Our system will be
working on provisioning additional capacity. You can currently get
t3a.small capacity by not specifying an Availability Zone in your
request or choosing eu-central-1b, eu-central-1c. Launching EC2
instance failed."

In general it seems like autoscaling has some issues in eu-central-1a
since I can also see i/o timeouts. I'll try to spin up a new cluster in
zone -1b.

Kind regards,
Michael

-- 
Siemens AG
Technology
Connectivity & Edge
Smart Embedded Systems
T CED SES-DE
Otto-Hahn-Ring 6
81739 Munich, Germany

Siemens Aktiengesellschaft: Chairman of the Supervisory Board: Jim
Hagemann Snabe; Managing Board: Roland Busch, Chairman, President and
Chief Executive Officer; Cedrik Neike, Matthias Rebellius, Ralf P.
Thomas, Judith Wiese; Registered offices: Berlin and Munich, Germany;
Commercial registries: Berlin-Charlottenburg, HRB 12300, Munich, HRB
6684; WEEE-Reg.-No. DE 23691322


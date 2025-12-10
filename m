Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C984D3B9A9
	for <webhook@archiver.kernel.org>; Wed, 10 Dec 2025 08:40:41 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.12])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11081.1765356037852950991
 for <cip-dev@lists.cip-project.org>;
 Wed, 10 Dec 2025 00:40:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=H+oMHeNt;
 spf=pass (domain: siemens.com, ip: 52.101.65.12, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vzYT2MOPYMK7gd7D60cSgLfzbxeen5XKYHbvcltaAFUHLvCHWmo8gbjQPAhahZPxIDAFttqI56b6BewayPH1ZGCLueCSGmOzKd+Ae9E5M0k8CWs96cnNX2WqpS66rYn4NBaPHrBnGBkV21gJ1w5nMF8jBlOcKCSJjfsrWBOqFAJWdMAU325m8sWe2hwxCWqz1ijIv7vEP5RHgIEG6/fBOr9NL1D8rq3QKH86ElN4AxWFTQgEDhkRdck8PGXSKPor/QcUQxhm8/Kv++1eoaau4GmM8GIh3/1Rtc7ku1Uc20nZvlhuCVfO0G6Xsiw6lMu4ZEnvXPmNaziQbBXb92NZWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7du8KXNnru9RycVDEtvm4YTDVPXzjIVwECC0+Bihu14=;
 b=sBE0Fw1/d26bEzMwrKmERxb8Ny3L2qWglLaFm0aEhq9j6ALGHySXLOURThO+xHOFJEprgLYp9rqGjaz+qG/YUJSKYGLwrqg8N95Um4t8DWqqsFlrlV7a4x+bsVzRdiJqlRTWS3HM5uIbFVveBZuWzYZ54IpwD9fFhg+X3dRh6l/LFI5NMNXVUbzaCo5BWuVV6hzzH0HCNbb9ix0S4wsRiynR/G+t2pMnthJqbTmCu9xwRb6MhVVM1hqXaPDbV7p7XdVnOSDV2RpBXfizAVlTzMpOHaoKJSZrKzap5e0cVwZT1/PY5GsxXpGyjL3I+gx0R843N+xeYeZdl5VjLunK2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7du8KXNnru9RycVDEtvm4YTDVPXzjIVwECC0+Bihu14=;
 b=H+oMHeNtwQDOVwd0S5Njh7/UQLYMT25RitTwxvcto60RLHcyapf5soO2ByszQy0YnD00aIHTD9kWFaj8FoEfzAtx6FBTxYNXkIDe+X0+b+kRE5mgk0/xTV1Zd4dnLoLeWt7gsOS2oc1EVW/xjdfQhvXGfuJHesoBZKa0C6Y8Tj6N3X/Em/2ZQS85yNg7S9Ujx/orRs1+Y6RBezQT5E5FEd/ALaiAfUTgRN7kBTRreqcfHwsJg9QGZmn+WSmnz9ANza6qUmM0ht9wSoCUCsGzY1klm+jp3pC0nPSY69M/juigb204EjyQ/OxXYRS1PBmq+67KEyjDvADSy1b3BxDvXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB7736.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1bd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.8; Wed, 10 Dec
 2025 08:40:33 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 08:40:33 +0000
Message-ID: <5a48c2d2-2699-44a2-89ef-c44ef1c9ca38@siemens.com>
Date: Wed, 10 Dec 2025 09:40:32 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][RFC][PATCH] Remove support for building KernelCI
 images
Content-Language: en-US
Cc: Arisu Tachibana <arisu.tachibana@miraclelinux.com>,
 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
 Chris Paterson <Chris.Paterson2@renesas.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0193.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB7736:EE_
X-MS-Office365-Filtering-Correlation-Id: 81426659-7b36-4739-59c4-08de37c7c86d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|13003099007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?eU5IVm9JdElUT1kyaUh3cmhmL2g1ZTV3Wk85RXJjL2FSeHJObVJJZzlOU2dv?=
 =?utf-8?B?VFV3MzBZRXhENGtnWHFoRUMrYmgxdUlmd210am8ra1FpSXUxcWlGWERLMU1Z?=
 =?utf-8?B?dWNzUzg2Mi80WjN2ODBqdmE2eitaOE5oZnBQM1MyZ2cvYUk2bzJZZFBPYTlw?=
 =?utf-8?B?WlIrc1pIZi93YjQ4ZDRZSkxlbVF6UHRselErV2Qydmh1UWJBSjdXSlpXUlZu?=
 =?utf-8?B?LzRabDh0bS9CQzJxYmYwbDNNa1c1b1hvQmsveFloVjNhMFN3MXdEQ1AyYWcv?=
 =?utf-8?B?RzJqQ2I2MEFRa2t6cDR0azJuV3o4UlBRSUszSm9Pc2NhMXRsWHlicHF1a2FJ?=
 =?utf-8?B?d3lqcFBDazZJOFRSaFFEZ0w2N1c5a0FxRlVIMG1mYlFrMGJBL1p3S2xXZWZq?=
 =?utf-8?B?M2dGdEFQN3pHR0h5N2dPaEN3c0tOSDBWeVJzOFJIaHFrK0VIdnZLTW4vbkFq?=
 =?utf-8?B?UE1WQTRzZThHUjRyK1NMWTJLNUQxczBvcWxlMjFJVXNnWjdVR1YwR051QWhI?=
 =?utf-8?B?ek1MZElXTi9wdjd0S2NBOHZNeEY1Vk04Qm5jbWIvVUdZUWFVbmw3WlV2dklB?=
 =?utf-8?B?Qk1VdmN3ZGJMcVVySnlRTGhhc3k1TEVQalNkS0p2M0g2RWdMY1FGRDB4Sk4v?=
 =?utf-8?B?RTIyaHRmbENLeUJIUk5Vc2NHTGtvZlFBYVA4NVlpZWxZbkFXUDRPNXNGcUp0?=
 =?utf-8?B?OGJzYkM0Y1NwTnpuMkFJWG16dDJlSWNDMTkwMHhmQUxIMUpZaU1iWVNzOTJR?=
 =?utf-8?B?ZDcybkR2L2RVYkpDRDU1U1RFVFhTcEtZUStHMUU2TUprM01ST1FidmlIclAv?=
 =?utf-8?B?RjVkVUJPWldrZC9SMVZudnNMMHBKYnozYm1CQzVTbzA1ZmU2S2xnLzdSRER6?=
 =?utf-8?B?V3czMUd1dDluYldQZWx1MmZnMURISjJaYTVNZlZGOCtKMEFPM01HM242MVJZ?=
 =?utf-8?B?UUhZOWYvSHQvejNXQW1CZk9mL0p0YXlwSVlWbnlPVm5acnJkd1N6R2ZYS2hW?=
 =?utf-8?B?NU5EYjQrQVpVYndwS3ZZbnBRZUlENWVQWFZ0Mkd5aWYrWWEzcXAzWWw1N1pj?=
 =?utf-8?B?SXkxRTFJcjVQNkYxRFRUVTBoSE9RNFNscHZIUU0zdDZQOWpIemlIQzhDTlRm?=
 =?utf-8?B?aFpyVmtSRFVKU3BtWDIxcFlDWnZqTm9aSTN4S0pWNnZReW9xczd3dkpyYnZa?=
 =?utf-8?B?QzRHTnM2OHpTWUlhc1NJT1NMejc1Nm80NEpDOXBpSUVPNEtqQTQ4bHFKTW4r?=
 =?utf-8?B?a25EMWkyQlc3NVVzdUQ2aS9OeUVkUUZPS0VWUnFCeEFQMXJ4QWM5dTZpcVJx?=
 =?utf-8?B?WVlOS01lZ2FoZTNKTHNiajlveng2WEJyU1lGRnRyaXhTQzAxYnQ5Uk45Z2dH?=
 =?utf-8?B?SUtka0FRMThjMDhFdk5RdkxpL3hYV2lRRFhNWWFBd29iUUp2bE9rblVUMm1o?=
 =?utf-8?B?ZDhUbUhlNjNvSnJlK1lLZjhXM2pzQlFFN2w1Qi8xTnRiUGlJSDQ0NDMvY2l0?=
 =?utf-8?B?QVA2ZW5PK1o0MU1ya21Tb01qV3lmbWN0SnVua1pXQXpkUzVlYW85VG1hSUo0?=
 =?utf-8?B?Mm1RSWVoZ2p3bE5EUlZBV0x0VTgwV3AyRk0rTVF3blA3L0FISE9tZE9WN0E2?=
 =?utf-8?B?MHBIeU40eXNiM3BjZSt2UGFBTVB0cFAvUUtxU1pZdHlRSmZueHA2WU04VHZz?=
 =?utf-8?B?dnl5OEVyYThkQzRwTTlYTmVvZEhjRjgxTHZ6VStONnVUNWRodmtWbU56M1Mz?=
 =?utf-8?B?dzlhbFZyS0JaSWZ3MVFXTkVKOEUwMTkrbWwwTXI1WHJybjlnNHp6dmhRYmJs?=
 =?utf-8?B?d3B6bkhLa3VtWDI5cUl0NVAxZURYZGtaUUM4U1BlQTNrdTdzRC9tdzBsYk5F?=
 =?utf-8?B?NTdlV0d0R05OR2hJT1BpelhKeXA0WjVDRVdJbU4rc25nSXc9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Tjd4UktTMGZ1cWhEM3ZpUUxMNjR0MVFIMHF3UEtaYXhrY0x6Ky9SMmxXSUZC?=
 =?utf-8?B?b21IUDFnK1hXOU5wOFN4aU9tbzZEd1pFdm5xb0toWUFKNW9sTU5NU3BLcjN0?=
 =?utf-8?B?M2VUaTNDK3diSTZ4STVqWnRQaVhoNnRnZCt5eHdDaU5GKzFyU01vL25tUzVN?=
 =?utf-8?B?NmpNeEdXb0QzdnF4MW9taXJOUmtNYkl0dFplaTBRWmk5aDRFbzV3bDdZVlNE?=
 =?utf-8?B?OGY2dnA0em5UVGdtclAxb3N1RW0zS1RTNjhkaW1KM2xJQWRzMm9qSlRXbUh2?=
 =?utf-8?B?Z3pZTTYvWXNNWjlweXoyTkdrK0x1NFVubm1CSGJscmt2YytmZlRNZUg5a05P?=
 =?utf-8?B?dUxCN1lwcG5RaVY5SHg1WjdYcjVZWStNNkRINjZXQXBzTVlCdDlsc0RDZmdN?=
 =?utf-8?B?ZnJlQVlWV3FuSGd1YktRZXBZTkNidGlmb1MybVRiZ1FvTFY1U0RrcnhwL09F?=
 =?utf-8?B?cnR2T1RuVzdWNHBtMy8zNEw1NGtzb2UzSElVWTN6dFV1UEhUTFkyWW5RWklO?=
 =?utf-8?B?TG5mUnlJWnkwRGNuT0c5WWZUSU9mRDBiNGhsVXZESDA5SWVZa09USWlscVFo?=
 =?utf-8?B?OUppakc2S1MyOFQvYzkvZTRBSnNTbndMTkhENjRONU1YOGJPWDlEM0NJdTIv?=
 =?utf-8?B?SlRseU9SQVQyQmFBMjEwWDZmL2RoclRqVnRhTjlkZ1EzbDJlNThIZ1RVRVE1?=
 =?utf-8?B?bnp2c3Bnb3FVWnVsQXUxZHRrbnpzdXJBbkpZSlJ2Zmd3Y3ZmaGFOaXVZaHFu?=
 =?utf-8?B?ZjB3SlFGQ1FZY0hZTFV6MEc1bG4rRC9DR1pvUHJzSG9Qak50MjhzaTVOODJZ?=
 =?utf-8?B?YmovdTNkT2ZhQUxTeVRBNTA4NWEra01EM2p0MFZDamJWUGhOb2JMdlZMcDlh?=
 =?utf-8?B?UzRvMGZqc2ZlUzR4alRlTVJDQkdWdXB3a0haNCtEdHdXNUQydFF6RER6Rkpp?=
 =?utf-8?B?dk80U21pRGY0WTFhYlZwVGRJV25vUWxyZDJMQnFZUXlQbmZmOGhuR1poMHR2?=
 =?utf-8?B?dS9rZ0JOemh5aGJLTVd6bytCNUllREJxdWFpRlVJYTliWWxlaVpkMnM5alNN?=
 =?utf-8?B?dUtLZEhrYjVCd3FkVnFBSFRSZy85NVNuMFB0eTVDWVZVVW90Y0FpczJGRnhC?=
 =?utf-8?B?TEhMYnVHOTVybUh0dlhuMmdCWDBxOEt1eXlCak9qS0lEanZOTjVZV3Q4WUxs?=
 =?utf-8?B?Q010VTJOa2gyV0UyNmR1ODlHeURlY05nZVJWVnJaQ25hUVc1S1RIZmNiL1VZ?=
 =?utf-8?B?ZUVCTTNWMzlnTEhhZXR4bDIyZDdhdERKRCtYYm9FcHphamRoSkZxSGRnTFQr?=
 =?utf-8?B?cXF6YWJCQ2JudVFWWG9LejE1SXBldTB1Q21mMEdQdTRpTEp6aVRPL0dyR1Y0?=
 =?utf-8?B?OFNEMFBaYjJncEQyVjRIOXY5YndrcHVybkcrcGZyaW8rVWpoaWZURVF0ZGdV?=
 =?utf-8?B?eTR4NngwSVhLOWVUWkNkWVZPTVljYnZaQjlYUzRzNTlsYkxpMVRZcU41dnVR?=
 =?utf-8?B?ODJmT3dRVkZkK25oZVJkWStuZEpRdDUwVDRndVRMVjdNcUQ0RWJnK0RHUDlE?=
 =?utf-8?B?RGhDemZHTHd1bEVxaUFWQVVML3VsWlFSd0Z2cnNraENjVTBEaUVhemlST0E5?=
 =?utf-8?B?YlFtM0R3aWNLNkYvY3B3dHg2RnlxRVhabGEzenpPNlZYMW1uSnVuQUhjMXl4?=
 =?utf-8?B?Z25wemhUYTNRTlNxRXVQQUQ1MHpHVzYzcnBMc0pLQ2NwODVmSS9rZjVOSU9r?=
 =?utf-8?B?VzdKcmQvOTNJT2JVV3JsNERkRW5DRmQvL1ErWGV6TC9tcEVtTVBGUStMRFR1?=
 =?utf-8?B?YTd6WHZNU0I0bVRBanlGdForN3c2VVU0NVdPYXE1bVBIeTN5TEdVYjROaWpG?=
 =?utf-8?B?SUpYeGo2YWQvc1krM3JPQmFrRkExeTdxVERubUZFSXV2anpWVHhocnJJK0dw?=
 =?utf-8?B?Q3hEdUpiejQveXUwdUVaOGQxOWdyOURrVE12TTRxWkFGTDJOUTlVZCtRdHdw?=
 =?utf-8?B?WXdpbXIvelpuUUZJU3JzamxqZnhwVG5WNy9ucUw3MjV0clUrajE3WGJtUWV0?=
 =?utf-8?B?TUhuT0lzZlducjJBQVJEZVpPT3BjS2lpdXo0R1gyR2U2VEhFR1V4Qk5GOUVP?=
 =?utf-8?B?V2hHenY3VWdJMjZQOVExa0tBek40V29FaEp5ak1ObmI5WVpEc2JCWFFBemI0?=
 =?utf-8?B?OUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81426659-7b36-4739-59c4-08de37c7c86d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 08:40:33.6035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6IzJvqKJbxfCpJspED3onJ70cHXluehbs4vwO56ZhF3nWek/vMjvqnbyiLMI/zGGU7gKdzRi6wJSQKHpVX3zkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7736
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 10 Dec 2025 08:40:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20957

From: Jan Kiszka <jan.kiszka@siemens.com>

We are solely using the KernelCI-provided rootfs images by now and do
not plan to change that.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Please give feedback if we are on the same page.

 .gitlab-ci.yml                                | 29 ----------
 kas/opt/kernelci.yml                          | 19 -------
 .../images/cip-core-image-kernelci.bb         | 16 ------
 .../kernelci-customizations/files/dmesg.sh    | 23 --------
 .../kernelci-customizations/files/postinst    | 23 --------
 .../files/serial-getty-kernelci-override.conf |  3 -
 .../files/ssh-permit-empty-passwords.conf     |  1 -
 .../kernelci-customizations.bb                | 33 -----------
 scripts/deploy-kernelci.py                    | 56 -------------------
 9 files changed, 203 deletions(-)
 delete mode 100644 kas/opt/kernelci.yml
 delete mode 100644 recipes-core/images/cip-core-image-kernelci.bb
 delete mode 100644 recipes-core/kernelci-customizations/files/dmesg.sh
 delete mode 100644 recipes-core/kernelci-customizations/files/postinst
 delete mode 100644 recipes-core/kernelci-customizations/files/serial-getty-kernelci-override.conf
 delete mode 100644 recipes-core/kernelci-customizations/files/ssh-permit-empty-passwords.conf
 delete mode 100644 recipes-core/kernelci-customizations/kernelci-customizations.bb
 delete mode 100755 scripts/deploy-kernelci.py

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 2714a374..3a202536 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -20,7 +20,6 @@ variables:
   encrypt: disable
   dtb: none
   deploy: disable
-  deploy_kernelci: disable
   build_updates: disable
   swupdate_version: default
   test_function: swupdate
@@ -93,7 +92,6 @@ default:
           done;
           scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${no_kernel} ${dtb} ${CI_COMMIT_REF_SLUG} swus;
       fi
-    - if [ "${deploy_kernelci}" = "enable" ]; then scripts/deploy-kernelci.py ${release} ${target} ${extension} ${dtb}; fi
 
 # base image
 build:x86-uefi-base:
@@ -135,15 +133,6 @@ build:qemu-amd64-base:
     separate_home_partition: enable
     deploy: enable
 
-build:qemu-amd64-base-kernelci:
-  extends:
-    - .build_base
-  variables:
-    target: qemu-amd64
-    extension: kernelci
-    use_rt: disable
-    #deploy_kernelci: enable
-
 build:qemu-arm64-base:
   extends:
     - .build_base
@@ -156,15 +145,6 @@ build:qemu-arm64-base:
     separate_home_partition: enable
     deploy: enable
 
-build:qemu-arm64-base-kernelci:
-  extends:
-    - .build_base
-  variables:
-    target: qemu-arm64
-    extension: kernelci
-    use_rt: disable
-    #deploy_kernelci: enable
-
 build:qemu-arm-base:
   extends:
     - .build_base
@@ -177,15 +157,6 @@ build:qemu-arm-base:
     separate_home_partition: enable
     deploy: enable
 
-build:qemu-arm-base-kernelci:
-  extends:
-    - .build_base
-  variables:
-    target: qemu-arm
-    extension: kernelci
-    use_rt: disable
-    #deploy_kernelci: enable
-
 build:qemu-riscv64:
   extends:
     - .build_base
diff --git a/kas/opt/kernelci.yml b/kas/opt/kernelci.yml
deleted file mode 100644
index 517e7410..00000000
--- a/kas/opt/kernelci.yml
+++ /dev/null
@@ -1,19 +0,0 @@
-#
-# CIP Core, generic profile
-#
-# Copyright (c) Toshiba Corporation, 2020
-# Copyright (c) Cybertrust Japan Co., Ltd., 2021
-#
-# Authors:
-#  Venkata Pyla <venkata.pyla@toshiba-tsip.com>
-#  Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
-#
-# SPDX-License-Identifier: MIT
-#
-
-header:
-  version: 14
-  includes:
-    - kas/opt/targz.yml
-
-target: cip-core-image-kernelci
diff --git a/recipes-core/images/cip-core-image-kernelci.bb b/recipes-core/images/cip-core-image-kernelci.bb
deleted file mode 100644
index 849c0761..00000000
--- a/recipes-core/images/cip-core-image-kernelci.bb
+++ /dev/null
@@ -1,16 +0,0 @@
-#
-# A reference image for KernelCI
-#
-# Copyright (c) Cybertrust Japan Co., Ltd., 2021
-#
-# Authors:
-#  Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
-#
-# SPDX-License-Identifier: MIT
-#
-
-require cip-core-image.inc
-
-DESCRIPTION = "CIP Core image for KernelCI"
-
-IMAGE_INSTALL += "kernelci-customizations"
diff --git a/recipes-core/kernelci-customizations/files/dmesg.sh b/recipes-core/kernelci-customizations/files/dmesg.sh
deleted file mode 100644
index 3b096e10..00000000
--- a/recipes-core/kernelci-customizations/files/dmesg.sh
+++ /dev/null
@@ -1,23 +0,0 @@
-#!/bin/sh
-
-set -e
-
-if [ "$KERNELCI_LAVA" = "y" ]; then
-    alias test-result='lava-test-case'
-else
-    alias test-result='echo'
-fi
-
-for level in crit alert emerg; do
-    dmesg --level=$level --notime -x -k > dmesg.$level
-    test -s dmesg.$level && res=fail || res=pass
-    count=$(cat dmesg.$level | wc -l)
-    cat dmesg.$level
-    test-result \
-        $level \
-        --result $res \
-        --measurement $count \
-        --units lines
-done
-
-exit 0
diff --git a/recipes-core/kernelci-customizations/files/postinst b/recipes-core/kernelci-customizations/files/postinst
deleted file mode 100644
index 08544a4d..00000000
--- a/recipes-core/kernelci-customizations/files/postinst
+++ /dev/null
@@ -1,23 +0,0 @@
-#!/bin/sh
-#
-# CIP Core, generic profile
-#
-# Copyright (c) Siemens AG, 2019
-# Copyright (c) Cybertrust Japan Co., Ltd., 2021
-#
-# Authors:
-#  Jan Kiszka <jan.kiszka@siemens.com>
-#  Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
-#
-# SPDX-License-Identifier: MIT
-#
-
-echo "CIP Core Demo & Test Image" > /etc/issue
-
-# permit root login without password
-passwd root -d
-
-# set the profile for KernelCI
-echo "PS1='\$(pwd) # '" > /root/.profile
-echo "cd /" >> /root/.profile
-
diff --git a/recipes-core/kernelci-customizations/files/serial-getty-kernelci-override.conf b/recipes-core/kernelci-customizations/files/serial-getty-kernelci-override.conf
deleted file mode 100644
index a1472c5d..00000000
--- a/recipes-core/kernelci-customizations/files/serial-getty-kernelci-override.conf
+++ /dev/null
@@ -1,3 +0,0 @@
-[Service]
-ExecStart=
-ExecStart=-/sbin/agetty --autologin root --keep-baud 115200,38400,9600 %I $TERM
diff --git a/recipes-core/kernelci-customizations/files/ssh-permit-empty-passwords.conf b/recipes-core/kernelci-customizations/files/ssh-permit-empty-passwords.conf
deleted file mode 100644
index 04e75ab6..00000000
--- a/recipes-core/kernelci-customizations/files/ssh-permit-empty-passwords.conf
+++ /dev/null
@@ -1 +0,0 @@
-PermitEmptyPasswords yes
diff --git a/recipes-core/kernelci-customizations/kernelci-customizations.bb b/recipes-core/kernelci-customizations/kernelci-customizations.bb
deleted file mode 100644
index 3a99884b..00000000
--- a/recipes-core/kernelci-customizations/kernelci-customizations.bb
+++ /dev/null
@@ -1,33 +0,0 @@
-#
-# CIP Core, generic profile
-#
-# Copyright (c) Siemens AG, 2019
-# Copyright (c) Cybertrust Japan Co., Ltd., 2021
-#
-# Authors:
-#  Jan Kiszka <jan.kiszka@siemens.com>
-#  Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
-#
-# SPDX-License-Identifier: MIT
-#
-
-inherit dpkg-raw
-
-DESCRIPTION = "CIP Core KernelCI image customizations"
-
-DEPENDS += "customizations"
-DEBIAN_DEPENDS += "customizations"
-
-SRC_URI = "file://postinst \
-           file://dmesg.sh \
-           file://serial-getty-kernelci-override.conf \
-           file://ssh-permit-empty-passwords.conf"
-
-do_install[cleandirs] = "${D}/opt/kernelci/ \
-                         ${D}/etc/systemd/system/serial-getty@.service.d/ \
-                         ${D}/etc/ssh/sshd_config.d/"
-do_install() {
-  install -v -m 744 ${WORKDIR}/dmesg.sh ${D}/opt/kernelci/
-  install -v -m 644 ${WORKDIR}/serial-getty-kernelci-override.conf ${D}/etc/systemd/system/serial-getty@.service.d/serial-getty-kernelci-override.conf
-  install -v -m 600 ${WORKDIR}/ssh-permit-empty-passwords.conf ${D}/etc/ssh/sshd_config.d/ssh-permit-empty-passwords.conf
-}
diff --git a/scripts/deploy-kernelci.py b/scripts/deploy-kernelci.py
deleted file mode 100755
index 62f3f010..00000000
--- a/scripts/deploy-kernelci.py
+++ /dev/null
@@ -1,56 +0,0 @@
-#!/usr/bin/env python3
-# -*- coding: utf-8 -*-
-
-import requests
-import os
-import sys
-import time
-from urllib.parse import urljoin
-
-cdate = time.strftime("%Y%m%d")
-api = "https://api.kernelci.org/upload"
-token = os.getenv("KERNELCI_TOKEN")
-
-release = sys.argv[1]
-target = sys.argv[2]
-extension = sys.argv[3]
-
-rootfs_filename = "cip-core-image-kernelci-cip-core-"+release+"-"+target+".tar.gz"
-initrd_filename = "cip-core-image-kernelci-cip-core-"+release+"-"+target+"-initrd.img"
-initrd_gz_filename = "cip-core-image-kernelci-cip-core-"+release+"-"+target+"-initrd.img.gz"
-
-input_dir = "build/tmp/deploy/images/"+target
-upload_path = "/images/rootfs/cip/"+cdate+"/"+target+"/"
-upload_path_latest = "/images/rootfs/cip/latest/"+target+"/"
-rootfs = input_dir+"/"+rootfs_filename
-initrd = input_dir+"/"+initrd_filename
-
-
-def upload_file(api, token, path, input_file, input_filename):
-    headers = {
-        'Authorization': token,
-    }
-    data = {
-        'path': path,
-    }
-    files = {
-        'file': (input_filename, open(input_file, 'rb').read()),
-    }
-    url = urljoin(api, 'upload')
-    resp = requests.post(url, headers=headers, data=data, files=files)
-    resp.raise_for_status()
-
-
-if os.path.exists(rootfs) and os.path.exists(initrd):
-    print("uploading rootfs to KernelCI")
-    upload_file(api, token, upload_path, rootfs, rootfs_filename)
-    print("uploading initrd to KernelCI")
-    upload_file(api, token, upload_path, initrd, initrd_gz_filename)
-    print("uploaded to: https://storage.kernelci.org"+upload_path)
-
-    # Upload latest
-    print("uploading rootfs to KernelCI CIP latest")
-    upload_file(api, token, upload_path_latest, rootfs, rootfs_filename)
-    print("uploading initrd to KernelCI CIP latest")
-    upload_file(api, token, upload_path_latest, initrd, initrd_gz_filename)
-    print("uploaded to: https://storage.kernelci.org"+upload_path_latest)
-- 
2.51.0


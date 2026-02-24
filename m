Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD727F4BB8D
	for <webhook@archiver.kernel.org>; Tue, 24 Feb 2026 21:32:56 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.37])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.31572.1771968774599556909
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 Feb 2026 13:32:55 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=pEGvtZ7I;
 spf=pass (domain: siemens.com, ip: 52.101.72.37, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XZN4rQljc/TZqwzDhTxpQH42piVFBbUmdBAFKHBbRnvRW55tloyy6KYAtwBXOAxtCCa3Qx64ElTuWfTgsVau+P7LYMw/dMFMn+mBYX3tgpfZocfEvD8fW8HKfG0eqSgNTAZM+b/WYQcGBcGZgGZ4Ich+AJlQv5M1an1xzOGc5CStQIVFE8OSR1gpdxI7njYME/3Bf4PAyfFWVuc+VWS4kAHs1tLSp5oausyoYSN1hjml6mjpgo446PiTyzUnMRRGv7+UHlo8QMeGsdBC4er7aILR+PXHuReMBIPjH7m+HYovIY04VSEJZQytYerJOUK1IDf7N3l28qK7UndqMH8STQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tRIlTK4qBUUwnZSHoY776sP5pnBZgUrINb7jLqeX2t0=;
 b=xa0wqpGUTwQn1vhlGYGLAuavEiaalddphp77hDQv+BTH8X8jB9uHH2miw26AT606VnUVizGu7y7A+SGLwK2Vcz+UT6CjaaFnSCqZWa4IWnpr8leekihjr/2GhWVyMzatOseJ6wVxnSGLvfgCOWApOtymjb4CVxvJbi3VkMfZ4ZS2axm9pZMal5/edvfzsHksHER7xQVcJSu+LVIq+l14YFl5bt227oIG09tGNlPqk/9ga/78DXbyWbvg3Zn122olPMg/D8YGDiOPfItM+b/ABRGe8z4r/uauB9aJTJ+0/dN4icNBnow651VFrXG7tBb3vTOXoVNsTORCI/0JT0ED3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tRIlTK4qBUUwnZSHoY776sP5pnBZgUrINb7jLqeX2t0=;
 b=pEGvtZ7I0pk6JtmER0xDjjhTpzR0JKcrnC02fEJWFXy8h3ffLgqqyoJdLBKcnf5cmrvv+58GyQVneLvPdteHAb8YEi//OUSPtbYejXXxwFXYZrkF7HdusHSHbC1fmpPZGzW37ycIqNidOWcRpNfIpPAVqMKaoNX15FwP50/Gr/y4MRi24wrEscIYNX0IfV6IDvBlMHY9r/CQXjEWO4zYXvC/fSZfvktbPj8GGLWFscoitKDeooDLevS9Ci8o7XfEcSshLcdmBB2xUFdq3btqjx8i6NC6/D6Ix2ydeTHyVIfAshiiBrSaL8AciK72RHv9DPOXGrUlH9yt8YIdcEmw0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI0PR10MB9467.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:2ce::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 21:32:50 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 21:32:46 +0000
Message-ID: <9927e980-b0d0-43a0-913c-cff2bda757e3@siemens.com>
Date: Tue, 24 Feb 2026 22:32:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: i915 in 6.12 kernel
To: Stephen Ecker <stephenecker240@gmail.com>, cip-dev@lists.cip-project.org
References: <CAK9C7GAcSFAbw+Z8hU904aZvaG+uKCCdmomxM-8QRc679z91sg@mail.gmail.com>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
CC: Pavel Machek <pavel@denx.de>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CAK9C7GAcSFAbw+Z8hU904aZvaG+uKCCdmomxM-8QRc679z91sg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0103.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI0PR10MB9467:EE_
X-MS-Office365-Filtering-Correlation-Id: 0449a49c-c2e9-459f-4eb6-08de73ec4039
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?2XWu+ND8CFP8JydNRwKT5Pf+mStW17uJK2MPfRSIyO2XShWyBuPH0tsOsGnx?=
 =?us-ascii?Q?uM2LhHmbZBVhBnTCwRrnwxrW7DgTn4yjxni/z7+7S0lDV9mZnC1Pru3iRzox?=
 =?us-ascii?Q?xu6apYI2oDeXGdSR+CBOBBajVgurWAE5cBcPGmK00mLpWr0v3KDmgVzjxVFw?=
 =?us-ascii?Q?jYiliGWphO+o55LBMJptfsu576DnulmAt2aQdBSjl4WcRyGP+4Yg51IPILyr?=
 =?us-ascii?Q?pNmNZ/y+7mb/izWyd5L9q77TMwdsuIsN2t5UJlmMD50Gfukk+gC7b7T/ejZP?=
 =?us-ascii?Q?Hl1dOK/AncTdNSaiegrjc1RqwLYUR7zjsFoDK+6kJ/W+70n13eI1UBekh8rD?=
 =?us-ascii?Q?7pVVZhM/Iw/ng1IgANrY9f2jxz8XNHUQvUS/wagTmy0WqGA4A2f4udhNqldD?=
 =?us-ascii?Q?IGwxSgt8VFNs/YUyPSx8/Z4iBv7gqPrLIC0l9fuCUFIZ8suoZHop/cpWnH12?=
 =?us-ascii?Q?9L3TOAilYN2a3bkbodH5R72vx6PA0E0yQ1AfRGjLRXjt53izR3xDCOWd8Z9G?=
 =?us-ascii?Q?OMXqERVeKNnozQAJc9su0AG9NbbqDbZaAlFbRXaJ4E7g/VL+x16E/8DWJhzt?=
 =?us-ascii?Q?dNfAEuTOagGtoZTUN2jvWXVa+4tC5Zg3t1hk1lbKaHrsouckbIWo4K2zdYn8?=
 =?us-ascii?Q?0vgPd42WfT/NQT8fJ1aZfarb7xQ6zjGgebZkHYVLmLcNdtuThtsJzyJLKl9Z?=
 =?us-ascii?Q?7sPxPbi9u11Jh7VHjTo7lvLfsT/o6hT6C6Yt4OcgdGmzWx9EnfC0BdYUxxjn?=
 =?us-ascii?Q?BNR/9e24gKNsYlfYGGILWZCmtOo0MimUrm9kTSpjl/8moiunRJGhacRYQLEQ?=
 =?us-ascii?Q?Ti5czPp8iyax8ynk4SQktx3kCE8vTnF97cifyRHHbPi99Q/8zteR0OKwEOv+?=
 =?us-ascii?Q?Ty46mKThBg/207TibOYEJykDsE+sC96yxWjBnkEm8cpFuBDH8bUVr72v1e+o?=
 =?us-ascii?Q?haE3yNHjtDuQ0sSe3+DhY1hJvB59KO1dcspXQxmP8Ybpf+DyBJDZTK5ThYSF?=
 =?us-ascii?Q?ah8dXQzF1Nj+menLZ/pbnxt7aHMGlJeJ+5LvdsVrcyEvQOvvHum+AjHOvLE9?=
 =?us-ascii?Q?j8o/LRt1wW5z6nD/Dp0jytoTClLrEy3s9Muqcn2nV3OlJqsP4+eYX4+l6CDv?=
 =?us-ascii?Q?2njkMBSnavRkMPbell6Tkr4dRlG8ab7Ho9Ue3pHxDOFrn0HWNW0ZjqKritIv?=
 =?us-ascii?Q?o85zntJKbULG+mXHrEghDz6udfR0vyLL9o6uxBpUAldUzIa7nJOXfE51Ssr/?=
 =?us-ascii?Q?n8c1HmuLTR6OJPTdZMgjtRsnTzkUqDT8qkAel7bNNNmG4Ku6MpUMuRU/8Z11?=
 =?us-ascii?Q?HqC+qWkgVyZ/HWR7Wxb9hFDwu7SrQbrIbtHS83T9PQ3bitVZFTJhvFf8AtIV?=
 =?us-ascii?Q?drUBvW3ytGc4rRofSk5GWYVaEgKE+dnexzA/dBawRvc/4Fq6ay5jHF+8lZzX?=
 =?us-ascii?Q?ZriMte47KQEZJvUWtHP7UAlOtlAFh+2myeXSnloMRLUpT3uVGGrghi3vvwkL?=
 =?us-ascii?Q?a9t4hYxsJYX+ZbbxxuJ3Lt1UzKPPxgCq0UniD7Gv70dUJZYSaiIsKHq7vqsy?=
 =?us-ascii?Q?0zvn8s1vcJwiw0kkGl0=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?vr4VBZbDlSaDsENeaUYgghV83Weui3ZWSYojzf7UysecpjHLZacbThSg9WmF?=
 =?us-ascii?Q?GJF3u8+9JjtS2rqc8Ay6Vx0xW7Zvns8DxvK5PbK31hr7WDOnypKaFBsSDT2U?=
 =?us-ascii?Q?tOJUMwota6YYNTPtg2QCEzyT2tm195gqEnhqp3c+YrHRMEYsqUOgp1NFBNAV?=
 =?us-ascii?Q?q1bXutj967QWNarWF8nTnmdMNgS3sf4nWqtN8nnUKJnIDE+N1jZHKvh/t69d?=
 =?us-ascii?Q?zz/x9D9RRLp2H2gwmHJ+u5osvOlgJEEO/yxpGW+AggJNeS9+H7nAP1SpRAJ8?=
 =?us-ascii?Q?Qi8n9j6qysS8v3DXggWgq3jQFQMAwVaXVJ92A4GoilJjGNHmn0qB+2QtlHxK?=
 =?us-ascii?Q?wxzUuieXsoZNQCwIq+wab8C1w0GX9q7FjEpbLrWDr5zlzdYsf4h4S3z3D/p9?=
 =?us-ascii?Q?eQHuLt41A4OkTwnJUEKDaNNwO5hxMLAlWpWWQjKWHoItKMCPJgXz9Cselsr5?=
 =?us-ascii?Q?zuKJl+qIXYuZ3MArSumhi0bJWxgzmbPAnc7b9cKeWMrzQZ1JLrYgkwVyFyXy?=
 =?us-ascii?Q?2Bk1ICpgWHqJeUZizvHZdeqkhDv0m2DV03HZku0TDN2/7bJF7xuO3/y0ypZD?=
 =?us-ascii?Q?wzoHJsxCwvbSgghclZE6jk7VfXGSkqbmNIZyser6rzSnfPPmbBo4nezNiRh2?=
 =?us-ascii?Q?P5Rr9nv9pDURYFa9ZD0KyD40GsFs2iQ4hmTfGIfkzahmljELX4EhnDIr4i8P?=
 =?us-ascii?Q?UBs3EnA4zoH831Pk2Q4r+nc6+Elvv4O93T0+P+cHNGmx4DXcnA9XslIs5KGP?=
 =?us-ascii?Q?4sJtdIUz+R6qpj7dCErs81l52Wr+F698LfZ3Ddl8o6LRXHbGLc5uJFGmSJOm?=
 =?us-ascii?Q?6zFeMVWN/ofpQ/mP1OYVd6mIKY//tymfvz3olKSn/zk1X+bbrczDZL8Rm44X?=
 =?us-ascii?Q?K7rydf523aSHMA+0LECzik2vvZHof4CstJXUgqfpVWR2pHv4JIgwgz/bXFwC?=
 =?us-ascii?Q?9PmQdGRoHV7xUtsC7ycHZQYd6yuL3YhXEcMM6ooY3KKV2EUnWVS98BiUcDVe?=
 =?us-ascii?Q?TtxXp1D33yaVic+SaSqOgs07ezMfcBlHqQQ8+CSQDN8m3vtQdeti7azLQ1x0?=
 =?us-ascii?Q?+IJIprQWc3XfSVEY9fcZUxjNcyer2v+bIJ9+3e2xoRteSZo7B/pZ5vpVG6qc?=
 =?us-ascii?Q?/drxHUSDvnGCloS3h/4WlU2Rv1zW0Iir3WHrVzU8eO0mX1xqSgtSbiV8HUv3?=
 =?us-ascii?Q?7O9DuxnHHtbhv9ufKfGFCk4T3Gnp0fs0eI1OMLZvl5MO56z5f9ikKyWRF9T7?=
 =?us-ascii?Q?X0MKfrn8z6nN9q29jGrIc3SFqpK/jp4+jXnR4Yp2M+FgZmNI5sKKZw8nGW/U?=
 =?us-ascii?Q?Cs2i925mJrKQRqNAMieOo2ACvU0Om+t74eSJvPWUx53Rkt0oTipCbIKSlIhv?=
 =?us-ascii?Q?6QREYWPpkyTVcPNe7szBOg3YjJm+ckg0ZsfgXsukJU6KJa6uVOMOF6gUs/Sg?=
 =?us-ascii?Q?37D79fXz20fKUTaKhFE6yyZ06nbMlp/hupVIvEYTveI5czmGsA4S78PfFWlm?=
 =?us-ascii?Q?BcBLzzKd0VZtNZXXpeA3LAvPiAqndNjo9j3B8ogbjXaHXMPc/IePlqDXHL2Z?=
 =?us-ascii?Q?9pBkmVNR5awRTM1Sge5bM5mWnnIq3oAbVQ13B9lqjOcaMbZ02iz7YzSDAQtx?=
 =?us-ascii?Q?0MkgNHAAyNQnQX7RqoslSob9jL0GqmySef/OkRcYvhv+RIcZ9JNdInba7KDn?=
 =?us-ascii?Q?v0fw6ZNUtni58Z4OQQXQZYuZgdk5F1tdEeXfWI3M8b+6rLwH2T1vCXDWLb0N?=
 =?us-ascii?Q?ivxkpdEASw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0449a49c-c2e9-459f-4eb6-08de73ec4039
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 21:32:46.6596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: enntLiRizl8ZrLHOjk7vQDjJGi6+tClLOfn/ijUcqa0mxDhyUcIfz+fOsfaTW4NasNrVb8GGkAkbubSB0gaPHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9467
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 24 Feb 2026 21:32:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21927

On 24.02.26 19:39, Stephen Ecker wrote:
> Has anyone been able to apply the patches for the i915 module in 6.12
> with RT?=C2=A0 It was working ok in 6.11 when it RT was still an out-of-t=
ree
> patch

You can pick them up from
https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git/log/=
?h=3Dv6.12-rt-rebase,
they should apply.

But CIP decided to maintain only a single tree with 6.12, and that means
that we can only accept backports from newer kernels. Unfortunately, the
i915 patches are still not ready for being proposed upstream. I'm not
into their details, you may ask for more details on the linux-rt-users list=
.

Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center


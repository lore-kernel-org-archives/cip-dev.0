Return-Path: <michael.adler@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73003C021B8
	for <webhook@archiver.kernel.org>; Tue, 25 Feb 2025 09:34:50 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.60])
 by mx.groups.io with SMTP id smtpd.web10.4406.1740476082171329515
 for <cip-dev@lists.cip-project.org>;
 Tue, 25 Feb 2025 01:34:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=WPPL9WlT;
 spf=pass (domain: siemens.com, ip: 40.107.21.60, mailfrom: michael.adler@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D/xLxVkxvV/UJb0WrOp7Oe+9vy8MUmIjayHtqyt2A38WBPiJY8m/HxzkbRJeWKCzNiltltqOSPH+GHN5BLFl0McBI8J+WJMyNQJZwo7w1nM/442p+1KueDG5LaWkv/PERonuGbOCbURLpJQFqP5DUwmaQuaKH9LXB5VltiwnZpGMu2aC8mCSJZls/TKrB3PjkMJyrpMrjggwLT3n8LLhwgfmX+piv505ytIYvCAp/a2IkI42vinVpBe8mFtsOqBx9qC6m2vaap9IvaVrd3XCU4WGyj+iQQpO75gy089E0ps+qpNKXDglQcbf5clYmN0yi2eawHbkYy/bFJY3f7f1aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K7zLSADMqrpcWdfGUmdzHTfUzd49D152jFUELccvx9A=;
 b=Wtzvht3z51nnZqJDfaPQqGtQ83+pWQpEq9H7BUfecEXpj8bhs7E7j+WoM+0Y6o6OPLm4ImE9SFlsA4qTD7WQqHZf/RKM//A7g6EIbltBBtNBCXHvJOD8iG/7MaGxvDaneueaMfVkDCPd6tNYqRHXYY1EpvneC7IJPtlLfySJVwjV3XOpp8l6WVXSlQs1R1v2rwCrdVHH1gAwfnIACpgAOB+TkMOSbVEIbGB9ahdBWV9NS2ppFHhsN8GDtf1JOSASquuGXJBwK8WVUdyxeAF/vhvv3yAAFjNCrLXM4PRYu00BnTea3rCfImIAz1ZlHM2Q1xMikYNF9uMUDk1NRvi1fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K7zLSADMqrpcWdfGUmdzHTfUzd49D152jFUELccvx9A=;
 b=WPPL9WlTi35dKQpyV6SW0WcYglnIC4oLkuqmOvZJzUZBEHwzDs2MmLkVd49jBpa49joWNGAEA4xOdUXnplIn4yVOv5gWohz6LWGERx20Jh3detDmBcpy5m0N4pcGWoiqPpYVcmwFSJxGMPqqsrIwA+nGC81A3M+YkjtAWsjswi9gxD2eMSBqg59D8qMVk2uxIucRDqG7lexxnBbTrNcAsqzACohhefFMOicL89VGCiBvk1BkGpPj4nV4nN6nKue8DSOTh9FZWW2DuMSOo5jd3KSDFgASTREb95ccTDkZIAAK6j+KS5E9pvJlLTYY7PsWUfz84JWTNbI1nhXLxB1BEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by DU0PR10MB7118.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:42d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Tue, 25 Feb
 2025 09:34:36 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7499:8576:c129:4b89]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7499:8576:c129:4b89%5]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 09:34:36 +0000
Date: Tue, 25 Feb 2025 09:55:22 +0100
From: Michael Adler <michael.adler@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: christian.storm@siemens.com, dinesh.kumar@toshiba-tsip.com, 
	Shivanand.Kunijadar@toshiba-tsip.com, Sai.Sathujoda@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp, 
	jan.kiszka@siemens.com, koshiro1.onuki@toshiba.co.jp
Subject: Re: [cip-dev] Regarding support for WFX backend for software updates
 in CIP Images
Message-ID: <3lsy2jedcdwosdv6kfdykjadid44hnxcef3jqkqyhlgwydiqwk@i2iqb7hd2pfi>
References: <5A591B53-A5CA-4F84-B055-1C9843037F36@siemens.com>
 <TYCPR01MB9669FD137BC7D188F1D7558EC41A2@TYCPR01MB9669.jpnprd01.prod.outlook.com>
 <0D555EDC-271E-4EAE-A67B-7A02D9CF021B@siemens.com>
 <TYCPR01MB966913481F3B849D736C277BC4E72@TYCPR01MB9669.jpnprd01.prod.outlook.com>
 <2DD2AE26-2C5E-4E33-8832-9B402C9F7C4A@siemens.com>
 <TYCPR01MB9669C7FCF2D0CAE6A4492DE3C4E62@TYCPR01MB9669.jpnprd01.prod.outlook.com>
 <EBB0F642-B8AC-4E50-BEE7-8459AD267118@siemens.com>
 <TYCPR01MB9669A771E067BAC3460FC708C4E32@TYCPR01MB9669.jpnprd01.prod.outlook.com>
 <228C2800-9DB8-4708-A0BD-1AA393187323@siemens.com>
 <TYCPR01MB9669234D93FE29A364E394F5C4FA2@TYCPR01MB9669.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYCPR01MB9669234D93FE29A364E394F5C4FA2@TYCPR01MB9669.jpnprd01.prod.outlook.com>
X-ClientProxiedBy: FR3P281CA0064.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::12) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB4734:EE_|DU0PR10MB7118:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cfab443-bb22-43c0-377c-08dd557f9e47
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Ko/Ek6sAoQuQVKeM8vg/+Vq2PbE8lXcB+shggEEgd4BPm7qtcSXh3Zfbdo26?=
 =?us-ascii?Q?iEWHu7+qAlYvBn9EuTJ086M+XVt9H7MrvUo9pjaNG5q2VFN7WdVN0tyTk7OR?=
 =?us-ascii?Q?ICRXHz07vVs9HFwOYKhiTJOChOqCFBxFc4oYzmS/46kqIFTpF19ZCyewOPOn?=
 =?us-ascii?Q?JxyBFdXc/J7dFvJelPtyOo8Jgci/JKbt4aSq9WGN3bPww4sUbot+z48g7YUK?=
 =?us-ascii?Q?Wu+jAMUGGfctjXDxoJgYz1tO1GJpiMDfS9HP3PYREKlefSahHPxzY52jdPxk?=
 =?us-ascii?Q?AxgOvOR68juI2oclmDvvZbYpX1MCohO9wnRbk79sup8ZenswcNKxXEW2rIsO?=
 =?us-ascii?Q?w0mI+m1tw6zY/gQ1ThS62MThkS84F1llh4KNk/UN4ype3Z7+4GNnRF3hPExJ?=
 =?us-ascii?Q?klN/hyGwcBAUVGMlb3wxn7rVquLG7FO+AV/oQdeWzguNkngz88uL7aIhPc/5?=
 =?us-ascii?Q?ZrfI2+z+JZcfjIEOjEpw2XDLcXLGUq26FdbNHIKy60YqmtbsNmZw2ltKw52w?=
 =?us-ascii?Q?FBSigUgr3L2inh+v8kvqd7vHYYTfLmhcgyDdqqHrFmVc125D+eg/na6UdSFz?=
 =?us-ascii?Q?AL3+NeO5I2e1TbZoV6KF35GbWj09t1ihf60wlQmZu2+9rf95KW4P43XDONhQ?=
 =?us-ascii?Q?wEXUkIh3r8yu+3goGbXLWUWeVVFcL15DXAhHCNrpgkSO1XQVCP7CwtIuyeIP?=
 =?us-ascii?Q?2o3zF9xCFVrhIbExWC0EIdjdWCsWP3MiiKSZ7Qu/1N3XxJ/E8mYnaq0YW+ro?=
 =?us-ascii?Q?f/Q8OKtH/DWjxwqVi6bQppFHMFEXVq/xnXmFrCIV6n7UxOhKiOAkHmrEhIJZ?=
 =?us-ascii?Q?JaPhOSgrgz/lJEnn6vYUCGqTTYVYtdnE2XVHB8GVSMcPeqXslA8qO0pmLGT9?=
 =?us-ascii?Q?R8wj3pHWtf6rHtM7TckzlbQmuFt/Nzew/Q5SHShJL9JYVBmT8XSGf5Vq3ShV?=
 =?us-ascii?Q?2El9N2mmD9uFh2wSRjugS6rWyb1CKSIuQOFwdKZc1qq7fVxahsPaRFjecVNs?=
 =?us-ascii?Q?JcNPLbgKj+bcE6a0TcbFpn+1+eaBDwiN3qnXnG9JJMGJhJ/9iaEnLoJwWshy?=
 =?us-ascii?Q?ViQW8uomtVYmrVrnGWvSzcQhKUGiwO8K+Xf0douj4Of5OnZ41oavHU8QopU8?=
 =?us-ascii?Q?vAReU/YRMJy8qLHBHQu5AK8xmazaOMukESoNbDrk9+D4JeKfO/gKsAX9Hvpp?=
 =?us-ascii?Q?5GGkbilpO1WSEokHMyjbm3Nf6m05V5Ko9kuR5pGcPsYKC3/ZmKLMVRBfYFrb?=
 =?us-ascii?Q?YR1JDKoJFOROUNIZ7uiU8ifgWL6LK6zLWl7yk7GbicROe/z6zKFC1v0APot3?=
 =?us-ascii?Q?kKSJiLGLsTx96cjYHcdnY+4yg4WC+3tswRhPpyeTCCWrXt5ZY2JSZ3k/uzB1?=
 =?us-ascii?Q?dah7QybeJLKp9GOt7yIlzu27TA4n?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?65ZXO3gyhb1TFVknuYvvH0E05nQdFX0GjVnSczvVVrMqSu0lA8IqOD5jS8re?=
 =?us-ascii?Q?uiMZWWzQRVVwvjCg+3hiyYCqsbarU5GjwYjq8/2ZIBywygUi4bW/iShhWfR4?=
 =?us-ascii?Q?492RWRPcjcuDka1GUEvTbWXCRBx9x44A46jHgSp8BoUraJKvkUFCXvzhzSBd?=
 =?us-ascii?Q?8XnisZ9GsOa38iRlWy1IJLnC/2OAD5LKBajhccgaxIZFW8gS0l91YM6TuAgr?=
 =?us-ascii?Q?rJGMCJ/YajSxicPSmNCDTDZuha2vkC7cEvx1WJU+81xUd2MdL3fEOGWnRvAx?=
 =?us-ascii?Q?g2EYbxaJKT2awb0dyGDj1Lswk4DdIsVX019bvLig3v723RN+CnWUmXdIKob4?=
 =?us-ascii?Q?qVH1B+BzYyua0yVsVBoeIITwfXpdAbtd4Sk+XEd2uJlUbX/0FTsVSgpaDVak?=
 =?us-ascii?Q?mtthXOjwtEKqJxybppedejIVKWd+3CFj6TZQ955pqk2nOA+W6nWfzekMwU5k?=
 =?us-ascii?Q?5AwrWNQYtvmOt0T0WlwbPIIC+vjwWTNHdZAjPTnKtQ5PJPcNhNzpH/57YeWn?=
 =?us-ascii?Q?DhnQJPeMW+oYk5kaezsXXJCNadBMjs2EepWgqeweDGVfpMFaCGCE4IV+tYMf?=
 =?us-ascii?Q?JWcRhIXsrrfbXmqqD8aVxYkbH1NLOxjgwz37trkaz7QbBnApILPwP+n2eohC?=
 =?us-ascii?Q?AnhbqbPVVfeEFeT/LdFcYkhaMU8Ta0oVfnC0JO5LPsl9IdZ42ur52pqp6q+A?=
 =?us-ascii?Q?h8edgwjRlTwvHV1CdQbUVw/BYf/Sc0Lxtxc9mztlmb6pe6VcYyx4kh1tcpY+?=
 =?us-ascii?Q?bobUY5myD9zNDXS8OOahYzuNvzkLlZpyxxt1TWzpafLlDDNhObFCd11xbIZT?=
 =?us-ascii?Q?11aGBTbqih2KTXZKsjKnQRupk5Oz7PXzKYTVZAaRTvCNfejJIOWZP9xjAylV?=
 =?us-ascii?Q?+IPUYjoqE9YHtevFKSpX0daCaFOfKLhScg7PZpTM9rRKWO+c7h1I59uLjv8H?=
 =?us-ascii?Q?Zh48dAAcQ8y2QrE4oA9R9oVnYzK9+JBneT2TVtd2TvN3HhDOp4/lg3yOr0Ec?=
 =?us-ascii?Q?4eu3DIBuaXI54U1pUnT9ze8xoFDs3vfh78zIlG02vJRoURzFUCLlHHYGw3Ic?=
 =?us-ascii?Q?vFUOByakZFAHUYP+4J4t92y6+hnjmeiqLPl6H9p8oLHNexPOPKelJgwaBch1?=
 =?us-ascii?Q?QHiUmwTo74adC8HR3KiFUKA+SfDuxyr0dNsO/ktwLdtfDw29Lbl83b241vkA?=
 =?us-ascii?Q?Jwkuk3v5J5Q6QiYhIdMnumQVDmKJiQfGhq73p/HI3SU4JDitdkydhg9nYHUx?=
 =?us-ascii?Q?2ODy+MDUIz6iJiLCg6Pez520H3ffhQ+Ixynci92j8qor2IdrAi8i5qzGs5rf?=
 =?us-ascii?Q?WRZOphz+kXeST+luKpC9TbYTZ9C/xLdzQyR3RjebHxQSs+KlTpnk9OfSpTbF?=
 =?us-ascii?Q?iZoK/rL4Z0glClgDweZaFAVSIsIKh7aKkv1qRhTvk8pimnxLf0uGHJ1C6s5V?=
 =?us-ascii?Q?9nTcnWiLIw4aBB69Uv68YJc93hPE1OwYrqHPcIBixSUzbjVrUft/TZ62JN9W?=
 =?us-ascii?Q?HkP7+5k5o7OCEvA1LSvBN5calJmzEruSc2rg5kg7oU87QjhyUzM3zV1oa0xA?=
 =?us-ascii?Q?acRJEQgeKQ4eWNUmfyuCwEElj3PYrJ91b4U156EJRVhyzEROqvaqmFja8RFC?=
 =?us-ascii?Q?3A=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cfab443-bb22-43c0-377c-08dd557f9e47
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 09:34:36.2713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EI8fyGBcFKonRp3rZ81MII+W6jQLZD6cGNUQD0OqM7oq4VU4w5RUkRJocgO1aB5InhgqepzBgKwIEyUKuqmNHa3FN3nVhUZJi1YC8ZyiHlA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7118
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 25 Feb 2025 09:34:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17906

Hi Adithya,

> Please have a look at the implementation when you get some time. Would like your feedback on the implementation.

I hope you don't mind me sharing some feedback as well :)

- By convention, custom HTTP headers should start with "X-". However, consider removing these headers, as proxies might strip them. This would require a slightly different approach for generating the clientID.
- The onboarding client seems more complex than necessary. It looks like you reached a similar conclusion when you started using external processes (like sed) for tasks that should be handled in Go. A simple Bash script invoking wfxctl might be more appropriate and result in fewer lines of code.

General remark:

Upon reviewing your architectural diagram, I wonder if using a plugin is the best approach. The diagram is slightly misleading, as the plugin sits behind wfx. Requests from the client always reach wfx first before reaching the plugin. It seems you actually envisioned an additional (micro)service that communicates with wfx to create the onboarding job. Ultimately, it comes down to whether you want one service (wfx) or two services.

My perspective:

- If you can significantly benefit from code reuse on the client side, such as leveraging the existing SWUpdate wfx binding without having to write any new code, then opting for the plugin approach is fine.
- Otherwise, if writing extensive onboarding-client code is necessary (as in your PoC), I think a cleaner solution is to implement an additional microservice in the backend.

Best regards,
Michael

-- 
Michael Adler

Siemens AG
Technology
Connectivity & Edge
Open Source Embedded Systems
FT RPD CED OES-DE
Friedrich-Ludwig-Bauer-Str. 3
85748 Garching, Germany

Siemens Aktiengesellschaft: Chairman of the Supervisory Board: Jim Hagemann
Snabe; Managing Board: Roland Busch, Chairman, President and Chief Executive
Officer; Cedrik Neike, Matthias Rebellius, Ralf P. Thomas, Judith Wiese;
Registered offices: Berlin and Munich, Germany; Commercial registries:
Berlin-Charlottenburg, HRB 12300, Munich, HRB 6684; WEEE-Reg.-No. DE 23691322


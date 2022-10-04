Return-Path: <michael.adler@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD2AC433F5
	for <webhook@archiver.kernel.org>; Tue,  4 Oct 2022 07:53:26 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (EUR01-VE1-obe.outbound.protection.outlook.com [40.107.14.40])
 by mx.groups.io with SMTP id smtpd.web11.8132.1664869993032153114
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Oct 2022 00:53:14 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com
 header.s=selector2 header.b=nv4d4ejH;
 spf=pass (domain: siemens.com, ip: 40.107.14.40,
 mailfrom: michael.adler@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EGTwULaAW0pyiyQEJHVA4gXwhU7ouJkzi2dklOonLCnEHUYerv3mzIn0pQhtQspM3JExJDpc8r9hfG7+HXemKFG4BTSxSMCLsL+DUDpjzlyCvyOZEjtBbZr6+kofGxCcP8415lRYXXQwFzH1Ynvkk6YsQDHcXfjdJ3/do+NtFLJOv56WBhy+GskwozSOPKKWXqQIYkVvz2Rywx6r16VTmet+bh30ZKqB3hE7IO8y8cvv07YvFzgBINwk+dkhn9C4IGKxRDA5we0H0mM7Y4+fz+8K8YIDgQUQ7Ni8CxKqeeOol9d68r/mN2RlX1iLii3I3eL/GUPSuhAYNs48crqtQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gY68iHpje9lSaDhH+jd8r6OBdkr774zQBaIpLO35oS4=;
 b=I2UczPmAx0x+ioL12pOA+ABKuk0ANMWULfQ04e5qNG5c3jo/TjKFzO8eytu9dm5pwZ/7MPQwR+HKtS9eZnOE2V527uvpZb//iosOecYu1PKjUyliepqSJ3/TumcsRO/SZiFXYW/fQ7FwtxTCSRTH92hcx9ldea0VFVM8sD/sx9FOQukc74Vpf0LlBw4/IVXYz0qH74goiEjhhPV7pWcx8kvx8uB7MpcmcG/sN7172WueDc61gAqMhaPmzFQlCR7ZGqBE8Rw0NycA8DdlMnj2zeFI5CRgH8IhLy2QEl84wyulg+gbA1/PP3LdI+imW3lEyDUNPG/IyxSReB4Fts/l5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gY68iHpje9lSaDhH+jd8r6OBdkr774zQBaIpLO35oS4=;
 b=nv4d4ejHq4cF4fNhHbaWLhMhSJu4zxGNMJKHpGRPs9Zo8nYYut4bZGOxGF+HqR3VxRFWC3AAvED7T38oAkuppx4VIjkhe3veI6tHf6V/D+HxQxdFjUR377YpHMo40++Jhc4ZYdr0avmMBhRHgbu04bpHTHdEayBazogoU2JyVQntZuLd3mZGl5AWMUMXmR7xmp4mui1irCrtH3YGW6XiIeLf2ev7ntu85JNPFfkJlbOGPYhlw+pGbVCBGmL/O07Hx9gs9rAqXcxEfGYe8Lnr/HYRMolxaiB+YFRzmJffMhbrOKB7LFvvD7tl/ohYRWJOlAmmw67C5GSloIkMa94uRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by AM7PR10MB3793.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:176::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Tue, 4 Oct
 2022 07:53:09 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ac6b:22b8:6b19:8ce3]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ac6b:22b8:6b19:8ce3%6]) with mapi id 15.20.5676.023; Tue, 4 Oct 2022
 07:53:09 +0000
Date: Tue, 4 Oct 2022 09:53:01 +0200
From: Michael Adler <michael.adler@siemens.com>
To: Chris Paterson <Chris.Paterson2@renesas.com>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	Pavel Machek <pavel@denx.de>,
	"alice.ferrazzi@miraclelinux.com" <alice.ferrazzi@miraclelinux.com>
Subject: Re: [cip-dev] gitlab test failures -- job failed ... pods not found
Message-ID: <20221004075301.etgur4dyb5dtrcct@backstein>
References: <20220930105048.GA19081@duo.ucw.cz>
 <1719A05389EC9CB2.16804@lists.cip-project.org>
 <TYCPR01MB105888A4C268DD3DE0F5481C9B7569@TYCPR01MB10588.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: 
 <TYCPR01MB105888A4C268DD3DE0F5481C9B7569@TYCPR01MB10588.jpnprd01.prod.outlook.com>
X-ClientProxiedBy: AS9PR04CA0160.eurprd04.prod.outlook.com
 (2603:10a6:20b:530::28) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB4734:EE_|AM7PR10MB3793:EE_
X-MS-Office365-Filtering-Correlation-Id: 3379deb0-8dfc-4112-f09a-08daa5dd7a9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	unv0kJpyYq0LM7sytGHl3DLPFRlY9Go06hbwvcaA37mtrau6Z43RXg//UAUuubYT6WEdEa/4oxis7tGyMSr5n041EwqF93F+syQy/f6Lxshf7BWK/EK6UrD5UZ1gDfV5k8GGBhSbAkp+if3MsF6lDhSlgKRCPBno1iQ5Qi5W5t5da7rw3hmXbxwJqo4jaXYmYHOgP0RDSH1Mx9CLRxmi3I8ePeRjR6bMI15gFWux7JpXOa3Olga3+Ub3OIsnQWPQprGf5wbaNsAbl6glklExdlET+KB9FkBf2ZMYZ/k5vsb0A5b7cTgaDTmDzs7WURmjtIxfsHF9rjUbbIYp6lNmVu0UW1poYSngyYjPYMzBQXg6KnLobztW440yA8l2BMpoJjWt2ogsEn1iGA8Xjmuj/dHA+l1r38eXCH/dlrxiockQk9zqRKKrjiRvnW9KXu7Md3FU1VTR3MnjZRORkOfMdEBbAXRlq9tc+GuEzYIYzU6F2I5HgR5suqprhaIMshcwuiJKHHGR+jmj53UGRM5SjfzAZ0h1/5+eVIebklR2Z8QVms93CcGKERgIE+nCiAJID5qI5ezYWtntmvCThfLWWNQ2FMUtZBLFMoX2u8/6ZbBstL3h7H7T1QKTvruGneHKcZ5mmT7cb7Py22AdFhoy5M4f0+an+UkuZIGmwO+0pN1eN0qm+8mWBZTJlhReXtA6oOyf/OO7Z1hvQCRrlEQmQA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(366004)(376002)(346002)(396003)(39860400002)(136003)(451199015)(6486002)(478600001)(316002)(33716001)(8936002)(1076003)(186003)(5660300002)(2906002)(66556008)(66946007)(4326008)(66476007)(6666004)(6506007)(66574015)(26005)(54906003)(6512007)(9686003)(8676002)(6916009)(38100700002)(4744005)(44832011)(82960400001)(86362001)(83380400001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?3tkzqYLt88dIh9OCiNhn+RSrgdQrwTJuzsznuFGWswBT302Na0rAn+qMSgbm?=
 =?us-ascii?Q?70/wKbvv5OUoWbVgBlQjUXBFh4j9g646egSbd9Vf0VLk/m1J7xFv1HJifoWu?=
 =?us-ascii?Q?2cQdf8/XQxp8xqZoaNsgpqvDikP4RVZKmFnHIHfdxAS6tzU4IH6qg7RJyq2f?=
 =?us-ascii?Q?kTrz8nSugPWDp0xqaQvYp/cnKyTzeoEA7htmP9BypyRnbDaZ3srbtPqoQfDU?=
 =?us-ascii?Q?ETOSEwoCP4ZVGsn5kTGRVyqT8BVyv67nsp6LU8SY0qobzrNzCtjQUHcakxWO?=
 =?us-ascii?Q?xqwWtdC1RZqMBNWcBysgMRIeFyApTDlay/atRrq7xUQs5kstE6KFKTjrUTNw?=
 =?us-ascii?Q?g+mIrxa7zH8ndiOA6X6QBiuupycYdqX0er+an7GjHVwUX6q/psi0ZTito4P6?=
 =?us-ascii?Q?r1Ncx8jAlLrrkcRyRFv0gZ+KZIk5prwN1rUAuDhJnlMEcmcxsaB+49NfsmbL?=
 =?us-ascii?Q?6dpQrhft0cTXl87JdGfxDoYGuPJPEieH9F0Zihu1EPo7JJcEbGEA6oPlVv3r?=
 =?us-ascii?Q?sV5PuCM2ZeHJCwsuA/brzyC+erOVfnd/MLoG9WWq/nnPS+x2uc0y7yAXXCYU?=
 =?us-ascii?Q?7IG3i/UUo3UAeNi+dG33BfjPsosdZ8Gpyi7WybPHoKYOf1UzLayFRXWy60dA?=
 =?us-ascii?Q?iAPznM4Fvq+NY07O+RWiKY7/nicnC5zXqPmLNlbH/Cq12bkxWD5YFtVLs3nW?=
 =?us-ascii?Q?mJUkIUJXmiisl2oxfRA5R7Ohi7TP/CqFo90RAJmWY1QUcgcW+AOpJluuaC90?=
 =?us-ascii?Q?t3JFY/+j5PZ+UTjZg9jhhXjAU43icCfo1+ioisJyaADN6l0UcwfIiHhwn7xL?=
 =?us-ascii?Q?eBRrC3BoGpRUszUGGyGcRJGkV/bBGX2Jjs1EvfIe9uuthEVRsbiwyUJ8O4Xv?=
 =?us-ascii?Q?DzqyRMHGvWgO+PCOtBxfAFAJffuBwgpfWxA5aln3zBHLc4NXuM1prvsjkoZu?=
 =?us-ascii?Q?6l0sR1j5lyyYEMWSvIBwoDRBV9SZ8BRBayFAAmX7r9wGbqc2n7h52VjH8TL2?=
 =?us-ascii?Q?9PUgJ4vxJ/qOUiER35TOS745zqgkXLCoR/4TARRrKFtublMsrdH72YoSpEeO?=
 =?us-ascii?Q?74q9MgMcGTM3/VKmKjCbQ78JS4OwAXmZJKmziGipLo2GyYjaYi7FQxX+uGLx?=
 =?us-ascii?Q?jsFjngwwXFJOyKfMgYNkjDwFLC3G4xRrbUKK6bQqabEph5yvfjp9uRrX48E6?=
 =?us-ascii?Q?Fe8ZD1rBluSNF1gWTk0/E1PIk7myK0x3Cg16l+CCWzWjc5VcZRmrrFB/te/X?=
 =?us-ascii?Q?VgBP3ubxhDZ/d7hI5JHbNLPAC2FvI/hahg3c70VWz2JNjZo8Y/8djrbViMvs?=
 =?us-ascii?Q?XcOkueDKeHiNACLyPJI4fXkgrHmp2L1A0kf3EIkSmEyq36GIMw7le1rRatlx?=
 =?us-ascii?Q?2d4mS/Anxm2YLLgCpKENe1yst96zGSiN56hUhV7UjibmhanonyGOCv9wLWSV?=
 =?us-ascii?Q?PUdeWAgAAoL3cpk6fzUrJ9f0jpoP9sqxF3XM0AJ/4Wu+YP7eWJV29ErNfqEb?=
 =?us-ascii?Q?+cvf+YCY2ZH0m/wh3+Qjubv1mBsxxZx//hVne+8Kselq+Gax8qPAUuQ+ZMW8?=
 =?us-ascii?Q?Y+VxYVvBrrEl1eCxtG8DxuIh44l1NHleJBkk8Fd2pNdXfUhc9ybswn6XLnL3?=
 =?us-ascii?Q?XQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 3379deb0-8dfc-4112-f09a-08daa5dd7a9f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2022 07:53:09.3283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 +smMQ9ukZFFicB8aTc1k4Ko740OXkoNO0ZNcP5jExjc0L3fSv6/Qsd4Qi0F/aT8/cWZsezHiNclRa9jZuO0DPx7DzU5IqRU7SEUVYQNfxHA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3793
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Oct 2022 07:53:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9620

Hi all,

> > @Adler, Michael, could you take a look when you get a chance? Could thi=
s be
> > caused by the recent upgrade?

not sure. For now, I have downgraded the Gitlab runner to the previous vers=
ion. Please try again and let me know how
that works out.

Kind Regards,
  Michael

--=20
Michael Adler

Siemens AG
T CED SES-DE
Otto-Hahn-Ring 6
81739 M=FCnchen, Deutschland

Siemens Aktiengesellschaft: Vorsitzender des Aufsichtsrats: Jim Hagemann Sn=
abe; Vorstand: Roland Busch, Vorsitzender; Klaus Helmrich, Cedrik Neike, Ma=
tthias Rebellius, Ralf P. Thomas, Judith Wiese; Sitz der Gesellschaft: Berl=
in und M=FCnchen, Deutschland; Registergericht: Berlin-Charlottenburg, HRB =
12300, M=FCnchen, HRB 6684; WEEE-Reg.-Nr. DE 23691322


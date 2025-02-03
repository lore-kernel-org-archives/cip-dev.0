Return-Path: <michael.adler@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFCB4C02192
	for <webhook@archiver.kernel.org>; Mon,  3 Feb 2025 16:37:00 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.75])
 by mx.groups.io with SMTP id smtpd.web11.92173.1738600616650401424
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Feb 2025 08:36:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=WXh/FKiZ;
 spf=pass (domain: siemens.com, ip: 40.107.22.75, mailfrom: michael.adler@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZLh4KFwP1UJWGivWG5YtOVPuG1LVsOJZiOy2/KSb81bKSmrv5j/XZsd8YJht0PNgmhezeZ3E8UKZ7wFAW2eeLW0+NTTaNFn8GS1LUrcZYhnqOWCAqan7pPUaEAb4Cic1OzV6eNQjdzXzI+mh7ENhQoZ/TH1wqlJZrQjb1BxFChZJOZcCLIpWesq+NhP7+QW8kqJ8Yxmf4j9Oz2MrFKN+j/WB+2RFhqkUlu/x+re1V2N6wo6W+fvtOeOcOFqfZO54xZxryNUnRHac53cyuiwGLTNLZfoNhhSUhhGZc3wL3sVjTuJ3zH6WGPoUHfuX2SaTzstU7Dw7BHihaB/hnyzUiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dJvREouHMzjubWJNz+RgLaerxJKX0qdlQTtH3U093vs=;
 b=m6B6dKpef4XUXjIRfwlvBiH5eUV5PPGofEX0JMDr9XTs9XB8rfqzIcng/PT2W32y3T4E8UVfkMVLmDccQgv8zJVCxLBgcaahXZ9sCn1X0rByNog41Tpy3ziSyLwFE6oQtyVfOhBpdwbkOsreY7P3QUKWEnd4TagIW3o2pZs8oG12MO1Pcwr3Aw0R+12LSaSOowSaDgosL0Y11e5b1rWtgrC3+AUzBnH5BmIBiiHWdtCKAJlIeEYITHIt/9OFOKqF3F7x2aAEAybf6Bkbn1NFEKuAkRSWnvdUfbwtkQplU04oEU8JO642FL3fNce5Vog4qOYFVKyf7vCZpN+LXZ7slQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJvREouHMzjubWJNz+RgLaerxJKX0qdlQTtH3U093vs=;
 b=WXh/FKiZFG0QiY1k1AI4Sjv8dNGl7bln2hGFaxXK/7vx2HWul36jtcC5gu+oH0kWG4lykcrCwXnC9CllYI9+M2z9iXyQIHJ4mSrptT5vY026cREgnLPENoZKschISW171Fp6HLvg1AixHDQKK4U09vSoGdk8prdtyUUU62s1t4K9KnWLEVDzpHWN8U4S15dco6xevm0E/wL8So0Fp5odzFn51tzxivtFNIpjpVtWltWxp67zixoxqLhTkRK3hVEtJxGZLpqQV34M7A2xLi43n7njMIynZpnxmCYhgtkFIZEJIPN7YqWj+J5C+87uPWFC2G+LTQx8WaYQz1wfgycXtw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by GV2PR10MB6936.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:e0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.9; Mon, 3 Feb
 2025 16:36:51 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7499:8576:c129:4b89]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7499:8576:c129:4b89%5]) with mapi id 15.20.8422.009; Mon, 3 Feb 2025
 16:36:51 +0000
Date: Mon, 3 Feb 2025 17:35:35 +0100
From: Michael Adler <michael.adler@siemens.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: felix.moessbauer@siemens.com, cip-dev@lists.cip-project.org
Subject: Re: [PATCH 0/1] linux-cip: add kernel config snippet for container
 compatibility
Message-ID: <v2syznc3irmucfpeqozsc3mvvsrnhhefx6sx7xojaqjmnswvxl@h5bfnlqcrzem>
References: <20250108100755.55673-1-michael.adler@siemens.com>
 <27230c907a5b0c43baada41fe3b49528b0d81eb3.camel@siemens.com>
 <OS0PR01MB638822A2AA063548128D1A8192E32@OS0PR01MB6388.jpnprd01.prod.outlook.com>
 <D7DLXLIXEJ2B.1FZ2QPQSTIG41@siemens.com>
 <OS0PR01MB6388D35A13069092EE62700292E92@OS0PR01MB6388.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OS0PR01MB6388D35A13069092EE62700292E92@OS0PR01MB6388.jpnprd01.prod.outlook.com>
X-ClientProxiedBy: FR4P281CA0133.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::14) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB4734:EE_|GV2PR10MB6936:EE_
X-MS-Office365-Filtering-Correlation-Id: b8b75049-00a0-41d1-7c30-08dd4470f604
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?LEdUgx5WLBTrP+YKNh2h3KB35EibOGPnyceN7/44vgm6z2XZlh3qjlwNk9uS?=
 =?us-ascii?Q?2yT4kE5ynqrRvImwpZA1y8YmhiItkKk8kXqe9OlHNV/iFYNlAmsid/BomCq/?=
 =?us-ascii?Q?GROvVlG2vJlSk89cG0SXP4V0lyNU0KusjlQWk9LwhWdKI5KvDjjB5y/n0Wx4?=
 =?us-ascii?Q?MmL4Fzm+pMon5LW0HvEw/ZThCExh/EYAEYxlFu+pEb+cEd8HCTQckY6BJf9i?=
 =?us-ascii?Q?zXMVRBHeh1R8si9RS9IeLSQRPZk2DBjKhBAC0y6PX0iru8QP5wN2X1cDQGNI?=
 =?us-ascii?Q?tx8EOabKMr4sdXb2RFL/dQoc53zYlw/ed8LzCk7JAM5H373XiYzUoB5A5Qui?=
 =?us-ascii?Q?yyvAW2SC+5r3xUPGEdIQV5IUBImn3yBhpHQq0cmxuh88bCBnPPnOl9CYLHNp?=
 =?us-ascii?Q?ceqAfbnG/KNCJbL7f7lmNDr1Lph/0jHF35gUWgtLz65gf/x9AyrmTUlFHMW6?=
 =?us-ascii?Q?3s3iP5g46+rwj9SRZIe9F0QiIPcxmTW9BuvAPZe6RB0iCBqal/vLkxVno3rL?=
 =?us-ascii?Q?RUuBwdmEBqhY2C6Jzin5fGFeIfdKzOTU5tc6lZBD2jT7nDWLBraXdEKSNNZu?=
 =?us-ascii?Q?i9RgBieTekLjz6nYdNaUXxbQqCEA7t3d4b8/FI58BQ0nQNOpq9+Yq+Xp/7Q1?=
 =?us-ascii?Q?tF1MONNhnofPWrY4t63OsgA9s5asaEwPK9rsLtEEa6bLJdvzHILZUvmB6GHI?=
 =?us-ascii?Q?SVPAeigpeMfNe6hKmy/WdfBdvEpWWEjsyUh+2EpiO5lF1YNqpRaBTl7qriKX?=
 =?us-ascii?Q?peKPSsbRaIF9W4AE7SeyxsciZq7ZEX9KkcEiTegnX+AfFi3hC+QMVhh3TG7/?=
 =?us-ascii?Q?S4vrDavULOKYahepHS0+/l0u8ZbYXCbHkdZj1j2VMvRqF0WWqCkh6PoexG1K?=
 =?us-ascii?Q?MStAJx0gZZaZt79kZo6JzZ9M0vVcoQ+wHfWAcgeRe/SjCyYyaAVj1sqL/eqj?=
 =?us-ascii?Q?kOJlLBJn3nBp4pENdLJSfIWYA5PR/g57kPo5v+IN30gc/vRhkrwEhZLFdBcR?=
 =?us-ascii?Q?iR+XLJrs5l3uZYKFCCZzRcRYCUNMKHQlktNZD4dTf+g1dRxgOpf58qydipNI?=
 =?us-ascii?Q?w0FFEvj1uBVjaJajsk08ARYGUwEKb89AD5GaphwVd5O5OGyUwZwSYRKfN3vY?=
 =?us-ascii?Q?6Y2EmfJl5ZLBs/j1jsCkLSAAqLvIj51yA9mqlf8m0i5xGxV8mIAcaDjt9amN?=
 =?us-ascii?Q?hRawAz2CJ3V7mUEvVKOEEkPxsySMeVRIsxTuHauKqptGkVeAxLCIZhKjMMzp?=
 =?us-ascii?Q?32zuNwfO6ArQhxckPcL4fueLKYk7HRkugvuMHGHRaxqyfzEb7zBQ3nT9qHFw?=
 =?us-ascii?Q?bVx048PyKc2HVtJFU7vt2ozBS/8d81oPqeaFA1FJgqdisezDscTJqmtupJen?=
 =?us-ascii?Q?i8Ln36C1DOg9L/Ml4H8W+JdV7zfj?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?pMQKqeSZ13Bh02cOWc62LQGTmxvhD03igMQNwOvORtY9yXKbu075AQPBKMK9?=
 =?us-ascii?Q?3W6TtM0gnpE7Q/fIyZTDYYp2n+BdP1ogxqNHLKjbCj2P3SkyoPDbGgNygn/c?=
 =?us-ascii?Q?j5DAEAN3eIwi7XQQA1GIRnBtyGEMXZyu22CwabYnd/Wcls39Fs3y5F5Pp7YW?=
 =?us-ascii?Q?DJeK7YTma+fwYs+gUOapVGLwe1+BG6JELuZC7U40+VQlFB/O203aT1Rwzm5h?=
 =?us-ascii?Q?ff1wOOM/g+41YxhqwxLmRdUZte33d4x7yME97wQPqlxxuO4AhLU6V+5msfwq?=
 =?us-ascii?Q?6jdpQehKYQg6fwAPy/8YYhVtwH+ALXfBwlQabiX0iiJOFVdbIo4IVBLra3UR?=
 =?us-ascii?Q?egzCruOrVVuWYNNJScuhKJdmgyF7pO2dpH0H6gCkDdSfpz331SGHvBUcDAW/?=
 =?us-ascii?Q?mR5ZZMqdrc7N3x7unVs79ytisdrENsvX8fP6tbD576G6+dcnZGgIDA0CjeDD?=
 =?us-ascii?Q?pum0XHtDFFO7TF1x7yL/RtObN9KRkQm+Om0HnH0o/8ur91DQvTC+7Zl5Tp8B?=
 =?us-ascii?Q?Dl2rzKwjExW35vKoIOdWoXM0P6bwuejX3GFwtpysuln62SzYbHkyHfEI2SuI?=
 =?us-ascii?Q?AT1cdqvE0lPtFv9v+ib6nag/1Giq9XpUyYiFFA5tpxV+PAnYSMPhlxXpy1Th?=
 =?us-ascii?Q?XaAZVBswAS7pJUGDePrgDZmcvZnNvI0V8aBinwOqrGFUBuWkbL9aQhJE2wIy?=
 =?us-ascii?Q?cHd/8pcNpSr4l3UpEeN+EjMUtmPsI/KbDYxATTkRvbmviT4Pxd8L48Qzr6FF?=
 =?us-ascii?Q?Wy8yhxeq8EWQEhH1BzbNm/l4glGDg0w4f8npZn32uhbkfn2ve5a8wzaBgtH/?=
 =?us-ascii?Q?un/iEZPiDZeY4X7oWfQ14GIP3VSb3U0uS/TTv17ydunKwfaK3Ev5iz/Ir7o0?=
 =?us-ascii?Q?uoHhWUvsIPRGKGmyJIrvuUhzG64r8wmY5HmB/MXhq0K2bRfZwNs2bAlgLChi?=
 =?us-ascii?Q?mielJNVEvs2U/eOvIOX2IezC61lVpPwTbmR5EfwIs58wzYyIUnWFfL/fAZcL?=
 =?us-ascii?Q?+NNhhCp4zkoz5c1As7hOq2IUWzVoK53HWaEj9WHN8cS52OC5/Cv4ApDfut9S?=
 =?us-ascii?Q?vpxT1Q0zlE+PsLPOYMq7HJqQNQ6H5Gds7n5kB3iqQK457+2YmmbHXk+IdKAj?=
 =?us-ascii?Q?mYLIBoKFSBu0EbPjlQcTmpbggvnJ4yWE1JYUa28DI8TRJijO+mhu2azt5Y0T?=
 =?us-ascii?Q?bafFM6cihDrvnRoLNEjOpbPWIl4GHLyneXBlly1kvozDxmUp/Jsa4+k8bls4?=
 =?us-ascii?Q?6/TDO9l6Z0qn/b1iiy3YHr6i6rbqd3PB8npM1BlU13pRdze8Cg4aRYkqFhvF?=
 =?us-ascii?Q?94ykPKgLIhbBxFUUGlJm4uad4mEdoZrEzxvISdtLrIvZjbMUb5hi0noFKVW2?=
 =?us-ascii?Q?ndJWOjxKoJ5mfWo9ovGgkZkXirqVn0wmGdgvBdbvDhKQeRn9N+PtAYONNBqX?=
 =?us-ascii?Q?FV0sordPPxMqM+/a1FHGD+I2yJKGfsboHpjmZJCzFoz0POqg0ofQrjayEyb/?=
 =?us-ascii?Q?1qrte6Ny/XPo2al1rf6Dblf0cKjGiN841Q/bGK2lCt/EgkagYszyHlmtdAUh?=
 =?us-ascii?Q?KKzmwKRA7EaC790kSx060h9x/+vSs34jZjQ0y4Q48vfRb2ebK9XLI+t4xbtp?=
 =?us-ascii?Q?2g=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8b75049-00a0-41d1-7c30-08dd4470f604
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 16:36:51.2499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tjulDDPklDzjnjJ3bRF5Opyvm5evVIdbKSryfacpgtG8oI5bGB9XwRsrldKCni+bam7jGnzqQ5iD3myPcvvP3wM0gTsi3Mbr5baf5NpgWCw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6936
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Feb 2025 16:37:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17731

Hi Nobuhiro,

> First, could you create a config for the container, as wrote above?]

I'm not sure if I understood you correctly, but here we go anyway:

https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-/merge_requests/112

Here's how I created the config:

- took cip_merged_defconfig
- appended the options from my container.cfg
- removed duplicates

If that's alright, I will go ahead and do the same for the other kernel
versions.

Kind regards,
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


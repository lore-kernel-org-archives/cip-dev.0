Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A4EAC4708E
	for <webhook@archiver.kernel.org>; Thu,  5 Jan 2023 18:59:22 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.40])
 by mx.groups.io with SMTP id smtpd.web11.17575.1672936636587209458
 for <cip-dev@lists.cip-project.org>;
 Thu, 05 Jan 2023 08:37:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Gz0q05rp;
 spf=pass (domain: siemens.com, ip: 40.107.8.40, mailfrom: henning.schild@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bad7tF+2BI3TLPFy0xe/tIPw9wqQYpSLiXxJ6wyD7d2ubGIwO5v9QVgVFsy/x7cAX1notew6NV01gJOXCGQkmQsIBt3gVs1wdYI3gA4YnhH8LJR1hlioO6S3LElD7VgBts6xrT7wpIjdFFDPO4/PaJm9VAedp/F3sM4LLRKQY/Om0Xb7jFf12+pp3ioWH6B9X2srPx8yd6o+4wa7YSh1xHTK0jMhS0d89dIKfijXkt+06gzM+86BvnNoLElt6nwfz3+a8o3oVMdBwYc1CU8WZ5AnegoJNb+6JSKaIXIU4nde4b1WhMDfzJVhcHAfJmpL1DTCGSjeaZJJVW48Bm2ljQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WBnJCZvHj5J0mV5WvJ/6oDsF1+5/uH6ncruN/YnGnOk=;
 b=TOfkNSrjR1unrUvXbMVaYt+2EUexqZ30yy7N25XltcFZlG48ijhydydzQX0c2CCVD9BJvTksGeswBxIdy9yf1t2ufDx/ZiXdRad0fUjm8enIYYjxZRiBQxKdaBqZH1+JpNtiFMtYlLNq46AwNDmb0CvbSFnaD4n4KdfZ53/jwi2eWUJqN7IPCxrPsXcZlUFS6I0gLvFSK4+wWIVEevS1K/GpqAJO97RqldkciSgLDPUSplQgw0vmYTjFv7ubbMzbc81n9TEEca+cRN486sLPro0t8+xPHzW9R4nSHXVOQzqwso7zulbzYALRqNRHBhw8sojyrw9Wiu451t3PTCQAIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WBnJCZvHj5J0mV5WvJ/6oDsF1+5/uH6ncruN/YnGnOk=;
 b=Gz0q05rpEz+tLNo9V2cSCgeakSrL6nBi9D5dqpAfwakygOil0AD8BWcM4EVdj2T5Dks1rXiaoscVMB+G5eY1eFZUB9l99GYkw4W49FaOldFvgX7fLO5G7BD90lsgG/2ffLruFErheVpEw/assqfO9tdZhlqtGD3ULtZRTxYwxr/YfmWbvPWX2nnVkFo6Lydb6jJOHckvSQbOyl79y5naNm++vWN1GWklzdA9X9uk1mch/Y+BnMMPB0Fi5Y1HIOJD9NWZK08KEnB4LErUk2RCg8nwaTBNY+1fKIJcQF18L+TDYQrEJrzFYjdgb5Qp6DNEdqgbwcIIN7xmiKMO8yG0+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by AS2PR10MB6425.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:544::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 16:37:13 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bdf0:fdeb:f955:bc79]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bdf0:fdeb:f955:bc79%3]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 16:37:13 +0000
Date: Thu, 5 Jan 2023 17:37:10 +0100
From: Henning Schild <henning.schild@siemens.com>
To: venkata.pyla@toshiba-tsip.com
Cc: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com,
 dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: Re: [isar-cip-core] security.yml: Add root user credentials in security kas file
Message-ID: <20230105173710.11c19271@md1za8fc.ad001.siemens.net>
In-Reply-To: <20230105173359.731cfc51@md1za8fc.ad001.siemens.net>
References: <20230105150242.21236-1-venkata.pyla@toshiba-tsip.com>
	<20230105173359.731cfc51@md1za8fc.ad001.siemens.net>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.35; x86_64-pc-linux-gnu)
X-ClientProxiedBy: FR3P281CA0180.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::13) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5780:EE_|AS2PR10MB6425:EE_
X-MS-Office365-Filtering-Correlation-Id: 66f74e5b-3d32-4b46-851c-08daef3b1967
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	sQDEpUYkLbY1sxf4Ya+MDx/oKUQOGOmggQtVYRwA4e+R9wzvNDhv1lG1elS1L2QbOgHYhYGw9pVnK3TBOOI2rW5vulbLcKbmVBvgqhHnG4VN+A/3bqRB8xqdtaBs0DNYgKkno7vw+s6xs6XxXby4uBsx8vcvB2z3WUm613iGWeA0wRd5rc8N7a/xYNz5LI4VCEikxyIU68hTeh9OUxUlmqJn48T+66rz+mhuIB8cWEFybdOTxAB2ac8Z9Jce336DfCjnKmoXVkIfNUQ5TaH8ZO1ut6a3i4cQx6HFAt/p9eO3zqVpRBwqZw7pNZjxXPD9B3/+sDEa+NaH/9hEW5kqCTNe2rv1C03OTVJdTns+6xqxVKM11AQwJxWHvaxK8wsiVHs59VBtD220MFIcit96V2Dd4SN5Rtubm4oQ12FUAw2mV/xzT0hwVEAI5CC/loTh9kV+Ahux+Zo+IyDDtnSrfkaAokYnheCpsih6B7R/IgXvBLeqp9vZhLcvY0ab7QTZfrTdcQfDCfy9F99gxDBG+dd2L4Im+aP2KWQS9vm0xaZDQmXSI5Q5O607jSOhCt4TD67gIxRPTrZvexoyw3svwK0A2U3403zwOdoEVWIqvPK1/AMISQoq2Ux7vzzBKrjKao3sRMZW9kEVrFGosBpVFQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(366004)(376002)(396003)(39860400002)(451199015)(38100700002)(2906002)(15650500001)(41300700001)(9686003)(316002)(6512007)(82960400001)(86362001)(83380400001)(44832011)(8676002)(1076003)(4326008)(6506007)(478600001)(66946007)(66556008)(66476007)(5660300002)(6916009)(186003)(6486002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?P7E+UpJz1XW0muCNB3NKOCQzpQsj/z1qAThL6mnC6PCclEh/GgvHc2nwsl0m?=
 =?us-ascii?Q?FrrcYt4Hduah751zggyVGZdLIleFdRGZeTGVBb2izHbWRgqTnCVmQpJx8usK?=
 =?us-ascii?Q?rRvIydA0oxGvYkPU9XNi5/aMfQdHJC9F+rmEyIuNvNcQEHLsxUieweeY41jQ?=
 =?us-ascii?Q?wqOswAt4rBEqYvdgiZgj6tgy/b4xHPBUJk7IXDg3KeUxUMdxHfGMEiihMeQD?=
 =?us-ascii?Q?fVpmZJu4zBPY1OaD/fG5ZDpohwkYWn/PlWxdHW5w+n8HdRjeheyd2RjltiA3?=
 =?us-ascii?Q?62iHa3Ahuvq0Rk5Rt+TROY07B59ispzg7O/YphGMVdnde4P9uvDbTltNCnGJ?=
 =?us-ascii?Q?zB2Jazzz79WsaOs6hO4yq2VFi4Lh1FSskp1wDX2pK3AuwxaqQzitR9QQvv3s?=
 =?us-ascii?Q?89yg4rNwFVTDCDAXD0gcelzsRREA5y0NeMR4FGSKWUwMS7tEO9ipC7Ii/plk?=
 =?us-ascii?Q?EXuPxbKQBsDXmKTLLkJR5mgjfnxfBoHhRckWv9j+v19Oxt8N8DlWK7gBYjXi?=
 =?us-ascii?Q?zodbJvXXPYw8tIfx3HFdKfRvZXBQL4KcBZ2Cxnv4Xxhj5lNqs+l/cCR/Q9WJ?=
 =?us-ascii?Q?krCsqltjvNAsfDzz9xuYv81bBd3DJmJuUoAvj9+SVSC/PMpIJ/hICJ62SO40?=
 =?us-ascii?Q?SAzAIxsqaLlBZRjeLb2sDDTxOXi6yBwsi0ngY4/SkXHeMRgaEtm2MOrTfK0C?=
 =?us-ascii?Q?+ojT4VudjNUtqRiDgM0HbB0agAFJADVhC8QbRarIyfjcDnDa9Yb8zrb474X0?=
 =?us-ascii?Q?gy+d+lv0jR1utcwLX7qXQVHTUJ3pyaxBY+KbpI5ivKh0GUbfAZ+UQPxZSVIJ?=
 =?us-ascii?Q?z2GMDj7tNbnIapXzCvWzpwK5JwXJ8DXK7MvMtLF40qVqvmRF1YHv7sCDQ29V?=
 =?us-ascii?Q?QpAHjGhHq7TEDQT+TCh6hvnJIGesicvlL12nTNaKnGWzRmoj7zjiFWqXOadm?=
 =?us-ascii?Q?kXegTzQQOIDEuQo1oJPCt55iY/OVNZmP7t172svfJdPZSkH6Fr/yp96Qq2Bc?=
 =?us-ascii?Q?V/8S2T18yG92A5MzYUBsLs8CLejf5vzKyIthe0dBXkZZSVV5GZQIO8+/EEld?=
 =?us-ascii?Q?Vk9ze7gx/U0Pp6XpLuoagpevqoqTPdhJaWHXskMROs40UvBgGWBUhHW0p+pg?=
 =?us-ascii?Q?TJbWkeaYCAN7l6UkK17gSDu+SyqcpnqM020gJyWAHEHBnPTaY5QU8SCvCoze?=
 =?us-ascii?Q?uaIUHhobyeQIHyAEUapZRVDjpqSItV7X2ziLuTVRQiouC8n1Z/sRNcKSrqAa?=
 =?us-ascii?Q?r+bq/spy3WxHC+6zYIfsCO8X2coTcubzJpweIirh4J00N4qj+OAFJArv8FMa?=
 =?us-ascii?Q?IMZjk578sXecvNTSFdU2+aCohPbszAodKdE7F4270k5KqmiY9c4HCc36zops?=
 =?us-ascii?Q?8amN845UP7ruRBHLUgvQAlZKdBwznRjdbXML4kl35s1nPsuwrEgIYGDQLeu/?=
 =?us-ascii?Q?S4BnsZ3v4jDJIJJlbK12fJkP717LAuKwqUajgkvEg3fCdulcZJNzEtEeernj?=
 =?us-ascii?Q?mMdCqhW5bpUdGxfciW8DvqWhuW0Oqkx7WQgts8HO1rMtQXXOhArORZnZJhnu?=
 =?us-ascii?Q?ReY3siR+RFtiWZPouYUOPp3ZJ7AJkuMObZvwbi66o5PZz/dV7+R6RrNk7SG6?=
 =?us-ascii?Q?Zcue6NMmlEvmuyGnq1bHo6zbEyr2QA25abQOmjSC1vcpMq/ININYtt7QBZvG?=
 =?us-ascii?Q?uGBYaw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66f74e5b-3d32-4b46-851c-08daef3b1967
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 16:37:13.5919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gp4peRF7U6850/ri0Td3R6QVr4qnVMfAY1ECJiZVoHg1QZNrlizGv/oNi5PeoUTL3ELM7C+UMQ9WsORuF5ybK1ng7T1mHzpjbneDTRcx4Ms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6425
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 05 Jan 2023 18:59:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10327

Am Thu, 5 Jan 2023 17:33:59 +0100
schrieb Henning Schild <henning.schild@siemens.com>:

> Am Thu,  5 Jan 2023 20:32:42 +0530
> schrieb venkata.pyla@toshiba-tsip.com:
> 
> > From: venkata pyla <venkata.pyla@toshiba-tsip.com>
> > 
> > Security image creation imposes a rule to have strong password in
> > user accounts and that should not affect the normal image user
> > account settings, so overwriting user account settings in security
> > kas file as required for security image.
> > 
> > Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
> > ---
> >  kas/opt/security.yml | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/kas/opt/security.yml b/kas/opt/security.yml
> > index 4e74a9c..c385a62 100644
> > --- a/kas/opt/security.yml
> > +++ b/kas/opt/security.yml
> > @@ -12,3 +12,9 @@ header:
> >    version: 12
> >  
> >  target: cip-core-image-security
> > +
> > +local_conf_header:
> > +  root_password: |
> > +    USERS += "root"
> > +    USER_root[password] = "Cipsecurity@123"  
> 
> This looks like a pretty hefty interface change and should maybe be
> documented somewhere. Note that we should use that variable in
> recipes-core/security-customizations/files/postinst when appending to
> /etc/issue ... or the value ;)

And in fact we will need two packages coming out of that one recipe if
we use different passwords in different images. Building two image in
the same tree would likely cause false sharing and whoever build the
package first wins.

Henning

> And talking about the value, can we get rid of the "y" and the "@"?
> The "y" is subject to QWERTZ vs QWERTY and the "@" might also be hard
> to type when the keyboard layout is not 100% ... like in qemu when
> your host has german layout.
> 
> Henning
> 
> > +    USER_root[flags] = "clear-text-password"  
> 



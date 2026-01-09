Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E38ED1681D
	for <webhook@archiver.kernel.org>; Fri,  9 Jan 2026 11:59:07 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.35])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8543.1767959931234222750
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 Jan 2026 03:58:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=ahgTzEon;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.35, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ue4ywx6wFkO2kluZgIizAeWfeCLCvNNsnKxQTcr1oATxYAL1OBuypf5TCv8VxRpVOnhK9n7fiQlEq8pNLM5Q0t064MfISIM1uYUxZzssaXHfACYk9/Z0phdZ7vu+pgz+9hhm3VP1KYllpK1nFqNHA0Z9fgcwv7qgygw91xXhbJVmm3PXQBpDbm1wtgiNaNRU8WTA5gDZX0Ivv0TijflDj5HBW49/qQFU5ZSFA69HukEmpr1NUe2dq9gV+TJsB+NVbD7VNLXpPgjVFfAu2VkPwb3DcIdtb+bLVqAty97dqc9NuXxB5XOYsvRLCns6yWLrWFmhVBOky4KGGKeQNg2VYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0stkaateCe5w0BRJ8MNvgNYAlWuBMWNGHml63Uf3OPw=;
 b=jimseis33jejebmNlH5/pVC3e2ReV2Byj1GJ9GypT4a7f1YT/TeMUgj0KnNokDWcS+yWEUZrCfJhU6dx9X2Ect3iNJ9tkKpUg5PMveFZgLeTaXZE3B9bb/VNUrYCMQl1KsLFa4QTeX/CXFN89q5wKfwzBjX/wIAlx0sxBTHarTcaJvf7C+mSdxXCpnKNhXKlaDOREjGYhdpeeNg77x5kpRr2KF/1x+mS6eGAm/ZTfG7k6udhJfrazVYk7DcF+fLVxtAw2GA+yf8Lqu3zA62DGJIuI8D1NOWApNQHz34Nzx79Te14KXJ7os/6Ty6QATOQLugbLNPGINznezSnT+hURw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0stkaateCe5w0BRJ8MNvgNYAlWuBMWNGHml63Uf3OPw=;
 b=ahgTzEonKSgO1+jJQQjJhl/EEuSBSWJrEYmFO1BpwOouKCcq3+zgN8hDe9ZndCe8ndafg4YUQ9Es7SQBVQPYKEMF5FfQ7em22oaqJURqh2jUHSDbMgXEXfg84EBEgJG6nNrKj5LnciYnAe3oT/PJngKHkJwadN7HOp0pdV2hdjo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TY4PR01MB14106.jpnprd01.prod.outlook.com (2603:1096:405:20b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.1; Fri, 9 Jan
 2026 11:58:45 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9520.001; Fri, 9 Jan 2026
 11:58:45 +0000
Date: Fri, 9 Jan 2026 12:58:30 +0100
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: Pavel Machek <pavel@nabladev.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 04/22] i3c: master: Add basic driver
 for the Renesas I3C controller
Message-ID: <aWDtZhy_vCiwVYuS@tom-desktop>
References: <20260108092823.489287-1-tommaso.merciai.xr@bp.renesas.com>
 <20260108092823.489287-5-tommaso.merciai.xr@bp.renesas.com>
 <aWDW8tT9BNp3Cz+L@duo.ucw.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWDW8tT9BNp3Cz+L@duo.ucw.cz>
X-ClientProxiedBy: FR0P281CA0187.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::17) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TY4PR01MB14106:EE_
X-MS-Office365-Filtering-Correlation-Id: 26777c16-d445-48e1-e6d1-08de4f7670c4
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?G2Z9zE2OYCgNHoY/fqRyJCPqFQ0knZwLwRosR3kqpgUFWgEeEoi17G9s+zWA?=
 =?us-ascii?Q?qkGrxMy/N0lg84tY9EnrA8+coG6afprtrzmsHbwEhQWrHZaDuWuJ0Ol5XP0O?=
 =?us-ascii?Q?u6mJi3slX8xuvX8FClz4nyMAL6Pkp9rvU6qFIs4sUBwntJCQe1L9jWF6yN8x?=
 =?us-ascii?Q?5cNiMFhyQX7t+FUJqX/KxvLk8hEpyac5tPn0VSK8MBRxZaJDULwTj61Qbuik?=
 =?us-ascii?Q?1ZMJ1EkEhGojCdyXz/B+6I7SGBmeky17pO6dN/4ucg4zwwfF90sGvdY4CAoV?=
 =?us-ascii?Q?0OwxmiOnuT9CA8tbNm0UykGyaDkZkLIXELegRGzv4fMcz7ZWraDGGDsWeKYJ?=
 =?us-ascii?Q?fnRdLvjYXN3U7wCnGhaKyR4U7DrzmRYruzgubRF+2gKGYCIFQusvV2lFNqAn?=
 =?us-ascii?Q?62CY6n8vQaCLdDcMpZB8Q2lzAendRz74fKaxHwWKT6GAzo0SRNITq9kAfERI?=
 =?us-ascii?Q?2M60Aiphh+IXfGnH/41pC23lLT7zvhVMLKC2vtehdIOTgICN6yOcAiH+wDFY?=
 =?us-ascii?Q?Mc/k2aJg/KGtHhTps8axkng2sOahHhYA3zTatdSpYogrdlVSy6Z03KRen6fQ?=
 =?us-ascii?Q?zQ/aC4DnvSddcm2JczY1u0J60PAYorMfnvecIJiAhe4uL21ILUldxZKkHwvQ?=
 =?us-ascii?Q?1vwakdD1uUaXIqPJa8K2ZrVs+jdpVhmNIjz7W2NH6sjbTx6onJ+18CB/P7EH?=
 =?us-ascii?Q?ZcFlNxWgjzYO8W1IpirmLskDePVo+WJNWnoEiBeMseQ2Qt4oh+szkH2VUmOX?=
 =?us-ascii?Q?x4MUCYfjEz41AiaFESKSoKT+lmmwigERu+qVPpr5metDLJqzHuxfod87JXQA?=
 =?us-ascii?Q?yj7Sze6jLsD2OjpHDoOM1kqda85Vycs3DSUUKaMzVOJeJdGzti+8NMV7r96F?=
 =?us-ascii?Q?ik/UzlJuoRYfD/si/jGhVbejUcm+n9obXpQSn2AtWl7mINnUInu8xzT09Cto?=
 =?us-ascii?Q?0ZEPXMzxuy0Hfibj2CTBqV+uvLf9B80vS7opvNlp1fAHJNoJSICidZojwD2P?=
 =?us-ascii?Q?L0vM6WDin3E6OsSWaScsbBxcDB4gatt4g6MBCnNM1ep+nvk9+9l/vC/aB2lF?=
 =?us-ascii?Q?6oVGNUJ2Rrx6arsap9bT6zEy4WmVUgzytoPMveIaWQRyB240/itINAF8eOXD?=
 =?us-ascii?Q?XzUJtWuBvUAHMCp3eBuIIqSnTIwLl6Jq7WuHUDkeTpF73X/V8TqayIxKTc0C?=
 =?us-ascii?Q?SB7e2nkoTylvmCrNkogsahtC9ORAhPxg8fzwjugu+7vHO4xMux/MyChKoVR+?=
 =?us-ascii?Q?lhFNF1foF73XwsCt1y+kQxzvSkWOi8VgP81z2HX1H7N2HtwqdR7Y3hsdBvEo?=
 =?us-ascii?Q?3qtAi5afggozf3bSdMaypU2t57OEqLehPnVgvIdL/DQ1ZmAOvI+fLc6MiJ1N?=
 =?us-ascii?Q?Y6a4CZXMHx6yJHqyVG/z75Av8Id88IVL2oCFbVgfKSSWdVImeHqTALY2iBgP?=
 =?us-ascii?Q?PctWo5FNIXTxTyFbDfgbpBcV13/Sggw9ygF0zB6oFuEOzQsU2rH/ltU172d+?=
 =?us-ascii?Q?cWftZ84Cz/w9QHRFvOW7aSf4iMyb0z+d0L1W?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?eOcfVh/qAnpI8R9qSMmxeq0NXmNx4LXEsOO1iSxdTYwctbSwYxmU5nPGftZY?=
 =?us-ascii?Q?0A1ifZdETlxVjTe7SLN+UC5U4Mo16QninYMEqsHdi+oaG3XKwQZstg6dLmth?=
 =?us-ascii?Q?eoB/OhhwKclFkOGf7VdGD2CLPYU2INlyZPyzSwqg2XoIUa88TaAv8/2UCpoJ?=
 =?us-ascii?Q?OO1VRB2Z1RMJF0TwCZPUfIceQRPvWUIUHCoVyPOIz83Lo89O6a6O29nkYPkb?=
 =?us-ascii?Q?4/58SMKne1yNwB3kqdgL4U60YUkRVJRg5R8cNyhb10JUCgSTmuwa/znJRSFs?=
 =?us-ascii?Q?L4YWvGsECUIx0gFNzTVoEbT+erc3JwkjUCgYuwFViihrygHG3GMIXNe3zDze?=
 =?us-ascii?Q?QfWOQ5jf8L//BwMWQuL1WBg2EZvopaXpTdPS462Fb10rT4VlPuDMqU+mK5GO?=
 =?us-ascii?Q?8KVpmN7mEZP90kLIbns04NnZZkjWohlSUOhPW8u9iod0yb6+7GuQqhEGVmlN?=
 =?us-ascii?Q?CjETe3rC6wgBJob64wEtaynLAacKc5rU/NWPVnpnb1dU+2/X7A37TEVRzrrZ?=
 =?us-ascii?Q?R9oT0ZE1MJ0dOAFAMk2G76s3mCC9rBhlHxvnS6ANfRduFtkVttF4G8S8m/gp?=
 =?us-ascii?Q?ZWX2KGCEiL1Ur+DrHtP6pTYNPT7adtjoP6IDiooBdqgtrSLhvgNMVgIlPHUj?=
 =?us-ascii?Q?oaAlAr/aDDoBjJAMCVih4S7dmkSmj7LyGUHKezwPPDMh/KDSHcoxbXSLYHm2?=
 =?us-ascii?Q?tBnUmYDW2Eqmdr2N0gcmGAn0AuN4wYrbRHU6Y5iBkXfXIL8EMGneXVTmJNTu?=
 =?us-ascii?Q?d3vnogKIFw086+97J31TwvqkL+ds8WoIEIu0h+Ikr2n5MDQ6mDYB6o7IEefy?=
 =?us-ascii?Q?5dsamPenN3snQfont1e2mSu7bxjVtPFY+Rzb0SU5PPFKDKvQrMpndL8RDOkm?=
 =?us-ascii?Q?thiVwBj6kChY2Ume1oh18r1n85MV7bUCx9dE3klV9yoTl/NJSSDzelKlyXrX?=
 =?us-ascii?Q?QWkBaCq78NYDzNB1vAC7QXilEgPYdEWsqa+9Cdk1YcsPtSLLbTS36SF9wa3C?=
 =?us-ascii?Q?8zvMkjByyfRZ0MJS/uJd5qT0or8sn8SrwdcFExRCMUGhW9+zu7ifrF9j+35+?=
 =?us-ascii?Q?9pLEVuv9kQtiRyLsN6NzK/mawoVinLKvLVP+4ZsKRGBDyMjbhWDaF5BxMDZk?=
 =?us-ascii?Q?O1Hgwd6G3I7j64t4fDIkFAwoH07iQ6BWu2UyCmfrWvImrn/Z7320QQwyLvLW?=
 =?us-ascii?Q?kt/+Nvx9S3bLL6oTqeMmCyMKHY8Mgs/QvjVrcYwQ5JkNYCYeIUTnwFgXN1z1?=
 =?us-ascii?Q?b9nnlLfoUFgU9V+9OuEnZw883sGUFM8iX4GqG+RFy033Hdv6J/jnU71/a9SG?=
 =?us-ascii?Q?6PH6Pg2kSDiywtWbsz3w9OgPxrEk0UenCLmqOkW0aq55xRVp8BQ98hX+9qVG?=
 =?us-ascii?Q?IPo6T/TeyVyMRl3EeJhI75qvyFAsnG/5lqXMNNyN2FpebCJ3MjePkdmCyKbX?=
 =?us-ascii?Q?zFqN08FevyPOF8R7NfZ+5rRXc7E7S9WPMFxbY5ur9Dgg5M0z005glJpzxn3M?=
 =?us-ascii?Q?oG26EwGuZOjQCYh4uFHOfDDVbvhLk/jtDZnJGKjZokxnmpt9bDYUMoWHPsJE?=
 =?us-ascii?Q?P/wfXHDqcQGB8HwJTyAJj/1xx3RFjC9XUevMkVfdjhoDEIWHyuWDp4snofls?=
 =?us-ascii?Q?KfDCqisxfm1hb31DKcCSqg+ZW/dniAkxPt1PbjLBDdD7/2a1vvKdjf0qYhj+?=
 =?us-ascii?Q?ajIJIJE4a9I17ZqIeb6a1M3+7qZyZBI8QSDQGzwgOjlZ5em5oFWABJzZo9O7?=
 =?us-ascii?Q?OdLQsqshDUaKukeC6KQOClTmNT1+9RLR//WupfWAD4jQUOoCTyle?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26777c16-d445-48e1-e6d1-08de4f7670c4
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 11:58:45.3688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hdulcIGpYHFLE5f5nsBZX85Gh1i5JFAp8QxieDzQHbrG+WrAt/azfvZBkUjfr+gak0eO8/mLS0BiytShM8WayvKoS88cByWSABLmzQDQXP0JQz0S0Q+EYVnqReELui6F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14106
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 Jan 2026 11:59:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21504

Hi Pavel,
Thanks for your review!


On Fri, Jan 09, 2026 at 11:22:42AM +0100, Pavel Machek wrote:
> Hi!
> 
> Some comments and questions are below.
> 
> > Add a basic driver for the I3C controller found in Renesas RZ/G3S and
> > G3E SoCs. Support I3C pure busses (tested with two targets) and mixed
> > busses (two I3C devices plus various I2C targets). DAA and communication
> > with temperature sensors worked reliably at various speeds.
> > 
> > Missing features such as IBI, HotJoin, and target mode will be added
> > incrementally.
> > 
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > Link: https://lore.kernel.org/r/20250724094146.6443-5-wsa+renesas@sang-engineering.com
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > [tommaso.merciai:
> >  - Removed  __counted_by(ncmds) from struct renesas_i3c_cmd cmds[]
> >  - Added struct reset_control *tresetn, *presetn into struct
> >    renesas_i3c
> >  - Use devm_reset_control_get_optional_exclusive() into probe function +
> >    reset_control_deassert() and devm_add_action_or_reset() for tresetn,
> >    presetn error path.
> >  - Fixed renesas_i3c_remove() from static void to static int]
> > Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> 
> > diff --git a/drivers/i3c/master/renesas-i3c.c b/drivers/i3c/master/renesas-i3c.c
> > new file mode 100644
> > index 000000000000..432be328a4e4
> > --- /dev/null
> > +++ b/drivers/i3c/master/renesas-i3c.c
> ...
> > +	/* Initialize Queue/Buffer threshold */
> > +	renesas_writel(i3c->regs, NQTHCTL, NQTHCTL_IBIDSSZ(6) |
> > +					     NQTHCTL_CMDQTH(1));
> > +
> > +	/* The only supported configuration is two entries*/
> 
> Add a space before */.

Ack, thanks.

> 
> ...
> > +	/* Hot-Join Acknowlege setting. */
> > +	renesas_set_bit(i3c->regs, BCTL, BCTL_HJACKCTL);
> 
> I would not mind consistency in the dots at the end of comment. Normal
> convention is not to have them unless comment is a sentence.

Oks, thanks.

> 
> 
> > +static int renesas_i3c_priv_xfers(struct i3c_dev_desc *dev, struct i3c_priv_xfer *i3c_xfers,
> > +					 int i3c_nxfers)
> > +{
> > +	struct i3c_master_controller *m = i3c_dev_get_master(dev);
> > +	struct renesas_i3c *i3c = to_renesas_i3c(m);
> > +	struct renesas_i3c_i2c_dev_data *data = i3c_dev_get_master_data(dev);
> > +	struct renesas_i3c_xfer *xfer;
> > +	int i;
> > +
> > +	/* Enable I3C bus. */
> > +	renesas_i3c_bus_enable(m, true);
> > +
> > +	xfer = renesas_i3c_alloc_xfer(i3c, 1);
> > +	if (!xfer)
> > +		return -ENOMEM;
> 
> ...where is xfer freed?

Please correct me if I'm wrong but xfer is freed at the end of
renesas_i3c_send_ccc_cmd()

> 
> > +		xfer = i3c->xferqueue.cur;
> > +		cmd = xfer->cmds;
> > +
> > +		/* Clear the Respone Queue Full status flag*/
> > +		renesas_clear_bit(i3c->regs, NTST, NTST_RSPQFF);
> 
> Space before */, please.
> 
> > +	ret = reset_control_deassert(i3c->tresetn);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = reset_control_deassert(i3c->presetn);
> > +	if (ret)
> ## BUG:		return ret;
> 
> > +	ret = devm_add_action_or_reset(&pdev->dev, renesas_i3c_reset_control_assert,
> > +				       i3c->tresetn);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = devm_add_action_or_reset(&pdev->dev, renesas_i3c_reset_control_assert,
> > +				       i3c->presetn);
> > +	if (ret)
> > +		return ret;
> 
> This is wrong, AFAICT. If return happens at marked line, we'll leave
> tresetn asserted.

Ouch, you are right!
This should be:

	ret = reset_control_deassert(i3c->tresetn);
	if (ret)
		return ret;

	ret = reset_control_deassert(i3c->presetn);
	if (ret) {
		reset_control_assert(i3c->tresetn);
		return ret;
	}

As I've introduce these calls because of missing

devm_reset_control_get_optional_exclusive_deasserted()



Should I fix in v2? Or you can take of this while applying?
Thanks.


> 
> Best regards,
> 								Pavel
> -- 
> In cooperation with Nabla.


Kind Regards,
Tommaso



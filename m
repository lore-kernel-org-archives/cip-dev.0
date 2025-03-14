Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C79DC282EC
	for <webhook@archiver.kernel.org>; Fri, 14 Mar 2025 11:09:44 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.31])
 by mx.groups.io with SMTP id smtpd.web11.11843.1741950576757677617
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Mar 2025 04:09:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=WHvBrpHZ;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.31, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J5MQEpjEE+ldlXqNQito5ngCVu2ZENnq9OiluTJE76QTAVdTvfJ7wNMIA/Tcy4rY2IhZk3TtFQIbmuPkA+dYbcrS4aYBtLGgnDbU7S3qjMmPwr+yal6yNDLk3cLU8RCNoky4EDBfExROWcGINBt+XuYqDtm0hywTD4yIyQWHzOHJHz+q3/CH4ajOBqeamllUeLgXQEoC8vaOh/ZtI/mgtUgtMFbWBfqLNMmpuFm7Nr97Y+8iQzUJhgW8IutSD7eTGMcvLJjVtFfZYNtXMvwDz5e/Rh9IKQ1CpwO7v+AQJV1llmQGAK9tcenlMwPunN7XcWpWoUPVoIw+kTeV1GIkGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/mEFuV3UDAPuBCm/i32qZhVNvAYA8Kj9akkczB6d0BY=;
 b=uKP7mVuSnNmA4sxR/0XrYr1RziA1QNLvLbnkMFjm7v1vSnWgUHF2ww6eQYTCWgqwDZuNSPOx9iB59jG67XVGXZ+8IiLUZ7dkYEXCwO+UT9BrlJCuZ7dFWcTnibVVXZgY9/gETFqrMEk9US9rGgCaYxACLxhNywZtT20Kd5bQA+2mM8aMz6efdwIBlBteMOhbFVoqcUSxhts/mxkTGv54TeVEuRV4NAmO0B+fIoYH2+xXDdQNuqr0TGT5KmwHM5i44At99gPEmUqycow+p/tPLH67dnvmINZYwM+th9cIQqTuViZ95+11Q2FiQAP7zNErFBE3ke39IRvoLnnMXpxA7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/mEFuV3UDAPuBCm/i32qZhVNvAYA8Kj9akkczB6d0BY=;
 b=WHvBrpHZMQUaZk3VmftiT1K3lql9Om1kPaFfTKTRT6420QTMYG5UOU2CCbXyoRL35Jmq0TGS/knuby1RSOGRoZG7UnzlSmP/bzBC6mHFHzlsma8MXTyfx7ifnywUt9wrlCAZ+PHU3aRyYijl+vMH6mcJTdNmnueUuWEKEucd++8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TY4PR01MB13332.jpnprd01.prod.outlook.com (2603:1096:405:1d8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.31; Fri, 14 Mar
 2025 11:09:30 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8534.024; Fri, 14 Mar 2025
 11:09:29 +0000
Date: Fri, 14 Mar 2025 12:09:18 +0100
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [PATCH 6.1.y-cip 05/85] clk: renesas: Add family-specific clock
 driver for RZ/V2H(P)
Message-ID: <Z9QOXuYQA4oG_oss@tom-desktop>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
 <20250312112302.1605750-6-tommaso.merciai.xr@bp.renesas.com>
 <Z9QA9rwuXCuVbOXp@duo.ucw.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9QA9rwuXCuVbOXp@duo.ucw.cz>
X-ClientProxiedBy: FR3P281CA0116.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::20) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TY4PR01MB13332:EE_
X-MS-Office365-Filtering-Correlation-Id: fead7488-bdd1-49d5-8502-08dd62e8b0e4
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?GQRb36BLWetXcYqTedYuHhE5hEWzOIQVKelKkqEXkkzgYx3MnYIIMHB3LWW3?=
 =?us-ascii?Q?FRKKS1XPjPpIkDgk/NIP7ZkmqxbDV+elbLtQjlp5AYAciz2gCyAVdwEfTiu9?=
 =?us-ascii?Q?p5yVebL7oQz72LiAfhsO1AV0nSiJyzhDnhRwx5pCakyBlTnpZg64bxND7gir?=
 =?us-ascii?Q?W5yom/2+WfTnuWD62fA6N6qOcJeid40u0Gok3E41hFp4ScsU3L+80NnUhUqe?=
 =?us-ascii?Q?dHBnh8dGK8pmKn0ZLBNKJYI7aXiv3qTiuibTQFUDaaILbxrGKEygHelQ/Yqw?=
 =?us-ascii?Q?TIrCGvF4opRl8evngG6P42XCKBfRvovKqPg03l1QSiFdx1/TtBgs6Zahi+DC?=
 =?us-ascii?Q?RLkOlYKnFjhutF9so4ppylcl+tzsA6m+qXeSTmSG5ngGD9qfnMi9ifJGJq/6?=
 =?us-ascii?Q?R+1/r1jBqgL46YhN/Qspi381pBQqxQsIqeg9go9FMJZSrcMNYA1V2IHd8OXV?=
 =?us-ascii?Q?OYsomI+mOx6JbfjbOsbc4ojRPQqYwZp4C4JHsFk4JxiQp9uZaKLt9QVnGZ2d?=
 =?us-ascii?Q?XjX0Z3FGrTfUWbp9lCEeiTd+g8ljCcuNFiaq75+EvItXZu2TqcDiBeOz5CD6?=
 =?us-ascii?Q?7SaQ1Yk0tAbqj2IIgqSQEkfHLzgPesCMRS/Apn20uoqB7V2/5xCcVgFrtV+e?=
 =?us-ascii?Q?/80vEGXzYky5zxslVWOuS3nRgaFu4v6GmyOJEKIDdE7BOxMFPa+2ShKjNOXC?=
 =?us-ascii?Q?oW0rMvGW3HtSUz9/wJnPa49aDCNk8JmsW6jtwCtd18Fu/WYWpfNM6vBlbj3R?=
 =?us-ascii?Q?5sSglq0XXAyehY8/NyzFYxA6RrjNX/dWeV2coNyLkbLKMVZIiddMv7vmTQe5?=
 =?us-ascii?Q?IYACQuvdhFje7AmP5iDARO+2WJ/YIFqNyhGFC8/MfQ1sN6qlhwy6SM3uINNz?=
 =?us-ascii?Q?WA51nAVxhFrQwlF582crK23hiz3/8iGAJkWT/jKRMaGQ/xV8SVFkpmRML5i8?=
 =?us-ascii?Q?gX8UPKAZhRVtu51QhhAeVqQKfODf854W+dVZCn/vDtnVeTGk6KahDFUohbmr?=
 =?us-ascii?Q?apiyZgL+XiuKe/Du73Iw3wT0QuGfFwLWTf8X4FCAtd9E0OuEWEm0GWIm6C5h?=
 =?us-ascii?Q?haYzG8Uad8EdGnNECcAGOFdWjPld4aYLfOlQNlII8quZ+KLurvz34MqfJFMp?=
 =?us-ascii?Q?hgRPtfisQFynd8fd+MkjGvxg9ob/lAYdMebeCrFxuphphKpFIjy5D3QfXTx4?=
 =?us-ascii?Q?XnZeBLOeqbNMasyFySEoPoJt4J0J65kym8y75Zk+hD7ByRV2t6Dqz4n8JZNO?=
 =?us-ascii?Q?GcuEShmPfN0QbbxmVQxHD0UpXytZcZQ3j9X2STFQN6bbtFmuhvPSgBck3uab?=
 =?us-ascii?Q?2BGwidQQCgdeMm4DXxDi7T6uuHmUtpzOxMEtYD3FcRhQxxWWQPk72tyMvXuu?=
 =?us-ascii?Q?SV2VhMI4QtvuVpbKV1ub/Jc6cFHVi6t6N26ecjrb/z/payCuDIsp1MP6wdd/?=
 =?us-ascii?Q?lVmIhQe/luHYeCEoG185O2XGXiiD1EKI?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?H6psRTE3shLn8uFrEuerpLYjwzIxIU7/5gjM6VWMx1DEI4g0rrkzz3z/s1Ms?=
 =?us-ascii?Q?UZrRrzNx0+hlnTRVHCMbUu1haTdc69FgtkCFV3kDGZUS91iO5IzQqzda+f9I?=
 =?us-ascii?Q?oMpwMH4L9ta4xYufJbSxUb1w7GM4KuwRSDCGaJwm1eR0cZhAKMWJYkzA0VI2?=
 =?us-ascii?Q?pKeWxDkZ37Ln+cBgaT8TQuQT6YfvxvYIgCq87L2ZkM9+pacEzZk5f1CSiZYr?=
 =?us-ascii?Q?0mJ6PZZQtkIr+2FhzsNTS5CEPTZFlzlq02A9MlInzCs+Gzgcf0Anlil8dbQf?=
 =?us-ascii?Q?SAU+55mXHX2m+gVQ4gch5e77QXsAPvwXR9D/ykGcwitC6dfPomnk4IhkXufd?=
 =?us-ascii?Q?KAb3akL5gOSX/M5SlrUeaUnzljZ6uwn5EVjk3LZ7tR+hNzQpd9gy3hQ5fB4i?=
 =?us-ascii?Q?Kl8+KLHIJ1jTYwXbYePwJocWHey8BijGFhUkbOLQYzpLWpLJBA16MuN0EUJd?=
 =?us-ascii?Q?/li71Ja80ZMiaIQ1rIi1FUMU4sr8tmv5QS7JqQUIKiCnsfDivC882zaegbND?=
 =?us-ascii?Q?7nlQp3IDPg0VJopI1ODlMcsbNkqgKIs/FR6v8scPJtHOWfrOsHNMcz5DMRFk?=
 =?us-ascii?Q?5gv8JYKahLjzbOYVB/OJrcSbjYie5tzjrYyYAAhnGfGCd01gSyGaLyLkLPkW?=
 =?us-ascii?Q?Wgn38FgeRbXUZATTeBjbe1snw2r9WS2NJI19miEen0lCvyA12BIW7URVf/Zn?=
 =?us-ascii?Q?6fDdpzJLcSKsqzNDykd9POJTg+KfvbGHE0wCz+Tc8Pj7Ul4fRrEadmuc9/Dv?=
 =?us-ascii?Q?wUwHTtsdyBzIx6w6rR0tB9CsLjA5GsQT1kLfXL5Pe7NdWWtwsPB8eIjDbEnC?=
 =?us-ascii?Q?0wEPD8vy8dORiJuU8GTP92rraCzrgE++PczTe9v+bsiNtrOLB0CJXHnRCfhz?=
 =?us-ascii?Q?kPTmOUij5+5MTQaIJNP8p3RvXcZauGSzqfT9gTZdI0cTVIJIHw7LYR1oG9Mb?=
 =?us-ascii?Q?1jbsAKkPGLWc0bSrLnfTS0k2tYmWhKCnDutUryJfX6YO9Zp6RrXPakJgOfza?=
 =?us-ascii?Q?qddyUmfHj8J0J/4CjC76AbyXg1/5dtnj/pQKxMDLqHidwiuWjEXsbNoecSkQ?=
 =?us-ascii?Q?IONqnbnQybzdkhoev2k/wqnUVkhB1x72GFeo6EAzskxQj/YU1HEHi48EyZRI?=
 =?us-ascii?Q?Il788Kuovh1Q9KhretqWzV6sH7pA40feGv0D/1S9lZKD4lv5XUtK63S9PfNS?=
 =?us-ascii?Q?XMWNoYHcARMFRiWIlvKzODzP/1W0uauLd50V7NqEWyvbg7frAQg5KUFxZ0fn?=
 =?us-ascii?Q?IqpYNjKvy2W+7tUwkZuP9vuGnuYY4ayvn0a9PbDCWWa6JWwHCafu+Zzxjm78?=
 =?us-ascii?Q?mMgn0zOxHNAGH+2v2XCV9Sdv9xp/zIxrWkejLxcCBHHznazPFJprAydsep2c?=
 =?us-ascii?Q?azu5bRPYkhPqvoJ3bxWpvbkbZEhCYZPD8RY10GkrtetTSqhZH6t3Oy3r1E8+?=
 =?us-ascii?Q?cyEM9ISS15+1q2pwoDRTkkMY+PKJNtmEcV3cCe0lEhPo5KdVQcmBpwrgp94E?=
 =?us-ascii?Q?riG5d4ZUj/qtubV//4j0BGCwcSQ3PbcvJm9v0OzNciDm4JR/NulxyPJ8VaBT?=
 =?us-ascii?Q?YBadzeNbeLWQWVq7D+/FyG9Oe5khhMTeKKfo4WcACw03uminHZRsItMpThyG?=
 =?us-ascii?Q?q9tpxG5fPscfs4sx2dEwX40=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fead7488-bdd1-49d5-8502-08dd62e8b0e4
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 11:09:29.9482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YUqABgG/vI+q2qsVOlpDcCGq6ELQF1dfVX2up7D3jPWQ/do0RaBYwXjesdOaf7l1pdo0Js8vOhbsDZVInnRz0UPgIX6EsdZsEpsA3Ld/YjXc7INpFHwP8iFxNKzRyAF1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13332
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Mar 2025 11:09:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18213

Hi Pavel,

Thanks for your review.

On Fri, Mar 14, 2025 at 11:12:06AM +0100, Pavel Machek wrote:
> Hi!
> 
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > 
> > commit dd22e56217495e2d392ded86a1e11a908e424e64 upstream.
> > 
> > Add family-specific clock driver for RZ/V2H(P) SoCs.
> 
> So RZ/V2H... seems to be something different than "RZ/G3E" SoC. Good
> place to split the series?
> 
> > --- /dev/null
> > +++ b/drivers/clk/renesas/rzv2h-cpg.c
> > +static int rzv2h_cpg_assert(struct reset_controller_dev *rcdev,
> > +			    unsigned long id)
> > +{
> > +	struct rzv2h_cpg_priv *priv = rcdev_to_priv(rcdev);
> > +	unsigned int reg = GET_RST_OFFSET(priv->resets[id].reset_index);
> > +	u32 mask = BIT(priv->resets[id].reset_bit);
> > +	u8 monbit = priv->resets[id].mon_bit;
> > +	u32 value = mask << 16;
> > +
> > +	dev_dbg(rcdev->dev, "assert id:%ld offset:0x%x\n", id, reg);
> > +
> > +	writel(value, priv->base + reg);
> > +
> > +	reg = GET_RST_MON_OFFSET(priv->resets[id].mon_index);
> > +	mask = BIT(monbit);
> > +
> > +	return readl_poll_timeout_atomic(priv->base + reg, value,
> > +					 value & mask, 10, 200);
> > +}
> > +
> > +static int rzv2h_cpg_deassert(struct reset_controller_dev *rcdev,
> > +			      unsigned long id)
> > +{
> > +	struct rzv2h_cpg_priv *priv = rcdev_to_priv(rcdev);
> > +	unsigned int reg = GET_RST_OFFSET(priv->resets[id].reset_index);
> > +	u32 mask = BIT(priv->resets[id].reset_bit);
> > +	u8 monbit = priv->resets[id].mon_bit;
> > +	u32 value = (mask << 16) | mask;
> > +
> > +	dev_dbg(rcdev->dev, "deassert id:%ld offset:0x%x\n", id, reg);
> > +
> > +	writel(value, priv->base + reg);
> > +
> > +	reg = GET_RST_MON_OFFSET(priv->resets[id].mon_index);
> > +	mask = BIT(monbit);
> > +
> > +	return readl_poll_timeout_atomic(priv->base + reg, value,
> > +					 !(value & mask), 10, 200);
> > +}
> 
> Assert&deassert are fairly similar, can you share the code.
> 
> (This and the other cleanups are not critical, will not block merge,
> but may be worth fixing in mainline).

Fully agree I will fix this into mainline first, thanks.

> 
> Best regards,
> 								Pavel
> -- 
> DENX Software Engineering GmbH,        Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

Regards,
Tommaso




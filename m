Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10FC8CA0EFF
	for <webhook@archiver.kernel.org>; Fri, 22 Aug 2025 15:36:39 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.10])
 by mx.groups.io with SMTP id smtpd.web10.801.1755876991437527959
 for <cip-dev@lists.cip-project.org>;
 Fri, 22 Aug 2025 08:36:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=VU/Ps6Md;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.10, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wgFstyvpI/OlkUtZayN28l7o3GwyikspZEkgDrr4HhMomkbjlMmFBKWDim1oZ9ll1ILxtGcrrMUS3RUG724f6pcZVpWCmzsGFttPOWThjLAAX+/vLTo4VERIxx9xwV98iya6P6CkYDAGgvb09Y3iY5BDXJboe+0S7USnmX0ka4hKBuR7rFSi+gC59jDptEQp38m7FQdskXRm9KUt3A1Tfl6sUqYIXsKT317UgzGXsfotvTOhzQc3qtm9nbmqO2xK3hzvgDvkA/jE7+s88br3aZDsQtUQV21l9Hv0LzyvVj7V7GBkhlaBGO6HLJCHUWMe9byUEJX2zvL8MOtebYV+fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zh2IP+Jb85cfTIcjRhFCYrFiyT0qgxVPo5ZGcHi7KWE=;
 b=PqdauW89qM03v79Oy1IzTDLcI+6ovBP2shJjtshQoJyxdOkbvr4pAWCZxlTw5P4Z6LjgqH8lcIVpJpKZcolAowU9L8jSLrbZWQDJhGhYA1YyEP4M6A61ETeJc8wvQoCwcP3VN/P8jTN2Sqr/JPeWH6irfYFfnIXIWTRod4ZGPFbFth71f0Lzb9oM6mQ5q4x5A1/EPgn+AepRseu1oE44pPFbxmQLyadlfP3aD0MzG+9qpWbMUzj72hYxvCyuAZ1aEIpZLUdu6fBNYGKHMdbQPYm+Vu+CNAvfHiBPUdRF1D9cd7ONwAIDDQLKziLPG5yHlrNhImF3cJX+DH2hOVhBvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zh2IP+Jb85cfTIcjRhFCYrFiyT0qgxVPo5ZGcHi7KWE=;
 b=VU/Ps6MdYo4OBeP9G1HCMzlBApbGS/zEdiGM1hsmQsJe6LrFg3QovyiKfF+7fNAg2UgkWJVqggiQzEspyZLxvkOoyPFBqIee72lAovkvlyZq96Nl5hnOHwGkAMlyFv8xxagDTc7oZzuBHuYKFTSZEYEHHuJpnTQ9RY1KAFujxUY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TYYPR01MB12638.jpnprd01.prod.outlook.com (2603:1096:405:15b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Fri, 22 Aug
 2025 15:36:24 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 15:36:24 +0000
Date: Fri, 22 Aug 2025 17:36:11 +0200
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, tomm.merciai@gmail.com
Subject: Re: [PATCH 6.1.y-cip 49/55] media: v4l2-subdev: Refactor events
Message-ID: <aKiOa-Bv4-IsEjP7@tom-desktop>
References: <20250820160413.801341-1-tommaso.merciai.xr@bp.renesas.com>
 <20250820160413.801341-50-tommaso.merciai.xr@bp.renesas.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820160413.801341-50-tommaso.merciai.xr@bp.renesas.com>
X-ClientProxiedBy: FR0P281CA0095.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::12) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TYYPR01MB12638:EE_
X-MS-Office365-Filtering-Correlation-Id: 98aca7a1-714c-4149-7f05-08dde191a6e9
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|4022899009|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?vnAkQoW/o+8wfbKkuZx/PHMP6Ga/c8YmoZRvEwocEEFF3eWWKj1XSq9MqhKS?=
 =?us-ascii?Q?vod3efYWnubDEyOugaBGFP7fDsNgsrk0yA5e5lFKkrE2NPgZTum0/d9gIWW5?=
 =?us-ascii?Q?aagd+6bhQLDdnAEEISLn9jUyrqZSMd27GpUJjtVVASrqVohEzPTYA7Hj98yN?=
 =?us-ascii?Q?Z7S+Nuc0jSGvNcfPpiTAmXxLOApHtQSjaoDZUpEIMpn5ELRRsENCbNYh70EL?=
 =?us-ascii?Q?jFp33Drq0Mq48hw7M7rKkoubVSOKUZrmEuAbYaMCIJIWecWIm8FMF+FaK9we?=
 =?us-ascii?Q?pyPkBR41eJAdH9JrSH1DsN7NNPCfgukCicmYOfJcjxtLC5wuV20gaQubHxMJ?=
 =?us-ascii?Q?A+ula77o3vBSi4M7Aday3o1bEYNXR5NClE70/IA4aQEoHMpgu+mxFl7sonQT?=
 =?us-ascii?Q?85HpuXY/vMJVYP/dpks8b63ek7K9iwBIGeEUKaQxWHxEvVcVnfFioKOSzDLC?=
 =?us-ascii?Q?Reio6qDqnls9biOMm6LMBiLgvtLlZBlvL+7bnp85LikVtgAlJ1QsNzZVuMct?=
 =?us-ascii?Q?DFxvdrST60RuHwwg0DcDKhvuxlo0MOGLw7PghIQiYeUANhRHZGa/8/sR5tRM?=
 =?us-ascii?Q?7UF1AEhL3gUn3PXz+gpkJIY7D5QomfkAFnO5oCu6aDHMvZNVrTtPyMSAGuIQ?=
 =?us-ascii?Q?w/QTeM5J5t+vyzWAJXMKJ8P+NjewO+DKuQCoRB2C6HHPeNQntwb3koSmuGXh?=
 =?us-ascii?Q?05Yo5JQG9Pn+ISrhqGNfTWnwm3pNWX3NtwaXbQFHvbEOGXJ73LyGiM6qpqUx?=
 =?us-ascii?Q?bCw/CyZfV1xwwX2DyxzP0lYgH/sTRyJEUTK9+33o3ImOX3zSC2CQtzXnw0Cc?=
 =?us-ascii?Q?lA55UgWEqtbYN6eIyFvJpNuU6OCShHN3CubjaF4DSc25lslY9UGD40Ext9dL?=
 =?us-ascii?Q?6QNhhpPxaR7KW5uBrywSLBpI4wJXPD439A+QSyKYmcaFIlKHzYLDJ1oS5J5/?=
 =?us-ascii?Q?da/fhkS7O1+H1T6u1i94ICsW8ef9bksEY2QfitOojmXtfGSQl/Ow39C1ZWsp?=
 =?us-ascii?Q?328SB2ZtMG3xAuMeEkAoeKx2dS6ili+zzMOR4eO7VlTuX76PN7QQUTPcXFub?=
 =?us-ascii?Q?KAeexiTq4cxUjZ0yT10SD0MHoeW4pI3ei6GeTRWweUbYyJHnmRkgeSmqdg9N?=
 =?us-ascii?Q?Tka981HyX/vteqFDEAWquQHm0mMqC3EhTCdlC68fdFy525EF9OQDX+4gtANv?=
 =?us-ascii?Q?LQ6ocVc5vVZz6mhuo4aIC9POznAJIF3wTO7Y4x4x65wMfQTPdHsgWKsfyyJM?=
 =?us-ascii?Q?OAX0m0j9MRhynZk1lPK3vBecx2ogx6ly3xbPny0LC6p92ewYN6iOSJOrHluj?=
 =?us-ascii?Q?kFXo41yQB2uSSNjWFpB0Ghkrc+FkIX77qc6KbBFMoZ19+gawrsc1QQud8WFG?=
 =?us-ascii?Q?WX23oyJ/iWyEHmL3+BmKcnwhhQ7AqODYsJE9Mg9IvEXNsELQTBkzmnac/yEo?=
 =?us-ascii?Q?nSoBNmwDHzWJQKkXuSOcqyvXpwpc0y4VqY0QAUyBkutaTKLMh2I2Sg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(4022899009)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?cDdkMeIrJqKwKyptnlmhqyziRREMmrszHObRHsh6tbwnEC01uA1h9QS0kn9d?=
 =?us-ascii?Q?M3aeRVgVoxK6QLAUcJm+8tekIJOtzqY1IeV0T1gL0LfFap7WS0d1vIqEMdnx?=
 =?us-ascii?Q?jE4BCiCvHF2Z5CxZYuZDu2G2aLkI1OmVzrUt60GQQLna0D62HYdGr+XOHYqh?=
 =?us-ascii?Q?CMYyk9XxAm3/farB7b6DnBppYer7iK/OnBO4ljQDMOcLjG4L+iyJDR+MXeDl?=
 =?us-ascii?Q?tKvZi72d3GifIzblIw385XREyBQc4UZIfzrBeM/8TTOb7bCAZgIUAP7ezvba?=
 =?us-ascii?Q?qCJOj6FGm5Vm80cnFw1VIDWBFa9ix2ifhytxvqBOSHYgmcjyrwD74S+Tmpe9?=
 =?us-ascii?Q?4x2394Oao1quXq+PMI1sLzI8Cyt+eM73wHzNGE6eNXNGULNX2KY6WQuOdL9/?=
 =?us-ascii?Q?dVZmzTDPnwtc1rk6msxZZJktBDx2rgoLB2C/CQ99yBItdjud3i/9oyhgKppd?=
 =?us-ascii?Q?v/TTVB8cZ7dKApmJ3iq4qGsEoy5eicUA037SsL6G6V6EYxzH0y5dIFqJ4kwY?=
 =?us-ascii?Q?J9OPaPiErDbrwHzeHQPK2YmPT4+DsmDrRzoPQM++l9B1oYA5vgCthfax8SAk?=
 =?us-ascii?Q?ndt2H1NBmlB/0OAnuosmnPXtX42tLhnXXd4HAwDz7UKT1QHqpX3zzjX9ULRm?=
 =?us-ascii?Q?UkiJuhDvYdhRX8/2K06L6uevZd/4TFJUZXqeaMS2W8iA9TFhjbrLPF7A7v86?=
 =?us-ascii?Q?4k3enTUWyUccnk4ozkBGzfCmKIFZpandOgg44U9xHD0JiIAKCIe9FL3GLvqW?=
 =?us-ascii?Q?kFli0eV3pjDakS5J2FUbufG8jVBnTuUU8q1xlRAHmE5KqG34C/3hIEpNuSiE?=
 =?us-ascii?Q?h9doT6X/vVY2PgPi5+mveoQ9kIK0vAKUmLqNMTrLA2nyp/aNqXATnXdACVAO?=
 =?us-ascii?Q?fQrcTIwPScbSp5L4r/OS0ZQCLWBsFa98OtRysUedJMkC2f//N8Ag4IimaANJ?=
 =?us-ascii?Q?6pKMxsoPrAQJWyvgnpnVlFx2VP3ma5FqejNTdpRG2YIrVbu9StZqXImKkaoZ?=
 =?us-ascii?Q?jXijWiAbj9L3B1ukwgRB35/EYKFWw3aSsogm1IdEZomKyw65vCunLALEYErd?=
 =?us-ascii?Q?fAeotsu/pCUatBhQ2r4HsO6OzJK0GRiGNunZrdSkEGFUJTWLchjdjfzz5UJc?=
 =?us-ascii?Q?qky3n/k28+7ozAB4K2eV6moFOzDBZahMQMR+il59/H27UxP2MrQk8NDzlVG9?=
 =?us-ascii?Q?7oUR+q974z3aZTprLPHycbUoV5RkfTzw2EyljiSIniydoc0LoaxlJhxIEBfP?=
 =?us-ascii?Q?MXccy1viGhEFMetYNZm0sijKaF/rjDiqytOEfTjYV4hcXQS1O2+HRSaTR4aL?=
 =?us-ascii?Q?/rEPIQRUAnz6R90r0Oi1IM8rRdm3I5n2diHAYe4gNHPqARgBu2wzoQOXlqs0?=
 =?us-ascii?Q?+Wg9lXLiWYqmf3vDuwznMsCX4F5DsnSh9g6PenJNSuh+t04j7iU6+4jBMqEu?=
 =?us-ascii?Q?BhdFsk2xW/T4RUzwZWCzt5n9JLc3SQ1B99iOMpoiUSBsCI+QxUES/hISQWA6?=
 =?us-ascii?Q?Vi0TkctHTswc0TYI6Uw+Nt6IwHm83mKScqyWecagXe8orSeLf7OfdJsseti1?=
 =?us-ascii?Q?RoFx6aNCbGl7eS7cg9jfqcyURNCVyDUnzqtaMmoHFxFwBDjC6l+LjZJTB9k6?=
 =?us-ascii?Q?MiwvUVz2foLbNmYQ/Uu78gM=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98aca7a1-714c-4149-7f05-08dde191a6e9
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 15:36:24.6977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6rIriEHCWbdfrTg4PqHbi/U/YSK1Jf6bDNT6yvrjyAkKYi0l9iJ3GF3+PtkBiBU+Bzioyd05ebfHO2ka+fkfmPMcZ1JNAwxQ2mPF7mdFjtj2e75K7m3u05RR7pLBfU+/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB12638
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 22 Aug 2025 15:36:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19951

Hi Pavel,

On Wed, Aug 20, 2025 at 06:04:05PM +0200, Tommaso Merciai wrote:
> From: Tommaso Merciai <tomm.merciai@gmail.com>
> 
> commit e7724e23196ab1b4bc843aa60e917967d95697e4 upstream.
> 
> Controls can be exposed to userspace via a v4l-subdevX device, and
> userspace has to be able to subscribe to control events so that it is
> notified when the control changes value. If a control handler is set for
> the subdev then set the HAS_EVENTS flag automatically into
> v4l2_subdev_init_finalize() and use v4l2_ctrl_subdev_subscribe_event() and
> v4l2_event_subdev_unsubscribe() as default if subdev don't have
> .(un)subscribe control operations. This simplifies subdev drivers by
> avoiding the need to set the V4L2_SUBDEV_FL_HAS_EVENTS flag and plug the
> event handlers, and ensures consistency of the API exposed to userspace.
> 
> Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
> Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
> Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> ---
>  drivers/media/v4l2-core/v4l2-subdev.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
> index 5c27bac772ea..423e9663d149 100644
> --- a/drivers/media/v4l2-core/v4l2-subdev.c
> +++ b/drivers/media/v4l2-core/v4l2-subdev.c
> @@ -502,10 +502,25 @@ static long subdev_do_ioctl(struct file *file, unsigned int cmd, void *arg,
>  		return v4l2_event_dequeue(vfh, arg, file->f_flags & O_NONBLOCK);
>  
>  	case VIDIOC_SUBSCRIBE_EVENT:
> -		return v4l2_subdev_call(sd, core, subscribe_event, vfh, arg);
> +		if (v4l2_subdev_has_op(sd, core, subscribe_event))
> +			return v4l2_subdev_call(sd, core, subscribe_event,
> +						vfh, arg);
> +
> +		if ((sd->flags & V4L2_SUBDEV_FL_HAS_EVENTS) &&
> +		    vfh->ctrl_handler)
> +			return v4l2_ctrl_subdev_subscribe_event(sd, vfh, arg);
> +
> +		return -ENOIOCTLCMD;
>  
>  	case VIDIOC_UNSUBSCRIBE_EVENT:
> -		return v4l2_subdev_call(sd, core, unsubscribe_event, vfh, arg);
> +		if (v4l2_subdev_has_op(sd, core, unsubscribe_event))
> +			return v4l2_subdev_call(sd, core, unsubscribe_event,
> +						vfh, arg);
> +
> +		if (sd->flags & V4L2_SUBDEV_FL_HAS_EVENTS)
> +			return v4l2_event_subdev_unsubscribe(sd, vfh, arg);
> +
> +		return -ENOIOCTLCMD;
>  
>  #ifdef CONFIG_VIDEO_ADV_DEBUG
>  	case VIDIOC_DBG_G_REGISTER:
> @@ -1023,6 +1038,9 @@ int __v4l2_subdev_init_finalize(struct v4l2_subdev *sd, const char *name,
>  {
>  	struct v4l2_subdev_state *state;
>  
> +	if (sd->ctrl_handler)
> +		sd->flags |= V4L2_SUBDEV_FL_HAS_EVENTS;
> +
>  	state = __v4l2_subdev_state_alloc(sd, name, key);
>  	if (IS_ERR(state))
>  		return PTR_ERR(state);
> -- 
> 2.43.0
> 

With OV5645 part can we gently drop also this one?
Thanks for your work!


Regards
Tommaso


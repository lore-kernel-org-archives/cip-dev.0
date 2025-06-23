Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC2FC77B7F
	for <webhook@archiver.kernel.org>; Mon, 23 Jun 2025 13:45:10 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.71])
 by mx.groups.io with SMTP id smtpd.web11.20081.1750686307720459717
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Jun 2025 06:45:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=XdT0lP4t;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.71, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PiH/wxISF1lqH3qMXHDNebY9jD/mfTTVBcWMlTkQNxaUd6t27275aq4yYedj6TGTP9XD1zIMrI07FPQnHNg4pCqNgkfVpdZOG13NVkgXg+UbHccztOxG4g43JBtIJ8oWfqatH9RmtGX+0H6782Xa+FE8/mRqgXSoIU9Em2yIDTnyT++Fo/59MGTkXa77Ix4Pc+e+NJXDxPFZ5ZHx8GI4rgVcSVWxZV0M/6ldxTOxmxPOzN8xS1J5X9edOQZdkRQNBN7PKgylY+qnW03S5zuCrB7OI0Uvv5LHnWJ/0ntXaNkmbgQmDvkDGt621G8TwbYP83NADp64ElG1KEhvHSi8Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hJPvsX7DhGw6aiIVR7C2V7yxLyrLd3YXWaE0sVyeyk4=;
 b=tVtfAdn6w9/XLOkmy03piNuNkmA8NyYaYr7xbH+0tTV2mzRbaFWh9FWN4127Ors9qZot/nR5pVirW5ZsQ62jtzO5c+M77sqnpGLEQW0I20SKsPq1R9/Bn1twMUcky7yz45OS2S1+XecdO8hrNs3kNPedecqGrxYYkbVCBwd2DgKF3YoGSTX/Xgiy62j1rwdj/PtiQffkAsq0RMigZ0D866yTqw5VAsbWhBFgsWlcP/ZPbQbBQvmpk/xp6Ty8NvaTXW3+57DaL5CRxYdBEF0BUHKj0B2pIyX6TJwGkS6X917yLW+6pyg+t2HegO2JQWIA2HH8VgUfJ02p7k2uZa1ZYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJPvsX7DhGw6aiIVR7C2V7yxLyrLd3YXWaE0sVyeyk4=;
 b=XdT0lP4t4AwurQvLZZCFv9MgjiXavx8cK8t3+W0UgKABsfJLyLmOu5VChrpHlQC7kbWnKIa2+zSBB6B8Dy9XRWj8bjx8Erqq1cZnVkeqPxaHZ/btne8EV6q/DW2txv87IkkBUP/6w85IJWnCCEu6YCnSTkzm6AAqXRjVbbGSfq4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OSCPR01MB12914.jpnprd01.prod.outlook.com (2603:1096:604:33a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Mon, 23 Jun
 2025 13:45:04 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%6]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 13:45:04 +0000
Date: Mon, 23 Jun 2025 15:44:52 +0200
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [PATCH 6.12.y-cip 0/7] Add support for RZ/G3E WDT
Message-ID: <aFlaVGHDs6A4yHR1@tom-desktop>
References: <20250623102857.1493371-1-tommaso.merciai.xr@bp.renesas.com>
 <aFk2QQJUVBuWYKiS@duo.ucw.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFk2QQJUVBuWYKiS@duo.ucw.cz>
X-ClientProxiedBy: FR4P281CA0074.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::11) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OSCPR01MB12914:EE_
X-MS-Office365-Filtering-Correlation-Id: 727f0fa3-5a64-4a3e-7afb-08ddb25c2864
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?i0i0czrxaD/H8puj/xNvSvdEKtmUyFb3S0DqkubhoWmXW/NzcYfpiSBg+gyB?=
 =?us-ascii?Q?rF3BD4DSpCGxXQ+AjhAPPH36IcdLbMBdIWES2nFKw8IiQLBh48ISUxCNndm5?=
 =?us-ascii?Q?VLuRdSgTAetWjxppILnXm856n83QqEj7hhFBec4OPfY0g4h/EDla5EE+2ojV?=
 =?us-ascii?Q?e5HY3c0d9n27r9OmVbUG8bTYrtf/QDFPEUC0/2VdTFuZuQHxhRnrN9fn5+Ji?=
 =?us-ascii?Q?fpB7DOUyDgWWo0KoIHFUx9gEco/37BDwmSq8I6kzdlVkfPJcQtiyHhKI+HpQ?=
 =?us-ascii?Q?HhZkgZjOrZvGh3DaUiTbh7NurnDE5voMtbHf/tSCKVh1pVQ31kTQRA5UmRIr?=
 =?us-ascii?Q?mI2qo2MxnfQuLs3qmGYNsbvI9OLWaZGP4Gvvn4/RYmkJAtuPBVA9ZbpGn9/l?=
 =?us-ascii?Q?qVDk0tvd0Pfxa0ahYMQi/uQB7XHRoZRWDLTHC/R1bod7znmtNYpb9FXpykra?=
 =?us-ascii?Q?AvcpwyrmbU5kNZkrjrjRBKl+bsLNcu1FenECs7hDMRiBzjkY40/Dri4PPTQj?=
 =?us-ascii?Q?OaQtB6kVhKlkmtxuzrstie/L0KYkUqR3rodih3AeJo0W1DxO3K90kQT46ary?=
 =?us-ascii?Q?aa3nmihDoJFxshBR22Tnd/3YjfSlbMMwTjl19FKftO4SkwiWo00VtV/g7SC3?=
 =?us-ascii?Q?0Rvbav92ta7rr4OWEYv3DUr2bx3FZW6gGJtEcjNM4KGDb2oak7kWR0DMPpum?=
 =?us-ascii?Q?cPffcAAzIpRXM9MFn4X8QXHb091GA/eTrehlTgWc26rhuqvwhKH/Qp9mYUHo?=
 =?us-ascii?Q?nfWgDXHGTNTJu59TR/nkEk6H/FeOEwdpcxFWbgXW9f7B6HkM8TSPxa+4Jh3C?=
 =?us-ascii?Q?de595o9d+3jlnRSbRR2YnWqB2MLSkt+iN12ELwzNsk4+/MvYz3FN4PES5H7E?=
 =?us-ascii?Q?tPOTvjypBJs3TD9G4r9Y/ekkkAq2Va6sfYlrzi6p6dBA0XmI/OO01dNw7Q/7?=
 =?us-ascii?Q?fCfriXaRT7claANv8FnM+o188G8/QNma/hZN3JGfyv3ugQimF9FtMTaalGFo?=
 =?us-ascii?Q?6MtRhXACvZkJmPd8oAd+/kjEzY/UGPUcNZIWw5Ab6HPj4Eosxd1ptoR1lIeQ?=
 =?us-ascii?Q?tGxzR6lfveLmPcE7HY1FsW5xJO1TTbBu/DCFDJ5QrwpQ0Y6C0W84LB635qve?=
 =?us-ascii?Q?HgxOH/ci1UhIn5fcce8KexL7WQmUMRVtLkzS0UWZarZu6q5hiusXxQIqpINY?=
 =?us-ascii?Q?wSFnRRoDqpDRA894vw+wzTpOw62Q0PTyMrzf9IVZdQW0IPonH18z6pAoMd53?=
 =?us-ascii?Q?g7KpSZrq4eE6HeHhPWKKLPxsSCQ6Yx3AGPaoQxyi9UrD+ynhtVX8xWyf+D0e?=
 =?us-ascii?Q?SBD3anRpjbf7Woair3vFSyFIaXCmN5rovlFl8NMN5g9VsZT1cylAGBUB4AEo?=
 =?us-ascii?Q?cNLXGSI1sT55nUDUIqG4o+bywUvrUSA4iwhM1DiAkx1RRGUm3Nlbw3sbOP3n?=
 =?us-ascii?Q?Ytgf4hLi7OO/ywMas+hyfrzKEE/6LQmG/Djbc1N/Vq7nJgidoKjnZg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?zU7VV+Vk1cOioEmZKDQhx3whh5PgsZ6pEa1Lh6tCc4WaSb5IuqVQIRLqyPNU?=
 =?us-ascii?Q?NLnO7qOAamRqzhpd4vJBfjU8Mx4gSgeoAPJn0spT70cPvX/5u8sC/5NiyqaH?=
 =?us-ascii?Q?zECZEB5HYx2xoc+/ePkFeD/DVDbtrOAhvqkhy2B9nYCm/OKF+XltYznTy8R4?=
 =?us-ascii?Q?IHkZDSSGqX4HylL/f3kqx02WmuUuoswkpGz/3EeJKTbkF2aoVyic4Bf8hKcL?=
 =?us-ascii?Q?sTOKyjkIzoTtE7Y4CcyQE2h3MzxQOc3rEL/1b4E/uvpuu3IaFXJ8Yv9h724N?=
 =?us-ascii?Q?eCUYIH/qFwUFzIGz7j+kTpy9X5q0sF34pWlAGIQ6hVpaf1AR+10Tvu/lRqte?=
 =?us-ascii?Q?eyETgv7WpYDKJAJoGhvzr+42XYXFz1lSLoPqsiSW3Xcg398GjCeGMWG9zP76?=
 =?us-ascii?Q?QOmxwHAWQCMrykJyQ2I8x6ANwGd9dF5PIdQtCe3DxkkfSUqZs2ueP+w25qns?=
 =?us-ascii?Q?/Xc0wquPartFvneEDZwkyijQIeTQknfNkWdx7zpjlrt86V3Kmc/cJ4UDlITJ?=
 =?us-ascii?Q?W29P8ez94vVGC3VfRUqniK44UCEMCacK2quoXkBD06fb7DwSWghH+QRK6hVm?=
 =?us-ascii?Q?+xGG2Z9yXj+wG0ifGhe08dWKtaqZGYdnr4Oe4yTBRiFuub6J2Ef7K8+C+J8s?=
 =?us-ascii?Q?93QpfNzI6r3EkxtgcCD/5G23MWCQs+0CE9jR49Sa3oRQgsUM5E5apguX1LEt?=
 =?us-ascii?Q?uBTHWVrbOiYKwZ5LCbV9tAzLar38MgERETVs2C5+MbdXVXOrKl+e+E0B4vAo?=
 =?us-ascii?Q?+OJKss7XQZBBXtO3dUpQ6Hy+JkI3X2jtYqXjtca9g8z5z4odvWs4mmcg2eyV?=
 =?us-ascii?Q?1osd74LaBHPPWU9ztZhXBDG6vZpmaWy+9/npPXchn4qlkbMAUvcD6uM9fc8s?=
 =?us-ascii?Q?P9ioWqm4N3HUsvrsKsPWSbd3LeJlhmCN36MxxeqsiQddCDqThv0vHmURUI24?=
 =?us-ascii?Q?wbhoxnda8GA0pGXlU7hheZyyJ0HkLHbQwzAUxlMj4FO5+qw6/OxAiIhpM0Tx?=
 =?us-ascii?Q?zyBARba5DAfSqHhpC9vWpvYsN6YM1put5F+m5EJ6+3+LILy5bbm0uUmnApbD?=
 =?us-ascii?Q?jZ5GzXVoHf+KujvYY+tI0oxeZ1rvqBp1x6HLjvvPU+hOtABd6wADDXxFJLpk?=
 =?us-ascii?Q?1j/ZOMEKqdDMRYK3ia6G8jOLOY30AkpI7wiBaznNOw2XgJ0NWyRQy8QAh1E6?=
 =?us-ascii?Q?bsKJasLyVhbu2epLfaM+GA9Z7h4iPiDWwGwMI9c0qeHxJkWDhuDopmDwNG7x?=
 =?us-ascii?Q?BelrJ3t4a4g6ZtFKbgLS53R9K5LYKuxmO/G4z5pJL3QDU2wXhntGU5JdJSrV?=
 =?us-ascii?Q?ou7QEPM9WmmEFFvkcQBKP1facuUGhxL1vBsJZXyDxbCVUdhKm47cthe2INBi?=
 =?us-ascii?Q?uMCRbWpPAGJOVWKZ14pWkFwQRtfFjlIaqUkmN4Bntx7GicnI4t7pebMIMsh4?=
 =?us-ascii?Q?YdlYzfcAvtC3N++4IC8KfK2Qu+naq4eB0AWdVLcHAXEkL51riy57IV5EsDJM?=
 =?us-ascii?Q?j5sUXY/4IjXGUcwO+cP6g0ZODHWhjkO8/owVyNrrQuXwDbgnwZ47xCiid670?=
 =?us-ascii?Q?Ucn21duta71YlT44zvmwXKCzYa+MkcX6Hr7GkK/1wp8KuwEturPWkedgvadT?=
 =?us-ascii?Q?btvCxCObawnWvXINt9ROJoc=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 727f0fa3-5a64-4a3e-7afb-08ddb25c2864
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 13:45:04.1672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FCOkmvn1++XRrZvC0sTZYMEC1LZx+oVRrOyoJ/JUYcQALQ0szAYWV0pHHybUW4yamYtNn2v1StAtZwBffehY+XZTPuMdSA1tdLhD8F45KirU8RA0sWwmm+2BPm7KEXPt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12914
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 Jun 2025 13:45:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19186

Hi Pavel,

On Mon, Jun 23, 2025 at 01:10:57PM +0200, Pavel Machek wrote:
> Hi!
> 
> > This patch series aims to add Watchdog Timer (WDT) support for the
> > Renesas RZ/G3E SoCs.
> > 
> > The RZ/G3E WDT IP is similar to RZ/V2H WDT. WDT0 can be used for CM33 cold
> > reset, system reset and asserting WDTUDFCM pin where as WDT1 can be used
> > for CA55 cold reset, system reset and asserting WDTUDFCA pin. Other 2
> > watchdogs can be used for system reset. So define WDT{1..3} in SoC
> > dtsi.
> 
> Looks good to me. I can	apply it if it passes testing and there	are no
> other comments.
> 
> Reviewed-by: Pavel Machek <pavel@denx.de>

Thanks for your work!

Regards,
Tommaso

> 
> Best regards,
> 								Pavel
> -- 
> DENX Software Engineering GmbH,        Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany




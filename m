Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 792AAC3DA7A
	for <webhook@archiver.kernel.org>; Thu,  5 Jan 2023 18:59:22 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.66])
 by mx.groups.io with SMTP id smtpd.web10.1115.1672943207120626701
 for <cip-dev@lists.cip-project.org>;
 Thu, 05 Jan 2023 10:26:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=DOTtunHL;
 spf=pass (domain: siemens.com, ip: 40.107.249.66, mailfrom: henning.schild@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kJYUI0XAIizTQ1QH9a4VFbbFnyOyTR/EJpGTLK4FW6UwtNUeELwThwEZ/w3KwuTHWC+Ulaa0r/i50MhCRdxHW1aB+OBWQd2WEv2FzOIWaYtjsRwliCEIfj5HE3uI4pawfGUlw6AFWPdS4uQ1C3HodA45sd30LyocVE14kZohipK3NL8R0Wfg9Bb+jPkokFc0r7wNXEeBy8GBWBhBdt6ZcJEs4+QhjKwE0P1KTZXV8ibFvTpTMGA9+DNiO6fuRuLPPfmXUushuYimwlib+CbD1ohZdFULTCL6rhvEnMYrLaporiKUnBi9NtibxXk8gaDE8TK8Hn9vOxJh91eqhRw5TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Y3P/NlSOKC894c6fI/uzmQitKLsQOs+y3UN3wkMZmI=;
 b=M8PvOsOKdwBAI1H3xPy1EfVAfKiYC3oMgcHvLrBXFsv/xzG8qNGGVBsM+WCOC95Mj2dVnjFiWROoeYh20cEv7wbE5YDreU4LiSuUMYw8dRPNe13dE0PwEVD7S7o/ZHyiaxgfBG5RpAYzmulU1YHQYUoQ+bzKp+sLmeRzhTCsttNkn9MnfS8nD1um7G3edLEjXiys2HOyh2bYsbNUFF0XngoBs7ZWRnbUpOh0n8TBRMgcWU4Byp6rvw4JPc8L5lWtAtu2JQWnYdYCS6rXkGwpz8u+iq6blUEhbUPZflyd/5ghlDd4lAKhi/gaO1UeNVyBbjMDXIGzk+9qZUa8kIPoDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Y3P/NlSOKC894c6fI/uzmQitKLsQOs+y3UN3wkMZmI=;
 b=DOTtunHLg6s51BhMEAoLESdnOYeLOcOnZr6nzqrCsfxf1+9uO+ZLSy1cxG6Iy4i34S+T9z/sTzLqElmNHWDoX4Z3rgLRJEPI2pxqTqnOIRJ3lPnLdHWQ5HON5U/wMINDW4Mg4t0EDgcW8UZt3U0INiT8BRaKV57I02kLpPPfF9dw/XCM3XspdcTQfn6RhrF0BDRqw4Yg1YWp/aBcFGeK4ExD+0ioUL5ewevzIjFDdzWKo2UKmpq2HTXlJvaYdz0G8fa8IT+QFNJnYF9WuCHB0Y9rRO4/ZFAX0pRLv66tC9ok//h+/wWc9Z+ZugcvLVf/lKSnuebCHCKdiuaiFgnnYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by DB9PR10MB6740.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3d0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 18:26:44 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bdf0:fdeb:f955:bc79]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bdf0:fdeb:f955:bc79%3]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 18:26:44 +0000
Date: Thu, 5 Jan 2023 19:26:41 +0100
From: Henning Schild <henning.schild@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: venkata.pyla@toshiba-tsip.com, cip-dev@lists.cip-project.org,
 dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: Re: [isar-cip-core] security.yml: Add root user credentials in security kas file
Message-ID: <20230105192641.25035159@md1za8fc.ad001.siemens.net>
In-Reply-To: <ad475583-af1c-c0eb-b90b-50496c375d63@siemens.com>
References: <20230105150242.21236-1-venkata.pyla@toshiba-tsip.com>
	<20230105173359.731cfc51@md1za8fc.ad001.siemens.net>
	<20230105173710.11c19271@md1za8fc.ad001.siemens.net>
	<ad475583-af1c-c0eb-b90b-50496c375d63@siemens.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.35; x86_64-pc-linux-gnu)
X-ClientProxiedBy: FR0P281CA0129.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::15) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5780:EE_|DB9PR10MB6740:EE_
X-MS-Office365-Filtering-Correlation-Id: bb44eb5d-1997-42c4-52be-08daef4a65a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	gJ9vYCksHz5IRueZRJEr/9OfGmU6r8jorXK0pZ4lMZg/ml19sg0onZ9w2GpkK5EH/OQJnID2I80cQCCNZ7O3YDZ4jTtO/UxQbv5OrOVdNLbeD4Sso8Roo+mIGpFlhD7R7PTG8U8QBsKZWN4Kp64lvKb+oyzWK6i9O7SKLOgerz1Jj8J7V+23T15in76d9F0wj5cHtvywPjn3ZDTmfOScoRT82Hqb7Ok0DHlNyzusKGTKggRW9ehlX/w/t0IWJK6VhAFNQUuEdQsRIQHBITmHvItzfBw0vkTml99VrqZwUneYhWNUSxR//0HV9p0hsGxdojS9OQ6uuTmd3rjU5jwOsqAzz5kLC3ef2TYcdm4uuxf8/FAQ8Lg+3E0dv7zuJE1sgPXIMjFcr+Lkq8eVRHSJf0rKtLFuQV9mzzlSyx32Q9oWqLBq9D20Rzjh2cpajBzKHsc8Y9a2LmD8mhPTc7nTNEqoFS9kvS0QldCVh4TYcnpBmP2bSMsTqed3EVaCKCxqQJQUbYimaN1asc42l2f8KU3h3U/Ovl71KVRdJjBswQe566DTMqWY4/52Rn93UzlDRETe+5rEzcIkrTN821bdCE2Zkj71VjC/gg3uPagJsL9U1MEBkTuXJnfPAGS7IyX/yr1asJXnE7cVhGQlVqUvpA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(396003)(366004)(136003)(39860400002)(451199015)(82960400001)(6636002)(86362001)(6506007)(38100700002)(53546011)(66946007)(66556008)(66476007)(6486002)(6512007)(478600001)(9686003)(186003)(1076003)(6666004)(316002)(2906002)(4326008)(15650500001)(8676002)(8936002)(83380400001)(44832011)(5660300002)(41300700001)(6862004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?F835hQQwgQ29chTiZTK4b/fwrd6HDWRQhdmqAPYWgXzfFzW2kXloLpcd1Zfj?=
 =?us-ascii?Q?/Z9NFkgxvY5k/LMmN1s36xRCd2PmoOfMgMQhD3gM/OkOneKaIiUs/VmyUgRJ?=
 =?us-ascii?Q?3HXSwcR5lgy3283DXXV7UXBAb8/TnP1UZI/Qzk2fFfeMrdwd5huKS4cqzEUy?=
 =?us-ascii?Q?jHl/Vr9TXe4qhejPoTqs2e+ZxLRQuqfHNEbM+EsqjzcOGmQPniuaIx1XjS3j?=
 =?us-ascii?Q?PWLYTx/ZkdYuFsNEJD4X/USO92OWKRhAQP/ccQcGZwh5fVkCW4Kgp/EJ1UFX?=
 =?us-ascii?Q?BPx9KATQ0KxVW4jUq1Jse0WcV9LXZmNQhbK4tqO4FG334y7rMU9rRtlgswEe?=
 =?us-ascii?Q?RK+Nq7XMHEiqbRNr6LGSEXE9p9bBDsd+xwjrTSWBt+rTZ5QaJ/G7GRTc+9Zk?=
 =?us-ascii?Q?0IHTDM9Q8GW2MUoi0zOl1l93bC1pIn9AwhgOepT4yayaH6S/m6fc5gTOuCod?=
 =?us-ascii?Q?2PtQ4BaX/q4wQO6RwkyDf3KBl0z2vcXT51Gg/ZJVAP+bcRblARKORtZBOZVh?=
 =?us-ascii?Q?nUvGEFx21B7F8Z2AgA4H9hE8tPzbt3fFiSqD1mo+dKHzGPh9UOP/DXNaveS7?=
 =?us-ascii?Q?tvJYHOE5Ixcw74zGQ5c3HXKULcifjA4925j7EtzQ3Z1qnOtF+YaOC3M/hkqi?=
 =?us-ascii?Q?pPMJhG4UpW8ys0EvHYI+UHaCZW2qQygkRtouZWxiIYaxeAmU/lNmJpYozjDd?=
 =?us-ascii?Q?NOtnHXeL2ZFgXrbPoNwcJM3Xz9AkBVo+i44b5pcTg27QPKLHMiPnpZsxuSG6?=
 =?us-ascii?Q?kZxHza0kXd26KCxrdhmA40J7igwQvxbbMY5kx5Lel40FkdMkKHfNiqFcf8Bt?=
 =?us-ascii?Q?LGfit+56NKH8fdsOH56Vxn3jpV9mJ+e38A+4xzvXVHI62vSpb1ieDRbeCFLf?=
 =?us-ascii?Q?4EEVoh9c4jopLXNDa8fF23X3fhfan6ULxA7GGztaAcbJKWeC3AsubaMCHS6w?=
 =?us-ascii?Q?47Qou8WAvzvVp0k8+bWv0ZjEq/v+Xl3NMPOxHC78nJk8aytiad4tGXbTe9W2?=
 =?us-ascii?Q?86gMuJjOED0fjdVnY53l9BcD/OHMO6qdDzud0/mXNAZ3Hc6TnK2D2Bp/BT1h?=
 =?us-ascii?Q?ClOKo3YNs3hgfo6fgAoTR57DROdU9YQigfnEwo7hwdHr2I/cRx6rBZFXzEvT?=
 =?us-ascii?Q?P9jlJzq4NwmJOddPVz6x20vVWXXLR74/0QLoLqEf8sl5DSxGEgpomLRZE7I+?=
 =?us-ascii?Q?QJ51TqW6W29rNYnRlJKrmSsQASXWFf5KRdKfH7TOeJXIeLvIibEK1QngPhP9?=
 =?us-ascii?Q?g7XOFkA9H0d/pQ5NUvM52SZjyAULe/KrmeWHxj/0joIklN118kPZhZTd8ht/?=
 =?us-ascii?Q?6wX4TPV2YVVo266ke1MI/7cpKQ6J9V7QGxfFXmqC6trwjRlw2VABmCzb+XiX?=
 =?us-ascii?Q?i+m8BMXsYKCqwZLJF9RmeqKCl8ENnN04wtcPXuFCa3XCpaRk2DhG7lvNsln5?=
 =?us-ascii?Q?neqi3P0GcaH+aZQSCuLWtmC5B1IQKt/wjyMgUsT65puTL6uhXejNS0VhYouG?=
 =?us-ascii?Q?SDMT5jVVIV7eaE9XIJmLjcWuluV5sbUeWolcBBRTJhsPITK8r9LBKtbRnSMT?=
 =?us-ascii?Q?Ju1AYISfhntYuSN/1o36Yw+fBlqnWLXlZi6WgBuQnrudW4SerqBrA8UaNg0/?=
 =?us-ascii?Q?3gUUz6/y25FrNwbM4Lsv/QGeefu/Gt92XbtwS+wLuK2g0a3Ew/D8TgfDKwSW?=
 =?us-ascii?Q?vINgDA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb44eb5d-1997-42c4-52be-08daef4a65a7
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 18:26:44.0629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EVAjT4lmk29B/GuzthozJGd6yeUfjTBcLfhpMauQJkEWJ0tkIbaVLZzdrt0firldFzCFAyU5QJ1pWH8aavBYTRgpDURDfcuMJYDAUBi670Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6740
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 05 Jan 2023 18:59:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10328

Am Thu, 5 Jan 2023 17:45:44 +0100
schrieb Jan Kiszka <jan.kiszka@siemens.com>:

> On 05.01.23 17:37, Henning Schild wrote:
> > Am Thu, 5 Jan 2023 17:33:59 +0100
> > schrieb Henning Schild <henning.schild@siemens.com>:
> >   
> >> Am Thu,  5 Jan 2023 20:32:42 +0530
> >> schrieb venkata.pyla@toshiba-tsip.com:
> >>  
> >>> From: venkata pyla <venkata.pyla@toshiba-tsip.com>
> >>>
> >>> Security image creation imposes a rule to have strong password in
> >>> user accounts and that should not affect the normal image user
> >>> account settings, so overwriting user account settings in security
> >>> kas file as required for security image.
> >>>
> >>> Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
> >>> ---
> >>>  kas/opt/security.yml | 6 ++++++
> >>>  1 file changed, 6 insertions(+)
> >>>
> >>> diff --git a/kas/opt/security.yml b/kas/opt/security.yml
> >>> index 4e74a9c..c385a62 100644
> >>> --- a/kas/opt/security.yml
> >>> +++ b/kas/opt/security.yml
> >>> @@ -12,3 +12,9 @@ header:
> >>>    version: 12
> >>>  
> >>>  target: cip-core-image-security
> >>> +
> >>> +local_conf_header:
> >>> +  root_password: |
> >>> +    USERS += "root"
> >>> +    USER_root[password] = "Cipsecurity@123"    
> >>
> >> This looks like a pretty hefty interface change and should maybe be
> >> documented somewhere. Note that we should use that variable in
> >> recipes-core/security-customizations/files/postinst when appending
> >> to /etc/issue ... or the value ;)  
> > 
> > And in fact we will need two packages coming out of that one recipe
> > if we use different passwords in different images. Building two
> > image in the same tree would likely cause false sharing and whoever
> > build the package first wins.  
> 
> We don't build two images in CIP. This kas config snippet simply
> overrides the one from kas-cip.yml when appending it.
> 
> In the end, both passwords are for demonstration purposes only,
> obviously.

I later saw that there are two packages writing the issue file, the
security one should be updated to use the new value. Or maybe both
should use the variable.

Henning

> Jan
> 



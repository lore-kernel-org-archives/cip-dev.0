Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DFDBC4332F
	for <webhook@archiver.kernel.org>; Wed,  4 Jan 2023 13:41:13 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.72])
 by mx.groups.io with SMTP id smtpd.web10.12164.1672839612324531012
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 Jan 2023 05:40:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=HaAwBuhN;
 spf=pass (domain: siemens.com, ip: 40.107.20.72, mailfrom: henning.schild@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AdAedxLpsweuxvpDQj3KTZW0Ns6FX6dKzD33GnLlkTSnBhsPhOfoR0CSaSgp9ynsicgH+1oEQBxYyiqGnuiB/2Xik5z8PX4qmT8g2cjdamPt7NRsKYM4etGjchaZYX75b6XR2ZLE5pcDZPlTKa3PzIM7BQHDWrKyg729/rAT+AYFoZs9uppr6avfdJhruOuZDQrjzEMhC3AArqDpVTR9OvGCCLEJC+I27438v2i2C4ekNAOX8Y6snxvtsC3PwSFyEuaSsblYcDZ5Reh2BO5Mm7HZMCA800uyAnIm3GB+cXiR2T32b6UbDEQ1VzCnaVpARO7qjf32vQJ0pBYs3oBSbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mlxwLvQCwpSuPjHVXLr+RC1NGLJTAn07BXYXqw0UDqk=;
 b=dWnk8eFpLyvsJ0wOJke5Dw/sV7M7aroGeknpghdeL3zYB/hK+z1pwQiSYe/3F3N511t+PYj6zbBsz/ynKWFW/5C4CsQZraaiamVi6xkJLml/2dJJIWhiJVMmEfSdrZAD0ehU6RbSrwZXYUvAjgR64JZxp+uOKLuk42Iad6ubJoZFxLD58ZX+X1zNs+OI4G/A2W4U1tZJXnl3QM/df8AJWJNdxdIB8D0aT5Ap8HRaTtMpR8MmeqseKxPSrucLsmluENmoe3VGaZHH9RNZ/cr95IhHIpgD90pDq5f6T0FvEie3a56bcQbKpAAvj3PPNNdXKCz7RsnNypeSFVYk27jq+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mlxwLvQCwpSuPjHVXLr+RC1NGLJTAn07BXYXqw0UDqk=;
 b=HaAwBuhN56WjYmNevHL9KXPHSmewS6jVqeELydJhb5sIwJJo9QdjQKzVelSqJvAzu4RC5kUMwuQlVwiCC2rKFJIQmVCyZODDoUXN8Mc8Mjs1CmrFt0a1lcuxNZIkky7HT8F+Cim8ykmHbdIgH45y4hdhCYRfc5gSXP67+Jz90NgXnnC8ZnegALFG6Ia82Z84b0BDTG44M3bABROCw+IgFp24couZMSZhLUFHZv5rXymfuF/Owa73s/3o6ftodRm4oWb1H/YTGHklk8PIEQ9G7Slug0Tr8Q6981zXoit/H+ELlcJeWGN1GdJHlfHciBJgV846rtdSfsH0wuRcsHB7Pg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by PAVPR10MB7091.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:317::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 13:40:10 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bdf0:fdeb:f955:bc79]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bdf0:fdeb:f955:bc79%3]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 13:40:10 +0000
Date: Wed, 4 Jan 2023 14:40:05 +0100
From: Henning Schild <henning.schild@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: cip-dev@lists.cip-project.org, work@hennsch.de, Wang Jing
 <wangjing@siemens.com>
Subject: Re: [isar-cip-core][PATCH v2 0/1] root home dir package
Message-ID: <20230104144005.249b428b@md1za8fc.ad001.siemens.net>
In-Reply-To: <69ad7a27-f81d-cb61-0bbc-747c3ca8bfc4@siemens.com>
References: <20230104125103.9089-1-work@hennsch.de>
	<20230104140251.52df8822@md1za8fc.ad001.siemens.net>
	<69ad7a27-f81d-cb61-0bbc-747c3ca8bfc4@siemens.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.35; x86_64-pc-linux-gnu)
X-ClientProxiedBy: FR0P281CA0002.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::7) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5780:EE_|PAVPR10MB7091:EE_
X-MS-Office365-Filtering-Correlation-Id: a03ce747-ccce-4907-0929-08daee5932d2
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	DNNt4Yu3uvff2Z8iqkozLxg943wtyg4q+lgHG4em2j/5nHXyIxF0NxYQHzupLKs7aX3Zu7lKnSFRjnj61Yvjj11yxJaSrOvTTD8f6q2DF6DKagFk98idAcYMBwH8Xu5hwyJRhrW6OG/8mVrmpgoapcF48a1dvgxEc9ZZ4ZmIKqMyBKANb9x3eWoU+U2TFDmfZur8tIwXhT+fS34+qBuXXMs8hjH5w39D0xD2DbYjFc865pfDyh8wKx4YE7WdQYU0bklOzHWpacPqEaqLmxigRsr42OpIJ5afD9GYcjvGYY9YnN7wbpwla+dg9owJ7vzDginRooEQ2/lvE2fC+RCWZPH1S0tFL/kL16dIhX2KhufXYIxQEY6/T24V+tTURQ5wpaG7N+Vof3CQqOLozFBgbMQWEDOJtKPkG/U92RDqJ93rPuXJ9dUBroOxSlGdgk7xtSXniaLYpvOKZJUF6suJPNt2/OPVjwzxEHDDWUNyKfDTkNsFYF1rWiXLbEL1naFK8+JwIxFE2Q7qsFQ1aPyT9aClPfpypvGPxihPhI4nE/RaF0tABdPo3Xvd6R986/xAh7lga+PLBpBypKdRk6IE9Hf3ltNiUrSfJ39VYBuJXtmvY1aZrj8ix53YKiCNWDE2ibxvYbHmsQ2r3LkDphvi0A==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(366004)(376002)(136003)(396003)(451199015)(6862004)(83380400001)(8936002)(5660300002)(2906002)(44832011)(41300700001)(86362001)(82960400001)(38100700002)(186003)(26005)(316002)(6512007)(9686003)(6636002)(6666004)(107886003)(6506007)(53546011)(6486002)(66476007)(66556008)(8676002)(478600001)(4326008)(1076003)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?N9WKt/2aLpQ2mX8yEWZ/j4RUCQGyTR1M45Q4rnniygmu07LtPdek3sSqlWG2?=
 =?us-ascii?Q?aXXONAiGEpAC1/j+sdGojkdiiVJ6w6+RfJUeY1pb91gQMP59ftTJjuGe2LDc?=
 =?us-ascii?Q?/czBUNgvjsIuf/TUNW8WWVX5SRfeTbsavrgDnQwYQRx1mUbzlTJa20yIpDXG?=
 =?us-ascii?Q?FTANB0/IXAKFsamlyK4nC2BxRJU49MyYYrabvKuKAm2+7xx6QEk11Hhgd/NZ?=
 =?us-ascii?Q?IeVPg7TcdoVbo1Xta21wsgpcYv4vkBPHt1gtc799DxV0d6fsSlGXCDLSCVwB?=
 =?us-ascii?Q?SBKIlqsFfe9JNnm6xuLGSHB4VCI5qnlM1uo3n6mbKxU3uxUdiblqHngbSzJY?=
 =?us-ascii?Q?taUFDomCHXSudEkrI5uYPrBxDfiGH+zn/Hx7tVZnqpbkKMNWWd1bkInfDRJm?=
 =?us-ascii?Q?ShayaHsFh34oLGZnCEeVYIO+CcO/KbJSmN3Ftdk/lyJV50UAmzWS+kdhNwHj?=
 =?us-ascii?Q?h/tZJgbEOJikD7vKWUTJDEXaKG1Ggu6reLyZOnlnkXPqHQZNGsIUmMLhj3t1?=
 =?us-ascii?Q?bCT4tpEc8u15SD93ccnjaOJCVJXucsrPqwx6rTmd5r4sG/iBA/PJi2I2DrJv?=
 =?us-ascii?Q?8Oj5ZaCZPhEgYlP7nmDSX5Q02iLjjlmC0nra848Zx0go8PxJjwB9earHLG7J?=
 =?us-ascii?Q?QBvrGFt/l08x7gsVRgZ4b2b04TsHduckiSKEXtSORDBzkWKKOeFQM3WwGcQp?=
 =?us-ascii?Q?oJK4iTtlp15IXHXeSqu8jxt3PnlzX8otE+RtWSnJwV4q1SlMDIGjZTbaAdcP?=
 =?us-ascii?Q?YZmBB7170BJMxMqeO15zclymL0PfHduj0X2Et4MLFAzWPO85PBHNfpeeBFb7?=
 =?us-ascii?Q?14WWgsBjK1/sRpqr8UtdfBiuGtngCwW51rHznOikXWJawnRS4jCO6SEGkQZv?=
 =?us-ascii?Q?BlnYFUtNF3PCTi8iglb3OMYUEZp2Y7M3Grc1UYjo2ScIDvx6zALOgnFAk77o?=
 =?us-ascii?Q?J3nFiPDxC9FSiQ5hETA0nbBOsaPGGPliwRBpbjNn6VZdyXNlRwHV77Ldp/s3?=
 =?us-ascii?Q?6kkYHn9QwxGmI8pBu1Ay7f9RwXcvb+xza7euIVjq7xNSmrrY+Gt9gWfWOBWy?=
 =?us-ascii?Q?7mguNv9pphSaB0W4bhrVpbrsv+swKVMbASmja0eMJBQyGpKst55BElhpyrjn?=
 =?us-ascii?Q?2ikcEC5iwUGSHfxLgMgrS0K/vAi7AGUn9eJ9pyXnqxEAgRhk59e3ppZO9KUJ?=
 =?us-ascii?Q?j1kbxOQPNGBvJdxXdT+FidRZrv70hftIIQGoKqq/wsArFcqbpk/Pclke9VY5?=
 =?us-ascii?Q?R5XkgMzSoeEcCusE0RFkByUR+3Kz9zEg6M26LzgF4P0QD0pghPwpkeQUC7V0?=
 =?us-ascii?Q?ENL6omFzUuz66u2bP/hCbh/SxUTeIgDnn51YZYUbxWU8Ne+RPjh/FdkwKc60?=
 =?us-ascii?Q?nRug6SEWiN3E9X5EnVIMMrTInw9yEt11mAcx3OnGkcYXnAC+vurEUrHL3XAG?=
 =?us-ascii?Q?4fqHDKcDmbgeaWI/hj1R+9FUFtNOtR54uSGMJX9M+BbmG+RBLdIXMV09xhy6?=
 =?us-ascii?Q?i7V8MJuRoggmn4w9sHIhdchYwb4f0UzQ5nTO4TBF/VIR9ASb1Ae996E5I87m?=
 =?us-ascii?Q?Vj+k/a2lVVXp5sBwzgX65zdoDTSiA3y4YEDj+KvEMvbrIFHb8uCJmIIiICOM?=
 =?us-ascii?Q?l7vHTxhI+hYJkkJagMj2wW8=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a03ce747-ccce-4907-0929-08daee5932d2
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 13:40:10.0048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ERfua0j4FPt/U4cjoiRZ5S9uMgwGebrJXnC+CGl16I7kvMgq605PqEeHHOf/b5cprjOXhK4BZK4EpVaS1JNfcGF0jNhWEkMaTk7ZTVmkQX0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7091
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 04 Jan 2023 13:41:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10314

Am Wed, 4 Jan 2023 14:35:53 +0100
schrieb Jan Kiszka <jan.kiszka@siemens.com>:

> On 04.01.23 14:02, Henning Schild wrote:
> > I again had problems getting mails on the list, that is why i sent
> > this twice.
> > 
> > Once with a "Reply-to" and later without it, because i got mail back
> > telling me that the remote hung up because it classified the mail as
> > SPAM. No details why ...
> > 
> > I bet none of this is on the list ... again, but at least using that
> > other mail infra i got some feedback.  
> 
> This one made it, even through to kernel.org, but not the real series.

But this is just talking and no real content. I will send all that once
more with the SMTP setup i used the other day, where things got weirdly
stuck but eventually made it.

If it does not go i suggest you merge without patchwork and archive if
that is an option.

Henning

> Jan
> 
> > 
> > Henning
> > 
> > Am Wed,  4 Jan 2023 13:51:02 +0100
> > schrieb Henning Schild <work@hennsch.de>:
> >   
> >> From: Henning Schild <henning.schild@siemens.com>
> >>
> >> changes since v1:
> >>  - add missing copyright header
> >>  - update copyright date
> >>  - rename recipe to include PV 0.1
> >>
> >> This patch is now coming stand alone as it was not merged with the
> >> rest of v1. It is based on next
> >>
> >> Henning Schild (1):
> >>   change-root-homedir: split root home move into own package
> >>
> >>  .../change-root-homedir_0.1.bb                | 15 +++++++++++++
> >>  .../change-root-homedir/files/postinst        | 21
> >> +++++++++++++++++++ recipes-core/customizations/common.inc        |
> >> 5 +++-- recipes-core/customizations/files/postinst    |  8 -------
> >>  4 files changed, 39 insertions(+), 10 deletions(-)
> >>  create mode 100644
> >> recipes-core/change-root-homedir/change-root-homedir_0.1.bb create
> >> mode 100644 recipes-core/change-root-homedir/files/postinst
> >>  
> > 
> >   
> 



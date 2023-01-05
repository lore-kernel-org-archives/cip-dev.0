Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C72DC54EBC
	for <webhook@archiver.kernel.org>; Thu,  5 Jan 2023 18:59:22 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.70])
 by mx.groups.io with SMTP id smtpd.web11.17468.1672936445906038657
 for <cip-dev@lists.cip-project.org>;
 Thu, 05 Jan 2023 08:34:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Z/MP0kOX;
 spf=pass (domain: siemens.com, ip: 40.107.7.70, mailfrom: henning.schild@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SSEYcDIu8tr/SGoe3UIpijJ3xKd0TRQvbn3Np+SpHNp6ItNB65F+PnwVKoWl/4HfpEa/zyoC0niEBuPH9TimGoPw6kqYRPLxdRXK8jTtGkWxnnvehZmAXpZbCb3tX5ddAwkvdY0ifynZTw6Ou10DuuYuzsez6+AVVKOUVnH2hMOgSVQ8+qOMcaZ9I48Wyf5h5g6vqJiBjElXc0Irkiqme5QIoUX47j13T3wqqODluIoJts0TY7WDSpwfW/ijqGYSRyk7zhC9NhPbV5KVIIQnHvEfrDPW1fa+C7pXq4mpPC/eLrOOkzOaH0cdz/9zPMNs/A4tYy2v+DUvCxdYGDI00A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z66W8ZuX68iisWLdOzu3fomxFj9kAdWZlm4asaOfQx0=;
 b=WlvySc8L+FPqk8lpom388e70VaoyzlFbu2hziV63DC8b74GYtkIFyOK0Ype6n5Deqc+Q2DMhpxh/quK2lkdF2YuEB/nxCv0W5WN6qQLr+hn3ueCUucupcVmN5nz/zGbze9PpbISybwQp+HTuY6i5PV2bMsl0yYSg9sTzkCFQKWJosMX28UTUk02+yYRj7xgTF7jKVSZpTIEj19wc395mT9DKbf84aWqJz/Gyf/wTqx1QojcvGr5lguZgC5uyGL1zcJn8mUcBmFg5rXby6i9S4p/hfc6iZseR3U17oDUTMxgXAZJFQpwIk8HEFCs558L/UOvtnHgJvAznCzdnX/m0mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z66W8ZuX68iisWLdOzu3fomxFj9kAdWZlm4asaOfQx0=;
 b=Z/MP0kOX/9et2pXxtyPmSunwxkYc7pWD76u7T3zaBXoFg+XUTWqiPPukxdBzeP0YwnuHn26xyTVFFHvedCDd8DxNhK6UGd5Na2Acm0p+5wHk9dFV0SCAKZ2kXI0qW7+iUKf+NXNtgEVKZxxCuonyiFjdaGEeq9cA3tjNLBCRpB7fqPg2vr7Xk/JvtB0/uzgsEnaVCi/vWOsdKYKGVskmXHzsrJhZ5K66/y8wYGKqfF66GL/xV0yBfvRI3TchmraWSwEnsbntCvL2YJsKVdVbbzcNKB6VgLig9hrHPI1Gfz0fvjdcIQRu9qfjfEDGnf0pAfAD+BIVMae3YizvbXo8jw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by AS2PR10MB7737.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:64e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 16:34:03 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bdf0:fdeb:f955:bc79]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bdf0:fdeb:f955:bc79%3]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 16:34:02 +0000
Date: Thu, 5 Jan 2023 17:33:59 +0100
From: Henning Schild <henning.schild@siemens.com>
To: venkata.pyla@toshiba-tsip.com
Cc: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com,
 dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: Re: [isar-cip-core] security.yml: Add root user credentials in security kas file
Message-ID: <20230105173359.731cfc51@md1za8fc.ad001.siemens.net>
In-Reply-To: <20230105150242.21236-1-venkata.pyla@toshiba-tsip.com>
References: <20230105150242.21236-1-venkata.pyla@toshiba-tsip.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.35; x86_64-pc-linux-gnu)
X-ClientProxiedBy: FR3P281CA0208.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::18) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5780:EE_|AS2PR10MB7737:EE_
X-MS-Office365-Filtering-Correlation-Id: 5aec1cec-7907-40fc-77a0-08daef3aa790
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	bT5VV6Sq881aigJ6TSmhsOmoWPQWUV61UjfQjFc16GEmjyULw5+AepeyoG/QW1sumKJshVVCaGwC7ue2K7N6L3HQGcUb/3L2cl+NyUFjMax4z2renEU2iFNYfb+hPeXJD5W/zUdJLI9FxcaoCJDPxlJCdrwNH1OIwo2PQSU/1MJQtj2mv07dJdhjUd9pq97JonQogqVmVYXKa00KzV8tiToP9W8bMLvQsBA9TlTP/CWicUB3cE+tvvr5UX4n8j9R3zwNGlxKp/neu/TmVKRyUXnxI7a0Yg8ECsnRWo3ydQDPv+EIzKWwqYz3+YeBa6cdz+hQCf/FTIGts6/HEzbq9PlCXQW2vdU3xWFg8sQ1sfuHAPqYNSC+IA4ts1zRlYBpUhKipluH+6FLFb5pBZcaB6rNaNTTuPd1Az4mQ3dF77SwWet8G1ebrWmIAarsTfMokoWkrPytoefzcLPZhgxFqldiv5WSYPQyrWcYmmHr+QbJjfcEZQLXfgbcuQDEymFis8jSs4I8wQ90RoZ1FIBMnC62L0roarTBIPoc2Nos8Bpds4ddK/MfLhhJ/T5ecZXylP7+edDz0teiR3JjrC8o+HX+7yirom7fHErJ6mvi8Dq/O79xk8Ru8G6MFn4OtkZpIjETrfT9vguDgqXicKkj2A==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(136003)(376002)(396003)(366004)(451199015)(83380400001)(15650500001)(1076003)(86362001)(66556008)(66946007)(66476007)(82960400001)(38100700002)(8936002)(8676002)(5660300002)(2906002)(4326008)(186003)(9686003)(316002)(44832011)(6512007)(6916009)(6506007)(41300700001)(6666004)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?kcwUfbRitJIaZV6Vo7daGwWD6y1INxBnqeuMn4wQ6b06fGb6CrbgpJjBWW1l?=
 =?us-ascii?Q?NoF1T9K55un8slZUMKhsbBse1MR4pVmm1eL9QhI2HZco9JKpmGbCOQ1a+ay2?=
 =?us-ascii?Q?OPzqnnGj1CZ98t80Ygzmk6tQ9mCh/T21pXWTKSuaBmQrQtg+veapP9dvFI0b?=
 =?us-ascii?Q?jEXx6KEBco8Rym7bhk5Hv0LN9p8aO8b15HPYHqHMcqFAXfZa+dCcDfVNp27F?=
 =?us-ascii?Q?1t19D2dlMVj5qelnaTb3qFq8Fx31QzJTj1hHNpbymDyu24egcKEbV3yfHa0O?=
 =?us-ascii?Q?sJli9/IhIe4+4tzYDWu9BYkwTvdizAsbLQtNoUTqaD4w+KWAkCScyT1L7yPS?=
 =?us-ascii?Q?FdZ7HUYUlV79ggFEY+6SmvqnNeqD1Ri6ZJNJtZXC2B/GxCwN69f9Rnr+az01?=
 =?us-ascii?Q?QNUpaAZXf7pUJ82x7XbUalGov3Vuu/FB25Wbc2zPa/IWkmx3tsQUqfk2Yuna?=
 =?us-ascii?Q?rHsODBwop+Vb77wqCBz9QusTuh6/yuSYIHryJwfGELG3KxX4Yg4lqCt953IB?=
 =?us-ascii?Q?ByHtRs9GVPE/IOG64S5K/USrnYQ56FBFG8skvTUSbK0NyExJI1eiejZB0wKf?=
 =?us-ascii?Q?k5ve9bSKTXIm1Y+PVe+XntUhwmq2W2+tEA0UENSsFk+kl9brhzZz6wXTo0Uq?=
 =?us-ascii?Q?Luc8Gd+BZhEZ6XjNlU5++9TbH9je18as9PKSQhkDFdHcCZYbUstbPWxD84Nf?=
 =?us-ascii?Q?7YXbqiJUH+OGIMk6CkpgL1DQjLBdy2wRhgdlj8OqJFrTe4+UivVqcsM8J+O4?=
 =?us-ascii?Q?1mclYboc0+PEQSlq0JfgLgw1x6DQnev4+EEdTHusb936tAauLcUQoGCoez8/?=
 =?us-ascii?Q?GoSnqMPGnIOYcWbaUZPaWXKuqX5GhTRum2Fy9b7HGn/vEXSjqa1bcAtQcigP?=
 =?us-ascii?Q?oNXz7h8Y08ZfbzVETTrPUfl+la9UUW7CLK9JyzH1lMQgJQ1Mo7sgkgnG5yOv?=
 =?us-ascii?Q?xu1PMnKyMXGo2glDujv5p70jg2lmK5cGCLzqjXpZUgH6qOV1eeFaI8N2ABGw?=
 =?us-ascii?Q?GtI+VQJfQIEvgfBlfmx1RETgNw5Q4BVToeRkcS5HDpB21LA/jg0B7JNH37L3?=
 =?us-ascii?Q?Ed3DluVcB6lCiqPUBT+TE8p5+P3NfQjzzA4yq8vQyvb6fvqUUptqZjYoTvxR?=
 =?us-ascii?Q?bCoQwGmThAuwPhOLW4Qa7tDxhXpsijpil9wzgvq+fxjo8EHuGeIjRjtPqD7Q?=
 =?us-ascii?Q?BQqelxbz7etKbbVpLHGiolCBqdRFmjTav1KnvqcGEWOcB3ouWh7zp1n16mJG?=
 =?us-ascii?Q?gZwa7H2kfc5KjitL8EmPWFpukme7IQar7GsTg0pME+H6JlWPvF6yrxpHQEJB?=
 =?us-ascii?Q?GDlxub0usucJi29ZbyTbosYa0ZqQZb+7uB3wRlBd4Uqrg1aaaVG4aRlMvlYP?=
 =?us-ascii?Q?/+k+/c/fAZpNxlGPT6wHqqLWzmbpL1MrZIlI9q2rQAYeaQlI14C4S9n9MeV4?=
 =?us-ascii?Q?5BO9g/ekZUFIhYH8GmTkW0tKEWgnHqzHMBTaJ29GoE8W+zE+mbzg1L9OdRk2?=
 =?us-ascii?Q?7yI7HUsyAs+uG4bfKbD5HK4vsvvkLCTPMiXD41KlzMuY6E3FdHbuLEZZh7Pc?=
 =?us-ascii?Q?1R0LBbp//mFwzn5wj5v47OdhOLbzbuNNhitRSqEgfXb+XEyatoVjdqt1zw82?=
 =?us-ascii?Q?Xxj93kdpd3BEr5PcHL4sj+OjOcABtPffJSg3gNAZwLrmZypA/ZqwKb0oqaIa?=
 =?us-ascii?Q?4IdfKg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aec1cec-7907-40fc-77a0-08daef3aa790
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 16:34:02.6313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vGna/ggW6KeT/jwDy1i8545dVU1oLSdMIIBY7NQzXJZIOkBg/OqtHNySXbS5o34gS+CwrhCL8Vu0g9HMzZ3OCzVsU/qOqaxmV0UQou72mks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7737
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 05 Jan 2023 18:59:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10326

Am Thu,  5 Jan 2023 20:32:42 +0530
schrieb venkata.pyla@toshiba-tsip.com:

> From: venkata pyla <venkata.pyla@toshiba-tsip.com>
> 
> Security image creation imposes a rule to have strong password in user
> accounts and that should not affect the normal image user account
> settings, so overwriting user account settings in security kas file as
> required for security image.
> 
> Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
> ---
>  kas/opt/security.yml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/kas/opt/security.yml b/kas/opt/security.yml
> index 4e74a9c..c385a62 100644
> --- a/kas/opt/security.yml
> +++ b/kas/opt/security.yml
> @@ -12,3 +12,9 @@ header:
>    version: 12
>  
>  target: cip-core-image-security
> +
> +local_conf_header:
> +  root_password: |
> +    USERS += "root"
> +    USER_root[password] = "Cipsecurity@123"

This looks like a pretty hefty interface change and should maybe be
documented somewhere. Note that we should use that variable in
recipes-core/security-customizations/files/postinst when appending to
/etc/issue ... or the value ;)

And talking about the value, can we get rid of the "y" and the "@"? The
"y" is subject to QWERTZ vs QWERTY and the "@" might also be hard to
type when the keyboard layout is not 100% ... like in qemu when your
host has german layout.

Henning

> +    USER_root[flags] = "clear-text-password"



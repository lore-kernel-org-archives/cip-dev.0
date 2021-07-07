Return-Path: <SRS0=5qi8=L7=lists.cip-project.org=bounce+64572+6594+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C41B2C07E95
	for <cip-dev@archiver.kernel.org>; Wed,  7 Jul 2021 06:38:41 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 360A461CAA
	for <cip-dev@archiver.kernel.org>; Wed,  7 Jul 2021 06:38:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 360A461CAA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6594+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id lDpTYY4521723xbgxxrJLe2C; Tue, 06 Jul 2021 23:38:40 -0700
X-Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.79])
 by mx.groups.io with SMTP id smtpd.web09.17806.1625639919688954621
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jul 2021 23:38:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dvjmQHzZtmgKXw7l+/tbYjZqqm2mYn0zkOrMfBPxPZX0ozrfZbO3CbjOSIMgzQ7HfTH9o0VMNu93fYFwnLN1K+kYVeyMJmPxbSTdIKmR45SCJcFuB7Dtoo0wIlZ738Tui85XAyNYMGxr7LP3rgi13JBOwIkARVa8wJ3CMmOBnAFJ4YEFU3wTIaImJoAvLhMdMmsDD7NWrOqr2W9d/IZYShjYpLB7nP9v53jBpgG5S94Kdnw6W51amh66hm7tNk1iO6PRBy7rIYv3JtXaclqpsK6tFj93PJe95zDgzXYURVTi3c2LHxDEBIm72D30yxLXYfgIWyCnG6CWcyr4vnkDsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3xc7WhUKuSizqv4GMX8mcQyNL+7/62xd/0xbL/xZtT8=;
 b=Vm6tX0KKECEH+aiTJj4jBHgFsYBycU2t57uc3V0mQNgW27ZVg9A0uNgPrBL6KMw9JLjtqa8RnjBmW/DgC1Edio6TevkS4OoClziREOY0R2IAHpoCL7vu9M50Zz1Axpbl8nBeHpyFsYar9r+egHYFoz4PsDLSvHfOhYt5kviutvcNaHYOvZBMPz99t4n8KyiKmvJhJ3LPzWGXdjyXeUUBJ9JBF6sm+PzRzVIPefgcH/XKR748BdSByoLKvIssc6QqyxVLsdIpdZiOKYIA0R+yuIF91ZEQEnVyxYsEbatJSJLfFboti2LJS6Tqdn7OUfGYdFchxRJ2XBiOrdHW1W6htw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
X-Received: from AM0PR10MB2322.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:d7::22)
 by AM8PR10MB4097.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1ec::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.33; Wed, 7 Jul
 2021 06:38:36 +0000
X-Received: from AM0PR10MB2322.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8c94:c889:ed69:3f5b]) by AM0PR10MB2322.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8c94:c889:ed69:3f5b%3]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 06:38:36 +0000
Date: Wed, 7 Jul 2021 08:14:05 +0200
From: "Michael Adler" <michael.adler@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
CC: cip-dev <cip-dev@lists.cip-project.org>,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: Re: [cip-dev] isar-cip-core unhappy with our current runners
Message-ID: <20210707061405.cb2uqez2x5xnuvrh@kratos.fritz.box>
In-Reply-To: <cc986bb5-c1b1-0ef5-5dfb-81d4447ecc70@siemens.com>
X-ClientProxiedBy: AM0PR05CA0084.eurprd05.prod.outlook.com
 (2603:10a6:208:136::24) To AM0PR10MB2322.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:d7::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-Received: from localhost (93.104.81.42) by AM0PR05CA0084.eurprd05.prod.outlook.com (2603:10a6:208:136::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Wed, 7 Jul 2021 06:38:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ac27599-2f76-4978-566e-08d94111d92d
X-MS-TrafficTypeDiagnostic: AM8PR10MB4097:
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<AM8PR10MB409731617621D0A1BCE40B01E81A9@AM8PR10MB4097.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 
	BdaLBPGvLRbKHUYYymcNxUjlIs/B1NhdDp6h0HSYo0e56ODC+Z/CTnaGUsyL3jJHqjdsZ++DcaWaXcfwlS7Ba+57fxKFBJ1ZhtKbKcoB48/pj4PpV+3mhNiM+mDexPoxRbzduKGaPpmExr26VcELwli83fYL1cfBcLEYofTq5ry07o0Hlixd6oPnuj2+SmlkWldrqVbVTTSNbQaPrCMrqQuT5zEYvTTPAgc8hCqdPfRFOhLru5X4sV54pWsWY7LXMIS8/KbDRk10lUuAZUKgjtk1zZ5tZdft9mDPaMwTTBqoqJ63vXMlVaIiF/oChsfRC0eB27CZjRkVgabZrj9CWMfh3R0zVN/uHeNIPF6qLcz71yzh1LUuS+9cw7tuHyFLXQXwqhrFIaNJfg+WzCcndJcHqXiGwatSSXMtvm9Wy3LT+PVKj43/l7cQcNIsVDIJorVFwU6SSbQCXH1NckP8MulrXgHCgXLFLJBsoRb39QmsWqIRT0zqfspqtttTELINfhTve/o2Yx4lJ8s5FHzzvdGVadT3Ww2+Pesih/MeBwtbMbt5w6PDiGQ0WR6URRgMuwPIx6AmdLLJA3P34xpnPIF/nH24SVGCFLO0n0xOlBLqhYm2xlXO8wmZqEV1L3JM5ysQxMgBDu7ZESiGEiw7Cg9ikkzaAwGXOtf3NR3EVtmieqdw6yX/sVmlc0VF0YcZyYRWpZhw4DTgIZSUPVitCtPxGs/KHMGegQHdKgJ5KIYM4rtYCK7ltAndUWcJtUuEovj7AlsQoCSyusudPsWuIw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?fwWGCeT1S6jXV7LJVgKDY39X/yqdePQwRtKY2+p2PfiAY4EHP+HDUk/U9ba2?=
 =?us-ascii?Q?Fyzc2WTIZSqQ9GncEe8poftsoyoHG2GP1YEK/yfgMBi9XSCcZgP/mFPLwZXo?=
 =?us-ascii?Q?m73DV7bMWv8MDWjQCe6SB6IKBVHgDXpA0T/mzZcu+ImuV6mUWVo2e7pgj+p/?=
 =?us-ascii?Q?5ZbGI7XQ9BU060ImY14unU3i+UnHXWn9eysG0ykGIXiykFXr10ugQXTpBH00?=
 =?us-ascii?Q?O4Ylg2EBAjd4tk1fI8mBjc0fnhNTLe4deGwTBKpad+Dl3PjNe0NXxxxgWZ5y?=
 =?us-ascii?Q?sK2yMO2Aya3/RuoPMlNuUqe/L8n2Gr+T+7frEERIEndN49ANpU4t4ys61vkG?=
 =?us-ascii?Q?7Ox0ragDqyeMXbMPCVZuSX4FoCZt2kFeWuXKj3hn2pmrrIQIQwVIQySqxD8c?=
 =?us-ascii?Q?2WrvyAD90b436BPvzeKF7P/TnT0DWLr7WqIr1Ge6RKuaMOQ/A5mOP8jodiuZ?=
 =?us-ascii?Q?ojldDMUo90f/SUNjCqSfTafN2sgrQ7cB6TECoTGA5Z9IsnL+ZqfjN+2Ws0CQ?=
 =?us-ascii?Q?77TLcwcLnJiEFg59gCMvAantHteGnFRXd/sRSx2wJJboAqOGsLzOXdfgPxx+?=
 =?us-ascii?Q?nnsremeOlllsjgFW8TXEZs8QfeYAZVdHDR35bdIAllVY0yppbELk6wbs4pQt?=
 =?us-ascii?Q?S3Ta5Isz33s15bs90L+yCWyiRInjckMzLrK/mHz6ygTxvXkJPuIvX4qCU7+J?=
 =?us-ascii?Q?N1g7CEEH2XtRnPakMwyTTlP76hxFt957c4bQMSfP+mdMX5K6yPCoflvRLLWI?=
 =?us-ascii?Q?mvbKCk2YzLWiuU9SUEuiFdswkTC/jxMRa6flAeA5PVQcNv2XxSF3M7c154Bm?=
 =?us-ascii?Q?xi9/SuXjmr3Gv7eRRcS3kTGp3tErtVXka1YR7jGEOQM4OY5jWuhzaMbVpruh?=
 =?us-ascii?Q?VfImxApYlul3MSVnBZcgOeeZx9fczt+LFuuWt954cnKnV9hQhTHttwjlvnC8?=
 =?us-ascii?Q?lxgERy8AVoYQMFZkNlWjEjmFId7lMNRGoXXpLqjSrT/XmJbaP/pSPyYrJFm8?=
 =?us-ascii?Q?LarIja+2vxVeVG0q6BicNzYw46YQUxcGvIpyzklkyTjoIcoV9zQKkqsSeKxd?=
 =?us-ascii?Q?XQfMeUdH1j3QhqfFbrEKFWc4LbuycgIbUSnkjrFbrUEJPTMWr2zxCPqKMh4m?=
 =?us-ascii?Q?T3jSl9UkgSgzGZ0phVhtWHRZKxnFCpNmn4guQQUihCPzYEyM8ziAieffNuNb?=
 =?us-ascii?Q?WRKxFN+dC6jtaxznRjKsMxHMbVQAJPs0B08jZ5x6h/kHy42R2BBmhs4Z/k9C?=
 =?us-ascii?Q?gNvnIKZFigzsuOehjuJ2cCWaWOKXlh+Nwam2yRmcXP69o8gCtGvvM3ZJ162F?=
 =?us-ascii?Q?bkzMLLxn1EdtuuLAebA1VN6p?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ac27599-2f76-4978-566e-08d94111d92d
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2322.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 06:38:36.5891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xYulIpxXyqPQ+klX4XSj6iARmm+d9VntHASoTlPKSJ6RV+8GP+OU5XTMaMMcNqSuakOrug2C0iBtzM9oYLnlpKosMHhIN42bSK47GCE+FBE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4097
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: sMywDokC0tjezngNRKxIOikUx4520388AA=
Content-Type: multipart/mixed; boundary="tpLEbqA1ahGxetussp9Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1625639920;
 bh=XlZKTtmMSN1oC34/dQwBmzKybfc716csEbywjJrwSkk=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=D3Y8LlISp6FfJczi6WvhXRoFOY6y9ggGpkq84FLGktNoH1iYaZ5PVWLAV7y8UW/7mHU
 fmrxSmwfxPWg3EBqsMUjdG9pP/WuXGOypCNHNYPBpCx2puEkmDgoWesmV7xHjd6lB3lym
 hhj96VtA9yoU9bcLCdA8lQAkKeQKsbd0OhI=

--tpLEbqA1ahGxetussp9Y
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jan,

> maybe someone has a clue: isar-cip-core does not build anymore with the
> current runners, see e.g.

yes, I might have a clue: I upgraded the runners to v14 two weeks ago [1]. =
I have downgraded our runners back to v13
[2].  Please let me know if that does the trick. Then either we found a reg=
ression in the v14 runner (which might
already be fixed by now) or we need to adjust the configuration (I have a f=
eeling that the privileged flag is not
propagated correctly).

> I'm also not sure, given that we have two group runners available now,
> if they differ and if isar-cip-core will use the right one. Maybe
> additional tags are needed?

I think it was the correct runner. We have a large (tag 'large') and small =
(tag 'small') runner: The large runner allows
privileged, the small one doesn't (anymore).

Kind Regards,
  Michael

[1] https://gitlab.com/cip-project/cip-testing/gitlab-cloud-ci/-/commit/792=
0a9105743c96db548c06faac28243d7cd9c96
[2] https://gitlab.com/cip-project/cip-testing/gitlab-cloud-ci/-/commit/6e9=
b58da1a557be4ca602822ad4b8f23f172a2d3

--=20
Michael Adler

Siemens AG
T RDA IOT SES-DE
Otto-Hahn-Ring 6
81739 M=FCnchen, Deutschland

Siemens Aktiengesellschaft: Vorsitzender des Aufsichtsrats: Jim Hagemann Sn=
abe; Vorstand: Roland Busch, Vorsitzender; Klaus Helmrich, Cedrik Neike, Ma=
tthias Rebellius, Ralf P. Thomas, Judith Wiese; Sitz der Gesellschaft: Berl=
in und M=FCnchen, Deutschland; Registergericht: Berlin-Charlottenburg, HRB =
12300, M=FCnchen, HRB 6684; WEEE-Reg.-Nr. DE 23691322

--tpLEbqA1ahGxetussp9Y
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6594): https://lists.cip-project.org/g/cip-dev/message=
/6594
Mute This Topic: https://lists.cip-project.org/mt/84024159/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--tpLEbqA1ahGxetussp9Y--

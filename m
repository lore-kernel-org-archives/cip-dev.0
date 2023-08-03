Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61ECCC00528
	for <webhook@archiver.kernel.org>; Thu,  3 Aug 2023 22:00:33 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.65])
 by mx.groups.io with SMTP id smtpd.web11.14703.1691069001076158908
 for <cip-dev@lists.cip-project.org>;
 Thu, 03 Aug 2023 06:23:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Q5HaU7K1;
 spf=pass (domain: siemens.com, ip: 40.107.6.65, mailfrom: michael.adler@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HzzgKih60tB8BsqLcSgv3qzNOAm3Sf52c2JYlrTzJ4gMiyRf+uUslQoEhsNdQEEsEbFQY34KhrShssymyq7G0AMBcXhZQjOw+VOtfH4uHTwTKPAKSmc3VSEHy2EexgcF2wMEPxNEI0PfOWJA4xLS+qj0l0qmUC4a9ksukHR5YuLlLRS/EVkwSiFMYjFqPLkBtjEx+2N6MhMAxiyXx8oaQW/4ngUrlAf5vxbCtvZETdLbu76hvDCXtUGvez2/HEEfOz6GpqeX8hfwC0AYYQDVEbDMI05Fgxp72e0ApNiM4cxgGUn5XXoYw4xzQZsSBUvSuJhTsVF2TPn7bFi4X5ClSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GAJjPP+Z3lscfKvWDvGb8UCKtDgGuJ8h5J64jKugc8c=;
 b=Aa39LhVbHDHpTCcLE++tZvMHKakMu9ELBNy0foXiHgSO3sf/BBQfjIE1bSWbRdGjC+P+NOIxoG80V9k9ohtjW631QIcxGewA5drWzDQtwpK2QGULKHfo2DceIw+rq7iZFo9ccBmVeYs7uHbJ6c9wmvWPyhqJpyvEvrtOyk+uw2KVcw2uf3Im5sdb5ne+5cLp/vKns7A4PtH0Yot6Pvo6LI149y3cdKEwqNm+WW6mM1GC7/Ev++OF8sT0fJQCnEn8oZMRKSWVfhiAIEGZtCdEetjXI9Kg8fl/pvr7rRZfTFYPvdNt+dX/KlHpg6FEN3v92zv+ZmT7SLmBkqkHJaaGNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GAJjPP+Z3lscfKvWDvGb8UCKtDgGuJ8h5J64jKugc8c=;
 b=Q5HaU7K1UMhnuT33FCGCfiBa1g3lG50XmQdKS8Nhils87f7kvI45JLZCcoOwK3wATc6GbVxoAz7FK8JXgfPAdYoaUZg8d4GlVAJ8sS7w8xrCs2I9cvFKIQ57ufNRuhaw0yvKqbW511rVEye32l1a5yVRY25pNSCyF2PgmQJdGM/TWT1qiq3yTqAlESfENF6L7Si1Q/qzEThBb0AGpIt9uv2Tg+T7o+sbkMEv9fQg4a816gnkSfbps0lNd8qAhC5IP51MpV7TiTUId3UmzeyRmJjCotzgJPYjOzL0RDLe9z8diOywnlWswU92CceJ1az/EwDgm/kaMeuyMzbxPXwCvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by DB9PR10MB6450.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3d9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 13:23:18 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9505:a6cb:9759:b1df]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9505:a6cb:9759:b1df%3]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 13:23:18 +0000
Date: Thu, 3 Aug 2023 15:22:50 +0200
From: Michael Adler <michael.adler@siemens.com>
To: Chris Paterson <Chris.Paterson2@renesas.com>
Cc: Pavel Machek <pavel@denx.de>, 
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] stable-rc-ci tests failing
Message-ID: <x6gtttscicyj2tuy4jbrdjk7s4c5idx52gjmf2ussf7bey4kcm@rqhxeuxkfk4j>
References: <ZMoaWmwWiLQz+vNU@duo.ucw.cz>
 <17778648DB0D91E2.2497@lists.cip-project.org>
 <TY2PR01MB37881707081B7D70710B10BAB70BA@TY2PR01MB3788.jpnprd01.prod.outlook.com>
 <20230802125753.4d2e6225@backstein>
 <TY2PR01MB3788D79592068F488400767EB70BA@TY2PR01MB3788.jpnprd01.prod.outlook.com>
In-Reply-To: <TY2PR01MB3788D79592068F488400767EB70BA@TY2PR01MB3788.jpnprd01.prod.outlook.com>
X-ClientProxiedBy: FR3P281CA0028.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::19) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB4734:EE_|DB9PR10MB6450:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a1080e8-987c-42e9-88da-08db9424ccfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	acbFMnBaiba3wAGCUOpqTpy0vsgdt4/iz75QekZGkBXNncxe+gSlIouFw3f6VTmrmwkEYeTAtKdX7u0Iy7JOD5b4V2tHp8GJ9dkXCKKncwJ7oOFkd5+A4QpZLDfW6093nito4vaR1jP+kV9kPvXKEdzWkmw78eOi9WRzQSK01K8jj5TILQxtAciP9VI7VsdvMMcH+lm13q7r8PaCtacgpKm89P94QWSxnLO4/mP5ablkPIJRwBUcqaXGSXrLvwzfrCHdhz8T65tG8MufUGtQ1JctnGFjC8EEfSFONK/yFQ3v+tbVRHIeTleFsZ39DivfZ1ekH5ZwE/F6F7k4IozstGsv/47Pb5cMDe0GJMQaw1U6oA5usVicICnivJFvTa5Tv8ABBiKFzzYDPrLoI22KF8sWnonC6QfLaNw+OYHfhe+HfILpuChg4xanU0s/VUwKvQGTyt2Gh1Q64XzsT5wgainVL8xThLhpWMF9rfArTMhOZi2xoF+lk8FOhljE5wTA+NkV6o6pZF0hDlhed8jeGYRy1MNKtPViLMgRcDCC0K1u2OA/GL7/IRvsBowe7z8E
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(376002)(366004)(39860400002)(346002)(396003)(136003)(451199021)(33716001)(86362001)(54906003)(478600001)(38100700002)(82960400001)(6506007)(186003)(26005)(83380400001)(8676002)(8936002)(6666004)(44832011)(41300700001)(9686003)(6512007)(6486002)(6916009)(316002)(66476007)(66556008)(5660300002)(4326008)(66946007)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?QZK0B/MaKC6D1FFM4T57fVEvBZvq+zINtK3pbsS+jcRkoSIJrDS++Hj5XbF0?=
 =?us-ascii?Q?vA124lJhjHAMmkPHCYXMq5kcsxpviEKvhPOfG+1BlN1+iPiWif2xZJ6VNhau?=
 =?us-ascii?Q?GPgoDkCW6BuhpUlJMy741XKzEwFRlTuRGMGemYRRJu2Fw8e1vAeJYnxbFRVt?=
 =?us-ascii?Q?zy+28VVA7IDhT0zyb9bDxwCspVACnYi8Izis4s0F5z1KvTn3ym+EITsv2xdl?=
 =?us-ascii?Q?sD1BFFZrjT+MTCS7wXG2LrEMSOk5zmpIaTQ5j/XNoRFeY7SWlLPtC1WehYfs?=
 =?us-ascii?Q?/ClovsEdaFuqT13vpddNry5X+/IiuBYjttWy4MQFK+f+idWXV8ry2D+PF8lJ?=
 =?us-ascii?Q?J5QhHmN/wC1XiQbsqiIDDrh5GbMjKidma4j66YVsLUSUni3K3EOqTG0jAz2K?=
 =?us-ascii?Q?iHU4eaEKLqbAmom+SYOsDixio484kNYYasz9zOt72KUm1PhE84DMd8zDgOoa?=
 =?us-ascii?Q?+n9pMHoji12GevvYvleI/PoMtbCK1vwnund5QB59CrQJ+hB4T3Vfjt2EaG77?=
 =?us-ascii?Q?q68G16dsXgSjcpij/YqPIZmjWNmuRjVQmr4FERUU2pHZTt34ANTomBBWuiJN?=
 =?us-ascii?Q?8B8qQynZRB1vlumw/JJAgEer8JiGIlmmbwzo8vlNJwWYpiVNYTdfXiXtI9WZ?=
 =?us-ascii?Q?XBmVWHI+3eMKtxbTWxsDRBvSA2R09utUKaJUa/AtOgmI+T7WmW2pWAFsUY/E?=
 =?us-ascii?Q?Exl2ivMEfISkxQyTg3X0y0o/RZaZHoU0cGojsbiNhqUtYJr5ARw3UCG11QmU?=
 =?us-ascii?Q?l42yVJ5x27UEeEGr05LwuHIqWKu0aSlB34aEfgiyj4M0ejScKyBeYtBWWDig?=
 =?us-ascii?Q?X2d/KzBFO0Mxfw77QWY7kUs04Yr5X0RqzWiJWZiwBOuQdcdHONmmULYpYhg7?=
 =?us-ascii?Q?5vTJ77HI0Ivz8Ftu4YPNGl7SLIt7iR3CJ479HXGoxMvwXVvAK0QlNqYYg9T2?=
 =?us-ascii?Q?+O/mEW7DJHFdzTQawzxsHpv/eUqaAExKldeWS6JZ45/hTV3U/b5605RKjwIo?=
 =?us-ascii?Q?ZtV1TKgfx36k6Xu2RNomgLx2I1jdJ+TlUMRrAILUsOtq9pc2fwew8NitpL2O?=
 =?us-ascii?Q?yrbaKCLx3vGMzV5fT22ML83fEFswzRU5UtA+oUfIbFdvH0WnfZKB9jIFwxS3?=
 =?us-ascii?Q?8R50jX1mbCw1hbSvZKiHDEq0rZ738inLEwdmfeDoIWwai790d206saIYiw/l?=
 =?us-ascii?Q?K5f0yFMMZcx8nLzEHcvu1i5D5GzlHyioAvExUU/DWTWtz+2YAvUTqYgNb7pg?=
 =?us-ascii?Q?LszUokCE0L5HJ7FosMdE39twA7iujzmbsaoxvpyEsHn2obW4lbWYxyeiCL0k?=
 =?us-ascii?Q?ArG1d4ejQ6xj0hjAI1ExhrYesPH22CqIOb435GlLYs/osT8jQH/AgnFDXpkB?=
 =?us-ascii?Q?ckeYqh0cCn5EQ5hldBwCQr0U4PGkM8wqY7h76SHhaEjRBBrzAOjhzU5A/hh3?=
 =?us-ascii?Q?DwKLy8TAEjFimREli2JRtHkVMTlBIoLyPL5rS1eeDmq42yHWcRe1DTufjujP?=
 =?us-ascii?Q?o1ebpiTY/2+UdSm/fwbOWtCovg+/o7sg+wX60GWy3SJYB2mylEiMX8fo4mkz?=
 =?us-ascii?Q?zXcO/yfPbgJ9eRa69EMCMku0ddZpHo2fOSQRy1oJzaJcaDLikstyg9t+3E0E?=
 =?us-ascii?Q?Gg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a1080e8-987c-42e9-88da-08db9424ccfe
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 13:23:18.3664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lnXoONcGAboKH9c1wqH//bcvSMpHuyzhx+9VFu0HNAnkYQDWE5+Qp+mfxN60GzDZ+xVqMaOvVI9X125QdNQcUDLOhvmaHMHvqIKe8DLXgco=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6450
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 03 Aug 2023 22:00:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12551

Hi Chris,

> Do we need to consider adding some sort of fallback support to
> gitlab-cloud-ci so it'll try a different region if we get this kind of
> failure?

yes, I've just implemented this. The small cluster will now (hopefully) try to
auto-scale across 3 different zones, thereby improving availability and
robustness. Previously we had a max node count of 5, now it's 6 (3
zones each having at most 2 nodes). Let's see how that works out in practice.
In particular I'm curious if the auto-scaler will choose a different zone if
it sees that a zone has reached its max count.
If we don't face any issues with that new strategy, then I will upgrade the
large cluster at some point in the future as well.

Kind Regards,
  Michael

-- 
Michael Adler

Siemens AG
Technology
Connectivity & Edge
Smart Embedded Systems
T CED SES-DE
Otto-Hahn-Ring 6
81739 Munich, Germany

Siemens Aktiengesellschaft: Chairman of the Supervisory Board: Jim Hagemann
Snabe; Managing Board: Roland Busch, Chairman, President and Chief Executive
Officer; Cedrik Neike, Matthias Rebellius, Ralf P. Thomas, Judith Wiese;
Registered offices: Berlin and Munich, Germany; Commercial registries:
Berlin-Charlottenburg, HRB 12300, Munich, HRB 6684; WEEE-Reg.-No. DE 23691322


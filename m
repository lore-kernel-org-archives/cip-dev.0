Return-Path: <michael.adler@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F2F9C3A59E
	for <webhook@archiver.kernel.org>; Tue, 12 Apr 2022 16:46:40 +0000 (UTC)
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (EUR03-DB5-obe.outbound.protection.outlook.com [40.107.4.67])
 by mx.groups.io with SMTP id smtpd.web08.7589.1649743597994394344
 for <cip-dev@lists.cip-project.org>;
 Mon, 11 Apr 2022 23:06:38 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com
 header.s=selector2 header.b=meqO/751;
 spf=pass (domain: siemens.com, ip: 40.107.4.67,
 mailfrom: michael.adler@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fd4BnS9tsdj6bkiiyxMKQrsL7WH36Suv98tcM+0mAMjRAbyHS4R10UtwyNCJeX/+Jkkm/W0NyO5sjfvCpsp2oL4b+w23Fof3WI8moxNcv0IXUzEjVyOcFUOy60/f7XV42O1drA0VnEMJtA1k9COUy16SF5jQziG4Wcc8CjJ3w0FECKu4lHLslyCqGdX1RuyaKo+VCRbYwsxQF07bNsrH75OcgQeJr/tnlE3p6VzSSHT/CtCakDzaXCBIAsbNJPXOl5Ym1M6XGqEPeePgCqD/eOCj6hhxy/C3pVm87eum5/LkhAMUbdG4x7FtsB4DB6BK/8HDFu/SU1IzG+vGPoU6zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e3HKgwDGYgAXsIKyuLoFYCwGOeJOb2Rh5SFXyXzN+RU=;
 b=QXpQgBll7/9SA4adGsdhIPpyjsOx+Fn/rEtU9INSkFOBtYDwe2cWx9VATPpV/cNJP9I5QG8gVHU4vRcdJCQFh42gWzlJVDvjTiPFjo0MLfuufYZ0XgauuWYelYULMnhM3Tfm3jS9kjpQlB0Yp40KpCJ5wxp5jpUqY87LhJ6GCKFH06cIsVMgrxmodsNlpoFNOiheKi5/sGUABmBruYdLicM45SWoASvKoDaclrbOAqvXmkRyYEKc7RIBzuQnkOcxSFLQb1jt4KVSdKDAYNT+ohi1LZyU3eii37Xuy0zdsm9wZ67YevBwa5uAgVXYzKi3KJlVbHSk6J7FJoKO/RUBPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e3HKgwDGYgAXsIKyuLoFYCwGOeJOb2Rh5SFXyXzN+RU=;
 b=meqO/751iQReR3i1bjgvVSJ+Q9Dx26LlRQjEidrFKqOc3KXuwztgXiTcWQN+t/kBZNjYCgCJd7P7779oI14JyGKDuGJa9ubsfL7CapGDk2ZCJnGHq48JWWlhl8wDoL17hl/Nb/ZRVSGJlrin6ofNMzXT9IXW4rWWtIQNoXPJwQWpjy2RDoeAhEsx0WlrlnfMXiO1U2wg8RXMCXsr59WSgDivmgbExZQ29uE1BqclX3drihukYF8SPe1kSbQruAtpCrruMfqW5CgXgYAcKDAUdTRjVYEsRY1RHVQ0ppakZEZcl2qv2OqxZGmhJrJcX83PFJALZBoV5+W+AHA+fxjFnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM0PR10MB2322.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:d7::22)
 by DB6PR1001MB1365.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:4:b5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 06:06:34 +0000
Received: from AM0PR10MB2322.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6c20:34d2:7acc:1a58]) by AM0PR10MB2322.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6c20:34d2:7acc:1a58%6]) with mapi id 15.20.5144.030; Tue, 12 Apr 2022
 06:06:34 +0000
Date: Tue, 12 Apr 2022 08:06:28 +0200
From: Michael Adler <michael.adler@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
CC: Chris Paterson <Chris.Paterson2@renesas.com>,
	cip-dev <cip-dev@lists.cip-project.org>
Subject: Re: cip runner offline?
Message-ID: <20220412060628.vqy36h6ljqedpamw@backstein>
References: <29265285-2084-12a6-4cb9-1b7a31d14a47@siemens.com>
 <OSZPR01MB687760863E6FD8E921C9B80CB7EA9@OSZPR01MB6877.jpnprd01.prod.outlook.com>
 <257197f9-3563-b5dc-2eaf-dfb002e3acd5@siemens.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <257197f9-3563-b5dc-2eaf-dfb002e3acd5@siemens.com>
X-ClientProxiedBy: AM5PR0601CA0043.eurprd06.prod.outlook.com
 (2603:10a6:203:68::29) To AM0PR10MB2322.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:d7::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f1c7e0d-fc98-4c59-0ceb-08da1c4a98a3
X-MS-TrafficTypeDiagnostic: DB6PR1001MB1365:EE_
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-Microsoft-Antispam-PRVS: 
	<DB6PR1001MB136552B1238B027732EC4A8FE8ED9@DB6PR1001MB1365.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	bCQKDJJNZduyp+Fe+MqD6in+MY0Q1bhnB91fm0TZJY4whntUkuaOUYDyt6t9TFbt2ZAxT/4lJZl+hNWl+Y/lOBDBInzhZqpUTzVmZLEaAGYn9+rY3ol439R1jrnA8cC1XV33ROFzmamvtcZvXQXQ30Vr0cN3CR39x/5SC6HW4z7UY4wVZcG65RsZU3KBkgSxcAZrTe9NdpVDKJ332G8RNvC5Yo/18KHr1r/EIjTbcs8SPgTX12J6qOZ9hq0UZPlqA8bLXlT4kaU/OFXoDywPkJIc/dmsyHyXi1YXlQ7I50QkGcPfo2De7g24iC8tgW7OyPSoONOFnaZjtZ9+KTBsRnUSxIbIZIQ+1VxT3kbHUk9X32+4kk9zDGkEl3G8RWAuScGUJFbBouqxComszwTd5DyCwKkaTz4gx0fXpv11yQP1NBZt3/ruxwl9eiWVXIEbKH9scwiCFOwN5DheJwyqLz3i/coS1bU9s6N3+97aOiQJpiOQb8Z+pT3Z7C1diji3UssRiCMlWR34wmCC0E5G2cMG3eAoXT0BPYxzYPSiJ1Z/NHhQEUw/Hk5wRNNPVa8GZOr3BgwtFJuVzYFYmGEOdTGAuc6V4QV6cuCOIgxOX3CawAP8JkDgaCafpbelXV2FnW/m7+rZpqQWNqvVjG0cBg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2322.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(66556008)(4326008)(38100700002)(6636002)(6862004)(6506007)(66476007)(66946007)(8936002)(1076003)(6486002)(8676002)(83380400001)(7116003)(508600001)(33716001)(82960400001)(54906003)(86362001)(2906002)(26005)(186003)(6666004)(3480700007)(4744005)(316002)(44832011)(66574015)(6512007)(9686003)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?gFEYPTjjbTCR1Ikm+eR33fiwgF7mBvip9jhAm65Z8iGbNfH/CLCVRNBVXYdf?=
 =?us-ascii?Q?QcoD3bzR3ST0JLcGDwDGxEdTkq+W0GJ5Ul3s4uxqtlQNgEyELkv+qVOAYWEF?=
 =?us-ascii?Q?G2sEu/8rPsx8Rn3bC63iTBjuH6bdMm+Xa+p5Mu83I+RLI81nax4CZ8FhYG5J?=
 =?us-ascii?Q?8beugyp0EMorh687xbg0t+FNMYaiYPyDF8GdxOwi4P/W6rSJlmK/3yFcbdbu?=
 =?us-ascii?Q?5K91zjMUoAhYWNkphI2JNnFZbY3l8++rV3bdWOaHNSa0jZYHKc9kV1SCMj9R?=
 =?us-ascii?Q?GHG72Sk6ziMFjECCmafsnKt0V3MDNUxplTU1Ky2PSein6CsL8JvEDiDAs/Df?=
 =?us-ascii?Q?KwQIVhioAaLYdrvaGnZO8JnUddu/I8DzaaOk7t8XUppzr6iG2xIJ15pYIpgy?=
 =?us-ascii?Q?MQgp9dZLb+C2Pf2K2bWORTc1EPCTbFykz1+9fIov53GY9HDITAldUjQf6Mc6?=
 =?us-ascii?Q?H1T/l/DfHoR8aQLTagmTJtedVJzmR3X+c5pXaKTw1mwp5peI/7+dY6YGSCRL?=
 =?us-ascii?Q?+dkkWWjFZd3BSMBzmmDrIcf2W1D5Q2/jHuh2rnzdhfqtFVB9b+VmhfXe1obP?=
 =?us-ascii?Q?A6Na+fFg8CMg31hR91MfUn2TG2jHoVZcoidWc36w/j2bfRZLUYwu1ZmJeUND?=
 =?us-ascii?Q?IFffbMI/KKS1IC5R6P5cs9z1WaJ2eLd7ISg3Wn9RjhpP712pgzzQievXR++7?=
 =?us-ascii?Q?GuM2QY2dm9YEc+MJ+eso9z5pYEtuRtjGg/2+NO+9S/KS638Xi7Mbx4lR82m6?=
 =?us-ascii?Q?bYozUerFhRixYAWfy0m0VOEe+zLtTl+nF5v39s+YhNFrSMTnc4uc1OjcGivQ?=
 =?us-ascii?Q?U9cEH+FNKqTlV9Rp3s7E0RDtPovzqkjbLL8u5w5gN9Vnjy3o0bJMgqA/pU7V?=
 =?us-ascii?Q?qg3zc8mBsIJOV59btOwx1gjiP0TvLncMQixWrgtGx0WjMcGDO+YndlIGCaFQ?=
 =?us-ascii?Q?Rp1MV/pavFgaElFegVnN+GiYTPNobYhT+3vdg2YfpxsnwSTo55kVcF7gyF8a?=
 =?us-ascii?Q?EpCKZ/o6qDMCt1tOGKjBfQQVbC2q9LaIqBTKOVrYGF5QSWQnJsedNN9mMtvb?=
 =?us-ascii?Q?xi9G34YViXgDXpyJbHKTbSj0XUJsnN8Qfg3a/jUoCt1pz8rcbGKZFyYI05/3?=
 =?us-ascii?Q?U5OgvJpK+gORSJ1z4a6sL55MYDafEl/w5kjUw5NLQoTl7PoSnlgYOqPs2jXf?=
 =?us-ascii?Q?fEs4yMX7CjzdKbYuAxcHbKcyi16SW1ZKA0Z5GxRnASIBpskFuR81V+ayTSrn?=
 =?us-ascii?Q?qb77INTR8W+ZZc+wkFxdPnOueyJ+MrPjFNd52HJeHxZyKZRukgabK5oSZkWa?=
 =?us-ascii?Q?kJJKBNA73F8d+FfaVmOxO3rfaKkCGpF/9+RnWs7pCpvPVbSXMCtUZZ2bD0z8?=
 =?us-ascii?Q?Z2BAUhqgrxJhome2v/v4whBh3b3/w6+BEzx9OStQlpS5ntWSpTpL99DMfk47?=
 =?us-ascii?Q?1lfclee2CofK7UuzZXQiwfCpesClcu0lLTt1nUjWnfIMY7SsP6sfULsq6rUQ?=
 =?us-ascii?Q?bcs8L57bT2c4vrSqGRf/yngPKCLHYcd07Q6M45m3hdxeDj3FjBU3Li+QmYYg?=
 =?us-ascii?Q?W9iEJRBjAG7hX2F7Mxmf8o1cQTaf7pyMx31ez1HyAsXUlQru8CbCR2Ye3or8?=
 =?us-ascii?Q?T6UY+sEH6p5WIgRochPg+hGgTHbdBjMCPUcmSE2lPm4WSZwxRonq6WOqlwy0?=
 =?us-ascii?Q?4Asx1FzF5eMDpV8kuMKNXrE3Jef6fTKw5SQ1c27Z2YsCsFMRNQr7wm/fw9wv?=
 =?us-ascii?Q?oLe59dUQceZPGN6ncX8bNM76OcssQjY=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 6f1c7e0d-fc98-4c59-0ceb-08da1c4a98a3
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2322.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2022 06:06:34.1420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 CWWV9EwiZlcWHiI3EGVgIEyPRogNv/Sg6rGh8nRUYorOuXCKqDPZOrlt7D8HabthtXUIsYm2ORg5bcSc9rguNFw8mWfM+vjTiBTPSGJzAeA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR1001MB1365
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 12 Apr 2022 16:46:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8047

> > Hopefully we'll be up and running again tomorrow.

The new runners (v8) are up and running now. Gitlab has changed the runner =
registration tokens (which I cannot access
directly), so that caused a little delay. I also took the opportunity and u=
pgraded to the latest stable K8s version. (As
usual, this implies a few security fixes.)

Kind regards,
  Michael

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


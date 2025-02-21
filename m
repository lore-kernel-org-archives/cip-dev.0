Return-Path: <alexander.heinisch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86EB8C021B3
	for <webhook@archiver.kernel.org>; Fri, 21 Feb 2025 13:13:54 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.82])
 by mx.groups.io with SMTP id smtpd.web11.22434.1740143632844622486
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Feb 2025 05:13:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=lih0x+zj;
 spf=pass (domain: siemens.com, ip: 40.107.249.82, mailfrom: alexander.heinisch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EeF1QOOBzdLYA6XIaVMDeoeqydqoFRMO4F4qq8hTJClMXzdyLXwF+WMACp1AD7GrrAUZnlVS78sYyzzACWun+OKZlo/9a1DpvAe7VjEE5Qawebf5Iambbir02h86t07S73NJQB8YGJD9GacAYvOEboM6lyznkXOGpVQFFNM9GQBavvBAGSUfxKWvNFwWo64NI44vIuGkXirRuFhWJS1rfoIa/Z/fOcj/cD508SIZFTurfwznN4sxUktqgFr2dYLSJ4KgC4ghNGXcUfIMwHQxCUT1Dqxfbakkyx3V6A/WCCs1xJzeSh79cq8OrYN2TYFOALXXvwrOyEQtQPI3XtqFHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ok1QWYZmvnEFabO1uY0pnW/kIYSaCuFM/MQBdSkPkWE=;
 b=Cdl1dKg7frXy0XrBpbWMjC9LWSOTmr3Pxw+6i0MG5jAadr2l/ZPFHA/GYb+ThielqFpWqchwfD2HR+xta+gE9yH2Rsh4NvYMOPr0ZUPSNi/KIG/9fMM7AfRIfMgFIXf1zx+tV032MrXb5j84FKPwR4SwRrwRPEXTuVW9Vr5Ry4DkqQME3Cn9msS5C0JzspxRUNXyJaev151l7ZN5qBaShWw4mDAAKwDFOpD3qY5ouMyd4ZujNG0AI2kLGDd0Jve2k7O9EnSXm7f/PLrVlLQPyadcxG7OGThMdJJXJxzRECE1payWdaSsWav34ZoJDXHO/MSyCZ49d+mMsuq7YEITJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ok1QWYZmvnEFabO1uY0pnW/kIYSaCuFM/MQBdSkPkWE=;
 b=lih0x+zjFdj2WzoErTY2fn3wOhehdF0boPwQnBTqxSlnfBEde3SVTgRh3/R5zDJEswzy9hXRotn4l4HQ32jth6CY+4MD9ijZQ1SsONJXQFPdXBHRzU/vq9RHmGHkRvW8+UM80EemBpFVptu/JiIWZruJRwSNZ9KIzQDMuWj/fulyHsZFPjk2s5SNlyf/G8nRy8PgRkbocD9VSsiy0XA4XYz5ywA4ufiY95WfQqIJBnyedigrPlD0U64nkzmh4IV3rCgRp4479YZ68/VV0QcnLWcytW3rX8O9J/FnWqXaLbIWYvq4Ufb5BGIIvs5LWyXMiyY+mAkH0uQc712mH242Ww==
Received: from AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:10c::13)
 by AM7PR10MB3762.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:170::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Fri, 21 Feb
 2025 13:13:50 +0000
Received: from AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3a6d:95dc:3ce2:6da0]) by AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3a6d:95dc:3ce2:6da0%4]) with mapi id 15.20.8466.016; Fri, 21 Feb 2025
 13:13:50 +0000
From: "Heinisch, Alexander" <alexander.heinisch@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] [isar-cip-core][PATCH 3/3] Added support for
 rootfs-overlay.
Thread-Topic: [cip-dev] [isar-cip-core][PATCH 3/3] Added support for
 rootfs-overlay.
Thread-Index: AQHbgSMESHIqBRSQG0SRnFi2OXsmKrNMvtsAgANtKxCAAAOyAIABjmtw
Date: Fri, 21 Feb 2025 13:13:50 +0000
Message-ID: 
 <AM7PR10MB33205793EE7C882A7C212E7D86C72@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
References: <20250217100024.42995-1-alexander.heinisch@siemens.com>
	 <20250217100024.42995-4-alexander.heinisch@siemens.com>
	 <715da9f1-ec6d-4a90-9d32-674d7fea0d86@siemens.com>
	 <AM7PR10MB33207EA44EE03D94AF84B79A86C42@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
 <75549b150c5c37710d3bb89ce272372a19ac21e5.camel@siemens.com>
In-Reply-To: <75549b150c5c37710d3bb89ce272372a19ac21e5.camel@siemens.com>
Accept-Language: de-AT, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=753eac64-ac86-4405-b4bd-10319b110716;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2025-02-21T12:57:47Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR10MB3320:EE_|AM7PR10MB3762:EE_
x-ms-office365-filtering-correlation-id: 93771511-92ac-4532-5927-08dd52799503
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|8096899003|7053199007|13003099007|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?6/YhMDun6dWSJiY3vCvPIw3shsNd1apHbXjI3bNK9LAzmxIDDgZKUXbnI+vB?=
 =?us-ascii?Q?Ygf4dcoAvXRp0iI8RoCHfKvXF1W70pENC+yyxYdxrt0QpBy9ZAXgWCLWvQ6i?=
 =?us-ascii?Q?56x78w9385XbFjTgkEbFINTyXcCh/teUk6w6BCVadLZ7kT1m7TqQdW5imuhl?=
 =?us-ascii?Q?MUyYVcFxq8oebTb35YyDj2SwU0TfbMISxGP7h4m1ZKuR8BccQWN3fz9BrkHe?=
 =?us-ascii?Q?kABAV3F0Q3/RdCdul/FhldjKEJreGYI4Tzidx0JMg5pkSAe457p4zeQptwEO?=
 =?us-ascii?Q?7uEXqysgMVTK7RbGU6xewrdcRETu98a4F5RTboPRMAPH47qtwoMpsMjjZovS?=
 =?us-ascii?Q?eRn8Rywzg06KFAckT6MHT8W31YQl1QV3ucdxx41oQFSJiyt+LGHBJXPB6OAF?=
 =?us-ascii?Q?TM6RmRXyHIuU+GmK3NT12HURhiutEsd+8+IGjm5Yq45E7F6Od1Hg5pjR3csd?=
 =?us-ascii?Q?MT+7GFED0pCOPomaov4odClZWQEpO7W+fXLxOAABs0PTajS2opNkF5FMKRGY?=
 =?us-ascii?Q?dpt/+0feZyUUJI4EGrVoaRZ0u7KvNFW35D6ZA2bH2W0Ds0/Ux+i6eNP3zQ4t?=
 =?us-ascii?Q?t+87Ki+LcdlIemy0uO9WwhbG1MvXFuB0unzLbntX053dPF0+sHUMVgs5HQyh?=
 =?us-ascii?Q?aF2YXDzgRSoyAsKOGE3fIV/RFl/0jUYmvqe9nRZDLx3kJKw12dr4UaLH7zpL?=
 =?us-ascii?Q?2h8G2uqQFr8EZVgiaAwxLslPj3helzhVikssCz9BAT+Z+IAnHO7pvUaK2dr7?=
 =?us-ascii?Q?ydLnhrTWNYtsheiMXj0uQgrz8/Rx+OWO5EA6Zf9DC57/n6cuttOuyGku9RWj?=
 =?us-ascii?Q?Egixx8M/S4pS+3K7eQVxKm1Pn/DtsIsHAdVgM2+Kn4qyLtHUDaAdQa55r2s8?=
 =?us-ascii?Q?7/99JtX4U8FnVSnFz/M0CoRMBB4rB+adRd1PVZbieGDoFzcyChAFPXqMm36s?=
 =?us-ascii?Q?Ya2+0YH6rPBV+yblK4cPwreRwoNTYb4+QfKP3NRwIN6j+9Hfyv7ArbiYnEXJ?=
 =?us-ascii?Q?eSRdl5RD/xK954EFTHFrPBItefHpP9ae/kqarFHGRhBhNzL1a5NATcdGzb+V?=
 =?us-ascii?Q?tLO/UaiXSjsOwmotjuqnFdvOyNzMD6QdG0MU9+lvTFnEyF32NUHVE4qAunq3?=
 =?us-ascii?Q?wnMteBB7XW0u3KRW8prefHORhiEmMauHfN2324G7wvk3imvxLjk9DtMb+ejd?=
 =?us-ascii?Q?QxTDveTp6LZszbKMJelN+5Yd1a/AwKESlHAED/b8wlyflxkgtVPEwTSMKMgW?=
 =?us-ascii?Q?CcHc71enhaU3b2Yj323LsHYV4W0pQrZkhQf7YI9mHZ02c/q+/hNajtOwaOHQ?=
 =?us-ascii?Q?81zKpJVLx9U2PJcLc2q+HX5BAwIAeibw18yMwyQLC/6RzFCl0u+X2ywqM0MX?=
 =?us-ascii?Q?4eUowBfZc8yt30UBboEKm9kuYGib?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(8096899003)(7053199007)(13003099007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?l8CkozsXdwCMGtfoA0kIHEJgONZ3nTxLrg2FMNCInnKV8soddZPCyWVOyXRy?=
 =?us-ascii?Q?nKTzlZN9Cd+qU265Z/pDRNPY1A4s22q738RB12zJBNukMgIus0U23ZhHb7Sn?=
 =?us-ascii?Q?SUoIbURYLaD1PBxEi4oUkxglvY58alsaef4KRxhmcTY9wmZAp0gcOgvsLFuQ?=
 =?us-ascii?Q?AeVb2e/xXWql56vEwGNzkrut+PNEYVjUEom4dVr6NFPSxn+jLhhgpNddZ9s1?=
 =?us-ascii?Q?iaYxY3LLMh1mhJpCDr3DanV3JmkWUTqpxjONZ3prp3bv9RUdToNXk/YOLgd5?=
 =?us-ascii?Q?E+dE1gEhJTiuWjeRp4aoqeh8foFUkHu1P0f+wVgqRZ7Vjidbh9uqx1+YStQA?=
 =?us-ascii?Q?s4eminNWNAOqs5P49jMw+mpOno/4Wm1Itoc86g+2Au+TBXd4f5Lr+Qs4eXzv?=
 =?us-ascii?Q?qqugK5ZOX1BEsXUqurzuAMAGIMQnUacZr48ns+2MNIPXvF0zhks/5WFADb/J?=
 =?us-ascii?Q?gDCDokYgvANylySoPAov0Vr5+x2yixUVnELJaoRx7E0o7cNS1HGll4T1Jefo?=
 =?us-ascii?Q?BhAzMt8ko8OdDq1RnoXfrU8/311lNHtwtF95FmIhfXk5X7UG/wyCm9gC4ZMO?=
 =?us-ascii?Q?ZvyrkEWcHpL5rlFbcEAYOlCN37XTpt3gYBaXHjxeaqtY1PkW4YcBGyaTv4n+?=
 =?us-ascii?Q?UYWLL72VUGO4tnoBx+WIo0qkHuJ9VJcGbwtNZ2pHJg/OWjHEFDDOp/DTPbKl?=
 =?us-ascii?Q?GEs58x8EffoyB4oBJnd00nl8isSXBr5fKVEETIPm1NMpX0Jd2Jt4LZBQl6VE?=
 =?us-ascii?Q?0WDMqngoXN1lGN/pDT4ta0DAUOp26wupo9JGO7dY0MYfSrI++w+qicdX3fha?=
 =?us-ascii?Q?H20g2BAnVrAVuRZFwMqM+y3RWVRzphe3mydzdIIR1Z3BCt3GFPGMTYlaqFxx?=
 =?us-ascii?Q?lt5mQaqi6g3mTeNaUxtlqvR4cVoVCi1f+CEzDL9+PI7iJMwEEtfQCbygoiEg?=
 =?us-ascii?Q?79zQkJ3OcbM1eNKMVMxgKudTuMZ3W0/wUKlLhsL43u2GuCCf9hteIHacXPZ3?=
 =?us-ascii?Q?JQA/NkOqoPDXbDD4Z7GTgd68lPLbrHgmCSF8CRglAmCEBQ854ZbWmvd2QeGK?=
 =?us-ascii?Q?xvU5ncXSYgmauFMW76qhDyo5SfXIpwdvZx1iqed3SUY8Zs/vQDSxxAm2rg7n?=
 =?us-ascii?Q?Amdh4SDsoEc8jjcnAOJNjsDykvtHYz/7Mpg5D87X4OEeT2TNuHV2pa46q2Hi?=
 =?us-ascii?Q?wbX3DNmQwOmGj7ELYCc8eBo1sNH05+06dFgVRDiJYT00TWN0lOpusvOSyW2H?=
 =?us-ascii?Q?WUzLI/alUoOUo36aIsx107ABCDizYAz90uBprKZZHKvme4b6II+MovRf7MPC?=
 =?us-ascii?Q?L7fSK6AscgV0+Q5szzmT4egOkzEPENr1Z8FxksCj7r7kYyAkKXck487l33hX?=
 =?us-ascii?Q?lsP0nZtfOpJ2ZaFRFqJ58BL4iye44yEnWT3XMX0dRAKO5e/nSKJZn0WlYNAA?=
 =?us-ascii?Q?D6KKzmiRCcjzLCgsBTqWaaN5Udi8MIsV3o3iQc1/63OAU6ZBPGewVNVxEgGx?=
 =?us-ascii?Q?YKKWD43zTsokzS4Epi7MQ0ITGBYbczGAgoHhZSwOIBK7mHV3AuelmKYEkmYo?=
 =?us-ascii?Q?y8rUYx2vd7uvgYbbOpUC6YkQQE7mvKyDTbTYwG5fV49FIXvSl7/q8uRAEa9Y?=
 =?us-ascii?Q?rQ=3D=3D?=
Content-Type: multipart/alternative;
	boundary="_000_AM7PR10MB33205793EE7C882A7C212E7D86C72AM7PR10MB3320EURP_"
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 93771511-92ac-4532-5927-08dd52799503
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 13:13:50.0837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uc17aJyQJdCIibus5/qDiqhyVFMeNC6hr99fFwgX650S+jla+ZRXQt0WR/ulc4aQc2wq+3wZ8Zg14s46cQQrwTwY0HJVSM2MzWNOe1Ny+qg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3762
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Feb 2025 13:13:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17877

--_000_AM7PR10MB33205793EE7C882A7C212E7D86C72AM7PR10MB3320EURP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> From: cip-dev@lists.cip-project.org<mailto:cip-dev@lists.cip-project.org>=
 cip-dev@lists.cip-project.org<mailto:cip-dev@lists.cip-project.org> On Beh=
alf Of Nussel, Ludwig via lists.cip-project.org
> Sent: Donnerstag, 20. Februar 2025 14:12
> To: cip-dev@lists.cip-project.org<mailto:cip-dev@lists.cip-project.org>
> Subject: Re: [cip-dev] [isar-cip-core][PATCH 3/3] Added support for rootf=
s-overlay.
>
> On Thu, 2025-02-20 at 13:00 +0000, Heinisch, Alexander via lists.cip- pro=
ject.org wrote:
> > > On 2/17/25 11:00, alexander.heinisch@siemens.com<mailto:alexander.hei=
nisch@siemens.com> wrote:
> > > > From: Alexander Heinisch alexander.heinisch@siemens.com<mailto:alex=
ander.heinisch@siemens.com>
> > > >
> > > > In addition to the overlays for e.g. /etc we now support
> > > > persistent overlays for rootfs as well.
> > > > To enable this behaviour you can either set
> > > > INITRAMFS_OVERLAY_PATHS =3D "/"
> > > > or extend your existing config INITRAMFS_OVERLAY_PATHS =3D "/ /etc"
> > > >
> > >
> > > I would like to avoid that anti pattern of creating an overlay over
> > > the complete rootfs. What are the debug case you need a full
> > > overlay?
> > >
> > To be very clear: This is not meant for debugging in the field!
> > Never, ever.
> >
> > The intention of having a root-overlay for us was to have an easy way
> > to develop and extend recipes based on our existing images. That
> > means,
> > we wanted to have the possibility to install packages with apt, or
> > copy
> > additional binaries, services, configs on the device without having
> > to
> > rebuild our image all the time, still maintaining to have a working
> > environment
> > as close as possible to the production image.
> > That enables us to develop features in a debian native environment,
> > still being
> > close to the features present in the final target image.
> > After being confident, the steps done and changes reflected on the
> > overlay can
> > be transferred fairly easy to a recipe and end up in a production
> > image (image without the overlay).
>
> For that it should still be sufficient to overlay /usr only as that one
> holds the read-only OS parts for any halfway modern OS that has
> usrmerge. /etc already has a separate overlay.
>

Probably that's the case for most partitionings. Still having a complete
root overlay is more generic imo.
But I am open for that!

>
> What we came up with is to trigger the /usr overlay based on presence
> of a file in /etc. The backing store dir in /var is then versioned
> based on the revision/snapshot of the OS in /usr (eg BUILD_ID in os-
> release). That way the overlay is only used for a given build of the
> OS. A new build of the image can then be deployed without old overlays
> interfering.

Sounds interesting, are there patches available for this?

Anyhow, I would not go for an enablement of such behaviour via /etc or any =
other rw-able storage,
as this may cause security implications and lots of argumentations during T=
RA :-)
which can easily be avoided due to the fact of having separate images for d=
evelopment
and production (where this behavior is disabled by not having `/` listed in
`INITRAMFS_OVERLAY_PATHS`)

>
> IIRC recently systemd-sysext also gained some options to provide rw
> overlays. That might be the way going forward.

If limiting the overlay to /usr systemd-sysext could help.
But that requires systemd 256

BR Alexander

>
>
> cu
> Ludwig
>
> --
> (o_ Ludwig Nussel
> //\ Siemens AG / SI E R&D IOT
> V_/_ www.siemens.com<http://www.siemens.com>

--_000_AM7PR10MB33205793EE7C882A7C212E7D86C72AM7PR10MB3320EURP_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Aptos;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;
	mso-fareast-language:EN-US;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#467886;
	text-decoration:underline;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:11.0pt;
	mso-fareast-language:EN-US;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"DE-AT" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">&gt; From:
</span><span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-s=
erif"><a href=3D"mailto:cip-dev@lists.cip-project.org"><span lang=3D"EN-US"=
>cip-dev@lists.cip-project.org</span></a></span><span style=3D"font-size:10=
.0pt;font-family:&quot;Arial&quot;,sans-serif">
</span><span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-s=
erif"><a href=3D"mailto:cip-dev@lists.cip-project.org"><span lang=3D"EN-US"=
>cip-dev@lists.cip-project.org</span></a></span><span lang=3D"EN-US" style=
=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">
 On Behalf Of Nussel, Ludwig via lists.cip-project.org<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">&gt; Sent: Donnerstag, 20. Februar 202=
5 14:12<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">&gt; To:
</span><span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-s=
erif"><a href=3D"mailto:cip-dev@lists.cip-project.org"><span lang=3D"EN-US"=
>cip-dev@lists.cip-project.org</span></a></span><span lang=3D"EN-US" style=
=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">&gt; Subject: Re: [cip-dev] [isar-cip-=
core][PATCH 3/3] Added support for rootfs-overlay.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">&gt;
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">&gt; On Thu, 2025-02-20 at 13:00 +0000=
, Heinisch, Alexander via lists.cip- project.org wrote:<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">&gt; &gt; &gt; On 2/17/25 11:00,
</span><span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-s=
erif"><a href=3D"mailto:alexander.heinisch@siemens.com"><span lang=3D"EN-US=
">alexander.heinisch@siemens.com</span></a></span><span lang=3D"EN-US" styl=
e=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">
 wrote:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">&gt; &gt; &gt; &gt; From: Alexander Heinisch
<a href=3D"mailto:alexander.heinisch@siemens.com">alexander.heinisch@siemen=
s.com</a><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">&gt; &gt; &gt; &gt;
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">&gt; &gt; &gt; &gt; In addition to the=
 overlays for e.g. /etc we now support
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">&gt; &gt; &gt; &gt; persistent overlay=
s for rootfs as well.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">&gt; &gt; &gt; &gt; To enable this beh=
aviour you can either set
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">&gt; &gt; &gt; &gt; INITRAMFS_OVERLAY_=
PATHS =3D &quot;/&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">&gt; &gt; &gt; &gt; or extend your exi=
sting config INITRAMFS_OVERLAY_PATHS =3D &quot;/ /etc&quot;<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">&gt; &gt; &gt; &gt;
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">&gt; &gt; &gt;
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">&gt; &gt; &gt; I would like to avoid t=
hat anti pattern of creating an overlay over<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">&gt; &gt; &gt; the complete rootfs. Wh=
at are the debug case you need a full<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">&gt; &gt; &gt; overlay?<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">&gt; &gt; &gt;
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">&gt; &gt; To be very clear: This is no=
t meant for debugging in the field!<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">&gt; &gt; Never, ever.<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">&gt; &gt;
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">&gt; &gt; The intention of having a ro=
ot-overlay for us was to have an easy way<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">&gt; &gt; to develop and extend recipe=
s based on our existing images. That<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">&gt; &gt; means,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">&gt; &gt; we wanted to have the possib=
ility to install packages with apt, or<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">&gt; &gt; copy
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">&gt; &gt; additional binaries, service=
s, configs on the device without having<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">&gt; &gt; to
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">&gt; &gt; rebuild our image all the ti=
me, still maintaining to have a working<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">&gt; &gt; environment<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">&gt; &gt; as close as possible to the =
production image.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">&gt; &gt; That enables us to develop f=
eatures in a debian native environment,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">&gt; &gt; still being<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">&gt; &gt; close to the features presen=
t in the final target image.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">&gt; &gt; After being confident, the s=
teps done and changes reflected on the<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">&gt; &gt; overlay can
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">&gt; &gt; be transferred fairly easy t=
o a recipe and end up in a production<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">&gt; &gt; image (image without the ove=
rlay).<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">&gt;
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">&gt; For that it should still be suffi=
cient to overlay /usr only as that one<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">&gt; holds the read-only OS parts for =
any halfway modern OS that has<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">&gt; usrmerge. /etc already has a sepa=
rate overlay.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">&gt;<o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">Probably that's the case for most part=
itionings. Still having a complete
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">root overlay is more generic imo.<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">But I am open for that!<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">&gt;
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">&gt; What we came up with is to trigge=
r the /usr overlay based on presence<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">&gt; of a file in /etc. The backing st=
ore dir in /var is then versioned<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">&gt; based on the revision/snapshot of=
 the OS in /usr (eg BUILD_ID in os-<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">&gt; release). That way the overlay is=
 only used for a given build of the<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">&gt; OS. A new build of the image can =
then be deployed without old overlays<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">&gt; interfering.<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">Sounds interesting, are there patches =
available for this?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">Anyhow, I would not go for an enableme=
nt of such behaviour via /etc or any other rw-able storage,
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">as this may cause security implication=
s and lots of argumentations during TRA :-)
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">which can easily be avoided due to the=
 fact of having separate images for development
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">and production (where this behavior is=
 disabled by not having `/` listed in
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">`INITRAMFS_OVERLAY_PATHS`)<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">&gt;
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">&gt; IIRC recently systemd-sysext also=
 gained some options to provide rw<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">&gt; overlays. That might be the way g=
oing forward.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">If limiting the overlay to /usr system=
d-sysext could help.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">But that requires systemd 256<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">BR Alexander<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">&gt;
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">&gt;
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">&gt; cu<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">&gt; Ludwig<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">&gt;
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">&gt; --
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">&gt; (o_ Ludwig Nussel<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">&gt; //\ Siemens AG / SI E R&amp;D IOT<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">&gt; V_/_
<a href=3D"http://www.siemens.com">www.siemens.com</a><o:p></o:p></span></p=
>
</div>
</body>
</html>

--_000_AM7PR10MB33205793EE7C882A7C212E7D86C72AM7PR10MB3320EURP_--


Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE2A1C77B75
	for <webhook@archiver.kernel.org>; Tue,  9 May 2023 10:40:01 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.120])
 by mx.groups.io with SMTP id smtpd.web10.28565.1683628795007243468
 for <cip-dev@lists.cip-project.org>;
 Tue, 09 May 2023 03:39:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=GbCoLv4H;
 spf=pass (domain: renesas.com, ip: 40.107.113.120, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bQRdauQ67wDalf6Ng+nSrZ3hlt0PL+GM7csKuWnXYhkI92pR/zz20BkPrj/+6//tBUw4f0DLkahkdSuX1RDNq9Q5Lt2A47roahfVqjm/qDp0jVQLlEpYs3CKXJteRzorIKeYeB93CryOm9z4r8nnENZNClnywkOvYft9p7PAhQVdBz74VOQZZIb2n+UWnEvUKgMWq/19M9fCVXuL2QDDCpZG9v23EJv9duWwDGQHOTioSLKmChLB+m2t1PLcao66t+eOHyBAUhHufz7NSPUlGiWg0RXb58hvmTIKwj1O1igDG6Up8DjM4fJdXOL5304a3WYhzRXDAp8lZzqEYJb8UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YVMMrd9fc1Ix/heY/4JXkCsIezbJrGWKPrIHG74ztLU=;
 b=iPetcF36Z5t5AV+k1hLCzNYiMcUVTdfejq4M0TIVMGh/ANJtKHBx4Q8hx1WhwfJGCvfDZyuio1gaNHlSwjgUAlY819R7Oe+6xoWx/shyT5l1QZe2iOMjI2l2Hn/RBd/nU6vhS/UXRVDBljmP/b90kJC/0OpSH0KDGsRushlsDMqy4Ho1MRw0Vpz6WuMefmhhDGtwQYLQvHdwkiIorHkigLFOtkImhXCqDkKMWOOiKLs7JNWCpGE0UEhJYJ7HBo33Yo9DHm3LiYcp4/Y8Il0bf7EL0Eii6slHSghk8D0DxntMc3QEJnGnk20JE0jf54+HJt4oNtRPMM4xeadt7UWT8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YVMMrd9fc1Ix/heY/4JXkCsIezbJrGWKPrIHG74ztLU=;
 b=GbCoLv4HvW60WNjCVVf+FdWcfXCblv41xZCKmtXWnOJhj/TfGDJ05KZTWlgy7Je7IfY3a4GCRePhwN1o58KGgSp5CD+eELhAcnv8BPhWG0jEclynttNw3VrelpQV8sgTmWmJjC4k8L4gymveqE5N7LuQtfIRXBDrRjVx3L4wV9Q=
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com (2603:1096:404:dd::14)
 by TYWPR01MB9676.jpnprd01.prod.outlook.com (2603:1096:400:232::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 10:39:50 +0000
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::8c55:9dbb:2418:df89]) by TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::8c55:9dbb:2418:df89%4]) with mapi id 15.20.6363.033; Tue, 9 May 2023
 10:39:50 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Masami Ichikawa
	<masami.ichikawa@miraclelinux.com>, cip-dev <cip-dev@lists.cip-project.org>,
	Pavel Machek <pavel@denx.de>, Nobuhiro Iwamatsu
	<nobuhiro1.iwamatsu@toshiba.co.jp>, Ulrich Hecht <uli@fpond.eu>
Subject: RE: Size limit in the cip-kernel-sec repository?
Thread-Topic: Size limit in the cip-kernel-sec repository?
Thread-Index: AQHZgkEC40jacwRpqkqontinFPUAda9RvUfQ
Date: Tue, 9 May 2023 10:39:50 +0000
Message-ID: 
 <TY2PR01MB37880583E930BBEC98A5803EB7769@TY2PR01MB3788.jpnprd01.prod.outlook.com>
References: 
 <CAODzB9oaJ73uvgppYvcOBbM2xLNB1LQW34TZbjA3gd+bkAKaVg@mail.gmail.com>
 <63fb0d57-3550-1188-8243-7ea8c8b5ab5b@siemens.com>
In-Reply-To: <63fb0d57-3550-1188-8243-7ea8c8b5ab5b@siemens.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3788:EE_|TYWPR01MB9676:EE_
x-ms-office365-filtering-correlation-id: 04b4eb71-0753-4bee-bb96-08db5079b799
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 xHQOryYnHd0M3EKZzJVxcCITTAO58pDCQWrIV1TuJQyANrwQTf5IU5MjVuT8ltRMrXeu2nyw1sKSaq52EKjKiiNr8J/qee2YhVMzFpzbg46sSRJjoqYuXRbnofvg4zFjZ6HQM8AbGuhaUHWyA6lEBS6vmOFJqPNYA6YkYC3fsIedtcQc9UHNlPjRSQyTWbzX2RTH4F9+2lvw3DmWx0MFqkMCxKW3+j4YDG/nEQT3T66jQ9NU7Dar8sRjK8D8x2ig2aN2LWF5cSZwDnZnke/n3gj1ihxl1QkLvWZow9VQtqhsMD+dp3YxvY8cVh/BJq1+tjwq4zb112O3XPB5fty4Riw8V1XmR0+RjvPFSGxKTIFeKlOhTv2HYCZzZwAgHXprpICDj7UaNOZttEkpkajbRP+s8RHHva/iTLuy2RleqxAhQN3g4StgaTMdB025xmxIaE4TfzJlWBAv+XzFv0pOKQO/oZrD/O0afSZ3czvbfm7Na8RgnEuNHoKWT5k1LF2Bb5FvOIjCGRL4xiphdjfLzZJxX5W0EVQhiGJR1HbroJ0e2qILg22DGPXXD4DLGtj/HakMd+oEiQgi+6qVnNFDhZUnZ6hqbtzOJgMveepiJg8=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3788.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(366004)(376002)(346002)(39860400002)(451199021)(45080400002)(86362001)(33656002)(316002)(110136005)(966005)(66476007)(478600001)(66946007)(76116006)(66556008)(66446008)(64756008)(7696005)(34290500002)(55016003)(52536014)(8676002)(2906002)(5660300002)(8936002)(41300700001)(38070700005)(38100700002)(122000001)(186003)(53546011)(26005)(6506007)(9686003)(83380400001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?PCcweD3tL9cWTeRJLuabA41UjKD6WmBkIhEcS8MZt8VQ7uMtyhis32Bb?=
 =?Windows-1252?Q?DChHo1vSKLYw3XFcFB/U1xuu9GJY003dy6WFqlSMKhuWGblg2P9t9Gdg?=
 =?Windows-1252?Q?FxFb559OCoPy+/n1RQ5JlJTUAiwtF1z5yguYeJI5AoySFMaP7egUuvgl?=
 =?Windows-1252?Q?eSPQZJklGsF1pt3ZOnOSnMGTW6RmRxRxdCSx6yT+a5wsQJ6ky8hnvQ2i?=
 =?Windows-1252?Q?EMESTlULbIZDUVM3dUROaU9GrFtho9qh/rzys8Lw1j0UIMmJo+00gBmP?=
 =?Windows-1252?Q?MbPvUmxWHoY/R6kvVbkg6EFM1PDASW430muS6E5d5UmvujB/1VnT+qRK?=
 =?Windows-1252?Q?Tfl2L0gMgmVxh5S+B0gcMPtNKrbF3LOPOmoEgzpTGBmO4e8E8sWLyKbx?=
 =?Windows-1252?Q?nQ1pC0xFAEOUCjASxTzhc6Yp55uKgq8yG286PSAC1VAMXHhtfBrM9qSj?=
 =?Windows-1252?Q?GWJ2zYA9Lk51itEc1a8wEDK4gRMI5FmfbupTP4m+8LEhskZ+sG13S30L?=
 =?Windows-1252?Q?3ZEg45ORL/LC3+ymUwcUiU0jlKEB/BsKlQlnHCrdnTEKls5prHug9fkt?=
 =?Windows-1252?Q?4XTuthtTQ2SGFdrU02nc2Kbu9elttVnrPmsCX+W0JvJjGRnxJ7yr0/Qh?=
 =?Windows-1252?Q?BGOQKeZRs4MhjgqcluzTpr34ImuixuTSkN6M0C0PVAwXTyAazXQBrGJN?=
 =?Windows-1252?Q?tXhmt5TL0D4VLa0e3cnK5bFV1o78Hzvnds46d1bPl8bUWC4mqaKjEda8?=
 =?Windows-1252?Q?WYQ1R61Z3bVZSgOOThByXsXLPxSstHj45KAI7VyD8uSAcmGi49gxywkk?=
 =?Windows-1252?Q?oazX1Lwjlkp+6WENFdWcrDc/YfJybVxO0gf3q9gfl9gMurbdeXiKua3q?=
 =?Windows-1252?Q?zOhSHNoELFoY44S5sz2jrJ7YMIwBZNh9H16bS3pSU1xmSWb5Xvq8LKNe?=
 =?Windows-1252?Q?GmMhJgzlxNdi2zFIeU551ibmLghSYUZ8iIQ3QJ5Efq9X37VjozjtL5me?=
 =?Windows-1252?Q?AXuUYBXwPI3zqeo9HausziLOmt8jBhb4gpjZAtOvPTjJrJ4yan2s8sv6?=
 =?Windows-1252?Q?zQGLr3vBs4JWI2FQsC5QccX2GlcHaTtctv7hY6MrPQq3bVLHfLyDTfTx?=
 =?Windows-1252?Q?zmuR1yUuVx2G0TWcKS/PaMhOZxIhKmiPhdB7MGtk6XP9lVNVg6g7+/7c?=
 =?Windows-1252?Q?O6SyLUwclrSucjW0m59StytO4+5uvDdYidWKzbVH81tuarhA36SiBeIr?=
 =?Windows-1252?Q?ZVuQCkdKkSF0HZgNqMLOKbmCNqjj8Y0nL/hQpIr0JWldCngpT/8QvwYl?=
 =?Windows-1252?Q?EtQVlFZkkFzNd+HeCJda396/ICp8nkwKrXLDX8w1bnLzJf35ftOJWMQS?=
 =?Windows-1252?Q?/ditsqsflETmuzyB4f3hLOsinKJUkSVDhd/aDE2Fppu0OJj5ZT27uFiH?=
 =?Windows-1252?Q?14echEqCOxCMkvU0cZRLEwbHro9yhxhBhttpaPos/msxKcXUkfu2oC0C?=
 =?Windows-1252?Q?iJQ4vOnKA6pVznDBiBZffXOLVO2aLJh3X25XXdsuY4L5dGm6LA6DoclK?=
 =?Windows-1252?Q?ufO17CttUUuColmubOfO2+gis3yZ03rsCckL8yrvdTdpev54zef0mhOv?=
 =?Windows-1252?Q?30rlZ0/SHlJt4/HgIwfok4kGf0MBtqRvu1vuHl41/1iKktlpcvRSkw8N?=
 =?Windows-1252?Q?LPkv8rG2d7BReuSXpnrF+ezpe4b0KmklJtl7q19JS9bW55CM8BarEQ?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3788.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04b4eb71-0753-4bee-bb96-08db5079b799
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2023 10:39:50.4578
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: llydHfZ37awGYXyKOBTlrvvycxlZlITSg9JA6qbG+UH+4e5J2gcPg8YsAySwwo4hET0HzoGQMs5YNVHnC1sishryrU4JT3SAj2jLPbs7rJ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9676
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 09 May 2023 10:40:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11425

Hello Jan,

> From: Jan Kiszka <jan.kiszka@siemens.com>
> Sent: Tuesday, May 9, 2023 7:39 AM
>=20
> On 09.05.23 01:34, Masami Ichikawa wrote:
> > Hi !
> >
> > When I push commits to the cip-kernel-sec repository
> >
> (https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitl=
a
> b.com%2Fcip-project%2Fcip-kernel%2Fcip-kernel-
> sec&data=3D05%7C01%7CChris.Paterson2%40renesas.com%7Ccf0d089f5f4f424
> 1aa6f08db5058242b%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C
> 638192111707052389%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwM
> DAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7
> C&sdata=3DCjxru6HLSW5Kq%2BwYCwcuzgmvfKwr4G4x4V8jbdakiT8%3D&reser
> ved=3D0), I get the
> > following message.
> >
> > $ git push cip master
> > Enumerating objects: 7, done.
> > Counting objects: 100% (7/7), done.
> > Delta compression using up to 4 threads
> > Compressing objects: 100% (4/4), done.
> > Writing objects: 100% (4/4), 457 bytes | 457.00 KiB/s, done.
> > Total 4 (delta 3), reused 0 (delta 0)
> > remote:
> > remote:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > remote:
> > remote:    Your push has been rejected, because this repository has
> exceeded
> > remote:     its size limit of 0 Bytes by 400 MB. Please contact your Gi=
tLab
> > remote:                   administrator for more information.
> > remote:
> > remote:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > remote:
> > To gitlab.com:cip-project/cip-kernel/cip-kernel-sec.git
> >    78850bfd..92d679f5  master -> master
> >
> > Even Though, I get the message, commits are pushed successfully.
> > I can see commits in the gitlab's UI.
> >
> > Do we need something in the repository setting?
> >
>=20
> This issue affects the complete cip-project. The reason is likely
>=20
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitla=
b
> .com%2Fcip-project%2Fcip-testing%2Flinux-stable-
> rc&data=3D05%7C01%7CChris.Paterson2%40renesas.com%7Ccf0d089f5f4f4241
> aa6f08db5058242b%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C6
> 38192111707052389%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMD
> AiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C
> &sdata=3D8YzAuSt5tXmv6m61DlGl8KZCTfvNXGyD%2FrAfTs8bS1c%3D&reserve
> d=3D0
>=20
> which hit the 10G limit, see
>=20
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitla=
b
> .com%2Fgroups%2Fcip-project%2F-%2Fusage_quotas%23storage-quota-
> tab&data=3D05%7C01%7CChris.Paterson2%40renesas.com%7Ccf0d089f5f4f424
> 1aa6f08db5058242b%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C
> 638192111707052389%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwM
> DAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7
> C&sdata=3D6TajRY6KeI9VMENausm3UpzfY5EggnVtjKcHYvVaPXg%3D&reserved
> =3D0
>=20
> Folks, can we avoid this?
>=20
> Chris, didn't we apply for an OSS project rank on gitlab.com?

We did!
And according to the billings page [0] this isn't due to expire until 22/06=
/23.
[0] https://gitlab.com/groups/cip-project/-/billings

I don't know if there is a storage limit even for GitLab ultimate users tho=
ugh.

Actually, according to [1] there is a 10GB limit for a git repository, but =
it hints that this setup may be changing to "namespace" storage limits
[1] https://about.gitlab.com/pricing/faq-paid-storage-transfer/#q-what-is-c=
hanging-with-storage-and-transfer-limits

I'll create a support ticket with GitLab and see if they can provide some c=
larification.

linux-stable-rc is a mirror of the kernel.org repo. There isn't much we can=
 do to reduce the size.
If we can't get the quota increased we'll have to go back to using kernel.o=
rg directly again and remove our mirror.

Regards, Chris

>=20
> Jan
>=20
> --
> Siemens AG, Technology
> Competence Center Embedded Linux



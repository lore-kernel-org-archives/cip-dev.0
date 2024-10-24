Return-Path: <alexander.heinisch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7ADBCE8E97
	for <webhook@archiver.kernel.org>; Thu, 24 Oct 2024 16:58:32 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.88])
 by mx.groups.io with SMTP id smtpd.web10.1465.1729789102524770588
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Oct 2024 09:58:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=hlMX1vIY;
 spf=pass (domain: siemens.com, ip: 40.107.247.88, mailfrom: alexander.heinisch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JmmnBrRr8Umlvj+ifQlp5mOZ/2eoi0fCGv733/hkVy9V1Irhx2g00/FKHhPt7FepIfVDMfORErTDGdFXbR4I9mG8+fuzK9nwgZyfTSSgrLIbo8tSwR44pq6z4TOs5KxkCvbc1b01W792Pjf8YD/w6rAH2NIx/zFk5DmD9QLEV95UPJlz1n/tXk1hQEXWT9LTNLbRDvt/YlAk5XL6lJBDqDnOIA5lFFvkz6ySz/vXah12c9p430YU/5nT5EkmBaVRNrUcukqaqkmf1dQWmTp+ybp6SgjjcyQqw6VQaKjdeNboR8t+wBUsH1VwaRU58rynvSoxfdIbCzcOTJC7yk6qPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4/tZMSe75toN0Ja0hGuyvf5tcu7Zsm5FFng+VwSWgUI=;
 b=MznGq+bIGDxHGKhuBbKQ9OUDlXwCeQ2fDg/CvxbZ91Ns59VS/JghBmSrESuon0k/NrwAlAhdvgHJnpwKcZNNdMUXZfXX0ypsR1Zf4IAOZMmXHnZsla3u1VXfhh+mMrOXCLaJijKItUZOTXHFYb8QVJK2MzWdj406vxqOOmvnYFoD40TsfFx1Wdxi8Qu96YcMHHb1VroumM5Tb8xCSphhnIDp3ki20e59eg2z8VEDkMBWCnnC56DvY2yqW/QBb6SgJ4kRF+xGLStZMMakEB5zPbR+5ZalYZPxhWHNHeOlN75CUZHDYqA19KPGsRoK06V3jMm6ttIYDb+C/SxvezE0mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4/tZMSe75toN0Ja0hGuyvf5tcu7Zsm5FFng+VwSWgUI=;
 b=hlMX1vIYxZXYxxk4KqboNgw8eI6etXcmT/hMVp7dOAnLb5qdGUatZUg4wm33gYTgalRnv2i2o0ByNXRG6NgSJXKFS1nbHELVBnmZBD9mAbNghN2PP718Q3hH5n64czver+WOdkrFikrkbbZbCRb782Tey711m5XhDLFSr1pm7LQN01qpu+kWU0i2ZrNN16fT9RTktE+APxEAmCma2uIWUpD6s/oytbWf2vkUqXQIu6Ed0M/Ea0PX43E/yJ5U+f52pqRShXdKmBAvMVWbtZQzSmZ0GbN3iaEYeNkP4BMsU95HHU1Im8FjMeMkWwgBf2vDYd3QV0EKWsriX/vkFriQwg==
Received: from AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:10c::13)
 by GVXPR10MB8250.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:11d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Thu, 24 Oct
 2024 16:58:18 +0000
Received: from AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3a6d:95dc:3ce2:6da0]) by AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3a6d:95dc:3ce2:6da0%7]) with mapi id 15.20.8093.014; Thu, 24 Oct 2024
 16:58:18 +0000
From: "Heinisch, Alexander" <alexander.heinisch@siemens.com>
To: "quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "Kiszka, Jan" <jan.kiszka@siemens.com>
Subject: RE: [isar-cip-core][PATCH v2 1/2] Fixing dependency of package
 expand-on-first-boot on cryptsetup and tss2 (tpm2) libraries when building
 with disk encryption enabled. (for bookworm)
Thread-Topic: [isar-cip-core][PATCH v2 1/2] Fixing dependency of package
 expand-on-first-boot on cryptsetup and tss2 (tpm2) libraries when building
 with disk encryption enabled. (for bookworm)
Thread-Index: AQHbI+q4NaXgEhKYgkiz6PQsKD/HorKWEKyAgAAP2hA=
Date: Thu, 24 Oct 2024 16:58:18 +0000
Message-ID: 
 <AM7PR10MB33202B3696E06E47C3520679864E2@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
References: <20241021185359.927395-1-alexander.heinisch@siemens.com>
 <20241021185359.927395-2-alexander.heinisch@siemens.com>
 <d4932ec9-d4c3-4be4-acac-b3957b710627@siemens.com>
In-Reply-To: <d4932ec9-d4c3-4be4-acac-b3957b710627@siemens.com>
Accept-Language: de-AT, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=4501df12-6ec7-404a-8082-7dcf8a4aff40;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2024-10-24T16:45:48Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR10MB3320:EE_|GVXPR10MB8250:EE_
x-ms-office365-filtering-correlation-id: 6befdab8-1cf4-4c37-c1cd-08dcf44d0f5e
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?ro52h0LTvv0Q4aLhNSZ8+VWIWrX7Mt8hTGeTNBfwr2rzqQmFy2RceJLZ3XfB?=
 =?us-ascii?Q?vBO1E/hf4D4UBHMWoqwcoWgJzx+75l3T0KkLYtkZ4inzoe/Kqdtl1GjXEgiz?=
 =?us-ascii?Q?1PqmjoUUOE6cxVrA7m6QFfbz4mzkko7qiAwLfH+odZH3cxieMTYQVBbHwaLI?=
 =?us-ascii?Q?AU43jN9mGcp/yrn8wN4BQgaFJx/DTEjFyL0XMp2FLz9q5YDZVtxmf7sCnWsH?=
 =?us-ascii?Q?JhYBlzWjfQw76askadPBB4knSqXYK25Oxpe38TkxL2KMJlLJKoEqJuZHdzRu?=
 =?us-ascii?Q?ERmTzcBSnS63phgkkRAwtQ2jyq7WZnrNwzpC67HmkdKEkMhK9CT5qDIrrDuW?=
 =?us-ascii?Q?wq6ASzMKFe4OfEf08JS69BzsZCpzRI0FjHr48sk6RDS6u9K//hCqR8wppD5v?=
 =?us-ascii?Q?GDdQAXsA6i5TFemcZCTWBdSNsGxkUBb7/EMaQ8qJyiNkPz21mqgayVn9EuiE?=
 =?us-ascii?Q?pxmJoGYsaeCMfz5eF6ZGKgZdhfxW5DBu0mDw+t65XerGJhJva60pA7HXFR5N?=
 =?us-ascii?Q?2wOMnwQJeqR5lgJOEvLc1BYR+Vy0Me/IJ+hK7mNsjqN9S79r5y8W+vPBFojk?=
 =?us-ascii?Q?7Oz5qVX2lLOZ4qY0V+9kqa3VdcGlEv+WOMVzxwdS6pu/hFRNAEp1czUSBYoG?=
 =?us-ascii?Q?DCJN0saLpxuaUJRnrifLqHrvYVrkl0oTkyMEgKuA37BxhJeR2EosK8ck1UY8?=
 =?us-ascii?Q?nOxYQt/ViCNR+cx98HOGkxVtYycgD6zS7G1i2vpr6y+6BzqQe8BkvicAFD8C?=
 =?us-ascii?Q?a7hRkVkDmW4JzaDtQKjbIA5R0k58VJY+RozDS/kb+YzmGUoq2tkaAKgHGKvn?=
 =?us-ascii?Q?4REvDtgpVh20A1qGzjAWbi5ge0qTB12U4m4uL5uoN1EPBSSxX29XJQI02UIG?=
 =?us-ascii?Q?sfAGKtg9iwaie83uc5BA05cCzlk8glTaeFEUdgRjJx4HOf5Tj9TyonGkZInQ?=
 =?us-ascii?Q?P2HNyh9kLk2DzZ0fmPgKx7IViDfZyBpjtiYHFI7U6Ts/zEhGOVWzKv3IyImK?=
 =?us-ascii?Q?j1KWyV0ux/BxsaBIi33MiPZm5G2hEJMZlcWkA44GedFEjHpfKpgdwUq40pkn?=
 =?us-ascii?Q?qWHBSnHfOfDhAHz+/2AgiqsWiybgZruvAx4fCxBaTADj7f/XSYFh040CVl/m?=
 =?us-ascii?Q?Dbu/LT6bh/xbiX+7/OS1i4Jn1FWQVnxdf8msL9HaHA57AaYTuWmE6Qu+n+Oj?=
 =?us-ascii?Q?MBKBsnQrDXPe6qKcXLwmWSBvVK0b7vfKSuPd3bOKLvvQNdRwnZNEq46Rdbpo?=
 =?us-ascii?Q?FbvA9ljttHe9Sxkf/8mnyH37LlWbzbGN7S1e3XRgn9qBgcj7mTli3bzbizHu?=
 =?us-ascii?Q?0rOVb/oscDupmfEtBjPJPQAI?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?/ASML/7kv4PD0rrwS0DIkNWqo3FX1yC5Cquf6CKwSt0X0TgrSdOypJWmhmwN?=
 =?us-ascii?Q?FUfgFfIqeuv7QhKRi4l/X43EmXXnPW19gaUrzuRAanv7IUIxT/ezDPkEjbgM?=
 =?us-ascii?Q?GVB2G1MMk8c88SflylNqMUtLx11EwfFR/rXI3u5y+YPvmQ0EL81TUsUQm1N8?=
 =?us-ascii?Q?aazwCdGOn06MZirJbF17Y/OwfbJX+PSHsf1unnniCjVSJi18t3z3PKKl+UBA?=
 =?us-ascii?Q?oaKaTX21QDjqnVXX6kYr6+7YghvIrTIrfXeE8VQ+XiDdcJSEZWUYLg/KIvSN?=
 =?us-ascii?Q?de8b8f1o8fscMXihQZYMY8RGoHqBZLzckYqzUIGOwUuD16VI+akdsNpG/FeB?=
 =?us-ascii?Q?x5Q5yjU/Lf5m53VEGRmfTQ4wY8iZC7cbLcsI5ZxNX+9d4chnxtT0SzKG38SQ?=
 =?us-ascii?Q?VdT9Cp1iE6dNtfWnzC8jZqKzTOQTmP7Hzwsv5/kyGEbCOHaNNmlS253ReJUF?=
 =?us-ascii?Q?VgpGeknQoVWQiRdWU//rZC/WaWxrRxuQLqjXS8Dmpkz5jfARy7u9TYMv5b1Z?=
 =?us-ascii?Q?ZiVVBWz5stNj+FAOkTPOEl61b+Vc1STOx1hP3yU7XHprSWg+9M5NkXSveLWl?=
 =?us-ascii?Q?Z9s7oQAGem0wVe5vs8zcyHyk92dDKoZcAE7aL7ZpvnWr11UnvzRuzmWidSJ+?=
 =?us-ascii?Q?7nSjKtDUFjZ63WYrYT+olXSXPWqmNrgreu4EGGTYgPzSHUz8uNH581ZMnRrT?=
 =?us-ascii?Q?P86CSjSzLq1KPsbqOmoQzltU2+LncHsLk6uWEAIhGNZT7o8CQNcVwdlc4+Eh?=
 =?us-ascii?Q?nhH/VIPiEaVoybVH5tss0ADfu2cxmKqyJNn8z7oU8jQaNEWdMi1yPwMdxFLd?=
 =?us-ascii?Q?L+Yd7aE7vFUwGRGeYpSjbsa1D/m9Kr9zwYuOIAgF0PSNSwk6SR3jVPK5b6fr?=
 =?us-ascii?Q?JGNlie1EHdFfc83U0lVstbv+zEvULgN1wiSUO0NJumqD4JGG7E58fO8+sLe6?=
 =?us-ascii?Q?UA5vMZdqsZWuaBwFOSWuzenl710LHnP7dWei5BjDeFFu5QHkrNb8vY2iWnvk?=
 =?us-ascii?Q?mEDjPbGUYE0uve6/8XmzVF9dNP+twEbqdoj2JXoBzqu+IyK9JjhDg0CsYLes?=
 =?us-ascii?Q?SQiC8ySbXnObkUWBc/rxiWcxdxWOuLi0+9LTcNmt0hVJ4aKh0B6DqN1dWte1?=
 =?us-ascii?Q?puby+DbNcjA3KktantL3Gsso6NwG8stGFnhfc1a/ennsJWmKG9ggltoZYh3T?=
 =?us-ascii?Q?7+XDiuLHeRIyJdgI8EOs0JyyVVMxhZnScb6gIi5IUC4MVmp/FJRSqL46pN29?=
 =?us-ascii?Q?0t3QEo8JsG+sTkFNILef1ns1evB229TKca6AdZDTyrS3q1Wop8Mptor8sEl9?=
 =?us-ascii?Q?ONos/dZWG9IhTT1nrSagzvb54p8KUKRJ1YF/sfKVO3hZjc7F82EzyvonGWBj?=
 =?us-ascii?Q?TFXjeJJ3rCzS4CUzrNSLEOmjqdehhTU/erec9c65fDouS8KMLptpInH7qkps?=
 =?us-ascii?Q?c480ZhhkFRPj+UJqhbcot4MNDSWPksLwVw3Hg4gp1Ma6D24CNj93wjMEtDcs?=
 =?us-ascii?Q?k0zPOTQVF5Jwcj6Jtx0qeMuoHooKk0uWP/CRkgGO4FIRE6xJ4R5dXWpUxg81?=
 =?us-ascii?Q?DmhPS5GT4L/wZZOzeDr6nA8VtUCAFQ4xEyM0ifahBVXcmbvsgcWVRX7ds6cO?=
 =?us-ascii?Q?Iw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6befdab8-1cf4-4c37-c1cd-08dcf44d0f5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2024 16:58:18.6828
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MR3jq6gyC0sNFR5+K6pq/pp5z369le0gxOumUda3YnRYnLDX9nFw5H1X2fzvDX9ErSpEwVg0Td/hBUPvM5fDiiwOOSrXe2F94FQdEr6e8RY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8250
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Oct 2024 16:58:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17081

> >    Unfortunately, I could not find such library anywhere! - Therefore, =
expand on first boot and similar,
> >    still won't work for current disk encryption implementations for bus=
ter and bullseye.
>
> There is no clevis library as clevis is more or less a bunch of shell scr=
ipts. If you want use expand-on-first boot with clevis a solution would be =
to extract the passphrase, see [1],  from the tpm2 partition enter it via a=
 environment variable.
>
> [1]:
> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob/master/doc/R=
EADME.tpm2.encryption.md?ref_type=3Dheads#steps-to-convert-clevis-to-system=
d
>

That means a bigger effort on `expand-on-first-boot` script than just setti=
ng
the correct package dependencies!

Currently, we are using systemd based cryptenroll in our project.
So there is not too much motivation digging into clevis for that use case.

Still, I think fixing the issue for bookworm (systemd-tmp2) is better than =
not fixing it at all.


> > +ADDITIONAL_DISK_ENCRYPTION_PACKAGES ?=3D ""
> > +ADDITIONAL_DISK_ENCRYPTION_PACKAGES:encrypt-partitions ?=3D "\
> > +    cryptsetup, \
> > +    libtss2-esys-3.0.2-0, \
> > +    libtss2-rc0, \
> > +    libtss2-mu0 \
> > +    "
> > +
> > +ADDITIONAL_DISK_ENCRYPTION_PACKAGES:encrypt-partitions:buster ?=3D "\
> > +    cryptsetup, \
> > +    libtss2-esys0 \
> > +    "

If we fix it only for systemd-tpm2, it's questionable if the additional dep=
endencies
for bullseye and buster should be added to `ADDITIONAL_DISK_ENCRYPTION_PACK=
AGES`.

BR Alexander


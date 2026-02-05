Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 743C0EA7959
	for <webhook@archiver.kernel.org>; Fri,  6 Feb 2026 04:48:39 +0000 (UTC)
Received: from TYDPR03CU002.outbound.protection.outlook.com (TYDPR03CU002.outbound.protection.outlook.com [52.101.127.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.28145.1770316426116684964
 for <cip-dev@lists.cip-project.org>;
 Thu, 05 Feb 2026 10:33:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Udr2VJd/;
 spf=pass (domain: siemens.com, ip: 52.101.127.53, mailfrom: badrikesh.prusty@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gYL6cM8Pg40HHcrC6DPjnpqpxQrAsUMAPeGbiYeAZhDmcN6KbOMiTpLv9CLFDODJcW+51ar/A8FZTxvp1PQ5OTN7GCqWzEp4/6lnE2o90nCTtH0hT6EZ9EFoeNpI1Qvk2i8hZIG14ORxFpJ6BD0HwGZkco/zQjxpreEoAyB87sT+VKck7xi3aEel4jUoOJ/2C/3O9obwDMdzcuNIkJB0m836w7MLeK4wOSah6Ka0oushmL45fHRRUt/3amgScyexexWSIDreZamCKe0COD2tKuKTzNqbTLw9Io7anCydomy3lV9AlbFXyKgYLD54PtlB5pr9IcCQR2v4EV+PKU8yJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w2UA8hEhUsUSV5IpDK7blGGchynima4xDkO4vqoqxYc=;
 b=QgznBtHdNWvPdUbxSDyPIEokbNbBhjIfgCeBqh4jZH2HqE62P1xEn5cpwE+yj2MrOpRYSiHirbpVVySelPJX/1u+xaaYlUhD86ZoYsmWRaQKfZ/xULpEo31XoQIJHvETO7HWQ52kvWX8ZVnhUfzZrBeJ+6heSQ6/KfWkYlU8u9VTdzK7ZEGMJFp+8Je/rjBfMzWZeZOCR+dQfWbbVMmOMcI5XysbpwFK52j0F/OFBS/OcLyUfOJeEXOZw0Hy0gUeTBvObfYnoIf7O4hFi1iQJ0/UyQAsbgVc0gNy5i/w/48i3XiXfkKHzaVnFAGL+YcQMFtr3n4eb5+t+Wvn+KCTJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w2UA8hEhUsUSV5IpDK7blGGchynima4xDkO4vqoqxYc=;
 b=Udr2VJd/O2MATfnlFuwv9/mK7gvK9ZWE0nmvhRk7vGqjOVxiRVJlN2+fg2/ghFAYiQNkI4PvZ5Z3etW4ECsaNQjpxFZiY9ByRk/yogSIBHwkLZww8bZG0fKI6YeN2El3klbEESAkpV2vqTk05Exp0hJZ7s1CCX1F73z2qcnI0WWXwCjgiTrf6z+EXz3FspTGoUvK2m6Qru43oaK9LKERnRj8SE2ENZvo3raDFSrw+7TCq786THIuKb8Jrkq46H1OvgRmAmQihfNOIK8HYox0jTURJlJHcFNKHawOmtfrIurfr7mibr4I+GPV1m6OcBzeVyFCxUgMD9zY0smq3Qo07A==
Received: from SG2PR06MB5107.apcprd06.prod.outlook.com (2603:1096:4:1ca::5) by
 SE1PPFF06F8354E.apcprd06.prod.outlook.com (2603:1096:108:1::42e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Thu, 5 Feb
 2026 18:19:25 +0000
Received: from SG2PR06MB5107.apcprd06.prod.outlook.com
 ([fe80::16ec:1c7c:12d2:6ff6]) by SG2PR06MB5107.apcprd06.prod.outlook.com
 ([fe80::16ec:1c7c:12d2:6ff6%6]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 18:19:24 +0000
From: "Prusty, Badrikesh" <badrikesh.prusty@siemens.com>
To: "Kiszka, Jan" <jan.kiszka@siemens.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>, "Gylstorff, Quirin"
	<quirin.gylstorff@siemens.com>
Subject: Re: [isar-cip-core][PATCH] swupdate: use self-built 2025.12 for Debian Trixie
Thread-Topic: [isar-cip-core][PATCH] swupdate: use self-built 2025.12 for
 Debian Trixie
Thread-Index: AQHclr3FXm2KuE6p30OGTnBpX+b6cbV0U4YAgAAU/BE=
Date: Thu, 5 Feb 2026 18:19:24 +0000
Message-ID: 
 <SG2PR06MB51078D17CA7212B9DE6CE6039199A@SG2PR06MB5107.apcprd06.prod.outlook.com>
References: <20260205163727.2995422-1-badrikesh.prusty@siemens.com>
 <944f83ee-b233-46d0-9e2d-f96af55cbecd@siemens.com>
In-Reply-To: <944f83ee-b233-46d0-9e2d-f96af55cbecd@siemens.com>
Accept-Language: en-IN, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=True;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2026-02-05T18:19:24.905Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=C1
 -
 Restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=1;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR06MB5107:EE_|SE1PPFF06F8354E:EE_
x-ms-office365-filtering-correlation-id: 1f887c17-7136-4fac-58a1-08de64e31793
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|10070799003|1800799024|7053199007|38070700021;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?LdDtH8qfPFv+/xrHZ9jWkgFP4KM0f25Dv7QV8wfzRxXf0JECyMbQOB77XWJB?=
 =?us-ascii?Q?nAT51s32dbZ1Gij3fereRh01euaTj9IG0CU54H1bTLVlcLJ8aXLjumsFELce?=
 =?us-ascii?Q?XJUdyBYO35tnh9YWXYmYpO8JxGJi9asWJpzD7SSxhF4LzwPIVEEZZ2TIIR7d?=
 =?us-ascii?Q?aeSGmvZqtomK1DKEQ5QoLG5dVEFHkZqqzJ+UDBtqQds1ePv68VzNA5CBh8W/?=
 =?us-ascii?Q?BDmYq8KEtAZ6+Y3s1VGG8qitFFpBcZD4pA2oGo9VGs5ydTU+LDaSlUWgQflj?=
 =?us-ascii?Q?yeM2hEtzVyFKF9+srjf/I3rzDfrT7fBKtvSNtGP01dT2bVbBr6BbclOfPbKq?=
 =?us-ascii?Q?cRdhq8t1/+8Slpw1danz+9EMl6di1nsbsAPjASQ2fqGXw5eQ0+PtwoVABuwW?=
 =?us-ascii?Q?4bEwSsyevpHSFnqC6KgnOh4no9BHK0JlBXQW2Orx7/RshoLZHdiB8KSEj7YR?=
 =?us-ascii?Q?ZHUSq1nogRwWfnrD63bm2fRCbxoedqaEuF8L3/1dVQe5BbOLRxkZv1wv5UC3?=
 =?us-ascii?Q?wQXDpXWNbMNgVB2GcCsIZPWinpjjI8drJgnWzV6WqaAlMDO98NVD6qQEq6tJ?=
 =?us-ascii?Q?EJU1/Lf/tLhL6fOrh++FH8Ln49EgIxeg0az+ARcV13iooUn62Q5GdGt4yxZ6?=
 =?us-ascii?Q?k7/RXbaflBrDOE/xecOo0ERgEy3TJmuI8RCyBC//3MpwOLPNnKUdSb9jGMLV?=
 =?us-ascii?Q?kY1I94vxQRDjHOFYiBHukr4062aJntGgajVmMR7r7qWonkV7rCIQDL1ROLzT?=
 =?us-ascii?Q?ti4NUU/HsDPX0wpz63qLcksZSrwgEGDsDOoLUre57u7urIRnofCIFMrBYmo2?=
 =?us-ascii?Q?hmqajW4E/YoyZgH9zbqoFA5wqj4VmaianjPj5n+X9BWKjyEucdBhnK1Uqg6z?=
 =?us-ascii?Q?YV21rhwvOxBk1Lv8kwZ+u+k/KPOVE5hSQPtcXLhn/LOSxdzg52zBZgKuRzze?=
 =?us-ascii?Q?RTOkrq8QneOr+yZ9Ub0tnCZIXsnH94G+7bCRbrEK90wx7tibxSLVXnus94WW?=
 =?us-ascii?Q?XoQav0pDe35/53VNQXfPCV4ikHLn3rowmA+RzXpP7umY7MlYIGJ5eQah3XgX?=
 =?us-ascii?Q?M99GCrBmM2naK4KL8pt2r2Gx4hMVaau4OV4pz9vhEtjLh1KRM4dhQRtK3Gcm?=
 =?us-ascii?Q?F1H1scqHM58IbT80IpdOBwv2X7CVv9knQs5G2u+KIosT8yQBsOdt7XHC6M77?=
 =?us-ascii?Q?Hi5ghoJZ1M9LJ7T3wfeGSld+eQOUf5bomvBrAYsa+r2xUDWsRYhTXZbgcoh9?=
 =?us-ascii?Q?Hur/5vgDr3jVFk8+kqoxD1JGm/mFNVHKPf3mSuIjkOBTora414gDigiTlyOa?=
 =?us-ascii?Q?VBWyReUBGpGPujX3QhvDk7ghi1Pqt/TvAY9K7s1if63xDtx5KbYhKOCwUvBr?=
 =?us-ascii?Q?t2whjkaLfFpR39doiDreCf9ALopxtTzciazrw2N7Ul87I9dx/NB4cN2Jis93?=
 =?us-ascii?Q?FYruNi8ualvqv7xh+g/KA9RMpHQb6bOeY2vcp+N5y5RIrDGDKi37VstXfvSt?=
 =?us-ascii?Q?Vp3YaYtFP1hnKTULdf4WpEVNkMCppBkSbR+9aifyjzDYimOKhhyhA0SbHKgz?=
 =?us-ascii?Q?dt/XS6hDJ39xO67XA/EWuf3e0JZOQ9Q5lTsu1SmlGpeS6/5mnpYdBRnJXV/M?=
 =?us-ascii?Q?OYfsHpk227BOrUT2n7N85xA=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB5107.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?WNuhageHqfd3Gwcj/bHS4NVDh0ArAd16NYZhAqorFXn1EHws4iBNicrp3BmM?=
 =?us-ascii?Q?8r7qI4xqGvMHPYSoVNYSsPDVa1CYKwYg/8PfyJklG5M6uT9RSJg+Eq56BL0k?=
 =?us-ascii?Q?IhR7nnsWk9+OFVEm+VWnvrYeANAkWmtOdJoYyfJDRGe/wdGdwv7CT96PSGtW?=
 =?us-ascii?Q?uKn9tqOPVYtDhYZeP15dzx+8SVtgTIdNVw1wGoJ1tQKu1M6UrnNw9hBGrzPX?=
 =?us-ascii?Q?vZRauN/Mki4GC9ioTgi1WU0qmKzlN1tYnGOnvU8Lf0qtJpv4jqUqYvH45plr?=
 =?us-ascii?Q?6vbSew1rL7DedyBo4Yl328TqxfnbehfbAoHB1aBIUVLO0OVwkDXvCg32SwjW?=
 =?us-ascii?Q?MmUs8MYH9jKmRLvjfO8+Pq4BCEZ5YLnc//fwLrkgeb5TgNa86KTS1Pk1y7Qx?=
 =?us-ascii?Q?1pON1v+yJZI5SObOLqzjmN4AmQKlkUqaJt0J08Ue2VEVHi/Qc75JZm5TIcpb?=
 =?us-ascii?Q?eFDnudCHhnwbTyGeebjc9IgzUqqZGo0BeVrkEa70G+URa6p0Qacfk4BYCbNB?=
 =?us-ascii?Q?jTft4hkvx95VN7UgiS+ATBr+lIeSAe7J7waxYRaa4AXYB/htH2kvsG3RrTK/?=
 =?us-ascii?Q?AcdJN39lKBgBH8Lbdt+HWCUVHwf60gqXUXFRO1/SAcCZDL6+g9lp7zgF5lzz?=
 =?us-ascii?Q?rcqKxaeqhrcWrXKcYsaaqWXy3V8zIlfQN7tOMjdhovVaLeU2IeEPWay71Mnz?=
 =?us-ascii?Q?3fs+tYaB7ghEppTt8doiSZQAsp/6+RilYVnEHRswAAHPzQQ4AiUF8AmoLMGS?=
 =?us-ascii?Q?Mdhxzz06JxRvqLovq7D7JdySngnWzjmTY+U4Up3ZZqhPQwTOjPtX32mfLA5e?=
 =?us-ascii?Q?n6aqXhK0udPbfVXrm5QTL3eA6BhIfJBU9k4bDOiURBBsD6ZYuSzlpq1Y8O9L?=
 =?us-ascii?Q?x4B76h8aGrM3eiCaH/uZO2PgdZCnbebHGmbj6RxOhGhlYxeWBvA917Xek2yT?=
 =?us-ascii?Q?PKKB2gjdbT15cdXbm4jegAIEeogW9sjZ5nbEwCe2jphL6fMBXx10tMjauR2D?=
 =?us-ascii?Q?hG6iboZZvXpVZE8Vpvvu5rbvEiTSieeNPRbjkXmSRn+yt77DpRtADN82W/9j?=
 =?us-ascii?Q?ltX/O0ipPjp3oeJellQMGLRNxZ4hlHtKoqOH/2B6UGPsuYJcq7EaOZtZYUUm?=
 =?us-ascii?Q?+IN0TFxkEBJmWSQzMpyWb8dvGhKgol3Q/zhvH12ha4KCEzyRxtOw8ye/2oAx?=
 =?us-ascii?Q?oVgMX3vwg6bOrRHD9UKxh3S3FCnQlsnDqG+rTr1xFPph+5dN65r/30ha/Yw6?=
 =?us-ascii?Q?Fr2MoeAzpz09z1Zpx4oDjeDmzc8DnfAiAes0OCGNQTBCRbkO6Ypm7xrr90qN?=
 =?us-ascii?Q?l98/ZqRTpEKiledyPEo8sWfaATA04Zx0z1/l2jMg+f1/rDS01qJmHgttK4Rw?=
 =?us-ascii?Q?NhwEhHUOFSw3S5gnDTsDZ1rkZ6YSgCWCTzcwHzlsTw8ra7ROWf8doE1T3Z9b?=
 =?us-ascii?Q?9WQmhN/PXPUqFXVs5QUZjU5Fy1TMjdOPx3fzx6PtrtpYlj9T+ywOwVClADdd?=
 =?us-ascii?Q?nkOVXT9h4JsI++OQJLJmdxNLjLtVa0kTxwBGdonwCTIcmb8ni43oT7SxleTZ?=
 =?us-ascii?Q?2qagOlrKFxM9fT79y4go0r3IDiVDjZCRGUodud64KGb1sq6M/EhHlM26HXaS?=
 =?us-ascii?Q?rVuM1iSxivAFpluY6DC3s7SAdfMWshRB7xMDpWs8n0CVVms4TS8eK7EfWyMg?=
 =?us-ascii?Q?+rGwuZudvnxDPynMetbvC3P6N+xYwkMusL7Zr3UU6K7TxySKySrqqikRFSYB?=
 =?us-ascii?Q?q1MoXkuPscSiR0IwxNAHZYInsnHa+GwQslJqnhdl7pHaNTZ1h1wesl1BDeja?=
x-ms-exchange-antispam-messagedata-1: VR7FOqhRPKN2BQ==
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB5107.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f887c17-7136-4fac-58a1-08de64e31793
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2026 18:19:24.8742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fxYuF6jT2Xej813c/zo4roM4oKOd/Ch51JtOanglgHn7ipJD9fYd+JzgF36Fwx8mq16UkyJdV9JXJZjkaGFZcBHb5onlGzfvUBAJwESttWg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE1PPFF06F8354E
Content-Language: en-IN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 06 Feb 2026 04:48:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21844

Hello Jan,

I have shared my changes as an MR for the debian/master branch here:
https://salsa.debian.org/debian/swupdate/-/merge_requests/34
Once it is approved and merged, we can look into backporting it to stable.

Many thanks,
Badrikesh

________________________________________
From: Kiszka, Jan (FT RPD CED) <jan.kiszka@siemens.com>
Sent: 05 February 2026 22:27
To: Prusty, Badrikesh (FT FDS CES LX PBU 2); cip-dev@lists.cip-project.org;=
 Gylstorff, Quirin (FT RPD CED OES-DE)
Subject: Re: [isar-cip-core][PATCH] swupdate: use self-built 2025.12 for De=
bian Trixie

On 05.02.26 17:37, Badrikesh Prusty wrote:
> Debian Trixie ships SWUpdate 2024.12 which has an issue: swupdate-client
> ignores the daemon's RuntimeDirectory setting and always uses /tmp
> sockets, causing IPC failures.
>
> This sets PREFERRED_VERSION_swupdate to 2025.12 and enables
> SWUPDATE_SELFBUILT for Trixie. It also adds patches so control and
> progress sockets are created under /run/swupdate by default,
> matching documentation. swupdate-client now uses these sockets by
> default when applying updates.
>
> Closes: #135

What's the state in Debian? Did they refuse to fix it in stable?

Jan

> Signed-off-by: Badrikesh Prusty <badrikesh.prusty@siemens.com>
> ---
>  conf/distro/cip-core-trixie.conf              |  1 +
>  recipes-core/images/swupdate.inc              |  3 +-
>  ...date-as-default-socket-directory-ins.patch | 49 +++++++++++++++++++
>  recipes-core/swupdate/swupdate_2025.12.bb     | 43 ++++++++++++++++
>  4 files changed, 95 insertions(+), 1 deletion(-)
>  create mode 100644 recipes-core/swupdate/files/2025.12/0001-ipc-use-run-=
swupdate-as-default-socket-directory-ins.patch
>  create mode 100644 recipes-core/swupdate/swupdate_2025.12.bb
>
> diff --git a/conf/distro/cip-core-trixie.conf b/conf/distro/cip-core-trix=
ie.conf
> index b133bbb..4ed2461 100644
> --- a/conf/distro/cip-core-trixie.conf
> +++ b/conf/distro/cip-core-trixie.conf
> @@ -12,5 +12,6 @@
>  require conf/distro/debian-trixie.conf
>  require cip-core-common.inc
>
> +PREFERRED_VERSION_swupdate ?=3D "2025.12%"
>  PREFERRED_VERSION_linux-cip ?=3D "6.12.%"
>  PREFERRED_VERSION_linux-cip-rt ?=3D "6.12.%"
> diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupd=
ate.inc
> index 00e972e..c9dbcde 100644
> --- a/recipes-core/images/swupdate.inc
> +++ b/recipes-core/images/swupdate.inc
> @@ -42,10 +42,11 @@ SWUPDATE_SELFBUILT ?=3D "0"
>  SWUPDATE_SELFBUILT:buster =3D "1"
>  SWUPDATE_SELFBUILT:bullseye =3D "1"
>  SWUPDATE_SELFBUILT:bookworm =3D "1"
> +SWUPDATE_SELFBUILT:trixie =3D "1"
>
>  python() {
>      base_distro =3D d.getVar('BASE_DISTRO_CODENAME')
> -    if base_distro not in ['buster', 'bullseye', 'bookworm'] and \
> +    if base_distro not in ['buster', 'bullseye', 'bookworm', 'trixie'] a=
nd \
>         bb.utils.to_boolean(d.getVar('SWUPDATE_SELFBUILT')):
>          bb.fatal(f'Self-built SWUpdate not supported for {base_distro}')
>
> diff --git a/recipes-core/swupdate/files/2025.12/0001-ipc-use-run-swupdat=
e-as-default-socket-directory-ins.patch b/recipes-core/swupdate/files/2025.=
12/0001-ipc-use-run-swupdate-as-default-socket-directory-ins.patch
> new file mode 100644
> index 0000000..e87c8bc
> --- /dev/null
> +++ b/recipes-core/swupdate/files/2025.12/0001-ipc-use-run-swupdate-as-de=
fault-socket-directory-ins.patch
> @@ -0,0 +1,49 @@
> +From c89f62d0a68e5c45e3f052edf6c3d77bba8c67e5 Mon Sep 17 00:00:00 2001
> +From: Badrikesh Prusty <badrikesh.prusty@siemens.com>
> +Date: Tue, 3 Feb 2026 11:25:18 +0530
> +Subject: [PATCH] ipc: use /run/swupdate as default socket directory inst=
ead of
> + /tmp
> +
> +Change the default socket directory for control and progress IPC from
> +/tmp to /run/swupdate.
> +
> +This aligns with systemd conventions (RuntimeDirectory=3Dswupdate) and
> +the documentation in `doc/source/swupdate.rst`. It also improves
> +security by avoiding world-writable /tmp and provides deterministic,
> +predictable paths for both daemon and clients.
> +
> +Signed-off-by: Badrikesh Prusty <badrikesh.prusty@siemens.com>
> +---
> + ipc/network_ipc.c  | 2 +-
> + ipc/progress_ipc.c | 2 +-
> + 2 files changed, 2 insertions(+), 2 deletions(-)
> +
> +diff --git a/ipc/network_ipc.c b/ipc/network_ipc.c
> +index 099587d4..e167d0b1 100644
> +--- a/ipc/network_ipc.c
> ++++ b/ipc/network_ipc.c
> +@@ -32,7 +32,7 @@ char *get_ctrl_socket(void) {
> +                     socketdir =3D getenv("TMPDIR");
> +             }
> +             if (!socketdir)
> +-                    socketdir =3D "/tmp";
> ++                    socketdir =3D "/run/swupdate";
> +             if (asprintf(&SOCKET_CTRL_PATH, "%s/%s", socketdir, SOCKET_=
CTRL_DEFAULT) =3D=3D -1)
> +                     return (char *)"/tmp/"SOCKET_CTRL_DEFAULT;
> +     }
> +diff --git a/ipc/progress_ipc.c b/ipc/progress_ipc.c
> +index d3689271..382a83c9 100644
> +--- a/ipc/progress_ipc.c
> ++++ b/ipc/progress_ipc.c
> +@@ -41,7 +41,7 @@ char *get_prog_socket(void) {
> +                     socketdir =3D getenv("TMPDIR");
> +             }
> +             if(!socketdir){
> +-                    socketdir =3D "/tmp";
> ++                    socketdir =3D "/run/swupdate";
> +             }
> +             if (asprintf(&SOCKET_PROGRESS_PATH, "%s/%s", socketdir, SOC=
KET_PROGRESS_DEFAULT) =3D=3D -1)
> +                     return (char *)"/tmp/"SOCKET_PROGRESS_DEFAULT;
> +--
> +2.39.5
> +
> diff --git a/recipes-core/swupdate/swupdate_2025.12.bb b/recipes-core/swu=
pdate/swupdate_2025.12.bb
> new file mode 100644
> index 0000000..d53545e
> --- /dev/null
> +++ b/recipes-core/swupdate/swupdate_2025.12.bb
> @@ -0,0 +1,43 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2026
> +#
> +# Authors:
> +#  Badrikesh Prusty <badrikesh.prusty@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +
> +inherit dpkg
> +
> +require swupdate.inc
> +
> +DEPENDS +=3D "libebgenv-dev"
> +DEPENDS +=3D "libubootenv-dev"
> +
> +DEB_BUILD_PROFILES +=3D "nodoc"
> +DEB_BUILD_OPTIONS +=3D "nodoc"
> +
> +FILESEXTRAPATHS:prepend :=3D "${FILE_DIRNAME}/files/${PV}:"
> +
> +SRC_URI =3D "git://salsa.debian.org/debian/swupdate.git;protocol=3Dhttps=
;branch=3Ddebian/master;destsuffix=3D${P}"
> +
> +SRCREV =3D "1fa1ce0c85423f228529d2fccbe8813f07040536"
> +
> +# patches
> +SRC_URI +=3D "file://0001-ipc-use-run-swupdate-as-default-socket-directo=
ry-ins.patch"
> +
> +# Disable cross for arm and arm64 on bullseye
> +# with cross compile we have a unsat-dependency to dh-nodejs on arm/arm6=
4
> +ISAR_CROSS_COMPILE:bullseye =3D "0"
> +
> +# add cross build and deactivate testing for arm based builds
> +DEB_BUILD_PROFILES +=3D "cross nocheck"
> +
> +CHANGELOG_V ?=3D "${PV}+cip-${SRCREV}"
> +
> +do_prepare_build() {
> +    deb_add_changelog
> +    cd ${WORKDIR}
> +    tar cJf ${PN}_${PV}+cip.orig.tar.xz ${TAR_REPRO_OPTS} ${P}
> +}

--
Siemens AG, Foundational Technologies
Linux Expert Center


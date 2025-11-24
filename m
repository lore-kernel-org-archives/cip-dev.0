Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F6A9CFD377
	for <webhook@archiver.kernel.org>; Tue, 25 Nov 2025 03:24:26 +0000 (UTC)
Received: from SEYPR02CU001.outbound.protection.outlook.com (SEYPR02CU001.outbound.protection.outlook.com [40.107.44.62])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.21287.1764002675332486781
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Nov 2025 08:44:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=vGqTQC4a;
 spf=pass (domain: siemens.com, ip: 40.107.44.62, mailfrom: gourav.singh.ext@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YDYZz0uwnj7Pz8SL3EfeW2SVfds7WA054UEh4/jxk7LdX8IgA3neDnrDd2sVTTE7Tk/coYnocIG7jp5iomf4T0Ej3/lUm17X3oYMzFqBFlDJWiz6irxRLabLczt71p/JdkH0Kfs2zyQ/8dZO6qB9gFalXq8hhoCqCXCeqcKJY2HPLo+Azf49NizMUPAMXW71bP9RW+5BEo0AcJE6/nm5H/EzGhO6nZ/VzeVX5MGDtiSteMkELbHIel7VNXdeqlNhZIuR0SnBijxH1qtUXATJj9XXn2LvhQgnplijJENZYXSdAwZHCzBeLUmM7fe6nUZaucytgqKHX+02NDTOneydnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=45hiosYEUrIP8vAYyHtGsy6rs75f5sjoHo44Rv0QxO4=;
 b=ANnoD/BCuew4DZn4aawfQjS9IL9UBwoKNoK/pfwQKHbn0rKZtKWso2hs2UeHup3l0DPGHnCN7WVNT9v0rpdbX4yL1hucAuLFA3d2ZpuiiRMvM05NiDwchQMNOxBKJgH0R/XYIhgqNdRUY1B3UKcJydmWP1JLKwNThZAxvi5G/TeluA0euM47LbM4d1HqtzRLoolFc6Nt0ve0W/a3kcrnj4S+ynYLo0mcF9gQcRt1r2bOk2P3ozC7f02AdFIAZprEfiJqUSarCJF3o7NawU9IlXspGpgSnn9SPTha18c8ldzkXa/iTEKjKUB8OtD6jwbFZDJ6rHPDwCkEiURM8k8QHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=45hiosYEUrIP8vAYyHtGsy6rs75f5sjoHo44Rv0QxO4=;
 b=vGqTQC4a2LZ1s/2D83AEk58Mdyj8qjZvi4yahef8hjol6LmiFnNBfqRqlGcGeiIrKS7O5hsu2/knp2/jLrxJIm4jIskCnvcOmeKkgh1W9DJfO4u64D7YFKzTxdSb0ijrkZ5GjXxEPydARPRMdhZwR9Volq9eUET7EECHZ7NOh589wF6eyKBL3wCpZvqABrvqIUeq4oBnE1/cGjZPINL2iX0OTmgw1vPJUs5fU3FDR2XutHhJm+tmOj9n8Rk/z/dB5Ri8VXwyTATA0KtNvMm3t8guyPYgAjbzJCZwlWkRgWUvPweZ2YlCKohlY++tj7ZLUEyZqdJzqdz58I4rppxd5Q==
Received: from KL1PR0601MB4697.apcprd06.prod.outlook.com
 (2603:1096:820:85::12) by TYZPR06MB6022.apcprd06.prod.outlook.com
 (2603:1096:400:340::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Mon, 24 Nov
 2025 16:30:07 +0000
Received: from KL1PR0601MB4697.apcprd06.prod.outlook.com
 ([fe80::d8cc:5aa0:b437:a0aa]) by KL1PR0601MB4697.apcprd06.prod.outlook.com
 ([fe80::d8cc:5aa0:b437:a0aa%3]) with mapi id 15.20.9343.009; Mon, 24 Nov 2025
 16:30:07 +0000
From: "Singh, Gourav" <gourav.singh.ext@siemens.com>
To: "Kiszka, Jan" <jan.kiszka@siemens.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
CC: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>,
	"dinesh.kumar@toshiba-tsip.com" <dinesh.kumar@toshiba-tsip.com>, Kazuhiro
 Hayashi <kazuhiro.hayashi.f74@mail.toshiba>
Subject: Re: [isar-cip-core][PATCH] fix(security): add libpam-systemd in Debian trixie
Thread-Topic: [isar-cip-core][PATCH] fix(security): add libpam-systemd in
 Debian trixie
Thread-Index: AQHcXQAcb4lZNF08PEGqGw5QdOFJ0bUBY1sAgACg96A=
Date: Mon, 24 Nov 2025 16:30:06 +0000
Message-ID: 
 <KL1PR0601MB4697CEAF6AACC78EAB99E5CBD5D0A@KL1PR0601MB4697.apcprd06.prod.outlook.com>
References: <20251124050607.876836-1-gourav.singh.ext@siemens.com>
 <345f8c1e-0166-4946-893b-02dba9dd71ce@siemens.com>
In-Reply-To: <345f8c1e-0166-4946-893b-02dba9dd71ce@siemens.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=85948fb4-68e8-4bdd-a1d8-be3149dd4506;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2025-11-24T16:27:00Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0601MB4697:EE_|TYZPR06MB6022:EE_
x-ms-office365-filtering-correlation-id: e8c6499f-e2ee-4d9b-2cca-08de2b76ba94
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|7053199007;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?XFOkoGuK5am19pz9GcdwwENAZacVW5bONQGUbl2F3tK50Mvbf1tLHWHSffZY?=
 =?us-ascii?Q?VdcWve9M8dUHrYaEZsd9th0/SSK2KmWyRUAjYSmxj6SVasd3cGUE+NFSSPCl?=
 =?us-ascii?Q?L8CfYcRy7pc7gkfv0ND7aXBWTAPv51AwtZHfVZkh4r1hSfhyMMYjDFnG/3r/?=
 =?us-ascii?Q?t9cgUhiyDF7UP7ZjAg8euCD41qQloAmK3azqZLmlWury1aNAaoy8KMrjvMvE?=
 =?us-ascii?Q?TOTuVSglE5PIeCfdMBHeLbakc6TFdjI7dW/Vi2swlxSqt4lKvoSFSEgRlDdM?=
 =?us-ascii?Q?BQ2bVWT1Bmj7xYOVSPZSepU+Z5/GCJBKhzP/m4CdYPDuyyMfUCAyF9R4QzNJ?=
 =?us-ascii?Q?PjJCO0DaDEg8zQ3O5tiU2kljyIhLE+FBxTQhJNPUSiw8B3IxcJyf/xRVLjnM?=
 =?us-ascii?Q?jMNjOkx7FbxVNhBwaRfndCmXxWi/BJD0VPtzKwJk1cPY9u2zJom06W0S+bu1?=
 =?us-ascii?Q?wxgDXIFMMXQKMOn4vEnyGkcOKF1Ty5mm/DpTXPwnKL2qvJ14iuFlqnOpfN5a?=
 =?us-ascii?Q?IDhMeETt7NUS/jez/Ne3oNxvzERQjURj6IlNuaYvTHt+rHXc7K+aFJWGJrtg?=
 =?us-ascii?Q?wNAV0JMk5HFtcxo8cAzUOzy7174T7MPzkjPeOhJNfGDVp6dzRbFJ5YGadz35?=
 =?us-ascii?Q?qr5cdnPILaWvbDQgRyHZeCq7o9Eo5NDxNWOOoNycYraOmsiOm3DFkQnclD8j?=
 =?us-ascii?Q?jZXcmeG4gJ467FA0MINMhSbB0juBT7mSk5MJb7P5qrpPn6B+wvDM3AJfI3vy?=
 =?us-ascii?Q?6HNjGZHgVo+ZxdNNO11WwC1wuPxS75Sei7NPHqjeeNjN1jjJ+tNjOmaZL1TS?=
 =?us-ascii?Q?32NdKo/bpxmyl0/bk5eYI3tVT1cGvY7gdZzSuCJUimGWTJiwFkaGe4g/dKqi?=
 =?us-ascii?Q?yomWJwzEErzLjfClgrrr2zZlzvmSVcgn/DJM5Z6DRquW8kIpc33XrQblauPK?=
 =?us-ascii?Q?oyvs9TeJO8i4st8b5TNubn3mXjepqjI9eCZb89PEFJdUDl4gZeqKwSYcgtXa?=
 =?us-ascii?Q?9Z3Wz659dVE5r3kotRePp1W9R59PGzhUD12Ub5eZbXEXfhrCvL4Y0/FV/1Kb?=
 =?us-ascii?Q?wAg/6i7V10qeSXEACbI6QEdkzmpaWZyUHNAey0IMUS+fn+r5epjRhO2Ll1wF?=
 =?us-ascii?Q?k121umUB7j/Anykecn4SHXpo7Bm7Mt2s/I/gapC0NumuUEqqwGnyjrAHyUva?=
 =?us-ascii?Q?FXuuCFpaKH6RaVldmjrVNTvtm5YgExiyq7O+oB40UcM/UKzE6JdbqWMfpntC?=
 =?us-ascii?Q?Z7tbfZ3vMY4+2QbXmELN3B50VGn/JY9MorvCc2HPyjha9jmldV2gzysgz2AD?=
 =?us-ascii?Q?GThIHtgHotbQ8lYu6KyQEfC+VIqHfWajRtv9T/qLH1EURFI0PPcWE4n2pVFE?=
 =?us-ascii?Q?l2oGBJyB2zayriY1LhmLkjZvbcGHnMyAGnZPYnCKy26QjS4O4zaFuPHZe+3P?=
 =?us-ascii?Q?u6UkT5ZZu9qBTpnDWd7V30UCL6YLSLQCcNZu9zlf7DmraE6oXaEzxQ=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB4697.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?KbsWVATroYipPiq4pZEzPrcFYloknG5LszxCKxQxsEa/q7Mre3Ua9A1j+Q1D?=
 =?us-ascii?Q?HywQvITD/WHWo1lbAVrgHj1egFnUMI/TvfWWejvFyqL0/X82I24Z9Cvv1R0C?=
 =?us-ascii?Q?Rr9mGC756QDXfaB3apbmy794k/zFsT9CqZXyGKuS0ZYcjfuDdjOzwNygwNnv?=
 =?us-ascii?Q?A6NeJ3PoYMHbhDDuopdWi8Yo49uww8g+DFGAdx7cnGdJKPohGhyLPCOSR9l6?=
 =?us-ascii?Q?oiS25kclFwclNhS8imdhgaTA/vUoAetrg3FGOdaW4q5T5wuGQH0AzXAfTnQx?=
 =?us-ascii?Q?iZrNsUWzemRS8CeYEEoEfwAjX9XOyHJ9BrhktKRJxW/v4ict9WB8g5Swvv8F?=
 =?us-ascii?Q?3oVWTt5SGVuOpr/jq2C2ZNrbgrDO0KROIMOOCk71AsAAhGEpRMWI6g9TOV2n?=
 =?us-ascii?Q?n283mCCSxZOLJV9uaH3xYpRiBOvOqHe9r5Z/YP9S5wsNzVn/obog+M/saO/q?=
 =?us-ascii?Q?WcZiMKJmCc9UExIBss1kQ5RR46CtehnyX3iyHNnKXPhx13e6UESY5GkMM5UL?=
 =?us-ascii?Q?21W8nDtNBNrvmZ/+2O3c2RRLnOBoZUq6acQRPY8WsAcWXVlAFEbCGDns5UK0?=
 =?us-ascii?Q?PPzuDVjDV9N8JUo8UuEzS5RGetvVOaftYvycmomBUcMzpIH47jQW/s+ljYwn?=
 =?us-ascii?Q?sXGr6V9xXoYmgIlfPpGMRavVzJEHskLCpP+xo76TYSvfQmGID6oQMcQQbu+R?=
 =?us-ascii?Q?s0BIXCSOkLuqRCOBmBiTvjGC9RSrKeqwcL+aHLDPsHP16WvMqFm27avzAjyz?=
 =?us-ascii?Q?3N9qHWx4ZwXMG8TFg6VkZaI36zxoSSNZbsLTxELofun7lQTyUlUM4E5YV2Ub?=
 =?us-ascii?Q?yfwyp07bVx8Kd97lsooXBkroRNwzEZxK7oJ+P9OvWCvEMb/YoRpfTiTo2+Mp?=
 =?us-ascii?Q?RYRNrPdIQ35k4i119d3Pb6vLfEWHJIAkaVmCWGYJXNMGq5QfFwATvhCBEQcR?=
 =?us-ascii?Q?yIzH/dbrD8OR0R1MXLm0FMKo2X7P+C+NvDGHFaFgIdJ+UI+u5/kVCuRK4KNQ?=
 =?us-ascii?Q?psotnSY8nlzVrU11aABnU9G8tkyJOduDeUrbogVKxcHTINAJscntQ1KW8AqE?=
 =?us-ascii?Q?gjqChzBMm8zCxWYfHZDNI8R8x/Z0c6Id6ca1JaAM0K4yiypW36LWisSOdTev?=
 =?us-ascii?Q?Ueq6AMGqU4KrukfyGav7WyYiXhSjhAE4Gr/Bj4ZncDws6xUSNIuE+FP9Tn8O?=
 =?us-ascii?Q?3uitRc3ZBClsMpqGZ61CvQ7VdBdbm+ZHPJLvrHvlckvfxdApp37ULnGX99Mo?=
 =?us-ascii?Q?ndlC99olgs0twabFIMpJQM1Pa1vib/SEEslNazD0Uj6vpbN5YvwBJFTV+1vM?=
 =?us-ascii?Q?3T4zmePpxKJZhK2469S4S4DRI3pDcNgTN/tCoaVzD8VKAVITrsfOlh5WomY3?=
 =?us-ascii?Q?LuegfPVpJ2cbDaGq/TyWMD//vPrIrsVxUuvd4VJ0PjjBsyBHorjTLF4KcKOE?=
 =?us-ascii?Q?Vzhv6zwXSIMnvcdoYYwRpeotvUJbaxpb6q5v01+kTZZBIZFXvoDJO7CVDlXu?=
 =?us-ascii?Q?msYloMgrqF3r8BbJM/SDOXt/PdgVEvWyoAnPBz0DNJrBhaclIRbT3grIHFhO?=
 =?us-ascii?Q?e1m7c6uxAx8rLua7J2vyvN0M//K6reC1PPYTHHuPmR1uzKkBwVQqRLDEqSwT?=
 =?us-ascii?Q?3w=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4697.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8c6499f-e2ee-4d9b-2cca-08de2b76ba94
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2025 16:30:06.9025
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6Y6hASm4b8ZR5lN8YwqaAlCsXJooodlOfxwpFco/iFd1wuHgjBuIuVXlBdp3nBZjrNdW3HNIDw5HysEQ+lCgnL560CRUnqMPLfJYs+RlNPc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6022
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 25 Nov 2025 03:24:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20720

Hi Jan,

Regarding customizations or configurations for the `libpam-systemd` package=
, which provides `pam_systemd.so` - a new systemd mechanism that replaces t=
he traditional `/run/utmp` for tracking active user sessions in Debian Trix=
ie - it is necessary to ensure that `pam_systemd.so` is included in `/etc/p=
am.d/common-session`. This replaces the traditional role of `/run/utmp` in =
session management.
Ref: https://lists.debian.org/debian-release/2024/05/msg00150.html,=20
https://ddp-team.pages.debian.net/release-notes/en/html/issues.html#the-las=
t-lastb-and-lastlog-commands-have-been-replaced

Thanks,
Gourav

-----Original Message-----
From: Kiszka, Jan (FT RPD CED) <jan.kiszka@siemens.com>=20
Sent: 24 November 2025 12:21
To: Singh, Gourav (ext) (FT FDS CES LX PBU 2) <gourav.singh.ext@siemens.com=
>; cip-dev@lists.cip-project.org
Cc: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>; dinesh.kuma=
r@toshiba-tsip.com; Kazuhiro Hayashi <kazuhiro.hayashi.f74@mail.toshiba>
Subject: Re: [isar-cip-core][PATCH] fix(security): add libpam-systemd in De=
bian trixie

On 24.11.25 06:06, Gourav Singh wrote:
> In Debian Trixie, /run/utmp has been removed, so traditional=20
> session-tracking mechanisms (used by w/who) no longer work.
> To restore secure and correct session accounting (needed for enforcing=20
> limits like maxlogins to comply with IEC 62443 CR2.7_1), we can add=20
> libpam-systemd.
>=20
> This ensures that PAM can register user sessions with systemd-logind,=20
> aligning with Debian's design for Trixie.
> See Debian-devel discussion: "/run/utmp is no longer provided in=20
> trixie ... replacement mechanism provided by systemd."
>=20
> Ref:=20
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flist
> s.debian.org%2Fdebian-devel%2F2025%2F04%2Fmsg00011.html&data=3D05%7C02%7
> Cgourav.singh.ext%40siemens.com%7C13545a99022f43a55dce08de2b25d0fb%7C3
> 8ae3bcd95794fd4addab42e1495d55a%7C1%7C0%7C638995638612273708%7CUnknown
> %7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4
> zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DtNzGl6b239zR7
> GFA5WPQwQwSi0fRIhXp5hQchE7pxKw%3D&reserved=3D0
>=20
> Signed-off-by: Gourav Singh <gourav.singh.ext@siemens.com>
> ---
>  .../security-customizations/security-customizations.bb         | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git=20
> a/recipes-core/security-customizations/security-customizations.bb=20
> b/recipes-core/security-customizations/security-customizations.bb
> index 717e2d3..d8fa22b 100644
> --- a/recipes-core/security-customizations/security-customizations.bb
> +++ b/recipes-core/security-customizations/security-customizations.bb
> @@ -25,6 +25,9 @@ DEBIAN_DEPENDS =3D "customizations, sshd-regen-keys,=20
> libpam-google-authenticator,  # - libpam-passwdqc: Preferred for newer De=
bian releases (post-Bullseye).
>  DEBIAN_DEPENDS:append =3D ", libpam-passwdqc | libpam-cracklib"
> =20
> +# Append systemd PAM package to limit concurrent sessions in Debian=20
> +trixie DEBIAN_DEPENDS:append:trixie =3D ", libpam-systemd"
> +

So, no configuration needed? And does this obsolete any other dependency in=
 trixie?

>  do_install[cleandirs] +=3D "${D}/etc/ssh/sshd_config.d/"
>  do_install () {
>      install -m 600 ${WORKDIR}/ssh-remote-session-term.conf=20
> ${D}/etc/ssh/sshd_config.d/

Thanks for tracking this down. I suspect that our certification efforts are=
 still focused on bookworm as baseline, but this is an important step ahead=
 already. I also hope we can soon switch CI to trixie, currently waiting on=
 lava-docker updates on the workers.

Jan

--
Siemens AG, Foundational Technologies
Linux Expert Center


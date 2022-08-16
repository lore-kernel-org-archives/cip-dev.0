Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 215D2C28B2B
	for <webhook@archiver.kernel.org>; Tue, 16 Aug 2022 11:51:38 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com
 (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.136])
 by mx.groups.io with SMTP id smtpd.web09.14821.1660650688445866931
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Aug 2022 04:51:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=gsjjP8SS;
 spf=pass (domain: bp.renesas.com, ip: 40.107.113.136,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZYQZtUl583QuNFmH8uLBifGKifdnXI0PtCK4rkIIj2urC/erE21Mlv1cXnixUjZctVXXqPTvkyMI+G3Eyyd41MfnWKHjTdTv7Wa02K7K+Kwkc6ENGP65AEnWO1KosQgS+Zz4CyI8l5K5a94qYmbk+iIpOEYkggQMH4E9ME3MblFJ4Pd9HecSfxQUyUbKgdxDloxUVvlhcGiI7aABWRX0vJW3LQgjSbZwoAZuv8lWSJ7SgFd8Ge78fJ1kPWHUpqX1f3+ROMJnEtpMxKNpG+Y6snZzXW2K19Rp+QSlVd2H/gd1AMGJ0q4R4TQeUrUA5cP0dN+aW3ULyTmiESC6DPGnTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mdT2s6GibNmeD2oS74PUhx+wqIVHxi54Muo8iPxW6vY=;
 b=HLGZznhKj8ty7xXAx9lzQyiPElQBiYsaxZGUQfHCj5TOonzkIaWdMhkJ1wtYJ7f2AVGez55ZSf/gPVSHSP/kD0NZIajl1y5WW5HFI+MHp16NoFN/wx+aXnI3yRj17EYm2LO8KJjR0HbNuNgTRDLXveiPI2lPdecgtPAUf3zK87jN5VmKZiUtMK+tG8/fUNzQorDDDzpDedjvyxhoVSV6WQ4P/dJFUHUeUd4Mslp3Czb3GnAEVr27Vh5YbEqymKsZIKbk7LX1hk7FiMtlD0zGnmZFBuXTsWxV4U9p48fhElA1j+MrMful7I6dhkOpuRAfGClbNmaB5Ku69FoFzhRl+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mdT2s6GibNmeD2oS74PUhx+wqIVHxi54Muo8iPxW6vY=;
 b=gsjjP8SSFTPSFO7EN7h8B8T1Bd/5bDwtiKReVCvPDMsQzHEQwhM3nCL3TpEgz+6dRnNKZdhz7U2pNS2yEEOQcgevQnXzmQxoMwneC1Fiu6CDPKz6zsu8kg0I5UxSnYIcZJf4Kpf2bBGW2xzeGnpCTWpQ0GvpRY+LCQn3G9i2MDE=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by TYWPR01MB7425.jpnprd01.prod.outlook.com (2603:1096:400:c6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.22; Tue, 16 Aug
 2022 11:51:24 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::bcc0:2df9:c146:8c18]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::bcc0:2df9:c146:8c18%5]) with mapi id 15.20.5525.011; Tue, 16 Aug 2022
 11:51:24 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 0/4] Renesas SDHI/DMA/thermal driver fixes and
 improvements
Thread-Topic: [PATCH 5.10.y-cip 0/4] Renesas SDHI/DMA/thermal driver fixes and
 improvements
Thread-Index: AQHYsWWI11MrKCvhAUOORv2bPT2u8q2xaIUw
Date: Tue, 16 Aug 2022 11:51:24 +0000
Message-ID: 
 <OSZPR01MB7019E251B422E91203D2F7FCAA6B9@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <20220815163718.24056-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220816114408.GA27428@duo.ucw.cz>
In-Reply-To: <20220816114408.GA27428@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5c04892d-15bd-457a-a1b2-08da7f7da4f5
x-ms-traffictypediagnostic: TYWPR01MB7425:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 EIiHHqflS4X9P5Yeyn/kf979leLn7EzR0Moitf14cVFwp14flJ6nAF9Wj9ErHta0MvYDkR+65lMfFR+eYohiBVOnbxG4OBsCFtSdN9TYhwIFumLAczrje0GZ/DFidUFbkYFs5UNiSuPlXgvK2havX5EU+q5DF7ymq2LTyPRs6KIuChuiakYRxjKqNyYFu0+i6SYXHgRzRyIlDNlMt10GwrdH01PirCwyfF0yElxfaVEiSNXsF4UPEVhOP6/yUOdFZW9DISQD8MfY1Syjdf2dBFIME5XpionayuocnqR8eCdG8NrJ5WaUEOlIyr5udbgOOWS5DgSW3KN81OqfS+y7RFdH9fAIE37mfIbwjhm2t4cQKYytYHSNaARo2KoHA/l9oKq2KYD0HHDCLXFp8ZW7X8gt7z4WTcJ6YsiUsBDpVAdYSrtmf2ea1M1put2gbB6Gv25rDZA0XrT/45R+tMKs0HFEP+rNS+g8pg5YGh3I0vH3ogiGlwiuRTBw7aOB0P4GjI8gh4nI2UED9RJuSJvSj+uJWdF4NmMsq5kcfr3EgyxbXgTJHskHh7gcI9JlxilU9N4fVjE5A2EOPq94nsLSgGIPcYgiSW/da1dnH33Q3ZngjhRNxc39Cdn3uZU2BfUcuncqDzTfiqQMTfdL+p39dCu7PsVN1LgPRBsHZPBBpXfBoPefwtFgcAeWoSsS6WsngXj/6OZxMNUaCYhGYNOVyN+CrDxrnG8JPO3/iGRJC4F7plkAYmGx7CF3qeVfCpGsqT98WcNdf5gEzEaXQ0TcWf758gNRUovORw27tTGkrQtjiMZfEINQtwTwxepTK7lt
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(376002)(39860400002)(136003)(346002)(9686003)(33656002)(316002)(54906003)(6916009)(478600001)(6506007)(8676002)(41300700001)(26005)(7696005)(71200400001)(86362001)(8936002)(64756008)(66476007)(66556008)(76116006)(2906002)(66446008)(55016003)(66946007)(53546011)(4326008)(52536014)(5660300002)(83380400001)(186003)(38070700005)(122000001)(107886003)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?L53pnZy0SAxyHe8bWAtRKNTISqAzv6tGSCezGlMQylMsS5JDi0y+nZKetH7N?=
 =?us-ascii?Q?YnTq98aGp9k5h45ZVphL9UQUh9vdsUMgseNAiaU+DXmNj7KSbTsCead6i0hj?=
 =?us-ascii?Q?RHrY1Z+NllFCmM8kprWany5i5o2w0iOmxllSuBM/eJSK0Yfvrjgq9saUej1O?=
 =?us-ascii?Q?Dt+Rvy+0wvF+QJVajjjFCTvq1JnXRj8oWLoEX1gFROIicRrHvjl9XtUDCJrI?=
 =?us-ascii?Q?/8aWDicI3jtOKJSydbHG8ELI1jsFIvNuiIw4qavqu5TM2SkjcOXvze6W7T0j?=
 =?us-ascii?Q?BQOu/S0zDnoFvPJxMuNbmZ7G8W3m4ZaVh3c3pOgzNqT+D81+pwUc4wmKMM2I?=
 =?us-ascii?Q?dh7XYNg8oQI6tfWT4aRgmFQbznHfNos+dMyqgq9AVvZHB1M5zrcNkoK8Gvcx?=
 =?us-ascii?Q?PRvhd48v8T3Efrvv3kUBN0cv8bN9Z5Uk5VXpAYqLtDksnFCUA4G+3jVWHcu/?=
 =?us-ascii?Q?xmF6l5zLtEdB9fkKHpmpWAEfnpSCcbIKkcgomcSG8wvpNOLVqzoBYZ0ceBgP?=
 =?us-ascii?Q?Tm1TvqPgJpYxUjtqXMHgbHAfb3vdOLBlnTdlYv6XbhyullZ2UT9mXWV7R2x3?=
 =?us-ascii?Q?eve8Sg6R6cdTWEztB/caB9JCoQjL+yr9oXsGby9g0/AG62VF6rRr93OqOT7a?=
 =?us-ascii?Q?/253wJXfgNgs95LTaSKUAcYujqgSR5wqDvyxniBwVEv8UkI7fz5Y/M+rCF8i?=
 =?us-ascii?Q?Og+tk3C1EkwsYk0iZH1ZsDaeFUXgXexszYn+RADbZ5kvUmyos4vminWhrJXD?=
 =?us-ascii?Q?FkgjqP1jQhmkV4aZU0cdk75YJKKxTAOqkrHR3xKPOxXA8cme/UhD5ic2u7Zv?=
 =?us-ascii?Q?JCryfeRy1YstlGywYmc/2JZF+3QTtOgj0/Ggo8kt+RNwlvJYB4CoheC0WcHj?=
 =?us-ascii?Q?EYDK7qibisDtDtg7WlvFf22xqrc+wCjX+bcLYralHvYpGw56XWlM7Ext2qNW?=
 =?us-ascii?Q?F8VL6oIjZcp1r9OYnWVgd+kWtBgW9D3pKNYLAitkjCdDIf4fnKzztwX2PqeJ?=
 =?us-ascii?Q?voU0FMPNQPtwAv+TWGoZEsvVeKUCXMD8FEXXfFH/tclPEHN+w9naJ1CTjUEf?=
 =?us-ascii?Q?uSlAzhnNHuhMkzFV1kYm055sF4u5RgotxlCy6S9fwYiP8C2qrOqlAZzn6Fuv?=
 =?us-ascii?Q?7pMFZyAZ1zOCHeVE1xxmAlQeY2vpmHY9zQJb4UtHbKuYTRqKVQ2Nzr2rTIp1?=
 =?us-ascii?Q?qOVhJ/Za2/w2hW+1zL0lvWCXAJO+M75jdgfG2VO/QYEeruA6SJ1Oh5H8dV9I?=
 =?us-ascii?Q?Kovmt3HrA8k4cAX71MPnSTd2T3RwfqEOi0ho8WGXB9CnqHuWo252+PvVyaWP?=
 =?us-ascii?Q?ZP+uxAxNrPyI0LdTiwlUIS6qymC0tyZdRFUm/EBCxSHETqZMRXl7wepoYtvC?=
 =?us-ascii?Q?NMD3Q7AiMXUPwMMcpf70/oG11r6ste99vvJ+9DNkUQqieRa4ligLhCQaGF5h?=
 =?us-ascii?Q?qvw/xkhxocroNAXORwoDgSeLK5msXzAuLMnsgakF4IW/PEqK1CqyfDhiOyGo?=
 =?us-ascii?Q?K8JE/k9etaQMKazxql+GwfRoHS5ikRs1+UU1toGMtGBHTJohuxokCepPbHn0?=
 =?us-ascii?Q?VGQuJJA8vjklxdksYZIC2KDjiDMog9bx67tXvA9eaNYmKpR6CXXZm16qTL/E?=
 =?us-ascii?Q?68I/i+A0Wrxnb0efyESAbvw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 5c04892d-15bd-457a-a1b2-08da7f7da4f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2022 11:51:24.1078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 3xFK+h1MQYep/VErp9bsQ3i3lZ9LacMRdmyUxW3KuqntflV52gO2cD4+PLf+EJz3hXZUifBLZhGf3wLNSYQILxr/zgDzrDEj5TD+dweREiSSZDoncSFlf8rqUCXmrTcf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB7425
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Aug 2022 11:51:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9218

Hi Pavel,

Thank you for the review.

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: 16 August 2022 12:44
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@=
toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>; Biju Das <biju.das.jz@bp.renesas.com>
> Subject: Re: [PATCH 5.10.y-cip 0/4] Renesas SDHI/DMA/thermal driver fixes=
 and improvements
>=20
> Hi!
>=20
> > This patch series backports SDHI/DMA/thermal driver fixes and
> > improvements.
> >
> > Note: All the patches have been cherry picked from 6.0-rc1 kernel.
>=20
> Series looks okay to me. I wonder if we have code using rz_dmac_device_sy=
nchronize from 4/4 in the
> tree?
>=20
RSPI uses rz_dmac_device_synchronize from 4/4, I am waiting on the patch to=
 be available in -rc release. I have tested it locally hence posted it  ear=
lier.

> I can apply the patches if they pass testing and if there are no other co=
mments.
>=20
Thanks.

Cheers,
Prabhakar

> Best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany


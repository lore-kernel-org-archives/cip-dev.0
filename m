Return-Path: <marian-cristian.rotariu.rb@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3E660C013E
 for <cip-dev@lists.cip-project.org>; Wed, 19 Feb 2020 19:18:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 28232843C8
 for <cip-dev@lists.cip-project.org>; Wed, 19 Feb 2020 19:18:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oU_CzT022up1 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Feb 2020 19:18:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from JPN01-OS2-obe.outbound.protection.outlook.com
 (mail-eopbgr1410108.outbound.protection.outlook.com [40.107.141.108])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 147988086D
 for <cip-dev@lists.cip-project.org>; Wed, 19 Feb 2020 19:18:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MnGa9S/Pg95h2gjKvs9MdtMSHGcYzcdJc1ADR0SZScdPhDaQMaSDOmu4dX4zZgkWag5oIiU3qkSmm70CDlBuSU/lrOdLnfPqTGu3Tf2il40gci7Ne+Yud3+yEZDe3LRz+0e8cMAtfXFQvcg6W23joN+GgKSje4pQldkGCK782Ox4SYpI/A0pAtAkotbgBcSalBlYUfS91zlwZqfXYVLaHjozYOkTSeFqpN6XgOpxK6/rD6/E8MmorLPVx5MO9dCUVMN8wvCoZExef7xiFzEpF9/Fjs21lIaf85ZXhXOIVL5Mv3pWATd6NOFHco/o0Dc/fkiPkvhJmGSQpvy52pfaKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ntlixJ9XTkv6Yb2KB6SOP3s/lw6AU+eSGQW3vS5kmw=;
 b=N2nF0TRUzNK5Vu1hVSImsw4Ajy0U7adYCQIMfnzk5FhRGJIJqNbF5lVBISPZ2aZ08I0oEVcWWfP41c8qeaOZIFoYzUU0GoB53wxrrxMYBCqZnfV0oTq8M14gWb4fEuB6wYqInlC56aGgATRMzcnlegtI0WDYTITjqKPKMs3foEfELxN5nyeAMMX3oIc5JO+iSWUJFsNY2DS/WusnTekk5kblfu0VygwUdhgY9gFFw3iHCa8wernl+G49OMYZkoJhyK8RLbdV1P5D3SZntQA3W/1BmMamVNjXP/3d9m4nLvrwsMKuF4MdKiJPEN/MSASm8GS+klxcxWsnqQ+9do8rBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ntlixJ9XTkv6Yb2KB6SOP3s/lw6AU+eSGQW3vS5kmw=;
 b=dFF5zqpKVxsMWiKcW2AHIimRfTakDblsZ+ipJ1Y14kZIMKaDqG2PHS+UhR5KG8DVo6emC2GRtPViBXKze9R+LrxQx5QFLzc1xFUF8KdtZaymR4adCGvcukZANXKExB8qC50D7gcyoMxDDnBzes+HKvugh2IHU3UUb1w0YK4nnj8=
Received: from OSAPR01MB5028.jpnprd01.prod.outlook.com (20.179.179.149) by
 OSAPR01MB4995.jpnprd01.prod.outlook.com (20.179.179.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Wed, 19 Feb 2020 19:18:24 +0000
Received: from OSAPR01MB5028.jpnprd01.prod.outlook.com
 ([fe80::50c1:d043:233d:2092]) by OSAPR01MB5028.jpnprd01.prod.outlook.com
 ([fe80::50c1:d043:233d:2092%7]) with mapi id 15.20.2729.033; Wed, 19 Feb 2020
 19:18:24 +0000
From: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Thread-Topic: [cip-dev] [PATCH 4.19.y-cip 21/23] arm64: defconfig: enable
 TYPEC_HD3SS3220 config option
Thread-Index: AQHV5v1DhAI/zKNlBk+e3dtenbME2Kgi5IVA
Date: Wed, 19 Feb 2020 19:18:24 +0000
Message-ID: <OSAPR01MB502839526F3E8BA135DD7C20AE100@OSAPR01MB5028.jpnprd01.prod.outlook.com>
References: <1582034720-5249-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
 <1582034720-5249-22-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
 <20200219081903.GF31996@amd>
In-Reply-To: <20200219081903.GF31996@amd>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marian-cristian.rotariu.rb@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 310c3c7a-364b-4465-27f9-08d7b5707ddc
x-ms-traffictypediagnostic: OSAPR01MB4995:
x-microsoft-antispam-prvs: <OSAPR01MB499577027F8B8E5314E066ABAE100@OSAPR01MB4995.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1148;
x-forefront-prvs: 0318501FAE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(376002)(366004)(39850400004)(346002)(396003)(136003)(199004)(189003)(64756008)(66556008)(7696005)(66476007)(66446008)(478600001)(2906002)(81166006)(66946007)(8676002)(76116006)(6916009)(81156014)(8936002)(4326008)(33656002)(52536014)(86362001)(186003)(26005)(4744005)(9686003)(53546011)(6506007)(71200400001)(5660300002)(55016002)(316002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:OSAPR01MB4995;
 H:OSAPR01MB5028.jpnprd01.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:0; MX:1; 
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NingRjRPWcRqb+rYuXtercDzYurObntEdY7AALwH2UOYXQrkSZOdsqu2pqTFsZ10q0bCnCWAKIU1Sho0KK8yQryIwYKfjlyhdgr6/nRijdelg64NRY9qveqrDoi2T9+8rcJdrv4bz75tnJk3QjOP2eZT1mc3odwkQqkrIr1cGxkhiIyCXEr2GFjztbRxOmfpV1j7no3UcnD/lw7mdrXRAOhEu+3ZzVjbSg5cvnchfKsUSJBnYbVnvBZ//XRHVlewP9R6KLoqgjBJH+zavcO8TiGsEUyXThtU/wl8lfHxUPx0SePuImrCwf3GcNgLMwiDWRS0O7O3dkp99NY0BTBOiC+gI4lFqovhFFCjowsYd9cDpH5VdYMc7UrWhe21SE5wdJRzCF8gy2kW8ZaHj9pIvRueZ2CQlJG5HtY5POn+LksEmMydfxbT6r3B5AOwYxlI
x-ms-exchange-antispam-messagedata: Yiz5c77r9iHSDSs6rZ7n9e3qVRGEM37pGtMwt5+8JeqT3agyDNHO4KVRAIOOjtpfaQb7EY8Rbe2MVY7Re8xXpAP1MSlq5RRtzY3lyOFhvcdU7zQPxS5lGFAdANcZFx8dgvVDLwkCiCr2prezjYjw6w==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 310c3c7a-364b-4465-27f9-08d7b5707ddc
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2020 19:18:24.7300 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W1/3k/xMCHAoLlZ2UJvKDn1AQGzy31FANHNNxY5VAh7vnv0Nm92hvVidtBI60ol/xapDicDdt/J1z4L4UTYLjPGdSDle6hVvtR44Zsc4eWcyaDfTOr3jHaY/IrNrIOT3kiOT7zdP6XbGsiDrCFQZkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB4995
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: [PATCH 4.19.y-cip 21/23] arm64: defconfig: enable TYPEC_HD3SS3220 config option
X-BeenThere: cip-dev@lists.cip-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: <cip-dev.lists.cip-project.org>
List-Unsubscribe: <https://lists.cip-project.org/mailman/options/cip-dev>,
 <mailto:cip-dev-request@lists.cip-project.org?subject=unsubscribe>
List-Archive: <http://lists.cip-project.org/pipermail/cip-dev/>
List-Post: <mailto:cip-dev@lists.cip-project.org>
List-Help: <mailto:cip-dev-request@lists.cip-project.org?subject=help>
List-Subscribe: <https://lists.cip-project.org/mailman/listinfo/cip-dev>,
 <mailto:cip-dev-request@lists.cip-project.org?subject=subscribe>
X-List-Received-Date: Wed, 19 Feb 2020 19:18:28 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: 19 February 2020 08:19
> To: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org
> Subject: Re: [cip-dev] [PATCH 4.19.y-cip 21/23] arm64: defconfig: enable
> TYPEC_HD3SS3220 config option
>=20
> On Tue 2020-02-18 14:05:18, Marian-Cristian Rotariu wrote:
> > From: Biju Das <biju.das@bp.renesas.com>
> >
> > commit c24f6886b2ee321b50543d3683573689a1817336 upstream
> >
> > Enable support for the TI HD3SS320 USB Type-C DRP Port controller
> > driver by turning on CONFIG_TYPEC and CONFIG_TYPEC_HD3SS3220 as
> modules.
>=20
> No, just no.
>=20
> Lets enable new code for your boards (cip-kernel-config repository), but
> keep it disabled for other people. We don't want to break build by mistak=
e,
> or something like that.

Ok, I will drop this for v2.

Thanks,
Marian



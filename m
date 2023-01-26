Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D4FC54E94
	for <webhook@archiver.kernel.org>; Thu, 26 Jan 2023 10:16:02 +0000 (UTC)
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (APC01-TYZ-obe.outbound.protection.outlook.com [40.107.117.103])
 by mx.groups.io with SMTP id smtpd.web10.70461.1674728152533656351
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Jan 2023 02:15:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=dioqqz8M;
 spf=pass (domain: renesas.com, ip: 40.107.117.103, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mWd49RibUtVQP6tuekFH5sC1Q/KzFzsJEJ6FqbxicsFWa8MSoU8l0I8AYN6o8+4hn3ZbetOJmWhUOsInJ7em5RnsQLcChNq9zTxDzJmltLI6UbVE7PmLmI3kN7oUBXDTDZanAoyIENFg7qzuWkE8E/p+1j9a5LkX8dnufPNhqpi/ju42kNG5/oB7I9HWsQXvNLomDtDIpq73TOqZjTg/SEacS4nMjZ1gxaTBpaUm3/2TSz6TlnBQHOm0VYkldXFlabza8a6AcDe5LaycyuxJuNrOHHcr6UsPgHeGScqTX8B8/nnVqUz9DoAf5zWB6f3eJT2R00B9wk3duScj51OKvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Azoha0TDa3mahupLVmx1jDJuBK/ikngCfeH1yLUCO4=;
 b=EpxtAOamm3vcxj1bEsPqHU/B2L++ZOJlBUPCwN3L86eny0fulNNquf8P3+TwK3F8HLnjsO8BQmPuAAdlxns/zYsSHtHDr8bfdQXUpOqVmrxG1erEb3ZkJGh2a21Pq4sWHb/7XDIgOLHyWvSVUl1raK0T+yKRhL9Emft03Il9B3CJEiFkpmOgZZsAqV23soUNQKUvMSx8Z9XZPl2WJ8O/o6ZahmoYKtbAQ7bm7IH9BoAJlTobq6/EF+uV1TdtJd67chGdTA+Iw1bn0rMFaG3UUOQKSWkHN8U2Aj1bovHWCug+103B4MGGOD5sB6uxvZfCiXfoQIU+KW26JeH8enhSWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Azoha0TDa3mahupLVmx1jDJuBK/ikngCfeH1yLUCO4=;
 b=dioqqz8MRpce6siWZ3NI6u8rn+7Uwg1auxjnSaG1W+Xn9ait/RfbeFFg3KiYoWQFdWGiPrzRajZU3jrux2d8rGYVHZaAmxbBqXMagPQ1DVZnFU4W6l2/gapcA7l2Y2XNxoSQRqrVQ1cXV7h5mCFc0hgjQHeIAYl7ecZLTGtHoao=
Received: from TYCPR01MB10588.jpnprd01.prod.outlook.com (2603:1096:400:309::8)
 by TYAPR01MB5386.jpnprd01.prod.outlook.com (2603:1096:404:803f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Thu, 26 Jan
 2023 10:15:48 +0000
Received: from TYCPR01MB10588.jpnprd01.prod.outlook.com
 ([fe80::943b:564b:b02d:f78b]) by TYCPR01MB10588.jpnprd01.prod.outlook.com
 ([fe80::943b:564b:b02d:f78b%3]) with mapi id 15.20.6043.021; Thu, 26 Jan 2023
 10:15:48 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] CIP IRC weekly meeting today 13h UTC on libera.chat
Thread-Topic: [cip-dev] CIP IRC weekly meeting today 13h UTC on libera.chat
Thread-Index: AQHZMW5yHDgZDjCw7ECXvJFpAGzSsq6wewAg
Date: Thu, 26 Jan 2023 10:15:48 +0000
Message-ID: 
 <TYCPR01MB10588E006C0EBE118B6BB6F0AB7CF9@TYCPR01MB10588.jpnprd01.prod.outlook.com>
References: <Y9JRl6Buzw+bTrw4@duo.ucw.cz>
In-Reply-To: <Y9JRl6Buzw+bTrw4@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB10588:EE_|TYAPR01MB5386:EE_
x-ms-office365-filtering-correlation-id: 44cfb9d5-396f-466e-e33b-08daff864bd0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 IU2HdtVgESSgTUs0Zt1YTem9ip1yg8+Ob4hiJ+0hKTNXlj7jlkgC6ETUJvWTXG1m4wrg5PLrAz3JhT6GdE2KFSqKdotCKyTvNIfYPHeoc0iaz30zJrTc2EMLhYBfi07nnbrbhSb0HlbS75wrqW3CCJUiDLzdvzJjdaPpkema3VpNvxEbfur0AXEtXCRfz1EmzQb81UR+dtZn6hJrAeg5pALqJx3xg06fttLOOkpImbhzpS+9vUcRxefx8vPDcZhGNwx8mtQDMsUb+MDDMhbjxsBRFm1JbZDCfch4Da5WnIzLOcBLgkfs2u5Jv1CqHCj2mkXAttuIZ+qzX9nMcViyH2ZukKl2A7joZUDNSDMDsXoEDQ+oaaP4hd2/St34K9g0Y2VLX5/tUUpgF8xLLpmWkmRQK4i5uVO3HRoJaMk8axfsBqZn2CN5/eW2snbU89+M/zsMU7TZ3D28SlL9o0n1EdYXh30O/aSbaj7jADcfKmNODygfJ5/m55kCsFW+FHuoIap3R9Oe3p400nkMRjt+tUyVTxEXSY/0qmBqSTZWk1Ze9/8KavdIJd0YL+CbLEGKbP8vZRddq/voLw+hxm0El0rfLyl/Qpr/EZFxY9K3/LvjLeEY17M5OqpKMI2mzclcncou/Ba4tLnoJVzz631c7+fB8izEPe+9Bzq5LsVdlue60vZOMqjpyQlFoCgPT3kpfkTLfyba+aGHGod041svMA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10588.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(136003)(346002)(396003)(376002)(451199018)(2906002)(45080400002)(7696005)(478600001)(71200400001)(966005)(26005)(6506007)(5660300002)(9686003)(316002)(186003)(83380400001)(8936002)(122000001)(52536014)(38100700002)(66946007)(76116006)(38070700005)(86362001)(55016003)(33656002)(41300700001)(64756008)(66476007)(8676002)(66446008)(66556008)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?k0bS42dAHmlGKTXndhemH9z90F0wgq2rZMfeKjlv9612o2+P9yKmD8/C?=
 =?Windows-1252?Q?7M1CqhTSSThQb5RMuRDlSBK0Ya4oXT2xWV/gfkKk7eUNv0AdGQB0axOt?=
 =?Windows-1252?Q?R8/pV7dO+GLlakfARdvFD2C/1qeY9i5EJK57Q2hgO8sdutN+OjmMocbK?=
 =?Windows-1252?Q?+V7dkiINbpKmwVfOHpXgMAamkvXmM3ifO89SiRE2fErPB7dQxwVgIatj?=
 =?Windows-1252?Q?PAEMFpAWfn5I22hB6H50h70w5WiWGGcHV4ZNpwQ8qrav+DgWbezkjLhe?=
 =?Windows-1252?Q?dyA1G04CXA+nDMEAvBnzfoZxpAyHhp/dmmSA/bDCCyDxtWProFt9nBhG?=
 =?Windows-1252?Q?UAxNtI4Red24Ce4gnfJgSR/OsFEE3pXMBinj8E/x4QbiyErzrb1TmmXY?=
 =?Windows-1252?Q?x0ofqIlxZkfFzInLZAqiYpAb3fizJV9MDSNhDlleCh9POOsxCqoRCLMW?=
 =?Windows-1252?Q?HF0Ch5YxtwUGsWcmyvfygGgqRCs243rYmnvGkzzI3JRRgjS0vJ5jSKOc?=
 =?Windows-1252?Q?mFQrLMoGvXgIzYdbwRQgRszvu37GPKlHjEY4UmdO1bbBhfCi0dP/rTKE?=
 =?Windows-1252?Q?wSEi/bZlk2exAyo7FZGYFpOvNrDSB+tbUOD4tU2yq6GSEYWgFYigTd09?=
 =?Windows-1252?Q?BQU0P1JWfeedEQ5kSAlRfrIpeznnyOILbVSdZNkLHVhoazlMmv2VQ+WN?=
 =?Windows-1252?Q?adjk6SJhmspnnrbE+W5TkdiCHJOWG6Px1zV0mgoP3+3cCYnRAokEhg4I?=
 =?Windows-1252?Q?ppbGaepW/YjifGNPkWsWf8+xUo2RAwhEFoZ2bJElcV6EbgUVbJS8QUGK?=
 =?Windows-1252?Q?9zrpbszUYtahA/ogMqIHlBz7CPVR4uIIdMmti9qrBxK5TiDFNOiwMMnm?=
 =?Windows-1252?Q?VC4uzvTTHFE7bHNKRIQ92cG40u1r+Mby2BZHB308voBASAD6PQjnZAN6?=
 =?Windows-1252?Q?/IN5Qnd5uNuXyAA6fgw8VFvToMhQwhqTVJL6CZagcmIghl2DhGBt8bZB?=
 =?Windows-1252?Q?OL3Ufbfi1Wr3/+vxtNVARLpEW2P31itEvZ/8x57UauW+786uvnScOLX9?=
 =?Windows-1252?Q?E8f7UZU/HokAuDFqQjbO0PWjx1C7tS995WvGcIpd39uQrFT4wflXFx/u?=
 =?Windows-1252?Q?ncb+Qn320uvHWOzO7R3o7R87+dRCxt/PXdrQzRlotSPuMt8WJrOsM375?=
 =?Windows-1252?Q?R53REmUqyS7+QOV35FpeDZYn/tEENjDm9bBe4AZvZNt+DMZFwanqJKcH?=
 =?Windows-1252?Q?M6I9Fj1RZzXtR5t/AyNAwqZq7Ns5HOpdKiZCTsQlWnfOPh6RkvAlno17?=
 =?Windows-1252?Q?Rck7EpwaXXkXjkj1dQdOwHrDi1F+/O18hcdIDA8sexdI2+M5ip7/3LEZ?=
 =?Windows-1252?Q?1xtCXYF7XoBdjiBVRlN3gqpQqd1TqFrTMbAejF1/JOZ6moyBBSay86D4?=
 =?Windows-1252?Q?m/7gOVe7ZEDhUupXTjuxQxYJcqmth8p1JHQ7cIMR6H8Jx5rRjUq5St/K?=
 =?Windows-1252?Q?PtoDL0tnMUM8Xgn04Gyj/HDq8DILTJ/s3/BXJv1U1EgAgeuLs8gIQLse?=
 =?Windows-1252?Q?R9Q8I8ExLBUGWyJKgcQOhVLyzG2kXlM8hWy5hx21Tjqxp8Zz24QRnpvf?=
 =?Windows-1252?Q?cXp1QmmsiLgEB2UGIj0QJ9UBfnAcrd4nOoGYiF/PQV6ZBlER+eDDFKxg?=
 =?Windows-1252?Q?b+DPco2WvNPgRY5+MzdCiSvtYZ4gJLNiLwaSu5JUJ1YufRQAwuTNUw?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44cfb9d5-396f-466e-e33b-08daff864bd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2023 10:15:48.8871
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2JS27vuz5MTkJF7n7C6PG3f8ro4xsbTA4bcySdj/eJIG8Uln0qPyPlYgQMyqi5/grHcMcbRYju/Bj23r/rsjRxzhuxZ+iz1h0Cvu7RId9Fk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5386
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 26 Jan 2023 10:16:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10482

Hello,

> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Pavel Machek via lists.cip-project.org
> Sent: 26 January 2023 10:11
>=20
> Hi!
>=20
> Kindly be reminded to attend the weekly meeting through IRC to discuss
> technical topics with CIP kernel today. Our channel is the following:
>=20
>     irc:irc.libera.chat:6667/cip
>=20
> The IRC meeting is scheduled to UTC (GMT) 13:00:

I'm sorry but I cannot make it today.

>=20
> USWest    USEast    UK        DE        TW        JP
> 06:00     09:00     13:00     14:00     21:00     22:00
>=20
> Recent meeting minutes:
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fircbo=
t
> .wl.linuxfoundation.org%2Fmeetings%2Fcip%2F2023%2F01%2F&data=3D05%7C
> 01%7Cchris.paterson2%40renesas.com%7C564b456fc0c1459c439c08daff8593
> 81%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C638103246413725
> 811%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2lu
> MzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DMGoC
> KCgn7Wf%2B57HbO82Fe4P5asO8XpFOE2lWGvCfXD8%3D&reserved=3D0
>=20
> * Action items
> * Kernel maintenance updates
> * Kernel release status
>   - 4.4
>   - 4.19
>   - 5.10
> * Kernel testing

Nothing exciting to report from me.
I haven't had a chance to look into the additional stable/RT testing suppor=
t we agreed last week yet.

Kind regards, Chris

> * AOB
>=20
> Best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany


Return-Path: <sven.schultschik@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 884C6C4332F
	for <webhook@archiver.kernel.org>; Thu, 20 Oct 2022 16:24:47 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.80])
 by mx.groups.io with SMTP id smtpd.web12.11778.1666283081741928964
 for <cip-dev@lists.cip-project.org>;
 Thu, 20 Oct 2022 09:24:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Fb5J7zCV;
 spf=pass (domain: siemens.com, ip: 40.107.8.80, mailfrom: sven.schultschik@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=akq2Q57EpjEZ6dzVvUdV/7tWCfby3SmPNw3FfThYK89elcDpEsmxnC9R8grb5TY36Q7RYO4102xyr6AB0Xp6TXAFzQQnJZlhNxcZkm8fTqcrTkfDgYMI7W/uEqLHDB4qqkkpPBTMfV5HlOqfz9VAOTQlGfPpUCAQNwUAsyhBMLmKfNSybW38ewwzUXDfilsWitGm/iSCuYPX9aLaZKXtNur7Tac/kV9hXteUSzOEpldY75IpD9p29IYgEQTQ3SmHg/3yEvWJXaa3tLbL8rD78y3a+ULJN1B8UBcrAsDdAPaFt0sN3i2UUm2i/0gc/+DplXuRsumleaKW6kmNOVoFnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CqFZICrfmsIdDRXA42uiA7sq9AFGY/HZePgRKRKJMpU=;
 b=iFTrGQRX8h921jiyKbWGWKGFbjMw6X2kIAbtl+uHOU0zQUWNhG2ueQNSo1PuSl4cMeXp9tLy8vtdg/13OZH4RByoSHBZlLbcypkzQ2zhA1J1S/0QZGjn2wznZuJ4KXdf+cIuGd9An8tom8ovJprqt5RsHRYT+AO+YEmtUBitF7Rh2SuSAI1+VSIdo8AgjVXbTLDrDQ1VG05UnG9SirEjcbFv556n4K2EVK+KFIntKa08/QSq/CeurPidtA3tjXbYHmwL+6UKqzozPT2AYgAB1Kj3SesahwLFtrlXsAVwRKNGs/GHiq0GEtSJHyDFDIvKjhqjaQWJaZymfjnmN3RZDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CqFZICrfmsIdDRXA42uiA7sq9AFGY/HZePgRKRKJMpU=;
 b=Fb5J7zCVmw6A3cZNjNOlUlXMA/A9mBWV2+4o9ns09uoAFm/AReYKakNW+MFAy6uH3V2SkmUCxTyMRdpq3NNOafKod3KYi07oaA8cfU1CzUH+XqGc1drzG4tf9pHBxfiWLEnN2a+IoSdnd/jT7lDD8nwdgs8iEj7X6Mul/pJtcJOORIO8NiDOyl4T1QCWjbbIG0VvUXOfXF2yyApeH5tooq1rFEgmoDBbZeMzGpkHgtE3SAhOHMk6BhZC+sid/IV7X4t6jjOs3CzgHPKN185Spgy6lt5JpCcSsuIut5xPA52a/Rc0HTE5nysPiIHsuQSt00HkojP15H19nHZsEvgK5Q==
Received: from PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:210::11)
 by AS4PR10MB5151.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4c2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Thu, 20 Oct
 2022 16:24:38 +0000
Received: from PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8f3:9a82:c9ed:6a3f]) by PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8f3:9a82:c9ed:6a3f%8]) with mapi id 15.20.5723.035; Thu, 20 Oct 2022
 16:24:38 +0000
From: "Schultschik, Sven" <sven.schultschik@siemens.com>
To: "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: AW: [isar-cip-core][PATCH 2/7] add recipe for for edk2
Thread-Topic: [isar-cip-core][PATCH 2/7] add recipe for for edk2
Thread-Index: AQHY45xPWaXKEQmUR0Ob3Ay49K84eK4Vi/qAgAHqyPA=
Date: Thu, 20 Oct 2022 16:24:38 +0000
Message-ID: 
 <PAXPR10MB50373CBB18305FA0DB7AF6B4902A9@PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM>
References: <20221019092117.5291-1-sven.schultschik@siemens.com>
 <20221019092117.5291-2-sven.schultschik@siemens.com>
 <760608c4-0d6c-43f2-00c8-bc93de8cdeb4@siemens.com>
In-Reply-To: <760608c4-0d6c-43f2-00c8-bc93de8cdeb4@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2022-10-20T16:24:36Z;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=cec8487d-f069-42bf-a834-759a437d7089;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0
document_confidentiality: Restricted
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR10MB5037:EE_|AS4PR10MB5151:EE_
x-ms-office365-filtering-correlation-id: 066414c2-df06-407b-cc95-08dab2b795c7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 5i3N1Dnce71l9f1yAFIe53/H9Rn/D0v5iMphhi1yFLfN4VkoHlHY0/YJwbMDQDJLVUHKtu7H9IpNArW1vRqw63nJz0wsionJg8TyVsZsPgsW0YSL9QbrVMfstwW7cwQKmfR/dPEQbKQqvChjHyXMp5BKOv6ymKTL9HG523osgJlFV4SgKvkUkGCrAlq46BAN0QuQpNwyUxwn0RScs/lNXYvY6Z6Em73KncadwHnOEeLUZLZwAXpvMr6Ma5FtnAsDmttHp+PsTXvcW9Eur7WTIHzbxDoB+wxRGgObG1lqNogMhYTbrsAysyWkypzgLhTdDZQhYPfnAn9MqLWIvqfY2ls6Oid68mlad/pPbLBZ+8XF/9V3Du6F5MuK8Hfk8SXuLTPwj/YFLZrm/glLawFmSI9oX/l2xI5BlVg8c7LINGzcbAaWD5DW07WNK80hzMk/KlVicyxnM24Jk6e+d7vc1LzooYqW+2nTVyFCsiou7m29e5RwSdmN6tSgefqMcB5LJKlao8UCq9LZKCNGdGHgTFoPADpXLKz9stbAKBg5Sso6kN8hDGEJKEtAObENv5giPOh926j2D1lHuPFV96T+XSHdu28CHGp5XAMMA8aM0ysQxS52S4ZHlUi8LTpjxS88/oT+cMIvEe2ejPqSgLs3QOJ1K1nClrZjGSbmLatTG7A0WrRGAesTUwJXq1Modcu6xDPkOQTgli3yu0NV6jxU6zGgU4NWliDpQjtUsKi/CB94T2Nmex1u/AP8HwncplHxSZ2gbHjYhliEosaK0/V+tA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(346002)(136003)(376002)(396003)(451199015)(52536014)(76116006)(110136005)(8676002)(64756008)(66556008)(86362001)(66446008)(66946007)(66476007)(9686003)(41300700001)(26005)(316002)(6506007)(7696005)(5660300002)(8936002)(55016003)(53546011)(122000001)(38100700002)(82960400001)(33656002)(71200400001)(186003)(2906002)(478600001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?MV/y5Z1rQJDEyo+FVN0xW+XpOaFPlvh8VPk3J7JkMMlqyOiDD2Q36YuYrT?=
 =?iso-8859-1?Q?j2dcc7pglFDn1uaVLzvvavpMV8tqa9ZzzPpCBSEc90lmeOhe3NTswXJ/Yj?=
 =?iso-8859-1?Q?hSpPa8GegV/3/rhkw8QDymAPW3tt/r0JTCx1+UmX9NJAssK+ph6XZaE3KW?=
 =?iso-8859-1?Q?jO8YMUgTSH4EpCet1L9BtygdcYOVEf31pg6vTJOJdk7s6VE8KxSwhEvFEJ?=
 =?iso-8859-1?Q?EEoxBW4/CBIz/EjqElWtIC7Ou8YJgMD19JswztGOnj8DmTgQ9ljqzv/kpb?=
 =?iso-8859-1?Q?cpZKNi8NE2mDGIYnUXZcg7ahjX7DIN1nKvDKVlMxASdR+JiZWP9a+kV/za?=
 =?iso-8859-1?Q?6EXCthl1sMytkkzwq6PnfZ+9sitcYns8mPNDpny1p9V3W4aq84/gGuX2r6?=
 =?iso-8859-1?Q?Reh649i+7JIbrgf2ONJ+tDl+jWJP19IPf6lTnJyoLzZ51f/C/I1SGvHaqZ?=
 =?iso-8859-1?Q?0PQuSxe+1naRjnic2LdyggrVCJWVqZ9tL7ZVq1H16hp+OkQ4ZPhHyze0rO?=
 =?iso-8859-1?Q?DhqXHd0dAncuYjmrLDmb6nNtB1cLulmH0OkMlHw8VSixkPfWhNjfp0XHJr?=
 =?iso-8859-1?Q?9SGcydEG8KqMScn6ySxR5Ew+ybaFBP1d0N8OVHwrrCvP7ulI8J3idjbuTc?=
 =?iso-8859-1?Q?Q1gqO/A009Rj0vUw2iz5A2UpVhHWQU3Fb2b6Ry1XZ0rtodJX5wRhyXAf33?=
 =?iso-8859-1?Q?ziWzksuQ9TCPCd/8YXmVj0dN4axkEO8yJarkwfThVjXgnegyGvbc/CZGh9?=
 =?iso-8859-1?Q?fpbny054AP4N7ztxdn/wNiWbx6LU0VVxMmM4Z/anX02D2K9lGWk4JwqCm6?=
 =?iso-8859-1?Q?IMzSf9/KyCD259UWzHvv756WiMtKIB9/aEQ5bSYuWaWS5evZ+KJlT7xz/E?=
 =?iso-8859-1?Q?FP4J0SSaLmfyM5B+k+2/TUtzjVAgqHmunxI2xUDkE8eZTaTfZtKEv4tIPY?=
 =?iso-8859-1?Q?qYfBnGf831NWJgZFDLMbEXDU8xZvBeoXYj5U+EN1Zq0BerqtiJnxM+sT2j?=
 =?iso-8859-1?Q?qLZdCC20wqXHxJh7RQVa+DVpxp0VPlB2OjDj2zL4bcB1mfbUdT0J/9hEqe?=
 =?iso-8859-1?Q?bWcKKgzs79f/x7uHCDhPuB2TAePVXSjkOuVKDnlOdaJsjclXITFVD3ioSi?=
 =?iso-8859-1?Q?Vn8LgiXzH2aMA5jV1icbuYL4E5qbdaylls5eMWsqcUO4F4Y0y2nYYPpkPF?=
 =?iso-8859-1?Q?QTvobhI02hQjfBo9PiJvkno85JCbQVl7F/8av835BLEiOT8/tywNdNyNa4?=
 =?iso-8859-1?Q?hxvQyCwV9OZSZvNE9Dk+PZWjR2tnuB/K9OMnPWMaWAdSaMuHM/KKssYwtB?=
 =?iso-8859-1?Q?paS5dBQPHy+980fHRyVr5JnqNxO8hHesNGjJ4H6GjsN6sSlKCX14t+OKDn?=
 =?iso-8859-1?Q?GS7eEiFdK7jbD3+BICLWhGsurNuYox7WFjW3XoQG+gpS+1oxpL7M7K2HNB?=
 =?iso-8859-1?Q?BKAf01eiNYzJ1L14ARREERz8E5eAaGl+7rnZhEZVZIo0sr2PIIKOAlnvjU?=
 =?iso-8859-1?Q?bA5YZfYl+2nBIG3CfNGP0R0bYCYwbHBLnlb7xEGkbu8u8XPCU9fcmyDCq5?=
 =?iso-8859-1?Q?0gNRSD+OsT4qyyj39xXAWQHhFB7ITf/j2dmKP0w4QW7lctqpIQxBw16/Jr?=
 =?iso-8859-1?Q?QJVfOY81EwoII1qGzXxHZ3x0otv8MRRigC7r4AkAbr2Y80fXOjvdbHKw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 066414c2-df06-407b-cc95-08dab2b795c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2022 16:24:38.7380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pAk6kHShvtx1F4DlGGLG4jKs8WX0pCm1jC6xIJZENmqfd2RsexCR+rX3zg3gUoRVk4nuSQ0TxbirbA5t4KRt9VGna82DpOANq692/vGukZU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5151
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Oct 2022 16:24:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9798



> -----Urspr=FCngliche Nachricht-----
> Von: Kiszka, Jan (T CED) <jan.kiszka@siemens.com>
> Gesendet: Mittwoch, 19. Oktober 2022 12:58
> An: Schultschik, Sven (DI PA DCP R&D 2) <sven.schultschik@siemens.com>; c=
ip-
> dev@lists.cip-project.org
> Betreff: Re: [isar-cip-core][PATCH 2/7] add recipe for for edk2
>
> On 19.10.22 11:21, sven.schultschik@siemens.com wrote:
> > From: Sven Schultschik <sven.schultschik@siemens.com>
> >
> > +MAINTAINER =3D "Sven Schultschik <sven.schultschik@siemens.com>"
> > +LICENSE =3D "BSD-2-Clause-Patent"
> > +
> > +inherit dpkg
> > +
> > +SRC_URI =3D
> "gitsm://github.com/tianocore/edk2.git;branch=3Dmaster;protocol=3Dhttps;d=
estsuff
> ix=3Dgit/edk2;rev=3Dedk2-stable${PV} \
> > +
> > +git://github.com/tianocore/edk2-platforms.git;protocol=3Dhttps;destsuf=
f
> > +ix=3Dgit/edk2-platforms;rev=3D3b896d1a325686de3942723c42f286090453e37a=
 \
>
> - gitsm (see patch 1/7)
> - please factor out revisions into separate variables
>
> Or can we also address the revisions via release tags? The recipe carries=
 a
> release version number in the end...

I checked and edk2-platforms does not have any tags. In theory you could us=
e always the latest. But then you can't reproduce the builds.
The version of the recipe is the tag for the edk2 repository, which is alre=
ady in use




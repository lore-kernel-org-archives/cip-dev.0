Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A168C47258
	for <webhook@archiver.kernel.org>; Fri,  2 Feb 2024 08:52:47 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.113])
 by mx.groups.io with SMTP id smtpd.web10.18903.1706863966309711833
 for <cip-dev@lists.cip-project.org>;
 Fri, 02 Feb 2024 00:52:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=JIQ0cxUU;
 spf=pass (domain: renesas.com, ip: 40.107.113.113, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N2vNUAf/DJW4FAI7wl/Kphu55iq5JLQ+OHGbrxv8/wY+A0BD6D/2SEASdcLnS2Ts7OuXlbdw0G1Z+r7kJYGuGCoBYD6zSboTkph62wWMcfu/2DokOZU5NYmKMKxd0bajo7FeRqi0r+27X6hY7EBQtZv4a4NanBbfc5TYP3ofAZZVVzNv1SbvB7e7lkshJz0Td10gF4A5DJV1JDgZi7eo0CXu6TiDd82qcZ3aDt8O7LgECWn2AQ/oWsFBL9nbG3/teLv5bHyg3HKa+WDotHMibWnP5vJGPFHkj/ZSWQ5i4nrXnz7e+PiCH0PUJrlWQkjg6ZuBxcYtTP05xwfTPPkC+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+eT/h6NUNQoSwjTWwtGyUxOlf9cEKapMV5HU149BkE0=;
 b=KqEIWCdVWzWab6MRGwhrXdCJ5HxMdyN9OY7cBJl2CQ2oFDAc2jTAkKgzmhDCnlrM6J6ObVNBaIx1CkAhGPrgHnNabxroMeT0XfioyXU/Nz1z9TYJM2cnkM7Af/hbIyeTKkEeTHhrWfY7bIW+F6m61wD/HKWQeL+1BZ22/5SuQ59lSkKdkvWavDt6FrTALClLWBRvCsBE0tVRGXSIgloK99vTGIpLMjBE3a0OKPaTCdcvpkgH/2uvsbUp48MWo+ndem/bFkisvQ0HD+x174Xmqizk0kGjhO/kZzXRsq+j8NlSuapj2K8mTGueQthRu3KmPTSsP3O5yPYIw/u2C/s2Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+eT/h6NUNQoSwjTWwtGyUxOlf9cEKapMV5HU149BkE0=;
 b=JIQ0cxUUki7wjXyQgQnJUonGHNarpr4V47TSzNRTxozmOyJY5EnkFi7uWsw6kNwsGeIMIeTT45CngQ5vwZ0jdtXo+L2RQ73IraMPImKAnJcPCEvXkEfLJRzBSprUrTgvFXYpMZu7lpEUCd9+HQ/92AnQBvcFdRdXMILJ8lQ++gQ=
Received: from TYWPR01MB11862.jpnprd01.prod.outlook.com (2603:1096:400:3fc::6)
 by OS7PR01MB11795.jpnprd01.prod.outlook.com (2603:1096:604:23d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Fri, 2 Feb
 2024 08:52:41 +0000
Received: from TYWPR01MB11862.jpnprd01.prod.outlook.com
 ([fe80::d543:aeea:6f7b:2a47]) by TYWPR01MB11862.jpnprd01.prod.outlook.com
 ([fe80::d543:aeea:6f7b:2a47%5]) with mapi id 15.20.7249.023; Fri, 2 Feb 2024
 08:52:41 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: Ulrich Hecht <uli@fpond.eu>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>, "pavel@denx.de" <pavel@denx.de>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: RE: [ANNOUNCE] Release v4.4.302-cip84
Thread-Topic: [ANNOUNCE] Release v4.4.302-cip84
Thread-Index: AQHaVZKraPjdXWvjkEuksbPoSIYIUrD2vDag
Date: Fri, 2 Feb 2024 08:52:40 +0000
Message-ID: 
 <TYWPR01MB11862381EB026AD8B1E8B4E66B7422@TYWPR01MB11862.jpnprd01.prod.outlook.com>
References: <1043550080.65973.1706849125840@webmail.strato.com>
In-Reply-To: <1043550080.65973.1706849125840@webmail.strato.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB11862:EE_|OS7PR01MB11795:EE_
x-ms-office365-filtering-correlation-id: 4579bec0-5f9b-4b25-bb95-08dc23cc507b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 EMXyo1MFOWw3SDO3eA6dquEFRr+8myfdUDY+/CaRr7RaIMhoNEgA19ZqKoIaaK2j31KRCV6DC1iAD4qU0ZV2p2hbIuUDOh2U3Bl5KH9gATiuedl6W60gVEA5Sauq7LDrg3JcISpjIMADI4O3tlqaciSLLThgElxj0dHnxedfGldAPypiGPmFK+0+KNGdiTVThgRItJuR3cBoi0yxVZ8szpvh9IBCA7i3QwPqApgPQkAZxIPCrkgKUEV+iqsVHhPec+Gy+o4703eS5Ty5/fBtFet9KyPKFrLSQMj9IxPqqtx2chvtm34WhElVcVuPHP8sLzZpgIeFHtDE4DKyS1bfqWpoWgx5yoQA3pGzPYs0hRVxdwrFvLJDXuHzmX1D/uF9Rvk7ThQBD30V8ITEhE9PM9ArFXjnaWXprX1HBXtA4X1uIGJ861BStEYpXoa2ulT+zuaE+/DvV5ZCkpTfJPNxz1iEf3HVdKwVi4YXlytFfPP9NI4DQ9YUC8tsA2bVbXJFOPNA/VFkfEx5EBHW8kmGTJVj5Kjim0kgTFjkPhR9tt5C+yGO3pNPrWBZk41zpjmtwXs8/OW22s4K3G185gKsWC76DSYum3vOPVeagIqKl4s=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB11862.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(376002)(396003)(136003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(41300700001)(26005)(55016003)(966005)(6506007)(478600001)(38070700009)(122000001)(38100700002)(7696005)(83380400001)(71200400001)(9686003)(316002)(66476007)(52536014)(66446008)(110136005)(2906002)(33656002)(66556008)(76116006)(66946007)(8936002)(64756008)(8676002)(86362001)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?3R5mH/Ass9/Ob76u7I+7jaCJgbQTTFJ9DHUQKf95m8oN1P7JGLip0MvM?=
 =?Windows-1252?Q?fcfWovDVN8JQ2c/cxIVzdypOEt5YmaxiuuciuN/TfMCMtN4i91PHQFZB?=
 =?Windows-1252?Q?MsexGsa7D9CO3E3jT4T61JDH8AreJ3v0mOpvoe1qEwJn0Knd7VaMFDP5?=
 =?Windows-1252?Q?/ajd2r+FQe3Ry4w0wKJ+rqEQlTrGym1rKR6Idfz8IJAZXz8MJhpGkcbr?=
 =?Windows-1252?Q?+iQ8yxbJDFKXWkLj3ez6VestNbOhLHNPFi0vLdzLfNaJFBAIXzq7UERL?=
 =?Windows-1252?Q?lGq+0WaVXV73XWBQZV7OxmjyeEnr17lRLHct4mdCSK7A4S0T6Ii1Waep?=
 =?Windows-1252?Q?37flfWKS22fRwGf5aYJtuXEM98hTaPJ3OCs08kMWtSto8Fri79UFdk1D?=
 =?Windows-1252?Q?kJFD8TIMVPZXaL/QL/vDMLtU1+EE3MPHDyAzKqazKti5Ho/jqymaM/tR?=
 =?Windows-1252?Q?ABRh54oGwejKHeYwG9AgbpU5YEFmy+TuDDTVD13CV0hupzaqe+t8f/kT?=
 =?Windows-1252?Q?7mSO8CQXnpCFF5CIIQlrq6JxsrkcK73VnyGUrqSJGZgz9fM6iWLDu91z?=
 =?Windows-1252?Q?T0bJvO6fYFsCk7aK7FVXanSsEbkNK3Y8ukw5MfZFZTvBJSOri5luUlBD?=
 =?Windows-1252?Q?/UlHP+PyTuEO3m4OJt+5xpOM94blSIa4LjzXs9S/9Kugf2/+D5N1WZve?=
 =?Windows-1252?Q?jug7OwFp/Zc7YKGn7vNaJGc4EeqB35cC8PElozj8L4b05wrMxqSQnA1q?=
 =?Windows-1252?Q?2l7Kl/Y3kSOFWapZA7SqPONcGQCv9CG3QaAGiw0Ru3J4fQxwHIJv4azO?=
 =?Windows-1252?Q?ikl7qPt9gq/J4uTZaY6bQnHOZd9hKYuI7SlQBM0b70LzqsGAOpbYz39I?=
 =?Windows-1252?Q?izom0EEptItOyR3DI0e0PMY2Nhb56KQT4Ck0uwiefHsD6zH+Zodcz2/L?=
 =?Windows-1252?Q?LArR8a1vjvjW5ni6anmtZUpVutY/2rVnvqj2/jSiTOoganEhl1XEhJ7q?=
 =?Windows-1252?Q?DN/URlV20kdj4pEHfiBfucQOVXqRymndU/LuZAocisuLPP4OMfWLPuaN?=
 =?Windows-1252?Q?8N8iIBfVHVndyMpim+xjsI1xalmBiJaDivnYea10VnevmXCY/ZPgd5u9?=
 =?Windows-1252?Q?szoG+CzIyX4+FNphgU/lsyByl65ihhQLP5QncRoWAeppaGR8CFvK25ah?=
 =?Windows-1252?Q?pj109GAfKvLXjwT02t3a/54QQ7revdI2LvvE2nETBrhKlpkc3BvfxG60?=
 =?Windows-1252?Q?45OiYwWzQ8q24vkkUA1CsWpK8XfXkDOlG299AJCcLA4T6fDAe+FZBucI?=
 =?Windows-1252?Q?5UI6Ay4/tty2sDN7WOLnw2xOtV8Fm2eOskWNCkVR92pHznjurSt/me1l?=
 =?Windows-1252?Q?Y+eP0OBJ/aA+m6R95U4aZY2DDxuF11u7FnUnDrmSbrjN+k2aoczN0Xsp?=
 =?Windows-1252?Q?DPqCmf/DB00hNcax7SdqcoV3XU54BtN2N1+F1p709qNc3IN6sigt5K5o?=
 =?Windows-1252?Q?ss6w7Enjw1p+BOX3L5w5iGej239nnVdGmrQ76n7s6Jf5FivOrwkASTAm?=
 =?Windows-1252?Q?p6thoKPKwn3mIxUqEcn5cuJ+S/+NiHvEijOve/RRCWS/euUOaD6kxZ3p?=
 =?Windows-1252?Q?hJuESHhGI0ddqmMrPshed0Z/DwDx3/Y1vu3KQdgApzdixTD3tGVgYnqZ?=
 =?Windows-1252?Q?r+a/w5YkUr0QWP3pZlXCfs+9MMn/yRYKulu5ART1hN3i0sPz/Zfelg?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB11862.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4579bec0-5f9b-4b25-bb95-08dc23cc507b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2024 08:52:40.9986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6JMfMI99FGEUyyQCq2IRsM9b+9nzlQuexqeXhEIGlKzUapchNcCz+ZirrCSvsbU/LxVqPPuXAvkmBGTUBDGrK+2ZCYSaK0HSkZiPESdpe+o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11795
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 Feb 2024 08:52:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14603

Hello,

> From: Ulrich Hecht <uli@fpond.eu>
> Sent: Friday, February 2, 2024 4:45 AM
>=20
> Hi,
>=20
> the CIP kernel team has released Linux kernel v4.4.302-cip84. The linux-
> 4.4.y-cip tree's base version has been updated to v4.4-st49. The trees ar=
e
> up-to-date with kernel 4.14.336. This is the last release based on the 4.=
14.y
> patch stream.
>=20
> You can get this release via the git tree or as a tarball from
> https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/4.4/
>=20
>   v4.4.302-cip84:
>     repository:
> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
>     branch:
>       linux-4.4.y-cip
>     commit hash:
>       779dae67e799dfb8a0267e26038ab74c58261f24
>     Fixed CVEs:
>       none

Test results:=20
- Dashboard: https://squad.ciplatform.org/linux-cip/linux-4.4.y-cip/build/4=
.4.302-cip84_779dae67/
- Results comparison: https://squad.ciplatform.org/_/comparebuilds/?project=
=3Dlinux-cip/linux-4.4.y-cip&baseline=3D4.4.302-cip83_a0ac575e&target=3D4.4=
.302-cip84_779dae67&comparison_type=3Dtest=20
- Summary: No new regressions

Kind regards, Chris


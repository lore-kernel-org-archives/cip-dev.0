Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 154BEC54E49
	for <webhook@archiver.kernel.org>; Thu,  7 Mar 2024 09:29:39 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.58])
 by mx.groups.io with SMTP id smtpd.web10.19448.1709803768895973929
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 Mar 2024 01:29:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=F/GMnamE;
 spf=pass (domain: renesas.com, ip: 40.107.114.58, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N7qxnxANJiUw7ZTXsbTPdaOw9XA3IjSLRHyi9rcb061TUE/zZCN6tBjf5g0J8828VQ4l0kXhlmvhmL08mWNf31cFqzzrwyUes0A84TKVIK8JFIkF5LabveHySS6H5O4A8k/h1U3PdBiDEbuZn4c0XL7bLQt3huJ3REQSpo5++ORdgrNqMcp528S2YhJ/Xpnh+Sprg5JEiJelw8AYGbBFZAxxpKpGEmi0bJAGWYb6JmYnC8/VTSsqoYrjtqsqJUSzoQyu4oc8vu/an9mIO4F4vBRkful0DjXu1DQylPNPoQTycsFs6Cu1Vs+m0Y6HOqCQDvK14w4lb8Sfk4dnHpRNoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=712oFM9j7UZ13UYnieI67yE7WdIhBS4rzepTlkVYyIQ=;
 b=kU0boT1QsJstZreP4vr1uHaycKrW67HiJIgTzjAyljGsX5N+wsXORwoF/HwzDFK4c50dx+TBZ7c3CwS2oIWSv2cy+Wg742qZQGkhTc8pdTT7D/+r7EaBgXw3YoPGPhBTFghMPAK4z3OiGXVzJFOiYho0p5AX3C81JUZP8b7QxUctiQGHYYi7ctGQiyevocd++VYqqEBZ+2GDUiKqczjKvxEm0MbuqCdSzVXqrS9s+b5GQHSjOCFmIQoLWICliOxCleFoyI8kpDSPFmHf+b4g65G5N7UTv7V6AnpKjkzc1eMBcYndAymIYwbTT9oiyUYNmwieKLhxEJYesKOWyKFPbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=712oFM9j7UZ13UYnieI67yE7WdIhBS4rzepTlkVYyIQ=;
 b=F/GMnamEx6ssX71k/VyQ/aqgdvQeFLFXTY/MjO4R5T1dw4LqZh7EdT9pf8+XgXrdp/sbk9zpKyXE+wnOPY2SAhJEFD9zcgiyBLOCICMwPhQ3Hy+PB9rjOj/VJDSRK7C53jqDBD4EW+a92TK4/oMxZ3wolCMqvYAm5yn94Anux8A=
Received: from TYWPR01MB11862.jpnprd01.prod.outlook.com (2603:1096:400:3fc::6)
 by TYAPR01MB6025.jpnprd01.prod.outlook.com (2603:1096:402:36::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Thu, 7 Mar
 2024 09:29:23 +0000
Received: from TYWPR01MB11862.jpnprd01.prod.outlook.com
 ([fe80::ec68:1357:d0c9:ad1a]) by TYWPR01MB11862.jpnprd01.prod.outlook.com
 ([fe80::ec68:1357:d0c9:ad1a%3]) with mapi id 15.20.7362.019; Thu, 7 Mar 2024
 09:29:23 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: Pavel Machek <pavel@denx.de>, "jan.kiszka@siemens.com"
	<jan.kiszka@siemens.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
Subject: RE: [ANNOUNCE] 4.19.306-cip107-rt35 (rt132)
Thread-Topic: [ANNOUNCE] 4.19.306-cip107-rt35 (rt132)
Thread-Index: AQHabCRgcZSGNSPZhUCd20+TF9liMbEr/21w
Date: Thu, 7 Mar 2024 09:29:23 +0000
Message-ID: 
 <TYWPR01MB118620535D4DDBFE002F16A85B7202@TYWPR01MB11862.jpnprd01.prod.outlook.com>
References: <ZeJQ0GdSPt8azMsM@duo.ucw.cz>
In-Reply-To: <ZeJQ0GdSPt8azMsM@duo.ucw.cz>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB11862:EE_|TYAPR01MB6025:EE_
x-ms-office365-filtering-correlation-id: 43de05f8-ea3d-467a-2b79-08dc3e89137d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 CIjJdnoVQHH24oF3dHyv4G57mKnd7odf8FnrDgm47Z8BpD3sQk8OamQAl5183S+qGAWpsjhvKpMvLynnVc1eQjdLQRO6u71WcD6sK4f1QgfB3fc0/2c2Yo910P3pEvZuoTZ/w9RARIo8T3h0+/JrPdN7u404EWLGv+XChjreDQk5UNS6EU//nCqZEr7Dmlc1XP7HbWYGAlNc7oUsEs5ztYaeRl4zZDdmC0e4QN/nhp24qSfjfScaKUd4+cgFXQ2EYBES3kzJHfKg7/08xbQFm5H0sVhpmXuTsS8goDbWDjSLl/h8WlSYF948+RXzFKlc/wYSR+UwKY7TGSP+DeSeoLePDJ5RFvVgj0LUonWlcpGoLXtTNJe4MCYXZ0fqKH5hUE+zo6QXQQv/qV3wj+OyS+vjo1u5hrUDnSPDHyS1xf1QBu2Rk4mXRwT/JAqTGKFf7FRlMr+3DvJrjbw9FP5jjd29uJhaIaoNoTYXVEzvN1CgUDwkO8QcCg6Nz8+W94tpAEGifJGY8JWbR38/jQBMsu1neH7csNOu+0qrLZeHqNJ8YAPvDaigtxZAE7wr7km2bvhIuDmXnDBgnRKNJO3QzYYYQ05b3TFKF9J7BHfgNk8Eg8+SKnXnQgPz5dNTECCL7fa8wVT1w+vayLiZ5G2HxBm6RvxmoPXYC1JSdDUglV4=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB11862.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?O3ryZD3mQjYjpR0FbJLe4KmfIn8yTPirbsVr1ca0AYYjs7u7tm5GzcNw?=
 =?Windows-1252?Q?EpEuXJpVN9DHpWaSzenpwkvwn/BjFXYqLawGRKLAwmEI1/GkPDp2+7jp?=
 =?Windows-1252?Q?XjoEB6SKZFZBU4G+h+E9nbfhvEMf8lsA2b1hjs0ydM2Ve4SKm5m2CAvY?=
 =?Windows-1252?Q?C3sbdwlqL6phcPVS53BVAVc4SL0aLDAHlgZgpe8pNlCWHA/7D5Nv+gjd?=
 =?Windows-1252?Q?b008GZOjyNidAdJ2L1Mxdob092rDrzsGvYgsET8qa6i13+efe9zUXjTC?=
 =?Windows-1252?Q?RLBgk145gD5vYpf5SqglF9L63EfHiHrWLIzn+831hlEmD5OFXudV9kYY?=
 =?Windows-1252?Q?CeiG8N0S3wLdqYHOxnXku8wyRfuTSpxvyc/YaDmWDqo8EXW8JQxyDPbH?=
 =?Windows-1252?Q?cdD+qPoFytbmfL2czjBscNK5wB7FpLXe2uzgumki7232krRSNsCgOzX9?=
 =?Windows-1252?Q?vhYVSbDKmKVc3cOkxlXVE+O99X22kStqLje4cSYKerOAYprr267/lm1a?=
 =?Windows-1252?Q?UZuS+o+NB1WcinT9D3Somk6pDA6ZTkc6XthgcJseRsBIoK8Anrh3FS+c?=
 =?Windows-1252?Q?WxLSUG7gYGZ0xF7+ceL52E3bzYMio0Puu96+x/kuYzCOVi1vnPJJw/zu?=
 =?Windows-1252?Q?czmjO75US0AF7LmgOrc7ClS8PlfuhxYSoR6GVL9yyO/c+p7a7stHQmS1?=
 =?Windows-1252?Q?eYT4vcmtY+eAEwqQxWdypwhBgc6J00xDGWFeICbfjNNnEvADlaP8wqpI?=
 =?Windows-1252?Q?A7bOM9nFPpsswM5Yg4kHA/EtD+RrUjoNzXejHB0UJQoxQvgLlRN3OL8q?=
 =?Windows-1252?Q?98d6Pn5khrT2mY3N4cOWsb+kzCUahchPVh+SDefTHB+SPAnStXMxhJrb?=
 =?Windows-1252?Q?xs2FJx0nuDKKLrj8kvgIu0lQlDwGK9WquQWmBAxiJdXyKybK7ylekzJn?=
 =?Windows-1252?Q?lqAAFWZGlh9pm28DkeYIVZuDncuokLcncZxIHedVAsc8xCQvChETGYyr?=
 =?Windows-1252?Q?xLUfl7EiVWFZIHq7KN7+uGDwuKseE8wFSgA/ggM8jonLZ7Hba6je7tZh?=
 =?Windows-1252?Q?7o4rbqni+2R34qAWgiHpj66eAfB/4c/tp2h+YXMUJ9fojpjLLGG8Y8jp?=
 =?Windows-1252?Q?j/xtxHlgOC8IHtYCsK5CvdZKnDlXnS1CIZiWzKqrdX6cJ2wn8xCSxavq?=
 =?Windows-1252?Q?VkOta5nms1nfvPG0LGMBnG6A86d0DAUtbH8hhhsHZxoLoK/TaVUMSSyg?=
 =?Windows-1252?Q?weE1qENUIy0xvb22q1BTZxdmU1uuA4+aY91o8eEtUay9sOkVCkCv5bau?=
 =?Windows-1252?Q?2PqC9jRJzQp/+LlwT9wwvZL3mrJIPA5aXmsDCIUV6M3NusQWTvwH5ykq?=
 =?Windows-1252?Q?qYpG3MNvKShY8btd+8YncMHx3gSorZ0SVEuyTPNtI2TM4PHZf0EVVOmO?=
 =?Windows-1252?Q?ai6QIi5W+m8xN6i4i7PFgxnhrjKqITJ3fDC4JTBfd2BPF16r3sswQ6B6?=
 =?Windows-1252?Q?Ab7NFtkCQTbkdN4j9A8q7usy9RanJqdLlfs3ktgHVKx1iZapQTN4S1pi?=
 =?Windows-1252?Q?B/pbAuGHCVwx8tANwLDtpYYN1u/LZJROd+FZZpWTeazP5h9Ac4jPKmX+?=
 =?Windows-1252?Q?UW+zpe167vaeJlhfb52oOQ0KIEQAaUOcoSm2YWONJVt6Mv+7UnlsRG6D?=
 =?Windows-1252?Q?IRkOaJBzpWZ9+dXW76Xa1qcaZstcXAFcpHSU1eDOfE3wsKg8/rIUMA?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB11862.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43de05f8-ea3d-467a-2b79-08dc3e89137d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2024 09:29:23.7923
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HZmCR9GbS9Ar/e2lfIYdzuS0aVlqBwikhpfLDJpCEAhty/DmYff78GN1fkkRTLIouiH3xrC9edB3KW2AtDvUQhRgc/IeKdrlBUuifU5U9ws=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6025
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Mar 2024 09:29:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15260

Hello,

> From: Pavel Machek <pavel@denx.de>
> Sent: Friday, March 1, 2024 10:04 PM
>=20
> Hi!
>=20
> New realtime trees should be available at kernel.org.
>=20
> Trees are available at
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-
> cip.git/log/?h=3Dlinux-4.19.y-cip-rt

Test results:=20
- Dashboard: https://squad.ciplatform.org/linux-cip/linux-4.19.y-cip-rt/bui=
ld/4.19.306-cip107-rt35_dcbd51e77/
- Summary: No new regressions

Kind regards, Chris

> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-
> cip.git/log/?h=3Dlinux-4.19.y-cip-rt-rebase
>=20
> And their content should be identical. There are also tar archives, at:
>=20
> https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/
>=20
> Best regards,
>                                                                 Pavel
>=20
> --
> DENX Software Engineering GmbH,        Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

